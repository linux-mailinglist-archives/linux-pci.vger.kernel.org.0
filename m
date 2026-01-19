Return-Path: <linux-pci+bounces-45214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA655D3B833
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 21:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0569308CCE4
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 20:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852772EDD57;
	Mon, 19 Jan 2026 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZDyQHw9E"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E9A2EC55D;
	Mon, 19 Jan 2026 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854233; cv=fail; b=uvZbd8AR4OHW66Q+0Z/d25PmJ9IO73oAezLDcBUvdvq1MfLu8kp03YwQMfdJ0bCVOwEWQRZjvkPNBLeUuIqFo8aqrVdC12JLO6l/4Hoofk5wFrJlqc1F6a1UM0Noy5KyQOLBgwliHwgtqL/yjr61jS+r63FK3qFAB4A9Dpd4x5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854233; c=relaxed/simple;
	bh=Xz1BobtRKuSwIZyju3y+OayN1nnbSneUGnef1lClvG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OS5DXzE6VtgaX/oRp6lceT9OSIemQKm9qgyFxuZsoVFU8xHspKlKpM0SRS0fnDSEIlMxdJzbbaV9VWIcr1/OSsXTmfEN4OFD4iVlLrpDNTY6DIkOakycDvMLYkdTCztOPIi6P9XQkLac47BbC76iES1H8e14b1Pcyt5Tv5VFkks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZDyQHw9E; arc=fail smtp.client-ip=52.101.62.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckHxTmc3bQ5dasLHjyydPIHa+uswpwTX1Pfge1eMdHHBGQ/R5HedEnwhBj4DN6ReShkCLFtrYDixHdGcp4nY6ks4NHdhRtxL/WGy5VqTQYJC2lGniVpkYWp6xuI19cVwutLlWbgZiTIgXU16b0S9Lfw4C7JKD2mXCeEzD4iYeIPpJE27Ae+Pm6NlheJhEd4PFiOwrYCVSw363hE+PjANuBfmsEVXgG23xkwOYIizAc19urAuYgLvsoFIaxkyRUCudP8BMn9S2lGXvCQ98oy8u880F68K2j4DGDd8UWSzfpDfTXvBCMy/X3n7WOgzFtsyTb+zTKeH6RajLNZlBatTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8VCvZmmUfYJ9OBTD/idVIz9oLifdpcGpBPqw9ga+Hw=;
 b=nHSO5ibvetiKQj6SpYBeTSmg5V4yer10MHfVxeboqMbbz3MYL+WyIP18lnzXqYLQi4IcJJRYtD6vES+6Zvjb2+PeywE2flfD0hIjgLAqhH0RXVAEis2oRMGEUyXja+kYXMlCCpWbyt8xCj1z5AVb+FpXmYAYlyNeiQOpeaz6CAjbLgSDnWfM84K5hxF3BVytuF9MYDVqhDTsbkuQc+v347X8RNOfqGtu8M7dVNkUPZeY5n8sHA/SRv2FlFku73VgYFwGNsbD8VngGQiaZz5pFTcraLwJPIYaB0xjvrqgop8ubmG/We99PmuT0InqmCPQD8WESfG50ZzA/rKeKWjDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8VCvZmmUfYJ9OBTD/idVIz9oLifdpcGpBPqw9ga+Hw=;
 b=ZDyQHw9EtGzgDk57TSW9pxIr8yWm/K86Fp/aAo91hDgdMHw3Z8HltZ3aDo69pWOkMKVzdbncyp69rOKn29ARTJp7QmgZSvZCThcrD82D/PyoO2yDTwmKKohdjGaxZOlDtCTwsYNbH2Am7yCffScoNMw+eNdeqyVv8dnM1DPNCl3rwDXkXx3g0IHf2M/3JWroPoJEPzLN+Py7UOfAFtgGzRJsnIyEO4Gh7pUPyEHKqt1XL6+2ZbOTg/w9H+Lk2HXQcYVN3DI5ik5mGM1A2gSqRQs1p8pH+uwOamRGBp8F38bOKo38GZQ8bTeBcQKk3ydkXbX/au4sdKDyt97T35DGrQ==
