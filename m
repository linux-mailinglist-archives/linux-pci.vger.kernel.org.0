Return-Path: <linux-pci+bounces-8946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D6990E014
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 01:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEAFCB21354
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 23:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E6F18FDD1;
	Tue, 18 Jun 2024 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGFJ0Mko"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53286185E70
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754077; cv=none; b=GzlMjbL1Lnbe01fY9GQ7V5A7LZXUo2IRrohRHDlApqCloD+Asp+gj1vZBTw7y8F3Slty0hgrqyKmeu3a7jMQqOkyI54O09iRg9PD0qxB24eASKkYF4Qs/nzjpS+Y8KWE727lRLiKDjzE3imy328zwb95rILOcde+xnL7PnCjkro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754077; c=relaxed/simple;
	bh=zvACUlV8IBXU/pD3ic7mnNuB1qziSw9soNd8mfHLC0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAWQoRCfJ1puKQA+/iyfUtXp3GeZi5jbciCmZnSNINFN25dRRsPFwnn6IsJn0kBZAc2aSjH3kYd2tQcvw6erGskf//idMt+9aBElNMXdqg+tcV9s5dLYyrSLjCp2Ib8crwZB7iZ0PGBskZsfT1GfoB1jhtzl1hSKhEOgx0Ik1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGFJ0Mko; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718754074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pc4rm2j75XYt4xCDuTDl+9iM4dO3yt5GwjGMzNcQwQ=;
	b=RGFJ0Mkowo+V/HrXXURf/wkPvjwWLUFA3fYTPFdzNbeeyvok/I7GUlOnQpLWQpFj8Pl9sY
	zAJCOlxc62myw3MZVZpy2rIdUo/kHhHGkmbopb/MwU+f8YxOabeGxCAokG8t59DDYwZSB8
	9Rcfy/d+I2JV4BDF29Z2t2a3oGnYUQM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-mSrmhyveMoS1ZJoJkuXZVg-1; Tue, 18 Jun 2024 19:41:13 -0400
X-MC-Unique: mSrmhyveMoS1ZJoJkuXZVg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52c989652e6so4072565e87.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 16:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754071; x=1719358871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pc4rm2j75XYt4xCDuTDl+9iM4dO3yt5GwjGMzNcQwQ=;
        b=LI5FbC+1fYIeabneDDdAz7TiBVWREmbybss4SFZ3on0z5whYBk8s/sinKm91BGZpvY
         LhgOT7IrWTStYDAadYAmVkxrHTLd2/9LSkZMZuCTO38omXOfi7Hk6lA1mJWmyQLbk0AS
         b1zJFEBEfwOwxM+LLXVD6NLJJzr8fWVFE41tF+ml1+0hGpMiTQ9yCi98DqqtXjTkuF+p
         1TCVm34YVFqFcdthq1JJImDIFDwid3wU07y66SFy3XHtay4Yvgg1BKFN+bShVaDWPmUW
         tCBYh3oTdR2C0zWvQpHBkjTo+67zYo177kg9fJWLP+kjPschZhWk/kLsfkJkxfJ1hUv6
         2UDw==
X-Forwarded-Encrypted: i=1; AJvYcCVj4RVzVL5z9DNzncU5Qg/kv502+VLUmTT2vIh6xODEhxse7QabHQRL8E3aBmxy1WsVwGAYNWIztyhno9ypkxZsoegBdIin3ms8
X-Gm-Message-State: AOJu0Yx3/Cs7ZVNDK7BAzEX+qOPqSRBqoA3WMIa+h8bJRwr2snkuHQZR
	rjJi/HiSVNTFI8rftzaxthijZWueD/J5H2UkFIOybUgpvOfsFcau/6qCcIDjDqzr6/7tjo0l22G
	/479qIX8dGswzbrnhl6EP1rb6JzwUditgDKA98BuO1vDJQ/FrryQ2FnemfQ==
