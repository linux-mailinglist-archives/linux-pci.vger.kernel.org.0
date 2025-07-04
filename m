Return-Path: <linux-pci+bounces-31497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CF6AF8641
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 06:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E837B41AC
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 04:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2EB1F75A6;
	Fri,  4 Jul 2025 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYx4o7Sp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD261F4CBE;
	Fri,  4 Jul 2025 04:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751602251; cv=none; b=XTfOVHFS5hHNP6lIwvEok+SXmTyhpMCoMLilCaBWZsT0X8WGEwsvyNcr4P2vmfHiuXdkK2JwfgZF+8sZd2sAsHaLYmZmjURxm7OFa/bq5zj7d4BN8Ff71kPRvNrDqgwKG4c/3yurSR3cHt4KlTkQsm4gEmyKAhPUYyff3NgbBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751602251; c=relaxed/simple;
	bh=Rb82lXwhfTwYPKu8Q8XF7KI5JIB8d/RCndqm2TyQhxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tglfVbpShLSWnU2y6/5LMTZ9HRkPMEMCDlxMkb9CMPlOZSUWxL642JS8cMNNZeHg4OoFMU6qg4EutlZ96eZQogzVS7qV+xv0fxbnvEXq9jYvGtdAiwYeKiUrmn5GGun+fHVWn8MMvgcS1v+EmXg7bWAIhP0YX8zMLFkPbUMa1AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYx4o7Sp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747c2cc3419so570846b3a.2;
        Thu, 03 Jul 2025 21:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751602249; x=1752207049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN4iAGbjA8Ktlzd5eLTpLdmfO5ssDEZ/FUSkzLKEQtA=;
        b=RYx4o7SpHmmqtwiTf3POwRuY4jFw0L+ezKHmQruVyDEx68JkEw4EEW3jrM5v9F2aKO
         sSx/pj9+o1zRfD/URzUY0zWswnW92zVwEnVtVXsQvx9Hqb0dlWFwBuQmhyB+/SVIn5mo
         /HKDTfsPv8P1k1Hp99N0YKvp9t/WTUaDbh51Zby/ttm/uUCm3LKD8wsKGe0HW0Gzrp40
         sIFkH0mZTTbzR8mWEUjU1eIPwUm6la6U0d8YAXLO1mDmDdCVIvDsogIfT/Q5emgFd0wb
         JiLkJFHAK/w2kZGghb8me2A54qZ5mfrUSZNssXZOTu25d4tcvQXqvB2lYm1k8ziIXR13
         pFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751602249; x=1752207049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN4iAGbjA8Ktlzd5eLTpLdmfO5ssDEZ/FUSkzLKEQtA=;
        b=wEdM320ae3t3syy8xdx5Y/oVs8cd6SBDIPbGPzx+GSP/plUHecE2nDotbECg20rwdL
         rXOxyEy9TryGFL5hHYouzvtQHr/l06sda1txckvbP9iyQoe8VivE2VyCA4fH9uFtXsXE
         uumBxKDwPtT066NAQGFq9JM6AvGhVvKeGGc5E1bZi1bpBcLzxG2FJfQOIwxuDcOz6lUx
         4Fx9YMKJTAUypfFlnTBi4vAvtxSBaqtS5Tp1cY2efel+u6c9gTv61WfWd+5MV4P37yPK
         Uhn47MWhB9Y2Prt/HEpR2UeMAs2is1i00jNTrK4AEJVBvnTIgM0hbER18at2jUuPm8no
         Yf+g==
X-Forwarded-Encrypted: i=1; AJvYcCVPXwwoDJQDWDjfEc/yorZp74dybddBWoHxMzqwUD4BNNQ48EVRN2+GPyahvlEvFZzWLUSda7JtTdQw@vger.kernel.org, AJvYcCVbSdAq5IFGlw/+288HWKWakyFn2kfAbYU3pdSBBZhqkwMl6vgDb7md9wmW6J3LfJmjCf+yDacA7YSTBLfv@vger.kernel.org, AJvYcCWUPiQzAqv5ngV/pYE5cnINuUgnxPxUUDX8JqB3HWsjWpOaOam2L159GtTzDX7mnXA77wRftBANXMa0bMqRX4k=@vger.kernel.org, AJvYcCWyrdfYC9yKWwHwaruN19/+mMa1d/Es15KmmbvJ3RAf8b76YZemzSIzv9ALMeu4m6ItOMFllNWRQpYF@vger.kernel.org, AJvYcCX+uLyzoNWE2d9gAx+9TXlx5x5O/6DW6+XuXw+XduyPkAN1giYDJLC+Qp/CTkgwtYSsr6Axt3LS@vger.kernel.org
X-Gm-Message-State: AOJu0YxEkoMZY8Zo69mlE1p7GbNNmyevfB1e+unE4iDSrkyCt7seL6nx
	/Pa78URX4QMGZM3zC/O9kXPVFxvRs9M35S7ORqeVzJisIulwOkShsgd8
