Return-Path: <linux-pci+bounces-42726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B9CAA678
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 13:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E22D7302015E
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043102F6933;
	Sat,  6 Dec 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NPjXl5Fw"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54302ECD14;
	Sat,  6 Dec 2025 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024951; cv=fail; b=B+twkJXTDgNrO+aHCGEyy6FNf92RprHEFGDLHqSEbAPjA2BcR5ifOWpZnLvcNu2P6FrUcHnFQhY0xWOcr0HDlaYAztzZou5/i+TqEBsjbKEj/Y2lF67k7fnUrQwRy1gdf05rmeh1cuqnZ5px+nfzFFpce3zNn+6A0l2OhMgFHUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024951; c=relaxed/simple;
	bh=q0sjgF/dl6dXdXtlkpWID1teGUIa26Ju0d2PVLVNANk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1JVOCPR9i/Gaw1mJRWLe6sP31Da2of9ygiHaEcvu0dxW+fCdrLMrhiBmf63k3IBUO7OB2mv/Y3ud/jGGnH57yAOq5X8ZojqYIamv+IIRFL05Jl9RRbO5euCLngqPd0R5Lno889E0ZaBArYBPE1ob4PtoOIAvTGBLbAiotwmZBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NPjXl5Fw; arc=fail smtp.client-ip=40.93.194.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHdcBnatoXD7qr7+R5E/tSSOCT5/E2hi/d3gjGePthn03Jr9LyVJL7m5ZV6T9EHOQEjaq+B3gBEDzbvGnJmlgZq9GD1+SD+nxXZOCVFRf4bLGSrznYiqHHQGr9TWOnZZYC6v384cNs929ZvUAZunsniu8rzRbQIbVRqSx7KMFxr31+ZW99IhoNWCWnMhVyyAxAQERB096k37rUu3GN9N7ZfJqc7rPhc5KyJzszLktUtQwz2YbxWSWoPazHKJiy1Z0687tTWLbInUalte0Kz9/6nsLzImnofE+aAoZn2liprDQ6NZuMzRlmdXHQx82Hq8N2pWJhi3vvzfP2hPdQhheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8+NXoskSNgJPKFsBNiWYgfiQlzaaS/OTM8lqY5JH8E=;
 b=fvztaodx9aaIlLpiqRq/f4YpxzI//iHsvwRi4Dpblu0LYulKoxPuNKmpGUHU6HyBuPz4koN9J+6bzDYi7iY0rHA7aLkMZgi03kZuop8+/gh1mn/SoXVtTNrJpgGeI5dnp7arSt3v3zy5kLNqX8ZNR/eqDO5y0zerqGEjV6bQPGv9rzQMlwFcE9VwRoKJ/YdDXgphdTP7/fnNW98Moa2O/p5Im1CdZPBPaoqC5dNIQAmyJXuMurPpx/6c2AfBEhD4KgWf3m2TPBZxtx/hwQkyBC+FZrK/IIPQDXmRC84c2ZOBa5xcUDNDgHsKccdl+/Ta+kgeRndxCwDx2mXLOWaFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8+NXoskSNgJPKFsBNiWYgfiQlzaaS/OTM8lqY5JH8E=;
 b=NPjXl5FwkjRqTow6oVnGmH5MSRRxSTBMITf7q56rO+gM5dvEj1O/VFqaOYgQmQ6bW2hDtVZGXDsQZt8U9tYv5Jm77QzuZupv0T3LJI8Gy4tJ0rAEyVw6iqHUkReSSmPG5qdg0gZM8JktfjdtUpZ0+YmSwtll71clpPI9g7YqjSJ0Qfw24CHsMWS+mw4XZ/+JrFmTnH3DlOMAjVhfmWnS4SgsOpmvvBgTKQvAzVIdSCm5ivQHuKIrQRJXphcvBF4a0H/BB7BCmrJlq6d5yBRXpaHmEFtTZe9RPXPh3mQFnqGlb0S++OeRAgBzgW3Im0g6GbgeR0lkFmaKnODE8rWkUw==
