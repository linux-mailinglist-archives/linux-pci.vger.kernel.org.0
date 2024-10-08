Return-Path: <linux-pci+bounces-14010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6C89959EE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8DC1F248C1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96F216454;
	Tue,  8 Oct 2024 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XXtZrCRV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4221503B;
	Tue,  8 Oct 2024 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425884; cv=fail; b=ZOpgxBufhq8Ky/Ina/CaXC1XY2Pqa8VUXk/S5EBs5nTahu1sPVJdnsIw+JDl1pDDfmYrd3to8RMRzYdTKRNvvg0qv2+ZZ5mzro6I7wiapOofTrDCzDw11xUDP6I5V+FUa8M5h+bICmKXM7jbykDswVdSvB0RYXzfNLpQemKvKkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425884; c=relaxed/simple;
	bh=OJYtZWQw6f669aGAjML3ycJHL7HsB6Al3dA3n8GFPFA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBLiVzm6kjikWcGIrgUpO8oI6cjutuBc0d8fmn0fiwgKpo8Wdian+Fwk+pU2teiIXT808aCZ2wQuW6RpgnoTAeIfRbVRRhs7cBYQE4GgkUZe+XMFsjxS2GNBPN1vuIvr7UxncBFCPbt6LqweiNePUouW6E9i+WEBb8udG7dAa/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XXtZrCRV; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqRftEEs0ls9d4I0lwfAiBFesQ9KgV8tJd1WENIN48pEsIkRbZ4WQ8sJ+E2ROxTZ3gRByMoSBPrNMBFjTXQKX1TdUD8o8x8Ffoix2pgYM/AOnEa95cudz+VjKXf7XsErDZ4vG4QujYZmW+uKTbNNbZn8/jEcN13F078JxgNRWKg3uWxX70p5uoCPb24r8PHHpxmi1Ok0LBVh9vcQNFapyg+jb2CFpkudzQ4ggQg7E893IVHJvj3Aa33XYQKEED06rsH+XIx1oLqu16M9Kb+PXx6A59RtthxFEXd9hFBiG/R9CZbXmh/QRMRp5vEFSLbTLbYfAUT0hHM15BfuKZ759w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCdctbVVHEMmR1KiD1vViPKiykyG3dlIPIy2SfUwEEc=;
 b=fDgBwRUl0hxpy0kNT5HmJJsdjHF6bhRZmQtO9J1QLDrg4uw9i+6IFZBDNQOwPhGwiztDwBRiNu+AofbGMATSCCeAjywaA7kDAnY2rIHpM+gS0AJXwQCcHchlk0imeP39Cw0+RSCuIxnpDxBB4C8DWNdXzU2S7gdqk2QMey8MGbSPfIRDMONd7kCi6OZfMuVu3wAZ6KZz4rPEA6kii/Qsg5GU9JzcRB8mZl16ITV91H6i929WwYO/zSCyLWsuJ/HWAxrqgc5MgOv0HKuFsVHTBFaWiS9EMuGA0pfzmquIsFLtyxrjgXiLPjwMExUa80kxcAmbIDWl8gLlLzh8KY8qEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCdctbVVHEMmR1KiD1vViPKiykyG3dlIPIy2SfUwEEc=;
 b=XXtZrCRVrIjvuxQnc4nXUQWAye+cWbwpWEkpR8sBlwDeBvcSTWbW/607XhuwSHcWpBmhzswpUODoj8O6glEYBWfk1TKoTd3RF0PYdEBND66YKT55pFwgQE0TmV1aUDalL3V0f4cLafa49V0BwljTc7CwmOr2kAxf3W/KTHVFn2g=
Received: from MN2PR15CA0051.namprd15.prod.outlook.com (2603:10b6:208:237::20)
 by SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 22:17:59 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::b1) by MN2PR15CA0051.outlook.office365.com
 (2603:10b6:208:237::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 22:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:17:59 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:17:58 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 05/15] cxl/aer/pci: Update AER driver to read UCE fatal status for all CXL PCIe port devices
