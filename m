Return-Path: <linux-pci+bounces-41604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAA0C6E3CE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 12:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1703C4F4856
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D4731ED78;
	Wed, 19 Nov 2025 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VfZ9B6d8"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6BA354AF1;
	Wed, 19 Nov 2025 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551363; cv=fail; b=QxSNC++QQ13zeR57gvPxJ4LQZJ/2AUlF0/JFvugKs7l4x+JHH+R2gLyYll6HtZ+RNh/rEUXZ/qpHup8rySS5Hkg2n6YeIV651OHBdhN/X9kIF/1GUK/mM1nh4YzMkGkMaXf7XSAIsxfTxlxpNxRHRygcxF37jQZmtoRSTcXtejU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551363; c=relaxed/simple;
	bh=1cSR2Bmug8uVJEz5oxNCWxEcwg8xgYV1vG1MyM8LTYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHxKh/IPBR8O+OIT2qkBSPNp0oL3SxU2m/X/MyG66uMXvuyP/NdhFQUvLMSYXOaOSi0xPAQ/53qlPeoMR+Z45Cd29tpEISszoNJlRqGmcVHIy8yGbJzkZMcTH3ahLSBCRMn44+wwOukQWt0PCTaQLiq/oYIYHMT8VF7ChFfxRfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VfZ9B6d8; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdhkdrW2J6DbE2kkHVpcVMCybqfsppVuzpDxmuGITvQudRutVKs2BSOx+XAhlJU5uwKOY6p9fyqVtH9VNPTjFTMnjn5mjtrgTd8f1SqfIVQZZzFWYYAvwATrl4v+DYHVnfv5YmZWQyY6+mJwkCPf/OajL0sk9rpvbbj/aFW3GTrBzypAHCy6fCvpM/Rf5utWBrVGmJVQaOYYlxbbjXE8CAppaJbEUYV+OGWH6GTeY7TqSpYJOVUG65X1Jga/i/x3An4MeQf2DzbDV1eeH2qQdHIWdxENPX42QVHjsT9V+7rUnEwCNbciENE6KrSwKZ/KAAe6n6Xs+SGJoFXOxxqXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrOh0Z1g8AzRxJeZPOdSZvQQ1e1ufJP0PEEL9MtB+EM=;
 b=If7EQXw+EhPVU0DVw8b/dWlLcIrjKzZSCK731ATzs+FXv3iggXWlXbkIioa7feQQiOO5AwicchMhXAlQSMdfjX5ySKK7xj9vJWM7WtYyWQjRss3Idy0ac7V9ADybSLr1cn1Wp5cB/1flklZ+IqsV/Ro3f0pBBjrLUlf0PGmPp5L4DYfIHHS3xGvgRLewnR9RyWGkpRR5BnBsmDo9s2IOCfh9sqTPheinJSNkbFZPTpwHvovo3w5tM8F5oyC0Lm4PxD/TElBqq5gmHoQukx/WD0QP5BNT14x8Vi2fZa3/DPOj4aEDyobiARswasLI3X9Iy0kgGBoUyMJ6vYbi7dKRMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrOh0Z1g8AzRxJeZPOdSZvQQ1e1ufJP0PEEL9MtB+EM=;
 b=VfZ9B6d8MeqonmmfodT5O12hIuq1J3YUwKv97oSuMn5Qo6SuLKl19tJl6neMm0Q73u2u+8hSJiI5JGx0rFIOaEHWkRTTPCUh8YEWJVuLjIHibxaCVk//VwWPEeRFDXWViViTXZ+/Ikpql0aqbbxrCVaOd93+GAr2lWhNLVPbh36p0x64Toofww+KZtH9lumaI0s32j/KogLnqw6QvsY2J7I2Sih9I19Vw4HH46BW+QZL6LEWqG3pxo/QYkcDziU4la9xeLSScDyn+na4PT6tZXp3FUeazVQNFP4pqfjLB1fQVB7+iBcuK4eO+UWuFAVfKsEdcXUU3QlCr9gCG3TnuQ==
