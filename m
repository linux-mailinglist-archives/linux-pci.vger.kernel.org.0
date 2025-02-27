Return-Path: <linux-pci+bounces-22498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B90A47369
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68663B52A4
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EB11B6D1E;
	Thu, 27 Feb 2025 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="SihsXEo1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CbAixCXE"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE4C190692;
	Thu, 27 Feb 2025 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625895; cv=none; b=LBJu6LGvmSsmxjyQdbXt97AcJeWqHnVbGlCJ90myy3yX1UGXux3eH2zURU2asHBXsRqzEuBuZlktLS6OnoCXafncXzpXzLvMKJ9ewf1x3Bv9+fMZebFUTTmaIOO3FCRbOec6jps/n4tUUghxpypOlT9Tqf6U6ybBqxM5F1xSbyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625895; c=relaxed/simple;
	bh=rzYpgZLZuUYJzMu9QBpUD+XLWvftZuDiLoC9vJllpuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8XP3ikZlAUYgSjqh63ChyU7tHzSFLdj1R2lim44Ao0zyW0FL5LI98RhAmU/kiOalGkn9A2x0KlphV4kQfJ9IWr3zh12xaYzbjBP0GwdAC6HM36vqGzJhukOrafLrpGAk9yXjPUTwvcIcWxedb1ZjxBgiqDAq91/IiQpXUAR2LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=SihsXEo1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CbAixCXE; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id F178D11401A0;
	Wed, 26 Feb 2025 22:11:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 26 Feb 2025 22:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625891; x=
	1740712291; bh=dUaNRxApP9skjepEsTYNSBikC/Rhnq3MSeo7e+Jsorc=; b=S
	ihsXEo1oIDmDIiWf0b/5taGD74A3VBVPWB2HO3sG0WmCqPXHajZj2KdpppJSOYmx
	iF/PaC4MFAp2Ln9maaDSp/DsR/51HpJ87OfWLWkskM7/4E/7g8ZWFDe9IRY9xZh9
	scuzTQbwYZUjZJo0dqC66WhHpkSzqPARW4Skiwf2S0kpktVCdKHYdpDSo6AvFUd7
	5GS2MkSk/lIxkjLlUgbC5O6Zlej7+FLWMP5K4YwqWyrq+6AWZkvxG8Za+4KCWp/s
	/Blwl7bPPu/lru5lbi+d/+x2fOAXNpPr4ZtQYCHWDjpC1MWa7/yoRm3aYsbuNzDk
	Xo06LdNdi9+d/mqYX/pWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625891; x=1740712291; bh=d
	UaNRxApP9skjepEsTYNSBikC/Rhnq3MSeo7e+Jsorc=; b=CbAixCXERH3a1GeFo
	PQHa7f1l6zOIdyHRw0mlvRCnh5lLkmXdefk1scpV/6cxlH2/Z46VSmcpwLdDXJ3i
	ENCAnfusBbwulXsaQQ0IqAk4Q4cbmmFMDF5seBKpH3wQvIB0S36A9RXU7PbdgdAg
	MdLtJ0CVUdSD5n9TvDc2em93SCVVtIzNF6MInnGdjjU5RUH39RGo7UnxyfIevlix
	tHVcGb+RtCHP+1xI/9mTP3p+4vnSBKRNnbmRpquV9sMw4xzDFpQJ8L0fVp4KX9I/
	KFFMXvsYjGxv7VU79dySsFT7wRHXMvblfTA0gkERbg5ECnW4tOmvYtTsjtgPQESP
	bXmxA==
X-ME-Sender: <xms:49e_Z3LR8-aWQJXxgHAzzQjDPsfsvZkOpuWNZWHrEK3A9ra1muhaMQ>
    <xme:49e_Z7K1Cp11sOlNgaq9_KDLBpU8w8VmOXCD9b54cybKEyidp-nf_jx0wD_JM0A9z
    yFf6kVCS0oKQXrhEOg>
