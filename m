Return-Path: <linux-pci+bounces-19372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCF5A036A8
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02B77A172B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BBB197A92;
	Tue,  7 Jan 2025 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="oXRZTNoa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OnpkWnBt"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DC61DED4C;
	Tue,  7 Jan 2025 03:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221892; cv=none; b=Hb2D7wFR4+9j5Dr+qWg0aAOv0KTCE9izvL81/V6tdWfg6TKDqw1hQtSZmW5KXWhiMQuLBdfB0rhJsJfuBggzwyCyLiCfagh35dGj9q/gpilm73rLqG/sNk83bewjbqQZ430W6T+kXuJmNmq2w0EAmVDeaP/zd9QLz0hca+hZ8sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221892; c=relaxed/simple;
	bh=cN/kxtMdHtq+fuCfVP47ntdOdTLgiFTqooS5PF1Yfs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=La8+EsVcDdtRS2TwQqDjJsMSAoOPieqoY8ykYr9fwD9kwp8cSU92OzWaBsXDpwdXhjsX9iGDwjGdu2wG/+ckQQ8gJtoFS1Ja2395c1hh9srKBOboveERhAgbX7OWgGQbWy4D0Q4P7omzflyh85vdsC+3T5CE0A9z+2/2LYQZ4VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=oXRZTNoa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OnpkWnBt; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D84B92540178;
	Mon,  6 Jan 2025 22:51:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 06 Jan 2025 22:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1736221885; x=1736308285; bh=jvRKxufKFl4JIrnzcaXwWMzthH8JJCX/
	y5SmcUypVC4=; b=oXRZTNoayLPrJimF1RhT3KEqm3YDs4tBscBlFZTM4u8OkInj
	9qRWFRZRzgnYGMB+cLv2hn508t8LSQ16aliquH8EHXVeiEVc59WOjfc/ZjA2QwSA
	iCAaujpvNhprRGFF9y2em1g5AvIZRv6O9rE0RgryxmkW+ohPdTJzNpbYWydXR0Km
	D4vk5azNBQF+iT5QSXZJUeD/k+YL6MnbTDnYm75l9Lz9h7Ps8lp8q5Io5XcZo3Aw
	h3GaAmNFuuJI/9zWM04tEOkUSwLyGI0aQYf26oOHhk7Wa1If24Ntfyr/6szhTy+Z
	DIT0dr4gqchhQMKR9bNGbkgnRoNrN4nP3PXV5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736221885; x=
	1736308285; bh=jvRKxufKFl4JIrnzcaXwWMzthH8JJCX/y5SmcUypVC4=; b=O
	npkWnBtCizSUZLeRoTY9klXibUJsuKIQcUv8cfi/SygEOfiCwHvOrPJUkl0XcE8F
	DOLQIVgq7B5s0ZNBbPFnkaqd4ujgvcOJfCBtfOdjYz0LHCsvJ5zDwy484OsuWMkv
	c7J8oOozuM10cCSNTOHcpkA6ATyyi5Nw3Bxssmdi5OjJKbsyd+5QErsWFbupoi5O
	8cgzuauJYPR7vKp8gODSnORhkE5b+HNRHZBFj/7bbc4Wp89iCeI9+HR+lIutYCXz
	965HGhhOqbipabkPMWajojLuby/jB6VhoMtekS4E3Aw1ZfpqSC6kLr8zyVideB2m
	a1XcLtkZ53XvngosdQ0ow==
X-ME-Sender: <xms:vKR8ZxcgHbnKpA9J-oA7UFegPwvgoigNL_n6KlwpN-n6FNyxcbmyjw>
    <xme:vKR8Z_NvZcs--vSyZ14HWi5WE_0AIfKrESLAOOPxW2EE40hA9p9e6iHEQOF6EkTw2
    cIA4hLoMzK1QXlgms8>
X-ME-Received: <xmr:vKR8Z6hUKaIGqGUQrARBBCReWSC6a2nIHRHezjq6rFrJ2K7t-6-xHkuiAkOxy_9HCGdqiO6uvfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrg
    hlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhephfetjeejteeileehvdeh
    geetgeffueetgfetleelgeehjedvgfefvdeukedtgfdunecuffhomhgrihhnpehgihhthh
    husgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtoh
    epvdefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegshhgvlhhgrggrshesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdp
    rhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrkhhpmh
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepthhmghhrohhs
    shesuhhmihgthhdrvgguuhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vKR8Z69nay1pZXeSF46eV5H-9I1vcNrmfRWp27HDGz-GrUCwNGZI2A>
    <xmx:vKR8Z9sjemkpxCDX4MASofFxFuuHonX0F0P8FDLjwssxGhNi-EGppA>
    <xmx:vKR8Z5GiAh50IwFTpWkDn8qKKjLBaPwdqywq-42aLCQ9dyD_WigzVg>
    <xmx:vKR8Z0MPdzOZxYJ2eyg6bjCK5DAdTvVcgsQGNYGMIkJPg4GhSLS2KQ>
    <xmx:vaR8Z2tVmNFW_Ou6MluQqZv_lrBHuDITzLlHuiH3EMDhEvKuOwCzBFSQ>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 22:51:14 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: bhelgaas@google.com,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	gary@garyguo.net,
	akpm@linux-foundation.org,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	ojeda@kernel.org,
	linux-cxl@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	a.hindborg@kernel.org,
	me@kloenk.dev,
	linux-kernel@vger.kernel.org,
	aliceryhl@google.com,
	alistair.francis@wdc.com,
	linux-pci@vger.kernel.org,
	benno.lossin@proton.me,
	alex.gaynor@gmail.com,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	Alistair Francis <alistair@alistair23.me>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v5 01/11] rust: bindings: Support some inline static functions
