Return-Path: <linux-pci+bounces-1788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D32826C27
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EC0282BEB
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8802E20323;
	Mon,  8 Jan 2024 11:06:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2042.outbound.protection.partner.outlook.cn [139.219.17.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD5C2575A;
	Mon,  8 Jan 2024 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGPeE0ZdGrdv1wFiOj7kvn/YslIlsNEeF5Ylpc1LFBiHd8XK6snmXcfeHL4md3Ij0bsLs0cCSeZqNsOc6MjYzGHrqJ3UgiTrjNdObRDmpsHPpTHJeMVTz3fpFGZJwGh7OoS10FnDf2+S9W6tPCIY0E7MkSfKU4VLVQJt67fswRuI3MFCNyWF73oal9gjBowewlCfdXbNmU6QpX6Inilfq/Ml7AUz/qK5Q9lvF3zoD0EBV6vgSPo5YSv5sbLVrtxC1MdynL1qnn/uIEZt87KRsN8vcNJrlAiVxpfT3kvFoOk1nA1eGnSXoOVBcXgkg2g4hupcMV2GLEglSjTZGMLb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka7gQ18jYzgl7s0/ZhcM3h/EGmQOqNnXDwuI+C34490=;
 b=miv/KfjIF/ANNqWfu54Yq8dxyOn/ygkQjDsVSdXST5EsRaqUy8SIdAAHiRtnqwBWzM0hKFF/h7qVF+3FmSYmEFYOkIDE0dg+4PNMwSC0WX7DFkzTBV4YR/3wJy35fRLHGTmNQqdFmf5YGkYVxETIYYw+/xJ8EJPoZ56e+SWXbEX/s7jqul2J3iNaQCJc6VZPQYokK/1hj3qe5YJQWG3+i6cI6yv2Q10/sve+nZHc/H4Gr9xqhzA3mf9xey27kqY5a+fKojmhvMLd6DpIpn8lB8hDlnRS7Nm8s8KkgupIYkaXRYbvJskAsVTW6YDjmnf0H+ZCUKnz3IR402PX2TLrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn (10.43.107.79) by
 SHXPR01MB0701.CHNPR01.prod.partner.outlook.cn (10.43.107.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.32; Mon, 8 Jan 2024 11:06:32 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:32 +0000
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
Subject: [PATCH v14 05/22] PCI: microchip: Rename two PCIe data structures
Date: Mon,  8 Jan 2024 19:05:55 +0800
Message-Id: <20240108110612.19048-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240108110612.19048-1-minda.chen@starfivetech.com>
References: <20240108110612.19048-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::19) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0701:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1cd0c0-f8dd-4c7a-e1e1-08dc1039df12
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KN92FCEQWeKPDtWJxAJvEjikoeP4wjzvTEnMD7HAf+X626v4IiP3rdQEv7GV9SV4mQ++ybAV34kadoVCNy65V1jERFHj7D5+7vsW2BDcKN5dSGL6/8QflRyK7hIqmX642s5WJ6Ma8JYYOvoC4dckY1cNh4jWCvp4IPpKY+9uyfR0FAB+Ta5m6pKgH5XhMwZ56ylKswceRm+zRTi4dPl+50ARAqRxR2uCbHcM77s3B2um8I38fbhKCLipGL1dU6k4vjliVMMXt1is5wUzWFw6n32J0HoLy1lpkSpazBpI+J95J+AZNpYMGjRWM3/sMvFQNcqdHlEWLc7FR/ENouux37H2cXZAqUQVJA/hR1ZrewpqrYVuVl+m7Rrd4WxhQrDsEwqLMXXnDO5rSGYI3GW1VMxVXWyehJ7B+Ov/Rczg1D1zhat0UivjLEsQ/E29eH16pncOx/fQgr0Vp316S9MNCzFX93fidgIGqHidqXZLwZpCabEqeyAq4hTum+CQm8MFb7TeLEEsG52LkIyZNOGWAEKHQSavfQd4iAnJvK4BqOIMBFr08pZRak3nx4umwhjV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(30864003)(7416002)(5660300002)(4326008)(2906002)(44832011)(8676002)(8936002)(54906003)(110136005)(66946007)(66556008)(66476007)(41320700001)(508600001)(38350700005)(6666004)(52116002)(2616005)(36756003)(107886003)(26005)(1076003)(41300700001)(40180700001)(83380400001)(38100700002)(40160700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ip0HpvumOvHXffOvdA4Afmb+t1JeiLOUJSmvs6/0Op7BPtHFXCMH2Lzx7bEa?=
 =?us-ascii?Q?+xpaFqFe33zlqSRLk/oa3CWoV5qTBbYGsunKoRiEBvzCIgdivenURsS7lIQL?=
 =?us-ascii?Q?wdwr9HprFTlrKP6uUIUcq/mpbPswDXqnkxKzdZcb95hDCXtZNbgFodWmh8E4?=
 =?us-ascii?Q?SrZT6rOc0380+Msf7lByPB5SU/7l8pFbWYtaSz0yh2v969zhthiCMRQG0ENf?=
 =?us-ascii?Q?wKsoMzzRomYPVAn3chKIasi0yTYE/zC9uCNMJ9D6r82bSqtkXAkrC8JN9mex?=
 =?us-ascii?Q?CJ5EEjEu+sbMLcuXD1UB+pZo3vLe6yWg1+1wIy+sCY7XHYEqX1GWX7eLnq5y?=
 =?us-ascii?Q?mVd4Vf7tuL/s/iUGej3FZFkxYWSMzhBzoNkJMdv1T2OZEMMvV/iGTOnPtGvs?=
 =?us-ascii?Q?Vfw8j/s9IygCod1OAYT6DrxFzxaOEkJzxVYdxB9WsgH07MSzIgwUUuGUixvo?=
 =?us-ascii?Q?3jnKzT79r4ufG0KFX9U0zVplMoTTQfB+3Pel7xwf1O3Eg1ci83q0HgZGh7eo?=
 =?us-ascii?Q?VFbFVV8UJBABB62KzFcMZ4CcKHnSNy/AZT0EODJpuuZblLExpLp0uoLUl5VC?=
 =?us-ascii?Q?aspmWxJIBv3ZLinMlF4HEyRzwxyVf6q+hC0sbygBi28RGoUQgQKKml69l/Tt?=
 =?us-ascii?Q?UuZtd+YP/M+xiif5FvmORdYqTKCP++3vGpwmXT2ZtQNQfAzOp5wew4PNuRa0?=
 =?us-ascii?Q?rKBZRcBJMRjGUrjXKz9Tpw/1C+CMmAYx88NuX/+FzOPE7NpeDoiqsN0xkyls?=
 =?us-ascii?Q?O5AS79B4yY37iSdwuvraaYFsyJE8XIxQEOnvnDo1ITRGKutvY27VXj+S54cT?=
 =?us-ascii?Q?J7njTfna1i0Vur0lEGrttbXD0/ByiVonOTT4uWI1ie9L1SGKzsK4+eXlB2H2?=
 =?us-ascii?Q?phcL3og5k+u2Mh4MxNHAlpgtVAyh3Gr3YbuJo3AUKXNHU4F75NZXVvbdNjn7?=
 =?us-ascii?Q?oL3NIw0Opx2tO4m2n+Vr5xzHWr5CpoExrc1/wj8iQFpIzWXfhN+JxBIZ8v+e?=
 =?us-ascii?Q?TGAh88dQ0NSFavPIosvEtcswserYF9yyIrlh1MaZh4RQSmTheuFqFb1Ek8vt?=
 =?us-ascii?Q?8yYeX2y4eSHeDA6Weh/CwjPHHOe2AnnRdbQLYEch2M8vvVpYnNo81zB6Ijur?=
 =?us-ascii?Q?nO154I5YaTnZ25b/4VSVuQGKxZQDkrNPeFUIiQMORDa5+hxeUZcs5tjmm684?=
 =?us-ascii?Q?LcA2Widc3yB5CMBl8YABU/JmNBq95lMKztZ0ivNIDZVwBxvfb4B100e2WZNz?=
 =?us-ascii?Q?VLAV5Dp2yVA6VlTeuewuQPEXakTbZAaXF/OGYRqb4nan3qxc7teIyR4Om0Ay?=
 =?us-ascii?Q?20OFYrMK9wfZFZztxDAC3PJf0DkL4Cn7Tx03iXUkMqIW7xdfs+EWKNbOga/n?=
 =?us-ascii?Q?/E7GnNN9yBIUvHmhoo0jRatsF9BRx57QQ4fmD9gcCLFSmc4DGtwmX4O/x8rK?=
 =?us-ascii?Q?MHoQOletdkuv7Jmn/1YyVsmr7k5bxKFNWU5U1XMOGo5nHlk8nr1q5PGNUQ5A?=
 =?us-ascii?Q?qK1JlqGb2sQ2GSKM5D8kdUrVflTulFnXL6szBo0qHCZYxUIKyQEPca+qp3dY?=
 =?us-ascii?Q?O1nxLf92Gn8gavlINZL6BHpeVj+ZVV9UP7ZHGwE9X/RYmPIIRFv+kaOCC3Mm?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1cd0c0-f8dd-4c7a-e1e1-08dc1039df12
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:32.3034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxRvXDHlWmVQTVgnlfy2fb76M9AMjKA/FfroAF5AOZ0xevZ0qUpPnsJAVAOMnIVAhYRZtiNJEltDSRGSQG94kO5Z1a84iyXaf+QwbPQvaIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0701

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


