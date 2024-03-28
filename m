Return-Path: <linux-pci+bounces-5324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E688FB0D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC88296AFF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673217C6E3;
	Thu, 28 Mar 2024 09:19:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2091.outbound.protection.partner.outlook.cn [139.219.146.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3337BAE5;
	Thu, 28 Mar 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617547; cv=fail; b=HI0kr5PtVUK4vU09rcWl6YJMMu2S4pNT0Xl2gToRRD//Zdv0OKiQ5SdPqJ7XsV4QdmJD+q7JdNuSe35HTW/PG0Q8w+8jrck9f0epOYDU9r0JMBTqolW90zngzwuWDNcz8cKvSmnZ9UMwdpySJ3QaFJid1QUxcVtC62C3yerucas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617547; c=relaxed/simple;
	bh=22WfnNEhA24fGIAnSj8FnGthhV9+MdctziwxO7auJ7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hBXzXF6XWsb7lPrsSLhoAIMuRSgWN9BSLF/BBSiCTq/AA1zXnpSbGlSc/QAZFI/nyAon4tEfrMzujp4X4QtV84whm+uvAsNY/3ReVLosOGNHs8bVNiS13zMYi9sHHdQXTXM8QWrLB3j3kNhbAAVpqFZncvT4FH16BaRkxkXvBeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYfkmpF9Rah22KXMpohg7j9aWZ7cgxa5MEu52lPKtKAK7fB2BpCaAq25sYnyIzsy1SNlpwkHc3KhM2v6KWxfxYxKSggIROgu2lbM8FZMfi3kgOZ5R2aZ1IM6sihMdPMCQGpJK23kz7TfCwNGBwJRh1v7a+MlEjrHqQBaRkb/Xc9V8Hz48vJBfqco0BJVC8F7jA3ZNpH/aAi4z7WOw+74xOsao+1qGBJsLjWdkPG6AopI/ZmBUpkdNZhWelVWOD59MEtyiO8QPLEA8o+yLRSoACjpQfdUqPbjsKeSDC/faX5fEnmNSG0lMr3yLWa8TYdsOutdVRAUGpIKo8aNAIT9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvgzgZ+kCWJDW3yTlipB4uET3HJVJTZKxQ2LjTr36CU=;
 b=B4SRzuf17w1+4mCkJF3gWLaQzDB8Q6OSFO+LikZFfvBXgIt0IzL7BQVZvBw9GuC+2Mmd+OfrZ1DN4AHeE2QhWLxAvuCbj+iVsbRfepYvR/QC5kdHU/CFbuzRdxs3amZAZQ3jRFNwedFay9DReHWwzyuWkMN9EE5pm+X/SMHNZhHqbLSAdL0K9Cf0JEtSpXv8ktITP8kd5F1Sufsm7KIxX2tQY8JGT2g8Dx3BjFAAlL0bPBfhPg74YTSIpvtPuQdgm+nL/t5VckT/Z4qyk7aj68oMn0bovoKvifTVUr3CHIQ/fWnyRuUT0x3iXI+n7Wo4b4FJfpDhV2OgLt7NbOq6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:53 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:53 +0000
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
Subject: [PATCH v16 10/22] PCI: microchip: Rename interrupt related functions
Date: Thu, 28 Mar 2024 17:18:23 +0800
Message-Id: <20240328091835.14797-11-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0559:EE_
X-MS-Office365-Filtering-Correlation-Id: 03485d29-8bfd-4fc5-10df-08dc4f0816a7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q355Akw4mnRgjVH0H02J9HiL63Vo5J1fZGpuAmLeuBniy2RBGtwem9lwh8XPWHiNxaOqgo1Kx37yPOiZcvBX2bP8djOnkg8beaKePJAZtnR2cnLNVCv8bQut0rj5ClHKQ6/sE688+d+4ExunknFNYRMcx8YqTt8RBSbBYGbsH/VzBSdbBZb3veFxqrLlaEJSbUJnjy0IWqSbMrpWPGLluSzrc+GGLNg7SkyjL5Rd9UKK/fHRZ71Bz6h0h3ejULrDV/lK72pq7ThJXdjh3BPBnHVHLu2XMLdyAO9pUF0q35hCUrsmM9QeCmH1sTCcw6it884dw3UyfQm8BH/PncgksrdyhWBQXnrLuVfp4Ys8nPyw6jqBQAlpzgmUjOB9CKASgnA/P4R7eu4NEqUlnZntqUzb0CZzKYefVEd7LoMj9O1vs3sC14z6TnP9D/XaqG4q421uRJtjhrPauKfTS3LkrgJiUJ36RzYH45W8bKPLM6pOtZyn9+2UI1rCWBuncgucbtqEKWgF0DLZkIBbCOVsKauMZYynHxEJglz0DOUq7PcYaxpJ6cnEuLKhJagQc/oaDRRBveTcc3Y6aT2s2YvD0hsTu83hlRjKpDxLhi7nVOGF3BMaMuborrs05i4xm1w6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?miCi7gHmUsP3MwJsck/BKWt6KV6ain7e7v/uhtCllaLHLeUR6+lvVU/J1rp7?=
 =?us-ascii?Q?E9+O6xJXt6710SSeJqM1LUxSkJsTo9H7pXdE1R/uZ0rrZEyMkwVS6IU3EF3P?=
 =?us-ascii?Q?guNYgvT59E/VgiPtJqmbLJSg0Aub1ZCp0tob88Q6rURun2N9oZvspF1cdlv2?=
 =?us-ascii?Q?E1vt60ci4A4NYZcAe/M75P6f5ZmcNWQkcDkIlMSZ4Mg1nzHn6iMxnodh4pEs?=
 =?us-ascii?Q?SjYxh0I5Xdlm3S22e6JY76Ksktkdy6uqtQw9RRTTgg9YKVnjME8lvDuFUpfB?=
 =?us-ascii?Q?b4+IUk75ANWirDwZXkajVMXdWgmTOrshyIMz2HT4MsheBJQex/8qdR+p2bW2?=
 =?us-ascii?Q?bNUuQ7kWLNcDDCR9fhlvg/Fz44wsJV7Zpvie9Yhh7vwKnTZOc8wszEgwCueV?=
 =?us-ascii?Q?JaqoEZlQntUFoyduc+dV39KqfUnQutVpcC9c82V/Mgl0rtVevxReFbzOVUUv?=
 =?us-ascii?Q?WxVndEOirQeZvFt/caG5a7c39gySuistxtZk+NdbkkL99LHm8ex6G8MeZtle?=
 =?us-ascii?Q?b/QZWafb53EEg7PSr9SdwFfXn9lY39qgqe41IXcB2L9tM7QVNZqd/AcIx7IT?=
 =?us-ascii?Q?c3y1WUSxy3TzvswO81voCGt+kZtJEndoF3UrSDdiKuaZjUTPyLFDTPVeQ/em?=
 =?us-ascii?Q?rGKcZQ6Tvqkbv55fFZqZJUXgSkYs6PA/L/5B/JroaZfYWihSt6vDU9YWqlST?=
 =?us-ascii?Q?aZGGAdDVN1GJfHKnutS57yYrYSB9WZaLRKsEPgSdA7viJrsa3RzhR6Sw2ceu?=
 =?us-ascii?Q?YexZcZmjnzvEqAPBeg6IGN7dTNvZIGHDI3opjOkgGu6wxjoahVAd7E6KhQMo?=
 =?us-ascii?Q?W6d2HI5B6T53dts0Nj8xojF6fmM2SmT5jkrez7eSt6xBGeQyYdCcHHOnRbdl?=
 =?us-ascii?Q?ONqhifGkStTjxBQ+fd2O86WomuaPEZaMwU3PQ7Cxmm/KPgN6CaovEhOILNLS?=
 =?us-ascii?Q?dSgaAPd1b18083e5R2VH59ypdBS4Lt5PJC51Np5DNtegbLqSRENgPoP0sy5d?=
 =?us-ascii?Q?tZS1kIDcT8o46S40JK2Kcyk4S+8b6d6E0Fvuq/fA5797SG60yU5MdQVySZf1?=
 =?us-ascii?Q?Yv8Le0pUeAvcjTxVuVwoSpcGSrBnEQj34hFiZRs8yaxE77C1dauGuuBq6ma2?=
 =?us-ascii?Q?u6EiYZqEi3obOoSkV6f+BYOK635qfy4rVkx38mnc1Szkz3pgCxFuVS4MUh8j?=
 =?us-ascii?Q?R42tbM/wR4x8AKVIIYObBVR4jUZJmkBWF293ECWw06ybtOGnJcr2wgG2pWa8?=
 =?us-ascii?Q?BdFDRE11k98XoP6XSUJhpLdTot0Oy9MjGJYD1tQXoKDQaXLxTn7rImcOHovo?=
 =?us-ascii?Q?nNhSr73eYRdFVugDol65dubkoOsGe7AjxmIwTFB+k77rFcP31Ls8DDMiX7Wx?=
 =?us-ascii?Q?cxQEY2ZyY4llHDWLMXlRLBXq3LpzLva1k3zFM89y3OAdff3Y3+W2iXbVGjt5?=
 =?us-ascii?Q?r3j11ti777QpsvvCCc/XyL7vQW+PXfLtRQhoO//YlFE53FRaOTYpJa6kSaA2?=
 =?us-ascii?Q?0AT+Hrpjov7cQA86bbouX1066uRWnWwJHMZIqJH7yK0chQJCzu5IB+Xs1fTs?=
 =?us-ascii?Q?1yizj+wLB/EPGdHHhpr4BYx66zl9gsZyn5waO02Y81lJx9jSS6YXl8XpA8P4?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03485d29-8bfd-4fc5-10df-08dc4f0816a7
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:53.9381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vFPvyg8Z5c7HcsSxXTV6BNx62puq0kvMzXaled1dcumuEp/iY0Omt7o76Z942gURyyiKgT/wDHmlK0RisWHe8MveuwdOzP5xrcXMT62hzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

Rename mc_* to plda_* for IRQ functions and related IRQ domain ops data
instances.

MSI, INTx interrupt code and IRQ init code are all can be re-used.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 109 +++++++++---------
 1 file changed, 57 insertions(+), 52 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 573ad31c578a..18bc352db389 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -318,7 +318,7 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *ecam)
 		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_HI);
 }
 
