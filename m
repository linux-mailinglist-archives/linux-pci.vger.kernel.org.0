Return-Path: <linux-pci+bounces-45211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE7D3B827
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 21:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43839300BF8A
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 20:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6002798F8;
	Mon, 19 Jan 2026 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q+/pL8fc"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7762E8B9F;
	Mon, 19 Jan 2026 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854200; cv=fail; b=dLeiYNRg4XY1Kg/1nbWQTsFMi2W+Jej9DIQt+OJAtyOlu6EMS/JAWFAIVIl4h8iYCed2+iBm0L1bn1SJK2ipA8TZWHXweFSkQLWlgUjtdsWxJu0OhRjdWMiJKppl16COeFKP80RCVt6tXrdbN5gvqPxDtJBTbiFKF4Oxk843FZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854200; c=relaxed/simple;
	bh=Lxj4PkBapAtBNnB2X0r047B1aw4vPK6YYG+v7Ht85A0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9i++sZHeqXoXz80fsBGiVFage8HVfojZJsUCglcsAX7oytcWZZOV/+VV6r7SXQNMzmbXN039wtc/+mXTFrY9lCCT0NCws9yVgosykbmJXIvdksIEUA0mXGfvNMgcOPLPHrXk34C/mFZTK+VREW39jnhd4zIyhdzknlgjxpEDuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q+/pL8fc; arc=fail smtp.client-ip=40.93.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkIAVzIcjpAiIkvGrUOSZX0SGshMWHCwF7ujEuwMBAy4wNnXRM89ccPCYOXVV8O6/IuERWWqrt7SyADS3xLJQSvD3fHleKEzE9TC6MEmaXHkrv7AjXYrv0FuB2Tm38mTdbrERgP41033nX7LBJUSRtvRDDrxl7v0WgU+FdCkhiTsDHNgkDtwNCPC/gWpO2PfuBiqsHOIMc8YmjvHz4xowTAjQOgAU3R+H8tE+qdB61CdjUOU2LCYEyJlrvM89kVlL74MXazfSf4sqExEo2WDkEaamOJyr4hXFMUKlYtZPMHuUspzeEQWEvt5mUp0mvQSg3AFVH0TF9IireJ4HyB03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVr6029GJBT27W7/udV0dd+wNmZk+pMBNPRUNVuJAYA=;
 b=EClH4gOMtc/Cz8nIUBvwqwhoi25rtL2VNUlCAhSKleJZ+YKMzhYofhjlcjZsa7WpjwU5XchlEk7qT7KAAXJgRARvcjuyEFS/U0Z9y18bQHZHPhQNSy3hdFpH7Ev6ZxRCosfA/U11hfKIvw2Silha5Sx79ESwp0PshGJmhQV7taxCTqo4vwUK2+aqB02Uv94Pc/afHiBGX8LmaFsSMkveQ3PkCiPcYWs/B1SpgCbJT+yi4KayMzd4bWlf44rut4EVHFC/0mBsfphMbFZ7t70YHgAREKoqROoNyUwrjPIgIsfs9pj8WBLGY7mNZTDuaR7uDUXiCANEVGflG1diBcmQ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVr6029GJBT27W7/udV0dd+wNmZk+pMBNPRUNVuJAYA=;
 b=q+/pL8fcT9gm4KoWvkuWlQCywCRXk+rcLb3rh6qxoS/crKyoffZ9MhpPnNc1Xh6FD8U8GCbWHChv5+x1NSBCCRkTShAEr7YRwbgAaenfpcHqN/FexOh/xB4TMDU91CFtbYV5R244gpLPznAp8EgDX9h5zPrR2XYzzxHP9IY667Krky4vJWgXiP0KnHHB0LXg23mx1w9ekPHRUH1IZQ8KOU1y+aCWsZlphpR0ZVX0DRvV2saGbjcjefEs8AgQCq+IDFKSxARdWlCkieYnplaiAWIy17q74AVk4yVggrnTo1qWmN9QQ6vbsMX+w9Ucp2IH+t8Mlgrxdx0QpJjApikaNw==
