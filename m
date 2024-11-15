Return-Path: <linux-pci+bounces-16811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6A9CD6AB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0DFB2479D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 05:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC62185B6B;
	Fri, 15 Nov 2024 05:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="Dkvw9f9b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G6ZFAO+V"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD74188920;
	Fri, 15 Nov 2024 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649616; cv=none; b=VB7u55f0/sJIA++oEWLZCYk/pZjDMis6x7yUoXSvjeeU0BzoY67u7bj7zfNuKdd60fSdgLgwLUDM8rEE90zpLSp1VIJ7YCZWDlNKg9sBkUt0ugSE21tYVIwLi9kLZJZbQvcOBf0IL9VrLuy+6nOwIrFq7cFDlC9dMrJnINg3bPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649616; c=relaxed/simple;
	bh=uzpdqNmNy98WB+VewdJT9rV5BTXlnvahqy7AVLeLdvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4V50Rssf33nNaYmPB/9n/qeYdRq32TNYkwLy/OvIXy/SUiw8GX9gqaNgDyHvKgWDVkfoxqYsNYVTCaq1+tQvtg0s+GWg6ioc2RgYbJx1PR/+5PNOrBwgf0Jxh3Dzynshgc53xmKCYZCCMXRaeLHKsRunV9nApVkHlFH3rhoUnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=Dkvw9f9b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G6ZFAO+V; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 9B6DA1140161;
	Fri, 15 Nov 2024 00:46:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 15 Nov 2024 00:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731649613; x=
	1731736013; bh=px43dPJE1FjJu4QJhWRqee+lLEDB9NfGGRe9sBlPwFI=; b=D
	kvw9f9bnLi5imN9uWK4tUx5h5YdaUBkJqbIlTv/LgVH/IVjgjwPzsRqGhc2NrVh7
	7ef7erFpKFVr4IwXRSuasrv4qoD+xQpre9GVDxfnyskm8OhvAwSJ5m8xkCGEryid
	T/VCOmmfJusG3MpbX9qgjiqZBumL6roOQaupLvGNNqi5RNVwdbw3FTuNZvE/wTe5
	eFxhM/JCFlL5nhimJ8ZMo4Go3+YYuKnUWbwwjF/PXPSKsju7v22FXGOgnR+9S7EW
	a6SHU/Uxp7w72mAW692SZNSiyWIyPrqZz8rgy1aiv6KRCJv2No9swsI/WCiFgKEz
	0t394PN6Nw1s9A1Q/cGWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731649613; x=1731736013; bh=p
	x43dPJE1FjJu4QJhWRqee+lLEDB9NfGGRe9sBlPwFI=; b=G6ZFAO+V6zzUqcSSs
	kLAQj9e8P5Gl3EVjw4yqM27cfEbYGU7R1BLYq0QFanI3bilfl2OZ04duEJsD0Mv+
	mVojL7HsQa0TtOUqy8eUpNViKybDEvCXg4sfwA2v7raUr7cyu7TL+v3M/a1miqnf
	O0izJS6Xf8uUlst5f6de6/gMAD9JG0kUrA7mm/v3pvV6KmccZ595ZuR769IKaf5d
	CzsoULztCew5kG6tYyOOI3wjmqyTdAUAAlt63LpzNmbJt573qLygwGhm/1w6vxud
	u53/7EVmMfD0KIYU4CiDG+U6EpMIBLDsUhnD005GHCUuxk6KizxsN7s3Tys0NxFN
	euE9Q==
X-ME-Sender: <xms:TOA2Z0I3jtqAQhdQKdttn95toaSjBUJGl9evRsFZeOOwn9U-wkea5w>
    <xme:TOA2Z0LvAElSd0ThAWdpgJ98SSvPHO-6kn6X-8nhboI2ZEygGBihYEfPAFMJyEoqA
    Hy6YEMAbdRQosAw1lE>
X-ME-Received: <xmr:TOA2Z0uDk7ARWySuUf9JpFejWbtyCAMV8x0ngQP1i3TW3WOjtZOGQBwqJ4It-A89cxM9Sb1YsG6G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeeitdefkeetledvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfeh
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepvddtpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpd
    hrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsjhho
    rhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:TOA2Zxa1yw5Tx-8gY7yJ4IgXB5UjpYwdN_Gb_2-GbjHTpw79E4rP6Q>
    <xmx:TeA2Z7ai-ZGQ27JXn8VhOmpyf8XOgf6e-YBPImHo4b5VY_PfGBdxow>
    <xmx:TeA2Z9BnKMTbx4Lyl0HZTkGgGd5aV6qC2Zg_-QtUgqD0VzhQ99kL5g>
    <xmx:TeA2Zxal1ljB1-OreX9Fvfn384gdNfD1c-OEFST-GfP-BzH7YToLIQ>
    <xmx:TeA2Z1YU7xNZIY0avpwkTDm_Wm6tSi6kowazrNjBrSaNcV_OS0OrYK98>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 00:46:47 -0500 (EST)
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
Subject: [RFC 4/6] lib: rspdm: Support SPDM get_version
Date: Fri, 15 Nov 2024 15:46:14 +1000
Message-ID: <20241115054616.1226735-5-alistair@alistair23.me>
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

Support the GET_VERSION SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    | 17 ++++++++++++
 lib/rspdm/lib.rs       |  6 ++++-
 lib/rspdm/state.rs     | 61 +++++++++++++++++++++++++++++++++++++++---
 lib/rspdm/validator.rs | 54 +++++++++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 017e673ff194..e263d62fa648 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -6,6 +6,20 @@
 //!
 //! Copyright (C) 2024 Western Digital
 
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
index edfd94ab56dd..670ecc02a471 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -106,7 +106,11 @@
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
index 5b55c4655e2e..9ace0bbaa21a 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -7,6 +7,7 @@
 //! Copyright (C) 2024 Western Digital
 
 use core::ffi::c_void;
+use core::slice::from_raw_parts_mut;
 use kernel::prelude::*;
 use kernel::{
     bindings,
@@ -14,8 +15,11 @@
     validate::Untrusted,
 };
 
-use crate::consts::{SpdmErrorCode, SPDM_ERROR, SPDM_REQ};
-use crate::validator::{SpdmErrorRsp, SpdmHeader};
+use crate::consts::{
+    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPDM_MIN_VER,
+    SPDM_REQ,
+};
+use crate::validator::{GetVersionReq, GetVersionRsp, SpdmErrorRsp, SpdmHeader};
 
 /// The current SPDM session state for a device. Based on the
 /// C `struct spdm_state`.
@@ -64,7 +68,7 @@ pub(crate) fn new(
             transport_sz,
             keyring,
             validate,
-            version: 0x10,
+            version: SPDM_MIN_VER,
             authenticated: false,
         }
     }
@@ -214,4 +218,55 @@ pub(crate) fn spdm_exchange(
 
         Ok(length)
     }
+
+    /// Negoiate a supported SPDM version and store the information
+    /// in the `SpdmState`.
+    pub(crate) fn get_version(&mut self) -> Result<(), Error> {
+        let mut request = GetVersionReq {
+            version: self.version,
+            code: SPDM_GET_VERSION,
+            param1: 0,
+            param2: 0,
+        };
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
index 5004804f85c8..05f1ba155920 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -6,6 +6,7 @@
 //!
 //! Copyright (C) 2024 Western Digital
 
+use crate::bindings::{__IncompleteArrayField, __le16};
 use crate::consts::SpdmErrorCode;
 use core::mem;
 use kernel::prelude::*;
@@ -63,3 +64,56 @@ pub(crate) struct SpdmErrorRsp {
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
2.47.0


