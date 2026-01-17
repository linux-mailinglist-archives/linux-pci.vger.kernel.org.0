Return-Path: <linux-pci+bounces-45085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C246D38C68
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 05:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AAC330478DB
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 04:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04212FC02F;
	Sat, 17 Jan 2026 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ltw3iMGD"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A51327213;
	Sat, 17 Jan 2026 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768625827; cv=fail; b=H8Zjpc0gWO+MLSFNKANi0SRIVa6m/jQz1lTCQ+95r9FuQtKutzWnBfi5JNTSvw4PSjA7P8rCzzym3x9kheKdIf92rhz76ZQJQ0JLt4lCAw4Xa9o98Vmpa49CKTMtmLNuGZQSMqV201IZb4QDSfih/8+p5IUX759W+gpT4XkhmJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768625827; c=relaxed/simple;
	bh=SvjMpPnUFCW4AOF7NuPWIknPYaWrL7JMLLGMilOb1NA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JXSkTx3ZwSaMstOQI7UxH0CalKJqMPAagkWhcTRyczv5ljHrf/A6Qq3OHiJedIVD3dAIiFwWRt/gu256rmBT6fHhplhLthuVebpRKnF34/5ak6V6U3eERJ6qOn1EN2oHrsXlZTl0LT1FgY3+VllrP3f256oloCGeB47xYHiDY6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ltw3iMGD; arc=fail smtp.client-ip=52.101.43.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijh3qtR4/SKd/QGpo+FjwQ2mxYTYv+R0r57JFiAJGznHWWVz41Z4PoqBSsjJpenBSKyucCUSBEFxfQycxQbm4NNXObWDLxLxDr7TziKQg4ZMMBEVE1X6P7s0KUqofXdC+gFRyryVG5DBg7vecw+IoXOG6aaTErfqUEmwhnUPuqp2PAT64AQ5h5vXm9Bk6LJyUhoNruLPuQPM4A9QawREZ4drKD/64Crs361gMQpuqFokbpMAtr9eX09Xkt6U5vuvTBIqva3eCcJP6aHpVo2CRjbjW6vlDbdfbhVeKXoTmntrQ7hK+7BOB5tetlRRGspOt6Sqz/TbXzR+otO5bXaj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPuGNwE97Qb8kErl0U5jmartNnGLUip5uvix5gQviYA=;
 b=WyTZx/kCPdpsAtAWIsLDcvpPrOffIJLyrWb8KfElgmmozNEUDHC8qlxikYwEa/md8WU5CZJk+w9Stpzk3IuqulmHKntI/L9RnRB4rs9f+sMg3gqeHX8tPM3njNZAkJq+PkxozCBFzLRKkECHzUbEmSYyJSTvq5Z+auNGXoFFNRWkc0YA0WHChcw9vT+CJ5thueyA1TcCpOp5fQ9bompwJzMTsIqD4AXdUAcCuyymkgDXmb0MFG11x3EcTUCnzEEGW4UZiO8vpYDW6UIHRsaZoH8Wx/nLNxE4Q/u9TnlmXro6Hfo1CIi4EUHM1nAZI1gXiJ8FLRQiQvH3nZgkQKJAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPuGNwE97Qb8kErl0U5jmartNnGLUip5uvix5gQviYA=;
 b=Ltw3iMGDeyjwBnvDSVvBwk5wMLw/r+nG3cJbsrrJsebsoSGuFkJMQ8VKXlNBKg8gtQjKT6nWTJQIZ64MrXgDNNHtSI56CRTKKy0rlIoAjmZiqRkWEFoVA+6lF/2Tfg4PxLi/CDEZGlnDf4DETS91SDPMiz9P0DvLoC7gMtVHDrqly2x/KkBOMSfRjJXfyKuDukJ4RHEN/YWm6dT0VtkeufUgY+Zcb9h083BnBJejVlTwiWj9BuDRBj0hAyQ2qR5G3FCmtW56SnLGy8vtyUsO6gVuhbxWj3OMYs4CqH5/DLg7GKP1+XtUqph8OGd2wRDFqGTJzyTeHwQQ5TrpooW0cA==
