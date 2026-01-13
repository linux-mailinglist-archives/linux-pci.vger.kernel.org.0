Return-Path: <linux-pci+bounces-44592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0B4D17B3D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D17830F031C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 09:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B5138B7B8;
	Tue, 13 Jan 2026 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZI3j9nxJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54632A3F1;
	Tue, 13 Jan 2026 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296239; cv=fail; b=DrO8H52hOhpcRnmqTjCZVDNZLnk1PCyTX+PQw8pebUga3a2iCkmrvAULwvHyeDZRrhd9vqsIOCXiF9UKuoHFBLjFrXtR8UCrF05l+XMFN0lwgxIhi2QCgfsHt5ecrBbr6LamHI78KuD3XZwBNhQdwUqQTPX9g8xiPS6O4SBck1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296239; c=relaxed/simple;
	bh=y+IA+Sz8RYjDyctuus4LwnQCql+X+V9nMaV04LeKz7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bddtg4ZrdB/BZ+ls6snIG+5hf3+/7kIYKROvLGpi4/Otwco9x/aL8hPehFQKq1MLM+6AvwqTWWEO+j/ozYm4xLV8tgl7los6xcnBnYzaflSZQz5ETeD7a9lAWG7K2DcJJF9J7J7953eb3QPlOVf5wPzxNKRCmwQE15b4zz/0rB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZI3j9nxJ; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JibaL5ecCG8se46pnD+3U7zTUyA8Ks37SlYjU7FxpvK9vFWYHX/om4jKPhmYsI/OihOTxdHAkKWZyJoqRGrqO642RvWtovZedAoYi2EU1sKtg0zR7Vwd6p/VPT6kqjBnNDMgtDz6jyFXYMGNpT0sm/j8vsG1jSaLolHO8oQJNj811S6NrKtBlLKY+nkKVOXQudwTlXWIA46GB2wAAXcdMxZ0YLhzjsdHZ2CoRDvx5WZ6roVqh76JGjAmd2MHc9ecXaR1x6fNw/JBxQvzjEkyR3spNnFbqNTy7rLzG+j0mJ41HbfsNDDwmswE7vpy08gInrdSkHAFH+nbbDuDz8KrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mHRspm9EyprAyU+CMRRaAAt+uz8c/CtZHap7eE+aIo=;
 b=jFunTLv8mO9aqjExd0aJEMt+cY6xZzJAt8iCRun1vrflZyeqMnoYE8VFGExfmNV9dKRyEG+spP+Q12u262j07hscoT6jU0jTezJeFRSdLVErzq7Hm509f1Z8ZuNLp/I2ZRh/YWuXNt6c84cLfE9o7DjZMoVSjYFFMUiJYHSv9pHGbMutQToblGQ7WsZzU7DXL7Dz5SDv1qXDp5DccsfrnfGaJZXIcKhiKUJhs24BL0Sf8LyNY8dWdKV1S2ao7kvO3pPNVhf8wfbJP9eTXIzw7dj09UfiBlBl9xt+/qeAlZbqHVclUAPXh699yjsHckwYeRBcrof/shWTkPW+Lcq3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mHRspm9EyprAyU+CMRRaAAt+uz8c/CtZHap7eE+aIo=;
 b=ZI3j9nxJysOfunW/RpjTaBVQHlljtPaX3RLWqwQFVOoSr2yBmRY1wRdd5NgKpux74QREqIkCKCpoEJbkqYboVBV7Zx8sneYQ+ukqgkUnN4yWyf/PRjWtGAtpMfE8yIov0met8CukZiK9DKO7LqahI0fEHvNB4WLvvXugFM2vhehd/2vxZxYQNgY7Vf0XxYShR3ZyxQsZvwTUqlULfmudnvpA6B1GI2kOXTLxeL0xUVUo/3usW+e2KP0bhS9hcmcrvxw7fN7u/GQwxZatrE2uGAhTQr3VTnfjnqazXrausOJVQRN+cteAizMzKSwWPSXWYPD+RDBQ/iBtrir7mVBAiQ==
