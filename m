Return-Path: <linux-pci+bounces-17639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ABD9E3957
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 12:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA5AB2C991
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 11:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90DE1B0F1D;
	Wed,  4 Dec 2024 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hxzMuxWW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060B1ABEDC;
	Wed,  4 Dec 2024 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313124; cv=fail; b=FCV+YiDrGFBUMdcNk6fAsHBpJ8HFlixGaagOsCNB38MUot3BBP/NOxh66koghJTYmuDzRsl3CcrycdmsDIv6XOVrPCVp7Sgzvzxbosuoq3v/1J+hbaBo51Y8NgC/3FSHApilIxYyUOQGXg8+hW4l+siq6IZqzAdij90RLOjdBOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313124; c=relaxed/simple;
	bh=V061oBFHHdLp7jlGcAQ1o8Z5TQhPnPInVfL7fYSs3LE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CtdO11Qqwk6qburSoVQRZZ/NOn/SxkCH/OA5f08Y054yMBRvGn0GUkjzOL9GXlls3B7VMqE3qhSZ2Gau87g1TvnicqgcTp4TZ7FqcxjrDYzcO02Cx2XeWNiyv3oPgMLOl0pG6qs3u+ybPLySDP75tmAH5ldrywHWCFgIaS/y9Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hxzMuxWW; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIaRIz9AP9b2zK6qKyH3aTFve8pTLvXYZMXNuJd98yF9edkk64uns512/RwzfRM9O+Gy1hU4J7J7KZ5WmYQSCZpLiI1p0q1lOgkZbcXtILbFRS4STxqNqVbnhX5EDi6USmR9mh2d0iydhI9+W4ZHTc+jslw78SB7BjwgsUXOeEx34H/FMC9FCH5ScVI9J2Kpx2L+0qaETlw4ZC8GWIg2xX2vEp0Z4tgFb+ftbZDWO0Y+WQhJJ6Z8B/7Hx0wiVPywtw3+Tcj0EAfQXI7fxj8cFFFXZ4dRGimwx9f0r4jfvwvdDpFK0FpY7zZMhGX3DMjIRwwwYx7hXkx2agBBT5bZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m02f2/2AsUPomL2Kqnwz2/k6uTiueWOZI8zM+/ReIA=;
 b=fmdWcm/zlWILTUvPZdM2iSBKFb/DETkFxTfedeZ85w3fKW2d4CVTQScNhHXubB7r2DFRhXZ0iTXk4H+clOWcLgAdpEwIiHGRB7E/HWGbIuZXyOwjEsbXi7zOUZg7XQRrvtEUM5x9q7S+JuDZBemBoTq0/GUwVq17xwgIsuS+n1JOpE4x06+2WESOhuT4NYP8X6+GLUJB5sKXWOJZ5Yfhpp2VOJ2+nETJApKcJwQRu6TuOWlKfZrNV34UZo017u00U7LZ5515QaMXNxs/L5V1E++pXEvQN2i/1rNAxamdGW2zY7dpYJ7iG/O6tWGWXQFzTcKMaMgBJa3ojU4dzHlTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m02f2/2AsUPomL2Kqnwz2/k6uTiueWOZI8zM+/ReIA=;
 b=hxzMuxWWSOoA+JTCHfmUCAXcB7YcjUV2xw9d6xnUBXsLPruoOzbb0dfM1sujF/FoRRF04ELywqrWPqXH/M2KP44u7DMBkc0rzO2QEd3HAaLIfr7z1z/E4sXR/gEHQ6p4EFbH2yqm6yS+4l6u0On9ehJlhkH/VPaHFju019vrlIA=
Received: from BL1PR13CA0368.namprd13.prod.outlook.com (2603:10b6:208:2c0::13)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 11:51:59 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::5f) by BL1PR13CA0368.outlook.office365.com
 (2603:10b6:208:2c0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Wed, 4
 Dec 2024 11:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Wed, 4 Dec 2024 11:51:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 05:51:58 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Dec 2024 05:51:54 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v3 0/3] Add support for AMD MDB IP as Root Port
