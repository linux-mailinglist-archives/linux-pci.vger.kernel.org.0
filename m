Return-Path: <linux-pci+bounces-22506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F34A47377
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C0F3B763F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4951B372C;
	Thu, 27 Feb 2025 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="HamN6V9y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iu21XGJ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F31AA1E4;
	Thu, 27 Feb 2025 03:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625951; cv=none; b=bFimsrGtStY/CJqTNFRbEgr09hW5ypG5dbJ4XLHqVMYAXiPmW9iPBAdClfO/4I3LF6z1947fFMVnGK7Iv/8N5NX9luwbE4hit7MZeoG8PKwzOCEOvQLF8w7087a7vbwqY+81O4zSSFi1CIosspSLmnNJOX5kMbgcBQqBxvzDK3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625951; c=relaxed/simple;
	bh=oLc6vRpYJ0xDVs2Dp2SxK42oRhdIET3pEOCkPPlQDTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocImuJMpYwdht4L6GbW13dJiqs5R/eWehlwKhl1NqHOHBbUIf2AUYUMkUPpGYsrZwgd05xqkF5jZd3jbuSVh1EtdJkQrj0OVOGLTUeGfT5gF6xBnWhSBvXSLLyX5cuehzchpMoCeuaVazBUcEFe4zVNTsgZdF1ynXHfOr42wodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=HamN6V9y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iu21XGJ5; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F82411401BD;
	Wed, 26 Feb 2025 22:12:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 26 Feb 2025 22:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625948; x=
	1740712348; bh=gvplroEYlID/SuFvQTVuGaL+OgftQDgU+sH7ibNw/EY=; b=H
	amN6V9ykH3sBV6UobUMbew3hkf75Yw6PYVR0ys3kaNBYBUTqe5imt/gEaTSfJnDM
	oIEd24RF0wqzWagEX+E/2ZHvEOVnM7/GraGg2q2WEADiYkaPCcWZrlQCHwNQTBVi
	U8Et3NsljPvdAJQ5Cg8dak1N8DQkp22i+G0Oh+ufqDNLUrLneXKOzrh6z5Mu2lp7
	jOTUU27pVVxMfkmOERra6j31XCI8gvufuINrgVvpWEu1LYJg5IEPlkqazerFaIvn
	xaFnmcSE9Bth0afhNtVXWlnW0MSjLJtZr+1/5zsbxdbc7HYDM9CH5YjyUXv2kbHw
	H0E7Q8wfiUIa0Akjxe6IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625948; x=1740712348; bh=g
	vplroEYlID/SuFvQTVuGaL+OgftQDgU+sH7ibNw/EY=; b=Iu21XGJ5gtoE3EMn2
	2pe/AJr/BA6qKaH3n1mUOPEB0/QOgmIPpxrbuDLH572NiB5KxYxGs27mh7ClqRZg
	WtDD7bbUFYOWG/QlCoG8D7hj9Vs052kSV6hZPhucnILkoxvHI5ILfGeekIsxXk6o
	xL2ldfRj0kL+3LDlPjOy/BajMdl1kHM5WEUUNRhEGQk0PF60yyQAUzEi+MffV4iI
	DsuzkvKa19ZDoFCPVgvBY2GEVtUpcloZhfYI49jDkhl9dseGJrFQrA6dVkNhhDh6
	lNBYq4UYnSl8fk7yHD3Uwk2KW1GcYA4tyAtb8IQ1vd28BTFs3XtrKARMisQ2k2io
	q1m2g==
X-ME-Sender: <xms:HNi_ZyxzSEYMkoPXgkDXUQEo5XyzmPmElVOprQFLfMjnVI9NxVvK7Q>
    <xme:HNi_Z-St2KA9xD4eyRiPX-Pai05bheRFHzf_IrKGqr4MOejFVAt9-C_l_GNKdFTSy
    F14EB-2tENw2LXRkQY>
