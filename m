Return-Path: <linux-pci+bounces-40771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D238C493E9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C683B0FFC
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34922F12CE;
	Mon, 10 Nov 2025 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="adItKvrS"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB78272E56;
	Mon, 10 Nov 2025 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806646; cv=fail; b=QRRr/l1B0WzmO1LpDpkG5SlffusuduRkMG5NYmWA30blfKGELMdXdt8aFX4hk75UE7k7djcKPubvD1RmIo44zfhz8qffbZ+hz+Tuk9rJcjzeGitCPJqVjO91kWxGja8VKLqBz7mYCOMtS+g9auZ81FLkHj+il1CETH6GMOR0uEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806646; c=relaxed/simple;
	bh=OjmkX9cZdbeTJtC8H/VtuQT13DH2b/srUEiqfaki6RU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8ZtU+3ncCok4LcojXsvfEdLBHtE2k+i9b2MTehHq+H5TEDuPDRlixLG4qKUMvufbNwkpTmvISCdk8qx3wlZQW70zlBRs3jJMlq0LTnWKpuXcyl+c92SxDihZUHxP/tnNxR0Sc7/+DnIp2y6CIp/0Rds7XjNqAiKi7onLNW0lAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=adItKvrS; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTRv8wj0SP4ZTzCgHA46W2iiADinYtKqDS5cBPtgyZXuRXirFdaNAMwa6RAcB7cMVK3bEFH1jyQvABmMZiuusBIYaat/34HGp+crLt3qX06xpj5kinGGLcy+z0WyPBTZKXNOk6gdQSdEbgPaeQs8an09pmgBcJft4t+ybrmGtyvjIZrU7dpw9yj22nq2Y8Rq3SaHyRgVsAA9IHcbD4mxeVaG3NVzuhTCrpP9UDbiDTyHhIG2SDXfHWeea2cSTCBcXqOSNhSQpq0wptsFTTAq1MTQtLcZvkyVeOQlceSfh87XzJsIK0QbLhrbKz2eLrf881qy3Sv3zNOopjugv40Fpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+x7tNPZSP1pwYR5mUookBrzPncXbJXt/+lUQQ4Gm1U=;
 b=CqrRY3nsC0IRTcWTyY5qyhQjIHTBZY5vWqvYrVxITd7lQfHNUI075pwrimCfEvU/IAc4C65rBL1ms78GGQB0sLTAg+GkDVCRshz1gX27+d/yMEI/z79Gh8xeXaIUdu3I5Ah73wZ2sC7R0cuTlOK1XjBTTDi+ubIzm/98WRvWFn/5KQR/MJGrjPGiqDUAmvrDtEiEOyHn5zPP4yN0j7BjY/Pd2eBd0L0D6eVZk7VjfKJengfcQVWrtHAGV7HercFD31pg5Oq5KirryjC3bjo01d6OiVSnOSOKD9hDKfRBGHmPTOg53ssIHUYYRI3eKQ3KiI8jR927EvOg4ry8aTs76w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+x7tNPZSP1pwYR5mUookBrzPncXbJXt/+lUQQ4Gm1U=;
 b=adItKvrSl0g/0LlTn3Lo9/1p7zdZZqMr1bgBR3jvg6c1vmyXAHSNqrpDVg3SEe/keqt50x/2va9zPumXvgAKeFPQR8/UeATBNm2fPrLHdytQOV60T9tS0FsoKa5HoiA+LbBvMXSZtjnX6Vbno8Qq1nPQaZQ1pkQ8PW0QUHD9CYe1nLx7dOZ7jrrczvEDKQbKvAIunEUrlEw2mUbqe5HT8FG+LDjm/Qicw3xWCmzA2ui2X8pQBXdOLcTSzKT7jan7iwDyybsfl8LatCsmun7BLJktGvypswfM4U69i2ocjWrAs665wYSRj8h7pqA567ZpdGtIjKBu8e5YzbyWfwud1Q==
