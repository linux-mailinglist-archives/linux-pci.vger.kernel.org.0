Return-Path: <linux-pci+bounces-41605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A495EC6E353
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 12:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5AA6B2DD47
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD23355051;
	Wed, 19 Nov 2025 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CRHbOx8W"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A815352954;
	Wed, 19 Nov 2025 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551366; cv=fail; b=VwPcWC3vejmvH32peYtXK0iYxL1LTCxLzLkH5Lro1EyG6M7ayrskb7vt4UX/1176GqhIyeeheqMrx/c5HY837q+5x/eZ6TzNuTIWGtQfyy0QZ9IXrAEJgj2EgMQbzwTS4zDjJA9VgQaGKrLHHn/rpQ8aa7A1Drxh5+nrLk4wwdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551366; c=relaxed/simple;
	bh=fR/DgZ5lG97qW1MgstYEvZeSmBG6KMMhqNfDN/9l2cU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYjVBal5EqomCVotrvcbJkROveaUuPWjPVrqKWSHuuyi+kcMUIAlhln+Cau9eYrVClLn5igB26cUO0896t1vL8g1x8R7Vcx3wamv2lic41nS0uI4jCw8KGx6rN0SKqiUNpqG9+n5nEYevum2q1Kira4TgEuzAQcwwNhSEeZW82s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CRHbOx8W; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UERi4CI2fOT5jls+edcey5fEdDEWo9PQXl5TWDpFrY2TUHvaMUwt7rAwCpAydfxmxZ4EBFfskg883B/gFp695gAvwkAuiymc5lrn/Zdre1s7I2yfXtXiTwB6pqn9dN4UewUYAq8O+yRDkTgwCDE65qiRSKTvP42XrPSja/47CLL///kyDemJwT6Vbg3YjrXGpCtNqhGUvyJ08JxvYYGggFeScwNkucjvadAKSIzOHlOmR4K3cmLygT6YF8LKHuEuuWR0OLxF0nSJiVBAyy7Bf3n6xbstdikR7+6xK+wpsWV78WajO5As4TqEH6wQUVYke9oRgURiu7a/TqxQQ+gAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJuZAvigxbvic2LJ2uis9r4bq/v7tdXamYFHmQfbcP4=;
 b=xQoTr9jPdynCNXEmSeIJchhdMpB515ZHuuhf/IaCEOp/TMq3Hy/gbpexj7ufFVl1/f8spVawPCgURxBeUndK2X9+SQZCnm42jE7lphwzm2abXAtfUpIX5Va1JZr3glbkQCraKFDBgZUyXd77oSBzmBZgH54pqTV08oz0T6rusBrcuR+qdaHSp+rTQbbmffblT+noRfWPjwrzqRlL0k1UATl6FTOF2s2ZieaZJUMDCf4+4wvYTI6Grmp+nseXaP41SvaTdG5PTLofU7Rb/tLr8l11ILOaHIaiT4VLVI3pZtL1jtRCMb9tz7CVeQ/uJ6SdPx1HQGodtTHpc7KybIv6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJuZAvigxbvic2LJ2uis9r4bq/v7tdXamYFHmQfbcP4=;
 b=CRHbOx8WKWTStOWEVxbe/d+zud+RoA9X+zKAQs9EG/7esUv59eo7PseSy5jHfVVgAemGW2xyt507kNZQoESicoLH5wkdbQnRQ0udh/cMmXAW7WOqTtNlzB8CkfjJ+GqHronhTebZGAPENJ8mI+asjc2BGo0KCWJOLJfxoTdL1d06qxBMTY6SI8eEzepthHQwa7fVfPB8ZfdvXBi/uNtm5rOh16GKQresGF/7Oba2BjzmYz1vpAQxHIuz/XinMa4Gp7THwOAP2LM9U97vr3FpG9P8aReLTW/iycZUEOgqe8XnCj0Sh2kjq3aL1dXRD49QqYKbk/uGZ1Ix4lGSPS4fGw==
