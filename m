Return-Path: <linux-pci+bounces-37796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03514BCC11C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 10:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD261425EB1
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF772848AA;
	Fri, 10 Oct 2025 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gD+H2mKI"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C46283C87;
	Fri, 10 Oct 2025 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083445; cv=fail; b=QBSzwyNDr4zLOXF/mwxhNxFYlOQwOK7L8boWChbz5oTG5jcHqet9Zt5J3cjbngwgvVj+fkl2Mk4qVarKLn+aoRuaKrr1cmT1hV7hGPDG/zRSPKsMzGigWbVpr43Tdxu/ihB+s9O/D9CwjPBzVIkhJj3dQzFG+EqDj03OV17Hp4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083445; c=relaxed/simple;
	bh=aPjKl+ViCa8ZQxczBV2CaMJOh/zbJjtqixUZ4XCFYhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bz7NH+wO+AYnbPVrC9kx1wuA/HRQZC/fEg1LAhkU5TEJ7CXXA+JX45AeJjKKE2CXUJyz2JpD1iaKJt93U2CpWll2OBNnYYtjiQA16bwHhYUNQJBa3u6xY8rpi+5E2fuf05n2iU5hDVbZhoYAeohplESRvDVszqfly2I7nedc0Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gD+H2mKI; arc=fail smtp.client-ip=52.101.43.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3tRvl5T0zOt4as+2m4Jxz/RCEJPNXNnRPbFGYAT8PZ13ZWrifhW2GsYblHXEM39eU2xCO5Ur2VWuVBPR5uO6Lo3pl34ZW+700NGQoqTrNnsQPGk/cipGbz9P2dAoz9hK+dJxqQT4fxO043Z+WuRP9xj7kSod12uIkEaGc0O3Y7UmOontqqsxPP7IChK6IoSBRC9FxBODtKYyJG0WdidmZ/KHSei7nIFSHEqDe+8I3gsJxl++TDCilkGebnp5KOafesTYtIJtbHS9kN8mgnb8qgIS/HzCn2bFNAReyOXpY9nZt7OqtXpWpJRsyZ1BXXemiS0M5Vqt8KVOIJPkQKrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaZQsoxp/XPfsQ4pui1JZzuVUDTG4rl1A5MyCP2VjXE=;
 b=MSIvqubMoI+S3w3d7jvAo3x7v7xvidIsjPqewFO57UKev4Zn/YMegW3O+XEv2dR91kFZ2a4Yr+gjIrsBh6qBKcx7vB7n99HwDUoKTVExtqRipe615xXYsi/FZyjIIoYER1GDMIEi38sA9IlzlQNXEVeqWZ4P9souLl5kMzVHq01EQM0msoFX/k1zdLJ3U6pxBXzAfstZ0hBqAWrRbdsDz7KphUMLSoP1gFH1SnVTQZW0fIFuFNcBD8Zkgxn0pcERv2EnIhkNphoordXBqP5PnXe/abN8kGfeMvLe7U6RigqxBwJj9zam6kgSI/hXM+MZt//sxoLzJQisgtubqGfqNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaZQsoxp/XPfsQ4pui1JZzuVUDTG4rl1A5MyCP2VjXE=;
 b=gD+H2mKIFYrigGXyl5pRkIbd/ChRbjtu6PSk4mtjSNO4e+1nZZaYYkKskSRx8cJZ7FfieoqKPihZhb6liytA6xRtdhpRy3RpP35cfAG1svO+EGfBWMbLdZO0SlR9Shg2rhxrt+NHha2SFWoYPBpcTcnPwTb6fRUOhERx1+Tv6ZtHNiK+zy+tcW7WNhPD3fjcm2q1voZtDGm6mJba3mVXjrtoABqZm6UloxFgQcNUABFX0GMVcYo9t5n6CWt3aKxshBQlGVFXCCfv3cztIVPPsag81YozHySZcgZD9E6BNqbe4iGckRZmh+6mHl3X1WKqYlRtkdlz7ELeLKe1D6PbHQ==
