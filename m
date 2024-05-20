Return-Path: <linux-pci+bounces-7678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98098CA15B
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 19:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BF91F21CCA
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 17:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9581384A6;
	Mon, 20 May 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gg/pdnz2"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B013A3EF
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226047; cv=none; b=B3JIxBmEiF6f5O53jfnh88ljyTQRXiAmIiEWQarI4nCeK63t8UlhM+5iyFhsnjTDr2GSylCbxKf8k/R/JWe5cHMMXTm0QKGJ+zcP2ZGpgiorFpAsUOche7ySsMLiXLsH//da72RL0ZbzzUn8U+j1UUELUUbMqp/5me7XA3uyK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226047; c=relaxed/simple;
	bh=Z/Z6FQt+IfhzYJGtOfnWM7hOAZBD5lo+z7OWyx94ou4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHsq+kDBI82RNVlCZgLoLAy2Sba0V09x2CmPouErB3LKEWiFzzfPIelkr06ymZB0meCFJlUpIz2V8P4UgAlepNI3FsRDy6cYkgpRzycb+f0iBv3ilaGCiwcok7tf88czZOWdC7SiBUWdwZyflKFnlwc1sqWqyFtWqWBBTyGz6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gg/pdnz2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716226044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ykRJ38aWUQhPojOF0arCmW/c5j5xwBTUzFlxtSsGSA=;
	b=gg/pdnz24dAklWnuQx4VylVTXDgOvgEnOIPFwloF5ulEP7EwF+52q2kwvJ3TlYfdDqEqJT
	hfpLB5x3B0CV3BRti8Yxhmy2Ya0000cabF/U9h+zZ1OWMGzNLbilM5V8339M+WMYcqMVuK
	fUfKarTuuYI0z/8m/NLmiMNGkVghiBc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-86xex3CeNU6qDIxOVaKVgA-1; Mon, 20 May 2024 13:27:22 -0400
X-MC-Unique: 86xex3CeNU6qDIxOVaKVgA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-354c7c04325so643439f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 10:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226041; x=1716830841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ykRJ38aWUQhPojOF0arCmW/c5j5xwBTUzFlxtSsGSA=;
        b=rS03vjgYotD7tv0dM61mkdnm0/c8AYQXZLgMFLogsWDOWwJcuiHRqebrOqyu0ks9fR
         EfbpEx6FNBplrAE0iOgL3s/UIoi8K3MWDp+VWrYjYUcBVKZUThSTnYixA5eYim/vf24R
         ymhiAUbpKGR6jPRwkV7XVEUPfla0NZ48tMGZ0+oiyGhnTuVRNt7J3FwBAw3Pivfplnnm
         VKylXbw6QND7ywus7nqcChYhQDGJtLjJQ2IM42c5a+eK52mVO+pi3CQK9oglzMY1b+0x
         aCm3eWjbyeSKom4Dk3eAYWOQ1BY+Ny4abj97R+2oVKU8/u99kzxiVJkEdk7VivFyqP6W
         NxWA==
X-Forwarded-Encrypted: i=1; AJvYcCVcHurpIIlITLyxnPM73RFFQiqOc6xC/S8xkaqA7M9CmgpE7tGCdUPeHDC3JQ+quizL2Ch5gcPqqEm7lAids8c4CQ+fCunB0jM1
X-Gm-Message-State: AOJu0YzqmcbZhAUDZGjgI4TlnHddZYh1stZXL/Sqp8y2zuAyh/qP2ARX
	Xs4D3zWB/O5FScABMGDtnKwqj58hx7/ng77fGNGPrO2RUQyHyFJMrXTp4yYSDIbsXMdnc//tJri
	WX9g3hKH6iYPAVWGhUeVGWTZw80eSzrI0m8VS4yoTB8It5kVSw9JjJNhphQ==
X-Received: by 2002:a05:6000:1083:b0:350:2ba9:ca03 with SMTP id ffacd0b85a97d-354b8e6577cmr5817508f8f.23.1716226041243;
        Mon, 20 May 2024 10:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi7mAWZQwNorKfygViuMjJctRMt7yGRf02f78cLaq2jisR8KhggcCcLDZDt+WNalb6qNuquA==
