Return-Path: <linux-pci+bounces-3673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C393885964A
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9A3B2122B
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22358433A6;
	Sun, 18 Feb 2024 10:33:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2100.outbound.protection.partner.outlook.cn [139.219.17.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DEEAF1;
	Sun, 18 Feb 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252415; cv=fail; b=ANsq0KqJxE3cAZvpiz7pKNo03joZr9ZywZli5PT31PdCFYRr12HrzbtcpR58CWnqe5JpR415R2NDSr1cXg03OFZ0NS/rrP3hqswFomI3cEVikU7WOL/Xi+0Bofw4iMy+9SA08/+Mz4CkcYi2+rBwT3Mwt0zuO/iU+5pHwCTTfRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252415; c=relaxed/simple;
	bh=Jr9GqF0VedirT+pLXfWGwtgNFSVamL87RXSJnlSv/Rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Po5La9V7LnH/AQatonR7cCrECav3N9e8twn9ged74E3sEreO/emrHX7kB7pzYQoEUquox8VkhQ+bvyRvEcvGEUYBqMkSboKJ3p/1Cl14lYVQt9+kyrwDKiOGeX38g1CkZP+wJKcG9PRt/Zw7uo18KZVOh8UChw29Aet20TAur/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcADFrQZ+WcRHciEN3UZh/QjaBbp/FsKhzrVFR3QCz0lBszJMxkdLbCkI2YAEayCIv+gM4eTrosRAWGoYfcNZJDQPVOzD3/Wu2oGvdWFlPNu2ByKSn36dzcgVJeS5uTds+a2R4n3RW07tQzG2eC/0KP5uranYwD9V02RoPyS0I1AWityfiw61QGkJ97MvMLWrictRquCIsKU90x4dn5b04TrOMFMgKiqbg1QN2cf4Zjo0qcGHT3IS3xKYa5mEvHPopmAsQSL0tpoYpbYOE03spnwWxoRra7w0EScKwjIFr82JbnkZR1oYY1QIhw/PaV6BQ5lcn2YVl6tvwDdRIZ6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx5Yb/mH7vkRlelY89RpGgyd0V1vSjgcQXjlTiRgDK8=;
 b=nCVJZswY1SVyvVcESOef9Z1i6L2oO+jqPVuLDDNOYe4U/k+f0QIPP9w1u1Y2lMtXu9YyEpTRn4AifAlxI6fGrPwJ/uG7Q1NyIij8MQc8kqWYTRSbz3m7ExQHfZ78TIQvoZHZjNb8xu/4834YhpcHsL7NM7Ka78INK9TXZnn8mQtyqq1JyOXLs5Q4elSr38Q87PVeJI8UMeHTn1pSEWq6F646gRvO6lS3j57zk0qyfmzSL2ZIiS94PeEvcx0UnAYt6DlyPR/wlRcXE5jqz1v2n5eACo+mmYZgCr2U6262mfbEMmw8A0wurEdBDBHrt4I0qx9PHhzSAuWwrdMeU522/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:17:40 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:17:40 +0000
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
Subject: [PATCH v15 04/23] PCI: microchip: Add bridge_addr field to struct mc_pcie
Date: Sun, 18 Feb 2024 18:17:23 +0800
Message-Id: <20240218101732.113397-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240218101732.113397-1-minda.chen@starfivetech.com>
References: <20240218101732.113397-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::31) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: a964eec0-b5f8-45f3-5a08-08dc306ad6ab
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tNa8Z291KrHrTJJzq7fxQ8Cd4fisuO9gZI7jaqqpMzm/Qns1Do1UzXEYyxGTLwlhMhcNqxnYkZEZmKgyZ3EX6lnJBb+aPK3mNLn0+8uWOKa54UKpsOn8PSlu4Vw76iM0hp5+DHp/2bPUlnDa8RdLgSiGu6yszc3G45yWiElcyP+vJXvE8mE/7Vrwx1uBf65vBwncBuymg0ej5V6LOXmWbRK1f29V3lCcocstJZ41CH5oot6PyztHq5dbmvX2PqY4KAdm/3K3FOnXsqOjFrJ9G3cDNCBhZEYzKSeqrQBnwEUXhn6aqSM1yp1VpsDelw6JXvY0BYnjQA8MAkO0jx2R38VlZ34m/0UD+xxgpdA/GsA/y3ODRTe5CmKAvB7OOvIOyfb2wuLWL8m85G30ES77E9fD5OWRXmkOt6er/THpg5AyD/cDBT3Yo2yEuFNzptdylh1ZTPr+AxiAzwlzvURvJ6MzArFLb01H5IQMnqw0jReWGVDRQEGluE9RX2HqzdIzxYOb9K3QXXaO849FSkqKUDDEN/2RNyjcmI4RvHAfIvtmRUiDEhQ2YWdJOOBSWLEo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(7416002)(44832011)(41320700001)(26005)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qEM4QqnOgt1MwuNUc2/pdYRff4pnK8J6oJh6+nDAexRwTg2gzvdTZkc38tQy?=
 =?us-ascii?Q?xXFRzuEzjhlLKm9Gq44xOzVqXKka3pls2J8/Zp8Go017a4GzOM/r26gzTwqz?=
 =?us-ascii?Q?9QnRih9QzpRrGbKFALr5lM+lTmyBDVwEPaO0/H08RTrCBq6apdMZmY35d4Z7?=
 =?us-ascii?Q?GvyFIlP5GKhHrYIc077t/Tr1n0pJ1+j/fQ5CQBNUohd9+qyiiTriixTm6qMP?=
 =?us-ascii?Q?WG4ibOxRWzIBvwIusWni0JLkjPd9gxD3kexzVXxxUA18SnYbCMn7ehpY+tAL?=
 =?us-ascii?Q?W3vvdn2iuJwGh/Ymd7O/0fxP9UjdHwQW9/fu8ADC9WPuNn5izAm1I9a9PXlR?=
 =?us-ascii?Q?ZARSAQJNlbU9QKvOzm62LaS40bvOk0851bQVN2ItJIcKPsq8RpQTmnRiIP3K?=
 =?us-ascii?Q?NsWDa+OyGH5AyYi/wioXF5ro/Rkz2C6WXf83WheYYvxyIwbhWFwKD0yigYj1?=
 =?us-ascii?Q?kZrsbCv3qSZDKKzYxHEUuDHCf4ECFtwxoVL2L0EfenUenBmrud9HuONYJsWo?=
 =?us-ascii?Q?uCR4cAvHY6fV2GrRS5UvK+ZpNGyJ4qZC8QuuvWyJZ52m304+uBoUQZB+qrQL?=
 =?us-ascii?Q?YFyeZiGcW1blheF+1jVSACnpK+NtJJXBk80XbkG3fVCxqVAXnUph4BYmZ69X?=
 =?us-ascii?Q?2ZxOTkHoCY1SjmyU1QbltkBVoT5wXWnotOXfPc6UMSZ7oBGkFl6T6+/dNqPI?=
 =?us-ascii?Q?scqzKjX5FPJ7RjoQqAnw4jAsMOWYIdgpLkSPKt1+PDaP559wxlDHMHLnpHfe?=
 =?us-ascii?Q?ZpedWwnZp0snSi3FieaO9+Y9whdzBvmQfzr/YA8Ade8Oxitk5CtfP6OWAkln?=
 =?us-ascii?Q?W1Iw5p4XQQV467Wp8ChGQrEf+65ppxqJ32J39F1KyO6EdrZk0dB8M3Isx9sc?=
 =?us-ascii?Q?Bwr7BpNiu/4+6bxRLAh50BogKyjsbASL4wbVhSzwE68L2yIJAR6qbVXlIOhu?=
 =?us-ascii?Q?FMt1TNVJOld8EpU/M8eN+jfScyRJ/WV2oyqRXlmJaSa5PvN6hMNrXoKfSmJW?=
 =?us-ascii?Q?K6rJn1TvW7LYuyHAPfly3hozFCyxgxGieJWJM34l/+ZWyObtTp88Tyu2HPfy?=
 =?us-ascii?Q?biD/Uw/ish1Ofg/2J4Y381yXB7TYBeSJhGE62mmlQ+Jzwe95ThOcgdp8jzfd?=
 =?us-ascii?Q?Mtct8TbH0ctTyHmB3/MNLRWjsl8+IBFMDLJOnumoXj/5Hxr06J7I+lyiiLe/?=
 =?us-ascii?Q?eospUhiOgqgFjqQWMZlb9ndff/u1J/ZEjTMHEyA02+A7CnC+sreloS/JFibT?=
 =?us-ascii?Q?17eLBddcVBdjUJDSgdLiiDwdzlrgg8GqNyAttzoNpujQWN46ObopVgFp6tfK?=
 =?us-ascii?Q?q09e+0RYnGCOp3tczRYahVwGRmpqW80VHabfdXWLb6tTzva5YGDEV29Sm3uP?=
 =?us-ascii?Q?TdcsRhLZdzKwhllQ5upaDTBOGb1BpmGvRHDLLqpVE94l559d5KttUonkPaR9?=
 =?us-ascii?Q?st9R2IyVFCfir/dfFT06+8JIAxhdZHh4D7J4VJzTSTt8Qepg9v5e3R6CcB9J?=
 =?us-ascii?Q?XfifsqT4CCBXwwwhQdafpiiawphrywg73huPuj29+L9LokEImD8X3CcnlrNq?=
 =?us-ascii?Q?vZGL7EDR0RIBleJ62yPl63cMZ4iTsMtEE+cXbJAB8IblNSFfUuCIYxbutS5f?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a964eec0-b5f8-45f3-5a08-08dc306ad6ab
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:17:40.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45LIfPssovXV6GHQGSnKFn5Eulqcu4seNU8HfHQGO8lfA6xxS0Do9btkoKUeau/8ly2gnZoSvE5riwT4EuH/FVvncjiB22C4rr/myyO1hCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

