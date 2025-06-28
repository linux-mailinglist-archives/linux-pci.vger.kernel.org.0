Return-Path: <linux-pci+bounces-30988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C788AEC59E
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 09:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5EA17AF5A
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 07:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D5D221D96;
	Sat, 28 Jun 2025 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BsPQBfJU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3648E221287;
	Sat, 28 Jun 2025 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751096587; cv=fail; b=EegZD4GOMkWypa2zyXmlBJvjzOSm9XUw9annYDLWvlY8ude+U8J+gdZKgTDItL4am5BaSj/xAl5vjScVNDVhvltk6LzW/pv5ODHdiZU9N0iiEdzX8OqdttWDEES5Jq7sCgCkKXcXIjAwDPinB3er5Lani4YJl+qeLSdBnmBu/zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751096587; c=relaxed/simple;
	bh=M7iu8DCHwioAp/RRzHanjR/uA6ArCnWkWt3/0owg7ro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UvM3ybY495jQ0fdl0Z2sFhAU+t9aQU3SgvjX4gt57YQkKoMZV7kEfHeZq/N515JptAcX7Z5NDwP2oMhbhfvJJ5Gvco7z01q36KlY/rado6CoP3SINm+toet6ZMuzgfNMgw6m0hy/Tin8/bspXvfecrVq5297lCRJx7yzoifCvMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BsPQBfJU; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejJl/NV4nYgvTJI1QFBMk4HtJz2awCJPj0kshRMYaIi5U7jPVVg1ui7ViRxM6+q3vhLpA4OtyBtNAn2wLQ36ZTZ208NUOhJKyojhglNGc8leljua5QSIK/3JLpvu8ftRJlUsW30csxRErEjWBTner941gYM7uus6O2oxDAMwSxMsECsIJH0GAiNNBsV2sRsO/ugSlWSHzjePluAGiWOr3kkIBtkT7exPxjlBbgmjPCwwoQKVabQCt9poqv8V4eiSNx6ONyil0c3CrUBkEvBGN5Re29NHVCMm9MrxOIZjSivRPOR9GXh+KXXB97o8Vfij0yPzzoCET0v66uWhZtEDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe5YoIMnhSn0ryAzY4tnoT2egBwVBeduWcJSH8BonIA=;
 b=UYSTTWrx28x4hHgi5oqA06fbUNXyTjOzuuJB/9JpiqSth6vGle6FRr3AO9pmbnZO5d+Ju5PzVO2FdraMBy+xj1X8ahs8BjN3kKfLRVQz/aZt+GnQ3LAKKYKjYqnDqa8haw9V6ADjUZl1/NqnDl7GQR+/sJlhHBm7VEx7f1flCTlhcSPMug2GFtqjAO82pLNxUqPKALHm8A1UEATp4jN9+7LO579csn86LOXsX4Awp4AulTnXDD4L4sGrNrXbCcFlYwm+S3IDYrCvwOnJKtOfYgYMCnimsHlr6XFZlEw5XLdLnDwMLbk97IdqUuiBMlqCVBUM9ZbYd2BWEZ758UkxXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe5YoIMnhSn0ryAzY4tnoT2egBwVBeduWcJSH8BonIA=;
 b=BsPQBfJUVJY/jjc9RKVXhSWjr0y5VsRzojJrdLA9c1MrBehC/X30bOV9c5Rn2iFFkpcqL9mVFcQnUpC/iNVuTKWEbzx+iMq4BMZENOnwF3bN6EWKyD8d5DsAJ+qrPnYSB99vUqB29si83Z+AlzCsOITfz46BZiJASjf+wE1ua4UfFdzBKYNhaoABhHpMAH+Asvq/6dXA4hP6M+OyLtZfNy5iw9AS+wJIos8QmaH/+NLylL9YRccczHmGSzxM2fGXRcQCf/ndPPs0jDCs+443j0HKQeECCfMdLwLda1leMP+DTtx+mDAZtYs6yV2tXvTSnHltLIMfLJIV6+ANj4DMHg==
