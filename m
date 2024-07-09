Return-Path: <linux-pci+bounces-9995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E32692BB89
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 15:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFB21F24C86
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61461176241;
	Tue,  9 Jul 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xVJW5bQp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EDA174EF4;
	Tue,  9 Jul 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532217; cv=fail; b=GyK1Ef/yBlsghH4r90o9MP6VwWkVZQqxZL+tPmvS+VsIVifo61Z1PYwRzlVY4gZdQ8De2X0LJh6GugAgOkHqZtSJHt+B9HjtcKu223uS5qbRrvnAvtcNCRtqASdmc89rclYxu7S/iDoyP4fTsHG9ddv5fr0dy0XqCDp1HfjGMPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532217; c=relaxed/simple;
	bh=cAt3eUbCP6mG+PemIm3TiMAopPUaq9KHiIrMgqKN2zQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1U1CqFt7a+QKlWQydmCDDAmX5M/TrUBzrEWedxa0p8REdBURbGM9C+6J0OGQxQ7Zowe2/782il9XY8gX/8p6sDqAw5boKnTeqFCrGNDicD/MtOr9kvWS7AvJ+Hv5LCw1hzMcjIgkbdt2zWG8k5nDovK/ChteMZh3XqDZasVEwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xVJW5bQp; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcmQmO+DhEJA3QwVSp1Jq1Ep8PmimM0AmTVMdnrLhdutKFnhGqAabOas/qQIdh+qEoyvhImKRq4Sb/kW86h/jsYCyhpGuIzCposJo/0BPMP+l9usShIILXP1oUUiOFqeChIlNew8X7HVV+P49gYE4+L9PHC3Svy+Hcp0jYkXipu6OhQvITsEwVMvhZC10VhsuCdRnm+hECQRR6IvUWmbEJizg0jDaxDZUjzYAJpIOFLwpsKYyJ+Gtuv06RKDsjWKw/RYtQwwg7az6NkK34S/pzdJvGt7VcWRk6nSjOCZuBsrBPHbz8lUuX2KvSIt3udie9zHAaVtpnzH7+09fwlgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEylzUqnG7CVXkkcgujuJRFplUfUTJpDtdksghUnytI=;
 b=NPo3QORv82yl1xoKvBnXusp1wo5ZIeTIUFKwrLA598tQcTX6QYHqaUOfSi4/HGyrXj+0VNQZUtk0w7LZmc91mVk6khlgVM6/n9AAJyf4jaWI5ehXo+HloceI58IjY5z3h4CTD5fPZQg0W4e0FYoF5adPz+nr4RTw59Jj8vkkVfgAnw4fVj3zm5ER65797n1zxdyqbNZ4QkORGIHBeGUSOeGsiik+JQWfhJTZYY4bvDf1X9f8TFn67Mk88pDxYkgFfSUv4y2ii0hV83sUQTboYTGsZ9FlsfafLG+XHG8P5FxK2JH0mJ1i7fJ0gHXEP9jCYrwyUIEZ52+/wwhpM7AMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEylzUqnG7CVXkkcgujuJRFplUfUTJpDtdksghUnytI=;
 b=xVJW5bQpEFTlAPc1X95G4yMmBKOmzZzP89T372uyg2JboIOB/esnBi57HRnt+iRhJrjm/j38jIYyggVCvalHp5lUelu322Jwa8sIulCnKvHeaGMbP3+OBNhJFZFhFmK3RzCV1NPwFmfWUMZCHujn6LniUlzGbwI4fHNqXaUX+lk=
Received: from MW4PR03CA0034.namprd03.prod.outlook.com (2603:10b6:303:8e::9)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 13:36:53 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::70) by MW4PR03CA0034.outlook.office365.com
 (2603:10b6:303:8e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 13:36:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.1 via Frontend Transport; Tue, 9 Jul 2024 13:36:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 08:36:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 08:36:51 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 9 Jul 2024 08:36:50 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] PCI: don't reassign resources that are already aligned
