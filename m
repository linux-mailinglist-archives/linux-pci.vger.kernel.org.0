Return-Path: <linux-pci+bounces-31900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18947B01206
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 06:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E913AE688
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 04:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787201D9346;
	Fri, 11 Jul 2025 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3L0xCES"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42F11A7AF7;
	Fri, 11 Jul 2025 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752207041; cv=none; b=KamQJi9NiM+ynDM/uBPyff7j87fVmz8vUbeygXqS9SxJ0C5VCCLNYZRYX746OvOaZq9N56eSyTnkCNLslEXNY4Mb6J/9JkZG7MZ00bNbbABo88F06iRk7fcLuaXiS6iUyrpGFEVZZm2pATCYCdl0Vw3RRxk91mDU3C8s5zstN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752207041; c=relaxed/simple;
	bh=hJB5UNZJFKPG2CgDqbDXrpAZl8wnBtsy+3T2LOvpdKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbinDTYNsuEu4Nxs6ztSUwcpTHE7FDAPLD7rtJpwUUDpLBu+O0YcqmbeD09G6Ed1ETb4zSqbwGHPVL+VU3Wm47FRBp6iuf4TZajXDub/T6shVSwXmfkRybZOPxKgSTK+3hMaMWzpLW9vTx1RtXL/C8WcQM7Ii3xt4ni/tdqtDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3L0xCES; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3137c20213cso1656423a91.3;
        Thu, 10 Jul 2025 21:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752207039; x=1752811839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FftY+H42oo78/iJj/bhTIQoeZQcrJ3tJuTl2e4g04Ts=;
        b=E3L0xCESOOmFpI7BP8S10EU/fXyujfybEG9/C4I0/hFHukm/wndUNjxiTWKx/OVLRF
         xAOGtS+zZdIAQUm0Ii56m9B4le4zGdpRM3xu6VsxL+tMHfmpzRCGj2a01K0uO+9kzoQ9
         IFV5725v2tE4VsS9JW3/jPDHC5rQ/c1Vy7VU0hUnyaD4KY+2QUdH3Fzy6H5q0wr9Phff
         P7zD1OcGHejgP6SGaOEhH8Fapny+DrvMo7RBg1AfMJ723JnMANbxJCAb+BH03w8RPGr6
         Y6uaMi3Sl5X/5CLo6d79j+FOVOVwL/ly/ZwpE7EbBFCPPS2EXrSXC254GO3wOqrKQaix
         nx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752207039; x=1752811839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FftY+H42oo78/iJj/bhTIQoeZQcrJ3tJuTl2e4g04Ts=;
        b=MhEMnZUJRyWW31LG8wjSm3KA0h3TNkaI/ek/bNtUQlV3KjMCAu3LTszlr+akt8fawN
         GLQ/Mgh8U4Xog1ZtH6mXhRgXXjYz3iVID8w7xoh9e+wAU2BdZXOTV2YSEA6LwzLLDrxV
         OvtNRHyh8BZb6DYOeRHkfbS41ZelUpCQmc5Xi4e+Z72V2Cm96dkEUAHAru57MQw+yU5C
         PUH6CncZc2oK/MFkQNcO8oOAskqIZRwjl0WJwd5Y/DcuCXgYvDYsWIz313nQOp9107br
         BDlfzz1NjFojWuRdwZYwErovjG4Gu/UJRNIw60EQLbBBZVhuvFZtSvyvZuUj6+vDwWoA
         y4+w==
X-Forwarded-Encrypted: i=1; AJvYcCUMCvHqQy5pU73/hWkKkeJWlF1+1NCmjJeKvlaGg9ydhi+ulLESPdiSQGsUQhkEf+7UhjFfci3ER/uX@vger.kernel.org, AJvYcCUNorcnO+jTy247qD7v+Q0Yhmda4lH/p9rqO5hReFv2yefAGEZTIgAjhaI0iHsYnkdK6xzs/dL2dLvD@vger.kernel.org, AJvYcCUROa0mZ3BVr8e7ILLV6EixPyUIDNH1dAw0FWs9hOpgCS1k4/AJCSZbH3SuM9viEmJjCC5MSGKoBU7nu9A/@vger.kernel.org, AJvYcCUz8SCgOYckDyyP5UOxLWDyY0vOy/Fb30Mm9uEs8zcsOEu4e+GbW444OEoajcGIpOVXCGeB9sZKVRBiVw==@vger.kernel.org, AJvYcCXQUB56XFQ8Nq7MT/USBEHVX1QmJhGR5r23GJs2CzJ/to+erJ+OGYfQrflyU/ZGlSu5aOaA5gDs@vger.kernel.org, AJvYcCXR0lfFUCWV6X6a1mm83ux7CGvp06lHNOU2IWkSiFy83CgWci0G6K2e4jnBxauSXG43UGfmLSTuKC9dNxHqdcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9eLflw/pchEqWlIrtdsew6NyAJEFmGzoeV2VPKjwRQKJc1ynE
	8pFq0u4dftRMRMJHialrGIRzENENsdCckvXdLg4L1LABt8WwOFO+8cvx
X-Gm-Gg: ASbGncv9iUa3haI734IMp0KQDlL+IZyTIyrw4o0tmjEaMZbXLFHtNRYz7hazfxhFtKu
	1t8vvgBa2a7roEtxJd/kCk48szX2cshecGHFSi4EW3vKApFNNZw1ozXs8kwgs/yFMQ50+xdLm/M
	Bls5bwNHKBMITuODE/TTTTiNJAz//izg7WxSwJUp1hxemH/IM6zh8B051fd/5L4hVUNAxGaIuDT
	hDgILrz86ORZDCgeIInoF1JVUVhXg8MPMLnFHTmP5pdVAdLny9H80iSWhrmj8gbS1B5ZqSnw1Rz
	j6S45w1aLsWqXeBBHk90Ads2oNlO2L3v+7PENa0kZKmVwaFivVHbXv1+YvxmCITTSb0lm2tdwvI
	VrHWAeupnFOivuoVFqQQhvCBFUlaXOeY60Dw+ewBwzTsgQw/3EKZdhZfl65pT1YHcpRNvKCKJQ/
	UbRp+fEg==
X-Google-Smtp-Source: AGHT+IFWTiFyINY3p3GkFh9rLrPAgb2Rm2YLBk8fWEOnNPV1fS36WcePgUDPT5GTTf3HkIlDqW/aCA==
X-Received: by 2002:a17:90b:2ecb:b0:311:f99e:7f4a with SMTP id 98e67ed59e1d1-31c4ccedab5mr2713396a91.26.1752207039080;
        Thu, 10 Jul 2025 21:10:39 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f4fc8sm3902095a12.51.2025.07.10.21.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 21:10:38 -0700 (PDT)
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
Subject: [PATCH v4 3/3] rust: net::phy Change module_phy_driver macro to use module_device_table macro
Date: Fri, 11 Jul 2025 13:09:47 +0900
Message-ID: <20250711040947.1252162-4-fujita.tomonori@gmail.com>
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

Change module_phy_driver macro to build device tables which are
exported to userspace by using module_device_table macro.

Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 51 ++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index f44e8107cec4..8b94f964f936 100644
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


