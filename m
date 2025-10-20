Return-Path: <linux-pci+bounces-38699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FD7BEF45D
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 06:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C58188D6FC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 04:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F062BF01D;
	Mon, 20 Oct 2025 04:29:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023143.outbound.protection.outlook.com [40.107.44.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380354763;
	Mon, 20 Oct 2025 04:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934546; cv=fail; b=FEPqYeDFTYKSrVQez2PgMMjdvqZ3Z7Cd+ih6VEXk+Q3r83Jbx+d4tWc1XWvTIp6iU6x9JnAIVHBacQOoHfaNppLPydGwcJHAqoS+ubGQ08lCpVIt9n5qGdLOc+q4bs0wXEDblpkHf6oP1NVBO6CenIv/eADPDBdwAfXRwqjZzZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934546; c=relaxed/simple;
	bh=qZoAYcJRoNBSGGl1BN0f5jQpXvqEOdXlxEcxDxAZ2Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lENkaxcnsDSR2J3Hd6T+kbboT3iIsUhyBgIxba84UTqiOfrYzsu5H5/IQprWFIYXwUdL8xUSh7M4OUj7DSGzc1frJjVb+cNKGl79++sKar/t7NO3y4Yv26NHQZQt0XxIVD+hzLqzYJN3KzfFedtTib9m+gnnd2Tn56+KA4uug5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCGhaILL2EXgVc2VgLaP/zQe0Mk2oXqzLnFvEGoIv28ywHIbJUyENLOrjgttn1STwcQ2U4X/UQBWJDXsFPbPJRvZ2Z6Fc/aBo5JNyT81atnMH3EqHc46ZXUBwzIeg6ik3HOS3XF6aFqEX1UuwLeGGOSo542WMiv3YdF8ooIT668ODlZsaOXardGkyMJ4dkU0viuI3iuljVnp9bj7qVyKHVqgtzwDqquC/q8EyKPDy99ws5iFTl8z3xVcTjLKLk9LvZS8Lf+lDB14Y8+H/ZFyIGQvwgjSiI02nasREIkvdYRXudrK0TQRJCZ0b5eE6GVW+cliAjzsozqK0Yf85Fw6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8ez4Zs7k9n9lS33UOnv1Ooc48NK/I4KeixCflfL0L0=;
 b=AA7P8+4MN21ZtRJ97DvBdl38qnmXn2aWh09BgMRKjWyeO6vEp6wJXBaUMi+dyU4leGYj/C+237c2hPt6mhmkt1EhYjHuQSr5WX5gWyGHX+ldeommkX18SRwvuyJOA64X5TAkRjLdvcZwEVAOvMA0ixFLB3VroI3oCZJxi/w6QyzMXOg1w8raWZud2+apFvOc8HBx7yBo2EPO7Z0CWSvATvNJz3ik0FD+u6POBpXK1nJgTEwG4I0AFE0oaQB7BD09WfOrbDzjtyDplpSOhkldnCDgPNwydlAWmrBkyfRCprPCJLAEzuzNpBGeQWLBi2njJx/XK9fYMQTe2T5TQI5vzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0312.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:38b::19)
 by SEZPR06MB5168.apcprd06.prod.outlook.com (2603:1096:101:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 04:28:59 +0000
Received: from TY2PEPF0000AB85.apcprd03.prod.outlook.com
 (2603:1096:400:38b:cafe::f7) by TYCP286CA0312.outlook.office365.com
 (2603:1096:400:38b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 04:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB85.mail.protection.outlook.com (10.167.253.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 04:28:58 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B8D2441C0143;
	Mon, 20 Oct 2025 12:28:57 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	helgaas@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v10 00/10] Enhance the PCIe controller driver for next generation controllers
Date: Mon, 20 Oct 2025 12:28:47 +0800
Message-ID: <20251020042857.706786-1-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB85:EE_|SEZPR06MB5168:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9c5f4b31-b211-439e-9966-08de0f913075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qhs+mPMY7RrEyxbWKxz/5cTYQitJXOznEHNyS/aM3grTFS0s2vQbkoKYoITg?=
 =?us-ascii?Q?c2p8h6CUCRfhQQcOQXe+ZfOtQ0FuliFKCbl1Mva1X5AfMAyLzxM9Hm/or8G3?=
 =?us-ascii?Q?habdgm/zd6nr4hJKv8zc/b23UbSvO+h8jQ9wuL/G47gxObaXD+PQu7ZQ/ZWK?=
 =?us-ascii?Q?oQMYBcP/uTXJu9dT/OBslqV6sKxuwLOq4ct6PslWnAmDhUrVvpDHR/b5Qpi3?=
 =?us-ascii?Q?SVPwADHpzv5uJ95F0HPXcnAi8FMFXKSalfY2rk+jTV0DsoQmUOxKRNvvLY5r?=
 =?us-ascii?Q?RpgEHCAPZRiS12VP206bbGVdGlyBfrGjdqAtKG1URbV82akoDtVKX+kDsysv?=
 =?us-ascii?Q?ei1jq/PkODwT/3uf2Tg/kZe4X9FMHc/YEdr68AEIIWukQBlio6d1HMvWt1ej?=
 =?us-ascii?Q?ficaX2YD6ZeuIBc2xWx3stdUM8UHiLINN0eQk6ZOQuszm4dQMkBzdq3Mnr81?=
 =?us-ascii?Q?RZZQY1Ta36zPrIFYdNBSOmebc9MI2NAlhjuoP118eAyVYdVVtu/Iu2o76AZT?=
 =?us-ascii?Q?p+hhfp5+f66YxZbIc/8KYtgjhEdrco2NOfGwM6eICAmGkxVUrxvWYP5wy4RV?=
 =?us-ascii?Q?rwSzaMSrswgmHsudr+uG22+adNyxfLF+7KUhjbXeRfcETr0PwowMKV4OxTGI?=
 =?us-ascii?Q?nD9iySPs/NkeO8uuCa2Bq2kX1nVPaRyEH/idrB47kWu2cXJekShevkVw+TVU?=
 =?us-ascii?Q?HE/pm/flubdaXMJeC+zb/qpxcRWAn4Sh12+PEXnAHEV7ezLSjgviLQZEGUJb?=
 =?us-ascii?Q?uhsj30XUMwacsWtfmdMOrbqBVVWurkJqXv0CcWsxqOOgdnlogKn9kxzUF3r4?=
 =?us-ascii?Q?xmyhKe/cIoaOv3mXSeDGnoFNJSvvp3Xb4CNX2fr5fhbYxyRNgSrO5umAYSdf?=
 =?us-ascii?Q?mjM/C/s6bl5FoEjHqZHnCiTkJLJ3VrCkQeSubJSzNxtXUwXPnkBP0inqE73+?=
 =?us-ascii?Q?GDh19AC8uxBquvqUoPb7GxHVxSDQqhO9bTUCqb30xOmhx2pllRgk77adMx/p?=
 =?us-ascii?Q?yKJWalx78u9W9wP6LTFZSpnx1kRVg9zguMq0Rlo5vg4wuhrBav8Wh8sal3Hm?=
 =?us-ascii?Q?aO7Y+/2gujdludd1WbxN0Iu6nQrIZj5ze67kSDFqTGIvAnD3gvW1yQ4PxXtT?=
 =?us-ascii?Q?HFmC/Eg5v7gKU1hyVfmYkRMuKHH2eDQ3h6Brbl50QP1MhRCntxJP8+5nVfuI?=
 =?us-ascii?Q?yVo06wNAaE/DTPnG+OYs6zww8BhWkay2GYDxbDf0Wbl0zEhvCdDKgcxBlyIE?=
 =?us-ascii?Q?RRh0+V5jwKS5RkX0R39Br7lxNgw8oYFP+X7z29i1TU72goOvwwk/8cRRBkO3?=
 =?us-ascii?Q?auKwlIVTdjtHGkJD/htqSJw3UUQPnUIJugLvFUHkisyPFMWj2htkm01LDNwp?=
 =?us-ascii?Q?/441GfZKSeFfcYFmKZItOUP8MibhSm9Iihls2snaaFnT9WkoR5eDhF7lNDKi?=
 =?us-ascii?Q?xGtnIaFflFD3ENMHgemGDuJsTjx4xZNTWR5mJCXWoDZVAaYQieTh6pAdhV2C?=
 =?us-ascii?Q?u2CvwbBUYS/uecmo3w3VKUYdkqbz9OAQe/SxPnfboI76peYcQJAQtEOss/iC?=
 =?us-ascii?Q?bljOKgV25lODUUjshl/XSIdCzfxx3a4ZZm7pCFTP?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 04:28:58.8518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5f4b31-b211-439e-9966-08de0f913075
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB85.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5168

From: Hans Zhang <hans.zhang@cixtech.com>

---
Dear Maintainers,

This series is Cadence's HPA PCIe IP and the Root Port driver of our
CIX sky1. Please help review. Thank you very much.
---

Enhances the exiting Cadence PCIe controller drivers to support
HPA (High Performance Architecture) Cadence PCIe controllers.

The patch set enhances the Cadence PCIe driver for HPA support.
The header files are separated out for legacy and high performance
register maps, register address and bit definitions. The driver
read register and write register functions for HPA take the
updated offset stored from the platform driver to access the registers.
As part of refactoring of the code, few new files are added to the
driver by splitting the existing files.
This helps SoC vendor who change the address map within PCIe controller
in their designs. Setting the menuconfig appropriately will allow
selection between RP and/or EP PCIe controller support. The support
will include Legacy and HPA for the selected configuration.

The TI SoC continues to be supported with the changes incorporated.

The changes address the review comments in the previous patches where
the need to move away from "ops" pointers used in current implementation
and separate out the Legacy and HPA driver implementation was stressed.

The scripts/checkpatch.pl has been run on the patches with and without
--strict. With the --strict option, 4 checks are generated on 3 patch,
which can be ignored. There are no code fixes required for these checks.
All other checks generated by ./scripts/checkpatch.pl --strict can be 
ignored.
---
Changes for v10:
https://patchwork.kernel.org/project/linux-pci/cover/20250901092052.4051018-1-hans.zhang@cixtech.com/

  - Rebase to v6.18-rc2.
  - Comments from Manivannan which have been addressed.
  - Merging of header file split patches with the patches that 
    use the changes.
  - Addressing some of the code comments, initialization of variables,
    making some functions static and removing unused functions.
  - Delete the cdns_pcie_hpa_create_region_for_ecam function, which
    depends on the initialization of ECAM by bios. After this series
    is accepted, I will submit it later.

Changes for v9
https://patchwork.kernel.org/project/linux-pci/cover/20250819115239.4170604-1-hans.zhang@cixtech.com/

	- Fixes the issue of kernel test robot where one variable overflow was flagged
https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all/202508261955.U9IomdXb-lkp@intel.com/__;!!EHscmS1ygiU1lA!EZnnh6v5bjIDVqDhCnuprUvH9PTNCSANIaNa6wx7Tp3NgGMqsrTwOKz9z8z5fWHkQH3Q8l_S$
	- Minor changes that includes adding a flag for RC, removing vendor id and device id from DTS.
    - Fix comments
	- Remove EP platform code by removing patch 0007 in v8 series
    - Fix comments style for new files
    - Remove #define from within functions to header file
  - Modification of the review opinion on CIX SKY1 RC driver (Mani).

Changes for v8
  - Fixed the error issue of DT binding. (Rob and Krzysztof)
  - Optimization of CIX SKY1 Root Port driver. (Bjorn and Krzysztof)
  - Review comments fixed. (Bjorn and Krzysztof)
  - All comments related fixes like single line comments, spaces
        between HPA or LGA, periods in single line, changes proposed
        in the description, etc are fixed. (Bjorn and Krzysztof)
  - Patches have been split to separate out code moves from
    update and fixes.
  - "cdns_...send_irq.." renamed to "cdns_..raise_irq.."

  The test log on the Orion O6 board is as follows:
  root@cix-localhost:~# lspci
  0000:c0:00.0 PCI bridge: Device 1f6c:0001
  0000:c1:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
  0001:90:00.0 PCI bridge: Device 1f6c:0001
  0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
  0002:60:00.0 PCI bridge: Device 1f6c:0001
  0002:61:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
  0003:00:00.0 PCI bridge: Device 1f6c:0001
  0003:01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
  0004:30:00.0 PCI bridge: Device 1f6c:0001
  0004:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
  root@cix-localhost:~#
  root@cix-localhost:~# uname -a
  Linux cix-localhost 6.17.0-rc2-00043-gb2782ead460c #185 SMP PREEMPT Tue Aug 19 19:35:34 CST 2025 aarch64 GNU/Linux
  root@cix-localhost:~# cat /etc/issue
  Debian GNU/Linux 12 \n \l

Changes for v7
https://patchwork.kernel.org/project/linux-pci/cover/20250813042331.1258272-1-hans.zhang@cixtech.com/

  - Rebase to v6.17-rc1.
  - Fixed the error issue of cix,sky1-pcie-host.yaml make dt_binding_check.
  - CIX SKY1 Root Port driver compilation error issue: Add header
    file, Kconfig select PCI_ECAM.

Changes for v6
https://patchwork.kernel.org/project/linux-pci/cover/20250808072929.4090694-1-hans.zhang@cixtech.com/

  - The IP level DTS changes for HPA have been removed as the SoC
    level DTS is added
  - Virtual FPGA platform is also removed as the CiX SoC support is
    added
  - Fix the issue of dt bindings
  - Modify the order of PCIe node attributes in sky1-orion-o6.dts
    and delete unnecessary attributes.
  - Continue to simplify the RC driver.
  - The patch of the Cix Sky1 platform has been accepted and merged into the linux master branch.
  https://patchwork.kernel.org/project/linux-arm-kernel/cover/20250721144500.302202-1-peter.chen@cixtech.com/

Changes for v5
https://patchwork.kernel.org/project/linux-pci/cover/20250630041601.399921-1-hans.zhang@cixtech.com/

  - Header and code files separated for library functions(common
    functions used by both architectures) and Legacy and HPA.
  - Few new files added as part of refactoring
  - No checks for "is_hpa" as the functions have been separated
    out
  - Review comments from previous patches have been addressed
  - Add region 0 for ECAM and region 1 for message.
  - Add CIX sky1 PCIe drivers. Submissions based on the following v9 patches:
  https://patchwork.kernel.org/project/linux-arm-kernel/cover/20250609031627.1605851-1-peter.chen@cixtech.com/

  Cix Sky1 base dts review link to show its review status:
  https://lore.kernel.org/all/20250609031627.1605851-9-peter.chen@cixtech.com/

  The test log on the Orion O6 board is as follows:
  root@cix-localhost:~# lspci
  0000:c0:00.0 PCI bridge: Device 1f6c:0001
  0000:c1:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
  0001:90:00.0 PCI bridge: Device 1f6c:0001
  0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
  0002:60:00.0 PCI bridge: Device 1f6c:0001
  0002:61:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
  0003:00:00.0 PCI bridge: Device 1f6c:0001
  0003:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
  0004:30:00.0 PCI bridge: Device 1f6c:0001
  0004:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
  root@cix-localhost:~# uname -a
  Linux cix-localhost 6.16.0-rc1-00023-gbaa962a95a28 #138 SMP PREEMPT Fri Jun 27 16:43:41 CST 2025 aarch64 GNU/Linux
  root@cix-localhost:~# cat /etc/issue
  Debian GNU/Linux 12 \n \l
 
Changes for v4
https://patchwork.kernel.org/project/linux-pci/cover/20250424010445.2260090-1-hans.zhang@cixtech.com/

  - Add header file bitfield.h to pcie-cadence.h
  - Addressed the following review comments
          Merged the TI patch as it
          Removed initialization of struct variables to '0'

Changes for v3
https://patchwork.kernel.org/project/linux-pci/patch/20250411103656.2740517-1-hans.zhang@cixtech.com/

  - Patch version v3 added to the subject
  - Use HPA tag for architecture descriptions
  - Remove bug related changes to be submitted later as a separate
    patch
  - Two patches merged from the last series to ensure readability to
    address the review comments
  - Fix several description related issues, coding style issues and
    some misleading comments
  - Remove cpu_addr_fixup() functions
---

Hans Zhang (6):
  dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex bindings
  PCI: Add Cix Technology Vendor and Device ID
  PCI: sky1: Add PCIe host support for CIX Sky1
  MAINTAINERS: add entry for CIX Sky1 PCIe driver
  arm64: dts: cix: Add PCIe Root Complex on sky1
  arm64: dts: cix: Enable PCIe on the Orion O6 board

Manikandan K Pillai (4):
  PCI: cadence: Add module support for platform controller driver
  PCI: cadence: Split PCIe controller header file
  PCI: cadence: Move PCIe RP common functions to a separate file
  PCI: cadence: Add support for High Perf Architecture (HPA) controller

 .../bindings/pci/cix,sky1-pcie-host.yaml      |  83 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  20 +
 arch/arm64/boot/dts/cix/sky1.dtsi             | 126 +++++
 drivers/pci/controller/cadence/Kconfig        |  21 +-
 drivers/pci/controller/cadence/Makefile       |  11 +-
 drivers/pci/controller/cadence/pci-sky1.c     | 233 ++++++++
 .../cadence/pcie-cadence-host-common.c        | 182 +++++++
 .../cadence/pcie-cadence-host-common.h        |  26 +
 .../cadence/pcie-cadence-host-hpa.c           | 499 ++++++++++++++++++
 .../controller/cadence/pcie-cadence-host.c    | 156 +-----
 .../cadence/pcie-cadence-hpa-regs.h           | 193 +++++++
 .../pci/controller/cadence/pcie-cadence-hpa.c | 186 +++++++
 .../cadence/pcie-cadence-lga-regs.h           | 230 ++++++++
 .../controller/cadence/pcie-cadence-plat.c    |   9 +-
 drivers/pci/controller/cadence/pcie-cadence.c |  12 +
 drivers/pci/controller/cadence/pcie-cadence.h | 410 ++++++--------
 include/linux/pci_ids.h                       |   3 +
 18 files changed, 2006 insertions(+), 401 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
 create mode 100644 drivers/pci/controller/cadence/pci-sky1.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-lga-regs.h


base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.49.0