Received: from BYAPR04CA0035.namprd04.prod.outlook.com (2603:10b6:a03:40::48)
 by CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sat, 6 Dec
 2025 12:42:24 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::70) by BYAPR04CA0035.outlook.office365.com
 (2603:10b6:a03:40::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.13 via Frontend Transport; Sat,
 6 Dec 2025 12:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sat, 6 Dec 2025 12:42:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 6 Dec
 2025 04:42:13 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 6 Dec 2025 04:42:12 -0800
Received: from ipp2-0489.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 6 Dec 2025 04:42:12 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <airlied@gmail.com>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <alex@shazbot.org>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [RFC 4/7] gpu: nova-core: populate GSP_VF_INFO when vGPU is enabled
Date: Sat, 6 Dec 2025 12:42:05 +0000
Message-ID: <20251206124208.305963-5-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206124208.305963-1-zhiw@nvidia.com>
References: <20251206124208.305963-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e7374e-d1bd-4590-cd2c-08de34c4e7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t6hnWEZk1l1Zbur0JyxlRwTgGV/6icYPapM7SNWKPlKZNnzDWfj+7m2mF+p2?=
 =?us-ascii?Q?MwOOK/LtKr9tRnWZAmUZbS3gaHx4NmrOs/TyJuAnWPE9Ez8NKa14uQRfRfr6?=
 =?us-ascii?Q?YkEiKAzeTizghic4bWn5X4aY93JhQD3/qsuGUmdhz0p9sJXeodB+kdXfyjW8?=
 =?us-ascii?Q?qGsAYbisaKjE7ZgmGTlEkbZo+JutqtOlJyiLznsmye6tktLjG8dACi4o3WVg?=
 =?us-ascii?Q?yqDwwmB39hY1jYZUq4/f0rdQpsdXjFV1c62TouX78HtWlGtntRrg18uFxW0i?=
 =?us-ascii?Q?fF8E+QPw0+YCQoFNaj0evQrVXQq+Sor9WoJZqw8o4v2NmehS2tM/2QIfowJo?=
 =?us-ascii?Q?D23FosGWstVHmayzEmcI7sidAk+wsWfdEWLMOLU7mEHz+Svwlp02w03CO6v9?=
 =?us-ascii?Q?Bw0e3cjz8IwBtEVl9XQrbPXeKHo1VRzagWnfZ7mbHeFP/9+UeghSYSMRSc+J?=
 =?us-ascii?Q?r2fkCxVnrrninjO+mYyoMGxyCTzM6WNIxi1ilLwXREk2tsIqxTPuwBCX9O80?=
 =?us-ascii?Q?h1vs6k2P9e4qVbuDpm7GFVg9P9olUsEa90I6/YDnQtLHj93bPhbWA2M3EyV8?=
 =?us-ascii?Q?/TMzrbPvTKg23ozCwZJWeTJt9L4UX8h0uj8swCBaAbn8DB26Gkzb1NATFkFL?=
 =?us-ascii?Q?QYSAY91tMS7/4H0ruZX2bHVXnfdMSbpBSJ2xt6bRSUXmRD5ZDHfX1U1G4AJ7?=
 =?us-ascii?Q?TbIru+2p3PRKOsc1bf2tiLoDGi/fXc+nnEJn8pZt/jM9tr04lmO9vuYJKlFj?=
 =?us-ascii?Q?4d90MzsQ1O7zFptAE+aXH/ENcoC+57k9JDjmSwcaXcVXPbXUiH3Or8s7iCMf?=
 =?us-ascii?Q?GCIsVFok8315hrt5YKlCcytlxLpbgEsBmP5/H6mBQqtVw/dHGainCeJl6lQl?=
 =?us-ascii?Q?iLtaTRDXNBstv9/dxuPb9wgAd27Ge9zenwohLjq1um0AXQXANwivqd8D38td?=
 =?us-ascii?Q?F5CC3l7i3eeu11cXqJn9gGL0tSPbxKyVRUbo1NdNRydHUHjo34vLZBbZdj47?=
 =?us-ascii?Q?OCqy2BxEOl0Yfm2gaT0uNKQ4GJefKlC0zC51RKXvaiax4ttPlgXAUWCCEtVh?=
 =?us-ascii?Q?3Hd4oHadwx6/+E8iW9byKiXoRPTVorNbJBOdFxUKzhMakwA9b8HEBe9gY19K?=
 =?us-ascii?Q?hucyQXtimwQhGihxSxCzvfufKzOIQ57beY65oyNihNdZdbUkJZVEeZSrI2Vb?=
 =?us-ascii?Q?h9kUIAkTlTUw4b1aR/BQFANk48Yrk97ujjDt9Ui91KTeBmI2EcrX51SiQP6W?=
 =?us-ascii?Q?a4DlbJia7JWnm8oWUnwh10E6bxzLoaUUtgb4iYC3V5N7jGVNTYEvqqtIil9J?=
 =?us-ascii?Q?66eSf5Gee5jCuGEPOJW60Lf2GAD8HS+niw1gdqhIw+1qaQryGumVn6oPLbLo?=
 =?us-ascii?Q?DiEcsAJ1RsygonK56VqB2r14T7NX5fvV3nOTh1tYfNWflDyNtFMgn4D3DV1k?=
 =?us-ascii?Q?cIC5KHHI5OwqH6kKM2dzozkVXUHLubS/Lgqicca+UfnQmBJ2wVRVa2JRVzqW?=
 =?us-ascii?Q?8uNY5pWS9NDR+yHx8cf2fJdXDZ4vBNwFGX+Tdl3qTUHsya8duIyj57Mw66GN?=
 =?us-ascii?Q?fJqy+rm26p8cwjs6uQA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 12:42:23.8188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e7374e-d1bd-4590-cd2c-08de34c4e7b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342

GSP firmware needs to know the VF BAR offsets to correctly calculate the
VF events.

The VF BAR information is stored in GSP_VF_INFO, which needs to be
initialized and uploaded together with the GSP_SYSTEM_INFO.

Populate GSP_VF_INFO when nova-core uploads the GSP_SYSTEM_INFO if NVIDIA
vGPU is enabled.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs             |  2 +-
 drivers/gpu/nova-core/gsp.rs             |  8 ++-
 drivers/gpu/nova-core/gsp/boot.rs        |  6 +-
 drivers/gpu/nova-core/gsp/commands.rs    |  8 ++-
 drivers/gpu/nova-core/gsp/fw.rs          | 75 ++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 11 +++-
 6 files changed, 102 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 10c5ae07a891..08a41e7bd982 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -285,7 +285,7 @@ pub(crate) fn new<'a>(
 
             sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset)?,
 
