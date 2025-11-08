Return-Path: <linux-pci+bounces-40625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D5CC42DAB
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 15:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8D964E38DB
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15462217F55;
	Sat,  8 Nov 2025 14:03:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022098.outbound.protection.outlook.com [40.107.75.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E02619005E;
	Sat,  8 Nov 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610595; cv=fail; b=X3cm3l46gFiYvKbT4UuQ+mqaMSFFLaem+bJixAha7xv+0v5sAJKJVesS78oGy30EtFhRJGLNZtyXga75Z4AXS/CyVASajkrmW7O9Bj19ND6nV/ziyxKxmW9hpmHWvr9S45sXSMUCdJaQe+uuXjaMlfiUILNGPW9P+bZM+zAsrds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610595; c=relaxed/simple;
	bh=8FcjBcgqZ+cKgZ6da9rByXGQeS1mKTaAnahDU17GFjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QkfMsbEBIdTdMrX7TVniEUVZQw6cjDk/b0Nx/od5cxBI1cqvEr6j7/84SKNd+EXOj8vO1tDxM41G34UYVLC6xaNx6LIiMwtEME26+NUq1cUkuBtCYa2MgajZWG7OlJaaE12GS4xYXgFbZiH0/JJmMhE7WpFn4mpAP8lBe20WTIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyDP9e9dbPY6/OY4PM7yimY7xsS/9c1loLLtwK45OZU1jTfncL1m3XZb8QQL8MKVDVESBdNbZP8Ry2d75MnRbZ3Nk+fnjFKpMZvCQOCA+T0naAX0XAaxp5DQFHz0DeUSKuABMYxgbWMDyeCVP/x60rvRxNWbXcnA2Ys2KLskfGBBtaam/s5cBBKCJlmFij6O+rLxCWvjegKRMBwD5pJsl1M3it8RQqZZRQ5Al+ILbzDiriSPjWTpGpymHuxx01bv1+fsmTmr8jfsoHnFnRxvfY1xmxdivMI/bIUuUgmSfX8I1Z17/g4w/eTu2Z9U6xW+kzLErkp907pqZlDmTb9lkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQ5XL67g5v4J21IfE2OiuzEDx83Fb+J5bvQBZ1d/pYE=;
 b=hudVsWIaqX0XyoNsp/hNGuP+DRAEZmXUtC4K4htjY3HbFd/Sz/4ShP0RWMiLKfZ6lr6DJzte78KImQapiU7TCxwq4APnS1yv3SE2rpXtli7Yt/raTSnX7vwgzB+wKcjQ67i+IcIRPXSuQ3z60UUr0KwloSyLJJRIsU8A0i4r1d4cjfgKRpvQK+nfYRdhDws65Br7wABP89oyvFfA6DJpg/t1mk+UeDw2s9oTlozz4Oc2EjexzBr7fHtaSxJVSOV3/lrJfeVf30aJTIIEfnXh1haTchWBHMC+Y2EJ4/umOXXVGfMpdgJuLRQQn5N7S6KWNh+wBEpA8T2u7HWQz5j3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PSBPR02CA0004.apcprd02.prod.outlook.com (2603:1096:301::14) by
 KUZPR06MB8058.apcprd06.prod.outlook.com (2603:1096:d10:48::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.8; Sat, 8 Nov 2025 14:03:09 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:301:0:cafe::d7) by PSBPR02CA0004.outlook.office365.com
 (2603:1096:301::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Sat,
 8 Nov 2025 14:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 14:03:07 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id BAEB941C014B;
	Sat,  8 Nov 2025 22:03:05 +0800 (CST)
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
Subject: [PATCH v11 00/10] Enhance the PCIe controller driver for next generation controllers
Date: Sat,  8 Nov 2025 22:02:55 +0800
Message-ID: <20251108140305.1120117-1-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|KUZPR06MB8058:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ff7c8191-80f2-4101-06bb-08de1ecf8b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WX+Zclak9sSvcO2ocknozMgAZPk/euz6ZiH9Wlpz974w/giD3Jc0UUwC6u/6?=
 =?us-ascii?Q?hYQO7RbjfNbS1KyfbhmXy25ys1P9lk8qBSZxiZDxN5pRAuyxDjbZ72kQc4Ps?=
 =?us-ascii?Q?lhPy7YU77lQEsz9U90kX3B9bDEFQUMjDL+WawDGghCGkHUXyREEmHZ/t0W21?=
 =?us-ascii?Q?BUO/haM7ouRzRZT9lQCiXbNFxODByFk/ZFEuUhFt6RlekL0V0G3ihPl9U1qB?=
 =?us-ascii?Q?+3BxjSQsfXCF5cIApdS9dXN+dwd+uyAMNxx5zIW7awEscB1b4vBSYyeWgTVq?=
 =?us-ascii?Q?nNcQJkr9uO0oYKcYq3mDsfxslJi9GrI4N3lT5C1URq8v+vyCBvj+1iJsDUVF?=
 =?us-ascii?Q?wpiO1YOoH6WOmW0gtz8P+TqGQQwsYAXCUC8C39gXVkr6i6FyaIE2b9ozLmM/?=
 =?us-ascii?Q?Z27kEn0sKqOTdJIlnzCdibmFC+/Iz2ZciqVdOGCx0JL4ZlIdXAzDVYGR2n2q?=
 =?us-ascii?Q?OuXr5cDuuJ6O8s6rr5ZVuNhu6RgJh09sB5fOq+jGjVVmiWFNpVUGBgRlSoT5?=
 =?us-ascii?Q?EG+4+VeyhZSmWwEUWhyhf7L05FFPsNNh01P/4ogiatTnnNC5P0mOMdRQkU6E?=
 =?us-ascii?Q?CYIDjMffkfAOhsaiiPjeYs019oYKcfLH08X1Mxj9HQe26IihdNGd2A115Yb9?=
 =?us-ascii?Q?cl3oFr8unpZ3WpglA4M3hruI2ChICD5Om26URad5JI+IoJCHk5ucv5ucmMu7?=
 =?us-ascii?Q?faeOKFulw+6ci7BH7w3PBgrK5R7TOfijnWMA/fxSO/xy58h0gedPPY6dZ33p?=
 =?us-ascii?Q?utKxGsJDdznHsj0yIbHt2+dl7/5YmmyPiG7tvXRceM5wCNpmE7RVlB3E81iD?=
 =?us-ascii?Q?5sZOBN58dOWJUI07T1gYlmqZhinBBgVWBZxStPnWe2ybq2dCSsjIvYL60EIM?=
 =?us-ascii?Q?VQNzs/lXL97ZSpNddS+n1YZP5gL2wY3zBz8rrhI+09zyTY/896LFg3UEFEGd?=
 =?us-ascii?Q?cwt4hF4snioakwl/TvF7syehZgV7ItMNUBbfmVNrfI1T4AoQMZ/9CO1aKZLB?=
 =?us-ascii?Q?d/xnSEjJSocjJIg3an8XirU5sWqhxP4yTzHY1/ffF2NGGIycRCxcZ/6mOOR+?=
 =?us-ascii?Q?O8pV/XEnnjhvPpww25e3Pt+O8qlf7IRK+AC7WBS7l909H70xRqg69Baun6NT?=
 =?us-ascii?Q?jRxfalSDLznXdis/MdGM2wh524yBUjJQD+0eUfQkpDDy5DCc3H01cp3q3Kug?=
 =?us-ascii?Q?D8NiM1akWOqPUbWUKTi2XDg7aUWSuNCztxs36AYXXb6boFeaXldbG+9tvqqU?=
 =?us-ascii?Q?CZyUE4ablP8aCTDGG3yMj8lWf8mCYo+OU5km2nxAQXzN0XrV1JBwjJIr01kV?=
 =?us-ascii?Q?rP0mfxiXxDvDABJZ7oWRAZdPyQ5HVcqhb+wTqU3qAv+beiFqPcZslEb7cliz?=
 =?us-ascii?Q?AMkne3noZab5qD9FXGFefMFnmU7ofmdbdkiw0IRe8rmXN3pX79UFDcd/4Q99?=
 =?us-ascii?Q?+hi3+xWeiPlzovt9Qm2Q6m4stf2RFDBcZaeji2yvTApv+ooV73oHGv+du7mU?=
 =?us-ascii?Q?VszR4T3/KaTD+0yhDcVUrccK7tERF+jh6ylNOm07myrYsG8altstZ5VXG9r3?=
 =?us-ascii?Q?R7sSD/8d9KEcaFJCSBI=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 14:03:07.1324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7c8191-80f2-4101-06bb-08de1ecf8b30
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8058

From: Hans Zhang <hans.zhang@cixtech.com>

---
Dear Maintainers,

This series is Cadence's HPA PCIe IP and the Root Port driver of our
CIX sky1. Please help review. Thank you very much.


Hi Mani,

Thank you very much for your time in reviewing this series of patches.
Manikandan has revised it. I'm not sure if it meets your requirements.
Please take some time to review it. Thank you again.

Best regards,
Hans
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
Changes for v11:
https://patchwork.kernel.org/project/linux-pci/patch/20251020042857.706786-1-hans.zhang@cixtech.com/

  - Fixes for testbot comments
  - Addressed the comments from Manivannan on patchset 10
	- Removed unused function cdns_pcie_hpa_reset_outbound_region.
	- Used function pointer callbacks to functions to reuse them
	- removed some not required code as per the comments
  - Modify the two return values of pci-sky1.c and add MODULE_DEVICE_TABLE(). (Mani)

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

 .../bindings/pci/cix,sky1-pcie-host.yaml      |  83 ++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  20 +
 arch/arm64/boot/dts/cix/sky1.dtsi             | 126 ++++++
 drivers/pci/controller/cadence/Kconfig        |  21 +-
 drivers/pci/controller/cadence/Makefile       |  11 +-
 drivers/pci/controller/cadence/pci-sky1.c     | 235 ++++++++++
 .../cadence/pcie-cadence-host-common.c        | 289 ++++++++++++
 .../cadence/pcie-cadence-host-common.h        |  46 ++
 .../cadence/pcie-cadence-host-hpa.c           | 368 ++++++++++++++++
 .../controller/cadence/pcie-cadence-host.c    | 278 +-----------
 .../cadence/pcie-cadence-hpa-regs.h           | 193 +++++++++
 .../pci/controller/cadence/pcie-cadence-hpa.c | 167 +++++++
 .../cadence/pcie-cadence-lga-regs.h           | 230 ++++++++++
 .../controller/cadence/pcie-cadence-plat.c    |   9 +-
 drivers/pci/controller/cadence/pcie-cadence.c |  12 +
 drivers/pci/controller/cadence/pcie-cadence.h | 410 ++++++++----------
 include/linux/pci_ids.h                       |   3 +
 18 files changed, 1992 insertions(+), 516 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
 create mode 100644 drivers/pci/controller/cadence/pci-sky1.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-lga-regs.h


base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
-- 
2.49.0


