Return-Path: <linux-pci+bounces-22496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BB0A47368
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDA5171210
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679891B424A;
	Thu, 27 Feb 2025 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="e1uWqyG6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5G2910l"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927171B4F0A;
	Thu, 27 Feb 2025 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625881; cv=none; b=HlrHEKeMnFwQ5+QPpGTnSrzDkHqwIl23fFr+nuWBltA04YnKbeWKH44ZHfj9sFxNR0w09g65zcrlByceDd3LttAQuDER9H3DzaT6msEg1+HL7d7PIYF+ubjZmEVJAw1xQ4gP/0buiJX/0l/jlihv8WicLef/xGOPMKSDXLcNHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625881; c=relaxed/simple;
	bh=wen8Kghp3uXHjcrYPZZjmR3nmFOOFu4DndvrMLZ4q/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdN0zXwuifmJ8afp0SRzWKYpmAwHcXlyTJwCMurbghKum+COefFTNJ22R6+Tw1iOpSGQjirzcuJbL2nET/JNLLukaQEeRBcVT0WiOiEBCoOBWwlKLNPEaavutjpnjlp5Od8ylXJYHd2mD17M7tCcHqMB+0hStR2z8gcllSjkXZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=e1uWqyG6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b5G2910l; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3CE4525400E9;
	Wed, 26 Feb 2025 22:11:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 26 Feb 2025 22:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625877; x=
	1740712277; bh=5Zcn/zYRyQlZ/Snfqkm7jCZaa/+R7uulSjm9wgXjBKc=; b=e
	1uWqyG69KondzMnqgro1EJW54I+9HjYVy0egNy8IrUEvtxo2X23KO4RN3mXyFrD6
	pBE4/z7bnY7a8xrffWqmrou9iK0a7xiBC6CJtxnFL1nDuAWM4sAIzMv8110Yhx0s
	uHbQNm/G+b8DsNU6rk8LLynbXjb11MMtXAxamEgr5Z/YAbDlE9VmKxAWynM0TFUA
	A2jVYPq8Irt9mNxRYwqUNHL3enTpmLPSXxbPORUWV9xfkcH48wl4K1Mb3XBda88l
	blzA0q29f3bK5MZH77f0fF0zBEzhYRlr8qjNrNV9nvi2wJhuzT5xfeFA3k5cspiN
	secghk2+zgi4aZAeXbChg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625877; x=1740712277; bh=5
	Zcn/zYRyQlZ/Snfqkm7jCZaa/+R7uulSjm9wgXjBKc=; b=b5G2910ldjBIc/K6K
	wk+IlqPFJKrZknu/S38LPZfLUXWMkWbImOwLwXDTr8noikXxalBdl8vu+G5knqEa
	amwbEmFkLQiI3slzMYLET9bPxvK5MS/HzCqS8517vA1cQa9RqNcg1VUNeGAjxPQT
	B03PEkWBqJW1XlIo9AZQFuaMPpK0AAUtipT32nU8LAKii9iHv0SpqiMZh216qH6b
	ptNzImVqsSPmWxpUbX+Cg3yh2TzQ6PsBgBERAydnoy7OCyb9pTCagoJ2fdfjOl6m
	bEtXOOw9MCCs5GhaBQjrlKCNHavGWd6jid1XE7DE6Nvhp0Ezava9vfVZfjSirjMa
	XGrRw==
X-ME-Sender: <xms:1Ne_Z6srbJmt8wZI6CeJIhMCJzzPzMPYvxwaYLt8FJ6aCFsR0v2P-A>
    <xme:1Ne_Z_dV5FXInTFKs_YDUtvn-HVqlMP_LfqJ9E801I1jLvCZyoF6fesugeNhZJZdb
    Wn0mDzXjY3DZq62Nac>
