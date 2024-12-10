Return-Path: <linux-pci+bounces-18072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B4B9EBE44
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6444B16A288
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8678225A4A;
	Tue, 10 Dec 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1IMDY+2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86991EE7BD;
	Tue, 10 Dec 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871075; cv=none; b=o0oSg0r2a/qjmeysFrOG6ehyLvi6W5pdYQsSlZ4UMzv+jfeEgUWwQyFCzuN9L89TMKQFuqVtVFcVLGXiXxW9Ba9c93eqpWDMAXBW1J5HBnLWX4wOnBsW9JUojUUKKLGbF73wTQ3ws1ba0T2mxVPiIEGE9TIfyAYhsy5g14taSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871075; c=relaxed/simple;
	bh=jrVPWbBukBXtbshCtZsBtD+5zJ+mmtK9G1LjoUASO/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0Q0+qbkOWERlevRZ0VmkX6olLDlsEN2LP7uQyGjTGzzs/RhDYzdVkPW0/XooLaHmaOVU9eQTGj7/dHmtB7nFFU2PxQf7x2pKGuThkIwTfEGRwA34ZwadYWtoAvKTaaSvzmd48mBea+ggMKKu/Vs+2eVJXdF01i2DC6hlyWfr4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1IMDY+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A37FC4CED6;
	Tue, 10 Dec 2024 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871075;
	bh=jrVPWbBukBXtbshCtZsBtD+5zJ+mmtK9G1LjoUASO/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1IMDY+29O+cEbyQA6cJv9YotAGqZcQovG30eQd1dcxb2fNXgY11Iqhp9omSbsy8t
	 /mEjxhiw6+QviOIIhnc64Z6Rt/m/7aCptyaMeml2w8a+ne3sYU1Z2MXWQ2ptrjPgf4
	 SQK0pJs6CyhwSdZDccUQbIXGzWg7twofqP9XBiiK+70VXXHEIEm3t6dxytkPY6Kc9m
	 FUDoVhB4yLzuHOU+rkRiygcmlHdmEWDS0KPagVlwvchfE8gej1WBx9uWzNVeu6sysR
	 5LSgmslEpF1buvxC1oyFbYjcQij7oLFJpJaLQryhL0RPiLbUBEUwqFBzUiOJb1qF1t
	 py8WkKHBwTpVg==
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
Subject: [PATCH v5 12/16] rust: of: add `of::DeviceId` abstraction
Date: Tue, 10 Dec 2024 23:46:39 +0100
Message-ID: <20241210224947.23804-13-dakr@kernel.org>
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

`of::DeviceId` is an abstraction around `struct of_device_id`.

This is used by subsequent patches, in particular the platform bus
abstractions, to create OF device ID tables.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS        |  1 +
 rust/kernel/lib.rs |  1 +
 rust/kernel/of.rs  | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 rust/kernel/of.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 50995e0e4252..7371ab484139 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17502,6 +17502,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 F:	Documentation/ABI/testing/sysfs-firmware-ofw
 F:	drivers/of/
 F:	include/linux/of*.h
+F:	rust/kernel/of.rs
 F:	scripts/dtc/
 F:	tools/testing/selftests/dt/
 K:	of_overlay_notifier_
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 07770add5ee2..7a0e4c82ad0c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -56,6 +56,7 @@
 pub mod miscdevice;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod of;
 pub mod page;
 pub mod pid_namespace;
 pub mod prelude;
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
new file mode 100644
index 000000000000..04f2d8ef29cb
--- /dev/null
+++ b/rust/kernel/of.rs
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Device Tree / Open Firmware abstractions.
+
+use crate::{bindings, device_id::RawDeviceId, prelude::*};
+
+/// IdTable type for OF drivers.
+pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
+
+/// An open firmware device id.
+#[repr(transparent)]
+#[derive(Clone, Copy)]
+pub struct DeviceId(bindings::of_device_id);
+
+// SAFETY:
+// * `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and does not add
+//   additional invariants, so it's safe to transmute to `RawType`.
+// * `DRIVER_DATA_OFFSET` is the offset to the `data` field.
+unsafe impl RawDeviceId for DeviceId {
+    type RawType = bindings::of_device_id;
+
+    const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
+
+    fn index(&self) -> usize {
+        self.0.data as _
+    }
+}
+
+impl DeviceId {
+    /// Create a new device id from an OF 'compatible' string.
+    pub const fn new(compatible: &'static CStr) -> Self {
+        let src = compatible.as_bytes_with_nul();
+        // Replace with `bindings::of_device_id::default()` once stabilized for `const`.
+        // SAFETY: FFI type is valid to be zero-initialized.
+        let mut of: bindings::of_device_id = unsafe { core::mem::zeroed() };
+
+        // TODO: Use `clone_from_slice` once the corresponding types do match.
+        let mut i = 0;
+        while i < src.len() {
+            of.compatible[i] = src[i] as _;
+            i += 1;
+        }
+
+        Self(of)
+    }
+}
+
+/// Create an OF `IdTable` with an "alias" for modpost.
+#[macro_export]
+macro_rules! of_device_table {
+    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
+        const $table_name: $crate::device_id::IdArray<
+            $crate::of::DeviceId,
+            $id_info_type,
+            { $table_data.len() },
+        > = $crate::device_id::IdArray::new($table_data);
+
+        $crate::module_device_table!("of", $module_table_name, $table_name);
+    };
+}
-- 
2.47.0


