Return-Path: <linux-pci+bounces-4096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064B1868DB2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C97C1F2341B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399913849B;
	Tue, 27 Feb 2024 10:36:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2118.outbound.protection.partner.outlook.cn [139.219.17.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CCFF9D6;
	Tue, 27 Feb 2024 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030217; cv=fail; b=QW1GVhnSk3IM6bqaDicCUdMSAfLCrDxpGjir6U83r4Ov1ZxcSUZ1cI1itE4C5SLU1dhF8rJEB5DM+GqzAnXFqKSZ/UkQbRHzIYFfIqfEAh0JIBsjM8D+ef2kB9kIB9Z8Y2hdvsta1ShKKrXGsh0ax71qgu2UojqPTHQQfe8hS8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030217; c=relaxed/simple;
	bh=3F1/lsndcv+DJDM6HO84U9/NvVXlDlcfqYIdTg7n4cM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLQ+tvXBNk//6L/3mjXzvVYwp6il9V8EnNPdzsh3eh4rTb5Y+qJY1GAO1LC+iDsPM6xtSJefbcuxZ5VUw1FUWrDUzspwFiO9WYdKrViDUFC60O0qFtkEzCGlL43QZEm4iJVQv76jtqd6MBJuBy9yWks0ypoJko0NmC19qiDl8kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WERWLyAOoUD9L/QzW5G9RB55b2aU2aiigzVPuISEJ/6bSvnw978LAKlyyGxLEkc91raqqbm7HkNWcqHgr/MkqJtagWnEOxOp0SdjKBrcu8ia2sM6M1JP+X90lmG75Rb0ngtpK6K40TV/vHsgvFlPlSAvcpUV9qaoYJH+yrN5qieypPvHgF3J6er1Mqqy43vob5oKx79q69LU6MXEIiDv1ycX7I/FmYRheu06vDwuyAuVEAhNDZYPYpDGQBnpOjk6n6rGQZ68tpZ4NkMdybhw1Nyi/nWOyR1Z8KhEmEeaoHykjLGBVZWVPUN3/3C1uOC3kBbHNFARI0LSSO7J9dD+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbCfwxEQCLcUcJNBQ9JZ4TkiYpLKqulShZ9N39mSbQk=;
 b=UtES4ko4qfNYO2WcySjGP6twVFZK3zz4p8iqLitckeWNZrNMQB31eJxZ4sIVa47xSsyPaTB1buKZLIPP77v2dMxY17PBOG98VGLXdYi41x1CBQ0Sq/Ww3k/6tePsveRcGpavcz4PTYDNIdfo0hXMJj+SKs13726jD2u64HzT/18hHNrUhynELUnpQhoURIwXbZlX72gyVXGXVwxb7ZLfg3RmocsCzMY+1pCafuE4kXpDvhtBw0VCb5/Hjd9VZfjhSSxtl6B3EAlTUilwJ+eNB93fkvtb2m/VlXDyHlEbyKEYDwKz4vPXhiOXZ2C6Xl6gWaj63iQSr4sPWUXdqc3TVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:42 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:42 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH v15,RESEND 12/23] PCI: microchip: Add request_event_irq() callback function
