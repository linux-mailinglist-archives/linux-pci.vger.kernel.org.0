Return-Path: <linux-pci+bounces-19432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9BA042DA
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1342A161622
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8061F2C54;
	Tue,  7 Jan 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dCe4P2M1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1C1EE7CD;
	Tue,  7 Jan 2025 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260883; cv=fail; b=F4bwR7z3QCNjZq4eRtlLjKaE+NbxgFDulUM9OU6F9uYW25pPkwuHgwv4Riu+YMqkvn9oWLbNJjYiK0YY0yF69GZse6AtH1krZejoJOpRqLzVT9pF3394zfL0CVvXMpb9Rx4VXYhjvnqhjQeEMJjLLpI3eBwZpvnMSc8LL4Kzdbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260883; c=relaxed/simple;
	bh=wWM2CDN3HsUJcGOqa1SmsjfirMZXyD8icDFkaHK7UBo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNb0eaZfoQFfv/GXyp5gyONuS5gLSsh+TT9jp7nL1Hs8GwdlmVi8x8dD5TgOblrBQlU8Igw53A5nqdp7hG/cInkY6jmziJ1+rd+WCKSGQYcxEX9ryQmM1p3TOzZTODelD/KMJp9C16kdVjiErgov27DFMTtPBhm6sRVgqH8r8Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dCe4P2M1; arc=fail smtp.client-ip=40.107.102.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeWAmexUxfRxQFmOLVNb5U1t3mAq+ebjISug6abtCIOFdcQ7BBPdYGprpb/xs+5NEsKV81bAcC/XBRpmFmqTapn28VJsMCr+XhnEQN0qJkFS8E14u3xLL+LFj2R50/D9Qka4rPhaEPnHXwTjriINiK1DuWULDY48Yb3G08dKyCvip+B1iJskA7swgvYZ+rNmF3tifjPXSFtdnAUf3ocYcPGtB+HO8o0CZmUxZrBMvvOS6xk0NJ2mlmr1NHgBTA/XQ5N6vVEsdekOwFXsa/EiG9NBCgZBFxvclVOcigkFTxHZinLp1iDDQzFl5TqvJbw61CwW8dHlOyUrH3/YFCS3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X33+uj3wgh+aPNa6KnNear0zv2Hht+r86DXt+xDQoOA=;
 b=QbwMdWmIjH1+EWshFZGtSRLz1AvU2ROOgpd9V2bbC3VZHneAraKuFMXB1yPpmjcmvPcEk175pJGNEFRBdd6jHVRvm8WJ07ccoryjT0sLeIGc4BU8gZ3IsuGd6HGe2I/oRfb6lYKkxTuFwD9/8Gkq78K5QHTPWSmFxuEgmMeH/RkEUBGVecIMGGiy7rFp/b2c0jJkKB5TCV/LuNythe9j8G3jrcMWrpKyg68OjjS31m9Pyma2c9b1n88LMqtvHzdoevWMcXkx0J4vzKx+vEsj8bfN6hlYje7ftjvm78hZxy4gcU+SddmkQOLufFBE7CKjNefK+RWnamJiK1Jg0rF4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X33+uj3wgh+aPNa6KnNear0zv2Hht+r86DXt+xDQoOA=;
 b=dCe4P2M1AL9oAEB8D85EJ39ZFy15FGyZ4RRmXxjkBtNpf5xCD3UG9XmsGevD7KLtuxfHO5geLd7EYPrEeL+z9NmXOc6PTQ8OM2/0PtA1iwBKER5oUaPNV2knHcSyQrSFDhorLJ4IgElK/J2OSKLtGr89L3rammoZJZ06nLkc8Tk=
Received: from SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:41:17 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::66) by SJ0PR13CA0069.outlook.office365.com
 (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:41:17 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:40:59 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 11/16] cxl/pci: Add log message for umnapped registers in existing RAS handlers
