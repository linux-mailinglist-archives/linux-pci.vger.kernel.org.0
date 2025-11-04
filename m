Return-Path: <linux-pci+bounces-40239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B71C3237E
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E48734AEB6
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621D033B6FC;
	Tue,  4 Nov 2025 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ue+C0/Jk"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C933B947;
	Tue,  4 Nov 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275874; cv=fail; b=vC8DGaET0abZ/QQ1R2tcJWUOsWdq0d8w81dwVpzkQ8pGekZifI9bkcDkJvXShEsNHGud8uboXxN74fe2DsxFLzZJzGmnjzK7XW5jL2M3hXIy8iUNVDTCtCHvltygGWezlqngq3XpTni1yhn5XEfuJGkcSf3ESUpFqHdCHeL5sY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275874; c=relaxed/simple;
	bh=2w+yOD1BhVZNwwD+wm5q+m2cEvyA/WSNZXFso16XNHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJfy5ai0BWLXd94E0etNkXMSBUuCfQNpgTQADj1EqI6e6nDfQJ8Ip0xwspOdOPqBVvlUSBTVx/OcO5oPeWmcUvAXIM1nCJNgLrJPphgEePQ3uBpoZL/o7pIlLOYvkTWA9s4to/24dr042TAesTGMgg4muddBYCUki2Ah1IZ4J6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ue+C0/Jk; arc=fail smtp.client-ip=40.93.198.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5BTsnIoBxl2v9PPgotGmDIdFOetqp2jvUtuG9Bn8VZcLp4veMDkTrbWH9/uyYxbu+x04tdmQia2SXyv4YOaUno4RYoddqfY+Io3jkmMaIJc9+cVum/LpWIXuwMa21+tRwdIcHzYAmzESyQWwizws5QNrHguSE3BYszk0XEEWFdYaxlOJCnsEn4U98OdOrYeOiJVHeTixqKbw7HGWFEH41yefCp9HC3zZkL3p9LBEjVUA3cp0CMoOLnWOABfaCSmjJzdeuGT/HLP/kPsxpBaSMfGeFb5ChDHM9MBuMhUtdWHJYxFT8SY75Zg4Fc+3ZVzdDS8IIub3jBSWtaQ+q+xww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS55YpMLGYOIbaZaGRLUZsL0mpY7hKYfiLkNbAKgy1Y=;
 b=gjQbGInWUEBkpT1l1jiDFQA3WWj7VPV4hzVNhG4j9utpaxV4grS5GBqMFQMsg8SIjGVr+nw7aw1+QvpCvqsH+iwxtOWFCs8H8jiUoT13yxa9S7GjmkE7Nk+JspRCZXpNxvZC05h9HOg6vtpEH9xE77XVx2j3SHaQffMxTJy1Fn2y/WolLmRbhrwV5ZBvoZkI06uqFF5U4GotSqvi4Y5kFNAiZwyBbOT64c/B2ilksf2yYA0sORRaWEMRHP/YjFCdv26LLeIWMrbf6R1bRSpzeuGIVZTm+ylh+Z7i74DAqtB+OXgVZp3jf9s1Mfs9pmg1BDRYx4lJ1eXDAf1KImDywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pS55YpMLGYOIbaZaGRLUZsL0mpY7hKYfiLkNbAKgy1Y=;
 b=Ue+C0/JkDTuafou+KBQCFDx+WphJYfNwCOU8AACZlJjBjPmvHunHBQXtrpQyoLmohWkeTc44qLsDJKaOYaNzCSgR8Tb11ZRspYa30SiLiRSisSQOrHNSwGuK22IF4y05iC7To2wewtLWiTz9AX5g7LnFjBjP6Nx47NB4ab14ibQ=
