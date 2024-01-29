Return-Path: <linux-pci+bounces-2670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D533B83FBA1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FA51C20892
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8F7C8C4;
	Mon, 29 Jan 2024 01:15:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2056.outbound.protection.partner.outlook.cn [139.219.17.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035C4D267;
	Mon, 29 Jan 2024 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490946; cv=fail; b=Nx2cetx+NSoT7I9QuMbE+HAowywbICOAl6xk3Q9cVcY7Ae2tRiRD65NfQDjGNTC9d2CxyVoJkBCjCtC5Tw/trf1vwvWNbWvYPJI1+TuZgR7f8JXRyjZKrzViDHNiV4jGuLoua5rSf1prqEBJxhkTrUIGqUOHZQfST81fCnZW7zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490946; c=relaxed/simple;
	bh=J1Vs67zFQuxJfPh0mWcRE1H80ffa1MU7C06LvBAwQ1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ktwk9fJ6HCPaEsxSjhKjm0Ml02CO1NXYoQBvfE0QP5sxWA1IxXNOr81m9hjhO9KHhrPnmxTTnIUTGnaS7Ziv2P/riwBGwwjb8uuGfUmQzVqI5SQRINlmlNY8V29fNeHnRCuLQjxLnZYLBnOrgGw9XS3allCX4MVaztTwaMQeiUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTryLzGzwujo7mnKS1MoivSe5PL4Xy2hDNCB8OdAsecarfRgxYj/Nmz3xjZfM6PN0UAFzmCw24KckpiUjs5TdbnHmnbJC+W0K3dej+chc60B2froF1TN+yQ9I+FUlyHnsIa0rpzG3IaekPwtAFYaW4xBhgu0fIBTWv8WjxEFIbKYxqvFhNO8oGJiuVVaXCw1uLGkyO+BMBiQegMr6l2Ut+dscWgKT38H7dUKGaFUJSO/QhW39p7ZHmfJpL0kyrM2rbhovXntQdqdbRjlQ7JwcSbhNioHXRIHOn/WN7B2DH86ycWBxhSU0YK8NhKuQYefs54vez/NRIT/NBAM1UaaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Itcg3aSqPauiN5XQFv7dSMmeVokhY5xZ4+FWKeBoZIs=;
 b=D7/6S015+vJek6eAcHzuZzoBHo9ykkzt+ZwE2gWy+MTF+WC+0H4VIvJGblyforRC4LEj3WOborLFnwAY4eW16Q8RtBnG03EH5UDh2lbC1Jxf2PQI5kjvHs1UyceH+Uu4K8H7e7u5RSj5b03fJhzYgwLRZB//roNYtjwvHmOz8Mvec7rOWonHwf1FM36bRdn83CWlnp6OXtoSpj1NxjfjhTZ6LLsa1lYcEtqipGsSHyBXxzDqvgGOjAKOpLRCi4qcaTujnbW5Jlle9PSb4hrr0Om3Mxa57kXJd6Gl4m6kIsJyH2HgH+dcwotqMkbtTQPwkOo96hD9QgLG9Wi9YkSuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0630.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Mon, 29 Jan
 2024 01:00:07 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:00:07 +0000
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
Subject: [PATCH v14,RESEND 03/22] PCI: microchip: Move PLDA IP register macros to pcie-plda.h
Date: Mon, 29 Jan 2024 08:59:48 +0800
Message-Id: <20240129005958.3613-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129005958.3613-1-minda.chen@starfivetech.com>
References: <20240129005958.3613-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::19) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0630:EE_
X-MS-Office365-Filtering-Correlation-Id: bff46389-2aa3-47cd-3ac0-08dc2065a2c9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3hP2BF1MvR3TCgMDoyFqKmm7BxHOIZAtRUL9u3IxZfqfasgGlzoSIsfFSsJjDjRkgaYkjAozQsseL0ahCjm7Ph//D3hZ1FHztvJ81gLaplRC5QWuB8njA0mxQj6b4iWNaiB2qxXn+Fo9K8Y80uc52Xrt9qOSRfJbIFPuGy47DpkSM3Oz7JGKHEhkSLfxf7uCsMqDi//ievQUHIdybuf0ZuFFIvTisU+GmapESCMVl8A60K1UNwyFU86SsR8hxwGXgR+OPezrbfgUamaHK56bgc/nUsn+bjo7igixLJeiV88GTLhYTo8TOM8Mmj1CBHkmzZuCAoBMndlGJfVT/1FnPmD9tVjUsqqMW+l6re+IkFi0oV3kb7HPA7wY4i/gNtG6c9/YnbacW/CoWoQdJrtwwlDJ+pfol4Yzdw0DL9It7p5KZ7jbOGMbw+1rl+WlaLFpl/QOWYhxuxu93xaThJrqU7msB70dsnNBIvSp11GooJxMubNG0sk5XejQLxEjzFXsytDFlVKXMocyw9Bt8n9TjdjO403mweQTOyjJ45BiSWrWaZQpVsy6UxEENw5ffBc4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(41320700001)(40180700001)(86362001)(40160700002)(36756003)(38350700005)(1076003)(38100700002)(2616005)(26005)(107886003)(2906002)(30864003)(52116002)(508600001)(6666004)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(8936002)(4326008)(44832011)(8676002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rlqf7olskp2Pqfiq20hQ33mEOhwyUxCQ/AZjlMy5QLZesxOvJwg0Q1mbmwih?=
 =?us-ascii?Q?DqLDyiLruJwV5qJ0AUbCFt1gve7CuK6f3+UYOnK+6PHUUNu0wA5GO71r1Ol3?=
 =?us-ascii?Q?atd+noQs756fgs2PWavld9y9w7cdjnPR+6ATFsI8vGpDl7Cq3GmUxsHMNlHI?=
 =?us-ascii?Q?1H9lCUTa5S68aH89srs49Dx3Z8ERNyx3/cpyFv937PPR3SQIqYWi1qnQMpji?=
 =?us-ascii?Q?t6hhBw91chIl+p35GhSyK6QRW+9A4PNhJHlmv7hopxZnKUW8rqpu4TwpnXcK?=
 =?us-ascii?Q?+kItLmRX1MTA+lLomdDna1j3kRYW1H6PLIh11hz3gA46yvkSgAnySdLI2FJx?=
 =?us-ascii?Q?w905JnaGkFOPSsZ8EqwvZ/+UrDptjD9usuFuPtIyYKGsnWhb+yLJOFu0KPIe?=
 =?us-ascii?Q?bR9eYU0/NDCmtzenqh4E/FrONJP5ntA+GVRXeMZ4gvAoZ7o2wTi/UOVWmydM?=
 =?us-ascii?Q?ZOTGpM/Mt+38fAkWXRQkreshMmttUSe4ODnlV3dFed3jnHexaLbA1ob0JqZe?=
 =?us-ascii?Q?yw7Fd1haeTeVX0VDBsmzmckjt+9qXPVOMF5HOXHKgHc1b2cDi15wnwDKohCZ?=
 =?us-ascii?Q?KM/XxcCUY72dPGHiMuj2lF0tsKxKFtLbqehUlOZw0aH529G9sMPKgw6+UaKe?=
 =?us-ascii?Q?JLLkk5McUp6DkY3MULlDIqhtMvOTtYrrbv9Pq3A9/Ue3MfDK72XEX4SVGJqY?=
 =?us-ascii?Q?7fT8hzw4tzwv6yZ75uRjhhmPXHYc8RFQUAGlPYlIEo4/tfFG9akO4CqyryWj?=
 =?us-ascii?Q?xfmfNCglk12UDD5e8KgkHFEYwrnR+ey1t3ejIp0pHhWRSvSI8f1ZQyHtV3Bj?=
 =?us-ascii?Q?6mkEoXRpDgsa+fsGoaNSbkVSDUV9p2eb8JZKuFg660u9xqrayVT5+MHOqAK7?=
 =?us-ascii?Q?c3llMn/T1f90kpMZLAlgX+p1pN2T74+UG4hmy+4WLfwlOvA767bvNFGVPApO?=
 =?us-ascii?Q?5NEHcGdMpMequVliIqKB/Vn5kz/m0yQuesxvdIwtNVILzI+3jUAkCbquYn9q?=
 =?us-ascii?Q?6GIG1nzmdDxkcmvge182TXYjaXH3N2p3T2sfARv2H4jxwaIomhoeS/H9C9OE?=
 =?us-ascii?Q?j6tjCrBGIGhWchtzqO/TJlnokIlx3EZF66DcWcfVA67uKcf9QIZW27PWhHT6?=
 =?us-ascii?Q?ofxzNtMMMOS5Tt34UOePdsMj7e9hMPATkzKVDdHDms8P6Y0oRFpEdMPhcGdV?=
 =?us-ascii?Q?1QxEVsJAAguL/Neqzru0eZGbd8odUcorqqrzbqN3R/RYqozh87JB/Kg8ZUD8?=
 =?us-ascii?Q?aWnF3iC7Vrhc8U4wRQEvjsSrNbJgyPKKafIbKJjAQ5tkL22NIUkAO2MZc6Kt?=
 =?us-ascii?Q?GdP5O+vVnSLIsn+hXg7ukrVdQDnN9w11SfRBOeitIeRKp6B69F62M+1sNGaU?=
 =?us-ascii?Q?XO3Fe4W1hXBE//89agqOlLwUuLxgY0G11Uijexz2XURiEMFg0cE7QIAp6yky?=
 =?us-ascii?Q?/wYw8m4ZJPBvlfKuKhEkAs0774E30E/ZKj6EurFTwfGd0XVlJ7MJhLfAaUBC?=
 =?us-ascii?Q?NWn9q5bjRoeORRyo+JSoeVwYhNGV19BYEoMwdypmZ7poVYhnzTiLDqtpoHD6?=
 =?us-ascii?Q?6T77yzreFf7v/XC+l09AbzXQo7t5D4XqT5tepnp9fe3hzoKX+g1IbkKBTcmz?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff46389-2aa3-47cd-3ac0-08dc2065a2c9
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:00:07.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghncKGugvMWn8DjrgYd3dvPCASKHf7nwuIevJ4dCA0M2GmDG303Tmky474Ju3pRFDb1XiH5bdg4N3mXYIi1fHwR4kU8A7c3XNufwRantLIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0630

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
index 44daaf962065..3b8d7ba12807 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16802,6 +16802,14 @@ S:	Maintained
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


