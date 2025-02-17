Return-Path: <linux-pci+bounces-21645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79001A3897B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A4D16C526
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A95226543;
	Mon, 17 Feb 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHxgniGX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEFA22619D;
	Mon, 17 Feb 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810256; cv=none; b=R3VB/4zuZfUd4LiAMvxYTK3VPQY1Y9kFlrGxSlM3fB61lxtuHRtfzuNH46Y8xaFT1PTlWpmnlunU553sLSnnH4ELmXmosbnTR/g8+GGVdN9GioLDQCyGnAtSzV3hkw4RcmiLpqh14bPob7vZYqLE+stlICAgFYHKRLcYVnBNzuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810256; c=relaxed/simple;
	bh=+eCE6Ql4+07nFG1qzGBgKrmMRBOoz2T/3CMljW1oR6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9iUQpyFnRbjEudtLohhO01dQHlCGBcTXDpRpyt+/aTnYKl59tNJsS3r4g7LjE9KrUFfTMe4xqGhBoJjhV9AF3zHGVfhV/dEhOPPhJy9zBrozV0oHRDYotvLqf8oEZ7euueWTp8Gas4o0GYtBuDBv7rbJcq8fo1x1huG/MMbJyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHxgniGX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f378498c9so1884621f8f.1;
        Mon, 17 Feb 2025 08:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739810253; x=1740415053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKpi0u6vaUnsrplCnc00ydxIjOGnOYCvPvGm+BeJUhk=;
        b=BHxgniGXL2Nw5cYGXH/j1SFrO+OQzNIu4o+spSU15RpmUe3fhsb5wAdoJMBq07GlYb
         VFksLhiBC8fkPej0eGBqUxAwQOubCTLEiui2MhSR/W3KfRGrwuA+NXhXwpUBUuTusUF9
         tBJeEch4iekcTfee5YFE+j5xtk9VAQ2LMnDkQdfw9jOuAav9P72/jcXhAWKgSLi2RNh3
         vZwt/+8x9hrn77+6xDfsM+SkY+MB06ZUQZ5zBDszeu9FJKsfBVsDVlIGBRIFOw1OmW68
         qzwxE4gy04Xogzqr9+ejYeeIi6YjughF1NyAHmyWJyzg0lM56Zg3tLgci6tJZ6Kcv2ye
         2JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810253; x=1740415053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKpi0u6vaUnsrplCnc00ydxIjOGnOYCvPvGm+BeJUhk=;
        b=DHa2nMlylGTCVzY5t2NGrYAlLmTWfCqbcYwJ5OhFGgCWwaw3uwmfdC8EB+EuEC937x
         NJ+32XlgUK+wx1NFXHXxbcJaD3xnD/kYpVLmTcw8U9orAkPgz1i2ppcAdtsZkpSyqVIE
         eLfv4QRG/MH1Mn9zGMZ23ZPHhq/b0XOAHmlobVRurf4ld3HJI8ewcD6yjTW+qdI5HAJN
         6IQtqgBIplJyrtKa6kCuRe8ZN3jWaftpZuZQKjASExrUGWvQQ7OK3SLmAl6GLpmWr9B0
         56okPimQDGDXIpIgscJQps32hjr4YcmBHThYJHp7J22ybGfaczd0KHQmSKu5SBTQA3EJ
         l3ug==
X-Forwarded-Encrypted: i=1; AJvYcCU0B0zEHixDRJQHp/pKM29o3rjjrA94FcS2AQS2gIJVbx8xL7A17zHZkN2rm5ddyHyEZCMCYwbWzxvhHQ==@vger.kernel.org, AJvYcCV6kin3tVBpr5Fyq5PAFMhLbBid3b7TQ+HfSUSdMm1J4zK2I4YtHZ+svdvlefW7/3aTaNSqs7Ex9OEa/F/U@vger.kernel.org, AJvYcCVAfLPN9T6qWOJHFKh8hy3Cv83RO7L/E3HBjvL5rXYMwRs66x2jQPW2WOnWlFj3OCrvA3JAH70TxPFW@vger.kernel.org, AJvYcCVvVSnO+JJD77kzmmO5mWGXTJFw7kERBi3XmF7y2TkR6884Fv7qlD84nYQJq85NX2VMFUheNH89AYg=@vger.kernel.org, AJvYcCXP8QOLnXI7i4un5aIraAeC/fyN9BuNUcDenkTjQpHMEiDMoKgXtdGaLQ8VY4esh6pjG7u8qiCSJwBQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxqF44o3pZCM+O0pbmubu2xwznlpNfN503aZdgRrcs9SwkTLxO+
	LuiNjlytvYuV7HbLFlCnNu77kUQzdLN/awXjZ+c2fVNZmPJWzCV8g+gcpg==
