Return-Path: <linux-pci+bounces-30342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A4AE3560
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 08:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C931716DD9A
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 06:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884031F237E;
	Mon, 23 Jun 2025 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bld7Lg0/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2B51F09A3;
	Mon, 23 Jun 2025 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659041; cv=none; b=C5ITCp30XEs4IyJOyDLtvSj9Vbjlr3UlZDZTPqzuwf5eo9RzF5bQEwIka0jeSFybhBmYyhJW/ulrDWhOqOcI7vz3FOhi+xA46Q9Ues2tgbz1KVYGXkdzIqrrJ9iu7Fmxv88erxloOqpHGFvxF53w1DoPXNC+GaD6qWW4A+A9pFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659041; c=relaxed/simple;
	bh=izClx4fO0QxlG0vSrI5j+u7UAglO6fztpbLAObv8R60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWxYl6tVtRBio754VSGBLAOxnc52DEBYwOQ6w2D7GdUIXz73XROiLs+Y66LdKNxm+aapVZXymK76sI3MuXaBed/WZHBH4qNY8S4H+WMWJOkV1OCcuuZLLDYo7w3gYF4KdWk92U+XQEe5Vc4uEQk1NLathj6jcoxHKzSR6gylCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bld7Lg0/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-747ef5996edso2783500b3a.0;
        Sun, 22 Jun 2025 23:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750659039; x=1751263839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdNaQL9Tu2TPrfssmRGP1lW46RFC7Xf3kc9ghofgNjg=;
        b=bld7Lg0/l+lGaG9IZZJkYx3uQsdUBTCUJ84fe7aLTHLAwVylDDGl2N+yHx86duQ+hf
         iWk3+ClTvc2G5+JDK8+WHcpBV50kgcmN/da4D5ubTc16u951CzOr+Fg/j65MSgJKNdUL
         z8QCtR8fUaDK1AMfUBToQzNefcWgKuzwYJGH/6+6VZ2O6JmJ2n31WlCboUYcG0/8wYFN
         ecILiLguVW9LOHuNuTOI1wfY7Z4+vX5uZMcGYyAY3wBA0O07v8tmI/iZgRzL9SQUp4dR
         ixBGq8UBm4bD+h77rCA4VLnyO5h6IFZB40+Py3qoCs6knZ9lkui0ODadIp+h2nQ28uqK
         W8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750659039; x=1751263839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdNaQL9Tu2TPrfssmRGP1lW46RFC7Xf3kc9ghofgNjg=;
        b=TPTaWcq0L9pQj5QLc6TTKhhzpIrVjejLGypn54jdLX/nzuWFLQrGGt5pfCsdVW1owD
         yjSqGuU2FhpTN3acMtYo0VPtA6o1tVuK5tXfx4pHaNte+l5kjfzr5U/lRHHBvXZqToqZ
         F9ZY6Hov4P9AaM/CJ2/mNuNzj2pqhoC0pWQ+juv7mw6410W8VRVKnhx7irdT/1R/bDlx
         Ujs2cAnCJuFL72UkqKRze9B441pk19N9Kb47VeIs3jByBSRgZ2KLxNNsEtBsL+emtUB0
         iexGeP/kgIgTzwab/Ctqe5plYXOUlGrR2Hcv9Qu4TjF09GLBhLaHF65AVQbYM5qyJJnO
         6lbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbi+rNjc616gFx1WmqJ8UPrgunOgNA5sWKWhumcSSMglEnzXrJD7Y0LKRHqrYZVEbb23dwxS0yAk58@vger.kernel.org, AJvYcCVOBLHuFm9yt07pSJNgN/00/Tfx2ozvMXMOj3XtxEw3vYAO2BcQjZEumgUlyQ33U/E0wY/7+ou4@vger.kernel.org, AJvYcCVg0kV284p5Tb5JNQO/YLnrccURQ1Rvw7LVgvP9apoAivWK8PXJoS37ngrBoWuL5Dvm61wnFXDaE0yVM6jh@vger.kernel.org, AJvYcCW2ICi/oYEYdsXdXKIsh8SeQgdIM9YqvY7Bv4GgPf3JEul2MnjyImjfAzEfWZCYJHdaZx78DEIIv6h0@vger.kernel.org, AJvYcCWpidDIswsC4Q9yVIVHGbn3isPe9alrPfkuZE8maHbtzHuiazn98QJpu8J2sdG1CQ+2NtzXDyT3vw4vWncmTDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXfDN26tVCtQ9AdWmQmf/7Qd4ETQ9IxsJM68UIoeZzK6UTy6q
	xn62DUeimY0wdfX6gUDJYM9GLwVEi59jlwmeLOg4Yh24LPKUodXabS0vGybbKJOp
