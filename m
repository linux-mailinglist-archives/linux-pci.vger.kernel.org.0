Return-Path: <linux-pci+bounces-40769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB75C493D5
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F7818908F8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E590242D91;
	Mon, 10 Nov 2025 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TcOXL+Nm"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841312EDD7E;
	Mon, 10 Nov 2025 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806618; cv=fail; b=lQe+F2fzV9rGVvCAO0C0pxlY+mT6tpQN9yO2x9/Sq/GvIA+orvM8+2oSNAG3HzNXSwTP1rIuCYBcEAjKPcurk+210djTyGF7ZoXjVzok+nGe17c0BcAdhf0gs8Txn3AiuRX3uGPf93bPox8l4KmrGcOpSlb1vsKRAX8LePg+5k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806618; c=relaxed/simple;
	bh=pmufUxO4slioaJ2XtjP+dPrsPcRDjxS4Yfvv2hMe+R8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fU6X0eIwPOy0hzS/D3IvXwJuDwXmRlbHMTDyqiYNHG4TmX6DExEwop89gSQN7URzS93qM5HWJdHwX/Qbky1oDSItNxHlmlAOFsh/f1dcIARa1twJVHelCeh1axycFche2IQupxGkxh7Sb+V07VU9d7/KOvb/QSgDVbin51s8GfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TcOXL+Nm; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbDXZDlYsrID4KURliv25dpN+FMyFDWeT9xs7H3BS1ROkTGbAmoMHr5uwOxnqdAx+qucyXn3VKwr7TfCULI5wPjwwMzHqeDo6QdxE0dAafn7tcjQ/9uiHuRYux7LJO8UIAxKxWnVxVMCIM7ywUktcoK2w6n1ghWR14hYFWEfuYdxC9wnhpE8Ip3k1cDsok3Uhz+j7L0e/h926S56nc2vU3o/5H1NC9iULPzaNeSrfsGdaS4+IIeOdC63cKNXU2yna4C62bBemZmz1Hj6OxIvdHSMKqHr0JugCHtn3+ZZEb056Lpe8bCZMnaodyNDlACFeufkAR8J7hoiO7wLdgyGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHnxk5gTlMEwwObcrUO522PaSj/dgW0lDqaTDSNRIx8=;
 b=KBiPkET6wK1vZUCpijYDQeyGFagau0Cn2/BBFWySEDrkJRw38vRiv7vQqmEqhpbsVYuWU9/6Vi19LFr3jDX9VBRVMqFoAu8202VR+mcyxEYF84DU0mSP2A+UXoFxy/wB9pg4iamMNffADogVhNQ9eVu20IL+ocWe7whq1kB1PeqNkIEQZ69hEijuqOKcDItYDiwHOyFk5dwRBusFSL4wQMxTtEdO0a/ypIOKKKf6NgWDzgBykyawhaQwu+C3O+U9VkHjYwxZkmP2+8b7T+QjHZ/6fcDIFLRZDysRjea4+uOsMUPzpHyyF0/T+eLz3qfnH03/Q6YTeL6CkoTW58ekeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHnxk5gTlMEwwObcrUO522PaSj/dgW0lDqaTDSNRIx8=;
 b=TcOXL+Nm8HU1z7X9LqwPrMduF9XhXaGG+iYgQ111vwgaWCDXm9X6koEMici0G+OS2h0Bvaa7DkcngDKOhy+/Byeignm/5gLq7EUHH1H/Ac8hjFo61Z/hyPaYAHC9dnRsWpLaWI6IluNRY7i11QenCMMUxqRfzPhKX+FebGCqYZaiBYjaYlVF9erMItlod4Wt4qcuS+rN1QJdKaKNj61B/nuJzIT9XcMKk5fRT4CWeICFffhbE0biKHzMbdI+pMh1qgs8vf6vs07aBWz74WefSR1mmucbqPMilIfJHhxiBXJjVkh92uoUSWNC32yiK+MsM4I7j45eFH8vGKzEUKqvdg==
