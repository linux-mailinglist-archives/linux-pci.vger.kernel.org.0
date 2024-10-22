Return-Path: <linux-pci+bounces-15061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74309AB8A3
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD8B1F21397
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905EF1CEE83;
	Tue, 22 Oct 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWLlpX82"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF761CDA12;
	Tue, 22 Oct 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632830; cv=none; b=Qkd+MmbVLNiqCeCgKqPlzSJjQ3kXCzWK0ri6jIRdW9aFuhoUpmbzlvoJh0WPfeCd1NurekVgbOOZlQwwXmkqxM0TEwb+lB6QIrTZKk5Emyk3YsW6G+/sb5d9gM4v3Fg+dWXoWgK77VXCvGo1Op0pWuhJ2R6vMFzvvSop3w0jyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632830; c=relaxed/simple;
	bh=oZxudZpPmp3wO6kvmh14Nmt+ARxxpIUr1MKPymhU6dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROrIad3u8/raRgxkn99csH3U5aSg9ZgS567iOn7xNOAwjZqq3g1ygaQmMNAAIWtoe8B8tNbogXzg2J2HTJL/gIBeqQEOdsRSFAFjmnhlWuw1jYyhEPmI+eNmMk3FyOHtDCPmOBU+YG0Vm5d7YiwcZjlxelgxqvbCEMCPvs6l+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWLlpX82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3375C4CEE3;
	Tue, 22 Oct 2024 21:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632829;
	bh=oZxudZpPmp3wO6kvmh14Nmt+ARxxpIUr1MKPymhU6dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWLlpX82/K4GKKTMSHc3mx9wavzsZ5VXCkelZAJvziHrudv3FhLTwY3BOaV5uH2gg
	 dTftQvmoH1qr96EpbTM6W/Fn9E9VwuHCVECxljNnY5HxDe00jzynTsX25SHCB4En3C
	 LsEV+zVrnIW/WarTVWGhAUorYRP3iQthVPL01DKnEfIobxr+qd1cpFNdh0KvgVDgQA
	 K65J4roMfmVo+vfsYQVr55k4nKeax9xCpuAjeaioHGM2cjFxXdr+ObDMkotoZFYcKf
	 e3m8Hlunebu/Wq/SbZpg1TKuLhGGPMlaLSZ50V7e/UTTZl+T/m9pcbFUZ9d7ZR2Nkw
	 cKx+4sj56tu+g==
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
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 14/16] rust: of: add `of::DeviceId` abstraction
Date: Tue, 22 Oct 2024 23:31:51 +0200
Message-ID: <20241022213221.2383-15-dakr@kernel.org>
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

`of::DeviceId` is an abstraction around `struct of_device_id`.

This is used by subsequent patches, in particular the platform bus
abstractions, to create OF device ID tables.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS                     |  1 +
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/of.rs               | 63 +++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+)
 create mode 100644 rust/kernel/of.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index d9c512a3e72b..87eb9a7869eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17340,6 +17340,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 F:	Documentation/ABI/testing/sysfs-firmware-ofw
 F:	drivers/of/
 F:	include/linux/of*.h
+F:	rust/kernel/of.rs
 F:	scripts/dtc/
 F:	tools/testing/selftests/dt/
 K:	of_overlay_notifier_
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index cd4edd6496ae..312f03cbdce9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/firmware.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
+#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/phy.h>
 #include <linux/refcount.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3ec690eb6d43..5946f59f1688 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -51,6 +51,7 @@
 pub mod list;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod of;
 pub mod page;
 pub mod prelude;
 pub mod print;
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
new file mode 100644
index 000000000000..a37629997974
--- /dev/null
+++ b/rust/kernel/of.rs
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Open Firmware abstractions.
+//!
+//! C header: [`include/linux/of_*.h`](srctree/include/linux/of_*.h)
+
+use crate::{bindings, device_id::RawDeviceId, prelude::*};
+
+/// An open firmware device id.
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
+        let mut i = 0;
+        while i < src.len() {
+            of.compatible[i] = src[i] as _;
+            i += 1;
+        }
+
+        Self(of)
+    }
+
+    /// The compatible string of the embedded `struct bindings::of_device_id` as `&CStr`.
+    pub fn compatible<'a>(&self) -> &'a CStr {
+        // SAFETY: `self.compatible` is a valid `char` pointer.
+        unsafe { CStr::from_char_ptr(self.0.compatible.as_ptr()) }
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
2.46.2