X-Gm-Gg: ASbGncuqBNOoKVB7MkMLjpuau2DvwFbPiuyFuD8TmqDYOkpq0A6h4QNn693ZpOvaIrE
	tVJxIWneTuoG0avb9q2Rop3UT9ZGlCnHp2P+i0J3LyN/mWHIP9s3kmTEqa04/U9iURSdC1PKuLL
	bESxWf+QP+lZLm8W4iCUM9MUjVNj03J02KnL4qMaNy13sTuZlYC1VKPQ/A8CKOxDpxdttDRFmnP
	UzDN4//w8Xlor6m+jDU6xe9DKUeUHwqZYvPcQZ3j4C7fZTzq69hb9wptADRYavjgq3ljcTsTwlq
	fkuJwTpw4lvg5bIwbF376MxLTTZqD8HDw5uvzIEVBX/+0egKC6bBEcFkK+3UlbiTZcy71Xw8Y03
	kmHpEBZAh0rLH1D3eO2Iyzmv7d3ozQFohOwFUatQNbZpRVw==
X-Google-Smtp-Source: AGHT+IHoBjjoSv77pVEgY+g6rKcikXxyv+N7sZn8ywOJg/2GiBRo3MVDptmc4Vvya/wsfy3DQnBNJA==
X-Received: by 2002:a05:6a20:9191:b0:1f5:8cc8:9cbe with SMTP id adf61e73a8af0-22026e60364mr14271591637.5.1750659039259;
        Sun, 22 Jun 2025 23:10:39 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a623e8csm7391703b3a.83.2025.06.22.23.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 23:10:38 -0700 (PDT)
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
Subject: [PATCH v1 3/3] rust: net::phy Change module_phy_driver macro to use module_device_table macro
Date: Mon, 23 Jun 2025 15:09:51 +0900
Message-ID: <20250623060951.118564-4-fujita.tomonori@gmail.com>
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

Change module_phy_driver macro to build device tables which are
exported to userspace by using module_device_table macro.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 56 ++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 940972ffadae..4d797f7b79d2 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -6,7 +6,7 @@
 //!
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
-use crate::{error::*, prelude::*, types::Opaque};
+use crate::{device_id::RawDeviceId, error::*, prelude::*, types::Opaque};
 use core::{marker::PhantomData, ptr::addr_of_mut};
 
 pub mod reg;
@@ -750,6 +750,17 @@ pub const fn mdio_device_id(&self) -> bindings::mdio_device_id {
     }
 }
 
+// SAFETY: [`DeviceId`] is a `#[repr(transparent)` wrapper of `struct mdio_device_id`
+// and does not add additional invariants, so it's safe to transmute to `RawType`.
+unsafe impl RawDeviceId for DeviceId {
+    type RawType = bindings::mdio_device_id;
+
+    // This should never be called.
+    fn index(&self) -> usize {
+        0
+    }
+}
+
 enum DeviceMask {
     Exact,
     Model,
@@ -850,19 +861,18 @@ const fn as_int(&self) -> u32 {
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
+///     ::kernel::device_id::IdArray::new([
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
@@ -873,20 +883,12 @@ macro_rules! module_phy_driver {
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
+            $crate::device_id::IdArray::new([ $(($dev,())),+, ]);
 
-        #[cfg(MODULE)]
-        #[no_mangle]
-        static __mod_device_table__mdio__phydev: [$crate::bindings::mdio_device_id;
-            $crate::module_phy_driver!(@count_devices $($dev),+) + 1] = _DEVICE_TABLE;
+        $crate::module_device_table!("mdio", phydev, TABLE);
     };
 
     (drivers: [$($driver:ident),+ $(,)?], device_table: [$($dev:expr),+ $(,)?], $($f:tt)*) => {
-- 
2.43.0