Date: Tue,  7 Jan 2025 13:50:48 +1000
Message-ID: <20250107035058.818539-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107035058.818539-1-alistair@alistair23.me>
References: <20250107035058.818539-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kernel includes a large number of static inline functions that are
defined in header files. One example is the crypto_shash_descsize()
function which is defined in hash.h as

static inline unsigned int crypto_shash_descsize(struct crypto_shash *tfm)
{
	return tfm->descsize;
}

bindgen is currently unable to generate bindings to these functions as
they are not publically exposed (they are static after all).

The Rust code currently uses rust_helper_* functions, such as
rust_helper_alloc_pages() for example to call the static inline
functions. But this is a hassle as someone needs to write a C helper
function.

Instead we can use the bindgen wrap-static-fns feature. The feature
is marked as experimental, but has recently been promoted to
non-experimental (depending on your version of bindgen).

By supporting wrap-static-fns we automatically generate a C file called
extern.c that exposes the static inline functions, for example like this

```
unsigned int crypto_shash_descsize__extern(struct crypto_shash *tfm) { return crypto_shash_descsize(tfm); }
```

The nice part is that this is auto-generated.

We then also get a bindings_generate_static.rs file with the Rust
binding, like this

```
extern "C" {
    #[link_name = "crypto_shash_descsize__extern"]
    pub fn crypto_shash_descsize(tfm: *mut crypto_shash) -> core::ffi::c_uint;
}
```

So now we can use the static inline functions just like normal
functions.

There are a bunch of static inline functions that don't work though, because
the C compiler fails to build extern.c:
 * functions with inline asm generate "operand probably does not match constraints"
   errors (rip_rel_ptr() for example)
 * functions with bit masks (u32_encode_bits() and friends) result in
   "call to ‘__bad_mask’ declared with attribute error: bad bitfield mask"
   errors

As well as that any static inline function that calls a function that has been
kconfig-ed out will fail to link as the function being called isn't built
(mdio45_ethtool_gset_npage for example)

Due to these failures we use a allow-list system (where functions must
be manually enabled).

Link: https://github.com/rust-lang/rust-bindgen/discussions/2405
Signed-off-by: Alistair Francis <alistair@alistair23.me>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 Documentation/rust/general-information.rst | 10 +++---
 rust/.gitignore                            |  2 ++
 rust/Makefile                              | 37 ++++++++++++++++++++--
 rust/bindgen_static_functions              |  6 ++++
 rust/bindings/lib.rs                       |  4 +++
 rust/exports.c                             |  1 +
 6 files changed, 53 insertions(+), 7 deletions(-)
 create mode 100644 rust/bindgen_static_functions

diff --git a/Documentation/rust/general-information.rst b/Documentation/rust/general-information.rst
index 6146b49b6a98..632a60703c96 100644
--- a/Documentation/rust/general-information.rst
+++ b/Documentation/rust/general-information.rst
@@ -119,10 +119,12 @@ By including a C header from ``include/`` into
 bindings for the included subsystem. After building, see the ``*_generated.rs``
 output files in the ``rust/bindings/`` directory.
 
-For parts of the C header that ``bindgen`` does not auto generate, e.g. C
-``inline`` functions or non-trivial macros, it is acceptable to add a small
-wrapper function to ``rust/helpers/`` to make it available for the Rust side as
-well.
+C ``inline`` functions will only be generated if the function name is
+specified in ``rust/bindgen_static_functions``.
+
+For parts of the C header that ``bindgen`` does not auto generate, e.g.
+non-trivial macros, it is acceptable to add a small wrapper function
+to ``rust/helpers/`` to make it available for the Rust side as well.
 
 Abstractions
 ~~~~~~~~~~~~
diff --git a/rust/.gitignore b/rust/.gitignore
index d3829ffab80b..741a18023801 100644
--- a/rust/.gitignore
+++ b/rust/.gitignore
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
 bindings_generated.rs
+bindings_generated_static.rs
 bindings_helpers_generated.rs
 doctests_kernel_generated.rs
 doctests_kernel_generated_kunit.c
 uapi_generated.rs
 exports_*_generated.h
+extern.c
 doc/
 test/
