Return-Path: <linux-pci+bounces-27481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8385FAB08B8
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58774C3E67
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 03:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F126D244672;
	Fri,  9 May 2025 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLknOyYy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEB524466B;
	Fri,  9 May 2025 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760611; cv=none; b=oI3YsBytbyevaE7VA0g/7b/S7EPHWpVxZFPQgcO1vetYPyL1rs6K5wLGUwyBCq76AII8AT3okUcgb1PNreEg/R8pT+d+PlviQdpTUZEwUYi3bcxdyGUaToc75rjVheT5MwnL/ZbKkYuZG3xrX7PODbmUrHivK5Z/7UmUnHWq3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760611; c=relaxed/simple;
	bh=o4AcQyGp5L/I+jB6OWdk8yCIGZDZ8lPUVOmSTSO+ras=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYUFxxHj2xI47oeJCJDsOHXfRXjniGeswVv2IgiDlnLUqCFo84BznVvo9cotal6pudlMFnp+9jmpuY6ESwJVhpfg4AyqMtqcP34be1ZiUCBzVwPIClHJqd3CH4IUNWotrz0KJyWEVEI5A1H1tQfWo6Ow3x0xiG6e2qoBFLSVxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLknOyYy; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-605fda00c30so729573eaf.1;
        Thu, 08 May 2025 20:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746760609; x=1747365409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbkkJzcTB85B47ipbpD9VdSKYv1GM7nCZHJmyoTnoXo=;
        b=gLknOyYy8O4YcrdBkydskPx0WcqrXBEuFx5VtxPzvEPNbBp5gD8eAK+d7YB47itf/q
         1ns/iyMEM6uh4GgBPFEUUg11VrY8UbbECCdFxLqTiPZT/ocO2mptLLvXmb4wQGE8dns+
         /bo2nAJHRbEU3NFkv520CsFxKp+K/YDSjG1V+K10B9PSHQDoFOuqIeRhIJOv48vxdnYn
         n9YHPMnbsJgT1Kum6YVIAiHN5rvyIPRhGpjJ8eeSSwb8QHEmgWH8VNY7ODoBlPFXlWga
         0tviLTtTQvpjB/AI6LmTr/ITy5GCQa8SvFCoTJeJySUz4jkk3ZxWA8iHNhHvKKB/hZen
         r+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746760609; x=1747365409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbkkJzcTB85B47ipbpD9VdSKYv1GM7nCZHJmyoTnoXo=;
        b=HdCs+OeV2fYoqGOGeps7PORoyGoZ2hLcm3MW4ZOTubOrVvfuJ0hxyUmetP4knlpO0A
         VSAtliiPxaH/owsV66nSrdjPGI2AhN9bUTnVqGp+9sST0KiJUGL0edHvqs0alsJ+2NSk
         VEvnLQfEbz8hEt+Y3v+OLgvnyYjrXXixP/vNBYOaum713GW4lVxv6eXyS7i567F/w6ru
         GoftzIQ7GutVdTWOiI14MUn/pEpj7+Rzifhk3ZXIolXTb1gvmwX3qcPyJT1hjm/uTirx
         /JsbMYV2dYGDZzyCg0fFMvcQLkHejLgkezvZlBwZa7eLIxC/h3RLEXH2T9s0OjkAYTO3
         oiAg==
X-Forwarded-Encrypted: i=1; AJvYcCU3bsv8qQsFo/Z0KgEcH3MwTIjndgSaEna1TacKxfLz0gLcgepXc2LkuqMgovEZsgKuj8JGiPQJ/bbHeosTVNY=@vger.kernel.org, AJvYcCUVN4izGcnmXB/1MD4bxkkrdcLb+Jdea465TX6wU6EwxdbsPjm6PrmEESuFYP4lI+ZEbS/ld3F56WkN97g=@vger.kernel.org, AJvYcCVfAvHqYm2ZHSWOxLdVe9BF1k4oluhYh2YISfh38vHt6TXH/L5csKJalxARGCadRpD3ZwXciWTdQP+X@vger.kernel.org
X-Gm-Message-State: AOJu0YwvlsMUAs320ISA6MF9eCTu+bTd2WdT/Ipje2gDWheL+zd2KFWC
	/qm82y2JcuGLaZuGhidVFEXcUDlaOQLqWdsZkFgOPo7Q/laN2flX
