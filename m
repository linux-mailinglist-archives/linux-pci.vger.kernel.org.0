Return-Path: <linux-pci+bounces-30464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7B8AE57A3
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 00:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B99189B989
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 22:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A606A227EB9;
	Mon, 23 Jun 2025 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTiAkh0F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9B225A23;
	Mon, 23 Jun 2025 22:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750719544; cv=none; b=cO52NDQF9Fa1mohe/GCL4MBTxVJU/KUjf6MCi6Uala579l1zGqsnEBzXLCZSYvseB7566pawi0MFPPyPpQ2V03jvtXK4YzbBMXJLrJypmxMjTSZmKTay5y1CgccWRgZSFj3mWY8qNqgXBWolOV5raUdaji9cur+ut6xj/bd1AI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750719544; c=relaxed/simple;
	bh=aodqo2TfNv//TKLZmuT/byFBC/ScJXPbbKHlGhkNSr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LifOGSzpt8Nc7ZVyAFA+ILESaoP8WPh+sVQWui5KYbn4OlMQG3W0vMF40lmasgzDGkd+XHj8C6GOugJEYHuf9cYKHnNzUkVbB6UNLR7wGDPvNQ1K7uB1epXZeZW9rewIP136nMOALh78gRGqCax6fwPANVvaEGmKX9+mtN7Uh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTiAkh0F; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747c2cc3419so3390595b3a.2;
        Mon, 23 Jun 2025 15:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750719542; x=1751324342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pcy7yresPbC3EzSIERmqz2XWS4vYmJ0nwu020eXVaWA=;
        b=kTiAkh0F4xJ55La83JmomVrdT01B8C3gN06ytrPw07O1tDbOvJDWmFY2wmpfFS4blr
         CKxR1/QSx7qqYnE9xjNMQlC1KgbKbAXZKJX+lt4ofcpbweV5kHu+VRr04LnUHK2bUC8U
         TXXKI7L07kHnQyphrVWndSrE4fp5+eKWPv1IAJmsTUThJ19F+1FiJzzOtNfmRs7JkotU
         eyUA2u+rasY88I4B+si523wPjOgG2wxB7284+QSdmfPYqVR0/8q7jAO7gXLxCUqlsXtz
         iV98zzCfXweZX3ZBnl/sEs8ZbG+56vcXsOP+bHIz1g4sIxhCRPMPl1gDIq63WeWQOgBl
         fdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750719542; x=1751324342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pcy7yresPbC3EzSIERmqz2XWS4vYmJ0nwu020eXVaWA=;
        b=wdqrQGUV3uCmtyFrfH5Hr8YurOPrMvtI6vgJZqvHtYP70pcp1Ey+OdDu6IU6pqTm9n
         HseGg/PwkCTvu0gzJuL/ISS+SfJCpS9bHAlEzv1VgIOaQqhmz5QMQ7cMZMnBlMzX3RD2
         IKdXzngv+/xKr2B2Om3eXFqOWu5UPicTaMPwTkIuJHqnlaK9Nfkx9FpOb6kDIPjHszp4
         8ig5ifAHQAhZJYFvEulIOOlCvogytcfX81GdaKpxm9oDGNbzkGRkPptIc2vcCME+OFA3
         8xQZLiMDcoPoXeh/us3kWRv6qcEn9vOv+CmK7oXQkO7Z2gTRFC1JOjWPQp5mkKGJJId4
         xuAg==
X-Forwarded-Encrypted: i=1; AJvYcCU7myKqsj8IX5cXpAbIXwxuDEsB+/17Wtd7OzARCYPSCt+01JUmsnTUM4UhVraDmn7Ov5qHNv8DTyDo@vger.kernel.org, AJvYcCUorBWTdXg2q1ikqsrCGTOqz5LJWVG6kpn6VbDZe4X8ISLH86f51PnKEVKAs05lz0avzG7FX+7/7+/BIDiO4+k=@vger.kernel.org, AJvYcCWbcqp9ukOA7Nd9Pyz/mzVUTHqy5Ek2O/qwL1vGcnAoNePdPRJgpzy2ORtuMStwCAojAJI7iSBqq7gj@vger.kernel.org, AJvYcCXS1+lJ9OAkvk+22yeSfqYbkKdbLPDROLJO9su0aMkWhde641QJRLYHJ+lWlZKv2eKMgpjIA+eEXBPMeWOw@vger.kernel.org
X-Gm-Message-State: AOJu0YygP+zERFI2tHWwax7BFiBXaZEBQXH8jNmmAHhc4a0C4kmKUXCL
	AlhahCv5FiHEgaPSrHGAJKPUKw2NyfL+P789Vw6MT3VWUXy3jV4NllMU
