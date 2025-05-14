Return-Path: <linux-pci+bounces-27708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F29FAB695F
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 13:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312361604A3
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA82777E1;
	Wed, 14 May 2025 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frzLdKLu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB65277027;
	Wed, 14 May 2025 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220333; cv=none; b=Qp95105YKBG2Q95CYFIDBdDthafxHFshlRdo3zOkocMrsg1xeI17Z3k+iWPQ/ABaRuKOFezUdvFyKH7vkGj/BbSndzvTTOP1grAYRXtQMRAwNr0GM35KiXigXOkdntttr309cbFfdWMSW4r5zChn/BAeGqCQFECh1rY1SOgGFcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220333; c=relaxed/simple;
	bh=Ez8ztq/dtERycj7TA7MDDVE9xQFvHtmZjoqvVWAmmLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dURsEaXphIXots5V2hgVPuOQy98NG9zOS/UV/4KGHrT8kqXYSFWt/x2UOxr7JuR6KDeIq3rrgoy6N7RA5cl4tDFxucmpmV/sr7LzpRhMEQvgA7IiLzuWq+V3FtykWjj6YUgOJbcM/PX3qLJqYD00nbPdLv1qn4OSpob8mcwqPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frzLdKLu; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c173211feso1809628a34.1;
        Wed, 14 May 2025 03:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747220331; x=1747825131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1MHzNKHnQubokyBvFDPePXlfvpf87qUBVJo47Tv4gY=;
        b=frzLdKLueGFwiQglXw2UliMrob5RejwIAngBxKiQ70YjLQFWqet//L3V/cV6V82q/w
         cZD/YKevZOmJCiAxSRmv4rJLcTLp25eE2xW83/JZzhP0xEnQPsyMkCAt23ItoLTMIcX4
         kM5bu/OfWNvp0xdgjKtWtxiX451hQ/ZUyz8xYa/5Vp5nqRqG5wxOFeR5LOt6GgeS06Wq
         6v9t55C8V70VMSyEYfmJf9tDikU4BZcJhMBVszFHXqV1StXbb4rHVqHN8faxWndvGJz0
         rLy2YpRZ3pdW6LJHbxo3LAMtJQjTCjG9/o+qYSvUb5t6YfgYgL4uvvpEXZEs/juj/Cnc
         01PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747220331; x=1747825131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1MHzNKHnQubokyBvFDPePXlfvpf87qUBVJo47Tv4gY=;
        b=kz6jbyWJL8bn2Nv7WdiOdL7hyb7aMflVQc54d22g6domTx3IKf6Ux/aqmB3fTjmexd
         Hvl9iIUPqpIAt2sfs+gtnP5BqQ18yuLsQnW4FzqWx6EafyxMGgnNnByly9NZrnxeCjpB
         WibQ7U024G/Ut7RdsXQoNraeB/GyAKiuMxSbuSERQwIEGV5GbJ75GBnpaPOydXTmDPW7
         mCExjU/6pqplEZOuV5+VnBVDGBUZE3Xy0NTZQQP1DgEnuVqvgEZq285dtBM78cjux6rj
         4BOjFWRZ1pKfvDQaP+nca4Q28mkvx5owWUwTE8Zs6i6lc559eVKa8FavHmYAx5E/iIsd
         Joxw==
X-Forwarded-Encrypted: i=1; AJvYcCUPXcsx/YUEjj/Q/NutkWAYvpeLrEpuBnFh4prnqg3BWXY5987tzIwqBkk7StxfmfApvnEunQy5Y7W5TOq3Bdc=@vger.kernel.org, AJvYcCVcdrojbwbu59/7aJc5LfuJSeUrvRkSxvdG7p5kyStH738hF/D9xhHaPoJDP9LWzEsalokJpg76kGxe@vger.kernel.org, AJvYcCWXjtkZjZ822F3olmQLDfkhoDHD91gB1swyr50Ra3NP1RkdX9trPckIBmmJnh6VEByoat8WHLAlzyqz6sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmlyWXaPMtZshTM7XTZejAhuGDWgoXnHlDTEmJPZ0w0B/83eCV
	ddaN5y2f3NjZvo/vVF1IgLO/Y8kW26ZBK+OsWsairf0IBkyvqgmb
