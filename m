Return-Path: <linux-pci+bounces-3690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F1F8596BD
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 12:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F971C20B89
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A1463123;
	Sun, 18 Feb 2024 11:53:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2090.outbound.protection.partner.outlook.cn [139.219.17.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831BA633E8;
	Sun, 18 Feb 2024 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708257187; cv=fail; b=SkExeDawNbOp09PGrBvluUyDuXd7nHILXYq6nqpIe3EFjQz1GKAI2crqZk2fZ+Brcs4Nd0ObMAqCLNV9jCpUQSuCRgDBfQv6Gwe8nWLds3AbYimzpdNUQqVuq1Ibd+d8kjKO4qRpif+AYkOYCbzY7Pnef9csxxkqFgYxQtGfiXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708257187; c=relaxed/simple;
	bh=6XCwz752cqas94FR5RuhUpZl6UqCr7+eaQv1gJiOKZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QhM5b9vQE44/ReB/XgS/uaUOLKbg1SbzrMNRQ7wJJyK84C0pIewJwBWpiVV1XX4QDS2nh17m2yw0cO8lDIRKQCaXhceNjNV9330KIHDcIalg8DUyxLvXqi4w0dyC99sea0P1Rsc4/6SGZgoYIT/7t4TuqYJV6lmRRPkNWEh11o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4BVq09jU/iFVJVNh2NJk9WMIdT3nzdXM1Yom3tlG1VTGwXBvC6B3hDkISZqJyISHo4Wxa8pnIburTgS0zy1xRJRQzZB/AzVY/p523hl1jgRuPSPfp1DREWJb9meV7FiT3Wv3bn9E67ysVp3aV/xEae4vns6eew+Tz4sBOSs0A5Ur2luMt7T6U4X9KYPredTPLqcmV21v3Eyy5p3YwpqQRUD6je+Hr3674NNmTlq+jodm4KCXXR6pMPYhXpPyrRy4oMMVBVRqrMH0bp98nUowlUbeuIz9jAQ4O9O/CkMA1oETwzZfMxvNzN33sNwOvIEzv/Gp3hj2RKY3fBWLdjY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQxZhsQtPCBTQ2Z4oxeeYTZYEbkQfql9Jw52WhQ5GP8=;
 b=iwGpThkEnXRNn7Rz9sB2rZFmTWKDDneCfdUAywPku+wIH0GIPIF6vgRTc+Y/lw1ut+hpoEFEzs11XB1VyLTKGsKzrab1NPNI935txOE931pB+A0YYn8gCp/c29iaq7oUHM40B1aZUBHy5AxwLGEEiEzQ5XeVIy5Af+ooMvZzKGiBoo5QcAbJSpKrPHqcBS/W1/aw+5lwU3hoDYoQYOyB6v26UGI5p3dq5yOHX2wELnyF+a8jp0irNVUDpCwYKgT9HhSzzBqcbbtZM9+KvYTYrxG5pYIW8VJXB5sEIg9dhhbi/s4UjGpVAIwzt4m0lmSH5voM4+9fSV8vF+2j/jSPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:17:44 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:17:44 +0000
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
Subject: [PATCH v15 09/23] PCI: microchip: Move setup functions to pcie-plda-host.c
Date: Sun, 18 Feb 2024 18:17:28 +0800
Message-Id: <20240218101732.113397-8-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 495fb8aa-6333-48ec-f7e7-08dc306ad8fc
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vU7+cZmEtfWJcvmfF0vwK1CDy+WKWa4DoNqfzAp7O0N6f9TTILzGkiBS3/odwRVhokDLOsQURqHDYwewFqipleHjVN0oUr+ql7xMlAAgooZuniF6qi2PUfZFsltCOrbOJp0sxi+ARllyS+QiCMKKaEL7JGb7hpVnXhbZh5twyVreNq6DEc/FJmcvFZ9CkvPJlNtojqCEeRfCrOVKnnB2bLkqWlFxjXZjXTRQwL+6CD6Xef/Doce+QC+NFru89IiNawxo30+Z6EGkkwzYLPpiElctkdwGjvX90iOJyne73TYn7hHo7pTkfi9b+4233UBPPAdgceJWAAmhuH8Nmm8yOQMXHN0X8kau4QB/HWwDRHEQGaXsaIQVg6Bkj76mvkik4R7NhmFvA1IRs0rS77z3r7oAOdiS411t4CNm1TrMBlmKBBWNw9aYPilf/KVXHRVCPBFPsrmWQAR8QUhcGP0DQ1SBdIlK8ttXLMb5cpbpx2O7qDwkctnRKBNRdwCQTbY0Rq4cJ6VsHHI0XpYQ3c1PF1KvfUgvCuO++ueRizr8y2c3DeKu8rqAQ572gAwkOgp9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(7416002)(44832011)(41320700001)(26005)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZADZzMn2IVfGot4Zh/vR29+YIJtY3ZTHL0WZjANOG0mBpdRFsq6PZ2oUQNOG?=
 =?us-ascii?Q?clREweEMuH1bXu/mHXKkqIH1TbIUMH+piz+q1mQVAjSXi/Bj5QcijirSNArQ?=
 =?us-ascii?Q?mk9DaLmnT/BxgcWZS9wgruLNWXRWoOIQ16dzdgG9jetySlRtJHaJrefnwo+G?=
 =?us-ascii?Q?+VhLp+pORBdU0DFb6N3VryJb9HCi71yFPfSg91IBOCWmz5W2/Aa8Qd/qhFYC?=
 =?us-ascii?Q?TwEcrYm+/+cFbMSStJOHuoQ45RRqGubtnZ6J7xmCSfCPTdJywHHHrvxQODBL?=
 =?us-ascii?Q?mJdGbBp7XjZbxLD/mrtzfMVrE2wquXIrYC88zjP2DypjM3aHX1bhlSJ68LPa?=
 =?us-ascii?Q?49csG1h9HQO8MrLYALw63WQBPx5UgIj1pSIvYd9Yt8T4S1L1iqhe32Hv+T4i?=
 =?us-ascii?Q?hwJWutPsAZUmDth1EZtjWYPkF90XywGteQqzKeqIbiZ+VW4FwzZSiNY8hoVd?=
 =?us-ascii?Q?Jk5iRk5M0m6t/m4hfiFEUj+BkhQPSSwPyBJqOAlnSYC5YxL7Pkg6SnKbFBq2?=
 =?us-ascii?Q?hW/bMVZaShAV5Dg1/fDpWmfZWtfCK2uqxDkewU4ge+Pen1GmIWOPf0Jye0Nl?=
 =?us-ascii?Q?0bTPEECPVhXjcYq3+cADNRqot4wQM9vM+JztMdf3uCuCiSjK4M5/enLGNnG5?=
 =?us-ascii?Q?G+L0+QE7rbD4383CrFASzUk/VMDUJjanDBWiUwGYdqwfliGPKn5TUI1iVYkV?=
 =?us-ascii?Q?ujdztawg+9YHa9s8bDTgo65i/OpfnrI/YmokTzRrgScqfHx9/gBVyCiWpDp1?=
 =?us-ascii?Q?K0Dm0qlZOTKfqhxXhPMXQE9IWBIUeAKFJg6/+ZMm2y87ji/kpxUd1Zq7mR5N?=
 =?us-ascii?Q?h4SJoL7xM1pHXlPIIVHOB4dd+xnjlAK+KmrUb4s6Wvt3oLmJoyZo9uojHfHr?=
 =?us-ascii?Q?AN9BAeC8SwJKgtBW8jALZyHsG/OFQjuzo5caBU6Z+P1RWqC7EY6mgtwk7h74?=
 =?us-ascii?Q?zw+buhMfYdFF+uVtKueUKnecNuD6UhWwmuH6o5WBTy4dAcS7unzLnmPfvO02?=
 =?us-ascii?Q?Kf6A9KUxPD6IiaqXdxWLmH5NJYi7D+rrFyzXGuhC+Wt8Nx6Oia9pC1d3216S?=
 =?us-ascii?Q?nYjoKql8tv++1UWoG4Pp7BTNEDtbUAf4JoZ2UUa0atmwDwbC6Y+CcMpO2/Qh?=
 =?us-ascii?Q?9wqDylHudwOKKlI7hPb6l266YytINGub9UGFWAeF1wfYuiTHXsEZn8kX89kj?=
 =?us-ascii?Q?1m/ixeKFDZx0r+r80UkYYok797yBdlEPltCNXMt2VNKs0VS0mgGv9oS4+KKR?=
 =?us-ascii?Q?WrZYcArLw+UTgu/T/PoU+S9RWzxcoM4tb19/d5MqFDngGQGpuRtSmI8bjUvu?=
 =?us-ascii?Q?ql4QRcu3jwkGfHxTBtU+iFUC9q6TT8cTkzXx0U+j0Eeh2tGQ9gmnb5c5SNv2?=
 =?us-ascii?Q?nMD6dhhpjaqBEfsRBBQecgAq66eVZsXMcyJdoylGQIxzXYKItYtjxoDTkQQH?=
 =?us-ascii?Q?qtJvPNRqQdSsC5rGpxS0DxiQCyNKZgmIvNhtJBbRv4gB8PVCb7p1eiamQBXu?=
 =?us-ascii?Q?aiNuwl9O6qMTyff+L4L+zMXeKzl0JpK3J9ywgliaTSHYpkGptT/cFQPN4HpR?=
 =?us-ascii?Q?sw7PsoSLMyiJjflEv4CSs2Lp/p/kMAm7nGKcjdDYjDAPqw1MTKYRMYgiXDZ3?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495fb8aa-6333-48ec-f7e7-08dc306ad8fc
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:17:44.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eepIrag9pJKJYUesSYer4JXgXdUTa7sME/8CnxxdIcsUZpvNqPYVkighKyt/ZeT4FpoN635BQZksT+kIJwzRKD6/aw8DNEfr8mRRGEpqFP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

Move setup functions to common pcie-plda-host.c. So these two functions
can be re-used.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/Kconfig           |  4 +
 drivers/pci/controller/plda/Makefile          |  1 +
 .../pci/controller/plda/pcie-microchip-host.c | 59 ---------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 73 +++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h       |  5 ++
 5 files changed, 83 insertions(+), 59 deletions(-)
 create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c

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