X-Received: by 2002:a05:6512:1283:b0:52c:5254:b625 with SMTP id 2adb3069b0e04-52ccaa53e28mr724797e87.52.1718754071308;
        Tue, 18 Jun 2024 16:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyhZD+H4cjxW/UXfmKccooFgq7bXcOlABZ65YfTv5CT4Ga/VtpKU0QwYIRw4WS5nhSk+d31Q==
X-Received: by 2002:a05:6512:1283:b0:52c:5254:b625 with SMTP id 2adb3069b0e04-52ccaa53e28mr724788e87.52.1718754070819;
        Tue, 18 Jun 2024 16:41:10 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36387d9b812sm47454f8f.26.2024.06.18.16.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 16:41:10 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2 07/10] rust: add `io::Io` base type
Date: Wed, 19 Jun 2024 01:39:53 +0200
Message-ID: <20240618234025.15036-8-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618234025.15036-1-dakr@redhat.com>
References: <20240618234025.15036-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I/O memory is typically either mapped through direct calls to ioremap()
or subsystem / bus specific ones such as pci_iomap().

Even though subsystem / bus specific functions to map I/O memory are
based on ioremap() / iounmap() it is not desirable to re-implement them
in Rust.

Instead, implement a base type for I/O mapped memory, which generically
provides the corresponding accessors, such as `Io::readb` or
`Io:try_readb`.

`Io` supports an optional const generic, such that a driver can indicate
the minimal expected and required size of the mapping at compile time.
Correspondingly, calls to the 'non-try' accessors, support compile time
checks of the I/O memory offset to read / write, while the 'try'
accessors, provide boundary checks on runtime.

`Io` is meant to be embedded into a structure (e.g. pci::Bar or
io::IoMem) which creates the actual I/O memory mapping and initializes
`Io` accordingly.

To ensure that I/O mapped memory can't out-live the device it may be
bound to, subsystems should embedd the corresponding I/O memory type
(e.g. pci::Bar) into a `Devres` container, such that it gets revoked
once the device is unbound.

Co-developed-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/helpers.c     | 106 ++++++++++++++++++++++
 rust/kernel/io.rs  | 219 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   1 +
 3 files changed, 326 insertions(+)
 create mode 100644 rust/kernel/io.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 0ce40ccb978b..824b7c0b98dc 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errname.h>
+#include <linux/io.h>
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
@@ -181,6 +182,111 @@ void rust_helper_rcu_read_unlock(void)
 EXPORT_SYMBOL_GPL(rust_helper_rcu_read_unlock);
 /* end rcu */
 
