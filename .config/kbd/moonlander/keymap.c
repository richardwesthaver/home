#include QMK_KEYBOARD_H
#include "version.h"
#include "keymap_french.h"
#include "keymap_spanish.h"
#include "keymap_hungarian.h"
#include "keymap_swedish.h"
// #include "keymap_br_abnt2.h"
#include "keymap_canadian_multilingual.h"
//#include "keymap_german_ch.h"
//#include "keymap_jp.h"
#include "keymap_korean.h"
#include "keymap_bepo.h"
#include "keymap_italian.h"
#include "keymap_slovenian.h"
#include "keymap_lithuanian_azerty.h"
#include "keymap_danish.h"
#include "keymap_norwegian.h"
#include "keymap_portuguese.h"
// #include "keymap_contributions.h"
#include "keymap_czech.h"
#include "keymap_romanian.h"
#include "keymap_russian.h"
#include "keymap_uk.h"
//#include "keymap_estonian.h"
//#include "keymap_belgian.h"
#include "keymap_us_international.h"
//#include "keymap_croatian.h"
//#include "keymap_turkish_q.h"
//#include "keymap_slovak.h"

#define KC_MAC_UNDO LGUI(KC_Z)
#define KC_MAC_CUT LGUI(KC_X)
#define KC_MAC_COPY LGUI(KC_C)
#define KC_MAC_PASTE LGUI(KC_V)
#define KC_PC_UNDO LCTL(KC_Z)
#define KC_PC_CUT LCTL(KC_X)
#define KC_PC_COPY LCTL(KC_C)
#define KC_PC_PASTE LCTL(KC_V)
#define ES_LESS_MAC KC_GRAVE
#define ES_GRTR_MAC LSFT(KC_GRAVE)
#define ES_BSLS_MAC ALGR(KC_6)
#define NO_PIPE_ALT KC_GRAVE
#define NO_BSLS_ALT KC_EQUAL
#define LSA_T(kc) MT(MOD_LSFT | MOD_LALT, kc)
#define BP_NDSH_MAC ALGR(KC_8)
#define SE_SECT_MAC ALGR(KC_6)
#define MOON_LED_LEVEL LED_LEVEL

enum custom_keycodes {
  RGB_SLD = ML_SAFE_RANGE,
};

