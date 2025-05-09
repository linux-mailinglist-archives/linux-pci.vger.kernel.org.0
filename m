Return-Path: <linux-pci+bounces-27482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D613DAB08C2
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4226A00A43
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 03:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9A223FC49;
	Fri,  9 May 2025 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly+5CCqf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F9D23F434;
	Fri,  9 May 2025 03:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760618; cv=none; b=bxUXPw5++/F9olrUcxKJ2HMLYuXTEh6H3QeHme4o7Kgtoz8PZ3OFvZiPbzGnLWD4CLjc3gpsKV7Vn1lw19ICdehMmrCTq9oiZBCyj+MX1zxRbO2SreUvNPM25k/hB1zthe4tAbV2rAmumkLsPUC1nNzM8kTHgz+hbGJ9wi9Y2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760618; c=relaxed/simple;
	bh=hPm3Ua3ptsr9xZyEqRt+rlIsMlSrZTHnbYPG3hbNvG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tykeuCY3GmlpLZanmRjJDG4PdaT/xjFX5JLoO0ilWmi51HRU6CkjF5sZBa/BpuqY1+sz9inI+4uqOWbF4BXTgb42oR3g5mLeSCDLrjOXqLvrKZgg06dtXXi/80Fobnih5xV9T03dDBSXJVDTBkJiHW2IPzx1vG5nPxrEzEVou7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ly+5CCqf; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6060167af73so988407eaf.2;
        Thu, 08 May 2025 20:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746760615; x=1747365415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xc7BzZfYEb+VFNTMq0je73w2/39IbT5bTX8c0mAg458=;
        b=Ly+5CCqfjdbC2WxVcvjR1avGEQlRZklX8BUMQKH9s/t3S07rbFzKFsO9OTWVaI2mC7
         2eI0o+hoAEkQeNvQ74GQzMZla2BtA6nFL69Wk08T2IclVgmMzfyvdcZ61cAIdodZxlZ5
         dpil059fewlh48k5ZXecqReAHTAMOh1o2LXN1hHrXqYjV9ezDJXF5sV4niUYB0+z9AP7
         HS7kixZQuIBBuyJX85IoIvh4bJxDZPWASRCCWDocGq6qSwk3jnjxmVW4XwrwXYH1HWnW
         LvwAmJ67rxMIVqd8mYoXEcPwGqtadR+Wt7xTl853/CEUvwJF3W8YU3SEJagx5Hliv3Yt
         OVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746760615; x=1747365415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xc7BzZfYEb+VFNTMq0je73w2/39IbT5bTX8c0mAg458=;
        b=S1zyd2Ftzfvgpf30qxJ/ISoMmFjz5pHfJPPoGsyN0vQpoMw6NpdYO4mZNRieYpXE5X
         ONsd12apizsJnawWV6UstoKGh6+CCZzcX7fSwnbPsL3Vo/LXYa7vRnNPhQGatx062XSk
         mUbdN6mWyfshXo1j89rV2DUZMZDcgf35eJWtBQUUJuDW4+0PbkjynxwTbv3zVj25i52t
         FVaFgLcM+t+IqKkRuW1c/3VP58e2RMNomKwUurM8//E9ujeRCJdL3LmSB7xZcaMhVbd8
         s/Z8iGGDKxhYLoP0bqb0r3zphhrgsp/3dtFhFp3MU1kof6S27LnDGzDADdVZby97dUFm
         y2bA==
X-Forwarded-Encrypted: i=1; AJvYcCV5tUiU9ee6xwYjY6ceGpp80/0QRQrNJ7UI/m0XiS4V3UnsLNqI1JXAcNDS/kmrJg3OvRakj626mhnOlK8=@vger.kernel.org, AJvYcCX5s205KVo04VMRb6IdqDsz+vKF3tDhK+Lvc0YvAtunu9tAmoQcy29096DT0g/v01SK1wvyqTIYzcDo@vger.kernel.org, AJvYcCXFYqvkUqtcoR1uwuXqYQCokiNZRJUyZg/Oy8B8i/mV5DJY2uhNADN5PJnyEOvbXFK6jXf0vtnGYBi9vd6TApQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywagnn4Ju3KZCEfA//yVoG0mofn2HH542utL/we3n3TDBFUNfcV
	mqr0WpM3NF9X08GP8aEAivZw3eblJxilZKSt93BUzLeTPf2W/O4H
X-Gm-Gg: ASbGncuELvDWTVD3sm09pNynMQE7en/wW40K875k2rOgSXzqxtM1M+MsMOgzCChGfzb
	fe7XXmjmEg+2Csm6LufWqNhFiTER0m4yAS06/+Hb0xX8+hVN8CFIpm8EWd7NOLLs6dYh2eCsG/K
	TYwwRmykH19eusEC6vOL2vQrPzDPWzlkYVs+/g5Ac3ZOUY9RmA0SHAUc8Dg+Gd2trV5D9vF3T2v
	EYUJOy+dE8oKPfvOnm/27Sq2vkXzahf9lw6PRs7+kBlkbTNyQv5uuRGyS9Lx+Te0UCvt9bXG1Vi
	/FSyVDyxQiJea6D8UPC/mQYmgqq9myIT6tEN32zrcEcj/x7tvOoirPv/MAwoBhW8UlJtpnq1oGn
	3/YxYzLCrPFie
