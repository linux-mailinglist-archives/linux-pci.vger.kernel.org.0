Return-Path: <linux-pci+bounces-21676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A18A38DD5
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 22:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF283A8244
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17D423875A;
	Mon, 17 Feb 2025 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="X6zfjovR"
X-Original-To: linux-pci@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDF8226545;
	Mon, 17 Feb 2025 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739826472; cv=none; b=QPG36kWh5G8TTlpRpoXlW/RU0Dtju3z8MhDlLNeN7ZSVi1MVGR7Ee95YTt8QtyhaInJd6TJCWWJTRg80Df+oBICYrUYhGVXDqg1aaeSRUBbbgoAUuDpeHq8l4bzG2a8BIgig8/Kn+5imROpDfR9NEo7SNLLy7gyQiv49yvPcm2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739826472; c=relaxed/simple;
	bh=LsYRpOjpOL3V/STxpqzTCiQRToI3srOvQgLq+WUoynM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M6oFzLMKsUHS3jr0ZfGmeJexgXez+o8mSyCjMIkPr7EQK+saMJnN6VJ5vPZHF4dd3CrtZY6buCVF6oQycVtcgDB8HvgnIMRNIbrlFWxvBabeOQ+pdA7domDvEIKh77nZYmy4L876ps9KSA7RGrgldtIUEoKwCFJtFiLhq3IPbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=X6zfjovR; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1739825928; bh=BRHWXSncwQHxJEXz+lPaEWqa58lv4Bor0CGJfRHxbg8=;
	h=From:Date:Subject:To:Cc;
	b=X6zfjovRH7NkXptn/J6mtDR9BX1owDj0vx8EV5djizyPDLDXxE8bLKkwQ71nb7SUg
	 VtH09O2H2PNU8NmTSQ5qbQ+k+FdeSwYyoTq7IMbClzFWK79RfKpPMGLgH1PvvpaZmH
	 AZtwS6REop8NX1W58OuDmboOfIPviUDnpE24sC2k=
Date: Mon, 17 Feb 2025 21:58:14 +0100
Subject: [PATCH] rust: io: rename `io::Io` accessors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-io-generic-rename-v1-1-06d97a9e3179@kloenk.dev>
X-B4-Tracking: v=1; b=H4sIAOWis2cC/x3MQQqAIBBA0avErBswy4KuEi1MR5tFUyhEIN09a
 fkX7xfIlJgyzE2BRDdnPqVG1zbgdiuRkH1t0EobpbsJ+cRIUpHDRGIPQqN9b4PZhrEPUN2VKPD
 zP5f1fT9gApy0YwAAAA==
X-Change-ID: 20250217-io-generic-rename-52d3af5b463f
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7615; i=me@kloenk.dev;
 h=from:subject:message-id; bh=LsYRpOjpOL3V/STxpqzTCiQRToI3srOvQgLq+WUoynM=;
 b=owJ4nJvAy8zAJdbGuXyr5NPHToyn1ZIY0jcv+n/TearU7Binj3UPrrXaX8ufesZINmrV44PFF
 xsatwapOO7qKGVhEONikBVTZNnidf/+j8xlWfb373bDzGFlAhnCwMUpABPJ3Mfwz+5N3OuTYjd9
 4p/23YmUebR7y1GPXquAgsTprs519xZoTGP4767yYn6X6k6r8utWjqEZJjkCNae4JbddlHKzP9m
 xbUIFDwDSDk9S
X-Developer-Key: i=me@kloenk.dev; a=openpgp;
 fpr=B44ADFDFF869A66A3FDFDD8B8609A7B519E5E342

Rename the I/O accessors provided by `Io` to encode the type as
number instead of letter. This is in preparation for Port I/O support
to use a trait for generic accessors.

Add a `c_fn` argument to the accessor generation macro to translate
between rust and C names.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/PIO.20support/near/499460541
Signed-off-by: Fiona Behrens <me@kloenk.dev>
---
 rust/kernel/io.rs               | 66 ++++++++++++++++++++---------------------
 samples/rust/rust_driver_pci.rs | 12 ++++----
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d4a73e52e3ee68f7b558749ed0108acde92ae5fe..72d80a6f131e3e826ecd9d2c3bcf54e89aa60cc3 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -98,9 +98,9 @@ pub fn maxsize(&self) -> usize {
 ///# fn no_run() -> Result<(), Error> {
 /// // SAFETY: Invalid usage for example purposes.
 /// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
-/// iomem.writel(0x42, 0x0);
-/// assert!(iomem.try_writel(0x42, 0x0).is_ok());
-/// assert!(iomem.try_writel(0x42, 0x4).is_err());
+/// iomem.write32(0x42, 0x0);
+/// assert!(iomem.try_write32(0x42, 0x0).is_ok());
+/// assert!(iomem.try_write32(0x42, 0x4).is_err());
 /// # Ok(())
 /// # }
 /// ```
@@ -108,7 +108,7 @@ pub fn maxsize(&self) -> usize {
 pub struct Io<const SIZE: usize = 0>(IoRaw<SIZE>);
 
 macro_rules! define_read {
-    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) => {
+    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident -> $type_name:ty) => {
         /// Read IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -119,7 +119,7 @@ pub fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$name(addr as _) }
+            unsafe { bindings::$c_fn(addr as _) }
         }
 
         /// Read IO data from a given offset.
@@ -131,13 +131,13 @@ pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            Ok(unsafe { bindings::$name(addr as _) })
+            Ok(unsafe { bindings::$c_fn(addr as _) })
         }
     };
 }
 
 macro_rules! define_write {
-    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) => {
+    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident <- $type_name:ty) => {
         /// Write IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -148,7 +148,7 @@ pub fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$name(value, addr as _, ) }
+            unsafe { bindings::$c_fn(value, addr as _, ) }
         }
 
         /// Write IO data from a given offset.
