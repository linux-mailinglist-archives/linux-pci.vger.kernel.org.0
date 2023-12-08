Return-Path: <linux-pci+bounces-650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E00809EF5
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874E51C20B34
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B507211C95;
	Fri,  8 Dec 2023 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pQHpt5WN"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAAB1736;
	Fri,  8 Dec 2023 01:14:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfQ3XCknOvbmhB5emox5i242wv3oCRO1FlBibqlFxA2VFwq3CF+jzDsVULeImms8Pau13KR4+OFz+XEsd3lSlNq/hohYVTTWjTKtNktt2nwreyOtnYPopylfxMLlBdVrjc6CsrisgGNiV5d862cAVH/L1kEUwN9afHkJM0CvUEqrZ8Uw3R7QyPLZ1e1m22lVQeGQpvkTdqXiiey6nXkUFJnkyrfzVetun74r8t7oDdsTOWh5pbpb4l0RWpLxZi6BAbJ0FSVVn8uEnXPmkW5Kp7jZvbyOjT3bq7/eyXz6PaLf+hm/zdvJVOjbnGPll9dG8IlUlk6H7k4hGQFflHwU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PQVaZlvZBjuhXe6cmiM9DNsp0BqsyeiNKzoHxw8N3A=;
 b=SuEKBxjtIfvFkboJ/HNQfUpj0+ALlYSnQhljlV1p460lNa7DNfDNVlDyB+FnX5+skmE+d4sVgkcs9OwStCsJFv22zpq6fbndNhwdTFR8u4VOU2juOGeIu0QRErLU3Wd5It0zLsi/vFjN82DjfRi6XBE/ofRs7/rb/80pY87/0NYmYNHi375mIIrHpqQ3mwwso6U2p+vJqV8SD2VViNqAun3fIqq0/1cCtRHVzI56b2hesAGSNxYMoshqclDjskGAmMuDbWG4jrn9OaIkqFI9rsyLiJnP11T1G/WUM6FCdDqOMIze7pKqTjNvFszE7n0DQgjvACdvjCs8aeIxFSb0fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PQVaZlvZBjuhXe6cmiM9DNsp0BqsyeiNKzoHxw8N3A=;
 b=pQHpt5WNOn2fuK1Se9+9TlIMkA28p1t7lTn8PhekPUdYgxKR81xM+YvJrp549VnEdhxD97K8mlIMNCn7GiCCSerpbFLDIuRCC9yBBZNPI/9Z2KgKew5UaUwRYOCQZqu0yfoV110fQTSQ2tOUkEK94b0J7DYneO/OvWG+uAtQuYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 09:14:20 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%6]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 09:14:20 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-imx@nxp.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] PCI: imx6: Add pci host wakeup support on imx platforms.