X-Gm-Gg: ASbGncvqbO74kpmEmLTQCmki5/1eGRCHFRejYGhFABdRRqd2hZAYaeFHtLCwwUhHh1T
	gN6fDto3uZsijvaJav1HKy0r4+OgiFx8USgC+rwe0b2/Mg45DupaFIopW81dAe0K0iLcmlza9VV
	QIuGv/SE+nhCrzkgrGwbGAEK5rQUXN56p+SOtHvNJSaaGVmfCVeNArZrFHa1DHwun+leFc+Q4Sg
	ubCcEV5/m7mYf3/NFuszjtylI09pKCg1XP9dWIUhi8971WWc9JwPp+FJS+Kqp4oQbjFUOctRwLk
	gO7CyhRXIWvB+v1JGUllcq0qo8IF/E8pbQd/9x3ekGO7DRAsV1yAo+bJrVkBz2pdJMunL7F8AOM
	i2aPCFtcW2WIVagghmu0cmYU=
X-Google-Smtp-Source: AGHT+IEvmuwiWZKjw7O4HiUgZ9VtQ/B2bT9Vp8sHqWzneblXp8y9RdB4sfskbtrUucD6vPheSQTSNw==
X-Received: by 2002:a05:6870:5251:b0:2c2:4e19:1cdf with SMTP id 586e51a60fabf-2e3488110b8mr1366100fac.25.1747220330682;
        Wed, 14 May 2025 03:58:50 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2dba060be9esm2654535fac.10.2025.05.14.03.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 03:58:50 -0700 (PDT)
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
Subject: [PATCH v2 5/6] rust: io: add from_raw_cookie functions
Date: Wed, 14 May 2025 05:57:33 -0500
Message-ID: <20250514105734.3898411-6-andrewjballance@gmail.com>
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

adds a `from_raw_cookie` function to the IoAccess trait.

`from_raw_cookie` attempts to convert a iomem address that can be
accessed by the ioread/iowrite family of C functions into either
a `Io` or `MMIo`.

This is done so that devices that know what type of Io they are at
compile time can give a hint about their type.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/kernel/io.rs | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 9445451f4b02..81b26602d3bc 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -6,6 +6,47 @@
 
 use crate::error::{code::EINVAL, Result};
 use crate::{bindings, build_assert};
+use io_backend::*;
+
+/// `io_backend` is private and implements the config specific logic for
+/// `IoAccess::from_raw_cookie`.
+#[cfg(all(CONFIG_X86, CONFIG_GENERIC_IOMAP))]
+mod io_backend {
+    // if on x86, generic_iomap is enabled so copy the logic
+    // from IO_COND in `lib/iomap.c`
+
+    // values copied from `lib/iomap.c`
+    const PIO_OFFSET: usize = 0x10000;
+    const PIO_RESERVED: usize = 0x40000;
+
+    #[inline]
+    pub(super) fn is_mmio(addr: usize) -> bool {
+        addr >= PIO_RESERVED
+    }
+
+    #[inline]
+    pub(super) fn is_portio(addr: usize) -> bool {
+        !is_mmio(addr) && addr > PIO_OFFSET
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
+}
 
 /// Private macro to define the [`IoAccess`] functions.
 macro_rules! define_io_access_function {
@@ -162,6 +203,14 @@ pub unsafe trait IoAccess<const SIZE: usize = 0> {
     /// Returns the base address of the accessed IO area.
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
@@ -366,6 +415,18 @@ fn addr(&self) -> usize {
         self.0.addr()
     }
 
+    unsafe fn from_raw_cookie(raw: IoRaw<SIZE>) -> Result<Self>
+    where
+        Self: Sized,
+    {
+        if is_mmio(raw.addr()) {
+            // INVARIANT: `addr` is checked so it should be ok to access with read/write
+            Ok(Self(raw))
+        } else {
+            Err(EINVAL)
+        }
+    }
+
     impl_accessor_fn!(
         read8_unchecked, readb, write8_unchecked, writeb, u8;
         read16_unchecked, readw, write16_unchecked, writew, u16;
@@ -474,6 +535,18 @@ fn maxsize(&self) -> usize {
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


