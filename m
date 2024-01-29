Return-Path: <linux-pci+bounces-2669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF95083FB9F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A76B2841F6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B9AC8C4;
	Mon, 29 Jan 2024 01:14:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2070.outbound.protection.partner.outlook.cn [139.219.17.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080CD27A;
	Mon, 29 Jan 2024 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490895; cv=fail; b=hGEfPk/iqRzE1LnaTX23O2GupbocwaKhf3BkjAfXaRv8gyxfyEpu7guQ6nUc0Mqd7cLigZnS8ZSPmyZhc0fguifUH5ofnVb16XrWmYOQzJYrjnSXAEnAL3w7nQOBaZ/ft6ZzPem1Q+WnKYFBLi9VVHADCegJZd2Zfy5R8B+qPGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490895; c=relaxed/simple;
	bh=CK38PTJKcJcw90VpcidRxBv9FWVT/PDLFLiHaWgmHaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pgurIJdENBrveh1aJcmF8QL+0vdn7ZkZ1txeyLq6DI3ZdabLwo0oY8RXQ+VrFDhFcD4xQUwx4EO2X1b60NF8wfXSzfC2Mm1DmQBn/Plxo0t3+1ZzAzWaO53wrlI4Ni2lebOwPm8GiKo2QmHP8SWHtwQNDAAiH0N5WfZ14cPThBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuscITfDmNM9+7+zaRWOt92p94mpf3WizhTNkNwiRt6ac6rqQAw2Lrdrg4hlRa9fVN36sd7q/wZVT3n7QIfc54j1YsaiarXlBN/XRbTLeDLdHAwmaGMLJzRBKo54cpKxPfxoNfkLpkWJVvhK6VOVtxGHcfgVF7UofToSThYkMV+BytPHe9UCrUrvzkLHNkpcBs9fw1hs6QBDoQky5FSLycwQ4B1cxwrK6CfbBt/z1HA0HbIrsxKpAk50ZbTuUtBUUWp7gys1V+OY4HFAeRj+zuYaR7S6+HYCCYYXa3ImpU8WY5BMtieMF4t7ewB8uuBWoO9hsT8IEuBGJuRKjx278w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w95He89+nS3O0/n7azFj8FLXOgq0kCSQDRtJPpzHt7I=;
 b=c+NzXSKYMDaqtmTrbVqOTYTglbTuXnAcPVBg6Avkf4Y55EOOpHIaGTR2USpvlxhEhd8koJ18jRkybD4HNHQanEjrAxNGmHOFjbUu/Jh7qOt5Hm/uPFivaCMz+fV+nT1P/j8ixp1xnKETuib4oEOyySSHJJz/I2g/yLGBTfNCNOlxM+o5bli3Ra22HdtQ4iXAwAwU8lQQ2aiHpM0OsPScmmOxeWxdwD+03MW8o1XD113fl1PFV2RHaYTYqP1+yPLkRAdnqv/Eg790Xfx/akB1CsXhKK7kWwfLESHvSGG7QRF0Qe6PwKfxLkDJ3XPYYhFqkkOZDT39nbg7w1t1SMzxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0552.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:13::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 01:00:20 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:00:20 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v14,RESEND 12/22] PCI: microchip: Add request_event_irq() callback function
