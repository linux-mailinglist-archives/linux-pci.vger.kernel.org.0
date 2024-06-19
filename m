Return-Path: <linux-pci+bounces-8970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3466F90E828
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 12:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82672B21C3C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 10:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CCD13CA92;
	Wed, 19 Jun 2024 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OIx7SEMx"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A012FB31;
	Wed, 19 Jun 2024 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792139; cv=none; b=cMFYDZm9Ix8wDirw1engWCzPx0526CPxNq4El7mqnjY9SNk8c1E5gNF0w7jCqR58nWKpT9lqcM1VbG8hs0Chg74YO3FXPsBVZ5PprStqoRPkNT4H2hWgVYCSM1iRPDJ6hItueelu9DsSBrwkp5QUA+eWMLl4VNJtHM/bOZLcNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792139; c=relaxed/simple;
	bh=lpcRI6pbJ32meL/VjTzpGOcoWSJTYnk21moIdV1Kpxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pnh4OfQ8Rlh6dZsQKGS/kI0ffb9TGeXU92GwF077Uv4l3cXFhV7gnA6YoCLQOw4xnjUDOxFUZMmiOsy+0rLPr5ImO3gQWaJ+C5TJHNqQ3YOiNmvCgXiOCK1DgO/K8cx8yFdELC+3YdMFuJFsDeG2EpeKP+aFphGPRowvmC3R1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OIx7SEMx; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00408E0002;
	Wed, 19 Jun 2024 10:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718792130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M72jZYyV65DqxQX89BNQFEE+r0wyDWzohfJY2wWVXuo=;
	b=OIx7SEMxKCHAkmzw1EABsspp6JWEbcRaiTqIri2fmYOm05adSXSwyAGoa/bml9ywzsN97p
	1Mg9e346QVix8QMXQZnA47xzZUm6gyH7t5AivROVoHex09xnhQzX3RstV4G/934nIQaJ23
	lBftlAX9KmWbat28HKz8staJSiDtmRjgln44ki/V2RD7OGgvO2GNB1g8IhWV12JKGz0o24
	BZx75W0yRNfjwD4M/cNO5rfLId2Jbm5Y4xleG1gfQGNHdaq9StDlFa3aZoclOZg8M1x7Mq
	NIDateKqsd9DaFJG5UkxI31zhUrYBJp4QfYeCpOqvAmEtIjq4DzE+btYr+GADg==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Wed, 19 Jun 2024 12:15:15 +0200
Subject: [PATCH v7 7/7] PCI: j721e: Add suspend and resume support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240102-j7200-pcie-s2r-v7-7-a2f9156da6c3@bootlin.com>
References: <20240102-j7200-pcie-s2r-v7-0-a2f9156da6c3@bootlin.com>
In-Reply-To: <20240102-j7200-pcie-s2r-v7-0-a2f9156da6c3@bootlin.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
 thomas.petazzoni@bootlin.com, u-kumar1@ti.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com

From: Théo Lebrun <theo.lebrun@bootlin.com>

Add suspend and resume support. Only the rc mode is supported.

During the suspend stage PERST# is asserted, then deasserted during the
resume stage.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 98 ++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 967a5bf38e26..96316a79ab8a 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -7,6 +7,8 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/container_of.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/io.h>
@@ -22,6 +24,8 @@
 #include "../../pci.h"
 #include "pcie-cadence.h"
 
+#define cdns_pcie_to_rc(p) container_of(p, struct cdns_pcie_rc, pcie)
+
 #define ENABLE_REG_SYS_2	0x108
 #define STATUS_REG_SYS_2	0x508
 #define STATUS_CLR_REG_SYS_2	0x708
