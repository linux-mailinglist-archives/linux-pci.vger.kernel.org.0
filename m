Return-Path: <linux-pci+bounces-41601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E12EBC6E3AD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 12:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84FA3356977
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 11:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4F032F74C;
	Wed, 19 Nov 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZMSDCJCN"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130303538A1;
	Wed, 19 Nov 2025 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551321; cv=fail; b=HWHKvBlzhBlagr5zPRo+VdsO3OFf9Zwmr2KjhZA+YmoD6RIGWpwiVaMDJX3M3jJiERlVBcCKnQlTkpeB51CAsJyAY17AOPFx/5O928SoGCtuCg9dD5M9dvdaHxGbd4AIECYazdPsvz2P933UvvGaZ4NawntsE+w04zOobNRi2io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551321; c=relaxed/simple;
	bh=pmufUxO4slioaJ2XtjP+dPrsPcRDjxS4Yfvv2hMe+R8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7FihtBqqb/jH/h8hvwOoc5bAH8mVRqNqpwT7MbpMvDPLwotkPL0YtgqUi6y63/Jnp3R73Vq9tnw8W+hND5eNVmKVqmSdv/B4841aT8eTHnWYzlU34Lt4hHI6v4UIQ45/3LuO6arZDWCJ5IM0+zvDuNRSnIgOuOJb1IEM3Y4mAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZMSDCJCN; arc=fail smtp.client-ip=52.101.62.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fxt9TPP8EbjAcD+0tdqXyDRxov4mTK1AGs3gum7PdveTVNFag6B2t98QsrSTpneDUR08i/BdlM1g9uQGpEi8V91t6s8EiibYB+tq6VKhqzzn/RTs8WVg4cIgxOeMePARRoaV3lMtKKtWdmU0ZHOMD/oPJx1TR5kGwVDgqRv6Ut+Ki5FiyPfy+1HDGxQ48HdZ2tP/lcPcv5yZMRKIZQ1ON7hM1ogJic9oE+0a0uT4iOUk6hCcefIZyEvSk/+xZfnJp8QLB1JRfTW19OwyDQ8/b8G+AXgMX6PYsuLbffVR+Sqs4a3S+tbJ1VQfAjlikRdAXhEVTYm07onQCOpLR2IS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHnxk5gTlMEwwObcrUO522PaSj/dgW0lDqaTDSNRIx8=;
 b=iyUhA+zN0xfWmWRRDfY1aTWXXovVm/JX06k4aa+jr6WuSFYraACeoOk4vuDRQKbn7FaDGUqc/yxf1Jmds8yMj7tTQw/Dehh2Q6LLtpYdXeyL0Gj9yMnQV8At9Num75xjx7hxZUmKrbTaner0PEivlvSJnUDwPUnCee6TQBTp6jpAh+CbsbLYbnvLIVcwa8Bh9tTM0SV2LMAksfE4Y7xqwG6s3ZNBIZ2lIO5jyyjHC+rgBwQnbE8EgSJAf7wexRfVvGPbs0BGGgjZUA2kz/gzFsDsENX1p07k5jVNrNZq69tYOEgS/iR/Fk7i9e/ifwTAYPGmqR7FfqXxv67R/E+n8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHnxk5gTlMEwwObcrUO522PaSj/dgW0lDqaTDSNRIx8=;
 b=ZMSDCJCNi5U1u5Ng9kZophm07UgVqWTXr3sLZwV1E3roja50S+2/zkRUjO2EZss64CNdUTK98PkuRniw3oUovhYY6zuluqX5R1IWqV0AkZoHQf1L7r6MP123dQwt7FtYb9wEzOO0NGKFm70yIKmpyxPrlG+KOIqqP5IqXYBdz3Mru41w0I0bE5aaqZ9oQZPibCWAZQNA7vFuhlcFzD55ZmpFCPuJzA/RRjzBnqH/AFKyana5zCu1L/k6nknErNFSyeUBWlTVBpy+pbBzOfFEKlVyMK7lHIQg6LjZ/0lWOJTGGH4YDRDVEfoYvVSDEL38POguvlVz02t8mlUNvOMHvQ==