For bridge address base is common PLDA field, Add this to struct mc_pcie
first.

INTx and MSI codes interrupts codes will get the bridge base address from
port->bridge_addr. These codes will be changed to common codes.
axi_base_addr is Microchip its own data.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index d9030d550482..c55ede80a6d0 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -195,6 +195,7 @@ struct mc_pcie {
 	struct irq_domain *event_domain;
 	raw_spinlock_t lock;
 	struct mc_msi msi;
+	void __iomem *bridge_addr;
 };
 
 struct cause {
@@ -339,8 +340,7 @@ static void mc_handle_msi(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct device *dev = port->dev;
 	struct mc_msi *msi = &port->msi;
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long status;
 	u32 bit;
 	int ret;
@@ -365,8 +365,7 @@ static void mc_handle_msi(struct irq_desc *desc)
 static void mc_msi_bottom_irq_ack(struct irq_data *data)
 {
 	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	u32 bitpos = data->hwirq;
 
 	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
@@ -488,8 +487,7 @@ static void mc_handle_intx(struct irq_desc *desc)
 	struct mc_pcie *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct device *dev = port->dev;
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long status;
 	u32 bit;
 	int ret;
@@ -514,8 +512,7 @@ static void mc_handle_intx(struct irq_desc *desc)
 static void mc_ack_intx_irq(struct irq_data *data)
 {
 	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
 
 	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
@@ -524,8 +521,7 @@ static void mc_ack_intx_irq(struct irq_data *data)
 static void mc_mask_intx_irq(struct irq_data *data)
 {
 	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long flags;
 	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
 	u32 val;
@@ -540,8 +536,7 @@ static void mc_mask_intx_irq(struct irq_data *data)
 static void mc_unmask_intx_irq(struct irq_data *data)
 {
 	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long flags;
 	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
 	u32 val;
@@ -896,8 +891,7 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 static int mc_pcie_setup_windows(struct platform_device *pdev,
 				 struct mc_pcie *port)
 {
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	struct resource_entry *entry;
 	u64 pci_addr;
@@ -1081,6 +1075,7 @@ static int mc_host_probe(struct platform_device *pdev)
 	mc_disable_interrupts(port);
 
 	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	port->bridge_addr = bridge_base_addr;
 
 	/* Allow enabling MSI by disabling MSI-X */
 	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
-- 
2.17.1