Date: Tue, 9 Jul 2024 09:36:02 -0400
Message-ID: <20240709133610.1089420-6-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
References: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a667d50-3dd2-40b1-ae10-08dca01c31a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L0xYI1t9q2LUsF0IfAMt03yr7Bd+Nubdkz65Y0iAUl6DA+L8HpQEuP5tJDX7?=
 =?us-ascii?Q?02blAzWAhDDhZHKknzDNTmmg1wCE1bGq43U1hSPqDk0ZHe/xkU5OvdgEEOx4?=
 =?us-ascii?Q?za3fPJoKDWwZokNvefjJsf4zy2IxWnBobU8KC/IKRxQKdBTjEJdGE+8ISBgD?=
 =?us-ascii?Q?UNDpcNADmtAv0GI2/qBdSN9dgmJCKnJq2yaTbk47RVQmKQ3jYXO+KSqaEKTZ?=
 =?us-ascii?Q?EYK+91o2XhLiQNtrPeHNiF/U17bZZVuVsbssjGOMrD0IE9CdoyS2mLysEzeP?=
 =?us-ascii?Q?QipG7g5VZg5fvewq4ypGV3GHssFWOvKY0f6v1Dos6o5Jz4u7UmnWvZA4xYn5?=
 =?us-ascii?Q?F2BW/jYlzfeJES+U9levhx819BPU5dUrJEXu7tiLGERlZ8ASvcVeWvfdnSo5?=
 =?us-ascii?Q?hC3nH4MOusCDBjRZTbyCoWEGBICiSi8e/XxUZQ7xIxXpv79I7fwtJMEzzMmA?=
 =?us-ascii?Q?LCKOXMHvDYirtQ3xSP6dtcPaV4tNI/MH9ZjUk61XWT2DeCe0+r16iEs719UV?=
 =?us-ascii?Q?SMf5dpJ4KYqCkmNvLh3JtlndVddUUkuwcK/kJXPtlpI1DSfjJ+VK3/dTd3N/?=
 =?us-ascii?Q?+U+P8zPJUHSIo18jV8GE+bUd+Ehny35y/NVy3LhQ8ITMbaoey0f026XrB7f+?=
 =?us-ascii?Q?M0/j77x25X7MD+mTAnqHMpHCIC7vCZVTw9V3Ry+hLhV21iuu7bDi0TptOU9c?=
 =?us-ascii?Q?aH14jkfPpGw1unDmYAMmDRw2kntXWGjOrKyNb2f9wiJbKDvtLRefqwE078lL?=
 =?us-ascii?Q?zNUAOBioCwpaGNrPuwW53A6Kgk0XX+cDwk4nsF95SsfJJGWFw3Vv14VfeI60?=
 =?us-ascii?Q?nLAonY94l2Y0uY3FZH0MiUAZkYSqbPoPJpNC7oeuT3HtrTzBF83gKpQh8tOl?=
 =?us-ascii?Q?ILg2mvc1FM9LuRglynj6U5s2Vy2MNwZ7b2UIlrgCqRo5SSNzkIqMp2tHmiVf?=
 =?us-ascii?Q?ExzSjpAPhHK1SXTa2R2Xmuuh+9VF3FfddfGV2SqrOuOqnZjp168BanmbJbFs?=
 =?us-ascii?Q?UjJgTCW+pnBduTKiLLS3G46fRwTQVojMM8VasEYgOnsYaWwDovb+g6FV2LHz?=
 =?us-ascii?Q?Xl71oPfkl2GK3zfQmCrNLmbwEzXKVRqOd7nc3DmkYxj9QXNj8NN3P1wz1iWh?=
 =?us-ascii?Q?VFa/bJwDOXVfg142BKOjjF1FdKHaVvdiZh8BWgIH5x/DIkhdhim10Hsai3HJ?=
 =?us-ascii?Q?hIgru4s4NPaY0rjcueeI808gYMagDQHZIkRnCJ8zOYDiRCYFp6TdTLYuTrba?=
 =?us-ascii?Q?yZIV11YcK/dYBHt6QlF5lMDQBHRWdf/u1yzPt8NrIwRqyKubZw47CzsQd+l+?=
 =?us-ascii?Q?mEHpXO9dzEy+BiQ4o7lZDwRK5mAO1rS/ssfiDI9/XtlqYNFrApnSt6kwNZdy?=
 =?us-ascii?Q?+pqhnwQq78EBXNGqMijK4bo8aLHMN+zbQ1pEroX04l3fZZIZ0TdcXtpF0PuU?=
 =?us-ascii?Q?ogu0uOX+Xf9j2UHCvGz9btSLflOkFQ51?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:36:52.9778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a667d50-3dd2-40b1-ae10-08dca01c31a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656

As a follow-up to commit 0dde1c08d1b9 ("PCI: Don't reassign resources
that are already aligned"), don't reassign already aligned resources
that have requested alignment without resizing.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7953e75b9129..9f7894538334 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6553,6 +6553,9 @@ static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
 	if (size >= align)
 		return;
 
+	if (!resize && (r->start > align) && !(r->start & (align - 1)))
+		return;
+
 	/*
 	 * Increase the alignment of the resource.  There are two ways we
 	 * can do this:
-- 
2.45.2


