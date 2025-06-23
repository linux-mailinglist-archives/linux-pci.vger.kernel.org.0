Return-Path: <linux-pci+bounces-30341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B0AE355C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 08:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909543B15AF
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 06:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914BD1EB1BF;
	Mon, 23 Jun 2025 06:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyq4S5eL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30E21E834B;
	Mon, 23 Jun 2025 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659036; cv=none; b=vCbDFRCgDNYrk5t6K+ZuQWADjNQO5Y6JQFm3+8GqAlsrW/M0MuSwA+SAslv49ewB3OYGFoZURGUgXwhAFBKXc7WXMpwtMAYmkoDTEer6hS4BA8rOZHem/SQmchD28/KC4JY3xlENLYydTeaXJeGBWGoed5QCTYfvfi0WNTQSkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659036; c=relaxed/simple;
	bh=Rb82lXwhfTwYPKu8Q8XF7KI5JIB8d/RCndqm2TyQhxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8T8UR/c8h2hSP8THE3rWpgT6B+InGu8lAOPMQ+Cc47CfIEzS4AN2NtHg1iLxomM/5FQFujVR+v4SoRUfRLvNaSKlHS1JQEuCd/9w8AwIqeeqtg8vtSaxwjUeYqMGnvpl6TFIhZ7IEWw/catLzlfg3z7CJABeFzexadoXYPpC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zyq4S5eL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2581815b3a.0;
        Sun, 22 Jun 2025 23:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750659034; x=1751263834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN4iAGbjA8Ktlzd5eLTpLdmfO5ssDEZ/FUSkzLKEQtA=;
        b=Zyq4S5eLchJI5OfCr0mTEoTJQiRjdqKh8icmG+eU+ezgFjkHFe+Snb9zRtvIp8noIk
         gAQM3NyZRSBE/WIG0wX0/JS4k3sqZhTwTTeQN+LpH86FoEu0vigjSIy1PlzQvIdOq4vb
         eacA8RWRmPxqpYv5U/9aWmQtkDsBcgrU4dGb5+CIoWkQITtu2n5wdJ+EAeGTGhaPP5yQ
         utcMT6ajJGlmsD2FO8Dz1lE7bR4bzxUBMndeZqujVAwxzK1HDU9PvM/V2TxbNlC88/yP
         k0kt/paUaHpf3vqCrzVbNzT6X1UOYISn7rZF+c2MXHFBh9NOn6Fi7WMgEEuCG90Vb5Xf
         SJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750659034; x=1751263834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN4iAGbjA8Ktlzd5eLTpLdmfO5ssDEZ/FUSkzLKEQtA=;
        b=Ujz7abKdE87TEEbGp64ez3cP/ro/40EmVafCgu0xefsJkiKoGG1k/L/mbeeyo+JqJg
         N6IdO2KL/uTSi+z2QDIBPRKNlTM449qQaxrMjf5+qB+WtWVMOCimHze+NIGDAkmbw9MD
         cDAUjggloPD+f086mATACTtvb5comoggeIEhLLTcO8BIcArMfeGkTO90ZaYG/J3hkeeW
         t+eXcQd2zu5WzN9X0btl5rH9YyZ6c7Z9YIJwWAa0YGEq9nJjBrGJseCFr1kf/aVmGSj2
         rSuVWXE//nDQBJFjAi4mbzakDCRBCvHDySqzjbK5UtTJ30oiWBYkSSIZARg2IvAMAwYo
         qb2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3QjQ2SBaYfQBypHXR7Y7o575slbe6+Gj7GZXPnBEtTAR/NdNGRpxxZ9iHhsuRZGmhkGhHmTzbprc3@vger.kernel.org, AJvYcCUmk0YdzoKJPhF6DiGygipWJikBTzHx0v5dE08uC4LR4KwjSp9MNrUM+10iMXJ0/AjCLtwkNgOEcYF4nEEnT1I=@vger.kernel.org, AJvYcCVNZQHXjjlY844LFdkaHZZhYOL3ZtJbGHQSZV6FYH1tZPJ1qxzcF1ciHsqwM8h7tG14bRLgsgLi@vger.kernel.org, AJvYcCX6NkcrxVGB7It8Etpn35c9vvFDwo2JfiSWD/KSu6sOYUdYt2kID9mQAXjqKmNVeH5GvMfTJLLYP/WjWiKe@vger.kernel.org, AJvYcCXeg5b61EEdUJE13/kKOSTnfhtd+dqZ4l6XaSQ9ObIYJ1pfKgk0m9QnB3eQiNtbIb4Rg8nE2yb6JIKb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7mtD8QI5jc6NofRmmtuR5ePYK5DvM1xH3afky+vR+2P0LSmad
	XOiNPvf6DJdKBCWCGMpVHWvVLVmrwH2EaAUSxUHCATb8IbOrtoczMRVq
X-Gm-Gg: ASbGnctE3u/MCq/NvcouTpKNtA7pADQZ3afWaAO4BHbPcG2mENWayIceSUPstmPSANF
	tWhfY8vKEHTA310exPwh0w7k3RXEhujWAdbjnC4yzd/TQmWZEJYoa10Lhy835Hf7cIOQN+x/C0J
	nNO+VxCt02Fv6QxldaWmCBT065La5YQou6CHAd21s/qQoWzLmOiSxmUt6xloCEme2CgzLffK2Qq
	PA0m7dTQArxvhHgDWgPwBsE4kU11Ovm5reohkgEOai6H8Hxn3zcGaGxy8SEd8a0dVMQoovhR7F4
	aCkln7iuS9hU/UzhpObLHEeSOPHNXg5zcShNoSuJLymMXsRHlbmgIfYRdU5TJsCGnDRlJ7E8x8q
	3/mpmtij7qjv8m+3wBzuByNEPXFIrJc3Dj9U=
X-Google-Smtp-Source: AGHT+IHJ0s+N82fET2NTu68HyBSgQnjWLVAQ5sAX+rRcZnyNqTiAyvuOJxtF7RDTNY4WSH3gQTcYrw==
X-Received: by 2002:a05:6300:194:b0:220:21bf:b112 with SMTP id adf61e73a8af0-22026c3228amr16754814637.13.1750659034306;
        Sun, 22 Jun 2025 23:10:34 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a623e8csm7391703b3a.83.2025.06.22.23.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 23:10:33 -0700 (PDT)
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
Subject: [PATCH v1 2/3] rust: net::phy Represent DeviceId as transparent wrapper over mdio_device_id
Date: Mon, 23 Jun 2025 15:09:50 +0900
Message-ID: <20250623060951.118564-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623060951.118564-1-fujita.tomonori@gmail.com>
References: <20250623060951.118564-1-fujita.tomonori@gmail.com>
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


