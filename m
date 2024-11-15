Return-Path: <linux-pci+bounces-16810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0339CD6A9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEAE1F226CF
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 05:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C242183CC1;
	Fri, 15 Nov 2024 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="p6BV0gpX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nCMoHtN7"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C48181CE1;
	Fri, 15 Nov 2024 05:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649610; cv=none; b=GswqCKAKMXc3R1O19tWZ0N8dEiGEWJkxEscDxwqqZ863EWr3AVMt314+uIKyBXk7X72dWQftSTBqHUDsidImBjn9f1JOEhSbzqbtImQSOHKLXb4MnQPGLrzPA5YcB11vak7FQawoXRdpAHIaNwPiW7SRHYuWlnw1AyDvmTZ5Y00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649610; c=relaxed/simple;
	bh=vAi4U3hvv80FEU28TXcL2BC7KBALsbTyGFXdw0JqxA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryZZit8+jTt5CqXdKzTtGSViLyk4DL/PikYM1BGhxoLf66fRifB49uj3GRqBpbcKU2RZhv3Up9QJ9LF2izMQ2Ppm05EKSoVkIkWyHCCR/NYRxXzHwFM3vF2HgflI8K3lbjdWYMPlwC2kem+rBsnGzvT3Yy5KgOFjr/Eat2n43nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=p6BV0gpX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nCMoHtN7; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A187254010A;
	Fri, 15 Nov 2024 00:46:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 15 Nov 2024 00:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731649606; x=
	1731736006; bh=czsj8witK6pY1F/cAjs/0shbKrG6D3+OTxs6hixCwOE=; b=p
	6BV0gpX1WV7TQLy7HZcsW24PrDreWdgDbHviP6zcaROp1E2VRdYro2QGvfZsHByC
	oScYsuerXIo3wbS6o9lqSPwow37jCne3SnsToXiTEpw82LNtOTQp77lilkT2YNSb
	IaRX106jpClGardvdSYbVIsMAYYu7SQgVg9x/w/kW8iYq8PDYlX4HKigCOa7AcSz
	7tiq4Gry3028ueRcVj6+UyG1rNxcQ1cYQwY21aVj/lMA6ZphoKGjT42c5ugMNCpb
	j3518yCG+Ong7qRe4bsG0NffPNJIjn3+8T36XnOzD65I2a8mRcRNuZ6wO8khbCFx
	TMlcK60pHrcSAaASfOnJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731649606; x=1731736006; bh=c
	zsj8witK6pY1F/cAjs/0shbKrG6D3+OTxs6hixCwOE=; b=nCMoHtN7moQ1/hy71
	9Yn/z+rNZUfmw0igjEWEpJTPD4G0+W33yUqUkVNN9KELhGTAhLmY7Pp5hYXJSAtw
	Xk679S7l5iZO7EmzflJ34W3WAi/QYWUlcDHmqJC1Hn0pFFRH02rfq/YLbrG3M7NY
	Hszphoq+0QKgqbfStQAHng9/GsmFqzpXSN+1URvwIEh/cT0uZ1HSwQr2SpBqTTxW
	MIppKGavFalyud/XB1JRTrfaibNfpAWZaws51WmK830J/YSie6hJFUPVK03iJpkB
	Il7G3QQsBWEM4G/eu7V966A0PHbXZakMrdZ+VcxkufN5oDf7U5hq0kcjZPcONmfF
	otqWQ==
X-ME-Sender: <xms:ReA2Z2CIyd19_RPsddr5R2SuibYjAPZfmsz46S0pkT2Scp2D_PzZbA>
    <xme:ReA2Zwhty7-ENzpXobcMEBXSzFC9MgOonoFBs2ItUOKt385AtQNSWn1pvPoniCwoN
    jU1AyK7Q5nalluQDdU>
