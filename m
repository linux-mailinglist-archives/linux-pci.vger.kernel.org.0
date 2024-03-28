Return-Path: <linux-pci+bounces-5338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A4F88FBA0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB8E1F255B2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0776519D;
	Thu, 28 Mar 2024 09:34:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDE818E1E;
	Thu, 28 Mar 2024 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618457; cv=fail; b=PJO7qx+eg6g8stHP2xm1Q+JBIUBn2h1ln8N1188LtYOZxsZN3j3hbUnN8oGySXZFKfms8fqLOK7n9n1V+XEX2Vp/fZgdgTYbyyBgt37YWnkQxHFqARnaYQd+XDll6AxOjUMszUUTDCz8Mj67Gd6Cn/02n/yN2E/VR581qLv7GM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618457; c=relaxed/simple;
	bh=lg+DutGd3feA8185E5AVK1JcigFtuQVRvUCtlC/3EZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=afFE4KKir7dtkcWeMhPdQcrdTfTrT2alsRaoMezo7RGkuQWN99ywReldMw0rN8Ako3vEHJFEeJNHRNHLzg5OB5A43g1zu6nbugcJQVxm8Jv/df+sCHMPiaHywxXqr3QDy3+/uK0Z5cd6+p2zkYme+DpehuXw2jYGXyzohSQ2ZVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9oWC22ccfF4yvxsTEbjkbwDu1ShlhYteshvdHMI0gkFZygs+wgdoY4b786cy3OTfnd5wiIGJASBAvbH0O3+cS/Uv/TYZIZ8/5BxldaErTSq09Fw3LPwDZ7d6G5i5v5gIXOCZ2QVuOv+T+EgnYQUJIUzkrrtRRr5FyuQAe2NGIlDy/+IdyU9NbKFWOOvPS41AVQmXRvZ0ggnALgjqoEiYdob6lfhL9hG+pHqEcp2vLMdxES7TVjhw2eAOiivRUJb7uHmxiwfRn5Zit9ik8zD7WZS5mB8oF8xff6TZ6tvxgE+WIFlIkYRovLkuIVYLtwb79HO79TDW5G06D1DFh+mrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDIt0Fvi2AI+V03IChS1zYgUdGhwDDpBrZnWxECVJlg=;
 b=dym5avZwmWuz3DkQtoXoVdIbOVLf7MovG0lFuCXtG9hftEMyS77MoYD3ZsjLqL6BC0kUEp79VSbiMBonsoU+a+S/vod8pGrQeeyo4kAtX6xBadMnt1kL+m8CBPUsPMXC222UJhdJYn8Kd+c5qz0cKMi6dgbXM/aF6xT3wtVIGJqF2R5XFG907rxQ9goBBVt2/Q1qG4SZnncWLGnrknLnfKR5S6yc/Ragy43rQi3Fs2vFOeBW5m4VQ1HfVMyK0gX9SQtxBjtjPq+0Uzqs/NHz4Er8/OZZkv5rzW6siyCNQHuP9Aa+YayKjhHzx/x+BCObr5BTpQ1kmfFrDkyM+91LPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:49 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:49 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH v16 05/22] PCI: microchip: Rename two PCIe data structures