enum tap_dance_codes {
  DANCE_0,
  DANCE_1,
  DANCE_2,
  DANCE_3,
  DANCE_4,
  DANCE_5,
  DANCE_6,
  DANCE_7,
  DANCE_8,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [0] = LAYOUT_moonlander(
    // 1			  
    KC_ESC, KC_1, KC_2, KC_3, KC_4, KC_5, KC_EQL,
    KC_GRAVE, KC_6, KC_7, KC_8, KC_9, KC_0, KC_MINUS,
    // 2
    KC_TAB, KC_Q, KC_W, KC_E, KC_R, KC_T, TG(1),   
    TG(2), KC_Y, KC_U, KC_I, KC_O, KC_P, KC_BSLS,
    // 3
    KC_LCTL, KC_A, KC_S, KC_D, KC_F, KC_G, KC_LALT,
    KC_ENT, KC_H, KC_J, KC_K, KC_L, KC_SCLN, KC_QUOTE,
    // 4
    KC_LSFT, KC_Z ,KC_X, KC_C, KC_V, KC_B,  
    KC_N, KC_M, KC_COMMA, KC_DOT, KC_SLASH, KC_BSPC,
    // 5
    KC_UP, KC_DOWN, KC_LBRC, KC_LPRN, KC_SPC, KC_LCTL,
    KC_LALT, KC_SPC, KC_RPRN, KC_RBRC, KC_LEFT, KC_RIGHT,
    // 6
    A(KC_X), C(KC_C), KC_LGUI,
    ALT_T(KC_PASTE), RGB_MODE_FORWARD, QK_LOCK
  ),
  [1] = LAYOUT_moonlander(
    KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_PSCREEN,     KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, 
    KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, 
    KC_ESCAPE,      KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                                                 KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, 
    KC_LSHIFT,      KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_RSHIFT,      
    TT(2),          TD(DANCE_6),    KC_9,           KC_0,           KC_ENTER,       MO(4),                                                                                                          LT(4,KC_ENTER), KC_LEFT,        KC_DOWN,        KC_UP,          KC_RIGHT,       TT(3),          
    KC_LALT,        KC_SPACE,       KC_LCTRL,                       KC_DELETE,      KC_SPACE,       KC_BSPACE
  ),
  [2] = LAYOUT_moonlander(
    KC_NUMLOCK,     KC_F1,          KC_F2,          KC_F3,          KC_F4,          KC_F5,          KC_F6,                                          KC_TRANSPARENT, KC_NUMLOCK,     KC_KP_SLASH,    KC_KP_ASTERISK, KC_NO,          KC_SCROLLLOCK,  KC_PAUSE,       
    KC_KP_DOT,      KC_KP_ASTERISK, KC_KP_PLUS,     KC_KP_7,        KC_KP_8,        KC_KP_9,        KC_F7,                                          KC_TRANSPARENT, KC_KP_7,        KC_KP_8,        KC_KP_9,        KC_KP_MINUS,    KC_PGUP,        KC_PGDOWN,      
    KC_TRANSPARENT, KC_KP_SLASH,    KC_KP_MINUS,    KC_KP_4,        KC_KP_5,        KC_KP_6,        KC_F8,                                                                          KC_TRANSPARENT, KC_KP_4,        KC_KP_5,        KC_KP_6,        KC_KP_PLUS,     KC_HOME,        KC_END,         
    TD(DANCE_7),    KC_F11,         KC_F12,         KC_KP_1,        KC_KP_2,        KC_KP_3,                                        KC_KP_1,        KC_KP_2,        KC_KP_3,        KC_KP_ENTER,    KC_TRANSPARENT, TD(DANCE_8),    
    KC_TRANSPARENT, KC_INSERT,      KC_F9,          KC_F10,         KC_KP_0,        KC_KP_ENTER,                                                                                                    CAPS_WORD,      KC_KP_0,        KC_KP_DOT,      KC_EQUAL,       KC_TRANSPARENT, TO(0),          
    MT(MOD_LALT, KC_PGUP),KC_SPACE,       MT(MOD_LCTL, KC_PGDOWN),                KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT
  ),
  [3] = LAYOUT_moonlander(
    KC_TRANSPARENT, KC_TRANSPARENT, KC_MS_ACCEL0,   KC_MS_ACCEL1,   KC_MS_ACCEL2,   KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_TRANSPARENT, KC_AUDIO_MUTE,  KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, RESET,          
    KC_TRANSPARENT, KC_MS_BTN5,     KC_MS_WH_LEFT,  KC_MS_UP,       KC_MS_WH_RIGHT, KC_MS_WH_UP,    KC_TRANSPARENT,                                 KC_MS_WH_LEFT,  KC_TRANSPARENT, KC_AUDIO_VOL_DOWN,KC_AUDIO_VOL_UP,KC_TRANSPARENT, KC_MEDIA_PREV_TRACK,KC_MEDIA_NEXT_TRACK,
    KC_TRANSPARENT, KC_MS_BTN4,     KC_MS_LEFT,     KC_MS_DOWN,     KC_MS_RIGHT,    KC_MS_WH_DOWN,  KC_TRANSPARENT,                                                                 KC_MS_WH_RIGHT, LCTL(LSFT(KC_LEFT)),LCTL(KC_LEFT),  LCTL(KC_RIGHT), LCTL(LSFT(KC_RIGHT)),KC_MEDIA_STOP,  KC_MEDIA_PLAY_PAUSE,
    MT(MOD_LSFT, KC_LBRACKET),KC_TRANSPARENT, KC_MS_BTN1,     KC_MS_BTN3,     KC_MS_BTN2,     KC_TRANSPARENT,                                 KC_TRANSPARENT, LCTL(LSFT(KC_T)),LCTL(KC_PGUP),  LCTL(KC_PGDOWN),KC_TRANSPARENT, MT(MOD_RSFT, KC_RBRACKET),
    TO(0),          TO(1),          LGUI(LCTL(KC_LEFT)),LGUI(LCTL(KC_RIGHT)),KC_TRANSPARENT, KC_ASTG,                                                                                                        KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, 
    KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                 MT(MOD_RCTL, KC_INSERT),KC_SPACE,       KC_TRANSPARENT
  ),
  [4] = LAYOUT_moonlander(
    KC_INSERT,      KC_LCBR,        KC_RCBR,        KC_LBRACKET,    KC_RBRACKET,    KC_MINUS,       KC_EQUAL,                                       KC_GRAVE,       KC_1,           KC_2,           KC_3,           KC_4,           KC_5,           KC_6,           
    KC_DELETE,      KC_Y,           KC_U,           KC_I,           KC_O,           KC_P,           KC_BSLASH,                                      KC_TAB,         KC_Q,           KC_W,           KC_E,           KC_R,           KC_T,           KC_7,           
    KC_BSPACE,      KC_H,           KC_J,           KC_K,           KC_L,           KC_SCOLON,      KC_QUOTE,                                                                       KC_ESCAPE,      KC_A,           KC_S,           KC_D,           KC_F,           KC_G,           KC_8,           
    KC_RSPC,        KC_N,           KC_M,           KC_COMMA,       KC_DOT,         KC_SLASH,                                       KC_Z,           KC_X,           KC_C,           KC_V,           KC_B,           KC_LSPO,        
    KC_ENTER,       KC_LEFT,        KC_DOWN,        KC_UP,          KC_RIGHT,       TO(0),                                                                                                          TO(0),          KC_LGUI,        KC_9,           KC_0,           KC_HOME,        KC_END,         
    OSM(MOD_LALT),  KC_SPACE,       OSM(MOD_LCTL),                  OSM(MOD_LCTL),  KC_SPACE,       OSM(MOD_LALT)
                          ),
  // [MACRO]
  // [LISP]
  // [CTL]
  // [CMD]
};

