Return-Path: <linux-pci+bounces-4104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F4C868DFD
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD54B27D65
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01C41386B9;
	Tue, 27 Feb 2024 10:50:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2106.outbound.protection.partner.outlook.cn [139.219.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CACDDDB8;
	Tue, 27 Feb 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031042; cv=fail; b=dX98DN+tHLftlNBomDoC4y33+EQR2hNKtDKYJhriY69FB8pVZewFDLYvUgL1qbc9QblmHtc3mdHyoNrtEwoy+z/NgpYJRz9dvo0IJKRGYuygo2y1vsHPg9zcCxWLcyRdoxENZr243xqvt5eRA8vSF4HgKToTxar7QTcCuiLmYoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031042; c=relaxed/simple;
	bh=F9NlRhQyLaJyReHe2hm/4QejYviA/m3GhdSoa2sRMRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IJeKLo+lh3VVDrq2db1JNKmcmpkTxCah2bvCDy0TdyoI5EJknoFshaxGKxHlizfuymbUsdLoI+irFDnpvxin9c5VIWE8SYXyVQwNnEKB8puBJVxfDbzvGLiHt97HI0OAnZfd9+wbBTOA/I42l4N5w3cEfC92dHMnUeL3HZ26MF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzyuJOEBEKQERIzf8dpdxs+PECsvfrfBUmmwtBSHnSmT9wMRIQJ7ka4hk6nIlD6uJdnX4zHBcahi9xk3D/YaR2O1C1TRJJrtMkY1yK17qSL3Bkc73Da7ys3v/n9CFfItXpdZ507Cwcqj/GS/DYV4NU+uNTC4r9I26ghCyJU6vA2M/Ds46dizQSdGX3bVRmCBpFUXuVL3b+0Ef5cdWS9cTvA9Nxe6jcGIAOZwS4prRtkyIJ9d9ZJrTscrWRqfl0iRiUi3s21ujz9hMiKrhuU52P3N9jLH440giD+oqDzFjgtYzs2MmCFrmT7Ym4lFmMurlfJRBTSclxr2HOCILFIWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzEdxPV9sVQYt5qDpW46LCyAbSxzK1+37b2lNwLB72A=;
 b=V11YMA+v2bGUft2az4lXZti6m4uyfiLQLp2Lc5Ax4ih0qJ5oP4lFbH/BIb7Gb7esHdSm1EuJ7Dt2dcQQpGx/sTzCC2tcibISr5xlFc3zQYfyGqbu8RdLpB5Mq5Ttzz8MuPYtFtaYbwxd0AWll6fXw3B80fftuqxjnx6RfeqV815s4G5ejBxRErN1027woo+LPcsLJhFCWGA2bxMqEBTz75X/v1z3LNzPFEbVYxxoeHyx0ULhd1z3Fuh9drJstee7ehFAMz+qcxYzwOKyFZSkpYy7dSuPi4YBfzRpjBWi4ShxnV6gfwBW/yAlhEBSejRZvghsnjEJvqNUgQJthV//aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:32 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:32 +0000
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
Subject: [PATCH v15,RESEND 03/23] PCI: microchip: Move PLDA IP register macros to pcie-plda.h
Date: Tue, 27 Feb 2024 18:35:02 +0800
Message-Id: <20240227103522.80915-4-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 427670c2-de40-484c-610a-08dc377fd36f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2O+vuISANsbFLKQtOMRQGR41MdsI5K/zkRDY0ZfnJQF+FG7jVaDD4lEWHmBbvG+SCcXbpZxnDabI9v34MknDrN7VscsrbQAvpZzRqBl7HIaWZeOfLVQiA+3htXdsSvG8oP+NHwvlAuVJQ34UAHZS+Wf6x5N9QWkvKFoKHVPRtcvGjL5sDLxkz9XLrmKEh4w81UXFfIyRtoAOvVM0qisBMfjV+osDZvUI5Fi5J1rtSJvNy7OFU64k6+1NgidcV0wmUadz+8XGY2hCiPB3U+SaZCynuV45O2G1kgCh5nM8EeCtvpPqABxPynbMjdtJZmk4Nk5ZItrr08uz5RunOklrFzC94fwkRkfANDcUc8sA5r+PCDGkZCX5jbwRdP0cnVhaRdzweIblLoAYkv01Vhlnu4NyoxEOiknstP3je5tjQUbB9D3osZDdvQzrJz62QnG8X6TE4nv5Pb0t6q47PsHJOIvhiKjrE3p7QD0kB5q+h/f2QZlIKQZ81I8VfDJz/+9MIs9lD6ThaBJKnUVk8Ey7x5soBkbH+7QeNnsk7h+eaZo+22nZ7WQfSZwtGnRdmIR1QUrazWNhUwZ/kWMW6Dnx63EK+Vu/vzVNzQZGHCJRnMebzEhaxyotXEEaSklS5XSg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BV+KtNUM39Tuj7E6pHCVXqKolw8aCw6DwexZe8Nb6Ztym5dNLEJ+N+bCdM9O?=
 =?us-ascii?Q?PinXfddjeiRUsb+ZqT2xJvsmU88M1q/9p7uLCErllJw/lB9L2oulZVTJ87T/?=
 =?us-ascii?Q?ghzj8pHQNn4PPVM1riJ1AeJ96+1Yq2j65DDTRhPRzqvuCKTyRszwbC9N0ozi?=
 =?us-ascii?Q?+OwWsZPS7mBw+do/FV2jGqcX8eUNxO/PoYWVr/wPls05BEiJysNx5EBBon2M?=
 =?us-ascii?Q?yn1dj/ER33+bD/qwa9CuhhD7H60cPPMfjwTMCQjxUVGVaLBOh5BaylyMQgA2?=
 =?us-ascii?Q?EykwYy3Y8ohbI7Qi4bhKzc9b1S4Hp2+4rGGim/IzIEIZng4tV5IW6/5ZLGcq?=
 =?us-ascii?Q?jLeXbfWpEVcwuedFbLodQ+NVQxtwC3w2FX7bFKujqLs0//8q3BV8dHMI+aVU?=
 =?us-ascii?Q?p5B8dHEgB4RSd7yqjIlSXHMqRJR8qUX2aQrzHIjDSHhtVMbISRDVMEd+tZOA?=
 =?us-ascii?Q?OSXmYlcCzqbhRRQ39UoFjPkP75lbHXbH0b3kJcp32JHgCV/7dqhaKkDlzHjj?=
 =?us-ascii?Q?JyAePJlRrhnAaF+pEV3KrijBcc5pG+hHwqOilFtgvI3lJ/8COfV/TqrEdhcM?=
 =?us-ascii?Q?YKVZyujBSCkuQus8HNwOatiaVTxQjbdW9byepVSi9fQzMvYSiH2XspE0uKTv?=
 =?us-ascii?Q?B7vl9HgKZZIVSLw6GReFqurZGm0hRBZ47sBIby2jCnaBpJeyBpXNZwzskm4f?=
 =?us-ascii?Q?2TKK9MpeEqI7SpZuIhgN5+oJY1jOpuaz1qkrkjCbIgFBscV6YzdrHwb1kPPW?=
 =?us-ascii?Q?4Jw+TDQDTpSP/rf7jr/U7gSJUsGnWEVVHXtRU9dsKO/G4u9vdbmdrWEeUX7m?=
 =?us-ascii?Q?LxE70FxUPSbPjLZzP5gj3jbNwyyuqyVB1YCC+vBsLTS5ElHn/xriBwMDyA+f?=
 =?us-ascii?Q?4Vq6eAJNkoBYWlmNgz/6b9fP7UzdcPl9PB4eLM0L58mEM9vfggSkZaggT4FM?=
 =?us-ascii?Q?JhaqEEd7clAClfb5L8jpwIjF8L/Dc1i3/hGqr2OeA83gNCWn3UwUryMidqkA?=
 =?us-ascii?Q?K82XEDgAN9KeNO9YtnDY0UC4Yjad5cnXPjnOHvzLs5Yvijsec5mtPtrdFSoL?=
 =?us-ascii?Q?YCXpNYjzrOCd6cFm04Ay4pft4TFQ4Drt2arN2HzEOV4BFbBBrFSCgmONatwx?=
 =?us-ascii?Q?gZROOCjp6utMz05dpqiy2ibW0/d6IVeN/hcjoY+a11GTZZP1B+BHOpuq2uM3?=
 =?us-ascii?Q?H9x3+HxD1XIoExB+nEfH+W3axrHJr0SMaooyzJofU2uSOJiHVNc8/unoyah3?=
 =?us-ascii?Q?O8zjYMzm2GSGcjtlaLu/nRsYZzWDszZ2EOzpHRqqnjKyac5yGvEqD4TACRZ4?=
 =?us-ascii?Q?zl3aPx+KNNNH7sJdKCfAGUAxSB4sdFhnddis1oN/GroTiB417egjMw+W2ZtH?=
 =?us-ascii?Q?UGYn1Y0aKJCzlwI7j8g82xG84B4pV6BLuykNT1cyL51bVhskEz3Ovdvkdmny?=
 =?us-ascii?Q?wLCaUW0Ibokumemj/qZM0UexQ8Vo9q6wdAfzgm2b/8Bo5qP6Zqeo8Fdzho0+?=
 =?us-ascii?Q?92QZYgnfrkgtNuepjWN2CCnrmFYy2QMLgNIkotvhg0LeDIFRl1UDBYSdo4Ii?=
 =?us-ascii?Q?PuvW9JtEi30KzRTpFseWhE0wvy2HnczIStze6cBMcbDWROvKd+OgCqH3AP/x?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427670c2-de40-484c-610a-08dc377fd36f
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:32.8453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOxC37RjlCj4IcdOkQEKbfUG0/BP7eTuhM6JccussaAksHL5opuFON1WcPVtqPx6eh3e07nUwVsbv5LkqLecfYanRk7cKiEcyDbnsA0VVEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0863

Move PLDA PCIe host controller IP registers macros to pcie-plda.h,
including bridge registers and PLDA IRQ event number.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS                                   |   8 ++
 .../pci/controller/plda/pcie-microchip-host.c | 108 +++---------------
 drivers/pci/controller/plda/pcie-plda.h       | 108 ++++++++++++++++++
 3 files changed, 132 insertions(+), 92 deletions(-)
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f7e907c8749..fc9576e69a71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16814,6 +16814,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
 
+PCI DRIVER FOR PLDA PCIE IP
+M:	Daire McNamara <daire.mcnamara@microchip.com>
+M:	Kevin Xie <kevin.xie@starfivetech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/plda,*
+F:	drivers/pci/controller/plda/*plda*
+
 PCI DRIVER FOR RENESAS R-CAR
 M:	Marek Vasut <marek.vasut+renesas@gmail.com>
 M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index cb09a8137e25..d9030d550482 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 
 #include "../../pci.h"
+#include "pcie-plda.h"
 
 /* Number of MSI IRQs */
 #define MC_MAX_NUM_MSI_IRQS			32
@@ -30,84 +31,6 @@
 #define MC_PCIE_BRIDGE_ADDR			(MC_PCIE1_BRIDGE_ADDR)
 #define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
 
-/* PCIe Bridge Phy Regs */
-#define PCIE_PCI_IRQ_DW0			0xa8
-#define  MSIX_CAP_MASK				BIT(31)
-#define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
-#define  NUM_MSI_MSGS_SHIFT			4
-
-#define IMASK_LOCAL				0x180
-#define  DMA_END_ENGINE_0_MASK			0x00000000u
-#define  DMA_END_ENGINE_0_SHIFT			0
-#define  DMA_END_ENGINE_1_MASK			0x00000000u
-#define  DMA_END_ENGINE_1_SHIFT			1
-#define  DMA_ERROR_ENGINE_0_MASK		0x00000100u
-#define  DMA_ERROR_ENGINE_0_SHIFT		8
-#define  DMA_ERROR_ENGINE_1_MASK		0x00000200u
-#define  DMA_ERROR_ENGINE_1_SHIFT		9
-#define  A_ATR_EVT_POST_ERR_MASK		0x00010000u
-#define  A_ATR_EVT_POST_ERR_SHIFT		16
-#define  A_ATR_EVT_FETCH_ERR_MASK		0x00020000u
-#define  A_ATR_EVT_FETCH_ERR_SHIFT		17
-#define  A_ATR_EVT_DISCARD_ERR_MASK		0x00040000u
-#define  A_ATR_EVT_DISCARD_ERR_SHIFT		18
-#define  A_ATR_EVT_DOORBELL_MASK		0x00000000u
-#define  A_ATR_EVT_DOORBELL_SHIFT		19
-#define  P_ATR_EVT_POST_ERR_MASK		0x00100000u
-#define  P_ATR_EVT_POST_ERR_SHIFT		20
-#define  P_ATR_EVT_FETCH_ERR_MASK		0x00200000u
-#define  P_ATR_EVT_FETCH_ERR_SHIFT		21
-#define  P_ATR_EVT_DISCARD_ERR_MASK		0x00400000u
-#define  P_ATR_EVT_DISCARD_ERR_SHIFT		22
-#define  P_ATR_EVT_DOORBELL_MASK		0x00000000u
-#define  P_ATR_EVT_DOORBELL_SHIFT		23
-#define  PM_MSI_INT_INTA_MASK			0x01000000u
-#define  PM_MSI_INT_INTA_SHIFT			24
-#define  PM_MSI_INT_INTB_MASK			0x02000000u
-#define  PM_MSI_INT_INTB_SHIFT			25
-#define  PM_MSI_INT_INTC_MASK			0x04000000u
-#define  PM_MSI_INT_INTC_SHIFT			26
-#define  PM_MSI_INT_INTD_MASK			0x08000000u
-#define  PM_MSI_INT_INTD_SHIFT			27
-#define  PM_MSI_INT_INTX_MASK			0x0f000000u
-#define  PM_MSI_INT_INTX_SHIFT			24
-#define  PM_MSI_INT_MSI_MASK			0x10000000u
-#define  PM_MSI_INT_MSI_SHIFT			28
-#define  PM_MSI_INT_AER_EVT_MASK		0x20000000u
-#define  PM_MSI_INT_AER_EVT_SHIFT		29
-#define  PM_MSI_INT_EVENTS_MASK			0x40000000u
-#define  PM_MSI_INT_EVENTS_SHIFT		30
-#define  PM_MSI_INT_SYS_ERR_MASK		0x80000000u
-#define  PM_MSI_INT_SYS_ERR_SHIFT		31
-#define  NUM_LOCAL_EVENTS			15
-#define ISTATUS_LOCAL				0x184
-#define IMASK_HOST				0x188
-#define ISTATUS_HOST				0x18c
-#define IMSI_ADDR				0x190
-#define ISTATUS_MSI				0x194
-
-/* PCIe Master table init defines */
-#define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
-#define  ATR0_PCIE_ATR_SIZE			0x25
-#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
-#define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
-#define ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
-#define ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
-#define ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
-
-/* PCIe AXI slave table init defines */
-#define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
-#define  ATR_SIZE_SHIFT				1
-#define  ATR_IMPL_ENABLE			1
-#define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
-#define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
-#define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
-#define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
-#define  PCIE_TX_RX_INTERFACE			0x00000000u
-#define  PCIE_CONFIG_INTERFACE			0x00000001u
-
-#define ATR_ENTRY_SIZE				32
-
 /* PCIe Controller Phy Regs */
 #define SEC_ERROR_EVENT_CNT			0x20
 #define DED_ERROR_EVENT_CNT			0x24
@@ -179,20 +102,21 @@
 #define EVENT_LOCAL_DMA_END_ENGINE_1		12
 #define EVENT_LOCAL_DMA_ERROR_ENGINE_0		13
 #define EVENT_LOCAL_DMA_ERROR_ENGINE_1		14
-#define EVENT_LOCAL_A_ATR_EVT_POST_ERR		15
-#define EVENT_LOCAL_A_ATR_EVT_FETCH_ERR		16
-#define EVENT_LOCAL_A_ATR_EVT_DISCARD_ERR	17
-#define EVENT_LOCAL_A_ATR_EVT_DOORBELL		18
-#define EVENT_LOCAL_P_ATR_EVT_POST_ERR		19
-#define EVENT_LOCAL_P_ATR_EVT_FETCH_ERR		20
-#define EVENT_LOCAL_P_ATR_EVT_DISCARD_ERR	21
-#define EVENT_LOCAL_P_ATR_EVT_DOORBELL		22
-#define EVENT_LOCAL_PM_MSI_INT_INTX		23
-#define EVENT_LOCAL_PM_MSI_INT_MSI		24
-#define EVENT_LOCAL_PM_MSI_INT_AER_EVT		25
-#define EVENT_LOCAL_PM_MSI_INT_EVENTS		26
-#define EVENT_LOCAL_PM_MSI_INT_SYS_ERR		27
-#define NUM_EVENTS				28
+#define NUM_MC_EVENTS				15
+#define EVENT_LOCAL_A_ATR_EVT_POST_ERR		(NUM_MC_EVENTS + PLDA_AXI_POST_ERR)
+#define EVENT_LOCAL_A_ATR_EVT_FETCH_ERR		(NUM_MC_EVENTS + PLDA_AXI_FETCH_ERR)
+#define EVENT_LOCAL_A_ATR_EVT_DISCARD_ERR	(NUM_MC_EVENTS + PLDA_AXI_DISCARD_ERR)
+#define EVENT_LOCAL_A_ATR_EVT_DOORBELL		(NUM_MC_EVENTS + PLDA_AXI_DOORBELL)
+#define EVENT_LOCAL_P_ATR_EVT_POST_ERR		(NUM_MC_EVENTS + PLDA_PCIE_POST_ERR)
+#define EVENT_LOCAL_P_ATR_EVT_FETCH_ERR		(NUM_MC_EVENTS + PLDA_PCIE_FETCH_ERR)
+#define EVENT_LOCAL_P_ATR_EVT_DISCARD_ERR	(NUM_MC_EVENTS + PLDA_PCIE_DISCARD_ERR)
+#define EVENT_LOCAL_P_ATR_EVT_DOORBELL		(NUM_MC_EVENTS + PLDA_PCIE_DOORBELL)
+#define EVENT_LOCAL_PM_MSI_INT_INTX		(NUM_MC_EVENTS + PLDA_INTX)
+#define EVENT_LOCAL_PM_MSI_INT_MSI		(NUM_MC_EVENTS + PLDA_MSI)
+#define EVENT_LOCAL_PM_MSI_INT_AER_EVT		(NUM_MC_EVENTS + PLDA_AER_EVENT)
+#define EVENT_LOCAL_PM_MSI_INT_EVENTS		(NUM_MC_EVENTS + PLDA_MISC_EVENTS)
+#define EVENT_LOCAL_PM_MSI_INT_SYS_ERR		(NUM_MC_EVENTS + PLDA_SYS_ERR)
+#define NUM_EVENTS				(NUM_MC_EVENTS + PLDA_INT_EVENT_NUM)
 
 #define PCIE_EVENT_CAUSE(x, s)	\
 	[EVENT_PCIE_ ## x] = { __stringify(x), s }
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
new file mode 100644
index 000000000000..65e0f3b72184
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PLDA PCIe host controller driver
+ */
+
+#ifndef _PCIE_PLDA_H
+#define _PCIE_PLDA_H
+
+/* PCIe Bridge Phy Regs */
+#define PCIE_PCI_IRQ_DW0			0xa8
+#define  MSIX_CAP_MASK				BIT(31)
+#define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
+#define  NUM_MSI_MSGS_SHIFT			4
+
+#define IMASK_LOCAL				0x180
+#define  DMA_END_ENGINE_0_MASK			0x00000000u
+#define  DMA_END_ENGINE_0_SHIFT			0
+#define  DMA_END_ENGINE_1_MASK			0x00000000u
+#define  DMA_END_ENGINE_1_SHIFT			1
+#define  DMA_ERROR_ENGINE_0_MASK		0x00000100u
+#define  DMA_ERROR_ENGINE_0_SHIFT		8
+#define  DMA_ERROR_ENGINE_1_MASK		0x00000200u
+#define  DMA_ERROR_ENGINE_1_SHIFT		9
+#define  A_ATR_EVT_POST_ERR_MASK		0x00010000u
+#define  A_ATR_EVT_POST_ERR_SHIFT		16
+#define  A_ATR_EVT_FETCH_ERR_MASK		0x00020000u
+#define  A_ATR_EVT_FETCH_ERR_SHIFT		17
+#define  A_ATR_EVT_DISCARD_ERR_MASK		0x00040000u
+#define  A_ATR_EVT_DISCARD_ERR_SHIFT		18
+#define  A_ATR_EVT_DOORBELL_MASK		0x00000000u
+#define  A_ATR_EVT_DOORBELL_SHIFT		19
+#define  P_ATR_EVT_POST_ERR_MASK		0x00100000u
+#define  P_ATR_EVT_POST_ERR_SHIFT		20
+#define  P_ATR_EVT_FETCH_ERR_MASK		0x00200000u
+#define  P_ATR_EVT_FETCH_ERR_SHIFT		21
+#define  P_ATR_EVT_DISCARD_ERR_MASK		0x00400000u
+#define  P_ATR_EVT_DISCARD_ERR_SHIFT		22
+#define  P_ATR_EVT_DOORBELL_MASK		0x00000000u
+#define  P_ATR_EVT_DOORBELL_SHIFT		23
+#define  PM_MSI_INT_INTA_MASK			0x01000000u
+#define  PM_MSI_INT_INTA_SHIFT			24
+#define  PM_MSI_INT_INTB_MASK			0x02000000u
+#define  PM_MSI_INT_INTB_SHIFT			25
+#define  PM_MSI_INT_INTC_MASK			0x04000000u
+#define  PM_MSI_INT_INTC_SHIFT			26
+#define  PM_MSI_INT_INTD_MASK			0x08000000u
+#define  PM_MSI_INT_INTD_SHIFT			27
+#define  PM_MSI_INT_INTX_MASK			0x0f000000u
+#define  PM_MSI_INT_INTX_SHIFT			24
+#define  PM_MSI_INT_MSI_MASK			0x10000000u
+#define  PM_MSI_INT_MSI_SHIFT			28
+#define  PM_MSI_INT_AER_EVT_MASK		0x20000000u
+#define  PM_MSI_INT_AER_EVT_SHIFT		29
+#define  PM_MSI_INT_EVENTS_MASK			0x40000000u
+#define  PM_MSI_INT_EVENTS_SHIFT		30
+#define  PM_MSI_INT_SYS_ERR_MASK		0x80000000u
+#define  PM_MSI_INT_SYS_ERR_SHIFT		31
+#define  NUM_LOCAL_EVENTS			15
+#define ISTATUS_LOCAL				0x184
+#define IMASK_HOST				0x188
+#define ISTATUS_HOST				0x18c
+#define IMSI_ADDR				0x190
+#define ISTATUS_MSI				0x194
+
+/* PCIe Master table init defines */
+#define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
+#define  ATR0_PCIE_ATR_SIZE			0x25
+#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
+#define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
+#define ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
+#define ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
+#define ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
+
+/* PCIe AXI slave table init defines */
+#define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
+#define  ATR_SIZE_SHIFT				1
+#define  ATR_IMPL_ENABLE			1
+#define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
+#define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
+#define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
+#define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
+#define  PCIE_TX_RX_INTERFACE			0x00000000u
+#define  PCIE_CONFIG_INTERFACE			0x00000001u
+
+#define ATR_ENTRY_SIZE				32
+
+enum plda_int_event {
+	PLDA_AXI_POST_ERR,
+	PLDA_AXI_FETCH_ERR,
+	PLDA_AXI_DISCARD_ERR,
+	PLDA_AXI_DOORBELL,
+	PLDA_PCIE_POST_ERR,
+	PLDA_PCIE_FETCH_ERR,
+	PLDA_PCIE_DISCARD_ERR,
+	PLDA_PCIE_DOORBELL,
+	PLDA_INTX,
+	PLDA_MSI,
+	PLDA_AER_EVENT,
+	PLDA_MISC_EVENTS,
+	PLDA_SYS_ERR,
+	PLDA_INT_EVENT_NUM
+};
+
+#define PLDA_NUM_DMA_EVENTS			16
+
+#define PLDA_MAX_EVENT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
+
+#endif
-- 
2.17.1