Date: Mon, 29 Jan 2024 08:59:57 +0800
Message-Id: <20240129005958.3613-11-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129005958.3613-1-minda.chen@starfivetech.com>
References: <20240129005958.3613-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::19) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0552:EE_
X-MS-Office365-Filtering-Correlation-Id: f213fb1d-c271-4683-494a-08dc2065aa54
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8cM2NAM5gFkEHpJOp9ipX068EK9e5N11g9lnpJfbbYjf6/CqPP9ldENAO2vQ2nCb+11xqaeMpSitwBucICib6R0t1nyzmhWmSjR7BT28/2YEmkcUxYjVbnlZzRh6eyAtEbj5h7E31TL6w1apPmsg3FLcuLoDRRD8eos1OIgtnasV9GVi4480ZI7BsLi4qErjOzKhXeSRxvuZ3besjBFXYoSg+ZV0mKfPeZZFXYJPbmWCiNYKv9HuWqAFmTVDPLEzhykrjYg5/yvU6t51m+9kaFyPKaBj21wlcpC0U+2i4fOYxi2QS5B3FF3K0o2foCjs3V5QxPNvujPMxF9aBu80n+X5NNufkxx8Iq20QfKgIUzCCi4QBuQyGr+G6Hpq7kurOa6fog2HVOFrwJTopVb0bZfloGBSMe/9Uz3mNn+4ruXjLzRPAyl8SbHiLNbWQNG0waAZOlvXnRhPnzDl7XlZB165PnPWsMMCLZ6MPvIGbinHFqEzU4j2YmdwZnamAI7QWwmwSV7LYc+FLqKGbnjg8gogUhtG4IbUafm5uoTBPz4z72lJLj7ULzv4BMVyu71D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39830400003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(107886003)(2616005)(1076003)(41300700001)(26005)(41320700001)(40180700001)(40160700002)(38350700005)(508600001)(6666004)(83380400001)(54906003)(52116002)(36756003)(38100700002)(2906002)(66476007)(5660300002)(8936002)(86362001)(66946007)(110136005)(44832011)(4326008)(7416002)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jBiqwpWkEQXWjD6Z9162bgIKC/21e1HwZEjvwUIiGESBZOrhpRQjrPrhqboP?=
 =?us-ascii?Q?g+fCkAX75Z+u3kvXA7xkbl8tOaMmrSsGk5mQONFx0tArprgyt25fKobVP3gC?=
 =?us-ascii?Q?8/FcSj5WxvmAQzdGIGMpyXUmOfQx77uh4btZJaTyEbuppltiSVxbX1xHKLtJ?=
 =?us-ascii?Q?s8kzbfCYFvZVHLr+VLlkhrtO7EQby+Oy5X0rJDjlymDGk4R+l2C8tnXHH5gt?=
 =?us-ascii?Q?7Vl4m+P8ojk9PqJHR2mhpD/eOwluJW+yQfWaOlmct99tF5o9TGnkw/N7NuxN?=
 =?us-ascii?Q?4edw5/Z2dqY7psrAfqq3WcxHWFRllL3U9dnOf5A4LUb8aR7p03lKSdG7Ahfd?=
 =?us-ascii?Q?z0K8+kfFG0j7XG10giP/CWtgsGGhebMakapzmeTpDA4Bi8WDd3dBA2mv2nLI?=
 =?us-ascii?Q?Cs8YICI5oausjMUmsXsnvd3m7IX9vGuIyugouq0SylC5Mrf0PWq2g5mMVt/D?=
 =?us-ascii?Q?M7ROu/iQzHujMi66vGNoQXqvupLEj1tWjbK+NgPgaxdcRkEk5Wo/hXVh7Tmy?=
 =?us-ascii?Q?FHQPK+woj0kFo8d/bHkt03FS/hfuCyoS8hHBjTAiCLIT9G0v+Q0D7VcdTQ5W?=
 =?us-ascii?Q?bbvsI9IcGDgCDWAY/JzNGwK5p09I/e+kZ1f6BNlJVygjEfNAFWqkHsKEdt5Y?=
 =?us-ascii?Q?T5UZO9w99LewLqQSQAg+Pgu3lNkUr72WQtwoGRpocZQLwwNMg1Vyy/8meOJU?=
 =?us-ascii?Q?b/Gs7oirg0kEl7qhVZsWw/gRsg1AsjmON0mDlLSwizJqKjeS69uyWn50faq5?=
 =?us-ascii?Q?arPCfdXL6eabIxDvsa+fMMejGZafdylm9ZzHhvQJZEl4bFmDm05TecfBzjjB?=
 =?us-ascii?Q?ax+5dCSq6m+wkyAV4T6SlLjpJAtzGNwH5kjTMGDc3c4YIYmnM7Jh1QlSMqOb?=
 =?us-ascii?Q?oU0On1Clc508skDuqvWmg+qd1No1iLDR5gjkZLd6T02Bu7+KpGY6fokHEGZR?=
 =?us-ascii?Q?vJ2c8ccbqHd/DW7HtLc6ye5+ZEA/u3URBFaVgtL0BGmF7YsG68NoFbqBXr2z?=
 =?us-ascii?Q?apLMbTZDdj136Bjozu3nbYvkdSav0tKjqoCbbdoBe0mU/UKdFInK6aJ+q/l/?=
 =?us-ascii?Q?tyWMDAtZjyDGGHSDQhpLgztH/r562vi463f23hD2wD0R8RN0jl15/HaDOnue?=
 =?us-ascii?Q?qB9lDP9o7v4DcE5uleStKv5Jr1TPpQDgiDyFQWkvqkI7W/EC/rOYJS2abAJC?=
 =?us-ascii?Q?v7o8Wkna8/OPOdvIKVM8dtTbzrEM99hLL2x0GRoRICxzSobcRjHimQSVOJSv?=
 =?us-ascii?Q?CVWjDnJvLxyV+70Z3W+qzFaWUylWYeOpTg/aLwm63x2s0/8Sbq6cvjl+x64Y?=
 =?us-ascii?Q?NJ6FkMdxIJW1LDgbO7UR9yBUUPm5XJbdlV7hS65dShaY1jQNDXlfrpm7aXkn?=
 =?us-ascii?Q?BlH2oeOtmW+zluTgaRIWSqgtw3itF/0jLEu/JNew8bLo7/xNG3dnwhUaZTvw?=
 =?us-ascii?Q?SubzBnkuIh4MSDKYc14YsgfEYXWGJ0/2+9wmlCzCpv08TJDHZAtnszPO2pLA?=
 =?us-ascii?Q?fBFWfRJQTvylYsDQuLXr3jUXquzOV3g9SZaFxf9//ICsiWOKqugXq6NE+/HU?=
 =?us-ascii?Q?4ROH2DCHGgkYQ6SD6Yj2j8dPE9iTr7g4HpIikKe+Yv69/mT76Hf8RaJnETCt?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f213fb1d-c271-4683-494a-08dc2065aa54
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:00:20.2550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atqgE2ZnPGwnkY5gHXIYaasKuv2lL1fjM+z3k7eIWjnBjo49kn90UI/zfBJ81Qx2T8zsmteuJE3c/Fd/lcnUjkzuS9YbXomjwnqMlXrgXnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0552