Received: from SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) by
 CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 20:23:43 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:26:cafe::1b) by SA9P223CA0002.outlook.office365.com
 (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 20:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 20:23:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 12:23:25 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 12:23:25 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 19
 Jan 2026 12:23:19 -0800
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
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v10 4/5] rust: pci: add config space read/write support
Date: Mon, 19 Jan 2026 22:22:46 +0200
Message-ID: <20260119202250.870588-5-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119202250.870588-1-zhiw@nvidia.com>
References: <20260119202250.870588-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CYXPR12MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a58c80c-2dab-4456-a907-08de5798a430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mnltd3dxdHE5VDNiSjhPWkZYMU1CU2Q3QnNnR2JROENwK2l1NUlGZ2FaZmlI?=
 =?utf-8?B?b3Z2RFY4ZWNQVWgzMjBjRnE3QTNUSUtwRUI5ME5oL09MeU1rSDhnVHpUSjQw?=
 =?utf-8?B?ZVdHbVEwcXBkVVVyV3ZFSFZrQy85TmdtOVBTODk0dmsyb1d5RVI0TkZmbGtH?=
 =?utf-8?B?WVhrVjlDaUdSd2JMa0RzeThFa3RkUHBrZll6SXdIb0orYVpEdzZKZnVham1M?=
 =?utf-8?B?eldGUDIzeGgvcUt4bWJ4VmJ2dXB5MmQ5SzFXZk5sVXFNdEJhc3NKZ2VpaDBl?=
 =?utf-8?B?YVFHY2xCNnQ0VE4wZFBXUWlGUDVrQ3FFL3FmU05rQk1ZOWJvVEF5Zm5VUG8z?=
 =?utf-8?B?R0wyNjB0cmlsTjZ6eUJia2V2U0I2WTVndzM2QnV1L3NmRjF3dm1jdVFNUmNr?=
 =?utf-8?B?OXNkRnVZbmxQMWJtcXhsendaNFpuYUZYcUZEM1FMUkZVR1BBcjhyYUw0YzRV?=
 =?utf-8?B?U0VMRlh4b2dJYWZGUFQydlYzcVZ2czFyUGxITDM4d2U3Ukhib0JLUkVCOThm?=
 =?utf-8?B?UHIydFVpWldoanhBeDlhK0E0MjdWVkdyUWJmZVhOZS9TQlMwSHpaK3F1V1FS?=
 =?utf-8?B?KzYwSDZYZ2tza1YrM0RVc1B1N0xkaGRiM0NrTXpueTlsejdmUFhmeW1oMW1S?=
 =?utf-8?B?YWIzTFVmQWNEQXErWmdBMkRZcnVmbGVBNkVhY0VGR25jcU1Qa3BydzJtWFFX?=
 =?utf-8?B?MVFJY1hFU05PRXhkS2t2cFB0UjlsYjJMbExBb3ZSaTlwVGZJejRZczc4dHN5?=
 =?utf-8?B?MXNnb2dSSUg1aS9CZjZ0VGZRVEl5VG9KTkh5ZTZXRC9BNGp2R2dsOTZNSEx2?=
 =?utf-8?B?dVBBZjluUEFMZTYzTC9HTzQyWTNLUGEwZjd4aktNYkZYdk1MZDBVbnZLaVN4?=
 =?utf-8?B?YXhwOGM2TUhnTHo0V21rSWVWZkZsUFhxSU9US0RFUkh4NUM3WTQ3Y1FGU0hs?=
 =?utf-8?B?SEo5UlVSRXBMSlZSMElTVjVJdXUxQzlFajVtalJUdDdqRXRSNHZTV0g2cGg3?=
 =?utf-8?B?RURDWi9PVE0xb2I4enhDNUhKdHZQeGNZVGF1MDNsRTcxKzB6cktUWUtva3Ey?=
 =?utf-8?B?VytsblozeXBTNkQ3VXlpSlRhcUdUSnQ5L3FrWXlVUXV6aWNSSk5NZ1BPWXI0?=
 =?utf-8?B?ak1tOFBBQ1labng0SllUN0YwWFM0ekh4YUc3MS9qTjRnTFFzQU9BbFNJNjlE?=
 =?utf-8?B?M2pBVEdwdE9XVDNPWUc4TXlsZ1dkWVBNWWlzVythMVFvRW50eVoyT0FuZXVO?=
 =?utf-8?B?RjNJYjJqUTlaSWRYc2h5aVluSVhkMk9lZFdDVjZKcEIyWGtvdWhTc1ZLUy9w?=
 =?utf-8?B?MGFIbXJCT2I4M05sRkVNY1J3S3I2UWFBL3pNdXR6bHlCdDZRcmc2OFJtYXhB?=
 =?utf-8?B?ZVV0c3lqUEVPTFBhZVpLL0x0SmxyQTlpOXg0bEFaTVJGZ0YrcWpaYnRxeDN1?=
 =?utf-8?B?NnVDdjlpZng4c0M1blc0bmV4cjBKM0ltRkpnSFdYeS9FTmRMNHRTWmh4Ny9u?=
 =?utf-8?B?OWxUSmxHQlJ6MldEcXFueWpXNGpvM0NxejY0NWlEOXJScklrUDhGeWkxSWtY?=
 =?utf-8?B?bWhVQ2RKZFJqRDJ6OGk4NXBwN3VMeVJ5QWFFamZOR0I2V0VmMzA1eDJ3c3FO?=
 =?utf-8?B?Y0ZUUHZqTHprT05ZVHBMQlBDa2UvU1dlVE5Oemk3S3grNTZ1Wlh0OFloZmJB?=
 =?utf-8?B?dVozYnBURGxHRmdDR2piN2xxSmRiQWdPcGUvSzVLaW5tVGNUZklUSGFVRXhM?=
 =?utf-8?B?NldtZXZyWG8zRm9hVlh2dzRZRkY1ZHc5UUw4MzJNaUl4RFZ1OVdRamtmYVpz?=
 =?utf-8?B?NDNQV3dTNDJVcUZjQmVmaVd0QlNFUkh5dDhZVlNjUVVYcklqWDIvbmFsbEVo?=
 =?utf-8?B?WjZwTkRTb2RUb3RSeHBKaXJoWFAwdU1LaVNRMXJtalZaSnc4eThNb0tGdll1?=
 =?utf-8?B?RjkxQmNFU2NtcEdDeWVIN3R2dkxZV3RGbTNEVXQxK3hjVDVoR2EvbThaWUNz?=
 =?utf-8?B?ME92REN5VGhQa1FtcUpWeThCWkw3T25TUDVQNlNUT0ZJalorODk4Ny84bGYz?=
 =?utf-8?B?MElROVlINXdxYVFjQjgrWUpGSkdDV0lOWFQrTGdoaHVKWWJHRmJSQXNoaFlO?=
 =?utf-8?B?ZzhWbFNUZDlHNWhxTDNOdVJVVXpYNlVLc3FjQUNxQW1keEZuUitjUVJheDF4?=
 =?utf-8?B?emxkaERoVU9yQzZIVktwZTI5VGVKTXNBamJQdkNrVG92ZlFLU1dYaDFYYlN4?=
 =?utf-8?B?REVHQ0pHbDBqci9ZY0F2aWlkcTNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:23:43.3060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a58c80c-2dab-4456-a907-08de5798a430
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9280