Received: from BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::26)
 by SA1PR12MB999107.namprd12.prod.outlook.com (2603:10b6:806:4a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 17:04:30 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::c2) by BLAP220CA0021.outlook.office365.com
 (2603:10b6:208:32c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:04:30 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:04:29 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [RESEND v13 07/25] CXL/AER: Replace device_lock() in cxl_rch_handle_error_iter() with guard() lock
Date: Tue, 4 Nov 2025 11:02:47 -0600
Message-ID: <20251104170305.4163840-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SA1PR12MB999107:EE_
X-MS-Office365-Filtering-Correlation-Id: bcefeca3-8294-4003-c860-08de1bc43856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GWxNNVk1KTP2Ls3kz3o8xEKrZsk3YwL7HEF2UhTV50CAqAJP7US7o5TLzkZC?=
 =?us-ascii?Q?FDhNK70x9w6qhQfqYnSI2hiLyXusFqXkT+NJEsj6zKs2ShE6AcYKmZYTpSPr?=
 =?us-ascii?Q?E+o2TBlvaOcUEmrN93zXkbDcCrzRlgUZX3GeDYGLXa/kSpBzsqbyzc5k3e0T?=
 =?us-ascii?Q?mROFyWfzqasKF0AiXVL8N+RIgwXrKUc3WutQq+7ACNJIbPPbi43a8nHzjVBM?=
 =?us-ascii?Q?fUrjAH2DUO7uJE+qmno6q0Nx3d3ut1UXYvTmH4ETI+Ijq/MT+ZXCG7V6JxbE?=
 =?us-ascii?Q?qtTCb9BvRdeoQRwV91bfgycK1IlfqeKwXbmOdzL3s++XTl30WCgSAyTfyAg2?=
 =?us-ascii?Q?ART0oAmmbCt1haYpEfXe8jabgbLn1zQRs/ItRjDocwwsWRbl7cWAZD/1zJQ6?=
 =?us-ascii?Q?Kj+JByNnkQ/+ff3nRcPFVFAhji3YLfDRBRPGnudOG02aJnYnaE/AyfbmwmnH?=
 =?us-ascii?Q?FEB+g7TZkkPLp4KMUggYRUbj8orDeHDNOIWLpEHVYqOiHsbyYnZY9M2+YeJx?=
 =?us-ascii?Q?oGgkRs8HkpR42pbCxJZxiqZBWcQkmY3UyxLyvls111I1nL6mWsC8hamoPvbq?=
 =?us-ascii?Q?ZxncG/bO542HDQs5Mw7qeLrUTLpZCOo52sBqsfkOaaG0oFNprWFeBlu8FRLC?=
 =?us-ascii?Q?Dc1jSaki3zc1eTDFjqc4gd8vRMClmIvNfZZF0skVovGqk72RD/0E5Muwr6rp?=
 =?us-ascii?Q?vAADtnjTzCFYHHgkRNJvbQS6sdaVMWNEv3szYvy4RNipb4lJiyhry+n57/Rj?=
 =?us-ascii?Q?LkyXbcNkOmR+DBw2mxrGX6Cv6wO4S1T7ojuwOVo5m3VToRdwE15M3Wq79WjM?=
 =?us-ascii?Q?Wc1AKc6OeVemLXJB7Bn3LouZm6pEcgDaMlwdG+Higii8cuocQcnQpWWpd8ZA?=
 =?us-ascii?Q?OfPpW7/3WZp4P7xSxzESw8vbS15EPqtxLxEEacQw2y8A0b9MXr6tCAfB+zXB?=
 =?us-ascii?Q?lnURT5ziVQ1PbvrC4KdVhIhW8xSHnYOtCTAqFgQ1w+pCr9f4sUFb2djh5QHt?=
 =?us-ascii?Q?93sKQVxWwyGVbyo1wkls+EnI6izT0MtZvx21z5RhO8I6L+4pQDNZSleSij6q?=
 =?us-ascii?Q?x9kgzb+1VzBf7qFsN9rGwSfogr2SSBfiu5UzpgMwYUkDGEO/3s//yvo7Cz0l?=
 =?us-ascii?Q?uKGdmE0uS5D+2bEhq1EZLZedgBXpWeN3wsSrpfyUKxsgsWvh7UDxofkIoayC?=
 =?us-ascii?Q?bxf4lWreKIfOJPTxu6ji8X6pGTT6zRbszhFrT0yZhcSk0SlYnuin3gyJjm+c?=
 =?us-ascii?Q?cSSxCvOuwPDA5BsL3rxPCI76zr4HoptMd3pJ3+pKFVV2Q2rvMiOKRQTlE268?=
 =?us-ascii?Q?fRxh+YDe19CXIr0rM3JySqZT6rx+dRhgABL92eAeJqdbiE3zj0ElGjlM6I7v?=
 =?us-ascii?Q?eOhBXMqIv+1DC86UWDkt5BalA3kAbdJfTv35FuvWyhDiUU0tiWudxk9jRn+1?=
 =?us-ascii?Q?TA9HvQKELqONmEr06BOgWrRQE6tX1UmqfNA4/WPfGUaAgCNVrwY7Zc3dHLEy?=
 =?us-ascii?Q?/tTvqJy7MLlRKvEjQ9/GHU/nVj+S6F6nvBnFbi+KO/p5kqNzj2qTrMQVSda3?=
 =?us-ascii?Q?1yoy1nY7UA8Jz8Fkd2j1ihXF3Ttqn+LU35wekgGN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:04:30.5504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcefeca3-8294-4003-c860-08de1bc43856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999107

cxl_rch_handle_error_iter() includes a call to device_lock() using a goto
for multiple return paths. Improve readability and maintainability by
using the guard() lock variant.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v12->v13:
- New patch
---
 drivers/pci/pcie/aer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 0b5ed4722ac3..cbaed65577d9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1187,12 +1187,11 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
 		return 0;
 
-	/* Protect dev->driver */
-	device_lock(&dev->dev);
+	guard(device)(&dev->dev);
 
 	err_handler = dev->driver ? dev->driver->err_handler : NULL;
 	if (!err_handler)
-		goto out;
+		return 0;
 
 	if (info->severity == AER_CORRECTABLE) {
 		if (err_handler->cor_error_detected)
@@ -1203,8 +1202,6 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 		else if (info->severity == AER_FATAL)
 			err_handler->error_detected(dev, pci_channel_io_frozen);
 	}
-out:
-	device_unlock(&dev->dev);
 	return 0;
 }
 
-- 
2.34.1


