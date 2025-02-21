Return-Path: <linux-pci+bounces-21961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E010EA3EBE6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 05:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F389F19C4E01
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 04:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0284A1E5739;
	Fri, 21 Feb 2025 04:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tfndnOgS"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3FB1D7E4C;
	Fri, 21 Feb 2025 04:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112789; cv=fail; b=HEItuu2jXo51v2m/+PTyF/kzfDHTEPyid4gg7zr3/DIy84AWkzvAOZnZxtFrnw6rwSuC7CEU0S8o8VV8hsgDvQrUKxz6NcyW3XgJMVlRQv8+ogLIvc20aO4m4KUeaafBm6gv695YSZvUBmIAxbXQJ30629oILywXLdrrgrDHyjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112789; c=relaxed/simple;
	bh=bq/Zx1YhmFk9D0mjZ0tcRW5mb5Erxhy1iFFbhPiaMNA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IEtgGeKRl7v4u5/bWfaHcL/MAgLOev6mNbsXru+Ukk4mwGOhmPpFbMd2qqlilx6J1aYqYm2pNMqjjyrdu6r7KamiNa28KRnYc3SR6rOpK+0msLeYLEOEEXur7i3W23gMAoQdGuNFkkwlKQ1+Dey8aySEmcMo3CMtKjM+9VKLpUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tfndnOgS; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxibgGv23vfXGvk8c/Uxd1aWlP4XW0EaSBD6DqJHbK1cCHhiGGjWETuIs84YPHjhCd6hDGimauz9MLPKZQnXZCUk8RF3j/lUG4pq8OgLGvHRHEZsTP6WT/q3zQObDbaJNmh4HSyWtjttn5DwsJxQUnQrogP0Zwt8Eo7n8FxIv0mbpTTlNx6zbV8d2SvOkPRwymlxDutEns0+b2ifFqdJVb5Z6LnUhCvf0PHN/8fWqPRnm103AcphKU7vkXERef9ZNpD95z+QLOVQAVmxxYa+4Js9M9QEySP4PV+iW2z1itfOFVwlYvM5NsIPZx9oxBmfhJjJuwrWRp757im7pZRFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXjFEySlCl6t6FZbUKKPS13FByFAdsfUVXi1jpofU2M=;
 b=WntvJJ3NeRyNnWM1WSodzU8ZVg32QN+Sl95t3UDkq8GHNAEIXPSPlSmusur9t7UnsAa5Togn5+ZQykmGCRejBl3/QvE9LuAZloaWKEVF2vzh9BYVhE/6R3JTp8M2/86DoF8KU/UdjfOvgcu/2MIMn1w0RMKFAOdGurmbU7GBVLJskl4nEdWrwhp4LjyXLvihngt9w4iiu0m2kugYz4RfiugBzzLuFHADmVfzDpD5iQwgL6sU4477Xp1jzwANzpzV7hcMKOkzCmFjhR+V0Mf8y18wrnDdDhz3Zss802RX8YO/fb2ALnNbx7UYedMFj3WJHQnuHueEdHr+wpvohaqe6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXjFEySlCl6t6FZbUKKPS13FByFAdsfUVXi1jpofU2M=;
 b=tfndnOgSqiJWxyd2gicIpDwnn6b08yOWpJx1TgZBxQU4Wo+fWPABV8cWu1R0Fn1+R/kjVHhNODsvWg8D4fMC65r1IxinA3HIkZZHYc8IermHBo/0pYRJBVeNYtALTnlZxlwFZ4Fv8Q57T6aPUU8OtvFs5cu2VdtKvSmX4fxTRslCDOiIDWF3TG3JUNEygJt2me0pQIhh4E/NYoRWW8NLXqgzBWx9n1Y9QsuFgl0q37TIcUD91FYWCWTX+rO7jAugoxNIB/49vziBi2a4V4gCG7ZMb56IY8LhdwxrxzYPzo1yIanUfxBqtQ5+WONWj2pDvfaTn5tMGntxKQn9+zmnew==