-static void mc_handle_msi(struct irq_desc *desc)
+static void plda_handle_msi(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -346,7 +346,7 @@ static void mc_handle_msi(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void mc_msi_bottom_irq_ack(struct irq_data *data)
+static void plda_msi_bottom_irq_ack(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
@@ -355,7 +355,7 @@ static void mc_msi_bottom_irq_ack(struct irq_data *data)
 	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
 }
 
-static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+static void plda_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	phys_addr_t addr = port->msi.vector_phy;
@@ -368,21 +368,23 @@ static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		(int)data->hwirq, msg->address_hi, msg->address_lo);
 }
 
-static int mc_msi_set_affinity(struct irq_data *irq_data,
-			       const struct cpumask *mask, bool force)
+static int plda_msi_set_affinity(struct irq_data *irq_data,
+				 const struct cpumask *mask, bool force)
 {
 	return -EINVAL;
 }
 
-static struct irq_chip mc_msi_bottom_irq_chip = {
-	.name = "Microchip MSI",
-	.irq_ack = mc_msi_bottom_irq_ack,
-	.irq_compose_msi_msg = mc_compose_msi_msg,
-	.irq_set_affinity = mc_msi_set_affinity,
+static struct irq_chip plda_msi_bottom_irq_chip = {
+	.name = "PLDA MSI",
+	.irq_ack = plda_msi_bottom_irq_ack,
+	.irq_compose_msi_msg = plda_compose_msi_msg,
+	.irq_set_affinity = plda_msi_set_affinity,
 };
 
-static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
-				   unsigned int nr_irqs, void *args)
+static int plda_irq_msi_domain_alloc(struct irq_domain *domain,
+				     unsigned int virq,
+				     unsigned int nr_irqs,
+				     void *args)
 {
 	struct plda_pcie_rp *port = domain->host_data;
 	struct plda_msi *msi = &port->msi;
@@ -397,7 +399,7 @@ static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	set_bit(bit, msi->used);
 
-	irq_domain_set_info(domain, virq, bit, &mc_msi_bottom_irq_chip,
+	irq_domain_set_info(domain, virq, bit, &plda_msi_bottom_irq_chip,
 			    domain->host_data, handle_edge_irq, NULL, NULL);
 
 	mutex_unlock(&msi->lock);
@@ -405,8 +407,9 @@ static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	return 0;
 }
 
-static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-				   unsigned int nr_irqs)
+static void plda_irq_msi_domain_free(struct irq_domain *domain,
+				     unsigned int virq,
+				     unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(d);
@@ -423,24 +426,24 @@ static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops msi_domain_ops = {
-	.alloc	= mc_irq_msi_domain_alloc,
-	.free	= mc_irq_msi_domain_free,
+	.alloc	= plda_irq_msi_domain_alloc,
+	.free	= plda_irq_msi_domain_free,
 };
 
-static struct irq_chip mc_msi_irq_chip = {
-	.name = "Microchip PCIe MSI",
+static struct irq_chip plda_msi_irq_chip = {
+	.name = "PLDA PCIe MSI",
 	.irq_ack = irq_chip_ack_parent,
 	.irq_mask = pci_msi_mask_irq,
 	.irq_unmask = pci_msi_unmask_irq,
 };
 
-static struct msi_domain_info mc_msi_domain_info = {
+static struct msi_domain_info plda_msi_domain_info = {
 	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
 		  MSI_FLAG_PCI_MSIX),
-	.chip = &mc_msi_irq_chip,
+	.chip = &plda_msi_irq_chip,
 };
 
-static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
+static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
 	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
@@ -455,7 +458,8 @@ static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
 		return -ENOMEM;
 	}
 
-	msi->msi_domain = pci_msi_create_irq_domain(fwnode, &mc_msi_domain_info,
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
+						    &plda_msi_domain_info,
 						    msi->dev_domain);
 	if (!msi->msi_domain) {
 		dev_err(dev, "failed to create MSI domain\n");
@@ -466,7 +470,7 @@ static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
 	return 0;
 }
 
-static void mc_handle_intx(struct irq_desc *desc)
+static void plda_handle_intx(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -493,7 +497,7 @@ static void mc_handle_intx(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void mc_ack_intx_irq(struct irq_data *data)
+static void plda_ack_intx_irq(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
@@ -502,7 +506,7 @@ static void mc_ack_intx_irq(struct irq_data *data)
 	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
 }
 
-static void mc_mask_intx_irq(struct irq_data *data)
+static void plda_mask_intx_irq(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
@@ -517,7 +521,7 @@ static void mc_mask_intx_irq(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static void mc_unmask_intx_irq(struct irq_data *data)
+static void plda_unmask_intx_irq(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
@@ -532,24 +536,24 @@ static void mc_unmask_intx_irq(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static struct irq_chip mc_intx_irq_chip = {
-	.name = "Microchip PCIe INTx",
-	.irq_ack = mc_ack_intx_irq,
-	.irq_mask = mc_mask_intx_irq,
-	.irq_unmask = mc_unmask_intx_irq,
+static struct irq_chip plda_intx_irq_chip = {
+	.name = "PLDA PCIe INTx",
+	.irq_ack = plda_ack_intx_irq,
+	.irq_mask = plda_mask_intx_irq,
+	.irq_unmask = plda_unmask_intx_irq,
 };
 
-static int mc_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-			    irq_hw_number_t hwirq)
+static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			      irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &mc_intx_irq_chip, handle_level_irq);
+	irq_set_chip_and_handler(irq, &plda_intx_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
 
 	return 0;
 }
 
 static const struct irq_domain_ops intx_domain_ops = {
-	.map = mc_pcie_intx_map,
+	.map = plda_pcie_intx_map,
 };
 
 static inline u32 reg_to_event(u32 reg, struct event_map field)
@@ -609,7 +613,7 @@ static u32 local_events(struct mc_pcie *port)
 	return val;
 }
 
-static u32 get_events(struct plda_pcie_rp *port)
+static u32 mc_get_events(struct plda_pcie_rp *port)
 {
 	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
 	u32 events = 0;
@@ -638,7 +642,7 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void mc_handle_event(struct irq_desc *desc)
+static void plda_handle_event(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	unsigned long events;
@@ -647,7 +651,7 @@ static void mc_handle_event(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	events = get_events(port);
+	events = mc_get_events(port);
 
 	for_each_set_bit(bit, &events, NUM_EVENTS)
 		generic_handle_domain_irq(port->event_domain, bit);
@@ -741,8 +745,8 @@ static struct irq_chip mc_event_irq_chip = {
 	.irq_unmask = mc_unmask_event_irq,
 };
 
-static int mc_pcie_event_map(struct irq_domain *domain, unsigned int irq,
-			     irq_hw_number_t hwirq)
+static int plda_pcie_event_map(struct irq_domain *domain, unsigned int irq,
+			       irq_hw_number_t hwirq)
 {
 	irq_set_chip_and_handler(irq, &mc_event_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
@@ -750,8 +754,8 @@ static int mc_pcie_event_map(struct irq_domain *domain, unsigned int irq,
 	return 0;
 }
 
-static const struct irq_domain_ops event_domain_ops = {
-	.map = mc_pcie_event_map,
+static const struct irq_domain_ops plda_event_domain_ops = {
+	.map = plda_pcie_event_map,
 };
 
 static inline void mc_pcie_deinit_clk(void *data)
@@ -799,7 +803,7 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
-static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
+static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
@@ -813,7 +817,8 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	}
 
 	port->event_domain = irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
-						   &event_domain_ops, port);
+						   &plda_event_domain_ops,
+						   port);
 	if (!port->event_domain) {
 		dev_err(dev, "failed to get event domain\n");
 		of_node_put(pcie_intc_node);
@@ -835,7 +840,7 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	of_node_put(pcie_intc_node);
 	raw_spin_lock_init(&port->lock);
 
-	return mc_allocate_msi_domains(port);
+	return plda_allocate_msi_domains(port);
 }
 
 static inline void mc_clear_secs(struct mc_pcie *port)
@@ -898,14 +903,14 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
+static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
 {
 	struct device *dev = &pdev->dev;
 	int irq;
 	int i, intx_irq, msi_irq, event_irq;
 	int ret;
 
-	ret = mc_pcie_init_irq_domains(port);
+	ret = plda_pcie_init_irq_domains(port);
 	if (ret) {
 		dev_err(dev, "failed creating IRQ domains\n");
 		return ret;
@@ -938,7 +943,7 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
 	}
 
 	/* Plug the INTx chained handler */
-	irq_set_chained_handler_and_data(intx_irq, mc_handle_intx, port);
+	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
 
 	msi_irq = irq_create_mapping(port->event_domain,
 				     EVENT_LOCAL_PM_MSI_INT_MSI);
@@ -946,10 +951,10 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
 		return -ENXIO;
 
 	/* Plug the MSI chained handler */
-	irq_set_chained_handler_and_data(msi_irq, mc_handle_msi, port);
+	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
 
 	/* Plug the main event chained handler */
-	irq_set_chained_handler_and_data(irq, mc_handle_event, port);
+	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
 
 	return 0;
 }
@@ -977,7 +982,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 		return ret;
 
 	/* Address translation is up; safe to enable interrupts */
-	ret = mc_init_interrupts(pdev, &port->plda);
+	ret = plda_init_interrupts(pdev, &port->plda);
 	if (ret)
 		return ret;
 
-- 
2.17.1