Date: Fri,  8 Dec 2023 17:13:52 +0800
Message-Id: <20231208091355.1417292-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208091355.1417292-1-sherry.sun@nxp.com>
References: <20231208091355.1417292-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AM8PR04MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 32004baa-9b53-45a5-6a94-08dbf7ce0f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+oa+0PiOWNUTHnyHZN3c/Kz/FovlTtwUSIH2RgqASC8Wy0hgbQwJbVhIF0P/qfM2WnyFY3NlfniQ95jYZEkq/qJ6P8XVysO7eNrRnxGH0xXhPs2mdvCj8bA4qW0lZBZMrDnrrAhROAfs2yIRKWiGzZhiI0ZjJjC4ii7vyayVdt8q/wB3HeE3M10RrB/8dvBMHoAFpSpFBz7EL7s2o7F2DI1rr3Itad2fQ7CHv0ldDUhidmZqfDgYMD1foBD/lzDKnW5Qb1DhDr2xPJdx0bPR+GBkPc2uMlfZL5PKGhy8bMtY7Cl5AKPCZWWmPfLjjlv3xVPHRPY1yOvnV+k+fZtm7YL8AjQ3ktAyhCnaFvWGExxw3xt/IXMIJkQkDtm8b6TdlYD/scoXAF/s3cTdatuZ73Q3p4J2ZwBUdEa6wkSPjAccqhWJECQN3FqGyxNNPJJGJi6kGwFS/P36LGasWWHkhwCUL83seMSKSpLGSw7IzaJ5Y2jm91pHR1eB4AUU86KO6qsjaMkAkZjQA160IngoqcRtKO/BblVfr4GB+c8vSIyU5g/y+j58TYLXt64yL1XH6W/V9V0jK7kcfvIjTucBKmrTBhpCikl1mt95Cwl7lAYfKO0V1MVHtlbbLRbaHo2Jl++/8lR3mrL9zHXpoFspJw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(1076003)(26005)(83380400001)(2616005)(52116002)(6506007)(6512007)(5660300002)(6666004)(4326008)(44832011)(41300700001)(2906002)(7416002)(6486002)(478600001)(316002)(66946007)(66476007)(66556008)(8676002)(86362001)(36756003)(38100700002)(38350700005)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D7Jhw+M5bVqDb/Wmj8Ogayp65eJZie9P5uXqXGZI5OPPOH2AQ/DsLJUsLqF0?=
 =?us-ascii?Q?fz6c4z0IxBX87ELlR2WiZkp1YITYp+9QDIUuFq2s88/YXnowBjVqAejglDhl?=
 =?us-ascii?Q?TpgClhGL+4LdYQ0GPAtyF0D2Id+1D93K4TL1RhYEStgRWgneMSyXZKzMviCl?=
 =?us-ascii?Q?PbasPlkgTcbIbyKePil/p1PKxn5k6QkQlGfRcNxYbUCFLw/kjrvLOehdmhto?=
 =?us-ascii?Q?Vf1tO1lZnh6qVtvBs70tcxEwLxpCB4XCMLHmw+BjYLeHW50eOyxsxN/6WlAH?=
 =?us-ascii?Q?c9vXPsWxZ4HPIFQ5lL9Ieux3Zl2XCcdWdZ/eY5L/Trn2/TUGqJcex5NKWom+?=
 =?us-ascii?Q?qZGuEQ0RGaA0GnDFjqOaGMXyjcklqagfiv6MHwLMGRc0vkKS+LzLtI2BsdLL?=
 =?us-ascii?Q?cS82DcOC34GFoBB2+PPHyxwqIjIWW5womzHvvlNtqF7Err2ON4jvZ1ULSban?=
 =?us-ascii?Q?6S121HL2wLKSBzlQZ/yU5S0yFqIxn+aRSBmVTB7pipJhFB6oIjdEETKYO8hP?=
 =?us-ascii?Q?uroGSfPp9fadunAECMy/MamSZX3QdNA3Sg0Mdcjv1iHh7Yr4UZKfrgs/PZUC?=
 =?us-ascii?Q?5Jn7ucdCFTYrbRyLvWIwk8wd14uz4cxLm1r8zXjyJJZdEGTxoDLBUE6tISYK?=
 =?us-ascii?Q?EnScY4XY7qE/oPjcVZGExXltfxJ/IX6zdgDOBmErWnuTeWwecPSp2JXOZrCb?=
 =?us-ascii?Q?rKMAJ7VD9W7htFEMP1H8ODh0MDAZQhwDalI6MO+dUkErV7cKOK2NrTSZ79Xm?=
 =?us-ascii?Q?+cKcOW+S9c1euUkNcfnQgLnuUquzACSS0n8e2WeDN1oCdPeChCpi8VZ7Mhgr?=
 =?us-ascii?Q?t1/Rj68qs3mCYOpqPB9ebqMfMQu2A58tlQfisHxYj5DWbcT70su2uljPPmCr?=
 =?us-ascii?Q?ojsMQTYUzpeVnnO+tkP97pT2ivYje8QuXA8pBk+2hqrsnJKExo4f26j26I2c?=
 =?us-ascii?Q?5Zv+qMTS5VyXTkiAMnoi3UJw9q0p58SnhiU4sqdGE70PIJJkO6rpCSUScu/C?=
 =?us-ascii?Q?332t7bKwJaG9DiwFHDTpt2fV89sAUr+SS6K2OXlsXFJFJ0aHBHbspc1jle0h?=
 =?us-ascii?Q?chPs529MquW4xGPX9IIfpeUPzY/+j4ih6ZMVBoJyigDRAF5PjNmdv9XISHCc?=
 =?us-ascii?Q?7q+TBj+L/4nTDL6R1zXlsqRfhCCky5QgAtDzG6wTICxkHLJeAv/3KiT3h9WO?=
 =?us-ascii?Q?nCtlZLxa6bfwuT8tEk3m9tFpNUX/3SpYFXDAyGQDDXRdBN1xmxTaLlShP3NP?=
 =?us-ascii?Q?H2ml23Gf5HaXWgXgmKzt2TnkeCGtY0GTWZPg3QN9tZolNy048OSCCrJk7Gbj?=
 =?us-ascii?Q?8L/tUgUkMbmZf1japs4nu0V40Tw7xmLfnlr3Wx56uBz0wkQVN203wXZR95+t?=
 =?us-ascii?Q?oSEQtDcW4hINekNSf/qnbvXcqN3alI5ZtJf0xR3XeQapMWvtfKZQe66tR2zB?=
 =?us-ascii?Q?GihLjZgBcNWQjmCoV6vIsw/V1vyK6dznYfyiVFvmwxsz7W/1JVaiLDJb0LSK?=
 =?us-ascii?Q?Wniu9mgDQ4ngnz3s87NmWQookchSvMPz8bf9FaInglVq4i/mu3rIuhklvMwg?=
 =?us-ascii?Q?Jr3zEVmhgOeRX/Lvdry+GyXdCyAKYxHPUq4a1TDg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32004baa-9b53-45a5-6a94-08dbf7ce0f95
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 09:14:20.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JZnlcWFAURhcvmOoM7KpZXAF/XzI9+3uEZMKpITwJWlXN9QWpgtaso6E/sE79bnLSbST02MEVQkiCgYzQgNGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7284

