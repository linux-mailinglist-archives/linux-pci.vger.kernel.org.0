Return-Path: <linux-pci+bounces-3681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B28859667
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CEE1C20A65
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C40E4E1D9;
	Sun, 18 Feb 2024 10:50:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B404EB2B;
	Sun, 18 Feb 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253429; cv=fail; b=cknohY/vSGAdxBLSYh9p8jPtk5MWONXGrXZxktOG4xsi3N3TTo7jZdZMXIl9YUosJFpEH0Nkh2nSV2eD4KYiqBWXtHbyAqsp1s6LAr8rZOQg01p5vS/c14khbxBHsIMjAxCnNfBXdm9/t+5mMjB++wQrlrdG1NNlYVWiHCOIKgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253429; c=relaxed/simple;
	bh=a7am6v2xZ49CNXVganzyoymQoDUkzff74c7Tk7OWT8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rzJl9mu71XIBJ0dwqouYhEHx1oLZbC/3VOvEDGsk+OYZJ2HFYE6dFcfNxEHi4loDODV4y95k+neUOLsLE01bYRc/rLBoNV6n1fgGBUKMxKHgjdr2EiDuFM0OY0cyrMTAcA0EsfSNxxoLcluL5CUGDdLg9KfzQfhrMOqbW9S9qCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ogzm4VKVSASBeB+U7yYxVjAvIcCYCb0Jpy1ijAwFJhAo2HfzUW175nH3E05DHTAeQJKSHn+Sdr6xGaNxiC0Hi9JE8Ijd2BxY8PGroGaVBLELgLW8ZuZNf4qec5Azc/3PxZFsHLTZ3h4tPLkfTZELcQqD+vc+dU7oh4ZuT0422nfpt55hoO42HDVWKH+xxJCv+phcXkB06SkoZlFz7p/FGUIB0PtDOz2E6/f8SYP6ECHojd+uDfKHANPJV0ATcOjNS689kJ87Nz15vPNIeWJMOEPErHlk3fzxWKSjhsibTivdC32nfkcWp9d+C+och3ue1dVodzry2OC7XdOCDNy5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka7gQ18jYzgl7s0/ZhcM3h/EGmQOqNnXDwuI+C34490=;
 b=OFhyCPf2QViJNsMVWUCmDP0SSsfWrOo24lbniBnUQaphT3I8erAFuAetAWg06a7RvuQDTpnnnuO29TYpNy1w3VcuREGfzuZinmqKIQhCgYHnEHk5RvZ+mYtyhqjF0fTkAR8wU1N6gaFaMHpYgjCZT3fDXr5zzGng2+qAq6h5N1JGpPbpNYbAhnxxlwLrVgtnykDvEW8+v4ge5hMCi5BOLZY7yn/4S6zajulW6BZl6B23F/Iwrc+DR7RqX5WSwR0mitUvkE0fq8aH9A/2HOheGAAr0NyCc41WgXw/GeYZaq2PQx6gHQEOWZtdi7+c5SuX44AyEAV80UUypevxp4y/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:17:41 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:17:41 +0000
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
Subject: [PATCH v15 05/23] PCI: microchip: Rename two PCIe data structures
Date: Sun, 18 Feb 2024 18:17:24 +0800
Message-Id: <20240218101732.113397-4-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: dea9a3ed-4a21-43c1-8d45-08dc306ad722
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Aa3M7J+WSBsm7sXVyG6eSrMIZ8bJeI03GqmZzo7Ttsu3c2o4ViMveTJdlS6m7lWUga+ooPrkChO953My1rgX+3b0pUgpb67mmPxbluZjYezPIntPE/BO1VUsE5T8BUmxxuY/QeDzeaPwqah2y/rBv7szTI9GWgFY6ebzartZyO7e6MjALn/IAgGbHJ+cwGQFqVomMzIurp2u1VOACX6nC4d1ltFdsxncqlVkuGneeRUZFsLzRcYPyaU4hZxG+O13VFgbepkrpOIzD0q8e+9CYMhxUYX0GLYMpAWv4vKkvxZL9NV3fAGf7cncZuwGZZQnIS9PYf9BU5wd8SmAxEHJ+feik4wbiw9Paf5ZCEiuLT0DgC0TwxFLMDhLeFqtDTxYkTGNOnrrIunlWUjMXhiXO8Nd2rraqQJaOe4jPXdCUCfBWlbqh+Cf7eVcEuu6XE9ht+TFLXpYZEed0OVrzdzazNCopZHSLnYNnXFgrZKk8jWwpHcpZa0QQbPHUTyP4yUAH4BZMzDKsTkUMpmFFTRrF/L8SXRwgT80iJgSaFboYjowVVOQytatfQhfuzcRd6Gn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(30864003)(7416002)(44832011)(41320700001)(26005)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f7M48ELCblRghXErEi3OJNJtwlafJ6ZbxrONzn2HR7bQp+AEbySN8SsvT0g1?=
 =?us-ascii?Q?tafyKX0/nVYFdAs9wG5/p+34+di90wHQcqv4Qu4lnxtkgf2DJJITrEiXVWWt?=
 =?us-ascii?Q?b/BMnypLLhzVhic2Pn7LtJDD8BiHkIkKtlE0F0INXq6nXK6pugrHy9Rkfdxx?=
 =?us-ascii?Q?8UWqh+yh6r6YOAKFzomuTZd8X7hNgDXQmlMwED/K3sAvg9UZ4tmDzFhABoYR?=
 =?us-ascii?Q?X8E5M7MAL1phHPN9aloSai2sjpxoNqTRzHFCuwmAXojhS0aGBhybjV1VZNsb?=
 =?us-ascii?Q?0VvvWsYTZBVxWXWEWuhq2WEONK2cJFZU8CNC07hp+j4f/6lK/Tr4TCqnWEcb?=
 =?us-ascii?Q?BJGKJ99Ec6zdQtxm6/tJVi5jyl4Nd+YrVznm67F7lesBDi6i2W9L4BscTO23?=
 =?us-ascii?Q?bZ1Tu7w36q1BYmsSusTCiVZA4RxVOGh2sa9u3WOi08s48Lmz/nxFi2sa8BOS?=
 =?us-ascii?Q?agayM4S9shzgKAWsEW6fO64MCpbbsPCpk1936auF5SVaocMd5QmLryUHuQQ1?=
 =?us-ascii?Q?OmUQSWwlc3PeTn05cJRSTpknq0wDc7gH5lA/Rd9hYi+IV5swDqB7e+35YpEB?=
 =?us-ascii?Q?XXxKrufi4QiMxDjXhLxhzvd1IkguUmlwAKt+fcXw/CSCyX8mX+2LF1rPY9RC?=
 =?us-ascii?Q?Z36Ky9Cvv5iOjx03SEmd+VPfdwdFj+05EplW9zlXLDm3kqklNOBaJ8cvyU2N?=
 =?us-ascii?Q?RHhYWv41QZ8/OjM0U+bakXXEeAOtNOzz7WF8iIEXRctqV4r8VUxAU4W3gjVs?=
 =?us-ascii?Q?O60rQSyt7y/LlpDY0SS5edKZKtThxXL1pZTheum3LP/5RY6Ajn/oZBiJ1RSD?=
 =?us-ascii?Q?I74ma5GjJPzcp+iuFXr1Syg3H1uSmY2n9ElagvySNvfPE0FCt05XzRRLbLMk?=
 =?us-ascii?Q?ayIzebG0FrXH41QqKkzu0CNs62Yst1SNmkT4nEy+s9/ZT8EMUvVP63477W4i?=
 =?us-ascii?Q?RrjVXcbAQDSPRau7AAR086uTu5+lHfpXAUGsaA8tDMBczEdpLBsQRRGUTMlt?=
 =?us-ascii?Q?fAhzr16J9OJzc1eau3cPj/MCevbQY1tDn/dKGWakqXpJFYnxqMFwgGsS0vIB?=
 =?us-ascii?Q?A+aEEw/K6mNp2q5Gi2nvKsrUuhwT0aUgoTsaw9bgiQ5cNN4gryYpch3VOHYv?=
 =?us-ascii?Q?5oyFXok9Kfhl0/qfHIeS8Xrgz27d79E6h20XLdpxenk/Tw6XpFMzZFijKUaq?=
 =?us-ascii?Q?IMb0sWW7y1qPfKsexCoep01ZSTps9DqUiw6xd2Df8zh2yZ/vx+E2iFavGlMa?=
 =?us-ascii?Q?Na5bAvkqgfap6feFA+FqrhQXDOy3+E5X072aOkEUmYd1vGDBsa2V8z3zx8fb?=
 =?us-ascii?Q?ailYoiw7SHxF1zWfCc2bRa+hRcG3S/fMfWtVjfMvPRDgN7Bg97HWfWj5hRBB?=
 =?us-ascii?Q?dHOFQsRUtEU6pU/rjQY5BODlR2T89FMPN295WG8DG7sqbANaUuLhxwRd0kr6?=
 =?us-ascii?Q?U/oKwsWXT3emNznHdhAuMdvnuuZL6rIcyY7d41AuHvqbLU6+qLdSQlnGutUr?=
 =?us-ascii?Q?6j1CD966GWxNiPfBi+ev2ifIMkdRWzQqd7+duPrMAGH9MlObYBEHc7hwevU4?=
 =?us-ascii?Q?cCakdzL0GOBMFroSE50m9qNJHKVXzt0ejUD195kFhLV5AHCdROMVHgLDzNMw?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea9a3ed-4a21-43c1-8d45-08dc306ad722
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:17:41.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uIC0HGlw/NLCjLS2PIGKswajeS5k8rZoNdirAvFw5EQpXzblhLD0I3VjqIA6wToXMFw0Ruz6zp9Pg7KA+g6EW9MSiA8ge1H1oTdHWz4JvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

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


