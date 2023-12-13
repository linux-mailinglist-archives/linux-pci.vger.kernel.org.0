Return-Path: <linux-pci+bounces-846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9648810D66
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B32F1F211A6
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961A200D9;
	Wed, 13 Dec 2023 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fpJZTNjj"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7954FDB;
	Wed, 13 Dec 2023 01:28:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+b5dwIR/F9y3M00MIR/UGfcQqvJKYJCseJVr01p3cfOTBXbZVLuenGTZJr5RdfnP/S67WeI/YfpUIPyu2v8d2WAlQdIVQDXQdq7U1hT1TE4S8794nA4CTFWKUYVam20TIQTWKg3mWUpnvLn9+qJiQNP3JJjcA0aJD7vLl9BiZK+yLqUe1qBHJHzmR9Bmk5fwFr0S7SJJ8wdF0qIkpEsfN5Bo5rUhSX++71GJVqOoj8lzmLsl83zDemzygIUrRaVP1FZxZnFICbotn7RmP688763THuur83ZO0lQdAhSjFX1faG0OUqwAdSbVdoiDTdedp8pp4fOzXKYhe2fJJUE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bfo3Il/zbDFJeMBYIHXKhuAvgRW/0s7JtCZyKPAnJrk=;
 b=BjK9mCZ7viFfZWHMr0Ak4euVcRjQ9/klKdjDE+UXGjTdMwuAZiRgXKvmKZgp6fvXXnCXddZZNMMmPBJXD1SS9aMHRA5WYisPCl8J0R3kkx6Ql+vWSfF3or1xe07m1lErVzxTuhM9jdNzRmV0RmaMtY553gdvy4D07MchNbh5k3yHctSeH0CuOCHL/xMG4rULSEiOHfDngYpjs3IBUU2E/l7p/CiYouu+0j6yu7BU75CP4txgUNYQtVikQApa7imogK1wuU+2O3X4zgRT5wTGlG/v6GYxLUl/e5C5+b4W+enKJ/++3j7V0nb/n3SDoRjHU+Tf3M+f1fn/p6AM5vUVVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bfo3Il/zbDFJeMBYIHXKhuAvgRW/0s7JtCZyKPAnJrk=;
 b=fpJZTNjjE68tRW72Cy03iVyrMpRT0v5mithvlIMMlnal7dN5oL5aD8UFRfA+JNmZgOo0EusPE8KXO4TWoVwN3CnkQ1NrLd9W0IJsjbJS5sRPI8mE6Lh4SAnNL8pfU7vJwOjrOmxN9iOVLBEWt9Apo28ya4rh+HLoSsE8d/yZQ0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PA4PR04MB7933.eurprd04.prod.outlook.com (2603:10a6:102:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 09:28:38 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:28:38 +0000
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
Subject: [PATCH V2 1/4] PCI: imx6: Add pci host wakeup support on imx platforms.
Date: Wed, 13 Dec 2023 17:28:47 +0800
Message-Id: <20231213092850.1706042-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213092850.1706042-1-sherry.sun@nxp.com>
References: <20231213092850.1706042-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PA4PR04MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: f766eb8d-8c2f-453e-45e4-08dbfbbde2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j/gBudOqbMs0pGh9WRd27zREg5zCM4d6VXf4VKrx/CNMZu2VbR98bX3AVZ7q9o8nNEveobJwhXOW566k0zWsSr1LScuUokqZsgXFukCrj7T7sAECOzVkPKnJTha3RCCPOR6jpwhEspgdcQwRy0Qw68E6QtTflzx+pw34QX4/xcllgZ2e7h3PdPEC2VU+sQel0qRxkh2VIt01cTWMKsRpM13VwI/DDS0cBOIbiot2erzq7Y5CJjBmo9GRFtjTwvm9ciyvLbz4+H9ZRUCR6LqSDcl4xasIrSlseJOg+nmBXF4MvO4bZW8yyh+AjwhUVAk9DnVqXH1XYbnIhlt11LIfqaGT5jbal448yX6lxuDK02zFojlR3i1ilIDOYDCZxvhggsO0m+YBWOT6hmVniI4hSbvx22zK/yuTTJm/3V1yUPhf78/FmwBaFMspGIsPhCGypFzIzYzJqLFFyLed9384OPSH7JChIYf0QnllkP31mblEfWUGu9cyv5IQMFpBEkzLB3l8isW1E2BASnliPlki46VGyylqS2X4fPlWDEVswX6OtD2iUR9/OTSP234B9yTJXC1//ieozmhPOxZKWfEka/RtGFc3F5wfL9ZROto/J6tOlIaXcfhpr5B/cFKEfTWizOd1BwkX1s88rzRbUpgOdQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(2906002)(316002)(7416002)(5660300002)(8676002)(44832011)(4326008)(83380400001)(66946007)(66476007)(66556008)(36756003)(921008)(86362001)(38350700005)(8936002)(6486002)(38100700002)(2616005)(6506007)(6512007)(478600001)(52116002)(6666004)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P46MDMxYEbef2CWUPhC+tNT+FAaecM60y0f8sYAPn7EQZStkF2yZBnz7j1qj?=
 =?us-ascii?Q?7TcVjHT04jW++9FkxustH8/QXfPxVp9Gr8Y+u+MLa/6br78qa4SljOnBSy2a?=
 =?us-ascii?Q?17wJJPUsgyeL21uXIDzMcDGqAgHbymBAaeaLRU5rQHzRdOSce5gg42i+30QS?=
 =?us-ascii?Q?VoJrSCD6wugQLdqewKWcEoEEw3XJOPYp8b49tOe02qMj1MWqrHZRzVOzPr4z?=
 =?us-ascii?Q?CApb1/eOPpGEMGdzDUVvS78ms9bcFTZwSZk/9X8Hb6frCyI5yxeU6b/gesHE?=
 =?us-ascii?Q?PQogSvA/tA78k2KKK/S7Z47r11dwBSYXqNvnFFpt4fgK7qR0EvBso6yaaNlv?=
 =?us-ascii?Q?h2xKaJNg7wPGpLPhGDN79rxYjfEZLYPWVgHKIVC75aa+/8QC/3n6yPsoTblf?=
 =?us-ascii?Q?dHNs8e43f1tX2vrMcsP/KyAro+90YNqJqVg1Z1o8QbYQk2JqPKZ6mXocVXn8?=
 =?us-ascii?Q?1Uz1Zopg/mSHVa0jzzNxVjKuf4KewNlisl0bhS4TZzUIKneQUX1TSS4FZ7VB?=
 =?us-ascii?Q?2djIWV1W9sVe+2Plc1j0mPoba4kUqW4wOC3wPUPxHW9Uqiaq76xH+JQ/411H?=
 =?us-ascii?Q?upvp2k5HIk6vq1eO2hlAno2wI/XwyTP0Ybav7H9le7K81BccWJqZIxr7K/2N?=
 =?us-ascii?Q?C2b4wzffYrOawsW5XcBz2UaawwI9oD9LnR+MXGcXhGWrI62Zn7fRnn0S/u7X?=
 =?us-ascii?Q?ZQc6Jdt9J1M4XffjOqBcQYsumbIL+LPPPhVFfIA5dmJ0f4p+JJtQXRiSgK3v?=
 =?us-ascii?Q?vyeZech91yME/nBt9+zvD2SgP7WC2QjYvpBLS/hhRdUENNXJI19TLe+QFKln?=
 =?us-ascii?Q?bFSHocaJ66KzEeWTNSUHOJ4B/r+PofsIO0j8Bn3xOUga7EJJyFF/ojyaV8ON?=
 =?us-ascii?Q?RGTo5Qx3UnXaf5ZyCQOdeFzW+tJlqitRAt8N8fl+W6NzF42w03BJ/SYtVGLh?=
 =?us-ascii?Q?KjZusdtY2zZvjojzw0SMBxS2cJ/a/boDQOmlwo9ACaqxUKPBVUAnA4BzZsIO?=
 =?us-ascii?Q?Z07ddnyIdEHe/ZcC35cUKXPzZ1XAS1A26BO/RzdyvVOPOintXKTNd9yicJQ5?=
 =?us-ascii?Q?tioPiAvRN/wcCuciw0HhY9BV8Nhp8G5QTRzyIcRLgtPXaPI/qjxYzEKpBluJ?=
 =?us-ascii?Q?hajBPuvrfXT3LfBsTAOcDoHDku+wx59NvMwwG4QQxyK07Au5vmP0PDfh3hU+?=
 =?us-ascii?Q?y4tBTY1tLn9PmM3PVE63qoB3XNlko4m1ACCzd2kptN+UC5Mrrw7xmXdyzuGh?=
 =?us-ascii?Q?EbBz5EweLHf4JMdBsn/NcnYZXY7kam0arWC/Cux+1T2+pg4aZ87juwOYCE8t?=
 =?us-ascii?Q?8ctEyK+tOHuhBktmD0EtxzI84WfrbSbfC/D45nguo40SXLq8vxp02TIc0qyq?=
 =?us-ascii?Q?FMUUwRBzp+ey/z46kWjYYycKv9XKBQNX61m+1e5500aRbfYYZbYz/P38T3Ex?=
 =?us-ascii?Q?KZU7Uhtwa+sPCR2bHznQA4Qjbtn/llRFsUW9/h0Dakp6tZQDfqWfwrXALlt2?=
 =?us-ascii?Q?4nT2NvYsNWWhwYSI+l28+l60hn0XSEjTOLXu1pkL9seifFcSr/i2hpOS145u?=
 =?us-ascii?Q?wURLzQm7thhJB95ru+lWOka8wmDxkDBWsQRca0Ke?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f766eb8d-8c2f-453e-45e4-08dbfbbde2e8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:28:37.9793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOw9fbRAimNMhEpokUdgQ2C3kkVvPvSvjkH6vNYPs3umdGTKyssmD+qdVubtu1OqFGqi03SFXE+EphnuFVlRXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7933

Add pci host wakeup feature for imx platforms.
Example of configuring the corresponding dts property under the PCI
node:
wake-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 60 +++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 74703362aeec..0cf7f21adff8 100644
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
@@ -1237,11 +1238,44 @@ static int imx6_pcie_resume_noirq(struct device *dev)
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
@@ -1250,6 +1284,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	struct device_node *np;
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
+	struct gpio_desc *host_wake_gpio;
 	int ret;
 	u16 val;
 
@@ -1457,6 +1492,26 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			val |= PCI_MSI_FLAGS_ENABLE;
 			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
 		}