X-ME-Received: <xmr:1Ne_Z1zciCDAtgovdsK5seWu_t_SsO1M0Dp-D7rmB74gg19o3cPyjQ3RRKKMGyow65vBRD9y8Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpedutddvffeklefhgfefueeg
    iefhkedujedttddukeeiueduudfhtddtfeefveeghfenucffohhmrghinhepughmthhfrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvpdhnsggprhgtphhtthhopedvtd
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqtgiglhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggv
    pdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhho
    nhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehruh
    hsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsg
    hoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:1Ne_Z1Pn8wEG3ir9nQ7r1EzHhdobiLHpOeHSfOJVQQdAOTxmcvKe5w>
    <xmx:1Ne_Z6_UdW2baah0M1_qyXnBGXb8nqULwuV6PNi33Etb5f8gwroENQ>
    <xmx:1Ne_Z9Vke8xyszBh4rM_VeE0BPmhpXfRoEJtnbteEmkSrUp4cM3c2Q>
    <xmx:1Ne_ZzfeGgpg7DNc_YCsQ2BNroO4u_mTZz0cG2aumGPSUL7TXKWmTg>
    <xmx:1de_Z9eCHtYx0DQlG6hmZijiqJwA9xANZRfLgBszK7KK0EL-tRFsvdNG>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:11:11 -0500 (EST)
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
Subject: [RFC v2 10/20] lib: rspdm: Support SPDM get_version
Date: Thu, 27 Feb 2025 13:09:42 +1000
Message-ID: <20250227030952.2319050-11-alistair@alistair23.me>
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

Support the GET_VERSION SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    | 17 +++++++++++
 lib/rspdm/lib.rs       |  6 +++-
 lib/rspdm/state.rs     | 57 +++++++++++++++++++++++++++++++++--
 lib/rspdm/validator.rs | 67 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+), 4 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 311e34c7fae7..da7b0810f103 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -7,6 +7,20 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
+use crate::validator::SpdmHeader;
+use core::mem;
+
+/* SPDM versions supported by this implementation */
+pub(crate) const SPDM_VER_10: u8 = 0x10;
+#[allow(dead_code)]
+pub(crate) const SPDM_VER_11: u8 = 0x11;
+#[allow(dead_code)]
+pub(crate) const SPDM_VER_12: u8 = 0x12;
+pub(crate) const SPDM_VER_13: u8 = 0x13;
+
+pub(crate) const SPDM_MIN_VER: u8 = SPDM_VER_10;
+pub(crate) const SPDM_MAX_VER: u8 = SPDM_VER_13;
+
 pub(crate) const SPDM_REQ: u8 = 0x80;
 pub(crate) const SPDM_ERROR: u8 = 0x7f;
 
@@ -37,3 +51,6 @@ pub(crate) enum SpdmErrorCode {
     NoPendingRequests = 0x45,
     VendorDefinedError = 0xff,
 }
+
+pub(crate) const SPDM_GET_VERSION: u8 = 0x84;
+pub(crate) const SPDM_GET_VERSION_LEN: usize = mem::size_of::<SpdmHeader>() + 255;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 24064d3c4669..f8cb9766ed62 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -109,7 +109,11 @@
 /// Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
 /// indicates authentication is not supported by the device.
 #[no_mangle]
