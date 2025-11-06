Return-Path: <linux-pci+bounces-40490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC439C3A495
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 11:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA13E4FE5F4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48D42C375A;
	Thu,  6 Nov 2025 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sH4Y02Q9"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9F29346F;
	Thu,  6 Nov 2025 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424989; cv=fail; b=sQ9PO/IRiHgiM6XJ2wiVWSkui8lfmOooE+EVPyWBsH6qRyMctnwWTlsWHBV8+9XyCOa7kSQIu7myVv5WRorUFVAXu5k//yPkT7jR4vbSzIxipNG4Beh2kGclKKGpTrbAsX3XB0+A1bzCrF3rNpTv45tJa9Yq1mECLvyTuHQa1Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424989; c=relaxed/simple;
	bh=UAlVehZO/BQ/Gxn53y1vcfvwyawrTeQ7k4WK965Triw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHzwG+P3Ji8EE770yqeEPDS07acbzp2uBM3K+HZLKg9+6JDPbgwpxN3+0wjWRWEoEZ4BXYF8mJyu+iWOx77UWwYBYY5MCZddivHHhzX0JlZ8qVuck2Uf+wrjVaSp9bLCLVXltto27sE8vsYJDEv1BM50J0B1RFbv46Mxo1yDSh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sH4Y02Q9; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SI5A23IGXAQzk6GDAGvUs9L1gHYOOH84PtoD1ZSWT9rh6WNn0hQC2Bg4R2PKLHuCbGD9uywoB/lFHLEnWkuvuKquAaLx77gMqYxAzRcONxtiEgy3V0gqUAfYHhr3HgU1evynrOpQXyMIyjcMCPvgcuJayAOLhcI1V5HWzOL9CcmgtIIzFN/p2KGnF5+MB1e6VcLiCUcKjCYNq5WFBLaAMAClnWKYSDSwvgDcZhvPNSJ3DJA2s9+CGPGIxZPxs1P368y8UztMqkP0/dokJ3Jhfc5R9ZmMoxM8X+Z4huGc+sD/fq5GxeNiBYpLyVo900fiege7mPIbKodluJcayyADQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttAQUT9oaBSccgpLNPFsHih6Q/up1j5LBKjPOrlSrGU=;
 b=VfbIILAxF/fw21J1eAT45PEN2CzEVUFqcaCnltq4VOluuvZSyEdaQdph6HJVeU/QYxYsWElFEFJeBXzesgjaRIt1senNX1vJ9fYOyOeATec8tUrAUXNzaX+vW6Lz2pZRVVEM9Sq5HUhSo0O+rJnROKPAqlqlTO++8Al8zLf80ZM4eEz4QVmlliwO9MKjNoyBha1ppYurHwhzZ5DmR4Dz6hB+zK04HLve8QqkEjMO/ndEEp5bUB0YRu4HlHhACX6K5zScud056+ISPuuCm7xKo3B6nT/rN0VqY2hROQgoFgWF8ozVKSB8mrrHbOEa0MtqqF0zyvEsRR+LBcdG/fg/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttAQUT9oaBSccgpLNPFsHih6Q/up1j5LBKjPOrlSrGU=;
 b=sH4Y02Q9gLChj3Lrd2jkljpYqQEwC+RWxSYdviCS4Gobfwy4vdyh1MyDibULTWPm3FfzstAgEKMy28E5XddmfkzB75TceDS0VeUgzZ3xW4bIp3y3D+aCxbEov5JV8d3FM1Ri/XwfG3XwlWEswKrBA80NgQDLsLvZXKpDiXIo/utu8CZP8L02+/kg24MSlWp3ADRaIRbUhByLL8VacOUkgvNDBh6HfBUcZcsBG0T/kUAc7rKo8yOAjtdZ5ApuxLrC48GlPk+BlAZLeAPFqqL5wEFEf/nsUD8gihpT3CDMNE94OM8J8NrGrTeDG86740CBtChQUmz9/O+WrZm64eh64Q==
