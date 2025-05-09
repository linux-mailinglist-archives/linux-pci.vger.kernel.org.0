Return-Path: <linux-pci+bounces-27478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203E0AB08B9
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CAF986D5A
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 03:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FD523D2AE;
	Fri,  9 May 2025 03:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOwdExAD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CC41E1DE8;
	Fri,  9 May 2025 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760595; cv=none; b=hTqy2ySPJhMzlqVQXbakMrkOVWgllYPLO+UzMz/ZjMRAZeZBNoukO0cYTdkvf0ES1fyo8HBm5tWrkGsZTxBPEOZCfDdHaO2YiMAJYFsoQ+J747wKB3JIlSJ/thOtWSPPGpkVQn2yvRUrX0+F0vCaq15gZ/VpL72XMF5ZhBSDl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760595; c=relaxed/simple;
	bh=GLtxsVu4AWGg3EinlzbF9Dn6fQ4Pm8pp3XtAi6Af2ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyNtQAruwbdEHJUIqow0fR8mapny3ehavruCm29e2G7ppT41xnJ0D0+nUHItbQziKhnp3V5fnCoyA1e040mzzDsk+z9DKcj48HJYeMGQUkSrNTYi+rqFMfqHL51MchexHkXGQxqHU7dzfVclOfab+OUFtHZTmmTIsEHI09pvB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOwdExAD; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-730580b0de8so1633862a34.1;
        Thu, 08 May 2025 20:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746760592; x=1747365392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEeMgcY7CYzVQOcJ2HEG+ye7cxvF4gydVYotaASGE1A=;
        b=YOwdExADxxDIloRrzWFp6A6c90tVU1r/93OxrpvgYn9qNyT0FGhTvj1nvldR7Zrupz
         iQoQSUep1EmuqVi0kY8pFcX4qW17up58bOQeTju6Pa3Qaw6w69DSniTyI/g+rrNX6Cmu
         d5JmdXq42DR6FUvxMjrTJHYKXU4ZkWcGYn3kmcaW9YHnwSZUMS5+t7rXJvBzeaViSy05
         RiifmU6agzdbfzWV5qWjIDee9Mn5l2G6ypHYuTv4w8MfkIIl96UNkvLWtOJRGvVQrPhO
         yOuoSlDozv9tVL6Ldj6WbIQLp3xegKbsM1IYlE8zU/20VpKRcFXtVwHCCE1o+DP2zgQn
         f/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746760592; x=1747365392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEeMgcY7CYzVQOcJ2HEG+ye7cxvF4gydVYotaASGE1A=;
        b=EzGknLJ/vhONmYoVgJL6pm2O1IYhY1tybVGTv+EMPtr7GaFyZGEj7nQxC+0At/6KIQ
         gvNGynjj4L8qNVW4EXj1OfA1Nj2p6n9QF0tz19MidveazAO1e3qHgJyEvcVmuGNW7MNp
         mgoEIyrpX7n87XNVEZudkNnwS/mSDU1woJ/VTNSfO/BRwHWlKaCK9bp72VyWRL5sIOOF
         rVbzPsvmCgPGMVcfGB5He6NyM4wdIlhX/ajoSrtsLlgQdS9SNfBvpATrVann90NscKfw
         Pl8k7qLf/eggUJhCZ4gEpyLsajTUzEEGg0515tPbheB7fOK6Qcw+9NiAzBSKShvjPxaY
         KBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlq9PmNLp+40W5aiumUHYGBKQAJgfJ737MdAq8O2jal5wATDiu8rHQU/LXcqeFqHxcetGKql0CP1U6X+w=@vger.kernel.org, AJvYcCVumoKMR0kN6cadYfkgzLY19hJ3yZfbtQ+j2r8DglIwQWJm3jsybXv9zTRhSKuWP7Fuhco9bhUNEAt8v1CBbTA=@vger.kernel.org, AJvYcCW61nH817WJfnCM5wGhola/4wRNQDoWslVsuakwSUqACR5H1M5AC963NmfU74z1Eo3R8k62NUHPq6/G@vger.kernel.org
X-Gm-Message-State: AOJu0YzoJ/ENh+bLFlxE+m8nzieq9g0DBmhFPWjYEHR6d/fh696ugzhs
	50O4s4+ApokKVhpuE1xnRMnCDKRRQ2es3HJyn7KXRrF35gfmC6c2
X-Gm-Gg: ASbGnct/HG1b5PuMg6hSwYOKEnMS3TPWckeyhqomXeP2hrstovn2H7VwpUciLPiWP9Z
	Ni7+GXMSXtjBU6WS9AV/p9MTOaOsoL7jUiaxhynj5W4SiUEbjO1NTWX1f3deHfjHwtrrKHaQtk6
	hLr4UU97Ddq5MeSiZfUjwTlx2s1CNi1h/ORgVhG5AD9nkiSs2HPZCQQUzSsam8uLNqakefxBRz4
	o77tjrtz7gtsTM/DOVZzQu8wLgmjW1JiH2gTDOsf45D8jNifWxAHqq8poKMLSKCwd//nqSJhCPQ
	cewDOGzGFq6Jmu4559TjvoIaUm43x1Q1V9APc4ewRsYUOSj/fb/pUnQPPMC2lragaqL6FB0jMZg
	/xtTqQzZv9C55