-            gsp <- Gsp::new(pdev)?,
+            gsp <- Gsp::new(pdev, vgpu.vgpu_support)?,
 
             _: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
 
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index fb6f74797178..2d9352740c28 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -115,11 +115,16 @@ pub(crate) struct Gsp {
     pub(crate) cmdq: Cmdq,
     /// RM arguments.
     rmargs: CoherentAllocation<GspArgumentsCached>,
+    /// Support vGPU.
+    vgpu_support: bool,
 }
 
 impl Gsp {
     // Creates an in-place initializer for a `Gsp` manager for `pdev`.
-    pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> Result<impl PinInit<Self, Error>> {
+    pub(crate) fn new(
+        pdev: &pci::Device<device::Bound>,
+        vgpu_support: bool,
+    ) -> Result<impl PinInit<Self, Error>> {
         let dev = pdev.as_ref();
         let libos = CoherentAllocation::<LibosMemoryRegionInitArgument>::alloc_coherent(
             dev,
@@ -156,6 +161,7 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> Result<impl PinInit<Self
             logrm,
             rmargs,
             cmdq,
+            vgpu_support,
         }))
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 54937606b5b0..5016c630cec3 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -33,6 +33,7 @@
     gpu::Chipset,
     gsp::{
         commands,
+        fw::GspVfInfo,
         sequencer::{
             GspSequencer,
             GspSequencerParams, //
@@ -136,6 +137,7 @@ pub(crate) fn boot(
         sec2_falcon: &Falcon<Sec2>,
     ) -> Result {
         let dev = pdev.as_ref();
+        let vgpu_support = self.vgpu_support;
 
         let bios = Vbios::new(dev, bar)?;
 
@@ -162,8 +164,10 @@ pub(crate) fn boot(
             CoherentAllocation::<GspFwWprMeta>::alloc_coherent(dev, 1, GFP_KERNEL | __GFP_ZERO)?;
         dma_write!(wpr_meta[0] = GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
+        let vf_info = GspVfInfo::new(pdev, bar, vgpu_support)?;
+
         self.cmdq
-            .send_command(bar, commands::SetSystemInfo::new(pdev))?;
+            .send_command(bar, commands::SetSystemInfo::new(pdev, vf_info))?;
         self.cmdq.send_command(bar, commands::SetRegistry::new())?;
 
         gsp_falcon.reset(bar)?;
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 0425c65b5d6f..1d519c4ed232 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -26,6 +26,7 @@
         },
         fw::{
             commands::*,
+            GspVfInfo,
             MsgFunction, //
         },
     },
@@ -36,12 +37,13 @@
 /// The `GspSetSystemInfo` command.
 pub(crate) struct SetSystemInfo<'a> {
     pdev: &'a pci::Device<device::Bound>,
+    vf_info: GspVfInfo,
 }
 
 impl<'a> SetSystemInfo<'a> {
     /// Creates a new `GspSetSystemInfo` command using the parameters of `pdev`.
-    pub(crate) fn new(pdev: &'a pci::Device<device::Bound>) -> Self {
-        Self { pdev }
+    pub(crate) fn new(pdev: &'a pci::Device<device::Bound>, vf_info: GspVfInfo) -> Self {
+        Self { pdev, vf_info }
     }
 }
 
@@ -51,7 +53,7 @@ impl<'a> CommandToGsp for SetSystemInfo<'a> {
     type InitError = Error;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        GspSetSystemInfo::init(self.pdev)
+        GspSetSystemInfo::init(self.pdev, self.vf_info)
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index abffd6beec65..a0581ac34586 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -9,8 +9,10 @@
 use core::ops::Range;
 
 use kernel::{
+    device,
     dma::CoherentAllocation,
     fmt,
+    pci,
     prelude::*,
     ptr::{
         Alignable,
@@ -27,6 +29,7 @@
 };
 
 use crate::{
+    driver::Bar0,
     fb::FbLayout,
     firmware::gsp::GspFirmware,
     gpu::Chipset,
@@ -926,3 +929,75 @@ fn new(cmdq: &Cmdq) -> Self {
         })
     }
 }
+
+/// VF information - gspVFInfo in SetSystemInfo.
+#[derive(Clone, Copy, Zeroable)]
+#[repr(transparent)]
+pub(crate) struct GspVfInfo {
+    inner: bindings::GSP_VF_INFO,
+}
+
+impl GspVfInfo {
+    /// Creates a new GspVfInfo structure.
+    pub(crate) fn new<'a>(
+        pdev: &'a pci::Device<device::Bound>,
+        bar: &Bar0,
+        vgpu_support: bool,
+    ) -> Result<GspVfInfo> {
+        let mut vf_info = GspVfInfo::zeroed();
+        let info = &mut vf_info.inner;
+
+        if vgpu_support {
+            let val = pdev.sriov_get_totalvfs()?;
+            info.totalVFs = u32::try_from(val)?;
+
+            let pos = pdev
+                .find_ext_capability(kernel::bindings::PCI_EXT_CAP_ID_SRIOV as i32)
+                .ok_or(ENODEV)?;
+
+            let val = pdev.config_read_word(
+                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_VF_OFFSET as i32),
+            )?;
+            info.firstVFOffset = u32::from(val);
+
+            let val = pdev.config_read_dword(
+                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_BAR as i32),
+            )?;
+            info.FirstVFBar0Address = u64::from(val);
+
+            let bar1_lo = pdev.config_read_dword(
+                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_BAR as i32 + 4),
+            )?;
+            let bar1_hi = pdev.config_read_dword(
+                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_BAR as i32 + 8),
+            )?;
+
+            let addr_mask = u64::try_from(kernel::bindings::PCI_BASE_ADDRESS_MEM_MASK)?;
+
+            info.FirstVFBar1Address =
+                (u64::from(bar1_hi) << 32) | ((u64::from(bar1_lo)) & addr_mask);
+
+            let bar2_lo = pdev.config_read_dword(
+                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_BAR as i32 + 12),
+            )?;
+            let bar2_hi = pdev.config_read_dword(
+                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_BAR as i32 + 16),
+            )?;
+
+            info.FirstVFBar2Address = (u64::from(bar2_hi) << 32) | (u64::from(bar2_lo) & addr_mask);
+
+            let val = bar.read32(0x88000 + 0xbf4);
+            info.b64bitBar1 = u8::from((val & 0x00000006) == 0x00000004);
+
+            let val = bar.read32(0x88000 + 0xbfc);
+            info.b64bitBar2 = u8::from((val & 0x00000006) == 0x00000004);
+        }
+        Ok(vf_info)
+    }
+}
+
+// SAFETY: Padding is explicit and does not contain uninitialized data.
+unsafe impl AsBytes for GspVfInfo {}
+
+// SAFETY: This struct only contains integer types for which all bit patterns are valid.
+unsafe impl FromBytes for GspVfInfo {}
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 21be44199693..3b5c05704b2d 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -4,7 +4,10 @@
 use kernel::transmute::{AsBytes, FromBytes};
 use kernel::{device, pci};
 