Received: from CH5P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::19)
 by DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:30:08 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::7f) by CH5P221CA0006.outlook.office365.com
 (2603:10b6:610:1f2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:30:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:29:59 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:29:58 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:29:50 -0800
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
Subject: [PATCH v6 1/7] samples: rust: rust_driver_pci: use "kernel vertical" style for imports
Date: Mon, 10 Nov 2025 22:29:33 +0200
Message-ID: <20251110202939.17445-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110202939.17445-1-zhiw@nvidia.com>
References: <20251110202939.17445-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: a4351bf5-cf25-4df7-f597-08de2097f0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kInSqsGDfq0mhSWSr8tQqKCYl7fWuwW2KPQAn8l94TCxe87PvmrQUi0n5Xrk?=
 =?us-ascii?Q?Lj8CtsfDPsK/5MrORJdrBcPvWsATTNO+H4hW2QfhbxgcJg03MmbsL3koP2Hf?=
 =?us-ascii?Q?rZyNvBS9KCLKKiUejk81LQ+iZIb+++jGXC/oehrVmbI1EaDkh1cWFK9XlfkJ?=
 =?us-ascii?Q?UkXlHAEAQ9xyN36dnkTEpyZww3JOPoYIz+8HdqcBHVXy+br74n4jVprYHc0Z?=
 =?us-ascii?Q?/YRuBkosOmH8Q1psDye5cfSktlyhTAg/klaqkQDlEWfSdUQC1vruIRGf74xH?=
 =?us-ascii?Q?v42UEkIK5nGtkWdNH4mERA+C9ltHDBJKWyDTXWzF18WdWxNEeP28eowY3cM3?=
 =?us-ascii?Q?spFOWka86N2v4COYFNmLXDXWW78pEeNfjYWvFLU5Z3xrSgGvnaL1URBaTS/o?=
 =?us-ascii?Q?07Lz2mINkUKFbLXGgKRfRmN7gCdSSL0ExU8+4Z5AgBZexdWwZGKPf4CNZbhO?=
 =?us-ascii?Q?c5c/hPSkEwPq7+oW4xVl/Qt7CVT+xaMnUcI7QVT33Napa13BBIaf+dpVwztm?=
 =?us-ascii?Q?5Tbm9bJ7GIgmyCMzi3aoiYRsVrgwR7r95bn98fnjfeiAeY1KEsFuja+bGjO2?=
 =?us-ascii?Q?NbENWTKA7SPtEJBZL/dYiilyUSQVqqhtK9GohCvo3eicBmNzmyDULt86bsTl?=
 =?us-ascii?Q?x9vzD6NUUVqow9rD+GvHJWp8ehg9Fpm2/FLnS8puFnegOKfvwtKy8tLCgVXW?=
 =?us-ascii?Q?yxMQFlUKUgbfgFQ7Y3NVxCiZCrInEWlWBM4+oj6e3hKCVnOC9oXBnR8gBP7l?=
 =?us-ascii?Q?VMYGzhD4RMSFaf7bd1QYW6uVhZGiGXZaiqR1KLSfYU010mD9ManzRhsXLbau?=
 =?us-ascii?Q?wQqk7Acu5KF81vRR3QSSEqwX1S9Ec8nBSIcOCnSDghjJ3N/hmWTl5WEKIN9+?=
 =?us-ascii?Q?IhdTa2y8sTFOo+5lqmHSJLuBH2o+TszNXvs4t0xQn7mEUkMNTaTMsFfAPYkN?=
 =?us-ascii?Q?g9tQY3TnWgmmphkcKbs6WKT2VcFXC2/miS+/RZ+VN4stQNH69OSVX6H5QXcZ?=
 =?us-ascii?Q?teWtRsnDDM6dgeMK936R62mucL6um7PdHs6+CrDpCGnkWAdzmrhvXznksS6r?=
 =?us-ascii?Q?DR6eecC0zV6g31z4YMi7qP/ce1WpnJc6ydmwt7/1F8KNcX6ZcRQIhDaQwJ1O?=
 =?us-ascii?Q?AfAJnYSdejGVWnlNLDiRjHNtwI3TCHfPkorz6YHW6uErRvuW4PJIYNtWymMz?=
 =?us-ascii?Q?VPNqPaZGLvPYje3FwK0XZ1npC6K0nMlEbNcHletfF6wUR7z1xEoUbtuOxEfH?=
 =?us-ascii?Q?M4bygeOFALgIjjSxHAZmYUgBMm9pk3E6xw9+XCsSDCCpJNNH3FroRkyf2gV3?=
 =?us-ascii?Q?HUWzovzqtFgcCBZbkhFu0UAWqF2JRwZ8KXeVlz8PTJemupBoXj0vUYm394En?=
 =?us-ascii?Q?fthttwLFdCzHkROqj1XY2CLL8U3YqriKJPSpQtdHzRnJXBhVkoGH+6mK2yq6?=
 =?us-ascii?Q?TTbBewkKKOuZOMMf4EC6l1/r1LC2dIu1FJizgeUzFu5XQthZwa2XVpLWNp+0?=
 =?us-ascii?Q?dw8d8TO82WnqgWN7YJBEa00GsaJnVaPW97sLwzpPQQFiMoNaIvs0holf1643?=
 =?us-ascii?Q?sDOXtTR6aRlzxox7Dks=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:30:08.1618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4351bf5-cf25-4df7-f597-08de2097f0a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745

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