Drivers might need to access PCI config space for querying capability
structures and access the registers inside the structures.

For Rust drivers need to access PCI config space, the Rust PCI abstraction
needs to support it in a way that upholds Rust's safety principles.

Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
accessors for PCI config space. The new type implements the `Io` trait and
`IoCapable<T>` for u8, u16, and u32 to share offset validation and
bound-checking logic with other I/O backends.

Note that PCI configuration space only supports infallible operations through
IoCapable<T> and does not implement IoTryCapable<T>, as the underlying C
functions' return values are ignored. Additionally, 64-bit access is not
supported as it is not part of the PCI specification.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci/io.rs | 159 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index e3377397666e..46ec75537097 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,6 +8,10 @@
     device,
     devres::Devres,
     io::{
+        define_read,
+        define_write,
+        Io,
+        IoCapable,
         Mmio,
         MmioRaw, //
     },
@@ -16,6 +20,133 @@
 };
 use core::ops::Deref;
 
+/// Represents the size of a PCI configuration space.
+///
+/// PCI devices can have either a *normal* (legacy) configuration space of 256 bytes,
+/// or an *extended* configuration space of 4096 bytes as defined in the PCI Express
+/// specification.
+#[repr(usize)]
+pub(super) enum ConfigSpaceSize {
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
+    pub(super) const fn as_raw(self) -> usize {
+        // CAST: PCI configuration space size is at most 4096 bytes, so the value always fits
+        // within `usize` without truncation or sign change.
+        self as usize
+    }
+}
+
+/// The PCI configuration space of a device.
+///
+/// Provides typed read and write accessors for configuration registers
+/// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
+///
+/// The generic const parameter `SIZE` can be used to indicate the
+/// maximum size of the configuration space (e.g. `ConfigSpaceSize::Normal`
+/// or `ConfigSpaceSize::Extended`).
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
+// PCI configuration space supports 8, 16, and 32-bit accesses.
+// Note: PCI configuration space only supports infallible operations (IoCapable),
+// not fallible operations (IoTryCapable).
+impl<'a, const SIZE: usize> IoCapable<u8> for ConfigSpace<'a, SIZE> {
+    define_read!(infallible, read, call_config_read(pci_read_config_byte) -> u8);
+    define_write!(infallible, write, call_config_write(pci_write_config_byte) <- u8);
+}
+
+impl<'a, const SIZE: usize> IoCapable<u16> for ConfigSpace<'a, SIZE> {
+    define_read!(infallible, read, call_config_read(pci_read_config_word) -> u16);
+    define_write!(infallible, write, call_config_write(pci_write_config_word) <- u16);
+}
+
+impl<'a, const SIZE: usize> IoCapable<u32> for ConfigSpace<'a, SIZE> {
+    define_read!(infallible, read, call_config_read(pci_read_config_dword) -> u32);
+    define_write!(infallible, write, call_config_write(pci_write_config_dword) <- u32);
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
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// I/O backend assumes that the device is little-endian and will automatically
@@ -144,4 +275,32 @@ pub fn iomap_region<'a>(
     ) -> impl PinInit<Devres<Bar>, Error> + 'a {
         self.iomap_region_sized::<0>(bar, name)
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