-use crate::gsp::GSP_PAGE_SIZE;
+use crate::gsp::{
+    fw::GspVfInfo,
+    GSP_PAGE_SIZE, //
+};
 
 use super::bindings;
 
@@ -18,7 +21,10 @@ pub(crate) struct GspSetSystemInfo {
 impl GspSetSystemInfo {
     /// Returns an in-place initializer for the `GspSetSystemInfo` command.
     #[allow(non_snake_case)]
-    pub(crate) fn init<'a>(dev: &'a pci::Device<device::Bound>) -> impl Init<Self, Error> + 'a {
+    pub(crate) fn init<'a>(
+        dev: &'a pci::Device<device::Bound>,
+        info: GspVfInfo,
+    ) -> impl Init<Self, Error> + 'a {
         type InnerGspSystemInfo = bindings::GspSystemInfo;
         let init_inner = try_init!(InnerGspSystemInfo {
             gpuPhysAddr: dev.resource_start(0)?,
@@ -38,6 +44,7 @@ pub(crate) fn init<'a>(dev: &'a pci::Device<device::Bound>) -> impl Init<Self, E
             PCIRevisionID: u32::from(dev.revision_id()),
             bIsPrimary: 0,
             bPreserveVideoMemoryAllocations: 0,
+            gspVFInfo: info.inner,
             ..Zeroable::init_zeroed()
         });
 
-- 
2.51.0