Received: from PH7P220CA0074.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::6)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 04:39:44 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::7b) by PH7P220CA0074.outlook.office365.com
 (2603:10b6:510:32c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Fri,
 21 Feb 2025 04:39:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 04:39:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 20:39:30 -0800
Received: from 181d492-lcedt.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 20:39:30 -0800
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: Zhi Wang <zhiw@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, <linux-cxl@vger.kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2 0/2] Add CXL Reset Support for CXL Devices
Date: Thu, 20 Feb 2025 20:39:04 -0800
Message-ID: <20250221043906.1593189-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 715254a6-d3a4-4a1b-bdb3-08dd5231c36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oTLA5PNNULlRGuxGqOHNFJy3oKF6bMrxVlq7cSd1FKZQsCv7+tBhlfT6wWOa?=
 =?us-ascii?Q?iGcBuolB+miRYCPEILFzPUHty7zdMwXaFPKS/S/NI/dlEoYoddrTgL6roNyg?=
 =?us-ascii?Q?nnNODSWMYZMwdpmcN/zXn13+LKcyZsz1RVHr184dbeAZZKIO/1N0XbOynsa5?=
 =?us-ascii?Q?7wUsVDq9cj7EGKv3Fdzdst75rEEMW+8F66W7AbVXRgZCheWBksMwbmYJBCuj?=
 =?us-ascii?Q?/xBwJcWGJpVNUEKH9Vcf/b/l8MVJ4W7O5uceva4i5G752FCr+8LgQpWuVRlw?=
 =?us-ascii?Q?lsuvAs4VAL2upQPYYZWJjyCDth8yrHh9wj6g+tWQFfJLPah6bYvjE02vu/L2?=
 =?us-ascii?Q?HIgz/yjH8cWdZ+Z47wSYsoaBwYG1eZkUxJN4mfmgpgATTIt8nv9wfmx7HDTJ?=
 =?us-ascii?Q?/Zm6vKePsuyddj78MYq/L/NQh6CwDgKJRZmIZwwD3U6ubAwTaUYQOm1/LEDw?=
 =?us-ascii?Q?UMVvxcSAR5n3n0/P72YAjYA4NonU72f+I8KjZLk8zcv7lQkTdq+P3pmxJ8Mc?=
 =?us-ascii?Q?RNSnrVoZ0PQHSQxWVu2gB8MNxIlJvzorO/NmQ49oMDT9B4S9RoLQJFmNpE4A?=
 =?us-ascii?Q?N0skU4cYpjHyX6c1CS2ZWeNWjIuKr8veYMX3PjoRS+91unQeaGZdCGGslBIt?=
 =?us-ascii?Q?Ect0b+5RbTPCukeWahIgKgd3Dj7B0VZWHtYwNRDvzVA+k1mlPW/uJQ5R4dU2?=
 =?us-ascii?Q?foB1BkRhbsijxcyXLvjUoUMfxO5tMPaSSG+ZoEMvc2w5dSI46rrYczm9KxvU?=
 =?us-ascii?Q?D/KdzOSJdtBG6ceZh/CZPVrROxi1NYlO6/eG9boMA8kdT7m1WU+5BscgGL4W?=
 =?us-ascii?Q?r/eTqF7UPZYpprM+kDSfKTGMNWm+nfTaEEhcuzSfpK8xYiT91fBxi+D4ZWRn?=
 =?us-ascii?Q?L3LatJcGHZ0K/atFcj68eGyf4vWlOJP41o0xRuAZrxJbpvFE2VdF9j2mNPDl?=
 =?us-ascii?Q?jgpyPJO7NRFAcF6SN/hdHj3vVfTlI4KjRsdMoLkMXALBvE+B6oXEZV6M11eY?=
 =?us-ascii?Q?pIFBuY6pcuOI2ku3XeauEQ2H3+eI10H4p/AxKTmpYAiWaD3SwIkyy+2nVmsr?=
 =?us-ascii?Q?30IuhN8QOxoKU6dilvNobLn81IkdyY/qbR3GFNUhqFWbS96Orvy0qMjs5Uck?=
 =?us-ascii?Q?HTjxiRd2gJ5CP4RTcThbfwLUWpN3cjv1R0JNA7qmpIbVK+MR0XRDIgN4dmAJ?=
 =?us-ascii?Q?o4yY9Bfg1JWvs8yfMRBPi6a7MsziTl+x3SO/rVW9GmzCa3ohuBdgSX4JSfv+?=
 =?us-ascii?Q?nbixLhZNI9IZcQPcIfXGpKAahZKuLag+KrWBZbf5+66wO7kIOCqg+zuCNay1?=
 =?us-ascii?Q?1SRmJxXJqRY6S3fJGC5+I7hyifR3O/nd9jDRhSa0u/HlT7K5Jp8IVfkxssZV?=
 =?us-ascii?Q?z4/gXZ5kk98u7e2oKOReJ1cZk3AhPVT0bcU+id+5EHAqtFWwCgUx/bFY3dMC?=
 =?us-ascii?Q?X0dJ2eIxixeVgB3rZ9siv2Hr6UoOyr/28/ioteMrbWRoLWJA44F7iI5XS83I?=
 =?us-ascii?Q?w8xZ4AOgjtp4JDU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 04:39:44.0499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 715254a6-d3a4-4a1b-bdb3-08dd5231c36a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266