As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an interrupt
controller. Microchip Polarfire PCIe add some PCIe interrupts base on
PLDA IP interrupt controller.

Microchip Polarfire PCIe additional intrerrupts:
EVENT_PCIE_L2_EXIT
EVENT_PCIE_HOTRST_EXIT
EVENT_PCIE_DLUP_EXIT
EVENT_SEC_TX_RAM_SEC_ERR
EVENT_SEC_RX_RAM_SEC_ERR
....

Both codes of request interrupts and mc_event_handler() contain
additional interrupts symbol names, these can not be re-used. So add a
new plda_event_handler() functions, which implements PLDA interrupt
defalt handler, add request_event_irq() callback function to compat
Microchip Polorfire PCIe additional interrupts.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 31 ++++++++++++++++---
 drivers/pci/controller/plda/pcie-plda.h       |  5 +++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 0a5cd8b214cd..bf5ce33ee275 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -642,6 +642,11 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t plda_event_handler(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
 static void plda_handle_event(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
@@ -803,6 +808,17 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
+static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
+				int event)
+{
+	return devm_request_irq(plda->dev, event_irq, mc_event_handler,
+				0, event_cause[event].sym, plda);
+}
+
+static const struct plda_event mc_event = {
+	.request_event_irq = mc_request_event_irq,
+};
+
 static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
@@ -904,7 +920,9 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
+static int plda_init_interrupts(struct platform_device *pdev,
+				struct plda_pcie_rp *port,
+				const struct plda_event *event)
 {
 	struct device *dev = &pdev->dev;
 	int irq;
@@ -928,8 +946,13 @@ static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_r
 			return -ENXIO;
 		}
 
-		ret = devm_request_irq(dev, event_irq, mc_event_handler,
-				       0, event_cause[i].sym, port);
+		if (event->request_event_irq)
+			ret = event->request_event_irq(port, event_irq, i);
+		else
+			ret = devm_request_irq(dev, event_irq,
+					       plda_event_handler,
+					       0, NULL, port);
+
 		if (ret) {
 			dev_err(dev, "failed to request IRQ %d\n", event_irq);
 			return ret;
@@ -983,7 +1006,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 		return ret;
 
 	/* Address translation is up; safe to enable interrupts */
-	ret = plda_init_interrupts(pdev, &port->plda);
+	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index f7e900b395f8..935686bba837 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -127,6 +127,11 @@ struct plda_pcie_rp {
 	int num_events;
 };
 
+struct plda_event {
+	int (*request_event_irq)(struct plda_pcie_rp *pcie,
+				 int event_irq, int event);
+};
+
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size);
-- 
2.17.1


