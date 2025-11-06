Return-Path: <linux-pci+bounces-40485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC84C3A465
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 11:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594723B00BA
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7B12DC346;
	Thu,  6 Nov 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cW+sLbxJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012040.outbound.protection.outlook.com [40.107.200.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42362DE711;
	Thu,  6 Nov 2025 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424935; cv=fail; b=UWsiu5uz6ndj20wDDBuo2lc1oyYYm554bRNEtRB6nVfXrRMpzHBZlQZO29Nxk3bDAzJZIwG/IiKhE4YQN7WttHrl3qcqi9r0JyCWxaT/EfuHVtizafeUhYVexz5V4PRIBBE+xEJYEQW6z2Xtn6yI1FU+AlrgdYeApFQnQCzKpv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424935; c=relaxed/simple;
	bh=tKDBxG3e6MoAesYciefNra/nh4DPjrp8k4A2slrdbrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpASr6C+3xXIaaeRSUZBGgSo6NAgZQ4ouNySHUD40Y9HqQNaEiLnsgEG5b7tEQ4VxXqnhdnoZrc0KPD18BS/oqyKmFMGdqscTp6Tv66JOlhKKCaYAj3iHtPJiQ0nK0kXVXAKVfSdp8UsHbSeiMSPWJ+8stw4Q4/JvKmcaCklGLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cW+sLbxJ; arc=fail smtp.client-ip=40.107.200.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7x7KPBnkMa8XcLBn3Yqr213Jj92OegIGsLWfV6bhJXFjA1KuF679bQQrJi2J1o6VD78pIwSKNzGFhHCrBlT+x959TFn1YB/WSqwp7kAlMjPcS0IfU4xwNc9qIYVToCPeNCllnp51LrbOQo86ODD/BrZDcA63882FgmiQ0XS1+ZMOWDDDk0M4gMfb9KcZW9fAA4M4+qaOZw793Zm9p2HKyQbBGZpnZZYQuzEoq91iHbQo1IWweoVOiNSye3g+x64kI8Oflp6UaFMKxI3HR52ZqNp8ZlMff4Rs90N4tpPstjUdsbm6g1p5CQCyBVSL6V91isEtS7lF6bkkSa4W3fmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8r/7njniFBJ58aIWqD031fcvnWshNpwknOtcJZEWxs=;
 b=J3xy2toWyBjkdq3pG3FU5VrdEjo2pg86NCds3++iFHAk/WKrmszhnA+tXCwKrd4O/BPgy/fm24ZYml8SFDPanz+ivbUisIDz9Z3/mPiwZIYcM/mJxKtCAB6cL6TBxQnFy+GJDuy7NguJ7QVHARUd1IUseRYPQOFBq+U59dF4/z6OAP1LkzGweZhrhLMGxiaLtfEfAhYJqnOdlYIl+E5xKQDXGEGctjm+vQb6H9JRoKr3j7rY3kGULbNBPNQcnpCf2cXGoUIRQnmFpH43Q53JZuA3BzbiJzxeTN8isC35pmHCp8iSMgQQXNvKtJsRUhGcGibiE+S3/oKvkbDB8F2teQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8r/7njniFBJ58aIWqD031fcvnWshNpwknOtcJZEWxs=;
 b=cW+sLbxJ016rtwiD0cP2KnBjz9wmcCH5q4oPCdB5abza2sh62T0sfhvZizOc8mYxUlOn8s/Q8ovm48gNNNxeBaIVipy5rXEAdup+gKJq85y2uRjhctVG0mtD2yM+KJfz79gi6fJPqcvl7YDoG26Nn6GOrBMUhCFdvSARagXE3cNJfu+8Akld0ZrqsKOcknt93pvblaZpZEO0/cKpMQWCDtjnv2zJ7GNmMS3aUzk/hJHkp6TrtFp3dQm4cHrczcHW3XvuW51GNFKSRuKH1OD5spXP25MY2lF4yYasFU8cCqol2rZvQqQiAJGRNU41yRZTIK+YvhAC5y5hGsMgmFeYLw==
Received: from CH0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:610:77::25)
 by IA0PPF6E99B1BC1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 10:28:48 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::e) by CH0PR04CA0050.outlook.office365.com
 (2603:10b6:610:77::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 10:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 10:28:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:28:35 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:28:35 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 02:28:25 -0800
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
Subject: [PATCH v5 2/7] rust: devres: style for imports
Date: Thu, 6 Nov 2025 12:27:48 +0200
Message-ID: <20251106102753.2976-3-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: b577c515-4c52-4845-a8ee-08de1d1f45cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ENxH5NPFtvtzhuuQhpaEAcFWsaUeag78iwkJS7RsFj6E9PH/9dy9voUzka/P?=
 =?us-ascii?Q?BeSwQwAlx/5j9Lc8tErB/pi5Y0DRMKK4LKVxSHbmugn9dD96uckym2kb8bhk?=
 =?us-ascii?Q?oH0L2MJLQYCVmBZ7+OfyHZzMER8Zx6J5FvBE/GX11gvHmPV6q/fH5iOawPn+?=
 =?us-ascii?Q?Ywj/JYBlo1x0pRYYMSZ/BzZ/Rju4IIVB5L3zPTaRw+1k6oeT3AaM6CfJ9U6Q?=
 =?us-ascii?Q?LLLT6adCFzApbpeEH/27sYKy8tYf4L7tMeIBhaQB7Gfk0KFrI08AfkPnd4S6?=
 =?us-ascii?Q?YdzO6BwMvoJPgQ2HjmU8DDlxeUMq5eEcvl2jwq3J93M0/91D7DmiYSeIX1d2?=
 =?us-ascii?Q?2T5kDmjEUpwJLqs6otwoKdWvCANplTfD8vEn0NFrZia0Lhn9syrQB4cwPUu0?=
 =?us-ascii?Q?FYuFEWJU9r7v/JGQ0aLCb5vqltRHCT1E5gAzLe+pU+ySemHr9LJzYmCHR9bm?=
 =?us-ascii?Q?F7QOCLcg5+4ZJG6lPjzogOBWuvDyP9G/XViVoUmF2s70bJsxwrQg1odBJb7k?=
 =?us-ascii?Q?A7DSf3Oi/NRhXKGJP6VzzDAJL05UlVM3WoRRKykmtn5TruD9zYW528UIrX+R?=
 =?us-ascii?Q?UtVVoikJj0lY4K4LZJqursoWVZxv2xG7MctJyROS5XPLoz7ZdkNUBMeEDamG?=
 =?us-ascii?Q?rXjDfq/h3sgvM/DSPsO96JOx3mK6m6OvQ4fo8+MJ5xDPMl1etTia5lRUGF0G?=
 =?us-ascii?Q?7xTnFXXKL/327aT/FZ8hOIB+ylm9Bsz9f88RwuK2eEDxdyzAMoLL8O5udhvP?=
 =?us-ascii?Q?GW5ORp5wrRGucZKQItiu2QcknHNUc9PTYWVdecc/fc8Sebt3CSooRDwW17/W?=
 =?us-ascii?Q?PSUhEQo4erdovdV6fRXbcuZ2k8wwKYwi4GMmUnSmV4kpUcb5zn8bqzntho/C?=
 =?us-ascii?Q?UWULUfJcgBIvXiu1MNsioV0odGxyF2dHWGSW8PL+/1A3gF8cLsi3ymb/C8pX?=
 =?us-ascii?Q?R6YMXl8aRxvi/y8tBYMnO7xAW+7ZsidthIL7NieLJVMEVlQvuk1qoa/FcYQ9?=
 =?us-ascii?Q?iq1jn/+6T9IdVFhFcTJL6wg8IcRo+cJ3RuLohvk2k2g3q52+gC5rLklfoiC4?=
 =?us-ascii?Q?2aFzpSJ9PXxDftYykC1wK2FaY0foVN12oPoWn4KIv80vn1Lmgwmh53VgbEzg?=
 =?us-ascii?Q?qWPO50Nz6gabD5ZFXP14Um3Jz1YAQeT08ABziLl2r6owvpAnCBGF1TnNEzIX?=
 =?us-ascii?Q?ddSzDRy4fsp6UEcDJEvPEQiFVrjcqB5zvsJfwLIYBuJkDMoVCcQ6iKHkE0bp?=
 =?us-ascii?Q?kshDYclg06f84F0brKFb446DJPQdqdLoZ+sVcCZiGTRF5fZj0BlOzi4706/z?=
 =?us-ascii?Q?mhgfkJdzezK2GKuhXQ9CWDYtqkw/AiXK3Ob+dQSP9h/rUYsh7HYvUwV8wNqo?=
 =?us-ascii?Q?yOU7xxP/etwvxmD9GG0I1upAriKU/+mQO67vFTlaXhkFXVjbQZNK5Bdl5GNl?=
 =?us-ascii?Q?Dzt+zyt0AT1Eujs94obKzQ5fd7LJ+wUsTpQwpB7ofBmziMqiT2ucYuKvqY4N?=
 =?us-ascii?Q?HGyKK+GZrkG06713cSadocLRvgZsBJwGHOa9ZWJOgNFODm0xMASZCwg93/+M?=
 =?us-ascii?Q?XUk560LGMLeg7/HEiJA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:28:48.3968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b577c515-4c52-4845-a8ee-08de1d1f45cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1

Convert all imports in the devres to use "kernel vertical" style.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/devres.rs | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 10a6a1789854..d4f3169248df 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -52,7 +52,15 @@ struct Inner<T: Send> {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, device::{Bound, Device}, devres::Devres, io::{Io, IoRaw}};
+/// # use kernel::{
+///     bindings,
+///     device::{Bound, Device},
+///     devres::Devres,
+///     io::{
+///         Io,
+///         IoRaw, //
+///     }, //
+/// };
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
@@ -230,7 +238,11 @@ pub fn device(&self) -> &Device {
     ///
     /// ```no_run
     /// # #![cfg(CONFIG_PCI)]
-    /// # use kernel::{device::Core, devres::Devres, pci};
+    /// # use kernel::{
+    ///     device::Core,
+    ///     devres::Devres,
+    ///     pci, //
+    /// };
     ///
     /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result {
     ///     let bar = devres.access(dev.as_ref())?;
@@ -333,7 +345,13 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
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


