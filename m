Return-Path: <linux-pci+bounces-19371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D001DA036A6
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABA2164186
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDB3194A67;
	Tue,  7 Jan 2025 03:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="VQcdDkmD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p5zi/eu/"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC6A86355;
	Tue,  7 Jan 2025 03:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221878; cv=none; b=taX20neHG2IJG6oIHX4tvE1G65o0ws2P/MqMi4xMXUvXB5mFw/Ag2DH0TF+jIHIlK9BLr0C33BRtE6b4c9wtElU1aB26d9CG60EZSoUkPvpfnsK61ZMMmVBzmXb+JTY7ETozi2xhy91UpBC6tbPOXiTKGE9k0+hSVVPz7Yp18+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221878; c=relaxed/simple;
	bh=a7eWzuS4iRVIloChj1QBeF0bIMWYs5e9Ne/q9iDPdaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=af1T8N0/UlDwpl+4fipWnroeREmEkc2jPdZPNaQuyyemEL+i+DW1kOpwX981AGtgU7mUlpscStiUSOzjiFgf1dd26sVAjHLLnuXL4/xR8EvScROwtY2l2sQU6ARwSzxbJi91zxLtifyrX4rBqPG0AGzCuad/YQQA39ceJAPSEdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=VQcdDkmD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p5zi/eu/; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E6B925400CC;
	Mon,  6 Jan 2025 22:51:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jan 2025 22:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm2; t=1736221873; x=
	1736308273; bh=s5LdnuzravPpMyZJ3rXVmIMgg5hQJL9QGfm6/zJbeI4=; b=V
	QcdDkmDOznEdw8W/ivj587CqnuFnxa8/dexkYEdwKzrlNpTqXd2vNzrJFE9YHbTi
	lIjUxp0QbKEi+F11hn4KZpEwNBQSyvG/BcqrnaexAEEp1616qQLngyh64umtK/mr
	ugRmOJklFOebMPJ58j2BV9yQl5McZ7MOikFW7BFQrPO9jOOcVGxqgYR1omCcowQU
	QnUaRBdT5l4PTOO2XJ2YBa1osJrHJysLKy/BuDeBp8sVyDFzC8X8LPITGeJwr6ZC
	P/qA7X/5se4eeAl9qagRG2Jgy0NC4Y/TFlNYRIroWyCdnadzm9SSksBOgr0N0ASI
	PFhohp4OUTeXyWX7kf3zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736221873; x=1736308273; bh=s5LdnuzravPpMyZJ3rXVmIMgg5hQ
	JL9QGfm6/zJbeI4=; b=p5zi/eu/2UchQM/Wzl2ZdgNM0obZFU9MINZF1Um3jQA3
	cWDXY1Y3s7cXtOBlK06AO458Yg5bSKPPZ99FdeKpBGJmy/g6n1b7QJ56wtfAT7XZ
	AITXw+MRcb7uKY3juPZSIRQYeNmM7uV/9XmsZuMWMOIZr+vI0Smw6X0/i/0avDTC
	TPtOnTwTu8tCgu5dMZ5wMq3mxaCrpkeKu14Q1SrOjQR8pG1FZcc+QR4R5dvn2dEi
	O9bzNFzsm4XGQ9HMCyQZhXGDZaQuYI1EWICmzmGUQQeV72c+5kZjHyHboxMGxvgL
	5OXsCqLHTIlems2D/BuqB7PmPWB0yhTRCYiU8hfOTw==
X-ME-Sender: <xms:r6R8Z9GqWmoxk9FzkzUpFNiBttdQNqCH3IwLwBE18zSfa6t6b8NwZg>
    <xme:r6R8ZyWdtLwMYx5suScKCNEmKNIz6777xF0DHe8pk0ECidqukU9TafEWe3RmuNVqL
    tmr4xFejYA81HCg6S0>
