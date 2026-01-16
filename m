Return-Path: <linux-pci+bounces-45002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A7CD29A8F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 02:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D0CB304C2AD
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1CF3112BA;
	Fri, 16 Jan 2026 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tyd3+ssO"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB718C02E;
	Fri, 16 Jan 2026 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527740; cv=fail; b=JstnTuDKyeOcLwUTjS/IcqIidLoHtbord6/Y+xwBTg4FOzn+S3gr4V4tJ38NmwQH0MBuS6mYRTuALKz4bP+Et1XmWQUKUbFme5VM0Pv94q/EHfXa2BKnJ7Stcoo0+1D1oMLzwtRGaH9cFkZiyNB3P/gsnSpjMG0wuk7KFme8ySQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527740; c=relaxed/simple;
	bh=Ut0nKdo7cavhoHp+MWFDPxy5O/dXKh0YrXzpJoXCyRI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dlUXkwhcaRqrjfsG/uB+z3ndrF3sftNsrSf16J6aFpbajHbX+TnjJjL5tD1pii1V/lBlJpgDm1ZcO1dRG8awSY7rcnpBy6Kmiq1OXF4F849ly32l9KWxzUNURt/6t31BjMgurJnrqyNbI/u+rIMlY8CNhLVQMiADfUsPc4lSKng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tyd3+ssO; arc=fail smtp.client-ip=52.101.193.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3mH8Dp6SqTysgnHVhrWc23kAYh821Dbk+TncekEjhBeaSApsE5vRgpF1epe6BjS4ijixrBUj1AbzvA4pDzCFmafo3oZGo4/apOuqUEE45cHU3RNR9XpzZ/LMKpzX3ebW+TIRf7UL5xkEeCKJR4hesh9fiwj8O/WMzZaHinVLENKDvToxWwQN/op1yuUj6vGtwp5WGtSyec+5U5onKczQDeBXVLaBtzzFkbYPhYSM0Lk1U7FfdGbeUKiGb65qf3z9Lz2MplNRSm+XVg52BTH9AVLGL6NZ0C/+/1dOeqiB+8SKzHuXYPHgHYlNfu6pLbTEV2tRtd9ktgfacXP3Iuxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp8cM0qavb+/R0cScmOhNRozsDZZN9PinvqfbEkYoBc=;
 b=D4B5dX9YgWXqXweGZicTyDkoDHJY2vbHUWJQ7v1f3tyMib/qTIV4nC4+IuKQeSUF2DPgRNcaaKzQQb7/cu2z+xJVpnZh1xh0SDmjUw8i3l6mlCPBgm4WgKgUisQlpPCNnYwewShMLdkHVGxL5ttK0X/j0jkWEGvSogdERlDEouVv/33jZ8fUgrY5RD41n4AHhDNRkv4K0jVUaskETcX0vEhrDUp7TA5KLCV7554Vnv4SxizHpIawFj6JTVoEMjOROdiI7YdcHlFOJxh8MbjJBtEPZJXhu8f7vKxozRjoVesycF+Z7U48HKVm7QEcSqKTJ5sXiPunCvpiBirLqBGJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp8cM0qavb+/R0cScmOhNRozsDZZN9PinvqfbEkYoBc=;
 b=Tyd3+ssOTWefLeUB7DInPjk89nwHD5bdDrJyABO6Xp2B0X4drRlq9loEyVOrxTIIZdgGAYvpawCoQQQZBNLaMc4WkqXQpNYCFuGypQBfnfzgMmtHLYbFXB49dyKoS9PZKTFiYLa/z5dJkdXP5cqEb6nOnMzAygr23wobM0qxL/hXxbso3wFrcFkd1ME2724uei+2ftXenYPlwvNQm62jhRGi0dQ+mcmqdfzN/nB62ODd2kddVbNJSTOk6qvZgVmJGY9EKEn6rXKjcHDEQfAtGrZEPB5sOEpRCdsuzjuXx6klE0DGQE6axtrm47j66vPD81KsDPto0xQU1+SU2M2a/w==
Received: from MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::13)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 01:42:03 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::d0) by MN0P222CA0003.outlook.office365.com
 (2603:10b6:208:531::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 01:42:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 01:42:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:41:49 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:41:49 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 15 Jan 2026 17:41:48 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v3 0/10] CXL reset support for Type 2 devices