extern rgb_config_t rgb_matrix_config;

void keyboard_post_init_user(void) {
  rgb_matrix_enable();
}


const uint8_t PROGMEM ledmap[][DRIVER_LED_TOTAL][3] = {
    [0] = { {188,255,255}, {188,255,255}, {188,255,255}, {151,255,255}, {25,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {188,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {188,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {102,255,255}, {151,255,255}, {25,255,255}, {152,255,255}, {7,255,255}, {102,255,255}, {102,255,255}, {102,255,255}, {151,255,255}, {25,255,255}, {102,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {188,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {102,255,255}, {188,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {102,255,255}, {188,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {188,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {188,255,255}, {188,255,255}, {188,255,255}, {152,255,255}, {25,255,255}, {152,255,255}, {7,255,255} },

    [1] = { {188,255,255}, {188,255,255}, {188,255,255}, {188,255,255}, {0,245,245}, {102,255,255}, {151,255,255}, {25,255,255}, {151,255,255}, {25,255,255}, {102,255,255}, {25,255,255}, {25,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {151,255,255}, {25,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {25,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {102,255,255}, {151,255,255}, {25,255,255}, {151,255,255}, {0,245,245}, {102,255,255}, {102,255,255}, {102,255,255}, {151,255,255}, {0,245,245}, {102,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {25,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {102,255,255}, {25,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {102,255,255}, {25,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {25,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {188,255,255}, {188,255,255}, {188,255,255}, {151,255,255}, {25,255,255}, {151,255,255}, {25,255,255} },

    [2] = { {41,255,255}, {102,255,255}, {0,0,0}, {188,255,255}, {151,255,255}, {188,255,255}, {102,255,255}, {102,255,255}, {188,255,255}, {25,255,255}, {188,255,255}, {102,255,255}, {102,255,255}, {188,255,255}, {188,255,255}, {188,255,255}, {151,255,255}, {0,0,255}, {151,255,255}, {188,255,255}, {188,255,255}, {0,0,255}, {151,255,255}, {0,0,255}, {151,255,255}, {188,255,255}, {151,255,255}, {0,0,255}, {151,255,255}, {188,255,255}, {188,255,255}, {188,255,255}, {151,255,255}, {0,0,0}, {151,255,255}, {41,255,255}, {188,255,255}, {25,255,255}, {25,255,255}, {188,255,255}, {151,255,255}, {188,255,255}, {25,255,255}, {25,255,255}, {0,0,0}, {0,0,0}, {0,0,0}, {102,255,255}, {102,255,255}, {102,255,255}, {41,255,255}, {102,255,255}, {151,255,255}, {0,0,255}, {151,255,255}, {102,255,255}, {102,255,255}, {0,0,255}, {151,255,255}, {0,0,255}, {151,255,255}, {41,255,255}, {151,255,255}, {0,0,255}, {151,255,255}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {41,255,255} },

    [3] = { {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {151,255,255}, {0,0,0}, {25,255,255}, {25,255,255}, {0,0,0}, {25,255,255}, {0,245,245}, {188,255,255}, {74,255,255}, {25,255,255}, {188,255,255}, {0,245,245}, {74,255,255}, {74,255,255}, {25,255,255}, {188,255,255}, {0,245,245}, {188,255,255}, {74,255,255}, {25,255,255}, {0,0,0}, {0,0,0}, {188,255,255}, {188,255,255}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {41,255,255}, {41,255,255}, {0,245,245}, {0,245,245}, {0,0,0}, {152,255,255}, {0,0,0}, {0,245,245}, {255,245,245}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {151,255,255}, {25,255,255}, {0,0,0}, {0,0,0}, {41,255,255}, {74,255,255}, {25,255,255}, {0,0,0}, {41,255,255}, {41,255,255}, {74,255,255}, {25,255,255}, {0,0,0}, {0,0,0}, {0,0,0}, {151,255,255}, {0,0,0}, {0,0,0}, {188,255,255}, {188,255,255}, {0,0,0}, {0,0,0}, {151,255,255}, {0,0,0} },

    [4] = { {188,255,255}, {188,255,255}, {188,255,255}, {188,255,255}, {25,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {102,255,255}, {188,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {102,255,255}, {188,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {151,255,255}, {188,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {151,255,255}, {188,255,255}, {151,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {25,255,255}, {151,255,255}, {25,255,255}, {25,255,255}, {151,255,255}, {151,255,255}, {151,255,255}, {188,255,255}, {188,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {102,255,255}, {188,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {102,255,255}, {151,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {102,255,255}, {188,255,255}, {151,255,255}, {102,255,255}, {102,255,255}, {102,255,255}, {188,255,255}, {188,255,255}, {188,255,255}, {25,255,255}, {151,255,255}, {25,255,255}, {25,255,255} },

};

void set_layer_color(int layer) {
  for (int i = 0; i < DRIVER_LED_TOTAL; i++) {
    HSV hsv = {
      .h = pgm_read_byte(&ledmap[layer][i][0]),
      .s = pgm_read_byte(&ledmap[layer][i][1]),
      .v = pgm_read_byte(&ledmap[layer][i][2]),
    };
    if (!hsv.h && !hsv.s && !hsv.v) {
        rgb_matrix_set_color( i, 0, 0, 0 );
    } else {
        RGB rgb = hsv_to_rgb( hsv );
        float f = (float)rgb_matrix_config.hsv.v / UINT8_MAX;
        rgb_matrix_set_color( i, f * rgb.r, f * rgb.g, f * rgb.b );
    }
  }
}

void rgb_matrix_indicators_user(void) {
  if (rawhid_state.rgb_control) {
      return;
  }
  if (keyboard_config.disable_layer_led) { return; }
  switch (biton32(layer_state)) {
    case 0:
      set_layer_color(0);
      break;
    case 1:
      set_layer_color(1);
      break;
    case 2:
      set_layer_color(2);
      break;
    case 3:
      set_layer_color(3);
      break;
    case 4:
      set_layer_color(4);
      break;
   default:
    if (rgb_matrix_get_flags() == LED_FLAG_NONE)
      rgb_matrix_set_color_all(0, 0, 0);
    break;
  }
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {

    case RGB_SLD:
        if (rawhid_state.rgb_control) {
            return false;
        }
        if (record->event.pressed) {
            rgblight_mode(1);
        }
        return false;
  }
  return true;
}


typedef struct {
    bool is_press_action;
    uint8_t step;
} tap;

enum {
    SINGLE_TAP = 1,
    SINGLE_HOLD,
    DOUBLE_TAP,
    DOUBLE_HOLD,
    DOUBLE_SINGLE_TAP,
    MORE_TAPS
};

static tap dance_state[9];

uint8_t dance_step(qk_tap_dance_state_t *state);

uint8_t dance_step(qk_tap_dance_state_t *state) {
    if (state->count == 1) {
        if (state->interrupted || !state->pressed) return SINGLE_TAP;
        else return SINGLE_HOLD;
    } else if (state->count == 2) {
        if (state->interrupted) return DOUBLE_SINGLE_TAP;
        else if (state->pressed) return DOUBLE_HOLD;
        else return DOUBLE_TAP;
    }
    return MORE_TAPS;
}


void on_dance_0(qk_tap_dance_state_t *state, void *user_data);
void dance_0_finished(qk_tap_dance_state_t *state, void *user_data);
void dance_0_reset(qk_tap_dance_state_t *state, void *user_data);

void on_dance_0(qk_tap_dance_state_t *state, void *user_data) {
    if(state->count == 3) {
        tap_code16(LCTL(KC_GRAVE));
        tap_code16(LCTL(KC_GRAVE));
        tap_code16(LCTL(KC_GRAVE));
    }
    if(state->count > 3) {
        tap_code16(LCTL(KC_GRAVE));
    }
}

void dance_0_finished(qk_tap_dance_state_t *state, void *user_data) {
    dance_state[0].step = dance_step(state);
    switch (dance_state[0].step) {
        case SINGLE_TAP: register_code16(LCTL(KC_GRAVE)); break;
        case SINGLE_HOLD: register_code16(LCTL(KC_V)); break;
        case DOUBLE_TAP: register_code16(LCTL(KC_GRAVE)); register_code16(LCTL(KC_GRAVE)); break;
        case DOUBLE_SINGLE_TAP: tap_code16(LCTL(KC_GRAVE)); register_code16(LCTL(KC_GRAVE));
    }
}

void dance_0_reset(qk_tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    switch (dance_state[0].step) {
        case SINGLE_TAP: unregister_code16(LCTL(KC_GRAVE)); break;
        case SINGLE_HOLD: unregister_code16(LCTL(KC_V)); break;
        case DOUBLE_TAP: unregister_code16(LCTL(KC_GRAVE)); break;
        case DOUBLE_SINGLE_TAP: unregister_code16(LCTL(KC_GRAVE)); break;
    }
    dance_state[0].step = 0;
}
void on_dance_1(qk_tap_dance_state_t *state, void *user_data);
void dance_1_finished(qk_tap_dance_state_t *state, void *user_data);
void dance_1_reset(qk_tap_dance_state_t *state, void *user_data);

void on_dance_1(qk_tap_dance_state_t *state, void *user_data) {
    if(state->count == 3) {
        tap_code16(KC_9);
        tap_code16(KC_9);
        tap_code16(KC_9);
    }
    if(state->count > 3) {
        tap_code16(KC_9);
    }
}

void dance_1_finished(qk_tap_dance_state_t *state, void *user_data) {
    dance_state[1].step = dance_step(state);
    switch (dance_state[1].step) {
        case SINGLE_TAP: register_code16(KC_9); break;
        case SINGLE_HOLD: register_code16(LCTL(KC_X)); break;
        case DOUBLE_TAP: register_code16(KC_9); register_code16(KC_9); break;
        case DOUBLE_SINGLE_TAP: tap_code16(KC_9); register_code16(KC_9);
    }
}

void dance_1_reset(qk_tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    switch (dance_state[1].step) {
        case SINGLE_TAP: unregister_code16(KC_9); break;
        case SINGLE_HOLD: unregister_code16(LCTL(KC_X)); break;
        case DOUBLE_TAP: unregister_code16(KC_9); break;
        case DOUBLE_SINGLE_TAP: unregister_code16(KC_9); break;
    }
    dance_state[1].step = 0;
}
void on_dance_2(qk_tap_dance_state_t *state, void *user_data);
void dance_2_finished(qk_tap_dance_state_t *state, void *user_data);
void dance_2_reset(qk_tap_dance_state_t *state, void *user_data);

void on_dance_2(qk_tap_dance_state_t *state, void *user_data) {
    if(state->count == 3) {
        tap_code16(KC_0);
        tap_code16(KC_0);
        tap_code16(KC_0);
    }
    if(state->count > 3) {
        tap_code16(KC_0);
    }
}

void dance_2_finished(qk_tap_dance_state_t *state, void *user_data) {
    dance_state[2].step = dance_step(state);
    switch (dance_state[2].step) {
        case SINGLE_TAP: register_code16(KC_0); break;
        case SINGLE_HOLD: register_code16(LCTL(KC_C)); break;
        case DOUBLE_TAP: register_code16(KC_0); register_code16(KC_0); break;
        case DOUBLE_SINGLE_TAP: tap_code16(KC_0); register_code16(KC_0);
    }
}

void dance_2_reset(qk_tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    switch (dance_state[2].step) {
        case SINGLE_TAP: unregister_code16(KC_0); break;
        case SINGLE_HOLD: unregister_code16(LCTL(KC_C)); break;
        case DOUBLE_TAP: unregister_code16(KC_0); break;
        case DOUBLE_SINGLE_TAP: unregister_code16(KC_0); break;
    }
    dance_state[2].step = 0;
}
void on_dance_3(qk_tap_dance_state_t *state, void *user_data);
void dance_3_finished(qk_tap_dance_state_t *state, void *user_data);
void dance_3_reset(qk_tap_dance_state_t *state, void *user_data);

void on_dance_3(qk_tap_dance_state_t *state, void *user_data) {
    if(state->count == 3) {
        tap_code16(LALT(KC_SPACE));
        tap_code16(LALT(KC_SPACE));
        tap_code16(LALT(KC_SPACE));
    }
    if(state->count > 3) {
        tap_code16(LALT(KC_SPACE));
    }
}

void dance_3_finished(qk_tap_dance_state_t *state, void *user_data) {
    dance_state[3].step = dance_step(state);
    switch (dance_state[3].step) {
        case SINGLE_TAP: register_code16(LALT(KC_SPACE)); break;
        case SINGLE_HOLD: register_code16(KC_LGUI); break;
        case DOUBLE_TAP: register_code16(LALT(KC_SPACE)); register_code16(LALT(KC_SPACE)); break;
        case DOUBLE_SINGLE_TAP: tap_code16(LALT(KC_SPACE)); register_code16(LALT(KC_SPACE));
    }
}

void dance_3_reset(qk_tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    switch (dance_state[3].step) {
        case SINGLE_TAP: unregister_code16(LALT(KC_SPACE)); break;
        case SINGLE_HOLD: unregister_code16(KC_LGUI); break;
        case DOUBLE_TAP: unregister_code16(LALT(KC_SPACE)); break;
        case DOUBLE_SINGLE_TAP: unregister_code16(LALT(KC_SPACE)); break;
    }
    dance_state[3].step = 0;
}
void on_dance_4(qk_tap_dance_state_t *state, void *user_data);
void dance_4_finished(qk_tap_dance_state_t *state, void *user_data);
void dance_4_reset(qk_tap_dance_state_t *state, void *user_data);

void on_dance_4(qk_tap_dance_state_t *state, void *user_data) {
    if(state->count == 3) {
        tap_code16(LGUI(KC_2));
        tap_code16(LGUI(KC_2));
        tap_code16(LGUI(KC_2));
    }
    if(state->count > 3) {
        tap_code16(LGUI(KC_2));
    }
}

void dance_4_finished(qk_tap_dance_state_t *state, void *user_data) {
    dance_state[4].step = dance_step(state);
    switch (dance_state[4].step) {
        case SINGLE_TAP: register_code16(LGUI(KC_2)); break;
        case SINGLE_HOLD: layer_on(4); break;
        case DOUBLE_TAP: register_code16(LGUI(KC_2)); register_code16(LGUI(KC_2)); break;
        case DOUBLE_SINGLE_TAP: tap_code16(LGUI(KC_2)); register_code16(LGUI(KC_2));
    }
}

void dance_4_reset(qk_tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    switch (dance_state[4].step) {
        case SINGLE_TAP: unregister_code16(LGUI(KC_2)); break;
        case SINGLE_HOLD: layer_off(4); break;
        case DOUBLE_TAP: unregister_code16(LGUI(KC_2)); break;
        case DOUBLE_SINGLE_TAP: unregister_code16(LGUI(KC_2)); break;
    }
    dance_state[4].step = 0;
}
void on_dance_5(qk_tap_dance_state_t *state, void *user_data);
void dance_5_finished(qk_tap_dance_state_t *state, void *user_data);
void dance_5_reset(qk_tap_dance_state_t *state, void *user_data);

void on_dance_5(qk_tap_dance_state_t *state, void *user_data) {
    if(state->count == 3) {
        tap_code16(KC_PSCREEN);
        tap_code16(KC_PSCREEN);
        tap_code16(KC_PSCREEN);
    }
    if(state->count > 3) {
        tap_code16(KC_PSCREEN);
    }
}

void dance_5_finished(qk_tap_dance_state_t *state, void *user_data) {
    dance_state[5].step = dance_step(state);
    switch (dance_state[5].step) {
        case SINGLE_TAP: register_code16(KC_PSCREEN); break;
        case SINGLE_HOLD: register_code16(LGUI(LSFT(KC_S))); break;
        case DOUBLE_TAP: register_code16(KC_PSCREEN); register_code16(KC_PSCREEN); break;
        case DOUBLE_SINGLE_TAP: tap_code16(KC_PSCREEN); register_code16(KC_PSCREEN);
    }
}

void dance_5_reset(qk_tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    switch (dance_state[5].step) {
        case SINGLE_TAP: unregister_code16(KC_PSCREEN); break;
        case SINGLE_HOLD: unregister_code16(LGUI(LSFT(KC_S))); break;
        case DOUBLE_TAP: unregister_code16(KC_PSCREEN); break;
        case DOUBLE_SINGLE_TAP: unregister_code16(KC_PSCREEN); break;
    }
    dance_state[5].step = 0;
}
void dance_6_finished(qk_tap_dance_state_t *state, void *user_data);
void dance_6_reset(qk_tap_dance_state_t *state, void *user_data);

void dance_6_finished(qk_tap_dance_state_t *state, void *user_data) {
    dance_state[6].step = dance_step(state);
    switch (dance_state[6].step) {
        case SINGLE_TAP: layer_move(0); break;
        case SINGLE_HOLD: layer_on(4); break;
        case DOUBLE_TAP: layer_move(0); break;
        case DOUBLE_SINGLE_TAP: layer_move(0); break;
    }
}

void dance_6_reset(qk_tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    switch (dance_state[6].step) {
        case SINGLE_HOLD: layer_off(4); break;
    }
    dance_state[6].step = 0;
}
void on_dance_7(qk_tap_dance_state_t *state, void *user_data);
void dance_7_finished(qk_tap_dance_state_t *state, void *user_data);
void dance_7_reset(qk_tap_dance_state_t *state, void *user_data);

void on_dance_7(qk_tap_dance_state_t *state, void *user_data) {
    if(state->count == 3) {
        tap_code16(KC_LCBR);
        tap_code16(KC_LCBR);
        tap_code16(KC_LCBR);
    }
    if(state->count > 3) {
        tap_code16(KC_LCBR);
    }
}

void dance_7_finished(qk_tap_dance_state_t *state, void *user_data) {
    dance_state[7].step = dance_step(state);
    switch (dance_state[7].step) {
        case SINGLE_TAP: register_code16(KC_LCBR); break;
        case SINGLE_HOLD: register_code16(KC_LSHIFT); break;
        case DOUBLE_TAP: register_code16(KC_LCBR); register_code16(KC_LCBR); break;
        case DOUBLE_SINGLE_TAP: tap_code16(KC_LCBR); register_code16(KC_LCBR);
    }
}

void dance_7_reset(qk_tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    switch (dance_state[7].step) {
        case SINGLE_TAP: unregister_code16(KC_LCBR); break;
        case SINGLE_HOLD: unregister_code16(KC_LSHIFT); break;
        case DOUBLE_TAP: unregister_code16(KC_LCBR); break;
        case DOUBLE_SINGLE_TAP: unregister_code16(KC_LCBR); break;
    }
    dance_state[7].step = 0;
}
void on_dance_8(qk_tap_dance_state_t *state, void *user_data);
void dance_8_finished(qk_tap_dance_state_t *state, void *user_data);
void dance_8_reset(qk_tap_dance_state_t *state, void *user_data);

void on_dance_8(qk_tap_dance_state_t *state, void *user_data) {
    if(state->count == 3) {
        tap_code16(KC_RCBR);
        tap_code16(KC_RCBR);
        tap_code16(KC_RCBR);
    }
    if(state->count > 3) {
        tap_code16(KC_RCBR);
    }
}

void dance_8_finished(qk_tap_dance_state_t *state, void *user_data) {
    dance_state[8].step = dance_step(state);
    switch (dance_state[8].step) {
        case SINGLE_TAP: register_code16(KC_RCBR); break;
        case SINGLE_HOLD: register_code16(KC_RSHIFT); break;
        case DOUBLE_TAP: register_code16(KC_RCBR); register_code16(KC_RCBR); break;
        case DOUBLE_SINGLE_TAP: tap_code16(KC_RCBR); register_code16(KC_RCBR);
    }
}

void dance_8_reset(qk_tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    switch (dance_state[8].step) {
        case SINGLE_TAP: unregister_code16(KC_RCBR); break;
        case SINGLE_HOLD: unregister_code16(KC_RSHIFT); break;
        case DOUBLE_TAP: unregister_code16(KC_RCBR); break;
        case DOUBLE_SINGLE_TAP: unregister_code16(KC_RCBR); break;
    }
    dance_state[8].step = 0;
}

qk_tap_dance_action_t tap_dance_actions[] = {
        [DANCE_0] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_0, dance_0_finished, dance_0_reset),
        [DANCE_1] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_1, dance_1_finished, dance_1_reset),
        [DANCE_2] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_2, dance_2_finished, dance_2_reset),
        [DANCE_3] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_3, dance_3_finished, dance_3_reset),
        [DANCE_4] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_4, dance_4_finished, dance_4_reset),
        [DANCE_5] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_5, dance_5_finished, dance_5_reset),
        [DANCE_6] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, dance_6_finished, dance_6_reset),
        [DANCE_7] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_7, dance_7_finished, dance_7_reset),
        [DANCE_8] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_8, dance_8_finished, dance_8_reset),
};
