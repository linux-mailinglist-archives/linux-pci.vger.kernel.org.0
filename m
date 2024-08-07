Return-Path: <linux-pci+bounces-11440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A30394AC99
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 17:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2711F2116B
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B947D3E4;
	Wed,  7 Aug 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TTo1IeTE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FFA81AB1;
	Wed,  7 Aug 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043860; cv=fail; b=jKyrrGjMybJqOCf85E4HvGdKX2nEmta9Q9Ktb7Rz/GQqOO0hJmRY5P1aZ7ZcWc54LM7InDtFOY+8Cd1oVaZYtQ29nLk65hq3d3m3FuM2wqGLItqEl0glOZKmENBn66TZaEZB4/u4MvrWr2cGcUkDmW5JnJ/nGpcAqaXb6Q0IARQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043860; c=relaxed/simple;
	bh=+Utb6ygez7N3eokQoG0VzinLCHeAIn9IfllSEnROM+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbGVfZ/Sbf4BegROdPCXjoF/2IUAgc4/KEaHvBwrOHChz/ULioX+aEgV4XeEz60BJF5R/JrZdW2WLVK2qBXG0f1b5Eky38J81XwgsS8ckVY26H0qKWCcVqeZgFDEszxF8jvb0KuhJB9xMs8+V6iF6kJE9VAXLf8uSm/6sbnyxlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TTo1IeTE; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EC0s9wWoKVbEe4b3TAmkUHeLhflIsEv2FHgXC6Oo3Og/bVjCLy0JUVu5J3U7YkxoXbIcQqbhqwJTPIRhvRS2BS7vQcbbti9XSOmkBwQ3XLGUN9JR0hiA4VYmU4IC2kuZc0Ryl1X4YVoI5tgwwG8yvX6vqLFe6q7ipilqLAzqWl+aJZNuFanJ2iJa9D24KlKnStvRgjDmPQgZB7zcFKYDdT6RC8EvDjo+FOuzhBiLeprYI+dcK4yeckVzRXkGLoFy6pW8EfFx4Ea3OWVmpAhsYkw/COnKAbXJ4ZNfusv/x+KvnwVrHMiv9pflzSUq35Ros34Z5Pf6sn/KEe7gVNShCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2BNuvrw/Hf36Uoxdd8ol6I3JLai8YB29pRt116znio=;
 b=wYm4bpqjjpdAE+6ZWh9/C9owEw1JoHM24bhiU/OsQdDzSkHThmCQQN5RoIrdeymDE46dfbuDbcdZUEaCuV2/Kv3F0MQ+M1w9j/mpCj+cQrDOTsm907fB752VlznZW+2Edys5ipcKYqY3UBYq4gYg2Ycrk225wOjXRQMw4BBSyeDee66EzF+fDmbwpsVLOMQ+rJlRVIcWrcdMW0mixmgqeErthAFhTk/om/YqdZwBXtgJRO2ROmT8OWCT3li25N3fUR8FLjpM9ofnw9XTImWY8/O9Ach65gazGEi5BUu2BFVlizi1FprSEGAGIOGOFETjVL7xi2idM+wuiswnDaubHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2BNuvrw/Hf36Uoxdd8ol6I3JLai8YB29pRt116znio=;
 b=TTo1IeTE9cCeTXMgMKkFOmY0Of18nQ6HNyfRVVEqy9oltWPcTK6arBNuuyhWDC4wWILah2CTjgVSrQMxCVGbITrza02pgWgPURPljIuQUI3Gebbt9s/HeeL95cbHu8a6tTXDabJFGbv73WAf6oMrujeEpXaWcF4xWzQmWNYGQNM=
