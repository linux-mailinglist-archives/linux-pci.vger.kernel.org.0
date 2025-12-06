Return-Path: <linux-pci+bounces-42725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF33CAA684
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 13:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E06DC3220294
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFBC2F6170;
	Sat,  6 Dec 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cKNCV5JL"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01142F6162;
	Sat,  6 Dec 2025 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024950; cv=fail; b=c3kybwkB1wz9fu4tqRcSPOUs5eqGxp6N7iFJaGVvc+skIn780i8ioQGCVCnfNvJAbXnLAb0QEvxXyP6ed3liEpCGGBjwhN9NcALoZ1KhsMiX7T1rV2Zt9OkJnhWo9Ex6jYta2Qx/YqFs5e6F7mJ7eNQUvFx6T1Hg7wK1VYPTJQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024950; c=relaxed/simple;
	bh=51MLlMQBxmyNAYwwIAnaIcdsqlYE0n21D9UIt37uXCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qW4Tm/ZuqZuMrhRxim/HsyTuyz4w4VoAyrrmvI0ecZmoXgI3UKWBhlWPTTgTxsruKaQ+pK9jRBV3zY6wTjJOC61P+Wbgu96FHKlceiaznY1F6bT1D/Ak060caSkdNqLuaGOLX/SiQf/CdUTNWUWa3GmjEUDrV10UErHh5Bn1zsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cKNCV5JL; arc=fail smtp.client-ip=40.93.195.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKJnAtn50ze6QRkGteaFKiP/rFLBCmqCr+E7Nb+Mn/RhylUCu+ABoBks1VqvSwOf5QPQOoeMPnc3RVzyTOpGx1DGtitV2t1fr7jGJ7cz8OKxnLckqU+aKus5jOS0DF0kamI+C2mSkM+sYKN9czqssm/EA/e8j06VbVW7P8O58ZRtbAbM2stxpjAXd5e0v4VVj0IXvZ4LZ6UoBcFW7/+7LVOLE8OzmiFPpLKEpFeut+Tn0hL5QhIIMFmyaHEAM3WW0MzGCCiB7TFv2y5P0MRP7/YoMQE/dbu1gWM5FJcvv4L7iIPxKk/6hYlXh1XFDQ3cftpcQ6uldNCaP9m9ys1Exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMNoXdv1WHb8BAsdUKJHe6IJ7vZVMg/C+yMFsBx5+gQ=;
 b=x4fYzlYeELqN9/hkPp+GlgU4D4kSTnWJSnvAKF3/UX4EDvyHgiYQ2gjHbuv4phOlYABZ+RE1HDYdy6v1xW3UPyxowBzR/Rz7glRYAMx3nktrXJpH8atfMq76cfbzWoUs6qpqiuiEkewuYgKNlA9RnMUNnz2yuRZXcV92HzGtP6/7IPgDVIU/1lC+FxGpF57WJOMJNKQSIoCE2ItfGNObcS5w1VW4v2vQ/JzbQCIAuEa6GHDTQ5eSCYdwjmt8mZU9IxmcuWuUiF8x5bdj+/hWJA1Uj1HGgqufVd9i2O9wAd3TfeSb4w3LQBIt2qHsI2BRWpyGcWy//U+r+ANY6URxyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMNoXdv1WHb8BAsdUKJHe6IJ7vZVMg/C+yMFsBx5+gQ=;
 b=cKNCV5JLDrdz8Sk242Mj4YNO9dnqioLhjgG3AY9ZccLlSEgewagm5/cxgOjwmWystOEZx7X6fDgwXBjcKb/AUdeayYNQVZCa/uulQKP1Qb4oF3ed+Wcn66EwOk7e6shzhHTB7aUCaKgUz+mXXN5ZeXbqXlekLKVu6AuXQ4jf5PPNFOeO7l86h8vkiAmaCz07JH3TxaqioZbRJ/hcsKjc2DvRBKvikPx3+rQmfIYUOSzpqRvA2/wAVDUIOE4Ol5KhZ1jbebW0r0gtVR1wjgiFc+aMcY1XAP/sTyq3VrCexmLop9L1W/ZXbYr4BIsAXNLerKnXX/hTQQJuvgU3UDltbw==
