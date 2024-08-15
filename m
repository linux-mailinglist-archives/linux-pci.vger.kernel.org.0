Return-Path: <linux-pci+bounces-11728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D09953DBA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 01:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B4C28A108
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 22:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175AA156F3B;
	Thu, 15 Aug 2024 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UVEfIt0h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A615B548
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762696; cv=none; b=Ba8+7xz3lbfGFLKCUtI5EBQXaxtz8JSuhMMcKqmqLo/xAVx6/h54iEa2yRWuf/+vJ8dC3Cj7imbY0GITNsq7EIu/8TgA3MkCBW1QzV8vtxdSdmcuNjnLHs486J0am9Y/RCbTcedQrkqqHdf3BDQIfeYm5a4ZJMD3VYiwXpRTjSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762696; c=relaxed/simple;
	bh=lHnevVJCu9Mk5lZpd4na9lfqYzTto76VEITcdURZh8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I2PQWgzfFgyUb6WzVLmtWqDQt6Gpif4IHED6DPHbCkcOYRkczpd13sy51T/vjWTF7X9Lpgbo7O/TrOZYZv286eJhL0bwl4v6mwPDm+lfMW04KG7M1JMpxcR22Z8e5vceupZL8Y4UvNvRvW1ZFv5+FFEQ4Kk0Ot4MTE8mHaOKKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UVEfIt0h; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7c6aee8e8daso966680a12.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 15:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762693; x=1724367493; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sw/y1YudoYw0z5x3kyJbYb7Us6/Aelo6uwQtXJHsCTc=;
        b=UVEfIt0hwLai606zN7zV1QXJ45E3TgMvCJcCKfWwHpswsbiwlAmpxdH1usbiccqZo/
         I/jFPRJN2o1KF4sQRJA7zwrWZy8XVHt9waisMPHdUeEWc1UxC72SA3ZHACql7lPaqXxG
         jiZwmrQzWXYbcsHiqOHqx5dXh0JAnnfMhja1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762693; x=1724367493;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw/y1YudoYw0z5x3kyJbYb7Us6/Aelo6uwQtXJHsCTc=;
        b=EqhkXFDcQn1dyYdygQnMs+YNjl0GxXEKV1X72YtMSvh2FHYhBiucSaS1evBAnbBV4Z
         2agWSnXH633scgGB0zw0BRfkszozHQwMTkpAmqYMQvzE/PiZqOq17vfNCbXnRj0om74m
         VXQ5guBB5iDzABgHKpayE/RAl8+VPZh4rvhmFTJCJu0/ZRDQqY65Ho3rNUE0StlsX9Vd
         9AgF/7UnwPAqvkwwCFmtCmv5LLqUfZ1UzEZpyfP1Kqcf88sq2bxQOLuWEIvdMU7tvfPN
         0/hExZQaIIIqxJxef0Rm3sPyTC9HbSEJoVo7Eedz9keysC37/pYkxo5FvkDINDtGXdIx
         Rj9A==
X-Gm-Message-State: AOJu0Yz2Ue+rbSYUDjp9D5b4rOaPUGtKETYuH80LU0o1cX2JeBVeiTRX
	pE+ECrHaOmoMQcabEXshlqQuZUoivPAVdEITroFHVBKSuPzTN7z/huD/gpU2pQTMp6uyp3cFI22
	+q1Ek3Qlax0SLORAYL5igWBr3v6jo5X+WJajMX9mkZm9jPaL0m9nWq4PbDspvGoQha2+6tDYQ0x
	qv3pQY0HeACRVjybjqmvSXVhayjY2wZFvzmrauDYeMMNAiQA==
X-Google-Smtp-Source: AGHT+IGe2VnSskgWUeuQ6btU4om0yhswtchJFUKGi72EMM35kbN0Vl7eoIcl778qfal49Wwzmi+SJA==
X-Received: by 2002:a17:90a:34c1:b0:2c9:81fd:4c27 with SMTP id 98e67ed59e1d1-2d3dfc61a9bmr1382610a91.14.1723762692574;
        Thu, 15 Aug 2024 15:58:12 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:58:12 -0700 (PDT)
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
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 09/13] PCI: brcmstb: Don't conflate the reset rescal with phy ctrl
Date: Thu, 15 Aug 2024 18:57:22 -0400
Message-Id: <20240815225731.40276-10-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add a "has_phy" field indicating that the internal phy has SW control that
requires configuration.  Some previous chips only required the firing of
the "rescal" reset controller.  This change requires us to give the 7216
SoC its own cfg_data structure.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 51b715fbf3a9..2431c5a75cde 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -222,6 +222,7 @@ enum pcie_type {
 struct pcie_cfg_data {
 	const int *offsets;
 	const enum pcie_type type;
+	const bool has_phy;
 	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
@@ -272,6 +273,7 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
+	bool			has_phy;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -1311,12 +1313,12 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
 
 static inline int brcm_phy_start(struct brcm_pcie *pcie)
 {
-	return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
+	return pcie->has_phy ? brcm_phy_cntl(pcie, 1) : 0;
 }
 
 static inline int brcm_phy_stop(struct brcm_pcie *pcie)
 {
-	return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
+	return pcie->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
 }
 
 static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
@@ -1559,12 +1561,20 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
+static const struct pcie_cfg_data bcm7216_cfg = {
+	.offsets	= pcie_offset_bcm7278,
+	.type		= BCM7278,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
+	.has_phy	= true,
+};
+
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
-	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
+	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
 	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
 	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
@@ -1612,6 +1622,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->type = data->type;
 	pcie->perst_set = data->perst_set;
 	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
+	pcie->has_phy = data->has_phy;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
-- 
2.17.1