X-Google-Smtp-Source: AGHT+IFCRJsr2OGQOgUW1EnBwtCSztfQBP0xfRtzoRTkbZzNHfWmUa5GFKAnIMjv8o+M8+sslDuuDA==
X-Received: by 2002:a05:6820:c8a:b0:608:3ee9:13a4 with SMTP id 006d021491bc7-6084b61bc85mr1314471eaf.5.1746760615396;
        Thu, 08 May 2025 20:16:55 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60842b096desm303745eaf.30.2025.05.08.20.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 20:16:55 -0700 (PDT)
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
Subject: [PATCH 08/11] rust: pci: make Bar generic over Io
Date: Thu,  8 May 2025 22:15:21 -0500
Message-ID: <20250509031524.2604087-9-andrewjballance@gmail.com>
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

renames `Bar` to `RawBar` and makes it generic over `IoAccess`.
a user can give a compile time suggestion when mapping a bar so
that the type of io can be known.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/kernel/pci.rs | 88 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 69 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index c97d6d470b28..7e592db99073 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -11,8 +11,7 @@
     devres::Devres,
     driver,
     error::{to_result, Result},
-    io::Io,
-    io::IoRaw,
+    io::{Io, IoAccess, IoRaw, MMIo, PortIo},
     str::CStr,
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
@@ -259,15 +258,25 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
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
+    original_ioptr: usize,
+    io: I,
     num: i32,
 }
 
-impl<const SIZE: usize> Bar<SIZE> {
+/// a pci bar that can be either PortIo or MMIo
+pub type IoBar<const SIZE: usize = 0> = RawBar<SIZE, Io<SIZE>>;
+
+/// a pci bar that maps a [`PortIo`].
+pub type MMIoBar<const SIZE: usize = 0> = RawBar<SIZE, MMIo<SIZE>>;
+
+/// a pci bar that maps a [`MMIo`].
+pub type PIoBar<const SIZE: usize = 0> = RawBar<SIZE, PortIo<SIZE>>;
+
+impl<const SIZE: usize, I: IoAccess<SIZE>> RawBar<SIZE, I> {
     fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
         let len = pdev.resource_len(num)?;
         if len == 0 {
@@ -299,7 +308,22 @@ fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = match IoRaw::new(ioptr, len as usize) {
+        let raw = match IoRaw::new(ioptr, len as usize) {
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
+        // SAFETY:
+        // - `raw` is from `pci_iomap`
+        // - addresses from `pci_iomap` should be accesed through ioread/iowrite
+        let io = match unsafe { I::from_raw_cookie(raw) } {
             Ok(io) => io,
             Err(err) => {
                 // SAFETY:
@@ -311,8 +335,9 @@ fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
             }
         };
 
-        Ok(Bar {
+        Ok(RawBar {
             pdev: pdev.into(),
+            original_ioptr: ioptr,
             io,
             num,
         })
@@ -334,29 +359,28 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
 
     fn release(&self) {
         // SAFETY: The safety requirements are guaranteed by the type invariant of `self.pdev`.
-        unsafe { Self::do_release(&self.pdev, self.io.addr(), self.num) };
+        unsafe { Self::do_release(&self.pdev, self.original_ioptr, self.num) };
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
-        unsafe { Io::from_raw(&self.io) }
+        &self.io
     }
 }
 
@@ -379,7 +403,7 @@ pub fn device_id(&self) -> u16 {
 
     /// Returns the size of the given PCI bar resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
-        if !Bar::index_is_valid(bar) {
+        if !RawBar::index_is_valid(bar) {
             return Err(EINVAL);
         }
 
@@ -395,17 +419,43 @@ pub fn iomap_region_sized<const SIZE: usize>(
         &self,
         bar: u32,
         name: &CStr,
-    ) -> Result<Devres<Bar<SIZE>>> {
-        let bar = Bar::<SIZE>::new(self, bar, name)?;
+    ) -> Result<Devres<IoBar<SIZE>>> {
+        let bar = RawBar::<SIZE, _>::new(self, bar, name)?;
         let devres = Devres::new(self.as_ref(), bar, GFP_KERNEL)?;
 
         Ok(devres)
     }
 
     /// Mapps an entire PCI-BAR after performing a region-request on it.
-    pub fn iomap_region(&self, bar: u32, name: &CStr) -> Result<Devres<Bar>> {
+    pub fn iomap_region(&self, bar: u32, name: &CStr) -> Result<Devres<IoBar>> {
         self.iomap_region_sized::<0>(bar, name)
     }
+
+    /// Maps an entire PCI-BAR after performing a region-request` where the
+    /// type of Io backend is known at compile time.
+    pub fn iomap_region_hint<I: IoAccess>(
+        &self,
+        bar: u32,
+        name: &CStr,
+    ) -> Result<Devres<RawBar<0, I>>> {
+        let bar = RawBar::<0, I>::new(self, bar, name)?;
+        let devres = Devres::new(self.as_ref(), bar, GFP_KERNEL)?;
+
+        Ok(devres)
+    }
+    /// Maps an entire PCI-BAR after performing a region-request` where the
+    /// type of Io backend is known at compile time. I/O operation bound checks
+    /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
+    pub fn iomap_region_sized_hint<const SIZE: usize, I: IoAccess<SIZE>>(
+        &self,
+        bar: u32,
+        name: &CStr,
+    ) -> Result<Devres<RawBar<SIZE, I>>> {
+        let bar = RawBar::<SIZE, I>::new(self, bar, name)?;
+        let devres = Devres::new(self.as_ref(), bar, GFP_KERNEL)?;
+
+        Ok(devres)
+    }
 }
 
 impl Device<device::Core> {
-- 
2.49.0