Received: from BYAPR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:40::24)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Sat, 6 Dec
 2025 12:42:23 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::1) by BYAPR04CA0011.outlook.office365.com
 (2603:10b6:a03:40::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.13 via Frontend Transport; Sat,
 6 Dec 2025 12:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sat, 6 Dec 2025 12:42:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 6 Dec
 2025 04:42:13 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
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
Subject: [RFC 3/7] gpu: nova-core: introduce vgpu_support module param.
Date: Sat, 6 Dec 2025 12:42:04 +0000
Message-ID: <20251206124208.305963-4-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf95d49-5c1b-4ff5-3c61-08de34c4e6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vFf08CyzB9SyQHfoS8YPvZPD77PH8FfI5uy7kzJ+NpH8B99qyZErjRtA5Tij?=
 =?us-ascii?Q?tNUcMw58g/LzPQL3yvCc/KQ4v6RnoGV+b14/Vmk8s4DGdNQRkzrEmG+Vo9Eu?=
 =?us-ascii?Q?etZ1voJ9+Zkwa7iAEtUJ0cu/Bx3RKT+Hrp+pQ+xSQqXOmDqG5UBBjkaLiNWQ?=
 =?us-ascii?Q?xjKTawol652/gYhr63+ivbg6l6X38pXkdUfx7onrKds7SbY/bPvNQZDVH+UF?=
 =?us-ascii?Q?sSb78ovVuM6MZOgKvSwAPQF6COOCJFRX1wYgv70plDnDmXX4zDdPYCJUJDJu?=
 =?us-ascii?Q?N65FJgbxxqIIQ9JKGTo1LQ0VRrawqeDb1AaXNqiNVToVZdaDmMqAwm8i0gbL?=
 =?us-ascii?Q?+OlXzlUmTCg1VrKY/FbcBWTszswrH3bRK2ooqp1NRHTPeq7db7OhqkKfpuQ9?=
 =?us-ascii?Q?LZlYekiswYQXIKGWtzkaT9ITQsUAQTVu68R/b0pUhw74dF3yDxpUkw8SBArc?=
 =?us-ascii?Q?1ji4314Ub1ZtSMTRuD1NAmgfsJVDigHnMt/+x8K0rI1oW365C1G/c9AKLxYV?=
 =?us-ascii?Q?zF14Xs12d4TWhirmqKuyf6lYLSXvvVtF9NZhNSbTmG1d8RlajweHmjc6LjG/?=
 =?us-ascii?Q?9MHlpZNkReBqzTRFaFcK/B0wc5MnOCewNsv+xueLqc0rQcp0LXXckNn3R7yK?=
 =?us-ascii?Q?6MRiZDp1H/px7ZmzSUntYPZC7a8djDYHslNzvoKK/2MIzflXBhd2pxlIPJ+F?=
 =?us-ascii?Q?lJDEmpagmiMf1VG87Ag38rXP3f+adqfFMdK7Pn+XtMuFDN8l3wOfG03yqsnx?=
 =?us-ascii?Q?bta95GTZgJAMnhkYutmwvnO79jil1Mi/6kbz4LZuGhuV6toSOC+0MKJp7Rq9?=
 =?us-ascii?Q?8F4hjW5HIp5Nf5v3/vBy4XVpa4T3zOfLN6IkUArSd/FAalLaEwpSBQV6PD6h?=
 =?us-ascii?Q?s5p/dgR5QTbdlslX8onnKEAPoOCaE6FH+Kb9BE5+CxoIbw4eaO1qOpSC5cuj?=
 =?us-ascii?Q?dggVSyJghuyfTV2MyhBims2ghD9gDVpbu0lfwrasd/pfXL4ucwmQ3gkz4GuA?=
 =?us-ascii?Q?ZvBH9NxFUxNyc0DHPK0bR2dX2skX1EnflACYG6/mulkrtCYZVdUEf+TYYcav?=
 =?us-ascii?Q?8cf7aW5gg41PHafq5vFvqQt1PJeUSeaIuoC8znSQdwz9MdUr6Nb683eMlnXL?=
 =?us-ascii?Q?W+LelKgS0FkZcab6X5tmoSO/x+qE3KNQMNkK/weqlxPgLkcZTs76G3S9eGCx?=
 =?us-ascii?Q?9N9RrS9Jj2DkoWnuKlyMiabjru1mQvz3MO2JdcrtWpK09+zU+ehTXeAo30jk?=
 =?us-ascii?Q?nq5RIWaOPgf4D0pJlo1y78SCN7vMBmkBoh5uwLdqcvIVRWuiMqweB2ge/hq6?=
 =?us-ascii?Q?3THFE0YCjPBD312gPco16MCq6npJQpnPMG/bkppNa+lzp7nWpcR7jXvWdfZV?=
 =?us-ascii?Q?+MhzfNb31XAp1zm4A5H7Ay/TQ1HnYEY1Ntuy9vFuX5GbgREhGFUI1YZPkCYP?=
 =?us-ascii?Q?/4fqn+6BgtJB0IhpMK6AAr6ijY6h6s9rUbRlsTQH/W2ofl/ZxfH1jGLkAWor?=
 =?us-ascii?Q?/GEg9HyRnUx57+XSdDTHDIq5Ta2KRauLKgm7+yA0UsG5I6R78XLCA6vlQ6Fi?=
 =?us-ascii?Q?jpatSxxrxb26yP+iyoc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 12:42:22.3870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf95d49-5c1b-4ff5-3c61-08de34c4e6df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715

Introduce a kernel module param to set vGPU support in nova-core.

vgpu_support = 1 (default): automatic

The driver automatically enables or disables vGPU support based on if the
GPU advertises SRIOV caps.

vgpu_support = 0: disabled

Explicitly disables vGPU support. The driver will not enable vGPU support
regardless.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs       |  4 ++++
 drivers/gpu/nova-core/nova_core.rs | 15 +++++++++++++++
 drivers/gpu/nova-core/vgpu.rs      | 26 ++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 drivers/gpu/nova-core/vgpu.rs

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 629c9d2dc994..10c5ae07a891 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -20,6 +20,7 @@
     gfw,
     gsp::Gsp,
     regs,
+    vgpu::Vgpu, //
 };
 
 macro_rules! define_chipset {
@@ -252,6 +253,7 @@ pub(crate) struct Gpu {
     /// GSP runtime data. Temporarily an empty placeholder.
     #[pin]
     gsp: Gsp,
+    vgpu: Vgpu,
 }
 
 impl Gpu {
@@ -271,6 +273,8 @@ pub(crate) fn new<'a>(
                     .inspect_err(|_| dev_err!(pdev.as_ref(), "GFW boot did not complete"))?;
             },
 
+            vgpu: Vgpu::new(pdev)?,
+
             sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
 
             gsp_falcon: Falcon::new(
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index b98a1c03f13d..e034353f69ab 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -18,6 +18,7 @@
 mod sbuffer;
 mod util;
 mod vbios;
+mod vgpu;
 
 pub(crate) const MODULE_NAME: &kernel::str::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 
@@ -28,6 +29,20 @@
     description: "Nova Core GPU driver",
     license: "GPL v2",
     firmware: [],
+    params: {
+        // vgpu_support = 1 (default): automatic
+        //
+        // The driver automatically enables or disables vGPU support based on if the GPU
+        // advertises SRIOV caps.
+        //
+        // vgpu_support = 0: disabled
+        //
+        // Explicitly disables vGPU support. The driver will not enable vGPU support regardless.
+        vgpu_support: u32 {
+            default: 1,
+            description: "Enable vGPU support - (1 = auto (default), 0 = disable)",
+        },
+    },
 }
 
 kernel::module_firmware!(firmware::ModInfoBuilder);
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
new file mode 100644
index 000000000000..9701b97bf6bf
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+use kernel::{
+    device,
+    pci,
+    prelude::*, //
+};
+
+use crate::{
+    module_parameters, //
+};
+
+pub(crate) struct Vgpu {
+    pub vgpu_support: bool,
+}
+
+impl Vgpu {
+    pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> Result<Vgpu> {
+        Ok(Vgpu {
+            vgpu_support: match *module_parameters::vgpu_support.value() {
+                0 => false,
+                _ => pdev.sriov_get_totalvfs().is_ok(),
+            },
+        })
+    }
+}
-- 
2.51.0


