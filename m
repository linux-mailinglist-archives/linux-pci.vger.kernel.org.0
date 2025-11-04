Return-Path: <linux-pci+bounces-40211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44057C315FE
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 15:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B3444F746C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 14:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185B432B995;
	Tue,  4 Nov 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z9DwyIc6"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B9632BF22;
	Tue,  4 Nov 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265000; cv=fail; b=NcLZJ1KHSZRxSWvN56MOlV5RnVmNmylvaZjcWObFO6SdKGSNSSVCYuvtWChepdUWNKRMzz7vSfBDM1ZE0Uvct6MnrCbuwqcMRB1I8tt2+pBnqr1fd3Tm1go3yfNRMpIYsD1O+s4eWTYBaJMo59AYdq80NM4kdYDKX255YvzUwnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265000; c=relaxed/simple;
	bh=EvxGsCLq437aLxeiB5mre3cqme48yiOW5z45YqRZLHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5xDaKLv5Ommq4F50WbG7AyFVakGgGc9Ygrn+CPYUc8uOdx44DO+qwcWK0SlriSHjT67iNTLTe0QYgy8jb8pdm+EttcMITUIgKHNAX8aNTh/FR79Ahn2JBdqw5XS659zYrYT4hMjpF5p9zvSHGYQvgID/Ugrd+2Jzy6pF8tucow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z9DwyIc6; arc=fail smtp.client-ip=52.101.46.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbmrX6MwXL0kgb1DeRNyEEXf+82ykTba3WaQ/mFcvOiDf+we6ccWuE3OFU07ypCR1Z9riNOgJ0qbcou1WdlB9WpYsZv03U9mF26MA8rv/pRHsN8tyiPt9v9q7ExLJ3a2ejPbBIC5PwsB/hBB3JPtLEvgfLFUjegxlhPs32uRtTA92gbyCGaq8fGsLOgbb+gZtIUTo0F/SzZLo/Jck5gsoh2l4ysGb6xp3Br/hReTFb3MXhcLX3okt5fzi95r/sC2C20BETaQH4TsgWi8NqxDeRogAVYMwjxIpjyNz16dEvehy9W5k34tp5lpJTiBcmkU9h6Mlq+gv8yAKqp+hL64Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgQx+7ipXsbEhGn4QRxvnBQl0VsR7YO6MrDRl6ASxbM=;
 b=e/RgU1+qHc8pd1sRChaQhd3BEzmHQCI/jx9JLaQZwyNYPGJHdaFgfGlzix4hHRfn36l/ttbHO7kgz6Vhdmuc9HNwLi8hjn76+xbm2CffB4lBye9vnynMsmpWY/krTEMenZKnk1htja/uPK2T5HzNEZAg1q/swYhmUtgWwYdElqIDHgTCGdn7O5TtZrCui+we7WOXfEdQkX2YrRhCt4qgZrb0VhhgGJ3a7u7NSBnA0wUKk1j8xPd/CqoLEvxT3s66rrS1S35zJDm+xHnKkUwZa6PHOg2aKzW1jucDmWES1SBYiyjnxL16QsaoGc6vWxJgCE4b56+VvzQSrYWWQwMaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgQx+7ipXsbEhGn4QRxvnBQl0VsR7YO6MrDRl6ASxbM=;
 b=Z9DwyIc6yswg2Nch8ysnr6cGNkC0uzBrAKOzLrorfXqJ/Gp68+xHCCsiANzLohnRi7MA9Cd7shKX3GGMnOs7nG5jqlFAr2xK8gjSqj1KHuLD3hHRdlEZbH2vEWjQRfuwJt77L9l9iWcyaanCpvuR/yDXdBXcEJUOGoZnD3K6G+JXUJlYuepb0Jwb7PX8gF0kwgjF8jylb+qmUTkY3lgRGBFscAORHDrDaDquHlhsbQenhUgw2yUX636EhwvHJIeqAXIv6w4Kn0rB5LYs2JeAp71rv+U65Zg+JWCAR84hbF4V8DzYcmsiwxYs7X8IczvJo/PJCyNiYB0hOt5t9+n8vA==
Received: from SJ0PR03CA0241.namprd03.prod.outlook.com (2603:10b6:a03:3a0::6)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:03:14 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::d4) by SJ0PR03CA0241.outlook.office365.com
 (2603:10b6:a03:3a0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 14:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:03:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:02:56 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:02:55 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 4 Nov
 2025 06:02:45 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 4/4] sample: rust: pci: add tests for config space routines
