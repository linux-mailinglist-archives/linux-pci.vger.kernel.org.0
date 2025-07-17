Return-Path: <linux-pci+bounces-32369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C023DB08AA0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A012A46898
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7A29A9ED;
	Thu, 17 Jul 2025 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxmrbYX0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D56629A303;
	Thu, 17 Jul 2025 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748376; cv=none; b=cHX50J/33y96Dz81tlrNH9aVgPb1M6tFsup73Fms0hq2sYHAKHCXlviodfXdwBcYkOIMzuXaOMbGbC/y/3QcidoM/Qb4IxWySiBgIp3L0O4b/x9Uku2BhY516i3qdk78z+thKu/BIw8b8wszK7Vdiy+Fmrr72NzRXm/oVDok8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748376; c=relaxed/simple;
	bh=ZDH9nnnANcSRpb0zEHcYNiYeeyt7UKzoc2r8+K/c0NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVIjMed2bbaDQscZk/DrMlqEdpGs/PgPrq/NsGMI8BhGs36G8XQhGXqDV0inY+iY7Dh7hPHuPp9ipbLgcElqOlKxHESiN9TFtWERAppBcsWtE5V9Vwvc0ANxYZluG1gr9PO2WBpG8t6JtpPZPd//VPHFba8eg4MfnNoQaNXOHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxmrbYX0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-455e6fb8057so7835465e9.3;
        Thu, 17 Jul 2025 03:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752748372; x=1753353172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aLo6QmBH2sfDcjFNDrVzv+tdtk/K/9cagqqXKGweA0=;
        b=gxmrbYX0V6Z0uuuSUU6daFXRE7GrDib+L9TU98yyTuOQHTnoQZrxj+Zs0uGTzRNi+B
         S9djrrlia4+CsvyrUQsmUkNnS/hKfGIJdg6w6Bzb1ml3i9+LxgiI9rOq1jowpiNKRTf3
         HXLtt3Ha4PclphGrLjhMu4mRfATjriPuWzLy1ke7P0mJwCO8meaMue3ZDEviS7vjlJXb
         abnWSy6Lq/CWcmERSsRyfJDz3iJxuHNLlVvHBG3NpxareCUTpy+aOq8yDTm2QlzMGQrO
         /D46xqEcT7EOFALh+2VuKv6+QWI5+OVvDKdiEn1bhu/pYGgDBy4xAFhu/zXRnt2O365+
         JsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752748372; x=1753353172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aLo6QmBH2sfDcjFNDrVzv+tdtk/K/9cagqqXKGweA0=;
        b=WgOhI+EJz2LcsQZ2PEtjxsAptgnCMXxzZGo7LlR1nKo3RzG2W/wif1hSTxBRf1nvV2
         6lPKTRQRaTcnzm2ddVpTwdgeq4d87JqIjanUn2S7KE9qCOGcLXlIM81ww3Daca+rD7n7
         MdqTKmFHbKnx+yLogY94Dltb6alm+lVY59/j/uxVo/PyAXbiWmV3m92fZ7nSvEXdoXz/
         ejLCteOvz5Mv5sZrmF+wfSurWfSAtUkYwoIGjXZ6jzs3FB6m4VFdNS7ODT7WS1tZZyCS
         oVgIc1NbbyfNiBJI+a17ah+2DgbxQkHheLcOtEPEX6yyiycZnjBmAsNopsAoKZvsYa/N
         N8bw==
X-Forwarded-Encrypted: i=1; AJvYcCV629OZtgFvwjLgCKQtvOsB+D6+2xvosO3nV6yVteUMepdBXNu4loqH7HTPCeyTFBByrpfOePbVY3cjhjKF@vger.kernel.org, AJvYcCVnsMOZhvRxWB28cYWS6r++cLJPcy6q1AikT17k2u4HHco9gBULRPCohiChY/MHUh5U3nJES7SB394=@vger.kernel.org, AJvYcCWZTsHgSKOV1Le7TfasEoZMTyCd0+am8Lc6AoW7LEigmXG7Vn4QFceYSw8oCdaba/qeG7tH/Nd8UmWM@vger.kernel.org, AJvYcCXSdAP3uCgscOaZdnG79v6zfR7r0USgoVKA56anHbcxz26yJJ7zP+jcM6hVNygHJKnuJ7CdudzEHtj6@vger.kernel.org, AJvYcCXmgzgNGAi8ntizFcVVjBMMVixS/i9Ug1lbkUkNiG1QnM3PI6PlQ/Tn+QKe7u1VCxNNEBwX7bvbJI19uA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NvUKkMW4/nMpeD/JnTpxC8xkjK1RSPxZa442ewEeFQdBwY2v
	OFfiipvwkriiGVF/aGXiqzkQIEBa2eiTyrxld8lWOYaVINCtzkbdV2o0xhwyvA==
