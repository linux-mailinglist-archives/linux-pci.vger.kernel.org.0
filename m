Return-Path: <linux-pci+bounces-22497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 416A5A4736C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5BE1891389
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D101B87D7;
	Thu, 27 Feb 2025 03:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="iM/HMaKW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BaMgGavA"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3B1B6D1E;
	Thu, 27 Feb 2025 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625887; cv=none; b=G4+1pCdF9fhiurQcTkJqNc1ahWOPdqQuEyl7lesUF7DuOSkTTu645noX0W96tlPer6Emr+zZguu2MZcxaee8ywemXf5Wz6ba5GPlWLc7RWv0BLwYBzA9Twt/x+fipvhYpixYKzchvIHdyDEATt5aUektiKEVNk9czR8N1x6Ey7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625887; c=relaxed/simple;
	bh=4dYavBGAZvR1zIBvbUyVRSek3sr6HHQGephV6qvbOGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIgiPaCGjtsrb+dkTps9CeN9bhHXR0AvyFfMcfAfS0OthXZ7KwT4AwuK64i4U/VqkI/YPUo9H8L4U6C1VaIqa5X4dbJR0qkHPSTMieuxxF3UDGH6TbFViSxJBKxIw+Mi+fd4RMD4OBCAp7OPgp4ge32jc4vuQ7v3Wolox+p9VEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=iM/HMaKW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BaMgGavA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 08EB82540115;
	Wed, 26 Feb 2025 22:11:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 26 Feb 2025 22:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625883; x=
	1740712283; bh=bEM8tVhnsdLYLYdndD+m0ib5kGm9xyvTcl4FxlXS7UM=; b=i
	M/HMaKWiU3tqekVehvNwJ4Biig09LStu5kmrNBgefHJQ8rPKG1f663+44WbbUWNi
	bPKUVlck56d+8+BrvTOlhi3tNVKukylxws2L3/PyoZKgaREApj5YHm8l+Q5YdLI9
	kG71j135RkgRgci6LTqYIqv8pIx1YqeYLTwXCuRii+q4JuzA2hFMeV9qb+7nIiDu
	DPdYjnLj0rXOmEyH/Leov4Gm/j+xKZMjIM7Fc3AlvDbdPkASNz7fWuTWI1D4b2rp
	74g7huVCy/unVTZmDIH5KSz0MXq6Wo5S0x+ibzvHCq8H/aOHqsvfYU1fQY9slvHn
	6oUJqJc35PlT9gxdqlEgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625883; x=1740712283; bh=b
	EM8tVhnsdLYLYdndD+m0ib5kGm9xyvTcl4FxlXS7UM=; b=BaMgGavAnQdOVfN3y
	I/Py8q1k6tRgVmj5OqFkfF5dgDWtby4noofuWySAK+5c1wpIaLOGqRASzeW/FcaJ
	hfGCQ8/2T5A47g4KTinUf2WpWdOlPWfK2I2FHjjemx3g+rMBnc2a6CjUuoCkT1ho
	gvyP+42455fRBh/gXLg5+17Gk2Gs+SM/9myo66r3PVRg4Y5/oA9J6xzKtTl4MHER
	Qm5WlMpxjCP3NzOOitmTTBPfbAE77NcZRj6zERGtfhd0Zll/0qaNjEillBPw6Jxj
	MG0e4cU2PhpotNm6RdG9ZJ0qaXs3GPP3qUJu3JVKv1x4QX1teh1LaedxYo8A/noe
	EVi4w==
X-ME-Sender: <xms:29e_Z3O1QW3xjf-u0AsVAdgZACNcjU11DE-twBcITAaYf2RkQsLYnw>
    <xme:29e_Zx-w-dUkHRS7Y_MCj-3ppnTADjIQA2Iui0b_5Jl-jubPshHAKMt-XSpmbZkp_
    AFMYHgxemwD6xyUk4c>
