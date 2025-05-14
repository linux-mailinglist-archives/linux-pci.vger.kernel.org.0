Return-Path: <linux-pci+bounces-27709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB12AB6960
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 13:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF8D8C3000
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 10:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03F4278172;
	Wed, 14 May 2025 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrQIKYJM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D47276053;
	Wed, 14 May 2025 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220335; cv=none; b=lX1Qx/Ro5Ss5PTCHSxZuFonQ08FFXVRRpxzFg/BAw20xsc6wsycZ+XErNg01Uaq6qnz2yfGfTjon3NgYElYvntSeojpQD07XoBRUZvKgH98gGQYutkEQAQPy2tdm4L0j79//APR6f6wODUOrqmqd9C/HRyNxVYSJiopZrPXTjuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220335; c=relaxed/simple;
	bh=bDOrowS5NDCnhOqDvuFplAJW+UVvxHo3B+vHfABMAP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suwU0eV3hxOXxOIxwiMjgWyq0fPtKMwVTZ1sZBlbpUEkEKPzEmrYzoOvN3OoHpT1I8Dr/IiR7tlw3Ida5O2frush7o9pWtVLfKrN40DTvLIW7O+mkRb6F5h7rv8LJodh7Tj5S7bxJtYRxYnd83p5fiCKX1yXQF31SQPgNiRctnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrQIKYJM; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72c40235c34so1871294a34.3;
        Wed, 14 May 2025 03:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747220333; x=1747825133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qD5w6c0a6kvz0Ef85ipEl+D0Znk2XoV05BpXME7RAZc=;
        b=FrQIKYJMrfTtP/dxB3ZECMuHLMNKQWKfe8gzy1uN1qEbPirkfSxJ39237KQ8XLuptI
         NVLaci8dfX+LjFelEEYOOrM/e6WgCh/CYvmbCjuu6tXEqkMFNaYcdpW5cqMX1RQzKML3
         uphyQLRsg2HfaGrRtlei/EURIlN6d3W1R5+iTtVu0KE+rZlSPvVy5NR/GRxd2hVbS3dz
         +y9itwxhRqNzWSArcJ7pLSh5qHJ3EQ3TBG70T2FUkoyD6L3DNL5z3EaCRAbN+hM1rNho
         r8NFMFNTr4gxVmV3LnNPnCQMQ0reFPSEVsIURdDN2OjGqnWfSVrrTODeG1uVS5tKubeV
         WVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747220333; x=1747825133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qD5w6c0a6kvz0Ef85ipEl+D0Znk2XoV05BpXME7RAZc=;
        b=ESYS668TAYaUNO1e17LW9qjdsI6pnUS6qaANaiHiw/wFp0ci3w5sOxt88eNEYZ2WXT
         Ecb2ITLIbU/g163Rez3uKT/UzpuZ1+fJQhvbn5AgopPOg95mhalWfhljyGoeimezo1lf
         AgdRYEMBJ747pDy3Edi/2ppuzOUMPsyjsmOzFC2/7Qr9JtytnGIPwcomU/vzxFyNChI/
         VRcg5vx92Ze+fDQLduaIA3lgXWva2V+MDOf2RIxkUx2SEbDKjVBLzWnqj/cv8FeyO9EL
         Ndpe/bJuwA7JvK89emxC+kQ/7xYr33nu4/S9TdnvmwR/DZMKf7b2WAB9tFmzJQPNSHHc
         dNjw==
X-Forwarded-Encrypted: i=1; AJvYcCUpT4mUcXfksiDyhzD4W4bvFvgxQZKGc3bdMbyrQX2EYyshx8dw+myn9RKUWeQ+Gi1t2094AGP9fFFDTqs=@vger.kernel.org, AJvYcCUthJPjkYUOJhhBjVlPorcYXFd/8f4lvlNVo+AovQvquA+vFfpNo/55JIP85zpu7cwx2qVtoptQmUWxEYvXoDE=@vger.kernel.org, AJvYcCXGXcuu+4Q3+/qVFc5M9OOtAnceqXhdHfHXiVeplTg6ibBAw19bqA75+cZVA1cxehA+Si/rDjXsI7CD@vger.kernel.org
X-Gm-Message-State: AOJu0YxCGyiFnZuNoMG2I1x0hyYILaT72S34eDy0p6lDPcjoemrGgMJ1
	pVEEz5OIFl6voFSBoW/gK4QSG0qEmeTuuSvAFEYAZx/dkmAPeCYO
X-Gm-Gg: ASbGncu+7+j7J5GL98NRwky5i0sAX6e+KgjvO3ryWvFYS7KGN9lNOAtUo/4v4hXfsCZ
	msia5NvcE4MT50D2QT85JiR87+Xn0KoWTZSBSxA1SGF5vXgaAhVHh3x0JrVqoo+3bUNaCNjrYT4
	Udrpx/QDjoWmjv3PD10PJO363ueAVb+tdLNwc4rAF3TX0/tIOev4BhTEcu57zgSomVdQSHC/oRM
	nDsYFwgXZXfAS0hVzJKqVmk7WKgQnuHHON1J+Ey2dJb90WUCaw/qCzx4FtrXUNECmqJkc95EPxg
	8YrLmRmIeDrnXN6/f1SEKk/4AyrqJMmjU9kDq0kwicw5n+tJZTyk3pstlZbjXjr350jaRKZ5ut8
	tUKU4tAuiJOdWufyu4RFsCQz8wPrchZWXpA==
