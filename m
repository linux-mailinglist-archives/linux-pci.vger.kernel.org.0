Return-Path: <linux-pci+bounces-1797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E9F826C84
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CD51C21B0C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D441428B;
	Mon,  8 Jan 2024 11:23:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2041.outbound.protection.partner.outlook.cn [139.219.146.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCA14A87;
	Mon,  8 Jan 2024 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRAhfbcpNECD3bUEbKwaPktbW2YiCJMM9K8d/8VIZhYmDox/WOmpNk6vMtIMPGBxSPBizjQ92I3FNuI280dRWZDb+3VvWv8c+95cxrehy9dRbdV+RkCZxgJnoFJn/LoBCcJPrw/UTXH2EwQ0cVSsKNjqZTauLvhMxmf9KFcZRsidnoVbDGZBW5e45jO+ICxoZUBeix5pPswQCjfDKab9I5RTfYSb0dBqCPYgMP1B8k4DUl+SR9gd6qBCYWsfWvOqxF19itJOZQdyEwZHlVhXUIvzerOhagT3S93O510qMNICZoO8OrGxf/dWs6iBGYeGcnY/Wbpaug4K1ORQLYWBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au2/G4EBK5VuF6ZN6z3pGw3XNqUfkLw2F7N4CI+h8AQ=;
 b=eleojd4SQAm6nQrYI9fj2EOWoEQVH68riTf7caSnHDwVmlqtq6X3R4qGTcpEUZRIsvDTU7UknERDh5BPuM5BqL2sEfCcFseEtk8AJZ7fkWWZSV5Wbxp51v2+mAsJoFjz2pgdXP8KkgNMoLjjKRtkEpfq89P1uSl0xmAjJfRudBQLqy8AwmR+i+5ojzJZTNgJD/BSCdx2tTx1aAcJf0fwfkpipD/Y01Osj4PkE3+nRP/CnIGRBwB6DBG0tAOb7QxeA8ukI3zMUUsgtfz8ad3syizT9OXXOhHlDkMXy4GnQTgM3H7SuKrw16qd8Y0aiqqbLfbS22z1jxPjMm5h27Xg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:07:03 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:07:03 +0000
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
Subject: [PATCH v14 21/22] PCI: starfive: Add JH7110 PCIe controller
Date: Mon,  8 Jan 2024 19:06:11 +0800
Message-Id: <20240108110612.19048-22-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0797:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4f205f-f0db-41a6-a5d0-08dc1039f1d6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c858YkTLYaFP8+ZpSzVtlcVfVOEWH4+v4Y4kDiaBsAq+1Q+jVojg3+9PjiIYAk+EzByU5TV/ZVwLDZx2Z3ZfCl3pU8doQCxLi4bT1QTd606ZC6q4nkHyli7yLzXRV+SVntr1XQeK8ghdZ3wZ4o8xKcGwrNNBJnIXVtu8ga1NQoghqnyw4jkUkWpqG4/hlCfn0cHKL4cZuZ5iHwX4RBov/LwSlOt4Jxf8gwLMU8y05vcq8zeMfSw3CkrCC95bu6JLnDmXmk/H08YKCT+R4IeI9Fcr9YhmedOynDsaAOJOeDjf/jLTynd3j7YT00ci2gf55xfVG8c89dnDAr8cBgoHwuRiitYGLRrXr4EnGIl+lwpeat0XyUKBL6aaPuCR4+/RSJAVbW7h0zQTZp2YpbhxIf04ZVN1ojWxVt54oBgfAhbXSciXSrCfPOdXaHQ6tn0FapOnq8tJxuWyD0Wpqe0vSgFxPZe9g5+Arn7qu1qiBzfNLh+52xoRBHi7MLaD85KC3rU3ekU7HjBS37F6KHxrJltXOmsUIVAeM62rvB731pENfqTfQ8MI09O+u5vehMA3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(30864003)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f9d/PqNr6u1GS5i5i9v1i1YluIhql9foIksNjLaef4ox6THGUel2NibtTWWt?=
 =?us-ascii?Q?qJRM41f1/M/ve5brc7HAFlKjhmU/GoKpbv961T7PULCaMYXWkmFnuuMgd4nK?=
 =?us-ascii?Q?F2i0Bv31bP6e+N+0cUDDunm27Bo6h0utY3SdS4N0eeeNKsQHw8642unk780G?=
 =?us-ascii?Q?zTVuvRLRlBsf830++Y+EMylmx0q78BoMAThHOmYHdMhkj6NxP8Q/6MYacTI7?=
 =?us-ascii?Q?VjELv5JZBZzDidyjILdAJENkBJkkFQEBApVBuU1txF+/kZPi2CYYidj7R1Rl?=
 =?us-ascii?Q?1AijzYw0dSVFjcZchYqFF2hq7zCsOYdJwatgcLxF3e1aR0cJ/R+CUNK/o5b3?=
 =?us-ascii?Q?hBM1yIc2c6rl/Xwb4IauOeRW0DUtXNxoZ0i11awrwm5ZY9ng5clvytOnbKkH?=
 =?us-ascii?Q?sM/38jfokkPS062BzXpCHRVmqCHoLgyzc90Yvcz9UbiUjUt6aFmc4k548r8x?=
 =?us-ascii?Q?yI3GpJ4TpSimZfmCGua0CfS/h5zDmHij0VM2k+DtIa9deVtUirInx66LJjJI?=
 =?us-ascii?Q?ysZ9rB/5wiuLX2pzpGuDRiaXqTBClJtGGkx7C1O5mSzbYr7crLi4sPgOy+pH?=
 =?us-ascii?Q?irLrHpcWMqgVGeCgC9wrQX1BUH/FdQDf98EfD1JdWxEyBQoOqaFJmiB2V5IA?=
 =?us-ascii?Q?rWvzxOtFkI3gpjd8NHqLPDYLoNhZ0s+7scRu6t4xMJ8DoKjhoGEhW9Voeq9Y?=
 =?us-ascii?Q?zv17vh4lOB3Ho3ahxw2XA2//J1vfDURyL/1dUejVJ2AaHDoAJ2DhEGTB8DA/?=
 =?us-ascii?Q?fyoADHsDFNRsqnd4MP/6KTKfLOt4Zewt5iuBrd5AY8tbSa+ooGQSoh/OTZZL?=
 =?us-ascii?Q?ao2pXNoSDHck4m7hUstVgIqz8eWvD4z2npKwupNjgL5dlsGjvw+qmpVymJew?=
 =?us-ascii?Q?IDTLnNHizgKiUP00wm2jYWI6pQJr6ImmWuvDqIK1IG297RwT3o2V14ESdSeM?=
 =?us-ascii?Q?M9zJqIclmtiVnR7/zdo0SX7Hc5QFrbTaggff6IMHauG37HTckGDEHojGEZq+?=
 =?us-ascii?Q?Z1IFf2QIhM6j9L5CFMGtN8sGhjqYarKKCdiyTRijDpzcXbTia4dNcP0kws0I?=
 =?us-ascii?Q?XDFA8Pb0PulxkBpnYhMQ7Fz3oQqLdTegyfWCJ8X69Lb0jx9Dz8b1mQbJu/BC?=
 =?us-ascii?Q?VKn31n6GR2dbOu7gKpT1Accvz312mnyW40giI7EhQrkv0J1y2ygxgfsPPksP?=
 =?us-ascii?Q?LUh5qg62Js8SyrqmhUPC6laQrlGFaEP16SzTqs2mT8gHLlJOUfb+N9kXEIX5?=
 =?us-ascii?Q?Ce5zjDU3m62bvStui9ulLQdaQ/2YavHbIMcFHvWFX2RO9w/6eSa1lwUCEfpo?=
 =?us-ascii?Q?3unoe60+Vjse0OEsE2Ve0ZBa7ZwY+wrP51X65KjlHTkVl+AMlOjRitE/umy6?=
 =?us-ascii?Q?q8qCMSxxhhWS/2CT9B+a/uz6PS6+H27NTdgQdT1SdZCPCvD1jjYnAPpyyXJN?=
 =?us-ascii?Q?YqyU+BbWq2vIYhI+qPQtRc5PMIQr0wPjtnOjxGpVOLZza4kv/sIhFhNwE5Pu?=
 =?us-ascii?Q?hvqZkFNMXLjzAZyxlgOUb0jyQ4REBKRSdd9CIx+6ShhSH+bkWk0cLaLghMwv?=
 =?us-ascii?Q?hSq84+jOUaQ4WcGfCxspAv6/oReTcuZPaUVi17UEG3Y7u4AfJwNJfeiUsdju?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4f205f-f0db-41a6-a5d0-08dc1039f1d6
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:07:03.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3nS4MQwsH2PxpzNMKN0LmKlipVI97Y7Jhi8CQknj10K20sgqQ+xu7qf4n2jk5d26hgHS/pykXLk1xnxg6a/3aE99KYBZSS9kcM+4FJhTCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

Add StarFive JH7110 SoC PCIe controller platform driver codes, JH7110
with PLDA host PCIe core.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Co-developed-by: Kevin Xie <kevin.xie@starfivetech.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
---
 MAINTAINERS                                 |   7 +
 drivers/pci/controller/plda/Kconfig         |  12 +
 drivers/pci/controller/plda/Makefile        |   1 +
 drivers/pci/controller/plda/pcie-plda.h     |  71 ++-
 drivers/pci/controller/plda/pcie-starfive.c | 473 ++++++++++++++++++++
 5 files changed, 563 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/controller/plda/pcie-starfive.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 730fe2d640a1..7fa339e6c25d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16821,6 +16821,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/socionext,uniphier-pcie*
 F:	drivers/pci/controller/dwc/pcie-uniphier*
 
+PCIE DRIVER FOR STARFIVE JH71x0
+M:	Kevin Xie <kevin.xie@starfivetech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/starfive*
+F:	drivers/pci/controller/plda/pcie-starfive.c
+
 PCIE DRIVER FOR ST SPEAR13XX
 M:	Pratyush Anand <pratyush.anand@gmail.com>
 L:	linux-pci@vger.kernel.org
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
index 7b69891700a4..04e385758a2f 100644
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
@@ -200,4 +214,59 @@ static inline void plda_set_default_msi(struct plda_msi *msi)
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
index 000000000000..9bb9f0e29565
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -0,0 +1,473 @@
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
+ * The BAR0/1 of bridge should be hidden during enumeration to
+ * avoid the sizing and resource allocation by PCIe core.
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
+	 * The LTR message forwarding of PCIe Message Reception was set by core
+	 * as default, but the forward id & addr are also need to be reset.
+	 * If we do not disable LTR message forwarding here, or set a legal
+	 * forwarding address, the kernel will get stuck after the driver probe.
+	 * To workaround, disable the LTR message forwarding support on
+	 * PCIe Message Reception.
+	 */
+	plda_pcie_disable_ltr(plda);
+
+	/* Prefetchable memory window 64-bit addressing support */
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


