Return-Path: <linux-pci+bounces-40486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14841C3A471
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 11:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A87F4FF376
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 10:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6612D7D3A;
	Thu,  6 Nov 2025 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F5d4tQAh"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B483727146A;
	Thu,  6 Nov 2025 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424948; cv=fail; b=P2FEfGzoFe/tueiuzD9d77ZvOJ9qaI2elLY3eBHazt0zqRfSfEYP0lVQ74qA5hcui+mJQMuHf/07ytAEzyy8AwwoAbXks0HxStIkB5KvtWKb0YcS23dwNOaUKSt2GBRTGCksjtFHxHkwCJafcZKQkd7jgDTFtRS5aNR7ZfWQ4B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424948; c=relaxed/simple;
	bh=1ey69uQ52DpCkFl4X6o0l/HSpZYJI/4HTWB2yK2xweA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmoRztJju8ypl8oWo6P1sQcmITYV0+MFPZE+WrGvmqr+8Rhu4VY8xfJre2CnkQW4tonBO5/C6hFNlWQesX5jX5Gy9+tlnKGv8GL1r6YI6qn5zYa5Z19Q9z8CiNxBjQMBYrODx/eKgUx5Dr5oYHoVo0gMpNuzvnFnNMiUDy5otf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F5d4tQAh; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bA/SKDMwxvRGTc+zU0pZoNrD2klXZebksWkRWOUDYn+C79uT/qTiFmPR7sqbc2YLXXe6C2aUL92ClV+QhcYnS1kxTtkqvHlXdIa5OJ7oOr9pY7/iQLa/jsGOOvXM1qEe+Qmr8F+uT+/qwB50L+MLu4gF15Z6HEyHvaNvCsFLdDD0jYox585pod4GWSe4npTDJjmQpdmx4h1fmm1hTdnjvIy58RzEUJp1u6lJJLhiGv9LfG/HjC5R9EQ6z1lcUsAKjcLagLIJmqKpkTxMJLOk7JOV08WbU6Fs7/SIYV0Sl6bpeHUOhv4p5uTMR7LJyhttq3qPIiljDlst3nedaR0lSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNQ+uPcwG3K1Zou3EZfp/PaCvV+74n+fUoGFaKlIAQw=;
 b=olmiv749JooAgxp93BPFIqXBRDTf7Erhgh9kqb5xTtCFE2F1tKRjfyHSqDjERJDYi8TToIF/lLuKQ69thaYDB/1xZ8CCFc1NVH3aFrIpPmM61W9M5wg555IHiLpSTR4Taj22qpbyiikXf80YYhPmsmeCJtmvlsL+LU4h7zS7jbNO/AdtCiODO7/DI1C6m6Tijobhqha9b/O/nlU22y+2cOgohdl+bdmSkaXJrQ46CxQIyNq7b13PSm7dhGw9Hc1/oL0C8h4oSrNz90sCmNdgJia55I/paybbB678iEDESsrtOgDtOlcmzah5rgwVkJ/8kPQibE5X3IODFBdo//1Jxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNQ+uPcwG3K1Zou3EZfp/PaCvV+74n+fUoGFaKlIAQw=;
 b=F5d4tQAhaAmxyEc50PsxX+WTAgbhI1YXNNt9BBc1eXZ/g7RXX22hotzt2jhJRq+Ev24rE1law7DFUVCKUdDnH1Ppxq+52SoQJ+2Fx+UCQav/0Pnt9iHG3z5t1YpvxmU5VKq3ITPbziJobJuxQ8EY5t9NEmte2oOYk6I2qwVpz0VQrWJE13vUFt2wGB+KXmEvmLcnpPzn1C1gCsGum6Z/jdpnaXkeqIYN4QdvQuAHG631h34qOYMMvRk3qy/W8wAvzAKgVEux6qiDzedR1QjLRCLT37YYAqGFOQ5N48mxbWHHkIB6Q/XjpRNruPaeHH5o192d3jICAJxvGfi8L2L3AQ==
