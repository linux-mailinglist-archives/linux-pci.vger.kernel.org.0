Return-Path: <linux-pci+bounces-4105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F533868E00
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E962B28F46
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97245139583;
	Tue, 27 Feb 2024 10:50:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2103.outbound.protection.partner.outlook.cn [139.219.17.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C199613957E;
	Tue, 27 Feb 2024 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031052; cv=fail; b=DQK8/d4geENukmCAkHymNo7HRsHZRn/Lsj9pJ3NAiM4wyRk328XT/mCKJj6G4rSYfozrQN4LcCLLhmvSWMMAtcOLLopg1jWrrdKxJxdR/LCmdKGolX2iE1j75XCc2wSJIYiMApd5Ntjcvr0a9FYGZXyBEE1YXSQYnpVYfV8qPIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031052; c=relaxed/simple;
	bh=Zr4mWUFXYvtyxcrmFpVmK+dYKLWMemI9hE1iMc5NAH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oVCgazKampJylgIbeERlsM3E41gW6KrNY7gBfSFYIc9fxCPRDIQofc/PSqXOPt1M9NycEZwPdXZHr9/HvA87mLJvmffZLHIc+w+sF56+dq1EnXtlDczPohz+gN+YBL+rqDU+nO4q8NA8PYoKNNqPtg52UqQIoTuUnbAiMONWI7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+V0FbOrTOZhPIWb/tehuoZUyNGK3u4NeudB+iq/a2BxqGbO/aYaE0DtzyjVe8SpLfXgS3DS5mmrysBn0lVB//m1qD2zXJok+FsRNTs8wNBONQk5fxKiN/NWN0M/cDInIbdTAsqdU5mL4foQW9/GFyO/Gtc+SJ16QlldA/9ZZBmy0cH8fYSepcP3rtQxG+qy/lEn7sKb5BoNBdn4PDJpwT672oYSHx+IwEjGu0vuxsW1moAYNncHOyDeAXCmE7nlg3B/ZCMPSxdFCAyJXw+oi6joj7sOUOwTzqBpz7mYQIQiWf9GBdwDbg0MRTzDjy4sXA3AbhDYC5Ld7coPnP7cOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTje0ALVDFVTLXaFJ/d5aQDDyaSpWhyjgAzo6CfB/Hs=;
 b=FYiZecIPEZkbc0G3gGCKdSxkjbPVQxGDKrHPO9BMOZTxC+6xeC6+NJfZ17+T9CuD3HkHCXIWu2lRt06yVPEw6Ep0/dhM/ksQfB4MW8VTApZjyMz42z5eM1siMx7GtV9y8ofBeuF/4jnv7MuYUon/FOVrEsPs/TlsXlfu00ozzHqdb8izxUkLpIsrjAjjkEBhfWhHPRKhG3cVj3G7mp82QzaQJQTK4wQQaWGZoieBwaohbgEHDhYD59ECp4AHn0LqqCawRW8yGLUbJunwL8WG/Rm81DWo20/v17eQpzVQxt+iF1XNpx1VSHw2mi/LTp0BxTvwkVfpBMpiwxqDy5yTXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:35 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:35 +0000
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
Subject: [PATCH v15,RESEND 06/23] PCI: microchip: Move PCIe host data structures to plda-pcie.h
Date: Tue, 27 Feb 2024 18:35:05 +0800
Message-Id: <20240227103522.80915-7-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 14884185-adf6-431d-7ddb-08dc377fd53b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fp4iZGgjWARwEqtCUnKrQhIkPRNqBsB3LcDaGkr60WkARXgYu6IXLMr5ouyuv+NrF5FOspOcr1pyBE6E0Pa/ZZANUdbe5JUlt7VxL79wn4xC5hBGtoyOQxF8z9rHkik2L9WqfDw7qH8+XG8FWiqKWd7VJ1ccHKrWUDfDODZm+Faf17lTE7pjthanxagK5+L7FJXXONiUfw/aGJyrWfR3btEmdneXm2H0JI+UA6BiNSDMG3g9/4707sGSVq03TuMKJLhatuOW1dPVKOk9bcluOkRW9eXccn91Ss1u4/Os1PAo8YhtkhrQtdP82fg3HGQ3SNwk/Sf9GVKTltLN1i+k0L/tI8TfZArz5dTn4+IGpyjTWMST3jmJ0H9kvsZn+cn46ZWpkZQay00gj2Yj44ts3YqnYjA6mWcl63EHs3SW3+mEpGOCVrE1u+ECRNIlfe3DNywIg6Cj+jMLKh5r1C2pwpH/pBVlhbVj+uZlqOuUmh5scURoRNJblY1L6SFurZJbWfxYaG2mBvYq/ueyuwxYltfvOhtnmA8K+jeSouxQRcT4fZSx7Y+ldz9E+Nc6VsfXliuIwFwDYZNAPPZHuL+zv3t/nvBh5ivXnc5JaQq/clnNavDBmIbbRmJXLJBZ2uVz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JLFevc/ODYjiPm9aASThGrENi38gMdTn2Aqrk1HiO0w22WJddsgKq6A2RPzM?=
 =?us-ascii?Q?Jz0T1tgdITDO0mlKcw0npRqEtxLoz6VQ4uRC9FvCMQex3gu6hg/wyT8E+iza?=
 =?us-ascii?Q?qtM9NA9XNLBEfEEJsiQG1CZels44jetNtpIephItQ1TyH5tmPCAZmOMLyJBI?=
 =?us-ascii?Q?MVqT2VEzS+/kga6tga9SidWtvWCJlTmwSh6gdZj0C240I8OEt9+XUiU5BC9Y?=
 =?us-ascii?Q?R1/dJCffH/h32DLhnXegWzUW6Spwiv3db2bv2xTO67hEFhaL9lIUlDl8U2hN?=
 =?us-ascii?Q?QU0E1+2CCUh4dyH8ltwticlDFNbusPePuT9WOjZBUHIqQEiPWiRuXmj7taiv?=
 =?us-ascii?Q?GjrAE3md/RV03GaTjAzd5b9DU+EOKgqhXmbBx4OnLy1/vBPGqcpdtFN6Sk6Q?=
 =?us-ascii?Q?+E7Q+eVAfxhFnuO13sMiobarmA2kxJdPoxGU19Lij/A94JiXhbm7Pa8Kg3ZL?=
 =?us-ascii?Q?yD/WorNdn+r2bb8THpVDNapj1AP87HeiM7CoShS+PiMWGdGyONdONpMBUIz9?=
 =?us-ascii?Q?XKhZ1F8+TqzXO2zim8RKRqEMfwJm3v+3WE4TXy530OZTOb/cBcNBm94GvpP1?=
 =?us-ascii?Q?xwHhrqrrf2CxsC9zQN2ZPiLRFdp0g9v32nPm/ReIVWmzUOyvq5UWzDqkJ1u0?=
 =?us-ascii?Q?3A+HUwV2Z+rhCovOJ9GY9QPfQMgBCg/bK+4Sn1sB+fkVgmT2SSyR6RzqP2HF?=
 =?us-ascii?Q?i2SekQkwvjHUpHMDgkxHDpdQwbO2IF81kVOvr84lOS9daHYD1HhHNjeiZPBc?=
 =?us-ascii?Q?1+ghW9aBp+GKRPScJWx8OQEYzNoyHrDJrLOJvZ+TWG6ID+pLcTujOypBRHnb?=
 =?us-ascii?Q?bGkHjUhp5N7STHkRRFq1GRHzBxkZUMIOqWswXBs6IUBsyz3uev+syxRy6i6E?=
 =?us-ascii?Q?/ljmwvIp2udVUedeDPV4kJeoaTAe1NvVwEtlBqpMhTjbSJXZAhjFc+6FE+LL?=
 =?us-ascii?Q?Q/t0tdfalIg7AvMhrcrpm/ANq9iWioz10G8j6fMbdODF/yBsC9M4rvwc/HZl?=
 =?us-ascii?Q?Ays7szQQgDvxRF3Qhvz4nyEzZ7j6zhx7kb9fpCIdL9VxFm0vPJKeMZywpv8W?=
 =?us-ascii?Q?+OOiBd8yVp7hVvZnPfMDYCGNsSpqRmol71QAeIy8npIMESc91pgGMLcyi8Dr?=
 =?us-ascii?Q?LnBlIxASjWwtNEW3mkwamDLnd33GwRJfmi3ieIawQ4IRFwdqTcd5Ss6/5tFc?=
 =?us-ascii?Q?Rdh0nkHR9PbGLxc41JP2Y5vDfbnXK5sX7l0vJsDt4dMOyE9gfWgcVBshjwOv?=
 =?us-ascii?Q?s1kXrHz3dtoweHgiUVv4IypbeVdQZFLAx14xTaAZD7HvSZS1h+zZLyOL4RE7?=
 =?us-ascii?Q?B7BOxCsOYfwVKze0T2+We/WfHFse7AmI9UioXuqPe+oz3JdhS2WO+t/MmGjq?=
 =?us-ascii?Q?q1PbmNc0B2kFXxYdnLopz7dYr5v5H1sPQ2b0QIxgrspbqrj/2/nNvkAr22Jq?=
 =?us-ascii?Q?h+thB98dHdjzFXwqbdkj2lv5xAX83J1TvlaX+VYuk4G/w4XlDfygn/P59eUg?=
 =?us-ascii?Q?Pi9632f06QBXY9cv8+ZQ2vtRbvuiMwH/Epdaqrj2IZglMkVw2N9WCEUsMTzo?=
 =?us-ascii?Q?NF6MF3Tf2U20+JphacUam6uebICK1XYv7nB/Uj3CIVsnjgLMwQGrLp7rGBEO?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14884185-adf6-431d-7ddb-08dc377fd53b
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:35.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcVTx4KxVwIV5XvS+XV4OeYPYpH7vyU5hzmbcq2lig4bPW/TI7D4zL0eBTAUAefqFEMidvZS07rFYKxqV90whNvsva8RsMimcKfvs+QFBa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

Move the common data structures definition to head file for these two data
structures can be re-used.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 20 ------------------
 drivers/pci/controller/plda/pcie-plda.h       | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index df0736f688ce..a554a56cc0e8 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -21,9 +21,6 @@
 #include "../../pci.h"
 #include "pcie-plda.h"
 
-/* Number of MSI IRQs */
-#define PLDA_MAX_NUM_MSI_IRQS			32
-
 /* PCIe Bridge Phy and Controller Phy offsets */
 #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
 #define MC_PCIE1_CTRL_ADDR			0x0000a000u
@@ -179,23 +176,6 @@ struct event_map {
 	u32 event_bit;
 };
 
-struct plda_msi {
-	struct mutex lock;		/* Protect used bitmap */
-	struct irq_domain *msi_domain;
-	struct irq_domain *dev_domain;
-	u32 num_vectors;
-	u64 vector_phy;
-	DECLARE_BITMAP(used, PLDA_MAX_NUM_MSI_IRQS);
-};
-
-struct plda_pcie_rp {
-	struct device *dev;
-	struct irq_domain *intx_domain;
-	struct irq_domain *event_domain;
-	raw_spinlock_t lock;
-	struct plda_msi msi;
-	void __iomem *bridge_addr;
-};
 
 struct mc_pcie {
 	struct plda_pcie_rp plda;
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 65e0f3b72184..9ca66916c609 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -6,6 +6,9 @@
 #ifndef _PCIE_PLDA_H
 #define _PCIE_PLDA_H
 
+/* Number of MSI IRQs */
+#define PLDA_MAX_NUM_MSI_IRQS			32
+
 /* PCIe Bridge Phy Regs */
 #define PCIE_PCI_IRQ_DW0			0xa8
 #define  MSIX_CAP_MASK				BIT(31)
@@ -105,4 +108,22 @@ enum plda_int_event {
 
 #define PLDA_MAX_EVENT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
 
+struct plda_msi {
+	struct mutex lock;		/* Protect used bitmap */
+	struct irq_domain *msi_domain;
+	struct irq_domain *dev_domain;
+	u32 num_vectors;
+	u64 vector_phy;
+	DECLARE_BITMAP(used, PLDA_MAX_NUM_MSI_IRQS);
+};
+
+struct plda_pcie_rp {
+	struct device *dev;
+	struct irq_domain *intx_domain;
+	struct irq_domain *event_domain;
+	raw_spinlock_t lock;
+	struct plda_msi msi;
+	void __iomem *bridge_addr;
+};
+
 #endif
-- 
2.17.1


