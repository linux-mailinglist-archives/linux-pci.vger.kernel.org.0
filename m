Return-Path: <linux-pci+bounces-27475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68257AB08B1
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B003B6A27
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 03:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91BD23A9B3;
	Fri,  9 May 2025 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeNKlvQB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C1464A8F;
	Fri,  9 May 2025 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760577; cv=none; b=n+8zptDA5ySNVF/i8LXeknwKCf/E4mWfVIG3n7jApU5+LnExtfPND3LM8f72ESPBrqQJbUDVYaaMho5hWLyhiZQiwgVxfAZADC6pPQGRzQ0W3HuSo0uXfOB489buY7xoxbeFlb2bmnqXGAP5s730HhWMqr0vJOveKxcMlCXncaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760577; c=relaxed/simple;
	bh=yVhH8L8EF+xcRDZ1lLHjoYLXPJyJHx2yAtsY9yyZxjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBgwFU3D9uzMx6zYE3BrvSgaUWuerPv5ZQdjYzxNSNgOjcPmgk6+oWmNFhvrrPIxPo5swHWBeQcR1mGx2bmL2drCdVcFPddmOCWlA8fLsAMrHlyXardtGRiWhT7WoWcaKeI3bCWWP9OASTWsTS3qNuS+jp34jwtDxu6O57Nq3G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeNKlvQB; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-605f7d3215cso930494eaf.0;
        Thu, 08 May 2025 20:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746760574; x=1747365374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzpSbe8Z8lqqNkTECrMU1EmRY6ZmbRg52BdLgYzOLME=;
        b=OeNKlvQB37acpmYOFeKMxJ09dL4fi7RCHQpzzB2A6rIiU8V9eFyT12+LIPpYwMUSIk
         qoP+vkWSlbZugMkbugtbjlTMfo5olFEAr5jV9TcH9iZ3oEpBAPJq9X+8sSUpo4L9U3UJ
         sQD2IOhh1TvGolz1tkavQzTSDZ3Y3ViFyfGdvD9KFvSNki4766ep9aVfwRRjmdl1aJlF
         J1lnQoWHKILvIrzu3CM4FmvFar4CTLjnbc8ondW47p+oxU9zzNeQtC0MtlaSCwEDQLMD
         ffuC0tPOQK4kNXCY2kHsXZAyvQh7GLARxq8IxxFSS2hVkSzuqPZhmwKPalSHcmB2/0qB
         sDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746760574; x=1747365374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzpSbe8Z8lqqNkTECrMU1EmRY6ZmbRg52BdLgYzOLME=;
        b=syux4KdWKq4esCarwsMmOPOzymYnx2iTEcHDzFBbSrbfGv93wyewr8SA/NyZv4BCii
         H/qqxrbu0yefjsYnG590gtVb1TIA38sqS4frE8xLOe+2KcypiW1+Hlq576DHssLuIAaY
         XZVuApSiX3vdLEGcdv9U5lUzOIwItjRDaFxePJ4azV36r+boywTSRlAO1YxwU5TaN1Bz
         9mO8dc3oXc9J/0Z+IgMgWub79ISsTqPyctj97A8Td4njk46Y7Shkq+OXLcHvuo/VoJhI
         L5OwyiRlc3j4VZawQfQ6Dqonk6sBLPUcPVQbWD0Iy0xt1yJgt1IkZ4mhzO+r4pCk4WLv
         pWcg==
X-Forwarded-Encrypted: i=1; AJvYcCUe5+uA94M2BRk4Tqo1r93SWjJRjkpOT7tr9Bg6PpPrxffUQ35PWOyPceycI+/aRCkhUpWCbma6GtYk@vger.kernel.org, AJvYcCXkokM6+l2sMp1kGE/a4yKNmMP3FTuBX6JfFU0k/iXEFGW92AwI1IBp54m39qU02to1virjqHjjOFG1ln1aiFU=@vger.kernel.org, AJvYcCXlyPY+JFMQ2A9s4vv4RUH6fh0yVShNGa0foMmy/PjmydvTndAt5K7399ebLjeKBtSJNh89Qv9C3mQXKew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGsI6p2myw5ns5gRmUCVV7dD21xpLQMMAjJk686UHm9e3/MvgM
	osU3auE0qWlJXWME5t1sIfl9f0GnVAIOplxQi6HKB5GVmrSGdspA
X-Gm-Gg: ASbGnctUkkIjv+fFn8t0bsm2uqNB844dIH9QvF9ZEEwk7ougFXOnuhJYwdftDOaPOlH
	wU5GmvqqwMQxqXIGV+pIAks+h/66Emk8su9XEAzv7IAJGxUeQ/zHopJT7w3dHQSJnwBYFEBZxOD
	//pr5BGHPOixiwsbTorwmP9/i7DkJpBlRKbgMAneGRAKMMnyKIBUz3uaxYB0rHANt557mEfrZb3
	tnR2uy6xsXAtmjx17rlKmocc+PLIyZqZt6AFSikT5F0aBRz2bh9yPhvsLP43OQx1nPtlOiNKC3H
	RQreW9inFsPUe+fK6cgZUHdzd/01E2RJmanAXAFI/Py8+cAqnxAa9WvKWPszTY7JubM0+llUgIX
	8zIfKwDSipahqOmE+zJqWRD4=
