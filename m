Return-Path: <linux-pci+bounces-22500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795D3A4736D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2363B5E72
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5B71C701B;
	Thu, 27 Feb 2025 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="fMovNesD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fB97Y/Xo"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4731C6FF8;
	Thu, 27 Feb 2025 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625909; cv=none; b=GTuzWaHlgwiF+KF8rR6ho7rcvcZQpn6Tr0We+wSLd1lJn5zlxZcAaOjeTaGwVg5oRhp0et2j/MODXty5agrO18P/vRmRxUkSFCeEeNJ2BJIYFwvAHQnYC+d3rKmySG9JneWqHspBv73vkOVvx/pUgOel8s8zFplSNhFpLJ8pNNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625909; c=relaxed/simple;
	bh=/ac9/4dnsyJcRleWLsYsLU2zT9prStc39+qtMZANcd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCu/pqaY7VnOjtszivu2BnYeGp4h+FC78fIi+ZDtT8EEMQsfOqeo9HVSbo5501BjTn0gDX1wjaDDTyQ62PQNiNZ8tx5xucCvy1Qa/0a/BDmzpJAgE549itNH6C8AKD5l8FA+o7RuDlMuXloNmOJ6cFQKYhA2FTvWnMp9lBJgF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=fMovNesD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fB97Y/Xo; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A91211401A3;
	Wed, 26 Feb 2025 22:11:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 26 Feb 2025 22:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625906; x=
	1740712306; bh=AknGaepVfMtNBcp7Xo/wA1SJO6y/hq/JaQGUv26u+4A=; b=f
	MovNesDWjttzm17FUyK0gXJ9mP/kvRZL9RSvTXYEYkAnnrPkldIniU7qzyS/GXvY
	JWQ6Xaa2zoMu+JxwcDmqWh8WT/mL20CS/QUcQK7vTCoKj9KSA3R6QlPoPA8LmG2D
	SpKDaAftlkC7nNhTlfCvFHON4ZD9dXr49p+w8yiwjwHttRO0d9xfhUxs2xk5h4BG
	VtnVA84eBSBilQCGLyYjupgKaPaib7ISbaXdEOBNq5+674i47OgnOtSoITPzwMJf
	Ksj9+E72UfnbVeDXuFv9nu6t99xdH7DA4L/pLBHqa9VGsskaSEe+CgWe/dOY4/Ym
	gfmdXLGnePxbPzp5neTHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625906; x=1740712306; bh=A
	knGaepVfMtNBcp7Xo/wA1SJO6y/hq/JaQGUv26u+4A=; b=fB97Y/XocPelnG3MF
	Dj4O13V2QLI0q4k0BvWyMy3GhvFGfXyfOaQPKYgmTSWVfDXsRjwBxXqRcGC+N8Ms
	JePu5F7ZCG4ag4i1PSCNBjzmYWjrnGfauByRH1qXVdoBDg1d7SEe87P0MDps4Ul3
	HEx8PqmMOmMTVWLN3sj2JmpMKz4zYQzTSxkmy0wXp0f3B3OmfcwCvypZr/C0SevH
	yzQM0TmOisvqoYOT6tIkajjHNToEqlBWnia1PYTJAhMqehW0ckBrcCk0PhuQfEFe
	nAeD10YeBeDkIYx98RcwMjQsMkpq3vg+mzOtxWEsIYa5PwstE5H5s0l5Acve9uTS
	SyLoQ==
X-ME-Sender: <xms:8te_ZzPEwW_DfT5Kr7TNNmaLgHjZ8BCYf8TJryA3KRcgqJF1FE500A>
    <xme:8te_Z993wAwUbcf_TULQcsvvRSY0ZTCrh6wqp-bdCIzFX3TEJCrF6UYWWQNyd_wAv
    3K0MJNoPRz82orByBU>
