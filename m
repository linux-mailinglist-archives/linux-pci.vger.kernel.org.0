Return-Path: <linux-pci+bounces-15055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02439AB891
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDD81C23164
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2563D1CFECA;
	Tue, 22 Oct 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYM0PmzN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79851CCEED;
	Tue, 22 Oct 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632797; cv=none; b=XoaMs1me2vMWItvpT7bNtFqKkpb2LUBjKoPG5K+KlZQtfmcrjCTX6Gy9lhaA2olCG7lGRIWcK/ejxn9qhiAvUsDc9sbS8BL6YrKDXyUuRRhKYowWIvhrMEs6sYkVT66cJuadwQNqavUHcR8hiNtjtQDHC9k7jNFCPRskniuO/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632797; c=relaxed/simple;
	bh=zMwd+PwXLeh2FtxkkTa0m0kTjUL8WGaTf3+bCzOAhaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qui0m90y7PBA+Z6wtahUKhGLcWirgukbVwaVDNmd3vi3oIKN+ehmsr92Xd7JgJmnqzoyVpgdb35JxBs+tqagKwfpDZj6131VnOKUi1AizeyzbTwbvFwl7lhpmBYm4LCoZj0AePB48F+n1YEuhRhHH7itiUjor/x0f0CWaCaouX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYM0PmzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF91C4CEE3;
	Tue, 22 Oct 2024 21:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632796;
	bh=zMwd+PwXLeh2FtxkkTa0m0kTjUL8WGaTf3+bCzOAhaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYM0PmzNGtHxSwPG76pIEclci8X6cIJ7yYG4burJUSUgvAW/HrQ+GWDkZLKMYQveQ
	 11Eao0BZHiNGi3qzyY0Z+82l49iJCO9dY85INwFrqRrtpLYytY3n68r6boP/wDlp1H
	 UFknV/mlULP7SBwvsIPE75xzDxEQikg5rXV5TOzJd9nSkA3Y+pTgm2yPy3bTW2T4xm
	 nfZX1addpdC6TR0Xzgz7d0lhi5YR88jfb2pF82vVN/g6j0svre7eNHN1BOF5VCZa29
	 3KD85a/RVEW7XJPhpmO8tMnHAqn0P/fgrZMzmMCf6LRVU0LzEionPkJFySaHKCl2rl
	 P6rQv4KdRyl2g==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	tmgross@umich.edu,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com,
	saravanak@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@google.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 08/16] rust: add `dev_*` print macros.
Date: Tue, 22 Oct 2024 23:31:45 +0200
Message-ID: <20241022213221.2383-9-dakr@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022213221.2383-1-dakr@kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
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
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs  | 319 ++++++++++++++++++++++++++++++++++++++++-
 rust/kernel/prelude.rs |   2 +
 2 files changed, 320 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 851018eef885..0c28b1e6b004 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -8,7 +8,10 @@
     bindings,
     types::{ARef, Opaque},
 };
-use core::ptr;
+use core::{fmt, ptr};
+
+#[cfg(CONFIG_PRINTK)]
+use crate::c_str;
 
 /// A reference-counted device.
 ///
@@ -82,6 +85,110 @@ pub unsafe fn as_ref<'a>(ptr: *mut bindings::device) -> &'a Self {
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
 
 // SAFETY: Instances of `Device` are always reference-counted.
@@ -103,3 +210,213 @@ unsafe impl Send for Device {}
 // SAFETY: `Device` can be shared among threads because all immutable methods are protected by the
 // synchronization in `struct device`.
 unsafe impl Sync for Device {}
+
+#[doc(hidden)]
+#[macro_export]
+macro_rules! dev_printk {
+    ($method:ident, $dev:expr, $($f:tt)*) => {
+        {
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
+/// [`core::fmt`] and `alloc::format!`.
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
+/// [`core::fmt`] and `alloc::format!`.
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
+/// [`core::fmt`] and `alloc::format!`.
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
+/// [`core::fmt`] and `alloc::format!`.
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
+/// [`core::fmt`] and `alloc::format!`.
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
+/// [`core::fmt`] and `alloc::format!`.
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
+/// [`core::fmt`] and `alloc::format!`.
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
+/// [`core::fmt`] and `alloc::format!`.
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
index 8bdab9aa0d16..9ab4e0b6cbc9 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -24,6 +24,8 @@
 // `super::std_vendor` is hidden, which makes the macro inline for some reason.
 #[doc(no_inline)]
 pub use super::dbg;
+pub use super::fmt;
+pub use super::{dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, dev_info, dev_notice, dev_warn};
 pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
 
 pub use super::{init, pin_init, try_init, try_pin_init};
-- 
2.46.2