Received: from BYAPR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:74::47)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 10:29:40 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::3b) by BYAPR05CA0070.outlook.office365.com
 (2603:10b6:a03:74::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.5 via Frontend Transport; Thu, 6
 Nov 2025 10:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 10:29:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:29:29 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:29:29 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 02:29:19 -0800
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
Subject: [PATCH v5 7/7] sample: rust: pci: add tests for config space routines
Date: Thu, 6 Nov 2025 12:27:53 +0200
Message-ID: <20251106102753.2976-8-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106102753.2976-1-zhiw@nvidia.com>
References: <20251106102753.2976-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 484bdd1e-b9ec-462c-946f-08de1d1f64b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qtNgyf1s0jxWiWFe8Y/08wUIqvd2wakb5iHLgJa8ydL53IDSQHygDQh7s1TP?=
 =?us-ascii?Q?d2oUmE2ilWjGCqrqOfS0+NCJRXYuvYCw0FuN1oNckfeIjoSL47cGJwWx3dX1?=
 =?us-ascii?Q?L9HlLQmldG1OVVyIjJ522+a4CNDWtKV6ONoukSoXyTTDXOWQn+caGpyd2aOe?=
 =?us-ascii?Q?vOjaO99zQMnat36n2JM2l9hcuQH+gxLBhYM37VyDyhFi/yBZHmXgsiWdC8pO?=
 =?us-ascii?Q?fXMbXi7jHwG6Vn/9n50KcADw6SKKaqD8EC6nGqVCRugDZVrzy67yY6h/eKHh?=
 =?us-ascii?Q?lyaYbroImKFgj1w+grAi1KJoFXGYGm3GT7Ag6lOxJ65nYWID5jVOMSrIt0Qf?=
 =?us-ascii?Q?qS64CfcatXELDbWzyrW9DKZHoTxeHwtYOfiEPFHuC0QcNu0Edlr0KrxJ0Sw0?=
 =?us-ascii?Q?SenG1+FWxR5N+vf59KVn4UnHfH7WRuaDppfITc51HtGPd/ZQvoRHejz37vvl?=
 =?us-ascii?Q?eC+QHUh+RLWbUF0sW04DZpV6uDpyBaeOIfLGcTV50y71ZC7g1SqK2oAVRFJ3?=
 =?us-ascii?Q?1AP78F0raFTeXVlji+QsH6J/0pWj5eA224WqoDzW4JwuLBBmlt8ruSDIM5hm?=
 =?us-ascii?Q?2ZwsgDnAnOOZ3kOuJz0/9RUSj3hxifua/TtJz0SdnKYzJn10ij258BCM5Ldx?=
 =?us-ascii?Q?ECWOGzmP1j6ZOSku9DZZuY66FlDKC9a16AnclDN4lyOosd60LlW/iDROgiPx?=
 =?us-ascii?Q?d86jcH40iu6zMvmJ4NoZTHyeV3oNy/e9rUQTfD67xrjlyLqUqPhdiiUly1QR?=
 =?us-ascii?Q?XRPLHw4dDvDVAa6oj7jlcgAJpLu1lgkDidBeTzJlFH2naH4/gHMVogVGH1H1?=
 =?us-ascii?Q?38kfAwL8X9YuQn/oTjX8znvOs7Pe+ejPKgnlhznKBFDU6fpCEbRYOZnULG9I?=
 =?us-ascii?Q?BHDCjtvtg9W1jb7trAb/9U9WkeuPgfFL3pGIWURkxbWtZEnzzCKZLYPqkQP6?=
 =?us-ascii?Q?zunqZFhCAXyoo5FTbTsVtkswo0uFgqR8NhZ0sY3hmZgk0YwIgAYs9WJuD9gr?=
 =?us-ascii?Q?n7DjHuj7jfEiJ8DFJiEeTOPaLWPmh/bv7I2srxlb66JIs/5av3n0oqe8mn78?=
 =?us-ascii?Q?ZW7Y63OMA2cYLCnHfObOWTOXki7MuZx1M3VfKWBEtlxyJMAQ1QEqOdvteE1E?=
 =?us-ascii?Q?clqDA5di0vfPnHR5D3bI9dN0gGItTDc0Tak53ln1ZNBODflsdrWkKQ7Ck+5L?=
 =?us-ascii?Q?FHmb6bpbEtzVTO+bAfzoxyLCuOn2XE+RzT0Atti0hUmoT18yBxpFo+lwsL58?=
 =?us-ascii?Q?c6rQ06q69JPjHKkcsjl4GRqBBv2adJv1r0aJEU4oseKlsBVh7kmM4KNkpurp?=
 =?us-ascii?Q?YV15ZXneqbnU74ePOka5e6/bl0sZFNaKFLtL3f0wUJn1dvnFeM0eaj81bqdp?=
 =?us-ascii?Q?9YjvBF8Zsj+9A0v+BY1OalOWDCW9FdCQ8cjLrsgFiXac3sdrQ7NTwbksPVNG?=
 =?us-ascii?Q?Q5YGHYJId6WIKU1Lke07D8OtBJ0ZdRl/AqyVwrT2ikJsCF/XOexp7jbCYW2E?=
 =?us-ascii?Q?oaa/ErEoueVKzt1WQofitYuecNvK979FprxWUvxuUUa8ckyc1HDbnuWnPbg0?=
 =?us-ascii?Q?guA15hggGF9IkAgIqK8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:29:40.3758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484bdd1e-b9ec-462c-946f-08de1d1f64b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

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