Received: from DM6PR14CA0039.namprd14.prod.outlook.com (2603:10b6:5:18f::16)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Sat, 28 Jun
 2025 07:43:00 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::1) by DM6PR14CA0039.outlook.office365.com
 (2603:10b6:5:18f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.25 via Frontend Transport; Sat,
 28 Jun 2025 07:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sat, 28 Jun 2025 07:43:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 28 Jun
 2025 00:42:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 28 Jun
 2025 00:42:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 28 Jun 2025 00:42:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH RFC v2 0/4] Disable ATS via iommu during PCI resets
Date: Sat, 28 Jun 2025 00:42:38 -0700
Message-ID: <cover.1751096303.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 03694177-c193-432f-9c75-08ddb6176848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DrzfNei+D5NqVzHbg07V42fY7rTc34xpZ6SHhQifM09UmnK+53CCIeNZbb+M?=
 =?us-ascii?Q?sY9+/RhA9iaNt8+tiKtxbywndlOD2q3x5VHFTJE8wyX5I6/OL+Qpdc/L/8l+?=
 =?us-ascii?Q?U9b+0uGNJY5KmnoXQT1FxXm+TIkPlvYNC9FsG6Xf4wTmYP6/4QyXEe+PEciR?=
 =?us-ascii?Q?Bsub6ijVN5GkQr2iPw4iDviQriRwv83StPQpD7pQwP+1+DPpux8yNXOtOsuR?=
 =?us-ascii?Q?6o1+cZF8WCulKIQOg5XvNOygiPuFeWtJFsqfI1aNdnsY3lFaEFCQLb7Dnecw?=
 =?us-ascii?Q?z/qHF5q7EWOQU+ugNwsNfLbraC/mxd79LvXDvqXUBRZELwotKuO30VpmGL9S?=
 =?us-ascii?Q?5RqIZJL03WMW+uo2BGA1A4t1rN6VxmxJhiToc4gYoEIv9ohQ9L2gEUvsdNVu?=
 =?us-ascii?Q?pn3STcM9YIN1752S/0UyFvtLW5t7PDXGA+YnIdU/+43thSRZkHcVd4foLx4v?=
 =?us-ascii?Q?uI9ULWTOhHJYwtXS6P4tb7+ZabyLqp4Omi/GHZHKftE/Q0KkaR8tvwvO7WC3?=
 =?us-ascii?Q?YYxUQCJPv0VE1PzWtItP7ttHXyx+80PVAyK8LhN9uYBRR0XfOCy6slEK/mJg?=
 =?us-ascii?Q?8QMuhYhDfT+ftdJfXY1C5Ous6wOTwZdtiH4Mbcb+A1giKlYepAUQ844eJTzo?=
 =?us-ascii?Q?U/GWht4t735YrT0iN1YF79vcMR75CyO9SgHJqx+CPtblN4rimexgoDNucnBw?=
 =?us-ascii?Q?eHyTJv7QpZ2jzGqf4E6nH5iaeMhc9Y9rsj7/Cku4i5uQrTdCYTZuDEpbCcb5?=
 =?us-ascii?Q?X8L6QBubQ6rUWylhRhH0Eacg9LZODg7f9niHvOegwM0wKSTDiyqs/83boSQ1?=
 =?us-ascii?Q?PDMUuQnSyLT0QP0xuMO35SCIZ334hVDEZoFxadDuLQMHlUSVBcJsE1m6sqxs?=
 =?us-ascii?Q?MGyBVWf8eF8Ue6HYwQJx9eiCTn1r9H37Jo00fc1Pz2PFJnv/N8lMwdPDDFG+?=
 =?us-ascii?Q?R7XYOVxh+qMAmwr5MQ3BeGK4K9CTGjPIsEbXcy1zXPXVlzHjAqCnwTZUE1hR?=
 =?us-ascii?Q?6sjZT3aTwG5r28NZqbmObMV8n0ytAnwuQCqx+F92gyA2ZKB2kvHNST85H9nH?=
 =?us-ascii?Q?doXEsxn+17ARJVHed+Hh/TFQVblnoGqd5X3c4LpGEaJCHMFLwtkXRJ5Q8FJW?=
 =?us-ascii?Q?JysbdhgF+DDqmlTJjeRvaY5n+RyfXophmov/GAVzctKUq2p7DzZ2SQ0ouWhz?=
 =?us-ascii?Q?es4A7f9SVDoyeP1rKiKGi+ZuwKVkJ4yRcX87iXQcTeNeM6p3Iq8wfR9ju1EU?=
 =?us-ascii?Q?QNUy5TD+1+9a0GyZM2BMHkwhuehdUhp48pseBlM7cg9Cbx4dXp0dlCSfnn5q?=
 =?us-ascii?Q?lh1lEossE+Bhciyb09aIx/3oCCpaDfGFvAwoUfQOSLI9xSOoSzjxpZ8609H7?=
 =?us-ascii?Q?GEK/slLUC5jPoO2aRG0RSgO8tszY+ZQV4huAFf2ffoc2dj81W2n2spEFhEF3?=
 =?us-ascii?Q?i2XtxWJRVDRkJKkrVDbENJ07FIelKxFX/R0uGU2JytFbt38H6oBrx6Tv8qCO?=
 =?us-ascii?Q?96Wsiov4fWG0ZY9qPUOtQKUcw91n9SxVL1ARCBNO2SEgGHscUXHebKPZUA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2025 07:43:00.4966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03694177-c193-432f-9c75-08ddb6176848
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616