Received: from SA9P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::20)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:30:42 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:26:cafe::e6) by SA9P223CA0015.outlook.office365.com
 (2603:10b6:806:26::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:30:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:30:17 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:30:17 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:30:08 -0800
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
Subject: [PATCH v6 3/7] rust: io: style for imports
Date: Mon, 10 Nov 2025 22:29:35 +0200
Message-ID: <20251110202939.17445-4-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d60c46-48ba-4c84-4164-08de209804e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7sfpra0OZbeKMjs36Qnoxfz/tPPNVbs8FaDsBjO/ZDXY0YD7WTsfJYv+EgM8?=
 =?us-ascii?Q?HGuSVCw4l8h71A1TqUa1Z2Eo/we0lbKTGX8zUEiuQT7fATY3Rr9REerUjxfX?=
 =?us-ascii?Q?c7wjOtLd/gmeF7AzTqYYw1139l7fqvvidANjZKGub4+Ay4YtIw2kNWQtlmYJ?=
 =?us-ascii?Q?uqdcvfr9mrQqxsemxxXvoWEcx42zL097lj9+8APzKljvi+qF+Acj0VU1/hxM?=
 =?us-ascii?Q?VgzhCYislXB3uvnYKY7imblnuil+IbOxu2iSYPkDhFqCrYxNPFAB0UyXKDmV?=
 =?us-ascii?Q?Gp1pC4nfQ7mK314Q1J9A4J0nDUYCrzv521vYHcjfi0o0jxMADOP0pcyMgrX9?=
 =?us-ascii?Q?mluRHlqwTnctdjHnoAHlrMgSOwIII4jJMiqBiQe85Goakv1i9n9YhaRW60oD?=
 =?us-ascii?Q?WACa+tmF36A8sLoEdJSngJMUteUVYnohM8jIR0GIxmF4YmQzXe50ehgpceUM?=
 =?us-ascii?Q?4q+QUR7FspOlSo2sk9KosAgG2gpTNhlG4785pQIT9laeruifgmAnT3HPgdkk?=
 =?us-ascii?Q?bT86EYdtv9aVK1+d/IAxYlobrTjVB6UeMY44Dz+197g8tdPkoITlPTpsCQXL?=
 =?us-ascii?Q?Jhxff+NkaEdvizqMp5Cni2hvkFyBEhmenEXKRoJNIyoyn2aUHHRsWsYFgAUd?=
 =?us-ascii?Q?7DiviBMvGI38MgGqCp7l4y4P3fa13OmdCU3JwjGNeGzIcpfmbcfpwE8kVRVV?=
 =?us-ascii?Q?r4Atwd7Yo9VAg7qLXJlOIzCRZC3yCr2vYIta4rUlsgLnSNVdXRkyNn4+BWNc?=
 =?us-ascii?Q?t+q+NS4XIvGDBe0ri1kEwey5+/SDYhLftlPIQXzROMmmNwzP1PI2MvtQrA9V?=
 =?us-ascii?Q?R9RvKh+sBy7e+gYGvqWp5Xs0wopRr1H6RwMJZwtXDV2dm/x7P5Zqoix/mDj/?=
 =?us-ascii?Q?bSbKKydeazAIJB6srTXVVZTrYlmJHw6EDsfgMKkzSWo+K96xdQ93KErW7KvV?=
 =?us-ascii?Q?StGfiAQiwS8eYYYL7NnSDFP9TwMwROevQDRt572+NFzL30Kbix6tCd0SIiER?=
 =?us-ascii?Q?Q611++KATwuYrH3vzPQheViDEbjZKHCr/ui91qyK52i6CHYomHZFhnh5NQak?=
 =?us-ascii?Q?KkIllh7vhuqScmsirVNgneWVL6QmgsFreT9Lrs0Z6Yw7N15vGBGOA66brmo5?=
 =?us-ascii?Q?9Fw6/cZ6qaeMX5KajoHXNhBbMeLsLRv2OTga/kAK5xJSJSma55yIvkw+g1+o?=
 =?us-ascii?Q?7jg6SFakFAcRzCjV5ZnUQY0EHvYCp431lAkSGAzdw0uFpe7QDVCu4tCeqGKg?=
 =?us-ascii?Q?AAJh8mDSkOo7h0dzGXIslVoEG5sL+6a+DCTmUck9xtpLrIWilb9SGSTXzXub?=
 =?us-ascii?Q?vMCJm0Urin19bg8b8EQvpXedonKuQ5porYOob5R5+uQxzjIYTnRUEkkN7w/V?=
 =?us-ascii?Q?Lan0NF1yjEUidU4+7DbLxTAxrIEmPkCXT2oLa72inXdl5JELnaVhT8u02s8q?=
 =?us-ascii?Q?6JOgUrJVh5BfShAWlmy3MyPt1jxD9SpRBmUT7c6pvKDJ7S1pzrwqQm6ABlc8?=
 =?us-ascii?Q?MWoRTj0WD3zkNohXQAYDhrPAi0/tKcs/5Xy0ivL59MkdsiK8LlEvsCqDzAP+?=
 =?us-ascii?Q?iu8ftAKFU2JkYT3inVc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:30:42.0912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d60c46-48ba-4c84-4164-08de209804e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436

Convert the imports in the commit in io to use "kernel vertical" style.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/io.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 1aa9495f7774..5af04c3b807b 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -64,7 +64,14 @@ pub fn maxsize(&self) -> usize {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, ffi::c_void, io::{Io, IoRaw}};
+/// # use kernel::{
+/// #   bindings,
+/// #   ffi::c_void,
+/// #   io::{
+/// #       Io,
+/// #       IoRaw, //
+/// #   }, //
+/// # };
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-- 
2.51.0


