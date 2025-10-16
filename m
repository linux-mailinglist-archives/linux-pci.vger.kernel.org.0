Return-Path: <linux-pci+bounces-38400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A2EBE581C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 23:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBB144F0A1C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2FF2E4241;
	Thu, 16 Oct 2025 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j509d84R"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955CE2E2822;
	Thu, 16 Oct 2025 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648613; cv=fail; b=bZgNegW775HMnziGfrdApaF67hCSwJEzrJ+ugLB5145sht0MnlTVdcArgZbYx/odqRlCBT1JXCJ2pTsZGlwYhhyHq+LV9NJOfLw28GzqANfxQk2J+OdnYnJL4YFJlovFtAEXmTlijR2rpSKm0aLLx6iO5hMuET3r2NbgwVcxAAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648613; c=relaxed/simple;
	bh=pkCIOZRts0TjBy/OzyY6x2+QqCfSwZJHVvFiGA9Q2Qs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpRXgsmLiE3CIlNYXwurtz0+Bd2FuCIYh0yeDEfRkK/G66jlE2+PUO0kOpWkAKghd9Kt0TTvGmeUUhvhb9JtOouX865x0oK57LXrJqV0qJZZTKfh86zJJfNJl3HuvlC7DAaKRV4GPyaSvSLU/erAen/n+mM2O4SABNOGOz+8Uw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j509d84R; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSwj8DkN8aC97tG2ZwLJc5ZKOFe9vY7qB54z+RvwP1Sc7ceLwb5ubhVLxPMD5MKoxIzD9NIbGFmvCf2EZcD3MiEZrUhqIwcgQ2M5S7XLKTTKGoazqkhlumWVkL4ZdHKhtpaxTVjoSDyGu2fkf/V0OTbL3IL9RQoqks07MCwVUGYm2WiZHJ5NV6UMe+ldejalxCgUYNVUHk2t9rtjKYyTuBj9buBhLBdN8pRj1Rtj+Mw8vGkli5nHEXsDS/JNaggeYF9yMTwH0mtqcouf7L75M0x02BxL2Fi2FQWBO6KS6K0cbmRRYaZGQF8yEibrdqVlSdzYTrTeh3On995Vi/CSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8ck5jQHm8HYg/OrbJLHVks5MpInYDVn6SOuaR3fPvM=;
 b=oonlh171sCL9ybR3Rkb8kQ/dtpX5IGD+kqJQ9TDs62Zwo4/YMhlOslftMhdPR6NX3Lk6KYKamgZom78UMlAMNvuwpItZwzvnQlrAdHGL0AMiegCJSg1X4nMR0vOJ6CRG+Uktrfa37AYVBJpFOsgcz8Y1PcaTErj617JcJV7ihs7ytDf5hhevES5llPHum6kyIvR5/kPRQNeLa4BWdSWBxqaDUwd2AcCc4tyE19rbedPnHVkoyoawbqMmwxZ62kvNJAMFlkObTi3QezL6oE+tkSeJn/3tA/OBfqWIN+Xcj4gkhZ+TqV7nprT4r2GLLCZSOaL1D28lV6r9usqJe271CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8ck5jQHm8HYg/OrbJLHVks5MpInYDVn6SOuaR3fPvM=;
 b=j509d84ReseCE1mOVTXrLXjAERKaNy0SJCo85uOr3/3L+CyuDZmCnicQ6Bvo3byQ4R7wMx0zrvsx9BGqIESjO7WI8eAH9IxYbrYLzrzIy2ILqZpJXFXr0k7gJjZRl8YRmXEWNHvZcknk7yi5D7w8WKJUz6Y9cWYB480SUnRevon+gOHnYSN/jk77WZQXR3b3/vrRROkqQoEoTBaCRNl2ZYUFerDfocWl6nkBWHm9IOZYLhSfVGFbWUtDtAq6v5tkgG+W0b/Xupd9CgAIjScZ/r293Hk8lx+xC9dWX/7qfIX4GYwV+Vi3PymyKZIsHIXtiXkMp2dBHbhZbW2lQZ+rbQ==