X-Gm-Gg: ASbGncsG9iaPxwD5wt36ma7syZQq00lAmy499TINkNiwFU6BPVklvcqVSpq/4miVU6/
	cWZZFQkRanQ2nR/jjBqJHMTAcjHFr4JdjJM+/LToXkFg3v9/T/XhvSF0Cx1jHC5GcPDbIUbfeyK
	saZoRoCXRKkGIwQ72GOXaQ6H641Gbdw84is0Lx5WkUbZosZ9CbpBevjknX3keZuu1MeRiBkAlGj
	o25X9RUyGScXRqJ9OmgTRYPs0sC2VNJFdlF5Td1KvSntmyo1r6xlJ/ovf7FZ56UpgqOOfFzqF2P
	GhFQNOaHV+fN1eR/VxVO5LilmENeUC8BTP2xKoc5sgxk8UeKDWMXCVmlvhYmxtg49/Bhz047b0Y
	b6pVbop+dKjnw
X-Google-Smtp-Source: AGHT+IGNqzdeadesIZwP1nYllqucukQIsSdIN+MQ3j6qsOcvk9hRsdNngAFQNCc+hQwb1HZg7HwUpQ==
X-Received: by 2002:a05:6820:983:b0:604:ae66:1e9b with SMTP id 006d021491bc7-6084c118041mr1122514eaf.8.1746760609172;
        Thu, 08 May 2025 20:16:49 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60842b096desm303745eaf.30.2025.05.08.20.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 20:16:48 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	akpm@linux-foundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	raag.jadav@intel.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	me@kloenk.dev,
	andrewjballance@gmail.com,
	fujita.tomonori@gmail.com,
	daniel.almeida@collabora.com
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 07/11] rust: io: add from_raw_cookie functions
Date: Thu,  8 May 2025 22:15:20 -0500
Message-ID: <20250509031524.2604087-8-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509031524.2604087-1-andrewjballance@gmail.com>
References: <20250509031524.2604087-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adds a `from_raw_cookie` function to the IoAccess trait.

`from_raw_cookie` attempts to convert a iomem address that can be
accessed by the ioread/iowrite family of C functions into either
a `Io`, `PortIo` or `MMIo`.

This is done so that devices that know what type of Io they are at
compile time can give a hint about their type.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/kernel/io.rs | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 3d8b6e731ce7..30892f2909a6 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -6,6 +6,62 @@
 
 use crate::error::{code::EINVAL, Result};
 use crate::{bindings, build_assert};
