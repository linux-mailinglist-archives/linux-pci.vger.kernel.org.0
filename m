Return-Path: <linux-pci+bounces-30340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA45AE3557
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 08:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897653A8D4F
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 06:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44441E25F9;
	Mon, 23 Jun 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjK2JpSL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330537261A;
	Mon, 23 Jun 2025 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659031; cv=none; b=bNAsuHy4a3smFkaXV45i45bkxG9euNd6bOBAx0z1AQIzPllh2QMp+JIGnqbkDHNbzlJyVCS5/fszVx4F1tYx87yhuBHj5orvHZDjH0qvEHeRxI+D++WPhw+L9jAHx2076cOmddDIYEApM2yLZNL8n3vSGRenLcRi97AOXqOV8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659031; c=relaxed/simple;
	bh=IX3NSHlFBlGmB80LzrBmBb2dfRqQ2p09Y20SMWJhES0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vn1i1svIRMO4t4oGQLxe2X1dQRGIyRyW6+HRWnwKTDlL6N3C5M44kMN4vUoObtzs95y4pWtYGq1dFFAtFrb29pqTNjM+bENacDqgLKxxqE3+wtWJ2GEKZIungYOe3pMC4svIRIxfWXyo96NrzndK16Gg6dC7gxdhWQm+7LQrpxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjK2JpSL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748e81d37a7so2256501b3a.1;
        Sun, 22 Jun 2025 23:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750659029; x=1751263829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UrEMakr0gNd8OjD7Qs2/TZiEbnDjNEMNzH2cXICJsw=;
        b=TjK2JpSLcLqxw3SMsHJHwsHiPJ/PLBDtjkhziFZkOBvL7eEWSKmScDe1+pfWi+UkUi
         bVunFlNa0MAINvlKLHr1w3PPCaafYSNWLtXPcSs4MPSMDsvV4MPM8HB0QqBKhGJ0YPpx
         MK4mvNRhXignSnBMHsFiS4NQjwgkJMFBAqO5hE1Fkt0S4U4LYC5y5QVfatYe8j7L/zyJ
         EMCFH/cbzZCD3kzFfSEL8I6Z1wWrbpOYtoVDxdubIZmc0nXqoK2/C2q1w0++3w0ezNZH
         R4rFQBkW6cqfSjb0V0/nYaLYz7z9z8Njyy0dV840pQPhhBIY71mh6hk2hH1wiIBxUlbw
         wOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750659029; x=1751263829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UrEMakr0gNd8OjD7Qs2/TZiEbnDjNEMNzH2cXICJsw=;
        b=hyK1MOnanO2Ni9G1mZN00jo8HxchdK9AmEr5bTC+gqlbmN4J5BFTxKPfT7lctRAKj2
         GCCr6rvd731Xt5pUyCtrUMk7KMQO4tmS8ipW166RDBuyGVbiWS1VWYQip6p8JVLFYLIL
         VC9kR3tjoOncf/U7F1BxmqtC+vd28Aa3YJ4LYSOaaYHzLjlno22+1/faQy3UTIbptTbB
         51kmCYaPGuCRvHYCQWHL0d+mjPRkSPBHTmphwfIJ4V+P7Y5F1wZnT/Os590YGlETfgv0
         kXn1a/DaVX8wxuyuip0Z734KguV80MeZNLL2zn8zz5/ukm6idCG2dC6XhxM4liwvoIir
         n/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUVZOLDPdYsvU962vHV0X6e9y7Y9gFLiRb/TgxwS9Fsh7JtsP8WWL08nSsv50Ui1mMlMdQr1kwuTBK4HLiU@vger.kernel.org, AJvYcCWD1dLKDNbsxycNhOObUSbdzPGBkccAeuAg/AHpkUx0DkpqXVLiJuPVRd5H7BJq5E325D9okY1DN2EcP4nVJV8=@vger.kernel.org, AJvYcCXBTdXJcJj2y+W27o4lTCXdeVhZdQ7z7t7Mj95PxBuA7jYWFl+5Tjf6qMEz0hErnLtt75+kVbf9F+eD@vger.kernel.org, AJvYcCXVFr0J1pGr95UAGKPFpTgvh3Xy2NdRhELc7/V1OAheoaEYJbi/JiOcX4cvR/hkj6OlgSyQPfd+e9sI@vger.kernel.org, AJvYcCXsLMfHlhi+icjOkm2LdHfQefMXeOt9e0KH+0trqnCyLgRRuoZzbLOFa940CCw+M0Azcxpl6Geb@vger.kernel.org
X-Gm-Message-State: AOJu0YzYdMtYiIqClxP0PSFUz/+QBLXzAAWT3RqyvbDvrGIy2tOCnnTr
	RaVPkwZ9I+IhOWI75lVY1NOHSzZkphdz28F7DdNFRgc70PLPRfHoxQ5q
X-Gm-Gg: ASbGncsdacLWzFNoigyHlO1mwubUtGbVNY722lWH4r517ixdVdOoCAEQBKz6vqYIGps
	0skQ0U4kgAd42APghOcYVCttSdkiUOhuZcFsrLiZPtmqo1y7mj0uAcrFQSY1g18Hgkzxs/YKE55
	7uJUrIG8d1nkFyEUOUX1ThBdTJGuPs0aQx9ZIGWNqSKkYT8vsduXS3qDic6MCeQ0kKvSY2Yy9fP
	mfMh6vnMyfQpIrKDERSpAmrlsN8JydyEnty0Wn+RKpHBsjKdfillerX18T4q+BfWrynmKCwPWkQ
	k4C6ubjSoXC4Z+q6+xIeuIsQCgXlF6RaN7XcDIbAGYPuZgTCA0P5KDHb7Cc0ighHNgtpp1CYLUm
	xzkibEKhQ04WXjKU3k5x0JOJ3l+oJUHXrAu58p+8rR37teQ==
