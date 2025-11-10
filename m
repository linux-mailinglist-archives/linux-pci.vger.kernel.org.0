Return-Path: <linux-pci+bounces-40784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BAFC49488
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3396934B679
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD942F60A7;
	Mon, 10 Nov 2025 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a6p2ZbQH"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49202F60A5;
	Mon, 10 Nov 2025 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807379; cv=fail; b=GgsmIvecBxtAE+2pnfAIpPT8puXTDSzpRheNGcp/WB0eMJfwrQpQp/t/vFRz78pp9JJZzURES2LphwxyyF2sBSLIJxGk1f4t2eFJqjaWgx5UtLZUlQeTki/rUmaHdakeFZCejcljMFRU4D+64/Bu9n8J6mGPpLecDs9Si2F7QL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807379; c=relaxed/simple;
	bh=UAlVehZO/BQ/Gxn53y1vcfvwyawrTeQ7k4WK965Triw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTtv7eGMaxZBfO6jYFh0+Nvd4mo3jt6G2sNGeVvKwj/J0EkhTOSOG7ezyp78YdOHuJVrte2QE1uwVHOARZgvukGhiXlk5i3ZeL8YR0SdApSW8Gaxi83ZIWlEJP8V/xT6QyFEu16NbVNOOmGNxVfZLaeAUJfOdmS6g4cmHXjsiUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a6p2ZbQH; arc=fail smtp.client-ip=52.101.56.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fvjv+GwQQrVsdFWH/lY3ZEQAHO7YtCpMIztjTILZuvCzrQV69IG8AWeJzO0dnANYLRw30GSYc7jdC6lLdTiPdKYqIm3ir6piaHqa98cWWAjf0EpIjspX3AbApNdUGt8U5froRMIHXU3hyU+cp5gJKzvtGyvw48q4IU9qMfH0Q76GUW1krrzri+U+4unf82fY50SX5iWn9zGL5bwaox5+uchfXs9Vf/rdLsja/B5QMrXWSMLfT7ztH7GAdKHSlcJa+0aaKJOE+Dqptyy4zh6xPg6lf7SAM+iBq+qANQ98ZuREnwaH8D+2ugZnQ+M4CiQEgEhcp5rzWIW4/9yMdKGr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttAQUT9oaBSccgpLNPFsHih6Q/up1j5LBKjPOrlSrGU=;
 b=duWygBa+Kzz3UFIGe0ZsGWwLT7D0V2rMvqF6wLbWdatQ14dkR81bTelfZ2duqQF/TiZiDBt18uCRhZ+H/mvnZ+W5K3/0uotRgYlduSP8ztH2I1cvw1Ns57hg5r5KqAAdUty1V4Ba5W0hAT09doT9xGj2xetuHSmqYx/hFZ2WIK9ePCTk4+sVL+TfFiUb3mcqRDSwX36b+mU9ktRkuwBf31MMa/7Se+f6cBMZfLCTb1xtjta2UNc6v+cZCnRAoN5Q+6PIUXjwpx0lXvPwG2cWMCVuaL9Y8AzWVS1FTqEjgSxv95CRLZJx7JOC+ZVzaHqPMpa6tu3usU07hCtjw6HuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttAQUT9oaBSccgpLNPFsHih6Q/up1j5LBKjPOrlSrGU=;
 b=a6p2ZbQHaZh4BubLctXHWHma62WDI0/uAFp+MBYL1cS9EpMkyKNtzcz33qidzEpFicB7RwG62dS8/NXiyDFoc3TXtrY54g4gPsuMGOSYQqGi0C8Nxmswh0KojixcJteMgK1LFOY18NC6+aRwjT5T4uLoZdeTYEnVxZRywF336lwAUbPfJBKxaN7Nj2VJkZ0Z+1O+0Il7V6/m2Zmdxa7+3LmJoQ/W6yrhTEOkiVIUsUj5f60sWLa5MnhsMKPxkwDZeajvH9lUi7DcIxustO7bTh7c4RRW3If9Sv//gutTGZlzg1f9BCZDdDLMK4Xh6I/sP1fXH7ZTKnMnzN9mrohaLA==