+use io_backend::*;
+
+/// `io_backend` is private and implements the config specific logic for
+/// `IoAccess::from_raw_cookie`.
+#[cfg(CONFIG_GENERIC_IOMAP)]
+mod io_backend {
+    // if generic_iomap is enabled copy the logic from IO_COND in `lib/iomap.c`
+
+    #[inline]
+    pub(super) fn is_mmio(addr: usize) -> bool {
+        addr >= bindings::PIO_RESERVED as usize
+    }
+
+    #[inline]
+    pub(super) fn is_portio(addr: usize) -> bool {
+        !is_mmio(addr) && addr > bindings::PIO_OFFSET as usize
+    }
+
+    #[inline]
+    pub(super) fn cookie_to_pio(addr: usize) -> usize {
+        addr & bindings::PIO_MASK as usize
+    }
+
+    #[inline]
+    pub(super) fn cookie_to_mmio(cookie: usize) -> usize {
+        cookie
+    }
+}
+#[cfg(not(CONFIG_GENERIC_IOMAP))]
+mod io_backend {
+    // for everyone who does not use generic iomap
+    // except for alpha and parisc, neither of which has a rust compiler,
+    // ioread/iowrite is defined in `include/asm-generic/io.h`.
+    //
+    // for these ioread/iowrite, maps to read/write.
+    // so allow any io to be converted  because they use the same backend
+    #[inline]
+    pub(super) fn is_mmio(_addr: usize) -> bool {
+        true
+    }
+
+    #[inline]
+    pub(super) fn is_portio(_addr: usize) -> bool {
+        false
+    }
+
+    #[inline]
+    pub(super) fn cookie_to_pio(cookie: usize) -> usize {
+        cookie
+    }
+
+    #[inline]
+    pub(super) fn cookie_to_mmio(cookie: usize) -> usize {
+        cookie
+    }
+}
 
 /// Private macro to define the [`IoAccess`] functions.
 macro_rules! define_io_access_function {
@@ -160,8 +216,18 @@ pub unsafe trait IoAccess<const SIZE: usize = 0> {
     fn maxsize(&self) -> usize;
 
     /// Returns the base address of the accessed IO area.
+    /// if `self` was created by ['from_raw_cookie'], `addr` might not be equal to the original
+    /// address.
     fn addr(&self) -> usize;
 
+    /// Attempts to create a `Self` from a [`IoRaw`].
+    ///
+    /// # Safety
+    /// `raw` should be a io cookie that can be accessed by the C `ioread`/`iowrite` functions
+    unsafe fn from_raw_cookie(raw: IoRaw<SIZE>) -> Result<Self>
+    where
+        Self: Sized;
+
     define_io_access_function!(@read
         read8_unchecked, read8, try_read8, u8;
         read16_unchecked, read16, try_read16, u16;
@@ -367,6 +433,19 @@ fn addr(&self) -> usize {
         self.0.addr()
     }
 
+    unsafe fn from_raw_cookie(mut raw: IoRaw<SIZE>) -> Result<Self>
+    where
+        Self: Sized,
+    {
+        if is_mmio(raw.addr()) {
+            // INVARIANT: `addr` is decoded so it should be ok to access with read/write
+            raw.addr = cookie_to_mmio(raw.addr());
+            Ok(Self(raw))
+        } else {
+            Err(EINVAL)
+        }
+    }
+
     impl_accessor_fn!(
         read8_unchecked, readb, write8_unchecked, writeb, u8;
         read16_unchecked, readw, write16_unchecked, writew, u16;
@@ -476,6 +555,19 @@ fn addr(&self) -> usize {
         self.0.addr()
     }
 
+    unsafe fn from_raw_cookie(mut raw: IoRaw<SIZE>) -> Result<Self>
+    where
+        Self: Sized,
+    {
+        if is_portio(raw.addr()) {
+            // INVARIANT: `addr` is decoded so it should be ok to access with in/out
+            raw.addr = cookie_to_pio(raw.addr());
+            Ok(Self(raw))
+        } else {
+            Err(EINVAL)
+        }
+    }
+
     #[rustfmt::skip]
     impl_accessor_fn!(
         read8_unchecked, inb, write8_unchecked, outb, u8;
@@ -563,6 +655,18 @@ fn maxsize(&self) -> usize {
         self.0.maxsize()
     }
 
+    unsafe fn from_raw_cookie(raw: IoRaw<SIZE>) -> Result<Self>
+    where
+        Self: Sized,
+    {
+        if is_mmio(raw.addr()) || is_portio(raw.addr()) {
+            // INVARIANT: `addr` is not touched so it should be able to be read with ioread/iowrite
+            Ok(Self(raw))
+        } else {
+            Err(EINVAL)
+        }
+    }
+
     impl_accessor_fn!(
         read8_unchecked, ioread8, write8_unchecked, iowrite8, u8;
         read16_unchecked, ioread16, write16_unchecked, iowrite16, u16;
-- 
2.49.0