Date: Tue, 4 Nov 2025 16:01:56 +0200
Message-ID: <20251104140156.4745-5-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104140156.4745-1-zhiw@nvidia.com>
References: <20251104140156.4745-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|BY5PR12MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: 5105df0c-d71c-4b6f-528d-08de1baae5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GfaSHuSn9Xl4h3DhDZj2/aYWJUQGGM8w/pmxP/49FP+85UxUOxunnaRsbW4i?=
 =?us-ascii?Q?dzV8wVgpYI7PQuljtN3oMOazCmiIrUWyygCtaZbDUBG17zFW4sqhjeEeZJFa?=
 =?us-ascii?Q?qpL/sVKLbc7NmGQIUccA+TERxOMgB1JpB2apwLn52Ave7fqK6bUnMHxljnkH?=
 =?us-ascii?Q?bxzGZ2UialHISOh4si+DGLu9S0MVjy//VYb2Ybh/IA/kau+wdN+dt4Ea8fr2?=
 =?us-ascii?Q?3MJ/Uz6wOfjhaMdFWz7xB6NGbRlhxEm9R0qZ2y4sWE9wLM0TsXBUXlu3s3Wr?=
 =?us-ascii?Q?2suHxd53WQzIFvGB62aiQB39e3A1eSqxGbEg7Y8YPzIW1g2dBshSbq2yFgo7?=
 =?us-ascii?Q?So3rR2aQapV73YZ8f658igJYdzMqJAxMG0WUUCan27Epap7rLTdtuJF+QSxR?=
 =?us-ascii?Q?XKpzX4O1jRH+fgVmxx2j3eFY+JThX1rDsAE83oF+lLvyBssc9gC8MXotIdMO?=
 =?us-ascii?Q?VEBmYVg9B5OggnKD3YyV6OLcbBSnbRCLvm6/M9oh8fj60faO660BcpSwiBGi?=
 =?us-ascii?Q?z8Q2AjymN9SKgNhxpMY+PP3Pvgnp4YYqcIUMTeELEhEJ4LmJ0TB1gMYOOY/8?=
 =?us-ascii?Q?zkDC/VxpX4GeOdRRPz5KjNDVFcfqYqw5i21fcdhniXVxp7iLdm7m70S7IwEU?=
 =?us-ascii?Q?tR07GAnIx2P9kaMJ9uuy/zH7fquJsw8lFkZUK351Ke1h6e+ZBpUU4Qpx57+S?=
 =?us-ascii?Q?scxbUSWdqe2VIqXK8hh2Qr8R+5KO6MEQkUq92eAah4wDK0vfIgmDExnCThNd?=
 =?us-ascii?Q?CGROwIl32PCfGmDgWhWqyT8J+fgzxC3ICTaBovsQWkiMbHOlKNN06XEtKL23?=
 =?us-ascii?Q?QUwe9q38P6yNFaJ81AirA8AK9kvUxsjZPAQMgC4BMmUVf7R1Mv9KYSxx1gea?=
 =?us-ascii?Q?Xeg74PvvNuj/BM4o3CTfIUsTtpbto46WgyOCzku/m8rVjADi/5lwK5Vkf6+z?=
 =?us-ascii?Q?j6T6ncujuJScnCqeUETvS2MIA2Tj2ft37jju8tB24rTujVA9okFm5UFVoGya?=
 =?us-ascii?Q?SJRELmKo+kz9xQO6hD53mm7SO3fXd6ZvL1DS2mb6m8UYqActUiZU0ls+qfQb?=
 =?us-ascii?Q?Hna4LPmc3OmW5DRbEcU6fvs96Ok8uPMPuAYMKDr1I+mGNTvqu0ORJF0A0noU?=
 =?us-ascii?Q?Dyd2WGp9xM8cdaUigTNpU5TWvxBO7Du7yrHiWz/5rjer6ul2xUNwbKph70ht?=
 =?us-ascii?Q?3Gy2nNPSt2T278TyzjwUhU1h5W1HUocemxaGUe6Fmbv73kyxdUlUVBhabywM?=
 =?us-ascii?Q?Xmu/XlnsToT9sIoVh8OHx9r9a6r8txsUOrBDEQSiBKVr+0uUf7ebdUZVWitJ?=
 =?us-ascii?Q?bAia9ndosAR5Na3m1ZqrCD4majK7HicRQQNU0DSQpK2sZkh4/HKNQk37+yNX?=
 =?us-ascii?Q?tXXAFyq5j2auP5i0vLdU/CSzXyacfDL8tiRK2Z7lec2OXgNBiIqUBkT3ANik?=
 =?us-ascii?Q?4dtP7jFW2030/lm7tVRtb2VFxL8oSHvRyH2JFPG8RndXzGLWd3sO/hz+FavG?=
 =?us-ascii?Q?yJPYYSZyosp4Y210uw41vskrmKqJAYGL8CX6DaC3Ujhhd5riX28yRzwO8GTi?=
 =?us-ascii?Q?3wfDl5UZM6mGpwd6Rws=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:03:14.6564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5105df0c-d71c-4b6f-528d-08de1baae5da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034

Add tests exercising the PCI configuration space helpers.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 528e672b6b89..6f0324b6bdf6 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -58,6 +58,50 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
 
         Ok(bar.read32(Regs::COUNT))
     }
+
+    fn config_space(pdev: &pci::Device<Core>) -> Result {
+        let config = pdev.config_space()?;
+
+        // TODO: use the register!() macro for defining PCI configuration space registers once it
+        // has been move out of nova-core.
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space read8 rev ID: {:x}\n",
+            config.read8(0x8)
+        );
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space read16 vendor ID: {:x}\n",
+            config.read16(0)
+        );
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space read32 BAR 0: {:x}\n",
+            config.read32(0x10)
+        );
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space try_read8 rev ID: {:x}\n",
+            config.try_read8(0x8)?
+        );
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space try_read16 vendor ID: {:x}\n",
+            config.try_read16(0)?
+        );
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space try_read32 BAR 0: {:x}\n",
+            config.try_read32(0x10)?
+        );
+
+        Ok(())
+    }
 }
 
 impl pci::Driver for SampleDriver {
@@ -93,6 +137,8 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
             Self::testdev(info, bar)?
         );
 
+        Self::config_space(pdev)?;
+
         Ok(drvdata)
     }
 
-- 
2.51.0