X-Google-Smtp-Source: AGHT+IG8QbL+NPZYYdJCHgbrLTq9vuR0ixK0ZuhhY5hEZoDmBaManE/qEIbt3DqDYTrXPyiE44aSCA==
X-Received: by 2002:a05:6808:309f:b0:400:d71c:ca26 with SMTP id 5614622812f47-40377957cf1mr3404635b6e.7.1746760592041;
        Thu, 08 May 2025 20:16:32 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60842b096desm303745eaf.30.2025.05.08.20.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 20:16:31 -0700 (PDT)
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
Subject: [PATCH 04/11] rust: io: add PortIo
Date: Thu,  8 May 2025 22:15:17 -0500
Message-ID: <20250509031524.2604087-5-andrewjballance@gmail.com>
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

From: Fiona Behrens <me@kloenk.dev>

Add `rust::io::PortIo` implementing the `IoAccess` trait.

Signed-off-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/helpers/io.c | 20 +++++++++++
 rust/kernel/io.rs | 88 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index 525af02f209e..d439b61c672e 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -51,3 +51,23 @@ define_rust_mmio_write_helper(writel_relaxed, u32);
 #ifdef CONFIG_64BIT
 define_rust_mmio_write_helper(writeq_relaxed, u64);
 #endif
+
+#define define_rust_pio_read_helper(name, type)     \
+	type rust_helper_##name(unsigned long port) \
+	{                                           \
+		return name(port);                  \
+	}
+
+#define define_rust_pio_write_helper(name, type)                \
+	void rust_helper_##name(type value, unsigned long port) \
+	{                                                       \
+		name(value, port);                              \
+	}
+
+define_rust_pio_read_helper(inb, u8);
+define_rust_pio_read_helper(inw, u16);
+define_rust_pio_read_helper(inl, u32);
+
+define_rust_pio_write_helper(outb, u8);
+define_rust_pio_write_helper(outw, u16);
+define_rust_pio_write_helper(outl, u32);
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 09440dd3e73b..70621a016a87 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -395,3 +395,91 @@ impl<const SIZE: usize> IoAccess64Relaxed<SIZE> for MMIo<SIZE> {
         read64_relaxed_unchecked, readq_relaxed, write64_relaxed_unchecked, writeq_relaxed, u64;
     );
 }
+
+/// Port-IO, starting at the base address [`addr`] and spanning [`maxsize`] bytes.
+///
+/// The creator is responsible for performing an additional region request, etc.
+///
+/// # Invariants
+///
+/// [`addr`] is the start and [`maxsize`] the length of a valid port io region of size [`maxsize`].
+///
+/// [`addr`] is valid to access with the C [`in`]/[`out`] family of functions.
+///
+/// [`addr`]: IoAccess::addr
+/// [`maxsize`]: IoAccess::maxsize
+/// [`in`]: https://docs.kernel.org/driver-api/device-io.html#differences-between-i-o-access-functions
+/// [`out`]: https://docs.kernel.org/driver-api/device-io.html#differences-between-i-o-access-functions
+#[derive(Debug)]
+#[repr(transparent)]
+pub struct PortIo<const SIZE: usize = 0>(IoRaw<SIZE>);
+
+impl<const SIZE: usize> PortIo<SIZE> {
+    /// Convert a [`IoRaw`] into an [`PortIo`] instance, providing the accessors to the
+    /// PortIo mapping.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `addr` is the start of a valid Port I/O region of size `maxsize`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::io::{IoRaw, PortIo, IoAccess};
+    ///
+    /// let raw = IoRaw::<2>::new(0xDEADBEEFC0DE, 2).unwrap();
+    /// // SAFETY: test, value is not actually written to.
+    /// let pio: PortIo<2> = unsafe { PortIo::from_raw(raw) };
+    /// # assert_eq!(0xDEADBEEFC0DE, pio.addr());
+    /// # assert_eq!(2, pio.maxsize());
+    /// ```
+    #[inline]
+    pub unsafe fn from_raw(raw: IoRaw<SIZE>) -> Self {
+        Self(raw)
+    }
+
+    /// Convert a ref to [`IoRaw`] into an [`PortIo`] instance, providing the accessors to
+    /// the PortIo mapping.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of
+    /// size `maxsize`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::io::{IoRaw, PortIo, IoAccess};
+    ///
+    /// let raw = IoRaw::<2>::new(0xDEADBEEFC0DE, 2).unwrap();
+    /// // SAFETY: test, value is not actually written to.
+    /// let pio: &PortIo<2> = unsafe { PortIo::from_raw_ref(&raw) };
+    /// # assert_eq!(raw.addr(), pio.addr());
+    /// # assert_eq!(raw.maxsize(), pio.maxsize());
+    /// ```
+    #[inline]
+    pub unsafe fn from_raw_ref(raw: &IoRaw<SIZE>) -> &Self {
+        // SAFETY: `PortIo` is a transparent wrapper around `IoRaw`.
+        unsafe { &*core::ptr::from_ref(raw).cast() }
+    }
+}
+
+// SAFETY: as per invariant `raw` is valid
+unsafe impl<const SIZE: usize> IoAccess<SIZE> for PortIo<SIZE> {
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.0.maxsize()
+    }
+
+    #[inline]
+    fn addr(&self) -> usize {
+        self.0.addr()
+    }
+
+    #[rustfmt::skip]
+    impl_accessor_fn!(
+        read8_unchecked, inb, write8_unchecked, outb, u8;
+        read16_unchecked, inw, write16_unchecked, outw, u16;
+        read32_unchecked, inl, write32_unchecked, outl, u32;
+    );
+}
-- 
2.49.0


