Return-Path: <linux-pci+bounces-10399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED89D93321B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7571F277F5
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0054E1A2C38;
	Tue, 16 Jul 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qhy2dxKB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C5B1A2C2C;
	Tue, 16 Jul 2024 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158493; cv=fail; b=lzZpltTMTGjeyPCWwBX8Rh0iaRcMvRA2EhQi2phMT0VDEfhEGINzoJqlajFTnE8f4TsSBKEq5AZlywFcSUaU0M0Jwx/uc544PFUEvVhzq+2QiJ2xrVOcXJZUpX6/ZSt/5jYAI98fuJafS9L7dc9+6PIe9RQLwpUX7gacmwdiW6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158493; c=relaxed/simple;
	bh=tTtOEb8cXv9POL+062+kiVBoIdwXF4JeZ1LRKf7o7PM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbEBZNEHlTccrnSzdmXc1Wj+TTgM4Ubee2FZ4Va3d2rKVyW+h8dHctNzmxJ8VZGbHQKpVzqZtKw5y/Yehc2Y1A/yD0dP14+p74pYK5HEaaqC7fo86Gh6NuWRSdPj4xY+0PNlIDgbBXO8O5IzY9mzYrLaG1KN97RtyEmFFaRBUck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qhy2dxKB; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr31ECiPaDTq/eHvzHhbsDyho/jImPDGHzxVOY4OCMDEdvvPmpT17ilF/wLIKWee7APsrSNZVT8j6+8k832sW+JU7vs4rtV3njKTepOlMG04zX7iFayQBlx06TJkSzswaNphHiMAlOfQeL++0C4DotkKY278rCAhUEv76W3EA7wpLE0jEw6wUuCmCFTaRXmypBfWtfO8+KxotOmdEeHb4dugMMubOW++hTEt09VPhNK2o22+jqBURn66SQTHi4uai81D3l4x26oCx3el2vfkHbiYf88c3H05G/dWIvBaKKmSMuwmUUcp2hgtLVORAw7swS/e3wx7ACZ3mZFYrGdpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4M+oA76gwrPzpOjUd6t7GrStaXH0nL5c3EVl0d7DPU=;
 b=Hh37NYTXWuAdU96i2/+NX9EMYD9OpBhOpeO1ZTsmz3wWa2nAl9XsH6gkkjpxOB8TJy+HqhGvHB9LVVdP9YE7qcW8xekh0yGUUo6Lw+B6MAJ8J1goydYiuuHXTj+x3kROwp4lKG0T9wMYMbozVO+/5DcDbK4r6fQNIF5hRixQN+7X76XCxI6RqJDZYdB5Mf7WmESLhR0aDDADNr32xrd+eNAZ/ZnSj6VCiiNJFGZ5YKgjXFcM7U0yGC9lMCeazW7LfeUwCK02ZX/xFe/yndyg6kfwwINW90YCAyZrB+t4tkA4+Px2vbUWvxQsTMbyeD9qcx5/Hb4XgqV0YzB1Tmb9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4M+oA76gwrPzpOjUd6t7GrStaXH0nL5c3EVl0d7DPU=;
 b=qhy2dxKBQNb/OMaD/mnfq/cghE0nHKnO/mLsD0Bp4e9YW9AL3r7P43AS00Hh4Io7igZqoXBJ/ajM1f72lbMj+bfGwlfLywemPaH6mddxpd9laj3Yy+UQReACwMtIQ8DvMfaBY2THJUhi9EM6yCI+6cg3R44w1OMEvWCjMkV+PdI=
Received: from MN0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::9)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 19:34:48 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::5a) by MN0P220CA0029.outlook.office365.com
 (2603:10b6:208:52e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Tue, 16 Jul 2024 19:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 19:34:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 14:34:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 14:34:47 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Jul 2024 14:34:47 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/8] PCI: Don't reassign resources that are already aligned