X-Received: by 2002:a05:6000:1083:b0:350:2ba9:ca03 with SMTP id ffacd0b85a97d-354b8e6577cmr5817476f8f.23.1716226040747;
        Mon, 20 May 2024 10:27:20 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3525f7f7d88sm10352988f8f.57.2024.05.20.10.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:27:19 -0700 (PDT)
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
	lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@google.com>,
	Danilo Krummrich <dakr@redhat.com>
Subject: [RFC PATCH 07/11] rust: add `dev_*` print macros.
Date: Mon, 20 May 2024 19:25:44 +0200
Message-ID: <20240520172554.182094-8-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520172554.182094-1-dakr@redhat.com>
References: <20240520172554.182094-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <wedsonaf@google.com>

Implement `dev_*` print macros for `device::Device`.

They behave like the macros with the same names in C, i.e., they print
messages to the kernel ring buffer with the given level, prefixing the
messages with corresponding device information.

Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/device.rs  | 321 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/prelude.rs |   2 +
 2 files changed, 323 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index b1c3f7a0d623..2988aeb4e040 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -18,11 +18,15 @@
     types::{ARef, Opaque},
 };
 use core::{
+    fmt,
     ops::{Deref, DerefMut},
     pin::Pin,
     ptr,
 };
 
+#[cfg(CONFIG_PRINTK)]
+use crate::c_str;
+
 /// A ref-counted device.
 ///
 /// # Invariants
@@ -66,6 +70,110 @@ pub unsafe fn as_ref<'a>(ptr: *mut bindings::device) -> &'a Self {
         // SAFETY: Guaranteed by the safety requirements of the function.
         unsafe { &*ptr.cast() }
     }
+
+    /// Prints an emergency-level message (level 0) prefixed with device information.
+    ///
+    /// More details are available from [`dev_emerg`].
+    ///
+    /// [`dev_emerg`]: crate::dev_emerg
+    pub fn pr_emerg(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_EMERG, args) };
+    }
+
+    /// Prints an alert-level message (level 1) prefixed with device information.
+    ///
+    /// More details are available from [`dev_alert`].
+    ///
+    /// [`dev_alert`]: crate::dev_alert
+    pub fn pr_alert(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_ALERT, args) };
+    }
+
+    /// Prints a critical-level message (level 2) prefixed with device information.
+    ///
+    /// More details are available from [`dev_crit`].
+    ///
+    /// [`dev_crit`]: crate::dev_crit
+    pub fn pr_crit(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_CRIT, args) };
+    }
+
+    /// Prints an error-level message (level 3) prefixed with device information.
+    ///
+    /// More details are available from [`dev_err`].
+    ///
+    /// [`dev_err`]: crate::dev_err
+    pub fn pr_err(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_ERR, args) };
+    }
+
+    /// Prints a warning-level message (level 4) prefixed with device information.
+    ///
+    /// More details are available from [`dev_warn`].
+    ///
+    /// [`dev_warn`]: crate::dev_warn
+    pub fn pr_warn(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_WARNING, args) };
+    }
+
+    /// Prints a notice-level message (level 5) prefixed with device information.
+    ///
+    /// More details are available from [`dev_notice`].
+    ///
+    /// [`dev_notice`]: crate::dev_notice
+    pub fn pr_notice(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_NOTICE, args) };
+    }
+
+    /// Prints an info-level message (level 6) prefixed with device information.
+    ///
+    /// More details are available from [`dev_info`].
+    ///
+    /// [`dev_info`]: crate::dev_info
+    pub fn pr_info(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_INFO, args) };
+    }
+
+    /// Prints a debug-level message (level 7) prefixed with device information.
+    ///
+    /// More details are available from [`dev_dbg`].
+    ///
+    /// [`dev_dbg`]: crate::dev_dbg
+    pub fn pr_dbg(&self, args: fmt::Arguments<'_>) {
+        if cfg!(debug_assertions) {
+            // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+            unsafe { self.printk(bindings::KERN_DEBUG, args) };
+        }
+    }
+
+    /// Prints the provided message to the console.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `klevel` is null-terminated; in particular, one of the
+    /// `KERN_*`constants, for example, `KERN_CRIT`, `KERN_ALERT`, etc.
+    #[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
+    unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated and one of the kernel constants. `self.as_raw`
+        // is valid because `self` is valid. The "%pA" format string expects a pointer to
+        // `fmt::Arguments`, which is what we're passing as the last argument.
+        #[cfg(CONFIG_PRINTK)]
+        unsafe {
+            bindings::_dev_printk(
+                klevel as *const _ as *const core::ffi::c_char,
+                self.as_raw(),
+                c_str!("%pA").as_char_ptr(),
+                &msg as *const _ as *const core::ffi::c_void,
+            )
+        };
+    }
 }
 
 // SAFETY: Instances of `Device` are always ref-counted.
