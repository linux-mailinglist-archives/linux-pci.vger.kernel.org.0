Return-Path: <linux-pci+bounces-3680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42E5859664
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53D31C20C78
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84944E1D9;
	Sun, 18 Feb 2024 10:49:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3763527A;
	Sun, 18 Feb 2024 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253399; cv=fail; b=Gv9EFxUw2k3IRKvPW20fNxOilwqdWx0IP+d5iyoVnRPWokJuTcTteSU12FkBOZYUxz0FXqfEMECiK1JOJHS24jtKs8RRDLSrour2S3mfWFPQU/JYIAkyLfNS2XFIHvERMXpQHbbxDNu1EU7qqk+7rZNN8hbDMCEJrMGvhN/iwF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253399; c=relaxed/simple;
	bh=RtY9mI1Mys9t78uHLspEFx6YMGr74HpLCqgrPJCEsTw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nOep/sPVp9ituoy+P3ews47omRNnmyJwZ30no0t0YvrB6MQKKC+k2i+QJLRkR6D0QPBPuGAXA0x/1hZILZA9/KEvglsdLelQGzAQVv9meIUK5zVvYCl1ZKp0/3abi5DOBWIlrkQO4VpDzE0SoYddbuRGf4oL7awDC7wDRnQAvq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVFOOXMnt3l98yfyZs5+MBo9Wd+UrgmqxM5X37eNNi8j+SCudnVTlLkKQfZ7OR3BOtrUOa/S1rK9VvrhX22rfouezNMJxlRuMnEUL/yXPA0zsrW4BioyBati7rbDca5uch7SOhdoFDsU5qGo/fHkx2pPkrmyRRizIU90lGIUMp7ZZulH9BxTLAMeKU+zrWIyHxPiKLFs8sVOHrSsoPqEH06SwVzwmvAnbsUwvqQmqpq0UlPXeJRXLBZsODLpm03vB1mabSrQRE9R+1bb97Jqi5dknJIVhWxCSoNR/jxXFQlt0kpWqYIo7+RT7I44Bsgdu0dkr0OHZ6OKwVVoeAWPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i0/Q0/Ofze1GfEideIzLkV1MUM7i2tiqby6SbsBOUQ=;
 b=fyadhKwLM3+/xfCFJadKJ1vg3wlcOct0BegRVUlnq5FTYHSCca1C7XB36N/lWGDa3JaTjqWSET6wUthlU1t6UpxmsaecfhVRXW9dFzGbAtknx5KkWztdSiO/1CHfcQ0F05SyBoN06/WiPSfyNzmp6a1SZA/mEMhpeNAwShZTyq9H86VT0SKBZ2W02JokFCwrXPyL/aMdzvqO9weJ1u3KYGTedmOLyRZmPEmzRW0Akkl7KzXEnuCs1SsdBP3uw4wCCsrt58PejaYdEzsRrY1ufp7mk2mXhCQZr7kU+urTN/HYL55jOSXb6t8jw1UqyoY4IsxiRi0qZy1Emcd04dH+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:15:38 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:15:38 +0000
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
Subject: [PATCH v15 00/23] Refactoring Microchip PCIe driver and add StarFive PCIe
Date: Sun, 18 Feb 2024 18:15:29 +0800
Message-Id: <20240218101530.113306-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::28) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: 97757169-b2f9-4b1a-fe22-08dc306a8dc2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HHP6FEfN6T3ifQuqBGD/g/3VLRHj+Hncv08ETA46IZmLpQpvwu/Qh2XmIqIYypsJN0hWS5yVGBTyyBlfaqbk2ozlseJyWtsw46DLoSoCbtRxxUEM3ptpyGy6zJ9c7Nsi41FgSuTkcpnkLz0XF87dtB6jRDZGnVklxBGXMUxFc8KKHTPLhclElXn5c4ql0SnRJxUJvp4TlpFKXM9gw1kjgDpTk/TvG4E1LnIG3WDFP7qNluPx8V4AXcFehNT/d+HGWN8Pdy5/Yolz22tCxULCjm3dCIUyaY6uuTXKkGwyE4+J8+uBNkEoG4ZirzHRuv9rD4OUC2mcTzNYpX0rbOgg04zhDPCxgHV3sYZozhFWzLJ/PrO+hLbCU/9uYK8xU+w5rtx9c/AKF4YWUaA2rzr7zmXyz8xCOZTb40X0WQSfukxKbxUWQSbCgyLIFLfqBx0WsjXb80gZw0Uz/cksdr41c3r/6rIX8eMofPgy3zwBMfZPSHvGXid+8HQ2ekC6guWJQH2bTO/DFEgJuOJmbERw5Lqeig+w8O7Neh4huB+NfFS9gITa7YgGAR1a7vFpKvVd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(7416002)(44832011)(41320700001)(26005)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A4oR4rq76S7t3EFkZCGK174slV1SXCYfBi1YQBNOBF7knbBlUh7ZjacEq2pm?=
 =?us-ascii?Q?GmYbQVMxOIX7jkhxcxdyjOV3Hf7q86pqN+glZGFX417ANr8rAeBTriNvoL5c?=
 =?us-ascii?Q?ch15pAMjgRBqb4ruCBfOnw2Xg7RoxgIsAc7YJ8zj0zHEUuW7HH4dz/1JPXts?=
 =?us-ascii?Q?n05VYa1sjcOc0oBnGP35Ws3djgu4ejEYd4aWW5SG2M2thyeXSEH2Ujt6iL8k?=
 =?us-ascii?Q?l6fyN7XeGZR07iPhwiUdqWE1okb4u6fYqhFtxEwMZTRpLlDeEYzXNgeHZJyN?=
 =?us-ascii?Q?0Vem6uFG1bpxiFxJ1M4zPTzLOXX8i3jPtqksSS9sdCsEE0En83PF/EEoaXSm?=
 =?us-ascii?Q?7Aadof8CQYLEgPU+HfATbFjGq6spAUzwJ9c0iJyg56xmg0uk+8NDHP+uo45l?=
 =?us-ascii?Q?OBFXntV0ms1HsBVTSp69zBSDLXVh/8g4XMfKzbqUyYwY3K5/MEm0liN0H+1q?=
 =?us-ascii?Q?fuUc/lNIzchx0lm+6IDelXk01gp4nFaAUN8+QW+euXtb5jRlQiTqhm8EhkjI?=
 =?us-ascii?Q?XfzUYBHljH23T2Afwy8tWfBxWYc2rzxpZq0CzrT+xdgZfYeC5Ya0qvv82TKu?=
 =?us-ascii?Q?wbggJXKvSnD4pCW5tsq3RbZblFIgXtJcrxbno9oG6pqnp4it4IiIOfWGNgEW?=
 =?us-ascii?Q?KseS6CiXEJOl+fR7aOZre5JJQZdsg72xXiI7p4PSkFR7SPNvVF1Z47mg5ICW?=
 =?us-ascii?Q?peoQWvlJNefQFnTclvhwxlPf0lv45NkD3WICKbLsUtHcu6oeZoGAPQQ+3mNO?=
 =?us-ascii?Q?H7fSuQFFQ4oKOEqyk4zwU5ZvEEw11wg+cpRAgb0ALamJTRcvAsKxYcX2SfCS?=
 =?us-ascii?Q?4vhPiw60G+7ERgFUnZAQ3JNIXRG8IGOUxbfJsOEnxOwZPr2fuhirf7iBvow8?=
 =?us-ascii?Q?vT2SS2n2AAFx9/OpunODM4qskM+6d7s5VYoLziV1MvHcq+o/XjhPq69JVa6X?=
 =?us-ascii?Q?NOD05F/Pqu/k93zjWkMAHHCBxyvG11UPrtm5bf7jCQKd/8nN/t8e01doimHb?=
 =?us-ascii?Q?i0hB6qh1GXlgbCK71EgLZWo/6+QeRjYAcyMDK5YfhIrmJsS4cb7bzwSL+3I/?=
 =?us-ascii?Q?41U9HHNIacNpbc6gW0capI7dNLdsYQTJemGCN+eX8bH/9UVc8UoxmdUdVfGc?=
 =?us-ascii?Q?2zdCSiTzIqzFbsGHoMkrXyIaab2KzKQrz806ourDl/Zu8MnhCj/v5MzI1+qe?=
 =?us-ascii?Q?e8kNS/XSbB1cS6FALxMniRmiCeNXJYyqxUzT9sUmIA/dZzWoPLro0TgAKyav?=
 =?us-ascii?Q?fa6EGZT+WYufuNhpfUpYjy6AaeWt7ZwTeZVRDHQerOk0ZisVqZM55NqMXICb?=
 =?us-ascii?Q?Zvx0Qjl4nezwiJkhOBRTLpQhWoIl38tmPCvC4uxtwADSCiQJqSIF/s6yyL66?=
 =?us-ascii?Q?fpzpAX4CfkcspWYIsEAXb1FAaE9b4fgoV1wz2yRZlbqbtVuzqSzk4+Pt1pcx?=
 =?us-ascii?Q?y3Iz9SwON/MtBukhPk0UJC3WCySMgLpJVTRommY3CNfstTf8kBHvyaO7ZFtJ?=
 =?us-ascii?Q?9p8fHPe0XWPb4mJi+fQy2Por2YOUDuSa/mBIuaID1bjICug2pqxeI+Xg1txG?=
 =?us-ascii?Q?3h4X2LaoRJQOKUkTTohSfsxaDwGWWqTvTv8oD3CKqahrQEONyds1RV22na0R?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97757169-b2f9-4b1a-fe22-08dc306a8dc2
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:15:38.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUUJRdHdaCZNHLPErlm1I968keUUgqneRz2Y1yB8ePXS0bvjyiBu+W+lEx3DazhkleFhTi7B1nsH3ZnePsmdBqKezQRLGQzTbaiCJk9K1O0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

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

This patchset is base on v6.8-rc3

previous version:
v9:https://patchwork.kernel.org/project/linux-pci/cover/20231020104341.63157-1-minda.chen@starfivetech.com/
v10:https://patchwork.kernel.org/project/linux-pci/cover/20231031115430.113586-1-minda.chen@starfivetech.com/
v11:https://patchwork.kernel.org/project/linux-pci/cover/20231115114912.71448-1-minda.chen@starfivetech.com/
v12:https://patchwork.kernel.org/project/linux-pci/cover/20231206105839.25805-1-minda.chen@starfivetech.com/
v13:https://patchwork.kernel.org/project/linux-pci/cover/20231214072839.2367-1-minda.chen@starfivetech.com/
v14:https://patchwork.kernel.org/project/linux-pci/cover/20240129005854.3554-1-minda.chen@starfivetech.com/

change:
  v15: 
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


base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
-- 
2.17.1


