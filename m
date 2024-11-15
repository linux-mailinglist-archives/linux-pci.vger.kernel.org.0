Return-Path: <linux-pci+bounces-16813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB46C9CD6AF
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC92B246FB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 05:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A46186E56;
	Fri, 15 Nov 2024 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="J/NU06tg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmlVrc0e"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8021F186E27;
	Fri, 15 Nov 2024 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649630; cv=none; b=TIFcXDbA2NkDRSqVxNUlCvbcKnyvYncE3RQQ8iHdPMTqp2xT5W09oVhHpwgY8OAkZRlEwzCq86Q4QizaytscW4BTjJG574DGbM7X2ZQfbd2eF4cbMuUXkmun11UW6RetefHDRGWeIg+3uwqyg7UI/1wTGVXfTxteB5KoBdOZwVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649630; c=relaxed/simple;
	bh=5F+hLvDs4A8FN9CMtRg9LRjXnhwzqS8Prz1T2799WjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMQtmA0oMUhkknsKgA38mKNByolJby+IVQG/Vs6U0CziS4mH4E9v0Nix69F78Ly4esjmGZbAaUMb11/ec98VIzyMCPZcxiFJoFNaJxWwtbwWdEb+TKeX2MLH1XHiuhsVbCw++nLS3HckI42+6OF5jeMtToLW0sBUJuJhfHoFWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=J/NU06tg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kmlVrc0e; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id EB17E114017F;
	Fri, 15 Nov 2024 00:47:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 15 Nov 2024 00:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731649626; x=
	1731736026; bh=UZJLlsXnBcXHAy1DLry3lTh/JADdKw2bOg5zY1Fzbm0=; b=J
	/NU06tg8nxpITnXAeDcsn+PJxXw+EuMHAcyQjXLZR7kVRvc0AiBhKWpm9fCr4OrW
	ECP9ITZRTuovyRdgmLPEpn64HLVJWW0OEQEKGQ488mzHtPrYd/5hhkNyZJgtU1K4
	YIt6qoiQt8RXdxAr7iH72tmyxV4DcogN3eMVEgXsphugUGHSbfDPQATBzvdqBt78
	myf7xIoMNySaTKN0TIVIgzeuW8UXaiUZwDOd5QeE7CMJnB2t+Umrd8KdwuqaRFu6
	XZaX3mtPKcH1yF55hj/1sQgLFiWcNu6URF2Zhq7ZBdPIR36VcowRlxWPVNZDoe0P
	Rr6KAV4+XSinBM+fJ5usw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731649626; x=1731736026; bh=U
	ZJLlsXnBcXHAy1DLry3lTh/JADdKw2bOg5zY1Fzbm0=; b=kmlVrc0eEQ2Ibbhiu
	BHu+IFJGhmDhShPaRgoBwTaRKGXUzSj5kdJD7lO4CvXJXmKXav+nZ8kj8Aq4xURa
	2K0vclOtBXglfWNMVc2/GiHWCdcvUZG7OyqquCioqplII8GG1oTP6M1kLlhOTCkd
	uaVUc+xTpv4kO63yjkvJB64cCbp3+QlbrWGm4qxVGCe0sVc92/n0cE8nSDuEcd8i
	tRytBGd59VWfTTJW+1zDdM1SGOeKrpzXMBGV1Y6PS4an25/CvtVvQXPOCWgGkCrp
	0H9Ri8p9U1dKtt++edBSWsjFgtFEaKbGtuGU2ZnMInZJt3Dp9LNS88FjI3ckPfCp
	neKPA==
X-ME-Sender: <xms:WuA2Zw2jqPMTLVgWXPALH5IDNJfQDRtmUtMNou4sL1buPYrzBy0hEQ>
    <xme:WuA2Z7E2PR-FYjHNSDu3totLzpmD_umOAqA6U7wp9NwCtC6cl_ELi48iBbWYsa3NX
    SMJiuueFCULMJ0Vpwk>
