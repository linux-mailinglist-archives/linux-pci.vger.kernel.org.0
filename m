Return-Path: <linux-pci+bounces-22491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AEEA4735F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11583188F319
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C501917FB;
	Thu, 27 Feb 2025 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="A9YeWCPc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u7F88Yw6"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59A1624C3;
	Thu, 27 Feb 2025 03:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625845; cv=none; b=YT2zh7S45bQKUA/qgeuVq985s3XftE6ztpl1aNB309dl9WdFRwFShT0ASU6l871gNmsyXFpj2WSP1zoyqt7vTrhD7pv2/Fr7XciE2szLAQIvkEGWrxHzR1+S+7Rw/7JdskWIvlRCHkEm6GHsmIq+2FkT12qjY8UB05Er1cg3dTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625845; c=relaxed/simple;
	bh=Xb33wqwBjwnYEgWkSPmtSotdhdph4BsAyiHxX6eiz4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsVWjmGVYdXOVHIJSZmRe+jKjBoZQAeGqWjVoCW2c7OX8f61GmMiFhK4FINohSGLCwwz1HPRC2REywWIakGMUuHWAQYzEGwsLJOuaWd/EtS1wTGfEuzijIGUfuO20qILFIy45mxYR5kR+km7pvXs6t+7nVeJKsRpiQH7gYOCUs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=A9YeWCPc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u7F88Yw6; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C5AE51140197;
	Wed, 26 Feb 2025 22:10:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 26 Feb 2025 22:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625841; x=
	1740712241; bh=QHYYanU9/fikbjXjGNrAJCVcxaYxU/vjJtAiwtzylc4=; b=A
	9YeWCPcpCiauLDcDgRmoRyi+N9f2KQzAixF1P1DF6kUpwLRbOC/H7tG/YskoySCB
	fGmR6guMR+KamdGPWj7yw6+Pam9AMs6p+nCRdT+XfjiC0cYVdhFBXpVAZe/xX5s7
	CpbJ4IYC8W/xhU2Mx+7XbQ4LucASMZWYhAZ+dQ8dGs95NvVUmAd2YaaFvpOhUwlO
	mMCExpoi/Op3mRbW4JaeHUwfuWmPn2OHoLmf+ErgBIFe6pRsJtsLUsFh9jUZ3voS
	D5+TGfFrMoZJKQxS3UJZWpieooGSHdbv54Hwrg3cg96740RIoio5O4ASYgMR5mBl
	KSvojL5zF6vnusJHbf2Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625841; x=1740712241; bh=Q
	HYYanU9/fikbjXjGNrAJCVcxaYxU/vjJtAiwtzylc4=; b=u7F88Yw63uZVFQWBz
	bPejD0zdEEvss3f1f+3Geo7rzO6xGRBu7TQ+FE6D6JJfM5Ng41ZQuEVXdc/6ejS0
	ELJ7G1IRpNiypHoMgd/bY7HTSsJy3knkJXHHhjo+VAAVFm+ZvUAn4cILAZy0WlQf
	LJ6nSqoCUnFaNXjloYCGrlZCJILzE7AlKNbWQTJ1bKyKM1WG05+j2KT9qNopPbMg
	bzjUQak+a6g4orSzPMXGVLW1S5/oTlQtBxMO/s+q8wZGtYJqh4C9eXmDyWb7uf6Q
	TtipiSIPJkxHhghgJ301F6IA3AtRJQHyLmRl1Q6IiobUet2UiMidCyfa8efEoEOO
	msSXA==
X-ME-Sender: <xms:sde_Z3dS_6Wk8xPMDNnxI305PcEMuERgXKHLCSl1EH-EzQjmlj2R2A>
    <xme:sde_Z9Mid5EmAcJTVMuiUgeXXW5MWWhssFp-OHWjOUqgCiHoJosJCDUVvhUjqDaPJ
    xW8LhBT6UA--aaPbMU>