Received: from MW4PR04CA0280.namprd04.prod.outlook.com (2603:10b6:303:89::15)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 09:23:47 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::b6) by MW4PR04CA0280.outlook.office365.com
 (2603:10b6:303:89::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.8 via Frontend Transport; Tue,
 13 Jan 2026 09:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 09:23:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 01:23:23 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 01:23:23 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 13
 Jan 2026 01:23:17 -0800
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
Subject: [PATCH v8 3/5] rust: io: factor out MMIO read/write macros
Date: Tue, 13 Jan 2026 11:22:50 +0200
Message-ID: <20260113092253.220346-4-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113092253.220346-1-zhiw@nvidia.com>
References: <20260113092253.220346-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MW4PR12MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: e28d5531-96b4-47f1-7894-08de52857464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3pKeGwvN0NhdnpoTkFEaHdxVWV0eWlWcHNaOGtGUUw4NEYyK2s1UjYvVHJa?=
 =?utf-8?B?L29sUlg3czF0SmtGaEU0VjZCZVFrVU5SR25HWjNkY1dYVTdZaEdnQmFTTyta?=
 =?utf-8?B?YkRvYlJmc2Q4c1JGMUtLSEthcXgzT1FodnJGYmZ2SFZGN0Fhd1Z3a2N2OVdQ?=
 =?utf-8?B?V0JkUzRzNGlUTGFaWkxuTGxKa0xncGVkbXpSbEpDcEFVZktCdWJ3OXIrdzlk?=
 =?utf-8?B?Sm1FekpWZzNyZ2loYittZFh2TW5wUUtzY3lsVytreTU0US9FT2ZUYWRhVGpW?=
 =?utf-8?B?RmVGMml5KzB6VlFUemNLOHNSd2ZrTlVyR0tXcGVnZDFmRUQzeVJPb3VFMUVY?=
 =?utf-8?B?U3Bwc1NlVlprMEl5Yi9BZ1FTVE5nQzB2VWxHOXdvZ0tZeEV2TktYWW5DNnZj?=
 =?utf-8?B?NjQ0OW8vMlI2Um8yZ1FIWmFyRHlXQWJtNUpIWVBzMG1TZG9KdXg2MkJKcCs0?=
 =?utf-8?B?RlNweFVxSDFJUnRXdWJzR0tza2xuMGNDeCt1QStWOUtQVlFuKzg3QzRwc3N0?=
 =?utf-8?B?THlVc0w5UzZkWnVIdkliVHpDUGNtUjhPMjlhUE95NFFBTHowN1M1Q05ZVXY3?=
 =?utf-8?B?alB3RXNSVGNwYTliTFArS3ZQY0tTbTRvNGI0Y2NaaFNyU1dydHFJc0RUaDVC?=
 =?utf-8?B?a0ZBZHkyNEdrYnZ5cUhQVDUzOFRPOFhZM0Z2L1MrclQzTkNqM0dxQUpmVkkv?=
 =?utf-8?B?ak44RTl4QnlaK1VCOVlFUmV3N2JVWnhvWXdzMkVHeTVOUnA5SVBYWWdrZHV3?=
 =?utf-8?B?V0NsZzlmUVpTaGZvcEI2ZUNHaVVneVZuQ0lMUEF5TGpQQ2VSVFJLK25RRzBU?=
 =?utf-8?B?Tm5zOENjYzJLSE5LSmhMRXhTd2N1WXB5TjhJY2VTeXFYblpQWWY1Qy9KQzlC?=
 =?utf-8?B?NDlGejZzSkFHT0tLQy9xcGpYMlp3aDdMWlVPa2F3Nkp1anQwS0VEb1kxTmlH?=
 =?utf-8?B?NFVMSzNUb1hmRS83RXB3YmNRckkrSkw1U3FaQzRkZ2d3OFpCTzlXVUhLOGV4?=
 =?utf-8?B?dm1BenM3eElOemZ5ZnNnaE9tY2dnK092YmxqdGhPamRIYWh2OXB6V3VGMHZH?=
 =?utf-8?B?TVJiVmFCcGUxbk0zZTVkalZDakhBK2NhME9CbTBsOHpITXMxSCt6am1YSzYw?=
 =?utf-8?B?WGJKU2xBT0hkbHBOQTBQWEpNMzcvU21CREEvRmRVTXJIQnZnS2hPOHVhc0Mr?=
 =?utf-8?B?OCsvVTNETStqbGdudFA4L2kwOTNwZUJPVlQwVnBaMDJjQXVWZUxOZEtRTWwz?=
 =?utf-8?B?NzZQZjVRMzhPeFZnempXa3FLZy9xRUEzd3pZa0dCeE9ya01tOXRpWEpMVWdN?=
 =?utf-8?B?ZWF0V3lRQUdvLzBxTEhGS1lJbTEvbGRDbUF5eDBjVGFScU4wMFY2SnByd2Fa?=
 =?utf-8?B?UkwrSm1mWGRpTjNHM1ZvVnNFVS8vY2psSitFa3c1bEtYaW9VUDgyK1V5TkNS?=
 =?utf-8?B?SW9QOEZMcXk4NDd3ZmRXRTJQYmIvVDErWm9RZlVwa1ZvVnlZbEVscEE1NVFz?=
 =?utf-8?B?VXo0ejlqdTRBbUhROXhhRjVLdzRtcVp5SjlMS1N0ZExhSUtBckhnK1o0YnFW?=
 =?utf-8?B?TmY1VmY2emEyMFBhSUNTak5rN0gvV3U2M08vVlNMbFpocUZSQ1UrS2lWdVJN?=
 =?utf-8?B?b01WRU9ENzlSU3RTYTU0RmhFaGNGQ2w3b1g0TVZqT3dPWWtGUW9CeWZvVnFt?=
 =?utf-8?B?Qmg0eUYySUZhYUpRaE81NytKSXlYQlhYT0M3YWlaT2J4bDJJcms3UFNCSnd5?=
 =?utf-8?B?cEppaGI2am50M1JGdW5KU2ttYUYvWFduOUlZdG9rZ0llQmZxOUFIZkVSVEwr?=
 =?utf-8?B?Z3Z6enZGSnIwM2NZQ1Q4SmpQM2IxVWxyVm13WW1raFQwL3J5Z29CdS85ZUpZ?=
 =?utf-8?B?Y3RiUmt5Q3RqSW9GYmNGcjhGR3lDb0lVUFpNd3lqY25mMG0zNWs4YVF4QTNC?=
 =?utf-8?B?bC9pdWZhMVhyaGtrZXYwaEFOYUNYZ1BkWkFha3lya28rSHdWQkEwZEplekxh?=
 =?utf-8?B?NXlsZittQnROYXdvSzFZbUJERGxPSVFmWUpTbDVHbngwUEVBTFdDZzIyYmJS?=
 =?utf-8?B?MXJJWjlsL2Ruc00zT0ZKdTVpMzQ3czhSaFRjN0tXdnZQaTg1SE5VTWg0cE9x?=
 =?utf-8?Q?r7yA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 09:23:46.8548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e28d5531-96b4-47f1-7894-08de52857464
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997

Refactor the existing MMIO accessors to use common call macros
instead of inlining the bindings calls in each `define_{read,write}!`
expansion.

This factoring separates the common offset/bounds checks from the
low-level call pattern, making it easier to add additional I/O accessor
families.

No functional change intended.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/io.rs | 149 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 104 insertions(+), 45 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 6e7f0d48ba3e..65a68da168c0 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -137,8 +137,65 @@ pub fn maxsize(&self) -> usize {
 #[repr(transparent)]
 pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
+/// Internal helper macros used to invoke C MMIO read functions.
+///
+/// This macro is intended to be used by higher-level MMIO access macros (define_read) and provides
+/// a unified expansion for infallible vs. fallible read semantics. It emits a direct call into the
+/// corresponding C helper and performs the required cast to the Rust return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the MMIO write.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the value to be read.
+/// * `$addr` – The MMIO address to read.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_mmio_read {
+    (infallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($addr as *const c_void) as $type }
+    };
+
+    (fallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {{
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        Ok(unsafe { bindings::$c_fn($addr as *const c_void) as $type })
+    }};
+}
+
+/// Internal helper macros used to invoke C MMIO write functions.
+///
+/// This macro is intended to be used by higher-level MMIO access macros (define_write) and provides
+/// a unified expansion for infallible vs. fallible read semantics. It emits a direct call into the
+/// corresponding C helper and performs the required cast to the Rust return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the MMIO write.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the written value.
+/// * `$addr` – The MMIO address to write.
+/// * `$value` – The value to write.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_mmio_write {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($value, $addr as *mut c_void) }
+    };
+
+    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {{
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($value, $addr as *mut c_void) };
+        Ok(())
+    }};
+}
+
 macro_rules! define_read {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident -> $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) ->