Date: Fri, 16 Jan 2026 01:41:36 +0000
Message-ID: <20260116014146.2149236-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 032cc7ea-f5ff-4a76-95ba-08de54a072de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q6xa2aaJXuJybego9tYgSx+qB/Ah9Pifredhed9lGvmumLklblAWca2Wm0i3?=
 =?us-ascii?Q?45+BhALqKGfnChF22jMKTFcpRIlQqBKv/2vndrzxHGqxoHvD45kaYhZ6ahjx?=
 =?us-ascii?Q?lTxRRxxrMcmt3Z/Mtqk2X/yy02d1s9V9w880tMqi1bY5giSQuTWjEkKmNfHS?=
 =?us-ascii?Q?WJI2/NR8+wbvPpsBIcfsBiZ4lXicer8nvRIKlTWqWbfo2eVbenqT2KoJJrqE?=
 =?us-ascii?Q?/SiaPK0X0HCDb+I50L0FEJECWkC1ine+WSRUSi5iv1dMDzhzAQmUvXHTNq1W?=
 =?us-ascii?Q?l7A0S4undwelOZ7UXyjwbpaqDG2szOxSceXBcRaFCemDecQwwwCv6Hhc1+h8?=
 =?us-ascii?Q?+aRahwsV000/iODbyjXSsWwsTFQnDKT16bsleDznwUnqMCbHaRJYlXhmPQCB?=
 =?us-ascii?Q?hyr0xGu5mLN5/dqPOjX2Dt32OYaBeLiZYBt79/ZSjADn5t4JxGV7jfpWc7ve?=
 =?us-ascii?Q?kavr+5PIBygUrVx6CCSfTXtXqBb0vsiY5DI18+ZQ/5XmLE8KLRJFjt39g5gx?=
 =?us-ascii?Q?rN9y4FdPjatMPxnGvXUV1OB4vmzxRmliiJfgpBdQ5Azc08VtePPTya594ybv?=
 =?us-ascii?Q?5gkweNToKmFdPbZV3sj8OaSczBCjvvoEHyFw/ix03zT16HEpNPwKt+gaeqtx?=
 =?us-ascii?Q?+QDNe1LMC7NQcKUI9a4Hi+BPfS3TjeJZ+mDPK/fD387p5D/7UvphAzuUdcTJ?=
 =?us-ascii?Q?EKaVHkFXgUVYqAzNfhT5T1bGgZEAjPXZS9kryPOzrThd5jDMOOoOd1BgCat5?=
 =?us-ascii?Q?/sYomHCdS3VuLTanxx7RAxjVZJN7t4R3Xxzzu2NkBPct6+ROo5V0GnIL8myj?=
 =?us-ascii?Q?esNERFNiOuBApidljtbuWexW5jukrfjMIVCTgRbS7VqJHBnfE1QDRmdIsPZt?=
 =?us-ascii?Q?UMCcCr/iHZPJdJxQD/rDnpGgEYsh1YT1GUE1QCeVus07gJzW4E4RIFDI8obj?=
 =?us-ascii?Q?7WJ896eFYfdFLS3gyWdcDfZ8CQ+G//qkC/YNrLwX2euo14C5w5AYzjG9s9VQ?=
 =?us-ascii?Q?+zvL2SS8ie1ZMgG2sX5YNLQLwr0MRnrX2+CW9nGwVT7gfFohoi10oehkmhUU?=
 =?us-ascii?Q?FKlZpb8qqZ0U0sRwOANytY72jphbkV3G+HM0FFFxZJmgWHjW9q1H1vHJgeMG?=
 =?us-ascii?Q?yZBP+Mq2upAuk/pocs+Agr6Y2natjFwZPGqMieeVy0Fav+EYON/s+e/fNOxh?=
 =?us-ascii?Q?Yx+20BtnCGOivUhrrKv4b8rdsnaL/ue+g33USBhIleU3/JVtioa22kZUarv8?=
 =?us-ascii?Q?P+hHfmSI/NacCXk7DUBRYkgtS4obcxcRel3z4CIYatDKL9DeDCHQoFAeA/v8?=
 =?us-ascii?Q?X6DbNmPsUzTMagfVtIROJ9x6PBXVgOdYHId6+UY75EYXwVTLugFhoBpSmslZ?=
 =?us-ascii?Q?RBBdlCL3HnkYCTU5nT7ZaRPvig0EsiSULM4tlHz5VUP6u84Ky/HN41zPePiQ?=
 =?us-ascii?Q?UDxL2dxVJ3vA3cb5SVFK8FI5Y7od2FArZolRbEh4+S7nD6WNjpXd0RzBPbTN?=
 =?us-ascii?Q?RXFgNJOZVjJ1Pfv60qT+lc6xLd0SnjnqB4L6xx/WNQ/qJtkBZf+vk2mrVpru?=
 =?us-ascii?Q?BeWPBKp7JMNgHQSVfV5ZIY+Zk1VDhMJwg9pX7xUWBmc8Q492l+c8yFZqmEC6?=
 =?us-ascii?Q?Q1GV0jC76PfDMGm3ElaeQE4s/pJPo5eEL3LwPxro4LBS8tJORL5cZdF3I69Z?=
 =?us-ascii?Q?A0ZFjajO38acyFPeFWW26cG4qrE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:42:03.0025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 032cc7ea-f5ff-4a76-95ba-08de54a072de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449

From: Srirangan Madhavan <smadhavan@nvidia.com>

Hi folks!