X-ME-Received: <xmr:sde_Zwi-5wTe2KCj9h5oaPDknJG-4JBcL9yfIvOGE9-JyKlwZonNm1yJVxlOf5gfjtt_99STFm4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeevfefhudefheehgfetheeu
    feeuteefheejtdekvdeugfdvtdevieefjeeklefgveenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgpdgumhhtfhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnh
    gspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhn
    uhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgr
    shesfihunhhnvghrrdguvgdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtoh
    hmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:sde_Z4-Fqq-CB8DpLt4jG24uh5J_mdteY9VhNKIV1D5RffLMyOxPTw>
    <xmx:sde_ZzscsV3BXx8lf-XEcnKtp6URN262mCxgLHvD6lCu6Oi7LzMpYQ>
    <xmx:sde_Z3GjELUp3qFrM6e-heoIWNPTiHZhAHv5ZAuPYkCQnw6inegvMg>
    <xmx:sde_Z6Outicx_oj6bf5Z_c5vgn6p6izHcMV5xYwESCCnK_hFyczSqQ>
    <xmx:sde_Z8PHU9OExXrERSCoHpaVuUR8SX5Kkv9PhAJvls2iao7QvY9_wSko>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:10:34 -0500 (EST)
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
Subject: [RFC v2 05/20] lib: rspdm: Initial commit of Rust SPDM
Date: Thu, 27 Feb 2025 13:09:37 +1000
Message-ID: <20250227030952.2319050-6-alistair@alistair23.me>
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

This is the initial commit of the Rust SPDM library. It is based on and
compatible with the C SPDM library in the kernel (lib/spdm).

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 MAINTAINERS                     |  12 ++
 include/linux/spdm.h            |  39 ++++++
 lib/Kconfig                     |  16 +++
 lib/Makefile                    |   2 +
 lib/rspdm/Makefile              |  10 ++
 lib/rspdm/consts.rs             |  39 ++++++
 lib/rspdm/lib.rs                | 119 +++++++++++++++++
 lib/rspdm/state.rs              | 225 ++++++++++++++++++++++++++++++++
 lib/rspdm/validator.rs          |  66 ++++++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/error.rs            |   3 +
 11 files changed, 533 insertions(+)
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/rspdm/Makefile
 create mode 100644 lib/rspdm/consts.rs
 create mode 100644 lib/rspdm/lib.rs
 create mode 100644 lib/rspdm/state.rs
 create mode 100644 lib/rspdm/validator.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b0cc181db74..0f37dbdcfd77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21376,6 +21376,18 @@ M:	Security Officers <security@kernel.org>
 S:	Supported
 F:	Documentation/process/security-bugs.rst
 
+SECURITY PROTOCOL AND DATA MODEL (SPDM)
+M:	Jonathan Cameron <jic23@kernel.org>
+M:	Lukas Wunner <lukas@wunner.de>
+M:	Alistair Francis <alistair@alistair23.me>
+L:	linux-coco@lists.linux.dev
+L:	linux-cxl@vger.kernel.org
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
+F:	include/linux/spdm.h
+F:	lib/rspdm/
+
 SECURITY SUBSYSTEM
 M:	Paul Moore <paul@paul-moore.com>
 M:	James Morris <jmorris@namei.org>
diff --git a/include/linux/spdm.h b/include/linux/spdm.h
new file mode 100644
index 000000000000..9835a3202a0e
--- /dev/null
+++ b/include/linux/spdm.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DMTF Security Protocol and Data Model (SPDM)
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Copyright (C) 2021-22 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022-24 Intel Corporation
+ */
+
+#ifndef _SPDM_H_
+#define _SPDM_H_
+
+#include <linux/types.h>
+
+struct key;
+struct device;
+struct spdm_state;
+struct x509_certificate;
+
+typedef ssize_t (spdm_transport)(void *priv, struct device *dev,
+				 const void *request, size_t request_sz,
+				 void *response, size_t response_sz);
+
+typedef int (spdm_validate)(struct device *dev, u8 slot,
+			    struct x509_certificate *leaf_cert);
+
+struct spdm_state *spdm_create(struct device *dev, spdm_transport *transport,
+			       void *transport_priv, u32 transport_sz,
+			       struct key *keyring, spdm_validate *validate);
+
+int spdm_authenticate(struct spdm_state *spdm_state);
+
+void spdm_destroy(struct spdm_state *spdm_state);
+
+extern const struct attribute_group spdm_attr_group;
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index dccb61b7d698..df9c96a440c5 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -714,6 +714,22 @@ config LWQ_TEST
 	help
           Run boot-time test of light-weight queuing.
 
