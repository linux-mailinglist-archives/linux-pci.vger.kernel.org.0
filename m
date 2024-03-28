Return-Path: <linux-pci+bounces-5336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D594F88FB34
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BC129D319
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3524F65191;
	Thu, 28 Mar 2024 09:19:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2091.outbound.protection.partner.outlook.cn [139.219.146.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B88002F;
	Thu, 28 Mar 2024 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617561; cv=fail; b=CLpzTlZ+8wa4/pcV/A9+4rbzA7KzDDxHy2sgMdP41IUYqNKTNq0odKqtyGO+p8g2lHURptKRzIJxyCBs3ot+xKU5IPAvy8KuISXaH3RLv6Mp/xOBBMbXWH6MN5WeWB46Ju6muDhQ7kG4Udx3zSGzn6YTdQqZG1WaWgPLLWCiy7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617561; c=relaxed/simple;
	bh=cKjN0WHAuESGn59cTMIox9hU3M2BhPOHtOqCYnITk5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufFenuwbGEBaKeNC9Kdl1rmBMzwl+vnWFNxhPvnNoZaYjkbAKiywmO3FePwiFS6mnF7QBdWwNxFR8S54OQh7L/yGKV/c8aGg7j867EqcyXVi7/BhU5TI/Esq7MYXILG4Duk6XBOKOMQxmOdBgqem3to1uaRaoBBrSeAM1oyjy+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+2ApI7PFS7/rr2i8Te+wP/yrY8spQUdkOgXCuYIJrpL4sbTHQ7Crba14DE0MiWdfkO83p4XM/IIH4D44t/O/bOUWA4xENthK+DbvJKUxh4RjPOjD5GsnsoFRHSJDxdyHk9CDOY6Ir604eLcZfnJ9tm9V8HHBxl7T34Jz37olR+fKAh2OQAK54n/L+wFdCAvIuwpAGXDYa3L3hW5pqx58z03CLtcIFFEvws2JYUOZBqkQEvxhSneR+ApmuohMlLfvGnUXTSDZbKSLojBN6FWWr7egyUI8zRAetyeBrBNxzGfPTHhw6Pg+qc8zMs7vUcvQcQ1JWT2JIjUvPjWJWCC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCcyqE0iXQVHf+lT2xT+xNvGQICy4SVXDLP+vaJn6ds=;
 b=WubqGtYCSyiHitPYa+YCOSt9UMZSVa4nePUaVjI3IghBCQIozcSAmZJDNXIVG+ARdMK4Kcln+0eRHjlkwz99LRW7HDFlCkaCHv6rWCHx9TQPZ5C1U5LDGpi0Ubu6n6zm0IWleV0eg0DS95ZtjRZQ2ZyIPH4P47RgiBsZRoIZTT7YkXnug+m9R+vJivsthRLKrrZU8JMSLFfJv48cqSfFq1CxkSuC7W0FmkB0kbQzoOBChdToAmR/seMcmJmaXgybsHZf6ra9sMW/4Snp821BxKEyNAlpeU45eV/Lpw8w4V5jfxEpYTFU7oYFnSDxeuA77SFgI0aV/nyBC1YFtr0iMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:19:05 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:19:05 +0000
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
Subject: [PATCH v16 21/22] PCI: starfive: Add JH7110 PCIe controller
Date: Thu, 28 Mar 2024 17:18:34 +0800
Message-Id: <20240328091835.14797-22-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: b869200f-e1b4-49d4-d121-08dc4f081d49
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m5epnUvA7NrnSj+blEKxHftAuVPiWRx2E/KYOCxiwKolb5ezAYcOoW9zELH9NqZtyFpcTMQRlM4fuDCrCE3H78fv2cujAC4bfWv/LkDueZJzGO0wV1tu6ynwh0Pm/ek4slbkxbpXu3EhnF4eYycrHUrihv9Z0opZTfu3VkMXHK0ul3oDcz3lGf8/rj/laAjaG0UXPOAAZvgiTrVxaigaGmGwSIeJUJnCYGATGmCIoW5ed9xLcz8tmtvAXJY3JkELMP90ItFQu0LlO9jOOxOy2CADVsrFb4j2IV0IgNK0cnDJdRncACjkUxr+ATjUHaUGn35VAGiWirst4xlEI+nnRKq2lR9GowxkNWxhSWsqhNpogntWYJyikYShrCxY0LhKqOJLTd/4n+evdxoXlwMVrduVQtgCTBnRKxO3iB4LlU3YygwRqrwFs7ZdA8GimfJIWfaHAhQ8648n4tTIfd/OCTHJ7CMhxdtSsA4f+PnuUBWCsdWIJF0mOzDfz/bbpobEmkpxBFVk83tbdT4KFXijuFfFh4niosgqVXn1rZI7yQ1iQsvl41WUJJiHBA+d4q2ePTJKzRotN2ltSgohw2rLi7dS/UI1uKV9hs+EGrUrbVIG1y4013uH7J4ed1dfe13U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/gXV0eBcqfegdp5yLEqo2bPraFQ79QmomDeMiLA+gGbGgpnPezSPLRnAsQmP?=
 =?us-ascii?Q?lQNE4pWCPZ+Vy0Vdd7vdJ3tRz417TeDzQWYQcdZStIGrLSoMBAA/qfugXhZt?=
 =?us-ascii?Q?+9WeR7Zak0oSBJlOylNNpz39VfZW35YkIcJy8Wj0vnVkbdCwOpTMPMozQ7GN?=
 =?us-ascii?Q?MKBvBuz+aPdkt9i7xKd/oj8/q6KmDKFBxTPnv2DaeSFE0KyuvbtfKVlkHfDu?=
 =?us-ascii?Q?HDtqToKOyepPygxjihp6gPlYuvxy8950qN0OJS7ipqJMeOwwcI0XfE+hI92A?=
 =?us-ascii?Q?xzG5HsuJkgL/8pw3HoC2wZaCGrGk2DodfpWz3sO9fkxqBaeB9wz3OHawx6rv?=
 =?us-ascii?Q?ius+4lRNKzG+0KHhW24MQKBy5Oa9pCTWy4OurRKEKudSz3ywDkNFJpCdfKHa?=
 =?us-ascii?Q?RIFW83IjiB0O7acN9XLsHU8/sM3hyqtuBF6VqAApUaXzoqnWC77Q9DDOES3c?=
 =?us-ascii?Q?6/V438uM5LhbftRT4CjM9Yyl5NkCRycIlVcmnoCfxZqoD3F+GV1xgHhgFAJC?=
 =?us-ascii?Q?Nj2Xf9N8uP8GwgOZcfUGMiY0RxjxsKfgfDYSFLzlAR4ZvDvo+6JmByMIE8U4?=
 =?us-ascii?Q?yW6C5e630hJSWHKBKrAaDQLG0Fu4YribMGFosFB+Q7jvuw0MXYtCkv2kWnlf?=
 =?us-ascii?Q?vOT4CGqXNSzIzRfJTyQpPjU7tpDFKL9NIG4ABFj7qWHRymIdo0kTisYwwWmV?=
 =?us-ascii?Q?N1tyOH7QXcUUI82SlZBJUjzpQ43aRdg+7TGM6Nwi+mowBytxIrmBG0JVXyTO?=
 =?us-ascii?Q?RY4wOt+Mrnz/VCr/JXkuHi4sgiPD6rGka4k8T31F5nITudjfaI+nEEc7L+Zh?=
 =?us-ascii?Q?FGL/9q8Se+9+96eUchWpMFFZP3ajZR6aNCeDWF6iNu39u49pBFU/D8VNZZSU?=
 =?us-ascii?Q?rhj6+/vvp1v2yFOp9n+EfAFwkTalw2YYzuArCgnsOpI/rBo8ebjs6w+AdQnN?=
 =?us-ascii?Q?fMireStWNvpMipZe+YS3hklk3Dxy4TXNVxqwXi0aUpj271dkhpfyB/2TTnaz?=
 =?us-ascii?Q?qsxvX/DCW+l+MHuMcn67TK9MwT/R8PMyJmMxKSl57DHV0XIStsEEjLXMY08N?=
 =?us-ascii?Q?Egf3u5p5bypRYRR9PFaySTjm4qEOdsmk6zYCt0FTRwq5pn1BCuCBPcTIOr1R?=
 =?us-ascii?Q?PsuKhta1Jx3cXiHV7MtacokLIqVfWhCRlEeXBaxZ/BFN426R1djuFSWo8rzL?=
 =?us-ascii?Q?DVqu6mVeMnbgeMw/G1RUXXsY2YfZ/dxhueTQ7olG5Z9uT6wiPNC6rBRurqC3?=
 =?us-ascii?Q?twaz6ubfQLIdkbw/E9Dfs4bQSwlkjlCl5E7XY5TAl9SJX8oC1tlFcZvyRLhf?=
 =?us-ascii?Q?n/UEP1JBvgqibS9JhdqJEyM3CC+v5bVlm83KX5Cl2qPqM8U6h2kqfGfGqgl8?=
 =?us-ascii?Q?VcBXmkCi1unJb9SU3rk1fMA6h6UyCEFWZ9tTcHfJ5b2ItDgNCu2xrV+vSgKB?=
 =?us-ascii?Q?Nt6Ez9jVvX9aJLuDNwCrPh0a9XvcR5wPnE9qL5Yo3wDtG0ToaFzOA4qRdTa0?=
 =?us-ascii?Q?dLbslF0BHD4iwR/x72+MP3AOxf5h/EUfkM3P/Aq89VdYi0V8mLcIYR+zc5ek?=
 =?us-ascii?Q?bBkvvuYKWpS/di8I8a/gpCOfVWStmj56bpBJYEMGB1CQKHPvQPw9+yQmIEN7?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b869200f-e1b4-49d4-d121-08dc4f081d49
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:19:05.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dl89eCWLs7SXIywp4zQUPyticVVXHOKdm6AReyuHd71RlNLVCxm3NzZiARQdQjprlocEuuYIhLL/kPJLtacqERArUTUeJ0KYMkrp6UGeurE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

Add StarFive JH7110 SoC PCIe controller platform driver code, JH7110
with PLDA host PCIe core.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Co-developed-by: Kevin Xie <kevin.xie@starfivetech.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
---
 MAINTAINERS                                 |   1 +
 drivers/pci/controller/plda/Kconfig         |  12 +
 drivers/pci/controller/plda/Makefile        |   1 +
 drivers/pci/controller/plda/pcie-plda.h     |  71 ++-
 drivers/pci/controller/plda/pcie-starfive.c | 488 ++++++++++++++++++++
 5 files changed, 572 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/controller/plda/pcie-starfive.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3772f6893818..de85d6d1b92c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17220,6 +17220,7 @@ M:	Kevin Xie <kevin.xie@starfivetech.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
+F:	drivers/pci/controller/plda/pcie-starfive.c
 
 PCIE ENDPOINT DRIVER FOR QUALCOMM
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
index e54a82ee94f5..c0e14146d7e4 100644
--- a/drivers/pci/controller/plda/Kconfig
+++ b/drivers/pci/controller/plda/Kconfig
@@ -15,4 +15,16 @@ config PCIE_MICROCHIP_HOST
 	  Say Y here if you want kernel to support the Microchip AXI PCIe
 	  Host Bridge driver.
 
+config PCIE_STARFIVE_HOST
+	tristate "StarFive PCIe host controller"
+	depends on PCI_MSI && OF
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select PCIE_PLDA_HOST
+	help
+	  Say Y here if you want to support the StarFive PCIe controller in
+	  host mode. StarFive PCIe controller uses PLDA PCIe core.
+
+	  If you choose to build this driver as module it will be dynamically
+	  linked and module will be called pcie-starfive.ko.
+
 endmenu
diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
index 4340ab007f44..0ac6851bed48 100644
--- a/drivers/pci/controller/plda/Makefile
+++ b/drivers/pci/controller/plda/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_PLDA_HOST) += pcie-plda-host.o
 obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