X-ME-Received: <xmr:8te_ZyS8mTR13LzBQCmo4PltyLwosomvhX6PseYHGr4dyIlEZiK0aWWbh9vHzrFyKaFNCoR_7IU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpedvhefhfeevffelhffgjeeg
    gefhteelieekudeiieeiteffudetheeihfdukeehleenucffohhmrghinhepphhorhhtih
    honhgplhgvnhhgthhhrdhtohdprhgvmhgrihhnuggvrhgplhgvnhhgthhhrdhtohenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrg
    hirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtth
    hopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnh
    drtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhr
    qdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegsohhquhhnrdhf
    vghnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8te_Z3vfkHLGfOityTuWPhHAAvkt7M_Ic1OsABLbcbp151dPVlwRiQ>
    <xmx:8te_Z7dtH9x8WAMwK3Lhq3AJ9VROtvP1xSnlJO7FCdG28Mhqg62vvw>
    <xmx:8te_Zz29jk3yJlaErLB7FiOdeUCiEe1FkArFxvyB3ZQO7o2NZS8bBA>
    <xmx:8te_Z3_ypBDTznkCW_I_5iAOP3BMGhokf72qsGvsQzh3aNb04Jojgw>
    <xmx:8te_Zx-6i4n7Otiyz6vrnf8TkhN2aQ82llPTvi8-e8Z_k8TkrOV3MZin>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:11:40 -0500 (EST)
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
Subject: [RFC v2 14/20] lib: rspdm: Support SPDM get_certificate
Date: Thu, 27 Feb 2025 13:09:46 +1000
Message-ID: <20250227030952.2319050-15-alistair@alistair23.me>
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
 lib/rspdm/consts.rs    |   2 +
 lib/rspdm/lib.rs       |  11 ++++
 lib/rspdm/state.rs     | 123 ++++++++++++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs |  64 ++++++++++++++++++++-
 4 files changed, 196 insertions(+), 4 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 9714fa52e2be..ffaf36ec583b 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -96,6 +96,8 @@ pub(crate) enum SpdmErrorCode {
 
 pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
 
+pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
+
 #[cfg(CONFIG_CRYPTO_RSA)]
 pub(crate) const SPDM_ASYM_RSA: u32 =
     SPDM_ASYM_RSASSA_2048 | SPDM_ASYM_RSASSA_3072 | SPDM_ASYM_RSASSA_4096;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index bf5f7c72f885..1535e3a69518 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -126,6 +126,17 @@
         return e.to_errno() as c_int;
     }
 
+    let mut provisioned_slots = state.provisioned_slots;
+    while (provisioned_slots as usize) > 0 {
+        let slot = provisioned_slots.trailing_zeros() as u8;
+
+        if let Err(e) = state.get_certificate(slot) {
+            return e.to_errno() as c_int;
+        }
+
+        provisioned_slots &= !(1 << slot);
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 7889214c6aa7..ae259623fe50 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -26,8 +26,9 @@
     SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_SLOTS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
 };
 use crate::validator::{
-    GetCapabilitiesReq, GetCapabilitiesRsp, GetDigestsReq, GetDigestsRsp, GetVersionReq,
-    GetVersionRsp, NegotiateAlgsReq, NegotiateAlgsRsp, RegAlg, SpdmErrorRsp, SpdmHeader,
+    GetCapabilitiesReq, GetCapabilitiesRsp, GetCertificateReq, GetCertificateRsp, GetDigestsReq,
+    GetDigestsRsp, GetVersionReq, GetVersionRsp, NegotiateAlgsReq, NegotiateAlgsRsp, RegAlg,
+    SpdmErrorRsp, SpdmHeader,
 };
 
 /// The current SPDM session state for a device. Based on the
@@ -112,6 +113,14 @@ pub struct SpdmState {
     slot_sz: [usize; SPDM_SLOTS],
 }
 
