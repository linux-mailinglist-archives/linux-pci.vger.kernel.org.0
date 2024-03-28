Return-Path: <linux-pci+bounces-5321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC2788FB04
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C831C2D5C1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73F67BAE3;
	Thu, 28 Mar 2024 09:19:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2114.outbound.protection.partner.outlook.cn [139.219.146.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC7465190;
	Thu, 28 Mar 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617544; cv=fail; b=kajHIGIuN0YsWDSFuWnZJ/lxr16eeVWAP3gmiwz+jIoXcZvj25c6j9OF6vvkM+H7ZGQMeYGOWpktVVfZZzjXQdToKi+r7bizd9iYINbLopSuSvxiEQ9qXzD1SyNw7rS0pTnuTEGVFl56FeNGMGbzgR3cUst1DBRoYmvZ3L/T7wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617544; c=relaxed/simple;
	bh=mZVP9mVmY3/pMTD7iw0Dl1X5GonWjA2miVBBPQjZy7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b2gr/FC1KOFCBob1P8BI+2VpluS4Guz2NIkHxhahEYsXIyuTah+O/kjHEr9cRgKOFC5RAAvXDQSQBWTogc6AMpGKMFIg/kPLHIFNKwn3KVbKv7hWVjBYGN3H3WRx8QHrUY4jnbIjIpG/vJCeZYX61v/pppOV14ChyWRp0/qOtsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8TFlcdivS6tx+X1sOaO5tFlNogmFWNo7+KkRq9YT5OfSnGn5JiOqetohmwsDx0H02A+kxCVIVvcbywsBRAg0xtf8WohhAfyLamGdWVC2SPNIKMyNoJLz5f1tcI6f4Lqq0lNImbXnEU8HoXuF1DpLilZGAU5Wm+zeoSYiQ/zMFx78xTUrUb73M/F7/mw26fpwtIBFrs9kpERI51IHl/5S+wotrBfFGaBCJGFz/O4LRV1w8B4gkgaCaqLi2d/+uz3BMZYMM6gBKmlUwasjGOm6rURp25ViJhW8Qjr+emZQnozDKNAs1M18QvKTpZ9gO285/0v06Q3fGBycfkan57qwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAk/xwn7GWZglTkzp3uu6d0eYZa6xFACZDWJOfpZXJo=;
 b=AMiBXMlDA6oyQLSL624dbPcwptgpuDkJ/WH4Zb+cAEO71VAPrg5ED3gnWUD43nGiLSH0HM4k0XmRZ5uNU/7I9+1rOfpJZDzjiyYzR9MjzvQUQXNUiIANyMZpTM6UImQvM8M210DfjdZL+Xe+CcI7uSo6h+pvdUraO+Zwx8Zz2fOTUAyCl1irfyquXoRcab9D6oOJM9kCsyrFDYCguapJGRWnGEBA+7nOIHrV9vbIMK8lWMi/uXIgyaT8BNolQaMNTRvcNFgzJ2wIe+1zbSnyOxW6SQcp5c+0OKrNbMDGnUSxiQsopTGcojtw5KKcFSJjBa/yz3Ks7vpkvQ+OhxkPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:47 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:47 +0000
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
Subject: [PATCH v16 03/22] PCI: microchip: Move PLDA IP register macros to pcie-plda.h
Date: Thu, 28 Mar 2024 17:18:16 +0800
Message-Id: <20240328091835.14797-4-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 20346f6f-0279-46c2-581a-08dc4f081280
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zi9q3aBW9H3FecrRyjD2B8gabDDGKtlFDzxFRSfkcRwACsslCn891w3DYOCPbrvm/r6MujgV7tYscLvygIyFokE08PzHiASKC1pdyDYLCIKu0QbwSMaS9QZmXlUZ6t3vA++IbTmNSlyaHnXLK/9xq9nmQZPnj3ozG5KTWEcMEB5QD/kOgXHyXFhUAN5/leWAd+mJyGAT2E+1Dwxf2sxo2cwYqMzCHuVK6B9WaQBgvCBnqUpyylXNjgeXD+RelJSoNzS6xZcGrbshMAYfArfWalCGTD90G/BqyizYgLxkZlnW1mRVbESbLISTuJj+DgQDVqduVGDE9nAWXt2jMFwxiFDW6Ot4YwUuNp//3WkBuITmeyk2M8+VRXi2TQuj71JbZtE1KZU3+YeVG8Zl/XVMlpHm7IqaF5QshDvRlIHz8+O7IGqVbr7pD+LXwlhmf086q6z6pyjkoTQGpYF/9h/u5XxOADlZQQtqKAOWIjMzts6KZ5fRrodWRXMNrwIbhATCgCfMFZDjgH1OWq6Ir8/Nk/oeOG5X8hm4aBFJTcJ2P+xsTDaQAiLIrdLZbrA7P0GBufT8aHyZ57gMhEM2aYWuZnxH3DF57OEFZsM/ROxb+wKyuN7C9g4v3OC4deLWALnh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HkogxtgrirA8kZWoc+6A9RLqPcB2W2elK39BL3oCnihKXZdfMI3MATjHeyU9?=
 =?us-ascii?Q?GayRK7T6ZGqpNwwyc6mqah525Z5IKXQx1Ls+uiu4EyX2k/uaVCXcCEagPFG5?=
 =?us-ascii?Q?xisR0c3vpAzSTBxAP6Na3w6ib2v+jXNhjkp5ZF25tvC6tLMaHQtji2lwcbez?=
 =?us-ascii?Q?SWqH2T7GHXNdZwq0KrP5kYAX16JYpT9F43hKd13eMWpkjSjRINI8YcLlwCVT?=
 =?us-ascii?Q?UckAJUHiBw9uyYUoNopTSaaJXf+xWdqvbg1JnHy+zh3nJEBmFYNmvqDGmZO9?=
 =?us-ascii?Q?iSzNEKStzPYSj5jxgWyK692l7G+ZGJTr+/4vyrnZJqQYjy0JLZSpIV89kuOU?=
 =?us-ascii?Q?MLYCKVmkVtt/pkogFVuCgzHMHSYuK5phyHdYWV+6EIDm3q2V5TIq9Yf7b1AK?=
 =?us-ascii?Q?9/AQQQgd2E4XKfENMHk6ce+hUu7IyKqHf30HrNT0V2MfA8KPcbPgst9O2jDY?=
 =?us-ascii?Q?E4iOdXd7D23IgvYEERTB2kJKHVuBf2kSCUlGOWMqWnOEghz5UJS1EUbn3WxI?=
 =?us-ascii?Q?jXRNjPxG6vXIXBeDEyJbAlxb81uc3gXzCore1bnj0uUbLGxw6nRtGvmEz0mr?=
 =?us-ascii?Q?1ZykWG9QTuAmqihjWgKsgzDNuHFrjekRN2b91afmj/bpFdtLk4G29StjJ5B7?=
 =?us-ascii?Q?0nX6wIZG4h2Q1lYeCGY31UVLO62PfCSfSeymQ9lArDWOvzmbYrsQEYW8/MAI?=
 =?us-ascii?Q?wbVHRqsoE/uXFpYFh03dZFviNLIRLjB+xVBfr7Si/xFDX2AKWTImr6m1g/9F?=
 =?us-ascii?Q?W0NCcj61318MRXMDFOR1c8ASGATIPhdqviPzslhcLIU5KxTnwVugD/ajoLSo?=
 =?us-ascii?Q?ImZLpkHJ1//17Rr1qDgO7vm9778hGdZ9ZkwZsLSHZ5m8fQxKlOhOfQQexZ9G?=
 =?us-ascii?Q?uG+MGWrRhgxjfJNEE1pAB6orOviSEXAZE/7Dc6tjHkQYOw5pjLMYRnQH8NZW?=
 =?us-ascii?Q?o4hu8iqEqczLcCxF7obl6929EfmJY+pD2POutcoLgc8XhOogC3DekKXSJOSz?=
 =?us-ascii?Q?FCNgbIfBdvxSItPg70zwlCHirF+gw2gwGjqBt4R48JhoiwqgbpnEvkjfMwvK?=
 =?us-ascii?Q?C0C18+IzYdeGloVnPGyB0j5wQSp/d+JzVrscmq2jWtRRJhS2HQSRf2bARsoG?=
 =?us-ascii?Q?JMI6NQKWk6c6Nss5mtW34IgjtAw6Vl3KsWjIcNQXhSgfXVa4P0lraW/He2Y5?=
 =?us-ascii?Q?pmX5Hg+N7LUTFdw8C2khMIFQVxYa+Wi7tqeY28NGY21D4Au7n99HCyG9aLmk?=
 =?us-ascii?Q?CbWtuYcmIX0XDZplQMez7dbltcq6YSkheGo4LN7/Djklj2nwk49V8FuGe34W?=
 =?us-ascii?Q?9Z6idM7/Yr7CB9uAp1OhcPAruCRo47V1Zt9pgOeFpf1ESUWRnjkutdWzytys?=
 =?us-ascii?Q?i7m9/Wbtd8sVCcB93PcKGngffkS4nTKowdp5fkhnXwCHre6cJWroKLmlRLcN?=
 =?us-ascii?Q?DQR6rOks2ixLTfh3nvU/3OMIhdhfhF4yKVgop6dxO2X1LQZNfePJ7RNmSkkr?=
 =?us-ascii?Q?oknOs+zHOhjJZC6BlqeP8ml050MC13Og2XlmlqYE0crIg0PFNMrfb+STBTZN?=
 =?us-ascii?Q?S7p9Mo9EjudHuOV77h65Pgix2mzcJgdevVwB1Y/dmxieZd5N3MPJd0w32wG2?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20346f6f-0279-46c2-581a-08dc4f081280
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:46.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXUgtRani3aIcYJmLkQUjdkUYL4knuHV27DXp5nOrPiHirO8Z11a5kvnQZGyZxSu1FlpfFcF8VpMiCXD8H6hokaFG/iBLeAlK9O+5Tjz5ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

Move PLDA PCIe host controller IP registers macros to pcie-plda.h,
including bridge registers and PLDA IRQ event number.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS                                   |   1 +
 .../pci/controller/plda/pcie-microchip-host.c | 108 +++---------------
 drivers/pci/controller/plda/pcie-plda.h       | 108 ++++++++++++++++++
 3 files changed, 125 insertions(+), 92 deletions(-)
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h

diff --git a/MAINTAINERS b/MAINTAINERS
index dd158cc7b009..1fa4d61291f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16951,6 +16951,7 @@ M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
+F:	drivers/pci/controller/plda/pcie-plda.h
 
 PCI DRIVER FOR RENESAS R-CAR
 M:	Marek Vasut <marek.vasut+renesas@gmail.com>
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


