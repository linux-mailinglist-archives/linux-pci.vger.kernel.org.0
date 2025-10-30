Return-Path: <linux-pci+bounces-39828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B60C210C3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 16:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D17D84EBFB8
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5366365D39;
	Thu, 30 Oct 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S/JVMQXm"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88273655E0;
	Thu, 30 Oct 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839353; cv=fail; b=M2toHWBvwDeAtzUTRS2LsbLqmLX+Idle6cauo1Y0F/eoH7Zs+7hkpWVYQHOcHUWh+2gB50BAMIb14TOQzCHlRUiqJkfnNsV0PZgPROA7bSn+qBHZ8v75b8GTmEgpy8VxdyC3qcVAfCN6q2GFGasPsjfn+E34GlmmEU7pwkmhDsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839353; c=relaxed/simple;
	bh=V4+1I89jrxk7/Vpc2b4JxCBJyu7cb3HtxKJC59JIreU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4bdVFMCk9K6uEMfkr4qkMandc6F5oeKqqsdLfEdEm/6MfidvqLY283NKq2Ut47xM7RGVGtMY2+vx1wzz6A4LHW9chlAh7ppljo5vdCGuKtVBjx/P6zKfBpy0PVBg7jJhBH6YMw9p/CXcLPTriQ3l7FacSXvHVG/yr2xxQCon5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S/JVMQXm; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qz0jP8OUhMicdNc82WeoHqOoO5M9xLLOjXQki9kdhmGGT9jawR+sn5zWdJrJjSa4aq9OqEwIu+2lY2GxuaXdc+eS/5def53jgeTcxtYu6PjTx0M3YPpAvUDKxysRSAXiqqscNOi6tiYa0DUoOfWsnW4x/4sIVRmkSiqBfKSiv0UpOoSSivwPZm3da/CDBHzQkae4lTHh0DYtjv8X3IueSahbSCIQ6I4AehUVQSfx7WNBL/zRV7l1R3dlfkS7imvoqSm++2p+OecnN1AqOzXhsolacc3rv2WPpvtV/13QETbBnHyoER52Mm/eTIJMrKhtBZaaZI5AxBL2ji8D3TCvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cn0acNwcVDyoAr+3yhpJF1EP43ohtviFSc1ufHxz9yE=;
 b=jUY3AbeFRoTWozPkuTrIP0LUKTR+D0q2ZG1sH9sB2MKJxJ7LylnG3MeYoOflUZcuc6iOS/UpgZxlPNGowpxSjL6ezXlPfvWS29IanyHOwEd7j2A/p84DphLVGgtvQzx6wPBqLI0evo/zE/XGU4V5GyxV0LzOsvEa0O0/EYIYXjMoxCpvKfNKtgiODfJAjg9u/19PjU8lhea+QqFzAbAdioSNmRUB8q5f4LcelXcK8KYKguFzFxg5n5/xL1W1GSo3pECMQHHpMGBrkCPYeAvgjw66OYwYq2u6WJr04kpSc65JNjz846d04QyBadi3FEpfjKRcbEPRb25gNAPGnHnPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn0acNwcVDyoAr+3yhpJF1EP43ohtviFSc1ufHxz9yE=;
 b=S/JVMQXmm4mJfa0jLDC6BfyeIeelWQdnL9g0teFWoObpWtyG0eyz1sqFf9thjAOWaDRUdtbjE8odQJoEE6yU4YDi808/DZo2INMmNAYg997OzXR/t+rx+XJExI+dTyJYXtuzQLYDQnkbs6ZqVF3Bu/rj3pqd3loV9vLZ4t1ElVb39fK+BF5nJluXOtBfIpPJCltXAPa6OIiUT7K61hpUsOyaL4OwrJI7boPoohxU/kPSyszWuP8LYrwRc3AjrsB8lBNyWCFyl08ASmliNTQShReZotNptFFsLqXAt8A4jS/OANiBfakQm9XW9u1qyaVbhH/+zoEGZyrmivU0pwXgjw==