-pub unsafe extern "C" fn spdm_authenticate(_state: &'static mut SpdmState) -> c_int {
+pub unsafe extern "C" fn spdm_authenticate(state: &'static mut SpdmState) -> c_int {
+    if let Err(e) = state.get_version() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 9ebd87603454..dd1ccdfd166a 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -8,6 +8,7 @@
 //! <https://www.dmtf.org/dsp/DSP0274>
 
 use core::ffi::c_void;
+use core::slice::from_raw_parts_mut;
 use kernel::prelude::*;
 use kernel::{
     bindings,
@@ -15,8 +16,10 @@
     validate::Untrusted,
 };
 
-use crate::consts::{SpdmErrorCode, SPDM_ERROR, SPDM_REQ};
-use crate::validator::{SpdmErrorRsp, SpdmHeader};
+use crate::consts::{
+    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPDM_MIN_VER, SPDM_REQ,
+};
+use crate::validator::{GetVersionReq, GetVersionRsp, SpdmErrorRsp, SpdmHeader};
 
 /// The current SPDM session state for a device. Based on the
 /// C `struct spdm_state`.
@@ -65,7 +68,7 @@ pub(crate) fn new(
             transport_sz,
             keyring,
             validate,
-            version: 0x10,
+            version: SPDM_MIN_VER,
             authenticated: false,
         }
     }
@@ -222,4 +225,52 @@ pub(crate) fn spdm_exchange(
 
         Ok(length)
     }
+
+    /// Negoiate a supported SPDM version and store the information
+    /// in the `SpdmState`.
+    pub(crate) fn get_version(&mut self) -> Result<(), Error> {
+        let mut request = GetVersionReq::default();
+        request.version = self.version;
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe {
+            from_raw_parts_mut(
+                &mut request as *mut _ as *mut u8,
+                core::mem::size_of::<GetVersionReq>(),
+            )
+        };
+
+        let mut response_vec: KVec<u8> = KVec::with_capacity(SPDM_GET_VERSION_LEN, GFP_KERNEL)?;
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let response_buf =
+            unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), SPDM_GET_VERSION_LEN) };
+
+        let rc = self.spdm_exchange(request_buf, response_buf)?;
+
+        // SAFETY: `rc` bytes where inserted to the raw pointer by spdm_exchange
+        unsafe { response_vec.set_len(rc as usize) };
+
+        let response: &mut GetVersionRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        let mut foundver = false;
+        for i in 0..response.version_number_entry_count {
+            // Creating a reference on a packed struct will result in
+            // undefined behaviour, so we operate on the raw data directly
+            let unaligned = core::ptr::addr_of_mut!(response.version_number_entries) as *mut u16;
+            let addr = unaligned.wrapping_add(i as usize);
+            let version = (unsafe { core::ptr::read_unaligned::<u16>(addr) } >> 8) as u8;
+
+            if version >= self.version && version <= SPDM_MAX_VER {
+                self.version = version;
+                foundver = true;
+            }
+        }
+
+        if !foundver {
+            pr_err!("No common supported version\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index a0a3a2f46952..f69be6aa6280 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -7,6 +7,7 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
+use crate::bindings::{__IncompleteArrayField, __le16};
 use crate::consts::SpdmErrorCode;
 use core::mem;
 use kernel::prelude::*;
@@ -15,6 +16,8 @@
     validate::{Unvalidated, Validate},
 };
 
+use crate::consts::SPDM_GET_VERSION;
+
 #[repr(C, packed)]
 pub(crate) struct SpdmHeader {
     pub(crate) version: u8,
@@ -64,3 +67,67 @@ pub(crate) struct SpdmErrorRsp {
     pub(crate) error_code: SpdmErrorCode,
     pub(crate) error_data: u8,
 }
+
+#[repr(C, packed)]
+pub(crate) struct GetVersionReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+}
+
+impl Default for GetVersionReq {
+    fn default() -> Self {
+        GetVersionReq {
+            version: 0,
+            code: SPDM_GET_VERSION,
+            param1: 0,
+            param2: 0,
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct GetVersionRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    param1: u8,
+    param2: u8,
+    reserved: u8,
+    pub(crate) version_number_entry_count: u8,
+    pub(crate) version_number_entries: __IncompleteArrayField<__le16>,
+}
+
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetVersionRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<GetVersionRsp>() {
+            return Err(EINVAL);
+        }
+
+        let version_number_entries = *(raw.get(5).ok_or(ENOMEM))? as usize;
+        let total_expected_size = version_number_entries * 2 + 6;
+        if raw.len() < total_expected_size {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `GetVersionRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetVersionRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut GetVersionRsp = unsafe { &mut *ptr };
+
+        // Creating a reference on a packed struct will result in
+        // undefined behaviour, so we operate on the raw data directly
+        let unaligned = core::ptr::addr_of_mut!(rsp.version_number_entries) as *mut u16;
+        for version_offset in 0..version_number_entries {
+            let addr = unaligned.wrapping_add(version_offset);
+            let version = unsafe { core::ptr::read_unaligned::<u16>(addr) };
+            unsafe { core::ptr::write_unaligned::<u16>(addr, version.to_le()) }
+        }
+
+        Ok(rsp)
+    }
+}
-- 
2.48.1