X-ME-Received: <xmr:WuA2Z46nvyz09TMtYo_z6UzdcDESzCgfT2VgFMM2rY8U5hOhcCmhUu2hwFCaHDQpizVCvv5FlLb1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeegteeffedugfeuhfelgfffkeekieelleeileehgeekgeehjedvleekieethffg
    vdenucffohhmrghinhepsggrshgvpghhrghshhgprghlghgpnhgrmhgvrdgrshdpshhhrg
    hshhdrmhgrphdpsggrshgvpggrshihmhgpshgvlhdrthhopdgsrghsvggphhgrshhhpghs
    vghlrdhtohdpmhgvrghsuhhrvghmvghnthgphhgrshhhpggrlhhgohdrthhonecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthho
    pehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphht
    thhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgt
    gihlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghjohhrnhefpghghh
    esphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:WuA2Z51X7x0ID-_G7CX1Y7qRicn1yWUuzr67ODSzmsmcKP11FJaVDQ>
    <xmx:WuA2ZzEgn-7-eODKYOB140qKTcrHv4UheMp954FNLkzNNmW36Ti4JA>
    <xmx:WuA2Zy9Xvzx6xWMGP_H2B4xIYh28IJ-opeIckCaBRZ7L6_0V5bWB_g>
    <xmx:WuA2Z4nqvVkvUjIZrk7PuVhWdLGr3lgtSMFj0nTG75FeRvQGI6OZJg>
    <xmx:WuA2Z-lPNpMeEonubU8jLh71ywW8UfpR4JJx6CEmVpKeiwsCSk5BtFJH>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 00:47:01 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: bjorn3_gh@protonmail.com,
	ojeda@kernel.org,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	alistair23@gmail.com,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	aliceryhl@google.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC 6/6] lib: rspdm: Support SPDM negotiate_algorithms
Date: Fri, 15 Nov 2024 15:46:16 +1000
Message-ID: <20241115054616.1226735-7-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115054616.1226735-1-alistair@alistair23.me>
References: <20241115054616.1226735-1-alistair@alistair23.me>
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
 lib/rspdm/lib.rs                |   4 +
 lib/rspdm/state.rs              | 225 +++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs          | 110 +++++++++++++++-
 rust/bindgen_static_functions   |   4 +
 rust/bindings/bindings_helper.h |   1 +
 6 files changed, 392 insertions(+), 5 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index d60f8302f389..a1218874a524 100644
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
index bbd755854acd..89be29f1b5dd 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -115,6 +115,10 @@
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.negotiate_algs() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 05a7faf17d47..80027bbde673 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -12,16 +12,22 @@
 use kernel::{
     bindings,
     error::{code::EINVAL, to_result, Error},
+    str::CStr,
     validate::Untrusted,
 };
 
 use crate::consts::{
-    SpdmErrorCode, SPDM_CTEXPONENT, SPDM_ERROR, SPDM_GET_CAPABILITIES, SPDM_GET_VERSION,
-    SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPDM_MIN_DATA_TRANSFER_SIZE, SPDM_MIN_VER, SPDM_REQ,
-    SPDM_REQ_CAPS, SPDM_RSP_MIN_CAPS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
+    SpdmErrorCode, SPDM_ASYM_ALGOS, SPDM_ASYM_ECDSA_ECC_NIST_P256, SPDM_ASYM_ECDSA_ECC_NIST_P384,
+    SPDM_ASYM_ECDSA_ECC_NIST_P521, SPDM_ASYM_RSASSA_2048, SPDM_ASYM_RSASSA_3072,
+    SPDM_ASYM_RSASSA_4096, SPDM_CTEXPONENT, SPDM_ERROR, SPDM_GET_CAPABILITIES, SPDM_GET_VERSION,
+    SPDM_GET_VERSION_LEN, SPDM_HASH_ALGOS, SPDM_HASH_SHA_256, SPDM_HASH_SHA_384, SPDM_HASH_SHA_512,
+    SPDM_KEY_EX_CAP, SPDM_MAX_VER, SPDM_MEAS_CAP_MASK, SPDM_MEAS_SPEC_DMTF,
+    SPDM_MIN_DATA_TRANSFER_SIZE, SPDM_MIN_VER, SPDM_NEGOTIATE_ALGS, SPDM_OPAQUE_DATA_FMT_GENERAL,
+    SPDM_REQ, SPDM_REQ_CAPS, SPDM_RSP_MIN_CAPS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
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
 /// @authenticated: Whether device was authenticated successfully.
 #[allow(dead_code)]
@@ -54,6 +82,19 @@ pub struct SpdmState {
     /* Negotiated state */
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
+    shash: Option<*mut bindings::crypto_shash>,
+    desc: Option<&'static mut bindings::shash_desc>,
+    hash_len: usize,
 
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
+            shash: None,
+            desc: None,
+            hash_len: 0,
             authenticated: false,
         }
     }