Date: Tue, 8 Oct 2024 17:16:47 -0500
Message-ID: <20241008221657.1130181-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SA1PR12MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: de3be1b9-fcf7-41bf-2728-08dce7e7115f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WTiO3jqrs4ZounpFYTxDDgg3VyPdDme86DBPliozFj2CUuMeVcuU89QLvRJ/?=
 =?us-ascii?Q?NL/mKocD012Xeoy/y8x/4MUjjZ7ewLsVuAlm1s3bfxu7pP/qqnIxf2hruENQ?=
 =?us-ascii?Q?KZm3qRt6e9RTuw2mm8qpPKDnyLt64SII0s+cAA4r1IKIfzHZ84n0WfbHn21T?=
 =?us-ascii?Q?1RPqwQop2GFTpsOKyaXe3oWmjEIx/RzQFRMyq3w8XWzgD7NX41sIci+AXxm0?=
 =?us-ascii?Q?0ij+xGWK3SlG23HH8u7HZdDzpZo1BIItzf5IGt+i4yRcsJujhUDa4LrEESsb?=
 =?us-ascii?Q?3lPFgmIJDdWgxYljvKprST2UK/MKoxB+jTRdV2zgtCyDDMrboOuyiGPhs1QT?=
 =?us-ascii?Q?tdKwAiyZOHYGECd0lifBVf8KppJR8TuPZDiFVeGtKQ75OqihncRZausff5uL?=
 =?us-ascii?Q?CCYaqw7sxVVgvGFPUgWDgjYjw9v/9gXNjjvYwEbhQzXtbCrp+C6er+POfWpe?=
 =?us-ascii?Q?22S+Shp0bxew7ik83xScGltHY1LYApCENWFUkEXiASG87bBWN20x5LXVCb7/?=
 =?us-ascii?Q?Ru07Sndqcgh62nIFNJulBOlMOKFu1KAe4Yj0btvyF+Sqgy/tnV/GbI4zB0kC?=
 =?us-ascii?Q?kZHlu38J0Y3FchGajD2GmcN3l/Zw/9ORq/TJcgX2nZ4nmbre9ncnEnYGdpat?=
 =?us-ascii?Q?wkmIFFRBXJ3u05FSCBj2fvRh5jt//S0p96kAyc9UJipKBgpdVSGNZDQFftVr?=
 =?us-ascii?Q?9hLGIo4KbIaBKELmaMfy2QNLGE0fP8305eyhFesecR/bQOEYhB0XeW6k5Gkl?=
 =?us-ascii?Q?o94E2a+nA1/cUCs/uJ3f5GIiwaeleXM304WC9ztB74gTgwVnDp9GFGdMTJGD?=
 =?us-ascii?Q?Q62TldvmrqlgWNlyMMIBiMdCYT22BuqijjY5h0naFpjTCXN8SeSDexbpMBVf?=
 =?us-ascii?Q?t5AYjuOrsgiJJLDN0GkbBictXlZignpR8h+54J0yTKFJJnUxNlX2GS8UWThA?=
 =?us-ascii?Q?VQS33vu7I4SW8HXogjSbP5bgoq7aIMMkLXXiM48BygwgoU4QVAttgfPgjwI/?=
 =?us-ascii?Q?ZzGg6BM4wuq3eGdL7EIbH5KZfMlBQ5tXhoCpFR5RVucIr0Yb97PSxH/HoXmK?=
 =?us-ascii?Q?pFp/xd//kBOiEF2nABGCaL5UE9HZb5loUryUh25FYXnkwH2lFYD30nEVJTEJ?=
 =?us-ascii?Q?ZF5KRQsU/G82rw26AecA7E1eRg4BzaIb5Aay6YT8nGIikSEqoD3FBFjvWqnW?=
 =?us-ascii?Q?lDEoVekc3hmRLfWDadXEouN/+dfX9RdPDED4PXRLIaQLPntX/Q346K6Otums?=
 =?us-ascii?Q?ram13SF+IbE2BwG6V37LTxIdc/Y0VE2vNRPHr4FwIW5j+Zq2+tZqiAETrlnW?=
 =?us-ascii?Q?MJXLQwgWGHfzY7sbAL4vHxAGVy6yroJu+MmkNBvCmZuzNxXK2GZhHM3NymOh?=
 =?us-ascii?Q?yfWbi8MwJhtyz28QuLh44752l9TL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:17:59.3896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de3be1b9-fcf7-41bf-2728-08dce7e7115f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844

The AER service driver's aer_get_device_err_info() function does not
read uncorrectable (UCE) fatal error status from PCIe upstream port
devices. As a result, fatal errors are not logged or handled as needed
for CXL PCIe upstream switch port devices.

Update the aer_get_device_err_info() function to read the UCE fatal
status for all CXL PCIe port devices.

The fatal error status will be used in future patches implementing
CXL PCIe port error handling and logging.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pcie/aer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1c996287d4ce..9b2872c8e20d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1282,6 +1282,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
 		   type == PCI_EXP_TYPE_RC_EC ||
 		   type == PCI_EXP_TYPE_DOWNSTREAM ||
+		   type == PCI_EXP_TYPE_UPSTREAM ||
 		   info->severity == AER_NONFATAL) {
 
 		/* Link is still healthy for IO reads */
-- 
2.34.1