Received: from SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::10)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 11:22:39 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::1) by SJ0P220CA0002.outlook.office365.com
 (2603:10b6:a03:41b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 11:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 11:22:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 03:22:26 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 03:22:25 -0800
Received: from inno-vm-xubuntu (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 03:22:16 -0800
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
Subject: [PATCH v7 5/6] rust: pci: add config space read/write support
Date: Wed, 19 Nov 2025 13:21:15 +0200
Message-ID: <20251119112117.116979-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119112117.116979-1-zhiw@nvidia.com>
References: <20251119112117.116979-1-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd63e50-429d-4627-03cb-08de275df29d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0l4dW12YWNUMnhLY2d2ZTUzRE54dHY1OXlnMlFoOHpVMjdwYWxxMHRkNVBW?=
 =?utf-8?B?OHI2Ymt2YjBMRWhZMVBFNnZ2emtnRk9DeG1Qb080QjM1ZldoZGNRUFQvT3JJ?=
 =?utf-8?B?KzVLeDBnWWZtYzYwTFB0L2Q3Q1I5elIrRDJkV0RMd2JrY09qaG9iSDBsUGlB?=
 =?utf-8?B?MDh3cVhIOUZOQ1FsYTlXQm1nUGVENmgyb0dDNHFkc05xQkoxd1k3TkNFUWZC?=
 =?utf-8?B?NDVHNmlseEs0Q3hKZ0g4REYzWDFHVUpGVkJZY09Rb3BDSmxZSGpuVTM5U1N5?=
 =?utf-8?B?M2NJdlVrbWtiMmdKRkFFdGY4MXd1RysrWW1mbEI1OW1wOVd5Y05pb053bXVE?=
 =?utf-8?B?Q216bkdTRUs4S2VrZkU0bzJ6Tk1uMThwUVFRZzUyRjRsVUtCQnhkNEpaTkRB?=
 =?utf-8?B?eXNVZUxtTERNRlJTQ0VQV3dDbk1OcUFMNHB4TlBNVFpLZ2ozbWR6bERqL3NJ?=
 =?utf-8?B?Ykw5YkRhNzBxVENUUE9uZ2VvaHN6L2xxU3pFWmR3V3EzeTMzVDM5S2pPMzMw?=
 =?utf-8?B?K0NxUFFNa2NuSVNnMGl5M3U3Mng2eG14d1kwVmJSSXVYbzhJNlZCclVsUWlz?=
 =?utf-8?B?MWZtZUx6NDBkODhWSUcyaWkwOXoxc1p2MTZBQ3BhZWxiQ2RaeGZhRFladnR4?=
 =?utf-8?B?WUVJV1RubEZtd01xSDRKaUpjazFXcERPMFhQZ2VLVWIyb29kSjdRemxKVkFj?=
 =?utf-8?B?dkRWTWtnWks0NWlLeFVQZzdxZysrZXVIUTJacUFYazBoNmJudVMxV3h2WUhR?=
 =?utf-8?B?cmlNYlBwOFlxSWU5VkwxdUJKZU5mWDk0elo0K1NiVzVOdVZDOWVsWEZXTnh2?=
 =?utf-8?B?cnVkVFhBUitZdDR5MTgyVlMrRi9PT0VxVFFqc0hQY281Z2JhL1JKVlB4YWNZ?=
 =?utf-8?B?QkVscFZkc0RudW5CazZCMFN3V2xJeHpoOGFUb2V6bFpSdFZrdlRYWFo3NlYy?=
 =?utf-8?B?QkZHNTJLdVVzOG5zZUhTbmlyQUhrYStqV2dXclEwZEJPMTl1TDdoU1MwZnBR?=
 =?utf-8?B?a0VWRlBKZFpJd0pFMUQ3Vno2eFd5NCs0Zk5USExNQS90WjdXSUNqYnFkNGIy?=
 =?utf-8?B?WjdOZGNPUTZrbGxTb0V3MStESmM0RGFkWEh4VjRsYUN4UmhYcjAvNUFpN0kr?=
 =?utf-8?B?dzBGcjlLTGRicnZpcHltVWFydFhHaEwwdk1WQTNVR0RWaDJVWkJzOEZCUHlH?=
 =?utf-8?B?dkJISDRkUFBOWGlZaDJEeGxqLzBaWXdXdU54VzVFK3Awcnp5WUpONG94RWEr?=
 =?utf-8?B?aTg2clhWcldWQ1JJNm96M0pZdE81OGdXUkYweXlJTDRzM3VzbjR2bUFpaHFh?=
 =?utf-8?B?NWduczhlSjJqejNvalJnODd1WHdIUS9ZRVJDejY2eGh3amZBR2xLVTFSUWdy?=
 =?utf-8?B?ODRzbmxSUjlvckxVTUNFZTU3dGFBdmpheXVFQUlHcThaa0VRVU95ZHJadFk2?=
 =?utf-8?B?MHhRZkFZU2Vmdm9MQ3E5WTBYa1RmbTVwR204c3hGQWNxd1p2UExuVHVhMm1r?=
 =?utf-8?B?VGQ4Q1B3VitBQzJIVEpBbXcvUmN5SnNKUzVGRnZUVHhkSzhNbGl1ejRxL3JV?=
 =?utf-8?B?WmNmUEZ1ODlLbHV3OTdTVG1ZTitKRXJFdGZLNHlwOG1qdjY2a0NmRDBCNE1w?=
 =?utf-8?B?RG43TEVVNTJ3Vjh2UkVXemp2UTd5RWVVSnNKa25aTTZibWdaVFViZCt4SDRB?=
 =?utf-8?B?ZUVoNmtzMGF0QXhMTTc4QVRIYTE5eDBYNDg2cEtCL0VvTkhyVEhuUjBOWG1V?=
 =?utf-8?B?S3ZGQzVlRlFHVlFBcXdFNFphOVU4UzZ4cVJTN2lJN21scnhqMTNtbTNjTDlB?=
 =?utf-8?B?dnl3ZnAxak5YQzlVMkVISkxqVlhlRVdYWm1CeGJFUVdMZVh4RnA4YjRyKzQ4?=
 =?utf-8?B?S0JuV2pQWWZ6ZExqTTRFcHZ2M2M0S012aXcxTXI3Ri81Wk1SdlZ4VXVIZ1Ns?=
 =?utf-8?B?TlJlY0xvYVRXeEFiVlBGelBtamtyRFU5S096NVBsT09Jd0Y4WmlGUnRPYXRT?=
 =?utf-8?B?NzBpclBQQytidnBBVU9uWmsrQlV2aEQ0VXoyYm9SNVZDclZhNDhkWXd6MTRr?=
 =?utf-8?B?ZG9abU9FTjdJSllLNDlna0NIaEtTS0VFcHV0c3FHK3J0a0dlQzFSUzZ1ZW85?=
 =?utf-8?Q?suMo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:22:38.8090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd63e50-429d-4627-03cb-08de275df29d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967

Drivers might need to access PCI config space for querying capability
structures and access the registers inside the structures.

For Rust drivers need to access PCI config space, the Rust PCI abstraction
needs to support it in a way that upholds Rust's safety principles.

Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
accessors for PCI config space. The new type implements the `Io` trait to
share offset validation and bound-checking logic with others.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs    |  43 ++++++++++++++-
 rust/kernel/pci/io.rs | 118 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 82e128431f08..f373413e8a84 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -40,7 +40,10 @@
     ClassMask,
     Vendor, //
 };
-pub use self::io::Bar;
+pub use self::io::{
+    Bar,
+    ConfigSpace, //
+};
 pub use self::irq::{
     IrqType,
     IrqTypes,
@@ -331,6 +334,30 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
     }
 }
 