X-Gm-Gg: ASbGnctx5EPfVAi/gVNwx9xAqT6OwD/2a8WpUNeIkqIIw+n6d2jwqg96trTsUiSNzM9
	8deeGtWQI8CubOizeSLH9OuRiMJcf3MpGNr4ILc+cSJxNumIDDXguGDA7MAmHxjdWv/Ig74bLe9
	4JX8QgCIXUiROS4SBqdAa6o2B5lkkhwC8E3/vWpnDDi4ACIDbwRktzKhUpRCWKCtMb49THR+yFg
	se0opeJnYCvKsAdQe5qnoDy85UgBVyiEVf8k4fq7WE1alEJtmR3RbgOSi34kdR0EWkkryFtMlmm
	VVS7eV7/kGeH+lOaMSlp6on0ui1Wew/lWxClQgT56Fx8Ex51f+v3xFa++byX94U3r1t+o5UIdko
	MPrnvQMw=
X-Google-Smtp-Source: AGHT+IGTsVCL+NTHpDgAjbfPGCf82Ky2fpMBBCHIOPIzC5FN2MM8zcjn3L7PrIBL8Fr/RKV6YFjIXQ==
X-Received: by 2002:a5d:64c6:0:b0:38d:cab2:921a with SMTP id ffacd0b85a97d-38f33f1249bmr8380187f8f.1.1739810253132;
        Mon, 17 Feb 2025 08:37:33 -0800 (PST)
Received: from localhost (p200300e41f22a600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f22:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f259f7979sm12509797f8f.83.2025.02.17.08.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:37:32 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] irqchip/irq-imx-gpcv2: Embed syscore_ops in chip context
Date: Mon, 17 Feb 2025 17:37:12 +0100
Message-ID: <20250217163713.211949-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217163713.211949-1-thierry.reding@gmail.com>
References: <20250217163713.211949-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

This enables the syscore callbacks to obtain the IRQ chip context
without relying on a separate global variable.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 83b009881e2a..61ba06a28fc4 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -19,6 +19,7 @@
 
 
 struct gpcv2_irqchip_data {
+	struct syscore_ops	syscore;
 	struct raw_spinlock	rlock;
 	void __iomem		*gpc_base;
 	u32			wakeup_sources[IMR_NUM];
@@ -26,7 +27,11 @@ struct gpcv2_irqchip_data {
 	u32			cpu2wakeup;
 };
 
-static struct gpcv2_irqchip_data *imx_gpcv2_instance __ro_after_init;
+static inline struct gpcv2_irqchip_data *
+from_syscore(struct syscore_ops *ops)
+{
+	return container_of(ops, struct gpcv2_irqchip_data, syscore);
+}
 
 static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
 {
@@ -35,14 +40,10 @@ static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
 
 static int gpcv2_wakeup_source_save(struct syscore_ops *ops)
 {
-	struct gpcv2_irqchip_data *cd;
+	struct gpcv2_irqchip_data *cd = from_syscore(ops);
 	void __iomem *reg;
 	int i;
 
-	cd = imx_gpcv2_instance;
-	if (!cd)
-		return 0;
-
 	for (i = 0; i < IMR_NUM; i++) {
 		reg = gpcv2_idx_to_reg(cd, i);
 		cd->saved_irq_mask[i] = readl_relaxed(reg);
@@ -54,22 +55,13 @@ static int gpcv2_wakeup_source_save(struct syscore_ops *ops)
 
 static void gpcv2_wakeup_source_restore(struct syscore_ops *ops)
 {
-	struct gpcv2_irqchip_data *cd;
+	struct gpcv2_irqchip_data *cd = from_syscore(ops);
 	int i;
 
-	cd = imx_gpcv2_instance;
-	if (!cd)
-		return;
-
 	for (i = 0; i < IMR_NUM; i++)
 		writel_relaxed(cd->saved_irq_mask[i], gpcv2_idx_to_reg(cd, i));
 }
 
-static struct syscore_ops imx_gpcv2_syscore_ops = {
-	.suspend	= gpcv2_wakeup_source_save,
-	.resume		= gpcv2_wakeup_source_restore,
-};
-
 static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct gpcv2_irqchip_data *cd = d->chip_data;
@@ -275,8 +267,9 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	 */
 	writel_relaxed(~0x1, cd->gpc_base + cd->cpu2wakeup);
 
-	imx_gpcv2_instance = cd;
-	register_syscore_ops(&imx_gpcv2_syscore_ops);
+	cd->syscore.suspend = gpcv2_wakeup_source_save;
+	cd->syscore.resume = gpcv2_wakeup_source_restore;
+	register_syscore_ops(&cd->syscore);
 
 	/*
 	 * Clear the OF_POPULATED flag set in of_irq_init so that
-- 
2.48.1


