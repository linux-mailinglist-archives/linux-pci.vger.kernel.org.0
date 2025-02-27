Return-Path: <linux-pci+bounces-22499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740A1A4736E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D2A17232B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E211A2C27;
	Thu, 27 Feb 2025 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="luAdfp5J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zz6+Q4cN"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90431AF0BA;
	Thu, 27 Feb 2025 03:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625902; cv=none; b=UrbUD9Mat4HQ3jnmGyLyeXXTZR+tcophFK+FGh2dZ/9Uho0tFgHk+B1hiikgqPT9LWSC45e+2+JrAg9hak5mfiGiFZ+3hbuQ1zU8YNlOwjpP5o6YGFHtaE8yuFb70cPsKmM6h8Rj/ElrbO5UXEHgZ0v8b6LwNz2ewSCPcph7Z7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625902; c=relaxed/simple;
	bh=xjXYpRdOJH3xqc+w5Sk610RABFY8qSV8xRa0fgEeVTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYg52b+8bTyxZoDRmu+8Ng4NjXQKat1AfB07EDMRltE0UEBo10sBdsQNkmiW+DwG9xFYhNx2o5dUhIziCrb+zHsDihkdQ+pmXrnORpdZj/7ZtZOjgWdmYRSTTM2SR1jWablp40S7ZV9Jw+kp5dV9EsnqyQznvgL/x3IF9bS0jDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=luAdfp5J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zz6+Q4cN; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9406D11401AB;
	Wed, 26 Feb 2025 22:11:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 26 Feb 2025 22:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625899; x=
	1740712299; bh=vQ3zjvSsX16w4XFFO6FyrbKChsJWTWoMOKDjAuEvQZg=; b=l
	uAdfp5JEXhxLEj+qcifVLxeKHzlD2icytcuRoRsMq4U0Y4Swp8Nj4Z+g7SGQwwNq
	J044p4iTArNHtAGYxMtf/Puzfp4LS3hQfQnHV8Fcg3OIfWinjhE/TvgSf/6Cg4Cw
	Ee1lxIa7hJgQ6ULJXbypbjhT9WIeEelvqoOeJVqmDkJx2enXijf0Xv6eqtyEIKk7
	Cqxxh74/HkvYyxhlOaORtFZru3uig68P+uRvc+qaFWMi5wFi+RyhCLu5dPMQwec5
	Ix/Ttg8a9M5ORrCEG40n9nKrZLvvsxm3HCNj8eQJ55FVpHLa5FKiNKgjXoUoeYA5
	NV0+9Mc1Dxj7KjjiZz2sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625899; x=1740712299; bh=v
	Q3zjvSsX16w4XFFO6FyrbKChsJWTWoMOKDjAuEvQZg=; b=Zz6+Q4cNJKsrIsy+Z
	3bml12EaUdUY7tu4A8osogbWoidd+9g2Mi/7KaIOPTW+MNBH73q5qgCzj0ZK+jZt
	UaFirC3XCfk9RsiLa+fhPeO8Qzl6mpr1ZQv3ZWON9HGggq7bSCZst/W94Yf5YKVU
	Fvg1h8liHaXhQu4apmeXkYSHAuWEHvP3NZVAC4HuW8Kg5pw0xFyDmBaMGawge6o1
	UydwIqez9Akj7vCbJTu/7JB4Lbw6YxNlY0UeMXVfmRVOfkvSZjKjiv+ZSh4bSTo0
	dpYn+DnbAXDdmxdiYxMFi/89CWmX8qNLuEPQTNZ5eR77T6sZIoSgTMkit5v2Gi4M
	VYy0w==
X-ME-Sender: <xms:69e_Z-6zbnsCCROFfES9tm3t4U45SBmrO3RrWwEICeS9NrK629JAOQ>
    <xme:69e_Z36MKI-3cWjXmA0XDkJMDSmrk6chTFccdaW8O2zO1v1x--Z4Yfka0bXOEwBzG
    cGxhZPUryIx8FASoy0>
