Return-Path: <linux-pci+bounces-40484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E01C3A45F
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 11:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C2B3AECEB
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 10:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66109299943;
	Thu,  6 Nov 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bIBjd9iJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8932248B4;
	Thu,  6 Nov 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424925; cv=fail; b=FzgX2cJeaTsjXq3tpnxPcHiMvum0FRiiozXVIKGagzCeKIxzlmbB+uQB0N51McpGbA9lza9E18D4We9A5l+afPheT4YnetsKtK5fiWDLfX8LCs3BOmwpG4/EnBiaYn52OqsMvg9IucALxgbNRt5vMq4SdscUYm5PUbtfIQVQjc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424925; c=relaxed/simple;
	bh=pmufUxO4slioaJ2XtjP+dPrsPcRDjxS4Yfvv2hMe+R8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGsqRRpSMMNRa9SXx5EKzvNUXDGhApjuL/eEnrfEqu5L3JbrKspTMatWCcHtU69k9SUeYjEL5/22/KUSuzOCQrYKm5sYDfysQd1ocC3yhJnEEQGR6JR445PjsqK3dRGBUxptyz7RMjQCwTg1viGagaq9cpMunTa3ZHwYWewj5sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bIBjd9iJ; arc=fail smtp.client-ip=40.107.208.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVKzNyo97xAw6ZXHNx8idMqRVB9qBe0dmnhgrzAxIy3UQSCCORTdnkQdgmd2EKrAgejswt+G+m7jzngjZejjass+YhqkvSepeXTd0xrNBOKscSVCPcWHHSx4GbB4GqN+0oWkPECvnKa2tZM0Z4+g7Eg055yxGMxodSnyQrRheq/0tDT2VDlriUi2ph87Pku5yIJptG+k0lfrhUmkV8e69iCXItwWI4WutvIZx0a2qw24Mk+8chBR64KTC+yKiGSCq/aSTOBZq6TDs6KAgPbA9EGNOsHrLy0HZke22XPyQsFGjCmuHpgr5x5dsqPKFQWJuLssVhGKdAhrbThC0+xLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHnxk5gTlMEwwObcrUO522PaSj/dgW0lDqaTDSNRIx8=;
 b=gJwSkjA9HTSYEJQ5jQXr0kqFvXRV0Ta/V5cFjTYgEh3OMxK97E8C9XT8rTmU7V2OfcgptHYGx8TEPWf2Y+7rbLFacBuKucIfCxU9YD2n/puq6NO1LxUYV0Uiu7A3vZjiIzgcH45SlYoi4ELZD8EFXrYCnhgCJJP6brgVrt2PzrxFHwdG8pnM7dzXT//IGBX+3dJIq2wvDKxmKpthqDdpBfNmK5/DOlGMo8krt4/puYVfQkcKvT+TKxlbzRB/DDiJuT3mikjn1JsVrfk3AjPvI/GsvGirBB0fb5KJ0G9MpSdCzmHLwmDFFzU7I217VPCk9NuRqIvUYbrl6Rk4RF7jnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHnxk5gTlMEwwObcrUO522PaSj/dgW0lDqaTDSNRIx8=;
 b=bIBjd9iJ8vQjBHtgGuJn8m7VQMg6iOhDW/faZYqPGPII2zV78OCwW+bhre9JnPXfLs6hsodJjEAxc7RTE7O3IEYr53nxqJFm3NVX+hRIZGUWVm0DX7zqi5HXUvIN1qy0KPqMDEdnvMujIQVZ+v1ZHQ9ogw7M/SwTsjeajuQWvlnFB7terbLEKDSSeiOc4g3vVtUXGYX6IxF5/34dGSPbUc9UPMoySJ99I5/LMyd9aYEz/tqjUTHkmzuCeKx0djzRBxZA/G7RChWFEEMRpCc3fTIISj8RzIVTnFQKTd/WTxFHg/Mfpxijq5F/GKj0s5ezxyECAe7TykBKWgZSl7HL1g==
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 10:28:39 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::7b) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 10:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 10:28:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:28:25 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:28:24 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 02:28:14 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: [PATCH v5 1/7] samples: rust: rust_driver_pci: use "kernel vertical" style for imports
Date: Thu, 6 Nov 2025 12:27:47 +0200
Message-ID: <20251106102753.2976-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106102753.2976-1-zhiw@nvidia.com>
References: <20251106102753.2976-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7bc97d-d5b0-42a6-991a-08de1d1f4017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2PGp0tRnT7z3V/w7QKS/3yormuFfc6JHpAbKVS+sIo379g1SW+kq4EWmDuXh?=
 =?us-ascii?Q?LobWKqKLNPrG8GW9wHbdd887fxNIXd+K2HvpzN5YCB2+yNDptaaHXraZFWGv?=
 =?us-ascii?Q?lKZz+C7WeZbLWcOoHu4JiMjJOT3NHXN3DwTIoyNHQptOmwistkjLwnaHvPYl?=
 =?us-ascii?Q?QX154KtJKo5kdUnhOo0CnJga/1N0Bul0ZMfov2qgfXZJ+CYDybeL//7R0jJ3?=
 =?us-ascii?Q?8JMCp/b9pTsSGky824l29mdI0iLEh9MynJSj7oLuOCCiBtEqb7RZw7mf6wyN?=
 =?us-ascii?Q?3ME37+bV8j3pqdJPuWQ/owOneNHqmpKEcTz2tjHETrBV6KGgujx/0fKkjqVy?=
 =?us-ascii?Q?Ko/JAhpXD3fUfVdiOQYslcE84vZusErchL2IWmz+fWFnD1LqCqoYbb+yNMDt?=
 =?us-ascii?Q?ZOu7r/XyCbMyPKifsG4GmuMZTsBSKz5/VpEZp22hy+Clx/xHYxXcq0B58f4y?=
 =?us-ascii?Q?4xOTFySVp8uGq1BlXacSDZfT1Ah7YcRHVZclOtvvNdLEftZdHwMu2KqkJr91?=
 =?us-ascii?Q?vGx1uZWcwjLH+GISlQ9PZGcdXC/sq4nDwbM014Nxd/jNwgZCrMVbBa7rBFTv?=
 =?us-ascii?Q?CbcmTIe+4Io3Dh3jaICaQHkdvTUUP3jR24xZry1QQwXnke5mjgsPxkgAm59t?=
 =?us-ascii?Q?Fhu9WWtgMXScDCO6s1OSRI+8gL1XPUIWpuKDM/2YkgZYKi2aSZbKMSPdYynR?=
 =?us-ascii?Q?ByXe0gsVFo/0qwLRG+PZ2nE+bZAxvR0CwI0YYAqLqdTdWpKMIXmETaduc1zU?=
 =?us-ascii?Q?VzH25PC8fAyIvvbEE7wAmiEwHu+w2tFRZh5/VMhCBz1NG39kbpNfdnoZbNkJ?=
 =?us-ascii?Q?QYW228QHNn0RzGe36hptAIh5RQ7GtZGTyDlExymD60n42EFj/P1jSAumVCqg?=
 =?us-ascii?Q?4OWyyfI9I0dpvLAClgeC1O7XmS7s4dkhFclWlG8bid6kcw+zpDOCLQwrbWQL?=
 =?us-ascii?Q?HVzTetqVZSALKTLe20oI47fBLMOT1u1zcQUBncOOnCirPp64ZFGaTr0RIMi/?=
 =?us-ascii?Q?d/gynyWewUQgFsQblXYh0RWKGxSplZfJFr/jftYH1bg3EIyaQNcPt+1SExFv?=
 =?us-ascii?Q?FCPUuHpBPrUY5DHTvESDOtNoxnCkxLsGMvYOD0CdusowLNxlAf10PPbYXdeX?=
 =?us-ascii?Q?u/88YMljhnmX2z/fEcJzyqa7jXp6ZIy0YVVAtLSsPs2al2azgm6fb9dn4jtu?=
 =?us-ascii?Q?z/4j8AMSdCnBcqSEUZpT/J/1eXBzC2r0IBTRWQVCXPNnRGI1lNZkznbNi0G2?=
 =?us-ascii?Q?Gu6cLug5hpt0/2OCyupX06eDsmNGiccrgOQphX8dLirWp6O6Y8ERp49tLhq9?=
 =?us-ascii?Q?irJVA+5DwWZbkcykUS0rmgmtmGr577rwyI1urSFJskbO2cf5zoMWZyOodAUX?=
 =?us-ascii?Q?4SFymPWkj7xF+RkyRLc4qVxXRmxvBa4dcnb+noN/AjALrclPSRDretua0azH?=
 =?us-ascii?Q?riNqCE1AdpixlUDM/F5je9T4t6YN34z1GrZ0oZ9SANIqE601s2fTCC8nUqZz?=
 =?us-ascii?Q?eP8HxtrBV6pnMPG5sqKXkXAJ/3EezX+Br9MCtnJrpPST9QwmTfX8upQujgT9?=
 =?us-ascii?Q?2IpWWx4kehCvgtqLRno=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:28:38.9093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7bc97d-d5b0-42a6-991a-08de1d1f4017
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852

Convert all imports in the rust_driver_pci to use "kernel vertical" style.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 5823787bea8e..ee6248b8cda5 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,14 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{c_str, device::Core, devres::Devres, pci, prelude::*, sync::aref::ARef};
+use kernel::{
+    c_str,
+    device::Core,
+    devres::Devres,
+    pci,
+    prelude::*,
+    sync::aref::ARef, //
+};
 
 struct Regs;
 
-- 
2.51.0