X-Google-Smtp-Source: AGHT+IFFH6+u2tuJktT4qWtVFvDEDDC7Ik0VgX5ZNR6l9ZlVvHjzs798fSJY2oERA3mEi/uVrYMj5w==
X-Received: by 2002:a05:6820:3082:b0:607:e57d:fe70 with SMTP id 006d021491bc7-6084b846db4mr1121427eaf.6.1746760574485;
        Thu, 08 May 2025 20:16:14 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60842b096desm303745eaf.30.2025.05.08.20.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 20:16:14 -0700 (PDT)
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
Subject: [PATCH 01/11] rust: helpers: io: use macro to generate io accessor functions
Date: Thu,  8 May 2025 22:15:14 -0500
Message-ID: <20250509031524.2604087-2-andrewjballance@gmail.com>
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

From: Fiona Behrens <me@kloenk.dev>

Generate the `rust_helper_read{b,w,l,q}`, `rust_helper_write{b,w,l,q}`
and the relaxed version using a C macro.

This removes a lot of redundant code and is in preparation for pio
functions which uses a similar C macro.

Signed-off-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/helpers/io.c | 104 +++++++++++++---------------------------------
 1 file changed, 28 insertions(+), 76 deletions(-)

diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index 15ea187c5466..525af02f209e 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -12,90 +12,42 @@ void rust_helper_iounmap(void __iomem *addr)
 	iounmap(addr);
 }
 
-u8 rust_helper_readb(const void __iomem *addr)
-{
-	return readb(addr);
-}
-
-u16 rust_helper_readw(const void __iomem *addr)
-{
-	return readw(addr);
-}
-
-u32 rust_helper_readl(const void __iomem *addr)
-{
-	return readl(addr);
-}
-
+#define define_rust_mmio_read_helper(name, type)    \
+	type rust_helper_##name(void __iomem *addr) \
+	{                                           \
+		return name(addr);                  \
+	}
+
+#define define_rust_mmio_write_helper(name, type)               \
+	void rust_helper_##name(type value, void __iomem *addr) \
+	{                                                       \
+		name(value, addr);                              \
+	}
+
+define_rust_mmio_read_helper(readb, u8);
+define_rust_mmio_read_helper(readw, u16);
+define_rust_mmio_read_helper(readl, u32);
 #ifdef CONFIG_64BIT
-u64 rust_helper_readq(const void __iomem *addr)
-{
-	return readq(addr);
-}
+define_rust_mmio_read_helper(readq, u64);
 #endif
 
-void rust_helper_writeb(u8 value, void __iomem *addr)
-{
-	writeb(value, addr);
-}
-
-void rust_helper_writew(u16 value, void __iomem *addr)
-{
-	writew(value, addr);
-}
-
-void rust_helper_writel(u32 value, void __iomem *addr)
-{
-	writel(value, addr);
-}
-
+define_rust_mmio_write_helper(writeb, u8);
+define_rust_mmio_write_helper(writew, u16);
+define_rust_mmio_write_helper(writel, u32);
 #ifdef CONFIG_64BIT
-void rust_helper_writeq(u64 value, void __iomem *addr)
-{
-	writeq(value, addr);
-}
+define_rust_mmio_write_helper(writeq, u64);
 #endif
 
-u8 rust_helper_readb_relaxed(const void __iomem *addr)
-{
-	return readb_relaxed(addr);
-}
-
-u16 rust_helper_readw_relaxed(const void __iomem *addr)
-{
-	return readw_relaxed(addr);
-}
-
-u32 rust_helper_readl_relaxed(const void __iomem *addr)
-{
-	return readl_relaxed(addr);
-}
-
+define_rust_mmio_read_helper(readb_relaxed, u8);
+define_rust_mmio_read_helper(readw_relaxed, u16);
+define_rust_mmio_read_helper(readl_relaxed, u32);
 #ifdef CONFIG_64BIT
-u64 rust_helper_readq_relaxed(const void __iomem *addr)
-{
-	return readq_relaxed(addr);
-}
+define_rust_mmio_read_helper(readq_relaxed, u64);
 #endif
 
-void rust_helper_writeb_relaxed(u8 value, void __iomem *addr)
-{
-	writeb_relaxed(value, addr);
-}
-
-void rust_helper_writew_relaxed(u16 value, void __iomem *addr)
-{
-	writew_relaxed(value, addr);
-}
-
-void rust_helper_writel_relaxed(u32 value, void __iomem *addr)
-{
-	writel_relaxed(value, addr);
-}
-
+define_rust_mmio_write_helper(writeb_relaxed, u8);
+define_rust_mmio_write_helper(writew_relaxed, u16);
+define_rust_mmio_write_helper(writel_relaxed, u32);
 #ifdef CONFIG_64BIT
-void rust_helper_writeq_relaxed(u64 value, void __iomem *addr)
-{
-	writeq_relaxed(value, addr);
-}
+define_rust_mmio_write_helper(writeq_relaxed, u64);
 #endif
-- 
2.49.0