Hi all,

PCIe permits a device to ignore ATS invalidation TLPs, while processing a
reset. This creates a problem visible to the OS where an ATS invalidation
command will time out: e.g. an SVA domain will have no coordination with a
reset event and can racily issue ATS invalidations to a resetting device.

The OS should do something to mitigate this as we do not want production
systems to be reporting critical ATS failures, especially in a hypervisor
environment. Broadly, OS could arrange to ignore the timeouts, block page
table mutations to prevent invalidations, or disable and block ATS.

The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable and
block ATS before initiating a Function Level Reset. It also mentions that
other reset methods could have the same vulnerability as well.

Provide a callback from the PCI subsystem that will enclose the reset and
have the iommu core temporarily change all the attached domain to BLOCKED.
After attaching a BLOCKED domain, IOMMU drivers should fence any incoming
ATS queries, synchronously stop issuing new ATS invalidations, and wait
for all ATS invalidations to complete. This can avoid any ATS invaliation
timeouts.

When a device is resetting, any new domain attachment should be deferred,
until the reset is finished. The iommu callback will log the

However, if there is a domain attachment/replacement happening during an
ongoing reset, the ATS might be re-enabled between the two function calls.
Introduce a new pending_reset flag in iommu_group to defer any attachment
during a reset, allowing iommu core to cache the target domains in the SW
level but bypassing the driver. The iommu_dev_reset_done() will re-attach
these soft-attached domains via __iommu_attach_device/set_group_pasid().

Notes:
- This only works for IOMMU drivers that implemented ops->blocked_domain
correctly with pci_disable_ats().
- This only works for IOMMU drivers that will not issue ATS invalidation
requests to the device, after it's docked at ops->blocked_domain.
Driver should fix itself to align with the aforementioned notes.

This is on Github:
https://github.com/nicolinc/iommufd/commits/iommu_dev_reset-rfcv2

Changelog
v2
 * [iommu] Update kdocs, inline comments, and commit logs
 * [iommu] Replace long-holding group->mutex with a pending_reset flag
 * [pci] Abort reset routines if iommu_dev_reset_prepare() fails
 * [pci] Apply the same vulnerability fix to other reset functions
v1
 https://lore.kernel.org/all/cover.1749494161.git.nicolinc@nvidia.com/

Thanks
Nicolin

Nicolin Chen (4):
  iommu: Lock group->mutex in iommu_deferred_attach
  iommu: Pass in gdev to __iommu_device_set_domain
  iommu: Introduce iommu_dev_reset_prepare() and iommu_dev_reset_done()
  pci: Suspend iommu function prior to resetting a device

 include/linux/iommu.h  |  12 +++
 drivers/iommu/iommu.c  | 180 ++++++++++++++++++++++++++++++++++++++---
 drivers/pci/pci-acpi.c |  21 ++++-
 drivers/pci/pci.c      |  84 +++++++++++++++++--
 drivers/pci/quirks.c   |  27 ++++++-
 5 files changed, 307 insertions(+), 17 deletions(-)

-- 
2.43.0


