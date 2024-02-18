Return-Path: <linux-pci+bounces-3698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C103285977B
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 15:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437171F2141A
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 14:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71386BFB3;
	Sun, 18 Feb 2024 14:53:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86975FBEA;
	Sun, 18 Feb 2024 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708267980; cv=fail; b=QmtcHE0A5/ljRB1EokmsX+LQd1jyUFAPAJeHISLYXb0KOAHIGmHJGO3Bgu7fgh6dmS+xC1bcVCbnq7hpa2FMoGmwEnY6tGcFeZFmkI1kbsdV+bsdkLGj0SC89ok7e0H2N7K6dcsrMdYJZmXdeKicq/dwk0q52nTGdAIB8FSvcYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708267980; c=relaxed/simple;
	bh=qtdCexKf0RhV7NeUlusIXpJoviFDA09h0n1X+I3d4VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UC4DBr6kzz+YC9YbPjAVhy8RJjf+f0W92wb7gSL/4IsDkpXJeQepGqX+ENDv0OASaiNVomzkoF1VFViHrJRKNJY2Prl8TDJ+t0nXH9J4g5womk6ukxh3Rq8vJSBxEYxRyuOuiKOX4PxrHs5lRfhN5PeFvELFkyOIFv7os3ZF0mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGsqknNe/lFwsvynnTk3fJ8ArNaDHizPFdKnFMhRGgQ48uO9iLxNZzH8uyiP60Mi1HS+J9KgMknZJ8kmfsE0Ky2MuG6Zjx2WksD2KzqPHXyT8koh8itAcjyQzUxQrOpaZUMUuivNfCxl/QiVdxHzNAllJlrqBjgR8IwB4cRJYN5aZYFkW58aBYQzxN/w5OkqZ95IVuz0DiV+4jPB6WcGdd69q4AWIQF45VHBRMUBVrzr42/NpRsNwP4tqtgCDAL2CPEC3c5gydpiSTADnNRtNSIhUpOJ958GTsrhHfy2Q/7tvqdYMjubL728wHD7jkOLy5C2R5mUfpAJ8Ux3LVVXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNCECHR5VWLxr1Xb5YCK7OceXtaF+jtsMysQb83OPyk=;
 b=GFM957w38sJe7BMqIwdFhv9xcLz9L7GeiROPQjnv24aTD22OTp/vdokjcue9HJE+E3xbaQibVsWPCzMWY8k09lYA9vrgZ68+UYF3ZFlr5/P5RqVMO1WWLa3xTrzdOe997mW8mfB8THWVlzqFRZwveFCkTNW5eixlPtJsOtxECuaplIcHsCpUj3WXJt0kx/h9z4Lv8wgCHCTcG4IkXtpV7K3BBNzBMmRHWir748dGt1lpRYu6zP7swIHm1gM8VcaTWkVjdQ129hFHmkzrD9E+KJ+w1h4idyucYY2CafWdhFeLiLMSEHd+IrXBuMnyb3PW4Mi04sLNf0erpK/aPHTv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:17:40 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:17:40 +0000
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
Subject: [PATCH v15 03/23] PCI: microchip: Move PLDA IP register macros to pcie-plda.h
Date: Sun, 18 Feb 2024 18:17:22 +0800
Message-Id: <20240218101732.113397-2-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7273949d-a2a2-4e26-c48d-08dc306ad631
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hyWTBFsxVNPvG61y9wAgWZXjVEN+0VsjU3AqpF/9Y+rZG1KqbkRJojXpAE/sf/a+fXb7x8juwYA4B4TN0qZAgHWGRJmDo10An3ceCBWoewnTcSA26sgZR5VhSGgXRonHLqGh2jasIXtnudOvYxFzFky1BG8reTfiwIum6fRbVPr74IL8Qoi4JdR4giDK9VwMoC+FBoN/9QO5FA5MOLePxQ3puuM28qAMP3i4J6R5IeGwgTwhGIAori7OJelidH90iyzFIM+xlBUyEWUTZSpkcTRdTZzedtCJUr3Vx04b04wnScG/NGAsBYag/o+s1hLGdfRlJX8kTlGeM03TsW9s6EBXJASz5cCNTPekVI/d9U2LONq7nVI7mImKRdSc5MUkBXsU/MJkhbLrvfmgbBsvNhO4XiSHp3ZnvJu1t00/nakOy1ov/Q7qjRt8I6pLh4TXfK+Lp1iLDiKqYvYS79JZFpspS1naYOP5u9G4gLnTzs9Qnop6Ozw+Tx2mdDb2g5Je3q5cF9zqFMVraia3KrFLAOAHD7/k+Rn+zT2iXpFRXUQjh4O7fEbYNiwBFmdyCHpn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(30864003)(7416002)(44832011)(41320700001)(26005)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gV/V06eNLE19v5o8CPOzmSzMO9e2fPH84stcfn0sArUXyFiu6vs5DeU7kV7n?=
 =?us-ascii?Q?z2SKYc1Q7KbTjgA3Bwfd9Tm5CLlfzfv/FV1VIQzO1yNk3N3+kxK59p60POdh?=
 =?us-ascii?Q?VqaKtDzwtmeN4cU+rvjHaJWfcx+jcqZ7Uyz4D9YciCPKphxZq2WMOLWOA1Tf?=
 =?us-ascii?Q?ghHJpVmnSSUG+6Ht8MMzpDUBJhG2nynxCjskpuIY48mUYtaFjfn9QNjRGWcW?=
 =?us-ascii?Q?rJG7egdSaQe8Q3+cwRB8ChwDsjcDyB25L/3KVc9C9sQQza1PIPKgXIibE98K?=
 =?us-ascii?Q?9K3cpGJSyD15MWF+5ilApz6ZT29jUjYA9epY5EkfhhvjEfQ13glKH5ZFarlq?=
 =?us-ascii?Q?wwk0n0ZthLj3CraPaDspdDAvfJwgES9JbXek7U1SiPbl16/aKv/Curzb2b3A?=
 =?us-ascii?Q?H/JrL224a+ZdYNwmKJsHB4d80SigrD3YziUEDFdqg9WUfLd5TMl13G8H+LQV?=
 =?us-ascii?Q?uC6ybR0Qusjb+drouA8qxlBdEd+HybPFj54xAKI8fdlVzZ+y/2XeUzmBAZ0P?=
 =?us-ascii?Q?6okKhVIASRNXnddOlv7weMU6IY8JpIaAmTSlhR92mn22NG2qNlG0DTdEMnM7?=
 =?us-ascii?Q?z8KzllH2Ll9g3Y+2Hw9zxKd+sx6NeBhIdEKUIsFr1BkCmgibDNHRvkFSObpm?=
 =?us-ascii?Q?LvGI5FiaPaE68dF28nstBmA7stuSUSOB7zoDr8zlFE2fHCXEuZiVs5XXgeNZ?=
 =?us-ascii?Q?0DFGJtrgjv6UPFUflHvgoM1HW28DBAg8Yh6o5fUfcJuN9jhCDIItCLeTiDUQ?=
 =?us-ascii?Q?V6+ZFFD0InS1B7MgX3fnbcuZYJVO0gV/5AtwlHoc6ILLZUaA3uvy6i1h3DJG?=
 =?us-ascii?Q?X1lqQ3H/Y9rd+ote47Bas0hla62KhK6tVULWN08Ecj6wmjp6bmRehjHmzxVe?=
 =?us-ascii?Q?aeO0FQq8GdGNWjichPndsXZqYXco4E0hvV1tfsT8XANmL+gJ5VURS7IZNkY1?=
 =?us-ascii?Q?/DP8Z4djCxW2LQt+yuzAUhuPoVjfO0jfXFzXxN0WCX0JvjbOzmaPbVHsCBl4?=
 =?us-ascii?Q?0KdiU4lH8mEtetNdcO04H3oFzynBYGQ++0lAzPDKauhaXI/iXIkE3P83ajwy?=
 =?us-ascii?Q?l8M3mXPIQVaSypjp6DmfrMh+ARv/REY5AmnygaX2eUVugkI1W4ewQScuSp6/?=
 =?us-ascii?Q?6w9Jh6p6f83DNFUoESv7BbevzD730afqtQ9iazACzDDadmRFXpkjJ5O/+BvT?=
 =?us-ascii?Q?QFqRNVZOEvEe/0I7Awbm8JUkyAa/06ERJz3Upp1s0GiG5aBZIJK48E+BskRM?=
 =?us-ascii?Q?8CIhwJGIGtuLuqK3iLeFXJgKcpPgV49AV+nH95Efen9h7//4clnmX7pfQVgh?=
 =?us-ascii?Q?FOt6sItlNERSOsbac/rMPIZBJDtS5mB/cbo29d7y86HI9G4Jn4IjkdXx0F25?=
 =?us-ascii?Q?c7kyruihBY7WnIPJ6p942aD9Nb/OaMDP6BN5MmfQwdERIFwK+GpKATPy0v8S?=
 =?us-ascii?Q?PZn0QcBN+2Ood+iF0i60buFQGGZmo7hwgA6O1LGJsLX2Iswxqfoov8rvUewi?=
 =?us-ascii?Q?1jRQqnfEglMh8JHIDhUGGizNWIk490bez3uXi8r7u70Ib2lJuNKWlttdgT0t?=
 =?us-ascii?Q?CQNUMBL33AGDcdIVaPyRJ1ZjIqAFxi3UA7O4p34xxC7atROxbmZpNzy3oXKR?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7273949d-a2a2-4e26-c48d-08dc306ad631
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:17:39.9297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IDbG/LtN8XvbmgFIOW0Dp64BYU3x69tU1GbSi/lLlmnQZedj5h1Yu8X70mEHSJINCZeG3OJC0XqGJosaXUIHwkaMyzQMJsU8a7pn2X2/4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

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
index 2c28fb28270e..9c2132fa6f26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16808,6 +16808,14 @@ S:	Maintained
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