Date: Wed, 4 Dec 2024 17:20:23 +0530
Message-ID: <20241204115026.3014272-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 123d7dcb-b091-4cfe-c064-08dd145a0f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DaiNVfs7afr+ziCaXp2AzaPV/QWXNcaZusOSOjLZuLfVZVuBtGfmbjVkLsOZ?=
 =?us-ascii?Q?MgV3Kb/gI3xbRiQdcJ+5NCbi9UN8k3LX7xw9cOIu4UzKG8jwww4+a23rzRq0?=
 =?us-ascii?Q?YuPxbRUPKJna7K22ifmNKAtHRmIt+EF6aLLDIPGK0zAtGTrlzG2CipINjnvB?=
 =?us-ascii?Q?tkaK+njzhr+RoxF+NMah4G/GazLm/+fVQn9twHi3J11xiKO+IWS67kD8VNjj?=
 =?us-ascii?Q?Lq9TiVheb+r5OJFpbmerijNO888LyhWBHpizHcBQ9Xbqg9gy1yYCFToy5/Ko?=
 =?us-ascii?Q?pU+0JdBekm0JwWXMmPfXbCWSgmq+cv3GQqjZFuACo7vrYx0KNx546C2vIfKk?=
 =?us-ascii?Q?80MHVP0PHMxqMi81a8khFU3fD0ZgqQVGzxyyM+l6mSuzPWKNp39zp+aWboGj?=
 =?us-ascii?Q?FVoyTnr53PXiP1JYkFs3nzH5lYVMQWOYKaJ/D7dQgJkN+ixcXw1kZROBYZSe?=
 =?us-ascii?Q?idSguBPmhv9QafjZUfiBI/CXXu2zeIwQkkCdXdREfy7LOiBdsneaIm/w62Um?=
 =?us-ascii?Q?UCyZnlh2eVRuP0HHA85QmozjoRO3tBFwxmmmC9iJFfm69zTaiwgnYWTHay7d?=
 =?us-ascii?Q?vKX8n5czVycmA/gqz52ej4KaJwP0PKE+OhuA7awlM2efp+uAmFLiLNmGd98r?=
 =?us-ascii?Q?yKa7+0cGcHw45UTIwIAX3N5qJ0j4GfzXk8KBi+utXtzhRTgpORGMNUG6IL9M?=
 =?us-ascii?Q?p+4M+fA2CpdgiR+IBL0jlj8JknMRw8XkEAZktt3zkzOBY8vd+SEO3XtfEq3U?=
 =?us-ascii?Q?uxDMjWvMayxybh/Fj6x4tEwGpg9DnlH4ZuUnoCkTKIgkeNthTdW54W+GobaL?=
 =?us-ascii?Q?kjXG9jbpSbmzonZYwY97CwQoXGDrhx3F6RZhRdPmXy0zSJ1Z63fn+craLvQy?=
 =?us-ascii?Q?+421RrCE5GPXwhc+tUuJtGX+rJXIxJL7OrT/2XaPT1b/BvxSHqr5Pth25xd5?=
 =?us-ascii?Q?1TgOlWzXAyZDTWULiKzYYEj5f1yphKwA+4wsxeLSA3FlBlpy0B3WQHMVJN2f?=
 =?us-ascii?Q?6EWEopWJKg887U4wR0HQQM7K2Izu45nz8h3JEgBsJcaUTMqt+Q9wc8IHyk4+?=
 =?us-ascii?Q?Xxt+AWHGK9OLX3MJGdhroN8HiPI2/8y4rNPaYNOvctmTLauESSwiN7ot+1JN?=
 =?us-ascii?Q?bHnTHzTbw4M7qm1qxXVcWLx2U5eBYey5ddgx6DZXkBhA9h5JHR/3nPX9g0iC?=
 =?us-ascii?Q?ncieiOJZmEo/SQnHqDbLP/GEh29vItSzeQndYqQgJd2I/Fnr3lTPpz0vTKsK?=
 =?us-ascii?Q?8UKtruShPOHS0v11XtdM7nUmTdl+b4swTVEefEKy+rfhIRAYob3ALsVTa1mZ?=
 =?us-ascii?Q?5hmUmbOY2ISMygYaFOvBKCiwb4tMshf6Z2SZTayYPFAlce0j/XVF8nriROnw?=
 =?us-ascii?Q?ffdV7VzR32Tv0tkDMCH2/FdnOa7l7iKVpIGaX62NPy0aLIIEMnJxaoClLA7V?=
 =?us-ascii?Q?Lxm6Rpok2ta2WsmqvHsMaHRafR8s/gtV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 11:51:59.0162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123d7dcb-b091-4cfe-c064-08dd145a0f30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670

This series of patch add support for AMD MDB IP as Root Port.

The AMD MDB IP support's 32 bit and 64bit BAR's at Gen5 speed.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (3):
  dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
  dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
  PCI: amd-mdb: Add AMD MDB Root Port driver

 .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 +++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 439 ++++++++++++++++++
 5 files changed, 573 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.34.1


