Return-Path: <linux-pci+bounces-38403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D9DBE582B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 23:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36F5B4EB87A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 21:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E925B2E7F3A;
	Thu, 16 Oct 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fGYIe3Lw"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4422E62D4;
	Thu, 16 Oct 2025 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648619; cv=fail; b=RX1uxebNAaID5f8t//D7hxoulaRaQfXCu6MOL/g0KCFCki/bB4HG4nwCGL42bXLFgRbJipEyWVTLstqsrS4bsXMvGB4uJ+9/pGg/qBnBUIO/qlCGhDl4l4pADSa/smhIpRugA6m90FnX6Ow0+K8n8Mih4LeF7FkrLjC550eFLd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648619; c=relaxed/simple;
	bh=RgkJB4N85Z7A9G9t43ii5a9+SbvAJALa+Z/SZAX/HqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUAFgw45sz9HuyvFSIT4FKLa46LSHxgrGQVGhU1mf5fEB1CLjFTZvcDgSfl1i6hKDXek6/9tvMysbswvf7b8AsHID7eKCWMPi7//b6BUWXjtH4feVuXPl6dSBG6/CSKaV6Kkr2+hKTCq2NO0/IrTANfmBjOAZVhJXEfqgTdnztM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fGYIe3Lw; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usivX8ieFSMSrC1u7A1po9jSxIa5OJ+7efaB0UfXOrM4r87I4POQRdSXbQPkIniKXglq5U3roz3xwvwgTNWYIqqPTIyfp0SK/S1U4jWtrS2lK0ydo95SYXQXzwqs8ysKjzbO6fopmpj8XxMncxgfOIFvjBm22ZhCcMgBT7+okyHjyWEmWM++TDIsyLFGTMovx6Q/TVSw7RKnN9qOpYABP+kBIjonctGz6+t3niIimhDFtdEht2LNwjjgT53z8ZFZXFZ72GJ4i7SxtgMzQJtlxzbf/GKml9BsdZF0bqDs89v+6EXgcrYPK3vmYTyAwbX8XzVUkerNZifbFit/sMw91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg/Z0EoKVy5C4y7adEhY65Mgrkpn2HU9CrMQ2ImIoUE=;
 b=veEs0bkfcISUbTDGVkJA3VAoBc/gSchsZmJvjefbyYXL4KeWvwzKc5TzIv98Gb6lQ4U3AP6m+x6rOY8v1niDmRXuiYZJwloTa8+AHWKWiBntRh65Ie2uVAsZHMPLUAGOmH6FKP/+oCMVd7AyZY1CFpltuD49NSCqMXc3yDS1Xa4txC6C0TbHV8BVYWc7UihI9sFcVTvFNleZVAtH9BxI35wjvltcpbAW5nvYUPasee72McoK88uCmKK0teUrooIhlXji+zm6DCUmh8ptKpn8vz64AjfiCwC9D/eUKZoEnZjbREfOCm33V46yrp6GqkqYuxtt0TYPnQQP6RTwqNjvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg/Z0EoKVy5C4y7adEhY65Mgrkpn2HU9CrMQ2ImIoUE=;
 b=fGYIe3LwFz22K2xpUT8foLkNhoGrAV7iYPMmMHJoaaxEMNZnsJCktNEcJf0TYaES+E+CeHzWqmd4vNhDJz/oDljPJkXD0DbLSMM6yfTMq1HmLiNMdjygU2aCR8jYCmJ/CKH3AC7kF63OSK6jvBtrJRnIHewcrgWqkdOl66Q0lobfIFCXsQCgQBKPP32RlsWzPM2TyrnLzK2NXeN9oWyFcnIp014V4qKQQV9qoOIxCIaODVcA46VynzkAkh33N5kY85Z3tUHrHj8meOBbFtz72UyiX3HNsE/l8Xc5lkRBTyZOEYXHAJxycYbTtDBDRcurxXyXB1R2gNrC7mRaGDVEJQ==