+obj-$(CONFIG_PCIE_STARFIVE_HOST) += pcie-starfive.o
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 52f4cacf7917..0e7dc0d8e5ba 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -10,10 +10,20 @@
 #define PLDA_MAX_NUM_MSI_IRQS			32
 
 /* PCIe Bridge Phy Regs */
+#define GEN_SETTINGS				0x80
+#define  RP_ENABLE				1
+#define PCIE_PCI_IDS_DW1			0x9c
+#define  IDS_CLASS_CODE_SHIFT			16
+#define  REVISION_ID_MASK			GENMASK(7, 0)
+#define  CLASS_CODE_ID_MASK			GENMASK(31, 8)
 #define PCIE_PCI_IRQ_DW0			0xa8
 #define  MSIX_CAP_MASK				BIT(31)
 #define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
 #define  NUM_MSI_MSGS_SHIFT			4
+#define PCI_MISC				0xb4
+#define  PHY_FUNCTION_DIS			BIT(15)
+#define PCIE_WINROM				0xfc
+#define  PREF_MEM_WIN_64_SUPPORT		BIT(3)
 
 #define IMASK_LOCAL				0x180
 #define  DMA_END_ENGINE_0_MASK			0x00000000u
@@ -65,6 +75,8 @@
 #define ISTATUS_HOST				0x18c
 #define IMSI_ADDR				0x190
 #define ISTATUS_MSI				0x194
