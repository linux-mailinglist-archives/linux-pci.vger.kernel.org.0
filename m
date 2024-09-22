Return-Path: <linux-pci+bounces-13341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D903997E039
	for <lists+linux-pci@lfdr.de>; Sun, 22 Sep 2024 08:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559E2281638
	for <lists+linux-pci@lfdr.de>; Sun, 22 Sep 2024 06:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D778211712;
	Sun, 22 Sep 2024 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T+Klaejy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15265130E58;
	Sun, 22 Sep 2024 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726985675; cv=fail; b=nhJth4IAqomeBz5axELd061bFaws/Ko+NPYGBLPOgiTtXJMIg6XfinbRkaQ7i0mue80nXsRKNvR+S5/8Fy9d55bIfMNn1kH+BzvYbwO890EuT1Q4zmW44ixQm4WD+aoP4bKicJECU9hRn/aVBPLPox3WlJgjyYfnsvqE0N6oDxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726985675; c=relaxed/simple;
	bh=g7Aoz5tb8ctHpK+I2cbWiLVVIzEzaVWALS7KUW4twLc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L46boav9N3tsQ7lNfy5D4apS9Im8lib3NM/2Tb5BLNHDkpsipmSS+nt+agA0XQkxMD1szdKrDTPqA5XRAVmUWI1fV8pZ4bkBSGK80k8mk04TdMYQVSrr3kn4EzVxyoHqj2fP0kjQIYk6Je+/FU6HwpjAxdYC/rwBxH02IHSHIUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T+Klaejy; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ6QdfdV+dOuF4Ul2dzdFhusW79UkpdRpGRvtMLRNbVeaFcteu4c8bQd5/Syw8cTZ8NBMN0eq0C1d2II2if2EhLOoAA1K665a6fsBarVfgxSspjpNM3YiZGLLhb23lR5LNuhwCTzSqiUkkwUVYW10zfq8mFKeW5MCbujZ3hrQEycIT5wAwuCoLhYQ8pyXeERKXQMZLHlPhn1A+2HhHunRfsa94r/l3UPr7Jiu2p/SPb25QJXnbh2hlReALk0nd96doVmXIFTsBXnFIOtr4wWj8JHJFT/AVioJtygRuqs0e0c3uiynwioyMKrzdlLxv5EKu8p+pcq5unaU0SiyLQZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGGIosIU+sMxJPeWTWm+Kd34TVPtvf7VOPC6ZGjGm8w=;
 b=nSMZYcM5/ayW4DEMFbj+lX0dUZEd0X7mEoYyOsOtnzOnVE1SMbXe/MoGBR0oPQcoiIiQVbp823oC70blBJDe1ON0/+4dcalwyy5V89IQiYfWqpxVWbAUD5BS43ZqN8qpFJ9pSrg45FiZ1KhaRssk/M64fOgdkaEykMSdxhQPfmFpx5HwK7tUyTOt22Uk3/UhobsLNyWkVIJzq7z7bM0PfDtgoNP39oiGTSOTOCy0/LLodm0YNfw90QfvrioFqzwzt+X0Y6bvj3Vzxfk7a9XU2VPmbxqNVyBvdl/DMeO7RzfpzM2Jx87FSIHGBgSfRTp4Y4nnJROXAHXiYfiQT2Dquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGGIosIU+sMxJPeWTWm+Kd34TVPtvf7VOPC6ZGjGm8w=;
 b=T+KlaejynQ/Pl0VWS9KGtJj7+TUcIKSltkR7FiOJYtYeRTf/wGoAX1pWe0ykvSr5cB932jPU01zcdhtjIopbm70eHrqmwjh7srLJNYlKembDRUtugQfikL5IqOCuhwEYy2dagEGOjFb2eWNiqzzhdWMHzuO2VjtXnTJziZWY/fo=