X-ME-Received: <xmr:29e_Z2QvgKVQB8dM8jK2BTWdngIozcwvVeBRBPWwY85gxD2UDxFVzUTN_34NKe9V3dKDvAcxepU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeekheduheejgfdtteefgeet
    geekieevveeuheegtdegffelhfeglefgvdffudetkeenucffohhmrghinhepthhrrghnsh
    hpohhrthgpshiirdhtohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtg
    hpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgt
    gihlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshesfihu
    nhhnvghrrdguvgdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtg
    hpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:29e_Z7txO09GJIUHYMAsdkoLgarS_8apZAMJd5TVT8LJAJj04nc-fQ>
    <xmx:29e_Z_cyJWPLqCK6OrHATy7CdRrf9xyeTGbNVyDVkKbuN0rPQWRlyA>
    <xmx:29e_Z305O1EkHoK77Av821Kwvw_Yrm2eES4tvlMI4HeuCxYiuIl6Hw>
    <xmx:29e_Z79Zt6N2KrC7z7XsS37a83O_w1IuuKm_patbnLe55GOIfYCmaA>
    <xmx:29e_Z18ZbvIjfWoVt2MF_0XhVg_GNcVt-gI293XBLrLDpr0djNcyAhFo>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:11:18 -0500 (EST)
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
Subject: [RFC v2 11/20] lib: rspdm: Support SPDM get_capabilities
Date: Thu, 27 Feb 2025 13:09:43 +1000
Message-ID: <20250227030952.2319050-12-alistair@alistair23.me>
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

Support the GET_CAPABILITIES SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    | 18 ++++++++--
 lib/rspdm/lib.rs       |  4 +++
 lib/rspdm/state.rs     | 67 +++++++++++++++++++++++++++++++++++--
 lib/rspdm/validator.rs | 76 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 160 insertions(+), 5 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index da7b0810f103..8a58351bf268 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -12,9 +12,7 @@
 
 /* SPDM versions supported by this implementation */
 pub(crate) const SPDM_VER_10: u8 = 0x10;
-#[allow(dead_code)]
 pub(crate) const SPDM_VER_11: u8 = 0x11;
-#[allow(dead_code)]
 pub(crate) const SPDM_VER_12: u8 = 0x12;
 pub(crate) const SPDM_VER_13: u8 = 0x13;
 
@@ -54,3 +52,19 @@ pub(crate) enum SpdmErrorCode {
 
 pub(crate) const SPDM_GET_VERSION: u8 = 0x84;
 pub(crate) const SPDM_GET_VERSION_LEN: usize = mem::size_of::<SpdmHeader>() + 255;
+
+pub(crate) const SPDM_GET_CAPABILITIES: u8 = 0xe1;
+pub(crate) const SPDM_MIN_DATA_TRANSFER_SIZE: u32 = 42;
+
+// SPDM cryptographic timeout of this implementation:
+// Assume calculations may take up to 1 sec on a busy machine, which equals
+// roughly 1 << 20.  That's within the limits mandated for responders by CMA
+// (1 << 23 usec, PCIe r6.2 sec 6.31.3) and DOE (1 sec, PCIe r6.2 sec 6.30.2).
+// Used in GET_CAPABILITIES exchange.
+pub(crate) const SPDM_CTEXPONENT: u8 = 20;
+
+pub(crate) const SPDM_CERT_CAP: u32 = 1 << 1;
+pub(crate) const SPDM_CHAL_CAP: u32 = 1 << 2;
+
+pub(crate) const SPDM_REQ_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
+pub(crate) const SPDM_RSP_MIN_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index f8cb9766ed62..fe36333b2d24 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -114,6 +114,10 @@
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.get_capabilities() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index dd1ccdfd166a..288a77b3ab56 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -17,9 +17,12 @@
 };
 
 use crate::consts::{
-    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPDM_MIN_VER, SPDM_REQ,
+    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPDM_MIN_DATA_TRANSFER_SIZE,
+    SPDM_MIN_VER, SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
+};
+use crate::validator::{
+    GetCapabilitiesReq, GetCapabilitiesRsp, GetVersionReq, GetVersionRsp, SpdmErrorRsp, SpdmHeader,
 };
-use crate::validator::{GetVersionReq, GetVersionRsp, SpdmErrorRsp, SpdmHeader};
 
 /// The current SPDM session state for a device. Based on the
 /// C `struct spdm_state`.