+#[repr(C, packed)]
+pub(crate) struct SpdmCertChain {
+    length: u16,
+    _reserved: [u8; 2],
+    root_hash: bindings::__IncompleteArrayField<u8>,
+    certificates: bindings::__IncompleteArrayField<u8>,
+}
+
 impl SpdmState {
     pub(crate) fn new(
         dev: *mut bindings::device,
@@ -626,4 +635,114 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    fn get_cert_exchange(
+        &mut self,
+        request_buf: &mut [u8],
+        response_vec: &mut KVec<u8>,
+        rsp_sz: usize,
+    ) -> Result<&mut GetCertificateRsp, Error> {
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let response_buf = unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), rsp_sz) };
+
+        let rc = self.spdm_exchange(request_buf, response_buf)?;
+
+        if rc < (core::mem::size_of::<GetCertificateReq>() as i32) {
+            pr_err!("Truncated certificate response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        // SAFETY: `rc` bytes where inserted to the raw pointer by spdm_exchange
+        unsafe { response_vec.set_len(rc as usize) };
+
+        let response: &mut GetCertificateRsp = Untrusted::new_mut(response_vec).validate_mut()?;
+
+        if rc
+            < (core::mem::size_of::<GetCertificateRsp>() + response.portion_length as usize) as i32
+        {
+            pr_err!("Truncated certificate response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        Ok(response)
+    }
+
+    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
+        let mut request = GetCertificateReq::default();
+        request.version = self.version;
+        request.param1 = slot;
+
+        let req_sz = core::mem::size_of::<GetCertificateReq>();
+        let rsp_sz = ((core::mem::size_of::<GetCertificateRsp>() + 0xffff) as u32)
+            .min(self.transport_sz) as usize;
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+        let mut response_vec: KVec<u8> = KVec::with_capacity(rsp_sz, GFP_KERNEL)?;
+
+        request.offset = 0;
+        request.length = (rsp_sz - core::mem::size_of::<GetCertificateRsp>()).to_le() as u16;
+
+        let response = self.get_cert_exchange(request_buf, &mut response_vec, rsp_sz)?;
+
+        let total_cert_len =
+            ((response.portion_length + response.remainder_length) & 0xFFFF) as usize;
+
+        let mut certs_buf: KVec<u8> = KVec::new();
+
+        certs_buf.extend_from_slice(
+            &response_vec[8..(8 + response.portion_length as usize)],
+            GFP_KERNEL,
+        )?;
+
+        let mut offset: usize = response.portion_length as usize;
+        let mut remainder_length = response.remainder_length as usize;
+
+        while remainder_length > 0 {
+            request.offset = offset.to_le() as u16;
+            request.length = (remainder_length
+                .min(rsp_sz - core::mem::size_of::<GetCertificateRsp>()))
+            .to_le() as u16;
+
+            let response = self.get_cert_exchange(request_buf, &mut response_vec, rsp_sz)?;
+
+            if response.portion_length == 0
+                || (response.param1 & 0xF) != slot
+                || offset as u16 + response.portion_length + response.remainder_length
+                    != total_cert_len as u16
+            {
+                pr_err!("Malformed certificate response\n");
+                to_result(-(bindings::EPROTO as i32))?;
+            }
+
+            certs_buf.extend_from_slice(
+                &response_vec[8..(8 + response.portion_length as usize)],
+                GFP_KERNEL,
+            )?;
+            offset += response.portion_length as usize;
+            remainder_length = response.remainder_length as usize;
+        }
+
+        let header_length = core::mem::size_of::<SpdmCertChain>() + self.hash_len;
+
+        let ptr = certs_buf.as_mut_ptr();
+        // SAFETY: `SpdmCertChain` is repr(C) and packed, so we can convert it from a slice
+        let ptr = ptr.cast::<SpdmCertChain>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let certs: &mut SpdmCertChain = unsafe { &mut *ptr };
+
+        if total_cert_len < header_length
+            || total_cert_len != usize::from_le(certs.length as usize)
+            || total_cert_len != certs_buf.len()
+        {
+            pr_err!("Malformed certificate chain in slot {slot}\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        self.slot_sz[slot as usize] = total_cert_len;
+        self.slot[slot as usize] = Some(certs_buf);
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 2150a23997db..a8bc3378676f 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -17,8 +17,9 @@
 };
 
 use crate::consts::{
-    SPDM_ASYM_ALGOS, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_DIGESTS, SPDM_GET_VERSION,
-    SPDM_HASH_ALGOS, SPDM_MEAS_SPEC_DMTF, SPDM_NEGOTIATE_ALGS, SPDM_REQ_CAPS,
+    SPDM_ASYM_ALGOS, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_CERTIFICATE,
+    SPDM_GET_DIGESTS, SPDM_GET_VERSION, SPDM_HASH_ALGOS, SPDM_MEAS_SPEC_DMTF, SPDM_NEGOTIATE_ALGS,
+    SPDM_REQ_CAPS,
 };
 
 #[repr(C, packed)]
@@ -364,3 +365,62 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
         Ok(rsp)
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct GetCertificateReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) offset: u16,
+    pub(crate) length: u16,
+}
+
+impl Default for GetCertificateReq {
+    fn default() -> Self {
+        GetCertificateReq {
+            version: 0,
+            code: SPDM_GET_CERTIFICATE,
+            param1: 0,
+            param2: 0,
+            offset: 0,
+            length: 0,
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct GetCertificateRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) portion_length: u16,
+    pub(crate) remainder_length: u16,
+
+    pub(crate) cert_chain: __IncompleteArrayField<u8>,
+}
+
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetCertificateRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<GetCertificateRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `GetCertificateRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetCertificateRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut GetCertificateRsp = unsafe { &mut *ptr };
+
+        rsp.portion_length = rsp.portion_length.to_le();
+        rsp.remainder_length = rsp.remainder_length.to_le();
+
+        Ok(rsp)
+    }
+}
-- 
2.48.1


