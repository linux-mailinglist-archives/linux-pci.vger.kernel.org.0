Return-Path: <linux-pci+bounces-33903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57875B23F8B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764C81AA3D2F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16C92BEFEB;
	Wed, 13 Aug 2025 04:27:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022084.outbound.protection.outlook.com [40.107.75.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D528D828;
	Wed, 13 Aug 2025 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755059236; cv=fail; b=Gz0dvDXQq8H+aQepxdsuorMTqtarOiZgjCI5IhaSs7PDTtOIUtto5BkeJhC1HZUXiy3Mi4ygtZKVUIuH0RqFUa8bRWia6o5IbsjsH9NLrh8rwXo9xSSEQwpFd4ngZgt3EaUeiDJ7FV+AGgfeesCrtGa4oCiDU3GMtM10jt4ZwZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755059236; c=relaxed/simple;
	bh=DkDsODTKJcwrQK1kJbSNW4xRQ5bE8A6A2ag3skAmrSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BXASjHq3RCNckYCQ9CiawQZt51A6Nxk+te63srxm03o5Wj70yCe4YjWGH6j4mzAkQnC2mMIagQVy4n9Q+heIk/elLRxj8ZH9WVQyDKZ2FBj/KFwHECjE90AeNFYJc7JQMQVTS0dVQEd/DacZvIUD263MOeWBJR7Sa3LZWaAJHU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLP4JlE3vmC8X1Pj+vb0pYYX6cmAdUQPXxYK/gP4BzHV9QHjGoNgP7yztQKd+ySEgpl09C/6qwoXvC1SRA1TK4y8+7BE9dfk13VnfrHziR32jCxTqJO2uSskeBZIuSkoSrZ183KDI9Vd5oGQ9XY0jFMwnrCdVwm8M4CLu5VV6MR57/Bzi6/WpasJQMS0ZVAIutU8yaCM2wW+ZqAI6pdZNG2MTJHjBSioMTS4Ro2hlvzZ2VzwkqYcHTSu6Pb+AeTyyOrP3TnUMlir8YO60mOnzba2ciDhuDV35+e2cc0XNjRrw0Ga5dT/eyU+i5jPZYVi21rkOG1E+2M7uWdvs5IMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0C/KassDP8CikJZj28nR8A+zX4uTOtkbKJ6E0WJRXw=;
 b=HNmYDkUgXqFmwjC3HgZYd5RIkrYmrtyUJDyftQW5SPoM1592AuwZrB3/iLujAjgcBQKiox+uNssSYSWM6VRfOC5XaoIT5f2HDnPgGOye8iMpc7jnP6Cgw3b2owXs/NMka7ItifhRQSFvAB5g5VADWOVk3N1+hCth6y7SgDEYye6Vkt6SQlfpaIqppVGf5Lp9GULmmxVvGb5eXjnTLavbHnayk4gw7ZU45+y5wElql7aa+Q5AqsEnf/E54uY4gmJI1bTh8qfMtcEzDEgl3u4Fgm8gCLEqWYo7wrHfmLpD2yizn/33vjvlFsETfI0CYZWmsA0lOVJ8paRes+m8Cy9AIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYAPR01CA0080.jpnprd01.prod.outlook.com (2603:1096:404:2c::20)
 by KL1PR0601MB5536.apcprd06.prod.outlook.com (2603:1096:820:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 04:27:08 +0000
Received: from OSA0EPF000000CA.apcprd02.prod.outlook.com
 (2603:1096:404:2c:cafe::e3) by TYAPR01CA0080.outlook.office365.com
 (2603:1096:404:2c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 04:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CA.mail.protection.outlook.com (10.167.240.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 04:27:07 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6E68644C3CBA;
	Wed, 13 Aug 2025 12:27:04 +0800 (CST)
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
Subject: [PATCH v7 00/13] Enhance the PCIe controller driver for next generation controllers
Date: Wed, 13 Aug 2025 12:23:18 +0800
Message-ID: <20250813042331.1258272-1-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CA:EE_|KL1PR0601MB5536:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 15e16e9d-dfd8-41c9-25d0-08ddda21a9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nM+whYMbCr0CWK9oIBACPfdOR5IBAfCW9wlkOqQPSs+PDSRh3323a54wRSmT?=
 =?us-ascii?Q?+RFAS3ihDRPt5jHFRFs++khtAIlHK/aPW92shSsm0bqTo7pJylhKok7QHh9x?=
 =?us-ascii?Q?vswhhuq+ysVMash7JJqC/Wqeqq3vpWx9a/+gh40O+SjdHo3j7PP6cvzCfoEM?=
 =?us-ascii?Q?2T10iMnfRPKDeIZmQo8Am/kNQBGPB9BJQ5aUIOqs4DY4vKPpMS3VRFcVCH2q?=
 =?us-ascii?Q?+FMIJWK/pnAUHGjpzjFo5A2O5+gapsBpiMYNpWWEUxuaKY3LyTOip/Xq3epQ?=
 =?us-ascii?Q?JWh9k+OQ43456z/jrrYl2t36lOZizQV6Iq483evBWhKUQcBzbZjgl5SqFM7z?=
 =?us-ascii?Q?97qfn4r/Y+7JZHUls0CSyxDXuyFZ/JLU6ph18W7qYBsfVP6CODqpHZd+npv0?=
 =?us-ascii?Q?+Ol5oBTs3W1h2LDN1nCmKaltokRmVo5LX9XHmq9t1F6KpA0VdEGgu/4CyOt0?=
 =?us-ascii?Q?dJ8SQJP5SheYKghwZQskBLtwxF6vQjuGDTmgmatzF2OmB+f978sneg2DQHA7?=
 =?us-ascii?Q?FVNLmJ2MMlYtrVAZchlby7eWWEe2kHqqQ77rHyUnHFg7wAZzFyvooDdI1eaq?=
 =?us-ascii?Q?4ZqQjBPLAljWTtjkFFTirJXEP3GhwsmDqtoctPyw9z/WmcM87zbenJL+EQhm?=
 =?us-ascii?Q?+HxRl2k22gpNCNazpmyqviwYotOs1TY09HD5uBUHJq4+OcSM1yKMzY3WDJQy?=
 =?us-ascii?Q?emDpDpIC/9gG4HfKmTjjx21lC6HEBlV5F0z3k2SccMcFFgdb4m+pJoFWvyPc?=
 =?us-ascii?Q?jizNboLGcxLLnwwkrJPVJWpFexuiIYqTf5Xn7MCRX/SMQNMY0kU5zBTHw/JY?=
 =?us-ascii?Q?8tWOCAgLUC8gW9GYCJwpvtHk6hV9wtsH/2oyx5LpDqPyfmhdEzlOrJbzavGw?=
 =?us-ascii?Q?9CUEb+Lvrl87/hyrV7c5XGee3douhkuiPfYV8HZ7uJze16t4/S4Od3o6thL3?=
 =?us-ascii?Q?k82U0zurFE6Z2rkXkwstk+9iH05fkHUkIy2vCux2sm0J3bl2wMr2ewVoAjvf?=
 =?us-ascii?Q?/wssatZbnF3SNgwxQ86X0Jst4R7SrdcIVX9qdKTv4CkbYoepxtkusgdbsFeU?=
 =?us-ascii?Q?T8qy4IRYwYrX8ximPe5mVjRT7UvpUfsGZJUs0Vn09yoYx16a4EfpsgijaqDm?=
 =?us-ascii?Q?85LpYZZCsyidfIqdkafrBNhudatSPzPy/S/jLLh/VAMB5dtfXzR3hZn++ZsM?=
 =?us-ascii?Q?Qn8BWiXxwQtR92feDjZhgshD1FliqJ9G3RuDPBavgD4/PJ97HtQ2ELfmcD7+?=
 =?us-ascii?Q?+3ctWvPQ0felvEcU7ZxBiSbHOSqNcxZaD8g15B6mS3Y91hpXbwReZpWG4mgB?=
 =?us-ascii?Q?/hIIXqDudh9SoodWjBzajSdl74EbTg4pQx9duFOTzkwuxtruSUrsHaxqydTL?=
 =?us-ascii?Q?aIH/9UX5yDtpCclC7EF9/4CFtU/0QpeiY1Dg610pVGgTLhAcELa+/O+wpBc7?=
 =?us-ascii?Q?fhhJkHQY6aeWI+EJc9+V0jlFsUxDzCvdxMI33aIjc6cfNp2xxr1gCZDU35kg?=
 =?us-ascii?Q?AFfqgZavQhVQSwDJLxfsqLSePt7TdOsS/uWHUub+uONrDlmTtcgXiQli0Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:27:07.1838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e16e9d-dfd8-41c9-25d0-08ddda21a9cd
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CA.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5536

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
--strict. With the --strict option, 4 checks are generated on 2 patch,
which can be ignored. There are no code fixes required for these checks.
All other checks generated by ./scripts/checkpatch.pl --strict can be 
ignored.

---
Changes for v7
        - Rebase to v6.17-rc1.
        - Fixed the error issue of cix,sky1-pcie-host.yaml make dt_binding_check.
        - CIX SKY1 Root Port driver compilation error issue: Add header
          file, Kconfig select PCI_ECAM.

Changes for v6
        - Based on the latest linux master branch.
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
        - Add header file bitfield.h to pcie-cadence.h
        - Addressed the following review comments
                Merged the TI patch as it
                Removed initialization of struct variables to '0'

Changes for v3
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

Manikandan K Pillai (7):
  PCI: cadence: Add support for modules for cadence controller builds
  PCI: cadence: Split PCIe controller header file
  PCI: cadence: Add register definitions for HPA(High Perf Architecture)
  PCI: cadence: Split PCIe EP support into common and specific functions
  PCI: cadence: Split PCIe RP support into common and specific functions
  PCI: cadence: Split the common functions for PCIe controller support
  PCI: cadence: Add support for High Performance Arch(HPA) controller

 .../bindings/pci/cix,sky1-pcie-host.yaml      |  79 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  20 +
 arch/arm64/boot/dts/cix/sky1.dtsi             | 121 ++++
 drivers/pci/controller/cadence/Kconfig        |  19 +-
 drivers/pci/controller/cadence/Makefile       |  11 +-
 drivers/pci/controller/cadence/pci-sky1.c     | 294 +++++++++
 .../controller/cadence/pcie-cadence-common.c  | 142 +++++
 .../cadence/pcie-cadence-ep-common.c          | 252 ++++++++
 .../cadence/pcie-cadence-ep-common.h          |  36 ++
 .../controller/cadence/pcie-cadence-ep-hpa.c  | 528 ++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 243 +-------
 .../cadence/pcie-cadence-host-common.c        | 181 ++++++
 .../cadence/pcie-cadence-host-common.h        |  25 +
 .../cadence/pcie-cadence-host-hpa.c           | 586 ++++++++++++++++++
 .../controller/cadence/pcie-cadence-host.c    | 156 +----
 .../cadence/pcie-cadence-hpa-regs.h           | 212 +++++++
 .../pci/controller/cadence/pcie-cadence-hpa.c | 207 +++++++
 .../cadence/pcie-cadence-lga-regs.h           | 228 +++++++
 .../controller/cadence/pcie-cadence-plat.c    |  28 +-
 drivers/pci/controller/cadence/pcie-cadence.c | 139 +----
 drivers/pci/controller/cadence/pcie-cadence.h | 436 ++++++-------
 include/linux/pci_ids.h                       |   3 +
 23 files changed, 3174 insertions(+), 779 deletions(-)
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


base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
-- 
2.49.0


