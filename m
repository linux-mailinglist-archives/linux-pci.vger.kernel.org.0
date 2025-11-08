Return-Path: <linux-pci+bounces-40640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF307C43032
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 17:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C1A3AEEB6
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFE1221294;
	Sat,  8 Nov 2025 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbkmHxGW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB0421C163
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762620935; cv=none; b=IdUMxtODAswpz2ifmcTJXgDaJEkN9XHVUP4dqw4MAPPdi5OOrAeXypOK+xdQ+UmBlm/TkeKG3vW+pKSQEoDHnxTXK50z4PqOu4nxPJv/JHhWAWv1kl93fbn6pGmCXS29dUYRHgWpxhcHNVmw11aMdC+N9ip3TOHtpWrJ+w5OCYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762620935; c=relaxed/simple;
	bh=GVUuC2fy2XU/fv4+p+YVtdSoHU3S//UTllww5EZKxAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnxE1AyXmdU5aBEo+Xyp9D0oFkvtBcr7TP5mVoePuk6+R7Q5fTl+3N0Ad9sJuiuwpIRf6HJEHZ63f80RzxelcZWFHL+pnobFU2Cfo9u2ulg06kCItOLKumy4nM5y38mB5STG3s6rA+vmiAUNyERJB7da5QBYt1A9OyOy0mrD/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbkmHxGW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso1463545b3a.3
        for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 08:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762620933; x=1763225733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfa0z+UQO6yPcSPdZFfLbPGOinvzfqyizepJWfWVugE=;
        b=DbkmHxGWioCkZx25jyb8Qezw5paJvwTDxlKB2UEwkHVlYc1SX1WroRv3JDbcvWclrg
         zPRcVKZ0lPVVgVkBjxpYlij/HTSzjmJOE4eT3eCzncIH81obauiOTONIXmpbo/6fD5Tu
         iX1ly8pozsMdlj9FEJxjfVOanB1MNscYVRL/00qgREE7Uz6lyMnWHmkvmGiozESds8oH
         ig7LYSsiixC4q5n7ONLGEm90hbIZiBmcf4DIIIMYWBydSDl0etBmu4o3jRO0tuArXrMm
         vO0ZbEknHpzgiAtDTKnSMELgojOnqWG4N0EcBiHCODtlEAqkHA/KjR0b9/1K/qOymrun
         sRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762620933; x=1763225733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lfa0z+UQO6yPcSPdZFfLbPGOinvzfqyizepJWfWVugE=;
        b=OJCBj+0m0+7qDGhoq9XXTE93aQmFn1B5jaIzYwa5l2omAbE37mMlkICkxQn6hyht8G
         mcMXzVrboFJLNjIEVWUZQzJjSP+VehJZ7UsBXxy9fea4I9gDYht/CvH0tIWYBL/1RyNJ
         WH9tO4Su/ZFUqLFl0PVoBfVsD3Zh5qkkSjFb5OtpOnkqD9QM54u803MWXxmU1chFmPhl
         +993t/YllQ5iA+gHgkSHSgjzUQqcBftb44R5LaFFwYVwlXfgmAtCbrg9nhXTlVD6BaI8
         Tmwj+E1+F9ZKuVUob8fTokKpeUqoq8nJqkwfYzMZvCfLqRpimshpEUIZNGzxyG2r5EGO
         NEeA==
X-Forwarded-Encrypted: i=1; AJvYcCUSPO/oLgAw8Ej/dQFx5Aj0eeSqr3ZsvP72vQoXVIOoCl00Esldl1d+QSi+AFR+2G9sc3ZbByj5siM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/q39yD7zMwUfcQfKY4IvOFMVF7pbT5TcSK8YRphH5KpKZa4sa
	bMVeZePpCcmaYRqjhWgCn0hQRIdFvIPLpNZiZztOK/Yq0ZfU6sAlvYIA