Received: from BN0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:408:e5::16)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 21:03:13 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::39) by BN0PR02CA0041.outlook.office365.com
 (2603:10b6:408:e5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 21:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Thu, 16 Oct 2025 21:03:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 14:02:58 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Oct 2025 14:02:57 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 16 Oct 2025 14:02:57 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>
CC: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
Subject: [PATCH v2 1/5] rust/io: factor common I/O helpers into Io trait and specialize Mmio<SIZE>
Date: Thu, 16 Oct 2025 21:02:46 +0000
Message-ID: <20251016210250.15932-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016210250.15932-1-zhiw@nvidia.com>
References: <20251016210250.15932-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a03b75-4157-4bc4-797a-08de0cf76bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VNFkYJSB1hOOnOJTsEGOQQl9alizgTepdeI8vYXcSI9xbBUwLf5xaETbgBeD?=
 =?us-ascii?Q?emOgmTECZkQPUuHOO3PbqHhVvwsG9Wmo66cg51ruK+d5DLoG5U8cQ3cOBDk7?=
 =?us-ascii?Q?Zc5uUGjQjRZlLVydYas9j6XUvR/vvXNFc6ACu+3APn2kYqGfgyp/6dp1xcRH?=
 =?us-ascii?Q?yVl5Npr616sOLm0yB6iMUR/HqemJodfdpHXtIAakyelhH5SxVcp/CIdNt3W1?=
 =?us-ascii?Q?TOrLdXuYCmt7pUGsl423/e8XycDTTyVUvozVzteHIYfgrC8RMtIwTekmsRED?=
 =?us-ascii?Q?Bze9JnNjdB5WU8hkJLkmKQsWesoLi/nXkM7lLOkPD6Sku9NS+nBJajiRZM2D?=
 =?us-ascii?Q?o8/Oj2HOau76/Fbz6qJyCYo8B441xSZJlHbp2J48e+dYPhsHuW8LCidsGMxF?=
 =?us-ascii?Q?+tLGQHIX70B2Hn2BH0ID/486i6UHYIDvg8rMGjO5dFMrUYb+9TGcKskHcVhS?=
 =?us-ascii?Q?E4Sk/nSuHpQLH5vaPx4ziKBwPe84rbG7DeDoLomVO5iT5ma7qkCxCf32BQ49?=
 =?us-ascii?Q?j6mjDgQzx/D86wAOwZn5byP9tax4QvgVNz0122ios/xEqTncNq0TUjFVhzUH?=
 =?us-ascii?Q?wZzverRJ62TQQf69dr9Gtt8CJENdHFyPqErVgUWL+jgukeQvub9Pk3WHSx1j?=
 =?us-ascii?Q?awyFYXRLnOLqOF35eANytJXQw9Ut1tlvRS6aBJomgJHz9f9RDpJsIlov0sS4?=
 =?us-ascii?Q?ootXZFoiEOLIyTItbb3dL33/MiwELKwe1PNia3m1Av8iApZ2b/sWF5IO5OIg?=
 =?us-ascii?Q?yNeNrW5e9gKYEcEuybzEXma08FUCBgy35cf6ZDSdabd/slcnQfYHBVdEbn3D?=
 =?us-ascii?Q?o07/iXffNff1mDQMu7HQg04PzL1vmE1UHmOf/T3hBpuoKtBnBZS98v+HACL3?=
 =?us-ascii?Q?9b3uOYRUkTe4GM2V48W91cyNsZ9IWi/CYU2aF5WD4jrWljN1fQDY8i7mYX1l?=
 =?us-ascii?Q?qgXoBfa8JTYIdyOCP0tu9KMuyO47BHInn5+mbm3H9Ujp0iEqNYDLRz+afSOp?=
 =?us-ascii?Q?zbxdVYA8oA7MYFa6GOoNrx0OY2bkNwakePHzfHzRgOselCUceEeLTefdFBvx?=
 =?us-ascii?Q?49QnDCYY3QWXaZDnn/qq5X58JtOuMIhi69n0t2U26dusRzRKaPnwaDVd1BAc?=
 =?us-ascii?Q?r6PgGuIyskNy6L/JvQ/+8nNl6FRP870UmXDNqiWBYzpaOvkjPrbF/FD7nxc7?=
 =?us-ascii?Q?IbM7P6r/xpwzglxnPPOgsbHYsXV/nZRNdz8SDxF95RLdAex8fLenLwC0QsXu?=
 =?us-ascii?Q?bx21w1uqarz0LeqqEGD8rsNWhm+v5WjwozR1OaaVe6HAqJLMAgXVWKjeore1?=
 =?us-ascii?Q?NaTrpC2AmBuuPUZPW8CHcZ53ZjIF2G9bkilq9Z56YqkyyyTcnZ7r300WnbiJ?=
 =?us-ascii?Q?dU5MoLuePKg5Er7ggbHpk4m1ZMyT5pV5hcSu1auu8id+K7utd7I7RrMCbAyq?=
 =?us-ascii?Q?msQTW+Pe2uoPUxXaXYC/HHIfpF0JS0KObhcEuxVTgxeFJ/EaD6o38PnaMnrs?=
 =?us-ascii?Q?B/xARpeP2PaTkRCLeuj0qRbOFuVVeijmw9egAAkJwzxjEodx9/DxykQ3AseO?=
 =?us-ascii?Q?7KeIMhkpv+hgUhr/280=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:03:13.4921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a03b75-4157-4bc4-797a-08de0cf76bb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166

The previous Io<SIZE> type combined both the generic I/O access helpers
and MMIO implementation details in a single struct.

To establish a cleaner layering between the I/O interface and its concrete
backends, paving the way for supporting additional I/O mechanisms in the
future, Io<SIZE> need to be factored.

Factor the common helpers into a new Io trait, and moves the MMIO-specific
logic into a dedicated Mmio<SIZE> type implementing that trait. Rename the
IoRaw to MmioRaw and pdate the bus MMIO implementations to use MmioRaw.

No functional change intended.

Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/regs/macros.rs | 36 +++++------
 rust/kernel/io.rs                    | 89 +++++++++++++++++-----------
 rust/kernel/io/mem.rs                | 16 ++---
 rust/kernel/pci.rs                   | 10 ++--
 4 files changed, 87 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
index 8058e1696df9..c2a6547d58cd 100644
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ b/drivers/gpu/nova-core/regs/macros.rs
@@ -609,7 +609,7 @@ impl $name {
             /// Read the register from its address in `io`.
             #[inline(always)]
             pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
             {
                 Self(io.read32($offset))
             }
@@ -617,7 +617,7 @@ pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self where
             /// Write the value contained in `self` to the register address in `io`.
             #[inline(always)]
             pub(crate) fn write<const SIZE: usize, T>(self, io: &T) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
             {
                 io.write32(self.0, $offset)
             }
@@ -629,7 +629,7 @@ pub(crate) fn alter<const SIZE: usize, T, F>(
                 io: &T,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
                 let reg = f(Self::read(io));
@@ -652,7 +652,7 @@ pub(crate) fn read<const SIZE: usize, T, B>(
                 #[allow(unused_variables)]
                 base: &B,
             ) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 const OFFSET: usize = $name::OFFSET;
@@ -673,7 +673,7 @@ pub(crate) fn write<const SIZE: usize, T, B>(
                 #[allow(unused_variables)]
                 base: &B,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 const OFFSET: usize = $name::OFFSET;
@@ -693,7 +693,7 @@ pub(crate) fn alter<const SIZE: usize, T, B, F>(
                 base: &B,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
                 B: crate::regs::macros::RegisterBase<$base>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
@@ -717,7 +717,7 @@ pub(crate) fn read<const SIZE: usize, T>(
                 io: &T,
                 idx: usize,
             ) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
             {
                 build_assert!(idx < Self::SIZE);
 
@@ -734,7 +734,7 @@ pub(crate) fn write<const SIZE: usize, T>(
                 io: &T,
                 idx: usize
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
             {
                 build_assert!(idx < Self::SIZE);
 
@@ -751,7 +751,7 @@ pub(crate) fn alter<const SIZE: usize, T, F>(
                 idx: usize,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
                 let reg = f(Self::read(io, idx));
@@ -767,7 +767,7 @@ pub(crate) fn try_read<const SIZE: usize, T>(
                 io: &T,
                 idx: usize,
             ) -> ::kernel::error::Result<Self> where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
             {
                 if idx < Self::SIZE {
                     Ok(Self::read(io, idx))
@@ -786,7 +786,7 @@ pub(crate) fn try_write<const SIZE: usize, T>(
                 io: &T,
                 idx: usize,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
             {
                 if idx < Self::SIZE {
                     Ok(self.write(io, idx))
@@ -806,7 +806,7 @@ pub(crate) fn try_alter<const SIZE: usize, T, F>(
                 idx: usize,
                 f: F,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
                 if idx < Self::SIZE {
@@ -838,7 +838,7 @@ pub(crate) fn read<const SIZE: usize, T, B>(
                 base: &B,
                 idx: usize,
             ) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 build_assert!(idx < Self::SIZE);
@@ -860,7 +860,7 @@ pub(crate) fn write<const SIZE: usize, T, B>(
                 base: &B,
                 idx: usize
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 build_assert!(idx < Self::SIZE);
@@ -881,7 +881,7 @@ pub(crate) fn alter<const SIZE: usize, T, B, F>(
                 idx: usize,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
                 B: crate::regs::macros::RegisterBase<$base>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
@@ -900,7 +900,7 @@ pub(crate) fn try_read<const SIZE: usize, T, B>(
                 base: &B,
                 idx: usize,
             ) -> ::kernel::error::Result<Self> where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 if idx < Self::SIZE {
@@ -922,7 +922,7 @@ pub(crate) fn try_write<const SIZE: usize, T, B>(
                 base: &B,
                 idx: usize,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 if idx < Self::SIZE {
@@ -945,7 +945,7 @@ pub(crate) fn try_alter<const SIZE: usize, T, B, F>(
                 idx: usize,
                 f: F,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
                 B: crate::regs::macros::RegisterBase<$base>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index ee182b0b5452..78413dc7ffcc 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -18,16 +18,16 @@
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
 /// the represented MMIO region does exist or is properly mapped.
 ///
-/// Instead, the bus specific MMIO implementation must convert this raw representation into an `Io`
-/// instance providing the actual memory accessors. Only by the conversion into an `Io` structure
-/// any guarantees are given.
-pub struct IoRaw<const SIZE: usize = 0> {
+/// Instead, the bus specific MMIO implementation must convert this raw representation into an
+/// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
+/// structure any guarantees are given.
+pub struct MmioRaw<const SIZE: usize = 0> {
     addr: usize,
     maxsize: usize,
 }
 
-impl<const SIZE: usize> IoRaw<SIZE> {
-    /// Returns a new `IoRaw` instance on success, an error otherwise.
+impl<const SIZE: usize> MmioRaw<SIZE> {
+    /// Returns a new `MmioRaw` instance on success, an error otherwise.
     pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
         if maxsize < SIZE {
             return Err(EINVAL);
@@ -62,11 +62,11 @@ pub fn maxsize(&self) -> usize {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, ffi::c_void, io::{Io, IoRaw}};
+/// # use kernel::{bindings, ffi::c_void, io::{Mmio, MmioRaw}};
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -81,7 +81,7 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -93,11 +93,11 @@ pub fn maxsize(&self) -> usize {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Io<SIZE>;
+///    type Target = Mmio<SIZE>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { Io::from_raw(&self.0) }
+///         unsafe { Mmio::from_raw(&self.0) }
 ///    }
 /// }
 ///
@@ -111,7 +111,7 @@ pub fn maxsize(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Io<const SIZE: usize = 0>(IoRaw<SIZE>);
+pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
 macro_rules! define_read {
     ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident -> $type_name:ty) => {
@@ -172,32 +172,24 @@ pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
     };
 }
 
-impl<const SIZE: usize> Io<SIZE> {
-    /// Converts an `IoRaw` into an `Io` instance, providing the accessors to the MMIO mapping.
-    ///
-    /// # Safety
-    ///
-    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
-    /// `maxsize`.
-    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
-        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
-        unsafe { &*core::ptr::from_ref(raw).cast() }
-    }
-
+/// Represents a region of I/O space of a fixed size.
+///
+/// Provides common helpers for offset validation and address
+/// calculation on top of a base address and maximum size.
+///
+/// Types implementing this trait (e.g. MMIO BARs or PCI config
+/// regions) can share the same accessors.
+pub trait Io<const SIZE: usize> {
     /// Returns the base address of this mapping.
-    #[inline]
-    pub fn addr(&self) -> usize {
-        self.0.addr()
-    }
+    fn addr(&self) -> usize;
 
     /// Returns the maximum size of this mapping.
-    #[inline]
-    pub fn maxsize(&self) -> usize {
-        self.0.maxsize()
-    }
+    fn maxsize(&self) -> usize;
 
+    /// Checks whether an access of type `U` at the given `offset`
+    /// is valid within this region.
     #[inline]
-    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
+    fn offset_valid<U>(offset: usize, size: usize) -> bool {
         let type_size = core::mem::size_of::<U>();
         if let Some(end) = offset.checked_add(type_size) {
             end <= size && offset % type_size == 0
@@ -206,6 +198,8 @@ const fn offset_valid<U>(offset: usize, size: usize) -> bool {
         }
     }
 
+    /// Returns the absolute I/O address for a given `offset`.
+    /// Performs runtime bounds checks using [`offset_valid`]
     #[inline]
     fn io_addr<U>(&self, offset: usize) -> Result<usize> {
         if !Self::offset_valid::<U>(offset, self.maxsize()) {
@@ -217,12 +211,41 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
         self.addr().checked_add(offset).ok_or(EINVAL)
     }
 
+    /// Returns the absolute I/O address for a given `offset`,
+    /// performing compile-time bound checks.
     #[inline]
     fn io_addr_assert<U>(&self, offset: usize) -> usize {
         build_assert!(Self::offset_valid::<U>(offset, SIZE));
 
         self.addr() + offset
     }
+}
+
+impl<const SIZE: usize> Io<SIZE> for Mmio<SIZE> {
+    /// Returns the base address of this mapping.
+    #[inline]
+    fn addr(&self) -> usize {
+        self.0.addr()
+    }
+
+    /// Returns the maximum size of this mapping.
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.0.maxsize()
+    }
+}
+
+impl<const SIZE: usize> Mmio<SIZE> {
+    /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
+    /// `maxsize`.
+    pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
+        // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
+        unsafe { &*core::ptr::from_ref(raw).cast() }
+    }
 
     define_read!(read8, try_read8, readb -> u8);
     define_read!(read16, try_read16, readw -> u16);
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 6f99510bfc3a..93cad8539b18 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -11,8 +11,8 @@
 use crate::io;
 use crate::io::resource::Region;
 use crate::io::resource::Resource;
-use crate::io::Io;
-use crate::io::IoRaw;
+use crate::io::Mmio;
+use crate::io::MmioRaw;
 use crate::prelude::*;
 
 /// An IO request for a specific device and resource.
@@ -195,7 +195,7 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> +
 }
 
 impl<const SIZE: usize> Deref for ExclusiveIoMem<SIZE> {
-    type Target = Io<SIZE>;
+    type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         &self.iomem
@@ -209,10 +209,10 @@ fn deref(&self) -> &Self::Target {
 ///
 /// # Invariants
 ///
-/// [`IoMem`] always holds an [`IoRaw`] instance that holds a valid pointer to the
+/// [`IoMem`] always holds an [`MmioRaw`] instance that holds a valid pointer to the
 /// start of the I/O memory mapped region.
 pub struct IoMem<const SIZE: usize = 0> {
-    io: IoRaw<SIZE>,
+    io: MmioRaw<SIZE>,
 }
 
 impl<const SIZE: usize> IoMem<SIZE> {
@@ -247,7 +247,7 @@ fn ioremap(resource: &Resource) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = IoRaw::new(addr as usize, size)?;
+        let io = MmioRaw::new(addr as usize, size)?;
         let io = IoMem { io };
 
         Ok(io)
@@ -270,10 +270,10 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for IoMem<SIZE> {
-    type Target = Io<SIZE>;
+    type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: Safe as by the invariant of `IoMem`.
-        unsafe { Io::from_raw(&self.io) }
+        unsafe { Mmio::from_raw(&self.io) }
     }
 }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 7fcc5f6022c1..77a8eb39ad32 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -10,7 +10,7 @@
     devres::Devres,
     driver,
     error::{from_result, to_result, Result},
-    io::{Io, IoRaw},
+    io::{Mmio, MmioRaw},
     irq::{self, IrqRequest},
     str::CStr,
     sync::aref::ARef,
@@ -313,7 +313,7 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
 /// memory mapped PCI bar and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
-    io: IoRaw<SIZE>,
+    io: MmioRaw<SIZE>,
     num: i32,
 }
 
@@ -349,7 +349,7 @@ fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = match IoRaw::new(ioptr, len as usize) {
+        let io = match MmioRaw::new(ioptr, len as usize) {
             Ok(io) => io,
             Err(err) => {
                 // SAFETY:
@@ -403,11 +403,11 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for Bar<SIZE> {
-    type Target = Io<SIZE>;
+    type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
-        unsafe { Io::from_raw(&self.io) }
+        unsafe { Mmio::from_raw(&self.io) }
     }
 }
 
-- 
2.47.3


