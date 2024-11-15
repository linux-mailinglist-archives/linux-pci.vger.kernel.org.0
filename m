Return-Path: <linux-pci+bounces-16812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 354BD9CD6AD
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61ECCB23D25
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 05:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8318A6AD;
	Fri, 15 Nov 2024 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="L7Bjh5oO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JRPuBVwo"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2331898FB;
	Fri, 15 Nov 2024 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649623; cv=none; b=ukpSDYHKKE89tngPKs8DbqxN3gQRDzvUdkcxaDBsBJpHXyUkVQgeQ7nBnl42E4Pd21oUw5OqA1MUd+gcZxw9FCDa7ZvE2jFrI6X+oHvx9YqcRlu6sQQZMhnS4MJdE7HcJPsUMYLrEqMj0nSJ4xmO4PkRDYfXyOkc+LDBhoRZiV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649623; c=relaxed/simple;
	bh=twMaTNW+uQlAUrCFF43ogtUkxwpcROiIJa+ql94KP28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHYK33HSpJ0A8/sX11KC3ON3+t8TwFKgiOCib7LXSycpqSo+v0Lu4QuHvXzKS8scDROnL7W8KoiMTnm+RHDMADXHHIlUg614hhMYsGfn/6ZReRZBnHxIfTOXwyVZv5LHPHcKKpX573a9kuuNM39frwOCbCMhbblxEt93wj3ZuUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=L7Bjh5oO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JRPuBVwo; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 486D2114017E;
	Fri, 15 Nov 2024 00:47:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 15 Nov 2024 00:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731649620; x=
	1731736020; bh=BROwafGv5+KSam/Tn0CU8rKMc0Vr4X3X/6hjuioSjIE=; b=L
	7Bjh5oOoToU+OipZ4R9sU2smotyesdfrXGL3DtAFy/d7WYf6nDkTNRUhvcum+E5u
	svZNbAogNCaTtSjoZ9z9/AZ+eaoMVtCfbexCCZPgrjdFSMUGe+XFjhkSdLxQyPFu
	AlUkRz+SMyYCoYxHc2P2BKnckr+jSYPXZwUJgfXM3q08RJFcwymS7v6TBOJtUJR9
	xYtUfZuiUCIixfya0DjO+5os8DOvjmXvIj/+TUa1KVFUWl1iZvNk8yUfyxDDA+BX
	OAUedxjIlmQdrpVtY8eFItpoTz4Ze5ifU2L9c8a8bcJDsQbLWpo3zZzOuVDRsaXF
	9tyo0X9AD9qi8TPty1VoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731649620; x=1731736020; bh=B
	ROwafGv5+KSam/Tn0CU8rKMc0Vr4X3X/6hjuioSjIE=; b=JRPuBVwo+eUDIQn6r
	xQHkvadKTNWcjzpVqR53ITEQs3hJCX9NmmD9RjyMQkS0mdRbljMY1YbNigLgqRlZ
	0zn1pAkIbYj68jrw+UHrrIjKj48ATOzzdpP8hjLxzs53sZXn8IwLWU8S8el6P9oi
	4tSNYfIZHEMxvRMNhT2MHqColH7BWDQWgjPz/5Uf8SyiKIVlhY/p7BABoR2mOCEW
	ly4zBBMs2v5t5B7cqJJdslZ0v5ozky6UGdTZVFErIbchCwvrkQyrz7cBzVorAWbH
	EFV7wqJl0zXbVO2H9dHdZaotIktBpgPG/Fxs2dqgWsqpPzKc8c2g8cZqgUKtXD6t
	6kPAA==
X-ME-Sender: <xms:U-A2Z6qtf441VwUFhudGz_Gh8bIlUPsj1KU8xL5pQC8bkMlE8Sk49w>
    <xme:U-A2Z4rJES_8AJePSbIkAq-hcfTnXEc7XIsoP9I_VNyMWFVTH_T8CdczpV1DzXpO9
    Csy6evvgZofXE-JROA>