Received: from CH2PR08CA0024.namprd08.prod.outlook.com (2603:10b6:610:5a::34)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 11:22:36 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::f6) by CH2PR08CA0024.outlook.office365.com
 (2603:10b6:610:5a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Wed,
 19 Nov 2025 11:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 11:22:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 03:22:16 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 03:22:15 -0800
Received: from inno-vm-xubuntu (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 03:22:06 -0800
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
Subject: [PATCH v7 4/6] rust: io: factor out MMIO read/write macros
Date: Wed, 19 Nov 2025 13:21:14 +0200
Message-ID: <20251119112117.116979-5-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119112117.116979-1-zhiw@nvidia.com>
References: <20251119112117.116979-1-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6481d6-e793-4441-efef-08de275df0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2JzQm42Sk5zR0gyY0NQY0R6Z0VpQ3dFZTFGbFd1TGJvUE1zeXBxM2xSNC9S?=
 =?utf-8?B?RDV1QzNMQlNVR296RWg1MkJaSFJIUUw5MFhVNFo4YlJsRTYxdmszTHNUSW80?=
 =?utf-8?B?ZGNLczhoNENjYmNHVkd4Uk1LdGpPWHdNWmhJNmxxdW5VK21MbVltNCtvWjl4?=
 =?utf-8?B?N3hacWtCWDRhUWtMZHlxa3NRdDVHd3RtQ3JZWnd5YWo1MGFZNzV3eGhQbDZF?=
 =?utf-8?B?WGVSSXNsOXp1eFAxbUwrVC9WdjNBakFhcFM1engzSXhHbDZqNENnUWRGVkZ6?=
 =?utf-8?B?T3psRHFZam9PTS9IQms3V2pENFNvOTJJeGlxQXJ6UEltRHpPMmQ3RWlBeGk2?=
 =?utf-8?B?blNKMWNLUTVDZlZFRmk1d3hqMkEvYTlPWXVnU3F3REF6YktOOFJmN3VxMWVp?=
 =?utf-8?B?RHpUZUo4WGZiQWdOczgrT29BSk5TSDh4Wmw1UnIrOTN0cHREdXlsbk9RYnpw?=
 =?utf-8?B?czNXM3BtbldYTC9FRncwWGVENHZiN0E5QlJyejFPd0l6TzBBMXhramFEUGhD?=
 =?utf-8?B?Z3E0VnA5WG5DNGViQ2k2eWlBMWVkUnd2RisxazAyY2c1eUVueVJUMjVuSTBk?=
 =?utf-8?B?V1hUcWlvRHo4UmNEOGZGdTRsOGY4Nk5WaGYraFp2YWlkZGJiSW9mQWltSFNJ?=
 =?utf-8?B?SHA5SE9UVjFXVXNWVHRwdm1DS0Z2eXg3elJHdjBGMThobEU3bS9WVGxJcVl3?=
 =?utf-8?B?TE0vN25kZlJhaXAxVkNqd3FobXk3ZklXN1FreE5uQzcwMGlGUVZsZEF1QTF3?=
 =?utf-8?B?ZlhIZ1NvbjZhMVoyYWJpblNPaFVNU2lzN3U3dzRQZ1hiNy9uYmM3eGlhb2pm?=
 =?utf-8?B?SlNTM3d0NDY1czRXN09oYnZTUDRzemdscmh3S2hxN2hBMU5mUUtKM0dFSWl3?=
 =?utf-8?B?cEF3WEZiME9EREZKUnQyNm1hSUJqZGRTOE1rQnlyTW9LbkxLc3pSV0xTR3Y1?=
 =?utf-8?B?aytmNGlubzBTcVVZL1VEdGlzZ2tTTEE1SUxxTHBjclZRRnk2ZzRhREpsK3lD?=
 =?utf-8?B?SHBOUEhpTis1NVlwbmZNRm5GazFIT0JZb0VQN0ROa29jMXdwdFFIWVVWSmYz?=
 =?utf-8?B?amlqTlZxTHZFMkp3eERqSUhJTkd6b1I0Vkk2OEwyajhSR2F0dXozbDRCSHBW?=
 =?utf-8?B?eWx2NjVnVzF4clhTOHlFQ3Q4Q3pML3JQMHM3NUVzUFBtUjhMR0x1RDFUR1F1?=
 =?utf-8?B?bWN2WG9GZ3cwWmVobUVreDQ5elEreit6NndUT3AyMEVLU2FkVnRHclhYSmRl?=
 =?utf-8?B?ZWVaOGQxNVhPeDU1enBkaDE3WEJmeGJqN2hFbWErWmZ6UDZuSnEvUFp2eDdY?=
 =?utf-8?B?NHlSalIwQ1FCRUJjS3JLVXBxaWpDQmV3N2xoQ1FmenhQVEkzZDduRFEvSWU4?=
 =?utf-8?B?Ni92WjlKS0ZQMXUrYzN6U1dmZVJJU0duSUkyUVhOalRGMjNLcWd0K2VVYWhh?=
 =?utf-8?B?OUZSUzFnczBXM3czL21UQkJ5NnRmb0xTVU45WDlNWUxEL21sM3l1TDNIOHM5?=
 =?utf-8?B?b0RwUldLYzRkeHBSbmxmcHIvamtzR0NVdkhuQUNZMUJmVVRld0MyODFHc2Jh?=
 =?utf-8?B?U1l4YjJ5R3ZNYUxmdlZvWmJTVnJtb1dINWlzVUx4RlEyUzFuNjlPUlBxcWto?=
 =?utf-8?B?TkIzSTh1Y1JoS25UYitvWXB1T0N5R0h0Qklkc3N5Y3RMcGU0T2t5aG5nUmFw?=
 =?utf-8?B?Z013aFprTlFyWTFhUmcrcnZLWEI3bzhuT3hLM2tWY2M3eHMrWjZ1Qmtwc3Q4?=
 =?utf-8?B?S3R5ZmNOVlBsL25hK2dQMkVwOGUwOWdhUWc4bG9rSm9WU0QxUVozeDFQQ1Jr?=
 =?utf-8?B?K0xBSmltVnJ3N2RVMllZa3VreFpTaXFwcS9HOVh6eU5jVGhrVFNndUVzZlpD?=
 =?utf-8?B?SHpTMFk1cDUzZXd2OVhFOFI3dkErT0Z3eXJsbGY0RkVDQUJIdFZNclZwY2NK?=
 =?utf-8?B?cDN0RFVZQ3J5eGk3c1JlbUdkZTJmeW45RGRhbjNmejVWREE1VWtYMituUko2?=
 =?utf-8?B?ckNyM0tlQkJLL09nYVNrZjBpbUo2cTRzN09jUHRxQ1hrRnAyZ1ltSnlWUmVC?=
 =?utf-8?B?RENiYVdnRURsZFNqaWIySCtpcEMwZDhWdm1WemxEcG9ZSkdXcHdRVktoeHBX?=
 =?utf-8?Q?WjfE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:22:36.0549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6481d6-e793-4441-efef-08de275df0fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406

Refactor the existing MMIO accessors to use common call macros
instead of inlining the bindings calls in each `define_{read,write}!`
expansion.

This factoring separates the common offset/bounds checks from the
low-level call pattern, making it easier to add additional I/O accessor
families.

No functional change intended.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/io.rs | 149 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 104 insertions(+), 45 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 3e6ea29835ae..6e0daaf8dc6a 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -137,8 +137,65 @@ pub fn maxsize(&self) -> usize {
 #[repr(transparent)]
 pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
+/// Internal helper macros used to invoke C MMIO read functions.
+///
+/// This macro is intended to be used by higher-level MMIO access macros (define_read) and provides
+/// a unified expansion for infallible vs. fallible read semantics. It emits a direct call into the
+/// corresponding C helper and performs the required cast to the Rust return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the MMIO write.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the value to be read.
+/// * `$addr` – The MMIO address to read.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_mmio_read {
+    (infallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($addr as *const c_void) as $type }
+    };
+
+    (fallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {{
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        Ok(unsafe { bindings::$c_fn($addr as *const c_void) as $type })
+    }};
+}
+
+/// Internal helper macros used to invoke C MMIO write functions.
+///
+/// This macro is intended to be used by higher-level MMIO access macros (define_write) and provides
+/// a unified expansion for infallible vs. fallible read semantics. It emits a direct call into the
+/// corresponding C helper and performs the required cast to the Rust return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the MMIO write.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the written value.
+/// * `$addr` – The MMIO address to write.
+/// * `$value` – The value to write.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_mmio_write {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($value, $addr as *mut c_void) }
+    };
+
+    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {{
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($value, $addr as *mut c_void) };
+        Ok(())
+    }};
+}
+
 macro_rules! define_read {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident -> $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) ->
