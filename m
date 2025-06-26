Return-Path: <linux-pci+bounces-30811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6B2AEA52F
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546D316A0EC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284FC219303;
	Thu, 26 Jun 2025 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="l2nsoshp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7AC194AD5;
	Thu, 26 Jun 2025 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961975; cv=none; b=i2oCe6Sc2PKrKiUew3YhVOMJhXDiGW6CwxMQAn3FzWCnwaZx7r+abG9DFOghOMGK/npwoJSuiVU8XMGW71aQQidz+feh24+YF34yAOco6K0+8brk8U5B2MrcmG4s1kjJ4ylUPw2eD3eABYve02aFUAP/2M2rDl+O7f3TzbnMQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961975; c=relaxed/simple;
	bh=zNeemGdU/vctglRfI3f7S+/H+wa5hlrBWbirOXcwPL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTZDL6duwytJ5dXp3DznjDuNa1Vf4aqSq4ZIMxE6OBXxYv6s6PNko5THY5kQtTnfkOTGzy4/yQeLHoRQgiiqpuN4MljKd2Ejad6I9m2GuGraO19r/xwiKFWomYRe751N+rbrGZgPFQ3lDfk+k1JVQr+y05cx4WfiS5aXeSnFs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=l2nsoshp; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QEfP7w009706;
	Thu, 26 Jun 2025 20:19:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	dwwi92ajr3Hx7+OnqQ/c83G/3mwouq+VJfJgJebS2Lg=; b=l2nsoshpGQzKnfk2
	5EJJstithUE9ie/HPh8xhyHxqoo4BdiwOjbZ4AJZns45OgXcqBt6O6uwUjx0OKw8
	DhmTMviM0SokrBSW1gae/wKfBoi9MbbjdENTfzfTPdoWnTEHmzRSE3rD+vzqxw40
	bMfrrjb22OrGvFFQzun3HcXLK2wpPdki9GOgPIZbrYDhktnEuye3zRbUkErMbrjK
	GzVCn+zoOFhCdSRMWQxjq4H6QmJsRNsLfvrTi5A/NatrX4XP+Z1h/0gEh3H4cZUA
	jivIs7+7mqV7xx8CTWms/OQ3smU6Ub7zZt1/cAZQzU+ZB6s6cNTovHaMyx/2hvmO
	nnV/xQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47e7ppn921-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 20:19:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DD4BE40054;
	Thu, 26 Jun 2025 20:18:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 53327BAE27C;
	Thu, 26 Jun 2025 20:15:46 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 20:15:46 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <linus.walleij@linaro.org>
CC: <linux-pci@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] PCI: stm32: use pinctrl_pm_select_init_state() in stm32_pcie_resume_noirq()
Date: Thu, 26 Jun 2025 20:15:37 +0200
Message-ID: <20250626181537.1872159-3-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626181537.1872159-1-christian.bruel@foss.st.com>
References: <20250626181537.1872159-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01

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


