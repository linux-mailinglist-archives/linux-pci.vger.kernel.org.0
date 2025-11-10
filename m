Return-Path: <linux-pci+bounces-40775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C63C49410
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F0404E9D6F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CEB2EDD6C;
	Mon, 10 Nov 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BGpWk7k8"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA52DE6EF;
	Mon, 10 Nov 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806690; cv=fail; b=p34y7BmaklXgkQ06i31jXos4CaU1L6wu9JMxabCUtMygSFFcWRKRWPPoxV7YKla/F8U/9jcS1WSE7dC7JYwgWh8I/WMtDBh9g8dvl0YvaEfGoudYH1NY+LT1toTX4hRwn48TN8LaaX745KkpejPUObbojYG1ShcI3uxuYEj81Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806690; c=relaxed/simple;
	bh=UAlVehZO/BQ/Gxn53y1vcfvwyawrTeQ7k4WK965Triw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gd5yDFX+DYldTEVUgBMcU3c1i0qmK2lIhj848x8iQKUWNXxHsK0VYW2LKs7Yx5p+hrPTUM8nvbcD/w2NKcd74M0yQ8FftQDoaTlSDLxU9Kiirl+gevohDDpM+fizmHmGiliRNCbYQ4cpTwuf+5MJBQJq9fmMgqpyjswOPquV/dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BGpWk7k8; arc=fail smtp.client-ip=40.93.194.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKdvAftt1FKlNNtoVB/dHNb+G5ZZoTmmCmHvxGeid9T/xxqBWumBvce9//klYdTGGPHtFzoRHc9GYrGgrA2q7vXyFtUQB+cJ5mBUO/hJ5LFWAYukHOu4TrVFA5PV4q4Hbdie/YEiImeE09FaiAX91jcjXH+xAyZ68/TotxAPLqFN8LDMP74rz4N4nHLfkmreKHvjai0zHy/HcpdMmm/YncvYkaHGE9tqPqp4krQ9CDu3hPKcW+qRvOvkgs9hVo+hFlDdQsQ9NTwYiMnbh5sf79BI/RIzNmycoR/DpAn1+VpWuzPBYGHEd0Yclt/wbjNj2cAGkaMA5zYOBbnLQGph4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttAQUT9oaBSccgpLNPFsHih6Q/up1j5LBKjPOrlSrGU=;
 b=TC0KTrWDUOovEmcV2xkKcfpgHWNTAhD98YUbZvDyIof83OmyfRbE9FZHMX07ZNhaaNasX5NbZVgM5yS+PWx/XCklZMMbWCEUVofrNU27UO5UqWZN/JcqtcaAILppTG907lyZ7LJ1GypwGMYvCb+BztoNkh6QEB+YUVuaWnO26IN7ko7TGwBOHXNwUhVn1LoK/3HIoHoTN0S0YehQ+ShNLn19BBcTU/8ke1LQ12VNaiKGB5M7oSEuIZrzPtCUCDFZq+qabDwfxL3P1PAvYRJbrMlCmgT9eZ3Tm2dz7Chf6eiM1xdHhCS0OGVjfOb2biW5V7ZbHM5kzv2dDaaMh7B3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttAQUT9oaBSccgpLNPFsHih6Q/up1j5LBKjPOrlSrGU=;
 b=BGpWk7k8pUK1Au8MpjjHkqwBSh0JOu98AlIS6nSijUfgj66OMZBeYlokf95i37ZzxvbHx3iRnPTdVg600FmM7KA2XLLjLz5Jq87qXVWzapggT4C7Q/8don3qW0+fkr2bAqb3u3jw4ru8nzMGKwLKUUwJu0ACaj4QtD9hCLDl+6nan8U2pMVlCreXhcp9qFjuHs7CZ/zroY8s3sVdXiWFAZndDK3nBFgIpzHxYrY31WCp5HBGQdHIFV5voz6ryBJ6JnK9fXCSg9HWd4Tv/epco7EbAy1VYYtCrDZMB+DatZOuhP65ok8tbJg3cNIDDpbJLf/MhAXiOJJ/QP3QZXGi/Q==
