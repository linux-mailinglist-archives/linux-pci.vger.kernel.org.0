Return-Path: <linux-pci+bounces-44593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0399FD17C04
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8718D310A772
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 09:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6754C38BDD0;
	Tue, 13 Jan 2026 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nwpjDimS"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2AF38BDBB;
	Tue, 13 Jan 2026 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296250; cv=fail; b=l2hze+33++srJSPvsA+GVMczWV4o1mukCDoK52FUVEGDJXklGQkyhB2kUG/1hIpHkfeUaVm51j7ErI//hRWKtyS5e3MMwWGnku0r/9LN1SynO4AatuO3ttXQwxFpMHiNA/vgbGVvuKFzbJLFk0WsNJDcz+YRZeZzruWRkqebo9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296250; c=relaxed/simple;
	bh=7+74NfBJt1/svJUDEqD6IAeH3VP5sx+Jw9i6MkfgoDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ywm5E9ibVHHAVn9oZOhm3bgfujx8+dseyisob2cCkztnkwMEfKJdEgQOgdUuWKbUN3c01a2198s4FKBhsUL07GzQ+kuxPgG977m02+xt0s9W3yF1wW+OkJngCS/vB7mA0ch2/lwubjCvT1ToeZvKQaj4MW9SbH7LLnMqjBCGx5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nwpjDimS; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+HI8fHcPy+Y9aTlLxDCp5G2GgH4+e6tMUO6L4xUvDgsGy3HvKmwiIB1lCe7AQyRVJ/bm+sA6Qe96VLDZUXAYdnM2WZ3xb7kiolUu/kun2MzdVZaAS6tUCbRBFt1xJsbKAga1lSCf4MO2o9lydHO9yiGovVoFEwRhesVa7S6n0G1P/hDeZw+JT3IkOAj7chDu3zN5rvn6+VdBRkJxpbTLRP5+BdlgHSeCiKVza9UccHRUNWaZAvaYDaNlQYrEK/rmNHQSt1k/sv2hxFwRPsdfAl69JrlVXsg12GBNDlwcSehxthw94HmeZfKp9bFS3fnB05XiIW8jFUbIRWF1oUCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1fLcs/dN7QwKrjA9pskXGNRCDE8u2b7cKekvVL/z1Q=;
 b=g4UhMjJVCnvVrtOK951/AGZsMqH0qJL3PCCYoQj01E13qTYBBvHerjEpxWGDDHoLedZR5EWbErj3mUW8VeNC/gYqt+L4sPLf/n/7kDl0ofXyVbc+BkxRBWZ+GzCchAPThQyWc+1e4P8RLHPvN/gxtfmMftrjZNJPI+QhKaIKvzOXjsQKYuUO3wVWMfmc2+pqztgMcrI4VkiEqKKcv5qXzq4wx7rRWEGwnzZtuFqPWhsJtpjaAvSBO2owJz8vdHOItRBqxsqeJBKcWe2PRIfRVlxtBzQ54TiPFuAqZJCtOUQYimMlXZn8g5qOelJZdNPxuDR5SwpVjcCWEUQoB+K7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1fLcs/dN7QwKrjA9pskXGNRCDE8u2b7cKekvVL/z1Q=;
 b=nwpjDimSNsIqsIEiTiqJIiGdK3hrcMii3z2jpYmVTYH5I6xZckbJ0FIoWNPRyIMJwSK9nC197PFUt//vTeHzqU9koWx0Ny3mPtuPUaasIpzsJUcnw0pnCCYenP8p0tEn8/fMfxF1yhFsYYmplrrZ9XQMcALtdet3KYCIR5Cw+xWFQS6gZ4bgkbv6ZyFR/QEkUg8cb7nzkPQrWUwlKjjxM8OFwve2QWW6Ppmavd0scedL9sSlUNm/IEdV/Bl48lK2DtbigloUZQY/wdVnbzSvzgt+Cr1vz2GJN1QO3VFtsFmBaN33ac7BW9uqO51AaUhekzbKpbrepdAxPIm/+PgWIg==