Received: from DS7PR03CA0108.namprd03.prod.outlook.com (2603:10b6:5:3b7::23)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Sun, 22 Sep
 2024 06:14:27 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::d3) by DS7PR03CA0108.outlook.office365.com
 (2603:10b6:5:3b7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.28 via Frontend
 Transport; Sun, 22 Sep 2024 06:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sun, 22 Sep 2024 06:14:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 22 Sep
 2024 01:14:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 22 Sep
 2024 01:14:26 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 22 Sep 2024 01:14:22 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <kw@linux.com>, <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <devicetree@vger.kernel.org>, <conor+dt@kernel.org>,
	<krzk+dt@kernel.org>
CC: <bharat.kumar.gogada@amd.com>, <michal.simek@amd.com>,
	<lpieralisi@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Thippeswamy Havalige <thippesw@amd.com>
Subject: [PATCH v3 0/2] Add support for CPM5 controller 1
Date: Sun, 22 Sep 2024 11:43:16 +0530
Message-ID: <20240922061318.2653503-1-thippesw@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: eab603e7-0470-4bf0-1d51-08dcdacdcff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ff6J78fgjasKcjJrumxyGAEyIAkTSLjpG0gATBgAktvoW+KvYnEtvf84tqQ6?=
 =?us-ascii?Q?No/smYlXd2Su3BceZgRl7tVkJmoxTAFMa1MBiN7kJbkJ8yvubLrrETaevlOA?=
 =?us-ascii?Q?TatY75GjGiWlmqJIYtLkuileLzoCKM3QE6PG92QV886O3ovIfLgyrYy2ZMyO?=
 =?us-ascii?Q?9sB+0CQTBA9oURzK4AuTMVWY8UlNJxUhcS/syKxhj1VND03oaZBM1AvBYen5?=
 =?us-ascii?Q?GlP6ZRM12QRR55WRCHIj4pQSRXCp1kPPQdmFgQSrWyuJ+WVxP0qOn3o5E6Lk?=
 =?us-ascii?Q?S0FfgPCd54kOE/Q9lbO/XKQPTlo9F0nu8oynkl6KrzgRFKu4SKsFJW7S7x2F?=
 =?us-ascii?Q?Q15NGJC47DuXSBv9QvvC+WZdcRmlc2jPtTAIICnPjFHNlAO7YLTeF+QLHBK+?=
 =?us-ascii?Q?3fMKC3ziOw9n1gxd74q0B3OGk2IynVh55E7PpJugS/yxSFsYbehBA9GbOG6x?=
 =?us-ascii?Q?Bx6cZkdZ6MRBZnx604NBAU77P2j+x5K+soUpvjCBbq3ParPzQGyC5o+QekE8?=
 =?us-ascii?Q?bXBz6dZGQeFmlV0gdiFfh4eb75GSpdCGtnOVgnYj3qskcCo5nLrYVOZWLB6+?=
 =?us-ascii?Q?arBleoJtP1kpXGU95OsvAQri03d/MOlkk+H4YD3MBUQtdVnBOMkeYXbA7kyO?=
 =?us-ascii?Q?quQYEmFBwZUDW/BJr5JeMKkkUcla+jJ+C1xz4xpDuzlbQzA9+6l7BU8btMqd?=
 =?us-ascii?Q?1lq55p8D4pIb0I7OIEhJGQEYhAelbl95fu33jywMtfrSaCsHo2RQP+1Aseg7?=
 =?us-ascii?Q?Dbm8UbYs6e0YG9zepPPW7W1ZM6fZ2l1KEmFDcE9+FrYTM8izY8ttvp8HcVNM?=
 =?us-ascii?Q?xPn3Al4LtHs3aTC0rK5xoACLybsT6wl+bpMqhD9zseCaI2ylVstlZ/S44pk4?=
 =?us-ascii?Q?msk9eUfdIS4yfaQt/WL4OPi4KlgQpwoS50KI4J3OATIXBZ/azWRoMZfYCJDg?=
 =?us-ascii?Q?BtmfjUeV7/rjzVjq0vFsKad4ZwM+TfwcjfJzPtSyaGUEvFcqQCLBYTVbQwLI?=
 =?us-ascii?Q?W1C/xWZGImDkOhl50qAfH/5ObosLXX+hDG3yliVwHilHh1r0NSql7eZduUev?=
 =?us-ascii?Q?CEsxx9y0xCHZ8NoQy6g8W1BBsZGFFto9n8+Tg8F1VCIvubWzNZNzCy9Ny/TI?=
 =?us-ascii?Q?HES3W5c2niQieAqJxZTmsHE9GFge5W4xzcBlRBD0i7Om7AbSrrJLHNSjGiwF?=
 =?us-ascii?Q?8KDZeKtF8ttCv3zQnLT4dd6SUxGd7p7wbw+9qpjx8REIQJobpPVDk9QhYjT5?=
 =?us-ascii?Q?Cpkv70Nwxtxzj+njhAnVuTfMzKidr61EtnzOniUCl6c6KYB0x5KRnfkDSQ6W?=
 =?us-ascii?Q?PQ4p5mPNmJWEFUR4hA/15vzSE6wlhqvJJRnKGqLT/odupJrd7B6pcptlLLEg?=
 =?us-ascii?Q?ixCKzEhJnku1p/PR5j9segfL5ya3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 06:14:27.0510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab603e7-0470-4bf0-1d51-08dcdacdcff1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630

This patch series introduces support for the second Root Port controller in
the Xilinx Versal Premium CPM5 block. The Versal Premium platform features
two Type-A Root Port controllers operating at Gen5 speed. However, the
error interrupt registers and their corresponding bits are located at
different offsets for Controller 0 and Controller 1.

To handle these differences, the series includes:

A new compatible string for the second Root Port controller in the device
tree bindings.

Driver updates to manage platform-specific interrupt registers and offsets
for both controllers using the new compatible string.

Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5 host1
  PCI: xilinx-cpm: Add support for Versal CPM5 Root Port controller 1

 .../bindings/pci/xilinx-versal-cpm.yaml       |  1 +
 drivers/pci/controller/pcie-xilinx-cpm.c      | 50 +++++++++++++++----
 2 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.34.1