+     $type_name:ty) => {
         /// Read IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -148,12 +205,13 @@ macro_rules! define_read {
         $vis fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(addr as *const c_void) }
+            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
+            $call_macro!(infallible, $c_fn, self, $type_name, addr)
         }
     };
 
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident -> $type_name:ty) => {
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident($c_fn:ident) ->
+     $type_name:ty) => {
         /// Read IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
@@ -162,14 +220,16 @@ macro_rules! define_read {
         $vis fn $try_name(&self, offset: usize) -> Result<$type_name> {
             let addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            Ok(unsafe { bindings::$c_fn(addr as *const c_void) })
+            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
+            $call_macro!(fallible, $c_fn, self, $type_name, addr)
         }
     };
 }
+pub(crate) use define_read;
 
 macro_rules! define_write {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident <- $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) <-
+     $type_name:ty) => {
         /// Write IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -179,12 +239,12 @@ macro_rules! define_write {
         $vis fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
+            $call_macro!(infallible, $c_fn, self, $type_name, addr, value);
         }
     };
 
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident <- $type_name:ty) => {
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident($c_fn:ident) <-
+     $type_name:ty) => {
         /// Write IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
@@ -193,12 +253,11 @@ macro_rules! define_write {
         $vis fn $try_name(&self, value: $type_name, offset: usize) -> Result {
             let addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
-            Ok(())
+            $call_macro!(fallible, $c_fn, self, $type_name, addr, value)
         }
     };
 }