Received: from DM6PR02CA0162.namprd02.prod.outlook.com (2603:10b6:5:332::29)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Wed, 7 Aug
 2024 15:17:35 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:332:cafe::fd) by DM6PR02CA0162.outlook.office365.com
 (2603:10b6:5:332::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12 via Frontend
 Transport; Wed, 7 Aug 2024 15:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 15:17:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 10:17:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 10:17:34 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 10:17:32 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Philipp
 Stanner" <pstanner@redhat.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>, <x86@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/8] x86/PCI: Improve code readability
Date: Wed, 7 Aug 2024 11:17:10 -0400
Message-ID: <20240807151723.613742-2-stewart.hildebrand@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f95031e-be91-4d80-a35a-08dcb6f41119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?23ZMbs6FFzQ5hX0DTMbhPoWQ7whMcmb7nnGX/k0YwjDzadDQTV/NpaTpSIz7?=
 =?us-ascii?Q?qKoLYxtapCNPA8DeTkK5PRLxqLbzj7WPjoaYzgdyQrl1GgsVLTfZLhQ+bPta?=
 =?us-ascii?Q?8yKjClSpvuJmlNZ+emEG1Br2OTm1uN3D2Op7lg2th1fIW9Yo/w2uObwYy4wI?=
 =?us-ascii?Q?p97WrJ8TC4m6BGdwcH9VAyUzhDBFIuQVycmlNTsPjTkA0EDIUZNnhxuYRRNF?=
 =?us-ascii?Q?B96CHe70w7GsKTj6fyvSIBHsm1KBExYhTqVWQI/dnH7wnPvHyY3lIk9Wid7j?=
 =?us-ascii?Q?tC75iaCbCZYUWzaUuuM3q3NabisXNN2WFvC6/Qnm1HyWKRCfFCXcjDHhrYll?=
 =?us-ascii?Q?7HNlfM2j1TdMtwTmdqljvZLSzB6l8TZFnzS4rDOejL9FaDnW7IyCxh/aUQIv?=
 =?us-ascii?Q?fhV9bnCxf5ODlqzQtE6StgnpmdhTED9psQ0d6QPDoQi+mn6UzbiF51oP/o7+?=
 =?us-ascii?Q?kWCgtd0HQuQtYH/ZYBn68d4W3Vo+P6UoD8HopkjQEVBxP3AAhg0WRtbxY2hg?=
 =?us-ascii?Q?XCNNAG1cmBIEvouvT7TUZ6pbA9iT7jwip1W+ePoB8CWAPGRdd+UnPMSEUbD7?=
 =?us-ascii?Q?px8EA4N7wOZn2ZiHNygHC6t7wEAcTnu8ehXoLpporV+CXB9KzgqI/okng6Eu?=
 =?us-ascii?Q?itpjBSzL4o8N+ZYNeHtj0xWxrFJLrqZ2U2SJKpftnmuRD5c/SfadWcD+HMau?=
 =?us-ascii?Q?U14zPcUh4wZZM8pLBQj7x04y89uzAddxAMGUPN3mdqLYRMATuU4SmDLZjAPf?=
 =?us-ascii?Q?RjUDH/298JZHTFF89wJcN4Q/EPIF/hrcXuRap2Hw8hWcUinxFZbjQtdsw+gf?=
 =?us-ascii?Q?6kjAQOlafJVS1n+NW3icNhNZtWSRR1ae12q4Fypb9SP1ADh0oMt4nviOU8/N?=
 =?us-ascii?Q?1q/BVHCXi00M5fDqVc7i5InK4ZXsa79ORxz6d66A203e7V+F8Z82vstWg/HR?=
 =?us-ascii?Q?1IEkk+l2pvnkAVntcA7DLZVZ4BrG/lfqZd/JxrG/zpORvOecq/tdN33ozjbc?=
 =?us-ascii?Q?jXYFX+zI/aBGY+9z0P/r8NaNEGxEqcEmVHubsj1aAJjt/kZScOozP5A7DLE2?=
 =?us-ascii?Q?59+a5JutzTSEDS2Cr2VWTbYtbROWqnoMX8j6QDmjNTn9bpq3wWNxIG0soF7p?=
 =?us-ascii?Q?eMgn3YI2gyKgGnJXoM5a9FDCAPNiY3y7rz3lbxIFrWP1KKs7jYPWu10W0Y7n?=
 =?us-ascii?Q?enE/Pdg+Lyt96aFEB0ovIKboPm/hkqvyw5BoVR410hK0Dh7DyIheijJcqKDE?=
 =?us-ascii?Q?9K8YxeQo7lByiVSmU7kKxDQKzvEpcuJZhsgiJLfLlPQCr/LVZFH/Lc3eYSgu?=
 =?us-ascii?Q?1Aqz/T8lc7T1nrzWJ8wMPYkfyxWrHzyoGC7UcCIhVo32G9d7iihDmG6iAiPw?=
 =?us-ascii?Q?eGR/Hpu5vL9qbwXTWJUxWh17SPfo54x6SBF/0WOQamc5Gh7YoubIiWEjXfcT?=
 =?us-ascii?Q?G2OBLhuPdMZ8JCh1UY/ObjWTk/QJy1gH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 15:17:35.3842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f95031e-be91-4d80-a35a-08dcb6f41119
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076

The indentation in pcibios_allocate_dev_resources() is unusually deep.
Improve that by moving some of its code to a new function,
alloc_resource().

Take the opportunity to remove redundant information from dev_dbg().

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
v2->v3:
* new subject (was: "x86/PCI: Move some logic to new function")
* reword commit message (thanks Philipp)

v1->v2:
* new patch
---
 arch/x86/pci/i386.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index f2f4a5d50b27..3abd55902dbc 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -246,6 +246,25 @@ struct pci_check_idx_range {
 	int end;
 };
 
+static void alloc_resource(struct pci_dev *dev, int idx, int pass)
+{
+	struct resource *r = &dev->resource[idx];
+
+	dev_dbg(&dev->dev, "BAR %d: reserving %pr (p=%d)\n", idx, r, pass);
+
+	if (pci_claim_resource(dev, idx) < 0) {
+		if (r->flags & IORESOURCE_PCI_FIXED) {
+			dev_info(&dev->dev, "BAR %d %pR is immovable\n",
+				 idx, r);
+		} else {
+			/* We'll assign a new address later */
+			pcibios_save_fw_addr(dev, idx, r->start);
+			r->end -= r->start;
+			r->start = 0;
+		}
+	}
+}
+
 static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
 {
 	int idx, disabled, i;
@@ -271,23 +290,8 @@ static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
 				disabled = !(command & PCI_COMMAND_IO);
 			else
 				disabled = !(command & PCI_COMMAND_MEMORY);
-			if (pass == disabled) {
-				dev_dbg(&dev->dev,
-					"BAR %d: reserving %pr (d=%d, p=%d)\n",
-					idx, r, disabled, pass);
-				if (pci_claim_resource(dev, idx) < 0) {
-					if (r->flags & IORESOURCE_PCI_FIXED) {
-						dev_info(&dev->dev, "BAR %d %pR is immovable\n",
-							 idx, r);
-					} else {
-						/* We'll assign a new address later */
-						pcibios_save_fw_addr(dev,
-								idx, r->start);
-						r->end -= r->start;
-						r->start = 0;
-					}
-				}
-			}
+			if (pass == disabled)
+				alloc_resource(dev, idx, pass);
 		}
 	if (!pass) {
 		r = &dev->resource[PCI_ROM_RESOURCE];
-- 
2.46.0