Received: from BN0PR04CA0171.namprd04.prod.outlook.com (2603:10b6:408:eb::26)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Sat, 17 Jan
 2026 04:56:54 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::49) by BN0PR04CA0171.outlook.office365.com
 (2603:10b6:408:eb::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.9 via Frontend Transport; Sat,
 17 Jan 2026 04:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Sat, 17 Jan 2026 04:56:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 20:56:50 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 16 Jan 2026 20:56:49 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 20:56:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH RFCv1 0/3] Allow ATS to be always on for certain ATS-capable devices
Date: Fri, 16 Jan 2026 20:56:39 -0800
Message-ID: <cover.1768624180.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 447014ec-7ef9-41bc-f94b-08de5584d5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o9vtOlLT1LnopCyKpPcl09C5oSsd4K2qY8WPrnMVDgtjrEKRRkgB8Uz88V6r?=
 =?us-ascii?Q?KgjGi92+SU38LyRjajT8ACTrEerjrT4Ue94n3+zOnX49dxTK9mJEIdph8DyL?=
 =?us-ascii?Q?HrPuLz0Qiq4Yt8DeHb4GqvjzLTHRvW9mV9rz5HhMvuVscq4n+B/ACTxnsOxL?=
 =?us-ascii?Q?Q1bDX3he8frA7NqQmBQLUgdBdLJkKRLr1JZmSpgYEjb47AU9ktV5JDVuyHbd?=
 =?us-ascii?Q?tgfVSre2x7Cg/LdqHIXhEZfCPZBZ1Y7uaOSMELaiEYq+2Atk4RPgbJyYSqKA?=
 =?us-ascii?Q?zT0UHMzbAIRxUFMWS19dThCTclMKnAJq9onM2lRAW8l81+VLd78Qs+e7Wq+u?=
 =?us-ascii?Q?SEqa+dUUMYix2qe26497EK+xQiw3EfavDuorhCc8a16LbpIEdQIvLBIRzjfQ?=
 =?us-ascii?Q?Bbn4hR3H4FVPXHabtLWOmDvBu1CvXMZ3Vz2deeVvHvxTzz0Pg04+9RoG2OC0?=
 =?us-ascii?Q?3f+iZdGm4MszzYX0wRah5N0p00NHgI5su4uIM7XPGVl2s4BV17kRfk8NyLET?=
 =?us-ascii?Q?Nhx4rs3i6i2NcutsPT2MBHRZTsFOtRPh0Cw9oUMZSyiQVGIa2635gmmkDPUp?=
 =?us-ascii?Q?NlUVOvsqu4rEcNlUZlZDzUXYFRPDwYX+fiklkOzfEpydC3AgL2ZoPbKIsUqO?=
 =?us-ascii?Q?WkNkvQtIhLiYyz9gesdps+VLGHSHqEdoCTmBJtMCnlKZr0T9Y/oK+g7xVtbT?=
 =?us-ascii?Q?zpWizxuy4U4nPsxl2jgsfQypqTwi2dS2qBTSYpILNskc8qC6M8mwtZ6GERXu?=
 =?us-ascii?Q?XgkaGcpP2cuqmhduLjDeR2amqkK0XRqRG/R5okgB6+hkwweyoWuxmr1jgFnq?=
 =?us-ascii?Q?AK/OjDrUo1wthk3OcvxU/eSqMkJqiF8PxsFEDSkaltQ1fW5toYbZWULU0LBt?=
 =?us-ascii?Q?LgXbmvzkFNMKJuS/RIREauVKhCvrHr40Q1nwSvAiy+5SwzJy6WT/YA0U+eWN?=
 =?us-ascii?Q?RQAr4g8a+90Ntscz68kKM6l6faKuvnAR2Aw+Sq84YXvgoQdQjgfTan461kvR?=
 =?us-ascii?Q?zDmYa4wtn74SoTyXX14HgUPjC2w66nP7luedktJYQzU9m1iIrB/wPFMEE1gj?=
 =?us-ascii?Q?duTUDVDZ+DHZaM3JNsrWGKeSlxFLxJC3HzDKgvCJwgVJtOSTrHRx139DQiCh?=
 =?us-ascii?Q?ojUux/8MLT24Nxzz6nz+3Ssud9Ka6z19aubXlO0Trl759+x3Dn91f3Gqvvry?=
 =?us-ascii?Q?DCXeo5PAIefqu9GNs9fe4IMiXNtC6ZYbRySFw1o/IU/eVKOAUIyG3F2NzoJ+?=
 =?us-ascii?Q?KmGqTQHss0WLB6CtGYgqaXDxLDMGK8uBTZOG9BeNLDSEYygOzK0gPd7Kku+L?=
 =?us-ascii?Q?Z/zqpOZRbZxE+4EwmIF+jMN32X9oBGV3Cl3Hcuq4TSEdcZdy+At2pjp2VgSu?=
 =?us-ascii?Q?wjw2atFIPbO5Vq/2YrVrl0peDo+WXsFF2dxNEXj1UNWH1dPz3x1NHdwA8TI7?=
 =?us-ascii?Q?nrB7ikuHcI2ffa5vC+RDX4i2xW/WSlh9NfIb5ZFDUHyodHcmgcvK7pqKYqHA?=
 =?us-ascii?Q?mgF6uxR5DPYNTbJoYzc2hJu9yFfjpMRe6yqyrGUeOSCShX7yxNaMSLi0B+VM?=
 =?us-ascii?Q?/HdHrwN1uufUwxODXa23J+y0JNtSV6ZPnvJW2XL1lFO26xEY8a005wu/9PwS?=
 =?us-ascii?Q?eQlJ1KjmlB27tiyFMCWLN26E9XzLHICJd0KEnyHkbffQTfj5dD+1eeHS+O9F?=
 =?us-ascii?Q?nzSDag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 04:56:54.0659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447014ec-7ef9-41bc-f94b-08de5584d5af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025