@@ -35,6 +38,8 @@
 ///
 /// `version`: Maximum common supported version of requester and responder.
 ///  Negotiated during GET_VERSION exchange.
+/// @rsp_caps: Cached capabilities of responder.
+///  Received during GET_CAPABILITIES exchange.
 ///
 /// `authenticated`: Whether device was authenticated successfully.
 #[expect(dead_code)]
@@ -48,6 +53,7 @@ pub struct SpdmState {
 
     // Negotiated state
     pub(crate) version: u8,
+    pub(crate) rsp_caps: u32,
 
     pub(crate) authenticated: bool,
 }
@@ -69,6 +75,7 @@ pub(crate) fn new(
             keyring,
             validate,
             version: SPDM_MIN_VER,
+            rsp_caps: 0,
             authenticated: false,
         }
     }
@@ -273,4 +280,60 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    /// Obtain the supported capabilities from an SPDM session and store the
+    /// information in the `SpdmState`.
+    pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
+        let mut request = GetCapabilitiesReq::default();
+        request.version = self.version;
+
+        let (req_sz, rsp_sz) = match self.version {
+            SPDM_VER_10 => (4, 8),
+            SPDM_VER_11 => (8, 8),
+            _ => {
+                request.data_transfer_size = self.transport_sz.to_le();
+                request.max_spdm_msg_size = request.data_transfer_size;
+
+                (
+                    core::mem::size_of::<GetCapabilitiesReq>(),
+                    core::mem::size_of::<GetCapabilitiesRsp>(),
+                )
+            }
+        };
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
+        let response: &mut GetCapabilitiesRsp =
+            Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        self.rsp_caps = u32::from_le(response.flags);
+        if (self.rsp_caps & SPDM_RSP_MIN_CAPS) != SPDM_RSP_MIN_CAPS {
+            to_result(-(bindings::EPROTONOSUPPORT as i32))?;
+        }
+
+        if self.version >= SPDM_VER_12 {
+            if response.data_transfer_size < SPDM_MIN_DATA_TRANSFER_SIZE {
+                pr_err!("Malformed capabilities response\n");
+                to_result(-(bindings::EPROTO as i32))?;
+            }
+            self.transport_sz = self.transport_sz.min(response.data_transfer_size);
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index f69be6aa6280..cd792c46767a 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -16,7 +16,7 @@
     validate::{Unvalidated, Validate},
 };
 
-use crate::consts::SPDM_GET_VERSION;
+use crate::consts::{SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_VERSION, SPDM_REQ_CAPS};
 
 #[repr(C, packed)]
 pub(crate) struct SpdmHeader {
@@ -131,3 +131,77 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
         Ok(rsp)
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct GetCapabilitiesReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    reserved1: u8,
+    pub(crate) ctexponent: u8,
+    reserved2: u16,
+
+    pub(crate) flags: u32,
+
+    /* End of SPDM 1.1 structure */
+    pub(crate) data_transfer_size: u32,
+    pub(crate) max_spdm_msg_size: u32,
+}
+
+impl Default for GetCapabilitiesReq {
+    fn default() -> Self {
+        GetCapabilitiesReq {
+            version: 0,
+            code: SPDM_GET_CAPABILITIES,
+            param1: 0,
+            param2: 0,
+            reserved1: 0,
+            ctexponent: SPDM_CTEXPONENT,
+            reserved2: 0,
+            flags: (SPDM_REQ_CAPS as u32).to_le(),
+            data_transfer_size: 0,
+            max_spdm_msg_size: 0,
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct GetCapabilitiesRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    reserved1: u8,
+    pub(crate) ctexponent: u8,
+    reserved2: u16,
+
+    pub(crate) flags: u32,
+
+    /* End of SPDM 1.1 structure */
+    pub(crate) data_transfer_size: u32,
+    pub(crate) max_spdm_msg_size: u32,
+
+    pub(crate) supported_algorithms: __IncompleteArrayField<__le16>,
+}
+
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetCapabilitiesRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<GetCapabilitiesRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `GetCapabilitiesRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetCapabilitiesRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut GetCapabilitiesRsp = unsafe { &mut *ptr };
+
+        Ok(rsp)
+    }
+}
-- 
2.48.1


