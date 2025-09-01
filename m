Return-Path: <linux-pci+bounces-35256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC8BB3DE51
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED9A189C781
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71AD31B11A;
	Mon,  1 Sep 2025 09:21:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023079.outbound.protection.outlook.com [52.101.127.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D030E831;
	Mon,  1 Sep 2025 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718478; cv=fail; b=hLJvrLqcxdtrCChpkIAA4q6WLPANMe8yth0xXeuMeRy9zhv/T/LngBGtRvoHY2JIQLedcI8HUBEDPlscE6hY9NYwU9j8tHKMQmpqebsFKNL+SggoiDh0FxfbAGqO2IvienXg6BIk9jNqJab3RuO07mRBcCErEHEDRx9mbcU9OXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718478; c=relaxed/simple;
	bh=WUj9bCqrgWCGMeQFOA35PWdaVm+lZiEV4JPHumTHI5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XoBwpAezAyAMgMzVCtcC1GrzVSMivlOng6/CCdRN7E2meqMM613xrzzgMPu6bXILDC5g6jf4jeXs7vRC+PbN8DgUoqd5RRLKhY5L9PRdCz09UrO9U136rJgpkYROrdRYumTB26qSrpuGHz8gYAQlqPkHM/DCTeRJIh9ym0y1+Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvuPNyqvJJzPLKaw1lYdApzjwyy+6WmH/Zr8sRuM32V14z5CVmaTLSdqR4fjegOb+nmHvaWceEHYCQ/go0oH5WJ5lYrkB60AZBY9yjH7NxGrMNaZwhNxKI08Ekkszs06HXQN5wtiYYhlnkG60N4wr1rVgSksfPvt69TVP8JYnvqa+y+pA/QN6HeBmMwgeTZ0/vf1LE/OtPLD87JKUPNvGzN/GzU01B2KqYVgqlA1ZU9MffNOqSPrseIypBTM6WbVTuC20kBeqoFE/nQWrAHN48T/2+M7TiT8IgpIWD2S+CdOIpFhUJzcczzxA5DF7HVawu07ISUZUDZSdT0tHveiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaZfD0S6jA5l7MsQanmO5KiA82VuVuZAFve4WyKPkvo=;
 b=U1v/qyi3PLk7SC1o5yRHGv/Qk4IJ02DAgEnDUm36urG4PIB2wRHGQTCS8OFNlMn3ojV+rNeZJql0WIY7bI6vNH/4iHjdzuqyWswU/RG0Ld5NE4T93wCcZmYoQ7H8InDk6oIOrHuVXiMmTLvv/Ar3VbQwi0yMc5/I4QZAh6lxVh3EPfSYG11F6ze/TCzvgO6A5isWoh2wWNKNx1ErvwDT/hYONcrCfw9ZPMTQTP5Xoz51Nv8U6ZyTHsMg/2+n518X9tQN7lOApbsSHIOfYduOcZzdxSu/IWcysJeYYFqv1YRCYNJYUxH/9tYtQSkw9KADecSskudN7z5syYmeK7cSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0030.apcprd02.prod.outlook.com (2603:1096:300:59::18)
 by JH0PR06MB7267.apcprd06.prod.outlook.com (2603:1096:990:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 09:21:08 +0000
Received: from OSA0EPF000000CA.apcprd02.prod.outlook.com
 (2603:1096:300:59:cafe::1b) by PS2PR02CA0030.outlook.office365.com
 (2603:1096:300:59::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 09:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CA.mail.protection.outlook.com (10.167.240.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:21:06 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id DA76F41C0145;
	Mon,  1 Sep 2025 17:21:04 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
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
Subject: [PATCH v9 00/14] Enhance the PCIe controller driver for next generation controllers
Date: Mon,  1 Sep 2025 17:20:38 +0800
Message-ID: <20250901092052.4051018-1-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CA:EE_|JH0PR06MB7267:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f840ec24-6ffe-4df5-bf70-08dde938e183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXvgUFcvDlGlax+cpRbi4OStDmGiIXsbeBzj/qDXEi9BqvhyuOl1H5qolnGV?=
 =?us-ascii?Q?gaJiu4H9g1drKeu02HZFUOj13JEoEuwfZo3Blm8yEEMpJLvJl7MCxkRpmk/x?=
 =?us-ascii?Q?iHjYRFu1lfgyaj/aqH070Ivt+kdSrOjzORaCZpJugKBcZpt/euuE6h6C3kHK?=
 =?us-ascii?Q?WGwI/eM/fl4BKNP99iwmxC3vVByw6z3kmK0GkzffRJ17wjyRkzG7b82jJBx6?=
 =?us-ascii?Q?56fmklbDDcckjRsE/FuNnBbeTEHy1L9iDCF1XrlW01nlGKBNzgvIFqVwg5dp?=
 =?us-ascii?Q?b79v61Oa8XtiSxqS+NCNeozOsDH1F2wDEeWDuSXVFQuz5ccpw8mVgGX9Le44?=
 =?us-ascii?Q?M3FAjbmDDhPeJJ62iCU6L/N0itYWdFr0sPrPCVa3QwbJHwtwqX8+WKxRBbJP?=
 =?us-ascii?Q?c38JKf5905n8QjeTuczXRJW0YK3LOqj8updPbfN8LjrgYgjcTZIE1izVZ5KH?=
 =?us-ascii?Q?jg+SRJwtm+Cinfu2asJBSipEylM3oWBQ/W3vLDCZj6YhGPuGtD9xaTr9/Pbx?=
 =?us-ascii?Q?FT/hTIycgYctq4sdPSdncEzdhvVXeyqoj/Fs6ohwUN9Tsd27atq6+dDdlsKo?=
 =?us-ascii?Q?J1fhRHTLaJqSkHMIxXjKGWtzLX3sGhntmUXA4VImS5QKD3zCZjq+gOEi6h/j?=
 =?us-ascii?Q?G4VqVHJxOhaypSIyxMSEYdSlNgRyrRLbVY2sr9K6OvOW1SVrKPn4bWXtYmKP?=
 =?us-ascii?Q?7iDFmbDBFH/6Az8oFb8J9qvR04KXPwvp4epps/E+g4AboXY1TfSCwo+3v+gd?=
 =?us-ascii?Q?7ybBAiBSFnUzGzmgBWI27BqLtdlZy05lU1NmLAOP6yuasT1TnyE8eMxa/tHu?=
 =?us-ascii?Q?CnphkGrdvVN5bmSsQgvX9c0THz4b88gMaIMRmflxX29r7f0TwrjsWvwL8R6j?=
 =?us-ascii?Q?GmYeREaVAr9Ywp+Mqj0pWJC/EoLmO/VKLIlxh1rIcVVXA1TC+OlXhmsBf8b2?=
 =?us-ascii?Q?f686IbKCGtFdd+YBMzX//dOhvJFhvLzd/4kekhB3IjZTgbrAFaNcoNY6B2Z7?=
 =?us-ascii?Q?K5XF0/6FVGrvXGba40Cxy9GEUsayguErg/vadq2yJFrIdro1i0SoT8oNPqIZ?=
 =?us-ascii?Q?lQ1Uodg4YkDKAZJvtfWUGLLq9vaDZqI0TFxlZIcTlKkBwRFw0ALb9e1Vm6Rm?=
 =?us-ascii?Q?RaUuRETH5NLAYkRBnlBtfQ8cf6c8hnDRn7g8DjI9yFNalLzSVkP9NNASYVLv?=
 =?us-ascii?Q?o4kAiZvnPibz7MAo14lULrzVdEVU7aDi7z7yOGO/sTR1MqfVTd4J53jvWMMj?=
 =?us-ascii?Q?2FHsTOx61QxA6gFpaxuKl/m3kxdfOZvSyno6+Nb99bNviXGVnXmqCdxfv1Iu?=
 =?us-ascii?Q?aAJLy1vOq6s3FrdhuixItRSg4FPsb1rCgW1bLssosdvFsN6sneiBvqJjkkKS?=
 =?us-ascii?Q?2Hhk9n7N9S6ArNLbZEeAUI8hHwAZIck1HsycfvNHZX/7Bmqo0OycgkZtPZ2u?=
 =?us-ascii?Q?ZnuVFcyJBvVCEOzOQp/FEXpaqtAQi8uCjYugWSHbo/S8UXeA0iwz6Csc9RZb?=
 =?us-ascii?Q?/sRnEUePYjOnVF7UvUyCoS5SlOom/aVQGHLoPiUJJyHWNrxwulCvVMYWHw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:21:06.4884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f840ec24-6ffe-4df5-bf70-08dde938e183
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CA.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7267

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

Manikandan K Pillai (8):
  PCI: cadence: Add module support for platform controller driver
  PCI: cadence: Split PCIe controller header file
  PCI: cadence: Add register definitions for High Perf Architecture
    (HPA)
  PCI: cadence: Add helper functions for supporting High Perf
    Architecture (HPA)
  PCI: cadence: Move PCIe EP common functions to a separate file
  PCI: cadence: Move PCIe RP common functions to a separate file
  PCI: cadence: Add support for High Perf Architecture (HPA) controller
  PCI: cadence: Update PCIe platform to use register offsets passed

 .../bindings/pci/cix,sky1-pcie-host.yaml      |  83 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  20 +
 arch/arm64/boot/dts/cix/sky1.dtsi             | 126 ++++
 drivers/pci/controller/cadence/Kconfig        |  21 +-
 drivers/pci/controller/cadence/Makefile       |  12 +-
 drivers/pci/controller/cadence/pci-sky1.c     | 233 +++++++
 .../cadence/pcie-cadence-ep-common.c          | 253 ++++++++
 .../cadence/pcie-cadence-ep-common.h          |  38 ++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 233 +------
 .../cadence/pcie-cadence-host-common.c        | 182 ++++++
 .../cadence/pcie-cadence-host-common.h        |  26 +
 .../cadence/pcie-cadence-host-hpa.c           | 579 ++++++++++++++++++
 .../controller/cadence/pcie-cadence-host.c    | 156 +----
 .../cadence/pcie-cadence-hpa-regs.h           | 192 ++++++
 .../pci/controller/cadence/pcie-cadence-hpa.c | 205 +++++++
 .../cadence/pcie-cadence-lga-regs.h           | 230 +++++++
 .../controller/cadence/pcie-cadence-plat.c    |  20 +-
 drivers/pci/controller/cadence/pcie-cadence.c |  12 +
 drivers/pci/controller/cadence/pcie-cadence.h | 413 ++++++-------
 include/linux/pci_ids.h                       |   3 +
 21 files changed, 2407 insertions(+), 637 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
 create mode 100644 drivers/pci/controller/cadence/pci-sky1.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-common.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-lga-regs.h


base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.49.0