Received: from SJ0PR05CA0190.namprd05.prod.outlook.com (2603:10b6:a03:330::15)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:42:53 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::40) by SJ0PR05CA0190.outlook.office365.com
 (2603:10b6:a03:330::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Mon,
 10 Nov 2025 20:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:42:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:42:35 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:42:35 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:42:27 -0800
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
Subject: [PATCH v6 RESNED 7/7] sample: rust: pci: add tests for config space routines
Date: Mon, 10 Nov 2025 22:41:19 +0200
Message-ID: <20251110204119.18351-8-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110204119.18351-1-zhiw@nvidia.com>
References: <20251110204119.18351-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f4d464-19e9-458e-7efe-08de2099b889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eRraBywqqb2RXy6IKlnQ8ms7PFNhpmoWrtsbFV+6XKUwxbPAvyfQEVZbr/87?=
 =?us-ascii?Q?p+WfAPbz/ntfM6zQAKM7dumvJQa2zRoi+9mceromF893NoxVmURCnqM9UooX?=
 =?us-ascii?Q?86NFvHAVpn97Nwz0w1i1WAN7mRKOUIIyTi2mVkDUOAWP+F88KuGkae5Yq11y?=
 =?us-ascii?Q?tPytH9uEv1b/ATjH8AuxAxKE7HfWyjabkKBkIOFkYWqDqvLCoGqmiwTP//pj?=
 =?us-ascii?Q?O7Kt+MFyb/f28bkawYTMgwW3L6unznqy59vNjy+r+66KLLa2IMZDLjy7JNXq?=
 =?us-ascii?Q?Vb4oCHt3PODYUPmh3WhQnWZ2/dkLkniezrIO2niIhgSbFaPN3tGLn6bHJklz?=
 =?us-ascii?Q?C4pGeh3LnEstCCvQPq0f/a68vig7tNAfp1pNPGQt2NyKhOfXKLcavFu7tp5i?=
 =?us-ascii?Q?nvzIXxzCucGQTqEezQUams6bw52GQUBPdNtEOeEuRH59MclUPDLgJkhI2JtM?=
 =?us-ascii?Q?o8lKtoPHiqpTqwGkNQBfpEuoGDfoTAXRyhDGYTIatNh+hE0epAD+qAfQnlHJ?=
 =?us-ascii?Q?xMyFXrtJqYPRY0mv8drdvxLlvj6rnxevEi9n3HleE/J4BIzaIokl0ycFj64s?=
 =?us-ascii?Q?vmA6l/7wZsh+2h1/VDzNY48ZffftQUoIFw7Uo91Q/UR56FZVkrPa8s/iJ7c2?=
 =?us-ascii?Q?3fX2Mj64yJjdNRAhsMr4XU/R0id3Lgv3iPEc6u0sLxtGsFLb2DKlumnjXlWP?=
 =?us-ascii?Q?7FQtYP+JEQqWcUyZ9oZSHXjX0FIZTzB/K4WJUr4yoNPRBlOPaM+L5CbHYL47?=
 =?us-ascii?Q?sEZe8MVlMI6oYgu4zl0fCC2Xb7xcoUXrvATvh9Mu7soFbaC7NWTvCi2CB/r1?=
 =?us-ascii?Q?q4E/zDB0uAPjGr//U/3AN2T/anvHxJUhFq3pCOlCZvZxy44Kso+qW0DZlETh?=
 =?us-ascii?Q?kjM9QjhQxlu5irx4S3AjrV0lTgtPSYZzmYSS9pj8l++Ggm6vtyjWBC1iTQ6d?=
 =?us-ascii?Q?io+rMoNk0rC44M5fF45p3+nYuqmQ4ivcH5YiTwdxQ4rAf/i6LgX1NjgMGpR5?=
 =?us-ascii?Q?it6KSmrP7nvTwrRcqGOHyrsZBYMegQYYOI2a1CRuTajIADHpIRueCfc2yU1Z?=
 =?us-ascii?Q?TO2+qYb8lG43O+OXWSMtT8IAWZoc9NCl4FxL+WFQJr1vrFZO+w9wxjoj5MV7?=
 =?us-ascii?Q?81mgSY5uh9VYDAUAfUgIxLC53NUUavgDG6ow/W4JFkwcK5LzIqYgyPHBZEIF?=
 =?us-ascii?Q?NxaCEZGBsPd+PhFnZmrbVizQUwaRpK9n6+Y8TOHy6sH1G4YQwGMtoqeoM0In?=
 =?us-ascii?Q?W0bdVNgmjrKVBic/VDXbL23Km6XohNAfjY/OFlKw0ZOyy/hNqEjz18/zy59l?=
 =?us-ascii?Q?dsLFPbjGrhvx3WZt74wbeEuBUF7AFnSI1u9MMeESOKeSB2gU39KCqvqtAATA?=
 =?us-ascii?Q?P4QXKC8+bJk1+duBlQBT3e1Do3E3l83uu3nPrds7zFgOkbB+onQv0bwx42Ej?=
 =?us-ascii?Q?bsBoNmsQOpTOsH09aICIukEjtIcE1Hx7t2i7b5AfORk7yeYbZTaHWAT3v6EB?=
 =?us-ascii?Q?4XriTENEYFg7609YSF2aabf4S8hj897NTkmDNFrkl1Sri3D5ToQl/BWi1/sV?=
 =?us-ascii?Q?j6fnCK2B/gOnT8avQsc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:42:53.0372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f4d464-19e9-458e-7efe-08de2099b889
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700

Add tests exercising the PCI configuration space helpers.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 74b93ca7c338..8f549b2100bc 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -67,6 +67,32 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
 
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
+        Ok(())
+    }
 }
 
 impl pci::Driver for SampleDriver {
@@ -98,6 +124,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
                         "pci-testdev data-match count: {}\n",
                         Self::testdev(info, bar)?
                     );
+                    Self::config_space(pdev)?;
                 },
                 pdev: pdev.into(),
             }))
-- 
2.51.0


