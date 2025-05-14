Return-Path: <linux-pci+bounces-27706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC04AAB6959
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 12:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863F6865ABE
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5D1274646;
	Wed, 14 May 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoeNiWFZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379BC274653;
	Wed, 14 May 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220326; cv=none; b=I7d5qc46mi78Zn4k02o2eTFmKFD+qXQUyT/9+tSlVrSqjpW8dI19hgWrxANVGhgimFYTR6gxOmZwNQnQ4eNR6tFIUNUBu6uZkMzoMBX7ka4AQcD4yYvRl+eSown2FntCORWAD36tuAhk0zyeaZJH+IFEX3LmANTKsGbzwXcwXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220326; c=relaxed/simple;
	bh=jBgr148jVjpuH58QBz4LCDpFD8RJBQ4LvEXTuUaGFZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgTS8gQZcVZsBmOzPe83XPLQX8SQrbT2fpVCi17nn/olDyCO/dMtMllTaasMfWx8pp2V953PPRomJjU9wTI/1w9iCa3jGZUa+ROF+EkgFYMQiKMt+nRgsaIF66Zqu/RP2qZ5xphOG68TItMFKk5xKmaYE8DrTKq90KXKdgDBTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoeNiWFZ; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3fa6c54cdb2so5612884b6e.3;
        Wed, 14 May 2025 03:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747220324; x=1747825124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hu8TOexpRWewY07dDXJsWt38JoGIzWPjMFqMEoSL2F8=;
        b=IoeNiWFZeEgh+MGNph0GV7QEHVLZGJbXsY/XR6i5r9C9+XnrSlz1XVGsFvsw3XLMf+
         NeUj1OxiKgTs6zbg/0mxDOwMSeMy9GkpDye/fk9AsUdm1Mfk4t5fOMDe+CSk6fOizEI1
         pZZPcGqIRTP4MZv15G65ahV3mhH4Qf6Z6mfkBYFEeGp0yHO2XM69Qr9gImO7yjAy6ONr
         EqawbKlgzbFOGSKWtlJLJxgErQOzUWYWNBD3jGrOFkkfZBnZCWQkS80Zv9LseT3hOQtE
         ErFzZHPL3CWK1ikA0QDcXla1MxuQtMRV+TMNLCQWjDYITHtiSsVq1AQ0UNomwepgb0GP
         tf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747220324; x=1747825124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hu8TOexpRWewY07dDXJsWt38JoGIzWPjMFqMEoSL2F8=;
        b=MoNHz9UAhmAIOeEZGNj1Z17jjQNvy/jnKo2FOq0IFXv/guFhb8U2yJwQ58AzksaoCA
         kKysDxcgnKo1eTtZzJ8MiOA44JLQxUNm67tHq7RGRwPFDfijut0gWgfPgzOQX2yVLMPV
         jXe8wBv/GO6OnCX9loSBS+GFHrIKtZyfKA5YbI3zPGP3TXsXA+1fh3gVb2QMaBqKQWt7
         iRstyARXGJjDoje2rWEE1XrvU97dxMzi5lHMF98XfzI5Wzij+GGq0eIzTGrwurAiHjc1
         dlt0+eVGBiWhF8uW85A4WW6wgJEXip0QS7rJCnYa9DL6nksFAJRLnYvFd0UcE4yphiTt
         m4oA==
X-Forwarded-Encrypted: i=1; AJvYcCX+9TykxuAAs5yG0h6CWfSUaIv+eux3rjskz81c4EdRKHyuZXteVY4ebRA85R7I2lzWq8+lsb89YKubm2U=@vger.kernel.org, AJvYcCXEWuSuCZOe91cPHiaR/PXKero+7uEyUOW12jVCRsTdQhi+k55O27ik+t4mZXnjCPP9fhtsL8tl6nbj@vger.kernel.org, AJvYcCXJX71H/vE4gl50SVis7u7IvZNP26aQ2jIWAQvZ/fA1wV0WaSHJWcpKNVOn+Td7yLvUFCpN7Q+ORKqsPcVn0oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHGQ/1Z0AAjdCKI1rWcUTIFya7uYcVwwFoooCYD+SeTwMJY5TG
	WY2W2UXa8ZVa1pzbaQ0gHmu4j5PKN4kPLeZ8VBF+esaJiZuBEaak
