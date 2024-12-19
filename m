Return-Path: <linux-pci+bounces-18802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5100C9F813E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 18:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5374E167860
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E03A1B422B;
	Thu, 19 Dec 2024 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfvIoyuF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9941B4221;
	Thu, 19 Dec 2024 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627963; cv=none; b=KyaYRujGz1I+FA4h+1O9dfoBsti2Qez3OMno/p+GSknF63JIdWEBtiA+XhwwRhEem+Q+fhY1hKeJ/hv8Fssd8EYdDXUaETLz4ZLWPi0ihCq90rEls7XI58Fj+5EabMFGWpEcYLs6srDLWIwXiXgxjZcHpxEvUDwQ8gdH85LTMNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627963; c=relaxed/simple;
	bh=zdeZqUkhnQ1ZXijSEcZxULhSXuBX39UFyXzYg6i8/YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOVWDnb5h+osdIDHJrY+RvGpLE+ddRHhCt7fi7IVqZJ4SjGn8J0Wi5p+hyCodAuPaSGc4NScosbwcqFFu7Us3KBkm5/bWXCkltzgUBEUpKghu8x9d+Tu0j4caLZLBAvYApZT97oC8B0EsA3HI2z5e3ZVYSaUMmSgZACoIYQXy5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfvIoyuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EB5C4CED6;
	Thu, 19 Dec 2024 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627962;
	bh=zdeZqUkhnQ1ZXijSEcZxULhSXuBX39UFyXzYg6i8/YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfvIoyuFMS89JQPIFfeBRaP21xM4zEhlhyxMLCJN7Z+zPHzh4tZSZTK5JtwTVaDPJ
	 Hyfx6RgHMCCgxYSuwL0Hb9g7Ahe9MQuItl3lj8hZ6r3fE8kKxRZ5uqB0xjIBByXJRi
	 NFNrguO0Ku71c79MvrcReObrPpEMADa0fmznR+QhxNw9xyhHypj5nzP/N1CZqIMkyp
	 dr6g/OiZ2aj3m2Z+yVr8+SswgRcYAF91+Dvpv2VpF+qz7M2gLT5fF9J8ao7IkPtT5k
	 7GOjwZMaUPFNHOO+agTUEXPB7xZHxp6fWeCwqI2lYFwSUev15vyZHsV3KDZyoOVDWX
	 avRO8kRH+n/bg==
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
Subject: [PATCH v7 13/16] rust: driver: implement `Adapter`
Date: Thu, 19 Dec 2024 18:04:15 +0100
Message-ID: <20241219170425.12036-14-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219170425.12036-1-dakr@kernel.org>
References: <20241219170425.12036-1-dakr@kernel.org>
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
 rust/kernel/driver.rs           | 58 ++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

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
index c1957ee7bb7e..c630e65098ed 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -6,7 +6,7 @@
 //! register using the [`Registration`] class.
 
 use crate::error::{Error, Result};
-use crate::{init::PinInit, str::CStr, try_pin_init, types::Opaque, ThisModule};
+use crate::{device, init::PinInit, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
 use core::pin::Pin;
 use macros::{pin_data, pinned_drop};
 
@@ -115,3 +115,59 @@ fn init(
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
+            Some(table.info(<of::DeviceId as crate::device_id::RawDeviceId>::index(id)))
+        }
+    }
+
+    #[cfg(not(CONFIG_OF))]
+    #[allow(missing_docs)]
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