+config RSPDM
+	bool "Rust SPDM"
+	select CRYPTO
+	select KEYS
+	select ASYMMETRIC_KEY_TYPE
+	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select X509_CERTIFICATE_PARSER
+	help
+	  The Rust implementation of the Security Protocol and Data Model (SPDM)
+	  allows for device authentication, measurement, key exchange and
+	  encrypted sessions.
+
+	  Crypto algorithms negotiated with SPDM are limited to those enabled
+	  in .config.  Users of SPDM therefore need to also select
+	  any algorithms they deem mandatory.
+
 endmenu
 
 config GENERIC_IOREMAP
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7afbbb8..09e1cfe413ef 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -303,6 +303,8 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
 obj-$(CONFIG_ASN1) += asn1_decoder.o
 obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
 
+obj-$(CONFIG_RSPDM) += rspdm/
+
 obj-$(CONFIG_FONT_SUPPORT) += fonts/
 
 hostprogs	:= gen_crc32table
diff --git a/lib/rspdm/Makefile b/lib/rspdm/Makefile
new file mode 100644
index 000000000000..1f62ee2a882d
--- /dev/null
+++ b/lib/rspdm/Makefile
@@ -0,0 +1,10 @@
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
diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
new file mode 100644
index 000000000000..311e34c7fae7
--- /dev/null
+++ b/lib/rspdm/consts.rs
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Western Digital
+
+//! Constants used by the library
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
+
+pub(crate) const SPDM_REQ: u8 = 0x80;
+pub(crate) const SPDM_ERROR: u8 = 0x7f;
+
+#[expect(dead_code)]
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
index 000000000000..2bb716140e0a
--- /dev/null
+++ b/lib/rspdm/lib.rs
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Western Digital
+
+//! Top level library for SPDM
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
+//!
+//! Top level library, including C compatible public functions to be called
+//! from other subsytems.
+//!
+//! This mimics the C SPDM implementation in the kernel
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
+mod validator;
+
+/// spdm_create() - Allocate SPDM session
+///
+/// `dev`: Responder device
+/// `transport`: Transport function to perform one message exchange
+/// `transport_priv`: Transport private data
+/// `transport_sz`: Maximum message size the transport is capable of (in bytes)
+/// `keyring`: Trusted root certificates
+/// `validate`: Function to validate additional leaf certificate requirements
+///  (optional, may be %NULL)
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
+/// spdm_destroy() - Destroy SPDM session
+///
+/// @spdm_state: SPDM session state
+#[no_mangle]
+pub unsafe extern "C" fn spdm_destroy(_state: &'static mut SpdmState) {}
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
new file mode 100644
index 000000000000..9ebd87603454
--- /dev/null
+++ b/lib/rspdm/state.rs
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Western Digital
+
+//! The `SpdmState` struct and implementation.
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
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
+/// `dev`: Responder device.  Used for error reporting and passed to @transport.
+/// `transport`: Transport function to perform one message exchange.
+/// `transport_priv`: Transport private data.
+/// `transport_sz`: Maximum message size the transport is capable of (in bytes).
+///  Used as DataTransferSize in GET_CAPABILITIES exchange.
+/// `keyring`: Keyring against which to check the first certificate in
+///  responder's certificate chain.
+/// `validate`: Function to validate additional leaf certificate requirements.
+///
+/// `version`: Maximum common supported version of requester and responder.
+///  Negotiated during GET_VERSION exchange.
+///
+/// `authenticated`: Whether device was authenticated successfully.
+#[expect(dead_code)]
+pub struct SpdmState {
+    pub(crate) dev: *mut bindings::device,
+    pub(crate) transport: bindings::spdm_transport,
+    pub(crate) transport_priv: *mut c_void,
+    pub(crate) transport_sz: u32,
+    pub(crate) keyring: *mut bindings::key,
+    pub(crate) validate: bindings::spdm_validate,
+
+    // Negotiated state
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
+        match rsp.error_code {
+            SpdmErrorCode::InvalidRequest => {
+                pr_err!("Invalid request\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::InvalidSession => {
+                if rsp.version == 0x11 {
+                    pr_err!("Invalid session {:#x}\n", rsp.error_data);
+                    Err(EINVAL)
+                } else {
+                    pr_err!("Undefined error {:#x}\n", rsp.error_code as u8);
+                    Err(EINVAL)
+                }
+            }
+            SpdmErrorCode::Busy => {
+                pr_err!("Busy\n");
+                Err(EBUSY)
+            }
+            SpdmErrorCode::UnexpectedRequest => {
+                pr_err!("Unexpected request\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::Unspecified => {
+                pr_err!("Unspecified error\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::DecryptError => {
+                pr_err!("Decrypt error\n");
+                Err(EIO)
+            }
+            SpdmErrorCode::UnsupportedRequest => {
+                pr_err!("Unsupported request {:#x}\n", rsp.error_data);
+                Err(EINVAL)
+            }
+            SpdmErrorCode::RequestInFlight => {
+                pr_err!("Request in flight\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::InvalidResponseCode => {
+                pr_err!("Invalid response code\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::SessionLimitExceeded => {
+                pr_err!("Session limit exceeded\n");
+                Err(EBUSY)
+            }
+            SpdmErrorCode::SessionRequired => {
+                pr_err!("Session required\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::ResetRequired => {
+                pr_err!("Reset required\n");
+                Err(ECONNRESET)
+            }
+            SpdmErrorCode::ResponseTooLarge => {
+                pr_err!("Response too large\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::RequestTooLarge => {
+                pr_err!("Request too large\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::LargeResponse => {
+                pr_err!("Large response\n");
+                Err(EMSGSIZE)
+            }
+            SpdmErrorCode::MessageLost => {
+                pr_err!("Message lost\n");
+                Err(EIO)
+            }
+            SpdmErrorCode::InvalidPolicy => {
+                pr_err!("Invalid policy\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::VersionMismatch => {
+                pr_err!("Version mismatch\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::ResponseNotReady => {
+                pr_err!("Response not ready\n");
+                Err(EINPROGRESS)
+            }
+            SpdmErrorCode::RequestResynch => {
+                pr_err!("Request resynchronization\n");
+                Err(ECONNRESET)
+            }
+            SpdmErrorCode::OperationFailed => {
+                pr_err!("Operation failed\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::NoPendingRequests => Err(ENOENT),
+            SpdmErrorCode::VendorDefinedError => {
+                pr_err!("Vendor defined error\n");
+                Err(EINVAL)
+            }
+        }
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
+        // SAFETY: `transport_function` is provided by the new(), we are
+        // calling the function.
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
+            return Ok(length); // Truncated response is handled by callers
+        }
+        if response.code == SPDM_ERROR {
+            if length as usize >= core::mem::size_of::<SpdmErrorRsp>() {
+                // SAFETY: The response buffer will be at at least as large as
+                // `SpdmErrorRsp` so we can cast the buffer to `SpdmErrorRsp` which
+                // is a packed struct.
+                self.spdm_err(unsafe { &*(response_buf.as_ptr() as *const SpdmErrorRsp) })?;
+            } else {
+                return Err(EINVAL);
+            }
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
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
new file mode 100644
index 000000000000..a0a3a2f46952
--- /dev/null
+++ b/lib/rspdm/validator.rs
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Western Digital
+
+//! Related structs and their Validate implementations.
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
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
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index f46cf3bb7069..42aa62f0c8f5 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -33,6 +33,8 @@
 #include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/tracepoint.h>
+#include <linux/spdm.h>
+#include <linux/uaccess.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <trace/events/rust_sample.h>
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index f6ecf09cb65f..8ee8674ec485 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -83,6 +83,9 @@ macro_rules! declare_err {
     declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.");
     declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
     declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
+    declare_err!(ECONNRESET, "Connection reset by peer.");
+    declare_err!(EMSGSIZE, "Message too long.");
+    declare_err!(EINPROGRESS, "Operation now in progress.");
 }
 
 /// Generic integer kernel error.
-- 
2.48.1


