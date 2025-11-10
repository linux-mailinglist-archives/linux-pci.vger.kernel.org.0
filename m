Return-Path: <linux-pci+bounces-40778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C9C49491
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCFA3AE990
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198302F12C4;
	Mon, 10 Nov 2025 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qyZijZQU"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320B42F12C1;
	Mon, 10 Nov 2025 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807341; cv=fail; b=Nj8qxdPCwqi98AoMpBhboj7iT9gAj7Wsg+JIp48chcUclmhB2tuqEKYDOWYLO/fkSF9eXbvxfQfjL/Cb/S6IqGCtpKCYNZUJZVjJfphLjxvbHQ65IEDPZvjGR4wKu82ULsop3KAUUcsM0EP5zm0Ju1L9+QT02aCintPsI4EbuIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807341; c=relaxed/simple;
	bh=zVTgZSALc9ooOxGC2bIZD2uEHqGZuuDYRPPA+c0p5RM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clr1skrrwyY2jHJN0+84zqQHDUgqd8ju72q4q0kip8idw36rrOA3j6NXUD+537p4mP1Q5xAUK5JJ0EcW/h6pflkqWCXeyvwS+YXktX/zzi8Yq8oy98ivZQSAb04baC6O/w+mi5A1XNdgIcKkNObpwxI427W8K4rgQe1Y5MJq/yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qyZijZQU; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nob/Z3v0OlpqYc9Mbqs9CMZT6zz5WRh7WYrdq/lpk3jPZy4Z5XSLIGRhsCzITbYXH9BjoGyPbMEoxLnxu88oi6x3Rzr1fpiwJfeuzwhsW5QiSED16mAA+133n4mIkX0P/rYgF/jHaLeZTyP295sg4uab4LXPSAtVl3M3lWg9iV2GA62eURMatejnBN9UwpRVckaSRxODNW3UwmLOT6/WTBuy/pqbk6WNc6k+BrC/YHSBbC9aDb0JC3FZEcQ1iKZ5WtEDzIaw9kXnobBDHjYhquj6UprpYB0sTd8Q1/zNvDR9DgxltlEl3AHcnEqGAq8bSuNYgoQdhPkSYlt8HQwhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njgxjY8FvNOeZPk10/Oj2QP56mLXEiR462AtgLUTsgY=;
 b=thNVk+2BaFrDshXvI68Z/InTQQoiazS4nDM07kNoVTDzSB++JwVoC0A0GkiduiDbXrfXZpgLX6OsYO17lSgmlekwXh7uaZrx3H8mFxHfX5Tz9I3aTLwmRib/2uSpEpIEZ1OdnD1ltdebD2hSauUPV/mf21ao2Nzz6eRqmt8h5mPazNNo/aQo+TKVfwaEaO/h/x0YTTxle3Mf9/neYWJRBOg9F5w7soH5EoaxuDzNAp4ovPkdUgzKoEmR0XXo5hy0okYUDZeaGFoKuKcuEEHkxvm1tKLV10basp9MRtvABqCfrldnG1tnGpPL7heCxQuHMcA+4MXXrY0woZeFlma/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njgxjY8FvNOeZPk10/Oj2QP56mLXEiR462AtgLUTsgY=;
 b=qyZijZQUl5UI3sWT6r+Ea7QkRWSiBjPd8UtTDAuJGfq8O68ZTW2w6yIijlRAUxqmJDGizvF/5ak0mkCjFGY5Oq6ubtbTHaHKJh6ZdrNez+Yvk5r1tNHVKpgJPxQsO5D1lDDH78i0ak3MrrXrxG/Gi69QmdI0KlXecEvdlyBfMuJEUplhGc1jR6JGJBh1K1KZx2Cz6ykb4Y4BwoVBDCQg9Xypri6Zor4+0Bf0MiCrcq+SXOwOJeGh6Uk4HxprGjGFuTLvESS0AIAstXwmStI6vnNBVHcOvFBI5o176Xq7FAl395Dj9UflQgxjXky6EDvXPk68RDNr0dsLw1TDn+/W7A==
