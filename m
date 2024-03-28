Return-Path: <linux-pci+bounces-5318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8199A88FAFC
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B638AB26DFA
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550B264CF2;
	Thu, 28 Mar 2024 09:19:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2114.outbound.protection.partner.outlook.cn [139.219.146.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0A56B77;
	Thu, 28 Mar 2024 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617541; cv=fail; b=SRx3mKKES3NvXog6wjBcj67AcUr6aJmWuIczMWV3u7beDfk/wv+lrzdTMar0+d5qrJt4WI2tbPnO1LHlFcdohkidY1PjpvLyE97Hg37DldrQSqmbBowsoFetsmQCMznG7EvXZMn23xvNlfG5TSHw7VeGBmMDYCtSxQYDkpbvlFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617541; c=relaxed/simple;
	bh=VFsrcZbLyoBvo/3iGfpesvcryOHX/DZDmEPwkiJRv3k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uE0uROvUL7s8WH/C0morCTeklEq8UvuKeCvRxTkV5u0vKKP7azpyM31CGfHDVJmagf9Y9+/PpUfITZB56gD5EGe7LrjcPIA1CAYlgFInHiZEtEKa7xZGTznvc9arbSiyxDgiPF2nzEcQUTpoSvrYHil62z9n799++yWREoBsfbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHWdXw/EX14yjTSDYybNOqJ0ksh7JwSueYa8cZvEQniTEPsclLhtUhNBl2z31pnqnWHXcsQn5sbLEiy9XrqyR1SpEl6pCq4VbSTV9vjz5kXK5WQoOGtnW4B6MMuAjYZSzdQyinWRMg3gCji8J+R2lC+ghS2OfTNV0XIioUmPKYb93GdliLfJlMXCk1YXJjoTPG06fMtAI9jd/uQdEr5OvwYqCbZKu+78N88tZdBIXauLalowwQK5RZwjF2Y3t6xBniTTr01wI8KKyqUomC40tPg7s1AgU7ZnF8sbNn5EyhhYrwZ8D8QCZcjEnBctqHNJ3SgJr1vpUByiQLI0/lclzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T8FHX0DwGXCxCXym/es8g1xTLkFdPwYZuF4DyTZlTk=;
 b=NH1GOOUfbDRKPHJhPyzNpd4IRvpBE++C2BaUJqhAZIt37+StdmazQRHpjh8dJbp2AM2RpbFsGaynzZG1XVm2U3jK9mjTr/vA0QodIiUakeMQqZpffwFw4gKnxS408WxQKPvXDrDDTO1UpHuYvdj9BeLnBgf7lA8bW/tuo2ynNWpdaL+G87ySMKjjMVKtuSEy3nnwYhdqOoLNv/GVg8FkHYWjWLYTBn5p9mOhPXp2fVtrkGAn2veYmXdJDHHDkoYFJQ3EZwdBCz0qyBFxv6GnKYvfXVIv+TNTqh0wHEgJWz5QDhx+wqo4RXtiutl6tDneQVq/zBdCVX4tZzSUuKhG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:44 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:44 +0000
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
Subject: [PATCH v16 00/22] Refactoring Microchip PCIe driver and add StarFive PCIe
Date: Thu, 28 Mar 2024 17:18:13 +0800
Message-Id: <20240328091835.14797-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-Office365-Filtering-Correlation-Id: de834a9e-1fd9-4e37-ceaa-08dc4f0810b5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ntAFqw3q7MlqfNu8vViuJnFCzDLE1+DYSQ974i0SujQClSoWyUaSA1oWJJoH+K9wkKDtzUac1j9Y8Tqk37LItc3novZgAbAekLj94CKJisqgeRpkKaL9CWZVXqH39gdc06Ov8HXdDBRuntgufgTi5EoBKiATToqPaLF2tkt/+aX5/sueK78yqWva49YR7npe8PiZuEFJkIu/RfW9J2fd/15dwEkDPylfJyGdk4rXqE7Hq1/wFsjDmfDBQ8S0RBRag/XjiVXannHPvVFChlgw8Qmj/sDqhNHMI5QSpvDoq0NLqz6SVEfKqQ4NDdzjw+zNapeMKx6w1pfjwFUeEmZwNKQd4K7UwH6uvoAqWY50aAR7q9kSAOxLAghfOEnLAdYgDrrfgx7NxgoClDVw0aoI3zCe865TVspaUBKQOYKNQneHV1DSr1w6y4Jrsfx68PtQQaO362gBojM8fmw+Q1KF2+1kllaYkP17JulRqowaS5UDGM7z62q+5mTL19OQZ79mjRrZ+57595TNrDU0tIEv+FBZY6+yR/5kXIPixRWbU4HZuGCHB1BM2Z3lrQNbP+BSvLW/+WDLsmVloOy0ru3qgyWvnMzl0aRX0R+yT7ZF6pD0lbDpV+dodF9/vAC+GJGa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5xoef7pKPRIBXP5Lzxi5o5BM1nCXrPWdYyBAMlL6K8YEp/TL1X57btnx/km0?=
 =?us-ascii?Q?uvCbpLxDDu+lQMQMevQ1yyBL4o+tT08xfuPS4JOc/yEsIL5I8V9CbGfbF2CE?=
 =?us-ascii?Q?4FtEPF6nWkhL9FdSQ2uT4nwKIdGA4Yu1fwG3DmqwSuvGMVtpN7Ih23Ty+mjV?=
 =?us-ascii?Q?IFSqp299HCbv0HbkZA5+EAxkpKwDqVacmkcQbg5qshKMhcCxqDtseewOmTab?=
 =?us-ascii?Q?bknwvxAxV8sPyMjVHfDW9CLfnrPf3QLIXtUr+UXHze+SdbzuFTq5Cakc1cUp?=
 =?us-ascii?Q?phCjFTCiSHlGp22u0JK5XOAc3CvvSAZfsQJRolGdeu3MgMY1sYyLAxe+9qJp?=
 =?us-ascii?Q?WTdrxs4AwDkKDS3ixWsiMupE78yA2H/zGz+O7jvscUhMpPGuOegZUfPFEsxn?=
 =?us-ascii?Q?uTU4+qjTr9s4BJ5ei4r/JEqXWS29wfEllBA1ZCsqMN9NVfKXbJAis8IOvrb8?=
 =?us-ascii?Q?ZhDrQHNDToa27Q+a6kQIhY736DilDur8lMxk2IsLarE2mxe5jiMuHZ7hVnPV?=
 =?us-ascii?Q?o6Wrn/e+V52sZHRx50GV+OxLvVGuuw6fnH4OvjexUZEGILA3QCOlwSnTzXsQ?=
 =?us-ascii?Q?9vVqFtmfdKuIoP1lIyHJYDuJZBTXhV2GPvJjtdLUJpweSGwUc9AwWQseVVfK?=
 =?us-ascii?Q?9SxiZqjH0ii8Ynys6s/JAcppjFlTeEUk5ZIwPsI2s7RyoMuOqQxnTiVGCUbo?=
 =?us-ascii?Q?MZv5Y08xzIXif2B2PoTfinHxYuNyXDIYa7igSspW1hMbRVut3xUlFtmvfwJ5?=
 =?us-ascii?Q?HteiU/52+mHH8zw1y4xDjZK7QOVhWurpQeU+fGn65s9iYengR1t0lpd6OklO?=
 =?us-ascii?Q?lqIP75Izi7I4+7qdvPQBsIjK1y6D35I9UIvind6i/c1Q8hYYOR0mxe/D5hmy?=
 =?us-ascii?Q?MOXSwHlT3Ym3EA/WD/ABV0lltZPjx9BDl9bMQ1SA1ChOPN5bOc+VIxYYufJE?=
 =?us-ascii?Q?ni3CYqtTG39Yj/lwHeKvmWgr9HV/8g/iQODjby96YX4lACMGXXVIwBfxMZXy?=
 =?us-ascii?Q?Juxmqf0ghFOzFUnZs5eIo1Oil5W/cvt9hCbIS86FhKXXLmXNHi6qLlnLgJne?=
 =?us-ascii?Q?UxkCzfw6uw4pEsaeNBnTz8ypegdFMefPAUwV4RGEfeP6+1b8LEwXAmfzWc5L?=
 =?us-ascii?Q?0C8CixSuhGFZ8QJuTwaemGiux4PtDCNyB4OYix15DfxtBLrCyFkkdKWSajtQ?=
 =?us-ascii?Q?7pNpERw5vyu3m1u6sLsfBUJm6+wNblyUvj4PHzXrBJPh4G6h6I1gEbVQMP+Z?=
 =?us-ascii?Q?Q/TGPkUcK9eoYY19b9tpLN6C6c3+h+ISUo3fqHog3XAQflSymemqYgh4gNsT?=
 =?us-ascii?Q?G5w8aqJhxPmHnVyrfqmJOtSoVkQyF+k3LfU0k49Wv/fn1fYqQADQV8ZTcqJJ?=
 =?us-ascii?Q?mutyGw1+LSA9o9P+mo+uiTQVn1MOrPn4v+PYO15Hwb/y6YecWmwYuIDG8hJr?=
 =?us-ascii?Q?wtsTskAX+tistOsdmYBY9VsdyjhlQB2CVclKbYBtmTIwDWyhfI0vhrVucnce?=
 =?us-ascii?Q?s4xEX8cZnhlPGAqYwOON7W53t4siUkcZVTTNctYb1r9wvlcJj/w6038ZhA0A?=
 =?us-ascii?Q?T7BiSHa7kUkQNI8D/OvIDvr4mSpFvar6mUzw/G9DJYF88ilcQ959d/EamHzp?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de834a9e-1fd9-4e37-ceaa-08dc4f0810b5
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:43.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQxdJkz4atBvwUcB9mayHV0Z9kfb4qoD9L0qmdemkVrMii+fUtzZjaH78NLxOih36SGmmaf0uxLBF4DtW6O8oNDhP/rX7iuWC22OZxxf/vM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

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
patch21 is add StarFive JH7110 Soc PCIe driver code.
qurik).
patch22 is Starfive dts config