Received: from PH0PR07CA0097.namprd07.prod.outlook.com (2603:10b6:510:4::12)
 by DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:31:17 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::ac) by PH0PR07CA0097.outlook.office365.com
 (2603:10b6:510:4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:31:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:30:55 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:30:54 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:30:45 -0800
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
Subject: [PATCH v6 7/7] sample: rust: pci: add tests for config space routines
Date: Mon, 10 Nov 2025 22:29:39 +0200
Message-ID: <20251110202939.17445-8-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110202939.17445-1-zhiw@nvidia.com>
References: <20251110202939.17445-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: ca904a28-20fb-4b6c-306e-08de2098182c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LogslNO9qF8DpiaMnvbfs6LiOd0fzwa9NkZQUHz3I2lwoarvWwnjLa61BjL7?=
 =?us-ascii?Q?tAID3XxIT5iuahOfkCbzG6Conbe6v40xUv4LWpzAD7ZF2gOYWk4kfldsL4Ka?=
 =?us-ascii?Q?/JeJetBvnBM75gJA+hBMDx8/qg0D54ZObGIc8gOcgCjlWdKe3FQyO6pSWID6?=
 =?us-ascii?Q?/nEUlWcxeudw949cITEPVd3kp6NWYrNWfDpz2et2akpjkbIJTo5kd2lgLU2g?=
 =?us-ascii?Q?zYB3sze6PZjUvTvhequ7vAPhqVSLQEJ6fpHb4KgrZeoUAVwFFkKcg3KA96OM?=
 =?us-ascii?Q?VKvYSsIVJOKEZPTWGdC0xOWYuYy9gYj+/SO51KPAPSQxmxtlt5gGovAwehkl?=
 =?us-ascii?Q?A1bV/cIKIet0cZSw/UL+iQwUa9CJ6s9VWUbYjkJGqgaqEuI9gADUteo5RH9w?=
 =?us-ascii?Q?enOf7g6TaLoZr9eXRRhtK+/MOgD2eO85lXDqIuYYIkUnE6lqLRy2YjjDyJNN?=
 =?us-ascii?Q?+rFbEdOnekHi6OSo5HXRmrUIeKNL8jQhYAf0wBo04wJ1tECsNYlvBMkjTM8u?=
 =?us-ascii?Q?InxIICnoCzMm2pgB0kKV9nbkfa5FWr8MuBmEU/L0EhlitGDpn3mDDwBmKdwA?=
 =?us-ascii?Q?y5TzihkdYGpZHUJ/se6w5+/skdEIQm8TPeV2sWR4Qd3YHoNegh8gx+TTGBk4?=
 =?us-ascii?Q?2MNX1cSZzSptxCaKFdUB1fz15YsRveWi0Qq6/D7ME0T6d4k/22K+WU7eiRkO?=
 =?us-ascii?Q?o/8CD1VAqH60u+pq+gqvcLn4RkkBaCAAsnlugEtAVaw1Y7dLWamrbrzbYV+z?=
 =?us-ascii?Q?7SqiBbWr035Zr9sf3qMHDTEzrIUbNmbfC371BTcWNF4+VDz63cL2JdDmVwA/?=
 =?us-ascii?Q?soPI0bbg4ffqV1xQrf4LJiCnF4ldymZlMaAaKR8Caw7Mj2j+7Ta1gPvfS3ip?=
 =?us-ascii?Q?pmBL4jvxEI3VVKioWX+UnLGFm6Fn26LhvyTD+rwhbqt8+8FL1XwL9TRwPRx3?=
 =?us-ascii?Q?tepjjoKLgr+iX15du2NOLo+OY8iwDNotrcF58Cx5dGV4Bqr76BzwMJckEs7w?=
 =?us-ascii?Q?r7Joq+hh5c0F1k0ZqS2gcAINsoXScu+KbEpGL/Fyaawpr8+hN2Vb+mHJcSiA?=
 =?us-ascii?Q?9E2zntysvll9r0dtc16BgSS6mtODgxh1lGDYBW1yeAvqP5iza3V2gKHUk2xi?=
 =?us-ascii?Q?ZjRGwWP/c+gpXaqNRY08r8f5KtheiTbALvw0vDY5iUBRTRtUz7IaBgIvfoJC?=
 =?us-ascii?Q?8KE/2iHb5f8aVvwMtnd/vyvrsvpFgwr/7RteqTv/xFfYOzkg4bO4eC5eHULp?=
 =?us-ascii?Q?h1kLD+9OVWxDdhSMWBV2UIM95BTCg22IhLZ6MwVBksddlHg8db58I5z6Y+MJ?=
 =?us-ascii?Q?r/kD11pT4FoldXPPbnWU462exq8LJG7+W/FE+rW2bnRQKGu8ND6soFKEQ5pQ?=
 =?us-ascii?Q?yh5zgokcbXcf13NsM4AB39hBCYHHmGMUBz+qwXrYq/N5qYX/jHX4dLiUCyoQ?=
 =?us-ascii?Q?4NXwEayHtpJT/RQJ2MGFHIrMIetSFgK7kjnreQWoNesApN5G/UCjQ+P0Bzh8?=
 =?us-ascii?Q?pl91goX38OLN8BgZUTiko2wfmF0gGaRMWqEzCiEWhP4nGH6F8IKdfoF5SrS2?=
 =?us-ascii?Q?TfqTL52sBYfZSx54xiM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:31:14.4413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca904a28-20fb-4b6c-306e-08de2098182c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768

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