Received: from BY3PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:39b::7)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 09:23:59 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::1d) by BY3PR05CA0032.outlook.office365.com
 (2603:10b6:a03:39b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 09:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 09:23:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 01:23:37 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 01:23:36 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 13
 Jan 2026 01:23:30 -0800
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
Subject: [PATCH v8 5/5] sample: rust: pci: add tests for config space routines
Date: Tue, 13 Jan 2026 11:22:52 +0200
Message-ID: <20260113092253.220346-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113092253.220346-1-zhiw@nvidia.com>
References: <20260113092253.220346-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 725be1fd-2f40-48d7-c6cc-08de52857be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x9JvPkiD0AmuAPuVNqUuQGyi5/IBYiU0uTA4flOcEAf5sHB1rdY8Dq8iSXlm?=
 =?us-ascii?Q?y90PwFkzurLBr/Lu93g8p7wTUOtJhnMW+a+6U7w9dwT8CCVqnDFLIYwkC+UV?=
 =?us-ascii?Q?I2vK50Q9dTssGPaNrUYfAXSSC9Di/86a9Q5XAGbFamXm37po2YzyBw/RTuLH?=
 =?us-ascii?Q?uU4NLDmAGIXWu7ONuWadRNsoCgoB3FbVhH01L5kJP9FomsLkGh4ZZvwL8wZe?=
 =?us-ascii?Q?YzTSd0A4uObUl/6MVs5R3U448FVm5n2jiag8pGRaxSmPeSmf2Ado7oI7pNbL?=
 =?us-ascii?Q?0hiPOSl9zqzNBcwdJmDeWldIC0gvlllnqKvozWKw+Q+/2K1obdRZDyNRn1wQ?=
 =?us-ascii?Q?MJzJlmhVXwEAjZE0ydkXf+nmjapk1KQry9D7vTL9SWkXsrxPLoOlC6N4Q00S?=
 =?us-ascii?Q?o86yJBbFzqraw5QH1ZxG0rCb2fpOrdVRQGysdCTJ7X4HAz9NPVupb9NqDfM2?=
 =?us-ascii?Q?bqC83qFv75n1PmcydIzoEvD4FW2oJ+Ko/yeIhSvuFXSIGDv2zJN1tT5UInKo?=
 =?us-ascii?Q?BrvF7EgKLJVpRt6jDwmIUb6zkSveN/ovvfKcoQL7romJtBaYKFyWCR7srT5c?=
 =?us-ascii?Q?Jp6SZMskzB5nozV4eluctUfl9NhZKztKsVnVE0j+N4zfaEXmcj0/y2dapAQj?=
 =?us-ascii?Q?XskPRd8UhxcWvnx/T9LTt45nZrd2KYIppncs0My33GCnrEkVyX9izsDzL6gk?=
 =?us-ascii?Q?SJjspcScqeIbnHb8sqAQpjZaLci40FKxGyC/ro4R1anhwqJRwN3rZNpvNwJm?=
 =?us-ascii?Q?k2FHYeF73r0AOwXZe9G3DN+Vi7kzkF+gX/zkgIu47dEHaxUxVgc5l+/zq0YC?=
 =?us-ascii?Q?temecrlrWdBVwD6dwZBQ5+WtGbDrgjysP+gqgoxJp5l3fuw1jWlDQNVd0kZn?=
 =?us-ascii?Q?11hkW8XtILToYlYKxUlEHZw5/p6nbIExuQgXpw3DhtejkQRR7E2Gzavv8tWa?=
 =?us-ascii?Q?oVvYy8R/QanawqqEusDSklBYUSrdiZS36DH3FVqga2h6TOIgxC9hAKufFTo2?=
 =?us-ascii?Q?QfmqED+GUiwHR8L9OcRx7o6AhHH+yQsjhYDmKWG9Dl8ueYje6pKNV75vndlJ?=
 =?us-ascii?Q?V1ourXisXv+lfrKwIgsr5staIh6wFaIpvk0vT51dfOFbHN3bXAP+TZPDK9WE?=
 =?us-ascii?Q?rFicnyk2BXcWcWOOY4Gpel3e6uxwyB4KbBp048XGSzrA8HoL3tw5nN4wUnIv?=
 =?us-ascii?Q?CKqhgX7cbUMKwMG/VTdvj/VJoDWDZZltCFLVe7c3zbf9IvqS6gTfPsM/OmWG?=
 =?us-ascii?Q?uFL08ZEDQ5/V8nZEHNem7sfLI0qtFrMXVDtLi0qynircA2QCqVETcbKXqTEl?=
 =?us-ascii?Q?uVHGFCOI8E4gZdO3KASJqGOPsELY8cxFDJYlIbgMLfR34iz0BEVo/heV7i0N?=
 =?us-ascii?Q?1vzXfrH/PKlPsRltwoKSq+AQFiG7YpZ8KjYhaaT7KhSeV+hWB8N+uTshNgL2?=
 =?us-ascii?Q?4K7IP4ft+7yKs0n3IKW3LCaIVpnIKzX1ihAZjgrYOR3np2e1OytucBJ+lRWJ?=
 =?us-ascii?Q?OJTPQdiI/iRDiZq0EbsrJAkPH4XbiMdg0ZrwUY17oMJCMDcYXrDNL/B7+DUi?=
 =?us-ascii?Q?O6p2H5m0u0n15Ip5FBU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 09:23:59.4363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 725be1fd-2f40-48d7-c6cc-08de52857be3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502

Add tests exercising the PCI configuration space helpers.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index f7130a359768..1b28a2a7d07d 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -66,6 +66,32 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
 
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
@@ -97,6 +123,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
                         "pci-testdev data-match count: {}\n",
                         Self::testdev(info, bar)?
                     );
+                    Self::config_space(pdev)?;
                 },
                 pdev: pdev.into(),
             }))
-- 
2.51.0


