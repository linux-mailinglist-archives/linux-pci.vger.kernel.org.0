Return-Path: <linux-pci+bounces-11083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0052A9438F7
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 00:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8DC286A6D
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 22:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FBB170822;
	Wed, 31 Jul 2024 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fYK4yan/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E6216EBFA
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464929; cv=none; b=iQfuseS2b8cIlwSqroRvcubnozAUwsqI+vAKSvDagVCusJcc6s8m5HKDcETy80iJmLhLAsf1Fh4jdKhkEMYxK6zu+NTg20ckc7xlLpBPDHKDzs0HVOpgPsQMuMbpkVcOqrfDcn2PeJ/grqmKrQpLXLqXM/8XXZ/r7d/7MBxD3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464929; c=relaxed/simple;
	bh=y4hjFNKfNrZAXib/tvA7NVNsQrFiOMDnP+KgXAPJWNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Fqp6KmoZ43JuzH9w9h7yNj5omMonrx2hw3J5iFn5rid5xYBGlEfvi3nFRxiUudZNccNx7aO5MMXmm4za6m8rkwo1m6oTCb4pkHmleN9OONMQ4UBsudoW74o6k7rWnCjZpVlusRi+ADZSG5UJ119eBBwmbeAXPM01+6wVCR5l+YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fYK4yan/; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-450059a25b9so13716921cf.0
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 15:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722464926; x=1723069726; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bv0ulUw6sT8Iayb14UqZxCz07Sx/8FXvzTyd8OjlUtI=;
        b=fYK4yan/eHVFlukjIxgLOOy6nlVRU2tBavQ6Hbdgj8gY6M4ZF9tbOXWDzsU50irc6N
         m940ekCSz0EjaxX2xU4ZuiQCXAsR+l15TxqofhTYew+lsqYdyz3QY/FPo/+VGOI0jMxW
         EVIWXHqBVjNY9YWH11Y3//guLyK4qcF71w2uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464926; x=1723069726;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv0ulUw6sT8Iayb14UqZxCz07Sx/8FXvzTyd8OjlUtI=;
        b=Q712efg4qKhAS4M6nNbBXhIG+9xh2QCoYzkr1MLbmRM5v6v/jnTXJ+YaNi2VlZRcGi
         m1swiz6qgJhoPlozgP72VX+TJuvxtjJZicdt5gHDa1jtrgoqlH+c2SJSbb1yqdFDu/Pn
         ADUe3GTTtRpNTlTS5hwYU3gn5Fdkj7RPJ5sd69TLnhPxgCC/I424yYxDTQKex8/y0mzg
         RUaOGeSDriKl5lSj9BumAToDjc/L8SSoIWJpVoux1eDylUp5ZM36fA0PeWkfPTFjfV92
         W9lB8b11aMKWBZVuvFB2OsuE7XbquHRJMkUn76sAMKSmpZNQwCrHQYNbw7uhzcuBzZVU
         l1zQ==
X-Gm-Message-State: AOJu0YyCuEVRtCqk0AWMRr0CEGTsJ1xurmt+FrBlfdZrJQNLD5LqewpM
	4kwxMyKHoGmPZRUKx2U0jqIIeSNm1xADAHgqNacwpEJAqKUHNOBWcKHZ5mSgpbw9fmpu+LfEozy
	eHdKl92TwI9FHqcq+FLGRCOaDwKYqvWrW6HmsmNtLHCorK5qQUIq8Y8+cOVZWvIWHlZkIVRqREv
	DN3NDRVFUnURaUE4gyPY3IOT3wO7UA4q5eZdDIED+qwdeLgw==
X-Google-Smtp-Source: AGHT+IEc1bug40GUkbPlSsJIRank943JPZR+j1XlzEMEL1N3IsMC7w+8rJGmsbIu3BEy1N2Ib6H+1A==
X-Received: by 2002:a05:622a:587:b0:446:5b56:989 with SMTP id d75a77b69052e-4517ee9eb96mr12185401cf.6.1722464926160;
        Wed, 31 Jul 2024 15:28:46 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416c80sm62359181cf.96.2024.07.31.15.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:28:45 -0700 (PDT)
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
Subject: [PATCH v5 08/12] PCI: brcmstb: Don't conflate the reset rescal with phy ctrl
Date: Wed, 31 Jul 2024 18:28:22 -0400
Message-Id: <20240731222831.14895-9-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240731222831.14895-1-james.quinlan@broadcom.com>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
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
---
 drivers/pci/controller/pcie-brcmstb.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 1ae66c639186..4659208ae8da 100644
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