+#define PMSG_SUPPORT_RX				0x3f0
+#define  PMSG_LTR_SUPPORT			BIT(2)
 
 /* PCIe Master table init defines */
 #define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
@@ -86,6 +98,8 @@
 #define  PCIE_TX_RX_INTERFACE			0x00000000u
 #define  PCIE_CONFIG_INTERFACE			0x00000001u
 
+#define CONFIG_SPACE_ADDR_OFFSET		0x1000u
+
 #define ATR_ENTRY_SIZE				32
 
 enum plda_int_event {
@@ -201,4 +215,59 @@ static inline void plda_set_default_msi(struct plda_msi *msi)
 	msi->vector_phy = IMSI_ADDR;
 	msi->num_vectors = PLDA_MAX_NUM_MSI_IRQS;
 }
-#endif
+
+static inline void plda_pcie_enable_root_port(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + GEN_SETTINGS);
+	value |= RP_ENABLE;
+	writel_relaxed(value, plda->bridge_addr + GEN_SETTINGS);
+}
+
+static inline void plda_pcie_set_standard_class(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	/* set class code and reserve revision id */
+	value = readl_relaxed(plda->bridge_addr + PCIE_PCI_IDS_DW1);
+	value &= REVISION_ID_MASK;
+	value |= (PCI_CLASS_BRIDGE_PCI << IDS_CLASS_CODE_SHIFT);
+	writel_relaxed(value, plda->bridge_addr + PCIE_PCI_IDS_DW1);
+}
+
+static inline void plda_pcie_set_pref_win_64bit(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + PCIE_WINROM);
+	value |= PREF_MEM_WIN_64_SUPPORT;
+	writel_relaxed(value, plda->bridge_addr + PCIE_WINROM);
+}
+
+static inline void plda_pcie_disable_ltr(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + PMSG_SUPPORT_RX);
+	value &= ~PMSG_LTR_SUPPORT;
+	writel_relaxed(value, plda->bridge_addr + PMSG_SUPPORT_RX);
+}
+
+static inline void plda_pcie_disable_func(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + PCI_MISC);
+	value |= PHY_FUNCTION_DIS;
+	writel_relaxed(value, plda->bridge_addr + PCI_MISC);
+}
+
+static inline void plda_pcie_write_rc_bar(struct plda_pcie_rp *plda, u64 val)
+{
+	void __iomem *addr = plda->bridge_addr + CONFIG_SPACE_ADDR_OFFSET;
+
+	writel_relaxed(lower_32_bits(val), addr + PCI_BASE_ADDRESS_0);
+	writel_relaxed(upper_32_bits(val), addr + PCI_BASE_ADDRESS_1);
+}
+#endif /* _PCIE_PLDA_H */
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
new file mode 100644
index 000000000000..c9933ecf6833
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -0,0 +1,488 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCIe host controller driver for StarFive JH7110 Soc.
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include "../../pci.h"
+
+#include "pcie-plda.h"
+
+#define PCIE_FUNC_NUM			4
+
+/* system control */
+#define STG_SYSCON_PCIE0_BASE			0x48
+#define STG_SYSCON_PCIE1_BASE			0x1f8
+
+#define STG_SYSCON_AR_OFFSET			0x78
+#define STG_SYSCON_AXI4_SLVL_AR_MASK		GENMASK(22, 8)
+#define STG_SYSCON_AXI4_SLVL_PHY_AR(x)		FIELD_PREP(GENMASK(20, 17), x)
+#define STG_SYSCON_AW_OFFSET			0x7c
+#define STG_SYSCON_AXI4_SLVL_AW_MASK		GENMASK(14, 0)
+#define STG_SYSCON_AXI4_SLVL_PHY_AW(x)		FIELD_PREP(GENMASK(12, 9), x)
+#define STG_SYSCON_CLKREQ			BIT(22)
+#define STG_SYSCON_CKREF_SRC_MASK		GENMASK(19, 18)
+#define STG_SYSCON_RP_NEP_OFFSET		0xe8
+#define STG_SYSCON_K_RP_NEP			BIT(8)
+#define STG_SYSCON_LNKSTA_OFFSET		0x170
+#define DATA_LINK_ACTIVE			BIT(5)
+
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES	10
+#define LINK_WAIT_USLEEP_MIN	90000
+#define LINK_WAIT_USLEEP_MAX	100000
+
+struct starfive_jh7110_pcie {
+	struct plda_pcie_rp plda;
+	struct reset_control *resets;
+	struct clk_bulk_data *clks;
+	struct regmap *reg_syscon;
+	struct gpio_desc *power_gpio;
+	struct gpio_desc *reset_gpio;
+	struct phy *phy;
+
+	unsigned int stg_pcie_base;
+	int num_clks;
+};
+
+/*
+ * JH7110 PCIe port BAR0/1 can be configured as 64-bit prefetchable memory
+ * space. PCIe read and write requests targeting BAR0/1 are routed to so called
+ * 'Bridge Configuration space' in PLDA IP datasheet, which contains the bridge
+ * internal registers, such as interrupt, DMA and ATU registers...
+ * JH7110 can access the Bridge Configuration space by local bus, and don`t
+ * want the bridge internal registers accessed by the DMA from EP devices.
+ * Thus, they are unimplemented and should be hidden here.
+ */
+static bool starfive_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int devfn,
+				      int offset)
+{
+	if (pci_is_root_bus(bus) && !devfn &&
+	    (offset == PCI_BASE_ADDRESS_0 || offset == PCI_BASE_ADDRESS_1))
+		return true;
+
+	return false;
+}
+
+static int starfive_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+				      int where, int size, u32 value)
+{
+	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
+		return PCIBIOS_SUCCESSFUL;
+
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
+static int starfive_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				     int where, int size, u32 *value)
+{
+	if (starfive_pcie_hide_rc_bar(bus, devfn, where)) {
+		*value = 0;
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	return pci_generic_config_read(bus, devfn, where, size, value);
+}
+
+static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie,
+				  struct device *dev)
+{
+	int domain_nr;
+
+	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
+	if (pcie->num_clks < 0)
+		return dev_err_probe(dev, pcie->num_clks,
+				     "failed to get pcie clocks\n");
+
+	pcie->resets = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(pcie->resets))
+		return dev_err_probe(dev, PTR_ERR(pcie->resets),
+				     "failed to get pcie resets");
+
+	pcie->reg_syscon =
+		syscon_regmap_lookup_by_phandle(dev->of_node,
+						"starfive,stg-syscon");
+
+	if (IS_ERR(pcie->reg_syscon))
+		return dev_err_probe(dev, PTR_ERR(pcie->reg_syscon),
+				     "failed to parse starfive,stg-syscon\n");
+
+	pcie->phy = devm_phy_optional_get(dev, NULL);
+	if (IS_ERR(pcie->phy))
+		return dev_err_probe(dev, PTR_ERR(pcie->phy),
+				     "failed to get pcie phy\n");
+
+	/*
+	 * The PCIe domain numbers are set to be static in JH7110 DTS.
+	 * As the STG system controller defines different bases in PCIe RP0 &
+	 * RP1, we use them to identify which controller is doing the hardware
+	 * initialization.
+	 */
+	domain_nr = of_get_pci_domain_nr(dev->of_node);
+
+	if (domain_nr < 0 || domain_nr > 1)
+		return dev_err_probe(dev, -ENODEV,
+				     "failed to get valid pcie domain\n");
+
+	if (domain_nr == 0)
+		pcie->stg_pcie_base = STG_SYSCON_PCIE0_BASE;
+	else
+		pcie->stg_pcie_base = STG_SYSCON_PCIE1_BASE;
+
+	pcie->reset_gpio = devm_gpiod_get_optional(dev, "perst",
+						   GPIOD_OUT_HIGH);
+	if (IS_ERR(pcie->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
+				     "failed to get perst-gpio\n");
+
+	pcie->power_gpio = devm_gpiod_get_optional(dev, "enable",
+						   GPIOD_OUT_LOW);
+	if (IS_ERR(pcie->power_gpio))
+		return dev_err_probe(dev, PTR_ERR(pcie->power_gpio),
+				     "failed to get power-gpio\n");
+
+	return 0;
+}
+
+static struct pci_ops starfive_pcie_ops = {
+	.map_bus	= plda_pcie_map_bus,
+	.read           = starfive_pcie_config_read,
+	.write          = starfive_pcie_config_write,
+};
+
+static int starfive_pcie_clk_rst_init(struct starfive_jh7110_pcie *pcie)
+{
+	struct device *dev = pcie->plda.dev;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable clocks\n");
+
+	ret = reset_control_deassert(pcie->resets);
+	if (ret) {
+		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+		dev_err_probe(dev, ret, "failed to deassert resets\n");
+	}
+
+	return ret;
+}
+
+static void starfive_pcie_clk_rst_deinit(struct starfive_jh7110_pcie *pcie)
+{
+	reset_control_assert(pcie->resets);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+}
+
+static bool starfive_pcie_link_up(struct plda_pcie_rp *plda)
+{
+	struct starfive_jh7110_pcie *pcie =
+		container_of(plda, struct starfive_jh7110_pcie, plda);
+	int ret;
+	u32 stg_reg_val;
+
+	ret = regmap_read(pcie->reg_syscon,
+			  pcie->stg_pcie_base + STG_SYSCON_LNKSTA_OFFSET,
+			  &stg_reg_val);
+	if (ret) {
+		dev_err(pcie->plda.dev, "failed to read link status\n");
+		return false;
+	}
+
+	return !!(stg_reg_val & DATA_LINK_ACTIVE);
+}
+
+static int starfive_pcie_host_wait_for_link(struct starfive_jh7110_pcie *pcie)
+{
+	int retries;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (starfive_pcie_link_up(&pcie->plda)) {
+			dev_info(pcie->plda.dev, "port link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int starfive_pcie_enable_phy(struct device *dev,
+				    struct starfive_jh7110_pcie *pcie)
+{
+	int ret;
+
+	if (!pcie->phy)
+		return 0;
+
+	ret = phy_init(pcie->phy);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to initialize pcie phy\n");
+
+	ret = phy_set_mode(pcie->phy, PHY_MODE_PCIE);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to set pcie mode\n");
+		goto err_phy_on;
+	}
+
+	ret = phy_power_on(pcie->phy);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to power on pcie phy\n");
+		goto err_phy_on;
+	}
+
+	return 0;
+
+err_phy_on:
+	phy_exit(pcie->phy);
+	return ret;
+}
+
+static void starfive_pcie_disable_phy(struct starfive_jh7110_pcie *pcie)
+{
+	phy_power_off(pcie->phy);
+	phy_exit(pcie->phy);
+}
+
+static void starfive_pcie_host_deinit(struct plda_pcie_rp *plda)
+{
+	struct starfive_jh7110_pcie *pcie =
+		container_of(plda, struct starfive_jh7110_pcie, plda);
+
+	starfive_pcie_clk_rst_deinit(pcie);
+	if (pcie->power_gpio)
+		gpiod_set_value_cansleep(pcie->power_gpio, 0);
+	starfive_pcie_disable_phy(pcie);
+}
+
+static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
+{
+	struct starfive_jh7110_pcie *pcie =
+		container_of(plda, struct starfive_jh7110_pcie, plda);
+	struct device *dev = plda->dev;
+	int ret;
+	int i;
+
+	ret = starfive_pcie_enable_phy(dev, pcie);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_RP_NEP_OFFSET,
+			   STG_SYSCON_K_RP_NEP, STG_SYSCON_K_RP_NEP);
+
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_AW_OFFSET,
+			   STG_SYSCON_CKREF_SRC_MASK,
+			   FIELD_PREP(STG_SYSCON_CKREF_SRC_MASK, 2));
+
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_AW_OFFSET,
+			   STG_SYSCON_CLKREQ, STG_SYSCON_CLKREQ);
+
+	ret = starfive_pcie_clk_rst_init(pcie);
+	if (ret)
+		return ret;
+
+	if (pcie->power_gpio)
+		gpiod_set_value_cansleep(pcie->power_gpio, 1);
+
+	if (pcie->reset_gpio)
+		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+
+	/* Disable physical functions except #0 */
+	for (i = 1; i < PCIE_FUNC_NUM; i++) {
+		regmap_update_bits(pcie->reg_syscon,
+				   pcie->stg_pcie_base + STG_SYSCON_AR_OFFSET,
+				   STG_SYSCON_AXI4_SLVL_AR_MASK,
+				   STG_SYSCON_AXI4_SLVL_PHY_AR(i));
+
+		regmap_update_bits(pcie->reg_syscon,
+				   pcie->stg_pcie_base + STG_SYSCON_AW_OFFSET,
+				   STG_SYSCON_AXI4_SLVL_AW_MASK,
+				   STG_SYSCON_AXI4_SLVL_PHY_AW(i));
+
+		plda_pcie_disable_func(plda);
+	}
+
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_AR_OFFSET,
+			   STG_SYSCON_AXI4_SLVL_AR_MASK, 0);
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_AW_OFFSET,
+			   STG_SYSCON_AXI4_SLVL_AW_MASK, 0);
+
+	plda_pcie_enable_root_port(plda);
+	plda_pcie_write_rc_bar(plda, 0);
+
+	/* PCIe PCI Standard Configuration Identification Settings. */
+	plda_pcie_set_standard_class(plda);
+
+	/*
+	 * The LTR message receiving is enabled by the register "PCIe Message
+	 * Reception" as default, but the forward id & addr are uninitialized.
+	 * If we do not disable LTR message forwarding here, or set a legal
+	 * forwarding address, the kernel will get stuck.
+	 * To workaround, disable the LTR message forwarding here before using
+	 * this feature.
+	 */
+	plda_pcie_disable_ltr(plda);
+
+	/*
+	 * Enable the prefetchable memory window 64-bit addressing in JH7110.
+	 * The 64-bits prefetchable address translation configurations in ATU
+	 * can be work after enable the register setting below.
+	 */
+	plda_pcie_set_pref_win_64bit(plda);
+
+	/*
+	 * Ensure that PERST has been asserted for at least 100 ms,
+	 * the sleep value is T_PVPERL from PCIe CEM spec r2.0 (Table 2-4)
+	 */
+	msleep(100);
+	if (pcie->reset_gpio)
+		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+
+	/*
+	 * With a Downstream Port (<=5GT/s), software must wait a minimum
+	 * of 100ms following exit from a conventional reset before
+	 * sending a configuration request to the device.
+	 */
+	msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);
+
+	if (starfive_pcie_host_wait_for_link(pcie))
+		dev_info(dev, "port link down\n");
+
+	return 0;
+}
+
+static const struct plda_pcie_host_ops sf_host_ops = {
+	.host_init = starfive_pcie_host_init,
+	.host_deinit = starfive_pcie_host_deinit,
+};
+
+static const struct plda_event stf_pcie_event = {
+	.intx_event = EVENT_PM_MSI_INT_INTX,
+	.msi_event  = EVENT_PM_MSI_INT_MSI
+};
+
+static int starfive_pcie_probe(struct platform_device *pdev)
+{
+	struct starfive_jh7110_pcie *pcie;
+	struct device *dev = &pdev->dev;
+	struct plda_pcie_rp *plda;
+	int ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	plda = &pcie->plda;
+	plda->dev = dev;
+
+	ret = starfive_pcie_parse_dt(pcie, dev);
+	if (ret)
+		return ret;
+
+	plda->host_ops = &sf_host_ops;
+	plda->num_events = PLDA_MAX_EVENT_NUM;
+	/* mask doorbell event */
+	plda->events_bitmap = GENMASK(PLDA_INT_EVENT_NUM - 1, 0)
+			     & ~BIT(PLDA_AXI_DOORBELL)
+			     & ~BIT(PLDA_PCIE_DOORBELL);
+	plda->events_bitmap <<= PLDA_NUM_DMA_EVENTS;
+	ret = plda_pcie_host_init(&pcie->plda, &starfive_pcie_ops,
+				  &stf_pcie_event);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+	platform_set_drvdata(pdev, pcie);
+
+	return 0;
+}
+
+static void starfive_pcie_remove(struct platform_device *pdev)
+{
+	struct starfive_jh7110_pcie *pcie = platform_get_drvdata(pdev);
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	plda_pcie_host_deinit(&pcie->plda);
+	platform_set_drvdata(pdev, NULL);
+}
+
+static int starfive_pcie_suspend_noirq(struct device *dev)
+{
+	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+	starfive_pcie_disable_phy(pcie);
+
+	return 0;
+}
+
+static int starfive_pcie_resume_noirq(struct device *dev)
+{
+	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = starfive_pcie_enable_phy(dev, pcie);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks\n");
+		starfive_pcie_disable_phy(pcie);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops starfive_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(starfive_pcie_suspend_noirq,
+				  starfive_pcie_resume_noirq)
+};
+
+static const struct of_device_id starfive_pcie_of_match[] = {
+	{ .compatible = "starfive,jh7110-pcie", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, starfive_pcie_of_match);
+
+static struct platform_driver starfive_pcie_driver = {
+	.driver = {
+		.name = "pcie-starfive",
+		.of_match_table = of_match_ptr(starfive_pcie_of_match),
+		.pm = pm_sleep_ptr(&starfive_pcie_pm_ops),
+	},
+	.probe = starfive_pcie_probe,
+	.remove_new = starfive_pcie_remove,
+};
+module_platform_driver(starfive_pcie_driver);
+
+MODULE_DESCRIPTION("StarFive JH7110 PCIe host driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


