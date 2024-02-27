Return-Path: <linux-pci+bounces-4112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C07F868E6E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A72B286CF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9B3139592;
	Tue, 27 Feb 2024 11:10:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2106.outbound.protection.partner.outlook.cn [139.219.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A880139589;
	Tue, 27 Feb 2024 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032206; cv=fail; b=lzV+nJTBEvgIY8FqoWBSFWyHaDsRtHa/DFo8bv+hZDBNPoVEq42Oqh/uvibzoc5kQaDMo0+B5YO6MgKMy17uddyWiXVZ96WDqSIIwMG4yOQDmyg/3iiuqFHR0AKfGjpqL+hVaV1ah6XtABWEfiqNWiI4ZU6vrNsfxDQ/1/EN2SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032206; c=relaxed/simple;
	bh=Jr9GqF0VedirT+pLXfWGwtgNFSVamL87RXSJnlSv/Rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ETdsDDQO/augOou2KDLbxP71WBzLAaN25MZYuhP2GH/u1vVN8wbxf/qEn5kSscUr+jxcCK36C+tvFljAHaaBbypaNzIdtCJwuSz4ZC+IS+Iqeybvksmg3C4EF2sWM5yOHbtFoA8Nl8x7ou3tGgffTkg0G19ZdWQYZa8ecYOOZf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJZCHK6KvD3waTAjQRJ08VH8/hpSzf8ggUUYsBZVHqJ6JRJAn7yem39uuQNyxfzV/ZomUOvU6ssdM5Ls/xP6ijbH7Hk3Adv3GM79c0fxw9dtoqyBZt1yS1zWoqVrboI68EVZ3lC3NgNhOP0T6wTRc+gJ+17gcMcXUNClRe9kFIMm/pxKYOWBGUHYmCgX9j8v7aVZtPxCnw+j1zX8itkvss70tu3+RBkVd1CVkvYMd6GBM/ffe+EVS6+3y+uETH/vXSHPWzoKk2O/BV9qPCRBDSHD+oaEZweFCYD8vYOMnfgPPdj87FUtj6pWaKdnzRlrhV1BzIP5rg+aNydJ0bo/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx5Yb/mH7vkRlelY89RpGgyd0V1vSjgcQXjlTiRgDK8=;
 b=GZA7Uc0L6WXhi3s0qH88IzlhmVOrga6+vk8EMAfOTY4RgWdvAFItwl5F7g4sVNGf3ch7ZXsO03MOooWrltZth6bhSCvQ8TZ/hGXd0YLOch9P1h9+HoKOyitJ2n/H3qAAVQovKS+Mewe9CVaWiF5GtIQkeWKG9xoX+BFgCeGOV8qmRvZJKcWqwBRyPdJBbOlGJoIj+PVBxxbIPMxTo6gfChQ2077TeV12KXP9SJwtL2lb4SYBX2giBKoRtcyB1OIIH1m40LF/ykM6HLPMwRWXEai3+dcRgIWN0Ff1UzvQ6orbcOSC1KF9pMcgIwoYc5fFkOfLhB9udmD23MrFFq1i+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:33 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:33 +0000
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
Subject: [PATCH v15,RESEND 04/23] PCI: microchip: Add bridge_addr field to struct mc_pcie
Date: Tue, 27 Feb 2024 18:35:03 +0800
Message-Id: <20240227103522.80915-5-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_
X-MS-Office365-Filtering-Correlation-Id: c1665225-4f7c-4e08-6b3d-08dc377fd3fe
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SPl9KL2pN0VV1GORtBctEBmiHcEHjSktz6i+GUnmD1HcCd0I113RCWRwa3LpdmYyVCHW7CnKET1Rxs/SPJTQKtopGQGdWgeetPD/+46dZSb+IvgDROHR7MESbVHAL5otm0zn4wDriA/VfQkLHQ8fCsGXgClUhOgtqkHHHXEYWsFy1yZ9ctBBE30/ULBUcl6ag59KBi2aURvKkKEA1hrVVZFdVMJai7bhNKYPa9Gf253wO5pQww8PuHlHTBN5FCclnno/Iw90cqQNgA3MlD7OGjUFsoAga4E99ZVeB0M9gPxW7/B/aQOpkgLSxhP6gisJHHf68UUvXU+w6H3jPMS8PcHtjVkbHpjGRQcC0HBslvfaUTeP3qljx+12QKz7ke3JiIu8uWOyGZaAPr9yIzBM5RCm4fEF8VagEPVS4TL4W/dCVjvIJ0G1HgNKcQr0diPQiX7mhbhmmKTktlK1zYDt2lu+/EW/gfjqkNg5fAas3eosgyk35avtFGXLF8HUqDtn54OF4Lj0rd/AYTQ/7GQY59qkLPCjVZtaXo/Jxiybkxso6YYI+f6UGTfuaPR5wU8GlJjJWSL+/xJ3P2QeO7updi3jQ0uorrMHPfJiMFuxswxo6qiaMumJThd/MEKjnQZH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mms9U2L2q6vhuO9IEXPR7mJI0IlA/KWHQiiJxvwoQw6rmRwq84Fxiv9SilxV?=
 =?us-ascii?Q?wjjyebdNJj4dMLiKyVj/9M/8r5LBPy1KNxnYcrMazTKeDmrdVhW1N3C3F2Nc?=
 =?us-ascii?Q?Rdz+TBG9Y+RCJzNhFU7/J0iiXjTWYUZlGYLFwEdCDkEnhZecGvz8+ub4vvcr?=
 =?us-ascii?Q?jHsL3SJbN30CReXRlcOtuc7ljuhiZlEbugzEFZEPlLsjvi/lUpJuzgHd1LLf?=
 =?us-ascii?Q?/dRVzSbVGl0VJ+iSeajRdHxheu6XqVwWV7da5ZQhmMgIYyU6o+bfqyil8o2f?=
 =?us-ascii?Q?n+Klkju9IS1jBxDaIhoK9r4bGC85nbF3BxTqc0cMOIOZ7hd2krdcmKdIqBBX?=
 =?us-ascii?Q?iJAIeXb/0qOdngbH1OEEnkfMjFLHJsq0AQx2p6rGCkk2ufeM8wJB1McSgdcR?=
 =?us-ascii?Q?caj4Nokn2X0qcAVPd2qbROXAfa2M/+3NXVliPUM8ZOVrIMHEm9T0i36rH9CM?=
 =?us-ascii?Q?AHbzEzSZ77ER+ySb2Pvy3COP9VE/iFsOFhxBbiRutZYuBmWR2qmGCQ/4jZ1u?=
 =?us-ascii?Q?fttTnr94PYci/E/MhkzeGOUXW4bBALyaM90aOyu81aQbaF8ejFSm7qEDFqUj?=
 =?us-ascii?Q?Xw46YZKhUaEThjfkLv5JddDxrmowObpFIBSWUUnwzepcSQqXF5qN+2kkIwVd?=
 =?us-ascii?Q?snfco0jOGNzZQYJRdrY3xdys6L5mkEmQhzRyw8ulOfej4x/ZcN8CtZXar5QK?=
 =?us-ascii?Q?7XSA7RIhks7hVoSOAshYclfsCGN308SmAksPlFh0AUmucs+CUlewbGTyaA61?=
 =?us-ascii?Q?/JrMfO10f6uaXUerk/iIJSAYdpVa8Rdm5ttYJLYujWAyhSxThOG0Hd0g4OSZ?=
 =?us-ascii?Q?ABCl7NXa9Gs29AN4egBr2RDxxCqBfABBWvFxyuxtvuKI0fu4iSMgoM5vBKvz?=
 =?us-ascii?Q?uCAkfvllKISCjzSVCPgMPZkM3j5OtHbAsFhQWnvgbmvdXhvBO/bjlO4FoKLK?=
 =?us-ascii?Q?KQf7YZFsc6z/Y2QTCZv03QKjzzl7NCNUEcby4svD/Cd0slqo0J6K2L7JKaPK?=
 =?us-ascii?Q?7k1HPD72Mu5Q+zbrRYNi13Z1k3kpHo9aEBfN1yI9ofpoBlT91fQ4ZxvHXD/C?=
 =?us-ascii?Q?+OLKSzQMo16HktkWWx0NKk/WMAjdkeYZoeKXYV3DqZraHBOHFD1FaKg9EiI3?=
 =?us-ascii?Q?iE9yvNKkzKK6VRBuea7XOFUsGkZ/5GAdcFcv+C1kYCG8dpOd8eQn25ez99f4?=
 =?us-ascii?Q?M4nfw1MU+WAg9t6MIhYvm6zRUxt85z1HuAkLAFcRTNsNixa56zp/sv2uPxXA?=
 =?us-ascii?Q?dECjbpKHJwwMTchm8fr6ChMztzTra8Ux5DQVlPSIN1Ru4V3Ka5a9BrgpgCMM?=
 =?us-ascii?Q?FrVcxtJsVZJ7iJRMrKIofrAgEWT/HQGxWJ573iBKJgRrUdUGtJYAsIr2WQLi?=
 =?us-ascii?Q?IPR9NAPzyaUfyDstF4aeJz7lkNydOs5+zTxNShs683mlqaS+8tXvxMEeeTLo?=
 =?us-ascii?Q?HlcP8shAr3kQzN1WcOW2ghu+LFR4pPhNKYfW85lK7y+cM8pUUugD+b91fr0B?=
 =?us-ascii?Q?37iis9MbhbbUxMvl5LEV4bcjpJFtI9t/vLSF/VayYWNRf21gTzdtoPv3RlDo?=
 =?us-ascii?Q?s5dQCLdM7b9uwWfzU3NkGALNKQS/bRTcjKwIjxdLVii6KkzekNX7G2KjZiaX?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1665225-4f7c-4e08-6b3d-08dc377fd3fe
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:33.8142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6r/wcpTI4z263xNIiJSuYI1UX8kCx9nfCyrYcGGJE1WpQDs/iNFTnjPF3MQO/LYRGI9oPiCAoLO5mndspCF4lPDk0+XlIdRI53fl1pQuAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0863

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