X-ME-Received: <xmr:ReA2Z5n0UtieD5ppPEPWVClxF7C-ubrTeMAgzzcGOQ8t3ehNxWEsN1PE1BOdDql6iNur_K1cMSb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpedutddvffeklefhgfefueegiefhkedujedttddukeeiueduudfhtddtfeefveeg
    hfenucffohhmrghinhepughmthhfrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedr
    mhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopehjohhnrghthhgrnhdrtggr
    mhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhl
    ihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlih
    hnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:RuA2Z0wHAxNqyBaQ9SKBMigbWm3oE9T82qJ_VcU69gcZDN21lMrIQA>
    <xmx:RuA2Z7QnLK_PQKPiQVb6JdBxdcWROU75OifNqbhRSFT_cTIraGomlA>
    <xmx:RuA2Z_Y7T3R9Z4gZ1vX4wSICMKaoy62PKFe56BPZXQthnOcqctzkKw>
    <xmx:RuA2Z0QdAcMTZqoJr4hqj4hjQXqDVJgG4Vc3Z0ZNnBOdG92Ul8-69A>
    <xmx:RuA2Z8T7rkXhYWKD83vw9Rmwp6uj7ngdYBKHnQnSuyBvd-ILAsc5YTBn>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 00:46:40 -0500 (EST)
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
Subject: [RFC 3/6] lib: rspdm: Initial commit of Rust SPDM
Date: Fri, 15 Nov 2024 15:46:13 +1000
Message-ID: <20241115054616.1226735-4-alistair@alistair23.me>
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

This is the initial commit of the Rust SPDM library. It is based on and
compatible with the C SPDM library in the kernel (lib/spdm).

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 MAINTAINERS            |   6 ++
 drivers/pci/Kconfig    |   2 +-
 lib/Kconfig            |  17 ++++
 lib/Makefile           |   1 +
 lib/rspdm/Makefile     |  11 +++
 lib/rspdm/consts.rs    |  39 ++++++++
 lib/rspdm/lib.rs       | 134 +++++++++++++++++++++++++
 lib/rspdm/req-sysfs.c  | 174 +++++++++++++++++++++++++++++++++
 lib/rspdm/state.rs     | 217 +++++++++++++++++++++++++++++++++++++++++
 lib/rspdm/sysfs.rs     |  27 +++++
 lib/rspdm/validator.rs |  65 ++++++++++++
 11 files changed, 692 insertions(+), 1 deletion(-)
 create mode 100644 lib/rspdm/Makefile
 create mode 100644 lib/rspdm/consts.rs
 create mode 100644 lib/rspdm/lib.rs
 create mode 100644 lib/rspdm/req-sysfs.c
 create mode 100644 lib/rspdm/state.rs
 create mode 100644 lib/rspdm/sysfs.rs
 create mode 100644 lib/rspdm/validator.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index a30aca77b17b..2c2d4ddcfb1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20785,6 +20785,12 @@ F:	drivers/pci/cma*
 F:	include/linux/spdm.h
 F:	lib/spdm/
 
+RUST SECURITY PROTOCOL AND DATA MODEL (SPDM)
+M:	Alistair Francis <alistair@alistair23.me>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	lib/rspdm/
+
 SECURITY SUBSYSTEM
 M:	Paul Moore <paul@paul-moore.com>
 M:	James Morris <jmorris@namei.org>
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 690a2a38cb52..744d35d28dc7 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -128,7 +128,7 @@ config PCI_CMA
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select PCI_DOE
-	depends on SPDM
+	depends on SPDM || RSPDM
 	help
 	  Authenticate devices on enumeration per PCIe r6.2 sec 6.31.
 	  A PCI DOE mailbox is used as transport for DMTF SPDM based
diff --git a/lib/Kconfig b/lib/Kconfig
index 4db9bc8e29f8..a47650a6757c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -754,6 +754,23 @@ config SPDM
 	  in .config.  Drivers selecting SPDM therefore need to also select
 	  any algorithms they deem mandatory.
 
