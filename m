Return-Path: <linux-pci+bounces-3689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 424638596B8
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 12:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57781F21A39
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826821B811;
	Sun, 18 Feb 2024 11:49:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7264EB41;
	Sun, 18 Feb 2024 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708256981; cv=fail; b=kff1gpSxFAY9+XCW2R8fMfr6bckK0pgitKyRlOpgjQeH+CLp1QWbSD8RsZzRAqTixAGXQmjWKvXlCUlo9GJ31jdk9xoTEx3CtrsTXmYoPRw7a98kt0zH0pEOSu8TZJLCSP5xCD5IPjbkSWhp2tcFRikGVUU1kpUdhE4KLL4mDRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708256981; c=relaxed/simple;
	bh=0zKdFaBEvvTpoknHfFCIpkeI8FGLQQLyd6lI7L5NVyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=g6pGhIaxbwZwnv6L0N69f6k3H2x9FTQcBFa/5nG0j3V57FKaYfP0RLRBr84dFTqkpjN+EdAmZlAOkdqW5iy7ncNh4u5qtftRjK76fUXrKPVom4DBQWUh1SHxFH+X2BpNFKjnLBumxzS4pcJGeA51kAfnhZBPa2MsnngAiqr8dPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs9DVCcSJdjD3KqxtPCK7DOBmYEAqSy8wlTbMZdSFNURwCqE2qeDzsstmBfcl+TP6F0QExQ35WPQVdvO5tnL5FHjJgqIWq872zWewK+skbfG9419pxrirySks5v9NNdMiL+keQPQTTmCfILq4KAd0HoahcKlKy5MmdpW35c5Y+bvZSqWP7WtQHTfah/vwjH0j8d4nv4EinopFayLn5f9JwAAG3PFPOqPWLh8k9wI0kUKChF13JfejM9F7i1tBcEBcRqRsPm8GUvogSAZp0QF8M+s9E9LoD6ggXX+4stUQOgFXMScrIW3g4QeTm9YZncEJCAVVwBQ1x/g6JQ/dYCn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVCQG8bILR383viubFKulvnCCQ0XA9npwE7/M6Li5FY=;
 b=Crtf5gZa84VjhATQzpzATRBB99q+PJ+kHHBtnim0Gb8gSkyA+fEymTbiuWzIaxAuI7aPC0sE/emTZWCo5Y8RM1obophlFQchdk3Naf+kvBHK4GUmDe3ZLYimuMbFkIZkKJCQ6m5dxrsYXF3iw3LrDqXa1uyp+C4el4QYr7gF8oJGng03KfxmO9CuvoCUen6jhEaLeWNpv37tqYK/upF5sATBiHbktJI1bHphCyQ3t/TyzFGlOi8iYNmpn7L8iJE/gfz3LFAqXfTCdoapEmwKhJDWZM7AmYFrIQhPEg6YusJWXl61hkHk1/g+muVbY/c27+Rob+oXR2gNqe6ftF9P3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:17:39 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:17:39 +0000
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
Subject: [PATCH v15 02/23] PCI: microchip: Move pcie-microchip-host.c to plda directory
Date: Sun, 18 Feb 2024 18:17:21 +0800
Message-Id: <20240218101732.113397-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-Office365-Filtering-Correlation-Id: 92ebcdaa-84cb-48e4-913f-08dc306ad5ba
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MVE2nMsuFb41oXhHPD5JkrdI4ndwRUNry7NrcS+nQBZChHujxIyFTpeuFzxzfZVynrZ4W2TF8pWC8IFCOCCXpSi/+LAYqI8rx404JtIhTAoASUoYxOUR8B5ZQo4jJzVQj+G3u7NWE2xPf1COF+lnq9D2jfi1rt2YvcXEz7zU2MkpYpP4a6nqNNJKwl2jPkutJPLW7mK/8C0b05gBalIBILd6lgkjpJbnKNbCjnZzaN+x2d6Elrm5XOZ0xkxx40gbPySLaLFFq7mlbE+cj7QYe0DCPI6wVIr+prbL6/CSXikAlZ2Gd0G7b+fugWnQOMj/JV+6W0HvrsJnkokhpEySeU29q+RpIQeZbZyWIKObMCeyrSxMiBqY43ITM1BVeZYKRKUvwGaVXMAuLzfLQBFo5zRHRRBWUVEBZhyGMrmH8jUWhJrBuPeWK9ntHhdZRl0IjTkGDoSs3yWZMl/BFGQ5y/mkKcFy6sfNMQbqWVEyQ1/GAhQe1OYg+tcAx50seZvh1oZGlgBWzCyxDaEVWFrPslHEMj5g8wBv6aNdZp+U67M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(7416002)(44832011)(41320700001)(26005)(45080400002)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DwQtnWRKdPpB7wobOBIz1fyFDL0bprTeylA3eyS3QlpWuw3gC6hOVP5R2XZh?=
 =?us-ascii?Q?0jMUPoZ217JU2QEa80/WBfz5pdJgihjV+A50M9APvwri6cCkEy2YIhYz5k0F?=
 =?us-ascii?Q?kNmBF5iIGACZmA/fazZSfntQSZgu+Q7/4od1Pm5sn+hgvlG3sjXBpYe2QyH4?=
 =?us-ascii?Q?y7Jdnofm1A/Fn1cdynnr9XB5Q9EIkDAPqbxaEpK8AUEIMOFngvX5n9qdknbx?=
 =?us-ascii?Q?L1uK9eNJplnWF/JpOqt7UGyosdLe3tSPogUXdak5uB3BxM0z9XbfZTM6LIsK?=
 =?us-ascii?Q?6SpRAwgjyEjIU9EtYojnAiNwxP2Xx/NBypMmzJ+zfXxohwq+KBxc1PWTgJOL?=
 =?us-ascii?Q?IMhUXpThfr4wWpzinodJyIthRGTsfhj7s9RODvr5bfQOEqHxF1ZzI0Nwww5J?=
 =?us-ascii?Q?qagGzNNBnAk0dAB1WxN10aTahmt2/bCBl1WJ5YC1q8Rxw+P5ctSiJM5ec/2V?=
 =?us-ascii?Q?/D6EQdpR1xVMwq63bZP5vDAW4V465XR7cusTOJF1s4aVPya7mH9SB6ddmw3W?=
 =?us-ascii?Q?uK6t6sJbjTxFs7GAlipfq6MI5fjXAV5cX2dyoNtC/2NCT0z3BCE+xkQ82atO?=
 =?us-ascii?Q?+rmkXo7GIMeOJ+kp+l7uRRxv+u455nbbXfh7R1Tsdi/dTnqk8d7/6vTcdSSS?=
 =?us-ascii?Q?1O4lVulSKGiscYtSxAXMbeV1uzV/l3H8rOrq2bWyJf588aNW0DzLLJJcH+rF?=
 =?us-ascii?Q?6GxQRvrA7qkDosc3HcsE11S09/Mh+jK+aai9FVH3rg1MkqVealhnn4S400zo?=
 =?us-ascii?Q?I01HF1rQXMum3pq0ivlfEbUrMSEtpdBwcYecPfsGZldTpYPfBePhCmat47aQ?=
 =?us-ascii?Q?nNqRLDHeoeOqXdbYnfXFaOqN0NJu0H2Vx6ZbQC5Df6dH2QYhiomaz13ViQpY?=
 =?us-ascii?Q?1+SPVZeB8BBNWlAWnjg8xFk33NfylWBeuojjhqOvCRmTadA7Hc7eeKiyJ+Mk?=
 =?us-ascii?Q?0TONoqK6Xt4OVdbkdY619xuYRFbAsyGexCvI8nApHJCETp+RBiES9Nzp+JXO?=
 =?us-ascii?Q?q1gdEo2mkTi5XFBpXbPKFCPvqck2KKTVEXgwO8W1BfDp5I2DzLdiwImwBpcw?=
 =?us-ascii?Q?SNKpHFytZJG0s8Zk2yb0EYmynV2DAcDiWHQEA5QgrxHN5ZSByzk+Rtn6xYXg?=
 =?us-ascii?Q?GA4OT8W+cKZocf8wBcqBOJslh3CxXfGmEd/oBHnF/Yq07evu/q19xY4keIHM?=
 =?us-ascii?Q?U87q8B3qJSO600ZOEsCKoqN6Qg1817RbjZrmkr76icm9QuLC0rXDupXYhoX6?=
 =?us-ascii?Q?BF5jAjuGHAIf5vIQ1mgkel6f6JLj3w9Z4V2pm3hNMLCBquDid36lg+WFxnU+?=
 =?us-ascii?Q?AzGodXoRu+aa9W8PKawRYGcsLn/MQkVC6xQL9G56m2PiAgrghSZJCoIBXKRt?=
 =?us-ascii?Q?WMUsBsPUgd9ldbR4QYnhCRDUrNuR04Hfh+/H5w0bGj+l49R76slT+PVPHrbw?=
 =?us-ascii?Q?I2EAEJgaYnyatFDUi33yxVWq9AG6P4fGE7pP79yD4S9mbxw8QSUaAcXmRCuK?=
 =?us-ascii?Q?8yNzU1bFld6WULbKkOsG+xRx+G3kQHq+4Nt3EA8VdxbbhKAWGzmrHBBS1LEf?=
 =?us-ascii?Q?otO14hUT0BnEjwoXJ4YgpzPF7M04fVfN5QWxYA3lGFL3Io/09VIIBFdca7qo?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ebcdaa-84cb-48e4-913f-08dc306ad5ba
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:17:39.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFXubbSX7vk/QnjDbi7onGpJog+nGjXl6n6EoT8JW6y02VEA6bNGOxi2SZ4IM8F1ElBb38QCX/H/4AZAWoisPmyJCRlTwDfKkSBA60wino8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

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
index 960512bec428..2c28fb28270e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17039,7 +17039,7 @@ M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/microchip*
-F:	drivers/pci/controller/*microchip*
+F:	drivers/pci/controller/plda/*microchip*
 
 PCIE DRIVER FOR QUALCOMM MSM
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
@@ -18831,7 +18831,7 @@ F:	drivers/clk/microchip/clk-mpfs*.c
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


