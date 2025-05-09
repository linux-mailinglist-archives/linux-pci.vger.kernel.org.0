Return-Path: <linux-pci+bounces-27479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76683AB08B3
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAFD4C4910
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 03:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F0722D4FA;
	Fri,  9 May 2025 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWgU+dzg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38C11E1DE8;
	Fri,  9 May 2025 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760601; cv=none; b=id2RN+IhvIkmWvP6FgiGuggJb/muNcxPp2Mj3MO0R1HY5s0drvp0cFQ0VQ2Yw8ILxYAzVZ/ztPDVuLipICySJTz8yZkdhH5CT5y9cryb0OisS/CdJdMAsh5AT4i4pij+czBLw2/ojn9OySROeOfJ3fYjF27k1vwwckIO6EZts7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760601; c=relaxed/simple;
	bh=bjTrEPpMKHJD3wSpaJbiZp8tufqK1zDiAdxndNWY7aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WE6XJvRxztwOQtGnUfp4URKf+DteU80lXVjHm+HLI7TQYSRpv8PS3USsmKMacTlNqLri7828lQOtkPeTQi1kL/k7TT5mYl0p9dOkyWdoZXz6lDiw8y7/T18IXaIYVwM/38KAhPdY6xFCfniq6PpYcY3lnXPaT94BJzYE5fk8ok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWgU+dzg; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-401f6513cb2so1543328b6e.0;
        Thu, 08 May 2025 20:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746760599; x=1747365399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FpcyogW9Sb9XRTvTc38KDvi+cUlELYSGH7PdgFznfY=;
        b=fWgU+dzgwyuw4iCqgq14KKORjMTqw1uxQaEm4+WNxo2+awjyDMmy/4RTTK04XBkwhI
         tBe/fZtI2hqfWRVeRMrNTnnI0cbkt+pMmfIT7Ij3I7iPpZyJOqdAuBlAgg5QdNEPrN5d
         GMXB0l3UexAMPH+EoXR/yOishFIxhGQWcXoMi7l+p4nFgZS46wWlvSjaB8ci/26AIWSV
         PKvpbK7FH9Y0HComQiEg42UghxNusu+aKZlLY4I1/iydeEEtE8BPu4KTf5VRhPsfYdGc
         Vyi5ISZGxuP/wFNmDvfgN+EAKnWekTdOMZKgN+ank6Oj25iDjleFRldfJitl2barn9RR
         mEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746760599; x=1747365399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FpcyogW9Sb9XRTvTc38KDvi+cUlELYSGH7PdgFznfY=;
        b=VjBaNnJbpoirydIYvxedA7xy622Nng4qMf6Q9VeVRJD1TuLdyZJToon+3rDbnEx9SG
         u7pOKWdugBZUed3Fc/8eDdGcOnvPKE7qh90z8oP6MMwAEq/bv6JImeMMaGVNSJ8tauYv
         mrUeKes6Rx5eCeN6q8s7rI+cVlFpB7EaogTz/l1itdZYFbxf5cGJXibc6EXDmXMwg77q
         Nf0gLN/zdtsduL4vi0OZaUVZWZUGbbX67W9/guZn/muHstwBajmtE5r0U0R2o+GoTWZU
         w3OauCXREa8Dzet76aQjEl0zClaZo6WU54EILmEyR4gFR3fOHGooGcovBfW/kj/9wLJD
         A+cA==
X-Forwarded-Encrypted: i=1; AJvYcCUX03uIj9hzPqlXmYUBI4ayg1eEjmiCY/DqB4pVXm5U9RDwfsQNiXSECIx6ERytYn4mQ0uEPNjL2vH1l+s=@vger.kernel.org, AJvYcCVv1bZ7QTLH1cxtJBB3cCUuiuq4ZcJ2V/uJViE8FFXbV48UZbVfYxXXbV0N+xuqqhWau2qtfr0+vpDf9zHfsLA=@vger.kernel.org, AJvYcCWZPljy3wlBJX9xdpowB2O0Z8l/IOcFlb2LHpfstkSrUmmxHQiKKXd/6nR2O+Lh0nF4xFnp5Gtokbxi@vger.kernel.org
X-Gm-Message-State: AOJu0YxhchyhGK00zF9qbOYFP0+odtlJumwaggnVRzXuMFV/CAdz0pHG
	89BE/JFY59WFE6JrJzWpqcZVtsTdXjn7UaD/x5zYR+iCs5bH0mwV
X-Gm-Gg: ASbGncvGx/dgylqAOwAJCCBS1yjQ+kNuA/jyDJu64g77aK5WIVp8u7BI9By8Qmllyd9
	ikBgJXL9HuGeKWB4YEKTqqaEOWSncpBRUrD+JPv9nyWmy5ULe3Bm00fFtPdwLDd67aNQrlasmiH
	5fbnLPZhv+AHM42bb/ArPTrF6Lp06FwPIO2tL2tXVwvLGKI/5BlmfInX1sARrr+iDJvVJTny0qC
	AxUSVhe+gsm6KuIeWxlnPAkIye7RcHAlx7vZ9PIqq4MPVkJ5z5J7dYsteegJrFKMsZaF8NvV28w
	8WUGDmRpML64FnxM1yBOL0pdKkH0rBzZe921KNSrSuvTg/ExXF8ans07UogMQsvqL/H5XYlC8Ij
	nzCvXTbSj9wxk
X-Google-Smtp-Source: AGHT+IEdxh2dCg5/We4vy5v5IiaPgW7LzfgjZM2joNSLRFy6xgWXUoJM6ruSZQvFAiSMKyUdL2wbnQ==
X-Received: by 2002:a05:6808:d53:b0:3f9:176a:3958 with SMTP id 5614622812f47-40377983b84mr3290641b6e.11.1746760598943;
        Thu, 08 May 2025 20:16:38 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60842b096desm303745eaf.30.2025.05.08.20.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 20:16:38 -0700 (PDT)
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
Subject: [PATCH 05/11] rust: io: add new Io type
Date: Thu,  8 May 2025 22:15:18 -0500
Message-ID: <20250509031524.2604087-6-andrewjballance@gmail.com>
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

adds a new Io type that uses the C ioread/iowrite family of functions
and implements the IoAccess trait for it.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/helpers/io.c |  8 +++++
 rust/kernel/io.rs | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index d439b61c672e..11c0c34f2eba 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -71,3 +71,11 @@ define_rust_pio_read_helper(inl, u32);
 define_rust_pio_write_helper(outb, u8);
 define_rust_pio_write_helper(outw, u16);
 define_rust_pio_write_helper(outl, u32);
+
+define_rust_mmio_read_helper(ioread8, u8);
+define_rust_mmio_read_helper(ioread16, u16);
+define_rust_mmio_read_helper(ioread32, u32);
+
+define_rust_mmio_write_helper(iowrite8, u8);
+define_rust_mmio_write_helper(iowrite16, u16);
+define_rust_mmio_write_helper(iowrite32, u32);
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 70621a016a87..3d8b6e731ce7 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -483,3 +483,89 @@ fn addr(&self) -> usize {
         read32_unchecked, inl, write32_unchecked, outl, u32;
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
+#[derive(Debug)]
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