+pub(crate) use define_write;
 
 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
@@ -339,23 +398,23 @@ fn maxsize(&self) -> usize {
 }
 
 impl<const SIZE: usize> IoInfallible for Mmio<SIZE> {
-    define_read!(infallible, read8, readb -> u8);
-    define_read!(infallible, read16, readw -> u16);
-    define_read!(infallible, read32, readl -> u32);
+    define_read!(infallible, read8, call_mmio_read(readb) -> u8);
+    define_read!(infallible, read16, call_mmio_read(readw) -> u16);
+    define_read!(infallible, read32, call_mmio_read(readl) -> u32);
 
-    define_write!(infallible, write8, writeb <- u8);
-    define_write!(infallible, write16, writew <- u16);
-    define_write!(infallible, write32, writel <- u32);
+    define_write!(infallible, write8, call_mmio_write(writeb) <- u8);
+    define_write!(infallible, write16, call_mmio_write(writew) <- u16);
+    define_write!(infallible, write32, call_mmio_write(writel) <- u32);
 }
 
 impl<const SIZE: usize> IoFallible for Mmio<SIZE> {
-    define_read!(fallible, try_read8, readb -> u8);
-    define_read!(fallible, try_read16, readw -> u16);
-    define_read!(fallible, try_read32, readl -> u32);
+    define_read!(fallible, try_read8, call_mmio_read(readb) -> u8);
+    define_read!(fallible, try_read16, call_mmio_read(readw) -> u16);
+    define_read!(fallible, try_read32, call_mmio_read(readl) -> u32);
 
-    define_write!(fallible, try_write8, writeb <- u8);
-    define_write!(fallible, try_write16, writew <- u16);
-    define_write!(fallible, try_write32, writel <- u32);
+    define_write!(fallible, try_write8, call_mmio_write(writeb) <- u8);
+    define_write!(fallible, try_write16, call_mmio_write(writew) <- u16);
+    define_write!(fallible, try_write32, call_mmio_write(writel) <- u32);
 }
 
 #[cfg(CONFIG_64BIT)]
