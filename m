Return-Path: <linux-pci+bounces-18073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0489EBE47
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF46E286038
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D05B225A53;
	Tue, 10 Dec 2024 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8pa0ypY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29571EE7BD;
	Tue, 10 Dec 2024 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871082; cv=none; b=XRApYnUwEKHiLKhbMUi2eJJ+QVp4ixrCpKrarFlt9I+Q14Obk1ztrxj2EjnKTp3DJhIovhPBSoIO3fiM6ewcZg0IhJviOmShQKm/7TXeraGRVYLvy1f7RWK6/B+pkvrrKX5WgtXL3xSGuVNgpwV3Lu045Rb7q1juLA6vdkqyftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871082; c=relaxed/simple;
	bh=G82NOJZHyH6ULzotBAiLVDncCdayd7kGRmb8TyDikAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOlNiS4jw9Zsnd3J0QR/M+1BdjPXflgdrkHu1U1LPQpy8MPZNtLwNa86drPbV4n7/hdU3KrT2k+gWmV43QtNMlg9RCT5yY41b0vj1KeBjNqZ8yc0vlReEVJlaLMTbEeflM1G6BuQeO2/5cKuKHg6DJxpIck7So9aO+Xx0Hd4L6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8pa0ypY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C949CC4CEE0;
	Tue, 10 Dec 2024 22:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871081;
	bh=G82NOJZHyH6ULzotBAiLVDncCdayd7kGRmb8TyDikAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8pa0ypYAZiYq0hdyoSrIBQvMVo0ftI6v/8AWlaJjM4UxHUxMJBfc97Zdr1kYnnQx
	 nHmyLRT5lYxPAdoc8JUZDWEfOmDetvYYGrhiA0NB5r8Ihtb8vnkfkpItd/AP3uzagA
	 0vZVh2A1BhL/iXm+rSD4JO3El9ftZrYx461xuXXeaEIrvuzv2Tj791uU1/qJQ6a/sI
	 vWvFIVcNcxFhUyjllskwcrrKG1kjtu2I/fO03zQHY1HsQR7/7jZKwuyXr9l9Fy9tgB
	 ZuBGkFgSiMtVSkHqR69a3LCNehhClCbWp7/BQoUo2CHS/OZyV6lvc80md6pU0Iihjk
	 iwRs7Lt1NhnnQ==
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
	saravanak@google.com,
	dirk.behme@de.bosch.com,
	j@jannau.net,
	fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v5 13/16] rust: driver: implement `Adapter`
Date: Tue, 10 Dec 2024 23:46:40 +0100
Message-ID: <20241210224947.23804-14-dakr@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210224947.23804-1-dakr@kernel.org>
References: <20241210224947.23804-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to not duplicate code in bus specific implementations (e.g.
platform), implement a generic `driver::Adapter` to represent the
connection of matched drivers and devices.

Bus specific `Adapter` implementations can simply implement this trait
to inherit generic functionality, such as matching OF or ACPI device IDs
and ID table entries.

Suggested-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/driver.rs | 59 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index ab0bb46fe2cc..d169899a5da1 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -6,7 +6,9 @@
 //! register using the [`Registration`] class.
 
 use crate::error::{Error, Result};
-use crate::{init::PinInit, str::CStr, try_pin_init, types::Opaque, ThisModule};
+use crate::{
+    device, device_id, init::PinInit, of, str::CStr, try_pin_init, types::Opaque, ThisModule,
+};
 use core::pin::Pin;
 use macros::{pin_data, pinned_drop};
 
@@ -114,3 +116,58 @@ macro_rules! module_driver {
         }
     }
 }
+
+/// The bus independent adapter to match a drivers and a devices.
+///
+/// This trait should be implemented by the bus specific adapter, which represents the connection
+/// of a device and a driver.
+///
+/// It provides bus independent functions for device / driver interactions.
+pub trait Adapter {
+    /// The type holding driver private data about each device id supported by the driver.
+    type IdInfo: 'static;
+
+    /// The [`of::IdTable`] of the corresponding driver.
+    fn of_id_table() -> of::IdTable<Self::IdInfo>;
+
+    /// Returns the driver's private data from the matching entry in the [`of::IdTable`], if any.
+    ///
+    /// If this returns `None`, it means there is no match with an entry in the [`of::IdTable`].
+    #[cfg(CONFIG_OF)]
+    fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+        let table = Self::of_id_table();
+
+        // SAFETY:
+        // - `table` has static lifetime, hence it's valid for read,
+        // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
+        let raw_id = unsafe { bindings::of_match_device(table.as_ptr(), dev.as_raw()) };
+
+        if raw_id.is_null() {
+            None
+        } else {
+            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
+            // does not add additional invariants, so it's safe to transmute.
+            let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
+
+            Some(table.info(<of::DeviceId as device_id::RawDeviceId>::index(id)))
+        }
+    }
+
+    #[cfg(not(CONFIG_OF))]
+    fn of_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
+        None
+    }
+
+    /// Returns the driver's private data from the matching entry of any of the ID tables, if any.
+    ///
+    /// If this returns `None`, it means that there is no match in any of the ID tables directly
+    /// associated with a [`device::Device`].
+    fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+        let id = Self::of_id_info(dev);
+        if id.is_some() {
+            return id;
+        }
+
+        None
+    }
+}
-- 
2.47.0