+config RSPDM
+	bool "Rust SPDM"
+	select CRYPTO
+	select KEYS
+	select ASYMMETRIC_KEY_TYPE
+	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select X509_CERTIFICATE_PARSER
+	depends on SPDM = "n"
+	help
+	  The Rust implementation of the Security Protocol and Data Model (SPDM)
+	  allows for device authentication, measurement, key exchange and
+	  encrypted sessions.
+
+	  Crypto algorithms negotiated with SPDM are limited to those enabled
+	  in .config.  Drivers selecting SPDM therefore need to also select
+	  any algorithms they deem mandatory.
+
 endmenu
 
 config GENERIC_IOREMAP
diff --git a/lib/Makefile b/lib/Makefile
index 5c6a48365993..4b55542c1aed 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -302,6 +302,7 @@ obj-$(CONFIG_ASN1) += asn1_decoder.o
 obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
 
 obj-$(CONFIG_SPDM) += spdm/
+obj-$(CONFIG_RSPDM) += rspdm/
 
 obj-$(CONFIG_FONT_SUPPORT) += fonts/
 
diff --git a/lib/rspdm/Makefile b/lib/rspdm/Makefile
new file mode 100644
index 000000000000..f15b1437196b
--- /dev/null
+++ b/lib/rspdm/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+# https://www.dmtf.org/dsp/DSP0274
+#
+# Copyright (C) 2024 Western Digital
+
+obj-$(CONFIG_RSPDM) += spdm.o
+
+spdm-y := lib.o
+spdm-$(CONFIG_SYSFS) += req-sysfs.o
diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
new file mode 100644
index 000000000000..017e673ff194
--- /dev/null
+++ b/lib/rspdm/consts.rs
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! https://www.dmtf.org/dsp/DSP0274
+//!
+//! Constants used by the library
+//!
+//! Copyright (C) 2024 Western Digital
+
+pub(crate) const SPDM_REQ: u8 = 0x80;
+pub(crate) const SPDM_ERROR: u8 = 0x7f;
+
+#[allow(dead_code)]
+#[repr(u8)]
+#[derive(Clone, Copy)]
+pub(crate) enum SpdmErrorCode {
+    InvalidRequest = 0x01,
+    InvalidSession = 0x02,
+    Busy = 0x03,
+    UnexpectedRequest = 0x04,
+    Unspecified = 0x05,
+    DecryptError = 0x06,
+    UnsupportedRequest = 0x07,
+    RequestInFlight = 0x08,
+    InvalidResponseCode = 0x09,
+    SessionLimitExceeded = 0x0a,
+    SessionRequired = 0x0b,
+    ResetRequired = 0x0c,
+    ResponseTooLarge = 0x0d,
+    RequestTooLarge = 0x0e,
+    LargeResponse = 0x0f,
+    MessageLost = 0x10,
+    InvalidPolicy = 0x11,
+    VersionMismatch = 0x41,
+    ResponseNotReady = 0x42,
+    RequestResynch = 0x43,
+    OperationFailed = 0x44,
+    NoPendingRequests = 0x45,
+    VendorDefinedError = 0xff,
+}
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
new file mode 100644
index 000000000000..edfd94ab56dd
--- /dev/null
+++ b/lib/rspdm/lib.rs
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! https://www.dmtf.org/dsp/DSP0274
+//!
+//! Top level library, including C compatible public functions to be called
+//! from other subsytems.
+//!
+//! This mimics the C SPDM implementation in the kernel
+//!
+//! Copyright (C) 2024 Western Digital
+
+use core::ffi::{c_int, c_void};
+use core::ptr;
+use core::slice::from_raw_parts_mut;
+use kernel::prelude::*;
+use kernel::{alloc::flags, bindings};
+
+use crate::state::SpdmState;
+
+const __LOG_PREFIX: &[u8] = b"spdm\0";
+
+mod consts;
+mod state;
+pub mod sysfs;
+mod validator;
+
+/// spdm_create() - Allocate SPDM session
+///
+/// @dev: Responder device
+/// @transport: Transport function to perform one message exchange
+/// @transport_priv: Transport private data
+/// @transport_sz: Maximum message size the transport is capable of (in bytes)
+/// @keyring: Trusted root certificates
+/// @validate: Function to validate additional leaf certificate requirements
+///	(optional, may be %NULL)
+///
+/// Return a pointer to the allocated SPDM session state or NULL on error.
+#[no_mangle]
+pub unsafe extern "C" fn spdm_create(
+    dev: *mut bindings::device,
+    transport: bindings::spdm_transport,
+    transport_priv: *mut c_void,
+    transport_sz: u32,
+    keyring: *mut bindings::key,
+    validate: bindings::spdm_validate,
+) -> *mut SpdmState {
+    match KBox::new(
+        SpdmState::new(
+            dev,
+            transport,
+            transport_priv,
+            transport_sz,
+            keyring,
+            validate,
+        ),
+        flags::GFP_KERNEL,
+    ) {
+        Ok(ret) => KBox::into_raw(ret) as *mut SpdmState,
+        Err(_) => ptr::null_mut(),
+    }
+}
+
+/// spdm_exchange() - Perform SPDM message exchange with device
+///
+/// @spdm_state: SPDM session state
+/// @req: Request message
+/// @req_sz: Size of @req
+/// @rsp: Response message
+/// @rsp_sz: Size of @rsp
+///
+/// Send the request @req to the device via the @transport in @spdm_state and
+/// receive the response into @rsp, respecting the maximum buffer size @rsp_sz.
+/// The request version is automatically populated.
+///
+/// Return response size on success or a negative errno.  Response size may be
+/// less than @rsp_sz and the caller is responsible for checking that.  It may
+/// also be more than expected (though never more than @rsp_sz), e.g. if the
+/// transport receives only dword-sized chunks.
+#[no_mangle]
+pub unsafe extern "C" fn spdm_exchange(
+    state: &'static mut SpdmState,
+    req: *mut c_void,
+    req_sz: usize,
+    rsp: *mut c_void,
+    rsp_sz: usize,
+) -> isize {
+    let request_buf: &mut [u8] = unsafe { from_raw_parts_mut(req as *mut u8, req_sz) };
+    let response_buf: &mut [u8] = unsafe { from_raw_parts_mut(rsp as *mut u8, rsp_sz) };
+
+    match state.spdm_exchange(request_buf, response_buf) {
+        Ok(ret) => ret as isize,
+        Err(e) => e.to_errno() as isize,
+    }
+}
+
+/// spdm_authenticate() - Authenticate device
+///
+/// @spdm_state: SPDM session state
+///
+/// Authenticate a device through a sequence of GET_VERSION, GET_CAPABILITIES,
+/// NEGOTIATE_ALGORITHMS, GET_DIGESTS, GET_CERTIFICATE and CHALLENGE exchanges.
+///
+/// Perform internal locking to serialize multiple concurrent invocations.
+/// Can be called repeatedly for reauthentication.
+///
+/// Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
+/// indicates authentication is not supported by the device.
+#[no_mangle]
+pub unsafe extern "C" fn spdm_authenticate(_state: &'static mut SpdmState) -> c_int {
+    0
+}
+
+/// spdm_publish_log() - Publish log of received SPDM signatures in sysfs
+///
+/// @spdm_state: SPDM session state
+///
+/// sysfs attributes representing received SPDM signatures are not static,
+/// but created dynamically upon authentication or measurement.  If a device
+/// was authenticated or measured before it became visible in sysfs, the
+/// attributes could not be created.  This function retroactively creates
+/// those attributes in sysfs after the device has become visible through
+/// device_add().
+#[no_mangle]
+pub unsafe extern "C" fn spdm_publish_log(_spdm_state: *mut SpdmState) {
+    todo!()
+}
+
+/// spdm_destroy() - Destroy SPDM session
+///
+/// @spdm_state: SPDM session state
+#[no_mangle]
+pub unsafe extern "C" fn spdm_destroy(_spdm_state: *mut SpdmState) {
+    todo!()
+}
diff --git a/lib/rspdm/req-sysfs.c b/lib/rspdm/req-sysfs.c
new file mode 100644
index 000000000000..aff79eb0c4ee
--- /dev/null
+++ b/lib/rspdm/req-sysfs.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Requester role: sysfs interface
+ *
+ * Copyright (C) 2023-24 Intel Corporation
+ * Copyright (C) 2024 Western Digital
+ */
+
+#include <linux/pci.h>
+
+#define SPDM_NONCE_SZ 32 /* SPDM 1.0.0 table 20 */
+
+int rust_authenticated_show(void *spdm_state, char *buf);
+
+/**
+ * dev_to_spdm_state() - Retrieve SPDM session state for given device
+ *
+ * @dev: Responder device
+ *
+ * Returns a pointer to the device's SPDM session state,
+ *	   %NULL if the device doesn't have one or
+ *	   %ERR_PTR if it couldn't be determined whether SPDM is supported.
+ *
+ * In the %ERR_PTR case, attributes are visible but return an error on access.
+ * This prevents downgrade attacks where an attacker disturbs memory allocation
+ * or communication with the device in order to create the appearance that SPDM
+ * is unsupported.  E.g. with PCI devices, the attacker may foil CMA or DOE
+ * initialization by simply hogging memory.
+ */
+static void *dev_to_spdm_state(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pci_dev_to_spdm_state(to_pci_dev(dev));
+
+	/* Insert mappers for further bus types here. */
+
+	return NULL;
+}
+
+/* authenticated attribute */
+
+static umode_t spdm_attrs_are_visible(struct kobject *kobj,
+				      struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	void *spdm_state = dev_to_spdm_state(dev);
+
+	if (IS_ERR_OR_NULL(spdm_state))
+		return SYSFS_GROUP_INVISIBLE;
+
+	return a->mode;
+}
+
+static ssize_t authenticated_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	void *spdm_state = dev_to_spdm_state(dev);
+	int rc;
+
+	if (IS_ERR_OR_NULL(spdm_state))
+		return PTR_ERR(spdm_state);
+
+	if (sysfs_streq(buf, "re")) {
+		rc = spdm_authenticate(spdm_state);
+		if (rc)
+			return rc;
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t authenticated_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	void *spdm_state = dev_to_spdm_state(dev);
+
+	if (IS_ERR_OR_NULL(spdm_state))
+		return PTR_ERR(spdm_state);
+
+	return rust_authenticated_show(spdm_state, buf);
+}
+static DEVICE_ATTR_RW(authenticated);
+
+static struct attribute *spdm_attrs[] = {
+	&dev_attr_authenticated.attr,
+	NULL
+};
+
+const struct attribute_group spdm_attr_group = {
+	.attrs = spdm_attrs,
+	.is_visible = spdm_attrs_are_visible,
+};
+
+/* certificates attributes */
+
+static umode_t spdm_certificates_are_visible(struct kobject *kobj,
+					     struct bin_attribute *a, int n)
+{
+	return SYSFS_GROUP_INVISIBLE;
+}
+
+static ssize_t spdm_cert_read(struct file *file, struct kobject *kobj,
+			      struct bin_attribute *a, char *buf, loff_t off,
+			      size_t count)
+{
+	return 0;
+}
+
+static BIN_ATTR(slot0, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot1, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot2, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot3, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot4, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot5, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot6, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot7, 0444, spdm_cert_read, NULL, 0xffff);
+
+static struct bin_attribute *spdm_certificates_bin_attrs[] = {
+	&bin_attr_slot0,
+	&bin_attr_slot1,
+	&bin_attr_slot2,
+	&bin_attr_slot3,
+	&bin_attr_slot4,
+	&bin_attr_slot5,
+	&bin_attr_slot6,
+	&bin_attr_slot7,
+	NULL
+};
+
+const struct attribute_group spdm_certificates_group = {
+	.name = "certificates",
+	.bin_attrs = spdm_certificates_bin_attrs,
+	.is_bin_visible = spdm_certificates_are_visible,
+};
+
+/* signatures attributes */
+
+static umode_t spdm_signatures_are_visible(struct kobject *kobj,
+					   struct bin_attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	void *spdm_state = dev_to_spdm_state(dev);
+
+	if (IS_ERR_OR_NULL(spdm_state))
+		return SYSFS_GROUP_INVISIBLE;
+
+	return a->attr.mode;
+}
+
+static ssize_t next_requester_nonce_write(struct file *file,
+					  struct kobject *kobj,
+					  struct bin_attribute *attr,
+					  char *buf, loff_t off, size_t count)
+{
+	return 0;
+}
+static BIN_ATTR_WO(next_requester_nonce, SPDM_NONCE_SZ);
+
+static struct bin_attribute *spdm_signatures_bin_attrs[] = {
+	&bin_attr_next_requester_nonce,
+	NULL
+};
+
+const struct attribute_group spdm_signatures_group = {
+	.name = "signatures",
+	.bin_attrs = spdm_signatures_bin_attrs,
+	.is_bin_visible = spdm_signatures_are_visible,
+};
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
new file mode 100644
index 000000000000..5b55c4655e2e
--- /dev/null
+++ b/lib/rspdm/state.rs
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! https://www.dmtf.org/dsp/DSP0274
+//!
+//! The `SpdmState` struct and implementation.
+//!
+//! Copyright (C) 2024 Western Digital
+
+use core::ffi::c_void;
+use kernel::prelude::*;
+use kernel::{
+    bindings,
+    error::{code::EINVAL, to_result, Error},
+    validate::Untrusted,
+};
+
+use crate::consts::{SpdmErrorCode, SPDM_ERROR, SPDM_REQ};
+use crate::validator::{SpdmErrorRsp, SpdmHeader};
+
+/// The current SPDM session state for a device. Based on the
+/// C `struct spdm_state`.
+///
+/// @dev: Responder device.  Used for error reporting and passed to @transport.
+/// @transport: Transport function to perform one message exchange.
+/// @transport_priv: Transport private data.
+/// @transport_sz: Maximum message size the transport is capable of (in bytes).
+///  Used as DataTransferSize in GET_CAPABILITIES exchange.
+/// @keyring: Keyring against which to check the first certificate in
+///  responder's certificate chain.
+/// @validate: Function to validate additional leaf certificate requirements.
+///
+/// @version: Maximum common supported version of requester and responder.
+///  Negotiated during GET_VERSION exchange.
+///
+/// @authenticated: Whether device was authenticated successfully.
+#[allow(dead_code)]
+pub struct SpdmState {
+    pub(crate) dev: *mut bindings::device,
+    pub(crate) transport: bindings::spdm_transport,
+    pub(crate) transport_priv: *mut c_void,
+    pub(crate) transport_sz: u32,
+    pub(crate) keyring: *mut bindings::key,
+    pub(crate) validate: bindings::spdm_validate,
+
+    /* Negotiated state */
+    pub(crate) version: u8,
+
+    pub(crate) authenticated: bool,
+}
+
+impl SpdmState {
+    pub(crate) fn new(
+        dev: *mut bindings::device,
+        transport: bindings::spdm_transport,
+        transport_priv: *mut c_void,
+        transport_sz: u32,
+        keyring: *mut bindings::key,
+        validate: bindings::spdm_validate,
+    ) -> Self {
+        SpdmState {
+            dev,
+            transport,
+            transport_priv,
+            transport_sz,
+            keyring,
+            validate,
+            version: 0x10,
+            authenticated: false,
+        }
+    }
+
+    fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {
+        let ret = match rsp.error_code {
+            SpdmErrorCode::InvalidRequest => {
+                pr_err!("Invalid request\n");
+                bindings::EINVAL
+            }
+            SpdmErrorCode::InvalidSession => {
+                if rsp.version == 0x11 {
+                    pr_err!("Invalid session {:#x}\n", rsp.error_data);
+                    bindings::EINVAL
+                } else {
+                    pr_err!("Undefined error {:#x}\n", rsp.error_code as u8);
+                    bindings::EINVAL
+                }
+            }
+            SpdmErrorCode::Busy => {
+                pr_err!("Busy\n");
+                bindings::EBUSY
+            }
+            SpdmErrorCode::UnexpectedRequest => {
+                pr_err!("Unexpected request\n");
+                bindings::EINVAL
+            }
+            SpdmErrorCode::Unspecified => {
+                pr_err!("Unspecified error\n");
+                bindings::EINVAL
+            }
+            SpdmErrorCode::DecryptError => {
+                pr_err!("Decrypt error\n");
+                bindings::EIO
+            }
+            SpdmErrorCode::UnsupportedRequest => {
+                pr_err!("Unsupported request {:#x}\n", rsp.error_data);
+                bindings::EINVAL
+            }
+            SpdmErrorCode::RequestInFlight => {
+                pr_err!("Request in flight\n");
+                bindings::EINVAL
+            }
+            SpdmErrorCode::InvalidResponseCode => {
+                pr_err!("Invalid response code\n");
+                bindings::EINVAL
+            }
+            SpdmErrorCode::SessionLimitExceeded => {
+                pr_err!("Session limit exceeded\n");
+                bindings::EBUSY
+            }
+            SpdmErrorCode::SessionRequired => {
+                pr_err!("Session required\n");
+                bindings::EINVAL
+            }
+            SpdmErrorCode::ResetRequired => {
+                pr_err!("Reset required\n");
+                bindings::ECONNRESET
+            }
+            SpdmErrorCode::ResponseTooLarge => {
+                pr_err!("Response too large\n");
+                bindings::EINVAL
+            }
+            SpdmErrorCode::RequestTooLarge => {
+                pr_err!("Request too large\n");
+                bindings::EINVAL
+            }
+            SpdmErrorCode::LargeResponse => {
+                pr_err!("Large response\n");
+                bindings::EMSGSIZE
+            }
+            SpdmErrorCode::MessageLost => {
+                pr_err!("Message lost\n");
+                bindings::EIO
+            }
+            SpdmErrorCode::InvalidPolicy => {
+                pr_err!("Invalid policy\n");
+                bindings::EINVAL
+            }
+            SpdmErrorCode::VersionMismatch => {
+                pr_err!("Version mismatch\n");
+                bindings::EINVAL
+            }
+            SpdmErrorCode::ResponseNotReady => {
+                pr_err!("Response not ready\n");
+                bindings::EINPROGRESS
+            }
+            SpdmErrorCode::RequestResynch => {
+                pr_err!("Request resynchronization\n");
+                bindings::ECONNRESET
+            }
+            SpdmErrorCode::OperationFailed => {
+                pr_err!("Operation failed\n");
+                bindings::EINVAL
+            }
+            SpdmErrorCode::NoPendingRequests => bindings::ENOENT,
+            SpdmErrorCode::VendorDefinedError => {
+                pr_err!("Vendor defined error\n");
+                bindings::EINVAL
+            }
+        };
+
+        to_result(-(ret as i32))
+    }
+
+    /// Start a SPDM exchange
+    ///
+    /// The data in `request_buf` is sent to the device and the response is
+    /// stored in `response_buf`.
+    pub(crate) fn spdm_exchange(
+        &self,
+        request_buf: &mut [u8],
+        response_buf: &mut [u8],
+    ) -> Result<i32, Error> {
+        let header_size = core::mem::size_of::<SpdmHeader>();
+        let request: &mut SpdmHeader = Untrusted::new_mut(request_buf).validate_mut()?;
+        let response: &SpdmHeader = Untrusted::new_ref(response_buf).validate()?;
+
+        let transport_function = self.transport.ok_or(EINVAL)?;
+        let length = unsafe {
+            transport_function(
+                self.transport_priv,
+                self.dev,
+                request_buf.as_ptr() as *const c_void,
+                request_buf.len(),
+                response_buf.as_mut_ptr() as *mut c_void,
+                response_buf.len(),
+            ) as i32
+        };
+        to_result(length)?;
+
+        if (length as usize) < header_size {
+            return Ok(length); /* Truncated response is handled by callers */
+        }
+        if response.code == SPDM_ERROR {
+            self.spdm_err(unsafe { &*(response_buf.as_ptr() as *const SpdmErrorRsp) })?;
+        }
+
+        if response.code != request.code & !SPDM_REQ {
+            pr_err!(
+                "Response code {:#x} does not match request code {:#x}\n",
+                response.code,
+                request.code
+            );
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        Ok(length)
+    }
+}
diff --git a/lib/rspdm/sysfs.rs b/lib/rspdm/sysfs.rs
new file mode 100644
index 000000000000..5deffdbf2b0c
--- /dev/null
+++ b/lib/rspdm/sysfs.rs
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! https://www.dmtf.org/dsp/DSP0274
+//!
+//! Rust sysfs helper functions
+//!
+//! Copyright (C) 2024 Western Digital
+
+use crate::SpdmState;
+use kernel::prelude::*;
+use kernel::{bindings, fmt, str::CString};
+
+/// Helper function for the sysfs `authenticated_show()`.
+#[no_mangle]
+pub unsafe extern "C" fn rust_authenticated_show(
+    spdm_state: *mut SpdmState,
+    buf: *mut core::ffi::c_char,
+) -> isize {
+    let state = unsafe { KBox::from_raw(spdm_state) };
+
+    let fmt = match CString::try_from_fmt(fmt!("{}\n", state.authenticated)) {
+        Ok(f) => f,
+        Err(_e) => return 0,
+    };
+
+    unsafe { bindings::sysfs_emit(buf, fmt.as_char_ptr()) as isize }
+}
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
new file mode 100644
index 000000000000..5004804f85c8
--- /dev/null
+++ b/lib/rspdm/validator.rs
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! https://www.dmtf.org/dsp/DSP0274
+//!
+//! Related structs and their Validate implementations.
+//!
+//! Copyright (C) 2024 Western Digital
+
+use crate::consts::SpdmErrorCode;
+use core::mem;
+use kernel::prelude::*;
+use kernel::{
+    error::{code::EINVAL, Error},
+    validate::{Unvalidated, Validate},
+};
+
+#[repr(C, packed)]
+pub(crate) struct SpdmHeader {
+    pub(crate) version: u8,
+    pub(crate) code: u8, /* RequestResponseCode */
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+}
+
+impl Validate<&Unvalidated<[u8]>> for &SpdmHeader {
+    type Err = Error;
+
+    fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw();
+        if raw.len() < mem::size_of::<SpdmHeader>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_ptr();
+        // CAST: `SpdmHeader` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<SpdmHeader>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        Ok(unsafe { &*ptr })
+    }
+}
+
+impl Validate<&mut Unvalidated<[u8]>> for &mut SpdmHeader {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<[u8]>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<SpdmHeader>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `SpdmHeader` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<SpdmHeader>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        Ok(unsafe { &mut *ptr })
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct SpdmErrorRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) error_code: SpdmErrorCode,
+    pub(crate) error_data: u8,
+}
-- 
2.47.0


