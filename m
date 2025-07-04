Return-Path: <linux-pci+bounces-31498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22310AF8644
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 06:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E0F7BA940
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 04:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9220A1FE474;
	Fri,  4 Jul 2025 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaHmfEhh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FDB1FDE39;
	Fri,  4 Jul 2025 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751602256; cv=none; b=SgnZwyVcU8XigBUI0m8tPzpYJzDofEK4xFOPtCfQ7MkRbb1zsp5m7bfplYABE7HI6z8KX5/vgv1N1UiaTdqbG9HsSbn9Cy1rkGNxroqk77VMY6CXJuJsFpkjNjvNmS5Abbe1a8MwXWmYSkqBw1inFItQw9j4/yL/BfNcl63FZf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751602256; c=relaxed/simple;
	bh=FtCvNYjLrE6/jIO6wT2KtwY4Dg2KTonsKpTSVZl93iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppCoFatoKQ/DLL8sGPd53wEwODWuB4oFV7Hd68MQ0hXZFTXuovd2WbCvLGmWTq1I2myR9rYU1JW06ZOk7X3hwiYCadCw+oBjXesrHLhK+UJc6GAp63nczIXc/9baDmXspNzJmbJ1MCGgDGQLzcGtuIvqCOP2DOm2YfMglrIEMjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaHmfEhh; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b170c99aa49so378779a12.1;
        Thu, 03 Jul 2025 21:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751602254; x=1752207054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YC19N8gX3c+UCcVBsZb/0sncBuBKOFkHCNQT4MJHZw=;
        b=QaHmfEhhe7u1O0BlIi4qDFK7I2JgXwJ8pV9oIkEIJ3eje8fuyPLCtfWkUZEkOMjJ2a
         tX+XHhvalhu7fWSJTDIG+oJ7bMArSOdJ+hqqNai0KQAgD/g18QA/Vk+OURtcZ67LN3hB
         dSZW1bXxiKEtdPEQYyahbXSuxw3YMxJ77OMzcNe9jRCq7cr/RRhaWoh1xYPbye9iaweo
         eNo6ab5WN4ic/BTS9/mpGWiAu9j2swWCx5uNrF0N5Fsx2vIlCLpyMFq3gXHk6Yd2kHvi
         EHQXCbTQbxdM/6+fG8rdgyukig2qxu/ygYLYu/0gK/YYEoHlJN9HZHylEQw7z+diRj7R
         YQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751602254; x=1752207054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YC19N8gX3c+UCcVBsZb/0sncBuBKOFkHCNQT4MJHZw=;
        b=C05ffqgHm+u+8xRL3KhjFe/W0OKggHWI3tfP9rIve5StJ07AXbmAzXf9eyL0OXf0gv
         DPvUeJvg9MTgBHNWvn2RW+J6uCdd1Lu6s0pbH3jwbT2ZqHnwTaLwK3vzZku0noWmlCu/
         yDJSnTpQDPCVupO0tM3KOjNtF6SbEFcYUQ5U1bzz4A0jX+K1E6lF2f41UFZM6Z4Z3sIo
         C3E1geISr+PzfeA02xWFWV+aU8FIKqyz0IBy2Tb9Q/TyMl2vXSLyESbPmHDk6ku7O3HC
         cE0GnT2McEMcVpb7nQBY3Nbp9G0Vx+LLR911zIVJyp4svWlJxW3PT1yKCHP3J178pl1M
         EWbg==
X-Forwarded-Encrypted: i=1; AJvYcCUE7sy3xD150QFEHyYlgOBG4ECfesMnpFpTcWah0AMwruMkwVJeG7CoFv+4PJ/jwfTMnZbu1/W3O5QJk02MA/Q=@vger.kernel.org, AJvYcCVEs+nk4ZKnsNLrm2UaiPIqq65FHD8tk710RXHY7NzyBKrQiAPVosqEQ3vZviRnVXc0mx7DukDujE0bAG8L@vger.kernel.org, AJvYcCVI+UPvvBVff4ZUtH5kAhneS7lF6RydNL6HMlijJMeYfUB3dIqbo7Pb5UWrYPmOudOozXKskYyflztH@vger.kernel.org, AJvYcCVgBSlsybNRPZX3XBwlLS7uuAQeWlBmgijUFjCyebpMmtFjCNTfd9KCaJczT5LZ40gGoA+rrRRt@vger.kernel.org, AJvYcCXvBAYm2G3bCKATXCYxJ0Z3PhM4sc7iY7M2w06hdrMHDUjfWPc/2s2zL1VuJmE6+rk55qTFQCIT4mrm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtt8VtfTykkaEkUiE0NS4PuSABOpS/KHp9xsB9Moly4P9jBi3d
	uN6bx/eCMCAN+H/GVtEdUEM9OXVOag/xW+JHwyHdQ4+PaGn/eQUodiOc
