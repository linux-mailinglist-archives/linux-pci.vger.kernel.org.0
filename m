Return-Path: <linux-pci+bounces-27484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8D6AB08C1
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F90F1C204DA
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 03:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5E023F434;
	Fri,  9 May 2025 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajoUsxrP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04D624167A;
	Fri,  9 May 2025 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760628; cv=none; b=O3i6551TGfgzxoJ6NHgZ0WutntJOlUG6iElM/GXxtMj8mUHKt/gsdmhXY/37fxIhJdarw5zeJoxC5MwtiRxHqzlU8H0nll3lBpwTteIhCqv7D12VjloW8GdxWpX3QUnkKCYIibvuXvQU9AleFvCopQncnyPM/q9HcQhoa/x/lP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760628; c=relaxed/simple;
	bh=trFt74+3gg1ftMy1tXtRkrm0JO0Uv1lk6B3Xa/KkMHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJQuBYQ3TWkJnzuUjBW+ebWsnYS/VrBXZxTTJXgFFCHDFV8+VWPrENveAk4xZhSlvD6nCcFNma6C6gBgoYTiN74a4bJJrggsINTIH7+0wOX9UmwJ9zNhBdHM3xZyZDoZ3HLF7lMw1kB4xjyYxieshnoaHAnueKtAOtUm+rJF3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajoUsxrP; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-401be80368fso600625b6e.1;
        Thu, 08 May 2025 20:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746760626; x=1747365426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgqV+bJH9bwGqYSCW6zT8FRineTcAn4X+KFdTGVLZEw=;
        b=ajoUsxrPkbTVpPW6SvsFDAaauwxtPTvK0czWs0F5C9IRsZSgiFpJmkCQWsRHUKW4Qp
         PfRo/C7EQy80II2SL76om6sB1zanVsiXg7UP+zRdU/4EnMABu9mc162b4+I5e3y/zMQr
         ttQ/HBIFIOJzfqsNQT+Zn/NF/1FzP+tK9MJ2R7g0UQrM3k8tcQ2SBqJo/t4iRUq/W6zs
         UlOQDBeevigFtInDgnyKutvkLP9v6PxxC5lnlF0U/Jahkw+YBAd0Tmi0EAVCqWzm2PCe
         dWKQMDkOqDDB177EY46TympruALonMxWAszDye+24wlFU4I6jM6YioN4qXNtcGt80DE1
         MeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746760626; x=1747365426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgqV+bJH9bwGqYSCW6zT8FRineTcAn4X+KFdTGVLZEw=;
        b=hm19ImUapJWyqV/zCF7tcGAB3kKxxaXduzx2Fva1vTskALf4a+S6QCRZOTXIjx+jNo
         Y9uF2PyOt2ii+Tls2GObIwySBK3EmsdIpThAZYXTAdd4sXD+u5IaDT0fjfwkSOoR4ArN
         N+jgXZ0oY+f+2yf7aRw0yzPkOujppxqUwNNZk/uu/SUli6RBpanyXB15b0WbNOrDQnNZ
         BXR9OTOdoO01+6WQBD8ipeZh/8n7IpxpW8xtHLm5ZnWu1tlwhX9b/JRnFUi6jc+R+sxr
         J32/Up7PkxohfVF5NZM8UniWNX3G8L5vIfLfIWsIkGNpJUBxn18ARgteEraPvDHe7rnO
         yU5w==
X-Forwarded-Encrypted: i=1; AJvYcCUB2Ux10eEHG6q829AH8gy+PqpkFJDNsCnPfj72Rbi9kuZaC3SxVJBrJBbmcVpDDdrgb8mRta99z9DQY14mBZ4=@vger.kernel.org, AJvYcCUPD4w3QDHYPl7iZ0oOoChDb5HIpBRLoTdzYysjn6BERXHMIuGUQ8I/AznwcJeLRQLB7pIXptUkSaZkz5M=@vger.kernel.org, AJvYcCUbHT6wn3vLZ7QvnAIqdEdBl3sjhoUbxytF/vRvhuW3PySB/i2aB4nxRbFXUTdUm/82NwUzvGHFxv9B@vger.kernel.org
X-Gm-Message-State: AOJu0YzpifjSbB4cUv23ha8IXe5jYZZEY6oHCZ7CDUsj12mFr019/po2
	vUKaCs/pclu/O91+D9tT35GhU2JUNZ1QOKdX9WZPs2Oy82bWUJNc
X-Gm-Gg: ASbGncs6izQdCxo+hcnV2xZNaQ+1fEcJZVx5R3kjo9FwLIx9UjFqBkBrRH+SGJbXI90
	F7W4LQ1xsQ00Y306qtLyM+Kq32TJZhKhZgl3TYxt10Dt94DWb+PTLB1woVLZLH8eLlXipH18pGI
	DrksnBxIhZPwmtXWq0NvOefXysWcky664Cj4VHrWRITSrHOwxgzoP1hYixXYxNubszEggbnFbXk
	t4OnSrQ3/ef1MMb3rWvq11dehgkvxDYRYeJGXfNbGTX5cjpjjNMnEKH35WskTYIODN4HGGI0myi
	U+A1/UtuF+j5dcZvRMNl82B0qdFFxjXdJc3D1umOUSAtYcUEmIPs6VD25fei/G1DTFBFZWeH+el
	V8v3gD+xwnyqP
X-Google-Smtp-Source: AGHT+IFW81DiF+olMWJMKxd0X0Haiy6R6/35pkLPuRc9ZALbjLeamffaAjN2DDY5D6gMNu99B3Hc9A==
X-Received: by 2002:a05:6820:3082:b0:607:e267:7297 with SMTP id 006d021491bc7-6084c10184amr1043846eaf.5.1746760625781;
        Thu, 08 May 2025 20:17:05 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60842b096desm303745eaf.30.2025.05.08.20.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 20:17:05 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	akpm@linux-foundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	raag.jadav@intel.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	me@kloenk.dev,
	andrewjballance@gmail.com,
	fujita.tomonori@gmail.com,
	daniel.almeida@collabora.com
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 10/11] gpu: nova-core: update to use the new bar and io api
Date: Thu,  8 May 2025 22:15:23 -0500
Message-ID: <20250509031524.2604087-11-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509031524.2604087-1-andrewjballance@gmail.com>
References: <20250509031524.2604087-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

updates nova-core to use the new Io and Bar api.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 drivers/gpu/nova-core/driver.rs | 4 ++--
 drivers/gpu/nova-core/regs.rs   | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index a08fb6599267..42596ee2e07f 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -11,7 +11,7 @@ pub(crate) struct NovaCore {
 }
 
 const BAR0_SIZE: usize = 8;
-pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;
+pub(crate) type Bar0 = pci::MMIoBar<BAR0_SIZE>;
 
 kernel::pci_device_table!(
     PCI_TABLE,
@@ -33,7 +33,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
         pdev.enable_device_mem()?;
         pdev.set_master();
 
-        let bar = pdev.iomap_region_sized::<BAR0_SIZE>(0, c_str!("nova-core/bar0"))?;
+        let bar = pdev.iomap_region_sized_hint::<BAR0_SIZE, _>(0, c_str!("nova-core/bar0"))?;
 
         let this = KBox::pin_init(
             try_pin_init!(Self {
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index b1a25b86ef17..079c3d275a47 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use crate::driver::Bar0;
+use kernel::io::IoAccess;
 
 // TODO
 //
-- 
2.49.0