Received: from MN2PR15CA0043.namprd15.prod.outlook.com (2603:10b6:208:237::12)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 15:49:06 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::6f) by MN2PR15CA0043.outlook.office365.com
 (2603:10b6:208:237::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 15:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 15:49:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 08:48:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 30 Oct 2025 08:48:46 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 30 Oct 2025 08:48:46 -0700
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
Subject: [PATCH v3 4/5] rust: pci: add config space read/write support
Date: Thu, 30 Oct 2025 15:48:41 +0000
Message-ID: <20251030154842.450518-5-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251030154842.450518-1-zhiw@nvidia.com>
References: <20251030154842.450518-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4c66a5-5bb5-4231-26d9-08de17cbdb43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IABoTPipSnhcxbzu/M3tv9rGHE/hVketCVGMruZX0IXHUNQDQ3kAH/LJtaTj?=
 =?us-ascii?Q?Bx4UdCfGpcgP9Lw+ALvrL7amXt/SYbQ+j2vDdWIoeuFP+CYDkmdHwASGiDH6?=
 =?us-ascii?Q?yaJ2x61nlOG7DprPbpRHB0JhXDpkJyioy3ZyBo8g8FrtPG30usI7pIJfeBul?=
 =?us-ascii?Q?62Yvx85DRyBPAw76IpxJRToBv7pl6AIQTEmtvdzFJQWjmUIK5txA6y7n8M8K?=
 =?us-ascii?Q?dr3z3jM4bvJWTX7XpjW2F5erKS5e4JkupCDJ+kT1E60owcxq68LEuOjtitiV?=
 =?us-ascii?Q?LxCxthD6V99L0o0lNhZu852SNgzh+gyPr+vuWBhUwjqiezNDrv82ibTk/iBO?=
 =?us-ascii?Q?gQdZaKZqgc70b40AkLqqFTk9HmPdXPxm31LNYTeYj7jU0P6xyMwb3z0F0p2m?=
 =?us-ascii?Q?d+7pgKkEuyxjSyjKmBvVtTnsNTFF6PhDOZvGVIv7c86HQCpxMkum6+XXqAs8?=
 =?us-ascii?Q?plkv1padIinPMUC5tjv+k/xqi4f7PqsImqwr9nayH1W9eNvK5Hk1Y8gG6Z/Y?=
 =?us-ascii?Q?HY9MbwH+RikwsndUqtp1ijlLvIDmgROw7WWqEoAi/B/wyAN//0UMWlCY3eM+?=
 =?us-ascii?Q?/aQJwYz4Ncq1zruF4Pe54FcbNeqwIn/DRhF69jKrlKYxxqqANtClGrEFWeIN?=
 =?us-ascii?Q?1ui7mN8c4RhfiM1fdXkBKgWdIAKyG5TKcKblU9hhCRnbxAEmEa2OVqDlAy/O?=
 =?us-ascii?Q?1nMuXBiCfJZWxP5e0E0zUVM5fXvokVplSNa0/ntmf5Dx4bw2ec4VApJVLpXk?=
 =?us-ascii?Q?O0kvS3SssCHpOsEWGqSi8Ha59THV+xaULY1lsA76X2prYY99htqMy5U2OJRG?=
 =?us-ascii?Q?xfeUHjXHFPqrCega6Qj+4R8dPY98odNfePU4pLm2IYVGUNzKHUroZhTTO+8j?=
 =?us-ascii?Q?ZABcsLyxYjn5LcGy6bYZ4aA6fdErODd16KbxAQM1M1lGNFxeHz2EAN9VRU/v?=
 =?us-ascii?Q?LD5x+77IRJIkO1OKtgpQG0UGB6PVg+DPZzgpxSjBuRJ9qcWtqt7f/UPXTIxh?=
 =?us-ascii?Q?HPLLbvRDPytDdpahGZjXQd7V/lOIueXqLwf8WZD2NuDuXnvBLURd+kqysOnq?=
 =?us-ascii?Q?pDLKxr2yqmIAyCRfV9hAnhz2dZV4vdYxh9ScmkFi/G+RVFfcYz5VC7FbAd1X?=
 =?us-ascii?Q?hPcRUhzua/R4vYFJMNLNOb8JfJRkOqONu9pBnxRTEreEU74Q5JYw6aipd+Km?=
 =?us-ascii?Q?k8ne/cAuxzxzuuSN80NHT2xAERjHu8HsPpQAWx9cc7ao+5FIZXYoAcomijUx?=
 =?us-ascii?Q?BaUHL9mo3tl3O5uLPztTlFBbi1/qs1cMh5ABgzBWoPddgZVWEf1/EaYFbZP1?=
 =?us-ascii?Q?lwg7Q63W8TXNH7rPvFv9xUTPiLqBpP5YLi0/jIsGKIjSNvhRVed3McbHW1fz?=
 =?us-ascii?Q?9SvxQPBPwQKkyQhpJpf70NkZh7rdyT/FU/Deku3QUFt10bQN1aNNDKrVGWN3?=
 =?us-ascii?Q?Wokyvmnn/Ps2ENTGOsDyW01IX/tN31dvOrxPrd1z3qDRj2fd3R8VIhmy9gxu?=
 =?us-ascii?Q?1LMqYYZVSoAI4sK07oHsKRwEOIT0MnPoGow5sASeVfb6c2DGTDRG853+S+HK?=
 =?us-ascii?Q?limghCKYoPyymJFLakc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:49:05.5799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4c66a5-5bb5-4231-26d9-08de17cbdb43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF

Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
accessors for PCI configuration space. The new type implements the
`Io` trait to share offset validation and bound-checking logic with
others.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 62 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 9ebba8e08d2e..80bf0d2420f3 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -10,7 +10,8 @@
     devres::Devres,
     driver,
     error::{from_result, to_result, Result},
-    io::{Mmio, MmioRaw},
+    io::{define_read, define_write},
+    io::{Io, Mmio, MmioRaw},
     irq::{self, IrqRequest},
     str::CStr,
     sync::aref::ARef,
@@ -305,6 +306,60 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
     PhantomData<Ctx>,
 );
 