X-Gm-Gg: ASbGnctAF1Zo65JoGIeJMQv8Yy7YOVX5I4XVUdGAXuAZi0OTlQETtx8VeH9JS+5Mzud
	Hx0SZ6mWEP52xEkLDeaYIbTwjLaestH+wSLX/Zx7PXiYE5fexQ8dFDZdYWqQ9yOXKk4O3JfaPaL
	zalDHsMmf0fWjmWWfxmX1ZHDt3pyJ/6xwu2DfxS1XptbtpVefsMtJ0n6QL0CYDJSKUWO8q+JfTc
	Z8tGxSyLRZPmi1+hvXc5xdsitzxTbfftaavI7fVUggmRLRqYFuvn8zXJaZhX+3oSqCoupJKMO2Q
	K1mA5mWoPOUUJslAdMY5RlNBGKXa0r9VUGpNR/uhSNOGpE2LAah3JYPwP918+4UJO0OSlh0m9kn
	ntcO3OzbU05GlO7sMyM2WI/PDRodeaCT5CRFWlHWvJUicWMielW3XpAP9MmtBQrpEqO1Fi0oLDW
	g4qAdOnClZ5wpUl3Gwj5osteL+Kg3W76JSSQVSIj8zJNl9wUn8oiBh8iYovZ+7
X-Google-Smtp-Source: AGHT+IEfnEipPO2csirPutJrNuJd3yrwHgpaw0FqT9YBv+eiOHV3d1CaNtZHRbJHir19k7Fvsh4rgg==
X-Received: by 2002:a05:6a21:48f:b0:334:97dd:c5b4 with SMTP id adf61e73a8af0-353a23d2a25mr3798516637.27.1762620932714;
        Sat, 08 Nov 2025 08:55:32 -0800 (PST)
