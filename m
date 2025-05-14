Return-Path: <linux-pci+bounces-27707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D02AB695C
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 13:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310BC8C2689
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7927605C;
	Wed, 14 May 2025 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c43CIYPx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D18276037;
	Wed, 14 May 2025 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220331; cv=none; b=MQCSlGG4F4o9kxmzWNhipfcdBxH/cUFZjXB27Xf/Ubu7DBDjptykkYfd8JiYa6esedGNQvun6QabX2KcOibPGRdwwbB8EqICGdTbmsQpMdyKM/E6IsLABW8UzU/VT1n87n4Df8BMt6TJVQiD/YYBcStbqpn1CHOjuE0SbOaP/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220331; c=relaxed/simple;
	bh=us24YMHGRBi3hbg2xCpl1Wl1HHgJcRn3NEPuZn3iX2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvtCYwjsfpJuPe7twiW7csMLxwwsC8q1wL8ktuujRjdrDkoyZ1BEfSKZhocFPzv4l2fNQQZkBMFBhOTw0r2BMnpDpCJEpMyesG4lrsBCXD/BdrDJCT5gt52maf0a9gqTvlsCzuH3vkrUNAkEH2ZMeto2QYUMbjUEu8M4puuLIuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c43CIYPx; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-601b6146b9cso3309795eaf.0;
        Wed, 14 May 2025 03:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747220329; x=1747825129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VovI2MJA5yrsgZVuWzhEGgze0o42B0tngXC0Xns04F8=;
        b=c43CIYPxfJCcIX6eQF9XANR3MTlH9zKw8NcRI6XCvCgknuVF7xoPZUsYbsq1nZJs6y
         l7Ai1IifHm91MCEnR+OkeR7ErWgq9pgr+Z8Bltg12SPVUBatIyCbv9jrkl/T0IFTR1Pd
         X+292gehftco2yMYCKfBHJLYAogA45/tZU0ZD27YojUA501JtPq12DprK7/ZLdb1GIST
         waRi+lHvF+hZsdDXWK83mOID1ITxgdqnbybZzFlHSHMjbwpXwVrQSLSMbJ1yKwyqn40K
         cSTd2CDcIJCisEerxmfZawy/BAdF39JEGsRkAzMRukAu6IiAWXF/Tkpw0dn2MWBGoyTD
         jYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747220329; x=1747825129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VovI2MJA5yrsgZVuWzhEGgze0o42B0tngXC0Xns04F8=;
        b=hLm961nelIEsZds+GDJRkbAAItf7BUNZtC7MpOTopuWF4SxJwm4RXCa1pNHD9U/i0q
         8IRcSeS0HHaAB6IMXBgml9pCYLVD+oksX6Zpu67fK6DTrDl7obwVGsXveLM5ypcGlSxM
         vjjuawzhXZoivXfZT4UZ76aTULlUVHRYljWIX5bp/3QRrVLm3cBNdlStLLoq/pzD7gWJ
         VTbymecVym5ZwbO8M8T/cyXrJEfk5fVVgIUh97RP2NqOjjWKtFbS4VA14QHgXdnXtV3l
         7BK1flGnI9ra5OVs07gHkIzSvtJJdTvRFoy36K51FwBlgmpPE7uhEsXmgQY9EFKllmrX
         +/1g==
X-Forwarded-Encrypted: i=1; AJvYcCU0zI+MX/uir3sBIPYbD/S5wU+o6csn6lGjZQS9+psK9u1cZmJQUCBhtrg5G3vU2LBkC4omHjt1OC5f@vger.kernel.org, AJvYcCVtqC/pwpCSCqT0R7xgn0Cn+9jytbAO7ars4iai7Thfm6ir80ji4U3apg0xRgR0fEjL3WfIXh4sbig8Ozc=@vger.kernel.org, AJvYcCW9FL/7Pomy6M7gWA6Fwg83gc765WbyUEPRaO/aEeIkt7dDRNdyFK4Fe29191jA7Jd2ePelGessn1SaueeWUMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoPhkRcfoe5iEgIUnynkqgM65IwawXOeFlOsXFLgWQsf9DL6jk
	Ko+MoW3fasJUqFAE4uOHH8ciEm4Z4S+319GEFsA53qRcU/ol/iAt
X-Gm-Gg: ASbGncuMHFOcZSU1tr2vWEzzPuVtrqChQsNgovNgkU1SUeF/gHVNwnwfy5atyGNCpzX
	N0+yTBb+N4L9rYqMjkhVwygSduNM1asI0hPegi9TWnzOdcjcBzVEW5Rq5kd82+gmaXye45lR31M
	L3/3/d5qKPymcGpwCFZrk9ndmyDXf3fn7NQSwwA2REqbdJgeUlv9a6OynUkWVbO1F6pVtPa0oI6
	zABPdAErgdSrNesmqtXH3zWcJlfWMh7X82srA76m8e53a779WJcbnY4PnKwi4vkRAoqDDJUEwNn
	PhnhRJuw5Dz6xq218eos94IrKBGqiQN5ejfUCSKqXnvmCUpzLE2fqtk5N3Ni9j/HZ7pAW/YMyJX
	I08XRawf7w1gUGppb1iP+EWI=
