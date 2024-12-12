Return-Path: <linux-pci+bounces-18314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 146849EF30D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC84171C1B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9C523D405;
	Thu, 12 Dec 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1GkefJu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F61923A1B3;
	Thu, 12 Dec 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021381; cv=none; b=KJfmn31NLvK5KFooCSDky2kSOCrHdnUOCcEuk9bMk7ZjO/cJHn30iKgRVSI41kbPkPijG/zInkqwCn/pyPNz1u5f+CZi9PKje1bt2wXVW6z0rdYPX+TE1eiV4qmCZB1DTykE4StmOo5GRV2ZsuGhuNe8cNT6TTX+vLAqzdqQmnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021381; c=relaxed/simple;
	bh=amaguJCYxDUqc57XLu1S9GMe5x6nv8/1Wsg07UQE+kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyV0mTRjCAU0Obb5LtnwiXp+RNx03jjwN9ng4qBPGryeCD4W3VEynhpEepolDrjd72LrB+SmlA57nP32Fyoz93v9Kj3c5pedhJum+oJILHuRzTLZBtr0RaeQzkpW9FduWiJ3HE0Dz9hVdXwX+cVHhe2BIp/Hq1Lu0dNFoyj8oZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1GkefJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090FFC4CEDD;
	Thu, 12 Dec 2024 16:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021379;
	bh=amaguJCYxDUqc57XLu1S9GMe5x6nv8/1Wsg07UQE+kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1GkefJuk7Ct1CdGtlsu17N1+i71nTnZJJu/GBTZEokplAlia3fRZJ5ayGWRvI9qy
	 x87t+jxrgSgu0YMpv0obquQ/Tso8MssrxOSW0fCc6yCtBIgOlCxFsjScT+uFr7WtsR
	 EckspMjrgQBJM4IuNL0L1DRW0BJ1DvOe+Vlw3/BxREFNatz79w1kVocCom5hFM/cBU
	 FfGQc9RIC1z+yHGb4i3+ZoTXwJLHuayPRdDftyVUrIQgsRAsbltURvwz22F/v8B8t/
	 UtiP7pZ+kmtsy5FIVgaDE/BNfmlzITYVS42dfuJZrBfcRfZueEVyoQH8cs5LWGfwQZ
	 5lWfeTcZmlBsg==
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
Subject: [PATCH v6 12/16] rust: of: add `of::DeviceId` abstraction
Date: Thu, 12 Dec 2024 17:33:43 +0100
Message-ID: <20241212163357.35934-13-dakr@kernel.org>
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
index b15eb7c6b23f..025a279ac8ca 100644
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
index 1dc7eda6b480..27f914b0769b 100644
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
2.47.1


