Return-Path: <linux-pci+bounces-31179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EE5AEFBEA
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 16:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF1E1C050DD
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F4827A10C;
	Tue,  1 Jul 2025 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbX99E/m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07299279DB1;
	Tue,  1 Jul 2025 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379280; cv=none; b=bQW4BVg9tUp0tKlpe3pqT4khcRKxqJIEnO0ggRd3+tmPjdwoVBxoCZmWEc8zBur+A+iSGYbF9CLw1m//KmMPwFUmMtfpBZDrcM4eUjUI/KEICkIX07FBkrtNfaJ0IjJGr6aQ2edIGKQTtzLJSbqN7vvP6bQhlF68FN2qEksgNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379280; c=relaxed/simple;
	bh=wY3pJ9nFlqmEeyPfW98+n/Y28S8S70pNb3omes9fzIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMUBjdHcdlS7uw7IoneCn8X00LvDbNEKrzrCH2SgYBMJzdwGbSXvji3pIHA4kXoI3rSOWUqRlmMjmAC+BvIMPZc2vOBtCVRsIfRKLJeIMchwJHqaP0XXaBI1/91kL0oY8NEAVd2y7gsjQNDXYgldCbhXe7zwQmgOKMblHL+qmjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbX99E/m; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235ea292956so29694695ad.1;
        Tue, 01 Jul 2025 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751379278; x=1751984078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhF5CcEqPzfan8Qj+FWBWIOdIwHq+OpoPrnKrGKGhts=;
        b=lbX99E/mEnl40ISUYBTgKXRRs+lpjk4qZwn13KtDSSrMCiwybyZIX/YV4PtbQMPgSF
         2S8OhC2X2aE3HIVWrosltix0ytK9M1tciSccZbQzLm0pUp2Ne+8z/C2kdp5azOk4CLDN
         kMjGvPILacPhZK8OAY+NRLG3xMDhL43DLR26IMR2nSCZDrmWA4tO+LbcrKyN9PvXCHhI
         Ke+LG8uKMyomx5tuwslbFP3wiY61zHDvzL1ibxOUXAXuVD8TycBnS0b/RES7ZIeN5MzK
         MFe54PjDuGZ4Wfbwz4FsvX2oe1c/grUmnJEouEEdTBeo2a9P6Kadp1rmaIkgPZvLu+FK
         FVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379278; x=1751984078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhF5CcEqPzfan8Qj+FWBWIOdIwHq+OpoPrnKrGKGhts=;
        b=CNIfwQdcrrteFtS7Pt9XvH+zU0UVB1WZHCxuDa9ktZrIeB4P3tqkILWVK6W+OxgHz9
         eTPiyTYo2VawW6vB1gQERrADxSDQJ4SdoJFypKxf4CtVNBn6GurQkNrKmr36EOtvySBG
         nAPPQjxrgrHCXtogsTHYKCGSRnP7nfi6+BOQ7WulQe+VgLjihu8xLPOPBZiE4Jm7tQzB
         VmU5nJLCuMuCihP9NQoFN+Gu++of8qXg0WYmsJPSoP6Azlzvy6GBiTMfgbOxuLbgelKH
         hZwJaL63MX/MJijCff39XpGHFneQk3g10igHL2lIGFeaYwhi/eyJcfNzZdeXhQpF+boe
         EjKw==
X-Forwarded-Encrypted: i=1; AJvYcCVH9JDFVYszkVwUpSZOffGTDP+NeBth1Or0oLKjUZYVpwCnoGWlowfSWgk+w4pnKhkJxlmbpm+sDE6M@vger.kernel.org, AJvYcCVJPx26M3QQT0J/Xw4qTe9mDdr3M1gStOjaU8UaeO48Q7hL5qpipPzemSzG+yfvw+V4s6nJ5sUon9QS@vger.kernel.org, AJvYcCWMosOxbzdcYrTXpFvfj8d6+R58oh7Hcg3yYGXg4RGhB7xrFu4Mnja0wFwehbCrxPKdyoVTMd6L@vger.kernel.org, AJvYcCXDzES5nBq/Huy4p8zGbE5CSUXLICTB81UaxbPd91BJBrNxddlBKLgMLiyN2nAt9ndDO/qgxsbfL8ONEZYRJiU=@vger.kernel.org, AJvYcCXUOXPMdbLF6BPIDP1rmmjmRSzjtWmUovoMYuX+/GPDMMd+NAFImn3ZtsoygU/JqUoYxTMxy5p66UVqmGy+@vger.kernel.org
X-Gm-Message-State: AOJu0YzR0I+zcibeStVyZb3zKev0/8Ln1ZbErVIiyB/dM13XgE/tI6YA
	jmNtHvodyq/ktf9ZbdQKz3dz5zYofShrGMBSfK5s1dEob0a6cIAaraQj
X-Gm-Gg: ASbGnctXAdy8F01zTFbDTAuPf9TIOougqXAbA3r88OHWogJq1+pJ0RaK5uNWgDpJG4i
	fIaVge48tgf7V7W8LySwrFmQSsqmStY0DYE/kJN5Ld3K/+n4gkxPa+VeqOYdlcI2OiLntk7cIw+
	d8qQuaCnhwX2LjnvMcOEPVlTYFJItGzDobcJAO2KNnuXo+jWsyRuY9nGCENNtCulwgSNF/1IPF+
	78/ChA12wrXhWJWjbABfpQdfLUfFY+CbOIbF9PvBh0dnXy7TNNpjPYIXKIxB0tXwzk8Z3+r+yO9
	xvhrHZwldVHmy1Crb9NRQFo89miUFvsUBjsV36AXwzuSXMsd8y75UncDQyDOvcbHO4J0AEcpTE5
	m/FASrSRUh2wj3y0UDjXi2D9p3XdQTWKikvo=
X-Google-Smtp-Source: AGHT+IHs/sgaXxj0cg5nqN7WtEqfWV4a21o8vt1rWTuNUjMzgURiIciaiuN3uj8jT0zhbiEB8voasA==
X-Received: by 2002:a17:902:e5cb:b0:235:779:edfd with SMTP id d9443c01a7336-23ac465ff41mr242885165ad.39.1751379278049;
        Tue, 01 Jul 2025 07:14:38 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b8324sm107240885ad.178.2025.07.01.07.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:14:37 -0700 (PDT)
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
Subject: [PATCH v2 3/3] rust: net::phy Change module_phy_driver macro to use module_device_table macro
Date: Tue,  1 Jul 2025 23:12:52 +0900
Message-ID: <20250701141252.600113-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701141252.600113-1-fujita.tomonori@gmail.com>
References: <20250701141252.600113-1-fujita.tomonori@gmail.com>
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
index 940972ffadae..8bb362aefe27 100644
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
 
+// SAFETY: [`DeviceId`] is a `#[repr(transparent)` wrapper of `struct mdio_device_id`
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


