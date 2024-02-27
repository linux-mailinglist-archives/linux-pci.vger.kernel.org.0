Return-Path: <linux-pci+bounces-4114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AF7868E73
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DC31C254F2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155681386CB;
	Tue, 27 Feb 2024 11:11:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2A138480;
	Tue, 27 Feb 2024 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032266; cv=fail; b=Bl1UC50ZQRhIUFm8DBj+C885KirEFR1/MbidnqY/7hb4aGwR0QE1FUSYFmeYisRWncH2qSRWZVfWfU1fEXu9kEi4dCU/zr3V2jAKLF9TuqLHOUtNKhxsIm3rZynCZGWw+i80IDK2vPP1i+qlTK7thLtsJ3x3KJp3nhmAv/Hey58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032266; c=relaxed/simple;
	bh=a7am6v2xZ49CNXVganzyoymQoDUkzff74c7Tk7OWT8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CXfgJp6kESAPVaH/rwPUaTOMDy/sjccoRvr+9K+SLzcPYF6isXHxyFZ1k1UKK1IaDy1cZjZphtjBE8pCKiArTQObyHbaSR/3iBoRlmaF8kVYE+QhbNWIIjyqdIZln8swIe+cWTEOkzeEV/PDTL9Ek3xb4TnOF3427U2YQhDJmHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfKJXOkxnaBBwQxvuHTgiDhSDLOrKmis+930cMy/HAwTrmYepOvYDRLplcq/3QpXXPUZzXlqRoY1P4PpKV0jA+JYKzb+Os6pR3VJPFvCv+bLT5ZJ42+tcKGBLcS4UiyRvYgPfyI9nZz7CcshPCZLb86QPJUYIkeOVgZU9qdOsyt4TrK0IrSXEtJMrArUEt2F0P0/g9REmAS0/1euuqJWq4wM9lUVZQvwC8XI5ZuxJfu5DtaaHACMY7wAr18pCV6Ai9oVopMX6tSHBS0pqsqhZn+pClXDXZvn0H5vKOiWDUqLgm/XvZenDf5qZ/ANhsOP8NvNf1Bt3hYvEKE9Yos03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka7gQ18jYzgl7s0/ZhcM3h/EGmQOqNnXDwuI+C34490=;
 b=SQOa2s2XwNfDX16uM2FcMxxP6ClwfGwzj2aWeh/EeJNmSv+hED/MVc1sjGTHjwLFH5wpKfrtIFeNht2Haup0VWiCBdPKnWsL5kZOFok+fw5lI8+xX+oyM66fEqowKtA18m7kE/zrNy1eEiWlkZ45xdSxuHPIX3pBe2xaJUNERuoMokXVbAxkd1h9RaPeqDpLmYhZgTZuXNNb5ndl2O/KoVAmH2cHdobr0E9qL+hoFSKKZmK3g/37sQ48KK+U3omW6Y2X5bH52QLGJJG2FG7cN1CUOi7wkiWYZ+J+Kj5y3fC/R3g7WPjUhOhDmIFMsnjk2FxXX7tNshQOVjI8ryDjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:34 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:34 +0000
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
Subject: [PATCH v15,RESEND 05/23] PCI: microchip: Rename two PCIe data structures
Date: Tue, 27 Feb 2024 18:35:04 +0800
Message-Id: <20240227103522.80915-6-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ec120f2-3231-41d0-c358-08dc377fd49b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	32SZWpRh26wbheBdwWSkFhgBqLnoCetRosF9vSnrNMSykMpAyQkUS4F9R+EOzEgqhuFIBEI9CNTftQBivhFQqXRGXyRjXLbf9WtAmtF81VAsmjBBVHqZsT0VHGiv9tuZNmWCFWFmCsy+3tCZWn1jVGwl0sVpOgVpyRuh0cHSOZ5kUGzSluufHDNPYS6ebGX/C3QfmUfYatRnS0gEkvhRxwW2hRsNSqOAfJyvpAdRROxpoN/TF3sevSXDuBJHnjpwt3evslyv3pk3eTowSqIDxy4NTldxq1vbPAVCbFFW3LO6LnqDGxxfn+iUYJz0yNBzRC1wt3n0zcIYeXBTgmMKUdeVefjH6y968WSB4CTIoeR1NoLJcGr2Boq0YGzCgT/nyly6UyJ9Fe5RRv2KynRgMLh00W4ro3se4ZGNvPc2KCHt9Aj/RvD8rc60imZ/4jH6kEgc1Dtmqeez4+6DPrsNN+YuDUVQTY4mHnoKoT2IAwacVDMnasfNFl2VYOGFPsc5IFBFk8r4/zkpj6hpmCr2+vXpC0UdJ9PZx3BoTXl8WbBjIAY6OYh1x8OtrU3h+hOVxbHid+jBvmU06hg5XCOyXqzB8uwLAi1gFD2kVOs+na5RehTqq8AgpJ6444yIYxY1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sqxOYb2M7cdkP5siJXv83ZeERVvfwta7CVA5Gq9MdnoH1oobkGGpiFH42Yk/?=
 =?us-ascii?Q?IAWpYvt/1VLMjPXuQ3Ptz4GnVgyHZjbp1oIRT9BYQdBJsGBpi4/5zYV80oR2?=
 =?us-ascii?Q?lRTQ0q2ihboHo4kpmLm7TZKsuPN90UGDfrTCn2HDtVrmQgpMs1IX5EGmAUbf?=
 =?us-ascii?Q?yhLrBCcWyEKNQBd3YbELjwy9D3QELb60XNx7qBntpMJZ1ieFhbnoDRepQB4t?=
 =?us-ascii?Q?TSXWFnaxk1SqxfJ5OXx/S14qcjy7/a3P9EVRIVU75SNNVh9kRB6o/KYPxMCd?=
 =?us-ascii?Q?4Ue9B8j92pSV8gDbfxLrlC4j6VdDqswOXwn4MmtcUsz1gS7fSsuURTbfM55P?=
 =?us-ascii?Q?EHoO+kRz+FtP4xgCc4Bk5etcNqA7VsiZ/DVWpoLvcJSjnuAJkrWhtfFdpNmy?=
 =?us-ascii?Q?VzzXX+D49zv9JwQSDTEUifztp5XUYWGxhWEA3i6ha8qa/BIXzjJYexNyChGp?=
 =?us-ascii?Q?wWLkZnLyq86JY3OurUiESoO7Cz6Mh1SM85JAAY4dpeYA5lKdCMCz1iiuj+JO?=
 =?us-ascii?Q?08jCdZX2Bo6w9rDJP9VfqgfjAtinmnevfXbVeDEI77Z5NqfH5ZuGivkJvnzz?=
 =?us-ascii?Q?XCKLTItRw5lTCDNyuUYmgenvRbuHzN8UOs/p6FrDRzviVa3J2f9BGYiM4CKf?=
 =?us-ascii?Q?FAidUSk2LX7WGMrO5pIeA2+175UqUb3cr+jBCKOkryv+6wwUxd4V98OXUAWo?=
 =?us-ascii?Q?GIWc19Cmt2fGWpXaCG3Yqq/PB26wpbQNAvL2X5cmyjqJBMmPccefCBBJBDty?=
 =?us-ascii?Q?1Clhxs5u5ezjp3D55dTnouzxjAyoNMJtbm1MvDQLiuqfYKM3FbS5ZLGbmgiK?=
 =?us-ascii?Q?8ufoD09sEp7lnv73MXCAzd23Zzo5kRY31fk4xKGsHEkakGSanT8ELOsnJURd?=
 =?us-ascii?Q?RdLFr7Lq+Fq+sHAswGcE1W938HyMaZMVSm/OMDe+8zpg8APYLKiUExSbMJDI?=
 =?us-ascii?Q?Nf8nNmhXXAfuA9kUDJTQwEuQ/r4G/tq0EQsoCfTF9pfIjAJY55IkwQzO6cJi?=
 =?us-ascii?Q?8vl5b9598Ss9sfKJDlct3IpzgqzNb5CuslV50HFynEwatec+El31ozqCX7sG?=
 =?us-ascii?Q?tRKpWnQhT65x8leGsSr85iI375ksYRsT2azU7uYD1asFq5aOIfybHGO+KW3D?=
 =?us-ascii?Q?x3IKgo104ws+OP4jbanlPdGqPwAE9YJWnjs8o+B15BMrZE0wy/pdNBMJZAmc?=
 =?us-ascii?Q?SuqBHIaTAvpwz4bZQgPshYZRlj9FtJMz/3YNCNBsnJC/uHS2Fp9FVykBo/bQ?=
 =?us-ascii?Q?VPqwkxJMw1jbXPp1gdOBVK2dXL38zRTBS6mYSrscL+EoBW8qmpMTzf57NHKU?=
 =?us-ascii?Q?gAJWwPS8sDumsCilFcpIt44KQbU2xzCFMe4gHIvm0hK1wQ2L8FF9CyNQoiW1?=
 =?us-ascii?Q?lQR/6sHUgEzvZZfrELcY2w7j25KM6XYpJ6z2kK/j5L9H2ep2CxJfgfOK+MjN?=
 =?us-ascii?Q?u5mNRP5OxPBx+2wtmagHMtl+8ecjWnepyx93YHaVYLZ2JzZ00HZunTeyzv5q?=
 =?us-ascii?Q?H+1giBQ3rEPgEVPjy+RBpNux8hpjg/0nnnvtjhwBCxttqZqV47uCBuFm7Y09?=
 =?us-ascii?Q?suAqlrXNwUw/QJAp99vMbxRMUrEpetd8tws2mVL0MjegRlOuoOEAlpyNF1L9?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec120f2-3231-41d0-c358-08dc377fd49b
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:34.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naAnM6oWSlerChMKO1/HhWmXMN0C77m9Kz7RkiU9LWO5dk7Y1dcDKkpvEU/xXHFqFqZAAx2aRtgB5DjfsnU+dWbCSzgr6T5v9UrHyUrzivQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0863

