Return-Path: <linux-pci+bounces-31178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ECEAEFBEE
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 16:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE8D447845
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76187278772;
	Tue,  1 Jul 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INEQSCf4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D622B277C9B;
	Tue,  1 Jul 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379275; cv=none; b=UP/he82bmQmuaGjvfMiiInuY8Cw1JZxKQtAz5+gfm6Xj7EQWnnPhcf16rHylbBs5UkxORF7u1AjFzrcXSVOqX2SP1lygth3W/UEEEqLf105zbAIQ+fm29t3k3RbDozzmMbqF15D08Pi0rtvRae+6bfu9lOxtuIIszKJvx3SXByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379275; c=relaxed/simple;
	bh=Rb82lXwhfTwYPKu8Q8XF7KI5JIB8d/RCndqm2TyQhxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEGhFp7RuoRglcd/vzzpapEmXRfbtl2J21TiFZJvbeGg1AuJIK/fUnm6Eau9hiMegJuAUJ99D42FTJSJg5Dziu8f2W6fX0NUv/eKe7mKi7WbzY4ekt7dqAdCNIyC4mKmMLMLcry+fCEXDfcz5DIEFTT9W4unakoaWE3BQ62twwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INEQSCf4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23602481460so58293035ad.0;
        Tue, 01 Jul 2025 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751379273; x=1751984073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN4iAGbjA8Ktlzd5eLTpLdmfO5ssDEZ/FUSkzLKEQtA=;
        b=INEQSCf4nRCzPqv7pAW5eYcDdcL1+lWcjzcw/yS7WLBGKAyIpiFeS6dHlQsvT9ot88
         e+IFX0Fre0dzjOH6nd8oFn/EHFggv4gC6yplwwuqMEdEHgoxLPtFmd6ytAmxnGxl31F+
         bQa2qjiqbYldOc0c7Oj7LZjWbgU5hPMZ8KRSNJ5l7ueZ0/rlINyr9yLGPTsoeZZ6ko1O
         j1IS9QFtNcPyhaLB+r7QfxgSHyvhIBIWSVDXfXvz4nfnN9RVd6MOnepf/JNpR2YeM+yx
         goeh6H40V8fY6BQ3N9A11d5RZ5Y2Tw0roMyS2p4ErxVkrW+sy+3d1pEqzbMYzn4OYbpJ
         Fzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379273; x=1751984073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN4iAGbjA8Ktlzd5eLTpLdmfO5ssDEZ/FUSkzLKEQtA=;
        b=pNilFqpPe2gp9aobeUBAwwV0aPl3ABKFu6KWmqBKiUFvNaGhaJajb6m04fM6vWLovv
         igcR6VJK5Y8ULFxeK8jVgAvt58Xe9un6HjP+djT65BKNASpR0Wa7+bI+4P13soJ8zr1c
         jMAPOkKMBPcCfg1bemylSYzMlz6pK965lCBY1HmDAFwaKZdULKxvxo5m7esTUrld0eIZ
         KN4GxTh71I9UTA7M2x+VbT51ElPBkh1rPTjZowQCfk5UqpddS+ghy4ZubzVR3az8T8UJ
         VwR75Wx+2NGquvMJk4UP7JobBWN73l5EClf4fv1LIkrsv23I/6UU4XJ7Tvq+809RNmHl
         Pb6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfCRjnjAv8yADLtHG6U126w9JoL5Lkm5CQCQVqtC4l4rwSsp7hQIFBq0HaLsed7bqPHAsp0KG4+X0J@vger.kernel.org, AJvYcCUp4E63oFpcTXPUGwNVtnKVMyXahsZp+U7W46+JZLU2sZKtk4ki19yFTC2goG76gERKTX+pqxSAWBVA@vger.kernel.org, AJvYcCWDOSFZejw3DW6Zlkr3tVJ44PLhrubSqDFKv+RPwg+7EcLtMnkn6ZlySDmQNleDwzqx6H6OH7oiuKsjVC//@vger.kernel.org, AJvYcCWNbklLq7iEhs+ShCLoZzZmPYhWbM/jzHMBOCzHOXzlKmJ7wIgZsIq4UsxIAI2JxJ+NbB3Q42M3@vger.kernel.org, AJvYcCXnAqXr2eWk4h7kGg3wHopPiiYIwpADlj88ZHghTJnbSFg99HnR6cWJHot3upFcl3DJEjhog8721+yiQ4y50Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfROhiCCWw8ipqPXSf9Bw0gDmzM7Cre1qZw7LHpuYsbgDhVepw
	6XA/wdi5ryEjA444iXWhxUBxJXqTDCp0mRf6HjCPxeFw+jZb6xbxmlgJ
X-Gm-Gg: ASbGnctTCJ/zLflS5THygmanYzHNdzdOFi5890b1Kie+qlXX5VTa7jxfPWf3fUosGEo
	hFw7yml1INrvpiPMuU2pHm48VQrXNkjUq9A78lQeyrfUuxG3P8BwVWb7YAvayxHvJDzDNa16jZA
	9a9yGRNv3mryRhgDAbanTKWquNLz2N8Q/WKUFj5YwHS7q8jRa3Rj+yqdLOnutG2DPPW07UXMcTf
	z/5CbRzZPvpolYtWqzBVnQaEu2UyWXdDTync4O8pswEHGCx15fgd+2QAn83m2DgQp3HCixCWgC5
	5OAzZpp/LsefC4nVA5mUlCPpeZlYXUuOBRluDZGot+si0PdeUPCUzqvwQ239D2BklwMYNZjmx9r
	yP/+U1iC6XyWkuUlBtX/gPLT000JfxnUGddk=
X-Google-Smtp-Source: AGHT+IGyxcHOqw/Ds4ck8Rm15wPSrkIYKHYGR3uJAD9psSqRiYCXcGDXjJRSBaDoY/cnoS5FY9D23w==
X-Received: by 2002:a17:902:f792:b0:236:6f7b:bf33 with SMTP id d9443c01a7336-23ac45e3681mr309972215ad.24.1751379273052;
        Tue, 01 Jul 2025 07:14:33 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b8324sm107240885ad.178.2025.07.01.07.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:14:32 -0700 (PDT)
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
Subject: [PATCH v2 2/3] rust: net::phy represent DeviceId as transparent wrapper over mdio_device_id
Date: Tue,  1 Jul 2025 23:12:51 +0900
Message-ID: <20250701141252.600113-3-fujita.tomonori@gmail.com>
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


