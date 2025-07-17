Return-Path: <linux-pci+bounces-32354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED7BB08502
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 08:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6A018828F6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 06:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0912192F2;
	Thu, 17 Jul 2025 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RVrVYkbd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29001E3DDB;
	Thu, 17 Jul 2025 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734023; cv=none; b=hRQnQ6F+gTZ4/0XL5zAr0QhEBfDzkalnU8NUHvikoXCMYrKGMJJRDAQjuwnrK5t/Zm8hrzKGpQ9yLOokZ1u9Gk62HIODH+Z883N2yjGn7FUsUqeaQ0j2rjQYCpU3nz9oqwV9jb2Ec9QngJyPdYiD8Pj8Zbr6JlwU+RFoiRo6IKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734023; c=relaxed/simple;
	bh=zNeemGdU/vctglRfI3f7S+/H+wa5hlrBWbirOXcwPL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0YqhwaxI9wtJtyg64a1/DYqvKxnTF/vqPh2SEsQiqaTdmhV2FCJCUCgTD5yO4pG0+AU5QEH2VQ1Tdj7IEX+A36PrqumHOQuzBsWaYSMi6zMBNMTfQPzAbJaxSvAnp+9IbCwdmb5I7Si4ST8PODGYuQ6OMv/rPK2fOT+ZwKCEL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RVrVYkbd; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H2W55C019996;
	Thu, 17 Jul 2025 08:33:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	dwwi92ajr3Hx7+OnqQ/c83G/3mwouq+VJfJgJebS2Lg=; b=RVrVYkbd4bX0SVY5
	BdSY02pTpW6qPdNinX2+osvN0l5c9hCR1hwItQnswWOUN4LLWrJq1TaU0lkjxfQz
	ZEoG8VOfsqAGT4RpGFANhRtcEHNNTU5UKDHOyVP3WAjTp9vh+FRDHrIxxnlTWoft
	u5NV0ktnZPAU1637KtvnSS2cDlNWZ51ROdbH5tHzBFsXfRDLPXGdiYh3dmkxyOFn
	sxi5wShjsNeJ4FJ13J95oNhDC9C456iE4MVYLeRhCGo3wVlTiZ6BzNfJLFnEBG5g
	vcD2OLdg9IT3UhGj10VZosVg33q/pjIPHUAKx5eUd86IXWU7nZGJZGCh8o2il6FY
	bszB/g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47uekh6329-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 08:33:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C47CA40046;
	Thu, 17 Jul 2025 08:32:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 951D478D295;
	Thu, 17 Jul 2025 08:31:31 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 08:31:31 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <linus.walleij@linaro.org>
CC: <linux-pci@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: [RESEND PATCH 2/2] PCI: stm32: use pinctrl_pm_select_init_state() in stm32_pcie_resume_noirq()
Date: Thu, 17 Jul 2025 08:30:42 +0200
Message-ID: <20250717063042.2236524-3-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717063042.2236524-1-christian.bruel@foss.st.com>
References: <20250717063042.2236524-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01

Replace direct access to dev->pins->init_state with the new helper
pinctrl_pm_select_init_state() to select the init pinctrl state.
This fixes build issues when CONFIG_PINCTRL is not defined.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Reported-by: Bjorn Helgaas <bhelgaas@google.com>  
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506260920.bmQ9hQ9s-lkp@intel.com/
Fixes: 633f42f48af5 ("PCI: stm32: Add PCIe host support for STM32MP25")
---
 drivers/pci/controller/dwc/pcie-stm32.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
index 50fae5f5ced2..c1d803dc3778 100644
--- a/drivers/pci/controller/dwc/pcie-stm32.c
+++ b/drivers/pci/controller/dwc/pcie-stm32.c
@@ -28,6 +28,7 @@ struct stm32_pcie {
 	struct clk *clk;
 	struct gpio_desc *perst_gpio;
 	struct gpio_desc *wake_gpio;
+	bool   have_pinctrl_init;
 };
 
 static void stm32_pcie_deassert_perst(struct stm32_pcie *stm32_pcie)
@@ -91,10 +92,10 @@ static int stm32_pcie_resume_noirq(struct device *dev)
 	/*
 	 * The core clock is gated with CLKREQ# from the COMBOPHY REFCLK,
 	 * thus if no device is present, must force it low with an init pinmux
-	 * to be able to access the DBI registers.
+	 * if present to be able to access the DBI registers.
 	 */
-	if (!IS_ERR(dev->pins->init_state))
-		ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
+	if (stm32_pcie->have_pinctrl_init)
+		ret = pinctrl_pm_select_init_state(dev);
 	else
 		ret = pinctrl_pm_select_default_state(dev);
 
@@ -274,6 +275,9 @@ static int stm32_pcie_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(stm32_pcie->rst),
 				     "Failed to get PCIe reset\n");
 
+	if (device_property_match_string(dev, "pinctrl-names", PINCTRL_STATE_INIT) >= 0)
+		stm32_pcie->have_pinctrl_init = true;
+
 	ret = stm32_pcie_parse_port(stm32_pcie);
 	if (ret)
 		return ret;
-- 
2.34.1


