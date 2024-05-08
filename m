Return-Path: <linux-pci+bounces-7218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C31478BF981
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 11:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7997D282571
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E253173183;
	Wed,  8 May 2024 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="moRUiT45"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70A1DFE8;
	Wed,  8 May 2024 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715160158; cv=fail; b=GBuggXOO9v6jGwSrFmJGOuaYE7ukZRYc/n+mBeKh+HjAyieQdCL4L6EFcmay/QvPeqGAPXyqX5ZsNg+cmwyHAV4jQtTw8QrzuCSUL909ynefCtIWJrP1IjRr6DaQY5a66sABEiqKXA6g/h0ltGyVdux+xcqixFQbJTtTc+18wPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715160158; c=relaxed/simple;
	bh=3r8b4Xg4+Kkmkb2j86VjKSQCCZ+zcdcJ0B3M6U40fk8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EwdoC8OEAT1nF6ERvCEzICEJ2LDmyBdmCA0qypxCKU+Kr7HH+1esN8JV6w6Rs/7fe0hbYByD+Z7vYbClGESi3tXqEN6x9/7suB5C/vIXhgS6312yc1bBCB2BKTc+wSVMtzTjAAjONph5OrDAZ5bHVYvbOWV67xEgu5M/7BS5VjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=moRUiT45; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms0EaQPviWm9EK0EgP1ErUogIw2YqqQXDmmaTRqOCprLYWIOrjIw9sznhmQmIy7juGez/FlbUAygctTzz+taOny88d65uwjzzT3lVctI08HOVff96OFea1FQea6VdCzlI+DVUHBZzr8OLVZDaZzCNGoYg44mOp/uc53+mcDxOZdQxhXCw6Ficd1gxRPP73RpEZ93CeOmjD/VEiY04n4YcYWWipcjjNE+0M07yuv2RbbKX2WqrrxAKKdoMMpIsk31YXnss73nq2kDog6zP5dTpQ6l09j3yPFFi+CxKQ8vij276NoX4uvqbWY7fbQimCa+6w+Ta4TlnZWF0U8n6ATl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kg227I/e2sPuji5nsoa7Y+ijPR1xsJC40Hzg8ZwtZI=;
 b=RNvv0IsB+m6sqx43iNcG0iymWVnad1eOtLhdRccpTpnG9mMu8Hw+lAs0wWqS87kVkPxb6KdejgO6ngev25t+yIzKPJE2v3i6IW5T7bkjADh5luWtuf96VXRxU4h9fqNLMESHa1rqs9UdyHKVGLzKJtO2hOZTWWM4ad7JObIhB2xhjLs+XNheNOm2WC0hRWolsO6hap+jt69WmTHYZwran/q3J5KwYrAfuXQIhQbSA88yDegcNsz0ruAgXYgP6Gua5u5b3NNLWQoIzYVBgSqLLjlSzdOCiCe1FlKM1EkJYgsy3SNDpHzx/xxOKiac7nW1jNbt47FGNMg3Umdp88dBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kg227I/e2sPuji5nsoa7Y+ijPR1xsJC40Hzg8ZwtZI=;
 b=moRUiT455tNTnFkro8qu+PtsfIyj7YVE+/fgjnvG5NNQzeJ9WuqIem/Rza2AUjleVqbteYNC55h/SSgC+WreYevbCqEBRKACa9QjTPudmNLl6qOKLD6FIsH0EQhRxYL9dbTZcQuNFzQbckShXVbZZPHr+Y9A/MRNA7PEwGCaiyxsZubNCNcUeBjngkv2ntTbrmX7KQ/bs1zP3tlr5ShBWwo03x5JkJAwn/w40zrKHrNoVS0f/dxC9nLR5EfaQwpMai9ES53NEofJp5NqAsuHJp/ipbBlA7AkH3XmtzQm+D5hAeJrh5LDYyitrBKZuB27L3O/DP1V3ltoBdy0CDTwdw==