PCI ATS function is controlled by IOMMU driver calling pci_enable_ats() and
pci_disable_ats() helpers. In general, IOMMU driver only enables ATS, when
a translation channel is enabled on a PASID, typically for an SVA use case.
When a device's RID is IOMMU bypassed and there is no active PASID running
SVA use case, ATS is always disabled.

However, certain pcie devices support non-PASID ATS on its RID, even if the
RID is IOMMU bypassed. E.g. CXL.cache capability requires ATS to access the
physical memory; some NVIDIA GPUs in non-CXL configuration also support ATS
on a bypassed RID.

Provide a helper function to detect CXL.cache capability and scan through a
device ID list.

As the initial use case, call the helper in ARM SMMUv3 driver and adapt the
driver accordingly with a per-device ats_always_on flag.

This is on Github:
https://github.com/nicolinc/iommufd/commits/pci_ats_always_on-rfcv1/

Nicolin Chen (3):
  PCI: Allow ATS to be always on for CXL.cache capable devices
  PCI: Allow ATS to be always on for non-CXL NVIDIA GPUs
  iommu/arm-smmu-v3: Allow ATS to be always on

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/pci/pci.h                           |  9 +++
 include/linux/pci-ats.h                     |  3 +
 include/uapi/linux/pci_regs.h               |  5 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 74 ++++++++++++++++++---
 drivers/pci/ats.c                           | 45 +++++++++++++
 drivers/pci/quirks.c                        | 23 +++++++
 7 files changed, 149 insertions(+), 11 deletions(-)

-- 
2.43.0


