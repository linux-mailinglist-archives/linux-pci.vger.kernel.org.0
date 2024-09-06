Return-Path: <linux-pci+bounces-12887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687996EF4D
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 11:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBD11F22AAB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5EC1C86FF;
	Fri,  6 Sep 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tC/gSBLk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B01C7B7E;
	Fri,  6 Sep 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615140; cv=fail; b=WquZXNi/NggvMTFRItv+vyzdKyRPeIHDaHmh46hHZWvVE97T/5L+vYhc8A75yvP1J+18rJiJ74hdYHCIwFGXjUUjmpj3YpQ9ccdjZk64G7/pfU234PSPBOIRn20XOygEZfN2KhMZjwaMbgvk4Z7PnfXo4t7AMcroYbkw03bRbpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615140; c=relaxed/simple;
	bh=uskjeL5xIuXZWCqOz1+8+zJGK3VAprz+ickQnf5u9Wc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvXOBToQVuqbtMNuzp8blXG8a9C0ADS1fvhQg6NbeUFdpcrwJ/DC2WLO64TCgwnePpqCOxeo+pPOJGpST/DacA9s3GBZ9iqdd8SXBip2dkgBDjy2I1mzS2l3nrF1eqTHc/29wglrTluYZuKfg1qWopoMAOJG7gCDPxtLc2y/res=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tC/gSBLk; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfyDL5w4xybOO3nBH8Fc6e+ZcCRLJSZYUu/d/Gh00VfnIzAQBqe+0SIJ08ZEXBlWJl1ttX1Gqv3jPmDr+S4lEC+NYih3Cl2B07PNdP0eS9MCgCasOV1Qjvqh3GJutQAZ5aKHqlltd8XcAOv9o/ewZhE9vrIKuZEhjV7JMBNKaek9Hw3nT4Zdj7PQkHie/ZbdoO7vJZhnwB2QKMHQdPVHnBEAV5O96iYS6T2cfw8BLkG9fkKr+eA3OC2ukQTBddMgQgXG2U4z+Rh8arfKMWMzKhVjCaVgJebiDWxx/fo7DqmDyOBKC1dzgY7KyXqgNm7s0+zaTZGSJOsqCUEJ6pEhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p59eL/vE1fY4ph6Vl27sjnaBX5/zEpfJ+mFybmwT+c=;
 b=kzzEueq1Gk+RwrSlnE6BMigN95fTeIoY48OFVKGgniVqC8gzWuUzu+F+l8XaEgIu/rCHLGWgo3kwloskleBjN1Mn4WboTHMvBAilbltOhohbLyQRRZNGdJWmKChyaxJzOQMeaXM1WXyeS9AcOODzJo5upjXJoVhmEG2BgkbJbXY3TZW4AN2jt8pwxIrN9eegv7Gjr8Qj/CPfkb/W/lTtkV9sf+rl2bdFnYlryi4Px7AHiaULK9Qc/OBVjnQhvaFSXrxDSE5xZBtxv+h8QKqtf1czlBY+/LAFI91fcSsEYmDMsxGLKC61YGw0fRIxJSmDpgFZx+Z+k/KqNRCcXGJm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p59eL/vE1fY4ph6Vl27sjnaBX5/zEpfJ+mFybmwT+c=;
 b=tC/gSBLkCBhakbUxPA3XB+NBBnc66agtJOfl1gN+HKImEjvyQjrG2AhEgXfpIJT0xT1WH2X4JXTeqiM2MCYV2Cn9Z92t2vw35CziXZmrngjCIijfjrxjG2re0OmjvzLV0zjJNNuUzIv6H6jzNWNkON20r694va7mGSrFR3yyk2M=