Received: from CH2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:610:50::14)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 10:29:00 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::34) by CH2PR16CA0004.outlook.office365.com
 (2603:10b6:610:50::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 10:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 10:29:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:28:46 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:28:45 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 02:28:35 -0800
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
Subject: [PATCH v5 3/7] rust: io: style for imports
Date: Thu, 6 Nov 2025 12:27:49 +0200
Message-ID: <20251106102753.2976-4-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 302260f0-694c-4064-f34c-08de1d1f4cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KYv6B32UHYqfedW51Hku1k8QXCIAySTeiNXy+RsD4zf79aWUURbAXCz2b7Hk?=
 =?us-ascii?Q?sK/aU/rt8e7RQTfM9xKPmRRbtRRfoJl4GJY5RyD5aoumf4vQqVwennASZA/2?=
 =?us-ascii?Q?ehJaskfLqNjxQymzHSk//MguVV3HQQfw651H+i9+Z2Hvy10HoqkhL8ieTqYm?=
 =?us-ascii?Q?2Mf4YMRPKpR2Cu3k5I7IAni+0cJWUn62CqWTun3nrl9j7e/GivSRPbczhPRO?=
 =?us-ascii?Q?TR3QoGQnuhluAeflrmd/Kbnic+RW32oa9k8vgeeTWVUV2qLZ/ISKeMI1kwLV?=
 =?us-ascii?Q?gSBPiVLe2y5VDlubs6sigdEnnZax5/SLvUe2nuWa/sYVkJpDA62jaoSfJK6l?=
 =?us-ascii?Q?wfpTkkkWYgRFFpglNaB5NmROfjf5q/O06KD7rVfM1egjXaqQYDDZ/IcKVmJ3?=
 =?us-ascii?Q?1UvkcBDFiNzvA7xAaJy8SoMhD2//7c2yaMtTzgZ1fnuqMUDa1Nnn7rJuOPWK?=
 =?us-ascii?Q?lRcB5mHKCPJYLsSTzXhZu6NViQRb/ukp8cuJZvDg4/JHv+jqt8PHkaHeUPbF?=
 =?us-ascii?Q?lLukONhoNriJIRYw+YUhzbYKKCU+DGFcrehyTYaTy5XcDBo67L0cb5kq7m1o?=
 =?us-ascii?Q?8AMwcTyoBH1EBK9kl9gM237kwUWihKnCCLxdLKjZZ590HMP29t6BHK7IUAmr?=
 =?us-ascii?Q?ILNZ+CnseDgyqE+Qhv7KJV3cO06lalMW3qSob+9AjZUJJi27acrGPi1NtOHO?=
 =?us-ascii?Q?BP/WmWdMbPWv8v/UmTQ1j3ZAsSca1P9o1fSARfcmxhlj5UcJ28/YwY6aivYw?=
 =?us-ascii?Q?AYa9xNLxqIXnMLxFCKOCpbRd1sTa1tO3OzeDahdZ439Bt/TZcAxJBfPFr92c?=
 =?us-ascii?Q?SSJN7P6AuQ6IQxJQBNwc20tpOfPzi7jGr4K6Axs1MoroOZ+kPeAurZK0JaFQ?=
 =?us-ascii?Q?2cVosqNK+Qv2umks38cPtfrNj4YdkWCTBDEII5l3XuaicG4jA/xg7HaSIS5P?=
 =?us-ascii?Q?7qhFR2ocfaLctYiZTo9jKqoX8mTdl9fRqUNEMCquytcBjxWVU4mwwK2Es5KR?=
 =?us-ascii?Q?+3Y177RfjEBLKuAmtKloVKRxKyGhc21kvxVO7kL7eLW9uiTDk45Gkf7QWt2G?=
 =?us-ascii?Q?t/b7G1jQ18lnhTnvGTXl1iDy7b9TonW2dY+HRv5qhviwJA9y9k5P+trHxtLi?=
 =?us-ascii?Q?cIKmbQnv5cfpiNxMn9ZSGVx482tiOV2GqNaUuPgfG0hw4P0iz7cDdXz1veP0?=
 =?us-ascii?Q?7tlNlCLnRcLJCuD5RVLng+MWparNRa6t7sjTjo8dHNZkU+MLQq9bosnqw6XQ?=
 =?us-ascii?Q?Mo/jN6U1fJmWvlGHfCFC82wACCEt6e7ldFb81qPEwLz+sVLpSDP7qeh3zVkm?=
 =?us-ascii?Q?VL/zgIg3scaN8z04rKClNQ6froUPV7JhEf7VDgekwOsC3Jav89LeicvKbdvp?=
 =?us-ascii?Q?kOcRdVrIxw0EL7ISSFv/xg/fSVDns+wY6nHROsubz/CWBCxhdZzt8gus3J+2?=
 =?us-ascii?Q?APmsLbJXaADFSp3d/1MERgAu2wIWgHGlTk3FPezvktgmhowQnUqO6sdaGOOY?=
 =?us-ascii?Q?cqGt8A40clfH+dnSkSKcdI282d5+DeYfEv3o3w4HIh4lgxL41CBld1mI3KlT?=
 =?us-ascii?Q?q8KrTfARTAjQLDnhllM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:29:00.1442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302260f0-694c-4064-f34c-08de1d1f4cd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271

Convert the imports in the commit in io to use "kernel vertical" style.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/io.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 1aa9495f7774..6f1e22613f8b 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -64,7 +64,14 @@ pub fn maxsize(&self) -> usize {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, ffi::c_void, io::{Io, IoRaw}};
+/// # use kernel::{
+///     bindings,
+///     ffi::c_void,
+///     io::{
+///         Io,
+///         IoRaw, //
+///     }, //
+/// };
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-- 
2.51.0