X-Google-Smtp-Source: AGHT+IGb+SPdwtli8hWJX/3MATXUDCSBw1nh68ByuvWCuMCmxTeajAuLE7PtMYnfrTz0U4bXbfCOMA==
X-Received: by 2002:a05:6a00:1990:b0:749:bc7:1577 with SMTP id d2e1a72fcca58-7490d7a4452mr14881186b3a.9.1750659029307;
        Sun, 22 Jun 2025 23:10:29 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a623e8csm7391703b3a.83.2025.06.22.23.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 23:10:29 -0700 (PDT)
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
Subject: [PATCH v1 1/3] rust: device_id: make DRIVER_DATA_OFFSET optional
Date: Mon, 23 Jun 2025 15:09:49 +0900
Message-ID: <20250623060951.118564-2-fujita.tomonori@gmail.com>
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

Enable support for device ID structures that do not contain
context/data field (usually named `driver_data`), making the trait
usable in a wider range of subsystems and buses.

Several such structures are defined in
include/linux/mod_devicetable.h.

This refactoring is a preparation for enabling the PHY abstractions to
use device_id trait.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/auxiliary.rs |  6 ++++--
 rust/kernel/device_id.rs | 26 +++++++++++++++-----------
 rust/kernel/of.rs        |  3 ++-
 rust/kernel/pci.rs       |  3 ++-
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index d2cfe1eeefb6..7b8798599128 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -147,8 +147,10 @@ pub const fn new(modname: &'static CStr, name: &'static CStr) -> Self {
 unsafe impl RawDeviceId for DeviceId {
     type RawType = bindings::auxiliary_device_id;
 
-    const DRIVER_DATA_OFFSET: usize =
-        core::mem::offset_of!(bindings::auxiliary_device_id, driver_data);
+    const DRIVER_DATA_OFFSET: Option<usize> = Some(core::mem::offset_of!(
+        bindings::auxiliary_device_id,
+        driver_data
+    ));
 
     fn index(&self) -> usize {
         self.0.driver_data
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 3dc72ca8cfc2..b7d00587a0e2 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -25,8 +25,9 @@
 ///     transmute; however, const trait functions relies on `const_trait_impl` unstable feature,
 ///     which is broken/gone in Rust 1.73.
 ///
-///   - `DRIVER_DATA_OFFSET` is the offset of context/data field of the device ID (usually named
-///     `driver_data`) of the device ID, the field is suitable sized to write a `usize` value.
+///   - If [`RawDeviceId::DRIVER_DATA_OFFSET`] is `Some(offset)`, it's the offset of
+///     context/data field of the device ID (usually named `driver_data`) of the device ID,
+///     the field is suitable sized to write a `usize` value.
 ///
 ///     Similar to the previous requirement, the data should ideally be added during `Self` to
 ///     `RawType` conversion, but there's currently no way to do it when using traits in const.
@@ -37,7 +38,7 @@ pub unsafe trait RawDeviceId {
     type RawType: Copy;
 
     /// The offset to the context/data field.
-    const DRIVER_DATA_OFFSET: usize;
+    const DRIVER_DATA_OFFSET: Option<usize> = None;
 
     /// The index stored at `DRIVER_DATA_OFFSET` of the implementor of the [`RawDeviceId`] trait.
     fn index(&self) -> usize;
@@ -77,14 +78,17 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
             // SAFETY: by the safety requirement of `RawDeviceId`, we're guaranteed that `T` is
             // layout-wise compatible with `RawType`.
             raw_ids[i] = unsafe { core::mem::transmute_copy(&ids[i].0) };
-            // SAFETY: by the safety requirement of `RawDeviceId`, this would be effectively
-            // `raw_ids[i].driver_data = i;`.
-            unsafe {
-                raw_ids[i]
-                    .as_mut_ptr()
-                    .byte_add(T::DRIVER_DATA_OFFSET)
-                    .cast::<usize>()
-                    .write(i);
+
+            if let Some(data_offset) = T::DRIVER_DATA_OFFSET {
+                // SAFETY: by the safety requirement of `RawDeviceId`, this would be effectively
+                // `raw_ids[i].driver_data = i;`.
+                unsafe {
+                    raw_ids[i]
+                        .as_mut_ptr()
+                        .byte_add(data_offset)
+                        .cast::<usize>()
+                        .write(i);
+                }
             }
 
             // SAFETY: this is effectively a move: `infos[i] = ids[i].1`. We make a copy here but
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 40d1bd13682c..0ca1692d61f3 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -19,7 +19,8 @@
 unsafe impl RawDeviceId for DeviceId {
     type RawType = bindings::of_device_id;
 
-    const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
+    const DRIVER_DATA_OFFSET: Option<usize> =
+        Some(core::mem::offset_of!(bindings::of_device_id, data));
 
     fn index(&self) -> usize {
         self.0.data as usize
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f6b19764ad17..dea49abe7cd3 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -168,7 +168,8 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
 unsafe impl RawDeviceId for DeviceId {
     type RawType = bindings::pci_device_id;
 
-    const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::pci_device_id, driver_data);
+    const DRIVER_DATA_OFFSET: Option<usize> =
+        Some(core::mem::offset_of!(bindings::pci_device_id, driver_data));
 
     fn index(&self) -> usize {
         self.0.driver_data
-- 
2.43.0


