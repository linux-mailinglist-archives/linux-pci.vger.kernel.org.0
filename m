Return-Path: <linux-pci+bounces-40216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D19C31881
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 15:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0651899AE7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ACF331A41;
	Tue,  4 Nov 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o5vkVF8x"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3A3314D9;
	Tue,  4 Nov 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266530; cv=fail; b=ub6twZ3/MfnyKSf1EKIBW4Fcv4dTcfn5q+CK9Hff0gjdLv7hwlwk8Oc1Sbd09dUDvMgzht04acc8a23OXd1iFrpdd65gu8bSYs0CR/u9IgIPhTh+vB0emheu9t6wakFm+vMIvNy72BHTwkJ3GNHSqTp4LqcdDzcbWRnUJMo2WTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266530; c=relaxed/simple;
	bh=EvxGsCLq437aLxeiB5mre3cqme48yiOW5z45YqRZLHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1SVGGKPytUja95afHygY372p3jepQwHWmUlVUMtLS0MD3scGljdHdglMFwyvTUqRGUFO607eGG9xdYBdVHsqKZMzpZCBQsQ4ZD+IUIkIl9AwRFt/+/qgZGmsILHRSeTcvtcorxayxm6Ah5wsOlM+bmYZt1os7laiAILrEXhrPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o5vkVF8x; arc=fail smtp.client-ip=40.93.194.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGXtrTnP2Wgyyziqi6+K+OJBnFI9zzf9YXxMcEsBKjzAewFUqeh6tfGknuValo9vF0WKstfmQevtLsuLa7acxKHIXsicxTz5uo+vjcfLDCh8u8PlOCauAzbc8e8ayQ0SB4XKZFQoTAQMnfxe+LNAiTEVmePtEMYkK8doEglXtN9QmGkeCkV0gvS4iKPtYFsdjBQH0pJUxCrcJtVI9rAvntg3dp9By/szkOjTCHKrILTpXLFHYaHEjJu9rCkS0GpeD1XekcEP3cIj1uJgzoksIH0eNk5EYaSOp2SS3a41a40BFMcYOgyeRQXZHyPA85RrQppXQGhltWnxN+6iYz2VPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgQx+7ipXsbEhGn4QRxvnBQl0VsR7YO6MrDRl6ASxbM=;
 b=K7v0H4O6N+eRkw+QaoXOVbldH9eoorq9vSq/ncTNM8yzbB2qo138xQBO6q+jM3X2SsLtTHCOSzZ4+biqZXEMhSTfRc8eK+NWxuK2iHe5KPIHTUwbzVC/DQVuNIkOnLSQsa0V69p07R4DOxZs+Kx1NnEWfswumjPf9/vtSySwFNTFIJ5cpDYXg4KGFvDhKiRYv9bj7YT4w1DNdhfPYy+KJMwuKaP7LinzfpHev3GcPusD+T1K477T/q8Snp7cxF+51R/3gAMA9ct0VnDccQtc1uE6EtrxqEFzWNFEjUBEPKzNv87Ic9oaBCG7zjV1mkGeQl7UarWaCh2rHB1c9c3Yyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgQx+7ipXsbEhGn4QRxvnBQl0VsR7YO6MrDRl6ASxbM=;
 b=o5vkVF8x7WvEnqnwEmF4Tr856rUvoZi01mj7wiOCZAlYuiVCVET3VXC0c8lc3LkaqGaZjyEaPttU2B0zGO/UNwH5ib3DlPiO8MYMxzhMibTyPlMMluemxy3QdEcaMSBy19QHXF/GMpzFw0PbQLVkryGMX3s0nb5rgXFMuianJo+tPZB6Km+IKhS4o6pVarL1XEN+Zt6nh6AHkmJq2RJjhZorNVGHRmYFr2TtLf6REvM3/VCvYigulqfEsEodi/OXH+eCHwImhhIHZRTvTTqZjy8pNVjhWYXYQVO4WW26R09rJVu3b/4sU4IH3VLrA57nfGNAGiWgMWxKZacVrgxjsA==
