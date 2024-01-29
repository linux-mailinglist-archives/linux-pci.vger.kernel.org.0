Return-Path: <linux-pci+bounces-2677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2E883FBDA
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45947282857
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1CCD28D;
	Mon, 29 Jan 2024 01:34:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2045.outbound.protection.partner.outlook.cn [139.219.146.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35656DDB3;
	Mon, 29 Jan 2024 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706492086; cv=fail; b=urqS8FiSpd80pB4iMfpH4yR6ZQlxxQzglamUphzf0lb6HSd1IIwPxqhhSYS2z9MSbDuIY/NjMC4waA75gqF6IHdWEhvkczcpeId5zFiN10Izm8HQJa85VF0IdyejSWfuGpSAHd7kscvT17DSovF1N3fyAPmC/1urg2JZNqEi96U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706492086; c=relaxed/simple;
	bh=a7am6v2xZ49CNXVganzyoymQoDUkzff74c7Tk7OWT8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SdInCNS/lhq+E4uhuNr0zHsoI0tAFKCaRlFSlAtGy0VD1dSkGZwVpkU1zJVaq4cFxBt/pb7lC/7BvPK1e6cCsdYWTXMgcK+ZMtERNzXlLKnHrlCOOoo7bSqE+6gUoSuVq8V8Yqxw/tdOCGRizj2JLUTlFu9x4xbn3MdIhanIl8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRxXmpWmhteqXTl5Tq4WCVSoGLCNP573K5cm2WBpiakMzpjIcKvhAJqEuZjK9FmA54PU3yK//7H/6pbbtvqn7QM9joaQvwqYV5i/RFT7NkGuMALwvSsQ2Z45OXJv/xMWQyBwJe+cB0VsrI2sp56HCM7pdPss8SJNa9dZUrqWXdL58zQ6Wt9og4MCHiXI0TejTDIVMqLkbef1/E5NYeiE5dkqPhCyg2ahnHhiZ3/cxYZxWLIDFvZAJG1VxO0ILKi56BWptIVWK6E9dhAOCYJn7L5D/HRbPimifEYaZZ2EcbLUy8ER0DRzNX1tWB0bbJaHwMsUn0KbNehCi4+8ONQLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka7gQ18jYzgl7s0/ZhcM3h/EGmQOqNnXDwuI+C34490=;
 b=cnQyrWdO1Y1m4lHQgtBvZj+D1OPrL3urs5k7XL6na+4swzLI1gOu9BhjsMVW6r/MH5UaX6460zBZHqurx0TMdFa18JzgF1woIUtLmcCA1rKC3kGtUQcZvnEoXf4z9zrIRrKPUracqAqofdLL10LTwaZ+jcH2nSib14ZbtfN43WjfRnB5CZOQyFh2+MwaF5SKws7yf8KGuVV1IG4P+zr/Pglwo4D5AZfQspuSiHDTA/d+ttf+z3AoFk2jK9rG+WvLulVGGQAH5laQ8I1hEAVnl6Qfz2DhlUfYhZAsR66ZtvO8TlZawfpD0+ic6xvgUGGMXFBIqSwLfbXFg1PRTnyRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0630.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Mon, 29 Jan
 2024 01:00:10 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:00:10 +0000
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
Subject: [PATCH v14,RESEND 05/22] PCI: microchip: Rename two PCIe data structures
Date: Mon, 29 Jan 2024 08:59:50 +0800
Message-Id: <20240129005958.3613-4-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0630:EE_
X-MS-Office365-Filtering-Correlation-Id: e4482492-20d6-44b1-45f1-08dc2065a482
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BusmB1gfWBcreE/Y3/WLbV7leVHmCXBAZcV5e2i+q+p/Iimga6/avzP3zGo8K/F7wV3WJv43gs9qN2HstSUNh87f3gRdYdoUZcW0YesFyG5wZRXIq+7d3BJi4eQBSbfSAh8/x7n9o9NrbtDFaERL6I0j95WU5NZ41OSKc/8eYzDckHe6FRZXYd8SV9hmRkZVrBDLBOi/eFmRCKEV0eRJxx4wZGyMdkipLLdqYYOt44wkhMAXtUVY9bOQn4PO6vL8lffs7dcP0iDrjfm2Hj4StrrlDmiCYcVifn1yHaM4L91q+C6isXTdChglNuj+Lh9LLRM7SZB5NMX7/h46t54Kdw7dP1O0loWlwrql/G8sPewOVjm2vIGVg3Cb3EPjY58A6yAksbK5eOa4ssRNkUmJtqZblwyQL9/M9KmK5R2BlwsUDef3/A6zib22433bTNyIJX0uYuAIFABFqtjtxThXUR/YE+Ns9PLKIrNgpc3jRVKB2S6rkwVQMTpxR9BpVN4bEonj2IWuHGd6+dx3y3ewKCKmOb6i69DDCuhV9PnkQxLOqPe2RLozdfg8+3hFEjSq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(41320700001)(40180700001)(86362001)(40160700002)(36756003)(38350700005)(1076003)(38100700002)(2616005)(26005)(107886003)(2906002)(30864003)(52116002)(508600001)(6666004)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(8936002)(4326008)(44832011)(8676002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CXDoeaTgzj0YVEzxrhKFIbDY1Ypb7gARxiaNZmrbAMLBhTueKgW3yu9WTtg0?=
 =?us-ascii?Q?MB3KHjZ2kbpX5LreMnujBfSb7hX4bDxkTOJRjEDdSzROXQGGwl8Q9zPH11Cp?=
 =?us-ascii?Q?nhlaHWHyVG+HYZcu7nBo72fYu/KUzZzPyjlg2Oj1/crz+Ab3v4s3nBooRUZ3?=
 =?us-ascii?Q?MOMThZLOBYU7GwNqPHJy2wm81CBsQSIieimztyN4reyRpooWl8Q8WGvUlSNQ?=
 =?us-ascii?Q?/+DB6sg4/6IUfS574+nqKOYz+T/vvKmCa60ei5Zg00OjLZ2spNhnuI29DaG2?=
 =?us-ascii?Q?yoLJmiRKglXJ+Mfa71VpyHlGijqCpYj0WDvX/owEJSi++4HeJ3X6pvtXIMoH?=
 =?us-ascii?Q?9qI1OLtm2KREeMG69xQiB12BfXq74crPDPq7AHftJabHvKe36N1WBo/OjIpJ?=
 =?us-ascii?Q?Xdu1udcuRt8DQV/nXZHbEDpDQL2KR2DAN8kdD1JYKdAMPUGV6BA0GktP0UNL?=
 =?us-ascii?Q?+Ty901BIcxFAiLBLOB8kMpPN9cwK//CB1encdODt8CBH4ZFhIboN93DwMPcJ?=
 =?us-ascii?Q?/k/o8CBLwtfVUNyo0eI3ARhlDwQAxaEpuZNnG8ZOw8OsbfOltaYvJ33O0c+F?=
 =?us-ascii?Q?+bSWt2OSp10Smo9um2GCslmHvMVeMNVqjYTBBseQoCd2J0A62FRlXD+CWgQR?=
 =?us-ascii?Q?5yBp+4mSywMxgfnINd63JG/gF9Mfr/GwZYPesGXw+8i3elB4K5gs13LIYFaA?=
 =?us-ascii?Q?h/3iyYRXgktM1pt/ewIKJX63ie9un9wRi30TQjb9M1VaFa/BzPjb37mp5/LL?=
 =?us-ascii?Q?XorI+L5BXelfqoLLHm2aVgAojv6wE4OInp2ZyCPU7o9mM95zL6bmbzJIGMrk?=
 =?us-ascii?Q?64MWwefCk5Nu7cvGwo/7kKCUnSgsZRC3Suxg3/VYyiHn5tW1QQ5O4Yu5uz6y?=
 =?us-ascii?Q?gAS7iWg/wDmeMD+4ntUPeuhEUpPxw2K223ZVA5i+qHUrWBy6ddvhXMgOEvF+?=
 =?us-ascii?Q?CbD7mg1j+uuO1WuwvnQ+b0iVlXVaCtMxIIojSzt1uzn5ihdbsFKZjRrYNmIX?=
 =?us-ascii?Q?20cKg8tD1vJKZuE7Z4YykgLWLHJCbbhRFOmnm50XkXIgpP7wi4TyXZE08hcQ?=
 =?us-ascii?Q?VabDCuDBYpMQF0CqAzlsJN6RNDqW7GA8yGaMHsMWwhuBznZb5tgIVk/iqxYy?=
 =?us-ascii?Q?grnk9Z6sHqOvIqWGIuwQ4NnsC/BM7JGN5/SWVwsFL/JVlkXUomcwLshKkNPM?=
 =?us-ascii?Q?mwW6v/w8WMjRq76JBdmLSkt6zxdyhvSiUVyXeaInWqe9HKjLwsjduP494CmE?=
 =?us-ascii?Q?eF/jtujIqsSON7SowDxfIeMCbjohmdgzw0XLjncJhZIq2W4v+92TJD4CGc1B?=
 =?us-ascii?Q?Lrs9O2NuuiKRcCvSoj8jUyqAnP3jljy7XGjijruGuV7CV3Vcp404DskpXVRk?=
 =?us-ascii?Q?2CJdDIlwz3N/zEKPujAZrNfbr91myUAcOrHA85KG2skKG5Nz7O00985XfAPe?=
 =?us-ascii?Q?LjTxD69MUhQ1LrSQAALMBFOgWokDkr8MNfvueNNim4dTv6wCiAPCTSxVPdCj?=
 =?us-ascii?Q?nDBMZKZyYklWODwoBNRL3362MaX36mfw0BOdBs1ENsNjzrfDIMPorSSZwMfp?=
 =?us-ascii?Q?EEoqQxiqtwe0j53rzhEXOFlvr/HRuO3zorA00KaSFkKot69BPghIZbNYVzEe?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4482492-20d6-44b1-45f1-08dc2065a482
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:00:10.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALG5xDa9RfRGJvUjRp9ZLEBF9574xFM/IjO0k8+W/ZBBGpvTatLVARoeosUiaxO2V6fY/Ot2cdRXzrxm4h7387fM9LYlk4eWjfoj9VeyDy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0630

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


