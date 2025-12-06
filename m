Return-Path: <linux-pci+bounces-42727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC334CAA687
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 13:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EDD23266909
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 12:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3302C2F3C3F;
	Sat,  6 Dec 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8PnPXjh"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB96B2F5A36;
	Sat,  6 Dec 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024953; cv=fail; b=EQcxqA4/uWUrGT3S7Uccp1YRLDKjOfHkaqibefRxDyLOZ1JGxOgjoW2Qo4gAtik+dSLu+b9p5ASMUY1USMi4Xi6V772mpJ+Zh7zJh5O8ku8ocv2s3toQsy6xw7xZcENM5nXLn7QmzprArqQGmwL8IecXJ7rwlldIygji6lIfMwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024953; c=relaxed/simple;
	bh=BDjxzq0EZB3fbbiS1/kWpZ8nVyDsIBMxB6WqW5NeU58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfXNbvVUORGgtuzNIVQc3vgfpETGe6NGSB15ZIPIn9xfqrxbjbUtuhf4Uk3GjVaOKXvNTZnJWnT4NTYAlLDwPD7PFhO8Gq5YAiv1fMZBFM/KQ8pcFHE4bH+Vyi1WKZ4Jj7mzeOLaTSXWXcq8fL1b81Xpr9WQS2e+5VQ4imp9PsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V8PnPXjh; arc=fail smtp.client-ip=52.101.48.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boOtiPtj+QeuR8ARATyfyoUSEFBfdMiaEiD/MT6huyH0odmQtqKWgyOPN9S+UmmLdZCNesZ0bbiCdnDJJzqnkxnoFQ/7nznmXEey5KuaijM66belOxPqibw4qfht9Rlt8axv6bi/93mNQ7K+tJfMqMwlRsMRe7MreYbP4ZASt6aSy7ug+bJhYmb/nWvMo17Hifk1R0r9mADmWDJyVgjvev+D9ag+VVySG36gkDh1Bs4nH9xH+o4APoCMS0nEZHJ31hONYTUPKz7f5786KHzF1ZH6S9vkYxUkl78t+afMseanxOOYN37W6OF87qylLzK2Wh+eGCLUK//fkdkcU1tdsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyZrS7+9bKlwhxBsiZQwhAmqz8PpyWe0DDaI/2zg1mo=;
 b=Wk2VNLWGOafboLgzvU2dEW8mXKJ0ojyN8vjMV2iQ/ZZ+pqeE15stmg9zIs6OgkGRYq8a5Lrv/fdGc8imc4na0PIpUFlsIYHc0NascHh+gFaCoOO2eqap4hR7maDbqUO5TS7XpoDQOGSCFGs0dLym6l9CRPcyNPwfp3WqiNCOeJ+sTpT0Ce6RTo5PNpczrbDEOoqHNwUa5c/rNB2La3fWb8qLqCeIPeLLwj/KrPL85Riw04m73EZf9CbZoRvt4fcuaVcb+GqsjoYzLl4ddSjwJzgjVizlMFYyvXjSq61aWnkoSI6VTY7KvOKmTNd5A7Y1hs+ep3nBFX82ba8eSgjRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyZrS7+9bKlwhxBsiZQwhAmqz8PpyWe0DDaI/2zg1mo=;
 b=V8PnPXjhYPYZ5b5QLPHwzvdcwh1FK3R6GT0i/VZgxC/iSYRULdLmy+VTsJDwwb8PAkR9hxFeDtmxElCcO9pTP6c5J+K1WaGsU5q034jdKZ5n7omhoHAkLTSJYgxssIbdciTUob1fFP8hnHY9eOxyoJRB6oxiHITivjFjLZtzfbwoRiL/z8de8CKM8wjC2DGs8vkPKruy/x0ci3lhT6G/C1IhUb1m5SRZ9BsOhcKco0KARR96mHIEV533kCWEGiLZIrD/TDCInm/It2MYzoSCF0eWjjdl17gpwIsBzwHP+TkGKfqW51reBwPHbuLA/Q1K58dTCe4TzPt1cEXVcT76ig==