X-Gm-Gg: ASbGnctBYih2ku3R84xbf77Otj7LCGapTUARW608vjlv9BJmAEL+cXUA0iMDrh4z7L6
	PLxQxpZ4xG5iS4BVLaPIGnDNAnREZYE8ongpCgl2Rwzw1GS3NlQrB12Ldvv3OwtltewxBzVCgvp
	zy1yItParh4nFf8/JqRL2YnVR3TT5XAhby94uPyJHMWpsGTI4mujwmUo7P3Lftz9pxIWf28N7HP
	ZBdvdWJKLEl+ikJ35+836lX4ie7fUM/WB8j/OEXrgeSg2E9Zpuoqk8PbWhGMk+KPp3FaqjQK+6i
	TjMzKnPUsZwe86fAEOAbU9/GhGRU9vkMmz5q2vOV57Z3zamw64fKIImMcb8XQ+MVEVg+cKUZbaN
	oORSZIeCqPIbRhsnVMeQZ4XgTUnB3GQsFD7E=
X-Google-Smtp-Source: AGHT+IHhq5Bx1kO3+4YSfT0X1Ne9s//Wk3I3d5kDIcUv7WpkVSrvF4k6d+nPAHN6bJBebdeqNlFqLA==
X-Received: by 2002:aa7:8889:0:b0:749:bc7:1577 with SMTP id d2e1a72fcca58-74ce6ab631dmr1421521b3a.9.1751602249047;
        Thu, 03 Jul 2025 21:10:49 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35ccb9esm1055290b3a.50.2025.07.03.21.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:10:48 -0700 (PDT)
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
Subject: [PATCH v3 2/3] rust: net::phy represent DeviceId as transparent wrapper over mdio_device_id
Date: Fri,  4 Jul 2025 13:10:02 +0900
Message-ID: <20250704041003.734033-3-fujita.tomonori@gmail.com>
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

Refactor the DeviceId struct to be a #[repr(transparent)] wrapper
around the C struct bindings::mdio_device_id.

This refactoring is a preparation for enabling the PHY abstractions to
use device_id trait.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 53 +++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 65ac4d59ad77..940972ffadae 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -507,7 +507,7 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
     DriverVTable(Opaque::new(bindings::phy_driver {
         name: T::NAME.as_char_ptr().cast_mut(),
         flags: T::FLAGS,
-        phy_id: T::PHY_DEVICE_ID.id,
+        phy_id: T::PHY_DEVICE_ID.id(),
         phy_id_mask: T::PHY_DEVICE_ID.mask_as_int(),
         soft_reset: if T::HAS_SOFT_RESET {
             Some(Adapter::<T>::soft_reset_callback)
@@ -691,42 +691,41 @@ fn drop(&mut self) {
 ///
 /// Represents the kernel's `struct mdio_device_id`. This is used to find an appropriate
 /// PHY driver.
-pub struct DeviceId {
-    id: u32,
-    mask: DeviceMask,
-}
+#[repr(transparent)]
+#[derive(Clone, Copy)]
+pub struct DeviceId(bindings::mdio_device_id);
 
 impl DeviceId {
     /// Creates a new instance with the exact match mask.
     pub const fn new_with_exact_mask(id: u32) -> Self {
-        DeviceId {
-            id,
-            mask: DeviceMask::Exact,
-        }
+        Self(bindings::mdio_device_id {
+            phy_id: id,
+            phy_id_mask: DeviceMask::Exact.as_int(),
+        })
     }
 
     /// Creates a new instance with the model match mask.
     pub const fn new_with_model_mask(id: u32) -> Self {
-        DeviceId {
-            id,
-            mask: DeviceMask::Model,
-        }
+        Self(bindings::mdio_device_id {
+            phy_id: id,
+            phy_id_mask: DeviceMask::Model.as_int(),
+        })
     }
 
     /// Creates a new instance with the vendor match mask.
     pub const fn new_with_vendor_mask(id: u32) -> Self {
-        DeviceId {
-            id,
-            mask: DeviceMask::Vendor,
-        }
+        Self(bindings::mdio_device_id {
+            phy_id: id,
+            phy_id_mask: DeviceMask::Vendor.as_int(),
+        })
     }
 
     /// Creates a new instance with a custom match mask.
     pub const fn new_with_custom_mask(id: u32, mask: u32) -> Self {
-        DeviceId {
-            id,
-            mask: DeviceMask::Custom(mask),
-        }
+        Self(bindings::mdio_device_id {
+            phy_id: id,
+            phy_id_mask: DeviceMask::Custom(mask).as_int(),
+        })
     }
 
     /// Creates a new instance from [`Driver`].
@@ -734,18 +733,20 @@ pub const fn new_with_driver<T: Driver>() -> Self {
         T::PHY_DEVICE_ID
     }
 
+    /// Get a `phy_id` as u32.
+    pub const fn id(&self) -> u32 {
+        self.0.phy_id
+    }
+
     /// Get a `mask` as u32.
     pub const fn mask_as_int(&self) -> u32 {
-        self.mask.as_int()
+        self.0.phy_id_mask
     }
 
     // macro use only
     #[doc(hidden)]
     pub const fn mdio_device_id(&self) -> bindings::mdio_device_id {
-        bindings::mdio_device_id {
-            phy_id: self.id,
-            phy_id_mask: self.mask.as_int(),
-        }
+        self.0
     }
 }
 
-- 
2.43.0