Received: from CH0P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::7)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 09:22:34 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::62) by CH0P223CA0019.outlook.office365.com
 (2603:10b6:610:116::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 09:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 09:22:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 02:22:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 02:22:17 -0700
Received: from moonraker.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 May 2024 02:22:15 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, "Niklas
 Cassel" <cassel@kernel.org>
CC: Vidya Sagar <vidyas@nvidia.com>, <linux-pci@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V2] PCI: tegra194: Set EP alignment restriction for inbound ATU
Date: Wed, 8 May 2024 10:22:07 +0100
Message-ID: <20240508092207.337063-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: f060025e-62b8-498d-32cb-08dc6f4064f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5B1LWvzTppc/Sed9vzAbZMcVF4aAxWBxKbVrouefeP6O6d/hFy3zkz2UL5qy?=
 =?us-ascii?Q?jAjWwFo0eQlWp7TQnhexznNFPZ4gVkCmDmyNvypbZAwcAUH136qMwVlg5LAm?=
 =?us-ascii?Q?/fbJHldvGUaQBkd2YcVxKW5nUow4ttwm3q+9K6fH1VnGhx0NoFoSUgIOCXa2?=
 =?us-ascii?Q?SH2Gtl0UAnGbZNF9hd9Xq+KHQUh9HdxqMpohyo4aGp/Ys/hoqw45xfGWHFAM?=
 =?us-ascii?Q?tCnuoI4D8TSW7ZfFE0+huxc6MJXRKa8WCJfD/4SsSrpEJGfl+/qoXgeXuSFZ?=
 =?us-ascii?Q?Ekg0jM1QG8fC8LaEfV28s2KoVohzntbNc0V/zEdZs2IbM9ocNaolC/6A0cjR?=
 =?us-ascii?Q?g5Lx8wk4d5L5XLyMd+xGnxKck06DzxeoBp3cdwvtBPoIyW8kotYOhAhx5zPw?=
 =?us-ascii?Q?ucsE4dkD0vc6Z6ifphTsIxtfOIZbBp+4VSq9iyjh4I5X4baDNER6Mb6NbFoO?=
 =?us-ascii?Q?7lFKBpp1RZWAyrJnt3fGDwt/jd+ms5xhHqQlXGR3kDddq+QhXzH9gxUlwtM1?=
 =?us-ascii?Q?huOyFJ2egAInO/vWAwGrgmUolguN0daI9aivd+Z2X7Vt89TRiMWBnfmZyXsA?=
 =?us-ascii?Q?YlZ66SUQu/DrJKjjrenGB18Vs/rggjc7YtxIGfMPAz6yQ0PAB8FW8a55hsjc?=
 =?us-ascii?Q?Q6pYtc/is/1A7xEccuhU+53lRTKTCRNcmrZxBTFOXxc5cBhpjSkhAmfphO83?=
 =?us-ascii?Q?e+ZW2PUAumPxsff4PmMK6kG6F7cdlPJ0eG0FqvUuQkLYQ9yF0tWhvuB1pV8N?=
 =?us-ascii?Q?QRfnc1erOpMRH5BW62d8M4BEisKTYNRP8U6CbfCygeUmihacmjRWpQOqopj4?=
 =?us-ascii?Q?mTLc3sey2wKojewfXH89YmUN2aTsIAl3rwwNx7fK5dher4WP4efz4WE7ou0w?=
 =?us-ascii?Q?SnJUaib+IdG3Bqf6TOUxXIo5qdQkMs3ulEWgMvCNi3YC7g1JGlMckIlupa+j?=
 =?us-ascii?Q?tX50p/F7obMbjnFKMNbHK6aSy/53bVWA+4i2YVPZvtdORA1FafM7rCS6ALAR?=
 =?us-ascii?Q?Ri5CvTptfDJSpTIwUlwfT0VISFqU9pSroNlydTOSaMk5dVRudG8gcAnEdcQp?=
 =?us-ascii?Q?nj3hNU5/vj7R2aWWeHHvCGjb7PahJx4sCNi+XSOs8DpQDqq3ITzerNxKNTB9?=
 =?us-ascii?Q?UgVJu4NC/motAaTWTtVlo5dIGNU0JjWolHxcEv4mnLHOoWhH5vUufydHWGzD?=
 =?us-ascii?Q?zx/je0YlKa0j2ppa72tcTvbghb1OqeQ5dIBnL8yTk7oY6ESEkS1+OV1fPr3P?=
 =?us-ascii?Q?AESWLehe7NpqJugEQibm+QHqAuFpRrHW9gu1GlB/CxcYLd5G7aPpLBzOX3Gq?=
 =?us-ascii?Q?caD5QznNFDN1ic7+f4WfRVSVkDBnXWf3qYOC9fto0llBVGSLTpdI0g8KMUlt?=
 =?us-ascii?Q?3sVXJak=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 09:22:34.0692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f060025e-62b8-498d-32cb-08dc6f4064f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365

Tegra194 and Tegra234 PCIe EP controllers have 64K alignment
restriction for the inbound ATU. Set the endpoint inbound ATU alignment to
64kB in the Tegra194 PCIe driver.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
Changes since V1: Updated commit message.

 drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 93f5433c5c55..4537313ef37a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2015,6 +2015,7 @@ static const struct pci_epc_features tegra_pcie_epc_features = {
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
 	.bar[BAR_4] = { .type = BAR_RESERVED, },
 	.bar[BAR_5] = { .type = BAR_RESERVED, },
+	.align = SZ_64K,
 };
 
 static const struct pci_epc_features*
-- 
2.34.1


