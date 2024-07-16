Return-Path: <linux-pci+bounces-10394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3A93320E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071081F26564
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 19:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4D21A00DF;
	Tue, 16 Jul 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aOhpZR9R"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135421A08DD;
	Tue, 16 Jul 2024 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158452; cv=fail; b=OUObYwfdPadZGBiC80wUefVvSWK3w91r6XDuo9zPR2FW1PA7tTXwM3U2bTznxYC89A46HwBkfKJ4Uy69vy8B8ngFNomEHuz5OGVRcNUpXE/h0IrUdwCYoa0M0f/oZRCv5h8QlSWNr4n7mLVU5DR7eFQcih5S70gCg1qQSStPCoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158452; c=relaxed/simple;
	bh=jBxqkgUUg3CLWL/ZnH438VPSunk47YkCwi7mNQLsJOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qx0iQ89kbSg+8h3nnBcIQhGncuzc9Xdx3/HHkfeJ/vvTu5qXuO3H0MMdClLMGjxYGzdGZI4LSvSTrEGlpgf2mIOGwyFh2MbIcYzctJQv/KKbg7hJlB+vc1oZIZi8AiVO0DEju5HSDmCA0sytxLFiJ0MoUPF6u4jZlUahzQ+e9Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aOhpZR9R; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9gqcHRueyJZ4qMMrVnEjGORPUPbyYjsKDjWUE/1t3tnyGiCs5GL3v2mlWJY0j9qXiS4XXQZjrEBK2AHywQE5JsoVrgbIaJIJLwvJ4BugIJ8uQ4CSORQPEzFA4RpyduwaGSulHt8RF/DfWaWwub4VCnnz17gwblMXhrhGBMcMNYyw6h5A62b3FtziMoX88cztO4msA/ALihRrK38sbYcDhaWbMdu95PmoJfNTQoz9ER0ObGyfxQFLmupAmQn+pzGW/XrRdj0ekOva16/Qa8vjB8uKGrMag5INBkGixLC378v/XzJrgaTzGZcUtg7FY/RgiwmHsyNfZDepxOO5n3oxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV6AgoX+2VJnMijFVErsOVX4oZTzkgip+oxsSrgRtlA=;
 b=NpnEucP802FohzH9QFgD7SvGHITtJzBtrdp7c/lqfgmZXriHNByA0ffN/wTvnZ/2zuKvweBkeHQhOwZFkL/NgPjYHOW0eJ0E7YwE8L1ZjWu7qSBYE95MohjE7teyuvXMoAT6CUhqKDH4npxJFVA8reGroGWXiFfsjUrEYW8cVwFT4iX9V0n9TR1QOT4A7gE7gfKj5pWnivYuMscG1bzgPccQYw0epQg72Z6auy8VKJSo9jAUjC2dOecEl6tn+s+E7R4d6z+VH1QL0InxDtvubxV6Rh2a7CbNPkBAXCe8JolYgtt2rsltrGHWoGW//PMre0eiemmZItjGJCxrwWRHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV6AgoX+2VJnMijFVErsOVX4oZTzkgip+oxsSrgRtlA=;
 b=aOhpZR9R5gs1CzzMWZwLbSnmsLftahvvVzyTroyWDTIMwkUj7R3M+wD4wSnBUHF8EPzPMvvQHqp9I9/mfWK4tMKTjSycFVpQf5hKIWI37NgDDc+NXTGIg0gtrdq11CL4024zHaYXJRAWLuj+9bPm/9aZTqGMQuY/ZmUmJX8cXlU=
Received: from PH7P221CA0081.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::33)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 19:34:07 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::9d) by PH7P221CA0081.outlook.office365.com
 (2603:10b6:510:328::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Tue, 16 Jul 2024 19:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 19:34:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 14:34:06 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Jul 2024 14:34:05 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/8] PCI: Don't unnecessarily disable memory decoding