+     $type_name:ty) => {
         /// Read IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -148,12 +205,13 @@ macro_rules! define_read {
         $vis fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(addr as *const c_void) }
+            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
+            $call_macro!(infallible, $c_fn, self, $type_name, addr)
         }
     };
 
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident -> $type_name:ty) => {
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident($c_fn:ident) ->
+     $type_name:ty) => {
         /// Read IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
@@ -162,14 +220,16 @@ macro_rules! define_read {
         $vis fn $try_name(&self, offset: usize) -> Result<$type_name> {
             let addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            Ok(unsafe { bindings::$c_fn(addr as *const c_void) })
+            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
+            $call_macro!(fallible, $c_fn, self, $type_name, addr)
         }
     };
 }
+pub(crate) use define_read;
 
 macro_rules! define_write {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident <- $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) <-
+     $type_name:ty) => {
         /// Write IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -179,12 +239,12 @@ macro_rules! define_write {
         $vis fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
+            $call_macro!(infallible, $c_fn, self, $type_name, addr, value);
         }
     };
 
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident <- $type_name:ty) => {
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident($c_fn:ident) <-
+     $type_name:ty) => {
         /// Write IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
@@ -193,12 +253,11 @@ macro_rules! define_write {
         $vis fn $try_name(&self, value: $type_name, offset: usize) -> Result {
             let addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
-            Ok(())
+            $call_macro!(fallible, $c_fn, self, $type_name, addr, value)
         }
     };
 }
