Return-Path: <linux-pci+bounces-6103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC68A0721
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 06:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF73E1F235F3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 04:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A3113BAFA;
	Thu, 11 Apr 2024 04:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AkkI0yaz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A840113B78E
	for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2024 04:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712809741; cv=fail; b=q2Jpoz19tljAYJ5jtP+JQmVsrqxiHDZxFd5G3PJC9u1+vIjWBsCEBEnYuKOv/msDFdAeAiiAkXLCJLQVmx04ipEM+Xdabwo3iV3EtfoLsEllhW+yijDZN1VlmpfBbfAhB9ye69g71UqiIQY8v/0H31ZAcj7bCrdCHhoJ+YoFOYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712809741; c=relaxed/simple;
	bh=oz1UPOUlChDCDsblMifspUB98+11Jw8WpfL1uhGuZdE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nVOFHBmWkDXUm1A1CK8JAPU4JYnFNTVLvzCptD1hxbD1KA2Vr9EVQvUlLz/ZY5G+YRaWd+YJkwlLemL8kfR1+1k9CBE9Lmkyd5inlNEF/WFkmsffJiGk4f9ftYk9IsthGvZVZ9wJqVD4ex4BaQxkpXxtoh02JLoaA0b50JwxAUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AkkI0yaz; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSv5GvlSgkPSEOmdIb/fiMAmNwpkpV404aZKD+bCG5MSpSQdXclsbk/U+y/X9vF2yhQIm5jk0UWtVYW2K2ruH1bEL1ak/kOK069mGZJ+sSNVHNfFWLaWTQJtPEMmu92+uBUeWvXINFdUGcr0QsRjXPGTB6AxDtTecdDYxPagdHko9SKgWOKqmYk5RyFIIoIyA4ZO3u+uLqvRvtzBNbv1JOnl4GQUPivC20on/QwBffVEn8XXb6L8f712WQtkiP5NFbM/UcmCFvaTPG+DUdH2CgP9QQrXzx0RC616mQdIi6UjTehC+QWOapE9uZFxewNR+NtLI855Ybsz72t9LvGwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0gKrG7nN0G1LTqcJG/rqjLykoDlOenNHBMxA8oiSJQ=;
 b=Rua9sD2D3NFhPNdzdYSX+iyeTo+Rb1yGrFKJDW0AnedQIlJ1Y3IZR5f1EUTk2PM1HuPhGzFlLKfCY0aqTepnyK4zLg+jEp7QZYFxxMQ4lMPrPQwX3iAfF7tu0Kk2VEkkUFcTWzUT86olIXBLrzxSg4+vcV0g2oSNxQEanmYupYFVJnVEuV2UBv+S2kAt4MeSEDTK2K7uoBeX6mR6BXzANLaRk7NWDlf5LW5b36UI0uoV/VuAUpAwR8o7qVRHjs+cAC7AZ2vv+8zNUDxwlkIr4svqU7aFDFysXDVOym66ziGG+QslUZxE1omhU0AXXIaKMiezEULTEbEZEV//mV3dlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0gKrG7nN0G1LTqcJG/rqjLykoDlOenNHBMxA8oiSJQ=;
 b=AkkI0yazMdXH6UZQd1pMlXyUn135tsR1iz+vvMBNBD3qAotshMxqIFJLdSoa3aDdSm5ASoNc4TrpYQmLAV5xUOincN3EZ7T0QWAhWF0zBb2IxHL0CnErZwcGeApTVTYGOjavB0ffPOaW9kuXJkxquNVeOXlEq4eMOFh1oEH/YnQ=
Received: from MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::28)
 by LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 04:28:57 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::88) by MW4P221CA0023.outlook.office365.com
 (2603:10b6:303:8b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Thu, 11 Apr 2024 04:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7495.0 via Frontend Transport; Thu, 11 Apr 2024 04:28:56 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 23:28:54 -0500
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>, Alexey Kardashevskiy
	<aik@amd.com>
Subject: [PATCH pciutils] ls-ecaps: Correct IDE link state reporting
Date: Thu, 11 Apr 2024 14:28:44 +1000
Message-ID: <20240411042844.2241434-1-aik@amd.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|LV8PR12MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b71544-f68d-4c7a-b66a-08dc59dfe6d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LSgFpIL6hZByrAdfJ+gdWDcr0YYec95yiyhKLhk/tFnpRlNGdOdurf39wRVLUeGZu3+gJBZbfosYU0ilxg6RTxFv/7QnQg2JzhnddRmcCbIMrnNtHq/hPdwXe/QprPvp7QFYc6BCYDVi3feJ4goVRNUITaB23inIdnBYwfz0haBnXI0Bu7KnAR2kQ5H2heuLE3AVuNUBpnz4QkFax9swj+UbquPRwNDwsaWjf6e8/nCn43EDQcKyQpZByw81zbSDlPLcYFwGF4s8ltCviEVH6OgC/RnIcIES2lZcrN4MhvZ58olhn4PQ/tub9H9CIS1NS3lYi5H0VYGxWsWK8AIhfc97qSpJnsQTnnp2BNuxNBsCx0rDHXg6GEGyB/RoTaevFCyWoR+lW2M9uA1MqrvC7lSugJ/w7X2r6pfdrrKBmcGmuy5q3uBroUhJcEMMKHCPYSXIGgznBU95QRATkhnTDHEvSpOorLmSWKvHFrg9ijpxH+uViy3WSNVG9PXg4mS1cmV6gZ7cm/ahYQGly4ukHAZNmv8iBpv/zZRkFTbPGRhRG0lhe3gxfcihT9oZCXlEahbFpwlT0s1pX9DKK/+mNXcUU5h9FhRvlsOo2/ZUmgFxVIBb78NzKF46OKQhzn9PX/b84K5Gi8ENbWoyDtNJgjx29MAyvuR52XibA67E/0mkfNh3lEmogVZOW4kLoMgnv9oDoY6OGoACi0ZWSWOFidT/JYzqx2p09i3Z5VLvBvBFK8X/Maw8AQuSEQYE7sIC
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 04:28:56.3065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b71544-f68d-4c7a-b66a-08dc59dfe6d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184

PCIe r6.0, sec 7.9.26.4.2 "Link IDE Stream Status Register defines"
the link state as:

0000b Insecure
0010b Secure

The same definition applies to selective streams as well.
The existing code wrongly assumes "secure" is 0001b, fix that for both
link and selective streams.

Fixes: 42fc4263ec0e ("ls-ecaps: Add decode support for IDE Extended Capability")
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 ls-ecaps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ls-ecaps.c b/ls-ecaps.c
index b40ba72..5c2724e 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -1512,7 +1512,7 @@ static void
 cap_ide(struct device *d, int where)
 {
     const char *hdr_enc_mode[] = { "no", "17:2", "25:2", "33:2", "41:2" };
-    const char *stream_state[] = { "insecure", "secure" };
+    const char *stream_state[] = { "insecure", "reserved", "secure" };
     const char *aggr[] = { "-", "=2", "=4", "=8" };
     u32 l, l2, linknum = 0, selnum = 0, addrnum, off, i, j;
     char buf1[16], buf2[16], offs[16];
-- 
2.41.0