X-ME-Received: <xmr:69e_Z9ddBSI3Ept5awZfzZHkFo1Ti6ymAwrZD5Jhi93wrX7T92mCVAGZQ6A1hP-sPGMInmSCdKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetledvleevveeu
    ueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhr
    vdefrdhmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopehlihhnuhigqdhptghi
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhu
    rgifvghirdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgu
    rghtihhonhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:69e_Z7KKr4c7oCgmaQM3hOOLqwx9bw5jHAehWF1GZ9jTTLOEC-b6sA>
    <xmx:69e_ZyK-tfBNKlR1Qm2vCGG_jrQc1k8q4oFlkySEtwVPUIwQKQWGWA>
    <xmx:69e_Z8wccwp2AkwcLfdEk86r6_tG47EKLvcT8GHrS8xS2Z0XG2rbSg>
    <xmx:69e_Z2IckMXArZLL5TejogGZgbVmMnAm2et6XM1c-TJbN16xbjG4Xw>
    <xmx:69e_ZyJ0ql8RWmhAvtkWtRF5YXVQROyHgz3txf8_SQUEBgOVPOFg9WDC>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:11:32 -0500 (EST)
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
Subject: [RFC v2 13/20] lib: rspdm: Support SPDM get_digests
Date: Thu, 27 Feb 2025 13:09:45 +1000
Message-ID: <20250227030952.2319050-14-alistair@alistair23.me>
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
 lib/rspdm/consts.rs    |  4 ++
 lib/rspdm/lib.rs       |  4 ++
 lib/rspdm/state.rs     | 89 ++++++++++++++++++++++++++++++++++++++++--
 lib/rspdm/validator.rs | 52 +++++++++++++++++++++++-
 4 files changed, 144 insertions(+), 5 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index d2f245c858cc..9714fa52e2be 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -16,6 +16,8 @@
 pub(crate) const SPDM_VER_12: u8 = 0x12;
 pub(crate) const SPDM_VER_13: u8 = 0x13;
 
+pub(crate) const SPDM_SLOTS: usize = 8;
+
 pub(crate) const SPDM_MIN_VER: u8 = SPDM_VER_10;
 pub(crate) const SPDM_MAX_VER: u8 = SPDM_VER_13;
 
@@ -92,6 +94,8 @@ pub(crate) enum SpdmErrorCode {
 pub(crate) const SPDM_HASH_SHA_384: u32 = 1 << 1;
 pub(crate) const SPDM_HASH_SHA_512: u32 = 1 << 2;
 
+pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
+
 #[cfg(CONFIG_CRYPTO_RSA)]
 pub(crate) const SPDM_ASYM_RSA: u32 =
     SPDM_ASYM_RSASSA_2048 | SPDM_ASYM_RSASSA_3072 | SPDM_ASYM_RSASSA_4096;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 5eee5116d791..bf5f7c72f885 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -122,6 +122,10 @@
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.get_digests() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 0aff45339e0b..7889214c6aa7 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -23,11 +23,11 @@
     SPDM_ASYM_RSASSA_4096, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_HASH_ALGOS, SPDM_HASH_SHA_256,
     SPDM_HASH_SHA_384, SPDM_HASH_SHA_512, SPDM_KEY_EX_CAP, SPDM_MAX_VER, SPDM_MEAS_CAP_MASK,
     SPDM_MEAS_SPEC_DMTF, SPDM_MIN_DATA_TRANSFER_SIZE, SPDM_MIN_VER, SPDM_OPAQUE_DATA_FMT_GENERAL,
-    SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
+    SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_SLOTS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
 };
 use crate::validator::{
-    GetCapabilitiesReq, GetCapabilitiesRsp, GetVersionReq, GetVersionRsp, NegotiateAlgsReq,
-    NegotiateAlgsRsp, RegAlg, SpdmErrorRsp, SpdmHeader,
+    GetCapabilitiesReq, GetCapabilitiesRsp, GetDigestsReq, GetDigestsRsp, GetVersionReq,
+    GetVersionRsp, NegotiateAlgsReq, NegotiateAlgsRsp, RegAlg, SpdmErrorRsp, SpdmHeader,
 };
 
 /// The current SPDM session state for a device. Based on the
@@ -54,6 +54,10 @@
 ///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
 /// @meas_hash_alg: Hash algorithm for measurement blocks.
 ///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+/// @supported_slots: Bitmask of responder's supported certificate slots.
+///  Received during GET_DIGESTS exchange (from SPDM 1.3).
+/// @provisioned_slots: Bitmask of responder's provisioned certificate slots.
+///  Received during GET_DIGESTS exchange.
 /// @base_asym_enc: Human-readable name of @base_asym_alg's signature encoding.
 ///  Passed to crypto subsystem when calling verify_signature().
 /// @sig_len: Signature length of @base_asym_alg (in bytes).
@@ -68,6 +72,9 @@
 /// @desc: Synchronous hash context for @base_hash_alg computation.
 /// @hash_len: Hash length of @base_hash_alg (in bytes).
 ///  H in SPDM specification.
+/// @slot: Certificate chain in each of the 8 slots.  NULL pointer if a slot is
+///  not populated.  Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
+/// @slot_sz: Certificate chain size (in bytes).
 ///
 /// `authenticated`: Whether device was authenticated successfully.
 #[expect(dead_code)]
