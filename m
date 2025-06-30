Return-Path: <linux-pci+bounces-31038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD84DAED345
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69357A4430
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B7E1C6FF4;
	Mon, 30 Jun 2025 04:16:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022138.outbound.protection.outlook.com [52.101.126.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53AE19CC29;
	Mon, 30 Jun 2025 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256976; cv=fail; b=TxzgGPBXOl4SX1fTSTt3S4knRDkxGLq3Td6hFz3YwgPlHQQs7JHSt+BGkOjT8kDbiiy5doV1dNle5WUQ+m5e8sejMLG9qNSd/ioC6+/2ke0H55uBlEPigmjL7Y1eMmmSM0wL3jzp79HxBjRMAQRcLCXH8dQZT9jEdNNAYJaQHJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256976; c=relaxed/simple;
	bh=rgrXjeZBySBDvWbcMnAZyly0qlkF+jFU1U/cNbFBQes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KGZSVIP3W/RAuGG1sFExxNEwd3SrGVASVbxcMkzLNyffPetP0nrM/WieUl/JzqojodqhDilEgFcGwommlYma6A47vWmvEOhWs4o0/wPAqnWCmXGlMGgGQgsN1gj2+S8MnjejnbAf3x8tkVtxR6Va6t5KpxbQ6GNWdWKUESFxmeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfwuNgjayI6sMwZtW6naPTCZS5JKujKj96hTYwktQLailVGMx+qg3agXpwmyobxcvfO/liw7BJRR4Nznjd9JQaFTxDfw+fXZSaVgbx2q0Zwa+ecCo94BnggyPD4RFrWgEoaztNmZAvPFjNIS4Fsu+xvVMpCI6rKhGzKj+gcp3NhEohCqchsATRq8ToCX0blYG7n1Pt7PB1LjIUli4Fc0IgVD1ZzIDvXwXqsFxywTm6rnh/yKV1E09GbMO4yPz9QfJarHW0Xs2TAjaiJolNVztr0Nipb9nkAkN4p6D1ZqdUswwciPN1sh7es3fdgr/XBznBT/5ikqZarIZgSFrm6iHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhLHdan/jCGLJQtm/Sp5km8sIgO8H7ViFS49X2PSs4M=;
 b=vNPgipBsY4C2bJJSh//D8iogF9ucNMoVPzkORYNsYtDhPfL7BmzZdUMk1Wgt9Txm3qxGV8RkMAKZZYpkqaj8ivX20OV2AGwwoct/E6bpTdF/mY3luiil5rIOJvjLhgqIEYeZFxO4xlx07L/WtdkjbM8AJOPBxua8htg4MzbxsK7gb54e2lIiZ/cUOGiJI06Y1YUMZR6vsImKLP31FQcerlWu4JbsYfCEWbjKGMJUSyNIC2KQXJ7NIGNiDGD/cxNgC+KLoUxIgAsjFVjfGn1Kti8w6pz0A11fe45UH0r1clHMEw+IFd3UrnWa37F5E97CZBMMJFrGrSkdn2X49sbXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCPR01CA0127.jpnprd01.prod.outlook.com (2603:1096:400:26d::12)
 by JH0PR06MB6939.apcprd06.prod.outlook.com (2603:1096:990:66::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 04:16:09 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:400:26d:cafe::ac) by TYCPR01CA0127.outlook.office365.com
 (2603:1096:400:26d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 04:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:07 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 61AC440A5A31;
	Mon, 30 Jun 2025 12:16:06 +0800 (CST)
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
Subject: [PATCH v5 00/14] Enhance the PCIe controller driver
Date: Mon, 30 Jun 2025 12:15:47 +0800
Message-ID: <20250630041601.399921-1-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|JH0PR06MB6939:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b0a6879b-4897-4737-91c5-08ddb78cd633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X10xtcO7nkpjBHy9yK07f6ltu9pYZG6Lmly7IQfLDeBWBdhSqbkYZypsdTOT?=
 =?us-ascii?Q?V1nFAirp2wiNeFBnMI/W+np5wnWDe0IjwX4Y5fPEv2OVM7cFr0sKrZq022vz?=
 =?us-ascii?Q?VBxxp4jA7MDjnvpXTPpkMh2iu8c2+E7gz7f2fCp7nLpLJx05+EuCn+gmryIq?=
 =?us-ascii?Q?UWI6G4QYczcOG3ri4Vs1GJCycHTF8LQ2TkZneF3NbANUFcAi8v6Q5PxYCVxy?=
 =?us-ascii?Q?Rmws+u+jD6leWSFs+3Nw3442maYgPQtnSvq8qgItTTw9X2GSYgb3sasBFPRR?=
 =?us-ascii?Q?3PK72YuGwHm6nApxRqR3aopC4R9PUkXDHa3xRWM1yzd0Df50Oo01fEF5MB2q?=
 =?us-ascii?Q?GdOyG7AGo8kiq2f3BrmVNmG/yiF5d4loFKqG3tlGlMfI6GYJKNA2741zfztq?=
 =?us-ascii?Q?r3Zw6m49rxUaTmku0WSQ9jNtCZ/UQS65Gx+l7TlfK74SN9Y76ikPhk1DIrPd?=
 =?us-ascii?Q?56W+ErLpv6LxJytqCoWT3/dajdxrvmw96eNHt+SuoAt8dUPiMpoP/8ls6I9Q?=
 =?us-ascii?Q?RP6J3Qtrz/qHo4G4Qgdnc8pC/PTwwFCYTHl/I37/QAjAovVJLf20ju8Bwg1x?=
 =?us-ascii?Q?oVXwsLIs8/usdHrLvUC1jhWvlirBcD/9kCi//Ts1qRr54Vcj2Bim/uv3tnaa?=
 =?us-ascii?Q?mcDkHkgZwW914na9FDB1bBn5D45R1fc0Mbm4x9fefyo+l84cqqcvz5iIPOE+?=
 =?us-ascii?Q?4tgufK/9Cw2Gd/kP/HTTCVJhpfn+PlK1/y/mA7Ogq88VRxHYwefxldaK5ZGi?=
 =?us-ascii?Q?5wuqsM11J8zP8XxNs/7mkrreRVjic4OYkBLP//lgDa0l/KfNJNAu7hlvGb9W?=
 =?us-ascii?Q?8NYjnoycpVjx8GDgDvGQuYE6Dcd7v+Wb2kOrbrx8v7ALKuJsmJMHFZLJd5/6?=
 =?us-ascii?Q?KSTZEa8cVTAQD5gWQHzmnm5ZDr6O3xS/e29HLrE6cXJwJUYBuUQb4/CZiwZJ?=
 =?us-ascii?Q?HcW7Cer6Kf7ePzdrRsIbSrMetHda7GQeLufgvHQCx1iOlqxK34cdjB1Lesm7?=
 =?us-ascii?Q?Zua1o5LSa6ggkd2/D/OyNo9Yu7m3BbASBORnAkpj8CcIy9C+vQfCPMNwoeG0?=
 =?us-ascii?Q?WTNoBsLW/ceLCu3NYDuMGMX4BMD9Bvq76tIH37GDyMgr9YzlOdqiDNoFQ3FJ?=
 =?us-ascii?Q?RAbe60sFLX5Yj9hgsS9OBdvNIYw2twdV0TnIidpTPiy2tHEkTRwQVE2sTkDz?=
 =?us-ascii?Q?q9YnXWykdM/mJOG6ee01kR1VE2L7qj8iS6XtCxjGdC0vQRb6k7xrf0tzFyfx?=
 =?us-ascii?Q?kHCSshNhvzXUZ3SLZcYbh0G9MyxsnGoNHWr3vSSzksx/oWSPwW/T8/oZmxxp?=
 =?us-ascii?Q?n5jyCG+GMvCiOeGGAYNS9G6mFwBfiroTaO0limtSRrsjgTBxCVCjeHzoPuLI?=
 =?us-ascii?Q?IS/hx36yg7Ao0CVlf4gfrICahdEwHjehzBd9fjt+vWKAJ3+Z2rAxh+YRJjvf?=
 =?us-ascii?Q?Ak28XebKzZmFlv5FIRtxANparVSi++MI/nHfncQKa++0/cZG1UsHjm7bpM+q?=
 =?us-ascii?Q?eaE51qsJI7t1yF0KXzmcWiwsulqu4K31aKhvGZw/kt9iuF7rj5z/bmJhBA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:07.1470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a6879b-4897-4737-91c5-08ddb78cd633
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6939

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
--strict. With the --strict option, 4 checks are generated on 2 patch
(PATCH v5 2/6 and PATCH v5 3/6 of the series), which can be ignored.
There are no code fixes required for these checks. All other checks
generated by ./scripts/checkpatch.pl --strict can also be ignored.

The ./scripts/kernel-doc --none have been run on the changed files.

The changes are tested on TI platforms. The legacy controller changes are
tested on an TI J7200 EVM. HPA changes are planned to be tested on an FPGA
platform available within Cadence.

---
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

Hans Zhang (5):
  dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex bindings
  PCI: sky1: Add PCIe host support for CIX Sky1
  MAINTAINERS: add entry for CIX Sky1 PCIe driver
  arm64: dts: cix: Add PCIe Root Complex on sky1
  arm64: dts: cix: Enable PCIe on the Orion O6 board

Manikandan K Pillai (9):
  dt-bindings: pci: cadence: Extend compatible for new RP configuration
  dt-bindings: pci: cadence: Extend compatible for new EP configuration
  PCI: cadence: Split PCIe controller header file
  PCI: cadence: Add register definitions for HPA(High Perf Architecture)
  PCI: cadence: Split PCIe EP support into common and specific functions
  PCI: cadence: Split PCIe RP support into common and specific functions
  PCI: cadence: Split the common functions for PCIE controller support
  PCI: cadence: Add support for High Performance Arch(HPA) controller
  PCI: cadence: Add support for PCIe HPA controller platform

 .../bindings/pci/cdns,cdns-pcie-ep.yaml       |   6 +-
 .../bindings/pci/cdns,cdns-pcie-host.yaml     |   6 +-
 .../bindings/pci/cix,sky1-pcie-host.yaml      | 133 ++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  20 +
 arch/arm64/boot/dts/cix/sky1.dtsi             | 150 +++++
 drivers/pci/controller/cadence/Kconfig        |  29 +
 drivers/pci/controller/cadence/Makefile       |  10 +-
 drivers/pci/controller/cadence/pci-sky1.c     | 435 +++++++++++++
 .../controller/cadence/pcie-cadence-common.c  | 134 ++++
 .../cadence/pcie-cadence-ep-common.c          | 240 +++++++
 .../cadence/pcie-cadence-ep-common.h          |  36 ++
 .../controller/cadence/pcie-cadence-ep-hpa.c  | 523 ++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 243 +-------
 .../cadence/pcie-cadence-host-common.c        | 169 +++++
 .../cadence/pcie-cadence-host-common.h        |  25 +
 .../cadence/pcie-cadence-host-hpa.c           | 584 ++++++++++++++++++
 .../controller/cadence/pcie-cadence-host.c    | 156 +----
 .../cadence/pcie-cadence-hpa-regs.h           | 212 +++++++
 .../pci/controller/cadence/pcie-cadence-hpa.c | 199 ++++++
 .../cadence/pcie-cadence-lga-regs.h           | 228 +++++++
 .../cadence/pcie-cadence-plat-hpa.c           | 183 ++++++
 .../controller/cadence/pcie-cadence-plat.c    |  23 +-
 drivers/pci/controller/cadence/pcie-cadence.c | 138 +----
 drivers/pci/controller/cadence/pcie-cadence.h | 416 ++++++-------
 25 files changed, 3524 insertions(+), 781 deletions(-)
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
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-plat-hpa.c


base-commit: 5da173292645ab241a9ccc95044a0b56c2efc214
-- 
2.49.0