X-Gm-Gg: ASbGnct20RK0odA25lyW5EdIskSwaLjT96QUnygcCLUBbvAb2yqAllPBet08tI9lXCU
	At3M22GP9bK2qgB3nc8AohsCZr0KXKFBgZO4WSSdD/xHdGUfIMAg5FFzKHEAEIczwYrAPvQbUWt
	8qnt6FypCOIPWx3k/PpcRhiVLffZU1RJTgH4inRNe1rxhuDrrbRxbnV8wACW6RpMUkUVvpWKsCq
	6kYny0uIQilORhtXAfLYysELJhmbEcKDX2paKanTyfCO6cSaozbeByX+LQ/el14QVckKsP5I/Gz
	IXcUzTmEM7y/nPgFd9Gt9si4PekOOgrYwb4Q/gSLxvlnecxpI+t+mIvFHm1crcxNXsFSdbaAbvU
	V+6Y5WThUxy+RrNVFniehwRk=
X-Google-Smtp-Source: AGHT+IGXkVccnY53tGuxSpCAUCholjM/YozYw8rMeLEOV6h73hwItyLwj6abwZHjjSwc7RwgLDceeg==
X-Received: by 2002:a05:6870:b022:b0:2e0:15a3:3b0f with SMTP id 586e51a60fabf-2e348815239mr1434508fac.31.1747220324164;
        Wed, 14 May 2025 03:58:44 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2dba060be9esm2654535fac.10.2025.05.14.03.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 03:58:43 -0700 (PDT)
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
Subject: [PATCH v2 3/6] rust: io: add new Io type
Date: Wed, 14 May 2025 05:57:31 -0500
Message-ID: <20250514105734.3898411-4-andrewjballance@gmail.com>
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

adds a new Io type that uses the C ioread/iowrite family of functions
and implements the IoAccess trait for it and renames the old `Io`
to `MMIo`.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/helpers/io.c |  7 ++++
 rust/kernel/io.rs | 97 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index d419b5b3b7c7..a138914523c8 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -52,3 +52,10 @@ define_rust_io_write_helper(rust_helper_writel_relaxed, writel_relaxed, u32);
 define_rust_io_write_helper(rust_helper_writeq_relaxed, writeq_relaxed, u64);
 #endif
 