@@ -175,3 +283,216 @@ fn deref_mut(&mut self) -> &mut U {
         &mut self.general
     }
 }
+
+#[doc(hidden)]
+#[macro_export]
+macro_rules! dev_printk {
+    ($method:ident, $dev:expr, $($f:tt)*) => {
+        {
+            // We have an explicity `use` statement here so that callers of this macro are not
+            // required to explicitly use the `RawDevice` trait to use its functions.
+            use $crate::device::Device;
+            ($dev).$method(core::format_args!($($f)*));
+        }
+    }
+}
+
+/// Prints an emergency-level message (level 0) prefixed with device information.
+///
+/// This level should be used if the system is unusable.
+///
+/// Equivalent to the kernel's `dev_emerg` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_emerg!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_emerg {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_emerg, $($f)*); }
+}
+
+/// Prints an alert-level message (level 1) prefixed with device information.
+///
+/// This level should be used if action must be taken immediately.
+///
+/// Equivalent to the kernel's `dev_alert` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_alert!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_alert {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_alert, $($f)*); }
+}
+
+/// Prints a critical-level message (level 2) prefixed with device information.
+///
+/// This level should be used in critical conditions.
+///
+/// Equivalent to the kernel's `dev_crit` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_crit!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_crit {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_crit, $($f)*); }
+}
+
+/// Prints an error-level message (level 3) prefixed with device information.
+///
+/// This level should be used in error conditions.
+///
+/// Equivalent to the kernel's `dev_err` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_err!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_err {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_err, $($f)*); }
+}
+
+/// Prints a warning-level message (level 4) prefixed with device information.
+///
+/// This level should be used in warning conditions.
+///
+/// Equivalent to the kernel's `dev_warn` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_warn!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_warn {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_warn, $($f)*); }
+}
+
+/// Prints a notice-level message (level 5) prefixed with device information.
+///
+/// This level should be used in normal but significant conditions.
+///
+/// Equivalent to the kernel's `dev_notice` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_notice!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_notice {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_notice, $($f)*); }
+}
+
+/// Prints an info-level message (level 6) prefixed with device information.
+///
+/// This level should be used for informational messages.
+///
+/// Equivalent to the kernel's `dev_info` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_info!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_info {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_info, $($f)*); }
+}
+
+/// Prints a debug-level message (level 7) prefixed with device information.
+///
+/// This level should be used for debug messages.
+///
+/// Equivalent to the kernel's `dev_dbg` macro, except that it doesn't support dynamic debug yet.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_dbg!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_dbg {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_dbg, $($f)*); }
+}
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index b37a0b3180fb..c5765ab863d6 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -27,6 +27,8 @@
 // `super::std_vendor` is hidden, which makes the macro inline for some reason.
 #[doc(no_inline)]
 pub use super::dbg;
+pub use super::fmt;
+pub use super::{dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, dev_info, dev_notice, dev_warn};
 pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
 
 pub use super::{init, pin_init, try_init, try_pin_init};
-- 
2.45.1


