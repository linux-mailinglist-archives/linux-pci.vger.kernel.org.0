Return-Path: <linux-pci+bounces-11447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018B994ACA9
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082A31C227A7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E5C13B587;
	Wed,  7 Aug 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ck01tqqW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8073F12CDBE;
	Wed,  7 Aug 2024 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043913; cv=fail; b=cJa1NeGIGX9xkgf3I+jtkT9KSNbGuLLnzOXnmwSp6WYHamzgbxCQPivmG3v9qhpSvqmnttg0WlZ7p4Ce1hCgnKNGvIfEnmZ2FjziDh0j92yHIDl9WJU4bsOEIMaTx17m+378Tpy2/jckteX517Vv9qCTp97cNqliQ2CVULBhxa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043913; c=relaxed/simple;
	bh=VbB9UAB9Oj402xPmMSvAP2FyTLDjGE88oel6mYb+hmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hodkzrTlFumeYs7H+OhvZYLsIeX5T+WG53JM7sthxzgapVOHjCA18o3yKLJEdRxYOPJ/wmkimzDsTNj/S8kQT9bfF9We+3vPcXGrMV0/7zAeTpE2HwBhTSY+5POt1Rl7SM+YLn4pE5hb38iB8+60QmQrZrVCRR2KGHmRtaPIWFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ck01tqqW; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mx9FsNRtft/essKCqi2Osw0ricyVAu9eyphvPcTyVCzRS55ETpysm4d9AjrvCDP4xV4nuofs2F0W41CXdZ5QeyDB/Nz6gzOHQGV1eBl63FiqU5RZwExkni7ZMHwDmKgWae970OHfu5VYAFiFycwGeXlYH3pd3RCtysphy4bha+CCPUs1D3jIth5XS9mfTGBSY1aT4AXjCreHI9wLUQEZyhb0QZgugcUTVbbn6+F5568fv7A3J7wOk7wTOQLjMWIckq0CG0rpmLfnzMUzt+9ttBvTsxDT4W09l0LwTjkcjIKIzga0oyw2qXP00qi6jPI6yuf4XBhLsdzJyNR14Jp9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUAL2p/eq8aSt7Ix7IjrN+OJU35c/19SpI61XiVbGgI=;
 b=wlcn0zOUtywHOwpt0k/EPPl27DfOyxQvt6AFgn/q0QvOkOjARQjBMoJGySpMc/BhC3BtpT3F6BZ8SHlOD3dksFxJVnyiQ7i1acmA/XT6VIa3rYkW8f1AgqJ3o4+a8uYhFH+ZRm21S1fUc1PWTi14dNRRNI63IhnIcQRPyHxl2zVnnNPibW/+DHowceBGfhF/QeE9npsMRnQXhm8NnrpXGXvVe+npI468/JO6KltUclSjNj5/nwY2WsdgYaLMBGm0oxl3ZzgBtTRO+8+WBmmlegB26+t1VDvoFKzJqCBNRFxiFJk/8uh4KP1Dl7xc7KXzxvh7OX/FieKqpTHYlguUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUAL2p/eq8aSt7Ix7IjrN+OJU35c/19SpI61XiVbGgI=;
 b=Ck01tqqWvkR15OKICMdMiht91LDchLhjKaYswPDeOojsAdnSwQxegEiZy2ggpc7Jn+waZEhQGu6F0sEfqHE6/IReusCqa98GrC5Yt8tP0drccMn/2oxypeQC41avADTjfzq6KtsAcMAHRxX4BK3+prr8t0Wp3F/TR6srur0fLpY=
Received: from MN2PR01CA0014.prod.exchangelabs.com (2603:10b6:208:10c::27) by
 CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.12; Wed, 7 Aug 2024 15:18:27 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::f9) by MN2PR01CA0014.outlook.office365.com
 (2603:10b6:208:10c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25 via Frontend
 Transport; Wed, 7 Aug 2024 15:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 15:18:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 10:18:14 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 10:18:14 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/8] PCI: Don't reassign resources that are already aligned