diff --git a/rust/Makefile b/rust/Makefile
index a40a3936126d..578fec15480f 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -10,14 +10,17 @@ always-$(CONFIG_RUST) += exports_core_generated.h
 # for Rust only, thus there is no header nor prototypes.
 obj-$(CONFIG_RUST) += helpers/helpers.o
 CFLAGS_REMOVE_helpers/helpers.o = -Wmissing-prototypes -Wmissing-declarations
+CFLAGS_REMOVE_extern.o = -Wmissing-prototypes -Wmissing-declarations -Wdiscarded-qualifiers
 
 always-$(CONFIG_RUST) += libmacros.so
 no-clean-files += libmacros.so
 
-always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
-obj-$(CONFIG_RUST) += bindings.o kernel.o
+always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs \
+	bindings/bindings_generated_static.rs
+obj-$(CONFIG_RUST) += bindings.o kernel.o extern.o
 always-$(CONFIG_RUST) += exports_helpers_generated.h \
-    exports_bindings_generated.h exports_kernel_generated.h
+    exports_bindings_generated.h exports_bindings_static_generated.h \
+    exports_kernel_generated.h
 
 always-$(CONFIG_RUST) += uapi/uapi_generated.rs
 obj-$(CONFIG_RUST) += uapi.o
@@ -301,6 +304,21 @@ quiet_cmd_bindgen = BINDGEN $@
 		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
 		$(bindgen_target_cflags) $(bindgen_target_extra)
 
+quiet_cmd_bindgen_static = BINDGEN $@
+      cmd_bindgen_static = \
+	$(BINDGEN) $< $(bindgen_target_flags) \
+		--use-core --with-derive-default --ctypes-prefix core::ffi --no-layout-tests \
+		--no-debug '.*' --enable-function-attribute-detection \
+		--experimental --wrap-static-fns \
+		--wrap-static-fns-path $(src)/extern.c \
+		$(bindgen_static_functions) \
+		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
+		$(bindgen_target_cflags) $(bindgen_target_extra)
+
+$(src)/extern.c: $(obj)/bindings/bindings_generated_static.rs \
+	$(src)/bindings/bindings_helper.h
+	@sed -i 's|#include ".*|#include "bindings/bindings_helper.h"|g' $@
+
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_extra = ; \
@@ -309,6 +327,15 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
     $(src)/bindgen_parameters FORCE
 	$(call if_changed_dep,bindgen)
 
+$(obj)/bindings/bindings_generated_static.rs: private bindgen_target_flags = \
+    $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
+$(obj)/bindings/bindings_generated_static.rs: private bindgen_static_functions = \
+    $(shell grep -Ev '^#|^$$' $(src)/bindgen_static_functions)
+$(obj)/bindings/bindings_generated_static.rs: $(src)/bindings/bindings_helper.h \
+	$(src)/bindgen_static_functions \
+    $(src)/bindgen_parameters FORCE
+	$(call if_changed_dep,bindgen_static)
+
 $(obj)/uapi/uapi_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
 $(obj)/uapi/uapi_generated.rs: $(src)/uapi/uapi_helper.h \
@@ -352,6 +379,9 @@ $(obj)/exports_helpers_generated.h: $(obj)/helpers/helpers.o FORCE
 $(obj)/exports_bindings_generated.h: $(obj)/bindings.o FORCE
 	$(call if_changed,exports)
 
+$(obj)/exports_bindings_static_generated.h: $(obj)/extern.o FORCE
+	$(call if_changed,exports)
+
 $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
 	$(call if_changed,exports)
 
@@ -431,6 +461,7 @@ $(obj)/bindings.o: private rustc_target_flags = --extern ffi
 $(obj)/bindings.o: $(src)/bindings/lib.rs \
     $(obj)/ffi.o \
     $(obj)/bindings/bindings_generated.rs \
+    $(obj)/bindings/bindings_generated_static.rs \
     $(obj)/bindings/bindings_helpers_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
new file mode 100644
index 000000000000..1f24360daeb3
--- /dev/null
+++ b/rust/bindgen_static_functions
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Don't generate structs
+--blocklist-type '.*'
+
+--allowlist-function blk_mq_rq_to_pdu
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 014af0d1fc70..02f789221025 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -39,6 +39,10 @@ mod bindings_raw {
         env!("OBJTREE"),
         "/rust/bindings/bindings_generated.rs"
     ));
+    include!(concat!(
+        env!("OBJTREE"),
+        "/rust/bindings/bindings_generated_static.rs"
+    ));
 }
 
 // When both a directly exposed symbol and a helper exists for the same function,
diff --git a/rust/exports.c b/rust/exports.c
index 587f0e776aba..288958d2ebea 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -18,6 +18,7 @@
 #include "exports_core_generated.h"
 #include "exports_helpers_generated.h"
 #include "exports_bindings_generated.h"
+#include "exports_bindings_static_generated.h"
 #include "exports_kernel_generated.h"
 
 // For modules using `rust/build_error.rs`.
-- 
2.47.1


