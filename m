Return-Path: <linux-pci+bounces-4119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE137868FB3
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 13:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018DC1C214E8
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507C13A269;
	Tue, 27 Feb 2024 12:08:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E9913A24B;
	Tue, 27 Feb 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035718; cv=fail; b=BuAnu+wMMPY4Mvj8jgLj7puhnA10jzLqwXoTD8pVOfd8DXZPEFt0KcYL+QFHNtkefy0ZxIZ0U8At4P0Qg3fvwGjUr4VuPDbxMoh1fAwBGly7LSP0D14qhoHXCS5s97xGyjAdNJ9eqdxMHKKhOqa+KVTA+6AQZil9qQ5J7C4WwGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035718; c=relaxed/simple;
	bh=MjldLW+yDUu+0LOkHkDamkUMatRtqSkUt7HWuxeLe6g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Wx5SWc7tXwrZ42ZKXA8lQ/reAm/+9D17EME3mXSQV6fwYOkI0FX0pnp3kD34pYVU5mxv27BNeqYX/sVeUkV6rwOwZTiQ30paa72G1LCrrV7z8IZPxUlIZC9fQwtoiGM5ZaX+V0yw91sd3gIS6RqJ8fw73iRuINNX6t6YTKAxFyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q46AJg/Ldkbxx0dl0YBIw1jTtN4BEaV1sSrtv24l2mJR2eVrI+2lb5yMecw7LazL5p0gxDihcmcxk3k/BZYHG9AhLlrkHFEI3dczcgxWepPPcJSQ6Ns8OMhYJCCOmAZls70f9ZEqqejszFeu2zurZqkkndjnlD0jdT8fvRiqBXzIkPOIcF03fPIJRFxWGyl9WfHkhYzP96CRAn1LKfL0tcjx11+hxQYn3FQBMn8tLiev7IQLNe7+GVXoMJOOGDYKWYj7+S/xYUgdZvk4J1jZQ6K+9yhZPlK2FRFTJe8i/wgUyaGw5AvT3HBBVtF0suYNds789Iiz0ggc3hCoOwsRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71RDMAlu1ICID8Xr08MWRpH0ivAdO+x72OYh2pWHDyQ=;
 b=d5j9IAodJL01X2NIdmfuB1tvdwgBxFIY7GRzsJhQjFZpoTX/AUrNCNw2UCnsbsSd9P1Pnm4EOodTp8o7N1NAGl/pMCv+F6MrGDQMjXFtexLY5C7JuAoQN6sM7pdMuhkR0NkyPi1qjUnuBjLJbBUdBGOLy/8pARUY8aFFf778i2AakgNf2TNIOB2yuEZXnikVNxvxVdgvjo2mf48TqaFKSj0hmwQEFylOxayTCLQhILWLGAn79zjqi/7VgLJlpSBnfBrvBe0zr0E2V1DAHzah/w1zdiCDZpYF0fYbsck5Rh9jdAteN5wrcVCK0DShZX8moaiH6MGf3lCIV2n1joNAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:29 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:29 +0000
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
Subject: [PATCH v15,RESEND 00/23] Refactoring Microchip PCIe driver and add StarFive PCIe
Date: Tue, 27 Feb 2024 18:34:59 +0800
Message-Id: <20240227103522.80915-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-Office365-Filtering-Correlation-Id: 33790b23-5569-43d3-7f9d-08dc377fd19e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mQNmxdcU2bs3juCvJSX92g9x6TiZTZJ+cga31wRDDjTI4Fl5z7BmtLDARTe0hye31AFc7yZ2HmEBQ9as9Z7r69kGETY40NTcqHWueSK7aJur46szZOvSRKQv4SfmzGmkClcsq2fQEKb1z/fVNkqVhrvecDE90RigtAHu+toKI+71qigNXWKMQecxyVMqt4k/bD+vtnSnNspR3W0yt0omG0S/rhgcpmnEDgyTUQwB8EuLr3ukuZS/sVbW5zzS2zHeQywZb13kY8TVrRmY0bAF+h2uzD4j+1ePJASXlGTXP9ZGNOO5Pd+V0HX2DmEn0L9ZoP1CXPpFjtUsOWcBCc/8cMWZjCepqqzovhxWYMYQW6ezHXvZJboam2valNSBHxsd8NT4Oo6oxGdwqk9o4gJnp/y5FdNx3gSyl7NnOBdfJQB/qmR7rUEpl+Vf3o9gr0eP9JaOkfT51YTjaYrowSwd2wWp4NtmrWaBVMEkDttmikInWfGPfO4hOJQorb0iRPucgUzveS+CLNsGTZEV7TamIXJXiM2BncLxT0QL9c+ofjejRXLNnwVdfd3VkwaaghmjzwYqsLUPU8kZ1FDMbILKx/DghWYp1QchuTeHILgrWOf4QRF45Vfa6pkydEn17HR0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a40ObUtVBsI1O6LEspYIApGJjfoI1Kf7ZfUtuVABnmgOCPxlR7ym648kmlHP?=
 =?us-ascii?Q?orZUtU+1knqSOZMdvPjF/tGQk7lcUyhgE8KYTlVBXh/doecktc4BItMlC7OV?=
 =?us-ascii?Q?quJLllBOGWY3U6Y97KxBukm3WexhlE6CMrTNQEWfev5dPIRmWfJgKI0U5IgY?=
 =?us-ascii?Q?ig25Tghf+O2g5SD0t0L6cOUND4crsFzibN9EqGfqMa8142pEsMWaX2eRxYAT?=
 =?us-ascii?Q?6+ZRRyd8RYjnUeABtxHCn9S728Cg++ptp+OgjhASmZkyAefQa4m7lHGPnVPo?=
 =?us-ascii?Q?6JiPuDWfc1jur1fuuSXsibDWQ34I/GyU+/XBHOZu2fLRnIQZLBt0FNTOU1ou?=
 =?us-ascii?Q?CBnOpaAT2yiioPJBv4pWoUtaR49noGrttzyQUzkMeQO0w1yOeL673PEaIx5K?=
 =?us-ascii?Q?y/EUVUulz5gA/i0Oo4KPVBJBDSC9IjAH3K2fZLvkvifY+mCCIVzFLcxJAF+5?=
 =?us-ascii?Q?PYrbizcZLs/LvRqGvzAe4c+XFulXY2D7KNO3ZipAMqVSTfVanOtm4mcxQbWb?=
 =?us-ascii?Q?tMM/v1h3oS95SDPBuqOMjV4EFIijKnTbP6drGD/cgidURZBCsUhhMD9CTeZ2?=
 =?us-ascii?Q?BWV8hf9rVa7Xkrn9JYijYRpAdqUX1IdKyvbCNYyWbHtFpcOUohC6hzqr/wEi?=
 =?us-ascii?Q?USpwsJ9eiL8zRalZwFAheBqj7rU5Z1Vk+rxuJA6FtemrGtR4f+YdKJO69kFg?=
 =?us-ascii?Q?aLEsiEkRzs6hRKGGZ3u+V2+XxASYz9twbinXs0fmAW8+5FLVP+LQHwsnscO5?=
 =?us-ascii?Q?+Z7rOa9LdF/mz1O2tVLSLpcSAyoCEYTmJNXmDB119QXhV5uGyLbj3h+sI2nJ?=
 =?us-ascii?Q?RrlNNlY5FSMCmBpPGg3t62nwDC8L8q0aVlHNIeODlJWjOx/deT07Z5USdYF1?=
 =?us-ascii?Q?I0qDogpU6DGBNehOF+bbCbQBnN9kSbcHJBKWYzse00qakBjPGPvOqh1XhkWg?=
 =?us-ascii?Q?/Dm3vJiceegIvcG7pwTc7uSfAEhc9D9Prt4m7rQ9tjEZpXhZpJkvaXcGaDIo?=
 =?us-ascii?Q?4V39M7eg7oQOTa3j4EeolYV0R0I15xychg16d2qlxAd9vFUERTcedJ6m51sM?=
 =?us-ascii?Q?Dxg1YArz1H+fIiHIs0Tu1YBPMqUaRFTBIBCjPh0e5dXoKZ10edTzwm7WS11H?=
 =?us-ascii?Q?bn/AIMqKmUmT5kh0um7jxmJb+Dh7NNbF2/SObKsXFcWLB/vSmfG9yoyZ9djM?=
 =?us-ascii?Q?DZdQhVTH2LXjed1glUVXmV2skO1OVaTn+3YnqmAOqi9TjxGrAJXJ6L1nAyO7?=
 =?us-ascii?Q?3iYi4Y92J3qzPFxo1dyAm6VXpkdjBOX7YORYUwfh78cjXrfgGHce/wb5qfNv?=
 =?us-ascii?Q?HIQBc/XO64idxk5AUYtqEbyXYpEVP16l8LTR9QqFREdD9RxwvmXbdzxaY44Q?=
 =?us-ascii?Q?rZN4prMmzewhyrmZaBiWMfUL2ijCXMH4SCr17OvMt2yDO8rDo+qOZizXZwm7?=
 =?us-ascii?Q?26xyXXVHst84MBxx3peQzMFNODIjxbj2Fv5rlsa87M2E2WD5Z6rAc0id9wmY?=
 =?us-ascii?Q?T9p5Ps7MyNUZWDilCC1RruFRtH/uG+2f6OvPnlBCuUO0HE5/jPlBKq/pHnWm?=
 =?us-ascii?Q?4TKwgM7vasCB8j06AWr+8/87FIduPK2GIsYLvccDMWYEuLImGipR+v+Y8ahV?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33790b23-5569-43d3-7f9d-08dc377fd19e
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:29.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8H2X9keFkZWbzt3di7vtL2mh57iM6DkUh2IjJNLcfGBtFOySH+85LJReib+eSlcSqs8GUkDTuCY86d7qwU1YiuhW/kboHkEkHrE4GhQRZ4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0863

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
patch22 is fix some nvme SSD timeout issue. (A workaround to JH7110 PCIe
qurik).
patch23 is Starfive dts config