X-ME-Received: <xmr:49e_Z_ugRVBZ4LuBF3k69UPRFwzCRg2y3gyveFSpmyIb3rUwp85aAICq43f0OfdzjS-7lyRRo9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeevteeufeekheeiledtveeg
    heejffejheeugefhiefhhfehvdefteelgfeiieeuteenucffohhmrghinhepsggrshgvpg
    hhrghshhgprghlghgpnhgrmhgvrdgrshdpshhhrghshhdrihhspdgumhhtfhdrohhrghdp
    sggrshgvpggrshihmhgpshgvlhdrthhopdgsrghsvggphhgrshhhpghsvghlrdhtohdpmh
    gvrghsuhhrvghmvghnthgphhgrshhhpggrlhhgohdrthhonecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrg
    hirhdvfedrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhhinhhugidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtoheplhhinhhugidqph
    gtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnse
    hhuhgrfigvihdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouh
    hnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:49e_ZwZ5jhJ9Mo9KSIf0GcoX6FpiVqmhIS75vYSNmE8XKjP01g5Dkw>
    <xmx:49e_Z-avMOlldalG6agjj-czF96UoS3VNf2jMLQt2pksMp-_tU2yxQ>
    <xmx:49e_Z0AlsiRBbKgbGkSGDXaIivuVGgL6ios0ZgjT6Qb89Rgi66h7gQ>
    <xmx:49e_Z8bt7vZYQmnnojfxwPWGM9oxgWGHx62WDYoHYtI-39TKOKEgkg>
    <xmx:49e_ZwbPbt5_M1boAX_vCNaUJ89rbsMI6qEcKWyB9m5R6Q5LZqwZ2jYe>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:11:24 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org
