Return-Path: <linux-pci+bounces-18315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666069EF229
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E65828B726
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419CE240376;
	Thu, 12 Dec 2024 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue99Vsso"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE69229690;
	Thu, 12 Dec 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021389; cv=none; b=m/bVFUgrLMp/8Mscs+ioE76lUyrMG65T3D9YpeoPv/GFbbs3JFv7HQ5AF0hnBLuDn1huHHbrKl8f1vFuZD9Or9nVgSFTJYgWm1TZYrEblr2ircES4N1k8aR3Mo5K7ItUanDTAdqgKSxTtqUMYZFpaepk7TlCvF0/UahT22neczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021389; c=relaxed/simple;
	bh=VgLwFqCA/KiVHxh3OdGxzRQekkZtdAiA0TylWdJBn0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6OHFutiIhFHr4iXsos7oaaa7CJXLxvF/Yyh7KbgkiASsDfLw/N8MCLtS0C/N7QgNyhXFwKyoZHAB7zm8XukCdYF5xfT0eBFg50KN3+yiehY3x5XKT5y8AE/2VkNiiCsYlervh+hCS0m2LR14pXmKkzbbumvMQSjB42/fDmEF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ue99Vsso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0BFC4CED3;
	Thu, 12 Dec 2024 16:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021386;
	bh=VgLwFqCA/KiVHxh3OdGxzRQekkZtdAiA0TylWdJBn0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ue99VssogHHrOicrH8c7cmH39XJ1JGopqe8rVxLXRkM7rjv9cGSvPSpGaROtq+lPf
	 4NMBhjojdXWb3kyQWhRw2FfucTUKv4GBqMCFE2Q8FBiKIe0qnNcmk8V4pck9NDiNG1
	 2c8jWfClGV1PiSEa0RwlLs5CnmgVFR48RHWUQNavX3nGg3rp/mFKzafClYUKUcWdFI
	 0EF51V8gaDCXSKannhTs8P4/4s+oEoxIg+hRmq9Kre9BQC6am/DNXPGTd/VliA+MAI
	 ge6WFv7xwJSYc0EoQtHXrUkYCcLFdrTpN2jvGqaIp1bZD5FOmEENhTgQ87k1qe+gnb
	 XR97RADbLzLfg==
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
	chrisi.schrefl@gmail.com,
	paulmck@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	rcu@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v6 13/16] rust: driver: implement `Adapter`
Date: Thu, 12 Dec 2024 17:33:44 +0100
Message-ID: <20241212163357.35934-14-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212163357.35934-1-dakr@kernel.org>
References: <20241212163357.35934-1-dakr@kernel.org>
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
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/driver.rs           | 59 ++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 6d7a68e2ecb7..8fe70183a392 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,6 +20,7 @@
 #include <linux/jump_label.h>
 #include <linux/mdio.h>
 #include <linux/miscdevice.h>
+#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index c1957ee7bb7e..63dbebbc0829 100644
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
 
@@ -115,3 +117,58 @@ fn init(
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
+    fn of_id_table() -> Option<of::IdTable<Self::IdInfo>>;
+
+    /// Returns the driver's private data from the matching entry in the [`of::IdTable`], if any.
+    ///
+    /// If this returns `None`, it means there is no match with an entry in the [`of::IdTable`].
+    #[cfg(CONFIG_OF)]
+    fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+        let table = Self::of_id_table()?;
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
2.47.1