X-ME-Received: <xmr:U-A2Z_MjPXTetUwjsYB2QbP8Z2SOeCM-BN8pPo1zD_CBiO3DyoTcerkNTPmFnUiSLM3t-A-hHqCe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeekheduheejgfdtteefgeetgeekieevveeuheegtdegffelhfeglefgvdffudet
    keenucffohhmrghinhepthhrrghnshhpohhrthgpshiirdhtohenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhs
    thgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtohepjhhonhgr
    thhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhs
    thdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghh
    vghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhptghise
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtgiglhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhoth
    honhhmrghilhdrtghomh
X-ME-Proxy: <xmx:VOA2Z54MPI-SJtICIa7cpsGUfmrEoX8D4IkXw38nc9HDQbehHiEmFg>
    <xmx:VOA2Z54X09F1j1-AUtD5nqQbNDvoEef7Yfr22yT3AN7DOywdysGcpQ>
    <xmx:VOA2Z5iep0hGzNIAkDVV53GhZIlx4MSYwNBW6_thc9RVL0NMgXEzWg>
    <xmx:VOA2Zz6omP4_6wGNMD4Ng0QNooMENKW66NwJIU5EYCoGE5kxICdmaw>
    <xmx:VOA2Z36uX4FMZabZF4EN5oKYXAGfHTB-2WwAFUauqD0JlUQbVdSbPAUP>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 00:46:54 -0500 (EST)
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
Subject: [RFC 5/6] lib: rspdm: Support SPDM get_capabilities
Date: Fri, 15 Nov 2024 15:46:15 +1000
Message-ID: <20241115054616.1226735-6-alistair@alistair23.me>
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

Support the GET_CAPABILITIES SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    | 18 ++++++++--
 lib/rspdm/lib.rs       |  4 +++
 lib/rspdm/state.rs     | 73 +++++++++++++++++++++++++++++++++++++++--
 lib/rspdm/validator.rs | 74 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 5 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index e263d62fa648..d60f8302f389 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -11,9 +11,7 @@
 
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
index 670ecc02a471..bbd755854acd 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -111,6 +111,10 @@
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.get_capabilities() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 9ace0bbaa21a..05a7faf17d47 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -16,10 +16,13 @@
 };
 
 use crate::consts::{
-    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPDM_MIN_VER,
-    SPDM_REQ,
+    SpdmErrorCode, SPDM_CTEXPONENT, SPDM_ERROR, SPDM_GET_CAPABILITIES, SPDM_GET_VERSION,
+    SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPDM_MIN_DATA_TRANSFER_SIZE, SPDM_MIN_VER, SPDM_REQ,
+    SPDM_REQ_CAPS, SPDM_RSP_MIN_CAPS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
+};
+use crate::validator::{
+    GetCapabilitiesReq, GetCapabilitiesRsp, GetVersionReq, GetVersionRsp, SpdmErrorRsp, SpdmHeader,
 };
-use crate::validator::{GetVersionReq, GetVersionRsp, SpdmErrorRsp, SpdmHeader};
 
 /// The current SPDM session state for a device. Based on the
 /// C `struct spdm_state`.
@@ -35,6 +38,8 @@
 ///
 /// @version: Maximum common supported version of requester and responder.
 ///  Negotiated during GET_VERSION exchange.
+/// @rsp_caps: Cached capabilities of responder.
+///  Received during GET_CAPABILITIES exchange.
 ///
 /// @authenticated: Whether device was authenticated successfully.
 #[allow(dead_code)]
@@ -48,6 +53,7 @@ pub struct SpdmState {
 
     /* Negotiated state */
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
@@ -269,4 +276,64 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    /// Obtain the supported capabilities from an SPDM session and store the
+    /// information in the `SpdmState`.
+    pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
+        let mut request = GetCapabilitiesReq::default();
+
+        request.version = self.version;
+        request.code = SPDM_GET_CAPABILITIES;
+        request.ctexponent = SPDM_CTEXPONENT;
+        request.flags = (SPDM_REQ_CAPS as u32).to_le();
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
index 05f1ba155920..cc998e70f235 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -117,3 +117,77 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
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
+            code: 0,
+            param1: 0,
+            param2: 0,
+            reserved1: 0,
+            ctexponent: 0,
+            reserved2: 0,
+            flags: 0,
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
2.47.0


