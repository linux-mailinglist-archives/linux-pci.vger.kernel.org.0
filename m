Return-Path: <linux-pci+bounces-2671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D150083FBA5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9131F21077
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934E7D267;
	Mon, 29 Jan 2024 01:16:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2084.outbound.protection.partner.outlook.cn [139.219.17.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE1DDA3;
	Mon, 29 Jan 2024 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490968; cv=fail; b=ovGNLywtrHZewv9GDOf/TeMBRAQB5T78K/R1Z+qP1oQsK62e+Sd1SXyif/OOWFn0Txiy1VB64pZ7ceaCnwFdLUktCmpxy9Wxi2JkJmhDySTSKmLOZEn0N9nguSdQN4exw25aLa5n2eR0qYRwMHwMcsIx6inapjnT3RShglGlnQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490968; c=relaxed/simple;
	bh=JbW+UxZUp866Fhyk9NXneVY+ZT+ecAdOHbvukAn2S04=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=At6++/etSd81opNkIxWGn217TMGaBJDua7vhvWMpVcwwWvj17636sey4e7qFicb6li/y8AET1s+LId++7e1gzeZG43NfMEnPnCygIsHqvQo+iJubAbesGGFw/HFYgUaUx1W3E3vIe5G3qo8j8T3dv5UWiy0aZB5iwIQACTtWFzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Alrj7Vxcq21ly6tpjtHMByT5Pvv8nV1HMmhYdEAZqSn2PKZTLDXE65zEc7r5+MS9+h4yMmOgRh2b0osskxhEvCdbbt9QGDlkzKq8Sx/qnJTOgf2Vxh0dPHOTgGqrYPxCq3xpIutSy7dxjYgdTh62n+zyNcBR8cO/n00G1pdsoGeLjRui+IRmDyhwNG0kgg+xfy1WQHBA8WxflGtgOH8CQhewWztF4D7SLq5IRPPRzKKVS3Ry+ny+XyZgk9BFRPGmpj15ks3RcZw38FjXyRTBSBTT+Ajg52GqmTjI14k+phYUMofWkzkkrXZ1XpqCV7RzRmcblbHKCM5CrSJ1jjqOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e32gHqF3/4Ta8V5kx4q5V2+D4dF4zhKKR6XIQgjmQYE=;
 b=JXvbwRknv3lmy514E5JUiihvQuVm2tyvxsGiWs+rr0uUooPdw/GreF3UP3J9lZYAF7h1Ba26ZZoBSOlCRxn7e5cLNpuZ9zIMR0GsfIFqHu04EvcGzCqQj30eczEHBOt/qy6BD/qdGvr8AYe7HzsLjm6CyuxdUVpn/tUMaDV4LFQ9+Hv9M7NGqGiGz9cn8JC2nywUKihcL0pERp/CdDsJfboSJ0q1xRHs8S7ZBfVmHmUL0oBUPWIxMl6ynBz/dF0JuNgpIoekE/9rOZ1v9TorVwiL4GDDBQb6zDAdxErXNsACAyrWnyycFEhwTB807j32boEBC37uhqnJ28EmxTBqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0630.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Mon, 29 Jan
 2024 01:00:06 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:00:06 +0000
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
Subject: [PATCH v14,RESEND 02/22] PCI: microchip: Move pcie-microchip-host.c to plda directory
Date: Mon, 29 Jan 2024 08:59:47 +0800
Message-Id: <20240129005958.3613-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-Office365-Filtering-Correlation-Id: e649555f-52ba-4b64-d1cf-08dc2065a1f9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B8Q1RttqYNI21ZfZuxeUYXxvrrOynorQs7u85YJ00m6SoQjLFbNlDqN/Xz3dv4a9+5uCeStHApp0tXMTOdNepYXfhEFqH01seSv9nukzkBEuFvlDrRnMrpXcYqw++bEINUbu2/PusgMx5iN2Es5pqI3poGCQgFKqibS77qP/p+jXuz4Kj5cv1JI/IuGls63NG/D2BAwYP1nXQp2vSubLEG8YQh9P8a5t9bOItWMYjn09VEgQVbSKU75Nzvj40tzyWRB2WIBgqnoT7lupPl0yBIH3EogocGurSElAZLbX9AMOsnAxDkycRgBBb8/P6j2chFgE/RPsiU6SiWJeQ98ufz4sO/phHogeXwqWFAITo6Dtb/HDrpEVWN0iCT0resHGr6BbgjEL9OCpx04o+cZxCJwsG+eslv3VQEhfEXFtSOHJ8dmT+8BNA6AQdciP4GmNP0iHswK5hD98xtoWhhDC2zGWKa9Ci/BsHMyW8nCWTuvYq7W4qPYNbJuiPkoLsYfkY2PmuR9HHAM1ONk3Or/E2+JZivIvIS6Y7l8LUp5EPnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(41320700001)(40180700001)(86362001)(40160700002)(36756003)(38350700005)(1076003)(38100700002)(2616005)(26005)(107886003)(2906002)(52116002)(45080400002)(508600001)(6666004)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(8936002)(4326008)(44832011)(8676002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?23XvUu1sQUwT6+bmg7YUS8ErmSQS9ig4dpbb7eu4qnkIQNUI6BkEuyYvT5iX?=
 =?us-ascii?Q?6GJKN3UERJD1bLWvELz+9y5CEdqNkkXPyWTFaIdFreGb4AMHvYBygkL4yIPj?=
 =?us-ascii?Q?Rh4qrj2iwGCY3MWufsOLVVZFwwDbSyEfugzHgiN06bJnnGQLA8fev5DSD6J8?=
 =?us-ascii?Q?41PVQH655pIRIwZstfrWB57he5y7J/sjjRhdud1fgtYhhHjlpiaxh5ywM04e?=
 =?us-ascii?Q?fBEWrUkdVGN900xm7Bn4k7JBpzhazOshLW8amxD0C8PP+K2pKKTw9o3XRFrc?=
 =?us-ascii?Q?Gd+0RZ1mGCkZey4TV8FGJ6L41J7dn/0naJg4h3CnJstCFiPb0jEdinsZ2rG6?=
 =?us-ascii?Q?Pf6ikiYfLh9/J163OYT8w8O5xTi7G4yt89tdOQM+OOX42/WL6jb16dKXC3gx?=
 =?us-ascii?Q?+aJdA866TvWAADSQuPAq/d785H2IGpXi8xma8LpkzS39Mr5yDJeBc1dSV7PT?=
 =?us-ascii?Q?eTKcE7V9KCDvZFMpDp5+kgw4x0dwGUU6UKOHmJCvpVUEbrXK89TJlS8B3jwd?=
 =?us-ascii?Q?ya/KluZU1P2pUrkVvoKficIWw2e0UYOp8Rd3uLbWuyrGr/PgPLd7m5lAwkNj?=
 =?us-ascii?Q?WLKfR3IpO4QtyoZxBKBxvdJQSe9I0GmoF3WczhBN05pUizQDewuFgfnlvIXw?=
 =?us-ascii?Q?PyGkZ4zgRyaoRlQdgLVwLQz4hTn/UCycqIOPLiVx29SM1fOBJBrJtNfv12gm?=
 =?us-ascii?Q?TqkSG7yywSKKxKSWTY/GsY2H+RUnitcU1jwItVFaP6kVmm8YxAvONzleoGcZ?=
 =?us-ascii?Q?En+DTQ9t+AMdYPsmC8AhEZuBcp8th7zUB6yAwOfdud6idiK7n9vqtG6N8SsT?=
 =?us-ascii?Q?BW+ogdXkjhBQ/DGrqm/41uIpHsaqDZ6ahoqJLBjpUF48lZbVQplOpd+GxQqT?=
 =?us-ascii?Q?UCPZMGFNEJyS2ke84n3hNaQexm5pYI2d3/uGV6qGytAIxLvFBlwsGOD4oRXj?=
 =?us-ascii?Q?UhVTmZuXIuLX3F8s/LpnXhhUtG1nOpfJDMcJrw2V7LXKelQzzcCKDb0MSomE?=
 =?us-ascii?Q?5WcHrmNcqpF5hv1Y+jK7i+eE3BCHVuKOvvzHwNW70xDVPzLHbJf4I9OjgbEy?=
 =?us-ascii?Q?k04uD3ADo4xCykaBYs+Toemm2wzgz0n+9qELfCixrcdk2MotYhpYeprbb+we?=
 =?us-ascii?Q?XTJvRh/S1mVdEpgul9DdRuTYpDm4U285njhK/pDX74h2HK7L6mr73+9vlfb1?=
 =?us-ascii?Q?uetqkQNgiSu7pHOUcNoiYHfW5iCNYNv8Us+4CQN1q1oQF0A0sGYnTn83utE5?=
 =?us-ascii?Q?3zv7/enZzgZNy9DH9xERvhvs8KXddtGuSDqMuqo8vjqd+FIyGokvPUU1dACq?=
 =?us-ascii?Q?CAKuz6UDC07oSiAZ/ayH23XhnGS93bLTO/AZliseA7gmRMzV+KN/J6gOKB5P?=
 =?us-ascii?Q?lzg5qv/B9/6MxkXJ49ZfJDZJReM4qVHeQPMGXHilJ453hISZDQpPO2cQhPN1?=
 =?us-ascii?Q?UOx+DXHuZ2s2NioqCrHokn8SYLiDh0QxFs4rSsAxORNAOjtWaLsuKhMu2Np2?=
 =?us-ascii?Q?4mYRh63JW9bXmLkRJnjkWNMxk98qMZb12rPz7chJzdJxOH1whaO78T+Ev1JH?=
 =?us-ascii?Q?MzKBJmHm3Ilz/ri3byQ9F/0eh6ura+wj2j784FUHLIIruuM0f1XAqIJf5Us/?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e649555f-52ba-4b64-d1cf-08dc2065a1f9
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:00:06.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ga0AmoB9kNm0DyQsc5/4KWgkZ8Psffoo/LO9G39kIjMXyi8uSdHovtvnfeMtINun2HLzDjcnUC3mtlkH04rFtJbw1I/dzMeA/++2iVS1t0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0630

For Microchip Polarfire PCIe host is PLDA XpressRich IP, move to plda
directory. Prepare for refactoring the codes.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS                                        |  4 ++--
 drivers/pci/controller/Kconfig                     |  9 +--------
 drivers/pci/controller/Makefile                    |  2 +-
 drivers/pci/controller/plda/Kconfig                | 14 ++++++++++++++
 drivers/pci/controller/plda/Makefile               |  2 ++
 .../controller/{ => plda}/pcie-microchip-host.c    |  2 +-
 6 files changed, 21 insertions(+), 12 deletions(-)
 create mode 100644 drivers/pci/controller/plda/Kconfig
 create mode 100644 drivers/pci/controller/plda/Makefile
 rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..44daaf962065 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17034,7 +17034,7 @@ M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/microchip*
-F:	drivers/pci/controller/*microchip*
+F:	drivers/pci/controller/plda/*microchip*
 
 PCIE DRIVER FOR QUALCOMM MSM
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
@@ -18827,7 +18827,7 @@ F:	drivers/clk/microchip/clk-mpfs*.c
 F:	drivers/firmware/microchip/mpfs-auto-update.c
 F:	drivers/i2c/busses/i2c-microchip-corei2c.c
 F:	drivers/mailbox/mailbox-mpfs.c
-F:	drivers/pci/controller/pcie-microchip-host.c
+F:	drivers/pci/controller/plda/pcie-microchip-host.c
 F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/reset/reset-mpfs.c
 F:	drivers/rtc/rtc-mpfs.c
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index e534c02ee34f..4d2c188f5835 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -215,14 +215,6 @@ config PCIE_MT7621
 	help
 	  This selects a driver for the MediaTek MT7621 PCIe Controller.
 
-config PCIE_MICROCHIP_HOST
-	tristate "Microchip AXI PCIe controller"
-	depends on PCI_MSI && OF
-	select PCI_HOST_COMMON
-	help
-	  Say Y here if you want kernel to support the Microchip AXI PCIe
-	  Host Bridge driver.
-
 config PCI_HYPERV_INTERFACE
 	tristate "Microsoft Hyper-V PCI Interface"
 	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI
@@ -356,4 +348,5 @@ config PCIE_XILINX_CPM
 source "drivers/pci/controller/cadence/Kconfig"
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/mobiveil/Kconfig"
+source "drivers/pci/controller/plda/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index f2b19e6174af..038ccbd9e3ba 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -33,7 +33,6 @@ obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
 obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
 obj-$(CONFIG_PCIE_MEDIATEK_GEN3) += pcie-mediatek-gen3.o
-obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
 obj-$(CONFIG_VMD) += vmd.o
 obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
 obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
@@ -44,6 +43,7 @@ obj-$(CONFIG_PCIE_MT7621) += pcie-mt7621.o
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
 obj-y				+= mobiveil/
+obj-y				+= plda/
 
 
 # The following drivers are for devices that use the generic ACPI
diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
new file mode 100644
index 000000000000..5cb3be4fc98c
--- /dev/null
+++ b/drivers/pci/controller/plda/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "PLDA-based PCIe controllers"
+	depends on PCI
+
+config PCIE_MICROCHIP_HOST
+	tristate "Microchip AXI PCIe controller"
+	depends on PCI_MSI && OF
+	select PCI_HOST_COMMON
+	help
+	  Say Y here if you want kernel to support the Microchip AXI PCIe
+	  Host Bridge driver.
+
+endmenu
diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
new file mode 100644
index 000000000000..e1a265cbf91c
--- /dev/null
+++ b/drivers/pci/controller/plda/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
similarity index 99%
rename from drivers/pci/controller/pcie-microchip-host.c
rename to drivers/pci/controller/plda/pcie-microchip-host.c
index 137fb8570ba2..cb09a8137e25 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -18,7 +18,7 @@
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
-#include "../pci.h"
+#include "../../pci.h"
 
 /* Number of MSI IRQs */
 #define MC_MAX_NUM_MSI_IRQS			32
-- 
2.17.1