Received: from SJ0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:a03:33e::11)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 21:03:35 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ee) by SJ0PR03CA0036.outlook.office365.com
 (2603:10b6:a03:33e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Thu,
 16 Oct 2025 21:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 21:03:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 14:02:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Oct 2025 14:02:58 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 16 Oct 2025 14:02:58 -0700
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
Subject: [PATCH v2 4/5] rust: pci: add config space read/write support
Date: Thu, 16 Oct 2025 21:02:49 +0000
Message-ID: <20251016210250.15932-5-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbf7484-06a0-43a2-0ef1-08de0cf77864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N9eKjraKStAmB/kOPI+KmUwxvpkvBPgNkicQGwcBbYIu1Z3eMu9sJMinHRW/?=
 =?us-ascii?Q?eaBPn8sViKU/pp6/RGSqzvMkUkUMp6zZSFXulR0XS4IBZiwTNBxjyxoPf5e5?=
 =?us-ascii?Q?6AaDZXvZFozFu2nI/l/Bpo7CbgeLI6XRpiv8uqDznuh85AyAhKb4sD/YpWyl?=
 =?us-ascii?Q?JQ+SBnszU24DuSL5pMZy17z+1WSQKjGOh70HQUFVcTCiT1vEYnx4MWQdkp02?=
 =?us-ascii?Q?OVd9AS5rFeYwpBjhGN2g3lHhxdxDsst+FTMuKgO8UVIt4d1+OeL8ksF+7G6P?=
 =?us-ascii?Q?8moD9DtKN7l9ii6BGsl17Pbe4E2Rl2ZfStWye07WjQSm9+nvqDhUqoRvPjlf?=
 =?us-ascii?Q?whEqZxbNMaq+EGFqS2Nt0dl501oT1Lz8+zolghjiq1JKUXFoXMm+icAqUN9p?=
 =?us-ascii?Q?0KBBslODMsLunzbv/57yeUs90+vx37ZfpkcTZUtWWA5VZJEFm8LLcpezHvcM?=
 =?us-ascii?Q?KFRbjopDc9F1OuEwLTj5esJbnZqeUSZt+3yoJkYdXBwb8usS90B2CpNZolOb?=
 =?us-ascii?Q?m8EmhdE5kuV2Zk16GrHNhhHesIEKoAgW+CQzqf+V8saLZieODGBPgnLTGklq?=
 =?us-ascii?Q?+x+rFz+XdqvgDeUWyruqsgAKGW1I/j3A0EitqcMd/tSC4VI82g/HVyiOlstg?=
 =?us-ascii?Q?G6C4LW/G3jpzkbzMEWu7krFHUataedt7C6+sRYkWIbs2Rs8LBpcAaxBz/KJF?=
 =?us-ascii?Q?5B5GXFn6b9yD6GwDqCuppJ7jd4nAXFsAH/UF0CeezqLYjNhikEjWx2bihToX?=
 =?us-ascii?Q?6/S+6O3I6PnrvpvdBpwPIHAmvJXKTmTv5EiMcoTzGo5z+jDGR/eHMV/yUJkn?=
 =?us-ascii?Q?PQvX07liAIdfWvTxI1ciRYO9oWEGhNOrr17P0DbxwjItI/VgxJJdNUnTRP2k?=
 =?us-ascii?Q?sNV2bE3cX+MLv+KRX9AjaAH++edUQlgjHiU0os4GmzgW3uz8PM/Wd/u9Adr9?=
 =?us-ascii?Q?qBo6NMmBm/WDNkiu/LYngPou4gGQLxva4hPqV61SubDVzTNhjHsttafSGsuW?=
 =?us-ascii?Q?96135Wr8FatsDa+q12Yg8s2rPSBgN+t8ehoIRmeQqYj2G3/k+0bhSvKlI0k5?=
 =?us-ascii?Q?W88bsOZNJEUd9sMNOuSBKA9McRfsBI/Z+aHLZD2Y715jYfO7A9Z9k56eMw7x?=
 =?us-ascii?Q?EZ+3H89LGkZHq3leseYr2qqwKHZZnUSjUdWjyT5EH0FGVadcCLEJSC1v4AX9?=
 =?us-ascii?Q?2uiuoZ2U6bSMo+Vli9LZ5FSYpJnL/KksOFLTmWjFW0wtlOqfCwVl+A5gfuWG?=
 =?us-ascii?Q?wwKDp+yk+A0Nht85SYClkwUz+OU/ZwuN9G7VtFJusfH47OgBXLyQii2RhZ6X?=
 =?us-ascii?Q?C8O/xl3lwanoYkHxrMJBkhq1Ss91Ra3rNm9nFn7QIhA5U+RUZl0swINKDU5e?=
 =?us-ascii?Q?SULCVJuHHcwXLgbEANISW8E+6aCL7dNY74tzQ0ewsCMAgCb5W59AQ+/cW+dl?=
 =?us-ascii?Q?isAnsvNBF2WiN+ZB1mAJ6c6Juy/EBFFxmdaoeaJzqyWPBLppqnf/RPvrObNp?=
 =?us-ascii?Q?LHutxuYrkS2Ov/ZzfokeEP+ODiSvZTANThaGbJslZm1PFLIS8g7KjZuV6ZTY?=
 =?us-ascii?Q?LvIdz+PSZwhmQ2X6P/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:03:34.8540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbf7484-06a0-43a2-0ef1-08de0cf77864
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
accessors for PCI configuration space. The new type implements the
`Io` trait to share offset validation and bound-checking logic with
others.

Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 65 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 34729c6f5665..d7e0f18169d7 100644
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
@@ -305,6 +306,63 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
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
+pub struct ConfigSpace<'a, const SIZE: usize = 4096> {
+    pdev: &'a Device<device::Bound>,
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
+        self.pdev.cfg_size() as usize
+    }
+}
+
+macro_rules! call_config_read {
+    ($c_fn:ident, $self:ident, $offset:expr, $ty:ty, $_addr:expr) => {{
+        let mut val: $ty = 0;
+        let ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $offset as i32, &mut val) };
+        (ret == 0)
+            .then_some(Ok(val))
+            .unwrap_or_else(|| Err(Error::from_errno(ret)))
+    }};
+}
+
+macro_rules! call_config_write {
+    ($c_fn:ident, $self:ident, $offset:expr, $ty:ty, $_addr:expr, $value:expr) => {{
+        let ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $offset as i32, $value) };
+        (ret == 0)
+            .then_some(Ok(()))
+            .unwrap_or_else(|| Err(Error::from_errno(ret)))
+    }};
+}
+
+#[allow(dead_code)]
+impl<'a, const SIZE: usize> ConfigSpace<'a, SIZE> {
+    define_read!(read8, try_read8, call_config_read, pci_read_config_byte -> u8);
+    define_read!(read16, try_read16, call_config_read, pci_read_config_word -> u16);
+    define_read!(read32, try_read32, call_config_read, pci_read_config_dword -> u32);
+
+    define_write!(write8, try_write8, call_config_write, pci_write_config_byte <- u8);
+    define_write!(write16, try_write16, call_config_write, pci_write_config_word <- u16);
+    define_write!(write32, try_write32, call_config_write, pci_write_config_dword <- u32);
+}
+
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// # Invariants
@@ -582,6 +640,11 @@ pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
             request, flags, name, handler,
         ))
     }
+
+    /// Return an initialized object.
+    pub fn config_space<'a>(&'a self) -> Result<ConfigSpace<'a>> {
+        Ok(ConfigSpace { pdev: self })
+    }
 }
 
 impl Device<device::Core> {
-- 
2.47.3