@@ -160,7 +160,7 @@ pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$name(value, addr as _) }
+            unsafe { bindings::$c_fn(value, addr as _) }
             Ok(())
         }
     };
@@ -218,43 +218,43 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
         self.addr() + offset
     }
 
-    define_read!(readb, try_readb, u8);
-    define_read!(readw, try_readw, u16);
-    define_read!(readl, try_readl, u32);
+    define_read!(read8, try_read8, readb -> u8);
+    define_read!(read16, try_read16, readw -> u16);
+    define_read!(read32, try_read32, readl -> u32);
     define_read!(
         #[cfg(CONFIG_64BIT)]
-        readq,
-        try_readq,
-        u64
+        read64,
+        try_read64,
+        readq -> u64
     );
 
-    define_read!(readb_relaxed, try_readb_relaxed, u8);
-    define_read!(readw_relaxed, try_readw_relaxed, u16);
-    define_read!(readl_relaxed, try_readl_relaxed, u32);
+    define_read!(read8_relaxed, try_read8_relaxed, readb_relaxed -> u8);
+    define_read!(read16_relaxed, try_read16_relaxed, readw_relaxed -> u16);
+    define_read!(read32_relaxed, try_read32_relaxed, readl_relaxed -> u32);
     define_read!(
         #[cfg(CONFIG_64BIT)]
-        readq_relaxed,
-        try_readq_relaxed,
-        u64
+        read64_relaxed,
+        try_read64_relaxed,
+        readq_relaxed -> u64
     );
 
-    define_write!(writeb, try_writeb, u8);
-    define_write!(writew, try_writew, u16);
-    define_write!(writel, try_writel, u32);
+    define_write!(write8, try_write8, writeb <- u8);
+    define_write!(write16, try_write16, writew <- u16);
+    define_write!(write32, try_write32, writel <- u32);
     define_write!(
         #[cfg(CONFIG_64BIT)]
-        writeq,
-        try_writeq,
-        u64
+        write64,
+        try_write64,
+        writeq <- u64
     );
 
-    define_write!(writeb_relaxed, try_writeb_relaxed, u8);
-    define_write!(writew_relaxed, try_writew_relaxed, u16);
-    define_write!(writel_relaxed, try_writel_relaxed, u32);
+    define_write!(write8_relaxed, try_write8_relaxed, writeb_relaxed <- u8);
+    define_write!(write16_relaxed, try_write16_relaxed, writew_relaxed <- u16);
+    define_write!(write32_relaxed, try_write32_relaxed, writel_relaxed <- u32);
     define_write!(
         #[cfg(CONFIG_64BIT)]
-        writeq_relaxed,
-        try_writeq_relaxed,
-        u64
+        write64_relaxed,
+        try_write64_relaxed,
+        writeq_relaxed <- u64
     );
 }
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 1fb6e44f33951c521c8b086a7a3a012af911cf26..ddc52db71a82a79657ec53025f9ef81d620516fc 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -43,17 +43,17 @@ struct SampleDriver {
 impl SampleDriver {
     fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
         // Select the test.
-        bar.writeb(index.0, Regs::TEST);
+        bar.write8(index.0, Regs::TEST);
 
-        let offset = u32::from_le(bar.readl(Regs::OFFSET)) as usize;
-        let data = bar.readb(Regs::DATA);
+        let offset = u32::from_le(bar.read32(Regs::OFFSET)) as usize;
+        let data = bar.read8(Regs::DATA);
 
         // Write `data` to `offset` to increase `count` by one.
         //
-        // Note that we need `try_writeb`, since `offset` can't be checked at compile-time.
-        bar.try_writeb(data, offset)?;
+        // Note that we need `try_write8`, since `offset` can't be checked at compile-time.
+        bar.try_write8(data, offset)?;
 
-        Ok(bar.readl(Regs::COUNT))
+        Ok(bar.read32(Regs::COUNT))
     }
 }
 

---
base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
change-id: 20250217-io-generic-rename-52d3af5b463f

Best regards,
-- 
Fiona Behrens <me@kloenk.dev>