Date: Tue, 16 Jul 2024 15:32:37 -0400
Message-ID: <20240716193246.1909697-8-stewart.hildebrand@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 7437f49b-0eb5-4187-2c32-08dca5ce5b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fi7csOYH3y9OFigB6vciegum6LRWcq6GvMNL4nkUk7uv+AGXmxWmWzy9gGv2?=
 =?us-ascii?Q?On8IrFJMtVfn8BEK2aBy/42T/r1CRzaV38jjBxbz58cpx1JdxY06NqiqxRXY?=
 =?us-ascii?Q?0iLnWt8uI7Ra7q7esNGCQNi5yh+5YPsLlIPOibdc/sXGCo6q11Mw7qXpEd+f?=
 =?us-ascii?Q?IpOrxsfP20BEjD9gr9mRFWPFUi6suLWzt2qBsDu3TmZ5/KyjVYa8kh79IIp9?=
 =?us-ascii?Q?5wMHdKJKkER2+IIwIS9VEbpoI7J+DB4URfMyJGIusUKINUuXX8PYSCa/p3Ob?=
 =?us-ascii?Q?+huTM6KtXXJ/r8NsgjysPHcLt3CkF25ddDVCKzEkt/J0t9pwthoA1ld6Ze0t?=
 =?us-ascii?Q?jl6pnwBe6a1LRROQj2E0KURjk/cdu6YG9ZvzMnmv9I5Gqeo6jx4HH0t8zUQb?=
 =?us-ascii?Q?tu1Sskb9gmw2DeFn4Dj8vFDoRc/N90/gJvIH4LY/pVJLB+on9s6xSjxrQcTO?=
 =?us-ascii?Q?QqDiTY/oKRYS+cDirmZeRPbT4gumUTFfceOg/GV3QZTJ0GQdwGfSS3xKMQrm?=
 =?us-ascii?Q?rX9a6JmYR4X9TGLowP91NK8nuEL+bgdYG9GgoQFoeQiErWczHjpboSpzE8Qn?=
 =?us-ascii?Q?jwlEfYEC+OIUCYPZsZWGsPKeadaEVyifRv5TSgxeMzreansPkWwfqbBgkkER?=
 =?us-ascii?Q?qe3uXAwPM9uaNW3Wunl0W+etwkg8P1Lci8N+zKWNw+IxKUkqyLVvl+Z2DzCu?=
 =?us-ascii?Q?aOjVexAYN+Rng3J+iEzNyTXuu7Ei25Ifu5R5kUvOxlgF/Pfb+txA5bKYjW5b?=
 =?us-ascii?Q?3VnQTtBI/h62GEG+51cQKync1Criw9DS8ez+VdeBO9Lk7Ku6OHt76kKesY6H?=
 =?us-ascii?Q?31Tiw/nUqisvvzhOzxowBLhkR9p/A5hAK/k+fg1F8+9KLQOmEcJumIbp2ihA?=
 =?us-ascii?Q?FR5xMEYZIgvm/GiyIFTj60h7qlI5NdAcu1SQ6DAh8uQUW3c/RIAoKKL9pkRo?=
 =?us-ascii?Q?47aCW9tS6WihkFLtVv2WQd8KObhv9sFxHsoYj+kU1E09vHPixmqaL1rCCRgm?=
 =?us-ascii?Q?ODCuoSxB8Bl9i9150/K1RzxV9jFbDT2aPykHrzNZLjDZAKjP5nHhOXvJGLK3?=
 =?us-ascii?Q?T9HJUNQJXRAHdnAb4mmV5Z5rC6A1wa4f7beXVRolq6JfCralzKIC5TzspucY?=
 =?us-ascii?Q?M9gGU8Bv5JLf/9bOcwr1ARxCR3+7AyxP252SAOb41E6bTC6DKD3BIb1ZmY7f?=
 =?us-ascii?Q?9XN5W/xZFnZeCORg8N9E8ULD5PDxcK2HVuufkIwqTxmOkR6thQkCKywYShY1?=
 =?us-ascii?Q?daC7i0HrlAD5hX7em8J1q2f3mDy/bpf45bHofGNaG4TI/2E5P+ss5oAD1Hz9?=
 =?us-ascii?Q?RqbkAHwfkFjLYSEdnKeCpYETXyB8+tzcQaDlVgA8RBsxG9u/d/EkPeI1vcPf?=
 =?us-ascii?Q?sQIfUnx6HzWXNZhStcjpRSEH97dGJDo8yS2aRXO+PyRLS5kLdte848iVvlQo?=
 =?us-ascii?Q?a25ArPPq+hrgqRbbqoajRwdlozoV0Tf+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:34:48.8619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7437f49b-0eb5-4187-2c32-08dca5ce5b10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360

As a follow-up to commit 0dde1c08d1b9 ("PCI: Don't reassign resources
that are already aligned"), don't reassign already aligned resources
that have requested alignment without resizing.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
v1->v2:
* capitalize subject text
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1ac1435ad91e..6df318beff37 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6585,6 +6585,9 @@ static bool pci_request_resource_alignment(struct pci_dev *dev, int bar,
 	if (size >= align)
 		return false;
 
+	if (!resize && (r->start > align) && !(r->start & (align - 1)))
+		return false;
+
 	/*
 	 * Increase the alignment of the resource.  There are two ways we
 	 * can do this:
-- 
2.45.2