+/// Represents the size of a PCI configuration space.
+///
+/// PCI devices can have either a *normal* (legacy) configuration space of 256 bytes,
+/// or an *extended* configuration space of 4096 bytes as defined in the PCI Express
+/// specification.
+#[repr(usize)]
+pub enum ConfigSpaceSize {
+    /// 256-byte legacy PCI configuration space.
+    Normal = 256,
+
+    /// 4096-byte PCIe extended configuration space.
+    Extended = 4096,
+}
+
+impl ConfigSpaceSize {
+    /// Get the raw value of this enum.
+    #[inline(always)]
+    pub const fn as_raw(self) -> usize {
+        // CAST: PCI configuration space size is at most 4096 bytes, so the value always fits
+        // within `usize` without truncation or sign change.
+        self as usize
+    }
+}
+
 impl Device {
     /// Returns the PCI vendor ID as [`Vendor`].
     ///
@@ -427,6 +454,20 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
+    /// Returns the size of configuration space.
+    fn cfg_size(&self) -> Result<ConfigSpaceSize> {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        let size = unsafe { (*self.as_raw()).cfg_size };
+        match size {
+            256 => Ok(ConfigSpaceSize::Normal),
+            4096 => Ok(ConfigSpaceSize::Extended),
+            _ => {
+                debug_assert!(false);
+                Err(EINVAL)
+            }
+        }
+    }
 }
 
 impl Device<device::Core> {
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 2bbb3261198d..72a83d4b6ea4 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -2,12 +2,19 @@
 
 //! PCI memory-mapped I/O infrastructure.
 
-use super::Device;
+use super::{
+    ConfigSpaceSize,
+    Device, //
+};
 use crate::{
     bindings,
     device,
     devres::Devres,
     io::{
+        define_read,
+        define_write,
+        Io,
+        IoInfallible,
         Mmio,
         MmioRaw, //
     },
@@ -16,6 +23,101 @@
 };
 use core::ops::Deref;
 
+/// The PCI configuration space of a device.
+///
+/// Provides typed read and write accessors for configuration registers
+/// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
+///
+/// The generic const parameter `SIZE` can be used to indicate the
+/// maximum size of the configuration space (e.g. 256 bytes for legacy,
+/// 4096 bytes for extended config space).
+pub struct ConfigSpace<'a, const SIZE: usize = { ConfigSpaceSize::Extended as usize }> {
+    pub(crate) pdev: &'a Device<device::Bound>,
+}
+
+/// Internal helper macros used to invoke C PCI configuration space read functions.
+///
+/// This macro is intended to be used by higher-level PCI configuration space access macros
+/// (define_read) and provides a unified expansion for infallible vs. fallible read semantics. It
+/// emits a direct call into the corresponding C helper and performs the required cast to the Rust
+/// return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the PCI configuration space write.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the value to read.
+/// * `$addr` – The PCI configuration space offset to read.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_config_read {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) => {{
+        let mut val: $ty = 0;
+        // SAFETY: By the type invariant `$self.pdev` is a valid address.
+        // CAST: The offset is cast to `i32` because the C functions expect a 32-bit signed offset
+        // parameter. PCI configuration space size is at most 4096 bytes, so the value always fits
+        // within `i32` without truncation or sign change.
+        // Return value from C function is ignored in infallible accessors.
+        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
+        val
+    }};
+}
+
+/// Internal helper macros used to invoke C PCI configuration space write functions.
+///
+/// This macro is intended to be used by higher-level PCI configuration space access macros
+/// (define_write) and provides a unified expansion for infallible vs. fallible read semantics. It
+/// emits a direct call into the corresponding C helper and performs the required cast to the Rust
+/// return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the PCI configuration space write.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the written value.
+/// * `$addr` – The configuration space offset to write.
+/// * `$value` – The value to write.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_config_write {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
+        // SAFETY: By the type invariant `$self.pdev` is a valid address.
+        // CAST: The offset is cast to `i32` because the C functions expect a 32-bit signed offset
+        // parameter. PCI configuration space size is at most 4096 bytes, so the value always fits
+        // within `i32` without truncation or sign change.
+        // Return value from C function is ignored in infallible accessors.
+        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };
+    };
+}
+
+impl<'a, const SIZE: usize> Io for ConfigSpace<'a, SIZE> {
+    const MIN_SIZE: usize = SIZE;
+
+    /// Returns the base address of the I/O region. It is always 0 for configuration space.
+    #[inline]
+    fn addr(&self) -> usize {
+        0
+    }
+
+    /// Returns the maximum size of the configuration space.
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.pdev.cfg_size().map_or(0, |v| v as usize)
+    }
+}
+
+impl<'a, const SIZE: usize> IoInfallible for ConfigSpace<'a, SIZE> {
+    define_read!(infallible, read8, call_config_read(pci_read_config_byte) -> u8);
+    define_read!(infallible, read16, call_config_read(pci_read_config_word) -> u16);
+    define_read!(infallible, read32, call_config_read(pci_read_config_dword) -> u32);
+
+    define_write!(infallible, write8, call_config_write(pci_write_config_byte) <- u8);
+    define_write!(infallible, write16, call_config_write(pci_write_config_word) <- u16);
+    define_write!(infallible, write32, call_config_write(pci_write_config_dword) <- u32);
+}
+
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// # Invariants
@@ -141,4 +243,18 @@ pub fn iomap_region<'a>(
     ) -> impl PinInit<Devres<Bar>, Error> + 'a {
         self.iomap_region_sized::<0>(bar, name)
     }
+
+    /// Return an initialized config space object.
+    pub fn config_space<'a>(
+        &'a self,
+    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal.as_raw() }>> {
+        Ok(ConfigSpace { pdev: self })
+    }
+
+    /// Return an initialized config space object.
+    pub fn config_space_extended<'a>(
+        &'a self,
+    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended.as_raw() }>> {
+        Ok(ConfigSpace { pdev: self })
+    }
 }
-- 
2.51.0