Date: Tue, 27 Feb 2024 18:35:11 +0800
Message-Id: <20240227103522.80915-13-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227103522.80915-1-minda.chen@starfivetech.com>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 259b7f29-f9f1-48b0-77f3-08dc377fd916
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/niWP6ebgDA9VhfHwEM9UzB6Hzx1hDWZ4YvXBnilJAAXVVqonhX9AgiQeam3Pa2pek6/5IgRakUs1Bi0IETtQnpucxlCn4A0xIiREzQQ4zFYlIJcLHC4qWXXWWhx+NRn98JqTzYpEmEOYF76fMtFTZOz9XFGV0WvvjsVNHyERUNUv+yjCFgfe1GejVzPFMS3jHjQoV9DLcYLSrRqTaDyNzc/aW/ipkD+Kn3K7mgH6UWWk8+YwghI7Eb/2+0dGIqkc3LbC+ucAA/tSIUGuO36pe3Ugd1LIEgzVMckRZ8HAEwgJvVXEJT6aiiFruv8fbACmuJolCqtz2KeyUUtG8GHJTxPYOFDNmxBlwwXkDe6qz5uJul0f5wY3KJ3twcNhVRshTjpvmV/9SwqmclLXmh3fttjarHz/DyByjdKrFoO7A5/qfEcxrAQ7SiiULbKq7YILTOCF2Re7mf9vGhblPZ514Av2MUgwhxE2VIrEXne8JB4x1PemqYE7LMmDWCyfaOagzXf2dCnsUpgNiUshg+GxxRHw01PShzywLfPV4L9lzQFPIQwtXgy6w8huXX9kTz6ls+DHPlxPPvisq6vi9blDFWFRirFEGcEyLW6855e/jHvtSPQtQpZsfzNQPdcG0rX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XlIH4Cb+R2red8fTVaAarHKKXp6nv8kUsr0kpGEXSo56pX33KGqHB2AjvEHZ?=
 =?us-ascii?Q?/nkxr6BvQtcXWugAkXktVWsdF6ueDQwpQJRu18u358aRRoz+MC7i5KbQenzy?=
 =?us-ascii?Q?FaqZU4Ks5a0PilCK/8ILJ8LWBM24K8BJ9MNzdeIESBFp2mlUuJPx93Yb4L1k?=
 =?us-ascii?Q?a7UBtvN+cQG4kasCZYOzgnxZO6HzMWrHz0G0qxcjXcGr2EATLb8TXXtSVLZE?=
 =?us-ascii?Q?wRwnU7cNI9wPqrIp3Cto/ihG55a/PNCG8Kjt8X6WAQ/S3zECAQrTM8QgN0mj?=
 =?us-ascii?Q?1n0GltwgCPVZKD8pZsWG2EwwoH315HqhDpzW/sTzXFyQ8BsmOlTO9vx9uxYE?=
 =?us-ascii?Q?gnS+2pM1gE5CP9jROU9mnkTvu8BSMV/27esjw+GtKqEkjmHQLRmfnxizaZ61?=
 =?us-ascii?Q?Q0MNr2XjGWaz08th58jvG+QpYe52qHaL27zaorRAJX4Hq0p5sbdLPpCAjuYf?=
 =?us-ascii?Q?A4xDQ8tsCgOWjxdgqBUySrP6MQLFioJ6UC5MgRKs88s1KGegewHPikcC0pdd?=
 =?us-ascii?Q?zYIebcTKESad8WvNMr0z9GCmX+/LY3UdsSi7zgAhSZ5HJblo+7g12TWng4y/?=
 =?us-ascii?Q?s+wgMyYLb8zdcICr3Q6BegKHVVsZIALVVJzLpmf+5nsm7Y71jvzoh/Hfc/Ca?=
 =?us-ascii?Q?2259HnCaLQ5LGsmOY68lohuzB3Jx23yDdB5OmUdaVydg51EYcmaBq/sL2i2I?=
 =?us-ascii?Q?Q+HOPYw55oPAKV0Q4TqrWg9Ul+cxep9JQOd7uH3eF9289L3BrdsSz7aBQfL7?=
 =?us-ascii?Q?Z0nhCkCnyWfxx209CMACc356JflaIFbrRJZl6jjylaCHto9naDBNe/crwdlV?=
 =?us-ascii?Q?qDAc0fed6WIyI64jlCcuxspG94UUZcCB7CJ+skCY0PcQqYPKHKHBpHz+7DAq?=
 =?us-ascii?Q?EFiiTKkp/jR2Spsoj1F7JwAP0D3PKQi+w83a7RLVfBi2+pmEXHcTn5kHs5OO?=
 =?us-ascii?Q?g5wrKTtw1iNPfORgCWKtfjXihpwuxqZRP/xYDmTBGop8WldLZKlDE6mN9Hnn?=
 =?us-ascii?Q?1UtMDg5VQAzJMQzsWITs+ANmQ4nDmXqRIE/vozNXGjCa5Utci9O1ZoFwxuHe?=
 =?us-ascii?Q?KeBADP6bwxE7BGZOx8BXc4EbOnmmCGmTrBypkV7xT7yRWafRx2/Vj1mZsOvo?=
 =?us-ascii?Q?f+a4o8X1Ccpvju8mxP3geISQ0cxEEc2yAyiSjtBpRculBtgN5I+w8yBJK/Dm?=
 =?us-ascii?Q?UeRV8QsJCabdQDrug5h+Y3dHGRf6pJKDdMg7CwUOP17WJrFEGhBFmuaJ5KfE?=
 =?us-ascii?Q?M9f86r6gorxP3ZyrZD+IaW/BPWEux7QmELiCvR/XVa2G8AIcFl9H7aE7TPHk?=
 =?us-ascii?Q?G2n8WYhs6BwIHV0jtPP9KcHtE17G8oKAhGTTsKVUUrAL+gnRM3qEXGeDVEpP?=
 =?us-ascii?Q?T/3Y6Sqbe/YH0oDsv+iHcjR0wAfMaJ0bcbIqYCfy4x+wZTgPbrRPNpP5PwIk?=
 =?us-ascii?Q?xlSWKQjBWN3zTiTmKDoSiXPaL7ZdnkLKgKBeruXvTEAKYjctZRwcdwwpdnup?=
 =?us-ascii?Q?lI4GBRnOr2phgyvzi5Mt9BWiw/4D7urv0wr+Beet7yZfgQ+RGNRyHrJZExhh?=
 =?us-ascii?Q?OBE14jksZ6G1LNNIUt53pr4zSHu0jEQkg8b85Wq2V5iCq1xDjbvXaabL+9Fc?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259b7f29-f9f1-48b0-77f3-08dc377fd916
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:42.3360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V43vIwjySZu5p0/w9UFlBF/3aaQeng3GfNAkAlTeD7U2tt+akIceNRQFpNg3EO3SJrnmJz/tUeo3eeaSZQwvjEsIVMKm+kmmuHwTnJkWOrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an interrupt
controller. Microchip Polarfire PCIe add some PCIe interrupts base on
PLDA IP interrupt controller.

Microchip Polarfire PCIe additional intrerrupts:
(defined in drivers/pci/controller/plda/pcie-microchip-host.c)
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