+/// Represents the PCI configuration space of a device.
+///
+/// Provides typed read and write accessors for configuration registers
+/// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
+///
+/// The generic const parameter `SIZE` can be used to indicate the
+/// maximum size of the configuration space (e.g. 256 bytes for legacy,
+/// 4096 bytes for extended config space). The actual size is obtained
+/// from the underlying `struct pci_dev` via [`Device::cfg_size`].
+pub struct ConfigSpace<'a, const SIZE: usize = { ConfigSpaceSize::Extended as usize }> {
+    pdev: &'a Device<device::Core>,
+}
+
+macro_rules! call_config_read {
+    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) => {{
+        let mut val: $ty = 0;
+        let ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
+        (ret == 0)
+            .then_some(Ok(val))
+            .unwrap_or_else(|| Err(Error::from_errno(ret)))
+    }};
+}
+
+macro_rules! call_config_write {
+    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {{
+        let ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };
+        (ret == 0)
+            .then_some(Ok(()))
+            .unwrap_or_else(|| Err(Error::from_errno(ret)))
+    }};
+}
+
+impl<'a, const SIZE: usize> Io<SIZE> for ConfigSpace<'a, SIZE> {
+    /// Returns the base address of this mapping.
+    #[inline]
+    fn addr(&self) -> usize {
+        0
+    }
+
+    /// Returns the maximum size of this mapping.
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.pdev.cfg_size().map_or(0, |v| v as usize)
+    }
+
+    define_read!(fallible, try_read8, call_config_read, pci_read_config_byte -> u8);
+    define_read!(fallible, try_read16, call_config_read, pci_read_config_word -> u16);
+    define_read!(fallible, try_read32, call_config_read, pci_read_config_dword -> u32);
+
+    define_write!(fallible, try_write8, call_config_write, pci_write_config_byte <- u8);
+    define_write!(fallible, try_write16, call_config_write, pci_write_config_word <- u16);
+    define_write!(fallible, try_write32, call_config_write, pci_write_config_dword <- u32);
+}
+
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// # Invariants
@@ -615,6 +670,11 @@ pub fn set_master(&self) {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
         unsafe { bindings::pci_set_master(self.as_raw()) };
     }
+
+    /// Return an initialized config space object.
+    pub fn config_space<'a>(&'a self) -> Result<ConfigSpace<'a>> {
+        Ok(ConfigSpace { pdev: self })
+    }
 }
 
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
-- 
2.47.3