Received: from localhost.localdomain ([119.127.199.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba901c3817csm8181254a12.30.2025.11.08.08.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:55:32 -0800 (PST)
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [RFC PATCH v1 1/2] rust: pci: add PCIe bus error handler support
Date: Sat,  8 Nov 2025 16:55:10 +0000
Message-ID: <20251108165511.98546-2-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251108165511.98546-1-jckeep.cuiguangbo@gmail.com>
References: <20251108165511.98546-1-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch introduces Rust abstractions for PCIe Advanced Error Reporting
(AER) and general PCI bus error handling. It provides safe bindings for
the struct pci_error_handlers callbacks, allowing Rust PCI drivers to
implement device-specific recovery logic for events such as MMIO
restoration, slot reset, and fatal/correctable error notifications.

The new ErrorHandler trait defines the equivalent of the C
pci_error_handlers interface, including all callback methods, along
with Rust enums ErsResult and ChannelState that mirror the kernel's
pci_ers_result_t and pci_channel_state_t.

This enables fully type-safe integration between Rust PCI drivers and
the Linux PCI error recovery infrastructure.

Existing Rust PCI sample drivers are updated to specify a default
ErrorHandler = () until they implement custom error handling.

Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 rust/kernel/pci.rs                    |  11 ++
 rust/kernel/pci/err.rs                | 273 ++++++++++++++++++++++++++
 samples/rust/rust_dma.rs              |   1 +
 samples/rust/rust_driver_auxiliary.rs |   2 +
 samples/rust/rust_driver_pci.rs       |   2 +
 5 files changed, 289 insertions(+)
 create mode 100644 rust/kernel/pci/err.rs

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 7fcc5f6022c1..24c82305f195 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -24,8 +24,10 @@
 };
 use kernel::prelude::*;
 
+mod err;
 mod id;
 
+pub use self::err::{ChannelState, ErrorHandler, ErsResult};
 pub use self::id::{Class, ClassMask, Vendor};
 
 /// An adapter for the registration of PCI drivers.
@@ -47,6 +49,7 @@ unsafe fn register(
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*pdrv.get()).err_handler = err::ErrorHandlerVTable::<T::ErrorHandler>::vtable_ptr();
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
@@ -265,6 +268,14 @@ pub trait Driver: Send {
     // ```
     type IdInfo: 'static;
 
+    /// The PCI error handler implementation for this driver.
+    // TODO: Use `associated_type_defaults` once stabilized:
+    //
+    // ```
+    // type ErrorHandler: err::ErrorHandler = ();
+    // ```
+    type ErrorHandler: err::ErrorHandler;
+
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
 
diff --git a/rust/kernel/pci/err.rs b/rust/kernel/pci/err.rs
new file mode 100644
index 000000000000..d61520563bc3
--- /dev/null
+++ b/rust/kernel/pci/err.rs
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! PCI error handling abstractions.
+//!
+//! This module provides traits and types to handle PCI bus errors in Rust PCI drivers.
+
+use core::marker::PhantomData;
+
+use kernel::prelude::*;
+
+use crate::{
+    device,
+    error::VTABLE_DEFAULT_ERROR, //
+};
+
+use super::Device;
+
+/// Result type for PCI error handling operations.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+#[repr(u32)]
+pub enum ErsResult {
+    /// No result/none/not supported in device driver
+    None = bindings::pci_ers_result_PCI_ERS_RESULT_NONE,
+    /// Device driver can recover without slot reset
+    CanRecover = bindings::pci_ers_result_PCI_ERS_RESULT_CAN_RECOVER,
+    /// Device driver wants slot to be reset
+    NeedReset = bindings::pci_ers_result_PCI_ERS_RESULT_NEED_RESET,
+    /// Device has completely failed, is unrecoverable
+    Disconnect = bindings::pci_ers_result_PCI_ERS_RESULT_DISCONNECT,
+    /// Device driver is fully recovered and operational
+    Recovered = bindings::pci_ers_result_PCI_ERS_RESULT_RECOVERED,
+    /// No AER capabilities registered for the driver
+    NoAerDriver = bindings::pci_ers_result_PCI_ERS_RESULT_NO_AER_DRIVER,
+}
+
+impl ErsResult {
+    fn into_c(self) -> bindings::pci_ers_result_t {
+        self as bindings::pci_ers_result_t
+    }
+}
+
+/// PCI channel state representation.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+#[repr(u32)]
+pub enum ChannelState {
+    /// I/O channel is in normal state
+    Normal = bindings::pci_channel_io_normal,
+    /// I/O to channel is blocked
+    Frozen = bindings::pci_channel_io_frozen,
+    /// PCI card is dead
+    PermanentFailure = bindings::pci_channel_io_perm_failure,
+}
+
+impl TryFrom<u32> for ChannelState {
+    type Error = kernel::error::Error;
+
+    fn try_from(value: u32) -> Result<Self> {
+        match value {
+            bindings::pci_channel_io_normal => Ok(ChannelState::Normal),
+            bindings::pci_channel_io_frozen => Ok(ChannelState::Frozen),
+            bindings::pci_channel_io_perm_failure => Ok(ChannelState::PermanentFailure),
+            _ => Err(kernel::error::code::EINVAL),
+        }
+    }
+}
+
+/// PCI bus error handler trait.
+#[vtable]
+pub trait ErrorHandler {
+    /// The driver type associated with this error handler.
+    type Driver;
+
+    /// PCI bus error detected on this device
+    fn error_detected(
+        _dev: &Device<device::Bound>,
+        _error: ChannelState,
+        _this: Pin<&Self::Driver>,
+    ) -> ErsResult {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// MMIO has been re-enabled, but not DMA
+    fn mmio_enabled(_dev: &Device<device::Bound>, _this: Pin<&Self::Driver>) -> ErsResult {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// PCI slot has been reset
+    fn slot_reset(_dev: &Device<device::Bound>, _this: Pin<&Self::Driver>) -> ErsResult {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// PCI function reset prepare
+    fn reset_prepare(_dev: &Device<device::Bound>, _this: Pin<&Self::Driver>) {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// PCI function reset completed
+    fn reset_done(_dev: &Device<device::Bound>, _this: Pin<&Self::Driver>) {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Device driver may resume normal operations
+    fn resume(_dev: &Device<device::Bound>, _this: Pin<&Self::Driver>) {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Allow device driver to record more details of a correctable error
+    fn cor_error_detected(_dev: &Device<device::Bound>, _this: Pin<&Self::Driver>) {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+#[vtable]
+impl ErrorHandler for () {
+    type Driver = ();
+}
+
+/// A vtable for the error handler trait.
+pub(super) struct ErrorHandlerVTable<T: ErrorHandler>(PhantomData<T>);
+
+impl<T: ErrorHandler + 'static> ErrorHandlerVTable<T> {
+    extern "C" fn error_detected(
+        pdev: *mut bindings::pci_dev,
+        error: bindings::pci_channel_state_t,
+    ) -> bindings::pci_ers_result_t {
+        // SAFETY: The PCI bus only ever calls the error_detected callback with a valid pointer
+        // to a `struct pci_dev`.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `error_detected()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `error_detected` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T>>`.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<Pin<KBox<T::Driver>>>() };
+
+        let error = ChannelState::try_from(error).unwrap_or(ChannelState::PermanentFailure);
+
+        T::error_detected(pdev, error, data).into_c()
+    }
+
+    extern "C" fn mmio_enabled(pdev: *mut bindings::pci_dev) -> bindings::pci_ers_result_t {
+        // SAFETY: The PCI bus only ever calls the mmio_enabled callback with a valid pointer
+        // to a `struct pci_dev`.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `mmio_enabled()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `mmio_enabled` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T>>`.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<Pin<KBox<T::Driver>>>() };
+
+        T::mmio_enabled(pdev, data).into_c()
+    }
+
+    extern "C" fn slot_reset(pdev: *mut bindings::pci_dev) -> bindings::pci_ers_result_t {
+        // SAFETY: The PCI bus only ever calls the slot_reset callback with a valid pointer to a
+        // `struct pci_dev`.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `slot_reset()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `slot_reset` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T>>`.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<Pin<KBox<T::Driver>>>() };
+
+        T::slot_reset(pdev, data).into_c()
+    }
+
+    extern "C" fn reset_prepare(pdev: *mut bindings::pci_dev) {
+        // SAFETY: The PCI bus only ever calls the reset_prepare callback with a valid pointer to a
+        // `struct pci_dev`.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `reset_prepare()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `reset_prepare` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T>>`.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<Pin<KBox<T::Driver>>>() };
+
+        T::reset_prepare(pdev, data)
+    }
+
+    extern "C" fn reset_done(pdev: *mut bindings::pci_dev) {
+        // SAFETY: The PCI bus only ever calls the reset_done callback with a valid pointer to a
+        // `struct pci_dev`.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `reset_done()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `reset_done` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T>>`.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<Pin<KBox<T::Driver>>>() };
+
+        T::reset_done(pdev, data)
+    }
+
+    extern "C" fn resume(pdev: *mut bindings::pci_dev) {
+        // SAFETY: The PCI bus only ever calls the resume callback with a valid pointer to a
+        // `struct pci_dev`.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `resume()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `resume` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T>>`.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<Pin<KBox<T::Driver>>>() };
+
+        T::resume(pdev, data)
+    }
+
+    extern "C" fn cor_error_detected(pdev: *mut bindings::pci_dev) {
+        // SAFETY: The PCI bus only ever calls the cor_error_detected callback with a valid pointer
+        // to a `struct pci_dev`.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `cor_error_detected()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `cor_error_detected` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T>>`.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<Pin<KBox<T::Driver>>>() };
+
+        T::cor_error_detected(pdev, data)
+    }
+
+    const VTABLE: bindings::pci_error_handlers = bindings::pci_error_handlers {
+        error_detected: if T::HAS_ERROR_DETECTED {
+            Some(Self::error_detected)
+        } else {
+            None
+        },
+        mmio_enabled: if T::HAS_MMIO_ENABLED {
+            Some(Self::mmio_enabled)
+        } else {
+            None
+        },
+        slot_reset: if T::HAS_SLOT_RESET {
+            Some(Self::slot_reset)
+        } else {
+            None
+        },
+        reset_prepare: if T::HAS_RESET_PREPARE {
+            Some(Self::reset_prepare)
+        } else {
+            None
+        },
+        reset_done: if T::HAS_RESET_DONE {
+            Some(Self::reset_done)
+        } else {
+            None
+        },
+        resume: if T::HAS_RESUME {
+            Some(Self::resume)
+        } else {
+            None
+        },
+        cor_error_detected: if T::HAS_COR_ERROR_DETECTED {
+            Some(Self::cor_error_detected)
+        } else {
+            None
+        },
+    };
+
+    pub(super) const fn vtable_ptr() -> *const bindings::pci_error_handlers {
+        core::ptr::from_ref(&Self::VTABLE)
+    }
+}
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 4d324f06cc2a..ea0113a42446 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -53,6 +53,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
 
 impl pci::Driver for DmaSampleDriver {
     type IdInfo = ();
+    type ErrorHandler = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 55ece336ee45..b714be978fdf 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -56,6 +56,8 @@ struct ParentDriver {
 impl pci::Driver for ParentDriver {
     type IdInfo = ();
 
+    type ErrorHandler = ();
+
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 55a683c39ed9..11ed48dd9fbb 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -63,6 +63,8 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
 impl pci::Driver for SampleDriver {
     type IdInfo = TestIndex;
 
+    type ErrorHandler = ();
+
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
-- 
2.43.0