X-ME-Received: <xmr:HNi_Z0U6DSbdrn4r4lKbTwuZ3x6mBtHVSwOxlyxThX0AKUBWLGSVpARgXjIJPQ1yj3E9sT_pzDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpefhvedvvdefjeduffeujefh
    hfeigfelheelvdfgfeejueeuhfelieffleehleekudenucffohhmrghinhepsggrshgvpg
    grshihmhgpvghntgdrrghspdgsrghsvggphhgrshhhpggrlhhgpghnrghmvgdrrghspdht
    rhgrnhhstghrihhpthdrrghspdhophgrqhhuvggpuggrthgrpghlvghnrdhtohenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthho
    pehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    hhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdr
    tggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqd
    hlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvg
    hnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:HNi_Z4g5e-gJlj5dNHfOSCrEYFiQ7AxYBJa6YwIipygxqHP03hzdyw>
    <xmx:HNi_Z0Bzy-fliv8Nultky-CL6ATf-1M5APsYgvUyl0aLYkFhuRPSKA>
    <xmx:HNi_Z5IuErvlxoe9HLEdJFIfrkTJ_nHkggdWGA7TNCECeIIPHiGhHg>
    <xmx:HNi_Z7CRyvk-ON-LBaKU-kyzK17L7hAn0IC1_1Z5hMOh5hvqE1cHoA>
    <xmx:HNi_Z7Bkc0q9Y5W16gG_bXvRhmhmewbDgfUhMO9SrCXELr3eUz5XHO_7>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:12:22 -0500 (EST)
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
Subject: [RFC v2 20/20] lib: rspdm: Support SPDM challenge
Date: Thu, 27 Feb 2025 13:09:52 +1000
Message-ID: <20250227030952.2319050-21-alistair@alistair23.me>
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

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs             |   6 +
 lib/rspdm/lib.rs                |   8 +-
 lib/rspdm/state.rs              | 212 ++++++++++++++++++++++++++++++--
 lib/rspdm/validator.rs          |  65 +++++++++-
 rust/bindings/bindings_helper.h |   1 +
 5 files changed, 283 insertions(+), 9 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index ffaf36ec583b..af4e1a98dc5b 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -98,6 +98,8 @@ pub(crate) enum SpdmErrorCode {
 
 pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
 
+pub(crate) const SPDM_CHALLENGE: u8 = 0x83;
+
 #[cfg(CONFIG_CRYPTO_RSA)]
 pub(crate) const SPDM_ASYM_RSA: u32 =
     SPDM_ASYM_RSASSA_2048 | SPDM_ASYM_RSASSA_3072 | SPDM_ASYM_RSASSA_4096;
@@ -127,3 +129,7 @@ pub(crate) enum SpdmErrorCode {
 // pub(crate) const SPDM_MAX_REQ_ALG_STRUCT: usize = 4;
 
 pub(crate) const SPDM_OPAQUE_DATA_FMT_GENERAL: u8 = 1 << 1;
+
+pub(crate) const SPDM_PREFIX_SZ: usize = 64;
+pub(crate) const SPDM_COMBINED_PREFIX_SZ: usize = 100;
+pub(crate) const SPDM_MAX_OPAQUE_DATA: usize = 1024;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index b7ad3b8c659e..c0e3e039c14f 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -137,17 +137,23 @@
         provisioned_slots &= !(1 << slot);
     }
 
+    let mut verify = true;
     let mut provisioned_slots = state.provisioned_slots;
     while (provisioned_slots as usize) > 0 {
         let slot = provisioned_slots.trailing_zeros() as u8;
 
         if let Err(e) = state.validate_cert_chain(slot) {
-            return e.to_errno() as c_int;
+            pr_debug!("Certificate in slot {slot} failed to verify: {e:?}");
+            verify = false;
         }
 
         provisioned_slots &= !(1 << slot);
     }
 
+    if let Err(e) = state.challenge(state.provisioned_slots.trailing_zeros() as u8, verify) {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 974d2ee8c0ce..4629c12a1b81 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -14,23 +14,27 @@
     bindings,
     error::{code::EINVAL, from_err_ptr, to_result, Error},
     str::CStr,
+    str::CString,
     validate::Untrusted,
 };
 
 use crate::consts::{
     SpdmErrorCode, SPDM_ASYM_ALGOS, SPDM_ASYM_ECDSA_ECC_NIST_P256, SPDM_ASYM_ECDSA_ECC_NIST_P384,
     SPDM_ASYM_ECDSA_ECC_NIST_P521, SPDM_ASYM_RSASSA_2048, SPDM_ASYM_RSASSA_3072,
-    SPDM_ASYM_RSASSA_4096, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_HASH_ALGOS, SPDM_HASH_SHA_256,
-    SPDM_HASH_SHA_384, SPDM_HASH_SHA_512, SPDM_KEY_EX_CAP, SPDM_MAX_VER, SPDM_MEAS_CAP_MASK,
-    SPDM_MEAS_SPEC_DMTF, SPDM_MIN_DATA_TRANSFER_SIZE, SPDM_MIN_VER, SPDM_OPAQUE_DATA_FMT_GENERAL,
+    SPDM_ASYM_RSASSA_4096, SPDM_COMBINED_PREFIX_SZ, SPDM_ERROR, SPDM_GET_VERSION_LEN,
+    SPDM_HASH_ALGOS, SPDM_HASH_SHA_256, SPDM_HASH_SHA_384, SPDM_HASH_SHA_512, SPDM_KEY_EX_CAP,
+    SPDM_MAX_OPAQUE_DATA, SPDM_MAX_VER, SPDM_MEAS_CAP_MASK, SPDM_MEAS_SPEC_DMTF,
+    SPDM_MIN_DATA_TRANSFER_SIZE, SPDM_MIN_VER, SPDM_OPAQUE_DATA_FMT_GENERAL, SPDM_PREFIX_SZ,
     SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_SLOTS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
 };
 use crate::validator::{
-    GetCapabilitiesReq, GetCapabilitiesRsp, GetCertificateReq, GetCertificateRsp, GetDigestsReq,
-    GetDigestsRsp, GetVersionReq, GetVersionRsp, NegotiateAlgsReq, NegotiateAlgsRsp, RegAlg,
-    SpdmErrorRsp, SpdmHeader,
+    ChallengeReq, ChallengeRsp, GetCapabilitiesReq, GetCapabilitiesRsp, GetCertificateReq,
+    GetCertificateRsp, GetDigestsReq, GetDigestsRsp, GetVersionReq, GetVersionRsp,
+    NegotiateAlgsReq, NegotiateAlgsRsp, RegAlg, SpdmErrorRsp, SpdmHeader,
 };
 
+const SPDM_CONTEXT: &str = "responder-challenge_auth signing";
+
 /// The current SPDM session state for a device. Based on the
 /// C `struct spdm_state`.
 ///
@@ -78,6 +82,12 @@
 /// @slot_sz: Certificate chain size (in bytes).
 /// @leaf_key: Public key portion of leaf certificate against which to check
 ///  responder's signatures.
+/// @transcript: Concatenation of all SPDM messages exchanged during an
+///  authentication or measurement sequence.  Used to verify the signature,
+///  as it is computed over the hashed transcript.
+/// @next_nonce: Requester nonce to be used for the next authentication
+///  sequence.  Populated from user space through sysfs.
+///  If user space does not provide a nonce, the kernel uses a random one.
 ///
 /// `authenticated`: Whether device was authenticated successfully.
 pub struct SpdmState {
@@ -113,6 +123,10 @@ pub struct SpdmState {
     pub(crate) slot: [Option<KVec<u8>>; SPDM_SLOTS],
     slot_sz: [usize; SPDM_SLOTS],
     pub(crate) leaf_key: Option<*mut bindings::public_key>,
+
+    transcript: KVec<u8>,
+
+    next_nonce: Option<&'static mut [u8]>,
 }
 
 #[repr(C, packed)]
@@ -156,6 +170,8 @@ pub(crate) fn new(
             slot: [const { None }; SPDM_SLOTS],
             slot_sz: [0; SPDM_SLOTS],
             leaf_key: None,
+            transcript: KVec::new(),
+            next_nonce: None,
         }
     }
 
@@ -263,7 +279,7 @@ fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {
     /// The data in `request_buf` is sent to the device and the response is
     /// stored in `response_buf`.
     pub(crate) fn spdm_exchange(
-        &self,
+        &mut self,
         request_buf: &mut [u8],
         response_buf: &mut [u8],
     ) -> Result<i32, Error> {
@@ -271,6 +287,8 @@ pub(crate) fn spdm_exchange(
         let request: &mut SpdmHeader = Untrusted::new_mut(request_buf).validate_mut()?;
         let response: &SpdmHeader = Untrusted::new_ref(response_buf).validate()?;
 
+        self.transcript.extend_from_slice(request_buf, GFP_KERNEL)?;
+
         let transport_function = self.transport.ok_or(EINVAL)?;
         // SAFETY: `transport_function` is provided by the new(), we are
         // calling the function.
@@ -337,6 +355,12 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
         unsafe { response_vec.set_len(rc as usize) };
 
         let response: &mut GetVersionRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+        let rsp_sz = core::mem::size_of::<SpdmHeader>()
+            + 2
+            + response.version_number_entry_count as usize * 2;
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
 
         let mut foundver = false;
         for i in 0..response.version_number_entry_count {
@@ -400,6 +424,9 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
         let response: &mut GetCapabilitiesRsp =
             Untrusted::new_mut(&mut response_vec).validate_mut()?;
 
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
+
         self.rsp_caps = u32::from_le(response.flags);
         if (self.rsp_caps & SPDM_RSP_MIN_CAPS) != SPDM_RSP_MIN_CAPS {
             to_result(-(bindings::EPROTONOSUPPORT as i32))?;
@@ -539,6 +566,9 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
         let response: &mut NegotiateAlgsRsp =
             Untrusted::new_mut(&mut response_vec).validate_mut()?;
 
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
+
         self.base_asym_alg = response.base_asym_sel;
         self.base_hash_alg = response.base_hash_sel;
         self.meas_hash_alg = response.measurement_hash_algo;
@@ -598,6 +628,10 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
         unsafe { response_vec.set_len(rc as usize) };
 
         let response: &mut GetDigestsRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+        let rsp_sz = core::mem::size_of::<SpdmHeader>() + response.param2 as usize * self.hash_len;
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
 
         if rc
             < (core::mem::size_of::<GetDigestsReq>()
@@ -659,6 +693,10 @@ fn get_cert_exchange(
         unsafe { response_vec.set_len(rc as usize) };
 
         let response: &mut GetCertificateRsp = Untrusted::new_mut(response_vec).validate_mut()?;
+        let rsp_sz = core::mem::size_of::<SpdmHeader>() + 4 + response.portion_length as usize;
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
 
         if rc
             < (core::mem::size_of::<GetCertificateRsp>() + response.portion_length as usize) as i32
@@ -836,4 +874,164 @@ pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn challenge_rsp_len(&mut self, nonce_len: usize, opaque_len: usize) -> usize {
+        let mut length =
+            core::mem::size_of::<SpdmHeader>() + self.hash_len + nonce_len + opaque_len + 2;
+
+        if self.version >= 0x13 {
+            length += 8;
+        }
+
+        length + self.sig_len
+    }
+
+    fn verify_signature(&mut self, response_vec: &mut [u8]) -> Result<(), Error> {
+        let sig_start = response_vec.len() - self.sig_len;
+        let mut sig = bindings::public_key_signature::default();
+        let mut mhash: KVec<u8> = KVec::new();
+
+        sig.s = &mut response_vec[sig_start..] as *mut _ as *mut u8;
+        sig.s_size = self.sig_len as u32;
+        sig.encoding = self.base_asym_enc.as_ptr();
+        sig.hash_algo = self.base_hash_alg_name.as_ptr();
+
+        let mut m: KVec<u8> = KVec::new();
+        m.extend_with(SPDM_COMBINED_PREFIX_SZ + self.hash_len, 0, GFP_KERNEL)?;
+
+        if let Some(desc) = &mut self.desc {
+            desc.tfm = self.shash;
+
+            unsafe {
+                to_result(bindings::crypto_shash_digest(
+                    *desc,
+                    self.transcript.as_ptr(),
+                    (self.transcript.len() - self.sig_len) as u32,
+                    m[SPDM_COMBINED_PREFIX_SZ..].as_mut_ptr(),
+                ))?;
+            };
+        } else {
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        if self.version <= 0x11 {
+            sig.digest = m[SPDM_COMBINED_PREFIX_SZ..].as_mut_ptr();
+        } else {
+            let major = self.version >> 4;
+            let minor = self.version & 0xF;
+
+            let output = CString::try_from_fmt(fmt!("dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*"))?;
+            let mut buf = output.take_buffer();
+            let zero_pad_len = SPDM_COMBINED_PREFIX_SZ - SPDM_PREFIX_SZ - SPDM_CONTEXT.len() - 1;
+
+            buf.extend_with(zero_pad_len, 0, GFP_KERNEL)?;
+            buf.extend_from_slice(SPDM_CONTEXT.as_bytes(), GFP_KERNEL)?;
+
+            m[..SPDM_COMBINED_PREFIX_SZ].copy_from_slice(&buf);
+
+            mhash.extend_with(self.hash_len, 0, GFP_KERNEL)?;
+
+            if let Some(desc) = &mut self.desc {
+                desc.tfm = self.shash;
+
+                unsafe {
+                    to_result(bindings::crypto_shash_digest(
+                        *desc,
+                        m.as_ptr(),
+                        m.len() as u32,
+                        mhash.as_mut_ptr(),
+                    ))?;
+                };
+            } else {
+                to_result(-(bindings::EPROTO as i32))?;
+            }
+
+            sig.digest = mhash.as_mut_ptr();
+        }
+
+        sig.digest_size = self.hash_len as u32;
+
+        if let Some(leaf_key) = self.leaf_key {
+            unsafe { to_result(bindings::public_key_verify_signature(leaf_key, &sig)) }
+        } else {
+            to_result(-(bindings::EPROTO as i32))
+        }
+    }
+
+    pub(crate) fn challenge(&mut self, slot: u8, verify: bool) -> Result<(), Error> {
+        let mut request = ChallengeReq::default();
+        request.version = self.version;
+        request.param1 = slot;
+
+        let nonce_len = request.nonce.len();
+
+        if let Some(nonce) = &self.next_nonce {
+            request.nonce.copy_from_slice(&nonce);
+            self.next_nonce = None;
+        } else {
+            unsafe {
+                bindings::get_random_bytes(&mut request.nonce as *mut _ as *mut c_void, nonce_len)
+            };
+        }
+
+        let req_sz = if self.version <= 0x12 {
+            core::mem::size_of::<ChallengeReq>() - 8
+        } else {
+            core::mem::size_of::<ChallengeReq>()
+        };
+
+        let rsp_sz = self.challenge_rsp_len(nonce_len, SPDM_MAX_OPAQUE_DATA);
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
+        if rc < (core::mem::size_of::<ChallengeRsp>() as i32) {
+            pr_err!("Truncated challenge response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        // SAFETY: `rc` bytes where inserted to the raw pointer by spdm_exchange
+        unsafe { response_vec.set_len(rc as usize) };
+
+        let _response: &mut ChallengeRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        let opaque_len_offset = core::mem::size_of::<SpdmHeader>() + self.hash_len + nonce_len;
+        let opaque_len = u16::from_le_bytes(
+            response_vec[opaque_len_offset..(opaque_len_offset + 2)]
+                .try_into()
+                .unwrap_or([0, 0]),
+        );
+
+        let rsp_sz = self.challenge_rsp_len(nonce_len, opaque_len as usize);
+
+        if rc < rsp_sz as i32 {
+            pr_err!("Truncated challenge response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
+
+        if verify {
+            /* Verify signature at end of transcript against leaf key */
+            match self.verify_signature(&mut response_vec[..rsp_sz]) {
+                Ok(()) => {
+                    pr_info!("Authenticated with certificate slot {slot}");
+                    self.authenticated = true;
+                }
+                Err(e) => {
+                    pr_err!("Cannot verify challenge_auth signature: {e:?}");
+                    self.authenticated = false;
+                }
+            };
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index a8bc3378676f..f8a5337841f0 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -17,7 +17,7 @@
 };
 
 use crate::consts::{
-    SPDM_ASYM_ALGOS, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_CERTIFICATE,
+    SPDM_ASYM_ALGOS, SPDM_CHALLENGE, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_CERTIFICATE,
     SPDM_GET_DIGESTS, SPDM_GET_VERSION, SPDM_HASH_ALGOS, SPDM_MEAS_SPEC_DMTF, SPDM_NEGOTIATE_ALGS,
     SPDM_REQ_CAPS,
 };
@@ -424,3 +424,66 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
         Ok(rsp)
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct ChallengeReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) nonce: [u8; 32],
+    pub(crate) context: [u8; 8],
+}
+
+impl Default for ChallengeReq {
+    fn default() -> Self {
+        ChallengeReq {
+            version: 0,
+            code: SPDM_CHALLENGE,
+            param1: 0,
+            param2: 0,
+            nonce: [0; 32],
+            context: [0; 8],
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct ChallengeRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) cert_chain_hash: __IncompleteArrayField<u8>,
+    pub(crate) nonce: [u8; 32],
+    pub(crate) message_summary_hash: __IncompleteArrayField<u8>,
+
+    pub(crate) opaque_data_len: u16,
+    pub(crate) opaque_data: __IncompleteArrayField<u8>,
+
+    pub(crate) context: [u8; 8],
+    pub(crate) signature: __IncompleteArrayField<u8>,
+}
+
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut ChallengeRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<ChallengeRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `ChallengeRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<ChallengeRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut ChallengeRsp = unsafe { &mut *ptr };
+
+        // rsp.opaque_data_len = rsp.opaque_data_len.to_le();
+
+        Ok(rsp)
+    }
+}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index daeb599fb990..16b8602c6d1a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <crypto/hash.h>
+#include <crypto/public_key.h>
 #include <kunit/test.h>
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
-- 
2.48.1