Add pci host wakeup feature for imx platforms.
Example of configuring the corresponding dts property under the PCI
node:
host-wake-gpio = <&gpio5 21 GPIO_ACTIVE_LOW>;

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 69 +++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 74703362aeec..050c9140f4a3 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -72,6 +72,7 @@ struct imx6_pcie_drvdata {
 struct imx6_pcie {
 	struct dw_pcie		*pci;
 	int			reset_gpio;
+	int			host_wake_irq;
 	bool			gpio_active_high;
 	bool			link_is_up;
 	struct clk		*pcie_bus;
@@ -1237,11 +1238,46 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static int imx6_pcie_suspend(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+
+	if (imx6_pcie->host_wake_irq >= 0)
+		enable_irq_wake(imx6_pcie->host_wake_irq);
+
+	return 0;
+}
+
+static int imx6_pcie_resume(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+
+	if (imx6_pcie->host_wake_irq >= 0)
+		disable_irq_wake(imx6_pcie->host_wake_irq);
+
+	return 0;
+}
+
 static const struct dev_pm_ops imx6_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
 				  imx6_pcie_resume_noirq)
+	SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend, imx6_pcie_resume)
 };
 
+irqreturn_t host_wake_irq_handler(int irq, void *priv)
+{
+	struct imx6_pcie *imx6_pcie = priv;
+	struct device *dev = imx6_pcie->pci->dev;
+
+	dev_dbg(dev, "%s: host wakeup by pcie", __func__);
+
+	/* Notify PM core we are wakeup source */
+	pm_wakeup_event(dev, 0);
+	pm_system_wakeup();
+
+	return IRQ_HANDLED;
+}
+
 static int imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1250,6 +1286,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	struct device_node *np;
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
+	struct gpio_desc *host_wake_gpio;
 	int ret;
 	u16 val;
 
@@ -1457,6 +1494,32 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			val |= PCI_MSI_FLAGS_ENABLE;
 			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
 		}
+
+		/* host wakeup support */
+		imx6_pcie->host_wake_irq = -1;
+		host_wake_gpio = devm_gpiod_get_optional(dev, "host-wake", GPIOD_IN);
+		if (IS_ERR(host_wake_gpio))
+			return PTR_ERR(host_wake_gpio);
+
+		if (host_wake_gpio != NULL) {
+			imx6_pcie->host_wake_irq = gpiod_to_irq(host_wake_gpio);
+			ret = devm_request_threaded_irq(dev, imx6_pcie->host_wake_irq, NULL,
+							host_wake_irq_handler,
+							IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
+							"host_wake", imx6_pcie);
+			if (ret) {
+				dev_err(dev, "Failed to request host_wake_irq %d (%d)\n",
+					imx6_pcie->host_wake_irq, ret);
+				imx6_pcie->host_wake_irq = -1;
+				return ret;
+			}
+
+			if (device_init_wakeup(dev, true)) {
+				dev_err(dev, "fail to init host_wake_irq\n");
+				imx6_pcie->host_wake_irq = -1;
+				return ret;
+			}
+		}
 	}
 
 	return 0;
@@ -1466,6 +1529,12 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 {
 	struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
 
+	if (imx6_pcie->host_wake_irq >= 0) {
+		device_init_wakeup(&pdev->dev, false);
+		disable_irq(imx6_pcie->host_wake_irq);
+		imx6_pcie->host_wake_irq = -1;
+	}
+
 	/* bring down link, so bootloader gets clean state in case of reboot */
 	imx6_pcie_assert_core_reset(imx6_pcie);
 }
-- 
2.34.1