X-Gm-Gg: ASbGncv5AvdTsFuCpI4fIQFY57gDAZE8VDnOv7k34GisXLHsIF4UIIn26/fby7rHZGI
	vO1ShRP6fjicrwS1rUCl3Orzwgg1nJ4oBsFe063kJtYHgNY7XGZlZ8GYag6v6A3q6PzwRFrVaYz
	RpnJYWw/s3+5CDZDN8B+N9i4uYwdB/9ivSluxXHja9eiWJoRyk+8r2meHxydvuv6DdVYI0ImAWU
	2B7M4Bqf8zyKm7KE+AhHFKW/8w/RtPds3d7/FsqXXUkIytI0OXhchcM/f7oxgazdCjtEl80aZAH
	Kms+65NKnoJfs3o52/LEwrqS7fUriJr+Gnad4m1MFJgliGuAAofjfMLezhYdAJ4UXi6n4kEhU1p
	Xs6VRBrxggAC+QtfkMksfBZ6BENXGKOIlKs/TJCZXl1OiOwZ9pzridIFkXFI3roix31csNaodT/
	qsmidEtu0g6n6Z5A==
X-Google-Smtp-Source: AGHT+IHy7PA+ydb4zAWKmtnVkxvp2yVipMuhRsPFmT5ULPVHvkEqwkx5+jJwmnytUHEZv9na/OVQiw==
X-Received: by 2002:a05:600c:1d20:b0:454:a37a:db67 with SMTP id 5b1f17b1804b1-4562e36c7a6mr69982365e9.17.1752748372489;
        Thu, 17 Jul 2025 03:32:52 -0700 (PDT)
Received: from localhost (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8bd15bfsm20610595f8f.19.2025.07.17.03.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 03:32:50 -0700 (PDT)
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
Subject: [PATCH v2 2/7] MIPS: Embed syscore_ops in PCI context
Date: Thu, 17 Jul 2025 12:32:36 +0200
Message-ID: <20250717103241.2806798-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250717103241.2806798-1-thierry.reding@gmail.com>
References: <20250717103241.2806798-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

This enables the syscore callbacks to obtain the PCI context without
relying on a separate global variable.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/mips/pci/pci-alchemy.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index a20de7160b6b..02f0616518e1 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -33,6 +33,7 @@
 
 struct alchemy_pci_context {
 	struct pci_controller alchemy_pci_ctrl; /* leave as first member! */
+	struct syscore_ops pmops;
 	void __iomem *regs;			/* ctrl base */
 	/* tools for wired entry for config space access */
 	unsigned long last_elo0;
@@ -46,6 +47,12 @@ struct alchemy_pci_context {
 	int (*board_pci_idsel)(unsigned int devsel, int assert);
 };
 
+static inline struct alchemy_pci_context *
+syscore_to_pci_context(struct syscore_ops *ops)
+{
+	return container_of(ops, struct alchemy_pci_context, pmops);
+}
+
 /* for syscore_ops. There's only one PCI controller on Alchemy chips, so this
  * should suffice for now.
  */
@@ -306,9 +313,7 @@ static int alchemy_pci_def_idsel(unsigned int devsel, int assert)
 /* save PCI controller register contents. */
 static int alchemy_pci_suspend(struct syscore_ops *ops)
 {
-	struct alchemy_pci_context *ctx = __alchemy_pci_ctx;
-	if (!ctx)
-		return 0;
+	struct alchemy_pci_context *ctx = syscore_to_pci_context(ops);
 
 	ctx->pm[0]  = __raw_readl(ctx->regs + PCI_REG_CMEM);
 	ctx->pm[1]  = __raw_readl(ctx->regs + PCI_REG_CONFIG) & 0x0009ffff;
@@ -328,9 +333,7 @@ static int alchemy_pci_suspend(struct syscore_ops *ops)
 
 static void alchemy_pci_resume(struct syscore_ops *ops)
 {
-	struct alchemy_pci_context *ctx = __alchemy_pci_ctx;
-	if (!ctx)
-		return;
+	struct alchemy_pci_context *ctx = syscore_to_pci_context(ops);
 
 	__raw_writel(ctx->pm[0],  ctx->regs + PCI_REG_CMEM);
 	__raw_writel(ctx->pm[2],  ctx->regs + PCI_REG_B2BMASK_CCH);
@@ -354,11 +357,6 @@ static void alchemy_pci_resume(struct syscore_ops *ops)
 	alchemy_pci_wired_entry(ctx);	/* install it */
 }
 
-static struct syscore_ops alchemy_pci_pmops = {
-	.suspend	= alchemy_pci_suspend,
-	.resume		= alchemy_pci_resume,
-};
-
 static int alchemy_pci_probe(struct platform_device *pdev)
 {
 	struct alchemy_pci_platdata *pd = pdev->dev.platform_data;
@@ -478,7 +476,9 @@ static int alchemy_pci_probe(struct platform_device *pdev)
 
 	__alchemy_pci_ctx = ctx;
 	platform_set_drvdata(pdev, ctx);
-	register_syscore_ops(&alchemy_pci_pmops);
+	ctx->pmops.suspend = alchemy_pci_suspend;
+	ctx->pmops.resume = alchemy_pci_resume;
+	register_syscore_ops(&ctx->pmops);
 	register_pci_controller(&ctx->alchemy_pci_ctrl);
 
 	dev_info(&pdev->dev, "PCI controller at %ld MHz\n",
-- 
2.50.0