X-Gm-Gg: ASbGncsKVvUgo92xXQzQNEaOJ7+4nTOhNeV/ExiIuDVrYtOZ5jc8dPko38f9R2C5cqH
	Yucb8BXh3SdPRlQePRbG/4URtl4VmYectmlqy5tfYkG6hYOPwCpFMeNB+9L9YbFlw6W0eruTWpt
	x+ao46rXmlpuyl9qmh+u1N7QoG4KIjjkY9M6ijYN7VE9+3rtpAwszgqF/bhOgBBES6VU9ilIzBj
	SCqCmi9CNSVF5dRxDWDaqSjUx0vSeKLrNm/V42QQkBDFjhE6RAiluu/5VWztyINJHHXpIYBZ1np
	8gayne3Hupjug+5Wr3DPsmmNWSBeXNYkthfHjKNIrn46p4QDPanVjZ128hXOas/he9CuV1usLVv
	h0lLMBAoRgClxIo5PyPtXNlAWYsXEgVp/XkJxcciba+nnHQ==
X-Google-Smtp-Source: AGHT+IE9LQuB7/Ap+rO08DMf7bb/ZRItBTKRcsr4ZNEKUs8oyTf5BtUNy7POz2MF7hdmGjfi5+UDdA==
X-Received: by 2002:a05:6a20:7352:b0:21f:50d9:dde with SMTP id adf61e73a8af0-225be6e38d2mr1817202637.5.1751602254128;
        Thu, 03 Jul 2025 21:10:54 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35ccb9esm1055290b3a.50.2025.07.03.21.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:10:53 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: alex.gaynor@gmail.com,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	robh@kernel.org,
	saravanak@google.com
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	david.m.ertman@intel.com,
	devicetree@vger.kernel.org,
	gary@garyguo.net,
	ira.weiny@intel.com,
	kwilczynski@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lossin@kernel.org,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: [PATCH v3 3/3] rust: net::phy Change module_phy_driver macro to use module_device_table macro
Date: Fri,  4 Jul 2025 13:10:03 +0900
Message-ID: <20250704041003.734033-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704041003.734033-1-fujita.tomonori@gmail.com>
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change module_phy_driver macro to build device tables which are
exported to userspace by using module_device_table macro.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 51 ++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 940972ffadae..338451a067fa 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -6,7 +6,7 @@
 //!
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
-use crate::{error::*, prelude::*, types::Opaque};
+use crate::{device_id::RawDeviceId, error::*, prelude::*, types::Opaque};
 use core::{marker::PhantomData, ptr::addr_of_mut};
 
 pub mod reg;
@@ -750,6 +750,12 @@ pub const fn mdio_device_id(&self) -> bindings::mdio_device_id {
     }
 }
 
+// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct mdio_device_id`
+// and does not add additional invariants, so it's safe to transmute to `RawType`.
+unsafe impl RawDeviceId for DeviceId {
+    type RawType = bindings::mdio_device_id;
+}
+
 enum DeviceMask {
     Exact,
     Model,
@@ -850,19 +856,18 @@ const fn as_int(&self) -> u32 {
 ///     }
 /// };
 ///
-/// const _DEVICE_TABLE: [::kernel::bindings::mdio_device_id; 2] = [
-///     ::kernel::bindings::mdio_device_id {
-///         phy_id: 0x00000001,
-///         phy_id_mask: 0xffffffff,
-///     },
-///     ::kernel::bindings::mdio_device_id {
-///         phy_id: 0,
-///         phy_id_mask: 0,
-///     },
-/// ];
-/// #[cfg(MODULE)]
-/// #[no_mangle]
-/// static __mod_device_table__mdio__phydev: [::kernel::bindings::mdio_device_id; 2] = _DEVICE_TABLE;
+/// const N: usize = 1;
+///
+/// const TABLE: ::kernel::device_id::IdArray<::kernel::net::phy::DeviceId, (), N> =
+///     ::kernel::device_id::IdArray::new_without_index([
+///         ::kernel::net::phy::DeviceId(
+///             ::kernel::bindings::mdio_device_id {
+///                 phy_id: 0x00000001,
+///                 phy_id_mask: 0xffffffff,
+///             }),
+///     ]);
+///
+/// ::kernel::module_device_table!("mdio", phydev, TABLE);
 /// ```
 #[macro_export]
 macro_rules! module_phy_driver {
@@ -873,20 +878,12 @@ macro_rules! module_phy_driver {
     };
 
     (@device_table [$($dev:expr),+]) => {
-        // SAFETY: C will not read off the end of this constant since the last element is zero.
-        const _DEVICE_TABLE: [$crate::bindings::mdio_device_id;
-            $crate::module_phy_driver!(@count_devices $($dev),+) + 1] = [
-            $($dev.mdio_device_id()),+,
-            $crate::bindings::mdio_device_id {
-                phy_id: 0,
-                phy_id_mask: 0
-            }
-        ];
+        const N: usize = $crate::module_phy_driver!(@count_devices $($dev),+);
+
+        const TABLE: $crate::device_id::IdArray<$crate::net::phy::DeviceId, (), N> =
+            $crate::device_id::IdArray::new_without_index([ $(($dev,())),+, ]);
 
-        #[cfg(MODULE)]
-        #[no_mangle]
-        static __mod_device_table__mdio__phydev: [$crate::bindings::mdio_device_id;
-            $crate::module_phy_driver!(@count_devices $($dev),+) + 1] = _DEVICE_TABLE;
+        $crate::module_device_table!("mdio", phydev, TABLE);
     };
 
     (drivers: [$($driver:ident),+ $(,)?], device_table: [$($dev:expr),+ $(,)?], $($f:tt)*) => {
-- 
2.43.0