This patchset is base on v6.8-rc6

previous version:
v9:https://patchwork.kernel.org/project/linux-pci/cover/20231020104341.63157-1-minda.chen@starfivetech.com/
v10:https://patchwork.kernel.org/project/linux-pci/cover/20231031115430.113586-1-minda.chen@starfivetech.com/
v11:https://patchwork.kernel.org/project/linux-pci/cover/20231115114912.71448-1-minda.chen@starfivetech.com/
v12:https://patchwork.kernel.org/project/linux-pci/cover/20231206105839.25805-1-minda.chen@starfivetech.com/
v13:https://patchwork.kernel.org/project/linux-pci/cover/20231214072839.2367-1-minda.chen@starfivetech.com/
v14:https://patchwork.kernel.org/project/linux-pci/cover/20240129005854.3554-1-minda.chen@starfivetech.com/

change:
  v15: 
     resend: rebase on v6.8-rc6
     Add new patch 22.(A workaround to JH7110 PCIe quirk).
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


*** BLURB HERE ***

Kevin Xie (2):
  PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value
  PCI: starfive: Offload the NVMe timeout workaround to host drivers.

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
 .../{ => plda}/pcie-microchip-host.c          | 615 ++--------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 663 ++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h       | 273 ++++++++
 drivers/pci/controller/plda/pcie-starfive.c   | 474 +++++++++++++
 drivers/pci/pci.h                             |  16 +
 15 files changed, 1889 insertions(+), 616 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
 create mode 100644 drivers/pci/controller/plda/Kconfig
 create mode 100644 drivers/pci/controller/plda/Makefile
 rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (54%)
 create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h
 create mode 100644 drivers/pci/controller/plda/pcie-starfive.c


base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
-- 
2.17.1