X-Google-Smtp-Source: AGHT+IE54MfSAuxodqlDuPCWb0IgGKv5g1H7LzyyZwbg9zyX4LOVBOAb43K73rSiK2QfFtlG75L38w==
X-Received: by 2002:a05:6830:368f:b0:727:345d:3b72 with SMTP id 46e09a7af769-734e144c500mr1437251a34.16.1747220332495;
        Wed, 14 May 2025 03:58:52 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2dba060be9esm2654535fac.10.2025.05.14.03.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 03:58:52 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	a.hindborg@kernel.org,
	airlied@gmail.com,
	akpm@linux-foundation.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	andrewjballance@gmail.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	daniel.almeida@collabora.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	kwilczynski@kernel.org,
	me@kloenk.dev,
	ojeda@kernel.org,
	raag.jadav@intel.com,
	rafael@kernel.org,
	simona@ffwll.ch,
	tmgross@umich.edu
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 6/6] rust: pci: make Bar generic over Io
Date: Wed, 14 May 2025 05:57:34 -0500
Message-ID: <20250514105734.3898411-7-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514105734.3898411-1-andrewjballance@gmail.com>
References: <20250514105734.3898411-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

renames `Bar` to `RawBar` and makes it generic over `IoAccess`.
a user can give a compile time suggestion when mapping a bar so
that the type of io can be known.

updates nova-core and rust_driver_pci to use new bar api.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 drivers/gpu/nova-core/driver.rs |   4 +-
 rust/kernel/pci.rs              | 101 +++++++++++++++++++++++++-------
 samples/rust/rust_driver_pci.rs |   2 +-
 3 files changed, 83 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index a08fb6599267..c03283d1e60e 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -11,7 +11,7 @@ pub(crate) struct NovaCore {
 }
 
 const BAR0_SIZE: usize = 8;
-pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;
+pub(crate) type Bar0 = pci::MMIoBar<BAR0_SIZE>;
 
 kernel::pci_device_table!(
     PCI_TABLE,
@@ -33,7 +33,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
         pdev.enable_device_mem()?;
         pdev.set_master();
 
-        let bar = pdev.iomap_region_sized::<BAR0_SIZE>(0, c_str!("nova-core/bar0"))?;
+        let bar = pdev.iomap_region_sized_mmio::<BAR0_SIZE>(0, c_str!("nova-core/bar0"))?;
 
         let this = KBox::pin_init(
             try_pin_init!(Self {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 9f5ca22d327a..42fbe597b06e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -11,8 +11,7 @@
     devres::Devres,
     driver,
     error::{to_result, Result},
-    io::Io,
-    io::IoRaw,
+    io::{Io, IoAccess, IoRaw, MMIo},
     str::CStr,
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
@@ -259,15 +258,21 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
 ///
 /// # Invariants
 ///
-/// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
+/// `Bar` always holds an `I` inststance that holds a valid pointer to the start of the I/O
 /// memory mapped PCI bar and its size.
-pub struct Bar<const SIZE: usize = 0> {
+pub struct RawBar<const SIZE: usize = 0, I: IoAccess<SIZE> = Io<SIZE>> {
     pdev: ARef<Device>,
-    io: IoRaw<SIZE>,
+    io: I,
     num: i32,
 }
 
-impl<const SIZE: usize> Bar<SIZE> {
+/// a pci bar that can be either PortIo or MMIo
+pub type IoBar<const SIZE: usize = 0> = RawBar<SIZE, Io<SIZE>>;
+
+/// a pci bar that maps a [`MMIo`].
+pub type MMIoBar<const SIZE: usize = 0> = RawBar<SIZE, MMIo<SIZE>>;
+
+impl<const SIZE: usize, I: IoAccess<SIZE>> RawBar<SIZE, I> {
     fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
         let len = pdev.resource_len(num)?;
         if len == 0 {
@@ -299,7 +304,7 @@ fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = match IoRaw::new(ioptr, len as usize) {
+        let raw = match IoRaw::new(ioptr, len as usize) {
             Ok(io) => io,
             Err(err) => {
                 // SAFETY:
@@ -311,7 +316,22 @@ fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
             }
         };
 
-        Ok(Bar {
+        // SAFETY:
+        // - `raw` is from `pci_iomap`
+        // - addresses from `pci_iomap` should be accesed through ioread/iowrite
+        let io = match unsafe { I::from_raw_cookie(raw) } {
+            Ok(io) => io,
+            Err(err) => {
+                // SAFETY:
+                // `pdev` is valid by the invariants of `Device`.
+                // `ioptr` is guaranteed to be the start of a valid I/O mapped memory region.
+                // `num` is checked for validity by a previous call to `Device::resource_len`.
+                unsafe { Self::do_release(pdev, ioptr, num) };
+                return Err(err);
+            }
+        };
+
+        Ok(RawBar {
             pdev: pdev.into(),
             io,
             num,
@@ -338,25 +358,24 @@ fn release(&self) {
     }
 }
 
-impl Bar {
+impl RawBar {
     fn index_is_valid(index: u32) -> bool {
         // A `struct pci_dev` owns an array of resources with at most `PCI_NUM_RESOURCES` entries.
         index < bindings::PCI_NUM_RESOURCES
     }
 }
 
-impl<const SIZE: usize> Drop for Bar<SIZE> {
+impl<const SIZE: usize, I: IoAccess<SIZE>> Drop for RawBar<SIZE, I> {
     fn drop(&mut self) {
         self.release();
     }
 }
 
-impl<const SIZE: usize> Deref for Bar<SIZE> {
-    type Target = Io<SIZE>;
+impl<const SIZE: usize, I: IoAccess<SIZE>> Deref for RawBar<SIZE, I> {
+    type Target = I;
 
     fn deref(&self) -> &Self::Target {
-        // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
-        unsafe { Io::from_raw_ref(&self.io) }
+        &self.io
     }
 }
 
@@ -379,7 +398,7 @@ pub fn device_id(&self) -> u16 {
 
     /// Returns the size of the given PCI bar resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
-        if !Bar::index_is_valid(bar) {
+        if !RawBar::index_is_valid(bar) {
             return Err(EINVAL);
         }
 
@@ -389,22 +408,62 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
     }
 
-    /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
+    /// Maps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
     /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
     pub fn iomap_region_sized<const SIZE: usize>(
         &self,
         bar: u32,
         name: &CStr,
-    ) -> Result<Devres<Bar<SIZE>>> {
-        let bar = Bar::<SIZE>::new(self, bar, name)?;
+    ) -> Result<Devres<IoBar<SIZE>>> {
+        self.iomap_region_sized_hint::<SIZE, Io<SIZE>>(bar, name)
+    }
+
+    /// Maps an entire PCI-BAR after performing a region-request on it.
+    pub fn iomap_region(&self, bar: u32, name: &CStr) -> Result<Devres<IoBar>> {
+        self.iomap_region_sized::<0>(bar, name)
+    }
+
+    /// Maps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
+    /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
+    /// where it is known that the bar is [`MMIo`]
+    pub fn iomap_region_sized_mmio<const SIZE: usize>(
+        &self,
+        bar: u32,
+        name: &CStr,
+    ) -> Result<Devres<MMIoBar<SIZE>>> {
+        self.iomap_region_sized_hint::<SIZE, MMIo<SIZE>>(bar, name)
+    }
+
+    /// Maps an entire PCI-BAR after performing a region-request on it.
+    /// where it is known that the bar is [`MMIo`]
+    pub fn iomap_region_mmio(&self, bar: u32, name: &CStr) -> Result<Devres<MMIoBar>> {
+        self.iomap_region_sized_hint::<0, MMIo<0>>(bar, name)
+    }
+
+    /// Maps an entire PCI-BAR after performing a region-request where the
+    /// type of Io backend is known at compile time.
+    pub fn iomap_region_hint<I: IoAccess>(
+        &self,
+        bar: u32,
+        name: &CStr,
+    ) -> Result<Devres<RawBar<0, I>>> {
+        let bar = RawBar::<0, I>::new(self, bar, name)?;
         let devres = Devres::new(self.as_ref(), bar, GFP_KERNEL)?;
 
         Ok(devres)
     }
+    /// Maps an entire PCI-BAR after performing a region-request where the
+    /// type of Io backend is known at compile time. I/O operation bound checks
+    /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
+    pub fn iomap_region_sized_hint<const SIZE: usize, I: IoAccess<SIZE>>(
+        &self,
+        bar: u32,
+        name: &CStr,
+    ) -> Result<Devres<RawBar<SIZE, I>>> {
+        let bar = RawBar::<SIZE, I>::new(self, bar, name)?;
+        let devres = Devres::new(self.as_ref(), bar, GFP_KERNEL)?;
 
-    /// Mapps an entire PCI-BAR after performing a region-request on it.
-    pub fn iomap_region(&self, bar: u32, name: &CStr) -> Result<Devres<Bar>> {
-        self.iomap_region_sized::<0>(bar, name)
+        Ok(devres)
     }
 }
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index a8d292f4c1b3..b645155142db 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -18,7 +18,7 @@ impl Regs {
     const END: usize = 0x10;
 }
 
-type Bar0 = pci::Bar<{ Regs::END }>;
+type Bar0 = pci::IoBar<{ Regs::END }>;
 
 #[derive(Debug)]
 struct TestIndex(u8);
-- 
2.49.0