Date: Tue, 7 Jan 2025 08:38:47 -0600
Message-ID: <20250107143852.3692571-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107143852.3692571-1-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a46e553-1d9c-4506-c3fc-08dd2f29580a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QXeT34sqmc4R/uh7fbrY3XfLgkSmCvDfUs8rFOeQ+VYX6dqG5MOYY4+RwcMc?=
 =?us-ascii?Q?73Zg8RsmOIVFskDxGI+sUakzhGoWH3U6CeYguyWEZb0yqejGBx/wTe2leXGq?=
 =?us-ascii?Q?SUFabQJ2Kd1J2U3OKFJcmzGnbJLOeYl68DX7FOY2DgpBXtOznn+EHOlRbyIa?=
 =?us-ascii?Q?laFuxBbVHGt5oeoznDfqhZrArKQfuWF/gHU1E1+8YvfyyhNKTz2XaVNU4+ql?=
 =?us-ascii?Q?B97wZS/YUyZ/HFKq98ZIB55ygJj+YvhbT5mxLRm+kJibVua0Y5rnI3c0YIYH?=
 =?us-ascii?Q?0xayPb6AycZRuCHnSEjHWdFzbRaE74Ng7ESZIpDaPV8PAPyge2b6AShnVY5z?=
 =?us-ascii?Q?7Y6hy9amlsOzrGSIYrwC3iNUXLqiHwFKI5FpyUz0cjgo0MOc20LoaQw974Ud?=
 =?us-ascii?Q?SZaVlPgMoP6QbdADKtHnACUSZc6evzkFnBweYV5vtZ/Bwggg9r3E/ygqvPLi?=
 =?us-ascii?Q?id3D9qZEcUNPI/sSuza1w1K4OeRLUriunxLQ5wMa1pZpZG2EaNryDA4ZJmjg?=
 =?us-ascii?Q?CMICZp1blbQ4NvcJ+6XSanSaRVqKQpXhfTjSaiaZjNis62dOvXK9HaOY/Nsi?=
 =?us-ascii?Q?OFe6xSyDBEAykUOEFUXt2dylhVb3Gp5v0WooJwOrMuzNhilKze3+EEto8Zok?=
 =?us-ascii?Q?Dbe5et10GlZb6joTk/0CxN+p2hNIAMXtvXHWkUdEh4l0ZEirXHOE7LdYFvl9?=
 =?us-ascii?Q?pjqX+7ESbxjj23rL+0c3nuZIxDEXCetr43YRKp3iQlGM/pMqNpQ3h/0QUN+j?=
 =?us-ascii?Q?sknkjH7un1jWrCWlEt5M5Ute4krWBL28RQqMCKxAyQ36b24vX/J6AgJWJIjV?=
 =?us-ascii?Q?L0vIag5jqqLplTwseH9Vw8TxHSqNP6Tz2P4KXjB/rfIoxo3Wu3LCpV+zCbBD?=
 =?us-ascii?Q?cuTxAWLLciKWLeayaiuELY8MOVXQArEM2p922T1J9bmvdRRrC1A1HAFymTz4?=
 =?us-ascii?Q?rX5hdTjCSmg8S5ugPxUehtdIiMa+gNUgcPQsZIns1ZTL5sOaYuvYD5cIi0oO?=
 =?us-ascii?Q?sUi0eBkf1KqjiLZIg5WmFJA3rbCMVGY5sGlxAOFF3CjjwwCixyhV6tew1ra2?=
 =?us-ascii?Q?xY6TRkSeJuM8tVu4IrLaBoDrb+wDxHf8JRv3OUZARvBRSuQoTtlkjocMVgZ0?=
 =?us-ascii?Q?wlM8+gRy7cw8QzZ/UK0bp/S7rUUTmzaRC8EFq8ZpqyhhAdeMWbD/OfmJs80K?=
 =?us-ascii?Q?PuU2gp8rkHg5KFpljHxGa1CX8vnChJXGFfuNZvGz3qKmn1DDpWPjAsVW2wkb?=
 =?us-ascii?Q?vLDxm3/4tX8WH68TGZN67SlsZpBRLdNLAmz61Lku7T1WINFY8pndNh+AMq9J?=
 =?us-ascii?Q?qOapn7J2oZ4hOG8u/UpAtBiIveniDhAXPktbIxVgBqW3qLFVfQoB0mMSKhRy?=
 =?us-ascii?Q?K2FYTmLlYC280cfUX1CZ4pCCauacVyCz27ZdzdhMVOLznNxPNzZgFAg7bAa3?=
 =?us-ascii?Q?MyGGUpplG/Jfm9Gwrl2cN2vhkzQxSp3B3EK9tQVEvSDEKRYknKkI0l6lW5uv?=
 =?us-ascii?Q?E7vAp3ay3DoORAI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:41:17.2181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a46e553-1d9c-4506-c3fc-08dd2f29580a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418

The CXL RAS handlers do not currently log if the RAS registers are
unmapped. This is needed inorder to help debug CXL error handling. Update
the CXL driver to log a warning message if the RAS register block is
unmapped.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5699ee5b29df..8275b3dc3589 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -656,8 +656,10 @@ static void __cxl_handle_cor_ras(struct device *dev,
 	void __iomem *addr;
 	u32 status;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return;
+	}
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
@@ -700,8 +702,10 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	u32 status;
 	u32 fe;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return false;
+	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-- 
2.34.1


