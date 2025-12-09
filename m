Return-Path: <linux-pci+bounces-42820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC72CAF01A
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 07:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A43393004D0D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 06:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6421DE3B7;
	Tue,  9 Dec 2025 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaTUZlk5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6AA79DA
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765261114; cv=none; b=F9v02N7C6buqOCULW6vK5KzVO2y+jHKRAdQXBsmfusvVqSOq7XWieSLB91e2baTnPRcntyXTyU62eiB3C0kEovG4NZIHojrltJvkX2BTu1z6tIfbkoqv+BhJ2YJxb+6004p8s4Xh9CPK/60DmrbzT+3jf1uaM2h3Jg46MIJP1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765261114; c=relaxed/simple;
	bh=nrOEe1Q1KKKztS9JQI5wIfoekeRaSqgEGhUdFlNZvnI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nAJ80O6Mm32Qz0tJRheXcWOWpxTdJ4FRrPBaVrmn+m082voGEGmyV9EUfD4UCOu/OJWVog7wN2MpCSGXalLtJXiPcmHjEm1hK5SGQpcZsBT/ncj0s8whw7f7E+Z/pf04GNw6p/R9y61e8JaboaRCQlKUSDUM7Em8xiLzarUmz1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaTUZlk5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29844c68068so67588985ad.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Dec 2025 22:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765261112; x=1765865912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSpG9FcTGr8H9OdU3YUlNCJNp1ODh6ENX89vc9//Z4k=;
        b=RaTUZlk5pdLF6tCNhXC1GDnWXRODol7+ZgGiUR+KOBhBHKJzUiLQ11rHfVVzV8A2vz
         K5Nsh+yc+NR9BUYinOSMkJYVcmuv1Tlzz9bwPBzQVen3EAnvJcgmvTu7XrQb0Wd7CFwd
         nWBuOwKglSfVv15y/G0dA7nFHt2MWO9a4rXp+mTAtmN5ZmL5WoKhgWaVZ6fFMsboRTuV
         JXBu1gvOLGI/24zzx/tfOMoZOalsJfH0BxTcejDZx3TIbIzfu3rZLub4bNEB5WUFexLZ
         LVlgAdmmUaJrksZu+mH9K+WX7gHKBj+A8zusFaGUnHgZ83drP134vIqSCKTRhBihQy0Z
         zUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765261112; x=1765865912;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSpG9FcTGr8H9OdU3YUlNCJNp1ODh6ENX89vc9//Z4k=;
        b=nijgd3Yfo85HCHFr9TJoxiiGMEoD40zpX1aEA9ifoMSYGIEGchKUm1qUzO6yBe1Bqo
         k6MWAYJaGKfN4qG9gsiWutFC1foRSGydtyRWVyk95hcTARli2en7GcQ2yil6k6h8/HL8
         1a/C+1LVedsWTup/2rmDB3FnWDIfxGox4Yq63qfQ/sfFomNuyAMbNdQwOOoZuoFIx/R2
         ZcqQqTMK3H8O2MT3gbEWCfRoHe1KDtpCdXyUs5Ik4caFEDM0bPg9YuoIYENQ94s3LARH
         lhp608Oh5bbw5brYTw4fpR/Bt5d/1UjFETwMy2O5uUNH4hSkLqYWVVnqRP+PWKYdGMks
         s2zg==
X-Forwarded-Encrypted: i=1; AJvYcCXEXZesBO2ow+d4iF5PpFuOTuKQbNJRW55Nihppszd+Vl1GCpUNF+4K9r4GtLT9OvHn9e9Ysi3NwaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0wBIVym1Mk0UxbPFreZFscGWGq6fLsT4Rphi+CCMsUsQ3LzF
	7Gp1NsaFnChed8j1kOxk6om4LNtgFVLGP9WIgOv+pnVrT8h/hw/b5dRw
X-Gm-Gg: ASbGncv1MHdMCmQEDPRMXBxaKqK1Uuvi4f3Z/3G9wIHgNVZJHtUgL4EQrZST7sMbleZ
	qR5PmAPgK5u8HVyTlq3ZfiwPT6PFxMeEJLeDghHLmOdMSpHKYk0ciVWNLv3B5xcOy4qZhIJ+n/e
	rdPSBE4MBOGVs+Wj22AN5U7JkGJWi7BosLoDnwc5vLOmcwordF6e0Afz/oY6aEE9NLsvGrlD5FN
	1APEGujtckBZXXr9j9TsCkt0rTdU+gNRTnV2vZvsEKJPrPif1jJVEKFTxn74yW0vWlFhwiZ5gLW
	12aCMiqDFO8fTOZdHvk6KiEzzuEPgPiq5mmBWm841PCX5jBt/s1hYbre4hq8wD1NzL5nBwagsof
	B4pBVbtemxXgz7qh7tf6cDK69z9UExMEN8NKqhZrpBBPxUthK76f4akM9qZkI8mkPXMdfH8/ggH
	KG4TBDUUJ4miCXHiVO4dUQBbTyv2kJiX7kM9WJKOa5qbw9oWfw0XloGoFqsGjS49QePw==
