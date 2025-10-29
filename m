Return-Path: <linux-pci+bounces-39677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2153C1C444
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CE984EF51E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4903469FF;
	Wed, 29 Oct 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsPkz5A0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCF345754
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755633; cv=none; b=SbYAGk+C+fp0C20i431X5Hr3g7w1K9+EuzBz5IMavSV5rwsqkkbHK95v7MZ5NJeEUNv1YcujTgtDtfa8nlbViC6VYO8hZJI7QyuDgg/GlKHkLCDxc6SvbtH+eNG7p3PhUOyLnbKQ5vkmfUKeduG6L8+QUbM0EbUCMcLuw0VZbSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755633; c=relaxed/simple;
	bh=nyc2pqrGN622czbqL752mZIP4IX12KOgaXiQ7fJqL2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ig/yO9DcTSreHxEwPmIKQPlF4A3FpJFYniQl3XgGc2hJXZQLCHbnTz534Olt9QccsUT4IZZbv5KrGkCPlTGz94N266Vz1+ue21cuyMFEkzhgUE/d3TjoBBYYZKPlECdieXvMsMg+6eOp88u4K4wk1Cy4/6Bycv4zCX3mH5Om4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsPkz5A0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b4f323cf89bso14623066b.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755628; x=1762360428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOtQpkg6YutdjljN7zgxOA0UqmJOiKsRIM6+iFOdM9w=;
        b=TsPkz5A0bpVSK3bFDodOhIgj/wYyMO0MoglQcGiMbEmlELok9GrfGJC/MX19dAtDWd
         PV9aqbzS7n9GKCMH9JbfEGzdsocDYidHLBXXUEqkzN24nFiRchS3bnV7lHvy0Zwe8PgE
         hYQNEP/ddtu+iQaTE2BL4+Dlj+1OBFEBuxAuKmwZUMfnCM0oAB26z0Mg6s9/FZaVLstL
         i0j1Ec6H6QqIp9QpyvJmECPGbGZV3UzFH+TyrwRdPZwMBIXlQCh0xfHmR5cX/sRfAFAE
         EiZ2Tc/IZpFGW3E/Hj0RWDZ2a39mH/qR7F0eqIV20xPkUwc+vdeSQS2opAAH39LXK2Vn
         24xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755628; x=1762360428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOtQpkg6YutdjljN7zgxOA0UqmJOiKsRIM6+iFOdM9w=;
        b=LJFpFy4PR3FPXFOcrx53AjTlzCT8cpq3W8BZjitNxKD7m2/ygPBReIinHm7rv7urMN
         9REK4IIoc/gpc7S3/IOV1Sep93GWw5u6cRF1NbyibYWPgo1aY5Zo2lWr1hj6Dc+jGwl2
         by4ung8wYSOa6F0BHX9lKhvalS+Ufj+i2zeygTl4CHv4nRUPZcYe5jk/rnoNS0vbjTp+
         s7s7XKOtrEZpFDoZTMjxEDcSlGc7xYuiaaB96QsW4AOAH0Ba9aut6eMH9E5hrDzOrCit
         p2AdG5zQrH/t1b/0Zc2K3cMnTQJ0kSDdZ4JSXlZyoOoYyulR7WBpE78UKtMk3CK6HsK8
         b9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCW4qg9wmaHEVX9/OLDCMf/hu0qdDmaTVXkqimja3cvko4vnANgC66NX7XSYAZYhA60CNPzoJ8+cChM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSutFFdZlUiMpkxlF9xo5WElmnL8pbyhHO5TTC3k7e8hsKC086
	2LRSnvHxqmWgZ5Qb+CjtMlAg+xEorKj3Q9yFF5oHpsMwz6hF311ctqMr
X-Gm-Gg: ASbGncvBLhHFAou25Dcg3LqX9ZJanGoQ8E+m7Xxw7d+N+dY+YE81uYdcE7z6h6xG+LR
	ZW6vQkZMVRGO9Wx1ZE88J7OSZgke2RTLX537GLOzLgefgj9QerVGyMhmUVHnz6kZ+CSvsz1/DJw
	hL90HuiDC71O3ykaPw9e9T356dhI1MNbUwxRF8pkh/FYRlOeahPVQ5llBWiLiYh7DM8rqr393du
	nIEsEn30F4WTpH5PG3BiqGKE6kpMc8/qGE2Ll8S7aaplchnwOq0fTHdRLkQz06pp9Lm/w/UoeYA
	VEmgBLUFbcKhZksqh8h5L8EoDya5EqPr62WHV5a+56PZeOxtVzdfeI4IuvesakTeKeNJzlNggYj
	UTftCO5vGsTS7PuQEn/bwhMcnmOVhv4ijtsH1CvW4USD5lHgQCYshVuZOaiqGTAVIxhHJ6clfxb
	qDQFU1XAA4Yp7FUUrFC/Ef6LdRANfzFgx9ckNJD2MtSnejD3wyabzPlQ==