Date: Wed, 7 Aug 2024 11:17:16 -0400
Message-ID: <20240807151723.613742-8-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807151723.613742-1-stewart.hildebrand@amd.com>
References: <20240807151723.613742-1-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c00629-51af-4df4-342a-08dcb6f42fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nt6VOfW8dTsTelTRhPOKPQplZshlBEgKJ/PuxCF8GD69tSMVUDPhd/ajj4Vu?=
 =?us-ascii?Q?7gP22IoKZDpZadyxT8Ik7KsTs6Cv6SmsuLPGI0Y0toWgJjQn7scfo8OpLLSk?=
 =?us-ascii?Q?1FZkwf6bMd+Qcq4xjbWFEGq8Caval2kwc1nz+otpWd2UJGkqtW8xb3Ymgc3Y?=
 =?us-ascii?Q?A/x7/WbICJcYNQR2UKVxBsLCSCdn7hAYcW1MfNOf4AX+VhJW0eXhW/RU38jx?=
 =?us-ascii?Q?fPteTY7E1TSXsko7thOkn6jNoMxueA1Pxs9MWv+gl1WFmXewbXH5vqL/mufo?=
 =?us-ascii?Q?Vlpbd/8nYf8XaYm9rdqRNAQUZnUaWUk/lHdowG5TIOVN0rqXBoJpd8A3xyg3?=
 =?us-ascii?Q?iFMvsZlr79FCNn8S6Uyh1ZbOArzGhTz6X1lbW1dpQi82LzTNCjiYQYjzAqQN?=
 =?us-ascii?Q?3OI8Mzx8Vm2+C9z5QpuUojUyKhE1RfB8LTim+m+TLeT2BET7f4j7lDQW7ggA?=
 =?us-ascii?Q?wCvJ+W835nAtMMbWXiBzLgepfzV/+RtXbadGXji0PWhUDyq2rK8IQxv9vbqo?=
 =?us-ascii?Q?6Tr/Z0nrG2ByS0gMGBygIH6I+FtCsthuaOtUQAm0oAR2nUnaX+Xn0LTu3Vc5?=
 =?us-ascii?Q?j/AQRZg1m+3iDFWmKcEaDwgeK0yxxl0N2y55+vxoSXZrywvrpDikC2p+p23X?=
 =?us-ascii?Q?R/q8zW0CCeY9dFaAO0qSNactEKyabtCv1s/PDya3GJifjg+WZbNVwHf5nPvI?=
 =?us-ascii?Q?J/NLd5LEsyqMcebqzt4YiPN34fpdIAYQl7lX85Fmd3OHWqUNUiI/IAlIIIUj?=
 =?us-ascii?Q?K7umsRjeOA/7bFJs10837ZHA7QioKWdoq3UB1BlPzp1wDMOYLhOaTPOFDyyC?=
 =?us-ascii?Q?JWjsSGo7eQoU5VclAfM/97gsZ3vZ12I0Gxw3aWSWMYrecVWdRwagLHT/jgAx?=
 =?us-ascii?Q?0NvIIPO++RnoGEptWoyFpvZjOlGsS+2Djn1wdcofARBzcaqZgUxc4Wgg4Dg9?=
 =?us-ascii?Q?LV3eqOTOeDq+Gt8W5THLTS/HweT+TlRhtuy8FLTMLzwT5vg9iwohIgzjxMC9?=
 =?us-ascii?Q?veGIa5t8tRT9eTpe3mtMGP9ysbthdbV89NYlbY2L46B+6v/DjOrlBX9pkxPe?=
 =?us-ascii?Q?E1QKIJ/a+8+KNu8oF5dOjA54nA3kQyOEykoC8k6eHeLushNePssOJ2PnE4vz?=
 =?us-ascii?Q?cGP/a8odZh5MLTHIlRjW3jRb2UgwvptHCNyCVhxQ4dyf7ISN4fZ0w+1Ijiox?=
 =?us-ascii?Q?zerdUX+v8YhSXWYPgXpX16jz7Tpb9iSr3r8f4TD6xG/vQ6ioE/pbAylUOZn/?=
 =?us-ascii?Q?d2CKRYS2TtmlXYCHoOtzN9gYxPmeX6HrR9xDaixI5hjpDyN6MHoSXLVyxIrw?=
 =?us-ascii?Q?DN94yCQBtjY6QV1AgH6+gB4G/x8FV/Bnekx3ZSRqMSIxG6vIB45oOkULfE6M?=
 =?us-ascii?Q?wEaIeB3yQGjiX6k21jAtmDA6RBbEEJKS9BrbrfMwpRD5wnCVB2mfDg83IhOw?=
 =?us-ascii?Q?Xr+BteeJz+81E2dcpOPB2qb0XUBVy+7k?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 15:18:26.7036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c00629-51af-4df4-342a-08dcb6f42fa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168

As a follow-up to commit 0dde1c08d1b9 ("PCI: Don't reassign resources
that are already aligned"), don't reassign already aligned resources
that have requested alignment without resizing.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
v2->v3:
* no change

v1->v2:
* capitalize subject text
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4b97d8d5c2d8..af34407f2fb9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6584,6 +6584,9 @@ static bool pci_request_resource_alignment(struct pci_dev *dev, int bar,
 	if (size >= align)
 		return false;
 
+	if (!resize && (r->start > align) && !(r->start & (align - 1)))
+		return false;
+
 	/*
 	 * Increase the alignment of the resource.  There are two ways we
 	 * can do this:
-- 
2.46.0