This patchset is base on v6.9-rc1

previous version:
v10:https://patchwork.kernel.org/project/linux-pci/cover/20231031115430.113586-1-minda.chen@starfivetech.com/
v11:https://patchwork.kernel.org/project/linux-pci/cover/20231115114912.71448-1-minda.chen@starfivetech.com/
v12:https://patchwork.kernel.org/project/linux-pci/cover/20231206105839.25805-1-minda.chen@starfivetech.com/
v13:https://patchwork.kernel.org/project/linux-pci/cover/20231214072839.2367-1-minda.chen@starfivetech.com/
v14:https://patchwork.kernel.org/project/linux-pci/cover/20240129005854.3554-1-minda.chen@starfivetech.com/
v15:https://patchwork.kernel.org/project/linux-pci/cover/20240227103522.80915-1-minda.chen@starfivetech.com/

change:
  v16: 
    modify the patch 3 - 9 commit message. (follow Lorrenzo's review comments)
    Update the MAINTAINER in correct patch.
    Add more comments in Starfive pcie driver to explain the pcie setting.(patch 21)
    Remove v15 patch 22. We will get the delay time errdata or find a correct fix method.

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
 drivers/pci/controller/plda/pcie-plda.h       | 273 ++++++++
 drivers/pci/controller/plda/pcie-starfive.c   | 488 +++++++++++++
 drivers/pci/pci.h                             |  16 +
 15 files changed, 1891 insertions(+), 616 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
 create mode 100644 drivers/pci/controller/plda/Kconfig
 create mode 100644 drivers/pci/controller/plda/Makefile
 rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (54%)
 create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h
 create mode 100644 drivers/pci/controller/plda/pcie-starfive.c


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.17.1