Received: from SJ0PR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:33f::19)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 11:21:55 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::83) by SJ0PR05CA0044.outlook.office365.com
 (2603:10b6:a03:33f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 11:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 11:21:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 03:21:45 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 03:21:45 -0800
Received: from inno-vm-xubuntu (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 03:21:36 -0800
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
Subject: [PATCH v7 1/6] samples: rust: rust_driver_pci: use "kernel vertical" style for imports
Date: Wed, 19 Nov 2025 13:21:11 +0200
Message-ID: <20251119112117.116979-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119112117.116979-1-zhiw@nvidia.com>
References: <20251119112117.116979-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 53443196-3ef2-40a3-3361-08de275dd8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rT/QiF4Gfuuy3S8WK1VLvZWJj1QAcFknJ087ZzJA0jMK7HF7P1oWIthW4vOo?=
 =?us-ascii?Q?nWtuP2uNU+VIx/9DKTze66e4TbmDsE9dcQj+FV1p1RQGV+mR43IcRSXyAlex?=
 =?us-ascii?Q?n9y4IPiqE0NPjMz6lpzDsWlgOfo4P5jMGuFcHMrv2HvuBbGPR1FULjz3glCq?=
 =?us-ascii?Q?FMfHW7U92zoTowBqIyECnxFYF/VLX8lJKZ7aVoucnt8yMqXYO41t79XFapxV?=
 =?us-ascii?Q?kauPWDe47H/i8Ge4aqEJvz5NqloH4QBu9iIAmD8v7lx8WcIMkPbzUNIoudn7?=
 =?us-ascii?Q?GJFbWLOuFe9biNrVUr3ocJdIDYymA5VSUXRFt6MJSQg3Scv/kRrkKcr/s63E?=
 =?us-ascii?Q?IysHcwIGVAFaA7/sTXYqF7fMmrSX1qned14xDL2gW9xguFiQzrvWqA9hFafg?=
 =?us-ascii?Q?SpR3nMmRyynDVhqtwOAP1YVqVvGZZuEKL3c2JiaWBcXmPSa8QV/TIsf5K/wF?=
 =?us-ascii?Q?iuOC8OA5GNtDEGMhjQ/1Ss47xtIEbKJQpvBvIS/sobI3KWCfxynbdR8C5tpD?=
 =?us-ascii?Q?wRT2ATVS5qy08ye0kySAEWl52M+i/78yPI/ZIzOy9TxfrfALwpK85eTbVGtK?=
 =?us-ascii?Q?2rX+tCClUpE2UBG2yy85z9Iddq7k2s3pQiWdPht1nXcx+yCc2VWuy3TscGT3?=
 =?us-ascii?Q?Ahpbsw3TYuEFLrvO7F4YXRWTc0GIj/SB1SGp1PHjRcqElHAZq3hszkm4xK3h?=
 =?us-ascii?Q?lXiivkEabyfrAgftJsWwh0a3fLsdy5xPCejxwIgRKq3v81fnLKOQQCKgsr+F?=
 =?us-ascii?Q?dW0LoSEVG2TcLhlyrEPBBhatM26V8Z9ZTgq7OvgqApBAO/l2wxc5g1y8CMQQ?=
 =?us-ascii?Q?dR3Z9RZGpl/WszAVjRgLH+5lE3r6kY9f/uSLm1LIEb55n3yjdDS1K011y8la?=
 =?us-ascii?Q?naJI3AJyw0LSy2Ui599wo449QPrkVwwNuEmpMPfnpVRXS7dTAG3EWiZNmgsG?=
 =?us-ascii?Q?mogR21ymxMZPLZaqSP/PN8xEpRh1pXc/0chXk8fdDWgph08wfUe32dqpZe1z?=
 =?us-ascii?Q?koabON64mDUiv0Vg524k6WsF9fVXt0vaXixx56xc9HGziocalRvvAtrGH3FU?=
 =?us-ascii?Q?r2zMi2YAnL0ZczzcTRRL3gKDJ8GEY4dRztcepPXmxAo7CIoyxHWtRx/uhN83?=
 =?us-ascii?Q?8RRyI6OZV9zV46XH4SSFnQnvgcLiv6fJO2oLIYtNq0eVe2eIc/8h3eDe4ymp?=
 =?us-ascii?Q?mz4SX7Ki7/fzH0pZfbEp233g0+RSik8OOl8xrTJ17CqUhBN5x9oHAzKRhPTY?=
 =?us-ascii?Q?Z2PJ4MQmq8Tw/gQYIEJ4tvuy5JA+D0zSYi/kcEWAp5Fblz89fAQc9ofmskFO?=
 =?us-ascii?Q?QFPMocYduhbZR480bS4VF/6ogAGkQGM3oFIvB18fNi0OaczXi+NQsdgO/NgM?=
 =?us-ascii?Q?cAyCaTs9TVgu/vcgShOpFnNia2OhB4qGymXrOVA6rcp29EVifdo0v15Mc2dj?=
 =?us-ascii?Q?+yqrgtuvAYPJj8Nha1rJVbdeWLwR1hhQYz716ufXljhld+TXF/F1T+U2ZPLc?=
 =?us-ascii?Q?IIXx0hNB7Pi1+FJy7qlR29Tudrs/4YOk7avsR4nlWCWkzDDB8YAfjMQoZeTF?=
 =?us-ascii?Q?gK2rLdp1QI9JkxUqdlk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:21:55.4970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53443196-3ef2-40a3-3361-08de275dd8cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798

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