@@ -363,16 +422,16 @@ impl<const SIZE: usize> Io64 for Mmio<SIZE> {}
 
 #[cfg(CONFIG_64BIT)]
 impl<const SIZE: usize> IoInfallible64 for Mmio<SIZE> {
-    define_read!(infallible, read64, readq -> u64);
+    define_read!(infallible, read64, call_mmio_read(readq) -> u64);
 
-    define_write!(infallible, write64, writeq <- u64);
+    define_write!(infallible, write64, call_mmio_write(writeq) <- u64);
 }
 
 #[cfg(CONFIG_64BIT)]
 impl<const SIZE: usize> IoFallible64 for Mmio<SIZE> {
-    define_read!(fallible, try_read64, readq -> u64);
+    define_read!(fallible, try_read64, call_mmio_read(readq) -> u64);
 
-    define_write!(fallible, try_write64, writeq <- u64);
+    define_write!(fallible, try_write64, call_mmio_write(writeq) <- u64);
 }
 
 impl<const SIZE: usize> Mmio<SIZE> {
@@ -387,43 +446,43 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
 
-    define_read!(infallible, pub read8_relaxed, readb_relaxed -> u8);
-    define_read!(infallible, pub read16_relaxed, readw_relaxed -> u16);
-    define_read!(infallible, pub read32_relaxed, readl_relaxed -> u32);
+    define_read!(infallible, pub read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
+    define_read!(infallible, pub read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
+    define_read!(infallible, pub read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
     define_read!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub read64_relaxed,
-        readq_relaxed -> u64
+        call_mmio_read(readq_relaxed) -> u64
     );
 
-    define_read!(fallible, pub try_read8_relaxed, readb_relaxed -> u8);
-    define_read!(fallible, pub try_read16_relaxed, readw_relaxed -> u16);
-    define_read!(fallible, pub try_read32_relaxed, readl_relaxed -> u32);
+    define_read!(fallible, pub try_read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
+    define_read!(fallible, pub try_read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
+    define_read!(fallible, pub try_read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
     define_read!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_read64_relaxed,
-        readq_relaxed -> u64
+        call_mmio_read(readq_relaxed) -> u64
     );
 
-    define_write!(infallible, pub write8_relaxed, writeb_relaxed <- u8);
-    define_write!(infallible, pub write16_relaxed, writew_relaxed <- u16);
-    define_write!(infallible, pub write32_relaxed, writel_relaxed <- u32);
+    define_write!(infallible, pub write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
+    define_write!(infallible, pub write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
+    define_write!(infallible, pub write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
     define_write!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub write64_relaxed,
-        writeq_relaxed <- u64
+        call_mmio_write(writeq_relaxed) <- u64
     );
 
-    define_write!(fallible, pub try_write8_relaxed, writeb_relaxed <- u8);
-    define_write!(fallible, pub try_write16_relaxed, writew_relaxed <- u16);
-    define_write!(fallible, pub try_write32_relaxed, writel_relaxed <- u32);
+    define_write!(fallible, pub try_write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
+    define_write!(fallible, pub try_write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
+    define_write!(fallible, pub try_write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
     define_write!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_write64_relaxed,
-        writeq_relaxed <- u64
+        call_mmio_write(writeq_relaxed) <- u64
     );
 }
-- 
2.51.0