+pub(crate) use define_write;
 
 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
@@ -332,37 +391,37 @@ fn maxsize(&self) -> usize {
 }
 
 impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
-    define_read!(infallible, read8, readb -> u8);
-    define_read!(infallible, read16, readw -> u16);
-    define_read!(infallible, read32, readl -> u32);
+    define_read!(infallible, read8, call_mmio_read(readb) -> u8);
+    define_read!(infallible, read16, call_mmio_read(readw) -> u16);
+    define_read!(infallible, read32, call_mmio_read(readl) -> u32);
 
-    define_write!(infallible, write8, writeb <- u8);
-    define_write!(infallible, write16, writew <- u16);
-    define_write!(infallible, write32, writel <- u32);
+    define_write!(infallible, write8, call_mmio_write(writeb) <- u8);
+    define_write!(infallible, write16, call_mmio_write(writew) <- u16);
+    define_write!(infallible, write32, call_mmio_write(writel) <- u32);
 }
 
 impl<const SIZE: usize> Io for Mmio<SIZE> {
-    define_read!(fallible, try_read8, readb -> u8);
-    define_read!(fallible, try_read16, readw -> u16);
-    define_read!(fallible, try_read32, readl -> u32);
+    define_read!(fallible, try_read8, call_mmio_read(readb) -> u8);
+    define_read!(fallible, try_read16, call_mmio_read(readw) -> u16);
+    define_read!(fallible, try_read32, call_mmio_read(readl) -> u32);
 
-    define_write!(fallible, try_write8, writeb <- u8);
-    define_write!(fallible, try_write16, writew <- u16);
-    define_write!(fallible, try_write32, writel <- u32);
+    define_write!(fallible, try_write8, call_mmio_write(writeb) <- u8);
+    define_write!(fallible, try_write16, call_mmio_write(writew) <- u16);
+    define_write!(fallible, try_write32, call_mmio_write(writel) <- u32);
 }
 
 #[cfg(CONFIG_64BIT)]
 impl<const SIZE: usize> IoKnownSize64 for Mmio<SIZE> {
-    define_read!(infallible, read64, readq -> u64);
+    define_read!(infallible, read64, call_mmio_read(readq) -> u64);
 
-    define_write!(infallible, write64, writeq <- u64);
+    define_write!(infallible, write64, call_mmio_write(writeq) <- u64);
 }
 
 #[cfg(CONFIG_64BIT)]
 impl<const SIZE: usize> Io64 for Mmio<SIZE> {
-    define_read!(fallible, try_read64, readq -> u64);
+    define_read!(fallible, try_read64, call_mmio_read(readq) -> u64);
 
-    define_write!(fallible, try_write64, writeq <- u64);
+    define_write!(fallible, try_write64, call_mmio_write(writeq) <- u64);
 }
 
 impl<const SIZE: usize> Mmio<SIZE> {
@@ -377,43 +436,43 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
 
-    define_read!(infallible, pub read8_relaxed, readb_relaxed -> u8);
-    define_read!(infallible, pub read16_relaxed, readw_relaxed -> u16);
-    define_read!(infallible, pub read32_relaxed, readl_relaxed -> u32);
+    define_read!(infallible, pub read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
+    define_read!(infallible, pub read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
+    define_read!(infallible, pub read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
     define_read!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub read64_relaxed,
-        readq_relaxed -> u64
+        call_mmio_read(readq_relaxed) -> u64
     );
 
-    define_read!(fallible, pub try_read8_relaxed, readb_relaxed -> u8);
-    define_read!(fallible, pub try_read16_relaxed, readw_relaxed -> u16);
-    define_read!(fallible, pub try_read32_relaxed, readl_relaxed -> u32);
+    define_read!(fallible, pub try_read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
+    define_read!(fallible, pub try_read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
+    define_read!(fallible, pub try_read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
     define_read!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_read64_relaxed,
-        readq_relaxed -> u64
+        call_mmio_read(readq_relaxed) -> u64
     );
 
-    define_write!(infallible, pub write8_relaxed, writeb_relaxed <- u8);
-    define_write!(infallible, pub write16_relaxed, writew_relaxed <- u16);
-    define_write!(infallible, pub write32_relaxed, writel_relaxed <- u32);
+    define_write!(infallible, pub write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
+    define_write!(infallible, pub write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
+    define_write!(infallible, pub write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
     define_write!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub write64_relaxed,
-        writeq_relaxed <- u64
+        call_mmio_write(writeq_relaxed) <- u64
     );
 
-    define_write!(fallible, pub try_write8_relaxed, writeb_relaxed <- u8);
-    define_write!(fallible, pub try_write16_relaxed, writew_relaxed <- u16);
-    define_write!(fallible, pub try_write32_relaxed, writel_relaxed <- u32);
+    define_write!(fallible, pub try_write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
+    define_write!(fallible, pub try_write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
+    define_write!(fallible, pub try_write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
     define_write!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_write64_relaxed,
-        writeq_relaxed <- u64
+        call_mmio_write(writeq_relaxed) <- u64
     );
 }
-- 
2.51.0


