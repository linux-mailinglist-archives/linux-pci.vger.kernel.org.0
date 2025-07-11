Return-Path: <linux-pci+bounces-31899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE5CB011FE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 06:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45714A703F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 04:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA651CCB40;
	Fri, 11 Jul 2025 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK4GgdvS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F86B1A7AF7;
	Fri, 11 Jul 2025 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752207035; cv=none; b=YrrP32zT7UNZIYTf98636QJ51D1ncDYMdiPruQjOzSa4F+Jmym3HA3bEkxZqCG8TUi9ShA3b6Hhqa2SFkHmvn4HMN542qN5oxl85FbHijQzZDsnX5suZxRdGPPKH4XUXA01m5NTO1Iru5fP5BNlJWPuZfOzwgdYSyrj1CP2YmqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752207035; c=relaxed/simple;
	bh=NYdzn4bzZK/DX+l9u4RVlEZ2M7V5Ui5MJnFn0sT7qlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFrtB1K9TxHRl+Y5bjwEZEAM0KXCA6SVc6zYsp7F9d+wM7dwjqPsTg8HUj3K8FLUNZRN27Reeoosiy24sZ5yKaII5KyZxFIc+mlw7U8y1ZlzdMX3yJVjFiG1erj0cyqfJ8N0q0ulfMUHt7xozL8K6T7aHYLFh0tbf2DISEeaj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jK4GgdvS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso1693513b3a.2;
        Thu, 10 Jul 2025 21:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752207034; x=1752811834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKQNRfLiwMNYz+RbhoybiNi7cvwiTAK0Zc8YMyuPU+Q=;
        b=jK4GgdvSkf/tNw7zRw6GA86m10OeGrhbHiBEvj1/cVo0GZhDeI22DUteBocrLJOcvh
         tnsFpS7+R+jx7vv7UwPheAIDfIA88yTZQEcByhmpbDvfWClwn48W+qpKTSbmS8WaQpqY
         KeQ+6aNYhoxVH4JyWKuPVKfukPfvLjh9b/esws/1JW2mN830rtyD+23jwOLhKVawgvC1
         BhtrN+lWsE6rSItNN+KEWLVijZSvXvvCy3bUaK6gp7xAL/+f9cp/x6iFwWYFXlRYiu83
         B983DrWTTSmUkdZkBycdzVBI5wKmseuWlMHYxjV0MOSBUxGeJ5POrYCfk72bR7STlP0W
         H+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752207034; x=1752811834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKQNRfLiwMNYz+RbhoybiNi7cvwiTAK0Zc8YMyuPU+Q=;
        b=jreZX6hdTfA9Mj54lePqvnY5C4ahbE0D3CMHCiUnIr4MuM16qf/TdruhcuNL1nqj+7
         ErsNaJWq1+mnY2WMY75n0fCrEgkdtUIDZ1Q6HEYjoto4Qvid/8Yfx+sEywRBy4voFjFB
         L0GJ1InbldbDn8jMyVNiCcehgc6mT3B7qZGsAzV+0catnFcItqwt10X97FR5qzfGkfOi
         qymhehn/ICIUlmAHZDrwwXJ/h8L986Os/xbZ9pbYDc9gTO+l/b4mDUd5xt+2ZnTn/aNN
         CxyF9NYFuYel5dm3X1Hk2gQcM9Uc8/sCBPcTKCe7/rFNkvaDrFqVsz/gLlN2+9X1rkjT
         yBWA==
X-Forwarded-Encrypted: i=1; AJvYcCUzOSs026ecCbvc2a8cg2mizhywBlTY7D/yXOIdXQ46nz+k0HueUel9EoOaHVRQp3vECSWX41ivM1e1@vger.kernel.org, AJvYcCVxXDE1O9dMaGkaApU7jTeHK48PnOrmtje4pNCGRtGwX4wnK8M3q34OK2YvX2c6q6aAE8dAduYM6BLYL3QExGg=@vger.kernel.org, AJvYcCWPrTp0tX8cIZZdgtA3eW2QVjG67qozaWZNKjI6477BUtcU6CWuQP0EIgHSg0sLhtVBebAaNO0KQWEu8w==@vger.kernel.org, AJvYcCWcawzP18uu9MaRC4WtOBzwDMaUJA+gt9O1Xl9dZD9NYCKhGMszamIyEXv4gs2QJJBQybl7kftxvjY7n4KC@vger.kernel.org, AJvYcCXTonxr2NiUa59LhzQAk2ohKqIKf8xAic2nG9cFt0ZD3dFERRh/f9wASNfG6X/dM7Y9yvC8HLwzaQ1V@vger.kernel.org, AJvYcCXhuND2pQmpJYQn6iXcRyJs7zL9J1+SNe1ddCRfI4EALNFXEFMbDL5+Et2J0H3g8Kd35BN5+MAY@vger.kernel.org
X-Gm-Message-State: AOJu0YwJI6XPbmYAPDucy3m8eGWzZaVopUQ7YlJ65nC4C2uvN58KUHi/
	gGX1NMxwhPHO0xF0OL0LwcPqiob/RvhC+x5DsQjdGf9KOEBq8m3ipbhn
X-Gm-Gg: ASbGnctqS35on4R0JLaGOK8js6eVFpG2+qtMChLWPCt6vWPzglRn7MSqV92j62rZIgN
	NnnLwO57xf4TNO1XpZmpiuGgFGttRNMtaUuzps/UrjTuCwxOx52jKU4yje2sXV6I4PdkUSuCweX
	fG3ijfZsGYaDjxCtwNcCI+VFQvhodQakA7gvaKQuoDOpbg970yEuM9xB8l1wUIr140eFqGRzf7V
	xOYpGn94a8ASk/6VXlZurROuQGme9y6P2hIEydSIqE8ogn4FF8sYIWreTT+qPJaRY408HFdthiQ
	JdNov8+uZdlNRV7PBJuQZtbikZZGvgm5TbEudR34DBzi/MMuGXIHWdJedX8nWt/JivTWnI1V7Jq
	OvyJRjkTjj8T+oNXn+Aa2r1SQ5YXwsskvh9ML+JYs3z/erYTrAXrRSZhQ9O1Xqncq+oirQ10=
X-Google-Smtp-Source: AGHT+IEbIdGkpA2W2Gy1wpx5qJPhxRbcqQj4wR5Pfptb5+eOqCXfrSh2swZyuKtThg35F2fRnphmFA==
X-Received: by 2002:a05:6a21:3385:b0:220:78b9:f849 with SMTP id adf61e73a8af0-23136861dcfmr2820636637.24.1752207033613;
        Thu, 10 Jul 2025 21:10:33 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f4fc8sm3902095a12.51.2025.07.10.21.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 21:10:33 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: alex.gaynor@gmail.com,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	robh@kernel.org,
	saravanak@google.com,
	tmgross@umich.edu
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
	lenb@kernel.org,
	leon@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lossin@kernel.org,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v4 2/3] rust: net::phy represent DeviceId as transparent wrapper over mdio_device_id
Date: Fri, 11 Jul 2025 13:09:46 +0900
Message-ID: <20250711040947.1252162-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711040947.1252162-1-fujita.tomonori@gmail.com>
References: <20250711040947.1252162-1-fujita.tomonori@gmail.com>
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
use the RawDeviceId trait.

Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 55 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 32ea43ece646..f44e8107cec4 100644
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
 
-    /// Get a `mask` as u32.
+    /// Get the MDIO device's PHY ID.
+    pub const fn id(&self) -> u32 {
+        self.0.phy_id
+    }
+
+    /// Get the MDIO device's match mask.
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