X-Google-Smtp-Source: AGHT+IFucoSpcC/sMHQ4BHPU2Sj/4WR5SsWuPVRxpOY+Rb83Lsjw7eIU5fItk/Z3WAxH0T7dO6D6kQ==
X-Received: by 2002:a17:906:ee81:b0:b6d:7e01:cbc5 with SMTP id a640c23a62f3a-b703d55289bmr367879066b.53.1761755627345;
        Wed, 29 Oct 2025 09:33:47 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d853e5138sm1485764866b.44.2025.10.29.09.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:46 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
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
Subject: [PATCH v3 2/7] MIPS: PCI: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:31 +0100
Message-ID: <20251029163336.2785270-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029163336.2785270-1-thierry.reding@gmail.com>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Pass the driver-specific data via the syscore struct and use it in the
syscore ops.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- adjust for API changes and update commit message

Changes in v2:
- remove unused global variable

 arch/mips/pci/pci-alchemy.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index 6bfee0f71803..f73bf60bd069 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -33,6 +33,7 @@
 
 struct alchemy_pci_context {
 	struct pci_controller alchemy_pci_ctrl; /* leave as first member! */
+	struct syscore syscore;
 	void __iomem *regs;			/* ctrl base */
 	/* tools for wired entry for config space access */
 	unsigned long last_elo0;
@@ -46,12 +47,6 @@ struct alchemy_pci_context {
 	int (*board_pci_idsel)(unsigned int devsel, int assert);
 };
 
-/* for syscore_ops. There's only one PCI controller on Alchemy chips, so this
- * should suffice for now.
- */
-static struct alchemy_pci_context *__alchemy_pci_ctx;
-
-
 /* IO/MEM resources for PCI. Keep the memres in sync with fixup_bigphys_addr
  * in arch/mips/alchemy/common/setup.c
  */
@@ -306,9 +301,7 @@ static int alchemy_pci_def_idsel(unsigned int devsel, int assert)
 /* save PCI controller register contents. */
 static int alchemy_pci_suspend(void *data)
 {
-	struct alchemy_pci_context *ctx = __alchemy_pci_ctx;
-	if (!ctx)
-		return 0;
+	struct alchemy_pci_context *ctx = data;
 
 	ctx->pm[0]  = __raw_readl(ctx->regs + PCI_REG_CMEM);
 	ctx->pm[1]  = __raw_readl(ctx->regs + PCI_REG_CONFIG) & 0x0009ffff;
@@ -328,9 +321,7 @@ static int alchemy_pci_suspend(void *data)
 
 static void alchemy_pci_resume(void *data)
 {
-	struct alchemy_pci_context *ctx = __alchemy_pci_ctx;
-	if (!ctx)
-		return;
+	struct alchemy_pci_context *ctx = data;
 
 	__raw_writel(ctx->pm[0],  ctx->regs + PCI_REG_CMEM);
 	__raw_writel(ctx->pm[2],  ctx->regs + PCI_REG_B2BMASK_CCH);
@@ -359,10 +350,6 @@ static const struct syscore_ops alchemy_pci_syscore_ops = {
 	.resume = alchemy_pci_resume,
 };
 
-static struct syscore alchemy_pci_syscore = {
-	.ops = &alchemy_pci_syscore_ops,
-};
-
 static int alchemy_pci_probe(struct platform_device *pdev)
 {
 	struct alchemy_pci_platdata *pd = pdev->dev.platform_data;
@@ -480,9 +467,10 @@ static int alchemy_pci_probe(struct platform_device *pdev)
 	__raw_writel(val, ctx->regs + PCI_REG_CONFIG);
 	wmb();
 
-	__alchemy_pci_ctx = ctx;
 	platform_set_drvdata(pdev, ctx);
-	register_syscore(&alchemy_pci_syscore);
+	ctx->syscore.ops = &alchemy_pci_syscore_ops;
+	ctx->syscore.data = ctx;
+	register_syscore(&ctx->syscore);
 	register_pci_controller(&ctx->alchemy_pci_ctrl);
 
 	dev_info(&pdev->dev, "PCI controller at %ld MHz\n",
-- 
2.51.0