Add PLDA PCIe related data structures by rename data structure name from
mc_* to plda_*.

axi_base_addr is stayed in struct mc_pcie for it's microchip its own data.

The event interrupt codes is still using struct mc_pcie because the event
interrupt codes can not be re-used.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 96 ++++++++++---------
 1 file changed, 53 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index c55ede80a6d0..df0736f688ce 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -22,7 +22,7 @@
 #include "pcie-plda.h"
 
 /* Number of MSI IRQs */
-#define MC_MAX_NUM_MSI_IRQS			32
+#define PLDA_MAX_NUM_MSI_IRQS			32
 
 /* PCIe Bridge Phy and Controller Phy offsets */
 #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
@@ -179,25 +179,29 @@ struct event_map {
 	u32 event_bit;
 };
 
-struct mc_msi {
+struct plda_msi {
 	struct mutex lock;		/* Protect used bitmap */
 	struct irq_domain *msi_domain;
 	struct irq_domain *dev_domain;
 	u32 num_vectors;
 	u64 vector_phy;
-	DECLARE_BITMAP(used, MC_MAX_NUM_MSI_IRQS);
+	DECLARE_BITMAP(used, PLDA_MAX_NUM_MSI_IRQS);
 };
 
-struct mc_pcie {
-	void __iomem *axi_base_addr;
+struct plda_pcie_rp {
 	struct device *dev;
 	struct irq_domain *intx_domain;
 	struct irq_domain *event_domain;
 	raw_spinlock_t lock;
-	struct mc_msi msi;
+	struct plda_msi msi;
 	void __iomem *bridge_addr;
 };
 
+struct mc_pcie {
+	struct plda_pcie_rp plda;
+	void __iomem *axi_base_addr;
+};
+
 struct cause {
 	const char *sym;
 	const char *str;
@@ -313,7 +317,7 @@ static struct mc_pcie *port;
 
 static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *ecam)
 {
-	struct mc_msi *msi = &port->msi;
+	struct plda_msi *msi = &port->plda.msi;
 	u16 reg;
 	u8 queue_size;
 
@@ -336,10 +340,10 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *ecam)
 
 static void mc_handle_msi(struct irq_desc *desc)
 {
-	struct mc_pcie *port = irq_desc_get_handler_data(desc);
+	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct device *dev = port->dev;
-	struct mc_msi *msi = &port->msi;
+	struct plda_msi *msi = &port->msi;
 	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long status;
 	u32 bit;
@@ -364,7 +368,7 @@ static void mc_handle_msi(struct irq_desc *desc)
 
 static void mc_msi_bottom_irq_ack(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
 	u32 bitpos = data->hwirq;
 
@@ -373,7 +377,7 @@ static void mc_msi_bottom_irq_ack(struct irq_data *data)
 
 static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	phys_addr_t addr = port->msi.vector_phy;
 
 	msg->address_lo = lower_32_bits(addr);
@@ -400,8 +404,8 @@ static struct irq_chip mc_msi_bottom_irq_chip = {
 static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
-	struct mc_pcie *port = domain->host_data;
-	struct mc_msi *msi = &port->msi;
+	struct plda_pcie_rp *port = domain->host_data;
+	struct plda_msi *msi = &port->msi;
 	unsigned long bit;
 
 	mutex_lock(&msi->lock);
@@ -425,8 +429,8 @@ static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct mc_pcie *port = irq_data_get_irq_chip_data(d);
-	struct mc_msi *msi = &port->msi;
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(d);
+	struct plda_msi *msi = &port->msi;
 
 	mutex_lock(&msi->lock);
 
@@ -456,11 +460,11 @@ static struct msi_domain_info mc_msi_domain_info = {
 	.chip = &mc_msi_irq_chip,
 };
 
-static int mc_allocate_msi_domains(struct mc_pcie *port)
+static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
 	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
-	struct mc_msi *msi = &port->msi;
+	struct plda_msi *msi = &port->msi;
 
 	mutex_init(&port->msi.lock);
 
@@ -484,7 +488,7 @@ static int mc_allocate_msi_domains(struct mc_pcie *port)
 
 static void mc_handle_intx(struct irq_desc *desc)
 {
-	struct mc_pcie *port = irq_desc_get_handler_data(desc);
+	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct device *dev = port->dev;
 	void __iomem *bridge_base_addr = port->bridge_addr;
@@ -511,7 +515,7 @@ static void mc_handle_intx(struct irq_desc *desc)
 
 static void mc_ack_intx_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
 	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
 
@@ -520,7 +524,7 @@ static void mc_ack_intx_irq(struct irq_data *data)
 
 static void mc_mask_intx_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long flags;
 	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
@@ -535,7 +539,7 @@ static void mc_mask_intx_irq(struct irq_data *data)
 
 static void mc_unmask_intx_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long flags;
 	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
@@ -625,21 +629,22 @@ static u32 local_events(struct mc_pcie *port)
 	return val;
 }
 
-static u32 get_events(struct mc_pcie *port)
+static u32 get_events(struct plda_pcie_rp *port)
 {
+	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
 	u32 events = 0;
 
-	events |= pcie_events(port);
-	events |= sec_errors(port);
-	events |= ded_errors(port);
-	events |= local_events(port);
+	events |= pcie_events(mc_port);
+	events |= sec_errors(mc_port);
+	events |= ded_errors(mc_port);
+	events |= local_events(mc_port);
 
 	return events;
 }
 
 static irqreturn_t mc_event_handler(int irq, void *dev_id)
 {
-	struct mc_pcie *port = dev_id;
+	struct plda_pcie_rp *port = dev_id;
 	struct device *dev = port->dev;
 	struct irq_data *data;
 
@@ -655,7 +660,7 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 
 static void mc_handle_event(struct irq_desc *desc)
 {
-	struct mc_pcie *port = irq_desc_get_handler_data(desc);
+	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	unsigned long events;
 	u32 bit;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -672,12 +677,13 @@ static void mc_handle_event(struct irq_desc *desc)
 
 static void mc_ack_event_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
 	u32 event = data->hwirq;
 	void __iomem *addr;
 	u32 mask;
 
-	addr = port->axi_base_addr + event_descs[event].base +
+	addr = mc_port->axi_base_addr + event_descs[event].base +
 		event_descs[event].offset;
 	mask = event_descs[event].mask;
 	mask |= event_descs[event].enb_mask;
@@ -687,13 +693,14 @@ static void mc_ack_event_irq(struct irq_data *data)
 
 static void mc_mask_event_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
 	u32 event = data->hwirq;
 	void __iomem *addr;
 	u32 mask;
 	u32 val;
 
-	addr = port->axi_base_addr + event_descs[event].base +
+	addr = mc_port->axi_base_addr + event_descs[event].base +
 		event_descs[event].mask_offset;
 	mask = event_descs[event].mask;
 	if (event_descs[event].enb_mask) {
@@ -717,13 +724,14 @@ static void mc_mask_event_irq(struct irq_data *data)
 
 static void mc_unmask_event_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
 	u32 event = data->hwirq;
 	void __iomem *addr;
 	u32 mask;
 	u32 val;
 
-	addr = port->axi_base_addr + event_descs[event].base +
+	addr = mc_port->axi_base_addr + event_descs[event].base +
 		event_descs[event].mask_offset;
 	mask = event_descs[event].mask;
 
@@ -811,7 +819,7 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
-static int mc_pcie_init_irq_domains(struct mc_pcie *port)
+static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
@@ -889,7 +897,7 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 }
 
 static int mc_pcie_setup_windows(struct platform_device *pdev,
-				 struct mc_pcie *port)
+				 struct plda_pcie_rp *port)
 {
 	void __iomem *bridge_base_addr = port->bridge_addr;
 	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
@@ -970,7 +978,7 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int mc_init_interrupts(struct platform_device *pdev, struct mc_pcie *port)
+static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
 {
 	struct device *dev = &pdev->dev;
 	int irq;
@@ -1043,12 +1051,12 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	mc_pcie_enable_msi(port, cfg->win);
 
 	/* Configure non-config space outbound ranges */
-	ret = mc_pcie_setup_windows(pdev, port);
+	ret = mc_pcie_setup_windows(pdev, &port->plda);
 	if (ret)
 		return ret;
 
 	/* Address translation is up; safe to enable interrupts */
-	ret = mc_init_interrupts(pdev, port);
+	ret = mc_init_interrupts(pdev, &port->plda);
 	if (ret)
 		return ret;
 
@@ -1059,6 +1067,7 @@ static int mc_host_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	void __iomem *bridge_base_addr;
+	struct plda_pcie_rp *plda;
 	int ret;
 	u32 val;
 
@@ -1066,7 +1075,8 @@ static int mc_host_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
-	port->dev = dev;
+	plda = &port->plda;
+	plda->dev = dev;
 
 	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(port->axi_base_addr))
@@ -1075,7 +1085,7 @@ static int mc_host_probe(struct platform_device *pdev)
 	mc_disable_interrupts(port);
 
 	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	port->bridge_addr = bridge_base_addr;
+	plda->bridge_addr = bridge_base_addr;
 
 	/* Allow enabling MSI by disabling MSI-X */
 	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
@@ -1087,10 +1097,10 @@ static int mc_host_probe(struct platform_device *pdev)
 	val &= NUM_MSI_MSGS_MASK;
 	val >>= NUM_MSI_MSGS_SHIFT;
 
-	port->msi.num_vectors = 1 << val;
+	plda->msi.num_vectors = 1 << val;
 
 	/* Pick vector address from design */
-	port->msi.vector_phy = readl_relaxed(bridge_base_addr + IMSI_ADDR);
+	plda->msi.vector_phy = readl_relaxed(bridge_base_addr + IMSI_ADDR);
 
 	ret = mc_pcie_init_clks(dev);
 	if (ret) {
-- 
2.17.1


