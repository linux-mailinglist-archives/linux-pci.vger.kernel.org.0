Return-Path: <linux-pci+bounces-34291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E433CB2C26E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9E3726233
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9473375C2;
	Tue, 19 Aug 2025 11:55:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022120.outbound.protection.outlook.com [52.101.126.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61AF3314A2;
	Tue, 19 Aug 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604519; cv=fail; b=X+mpIMv2m8mnPfkeeXBh43yNYjrTfK4vUcuSkb1Zstt01veaGBVTsRtaJ7l+ofkj0c1m51L2NJdJIUtn45E2kzWj78rkWkHtfy8niaSLt3hXol1sGWH8fZPW7MMAFz1SMZo+wmKUOHTlG9TFUdKgHKPIxtQuZySS2lcikckn2rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604519; c=relaxed/simple;
	bh=V1bWYpjHngtKYRZ+9wSNtinUJpMDG2Z6U+eizcWvJms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FdepvJ8BO766Zl88xR6rwxPpSBGzelIY8psa49GyxdCff8S9LgYTn/S3Z7265Zu3S+tT0gNSAKK80lsw5icZ4SJGHX1rPNlP7ZHo2r47ZwWmxM+UYPv8LeiDYhIJQEzfMDBQzcYT8Ahb67cMlIo0aXPpZxMaw0cR9H3KB4aZO7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMt0cwGe2BDmNRYY/TCe1S/A+2Qt/f5FIMPVQXPE/VY7BHRg8dKCF3i5y4V3WP4mx2ZFqdeLFgwh854artLGklkIoOIdHzQMWZstZcxHvulxTZoA9MLda/aASuKSzKmGNJxLUOtOrTCb0Vh6VaGCXR7pA011xvvV431Wi8w+RR956yofZblqH48ZcDcb/VlRXpqORzRhaA8/a+yqWNJHbUeUCnJmVbiCIJ9Q/MkweuIPLEI8aq4AjbHes24CrKRFxDq39G4UvJ//p3Is063FRcM+Ps32A1F0DrhYgFGOCEFwhdaVxvpcaVpKztztj+ov24SyX20GZcqa9ycsMcC38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dqv+g8+RV+yHMaBArL0IwTyOFOm+CEZRxyjSbOl4gaU=;
 b=vs7oRVF9cceo8q8oCxBr2G2XUQlTJJ+jAA7pvP8sPu2ZbylANeCMEhKPvIU2n2RATsmMXw7eG9+kSnqxFGq017xoeZ+M2sCVD7vpLDw2HLzGhJ1+lvRfXtLSB+AtukinOFV6sTVJd3lwGMo2B3wlHuN1V6w3jq+1YMReocnY5oG5ryU2lgYwsgRgFdveW5uHEWXHAsm2cNh3aGnJ/YramC08RRA9EFI7F/hj/AtawMOhISL+KjLtHP1p2wkieBJGNBuTZcqs12m/96jwab3RqpF0VNSEtuE0Ku79p/u4WKgKeZ/yjcFlAT4MPmzYvCLDurtV1jgHePP47wCnOgcieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP301CA0039.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:380::16)
 by PUZPR06MB6266.apcprd06.prod.outlook.com (2603:1096:301:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:55:12 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:400:380:cafe::3c) by TYCP301CA0039.outlook.office365.com
 (2603:1096:400:380::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.22 via Frontend Transport; Tue,
 19 Aug 2025 11:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:55:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 63031400E6CC;
	Tue, 19 Aug 2025 19:55:09 +0800 (CST)
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
Subject: [PATCH v8 00/15] Enhance the PCIe controller driver for next generation controllers
Date: Tue, 19 Aug 2025 19:52:24 +0800
Message-ID: <20250819115239.4170604-1-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|PUZPR06MB6266:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 83b6d5cf-f01c-4595-dc9f-08dddf173fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B4030h3+tn2oHZGAtU/IwOdfxAPlN0/cjhLHhtFd+8uqLtgh//ZfWGVPV/GF?=
 =?us-ascii?Q?f0n19JOE6Leb1TgNNWi1TzLxISASmZKA1o0NVw+9QmRsTfLLpvdAFPQ2DfYO?=
 =?us-ascii?Q?lu1S2O73cgpWLbNkYc1lXzIEBHAyKINGV+a7Qc2HN//jjOizKBeFrh/5umyC?=
 =?us-ascii?Q?Lh1Fu4SO/r8dyonhVZRhueEUY7HYL0P5eeVPbNcS/lbmja5mtFdIoLto7/K2?=
 =?us-ascii?Q?2CQIvw4bz2YcNdpyCjT+QDi8SYYtpHlrKnTyHTzsxobfI6Mvxw36a0H8wTmg?=
 =?us-ascii?Q?YOmrpDO+njZ7IaHqBcvJwg+w5cF17SJgCy4H1t/HGqgSTkzEiEkD+oenqKND?=
 =?us-ascii?Q?80e3lypywPRDLBCTo86DbLNBm3mYo47vYExk/E0pLurZSxUecFaPXsB0Pgib?=
 =?us-ascii?Q?//1Hg0OazvvCKt/kssWg+CzN0kQBpDuK16uYgRhl8HUsyll1Rxf7t9Uoi+HW?=
 =?us-ascii?Q?5lE1/tPwL7K4rTHZVDVOnCPnLpSY2T6zoCD4w23D3yfiNOEjp/8MTER6u6Fe?=
 =?us-ascii?Q?dEb4cJyho/3bW7nDiJXjGLSJezUajE+vxwpn4H7IFWGgsqENrvSlqIcYI2ln?=
 =?us-ascii?Q?EdOBm26c+MpSMo+jfBxPvdD2qL5uUZ9lSAwkp5w41m25muVLxYwaNit5A6Nd?=
 =?us-ascii?Q?YZfY7MEuwF58a6wTC9X3uuG7FGMfXnD8Hqmy/TO3VDswel/KbMHX/HUAOnjI?=
 =?us-ascii?Q?nVrJG/p3vTSz60vBrlBUjziode83X0ChvVYfiremvuJV725cEaDMrR2vrDba?=
 =?us-ascii?Q?wUErX6DQInN7vE3yaJgnNP/OTCm/5RTZyyYkAHiEX12So/fI/8DEX5Sm/8fA?=
 =?us-ascii?Q?zrYFS19scpQYSUy3BJwf6U1R7QDn2P5syEFqdMF8kjs7aU7IEPA6bScpxd9Y?=
 =?us-ascii?Q?oQAPtkkZI3fHXrOke+y6CTBgtVInEVK0x4sivYgYL5g7OboTfXLBDmJfrZOs?=
 =?us-ascii?Q?jrDQGMZ+6c21peaVCgOZkzpJ8SXOBHpLHAsg4fLE9tvK7nYzkrX4NjiaJsQ2?=
 =?us-ascii?Q?AXkqBeIZFg630d9m93FZVQ7YN7I4dEBN3a1arnv2hKHxWzhq05ju6qM+WTzT?=
 =?us-ascii?Q?tjSObCyCmiu37uBnJujNO13iH8+NtgqXj/MaBSsJvNWXEF/jnPUt1ROXOnZL?=
 =?us-ascii?Q?PllClvSenASWrcy0mcTVG1/778MD+jVcjIB6cpNijNF3N7Qxn9n8CBdR0pMx?=
 =?us-ascii?Q?vufc/+91S/j9H+smmdcg42nFgOhDcb6bhTSHCfwAuW4pMqkMTMGkitRuFqge?=
 =?us-ascii?Q?3i10SGg81owu0rp68deXybhyb9Xk+TiJBYvSCobTVvcyK1DWmJ0GWOxEnt1J?=
 =?us-ascii?Q?77zwqdILgZOIuX5tDaL4/j0VygIzdBN4618OZ/NSJB5E2LyDJqSClfSaubM+?=
 =?us-ascii?Q?L6D2TRuUH+XD8DWEc3SRRaWYh3Z1Iu5qg39sgP+2/gyqIx0224Achwf5JofU?=
 =?us-ascii?Q?QFtNX+b/6G4V226Q097pHkIlaRxQn+2NAm3wwqegTcHUESZncil6QWzsJh0Z?=
 =?us-ascii?Q?wMU4jkJYY/SfIH0=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:55:10.4368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b6d5cf-f01c-4595-dc9f-08dddf173fff
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6266

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

Manikandan K Pillai (9):
  PCI: cadence: Add module support for platform controller driver
  PCI: cadence: Split PCIe controller header file
  PCI: cadence: Add register definitions for High Perf Architecture
    (HPA)
  PCI: cadence: Add helper functions for supporting High Perf
    Architecture (HPA)
  PCI: cadence: Move PCIe EP common functions to a separate file
  PCI: cadence: Move PCIe RP common functions to a separate file
  PCI: cadence: Move PCIe controller common functions as a separate file
  PCI: cadence: Add support for High Perf Architecture (HPA) controller
  PCI: cadence: Update PCIe platform to use register offsets passed

 .../bindings/pci/cix,sky1-pcie-host.yaml      |  83 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  20 +
 arch/arm64/boot/dts/cix/sky1.dtsi             | 126 ++++
 drivers/pci/controller/cadence/Kconfig        |  21 +-
 drivers/pci/controller/cadence/Makefile       |  11 +-
 drivers/pci/controller/cadence/pci-sky1.c     | 232 +++++++
 .../controller/cadence/pcie-cadence-common.c  | 141 +++++
 .../cadence/pcie-cadence-ep-common.c          | 251 ++++++++
 .../cadence/pcie-cadence-ep-common.h          |  36 ++
 .../controller/cadence/pcie-cadence-ep-hpa.c  | 528 ++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 233 +------
 .../cadence/pcie-cadence-host-common.c        | 179 ++++++
 .../cadence/pcie-cadence-host-common.h        |  24 +
 .../cadence/pcie-cadence-host-hpa.c           | 585 ++++++++++++++++++
 .../controller/cadence/pcie-cadence-host.c    | 156 +----
 .../cadence/pcie-cadence-hpa-regs.h           | 182 ++++++
 .../pci/controller/cadence/pcie-cadence-hpa.c | 204 ++++++
 .../cadence/pcie-cadence-lga-regs.h           | 228 +++++++
 .../controller/cadence/pcie-cadence-plat.c    |  20 +-
 drivers/pci/controller/cadence/pcie-cadence.c | 139 +----
 drivers/pci/controller/cadence/pcie-cadence.h | 412 ++++++------
 include/linux/pci_ids.h                       |   3 +
 23 files changed, 3056 insertions(+), 765 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
 create mode 100644 drivers/pci/controller/cadence/pci-sky1.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-common.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-lga-regs.h


base-commit: be48bcf004f9d0c9207ff21d0edb3b42f253829e
-- 
2.49.0


