Return-Path: <linux-pci+bounces-5320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6648288FB01
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A71E1C2BB04
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E8B657D3;
	Thu, 28 Mar 2024 09:19:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8127265194;
	Thu, 28 Mar 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617543; cv=fail; b=WiNBe/r67AeT7U66NNm2C4X+pIwPv5j7FYF1r3hsR4nF5o91cm8nPw8al2Gb02U/Z0VsvMb6xfnpa/ZQItBm8nNQH4r80E0ZKS+OSEWOIaxL3SSB+ndjOi6FnPPW86OQozcgfSBkX/8jXxFx7gwz1TVABgmHAbiea9vcVVs7Gn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617543; c=relaxed/simple;
	bh=0btT0+1iFrRCEvfDPJYv5+lOHpsQmKWX2HlBz6kKQlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LBDUti52tqxNFGk44muOqN4ZdVRfgk/9hU0vbJRIXuk3Xhbm/iNJuaSiiy3Ti973tKSfjuOsluD+Zwh0wGm2CcI1+f2nmUrTjbMkzoViE7wun9cYsfS3Ak0y6ZYtw0X92MnusaoKGV+4Qb4mYwxyhSrq7FG0z0T4K+J+eqzr/0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyjSKV1Hhs5ShSFiUNhYDb8Xq32M5pI8IBbEHDaQgMoVvNBoAMT/JvcNsPy27Zz7A8tuowsrx/NhsWgUrxm7+soNGfv8rrOIOOkXd5VNbeNs8aKmXvJCt8xmBXdLRuhZlNXHsaaGG1FZqQBDcCVi9aV9wUYOq3wUvieE8BU8/k+GcWJWNRYikHh3EvE7nuUuSDWWwa1Q4JXwrRZx//plzCOtS5XY8MHIhj5NvAWHCvDkIiA/X9M4gJZOGH+STTZ+rTf1ccTFWh9dGAEe7NAzNRNrWZfB766uF2ixea55Ti4M8huhf+3Tc/dvSf5KPY/ttcJiVmu/L/QScoqmGOK2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DArdH8siR3MLqlRp5UbWIINNuoWS11KuX63fEBpRg/E=;
 b=grvUmEEYCE323Yz2BCG0X+Q6LPqWQ9GU/V89ZewLlJ+2wSQBPKc1qKQOuoWPDFG4rBJjv27cuWCsbiWX/3q7Kgd0AxPEwP/lVKtRoAwu1fj9CLPFgUuimmyNjGlaCoRyUzzZxo1hOCIzUcBZkqV24LwIp/T9kbxu3JW49R06MZUrNXjOC1mzV/Q1AR9I3GOxLnLCHRbgkz4H8f5pb3hf/LXeoEaiDUElJsm0R9rjrmiXKLc3a0Cy3VqJcpbKMKgqI6K+ZD4rSrJ5rMCo10L9SbPLJL/b1RPub0n8FHP1MUe7yjsBQmI1WZucyDyxxJUip93yc2u4DJdzoP7Fs+WAaw==
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
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:52 +0000
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
Subject: [PATCH v16 09/22] PCI: microchip: Move setup functions to pcie-plda-host.c
Date: Thu, 28 Mar 2024 17:18:22 +0800
Message-Id: <20240328091835.14797-10-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 418e8d19-a7e9-4d7d-8693-08dc4f081607
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q8RP3F9ksB5Wbmfa2gcUTXKfN4r0JsDNrSTVHcXiiZAzOloDRDdvnMG8HHEJ/rhPrA9CLACenagjHcTMu2UzmTLJvxINvDKPgnE2gyt9uxIajAsLNEjCQGvAdKskYGJsR1zRKNkQl3rGFL2byhEdqd9DIvDtHsG83+OzhQVsDqs9dxcMwmswPULSYZLGfFlokl8ikp+TRQhxZPdcQDyu3e1OhcvWwP7Z12PYmHNVGI2S8dN0khNCBA7lCxf/LEATOF/Gmj6h/SXYvG+wP5+kZHV5/BiMOBOkeW1pM7gcJj3zEvmAM83LwKD4h+Qm1jH0lFoObT47+dZ2zqET9VJ6kTECe6CuYSlGmZq0+/pYfKabMHza4cZUEcfNMTrlwzA6ALvRS8YpI+tV2t34/V/JYqIqf1fIRXCMQUSDVD1nltK/ojcVT+ZWW28BHahzZjLltXZDYnE4oeGJYWdfNx6k2FwDDXEMxFwCe8d0uEwlk79NC/HxJGR6CAiWUsC0A7QFfMqfPvhizo4jgO+eNeCYgXL3mbExulKWXZJZ2V0ZjzgD7FmMD87l/KK6DEqvCLUN2nFZlosXDTlnKcJZZGS1GZVdczandErN6DD0qGFMALwrlM/fodbzWZ7WUHYrFXCj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i5onzeOkAIegMHME5sISD3J0dtVwI3i/9yFpASC+bw5CuPnTqyBx8VY063kk?=
 =?us-ascii?Q?H5lR1FOMZPs9BxsprjzXos99Ska8wyAx2E0cfHbR8t2zuhFVU3WbEuyrG55J?=
 =?us-ascii?Q?bzXcgS1y/4Z0ZHGgTCiUwXa7m9sKCzgVFEhaJ8ceRLkvEfZUwKaPAA91oWbu?=
 =?us-ascii?Q?QfknRDPns2loDeGuMB1f+LQYyX8+gUMlyxCDS9+WKjVzzqK0IjIuIHYIwdgX?=
 =?us-ascii?Q?0wY1zFMXfTKfKRruI+9DBXCXPsbCgjouvD7ECiMuxyDJeu5X5G9AVZG+KnEf?=
 =?us-ascii?Q?tjkVZns4x052GVWwRibE0KiQ6ybw8313DTT7H1xOWi+WJJ/+XER2uy3rMAO6?=
 =?us-ascii?Q?COOA7W5q4OOrd4vn/cwOc2PcdiAWs8UNgd5yZYmyNBwD5yxVxSoZQQPItcK9?=
 =?us-ascii?Q?0nVoIAcwxfYJUzdjiPZMlUKmgS4jy4WMiSm6I4V1O/rEfvtO7S85CwK+Q3hF?=
 =?us-ascii?Q?l2b0tscDu0A1Bo2vYyCjPpEGi/9qeoC0+3xgDk5v/QQ8Mj4Tvyw+ljIyGmCj?=
 =?us-ascii?Q?NhcIvL2ZCx0gezbC2qpaf3NSt0baRp95dBnVNSvNLe68+RAn9VTqvqdrwJBC?=
 =?us-ascii?Q?g/7bdm8nEFBW9PXB2ll9pkSRZaBhxarVkeYkcoNJwyhgNRWohTFYKf5L+oJP?=
 =?us-ascii?Q?NF31bOqyuRk2d3xbHdlid6fn7iuD4SQapEytPet5oMVv6x7lo7anQrGrVPcq?=
 =?us-ascii?Q?n6FVU0ppgw8kRgPSydMQWyIv3d/fkfv0doKy6SnAiLHVHYJRVbIjfCc2hnge?=
 =?us-ascii?Q?UsI2wGWD7MXOnzW0XW1GbzEyQfq1SdyCcOb8Jdx4sgnqFfKP7uJiGnQ8+QOn?=
 =?us-ascii?Q?damaCWfIMaxGSwer/cJW+XuLUg2koU22dDM///RVXxWL1V6JesXlqUzTJOyc?=
 =?us-ascii?Q?Lr1RKXnksTMb04x7gIR9AMECel0RHRqqm9vy0QeK63NCO8X/QU/L4Gtfck7O?=
 =?us-ascii?Q?VIRldC8wpE1lp9rtDiMGnfYINyuNo9FS+gkd2mEhJrLi4/sQN9YOr5oIO+az?=
 =?us-ascii?Q?q8FQQfk1ZsEmwU0/03WfW9U+128qQmAwWA56xaQSXuRVY1HaVfLQBUxk00+a?=
 =?us-ascii?Q?TfcLcZhEunT7IGrqbcelhgAN3+efXSFNVUyXPUQBxmiASd+Zz6sj7nOaSjAN?=
 =?us-ascii?Q?sFFj074b4mq2JPCtHyjYlxzudblPHPX1ZikMO0k65QtzZ6szz5PxLdYUGSXp?=
 =?us-ascii?Q?dERUBRfrKMQ1Gz1XRkLYIK0P2z76ZM6fzw7pAopB8W+yh+ECABYONnD3vpof?=
 =?us-ascii?Q?fS7wh1q0IFVHDjZutC4BJWju4mT1ZxQlobzoBcWtssrAFA9qQX6WOZx4Hisj?=
 =?us-ascii?Q?2QG5jDn7gHuVw4q6NHFVpR4mwWTq9AqtqnB2n0USNMLYx9tSWssS/LriPR2G?=
 =?us-ascii?Q?4BxdiB+/7lGDn/qdrEkInqcBiyp2QHq3FTj+DI3soxXodNHH1C518XxrbJZr?=
 =?us-ascii?Q?4u1TFdEX0mbDwY2yql+R7QvLojecvpf0jIAztGGOQeNRD8Gk/HnXg5zu0v3V?=
 =?us-ascii?Q?qHMk0Mk0V07FEOZsijjp2rjOFNHW8im6ZHW5qiqMNadLQlVwyyowdOvEuEBi?=
 =?us-ascii?Q?fsCbUUtrlQA1k0QGFJypAhF4TlsZEIWWaPOdY8JkUowwOyKQdaBqCKkiuLit?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418e8d19-a7e9-4d7d-8693-08dc4f081607
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:52.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBy4RtaThGybHv6cBvf5LkgTSK2KGfvd93slSOzZ4RB70nIiLUUm2y+8yiYw5S3C8VyRuFfIVCs1LLfE4grJKSW8EMjlVZwc6gi1ZWwWjPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