+/* io.h */
+u8 rust_helper_readb(const volatile void __iomem *addr)
+{
+	return readb(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readb);
+
+u16 rust_helper_readw(const volatile void __iomem *addr)
+{
+	return readw(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readw);
+
+u32 rust_helper_readl(const volatile void __iomem *addr)
+{
+	return readl(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readl);
+
+#ifdef CONFIG_64BIT
+u64 rust_helper_readq(const volatile void __iomem *addr)
+{
+	return readq(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readq);
+#endif
+
+void rust_helper_writeb(u8 value, volatile void __iomem *addr)
+{
+	writeb(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writeb);
+
+void rust_helper_writew(u16 value, volatile void __iomem *addr)
+{
+	writew(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writew);
+
+void rust_helper_writel(u32 value, volatile void __iomem *addr)
+{
+	writel(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writel);
+
+#ifdef CONFIG_64BIT
+void rust_helper_writeq(u64 value, volatile void __iomem *addr)
+{
+	writeq(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writeq);
+#endif
+
+u8 rust_helper_readb_relaxed(const volatile void __iomem *addr)
+{
+	return readb_relaxed(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readb_relaxed);
+
+u16 rust_helper_readw_relaxed(const volatile void __iomem *addr)
+{
+	return readw_relaxed(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readw_relaxed);
+
+u32 rust_helper_readl_relaxed(const volatile void __iomem *addr)
+{
+	return readl_relaxed(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readl_relaxed);
+
+#ifdef CONFIG_64BIT
+u64 rust_helper_readq_relaxed(const volatile void __iomem *addr)
+{
+	return readq_relaxed(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readq_relaxed);
+#endif
+
+void rust_helper_writeb_relaxed(u8 value, volatile void __iomem *addr)
+{
+	writeb_relaxed(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writeb_relaxed);
+
+void rust_helper_writew_relaxed(u16 value, volatile void __iomem *addr)
+{
+	writew_relaxed(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writew_relaxed);
+
+void rust_helper_writel_relaxed(u32 value, volatile void __iomem *addr)
+{
+	writel_relaxed(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writel_relaxed);
+
+#ifdef CONFIG_64BIT
+void rust_helper_writeq_relaxed(u64 value, volatile void __iomem *addr)
+{
+	writeq_relaxed(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writeq_relaxed);
+#endif
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
new file mode 100644
index 000000000000..a19a1226181d
--- /dev/null
+++ b/rust/kernel/io.rs
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory-mapped IO.
+//!
+//! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
+
+use crate::error::{code::EINVAL, Result};
+use crate::{bindings, build_assert};
+
+/// IO-mapped memory, starting at the base address @addr and spanning @maxlen bytes.
+///
+/// The creator (usually a subsystem such as PCI) is responsible for creating the
+/// mapping, performing an additional region request etc.
+///
+/// # Invariant
+///
+/// `addr` is the start and `maxsize` the length of valid I/O remapped memory region.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::{bindings, io::Io};
+/// # use core::ops::Deref;
+///
+/// // See also [`pci::Bar`] for a real example.
+/// struct IoMem<const SIZE: usize>(Io<SIZE>);
+///
+/// impl<const SIZE: usize> IoMem<SIZE> {
+///     fn new(paddr: usize) -> Result<Self>{
+///
+///         // SAFETY: assert safety for this example
+///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE.try_into().unwrap()) };
+///         if addr.is_null() {
+///             return Err(ENOMEM);
+///         }
+///
+///         // SAFETY: `addr` is guaranteed to be the start of a valid I/O mapped memory region of
+///         // size `SIZE`.
+///         let io = unsafe { Io::new(addr as _, SIZE)? };
+///
+///         Ok(IoMem(io))
+///     }
+/// }
+///
+/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
+///     fn drop(&mut self) {
+///         // SAFETY: Safe as by the invariant of `Io`.
+///         unsafe { bindings::iounmap(self.0.base_addr() as _); };
+///     }
+/// }
+///
+/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
+///    type Target = Io<SIZE>;
+///
+///    fn deref(&self) -> &Self::Target {
+///        &self.0
+///    }
+/// }
+///
+/// let iomem = IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD).unwrap();
+/// iomem.writel(0x42, 0x0);
+/// assert!(iomem.try_writel(0x42, 0x0).is_ok());
+/// assert!(iomem.try_writel(0x42, 0x4).is_err());
+/// ```
+pub struct Io<const SIZE: usize = 0> {
+    addr: usize,
+    maxsize: usize,
+}
+
+macro_rules! define_read {
+    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) => {
+        /// Read IO data from a given offset known at compile time.
+        ///
+        /// Bound checks are performed on compile time, hence if the offset is not known at compile
+        /// time, the build will fail.
+        $(#[$attr])*
+        #[inline]
+        pub fn $name(&self, offset: usize) -> $type_name {
+            let addr = self.io_addr_assert::<$type_name>(offset);
+
+            unsafe { bindings::$name(addr as _) }
+        }
+
+        /// Read IO data from a given offset.
+        ///
+        /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
+        /// out of bounds.
+        $(#[$attr])*
+        pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
+            let addr = self.io_addr::<$type_name>(offset)?;
+
+            Ok(unsafe { bindings::$name(addr as _) })
+        }
+    };
+}
+
+macro_rules! define_write {
+    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) => {
+        /// Write IO data from a given offset known at compile time.
+        ///
+        /// Bound checks are performed on compile time, hence if the offset is not known at compile
+        /// time, the build will fail.
+        $(#[$attr])*
+        #[inline]
+        pub fn $name(&self, value: $type_name, offset: usize) {
+            let addr = self.io_addr_assert::<$type_name>(offset);
+
+            unsafe { bindings::$name(value, addr as _, ) }
+        }
+
+        /// Write IO data from a given offset.
+        ///
+        /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
+        /// out of bounds.
+        $(#[$attr])*
+        pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
+            let addr = self.io_addr::<$type_name>(offset)?;
+
+            unsafe { bindings::$name(value, addr as _) }
+            Ok(())
+        }
+    };
+}
+
+impl<const SIZE: usize> Io<SIZE> {
+    ///
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
+    /// `maxsize`.
+    pub unsafe fn new(addr: usize, maxsize: usize) -> Result<Self> {
+        if maxsize < SIZE {
+            return Err(EINVAL);
+        }
+
+        Ok(Self { addr, maxsize })
+    }
+
+    /// Returns the base address of this mapping.
+    #[inline]
+    pub fn base_addr(&self) -> usize {
+        self.addr
+    }
+
+    /// Returns the size of this mapping.
+    #[inline]
+    pub fn maxsize(&self) -> usize {
+        self.maxsize
+    }
+
+    #[inline]
+    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
+        let type_size = core::mem::size_of::<U>();
+        if let Some(end) = offset.checked_add(type_size) {
+            end <= size && offset % type_size == 0
+        } else {
+            false
+        }
+    }
+
+    #[inline]
+    fn io_addr<U>(&self, offset: usize) -> Result<usize> {
+        if !Self::offset_valid::<U>(offset, self.maxsize()) {
+            return Err(EINVAL);
+        }
+
+        // Probably no need to check, since the safety requirements of `Self::new` guarantee that
+        // this can't overflow.
+        self.base_addr().checked_add(offset).ok_or(EINVAL)
+    }
+
+    #[inline]
+    fn io_addr_assert<U>(&self, offset: usize) -> usize {
+        build_assert!(Self::offset_valid::<U>(offset, SIZE));
+
+        self.base_addr() + offset
+    }
+
+    define_read!(readb, try_readb, u8);
+    define_read!(readw, try_readw, u16);
+    define_read!(readl, try_readl, u32);
+    define_read!(
+        #[cfg(CONFIG_64BIT)]
+        readq,
+        try_readq,
+        u64
+    );
+
+    define_read!(readb_relaxed, try_readb_relaxed, u8);
+    define_read!(readw_relaxed, try_readw_relaxed, u16);
+    define_read!(readl_relaxed, try_readl_relaxed, u32);
+    define_read!(
+        #[cfg(CONFIG_64BIT)]
+        readq_relaxed,
+        try_readq_relaxed,
+        u64
+    );
+
+    define_write!(writeb, try_writeb, u8);
+    define_write!(writew, try_writew, u16);
+    define_write!(writel, try_writel, u32);
+    define_write!(
+        #[cfg(CONFIG_64BIT)]
+        writeq,
+        try_writeq,
+        u64
+    );
+
+    define_write!(writeb_relaxed, try_writeb_relaxed, u8);
+    define_write!(writew_relaxed, try_writew_relaxed, u16);
+    define_write!(writel_relaxed, try_writel_relaxed, u32);
+    define_write!(
+        #[cfg(CONFIG_64BIT)]
+        writeq_relaxed,
+        try_writeq_relaxed,
+        u64
+    );
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 601c3d3c9d54..f4dd11014a65 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -56,6 +56,7 @@
 
 #[doc(hidden)]
 pub use bindings;
+pub mod io;
 pub use macros;
 pub use uapi;
 
-- 
2.45.1