Date: Tue, 16 Jul 2024 15:32:32 -0400
Message-ID: <20240716193246.1909697-3-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716193246.1909697-1-stewart.hildebrand@amd.com>
References: <20240716193246.1909697-1-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0df364-e446-4037-cff2-08dca5ce41ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OeihamMmB9YvLqw6Ljgk2lX6GA0jxbbYMP+qnHXxvwEbPPZwxDaDIXpzyRNJ?=
 =?us-ascii?Q?trIGLMWGWp4CLxIqoUvfjRxk+pUdLWLpD8FZ9yYtZoSzrP2aygrber1GyiAb?=
 =?us-ascii?Q?K0GBtHh2S0lmSRVyqe3Lkbp4AS8eHqXxwLd0gjNGhHmHI6+bU74Ydud5Haz6?=
 =?us-ascii?Q?gCzgXrL6kYWz/ELt4OV9HJ+xcgEfucqCW1wxCni+Uhf3zpK0i1LW1V+i2dJ2?=
 =?us-ascii?Q?YvRmlCpb+BMVpqKexAs2FxgZaab64WkIMHjnS/lBku3z1iDLNdm0Jo/9nr5y?=
 =?us-ascii?Q?R/DikbhX71CsvNANaei+yWQuXv8qLkvvTRhRaxNUsTCQ4oLOJ2cqcg13eslg?=
 =?us-ascii?Q?4HLYhARmHM7ygfg9fshKzT5JaH/6i3aOhEynT/q3VCGyxjxHFi6mbDrezv0F?=
 =?us-ascii?Q?vwuAdHsFxIMBG0XkWz0agJ4GNV/cvyv0Q/rXfoN4nWUDHsdZxDtvAa71+riW?=
 =?us-ascii?Q?kzcXy2BzbLJrjahvlFjyHUukBdLYeqToHYyweFv/LppVvJqnMY9kFVxjeoLm?=
 =?us-ascii?Q?ezJnNR2U3mU3AlEZtR+ljqNd2xJuua+YNEPmt8S19mCM7mNRT01f5hxYNHyz?=
 =?us-ascii?Q?CyoaJTMBiYTIANN3P3KQAWyishOWE61OgMHpGeTE+FL/DrF7kyjJXI8oBWiD?=
 =?us-ascii?Q?ZUyhakKgmr/R/EuLb1//cYLmg/VN1q7q6HklLih4kx0tM26tH38CJEY5XWIU?=
 =?us-ascii?Q?SqzoxmTwUr6R3oqtL5cH0oSZNHabjQEp7oh5bcouTdRwLyN8PdIIpj73jje3?=
 =?us-ascii?Q?j/m2Hm4akSgv8tQUbaPQKqYPbPwM/qZgobXAjn0Ei6K2pbBtAQjjCsWbRQmc?=
 =?us-ascii?Q?Qkk4zakaqS54843/zjaBu2D4W48F4Yd5A9E7Qhzn7QBwYygFRTUBo3WAkNRK?=
 =?us-ascii?Q?mxBoy6hremKkdEoBULYPJ3MAaYhhQLEtM2SvqACLO2NYNwlL460P9gze163e?=
 =?us-ascii?Q?BCROkBZIafkMetPIRNhNXjKuQf8ArK4W0Yj+n1H+BQMDYElk723cEeFCwRkX?=
 =?us-ascii?Q?vMlxN2RBpbRR6wGEc+0FcG+ojQDhyL0zJRLhX5SbxrakwrZkCOhqsllYVZvG?=
 =?us-ascii?Q?/HHVbsscXZfQdP4RCZ2Tpvykw3mnVPBErAUo2TwY8iCJZNOzSEGZIyA4ward?=
 =?us-ascii?Q?ELK+y3ip6BfZd0Vsv4QE5ir1MAF60E7HU0RNUOe1ey9aoBHBWvOostGUr3VI?=
 =?us-ascii?Q?jQhR7BUjsG7Z6Q3VqlkIdyx6WFfsDHjI9zhGlHpqu1Qt32/pKrf5ZOof6TKt?=
 =?us-ascii?Q?ElG8TlkHo3BYKzfBV4QVDBo+z1Sh6pT6SF+NlGxNbyG0X04axmkIzTVuS/Ke?=
 =?us-ascii?Q?jBUlS0GtgebV1+W+dOM/dCxgBjhlgfJ2mEmECFUizqCds1zH4LiEJquVAeiv?=
 =?us-ascii?Q?OaVYTbBNCNIqGQ3eAl0ADffag91tl4Yz3nGoohVEFqkP5L/dyFHgYuxdRYlo?=
 =?us-ascii?Q?1uhkDM1Xh3bq+N3qREOKMnJiWa2pb9Ke?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:34:06.7647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0df364-e446-4037-cff2-08dca5ce41ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441

If alignment is requested for a device and all the BARs are already
sufficiently aligned, there is no need to disable memory decoding for
the device. Add a check for this scenario to save a PCI config space
access.

Also, there is no need to disable memory decoding if already disabled,
since the bit in question (PCI_COMMAND_MEMORY) is a RW bit. Make the
write conditional to save a PCI config space access.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
v1->v2:
* new subject (was: "PCI: don't clear already cleared bit")
* don't disable memory decoding if alignment is not needed
---
 drivers/pci/pci.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 02b1d81b1419..53345dc596b5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6565,7 +6565,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 	return align;
 }
 
-static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
+static bool pci_request_resource_alignment(struct pci_dev *dev, int bar,
 					   resource_size_t align, bool resize)
 {
 	struct resource *r = &dev->resource[bar];
@@ -6573,17 +6573,17 @@ static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
 	resource_size_t size;
 
 	if (!(r->flags & IORESOURCE_MEM))
-		return;
+		return false;
 
 	if (r->flags & IORESOURCE_PCI_FIXED) {
 		pci_info(dev, "%s %pR: ignoring requested alignment %#llx\n",
 			 r_name, r, (unsigned long long)align);
-		return;
+		return false;
 	}
 
 	size = resource_size(r);
 	if (size >= align)
-		return;
+		return false;
 
 	/*
 	 * Increase the alignment of the resource.  There are two ways we
@@ -6626,6 +6626,8 @@ static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
 		r->end = r->start + size - 1;
 	}
 	r->flags |= IORESOURCE_UNSET;
+
+	return true;
 }
 
 /*
@@ -6641,7 +6643,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	struct resource *r;
 	resource_size_t align;
 	u16 command;
-	bool resize = false;
+	bool resize = false, align_needed = false;
 
 	/*
 	 * VF BARs are read-only zero according to SR-IOV spec r1.1, sec
@@ -6663,12 +6665,21 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		return;
 	}
 
-	pci_read_config_word(dev, PCI_COMMAND, &command);
-	command &= ~PCI_COMMAND_MEMORY;
-	pci_write_config_word(dev, PCI_COMMAND, command);
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+		bool ret;
 
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++)
-		pci_request_resource_alignment(dev, i, align, resize);
+		ret = pci_request_resource_alignment(dev, i, align, resize);
+		align_needed = align_needed || ret;
+	}
+
+	if (!align_needed)
+		return;
+
+	pci_read_config_word(dev, PCI_COMMAND, &command);
+	if (command & PCI_COMMAND_MEMORY) {
+		command &= ~PCI_COMMAND_MEMORY;
+		pci_write_config_word(dev, PCI_COMMAND, command);
+	}
 
 	/*
 	 * Need to disable bridge's resource window,
-- 
2.45.2