X-Gm-Gg: ASbGnct4ffo8iL8E7QO+RLGZeEpe4hBZ4SfcujimJjkg2NnJ7pJaYwr541vcmokX+3O
	6DAhMWx+N0gsVxOcIJK6sH7UbzzdsSEocSJJvbNGHBoRbhKaFK9epUgp+n4B2jb8TWmDe/Ikd9t
	Xx1Jdw2gtLzUQnqkXfLcoa1qnPJN/8Bc08KGDrD2b6j0fxEVmH3Iao+NSIO3kHlDAumPpFVpZqe
	au1/6eMO1hIHCVPToPuzBXtLyZglcIoTO+GekC3XlSqtO4yTtA6hm3GiQrEWPvYn+IjcTkEJfzi
	eY6gsQJHbSRmMWCVH2vzVT7v7xscHC6zfNLu+0MBDS4YwxLw088DPIxsGkbZKuObL14XYDCjevC
	icYkswuRGzJrgo2XxcjEvsAKmL9MgjuAT65g=
X-Google-Smtp-Source: AGHT+IE939Z4t7O/tLb4fWGzn/o4VmmAeQawC4bX+wCLcSY8yO+m7Esw6TNR1NXnkHekz8HOzqa6sw==
X-Received: by 2002:a05:6a20:43a4:b0:21a:bc07:b42c with SMTP id adf61e73a8af0-22026fa379bmr24630957637.30.1750719542219;
        Mon, 23 Jun 2025 15:59:02 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c88532d2sm213620b3a.132.2025.06.23.15.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 15:59:01 -0700 (PDT)
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
	devicetree@vger.kernel.org,
	gary@garyguo.net,
	kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lossin@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: [PATCH v1] rust: fix typo in #[repr(transparent)] comments
Date: Tue, 24 Jun 2025 07:58:46 +0900
Message-ID: <20250623225846.169805-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in several comments where `#[repr(transparent)]` was
mistakenly written as `#[repr(transparent)` (missing closing
bracket).

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/driver.rs | 2 +-
 rust/kernel/of.rs     | 2 +-
 rust/kernel/pci.rs    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index ec9166cedfa7..de4ed5dafa96 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -159,7 +159,7 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
         if raw_id.is_null() {
             None
         } else {
-            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
+            // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct of_device_id` and
             // does not add additional invariants, so it's safe to transmute.
             let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
 
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 40d1bd13682c..cca3d5cfaa92 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -13,7 +13,7 @@
 pub struct DeviceId(bindings::of_device_id);
 
 // SAFETY:
-// * `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and does not add
+// * `DeviceId` is a `#[repr(transparent)]` wrapper of `struct of_device_id` and does not add
 //   additional invariants, so it's safe to transmute to `RawType`.
 // * `DRIVER_DATA_OFFSET` is the offset to the `data` field.
 unsafe impl RawDeviceId for DeviceId {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f6b19764ad17..dc1516ce0bdc 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -68,7 +68,7 @@ extern "C" fn probe_callback(
         // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
         let pdev = unsafe { &*pdev.cast::<Device<device::Core>>() };
 
-        // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct pci_device_id` and
+        // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct pci_device_id` and
         // does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*id.cast::<DeviceId>() };
         let info = T::ID_TABLE.info(id.index());
@@ -162,7 +162,7 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
 }
 
 // SAFETY:
-// * `DeviceId` is a `#[repr(transparent)` wrapper of `pci_device_id` and does not add
+// * `DeviceId` is a `#[repr(transparent)]` wrapper of `pci_device_id` and does not add
 //   additional invariants, so it's safe to transmute to `RawType`.
 // * `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
 unsafe impl RawDeviceId for DeviceId {

base-commit: dc35ddcf97e99b18559d0855071030e664aae44d
-- 
2.43.0


