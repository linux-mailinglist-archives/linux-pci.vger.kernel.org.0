Return-Path: <linux-pci+bounces-33604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFF0B1E35A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 09:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE791AA1CF8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 07:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7715824EABC;
	Fri,  8 Aug 2025 07:29:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023105.outbound.protection.outlook.com [40.107.44.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17F23B61B;
	Fri,  8 Aug 2025 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638182; cv=fail; b=Xf/FYL9+xRPpnV6JHLlXmLm+YaakoS28l5BZSeivfU0ZLLDwIlBavKO6OSFLY0ngQ+/gt2uYqP9ab8vJEoe/SXRkjwqefewa/7WEer9H/5FiYVafMJHFRZfqBKW4dKB6mMzret31astjZidVotxIgTBQV7g400TV9BtWbrHuoX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638182; c=relaxed/simple;
	bh=r6iXEhRTlUHNSLdfEyxaE8Mpm4VboWVLr7VqKLYc43Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f8ZNW7DaaEbFTXHB7PsDH4nnW22PtMkh4a0RI8ZsLY2CsCAsWLvAIdnOquAkvBhipFzUwkj01OvNuxzqEl/66vl6fhsi7FqCEAyub8SPT/ZEE7POOfWmxEG047B2XcKADLkGIIuptIPkNCyzTxv7iNTaXo9KpFum6VXe5jjdcVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZT3QhshNNb5MJ1+62TmgJwxRJDQtf0zeeyA3n+4PtdYmW+i6mJBV0pTAI0JITv7BeAw1LKPdPHGQQqCECbjmF9I4KSATiW0V6aSQoFA9t0xOlQ9viorqwULnsZcrywjzA79mztYSH3aQgvLjgFHOwMQDP4umLTiE77UaRIZuA8glrGbuqD29f3vrvXt5/K0Jsh5fwVnGPoCuDrCziKAz/VVPtzhUe0lMDT/DiLeCimGODRsJsctA/sJ4QhkmN1QwNyXRlZE0j7MWzXrYsTWDNpXoN07gdZTTff+aG3cJW/U603TIQlEzaDBFMek/2Koh3Mm1dBy/6qI6TDFb+zR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKl8/yOOqurWypM4xBt/zMOiCZcnIsiuTSF45eA1MZs=;
 b=EeyOOWEd98JWIicQ0klpPwiN0dhCi+86TNfpanFPTGr+U9542jdn+czZIfLjn9hUYNJOOw6+kJ6nQna75cZ4E+S8Gm6j6nuwzmqRpFFLkV2V0bWoLeDoMmEUl96im2fJk9uUIbcnxPEe4r/bzI2BIWFW6FoxkCLVKlqIrmtG/jIz5bXtXkwoIztcWHS7RvtiQRJYgjxiHGPpsYTG0vujXLrjpjQkFOOA8dOibu0I6lsSU6IKG7CdXAsOVVntU4J3ipQafkDNcrztl4Jksjh9/+cYJl+C+TNARZUUNUp5LNDzhbacP6yZSqfrJ+9abz7MvfbiO6FirfbVGKxWM7JOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32) by
 PS1PPF63C81D79D.apcprd06.prod.outlook.com (2603:1096:308::252) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.16; Fri, 8 Aug 2025 07:29:34 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:b8:cafe::6d) by SGXP274CA0020.outlook.office365.com
 (2603:1096:4:b8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.19 via Frontend Transport; Fri,
 8 Aug 2025 07:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 07:29:32 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0CC9040A5A2B;
	Fri,  8 Aug 2025 15:29:31 +0800 (CST)
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
Subject: [PATCH v6 00/12] Enhance the PCIe controller driver for next generation controllers
Date: Fri,  8 Aug 2025 15:29:17 +0800
Message-ID: <20250808072929.4090694-1-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|PS1PPF63C81D79D:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0d566e6b-62b5-4344-3068-08ddd64d51eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dSpLNn6MpEFAhgLiaxmbhL8W4iTVqT5SUceSGFpbxWhj6SVBKhAM+kbqJYyF?=
 =?us-ascii?Q?+N5Fl1uZQYAjuXeu8OkkaT8za1aOcormulh9HOOrq+jbs6Dzlw00Uca8lWkk?=
 =?us-ascii?Q?sR96zK8xRl2mutCymuBSQbGOGFQLpLheAyHdH+RDInH4aY3G9llvA1iCBNHc?=
 =?us-ascii?Q?jEkGo1l1PMIzlpyrigr7Yk3FYo3vKVXU8vxbhXePwcmS6gJlgnOpX48jZXw0?=
 =?us-ascii?Q?nftmyCLJ/aFB7hi2F7zObmBRp4up5L6vVBZXJPplu1nZ5fFPackQVzrmU1H8?=
 =?us-ascii?Q?EtyeSdMmujyBw6/DO6YUYZw2ExyKySCxJLhO1+jamVQ3wwHLCGUhqKHCTz0+?=
 =?us-ascii?Q?21PdJf8F/F3vZxJtDapjOCknAXNi6psS+lUAFhH57ecs171/TQ95CkW7Ln1K?=
 =?us-ascii?Q?h8ubUuM2+eWAcgPMFbGJ+TNfy8wepSkft/SFyrJsyxDTzdxN+TiwkxlLW18D?=
 =?us-ascii?Q?0N/gtU4K5/zCP33bTjtGIznzLkg41GPDif/HHd9TSDxeBJZI8gLGYwl8TYsN?=
 =?us-ascii?Q?ZUeIy6uO8rqpH7U8YaZKH/qAOfznqq7ybAgbw7afi0hNoXwHBH1rpHSV5385?=
 =?us-ascii?Q?rV7XobhOeh5VTksI+Jp6/WFLsiL0AkYvQZ0xIduwsTi5kTNWO3Pw154cnM22?=
 =?us-ascii?Q?OAJV++ZUR+Yf1YZ69BtBQJg4E5PU1ES5jJa0DRnNen08Z3eRic04NGvMtRG+?=
 =?us-ascii?Q?+dGn43cFZadNCJa5va1Cflf13fNmRjr6c1JErFZxD4lfplg88SIe/8+yzzWH?=
 =?us-ascii?Q?TWXIKmebgA38hp25iH1CiJxmiu55yXVZcHYIErP6STbcFun8PXZJGcNVzi5t?=
 =?us-ascii?Q?mHZgsOi5N9pUdlzfBjPHReyImzVjMOsxXhV33zvawFf6Jc7iok8kx3sUMkGC?=
 =?us-ascii?Q?OaP/5B/v2APfr5R9mrRAedmaAIeSFdq6ZbsltjoFJUNs48mX9VM5xQRD8Xq8?=
 =?us-ascii?Q?gEKPvP2vP4EO6M576FhdEGaE168vnbqyVFTwdJYo/KqeRe01bPjqkeUHTbUa?=
 =?us-ascii?Q?k7WKa12NW/IJbAJitsudStOZBmkziC2qRKG4MtYfvXNK5QlAz2nf0v4C08Z8?=
 =?us-ascii?Q?RWcBDHdw4Re1RD8g5uhh5IFeIEpWbqURIK60ux6N7a9QmJ8zzGFXKUMQfFuK?=
 =?us-ascii?Q?cCdhpJga0j2HUC60RpsAqAPaAMo0HS4zw2MnTUqNoZCW0P8E/uDhkT+vl0Rr?=
 =?us-ascii?Q?3OdmSsSCVT9qS7ehg+yfO+Oji1/w6AEifN2H8HgegUfiND+tLzGFQ9miLMsn?=
 =?us-ascii?Q?XzNlJ0Wcq0cMDVVDuQ3hLbOr8O03N/1UcITpBOotuuZoF89dLLeJ/MNXT5dy?=
 =?us-ascii?Q?gTazCE2kHaIa4JeOXJfFowQC8aYIc+8GLrJgQhRxgLwxlcAtPAOh7Jqpi441?=
 =?us-ascii?Q?+95Eczqop7WH4ncglFc9t/Zw6m+PtF19twIJoVpxVK+SwbAdRuZq8vw2ixrP?=
 =?us-ascii?Q?Q/Kt1pLas97vPSj1kCZAgW30pF2OyKyVclRLmkyk6JfohXfQu/R8MD9n4dsM?=
 =?us-ascii?Q?OQjI0v30Rwe5B+IP3n3BgwXVd38e4h6cq4rryMnm0ez3gBdXi2Cn6veXeg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:29:32.9996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d566e6b-62b5-4344-3068-08ddd64d51eb
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF63C81D79D

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

Manikandan K Pillai (6):
  PCI: cadence: Split PCIe controller header file
  PCI: cadence: Add register definitions for HPA(High Perf Architecture)
  PCI: cadence: Split PCIe EP support into common and specific functions
  PCI: cadence: Split PCIe RP support into common and specific functions
  PCI: cadence: Split the common functions for PCIe controller support
  PCI: cadence: Add support for High Performance Arch(HPA) controller

 .../bindings/pci/cix,sky1-pcie-host.yaml      |  73 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  20 +
 arch/arm64/boot/dts/cix/sky1.dtsi             | 121 ++++
 drivers/pci/controller/cadence/Kconfig        |  20 +
 drivers/pci/controller/cadence/Makefile       |   9 +-
 drivers/pci/controller/cadence/pci-sky1.c     | 292 +++++++++
 .../controller/cadence/pcie-cadence-common.c  | 138 +++++
 .../cadence/pcie-cadence-ep-common.c          | 240 ++++++++
 .../cadence/pcie-cadence-ep-common.h          |  36 ++
 .../controller/cadence/pcie-cadence-ep-hpa.c  | 523 ++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 243 +-------
 .../cadence/pcie-cadence-host-common.c        | 169 +++++
 .../cadence/pcie-cadence-host-common.h        |  25 +
 .../cadence/pcie-cadence-host-hpa.c           | 576 ++++++++++++++++++
 .../controller/cadence/pcie-cadence-host.c    | 156 +----
 .../cadence/pcie-cadence-hpa-regs.h           | 212 +++++++
 .../pci/controller/cadence/pcie-cadence-hpa.c | 199 ++++++
 .../cadence/pcie-cadence-lga-regs.h           | 228 +++++++
 .../controller/cadence/pcie-cadence-plat.c    |  23 +-
 drivers/pci/controller/cadence/pcie-cadence.c | 138 +----
 drivers/pci/controller/cadence/pcie-cadence.h | 436 ++++++-------
 include/linux/pci_ids.h                       |   3 +
 23 files changed, 3110 insertions(+), 777 deletions(-)
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


base-commit: 37816488247ddddbc3de113c78c83572274b1e2e
-- 
2.49.0


