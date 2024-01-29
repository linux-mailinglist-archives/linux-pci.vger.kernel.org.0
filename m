Return-Path: <linux-pci+bounces-2660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF05083FB7B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9BA1F217FC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 00:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E978F55;
	Mon, 29 Jan 2024 00:59:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2074.outbound.protection.partner.outlook.cn [139.219.146.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11BDDDA0;
	Mon, 29 Jan 2024 00:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706489959; cv=fail; b=paYepL0PP4ksjP14U7bDYQyCAJRqorj3w9/wiRaGtZYIp9lZfmI9hgUTZBxhPjxjdTULHnZrYEDyvRyYrFfub+y1kN7uVNjBno+npePtH/XZ5+NQhBdSLG2hEsiW1ERSz+mZyMTN7dPCqntlqO5zK0NmdpPMTD0EXgPJJcIggeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706489959; c=relaxed/simple;
	bh=a1fIuVIFQj5jHzv1N+V662J9jOLA6EtmSot2Scq1ggI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Orr0H7SbW9yx2pltrCwuUnUMA6shRPh5ygzwlQZM9OstyAtMAuG0l2WoMzrPHAdZSZE7xWkNDRQuEEu5OceWdSOGRdIMNmhallgA/ZkknIliBPPd2rX6ulalqqRFVcPsP5hxI+TQHjMa7oAvBfj2gxxfLeeH0lvv8CNjVfhIOWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg3hP0DuesBGqT2ukU1vJPVt5Z3+521u4fD3brpvJvM9NUi5kxiQovJuMbIPmqUlbBcZCXiEr954mgKQJ91pyAuABk6I8GI6V1DtSr+Eh7pShRF5n//IapbErdBt8Cn0yqP9vulxWrJyGaTbK2IKmboq7FZCLc8gUu4Lp0wCnsd26FBuaT/6+n2iIyGFcEB1syLv62DOVHBvGPM2bzraAdA+H4h/XfjrYAn02ZP3bMRAYG3DsJGm4l+1FJrhx1XdTZGQhyPJRTqtfAyJ/oLNfHjsfNiPig0l8YL59ogXeNuhJwKt01ddaS02HTSyJKDMMyt2OXE5R398WEeMaBRspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NgpySmXzoxq5FMielMScxGtRu1EyeCLpduhOf7+TO4=;
 b=SJU8krBeKy1UvUFs4oCVunryNUC2rsawvr/cm96FeeC/WLin1xyOGxJpsBtzaSNIk33aIB4UdPAZGLA3E1El3nzhX1Xg1vsHRCm5WqRJYfzkYsdmNA7I3ev9B2wmNiec7n+0aRy8raZ2YSn6plL+tj3iemvHVPxbl9I8kqAFUTe3TzWbXEH2wR9reYtoFe+9b/urFoavdk/JM/VErrqP/q99o/yyU8Fdxu80OU82FUiPbpaoTzVUa9HwX3ybNzCxF+0W6UnjMA5652Ix7PEAgtNnwYh1vjpGeoLGCvucxJW4c8swF9RbRRJdbpfL0NpGcjH0UkdzOAb0q9QEyAr9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0630.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Mon, 29 Jan
 2024 00:59:04 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 00:59:04 +0000
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
Subject: [PATCH v14,RESEND 00/22] Refactoring Microchip PCIe driver and add StarFive PCIe
Date: Mon, 29 Jan 2024 08:58:53 +0800
Message-Id: <20240129005854.3554-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0630:EE_
X-MS-Office365-Filtering-Correlation-Id: feca1bc8-6606-4a71-5846-08dc20657cd6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xnOYMZQziqJXl91EbiqgE/AQbexJSDaq8Apox2jR7lKMmP3JOKh8j13+8brjJR6aQQ3m8aDf0ajOUX7M/ontKrIio7z6JmXzYm8k2lgXf4zKguv1exdUSTP9zV93bA/zhkMrTZQNDd/Lc29E6DffPTFrP4RKvClafZC5CPsVxk0g678BGYji2DH2jF8t9CsA46pnwtLkhzhBVGlNJtWMfPsiIR4vYKqEeQXg1IIu3kA0F9FAXHUKtBg/oa/RJBEFapCSTjbf/Tt9NoVvQh14QxUwuXcbzbUVAXmpZsgngL6JgJT1u45ICXJM3K43m1sH483NeWb4k/AzujfjjUj0MeVJjP2VDD+281zmIXPkkoCteGM1oXeFyKtaiT9Ir9M8oYBUkGWKqLMbz6G7MO2jMMoN1tP6BLEHU1DidJD+7eOuwdf7NNOPeDixbMtVxfkZOaO6FWUZzKFmaoiYEMxAP3r2Q885XqGZRXCq12iZisDZFPkQzIwmOQAAvFa5P89k1FHsY6TS6KTQwwcZcjUFhucZNJZBYxR0jhgScFCbXLycu/9E8VKDvLXL049k58E3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(41320700001)(40180700001)(86362001)(40160700002)(36756003)(38350700005)(1076003)(38100700002)(2616005)(26005)(107886003)(2906002)(52116002)(508600001)(6666004)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(8936002)(4326008)(44832011)(8676002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?toLbP8W1gckkGRR2qijtxUW4nxX2ksqH30YMEp5lLoq9YK1icaGl+XqqPh30?=
 =?us-ascii?Q?VgONJf78Yz1rRn6VtG1vt3IokQGv7oXU2N9PWA4KhaSccBfJ20S4ZKMotefT?=
 =?us-ascii?Q?B988yRVmQgY0HIgWmKhAiv9Ps03eDgLTao+DPLqR1mQW1AOgtnI9YbPs9995?=
 =?us-ascii?Q?tdzsK5Bgl06L3kAuihKBseZzj4b+/FgVaizWacBCl92AinCKXFMCDuKkQeYP?=
 =?us-ascii?Q?lHNPZGSU+q/W5x78T1W8qU5bso3r6F0H+5d74LWveemnRmwuRn3ep3nw9YCK?=
 =?us-ascii?Q?WI5VARTmuhj/Gs1LPwrTs/T3Atd4vqE6qEaLWJpNJDsFRfiobYpyPsIL7DEx?=
 =?us-ascii?Q?j/YdCL2aG6zCpydm+HLID/hV77IKqqXbx7w6HPq9DDTgSTfgsxvQCN9hPeRb?=
 =?us-ascii?Q?NgEN0gzKx4gaBfrLUDgyNj5eBRtAOqypJEdulkLWWqovB6HA9NQQik5Z95kB?=
 =?us-ascii?Q?4AL7ZxCbuWH5Htq31qzOLK9xc87NXup/PryuMurs5qhJJFfSHEYXVMfnpxYj?=
 =?us-ascii?Q?W9l0wO9hSMxJkRvYnCggjOc3+5x57BGU96P0061jzUOitliNej0gjUQFtZO/?=
 =?us-ascii?Q?tFVb2XrQb7sQ7wTPSM0ftVsziRr2R4IMlqK/xNv1kCqs5oHrM87t9hNyfN25?=
 =?us-ascii?Q?XOXFLJrHHLAw511lONfAvleNRFkTyIa8WGZOGPp2sfaG6F3GwGOx0SUCabxR?=
 =?us-ascii?Q?zMm02Ebh4zawuWoF+BwFFhw5c667VuyEE6MQ/n6SXG9DtSkOQtTnPmXKF4uC?=
 =?us-ascii?Q?OqCeD55bJ76k63AdiWLOTP1iqrndfafk541KhOeHzz2JNMJY42myRrgANTTy?=
 =?us-ascii?Q?/+z/s4YCWkDYCN098+5ss0x43bbETETsV/lHiK/+iv+wuhfRgdtYv5MAhfWT?=
 =?us-ascii?Q?yJziyt+FDjtC/jmBZc1HIP3kBpS9CXaGnuVthXUhPjaa5Zfv0tes4EfT06CD?=
 =?us-ascii?Q?/LYLMZqI8WJOIufNZ1BYRGBVSIXBg9jOff4KBDin+dWs0C/UXeSpNavmpd82?=
 =?us-ascii?Q?une1UiRg1E9eJvjW9hFm8/hTJSZNv6+Y5ko+N83gBgJeimYCQiX1k/Q14+ro?=
 =?us-ascii?Q?BHatD/ZooYwxFsqq//d1160Mmk6pMMS/aSmQZ8wYkuTkEhWlgvaGjvXjhrQk?=
 =?us-ascii?Q?igcn6sBQ9fO2a10JrZUq2E7d0R9ZVp1kePvlnc0coatUnmvTVHmoZzIIDBrU?=
 =?us-ascii?Q?Ekz04P648v2Eu9OchP08/zZPOs5B3BmLl+G4mRrKW6Kuc8C9VAYCwQlFIZyF?=
 =?us-ascii?Q?q4nMgBtzp5BFJEH0cuAEZ4DUEHncXRdjfrKNPFe57YmOnTuXHGHd9kySFOxy?=
 =?us-ascii?Q?fqPH2hsSJCQ94tCf2N/5lVLkqZYj1MF8KIOb8fYMHlORqG3y4OqaTwO1sNhr?=
 =?us-ascii?Q?rkvB5QAOJeW90Ek4JduKB/vaT2StXzWIk5Wl7w9nzcc5bOWk4cxa+fcCvFfH?=
 =?us-ascii?Q?Lrc+YuIaUnlF6d2SDdU0b3s2CqMDlQEcVuIGorB9Dw2D4bZMBuUZU4r27H3i?=
 =?us-ascii?Q?B88daEtlnIn9EiwoBMAjRU5dHj9b/GM6+v2KbgdV8Hbn6MZ2K12m6z7yApjH?=
 =?us-ascii?Q?NCXFvYE3U4Cdh6x7o5MD094ZuK8NqmPwHljgMPzaUKFcCF9zswSp8OdkPd6Y?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feca1bc8-6606-4a71-5846-08dc20657cd6
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 00:59:04.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/hysvxo45zahjyjbw8pomObEmqUBqN7BqwaxD0Rtz7oxMs0jk/0R/dtX0j8t7nHoTtp8qrC9lQZ50Y5iLROATwemKf89X3U14TQx+zixNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0630

This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
same IP and have commit their codes, which are mixed with PLDA
controller codes and Microchip platform codes.

For re-use the PLDA controller codes, I request refactoring microchip
codes, move PLDA common codes to PLDA files.
Desigware and Cadence is good example for refactoring codes.

----------------------------------------------------------
The refactoring patches total number is 16,(patch 1-16)
which do NOT contain changing logic of codes.

These patches just contain three type basic operations.
(rename, modify codes to support starfive platform, and moving to common file)
If these patched are all be reviewed. They can be accepted first.

Refactoring patches can be devided to different groups
1. (patch 1- 3 is the prepare work of refactoring)
patch1 is move PLDA XpressRICH PCIe host common properties dt-binding
       docs from microchip,pcie-host.yaml
patch2 is move PolarFire codes to PLDA directory.
patch3 is move PLDA IP register macros to plda-pcie.h

2. (patch4 - 6 is processing and re-use PCIe host instance)
patch4 is add bridge_addr field to PCIe host instance.
patch5 is rename data structure in microchip codes.
patch6 is moving two data structures to head file

3. (patch 7 - 9 are for re-use two PCIe setup function)
patch7 is rename two setup functions in microchip codes, prepare to move
to common file.
patch8 is change the arguments of plda_pcie_setup_iomems()
patch9 is move the two setup functions to common file pcie-plda-host.c

4.(patch 10 - 16 are for re-use interupt processing codes)
patch10 is rename the IRQ related functions, prepare to move to
pcie-plda-host.c
patch 11 - 15 is modify the interrupt event codes, preparing for support starfive
and microchip two platforms.
patch16 is move IRQ related functions to pcie-plda-host.c

------------------------------------------------------------
The remainder patches (patch 17 -22) are not refactoring patch.
They are for adding StarFive codes and dont modify the microchip's
codes.

patch17 is Add event bitmap for mask unused/unimpementes interrupts
patch18 is Add host init/deinit functions.
patch19 is add StarFive JH7110 PCIe dt-binding doc.
patch20 is Add a PCIe delay time macro
patch21 is add StarFive JH7110 Soc PCIe codes.
patch22 is Starfive dts config

This patchset is base on v6.8-rc1

previous version:
v9:https://patchwork.kernel.org/project/linux-pci/cover/20231020104341.63157-1-minda.chen@starfivetech.com/
v10:https://patchwork.kernel.org/project/linux-pci/cover/20231031115430.113586-1-minda.chen@starfivetech.com/
v11:https://patchwork.kernel.org/project/linux-pci/cover/20231115114912.71448-1-minda.chen@starfivetech.com/
v12:https://patchwork.kernel.org/project/linux-pci/cover/20231206105839.25805-1-minda.chen@starfivetech.com/
v13:https://patchwork.kernel.org/project/linux-pci/cover/20231214072839.2367-1-minda.chen@starfivetech.com/

change:
  v14:
   resend: correct some commit messages. base on v6.8-rc1
   Add a new patch 17. Add interrupt eventmap to mask non-implemented or unused interrupt.
   patch3: rename the PLDA interrupts macro name.
   patch9: remove the redundant head file.
   patch10,11: modify the commit message suggested by Lorrenzo.
   patch12: modify the commit message.
   patch14, 15: PLDA codes will handle DMA interrupts. Modify the commit message. 
   patch18 remove plda default events. This is implemented by vendor.
   patch21 Add plda_event instance stf_pcie_event.

  v13:
   patch14: 1. Add plda_get_event() function. This can be compare with mc_get_event() easily and 
		track the codes changes in case in the future..
            2. The host event_ops is directly set to plda host port.
	    3. Setting default host event_ops instead of checking event ops.
   patch15:1. Add PLDA event irq_chip instead of event_domain_ops, The
		event_domain_ops can be re-used.
            2. The host event irq_chip is directly set to plda host port.
	    3. Add PLDA event irqchip ops codes.
            4. Remove Conor's review tag due to whole patch have been changed.
   patch16: Also move the new added PLDA event codes.
   patch18: Add plda host init and deinit function only.

  v12:
   patch18: modify the commit message and add starfive review tag.
   Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS to patch 19.
   patch21: Add disable runtime pm function in starfive_pcie_remove()
            Add "depens on ARCH_STARFIVE || COMPILE_TEST" in Starfive PCie Kconfig

  v11:
     check and modify some commit messages again.
     All the codes are the same with v10.   

  v10:
   All the commit message set to fit in 75 columns.
   All the codes fit in less than 80 colunms.
   patch 14: 
	Commit message changes suggested by Conor.
   patch 21:
        Add 100 ms delay macro to pci.h
	generic phy pointer related codes moving to pcie-starfive.c
	This patch Change pcie-starfive only, bus_ops move to patch 16.
	Some Codes changes suggested by Bjorn.

  v9:
   v8 patch 10 squash to v9 patch 12, v8 patch 18 squash to v9 patch 16.
   patch 4 - 16: Add new review tags and add more accurate commit messages.
   patch 18: move the plda_pcie_host_init/deinit from patch 19. Make
             plda driver become to whole driver.


Kevin Xie (1):
  PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value

Minda Chen (21):
  dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
  PCI: microchip: Move pcie-microchip-host.c to plda directory
  PCI: microchip: Move PLDA IP register macros to pcie-plda.h
  PCI: microchip: Add bridge_addr field to struct mc_pcie
  PCI: microchip: Rename two PCIe data structures
  PCI: microchip: Move PCIe host data structures to plda-pcie.h
  PCI: microchip: Rename two setup functions
  PCI: microchip: Change the argument of plda_pcie_setup_iomems()
  PCI: microchip: Move setup functions to pcie-plda-host.c
  PCI: microchip: Rename interrupt related functions
  PCI: microchip: Add num_events field to struct plda_pcie_rp
  PCI: microchip: Add request_event_irq() callback function
  PCI: microchip: Add INTx and MSI event num to struct plda_event
  PCI: microchip: Add get_events() callback and add PLDA get_event()
  PCI: microchip: Add event irqchip field to host port and add PLDA
    irqchip
  PCI: microchip: Move IRQ functions to pcie-plda-host.c
  PCI: plda: Add event bitmap field to struct plda_pcie_rp
  PCI: plda: Add host init/deinit and map bus functions
  dt-bindings: PCI: Add StarFive JH7110 PCIe controller
  PCI: starfive: Add JH7110 PCIe controller
  riscv: dts: starfive: add PCIe dts configuration for JH7110

 .../bindings/pci/microchip,pcie-host.yaml     |  55 +-
 .../pci/plda,xpressrich3-axi-common.yaml      |  75 ++
 .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++
 MAINTAINERS                                   |  19 +-
 .../jh7110-starfive-visionfive-2.dtsi         |  64 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  86 +++
 drivers/pci/controller/Kconfig                |   9 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/plda/Kconfig           |  30 +
 drivers/pci/controller/plda/Makefile          |   4 +
 .../{ => plda}/pcie-microchip-host.c          | 615 ++---------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 651 ++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h       | 272 ++++++++
 drivers/pci/controller/plda/pcie-starfive.c   | 473 +++++++++++++
 drivers/pci/pci.h                             |  16 +
 15 files changed, 1875 insertions(+), 616 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
 create mode 100644 drivers/pci/controller/plda/Kconfig
 create mode 100644 drivers/pci/controller/plda/Makefile
 rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (54%)
 create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h
 create mode 100644 drivers/pci/controller/plda/pcie-starfive.c


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.17.1