Date: Thu, 28 Mar 2024 17:18:18 +0800
Message-Id: <20240328091835.14797-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240328091835.14797-1-minda.chen@starfivetech.com>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: eba31e99-6978-415f-fb01-08dc4f0813af
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IyfIB2jW0o4fhs5vLZ+YQDpCZZbLWnQyb0jWbQFyMoIMuQiads3v5uHld6QSArSiZ+obNO3b19OHoHYiNO4A/hnxi4aJolbokR/ZRaCjIJGNItsn7nMeatfB6TGUGmVcv6FC9XrnRKXGQTW2jfwEpwR2QfdyJPdtzfod39xfY+rNYlPaP5igwgpOWht1fBbxiY3j8VacA1LbeIIKBKW2oy/PRs3OgIUGND8ytqlfhxJ1nQMQhBc05hUGbyPdpSRi7tS32sgDTVO59P+eA6G1wwQT14WMCGaVhq5uBiO2wp6jAOqltCjD2I2p7rvEixOu8TD44opl+6drlAnYN6Psz4H0HGpj1fClg32LmIlmnR+9dhDvB1NuN6+4T/SXLvZXbfYkDNekyx4im1LyOs0Rr0mB4uccGh2rXn/1ETPBwjVvTw8332Gn3Q+81MrcqArEy+8BfxMSss+K9aYDV6wVE6Mmi00gpedkO0Iguune6gznJDBvNVvVeEn+7n0Cv62ZYmYUOP3C0fzqmaBCcnet2qkmZ6oXqPC+apBKM8VVb9rGb40OOhdqXN+jwO61KphgtXcGEYpspSLpUS9kB0K25cMjl0VREpGFeCoYfO3dydKxwzCesy3OE5AW6aTdEg3K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kUO0SDwDozDYOQN+NLGA7xDfactdEc8y1QAr/07DdlsdXJc2+UiY+iA/ivft?=
 =?us-ascii?Q?auRXpMVO2JDCOMOFJFRz/lwcfT6hZWIPb7JTfEOHAHFoRcOpeIlQ2I1eLvhr?=
 =?us-ascii?Q?ZgMY1aD+x8f5HXtDZGaZ6/eZK5r97EnERWL20fqoVYwG423JKD037HDiJouy?=
 =?us-ascii?Q?4B3+wF4DIHBB3O8Ij/b1TVcdP9noONmwkoepdXu5FjB8PYGUTZuRmzRbon99?=
 =?us-ascii?Q?jT0k/UDr2uqv8oY/V5GRhs1np2OUxrqo4yWkruIbBAH1icksbQ+Rl+9cV4OT?=
 =?us-ascii?Q?Ze7Kvlzy1eMQLtbDPlhorAkI8EENRXVyaV2X9kz2ySimLYRHl7WpLdMyURkb?=
 =?us-ascii?Q?t4U94EbjJdfKJ+RHGHwhRU7ypO8EswPehHEV+wB1hVol/DUhxQ5dzQPbLuOF?=
 =?us-ascii?Q?/5Guc6MYbEfoL1MIoq6up7O/fPh3iTZz70KlgacujVYNT/69h0Q6cXL6H8We?=
 =?us-ascii?Q?AwkWI2EpaQzaXFx1UBVG6R39iZ5O7vee8VY0nzsk8vNSlZcPCqAuJsoRzDlw?=
 =?us-ascii?Q?f6UT5pC7t7QdjjzMH19Bpp5PDeTHiUuHUDzNz/Rw2T6hJ0cYD9GLoyngmc4+?=
 =?us-ascii?Q?J22YkBQD8aQx2r5AESfd1vFznDJEve1IrvD5UrK3jJE0CH3928qUQi002CAC?=
 =?us-ascii?Q?Cy8Ya5+Mj3eiCB4tTKtBGOdqaN6PrwiuAjDlj0SpdEtr1AF9BHvIwpmeUS6V?=
 =?us-ascii?Q?T6NXXqJ+ukKoR+gxvev1Tn6yvTl91AbKa42ecDBwuVm6qwFWnmLBINt3aGOc?=
 =?us-ascii?Q?0zgy+bW6OXHvpMUuEj0NAkVmC/pJrWg7GbPHO27Px3ukwDL6/c7plQUoICYx?=
 =?us-ascii?Q?IqWxR9fYROHgPq4Rv4UOqCcQaeM4oCFuHU7Uh8Y6ZcGawC13Ed3rnvlqUU8h?=
 =?us-ascii?Q?q6Uvaqjhn+ucnFsG3dow0kBmmSCmAR+P6tqrg3iVgiOiNdeYKt/EtTL9GYXV?=
 =?us-ascii?Q?5zmDYhb2QRkyTlbDkFJzigsTAi1VK0EXj3vsjRNbVYEwKswvikCN6LUHNHDk?=
 =?us-ascii?Q?UROMTMPOQh4IQdSjH+sDGpe6qj7aRcfDnxuMwQMp0xoYJGIeYrj7kbysQor1?=
 =?us-ascii?Q?XQJqovtVcu2XOLoPWOQr8TBb1EuMyKWemLYVE9pIuTCqA7qE8Ni0L5tOJA/k?=
 =?us-ascii?Q?OBcyi5hYw5ZP4FgDcYBFSjPRBca4es5p7sRSY/x/8D71zjkEiYOaLKuMA/Fs?=
 =?us-ascii?Q?waHyHlUOIbfUJLBk00PLy38suf+AEbrP+rZPmqkq9I5Ed6Bb2cV9OD1voCs8?=
 =?us-ascii?Q?fzyWHXTO65dqU+XAg6b2VDqzYlyHK6NedeuVrWf4isIZ5Cl2cLJKFj1NNkIu?=
 =?us-ascii?Q?ycyOjJnogtn/c6s4Em0oYYKQAcDjZ4lL15FCgoj1vUZmePAEbybfomXBhJiX?=
 =?us-ascii?Q?ZDvRoGM3g92xik1O0BdaqJcjW49TmOOsX2zuX1TYxCESEcGVU/32EjXzOMsh?=
 =?us-ascii?Q?xPtP6kO6Rkz51YamS+DAvndlxp7VJM7eqQ3gXGQwDySFZd7CvN+Z1myrBIUZ?=
 =?us-ascii?Q?D3TJmUa4Zy5nm40Q2XpWDx6SLZkSyqjUX9BrmtSPe1lotiet1bMDhGbgX+me?=
 =?us-ascii?Q?Eb1aMbwPVucgkcfWH8dLnvDWCPkKuQfjv9OZYh7exGZZuFGoEwM45CIHeskj?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba31e99-6978-415f-fb01-08dc4f0813af
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:48.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNq1Or/I3qVHZE2RveNgOoPfuW6SGIKlgPlcbo0AgSFDIN2m6Y1bCJDSFU8OAPECWSvScZJN7/mlx4/acenCddD9pMkXaym3rFeUQtWP7Zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

Add PLDA PCIe related data structures by rename data structure name from
mc_* to plda_*.

axi_base_addr is stayed in struct mc_pcie since it's microchip its own
data.

The event interrupt code is still using struct mc_pcie because the event
interrupt code can not be re-used.

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