Move setup functions to common pcie-plda-host.c. So these two functions
can be re-used.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS                                   |  1 +
 drivers/pci/controller/plda/Kconfig           |  4 +
 drivers/pci/controller/plda/Makefile          |  1 +
 .../pci/controller/plda/pcie-microchip-host.c | 59 ---------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 73 +++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h       |  5 ++
 6 files changed, 84 insertions(+), 59 deletions(-)
 create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fa4d61291f9..d85d9db38efa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16951,6 +16951,7 @@ M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
+F:	drivers/pci/controller/plda/pcie-plda-host.c
 F:	drivers/pci/controller/plda/pcie-plda.h
 
 PCI DRIVER FOR RENESAS R-CAR
diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
index 5cb3be4fc98c..e54a82ee94f5 100644
--- a/drivers/pci/controller/plda/Kconfig
+++ b/drivers/pci/controller/plda/Kconfig
@@ -3,10 +3,14 @@
 menu "PLDA-based PCIe controllers"
 	depends on PCI
 
+config PCIE_PLDA_HOST
+	bool
+
 config PCIE_MICROCHIP_HOST
 	tristate "Microchip AXI PCIe controller"
 	depends on PCI_MSI && OF
 	select PCI_HOST_COMMON
+	select PCIE_PLDA_HOST
 	help
 	  Say Y here if you want kernel to support the Microchip AXI PCIe
 	  Host Bridge driver.
diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
index e1a265cbf91c..4340ab007f44 100644
--- a/drivers/pci/controller/plda/Makefile
+++ b/drivers/pci/controller/plda/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PCIE_PLDA_HOST) += pcie-plda-host.o
 obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 805870aed61d..573ad31c578a 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -838,65 +838,6 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	return mc_allocate_msi_domains(port);
 }
 
-static void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-				   phys_addr_t axi_addr, phys_addr_t pci_addr,
-				   size_t size)
-{
-	u32 atr_sz = ilog2(size) - 1;
-	u32 val;
-
-	if (index == 0)
-		val = PCIE_CONFIG_INTERFACE;
-	else
-		val = PCIE_TX_RX_INTERFACE;
-
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_TRSL_PARAM);
-
-	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
-			    ATR_IMPL_ENABLE;
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
-
-	val = upper_32_bits(axi_addr);
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_SRC_ADDR);
-
-	val = lower_32_bits(pci_addr);
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
-
-	val = upper_32_bits(pci_addr);
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
-
-	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
-	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
-	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
-	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
-}
-
-static int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
-				  struct plda_pcie_rp *port)
-{
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	struct resource_entry *entry;
-	u64 pci_addr;
-	u32 index = 1;
-
-	resource_list_for_each_entry(entry, &bridge->windows) {
-		if (resource_type(entry->res) == IORESOURCE_MEM) {
-			pci_addr = entry->res->start - entry->offset;
-			plda_pcie_setup_window(bridge_base_addr, index,
-					       entry->res->start, pci_addr,
-					       resource_size(entry->res));
-			index++;
-		}
-	}
-
-	return 0;
-}
-
 static inline void mc_clear_secs(struct mc_pcie *port)
 {
 	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
new file mode 100644
index 000000000000..05ea68baebfb
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLDA PCIe XpressRich host controller driver
+ *
+ * Copyright (C) 2023 Microchip Co. Ltd
+ *
+ * Author: Daire McNamara <daire.mcnamara@microchip.com>
+ */
+
+#include <linux/pci-ecam.h>
+
+#include "pcie-plda.h"
+
+void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
+			    phys_addr_t axi_addr, phys_addr_t pci_addr,
+			    size_t size)
+{
+	u32 atr_sz = ilog2(size) - 1;
+	u32 val;
+
+	if (index == 0)
+		val = PCIE_CONFIG_INTERFACE;
+	else
+		val = PCIE_TX_RX_INTERFACE;
+
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_TRSL_PARAM);
+
+	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
+			    ATR_IMPL_ENABLE;
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
+
+	val = upper_32_bits(axi_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_SRC_ADDR);
+
+	val = lower_32_bits(pci_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
+
+	val = upper_32_bits(pci_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
+
+	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
+	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
+	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
+	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
+}
+EXPORT_SYMBOL_GPL(plda_pcie_setup_window);
+
+int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
+			   struct plda_pcie_rp *port)
+{
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	struct resource_entry *entry;
+	u64 pci_addr;
+	u32 index = 1;
+
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		if (resource_type(entry->res) == IORESOURCE_MEM) {
+			pci_addr = entry->res->start - entry->offset;
+			plda_pcie_setup_window(bridge_base_addr, index,
+					       entry->res->start, pci_addr,
+					       resource_size(entry->res));
+			index++;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 9ca66916c609..e277a5452b5d 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -126,4 +126,9 @@ struct plda_pcie_rp {
 	void __iomem *bridge_addr;
 };
 
+void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
+			    phys_addr_t axi_addr, phys_addr_t pci_addr,
+			    size_t size);
+int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
+			   struct plda_pcie_rp *port);
 #endif
-- 
2.17.1