@@ -336,4 +386,171 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
 
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
+        let shash =
+            unsafe { bindings::crypto_alloc_shash(self.base_hash_alg_name.as_char_ptr(), 0, 0) };
+        if shash.is_null() {
+            return Err(ENOMEM);
+        }
+
+        let desc_len = core::mem::size_of::<bindings::shash_desc>()
+            + unsafe { bindings::crypto_shash_descsize(shash) } as usize;
+        self.shash = Some(shash);
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
+        desc.tfm = shash;
+
+        self.desc = Some(desc);
+
+        /* Used frequently to compute offsets, so cache H */
+        self.shash.map(|shash| {
+            self.hash_len = unsafe { bindings::crypto_shash_digestsize(shash) as usize };
+        });
+
+        if let Some(desc) = &mut self.desc {
+            unsafe {
+                to_result(bindings::crypto_shash_init(
+                    *desc as *mut bindings::shash_desc,
+                ))
+            }
+        } else {
+            Err(ENOMEM)
+        }
+    }
+
+    pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
+        let mut request = NegotiateAlgsReq::default();
+        let reg_alg_entries = 0;
+
+        request.version = self.version;
+        request.code = SPDM_NEGOTIATE_ALGS;
+        request.measurement_specification = SPDM_MEAS_SPEC_DMTF;
+        request.base_asym_algo = SPDM_ASYM_ALGOS.to_le();
+        request.base_hash_algo = SPDM_HASH_ALGOS.to_le();
+
+        if self.version >= SPDM_VER_12 && (self.rsp_caps & SPDM_KEY_EX_CAP) == SPDM_KEY_EX_CAP {
+            request.other_params_support = SPDM_OPAQUE_DATA_FMT_GENERAL;
+        }
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
index cc998e70f235..5f64870e18d2 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -6,7 +6,7 @@
 //!
 //! Copyright (C) 2024 Western Digital
 
-use crate::bindings::{__IncompleteArrayField, __le16};
+use crate::bindings::{__IncompleteArrayField, __le16, __le32};
 use crate::consts::SpdmErrorCode;
 use core::mem;
 use kernel::prelude::*;
@@ -191,3 +191,111 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
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
+            code: 0,
+            param1: 0,
+            param2: 0,
+            length: 0,
+            measurement_specification: 0,
+            other_params_support: 0,
+            base_asym_algo: 0,
+            base_hash_algo: 0,
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
index ec48ad2e8c78..617316ce1925 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -30,3 +30,7 @@
 
 --allowlist-function copy_from_user
 --allowlist-function copy_to_user
+
+--allowlist-function crypto_shash_descsize
+--allowlist-function crypto_shash_init
+--allowlist-function crypto_shash_digestsize
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 8283e6a79ac9..c2f6b9a471bc 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -6,6 +6,7 @@
  * Sorted alphabetically.
  */
 
+#include <crypto/hash.h>
 #include <kunit/test.h>
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
-- 
2.47.0