This patch series introduces support for the CXL Reset method
for CXL devices, implementing the reset procedure outlined in
CXL Spec [1] v3.2, Sections 9.6 and 9.7.

v2 changes:
- de-duplicate CXL DVSEC register defines under include/cxl/pci.h
- fix style related issues.

v1 changes:
- Added cover letter and dropped the RFC.

The RFC patche can be found here [2]

Motivation:
-----------
This change is broadly useful for reasons including but not limited to the
following:
- As support for Type 2 devices [3] is being introduced, more devices will
  require finer-grained reset mechanisms beyond bus-wide reset methods.
- FLR does not affect CXL.cache or CXL.mem protocols, making CXL Reset
  the preferred method in some cases.
- The CXL spec (Sections 7.2.3 Binding and Unbinding, 9.5 FLR) highlights use
  cases like function rebinding and error recovery, where CXL Reset is
  explicitly mentioned.

Change Description:
-------------------
The patch implements the required steps for CXL reset and introduces a new reset
method in the pci_reset_fn_methods. It also defines the necessary CXL DVSEC
register macros. The actual steps for rest are broadly: disable cache lines and
asserts WB+I, wait for cache and memory clear signals, initial reset, wait for
complete and return status.

Command line to test the CXL reset on a capable device:
    echo cxl_reset > /sys/bus/pci/devices/<pci_device>/reset_method
    echo 1 > /sys/bus/pci/devices/<pci_device>/reset

[1] https://computeexpresslink.org/cxl-specification/
[2] https://lore.kernel.org/all/20241213074143.374-1-smadhavan@nvidia.com/
[3] https://lore.kernel.org/linux-cxl/20241216161042.42108-1-alejandro.lucero-palau@amd.com/

Srirangan Madhavan (2):
  cxl: de-duplicate cxl DVSEC reg defines
  cxl: add support for cxl reset

 drivers/cxl/core/pci.c        |   1 +
 drivers/cxl/core/regs.c       |   1 +
 drivers/cxl/cxlpci.h          |  53 -----------
 drivers/cxl/pci.c             |   1 +
 drivers/pci/pci.c             | 163 ++++++++++++++++++++++++++++++++--
 include/cxl/pci.h             |  76 ++++++++++++++++
 include/linux/pci.h           |   2 +-
 include/uapi/linux/pci_regs.h |   5 --
 8 files changed, 235 insertions(+), 67 deletions(-)
 create mode 100644 include/cxl/pci.h

-- 
2.25.1