Cc: boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alistair23@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC v2 12/20] lib: rspdm: Support SPDM negotiate_algorithms
Date: Thu, 27 Feb 2025 13:09:44 +1000
Message-ID: <20250227030952.2319050-13-alistair@alistair23.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227030952.2319050-1-alistair@alistair23.me>
References: <20250227030952.2319050-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support the NEGOTIATE_ALGORITHMS SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs             |  53 ++++++++
 lib/rspdm/lib.rs                |  16 ++-
 lib/rspdm/state.rs              | 213 +++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs          | 115 ++++++++++++++++-
 rust/bindgen_static_functions   |   5 +
 rust/bindings/bindings_helper.h |   2 +
 6 files changed, 398 insertions(+), 6 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 8a58351bf268..d2f245c858cc 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -65,6 +65,59 @@ pub(crate) enum SpdmErrorCode {
 
 pub(crate) const SPDM_CERT_CAP: u32 = 1 << 1;
 pub(crate) const SPDM_CHAL_CAP: u32 = 1 << 2;
+pub(crate) const SPDM_MEAS_CAP_MASK: u32 = 3 << 3;
+pub(crate) const SPDM_KEY_EX_CAP: u32 = 1 << 9;
 
 pub(crate) const SPDM_REQ_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
 pub(crate) const SPDM_RSP_MIN_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
+
+pub(crate) const SPDM_NEGOTIATE_ALGS: u8 = 0xe3;
+
+pub(crate) const SPDM_MEAS_SPEC_DMTF: u8 = 1 << 0;
+
+pub(crate) const SPDM_ASYM_RSASSA_2048: u32 = 1 << 0;
+pub(crate) const _SPDM_ASYM_RSAPSS_2048: u32 = 1 << 1;
+pub(crate) const SPDM_ASYM_RSASSA_3072: u32 = 1 << 2;
+pub(crate) const _SPDM_ASYM_RSAPSS_3072: u32 = 1 << 3;
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P256: u32 = 1 << 4;
+pub(crate) const SPDM_ASYM_RSASSA_4096: u32 = 1 << 5;
+pub(crate) const _SPDM_ASYM_RSAPSS_4096: u32 = 1 << 6;
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P384: u32 = 1 << 7;
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P521: u32 = 1 << 8;
+pub(crate) const _SPDM_ASYM_SM2_ECC_SM2_P256: u32 = 1 << 9;
+pub(crate) const _SPDM_ASYM_EDDSA_ED25519: u32 = 1 << 10;
+pub(crate) const _SPDM_ASYM_EDDSA_ED448: u32 = 1 << 11;
+
+pub(crate) const SPDM_HASH_SHA_256: u32 = 1 << 0;
+pub(crate) const SPDM_HASH_SHA_384: u32 = 1 << 1;
+pub(crate) const SPDM_HASH_SHA_512: u32 = 1 << 2;
+
+#[cfg(CONFIG_CRYPTO_RSA)]
+pub(crate) const SPDM_ASYM_RSA: u32 =
+    SPDM_ASYM_RSASSA_2048 | SPDM_ASYM_RSASSA_3072 | SPDM_ASYM_RSASSA_4096;
+#[cfg(not(CONFIG_CRYPTO_RSA))]
+pub(crate) const SPDM_ASYM_RSA: u32 = 0;
+
+#[cfg(CONFIG_CRYPTO_ECDSA)]
+pub(crate) const SPDM_ASYM_ECDSA: u32 =
+    SPDM_ASYM_ECDSA_ECC_NIST_P256 | SPDM_ASYM_ECDSA_ECC_NIST_P384 | SPDM_ASYM_ECDSA_ECC_NIST_P521;
+#[cfg(not(CONFIG_CRYPTO_ECDSA))]
+pub(crate) const SPDM_ASYM_ECDSA: u32 = 0;
+
+#[cfg(CONFIG_CRYPTO_SHA256)]
+pub(crate) const SPDM_HASH_SHA2_256: u32 = SPDM_HASH_SHA_256;
+#[cfg(not(CONFIG_CRYPTO_SHA256))]
+pub(crate) const SPDM_HASH_SHA2_256: u32 = 0;
+
+#[cfg(CONFIG_CRYPTO_SHA512)]
+pub(crate) const SPDM_HASH_SHA2_384_512: u32 = SPDM_HASH_SHA_384 | SPDM_HASH_SHA_512;
+#[cfg(not(CONFIG_CRYPTO_SHA512))]
+pub(crate) const SPDM_HASH_SHA2_384_512: u32 = 0;
+
+pub(crate) const SPDM_ASYM_ALGOS: u32 = SPDM_ASYM_RSA | SPDM_ASYM_ECDSA;
+pub(crate) const SPDM_HASH_ALGOS: u32 = SPDM_HASH_SHA2_256 | SPDM_HASH_SHA2_384_512;
+
+/* Maximum number of ReqAlgStructs sent by this implementation */
+// pub(crate) const SPDM_MAX_REQ_ALG_STRUCT: usize = 4;
+
+pub(crate) const SPDM_OPAQUE_DATA_FMT_GENERAL: u8 = 1 << 1;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index fe36333b2d24..5eee5116d791 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -118,6 +118,10 @@
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.negotiate_algs() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
@@ -125,4 +129,14 @@
 ///
 /// @spdm_state: SPDM session state
 #[no_mangle]
-pub unsafe extern "C" fn spdm_destroy(_state: &'static mut SpdmState) {}
+pub unsafe extern "C" fn spdm_destroy(state: &'static mut SpdmState) {
+    if let Some(desc) = &mut state.desc {
+        unsafe {
+            bindings::kfree(*desc as *mut _ as *mut c_void);
+        }
+    }
+
+    unsafe {
+        bindings::crypto_free_shash(state.shash);
+    }
+}
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 288a77b3ab56..0aff45339e0b 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -13,15 +13,21 @@
 use kernel::{
     bindings,
     error::{code::EINVAL, to_result, Error},
+    str::CStr,
     validate::Untrusted,
 };
 
 use crate::consts::{
-    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPDM_MIN_DATA_TRANSFER_SIZE,
-    SPDM_MIN_VER, SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
+    SpdmErrorCode, SPDM_ASYM_ALGOS, SPDM_ASYM_ECDSA_ECC_NIST_P256, SPDM_ASYM_ECDSA_ECC_NIST_P384,
+    SPDM_ASYM_ECDSA_ECC_NIST_P521, SPDM_ASYM_RSASSA_2048, SPDM_ASYM_RSASSA_3072,
+    SPDM_ASYM_RSASSA_4096, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_HASH_ALGOS, SPDM_HASH_SHA_256,
+    SPDM_HASH_SHA_384, SPDM_HASH_SHA_512, SPDM_KEY_EX_CAP, SPDM_MAX_VER, SPDM_MEAS_CAP_MASK,
+    SPDM_MEAS_SPEC_DMTF, SPDM_MIN_DATA_TRANSFER_SIZE, SPDM_MIN_VER, SPDM_OPAQUE_DATA_FMT_GENERAL,
+    SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
 };
 use crate::validator::{
-    GetCapabilitiesReq, GetCapabilitiesRsp, GetVersionReq, GetVersionRsp, SpdmErrorRsp, SpdmHeader,
+    GetCapabilitiesReq, GetCapabilitiesRsp, GetVersionReq, GetVersionRsp, NegotiateAlgsReq,
+    NegotiateAlgsRsp, RegAlg, SpdmErrorRsp, SpdmHeader,
 };
 
 /// The current SPDM session state for a device. Based on the
@@ -40,6 +46,28 @@
 ///  Negotiated during GET_VERSION exchange.
 /// @rsp_caps: Cached capabilities of responder.
 ///  Received during GET_CAPABILITIES exchange.
+/// @base_asym_alg: Asymmetric key algorithm for signature verification of
+///  CHALLENGE_AUTH and MEASUREMENTS messages.
+///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+/// @base_hash_alg: Hash algorithm for signature verification of
+///  CHALLENGE_AUTH and MEASUREMENTS messages.
+///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+/// @meas_hash_alg: Hash algorithm for measurement blocks.
+///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+/// @base_asym_enc: Human-readable name of @base_asym_alg's signature encoding.
+///  Passed to crypto subsystem when calling verify_signature().
+/// @sig_len: Signature length of @base_asym_alg (in bytes).
+///  S or SigLen in SPDM specification.
+/// @base_hash_alg_name: Human-readable name of @base_hash_alg.
+///  Passed to crypto subsystem when calling crypto_alloc_shash() and
+///  verify_signature().
+/// @base_hash_alg_name: Human-readable name of @base_hash_alg.
+///  Passed to crypto subsystem when calling crypto_alloc_shash() and
+///  verify_signature().
+/// @shash: Synchronous hash handle for @base_hash_alg computation.
+/// @desc: Synchronous hash context for @base_hash_alg computation.
+/// @hash_len: Hash length of @base_hash_alg (in bytes).
+///  H in SPDM specification.
 ///
 /// `authenticated`: Whether device was authenticated successfully.
 #[expect(dead_code)]
@@ -54,6 +82,19 @@ pub struct SpdmState {
     // Negotiated state
     pub(crate) version: u8,
     pub(crate) rsp_caps: u32,
+    pub(crate) base_asym_alg: u32,
+    pub(crate) base_hash_alg: u32,
+    pub(crate) meas_hash_alg: u32,
+
+    /* Signature algorithm */
+    base_asym_enc: &'static CStr,
+    sig_len: usize,
+
+    /* Hash algorithm */
+    base_hash_alg_name: &'static CStr,
+    pub(crate) shash: *mut bindings::crypto_shash,
+    pub(crate) desc: Option<&'static mut bindings::shash_desc>,
+    pub(crate) hash_len: usize,
 
     pub(crate) authenticated: bool,
 }
@@ -76,6 +117,15 @@ pub(crate) fn new(
             validate,
             version: SPDM_MIN_VER,
             rsp_caps: 0,
+            base_asym_alg: 0,
+            base_hash_alg: 0,
+            meas_hash_alg: 0,
+            base_asym_enc: unsafe { CStr::from_bytes_with_nul_unchecked(b"\0") },
+            sig_len: 0,
+            base_hash_alg_name: unsafe { CStr::from_bytes_with_nul_unchecked(b"\0") },
+            shash: core::ptr::null_mut(),
+            desc: None,
+            hash_len: 0,
             authenticated: false,
         }
     }
@@ -336,4 +386,161 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    fn update_response_algs(&mut self) -> Result<(), Error> {
+        match self.base_asym_alg {
+            SPDM_ASYM_RSASSA_2048 => {
+                self.sig_len = 256;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
+            }
+            SPDM_ASYM_RSASSA_3072 => {
+                self.sig_len = 384;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
+            }
+            SPDM_ASYM_RSASSA_4096 => {
+                self.sig_len = 512;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
+            }
+            SPDM_ASYM_ECDSA_ECC_NIST_P256 => {
+                self.sig_len = 64;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
+            }
+            SPDM_ASYM_ECDSA_ECC_NIST_P384 => {
+                self.sig_len = 96;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
+            }
+            SPDM_ASYM_ECDSA_ECC_NIST_P521 => {
+                self.sig_len = 132;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
+            }
+            _ => {
+                pr_err!("Unknown asym algorithm\n");
+                return Err(EINVAL);
+            }
+        }
+
+        match self.base_hash_alg {
+            SPDM_HASH_SHA_256 => {
+                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha256\0")?;
+            }
+            SPDM_HASH_SHA_384 => {
+                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha384\0")?;
+            }
+            SPDM_HASH_SHA_512 => {
+                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha512\0")?;
+            }
+            _ => {
+                pr_err!("Unknown hash algorithm\n");
+                return Err(EINVAL);
+            }
+        }
+
+        /*
+         * shash and desc allocations are reused for subsequent measurement
+         * retrieval, hence are not freed until spdm_reset().
+         */
+        self.shash =
+            unsafe { bindings::crypto_alloc_shash(self.base_hash_alg_name.as_char_ptr(), 0, 0) };
+        if self.shash.is_null() {
+            return Err(ENOMEM);
+        }
+
+        let desc_len = core::mem::size_of::<bindings::shash_desc>()
+            + unsafe { bindings::crypto_shash_descsize(self.shash) } as usize;
+
+        let mut desc_vec: KVec<u8> = KVec::with_capacity(desc_len, GFP_KERNEL)?;
+        // SAFETY: `desc_vec` is `desc_len` long
+        let desc_buf = unsafe { from_raw_parts_mut(desc_vec.as_mut_ptr(), desc_len) };
+
+        let desc = unsafe {
+            core::mem::transmute::<*mut c_void, &mut bindings::shash_desc>(
+                desc_buf.as_mut_ptr() as *mut c_void
+            )
+        };
+        desc.tfm = self.shash;
+
+        self.desc = Some(desc);
+
+        /* Used frequently to compute offsets, so cache H */
+        self.hash_len = unsafe { bindings::crypto_shash_digestsize(self.shash) as usize };
+
+        if let Some(desc) = &mut self.desc {
+            unsafe { to_result(bindings::crypto_shash_init(*desc)) }
+        } else {
+            Err(ENOMEM)
+        }
+    }
+
+    pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
+        let mut request = NegotiateAlgsReq::default();
+        request.version = self.version;
+
+        if self.version >= SPDM_VER_12 && (self.rsp_caps & SPDM_KEY_EX_CAP) == SPDM_KEY_EX_CAP {
+            request.other_params_support = SPDM_OPAQUE_DATA_FMT_GENERAL;
+        }
+
+        // TODO support more algs
+        let reg_alg_entries = 0;
+
+        let req_sz = core::mem::size_of::<NegotiateAlgsReq>()
+            + core::mem::size_of::<RegAlg>() * reg_alg_entries;
+        let rsp_sz = core::mem::size_of::<NegotiateAlgsRsp>()
+            + core::mem::size_of::<RegAlg>() * reg_alg_entries;
+
+        request.length = req_sz as u16;
+        request.param1 = reg_alg_entries as u8;
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+        let mut response_vec: KVec<u8> = KVec::with_capacity(rsp_sz, GFP_KERNEL)?;
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let response_buf = unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), rsp_sz) };
+
+        let rc = self.spdm_exchange(request_buf, response_buf)?;
+
+        if rc < (rsp_sz as i32) {
+            pr_err!("Truncated capabilities response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        // SAFETY: `rc` bytes where inserted to the raw pointer by spdm_exchange
+        unsafe { response_vec.set_len(rc as usize) };
+
+        let response: &mut NegotiateAlgsRsp =
+            Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        self.base_asym_alg = response.base_asym_sel;
+        self.base_hash_alg = response.base_hash_sel;
+        self.meas_hash_alg = response.measurement_hash_algo;
+
+        if self.base_asym_alg & SPDM_ASYM_ALGOS == 0 || self.base_hash_alg & SPDM_HASH_ALGOS == 0 {
+            pr_err!("No common supported algorithms\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        // /* Responder shall select exactly 1 alg (SPDM 1.0.0 table 14) */
+        if self.base_asym_alg.count_ones() != 1
+            || self.base_hash_alg.count_ones() != 1
+            || response.ext_asym_sel_count != 0
+            || response.ext_hash_sel_count != 0
+            || response.param1 > request.param1
+            || response.other_params_sel != request.other_params_support
+        {
+            pr_err!("Malformed algorithms response\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        if self.rsp_caps & SPDM_MEAS_CAP_MASK == SPDM_MEAS_CAP_MASK
+            && (self.meas_hash_alg.count_ones() != 1
+                || response.measurement_specification_sel != SPDM_MEAS_SPEC_DMTF)
+        {
+            pr_err!("Malformed algorithms response\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        self.update_response_algs()?;
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index cd792c46767a..036a077c71c3 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -7,7 +7,7 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
-use crate::bindings::{__IncompleteArrayField, __le16};
+use crate::bindings::{__IncompleteArrayField, __le16, __le32};
 use crate::consts::SpdmErrorCode;
 use core::mem;
 use kernel::prelude::*;
@@ -16,7 +16,10 @@
     validate::{Unvalidated, Validate},
 };
 
-use crate::consts::{SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_VERSION, SPDM_REQ_CAPS};
+use crate::consts::{
+    SPDM_ASYM_ALGOS, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_VERSION, SPDM_HASH_ALGOS,
+    SPDM_MEAS_SPEC_DMTF, SPDM_NEGOTIATE_ALGS, SPDM_REQ_CAPS,
+};
 
 #[repr(C, packed)]
 pub(crate) struct SpdmHeader {
@@ -205,3 +208,111 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
         Ok(rsp)
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct RegAlg {
+    pub(crate) alg_type: u8,
+    pub(crate) alg_count: u8,
+    pub(crate) alg_supported: u16,
+    pub(crate) alg_external: __IncompleteArrayField<__le32>,
+}
+
+#[repr(C, packed)]
+pub(crate) struct NegotiateAlgsReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) length: u16,
+    pub(crate) measurement_specification: u8,
+    pub(crate) other_params_support: u8,
+
+    pub(crate) base_asym_algo: u32,
+    pub(crate) base_hash_algo: u32,
+
+    reserved1: [u8; 12],
+
+    pub(crate) ext_asym_count: u8,
+    pub(crate) ext_hash_count: u8,
+    reserved2: u8,
+    pub(crate) mel_specification: u8,
+
+    pub(crate) ext_asym: __IncompleteArrayField<__le32>,
+    pub(crate) ext_hash: __IncompleteArrayField<__le32>,
+    pub(crate) req_alg_struct: __IncompleteArrayField<RegAlg>,
+}
+
+impl Default for NegotiateAlgsReq {
+    fn default() -> Self {
+        NegotiateAlgsReq {
+            version: 0,
+            code: SPDM_NEGOTIATE_ALGS,
+            param1: 0,
+            param2: 0,
+            length: 0,
+            measurement_specification: SPDM_MEAS_SPEC_DMTF,
+            other_params_support: 0,
+            base_asym_algo: SPDM_ASYM_ALGOS.to_le(),
+            base_hash_algo: SPDM_HASH_ALGOS.to_le(),
+            reserved1: [0u8; 12],
+            ext_asym_count: 0,
+            ext_hash_count: 0,
+            reserved2: 0,
+            mel_specification: 0,
+            ext_asym: __IncompleteArrayField::new(),
+            ext_hash: __IncompleteArrayField::new(),
+            req_alg_struct: __IncompleteArrayField::new(),
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct NegotiateAlgsRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) length: u16,
+    pub(crate) measurement_specification_sel: u8,
+    pub(crate) other_params_sel: u8,
+
+    pub(crate) measurement_hash_algo: u32,
+    pub(crate) base_asym_sel: u32,
+    pub(crate) base_hash_sel: u32,
+
+    reserved1: [u8; 11],
+
+    pub(crate) mel_specification_sel: u8,
+    pub(crate) ext_asym_sel_count: u8,
+    pub(crate) ext_hash_sel_count: u8,
+    reserved2: [u8; 2],
+
+    pub(crate) ext_asym: __IncompleteArrayField<__le32>,
+    pub(crate) ext_hash: __IncompleteArrayField<__le32>,
+    pub(crate) req_alg_struct: __IncompleteArrayField<RegAlg>,
+}
+
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut NegotiateAlgsRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<NegotiateAlgsRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `NegotiateAlgsRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<NegotiateAlgsRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut NegotiateAlgsRsp = unsafe { &mut *ptr };
+
+        rsp.base_asym_sel = rsp.base_asym_sel.to_le();
+        rsp.base_hash_sel = rsp.base_hash_sel.to_le();
+        rsp.measurement_hash_algo = rsp.measurement_hash_algo.to_le();
+
+        Ok(rsp)
+    }
+}
diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index ec48ad2e8c78..978276e17754 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -30,3 +30,8 @@
 
 --allowlist-function copy_from_user
 --allowlist-function copy_to_user
+
+--allowlist-function crypto_shash_descsize
+--allowlist-function crypto_shash_init
+--allowlist-function crypto_shash_digestsize
+--allowlist-function crypto_free_shash
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 42aa62f0c8f5..5ba1191429f8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -6,6 +6,7 @@
  * Sorted alphabetically.
  */
 
+#include <crypto/hash.h>
 #include <kunit/test.h>
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
@@ -17,6 +18,7 @@
 #include <linux/file.h>
 #include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/hash.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
 #include <linux/mdio.h>
-- 
2.48.1