Received: from MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33) by
 DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Fri, 6 Sep 2024 09:32:15 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:10c:cafe::d5) by MN2PR01CA0020.outlook.office365.com
 (2603:10b6:208:10c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Fri, 6 Sep 2024 09:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 09:32:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 04:32:14 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Sep 2024 04:32:10 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC: <bharat.kumar.gogada@amd.com>, <michal.simek@amd.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, Thippeswamy Havalige
	<thippesw@amd.com>
Subject: [PATCH 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5 controller-1.
Date: Fri, 6 Sep 2024 15:01:47 +0530
Message-ID: <20240906093148.830452-2-thippesw@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906093148.830452-1-thippesw@amd.com>
References: <20240906093148.830452-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: thippesw@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 430969aa-ae08-48ee-5c9f-08dcce56cb3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pU7VHhDXZMIdu0vKSuGpK1cedd+O1LaNYgRWojOyUtNPz3zsRbpDODeDp/C3?=
 =?us-ascii?Q?YZd1CEdTeh0GUZATkX63BpsQ4sskfD8lrl8NsKN/t3yx8q5WuvnNQdjVRv61?=
 =?us-ascii?Q?mQeF+pjDGcDaQbpuPR2ieaVugU7SLCuiTpudokVjBiNcUDup2z+6oCBjXSuF?=
 =?us-ascii?Q?FhnrxDARa7ts/Fs9+v93GBVtxFS1NsZD6DgBFusN4wQO+vISqnf4dX/01aZ1?=
 =?us-ascii?Q?mRDdwUBzi/0sZR3g5oGG63ZkWujx8CZRHSvBTnjNuxKYs9cGHqYCON+c2qs/?=
 =?us-ascii?Q?2nbh3j9Br9K57Oy+N1ysHxyin+04CrSt91ifFAfjaLwGcsnfTPtE7napJdRm?=
 =?us-ascii?Q?uaHy2710SqhT3aygd1qJgCKtyaUAXzjQa+rQ/nodenlvbEDecaP/jVmqujZS?=
 =?us-ascii?Q?t68CIYBWvU9nIEBgOiCH3oXDoHB9IiKu/h6T8Dzf/CYZDH8v5Sfj3by4utVi?=
 =?us-ascii?Q?a0JYol37c2qWne9bdcQYFRjoA+TVVqoOyxBUe+/sZ0Ela59m+JYG9tgPD69t?=
 =?us-ascii?Q?BnnpyGfxPb63lamO2uFQWalt3BuQOGa6VzWmILmDaBifHuC4dsxTY/JaeKPB?=
 =?us-ascii?Q?zOuMM5Qldh0C9c6dyXylj7x3JvwLt5Ousr81SZDaYhvFuz2AKXOYGrhcW8pI?=
 =?us-ascii?Q?tvVRjSjQhP/4kjRCK9i6DwbzSlY/bIAacQmF/ctofjQEVWg8CAk7VnkTyC0z?=
 =?us-ascii?Q?VnOC/zBvyXO4tDuBsuxEL5hXmPgsxj/GCvTAJARps0EpLU5S6E8gm0t9wG3r?=
 =?us-ascii?Q?Iva6RbRTDx2wuJwBKDleqUmRY5aAoMehw5roQpjBZzdMMDEDgZ9NvwquUYYV?=
 =?us-ascii?Q?pEpovUmxv6UQhQlPFnWN0XQS0zxYXq2mYWnidczeASF3UenmbxuzVuRnEb0U?=
 =?us-ascii?Q?DuWXFByp3aNmL9JEru3dcPNXQSrmv/oEt58bR7aIrvbV4wuWOnfd8WoyqQYe?=
 =?us-ascii?Q?Wd3rmzZFZ1/3/0W/6I2LWQjY4pRl1KF/u1YP1L2cGxoth9PKg0nuY+QeCCM4?=
 =?us-ascii?Q?e1VsTrGfmoFZMvZtUuT+zLkwM3INJlIKsdU0wx0M+ZG4g3dMNDacYu6s8Bc/?=
 =?us-ascii?Q?WRy2PNvHfO+6fggJpmKkWrkEv+8hmVjs3ZsTbuq6RFPjthiJToPkvoboyydJ?=
 =?us-ascii?Q?z8mgDjeBygBpwOQkTUi5vuFgVXl3pO8TrgskyyDHRkV5egFwHZ/l0NjxhoO9?=
 =?us-ascii?Q?KJONQrxp4jmbnp6IH9k/6p/9/tGiksqketbHpTa+61tJT95PYk0vOdHMUn9y?=
 =?us-ascii?Q?l09144Hx8ctYMAsfcOHMG6hPH9Tbpe1fXcvO2VH7oYlTIaDZ5Y++cRAffbbm?=
 =?us-ascii?Q?GPS7loSGFNO2lzqyfsCpqvJEoUr11zDsxC2TuhzjAUdh15webE/cvI21KiGp?=
 =?us-ascii?Q?0hdBIavTR+uN6QZeivN2WCWA18zBc2HCo2luxfZjoSFDPTL4kKgnmUV//k/X?=
 =?us-ascii?Q?VETgck3afq3q7CJ4Z/1YQpp+bCFkIuNM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:32:15.1135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430969aa-ae08-48ee-5c9f-08dcce56cb3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218

The Xilinx Versal premium series has CPM5 block which supports two typeA
Root Port controller functionality at Gen5 speed.

Add compatible string to distinguish between two CPM5 rootport controller1.

Error interrupt register and bits for both the controllers
are at different.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index 989fb0fa2577..b63a759ec2d7 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - xlnx,versal-cpm-host-1.00
       - xlnx,versal-cpm5-host
+      - xlnx,versal-cpm5-host1
 
   reg:
     items:
-- 
2.34.1


