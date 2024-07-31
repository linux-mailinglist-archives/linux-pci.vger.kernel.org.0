Return-Path: <linux-pci+bounces-11079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB2C9438EE
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 00:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4383D28501A
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 22:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE8A16EB42;
	Wed, 31 Jul 2024 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OgdIVUvz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075BB16E875
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464923; cv=none; b=OoIas69+MBS9ZVFkJwC/GCS5GTpA5Z+UOAUhkNeUeSSe1uj77BbIspou+3uGJtKSGkfoEulmQ35jNJz0XCkjVSCTTPug0W8MoGQbsPA5l0pDVCSTZsT/L7XVTSMCQDkCOnVSmcg9SOKbl7RQAQgNw+F2McRQ6msptJbOQ6q2A7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464923; c=relaxed/simple;
	bh=XABkIvkgFRWEK75ywChcUI9iJgm62PnlqcP6SvDCSlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m1NCaMU2rHGREZ85MUqI85rNNudCd/4mP6HSWLLJoKXI7iE1fhfe9RAX1OLv5Z1KS7yr3atlIfaHwfFYWG2O4It0BSFkN/0lpDX1vIkQz900IVBMl6fvTKVriisLDsCpsY//ON7se9iwNmqNc82zv1Bws9c1LFjTmQ14gxTGMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OgdIVUvz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44ff7bdb5a6so31924511cf.3
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 15:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722464920; x=1723069720; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WKU/C7t+A6Qxg3BQxfQdxyrXxjr78aUecg8SreaTGI0=;
        b=OgdIVUvzdU2pYRGnMoDJ0qGRxCUD0uOwAWzxPu3546VAp+QQPAd3fLp/rDuWAepoe9
         7qMeUI2cVt79bcp3gVNpONehYCHaF8JpFj877JgzoIiwFw1mumeP/WP3SY+CUnjL0MZl
         yZiDm3yPabrfn/WxyM6ik8zN3KcX8p6JzJCXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464920; x=1723069720;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKU/C7t+A6Qxg3BQxfQdxyrXxjr78aUecg8SreaTGI0=;
        b=oer/gjetJaQLPMacHs0B/Tosg7HYhDQy/kWMNppbv8fFEenrU9t7+/i64wxdQlXkaD
         o5qmC3uEsQy2FM+lvSr0s6ZNv37iQbOapJQDVUFrGMSIx0bc05BQu5yFH5LjhIP4QOVG
         0rIIZEhHw8JUwcnKaCSI+wkQh8q7naP0q9cnrYP58kuXEcjiXj+S2KmxKXw7KwQn4Kot
         NZ175Gk2UxoItrwPnul1lKJAVInZeYklaO5CQLgFtynBkaUWky1b1P7hfqEHIbjDsk45
         L1M6C6Rk3JPKLebANGDlC0hOv7BNJGRMi/FytINq/J7BiqvzhgnuCU4Lz8SmswvI6Vcq
         gbxQ==
X-Gm-Message-State: AOJu0YzPSj+W/JDRxFnuvAnLUjIv5dp/5rRXZoNWzv8+vHYkepeRVV4r
	5Khqt1o6aSt76hwInFY9lQ0v9TI0wY/VpjSi9uFHhh68Kbhfb+MRjqFx4PZJcrLJJc27xT/THdF
	Vt2bFkiQtv6q9YSaVuhikK1WArqz53CD4mt1VvNqcxhQn1Q+sH+A31qfCEYe4/JbtpI8MbkLP7k
	y9LW9bWQZYJTfg/9KW5sSx1yCv8KjhH6tcxkwx4mswimOhzw==
X-Google-Smtp-Source: AGHT+IH5WIAKBTNzHOk2cOY6cbJUFfh9InV6VDCil+I8iLVSY6sNMvSKIX+eU+Wup3PUxdLc/xIMzQ==
X-Received: by 2002:ac8:7f8d:0:b0:445:2e9:330e with SMTP id d75a77b69052e-4514f9a2ea4mr8919321cf.37.1722464920281;
        Wed, 31 Jul 2024 15:28:40 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416c80sm62359181cf.96.2024.07.31.15.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:28:39 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 04/12] PCI: brcmstb: Use bridge reset if available
Date: Wed, 31 Jul 2024 18:28:18 -0400
Message-Id: <20240731222831.14895-5-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240731222831.14895-1-james.quinlan@broadcom.com>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The 7712 SOC has a bridge reset which can be described in the device tree.
Use it if present.  Otherwise, continue to use the legacy method to reset
the bridge.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7595e7009192..4d68fe318178 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -265,6 +265,7 @@ struct brcm_pcie {
 	enum pcie_type		type;
 	struct reset_control	*rescal;
 	struct reset_control	*perst_reset;
+	struct reset_control	*bridge_reset;
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 	u32			hw_rev;
@@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
 
 static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
-	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
-	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
+	if (val)
+		reset_control_assert(pcie->bridge_reset);
+	else
+		reset_control_deassert(pcie->bridge_reset);
 
-	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
-	tmp = (tmp & ~mask) | ((val << shift) & mask);
-	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+	if (!pcie->bridge_reset) {
+		u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
+		u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
+
+		tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+		tmp = (tmp & ~mask) | ((val << shift) & mask);
+		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+	}
 }
 
 static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
@@ -1621,10 +1629,16 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->perst_reset))
 		return PTR_ERR(pcie->perst_reset);
 
+	pcie->bridge_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "bridge");
+	if (IS_ERR(pcie->bridge_reset))
+		return PTR_ERR(pcie->bridge_reset);
+
 	ret = clk_prepare_enable(pcie->clk);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
 
+	pcie->bridge_sw_init_set(pcie, 0);
+
 	ret = reset_control_reset(pcie->rescal);
 	if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n"))
 		goto clk_disable_unprepare;
-- 
2.17.1