@@ -531,12 +535,12 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		pcie->refclk = clk;
 
 		/*
-		 * "Power Sequencing and Reset Signal Timings" table in
-		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
-		 * indicates PERST# should be deasserted after minimum of 100us
-		 * once REFCLK is stable. The REFCLK to the connector in RC
-		 * mode is selected while enabling the PHY. So deassert PERST#
-		 * after 100 us.
+		 * "Power Sequencing and Reset Signal Timings" table (section
+		 * 2.9.2) in PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION,
+		 * REV. 5.1 indicates PERST# should be deasserted after minimum
+		 * of 100us once REFCLK is stable (symbol T_PERST-CLK).
+		 * The REFCLK to the connector in RC mode is selected while
+		 * enabling the PHY. So deassert PERST# after 100 us.
 		 */
 		if (gpiod) {
 			fsleep(PCIE_T_PERST_CLK_US);
@@ -588,6 +592,87 @@ static void j721e_pcie_remove(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 }
 
+static int j721e_pcie_suspend_noirq(struct device *dev)
+{
+	struct j721e_pcie *pcie = dev_get_drvdata(dev);
+
+	if (pcie->mode == PCI_MODE_RC) {
+		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+		clk_disable_unprepare(pcie->refclk);
+	}
+
+	cdns_pcie_disable_phy(pcie->cdns_pcie);
+
+	return 0;
+}
+
+static int j721e_pcie_resume_noirq(struct device *dev)
+{
+	struct j721e_pcie *pcie = dev_get_drvdata(dev);
+	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
+	int ret;
+
+	ret = j721e_pcie_ctrl_init(pcie);
+	if (ret < 0)
+		return ret;
+
+	j721e_pcie_config_link_irq(pcie);
+
+	/*
+	 * This is not called explicitly in the probe, it is called by
+	 * cdns_pcie_init_phy().
+	 */
+	ret = cdns_pcie_enable_phy(pcie->cdns_pcie);
+	if (ret < 0)
+		return ret;
+
+	if (pcie->mode == PCI_MODE_RC) {
+		struct cdns_pcie_rc *rc = cdns_pcie_to_rc(cdns_pcie);
+
+		ret = clk_prepare_enable(pcie->refclk);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * "Power Sequencing and Reset Signal Timings" table (section
+		 * 2.9.2) in PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION,
+		 * REV. 5.1 indicates PERST# should be deasserted after minimum
+		 * of 100us once REFCLK is stable (symbol T_PERST-CLK).
+		 * The REFCLK to the connector in RC mode is selected while
+		 * enabling the PHY. So deassert PERST# after 100 us.
+		 */
+		if (pcie->reset_gpio) {
+			fsleep(PCIE_T_PERST_CLK_US);
+			gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+		}
+
+		ret = cdns_pcie_host_link_setup(rc);
+		if (ret < 0) {
+			clk_disable_unprepare(pcie->refclk);
+			return ret;
+		}
+
+		/*
+		 * Reset internal status of BARs to force reinitialization in
+		 * cdns_pcie_host_init().
+		 */
+		for (enum cdns_pcie_rp_bar bar = RP_BAR0; bar <= RP_NO_BAR; bar++)
+			rc->avail_ib_bar[bar] = true;
+
+		ret = cdns_pcie_host_init(rc);
+		if (ret) {
+			clk_disable_unprepare(pcie->refclk);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static DEFINE_NOIRQ_DEV_PM_OPS(j721e_pcie_pm_ops,
+			       j721e_pcie_suspend_noirq,
+			       j721e_pcie_resume_noirq);
+
 static struct platform_driver j721e_pcie_driver = {
 	.probe  = j721e_pcie_probe,
 	.remove_new = j721e_pcie_remove,
@@ -595,6 +680,7 @@ static struct platform_driver j721e_pcie_driver = {
 		.name	= "j721e-pcie",
 		.of_match_table = of_j721e_pcie_match,
 		.suppress_bind_attrs = true,
+		.pm	= pm_sleep_ptr(&j721e_pcie_pm_ops),
 	},
 };
 builtin_platform_driver(j721e_pcie_driver);

-- 
2.39.2