+define_rust_io_read_helper(rust_helper_ioread8, ioread8, u8);
+define_rust_io_read_helper(rust_helper_ioread16, ioread16, u16);
+define_rust_io_read_helper(rust_helper_ioread32, ioread32, u32);
+
+define_rust_io_write_helper(rust_helper_iowrite8, iowrite8, u8);
+define_rust_io_write_helper(rust_helper_iowrite16, iowrite16, u16);
+define_rust_io_write_helper(rust_helper_iowrite32, iowrite32, u32);
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 368167d57863..ce044c155b16 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -264,9 +264,9 @@ pub fn maxsize(&self) -> usize {
 /// [`read`]: https://docs.kernel.org/driver-api/device-io.html#differences-between-i-o-access-functions
 /// [`write`]: https://docs.kernel.org/driver-api/device-io.html#differences-between-i-o-access-functions
 #[repr(transparent)]
-pub struct Io<const SIZE: usize = 0>(IoRaw<SIZE>);
+pub struct MMIo<const SIZE: usize = 0>(IoRaw<SIZE>);
 
-impl<const SIZE: usize> Io<SIZE> {
+impl<const SIZE: usize> MMIo<SIZE> {
     /// Convert a [`IoRaw`] into an [`MMIo`] instance, providing the accessors to the MMIO mapping.
     ///
     /// # Safety
@@ -293,7 +293,7 @@ pub unsafe fn from_raw_ref(raw: &IoRaw<SIZE>) -> &Self {
 }
 
 // SAFETY: as per invariant `raw` is valid
-unsafe impl<const SIZE: usize> IoAccess<SIZE> for Io<SIZE> {
+unsafe impl<const SIZE: usize> IoAccess<SIZE> for MMIo<SIZE> {
     #[inline]
     fn maxsize(&self) -> usize {
         self.0.maxsize()
@@ -312,13 +312,13 @@ fn addr(&self) -> usize {
 }
 
 #[cfg(CONFIG_64BIT)]
-impl<const SIZE: usize> IoAccess64<SIZE> for Io<SIZE> {
+impl<const SIZE: usize> IoAccess64<SIZE> for MMIo<SIZE> {
     impl_accessor_fn!(
         read64_unchecked, readq, write64_unchecked, writeq, u64;
     );
 }
 
-impl<const SIZE: usize> IoAccessRelaxed<SIZE> for Io<SIZE> {
+impl<const SIZE: usize> IoAccessRelaxed<SIZE> for MMIo<SIZE> {
     impl_accessor_fn!(
         read8_relaxed_unchecked, readb_relaxed, write8_relaxed_unchecked, writeb_relaxed, u8;
         read16_relaxed_unchecked, readw_relaxed, write16_relaxed_unchecked, writew_relaxed, u16;
@@ -327,8 +327,93 @@ impl<const SIZE: usize> IoAccessRelaxed<SIZE> for Io<SIZE> {
 }
 
 #[cfg(CONFIG_64BIT)]
-impl<const SIZE: usize> IoAccess64Relaxed<SIZE> for Io<SIZE> {
+impl<const SIZE: usize> IoAccess64Relaxed<SIZE> for MMIo<SIZE> {
     impl_accessor_fn!(
         read64_relaxed_unchecked, readq_relaxed, write64_relaxed_unchecked, writeq_relaxed, u64;
     );
 }
+
+/// Io that can be either PortIo or MMIo,
+/// starting at the base address [`addr`] and spanning [`maxsize`] bytes.
+///
+/// The creator (usually a subsystem / bus such as PCI) is responsible for creating the
+/// mapping, performing an additional region request, etc.
+///
+/// # Invariants
+///
+/// [`addr`] is the start and [`maxsize`] the length of a valid io region of size [`maxsize`].
+///
+/// [`addr`] is valid to access with the C [`ioread`]/[`iowrite`] family of functions.
+///
+/// [`addr`]: IoAccess::addr
+/// [`maxsize`]: IoAccess::maxsize
+/// [`ioread`]: https://docs.kernel.org/driver-api/device-io.html#differences-between-i-o-access-functions
+/// [`iowrite`]: https://docs.kernel.org/driver-api/device-io.html#differences-between-i-o-access-functions
+#[repr(transparent)]
+pub struct Io<const SIZE: usize = 0>(IoRaw<SIZE>);
+
+impl<const SIZE: usize> Io<SIZE> {
+    /// Convert a [`IoRaw`] into an [`Io`] instance, providing the accessors to the
+    /// Io mapping.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `addr` is the start of a valid I/O region of size `maxsize`.
+    ///
+    /// ```
+    /// use kernel::io::{IoRaw, Io, IoAccess};
+    ///
+    /// let raw = IoRaw::<2>::new(0xDEADBEEFC0DE, 2).unwrap();
+    /// // SAFETY: test, value is not actually written to.
+    /// let io: Io<2> = unsafe { Io::from_raw(raw) };
+    /// # assert_eq!(0xDEADBEEFC0DE, io.addr());
+    /// # assert_eq!(2, io.maxsize());
+    /// ```
+    pub unsafe fn from_raw(raw: IoRaw<SIZE>) -> Self {
+        Self(raw)
+    }
+
+    /// Convert a ref to [`IoRaw`] into an [`Io`] instance, providing the accessors to
+    /// the Io mapping.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of
+    /// size `maxsize`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::io::{IoRaw, Io, IoAccess};
+    ///
+    /// let raw = IoRaw::<2>::new(0xDEADBEEFC0DE, 2).unwrap();
+    /// // SAFETY: test, value is not actually written to.
+    /// let io: &Io<2> = unsafe { Io::from_raw_ref(&raw) };
+    /// # assert_eq!(raw.addr(), io.addr());
+    /// # assert_eq!(raw.maxsize(), io.maxsize());
+    /// ```
+    #[inline]
+    pub unsafe fn from_raw_ref(raw: &IoRaw<SIZE>) -> &Self {
+        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
+        unsafe { &*core::ptr::from_ref(raw).cast() }
+    }
+}
+
+// SAFETY: as per invariant `raw` is valid
+unsafe impl<const SIZE: usize> IoAccess<SIZE> for Io<SIZE> {
+    #[inline]
+    fn addr(&self) -> usize {
+        self.0.addr()
+    }
+
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.0.maxsize()
+    }
+
+    impl_accessor_fn!(
+        read8_unchecked, ioread8, write8_unchecked, iowrite8, u8;
+        read16_unchecked, ioread16, write16_unchecked, iowrite16, u16;
+        read32_unchecked, ioread32, write32_unchecked, iowrite32, u32;
+    );
+}
-- 
2.49.0


