Return-Path: <linux-pci+bounces-1786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F72B826C21
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28369282583
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E71E14017;
	Mon,  8 Jan 2024 11:06:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2042.outbound.protection.partner.outlook.cn [139.219.17.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B749920B15;
	Mon,  8 Jan 2024 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz84qJkKy5ccn4ziXRvay6D6H+3Y8EHtQ27sWMVXBZsnBO3hxztwuNVQUyJKwKeA7oN0gpXgxg7x63kHjbZYRPVZoH/f9MckmiOv7wtxE+Hz7Ic2fKR4CBK/hJR3e6CXifyDwfKmYJIP9MonmMDwMP9Ge7nM2Ber+SkckfHmjR1bYvXbBjlUQcvbfdaAIcsBO+wderii20KR65DagkYnp1L4/6JvvuEpr0HLZJodqOzuLCKRHa8WywNnY9p4ynYbflLL1NA43f2/rNVA3vTTjNZcIgJYbjIzZ9ixJMTK263eKsDzfo7uGmebFxErGdjwzGYPmXZDxoWrrtMgJPaHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyW4EAQbiZYuKYxXJVmGiy2m2BlKuB9GdjQyk91P2Kw=;
 b=ciWgSOS21hKjlD7EjWOcyVQ8H0rb5vJzynHpJ8gU4LyVPa59OpcuMFjOKJf5v7HIu7mnGnGMy7cK26SIixIgmDsMNSgGhGMk3+zGSE5mhQARrAS3z3cQAkEtC/CC/vgeY+G/xr6hwzJm7XXKFSkb8dAUV9yXgN1QVyMUiEH0Ps3a4NHaub16OOkBYXBCe6A5kQwnbH6ENKgCwSym7JwTzzj5/rBj8Vzhq1iIprSTb9FMiNYL2TSTNL7yX2/oAOFNoxdF1I2wRU+eqmU/jrRt59vjyDdmmMhLpNs5Qqke2i/qCiV8D6UPyu4xn2t5OkImvaCiDxN1bOA2/tV8QQszEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn (10.43.107.79) by
 SHXPR01MB0701.CHNPR01.prod.partner.outlook.cn (10.43.107.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.32; Mon, 8 Jan 2024 11:06:28 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:28 +0000
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
Subject: [PATCH v14 03/22] PCI: microchip: Move PLDA IP register macros to pcie-plda.h
Date: Mon,  8 Jan 2024 19:05:53 +0800
Message-Id: <20240108110612.19048-4-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0701:EE_
X-MS-Office365-Filtering-Correlation-Id: 896d77ab-ef72-4902-7f68-08dc1039dcbc
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n3RRlv7Qs/2LQXciW4gjR/3iSe/VCszG2LfeYKwi/bOVZTdOOxwtSg57ZIPwkSDdPc6pv0CNoaEkhf7KAYTNZGbDJyOEwHCeg3dtOf7MaDGreoBoFLZ0FD3ZjxzjfSjtSEqYCEKxZ4jcjJuEKezyT5UACDRHHFPugGBXKZsffKEtMpOuxW6nXFYszg2gevNktwfq2ddI5s8r12Es8wDfCAjJIqHbrZWAg/VkjSWD6TtO8NXzQ/o6UN4rycTrKuku4nINIL1MayJsRy8wLpnT02OYDSSy397ZFS/XgWiXJYw5/yF5iGOR4hFBiBXla8k1YCwjDF+oNkSgjQjLEC6uPrUIH4KAMhuXmnTJir1UAimsYjSdY+s1VtlrMdHbzrMXyEHWenXSdUcO3MyVEKf0AHCo+wtXZ/AJznOWAwfNsd8+U547KEFKENGE/bLDq20LEHmm3oE/KCESMrJYASiJgjmM4+sIxXVANNVm/5CQizDz/uOpZqh9kujueRdWWr0cd9FR9Flo9hx8dX05Mh8OJsrTlCi+TpRrd1yfv0YjfSgmfXh3VtDKYZIBW0JxSYXp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(30864003)(7416002)(5660300002)(4326008)(2906002)(44832011)(8676002)(8936002)(54906003)(110136005)(66946007)(66556008)(66476007)(41320700001)(508600001)(38350700005)(6666004)(52116002)(2616005)(36756003)(107886003)(26005)(1076003)(41300700001)(40180700001)(83380400001)(38100700002)(40160700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZzHVN2jk50FhDYUdk9oHDl4UWGBCVMLlxcVzMMrnCKdu6l1CWLz2PeshqYMD?=
 =?us-ascii?Q?fJAJdw3r3oJYkGod5wpbXSc9ceFEUt7qmi1oT/JBJp9G4/8WH8kFCzmzzTER?=
 =?us-ascii?Q?tjnNnIcmP9r+JLaoCDARb2wNHraF56JjemHU3z02eEJJjmhcAfmJwfU5KoDv?=
 =?us-ascii?Q?7EhZLeFvTqi7oyXmOtDUylsAKoSgfsMhxc3fYuq59kdqiVL+Dm33FHYHjYp3?=
 =?us-ascii?Q?TzD/LFlyzpgQyrzMKh2oZSK/IJz+LkypdAybRpXLB0KDzAZ+Ix2V2m3YT+pJ?=
 =?us-ascii?Q?i9pKwHe580PJfjrqTC9FxwEaqnog9IEaterbqxt6Z7opOd/YYhnr2RQXtqZV?=
 =?us-ascii?Q?AYJJ1Ix15O6E4vGDFXDDcqBjhN8EgQjrajrsGfD8Jg70ZBBDxSjUn7USuJRg?=
 =?us-ascii?Q?ebfMydLR5OZjzFodCLnj2ncRCJ0S9VdvI6UWbTBtsifsP2xifQ9jTfuXuPAT?=
 =?us-ascii?Q?5jbp4FC3wWush4yNqPBOZdjr0o3MwVmTaRmb3lNoxLBY0TNCRABTAWcbCQLo?=
 =?us-ascii?Q?6jVFTQFCRb3DNJKrOo0ISh5MX9/Z2I2/va9y8tAC4yRSNcv9iHOmihaiuG1z?=
 =?us-ascii?Q?XQso5NlTlIRhyzWUwLuB6sod8nLzb4IWCa9O5JXrF+hCBS3egw4jwP+KOvLC?=
 =?us-ascii?Q?e8Qt/+mOzD1sXQgVt/mdswHUUkx3Sc9peFhyfAVVwG54O+kuUjdNmvXjRPoM?=
 =?us-ascii?Q?Vuyw3tFW/zip8A5/XL4g56UdTV5p25Kgw+Rrh4BuXtptBPWZkQ5FuKyoWJOz?=
 =?us-ascii?Q?H1pAd1Zri6SLJW0apb2EaWOpYKKq5lPIxTH24Cz2B+7wTBkLnfjKrwFX6dqc?=
 =?us-ascii?Q?CoPf7ZzGbBRVObOhsvcMpXVbgHkUcU+lulJu5ElFLbkuHVMxMzHc90Hxzm5C?=
 =?us-ascii?Q?a/B/allBQb+o8+yBZJehxJKhxP613enL1ZCk2npXJYYAjh65GIoIYbRIFhQG?=
 =?us-ascii?Q?/Mj76U/7H8viCrewO3bKpmsvbSh13hq/IacZeMAshLbUOcKtPYG2haQt3V4t?=
 =?us-ascii?Q?wsHvdN0dkIEBFipO39wzpv3Qfx0wO3HoxyWrFu4UKlHF1hTVmLebxEKhBvJF?=
 =?us-ascii?Q?3/RkgyXbW8r495KgCXRaz8LRE8OMAfR/mXwNmcAv3PXLTy7gTHh9k05qn3OP?=
 =?us-ascii?Q?G/YduGUvC6/DxPNkLQl/ElM9hzlB21J+waOjV7zV5BIKTXLOat5QDwt43kLq?=
 =?us-ascii?Q?QPDUhcn9eWb6Cm9TUhk5PjPvZjdtWexVkTnb5OVA+iBqg4f1InGWubulguYn?=
 =?us-ascii?Q?hwRiDaT3B5pWBcm2f9s8ac7Jl5iMaKTDCttKUlgD06JhfpMzxjs8futmghDm?=
 =?us-ascii?Q?UuTeWUkckJt2DnNDLofNQTy92O+7MFGoVsQBLRCj1LUeQI9qGKteax8m6lsE?=
 =?us-ascii?Q?wy9HVlpuhcYh6m2Y/CV0CqW/WQtmU9Ww+st1U6poBjN4ueMqSqr7FTyNgWz6?=
 =?us-ascii?Q?SEPb6nMztVhh76S3NuikM4abye9qzATpRCevCZsKGG+XXEXd7F5f/zA1umO0?=
 =?us-ascii?Q?Juu8wSmET/04JiMVxpZFn1mknHh67ZevYMrnzt3t4Gqq3HwvWYq8aeazqq+Q?=
 =?us-ascii?Q?EhTZDlykefkU7eUy/vXCiWFvNehc3uLxrINEPeizRnnJUv2YliZ7ltxfnBMT?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896d77ab-ef72-4902-7f68-08dc1039dcbc
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:28.3766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JB9lk4xJSnJ+dr6Ii+KixusnyCesvjaxu/ftO2FX+9sHe4ZtO8ieBFXksrElQdC1SJX8u2kLextZIkKjqBjut5IFghIyRP8Fz1e97548+tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0701

Move PLDA PCIe host controller IP registers macros to pcie-plda.h,
including bridge registers and local IRQ event number.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS                                   |   8 ++
 .../pci/controller/plda/pcie-microchip-host.c | 108 +++---------------
 drivers/pci/controller/plda/pcie-plda.h       | 108 ++++++++++++++++++
 3 files changed, 132 insertions(+), 92 deletions(-)
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a2a4d2fab74..730fe2d640a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16557,6 +16557,14 @@ S:	Maintained
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
index 000000000000..cad3a98d967e
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
+#define PLDA_MAX_INT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
+
+#endif
-- 
2.17.1