X-Google-Smtp-Source: AGHT+IGvL6lH6ONZZTZw0JVilpcjbjUVXYPilV66tx5v9oXHgFKQIvgBVSwhNCuPOSNDrDvg0lp6Sw==
X-Received: by 2002:a05:6870:95a3:b0:2d4:c19a:94e5 with SMTP id 586e51a60fabf-2e34885828emr1280774fac.39.1747220328945;
        Wed, 14 May 2025 03:58:48 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2dba060be9esm2654535fac.10.2025.05.14.03.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 03:58:48 -0700 (PDT)
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
Subject: [PATCH v2 4/6] rust: io: implement Debug for IoRaw and add some doctests
Date: Wed, 14 May 2025 05:57:32 -0500
Message-ID: <20250514105734.3898411-5-andrewjballance@gmail.com>
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

From: Fiona Behrens <me@kloenk.dev>

Implement `Debug` for `kernel::io::IoRaw` which also outputs the const
generic SIZE as a field.

Add some doctests to `IoRaw::new` and `MMIo::from_raw(_ref)`.

Signed-off-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/kernel/io.rs | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index ce044c155b16..9445451f4b02 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -226,6 +226,33 @@ pub struct IoRaw<const SIZE: usize = 0> {
 
 impl<const SIZE: usize> IoRaw<SIZE> {
     /// Returns a new `IoRaw` instance on success, an error otherwise.
+    ///
+    /// # Examples
+    ///
+    /// Const generic size 0, only allowing runtime checks:
+    /// ```
+    /// use kernel::io::IoRaw;
+    ///
+    /// let raw: IoRaw<0> = IoRaw::new(0xDEADBEEFC0DE, 8).unwrap();
+    /// # assert_eq!(raw.addr(), 0xDEADBEEFC0DE);
+    /// # assert_eq!(raw.maxsize(), 8);
+    /// ```
+    ///
+    /// Const generic size equals maxsize:
+    /// ```
+    /// use kernel::io::IoRaw;
+    ///
+    /// let raw: IoRaw<8> = IoRaw::new(0xDEADBEEFC0DE, 8).unwrap();
+    /// # assert_eq!(raw.addr(), 0xDEADBEEFC0DE);
+    /// # assert_eq!(raw.maxsize(), 8);
+    /// ```
+    ///
+    /// Const generic size bigger then maxsize:
+    /// ```
+    /// use kernel::io::IoRaw;
+    ///
+    /// IoRaw::<16>::new(0xDEADBEEFC0DE, 8).unwrap_err();
+    /// ```
     pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
         if maxsize < SIZE {
             return Err(EINVAL);
@@ -247,6 +274,16 @@ pub fn maxsize(&self) -> usize {
     }
 }
 
+impl<const SIZE: usize> core::fmt::Debug for IoRaw<SIZE> {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        f.debug_struct("IoRaw")
+            .field("SIZE", &SIZE)
+            .field("addr", &self.addr)
+            .field("maxsize", &self.maxsize)
+            .finish()
+    }
+}
+
 /// IO-mapped memory, starting at the base address [`addr`] and spanning [`maxsize`] bytes.
 ///
 /// The creator (usually a subsystem / bus such as PCI) is responsible for creating the
@@ -263,6 +300,7 @@ pub fn maxsize(&self) -> usize {
 /// [`maxsize`]: IoAccess::maxsize
 /// [`read`]: https://docs.kernel.org/driver-api/device-io.html#differences-between-i-o-access-functions
 /// [`write`]: https://docs.kernel.org/driver-api/device-io.html#differences-between-i-o-access-functions
+#[derive(Debug)]
 #[repr(transparent)]
 pub struct MMIo<const SIZE: usize = 0>(IoRaw<SIZE>);
 
@@ -273,6 +311,18 @@ impl<const SIZE: usize> MMIo<SIZE> {
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of
     /// size `maxsize`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::io::{IoRaw, MMIo, IoAccess};
+    ///
+    /// let raw = IoRaw::<2>::new(0xDEADBEEFC0DE, 2).unwrap();
+    /// // SAFETY: test, value is not actually written to.
+    /// let mmio: MMIo<2> = unsafe { MMIo::from_raw(raw) };
+    /// # assert_eq!(0xDEADBEEFC0DE, mmio.addr());
+    /// # assert_eq!(2, mmio.maxsize());
+    /// ```
     #[inline]
     pub unsafe fn from_raw(raw: IoRaw<SIZE>) -> Self {
         Self(raw)
@@ -285,6 +335,18 @@ pub unsafe fn from_raw(raw: IoRaw<SIZE>) -> Self {
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of
     /// size `maxsize`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::io::{IoRaw, MMIo, IoAccess};
+    ///
+    /// let raw = IoRaw::<2>::new(0xDEADBEEFC0DE, 2).unwrap();
+    /// // SAFETY: test, value is not actually written to.
+    /// let mmio: &MMIo<2> = unsafe { MMIo::from_raw_ref(&raw) };
+    /// # assert_eq!(raw.addr(), mmio.addr());
+    /// # assert_eq!(raw.maxsize(), mmio.maxsize());
+    /// ```
     #[inline]
     pub unsafe fn from_raw_ref(raw: &IoRaw<SIZE>) -> &Self {
         // SAFETY: `MMIo` is a transparent wrapper around `IoRaw`.
@@ -349,6 +411,7 @@ impl<const SIZE: usize> IoAccess64Relaxed<SIZE> for MMIo<SIZE> {
 /// [`maxsize`]: IoAccess::maxsize
 /// [`ioread`]: https://docs.kernel.org/driver-api/device-io.html#differences-between-i-o-access-functions
 /// [`iowrite`]: https://docs.kernel.org/driver-api/device-io.html#differences-between-i-o-access-functions
+#[derive(Debug)]
 #[repr(transparent)]
 pub struct Io<const SIZE: usize = 0>(IoRaw<SIZE>);
 
-- 
2.49.0