Received: from SJ0PR03CA0247.namprd03.prod.outlook.com (2603:10b6:a03:3a0::12)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:42:15 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::85) by SJ0PR03CA0247.outlook.office365.com
 (2603:10b6:a03:3a0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:41:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:42:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:41:51 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:41:50 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:41:42 -0800
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
 Wang" <zhiw@nvidia.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v6 RESEND 2/7] rust: devres: style for imports
Date: Mon, 10 Nov 2025 22:41:14 +0200
Message-ID: <20251110204119.18351-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110204119.18351-1-zhiw@nvidia.com>
References: <20251110204119.18351-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 51da5f1d-c2de-4341-30b1-08de2099a199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EDi8BR2u89Xlgz2spkBPPJ8eJ1+FRAnCJWee2CaFccgUdgjtShz0uQ0BFWEq?=
 =?us-ascii?Q?Vaqy9c4Y+tHMhikEd9XgzlPSTmjYw4FZHfQt1OmNifu0JR+ccsd82FKSn8nj?=
 =?us-ascii?Q?rqM6zCsnDF/aOA8AIs5PPi0zX+I513Vq4A7iGzJOInOQTKtRa3lyoErMTvyy?=
 =?us-ascii?Q?sBeUoG+SQkOcAC9ROIVHebJd2zTcKIlJU146QdvOS2oo2eQNOW1p/dOrDlSC?=
 =?us-ascii?Q?K8ZMgL8rXr2g2B4FcE4E5D6f2fZzhpx+jyRcXRCvQd83GSrKauKg6X8AD15K?=
 =?us-ascii?Q?SCNiB2O1Tj0MXwozpqK47YOdE/EAf6uwj43DFa108NCc/OPXRrSTHOjWwEP1?=
 =?us-ascii?Q?9lZEPhfBzmxz4Hz9xDBmEkKzNFPkvZV5MJv+hTijkWek0TDtdr0OGk1evk9v?=
 =?us-ascii?Q?WkGe5Vygl2DTXolI7up8SrZqh9IhiGZGtwxgAxJL1wwgbvgbQ+9CoYiU8YQt?=
 =?us-ascii?Q?uoXJnbwTdgLVF1OWMJ9Ts3fAZvnpsY7fQcluAqixXFvPW/EthYQSco/+Xh07?=
 =?us-ascii?Q?VO28qeemR5iRCh9h9gwVWUX13cqME0cjxom0MLNSUnspqmd0FEclIJL2p751?=
 =?us-ascii?Q?OwiEWqaNIBWvkiQ0IIZKVgzMHieCxvPwLqYTkYBdZpkaaIcuHOMLFrA0zfgY?=
 =?us-ascii?Q?L26NF0fBg0NB2UZM8Avm/Y/XBS+Agu/Fvye+pfWH/FwZMKe2k3uD2PSkizLo?=
 =?us-ascii?Q?qrSfAsIFO1XBS56hANKl4jW24NvfzBhzH1VMV00PIWLmKs6tVAptkXAQIQkz?=
 =?us-ascii?Q?hRWqtO+lBAqQBckyEhRRfxpiZVG+8LMuaL+52HmWbd+zk8FSYqpKo84oPQbk?=
 =?us-ascii?Q?OmriVd4p8jpGIIVL4/Wb7Uy9JWxJT9gl5fhIrWAl63ybuT9xV61Xsy7IcdD+?=
 =?us-ascii?Q?senwliJ20QYmDy/NklBD7Ri2XJUGL9FglsXdNtL1uHnyICeDXxnUzJEtR0w9?=
 =?us-ascii?Q?rOidi0u/NwM269BVUyLcYjUSN39+WAdBur1ESCI8oFNdVBn4nerX8JnLL6/D?=
 =?us-ascii?Q?conujmLTo5hy9pkvHb0JAk6wwdSFzJ1xSIAwJWRt9E5JmxFZ+hzYU85L61w2?=
 =?us-ascii?Q?VfJ6atNGLqW7liCWJyrg6sdb6FexJQAIyKQEZ7zIAdpziLgbHxKXo9KlI1xK?=
 =?us-ascii?Q?7oUE5QmHNklDpHW17rPwyC+wElUo23QKlgJD92qpC27x9ZN8/NKoag9nVByr?=
 =?us-ascii?Q?11sGkyljJsmYbIAdPD8pKgfsX2CjB4/HPs6YS1/OpTOdia2JjvpFJro13AXf?=
 =?us-ascii?Q?4raPmmhUovoGzcidNKckGZWnhPhyvj9a/QJD3U/DbzNed99rxWKsAFM56kb4?=
 =?us-ascii?Q?kFpZmo57QS5X+AFsWmiw14SbhgGWJHRssZ76FhwCfiSfZGKmtC4jy8uuTkbH?=
 =?us-ascii?Q?lWSZak5j86rX+0klnKyU2D1cVxcwrbDYC9XWYkQA95BvGeMt52a0B9ccXe47?=
 =?us-ascii?Q?q2y32SUyAs3Vz3PFeVmVOJ60f3YfoI45ZOD8GkzfOjVguaAiN4b/5f0zMSwp?=
 =?us-ascii?Q?cK2V11ZeomGxrEbKh53kkhRcVcCnJCpfVTWU7rztJadSpjFRIFA81gIMRWnH?=
 =?us-ascii?Q?czreEGwdRTBpFFqu3xI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:42:14.5515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51da5f1d-c2de-4341-30b1-08de2099a199
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918

Convert all imports in the devres to use "kernel vertical" style. Drop
unnecessary imports covered by prelude::*.

Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/devres.rs | 54 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 10a6a1789854..3376c7090ccd 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -8,13 +8,28 @@
 use crate::{
     alloc::Flags,
     bindings,
-    device::{Bound, Device},
-    error::{to_result, Error, Result},
-    ffi::c_void,
+    device::{
+        Bound,
+        Device, //
+    },
+    error::{
+        to_result, //
+    },
     prelude::*,
-    revocable::{Revocable, RevocableGuard},
-    sync::{aref::ARef, rcu, Completion},
-    types::{ForeignOwnable, Opaque, ScopeGuard},
+    revocable::{
+        Revocable,
+        RevocableGuard, //
+    },
+    sync::{
+        aref::ARef,
+        rcu,
+        Completion, //
+    },
+    types::{
+        ForeignOwnable,
+        Opaque,
+        ScopeGuard, //
+    },
 };
 
 use pin_init::Wrapper;
@@ -52,7 +67,18 @@ struct Inner<T: Send> {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, device::{Bound, Device}, devres::Devres, io::{Io, IoRaw}};
+/// # use kernel::{
+/// #   bindings,
+/// #   device::{
+/// #       Bound,
+/// #       Device, //
+/// #   },
+/// #   devres::Devres,
+/// #   io::{
+/// #       Io,
+/// #       IoRaw, //
+/// #   }, //
+/// # };
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
@@ -230,7 +256,11 @@ pub fn device(&self) -> &Device {
     ///
     /// ```no_run
     /// # #![cfg(CONFIG_PCI)]
-    /// # use kernel::{device::Core, devres::Devres, pci};
+    /// # use kernel::{
+    /// #   device::Core,
+    /// #   devres::Devres,
+    /// #   pci, //
+    /// # };
     ///
     /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result {
     ///     let bar = devres.access(dev.as_ref())?;
@@ -333,7 +363,13 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
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