Received: from SN7PR04CA0166.namprd04.prod.outlook.com (2603:10b6:806:125::21)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:28:44 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::10) by SN7PR04CA0166.outlook.office365.com
 (2603:10b6:806:125::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 14:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:28:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:28:34 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Nov 2025 06:28:34 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 06:28:24 -0800
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
Subject: [PATCH RESEND v4 4/4] sample: rust: pci: add tests for config space routines
Date: Tue, 4 Nov 2025 16:27:33 +0200
Message-ID: <20251104142733.5334-5-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104142733.5334-1-zhiw@nvidia.com>
References: <20251104142733.5334-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1cbbfd-6606-48bd-3a55-08de1bae7579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q7ULHczdKnRaCozRRT1MerRMLWQhiGqc+j2+ZvOd0qAz51qg+IoAnlmcdm4o?=
 =?us-ascii?Q?Ayici+5wSzhPUlsg45jwJqAL3kj2qg7WFCCEWUgx/vau9n83vxnECj0HSrTx?=
 =?us-ascii?Q?NaEtaat3d7uLTdlH3rLjX6Dlws3pOeU6QB4GEI+udl11JDyPj5bVizoUiwzS?=
 =?us-ascii?Q?eVDtC7YC2d2ftvoEE71rxpbJEOTVU2BaoOcY9fTm+uy4vtkEX4F1y6uIT8up?=
 =?us-ascii?Q?wKVHQuoXtveLSD/pdtjq35GhnS5+APTBhg2cgE7961Y5i2wSx+ItAYJ9+25I?=
 =?us-ascii?Q?g0aFbIw5NNnG3LQhshhFTRvaaYzinns52GjaaVuE40qu+1nZIGGYcLI+IplA?=
 =?us-ascii?Q?IqMw8SC+Hpx+TSdgkDJVRQjm8XY8rm/iCj5cZmYpMTvC9VwPlnZnV/rYOk3c?=
 =?us-ascii?Q?Nti34AxUaYtIqjWbXrvcxOV3agUZ/y8vXwWlctC6/+JCq6pm3NIS8tJv/TBv?=
 =?us-ascii?Q?94glZ18k6txTLzWUQSJjWKP7tnFwyGPS51peda1aqsusDCUpWgMQY4/WmwK1?=
 =?us-ascii?Q?cJ+//7D9D2MkBBu4RepU3Ukl17/P3oaPQ5FOE4xilDf5YW26pUF5WZ1nFtUm?=
 =?us-ascii?Q?EyWOH/GYtjjkm12swUuGzAjFCxq9A68wJquJpeUM5VBt3ZS0y/K76Gbuc27h?=
 =?us-ascii?Q?W3LiofshBmztE1HrIEZhzH4UK3M8rTI0Lg3PlrRNlCrDobQLj3nmkiT5N48S?=
 =?us-ascii?Q?Mt1AIIME4pLIm7f3dL4vO/OMTz6m5/VnqgyERS+UcJeixuVnDUxQGXW+Oe/C?=
 =?us-ascii?Q?U8UYyOl9WBhULnPEy2EvfgY+eQwtj2EO3og9GlvLYNkDoSRktzJd0xkJCJPf?=
 =?us-ascii?Q?7+r2CoEaeWrYH49pCYThYX0msrGtdTG7IB1CLTJYmNTVIfj8tDdCIpkzsLt4?=
 =?us-ascii?Q?woT5RdEJLU/mLfm/Tz87oHUHPoPWIKgzRQbjayrRS43Zo1Y9SoyGi8ML0bzd?=
 =?us-ascii?Q?3CAQ60RyabjmwAtB+duCJsbSQ9y/V+2A0u28hG6+jaZZoFAMjJ+vFF2VkXUV?=
 =?us-ascii?Q?tg0mcRVmrCsU+qS8orMhDJ88jYBK9rVbWfhoCIrv4iywHIEMOGQaPvu60CvR?=
 =?us-ascii?Q?hry2I8UNnoUNKZS4q5bOiYIuoDjDIdW8fwNDxPJMwtiGJ+pdGGCoqjRxWbnZ?=
 =?us-ascii?Q?cSh7oRd6Ia3rdvbnF5agQuNX0W1EyIcdDQn+KpCkaf8TNxWbwL82VnSbLik8?=
 =?us-ascii?Q?d3sn7yNbyYPgUo9fmFyW9ewRQ89qoHko/hGKtlaLKkOfJq8D3P2+JF0OPM2e?=
 =?us-ascii?Q?Zy8/wooLfRrIOeVhy7VD3QGPLOMsKfuO5LMNGryhD7avO1YPImHyL1cIdSQJ?=
 =?us-ascii?Q?ziyKuz8wJrzkzCh0N3CBnZ0UVWxacQFiLHTWZNWX0VFBm0ZPqKadQ3eW2dPZ?=
 =?us-ascii?Q?i1uKH+XMxGGKAF+xmMMCRO8lKoTg1WCaakUhCEllrGNE9Ljns/iemZtkblNP?=
 =?us-ascii?Q?yqeCVg1VUvyRtRJ8VMbZp7z8xQOQ+FcOFfjdvx11bENzQQwWsgp/qeFHc+0z?=
 =?us-ascii?Q?6ycA9YaIsy028VaxvnKfpv/jR3mL2uunoE41o4PzjVH603kXlxxoIDzyORSl?=
 =?us-ascii?Q?TPnkWWPxRzDRkfj2Iko=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:28:44.1324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1cbbfd-6606-48bd-3a55-08de1bae7579
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572

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