X-Google-Smtp-Source: AGHT+IEPHmVHYlRLwG0PcIz7r8pVUrGZaRRQAJ9BL8ULdYzSdH8IEn99XoMWpMxcYnV9VeDC0U3BEA==
X-Received: by 2002:a17:902:e752:b0:295:98a1:7ddb with SMTP id d9443c01a7336-29df6326100mr94457775ad.61.1765261112403;
        Mon, 08 Dec 2025 22:18:32 -0800 (PST)
Received: from localhost (p4783053-ipxg23301hodogaya.kanagawa.ocn.ne.jp. [153.209.99.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca1esm141487655ad.2.2025.12.08.22.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 22:18:31 -0800 (PST)
Date: Tue, 09 Dec 2025 15:18:17 +0900 (JST)
Message-Id: <20251209.151817.744108529426448097.fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: dakr@kernel.org, ojeda@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bhelgaas@google.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, kwilczynski@kernel.org,
 lossin@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] rust: helpers: Fix pci_free_irq_vectors() build
 with CONFIG_PCI disabled
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20251209014312.575940-1-fujita.tomonori@gmail.com>
References: <20251209014312.575940-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue,  9 Dec 2025 10:43:12 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Fix the following error with CONFIG_PCI disabled:
> 
> In file included from linux/rust/helpers/helpers.c:40:
> linux/rust/helpers/pci.c:36:2: error: call to undeclared function 'pci_free_irq_vectors'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>    36 |         pci_free_irq_vectors(dev);
>       |         ^
> linux/rust/helpers/pci.c:36:2: note: did you mean 'pci_alloc_irq_vectors'?
> linux/include/linux/pci.h:2208:1: note: 'pci_alloc_irq_vectors' declared here
>  2208 | pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>       | ^
> 1 error generated.
> make[3]: *** [linux/rust/Makefile:621: rust/helpers/helpers.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> linux/rust/helpers/pci.c:36:2: error: call to undeclared function 'pci_free_irq_vectors'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> Unable to generate bindings: clang diagnosed error: linux/rust/helpers/pci.c:36:2: error: call to undeclared function 'pci_free_irq_vectors'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 
> Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is disabled")
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers/pci.c | 4 ++++
>  1 file changed, 4 insertions(+)

I just realized that the above leads to unresolved link warnings with
rustdoc.

Is it possible to work around the inner documentation comment in
driver.rs?

//! For specific examples see [`auxiliary::Driver`], [`pci::Driver`] and [`platform::Driver`].


The rest can be avoid with cfg_attr though.

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index c79be2e2bfe3..a33adbb303d9 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -67,8 +67,10 @@
 ///
 /// # Implementing Bus Devices
 ///
-/// This section provides a guideline to implement bus specific devices, such as [`pci::Device`] or
-/// [`platform::Device`].
+/// This section provides a guideline to implement bus specific devices, such as
+#[cfg_attr(CONFIG_PCI = "y", doc = "[`pci::Device`](kernel::pci::Device).")]
+#[cfg_attr(not(CONFIG_PCI = "y"), doc = "`pci::Device`.")]
+/// or [`platform::Device`].
 ///
 /// A bus specific device should be defined as follows.
 ///
@@ -160,7 +162,6 @@
 ///
 /// [`AlwaysRefCounted`]: kernel::types::AlwaysRefCounted
 /// [`impl_device_context_deref`]: kernel::impl_device_context_deref
-/// [`pci::Device`]: kernel::pci::Device
 /// [`platform::Device`]: kernel::platform::Device
 #[repr(transparent)]
 pub struct Device<Ctx: DeviceContext = Normal>(Opaque<bindings::device>, PhantomData<Ctx>);
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 84d3c67269e8..1af6eec7ec28 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -27,8 +27,10 @@
 /// Trait to be implemented by DMA capable bus devices.
 ///
 /// The [`dma::Device`](Device) trait should be implemented by bus specific device representations,
-/// where the underlying bus is DMA capable, such as [`pci::Device`](::kernel::pci::Device) or
-/// [`platform::Device`](::kernel::platform::Device).
+/// where the underlying bus is DMA capable, such as
+#[cfg_attr(CONFIG_PCI = "y", doc = "[`pci::Device`](kernel::pci::Device).")]
+#[cfg_attr(not(CONFIG_PCI = "y"), doc = "`pci::Device`.")]
+/// or [`platform::Device`](::kernel::platform::Device).
 pub trait Device: AsRef<device::Device<Core>> {
     /// Set up the device's DMA streaming addressing capabilities.
     ///