Received: from CH0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:610:119::17)
 by DS5PPF78FC67EBA.namprd12.prod.outlook.com (2603:10b6:f:fc00::655) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 12:42:23 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::7f) by CH0PR03CA0368.outlook.office365.com
 (2603:10b6:610:119::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.13 via Frontend Transport; Sat,
 6 Dec 2025 12:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 12:42:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 6 Dec
 2025 04:42:14 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 6 Dec 2025 04:42:14 -0800
Received: from ipp2-0489.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 6 Dec 2025 04:42:14 -0800
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
Subject: [RFC 7/7] gpu: nova-core: load the scrubber ucode when vGPU support is enabled
Date: Sat, 6 Dec 2025 12:42:08 +0000
Message-ID: <20251206124208.305963-8-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DS5PPF78FC67EBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 4573fb43-b09e-42e6-3a90-08de34c4e7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3eCzH1+0HVwp+vvDgmqYOHkkNn9uOD+jtgxRhPeL91WRT+6WkEKHCAXmzxv1?=
 =?us-ascii?Q?QmdqIuMoNrRugKsSCY3+ahfLqudoSN2K2Dt4z84xeibhsFKBRyEKRupe+1Je?=
 =?us-ascii?Q?ooHeKF9VCDzxkxdfJ50xcE2mQgHjRIzuQmyCQAWnbDcqs4NHlb6b0cYGnSKb?=
 =?us-ascii?Q?LevmUFCWYq6OLKMGt675e2Xpm3u5Dw5u3suGF6ouDUlO90z1h98QiQylXvXh?=
 =?us-ascii?Q?kyU+1JaWJ2iaMWQdTDHGItWUPVtubgoaX2OiURWDxXCB08SJSAgg0CMY1Ll0?=
 =?us-ascii?Q?x6VUHi30Q4xQQZ2Xly36Jv+s/OU5EEw6OSrw+blHokgo94Y2MatVvu/UGUHW?=
 =?us-ascii?Q?BZfgEuAJ3W2pEKHxn9/fwVPV3H8KOKxaYzgLVKHP+owUcErV+6uLQeAurxyz?=
 =?us-ascii?Q?HrzD7ATt/PyFtfmsIEAaeWKsR6y5Fd+ZppGyKGNRDK3YSCsr1SLnnSzEfQFD?=
 =?us-ascii?Q?b35uRV9wvlifCH+Kc7re2Gxq0/9Z/UK4M4f57uxbnQNY8E9+nAB47UsNlKhM?=
 =?us-ascii?Q?l1u3m1xpHmuEOMEjY42dl8x1wPpYPLToJz9vxCZKC39JGRsqon2eyU4MLXpO?=
 =?us-ascii?Q?E0N/hdavTETv2rgl7z8YAzjYes+gvaon8WrrgIs6FnviWWLD06LAhxiLYp2/?=
 =?us-ascii?Q?ao9oJIYD2gzr/qoU5lbFKxqkxufPdBLg7+QpmVV06hygoXSPADh4rHcof2LB?=
 =?us-ascii?Q?j+vgewAqFqo7fmpYQV4nqDJJPD3rmIYdla5PAJA7wIAHhlc1899DUeKN+/ST?=
 =?us-ascii?Q?h3eHFHMCjfV2EbIKHa+ZOw/hT5m4OthZteK2vmgfLcsVvWcRJveUf2HPQOLq?=
 =?us-ascii?Q?ii8u8/XCxJ3qgvmxEZmBZDZb+y8qTnnxJ2lyAMd9Nnn6rqW042rKO6IsGix7?=
 =?us-ascii?Q?S3UirB1oBYBEZFz3P8MKegyEUM0tDxlZxaY0KHYe8jE1ovQrJY5daQ+Ngu8a?=
 =?us-ascii?Q?lT4XtR6p2TakfM3rz6ZquDyLPvqJOYvhn2Q8zMFZJPLcF7kGpnhKL7wKqIvO?=
 =?us-ascii?Q?ljf98ZEWtB65g06LEChjcqEEq6T1MfH9OUHPoh9xT2bAF43NOLMvhCyPZFnR?=
 =?us-ascii?Q?zaWEDUwY1K9jXVPysvs7y8RodPtW0TuH/UV8C1f8zJ41ledbbqa/u9a5kGXH?=
 =?us-ascii?Q?Dv/ntULXteSGE7UmUzDLXoKLUwYf6HadxuMCFio/MhEjQS1EV0ozp5OLQOTX?=
 =?us-ascii?Q?Qnb4uNR6MR4M2Ul4kKzPO6vl8RxhgIIwyC6H2nWGR3mOaLST+D1gtXM4OdAK?=
 =?us-ascii?Q?cidXYzNJIEo9Hwe5STztzbMUkmdfTd6YJDtoH1Aq582ChZUlOX+jmN/dM6uG?=
 =?us-ascii?Q?j8TRlVBxVyav26FF4H6YsPyq41AT3IJfylR5VRhRFf9nXEUlRv1HtmTI0kfn?=
 =?us-ascii?Q?YhNQyw+WDpvFQzPgHhjpxEh7QriNxJ7lAOtVLuqguPOZwkwKYfuzeo8VZa/F?=
 =?us-ascii?Q?h8OdpAxvotduriKTtalxdZAhWbCCYJgrUsMpoKE4m6S4ZRhlwNWrNbiaQmXL?=
 =?us-ascii?Q?bU0APG7ith0Flso2CMWQmDsLyBhqH/kDK2CZfoMpKtSHtmGaacB0ZIJpNZ2o?=
 =?us-ascii?Q?oiPm0ClXDwrkZB9ujbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 12:42:23.5964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4573fb43-b09e-42e6-3a90-08de34c4e7a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF78FC67EBA

To support the maximum vGPUs on the device that support vGPU, a larger
WPR2 heap size is required. By setting the WPR2 heap size larger than 256MB
the scrubber ucode image is required to scrub the FB memory before any
other ucode image is executed.

If not, the GSP firmware hangs when booting.

When vGPU support is enabled, execute the scrubber ucode image to scrub the
FB memory before executing any other ucode images.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/firmware.rs        |  1 +
 drivers/gpu/nova-core/firmware/booter.rs |  2 ++
 drivers/gpu/nova-core/gsp/boot.rs        | 27 ++++++++++++++++++++++++
 drivers/gpu/nova-core/regs.rs            | 11 ++++++++++
 4 files changed, 41 insertions(+)

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 2d2008b33fb4..5ae1ab262d57 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -226,6 +226,7 @@ const fn make_entry_chipset(self, chipset: &str) -> Self {
             .make_entry_file(chipset, "booter_unload")
             .make_entry_file(chipset, "bootloader")
             .make_entry_file(chipset, "gsp")
+            .make_entry_file(chipset, "scrubber")
     }
 
     pub(crate) const fn create(
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index f107f753214a..f622c9b960de 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -269,6 +269,7 @@ fn new_booter(dev: &device::Device<device::Bound>, data: &[u8]) -> Result<Self>
 
 #[derive(Copy, Clone, Debug, PartialEq)]
 pub(crate) enum BooterKind {
+    Scrubber,
     Loader,
     #[expect(unused)]
     Unloader,
@@ -286,6 +287,7 @@ pub(crate) fn new(
         bar: &Bar0,
     ) -> Result<Self> {
         let fw_name = match kind {
+            BooterKind::Scrubber => "scrubber",
             BooterKind::Loader => "booter_load",
             BooterKind::Unloader => "booter_unload",
         };
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index ec006c26f19f..8ef79433f017 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -151,6 +151,33 @@ pub(crate) fn boot(
 
         Self::run_fwsec_frts(dev, gsp_falcon, bar, &bios, &fb_layout)?;
 
+        if vgpu_support {
+            let scrubber = BooterFirmware::new(
+                dev,
+                BooterKind::Scrubber,
+                chipset,
+                FIRMWARE_VERSION,
+                sec2_falcon,
+                bar,
+            )?;
+
+            sec2_falcon.reset(bar)?;
+            sec2_falcon.dma_load(bar, &scrubber)?;
+
+            let (mbox0, mbox1) = sec2_falcon.boot(bar, None, None)?;
+
+            dev_dbg!(
+                pdev.as_ref(),
+                "SEC2 MBOX0: {:#x}, MBOX1{:#x}\n",
+                mbox0,
+                mbox1
+            );
+
+            if !regs::NV_PGC6_BSI_SECURE_SCRATCH_15::read(bar).scrubber_completed() {
+                return Err(ETIMEDOUT);
+            }
+        }
+
         let booter_loader = BooterFirmware::new(
             dev,
             BooterKind::Loader,
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 82cc6c0790e5..9f3a52ca014f 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -173,6 +173,17 @@ pub(crate) fn higher_bound(self) -> u64 {
     26:26   boot_stage_3_handoff as bool;
 });
 
+register!(NV_PGC6_BSI_SECURE_SCRATCH_15 @ 0x001180fc {
+    31:29   scrubber_handoff as u8;
+});
+
+impl NV_PGC6_BSI_SECURE_SCRATCH_15 {
+    /// Returns `true` if scrubber is completed.
+    pub(crate) fn scrubber_completed(self) -> bool {
+        self.scrubber_handoff() >= 0x3
+    }
+}
+
 // Privilege level mask register. It dictates whether the host CPU has privilege to access the
 // `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
 register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK @ 0x00118128,
-- 
2.51.0