@@ -85,6 +92,8 @@ pub struct SpdmState {
     pub(crate) base_asym_alg: u32,
     pub(crate) base_hash_alg: u32,
     pub(crate) meas_hash_alg: u32,
+    pub(crate) supported_slots: u8,
+    pub(crate) provisioned_slots: u8,
 
     /* Signature algorithm */
     base_asym_enc: &'static CStr,
@@ -97,6 +106,10 @@ pub struct SpdmState {
     pub(crate) hash_len: usize,
 
     pub(crate) authenticated: bool,
+
+    // Certificates
+    pub(crate) slot: [Option<KVec<u8>>; SPDM_SLOTS],
+    slot_sz: [usize; SPDM_SLOTS],
 }
 
 impl SpdmState {
@@ -120,6 +133,8 @@ pub(crate) fn new(
             base_asym_alg: 0,
             base_hash_alg: 0,
             meas_hash_alg: 0,
+            supported_slots: 0,
+            provisioned_slots: 0,
             base_asym_enc: unsafe { CStr::from_bytes_with_nul_unchecked(b"\0") },
             sig_len: 0,
             base_hash_alg_name: unsafe { CStr::from_bytes_with_nul_unchecked(b"\0") },
@@ -127,6 +142,8 @@ pub(crate) fn new(
             desc: None,
             hash_len: 0,
             authenticated: false,
+            slot: [const { None }; SPDM_SLOTS],
+            slot_sz: [0; SPDM_SLOTS],
         }
     }
 
@@ -543,4 +560,70 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
+        let mut request = GetDigestsReq::default();
+        request.version = self.version;
+
+        let req_sz = core::mem::size_of::<GetDigestsReq>();
+        let rsp_sz = core::mem::size_of::<GetDigestsRsp>() + SPDM_SLOTS * self.hash_len;
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
+        if rc < (core::mem::size_of::<GetDigestsRsp>() as i32) {
+            pr_err!("Truncated digests response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        // SAFETY: `rc` bytes where inserted to the raw pointer by spdm_exchange
+        unsafe { response_vec.set_len(rc as usize) };
+
+        let response: &mut GetDigestsRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        if rc
+            < (core::mem::size_of::<GetDigestsReq>()
+                + response.param2.count_ones() as usize * self.hash_len) as i32
+        {
+            pr_err!("Truncated digests response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        let mut deprovisioned_slots = self.provisioned_slots & !response.param2;
+        while (deprovisioned_slots.trailing_zeros() as usize) < SPDM_SLOTS {
+            let slot = deprovisioned_slots.trailing_zeros() as usize;
+            self.slot[slot] = None;
+            self.slot_sz[slot] = 0;
+            deprovisioned_slots &= !(1 << slot);
+        }
+
+        self.provisioned_slots = response.param2;
+        if self.provisioned_slots == 0 {
+            pr_err!("No certificates provisioned\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        if self.version >= 0x13 && (response.param2 & !response.param1 != 0) {
+            pr_err!("Malformed digests response\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        let supported_slots = if self.version >= 0x13 {
+            response.param1
+        } else {
+            0xFF
+        };
+
+        if self.supported_slots != supported_slots {
+            self.supported_slots = supported_slots;
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 036a077c71c3..2150a23997db 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -17,8 +17,8 @@
 };
 
 use crate::consts::{
-    SPDM_ASYM_ALGOS, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_VERSION, SPDM_HASH_ALGOS,
-    SPDM_MEAS_SPEC_DMTF, SPDM_NEGOTIATE_ALGS, SPDM_REQ_CAPS,
+    SPDM_ASYM_ALGOS, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_DIGESTS, SPDM_GET_VERSION,
+    SPDM_HASH_ALGOS, SPDM_MEAS_SPEC_DMTF, SPDM_NEGOTIATE_ALGS, SPDM_REQ_CAPS,
 };
 
 #[repr(C, packed)]
@@ -316,3 +316,51 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
         Ok(rsp)
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct GetDigestsReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+}
+
+impl Default for GetDigestsReq {
+    fn default() -> Self {
+        GetDigestsReq {
+            version: 0,
+            code: SPDM_GET_DIGESTS,
+            param1: 0,
+            param2: 0,
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct GetDigestsRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) digests: __IncompleteArrayField<u8>,
+}
+
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetDigestsRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<GetDigestsRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `GetDigestsRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetDigestsRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut GetDigestsRsp = unsafe { &mut *ptr };
+
+        Ok(rsp)
+    }
+}
-- 
2.48.1


