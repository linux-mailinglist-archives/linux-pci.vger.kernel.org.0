Return-Path: <linux-pci+bounces-11732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3BC953DC1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 01:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DED91C254BE
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 23:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A64158A12;
	Thu, 15 Aug 2024 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KWEfl6iI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5B15E5A2
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762709; cv=none; b=D+ZcE6kQaTZnoznNVS3boAfzfCKEcX2SuyFahEcQRqO9/jgKSUySLSHOA2HZtBqfo/YFQLYXuXKAF4M8tWcZODPDz8A4FECRrSpAecTvJ3sOGFHPCSWBRlFZF0+460exV8NRQ5orGpeJagFK72uWwGWPLYsaOxtRhsSTA1z7bwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762709; c=relaxed/simple;
	bh=XQ9RjsJ/c62A9Icx1r751DOLP6WoZaUgI4RWwckyHfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Il0hULz7HxFR7TwnZkRoZL7i77CzSIfUMeznmmZH6w37/h6TxdbIMhO2w3lLDonzlZhc5aZIgOop06s9xjuRq0IpCFVbBgfsOgzpDrm2GKqDKN9nKJO6NlybtY1KRXc9rT23+geucK/b9hNhncNJTiyaIixBpVLeeTKzoBZ9Eug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KWEfl6iI; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a1843b4cdbso1098144a12.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 15:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762707; x=1724367507; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iEyfkuyjidIDKVD0EgGnVsHdeDp6cB5THGfAbkbJ5pQ=;
        b=KWEfl6iIaCHtNRuTAPWE3uOanhbGTszq1kWclAf1f1NmddC7H41fVTp7T77Z+4OEqz
         fbBv6xA63a+jCo+4g5QAbSmaoi+2/ZxrLknwM4Lk4mtfvZxIY+l5OBazx7kcGE8vu3o5
         1FuaDCAXk0u3ZYFEhIMjPGCQMh2EF2TVS7O9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762707; x=1724367507;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEyfkuyjidIDKVD0EgGnVsHdeDp6cB5THGfAbkbJ5pQ=;
        b=bu70m3EBQVf1Ywlkc/27WxXXJRU9tzkECnv5S1aXEiwdhuKqjQRPTZ7H5WtkfT2dqg
         3w12kNfCQ4r9oT3AAzh7159K7hR/n4C+MK3gLWAa+OobY3/fd5MeSHmS7a8+UDkAFtRr
         ki2HKkLIBjiJxvxTstrs1h8xopTOm/VBvs8tVAcyAopay7a0NEOULhGKyvJY1UZrHrPW
         FzSV7RkYbS+P9VI91zFVPm3qCtxC/9Fvy7HSo38h5/bac5xSE8DFazUi94ad0coM5eUy
         58KKGSUoBWmwKllGSjhklIifeG9ezySdHk2+L1BgvOrE3RqiStLtWyqWj9JWdGp0Gm1I
         kw3A==
X-Gm-Message-State: AOJu0Yw6HP552LpK+oPmOyppyxop6MBDaNS8c8EzG7Kj2KXBqcCl51ek
	9XMIx29M3VBhoCP/oE6NMyqE0HfBfjaGllkUpn5tK4Nc7sHVgwxCeq2ECyw3pjs3hmnHD4SeKCP
	tW3ynB6ql0j8Wi/AeTlbPIq/VqqCsuWOFtZKBpDnKGOhK7OWL3TEU3/mQLUzlpT2xshT+qE7EEW
	jTQdtlDsI2K8Rf3OvXUeR+Dyj1ERgd+kyI3rvKzOqnCTaCKg==
X-Google-Smtp-Source: AGHT+IGXdJjw0jDnc/rZ+TElPH5EDfkpxHpnAawNeGz/KmJkADzTu0pSSxdB5tMFhph2VdZ64qjpwA==
X-Received: by 2002:a17:90a:8a81:b0:2d3:d0b7:da4 with SMTP id 98e67ed59e1d1-2d3dfc7a8f2mr1274469a91.19.1723762706894;
        Thu, 15 Aug 2024 15:58:26 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:58:26 -0700 (PDT)
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
Subject: [PATCH v6 13/13] PCI: brcmstb: Enable 7712 SOCs
Date: Thu, 15 Aug 2024 18:57:26 -0400
Message-Id: <20240815225731.40276-14-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The Broadcom STB 7712 is the sibling chip of the RPi 5 (2712).
It has one PCIe controller with a single port, supports gen2
and one lane only.  The current revision of the chip is "C0"
or "C1".

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 26e8f544da4c..21e692a57882 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1203,6 +1203,10 @@ static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
 	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
 	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
 
+	/* 7712 does not have this (RGR1) timer */
+	if (pcie->soc_base == BCM7712)
+		return;
+
 	/* Each unit in timeout register is 1/216,000,000 seconds */
 	writel(216 * timeout_us, pcie->base + REG_OFFSET);
 }
@@ -1674,6 +1678,13 @@ static const int pcie_offsets_bmips_7425[] = {
 	[PCIE_INTR2_CPU_BASE] = 0x4300,
 };
 
+static const int pcie_offset_bcm7712[] = {
+	[EXT_CFG_INDEX]  = 0x9000,
+	[EXT_CFG_DATA]   = 0x9004,
+	[PCIE_HARD_DEBUG] = 0x4304,
+	[PCIE_INTR2_CPU_BASE] = 0x4400,
+};
+
 static const struct pcie_cfg_data generic_cfg = {
 	.offsets	= pcie_offsets,
 	.soc_base	= GENERIC,
@@ -1739,6 +1750,14 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.num_inbound_wins = 3,
 };
 
+static const struct pcie_cfg_data bcm7712_cfg = {
+	.offsets	= pcie_offset_bcm7712,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.soc_base	= BCM7712,
+	.num_inbound_wins = 10,
+};
+
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
@@ -1748,6 +1767,7 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
 	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
+	{ .compatible = "brcm,bcm7712-pcie", .data = &bcm7712_cfg },
 	{},
 };
 
-- 
2.17.1