Received: from CH5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:610:1f4::21)
 by IA0PPF9A76BB3A6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 10 Oct
 2025 08:03:53 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::fc) by CH5PR04CA0020.outlook.office365.com
 (2603:10b6:610:1f4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 08:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 08:03:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 10 Oct
 2025 01:03:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 01:03:41 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 10 Oct 2025 01:03:41 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>
CC: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>
Subject: [RFC 3/6] rust: pci: add a helper to query configuration space size
Date: Fri, 10 Oct 2025 08:03:27 +0000
Message-ID: <20251010080330.183559-4-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010080330.183559-1-zhiw@nvidia.com>
References: <20251010080330.183559-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|IA0PPF9A76BB3A6:EE_
X-MS-Office365-Filtering-Correlation-Id: be4a10b2-c37c-416d-89db-08de07d38dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mwxkd51Ew8f/Gn1ydtlk6U/zY6svymCMsA/oyCmnZ7OEPUN3mhIQJzego8hS?=
 =?us-ascii?Q?47tBiqSFqZSfNR5V4OJbK2Wng7oCsqgCsHWPmVl4wksPNShLuT1900CT0tJx?=
 =?us-ascii?Q?xYHR76BlinwipHOWMVXio/v8ThETageYN1z5wokdHN2cjH5msuRuFZRvmgon?=
 =?us-ascii?Q?c1Wr44pTSscHppywNWBR+QnL5oYicCB3P36DYJP+UCrXbKWmo9IWGdfn/Hji?=
 =?us-ascii?Q?4X0okEuwWjfUsH873Rs8Z2s/wqYvbGof1arLnanYc7y4MKjKYrCCAk3GDtto?=
 =?us-ascii?Q?eGdge8p+D3OWPwe3zfHGde2hvfhEVMAXJO8GBCzG2VO57FU+iOxv/kVP7wvH?=
 =?us-ascii?Q?h0lkhAaxwVHU801JwIMTc1e22+3lSPsMsdzkCY/7eiaJKwNuS/oHyGSv0C9e?=
 =?us-ascii?Q?D1NTbXxetWOoSZCjtiW+0GoknJ8/TbhuK8cTMa/h5BMYdwP6xN6PTjCdRJ8D?=
 =?us-ascii?Q?yA/8Zb3H6mCwA4IvO42SNOmokSYpwP4b3Cc4gdPTpWIDNvPth3g9v1fpqnBV?=
 =?us-ascii?Q?n++53+2+ijkT0cv/uV4frOJZ6RFcQ51ouSnBBMtPC1zVQxEzIPslB3+W/AgL?=
 =?us-ascii?Q?IYLfFEonUsgUKsaIwVsGIcQcyG2UV5BqUw0SmbMjYPh3UkO7Vt740xfXpn4e?=
 =?us-ascii?Q?kJDpTAHTy1QMIqUf8uNyL3/RP7lH1U8v3spltqGpFgO/D2i5dLFDtWAb9xah?=
 =?us-ascii?Q?8viVToB7kDh9wIFRBOvc0BgRdMxKikdNYQ/U8jNYkRUTX5GUk5I7fbCGd7AN?=
 =?us-ascii?Q?XE+QvGaAL3/kHqPx3orJdvYaOsNffdraTJVSB2xnL1NbeN5Y3ju/qn8v86uS?=
 =?us-ascii?Q?8Wea1j8efgn2g/lQVKq2zIuNkCUmYM632rEZjAQhC3pyPbgk0zRG5GzJRJjG?=
 =?us-ascii?Q?LyytyBF/5VmWCo5cSRFU71ALP5Ptl6AG7tHLP3ccyQm//ihC8Z3nDAPnZZK+?=
 =?us-ascii?Q?UOIyDLch6SeRnuX76Uaf3TLW5r+AiYpOalat+X9uECjmi6rDu5My/GPuLY8L?=
 =?us-ascii?Q?1dBau9VdIqtaRlAcWgzj7PrVkglPs8Dx4M4DzeuDFRE5q5D7ztCThJUwUQSf?=
 =?us-ascii?Q?jK0jZyhJZbXQOosjy27yoPI/KIxeZoCIvEgCnh10vMnaM5gPM4qJQna72SfM?=
 =?us-ascii?Q?6Y3d1WfkQJ4rgzP9itQaaDOUldvLUx6HmwA7yjaPOs05JmYx9inaR/A0hRGl?=
 =?us-ascii?Q?zMA4mTu0y3GHV6asKL0hf3DMYWt1vwMq/DuzzHRvuZffarvhR7BtceyNvux1?=
 =?us-ascii?Q?GDaNCeO9hP5tEHaqvrPxIH8omZXoFljav4CXVWT+c7zKzmpUtdBiKysNEU9D?=
 =?us-ascii?Q?Uvm6NyCgVydG4TjgKW2dALtIHW5Kk8RWIX1K4LKi3LNcfVKxUWrySBD9WxRR?=
 =?us-ascii?Q?DTOVYEjpf9gCmkWShgRh4NbQ1iikqJV2WLNpnkE7FbSRSUNBCmY/EY7viVyP?=
 =?us-ascii?Q?KedwwNt0t8W5iBnZsh5ZyI0AbrO1NdRcKi7VX5dohdNiskcNtWmk+eBFl11K?=
 =?us-ascii?Q?Js1+FDAAuTyVhZYEgsKE7kfzKZPacxPzvQ2yJBZGBCfNxgKRZe9JTET8URjc?=
 =?us-ascii?Q?4+0bJrszWJ0Ccq0PAiY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 08:03:53.3248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be4a10b2-c37c-416d-89db-08de07d38dfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF9A76BB3A6

Expose a safe Rust wrapper for the `cfg_size` field of `struct pci_dev`,
allowing drivers to query the size of a device's configuration space.

This is useful for code that needs to know whether the device supports
extended configuration space (e.g. 256 vs 4096 bytes) when accessing PCI
configuration registers and apply runtime checks.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..7a107015e7d2 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -410,6 +410,12 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
         Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
     }
+
+    /// Returns the size of configuration space.
+    pub fn cfg_size(&self) -> i32 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).cfg_size }
+    }
 }
 
 impl Device<device::Bound> {
-- 
2.47.3