Received: from BN9PR03CA0939.namprd03.prod.outlook.com (2603:10b6:408:108::14)
 by IA4PR12MB9785.namprd12.prod.outlook.com (2603:10b6:208:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:23:14 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::a8) by BN9PR03CA0939.outlook.office365.com
 (2603:10b6:408:108::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 20:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 20:23:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 12:23:05 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 12:23:05 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 19
 Jan 2026 12:22:58 -0800
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
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v10 1/5] rust: devres: style for imports
Date: Mon, 19 Jan 2026 22:22:43 +0200
Message-ID: <20260119202250.870588-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119202250.870588-1-zhiw@nvidia.com>
References: <20260119202250.870588-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|IA4PR12MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aef7ff3-ddd0-4bb0-9eea-08de57989327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vD5aivw0Gl+n6q3SXdxNX2PlwvkSIAjPkeqTjgNQOhzTpLx3qc4E18IjMpSs?=
 =?us-ascii?Q?Ha1noEwjdiBsSt9UZIIadQrB1x3Y/usWusF9qTSIBpEajMUftu5OLY9E/1SD?=
 =?us-ascii?Q?9cmWgmY1Av9VRbIN+eHLO+fpJs2HUUqgUum/hugaemCMkWbFotWcepxD7IzF?=
 =?us-ascii?Q?1r0vv9a3vrHNMblRDwUL3ogNtjVp89tRR+GDS/FoFvGDQQWKAlZehjJ5s4eJ?=
 =?us-ascii?Q?CoygLtfKxuEkfPPKByOUrNswfPQEY60hnW9ufPAx26blLGOi1DR3cNMaFG4H?=
 =?us-ascii?Q?JJeEoRF3Xt0WHY10Ntg95RHkMJRNiHkoULcEbd/wSFP4CBIwvYoETaIuOERI?=
 =?us-ascii?Q?88BZo44uAAeUBXsN2LoF5q46z5eNYtJHai44SuMYpYjK8DcQ8te2oRNrwds3?=
 =?us-ascii?Q?4fsKL20WZ1fy1JgDrjhnGUkw1ZBfpTNjZQMywHkfPbSAZXI+EpKorYDZ20f3?=
 =?us-ascii?Q?mKex5yYsEB0Q+FiomnFXYa6RJp16lWDQtfkFKVcEE5fHI94NqtpVKzjygStS?=
 =?us-ascii?Q?VqE9iVOq/T7yDmSMrWggMENA7CcICp+W6yDUyxQWoHbH+yr3MPTB25mGGfMz?=
 =?us-ascii?Q?22oiSJMNw4uhJmJj5XMA3RPERY6vV6hEcyL9SnvmZiE0vvFwruZ6Wu/Szvk7?=
 =?us-ascii?Q?WTOUxzZ/6mWsnGwYTHCop2lanxEkiex3hxYW1lWK4XzrBm6TtDZ3wph+MoK6?=
 =?us-ascii?Q?pUCIAm2zJ0mP1UOCVRJKtlWVT1DwEXnEHI7ANlBkD0q0xJhLUXCa2eceaGkw?=
 =?us-ascii?Q?4FDivQ6KUf6cOkr8T9R8CCZ37jrf62qLXSdHqpIwYVxjksjapAj8mVwTK+Pn?=
 =?us-ascii?Q?gDMbpLqrqGEiG7d1avkB1jsdUlrzbUTt9yr0gaQ0a/Dxugl/AUmWDZI1gjDE?=
 =?us-ascii?Q?EkNeEwOr+weDXb91OdTdX0oGgbJ+sv8rh3aVCMFoO+eCJkAJppyOaHVk1ttR?=
 =?us-ascii?Q?XLIehjTvQNg8JGtJDPq+WY5hjNYndfFvFBDGE3grSSiGriU2ehiE9Y1zThhs?=
 =?us-ascii?Q?UGrOwm0x91FAiqWR8t9SEXQOUr+j6eToxiEmAFtcqiyV/cwNDBgm4IgbbEfu?=
 =?us-ascii?Q?yZYxK6Zi/17GPUXlZY1cstANbzn4EZwaDNQVZD1bwqaCzI7j/ehHwfc6uaLn?=
 =?us-ascii?Q?+nPk6K4atrQXt+NKnoW/JQHBp0CoxRLz5wSsJiWf1x1Hep3ZIcjonfJMUAew?=
 =?us-ascii?Q?Xl5EiN7iOhp0Agq5ISKVfS1gRQ7kAinVsIv+49iTJa72USOdcFNTpjpxc+D3?=
 =?us-ascii?Q?+o+dzRr0E0WAXVxsxSCllwqm8W4RWVYY8Zm5yvEZPl25EdUwuOwHjI6+LcvI?=
 =?us-ascii?Q?yXe/1nmZc6H3rkTGVONCiVLw6qdde7Q67yQmCwHRdyp256q5BsSoFu/Lk3kA?=
 =?us-ascii?Q?cT85wby6mJMmVsF4mqu7xOkU3G0AzBRvk9q1GqVrxjeKa0uZT5F6jJeJhMIl?=
 =?us-ascii?Q?2ZTNwF/e6FQZorm865YQs8cD0wVLSacM12KNne+QACVB50LQa6r2WNvXo/Vu?=
 =?us-ascii?Q?oXhiHmEUh0eoEmMDC09M7rhApPnPzncU1LvRdTf5ZHN7PnFGVdf78Qnvb8U8?=
 =?us-ascii?Q?ekMisYULM+iP9yzvc2LQLo7/r0S5UVYA1fJ3mRzdSm5iExCNAHl79oTq7v34?=
 =?us-ascii?Q?plTJFGvFlsV6WV7Tauojky0R9oGh4sMj7DhcEKf+NtBFs3yQbSQARUlecPqD?=
 =?us-ascii?Q?YNSTag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:23:14.6769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aef7ff3-ddd0-4bb0-9eea-08de57989327
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9785

Convert all imports in the devres to use "kernel vertical" style.

Cc: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/devres.rs | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index db02f8b1788d..43089511bf76 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -254,8 +254,12 @@ pub fn device(&self) -> &Device {
     /// # Examples
     ///
     /// ```no_run
-    /// # #![cfg(CONFIG_PCI)]
-    /// # use kernel::{device::Core, devres::Devres, pci};
+    /// #![cfg(CONFIG_PCI)]
+    /// use kernel::{
+    ///     device::Core,
+    ///     devres::Devres,
+    ///     pci, //
+    /// };
     ///
     /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result {
     ///     let bar = devres.access(dev.as_ref())?;
@@ -358,7 +362,13 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::{device::{Bound, Device}, devres};
+/// use kernel::{
+///     device::{
+///         Bound,
+///         Device, //
+///     },
+///     devres, //
+/// };
 ///
 /// /// Registration of e.g. a class device, IRQ, etc.
 /// struct Registration;
-- 
2.51.0