X-ME-Received: <xmr:r6R8Z_J-kokoY7XzjjkwVvegz958lEvIcLpSRnKMJXSBIixEiSRe_G07QDZDD8MXdRc53zhkxSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpefggfdufedvfeelkeeitdfgteeivdeuvdeivedtkedtuedvvdeffefgieeilefg
    keenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdv
    fedrmhgvpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehruhhsthdq
    fhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluh
    hkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhn
    vghtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughupdhrtghpthhtohepsgho
    qhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtgiglhesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:r6R8ZzHlaFk-bWuwqZp1qbmcd0L-AedpuenrQ1tfLg9xY7ZcMK7zBQ>
    <xmx:r6R8ZzVgA1NUOh-EkPoECxyMB3swEOr9MZmc27ZFYMJMtMgNPZoGbg>
    <xmx:r6R8Z-Mwooi_smVLOUJx_knx5s4_yLNZprTpV9Dkx2fdSMKOssLs2A>
    <xmx:r6R8Zy1U3ELkeZh70EzNfhULhZOgP6Fr7xP7zSTpbEr_7IgQ_AF3-Q>
    <xmx:saR8Z5GBeka_e7N9GGmSDBUfEXUp-_fe5vfJVIj7gz4FaBYTcFnz63X5>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 22:51:03 -0500 (EST)
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
	Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 00/11] rust: bindings: Auto-generate inline static functions
Date: Tue,  7 Jan 2025 13:50:47 +1000
Message-ID: <20250107035058.818539-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The kernel includes a large number of static inline functions that are
defined in header files. One example is the crypto_shash_descsize()
function which is defined in hash.h as

```
static inline unsigned int crypto_shash_descsize(struct crypto_shash *tfm)
{
        return tfm->descsize;
}
```

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

This series adds support for bindgen generating wrappers for inline statics and
then converts the existing helper functions to this new method. This doesn't
work for C macros, so we can't reamove all of the helper functions, but we
can remove most.

v5:
 - Rebase on latest rust-next on top of v6.13-rc6
 - Allow support for LTO inlining (not in this series, see
   https://github.com/alistair23/linux/commit/e6b847324b4f5e904e007c0e288c88d2483928a8)
v4:
 - Fix out of tree builds
v3:
 - Change SoB email address to match from address
 - Fixup kunit test build failure
 - Update Rust binding documentation
v2:
 - Fixup build failures report by test bots
 - Rebase on rust-next (ae7851c29747fa376)

Alistair Francis (11):
  rust: bindings: Support some inline static functions
  rust: helpers: Remove blk helper
  rust: helpers: Remove err helper
  rust: helpers: Remove kunit helper
  rust: helpers: Remove some page helpers
  rust: helpers: Remove rbtree helper
  rust: helpers: Remove some refcount helpers
  rust: helpers: Remove signal helper
  rust: helpers: Remove some spinlock helpers
  rust: helpers: Remove some task helpers
  rust: helpers: Remove uaccess helpers

 Documentation/rust/general-information.rst | 10 +++---
 rust/.gitignore                            |  2 ++
 rust/Makefile                              | 37 ++++++++++++++++++++--
 rust/bindgen_static_functions              | 32 +++++++++++++++++++
 rust/bindings/lib.rs                       |  4 +++
 rust/exports.c                             |  1 +
 rust/helpers/blk.c                         | 14 --------
 rust/helpers/err.c                         | 18 -----------
 rust/helpers/helpers.c                     | 11 ++-----
 rust/helpers/kunit.c                       |  8 -----
 rust/helpers/page.c                        |  5 ---
 rust/helpers/rbtree.c                      |  9 ------
 rust/helpers/refcount.c                    | 10 ------
 rust/helpers/signal.c                      |  8 -----
 rust/helpers/spinlock.c                    | 15 ---------
 rust/helpers/task.c                        | 10 ------
 rust/helpers/uaccess.c                     | 15 ---------
 rust/kernel/uaccess.rs                     |  5 +--
 18 files changed, 84 insertions(+), 130 deletions(-)
 create mode 100644 rust/bindgen_static_functions
 delete mode 100644 rust/helpers/blk.c
 delete mode 100644 rust/helpers/err.c
 delete mode 100644 rust/helpers/kunit.c
 delete mode 100644 rust/helpers/rbtree.c
 delete mode 100644 rust/helpers/signal.c
 delete mode 100644 rust/helpers/uaccess.c

-- 
2.47.1