+
+		/* host wakeup support */
+		imx6_pcie->host_wake_irq = -1;
+		host_wake_gpio = devm_gpiod_get_optional(dev, "wake", GPIOD_IN);
+		if (IS_ERR(host_wake_gpio))
+			return PTR_ERR(host_wake_gpio);
+
+		if (host_wake_gpio != NULL) {
+			imx6_pcie->host_wake_irq = gpiod_to_irq(host_wake_gpio);
+			ret = devm_request_threaded_irq(dev, imx6_pcie->host_wake_irq, NULL,
+							host_wake_irq_handler,
+							IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
+							"host_wake", imx6_pcie);
+			if (ret)
+				return dev_err_probe(dev, ret, "Failed to request host_wake_irq\n");
+
+			ret = device_init_wakeup(dev, true);
+			if (ret)
+				return dev_err_probe(dev, ret, "Failed to init host_wake_irq\n");
+		}
 	}
 
 	return 0;
@@ -1466,6 +1521,11 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 {
 	struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
 
+	if (imx6_pcie->host_wake_irq >= 0) {
+		device_init_wakeup(&pdev->dev, false);
+		disable_irq(imx6_pcie->host_wake_irq);
+	}
+
 	/* bring down link, so bootloader gets clean state in case of reboot */
 	imx6_pcie_assert_core_reset(imx6_pcie);
 }
-- 
2.34.1


