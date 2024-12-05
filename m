Return-Path: <linux-pci+bounces-17780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604A9E5856
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 15:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0C3188464B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B0321CA05;
	Thu,  5 Dec 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhsR5ULe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9F321C165;
	Thu,  5 Dec 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408216; cv=none; b=X6OEL0BoQpfIrcjnkwKUHFKpgA1jPuhbbWz9RIza0sSSK/lHxigon2mhOQohgPcTP4aSWi25ieoGPB+V9qs1EZHyUWuZ+43/347gf7ihuaMFWfM0BaWnd1k+6gQU5mEVl+EWPkPTatfNzwiMDjx2QCOSHhPOBZWCo4yDsx6Hrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408216; c=relaxed/simple;
	bh=u7p5w3YMf9jp+upkdyNIlDdEvty8OlJvf0CytCuomJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PM1lxUGh3qDy8hcmDWVpkwfxqCd6JYiUy28AEItDlS3Y8tVmSc5AnAsOIJ6QfV+gJgI9bi7Pj0UfKygzUHCZlWfrnDrd2TrqBR9V4e/NGLMkY/Tf3otRD+uOW856BJys+LJBRXu2NyXYgUSYO2wHf6/Tx9bnHk1aUuUK2/gs7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhsR5ULe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8AEC4CEDD;
	Thu,  5 Dec 2024 14:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733408216;
	bh=u7p5w3YMf9jp+upkdyNIlDdEvty8OlJvf0CytCuomJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhsR5ULeOhna4l7gmxDSaxy0AOHo8LB5wvNWGNCrkU9FbebOrHpDNDsvtRjNFdge6
	 Xws4MtF2RvHZkAvFpD1+OEPaBB4DGHqMae1YwRNm63uV8JMV555uZzJk8w/FT3LtGM
	 l6OoxSI8hEiAWgYzjpid58lmzpVupe6InuUyfe5TUIK9UDLxbYzqnueccCi3B4hlsB
	 hUeRMHupuvruOxNQAcTi5SO3MF600oBU1+BBFcOwSKjuFM0OjBPNB6mmn4RwK9lyBi
	 UptyOrZoTHHRadDhpXZ+mTpnG6CwDaBe4HqeHOrSnOdCn0sgGxV3UpYd+1akdJb5j6
	 tGzOfPuL2288A==
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
Subject: [PATCH v4 11/13] rust: of: add `of::DeviceId` abstraction
Date: Thu,  5 Dec 2024 15:14:42 +0100
Message-ID: <20241205141533.111830-12-dakr@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205141533.111830-1-dakr@kernel.org>
References: <20241205141533.111830-1-dakr@kernel.org>
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

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS        |  1 +
 rust/kernel/lib.rs |  1 +
 rust/kernel/of.rs  | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 rust/kernel/of.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index f97052d5f454..7d6bb4b15d2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17499,6 +17499,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
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
index 000000000000..2b424f3bfa93
--- /dev/null
+++ b/rust/kernel/of.rs
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Device Tree / Open Firmware abstractions.
+
+use crate::{bindings, device_id::RawDeviceId, prelude::*};
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