This patch series introduces support for the CXL Reset method for CXL
devices, implementing the reset procedure outlined in CXL Spec [1] v3.2,
Sections 9.6 and 9.7.

v3 changes:
- Restrict CXL reset to Type 2 devices only
- Add host and device cache flushing for
    * all sibling functions on multi-function devices
    * all sibling devices in a given region
- Add region teardown and memory online detection before reset
- Add configuration state save/restore (DVSEC, HDM, IDE)
- Split the series by subsystem and functional blocks

v2 changes:
- De-duplicate CXL DVSEC register defines under include/cxl/pci.h
- Fix style-related issues

v1 changes:
- Added cover letter and dropped the RFC

The RFC patches can be found here [2]
v2 patches can be found here [3]

Motivation:
-----------
This change is broadly useful for reasons including but not limited to the
following:

- As support for Type 2 devices [4] is being introduced, more devices will
  require finer-grained reset mechanisms beyond bus-wide reset methods.

- FLR does not affect CXL.cache or CXL.mem protocols, making CXL Reset
  the preferred method in some cases.

- The CXL spec (Sections 7.2.3 Binding and Unbinding, 9.5 FLR) highlights use
  cases like function rebinding and error recovery, where CXL Reset is
  explicitly mentioned.

Change Description:
-------------------

Patch 1: Move CXL DVSEC defines to the CXL PCI header
- Consolidate DVSEC register definitions under include/cxl/pci.h

Patch 2: Switch PCI CXL port DVSEC defines
- Use the shared CXL PCI header in the PCI core

Patch 3: Add Type 2 helper and reset DVSEC bits
- Add helper to identify Type 2 devices
- Define DVSEC reset/cache control bits

Patch 4: Add the CXL reset method in the PCI core
- Implement cxl_reset() method with capability checks and reset sequence
- Restrict to Type 2 devices

Patch 5: Add reset preparation and region teardown
- Implement region validation and teardown before reset
- Add device cache flush for all sibling devices in a given region

Patch 6: Wire CXL reset prepare/cleanup in PCI
- Call CXL reset prepare/cleanup around the core reset flow

Patch 7: Add host CPU cache flush and multi-function support
- Add host CPU cache flush (x86: wbinvd, arm64: dcache_clean_inval_poc)
- Add device cache flush for all sibling functions on multi-function devices

Patch 8: Add DVSEC configuration state save/restore
- Save/restore DVSEC registers (DEVCTL, DEVCTL2) with CONFIG_LOCK handling

Patch 9: Save/restore CXL config around reset
- Save PCI and CXL config before reset and restore afterwards

Patch 10: Add HDM decoder and IDE state save/restore
- Save/restore HDM decoder and IDE register state

The reset sequence: validate device type, check memory offline, tear down
regions, flush host CPU caches, flush device caches (all functions), save
config state, initiate reset, wait for completion, restore config state.

Command line to test the CXL reset on a capable device:
    echo cxl_reset > /sys/bus/pci/devices/<pci_device>/reset_method
    echo 1 > /sys/bus/pci/devices/<pci_device>/reset

[1] https://computeexpresslink.org/cxl-specification/
[2] https://lore.kernel.org/all/20241213074143.374-1-smadhavan@nvidia.com/
[3] https://lore.kernel.org/all/20250221043906.1593189-1-smadhavan@nvidia.com/
[4] https://lore.kernel.org/linux-cxl/20251205115248.772945-1-alejandro.lucero-palau@amd.com/

Srirangan Madhavan (10):
  [PATCH v3 1/10] cxl: move DVSEC defines to cxl pci header
  [PATCH v3 2/10] PCI: switch CXL port DVSEC defines
  [PATCH v3 3/10] cxl/pci: add type 2 helper and reset DVSEC bits
  [PATCH v3 4/10] PCI: add CXL reset method
  [PATCH v3 5/10] cxl/pci: add reset prepare and region teardown
  [PATCH v3 6/10] PCI: wire CXL reset prepare/cleanup
  [PATCH v3 7/10] cxl/pci: add host cache flush and multi-function reset
  [PATCH v3 8/10] cxl/pci: add DVSEC config save/restore
  [PATCH v3 9/10] PCI: save/restore CXL config around reset
  [PATCH v3 10/10] cxl/pci: add HDM decoder and IDE save/restore

 drivers/cxl/core/pci.c        |   1 +
 drivers/cxl/core/regs.c       |   8 +
 drivers/cxl/cxl.h             |   4 +
 drivers/cxl/cxlpci.h          |  53 ---
 drivers/cxl/pci.c             | 621 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.c             | 146 +++++++-
 include/cxl/pci.h             | 134 ++++++++
 include/linux/pci.h           |   5 +-
 include/uapi/linux/pci_regs.h |   5 -
 9 files changed, 909 insertions(+), 68 deletions(-)
 create mode 100644 include/cxl/pci.h

--
2.34.1


