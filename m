Return-Path: <linux-pci+bounces-33612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D21B1E398
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 09:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83AC916EE77
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463B6275865;
	Fri,  8 Aug 2025 07:29:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023118.outbound.protection.outlook.com [40.107.44.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD1274B4F;
	Fri,  8 Aug 2025 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638187; cv=fail; b=Kuhbekh2UrmvafZ4QKWiC/hNwFZQjBSPbXDmB+xvmJxPFm9zgHrWboVIQbyV9g6LesNCyfIa57ta/dwTqZwIjcs9s5oCjR2cR9u6ODN34hYlAKnTwnaLDIkEQ84zJ+20JX+Qx0ibiIOLFbXUyz4znUfeD8lNqiHPfpqdGba3o9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638187; c=relaxed/simple;
	bh=G5eOl/Xm3GP9bTaLZSi9myToHoyTJVqJ7DYrdSEslFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxmeTK+IOOmbSbiAZn/96T/NWf0mRjS2v1s84zepU71tw8q1rEs0dwnPORX1YTPsO+xLa7djbuz0iDdXAD+zV2dfQtJLf+bAJE+piBGQR+v1RAWomCB3gvm3Mrc5uaxm62hF+gcZP9xS7VkxE1yTyVFJO/Tygrc2lfHu0+lub1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7IlKJ1nU7RQifJeLjDLNf5N2DuoKDQ27qDgyxRGrcCo0L8TKIRZXVclkOaMTTrpzvCcfN0fCsJRNsrStLNIA29cmtIMsq5IyOnpM+gDLow5ReyJ1BADKI/zZbV+G57yGW901ls/K8tFh1c83MmGGp41S+6pITivosP/tyU5tEV37HiQaEcyW0fSm5ENoJJYpHTn7jPKDA5+EMokTPjOo5DFj0fkkb25PgMWJmNptcvniENbY+fRxnclnTJiyzWRP/CfE3xZn0aDHc/TYqSkk0OzAJJuFh8HTT9Lt6bbZoMKrEn6JZqMPLrsYDvy8JEMN0u/ZDjmqZ6BZjrkE01zqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8BToPZxjTD4L5jPzzFAljpwlBxu60t0OjqLNMwJZRo=;
 b=rPGwV5zsiHZbbnJX+CRsjWrQxCFYIDQ2uVPc4wQuu+zMfd/G0UFbwtnMtufsQRP64qpVrATwn4A5alcdmtUOXjb/c+HE9d5Ko0xD0f3YcjVtH9j5w32F4/3IeySqDXQuygbf2w4p8Py6tTQ49l3hYi8pl78ZQdeAAKt3Jd2Fom/ws3Y6N01cq1jikO4QJLswL02Fl80RCvPPjoo8MvbN9Q4KcCWyWx6XiHgXMiebLm9n0STKE/2YIlFJ66iY4yRv7r6rWVhXU+HB1Y2mGITVJ0CfEmgEnBc3q1nuJuggXYQHyrfYBrETmDnD0Qh3aP1ChcTVgotcEShP9zyZtywKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR04CA0018.apcprd04.prod.outlook.com (2603:1096:4:197::9) by
 TYSPR06MB7298.apcprd06.prod.outlook.com (2603:1096:405:95::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.18; Fri, 8 Aug 2025 07:29:38 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:197:cafe::12) by SI2PR04CA0018.outlook.office365.com
 (2603:1096:4:197::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Fri,
 8 Aug 2025 07:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 07:29:35 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 80ED341604EB;
	Fri,  8 Aug 2025 15:29:31 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v6 08/12] PCI: Add Cix Technology Vendor and Device ID
Date: Fri,  8 Aug 2025 15:29:25 +0800
Message-ID: <20250808072929.4090694-9-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250808072929.4090694-1-hans.zhang@cixtech.com>
References: <20250808072929.4090694-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|TYSPR06MB7298:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b95a6e39-a0f6-431c-f21c-08ddd64d53a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yhb31YvH0aedVX6J1CuEwKv9NFhYfKjYyH8hQHhpHXDsLEje1ubv/2L7mULL?=
 =?us-ascii?Q?vI2nr7uAYXCEvlO7AYZaFN+4k/Be8aSM8MAjWTEHZz8lMmzQjewed1LQbTCA?=
 =?us-ascii?Q?a+1Vnd/SfGMbvBOQI6Qj1u5qtbRmHMlyDI1QPHo2q7K4huqAO/6eOHSH8e+I?=
 =?us-ascii?Q?obXv33F2YsmHkWHO61tHmdCq1x2ncqLn5CWKb2bVMWY2gS+AFk/our/QrwTx?=
 =?us-ascii?Q?+0TC//DPU1zKg022IAgknD7ex+d6CNeEVyIyiKJFiwBYuYyUAZklC2kDa6Zd?=
 =?us-ascii?Q?zSiI0CZFpY81tc9O5uHAELD5edW+GNCF7364GuXBtZdjcl2VFdOJA5WFa7H/?=
 =?us-ascii?Q?+Q93cVjTH2hlEOR7GgAdlq2PXX1zgaCKcsgcbsDaSXbbpnMLgrW3D14QkHzV?=
 =?us-ascii?Q?yg7VdzZhH7licn31QL+wn3Xu4PcGDmEXO990b5Ubkk4nTNckU2WU1+MXB/yx?=
 =?us-ascii?Q?y/uP9Ynq8GPWMrAS87y7fqphwlB2dkkT6dh3U/xRM9epc1No11IYWb9W3kz0?=
 =?us-ascii?Q?RPSnn4n5KQSXs0FqvJONE5dsZVLU03xtoHuid3a6WaAv27awqDCODe0Xu5oD?=
 =?us-ascii?Q?+MhvSKPwYgpAspmm6l1jtqPsxIaQCh8Ntas3fg/qvQi/hcbrkNIEChcsW7nC?=
 =?us-ascii?Q?yqI8aXAtV5bizjlK1XN1W99O/3cmbB3WHGA8OVsKa1laFRNZov6MPt8BxHPK?=
 =?us-ascii?Q?grCjSRQlaaZSGJskVgmKoUbxFNd38tndFFZDzlEvTfU4YyFgT5mfbP4zbFLi?=
 =?us-ascii?Q?Pam3tEvSCK376D1HF9Gh8VwVCoQGrEBV3ADtvPxESYyggH2jGnqTCTg1Kf4L?=
 =?us-ascii?Q?2LycVO/N6kdJhmiMyxRCtpkah92UjSzY9YDrQOVv7hhvqsu5sp49ZMiIE6/M?=
 =?us-ascii?Q?lolHP8DWLHb2g6Qt/0BXcBoxnYQKefMr2jN1DOFW6yw4ieLci0PfqV9o1yfX?=
 =?us-ascii?Q?z0MktyzlocfPPMGUujyVfnu/aaQ6vMODz5XnG4LxNgdSmjWaVmkGLbSYCqZP?=
 =?us-ascii?Q?SlkR+X6rBsXDGwmUF252wIn+hsMRNcaytowjvKo+d2ubISDWj2CCI+omx8Fi?=
 =?us-ascii?Q?by7+U2bmOJy9CyPD3p/1SwMeHblqMlJyeYPcS6/JUvK3ZtIBGQA4CkrspK4t?=
 =?us-ascii?Q?cyjMTFpmpb9tmvt++KUv0721DdmE40I+nsl61oXVPK4CZZZlGWFLxOnxlt4/?=
 =?us-ascii?Q?ytqDBuMDQ5ATXXyPNrhWl7GHGqnMqv5deLmkZRXpWbGNoH7cXV0OAdvQ5Wy6?=
 =?us-ascii?Q?hkx4z5ePXHtv950tktSIyB+Dtp+b9JGm5q4EqlmMGXB+733vV2ZQghZCKe8Q?=
 =?us-ascii?Q?1iUoUgnunwzv1IQCO2WLEqQQ9XQ4EBTfjRlw0o1Mzvl4pklUVVdnEC02f+qa?=
 =?us-ascii?Q?FDKyvPIFrnzW3sa/Wu4YRHtSMzAvqNn8wAE3AIpNopvPbp0YnBOjJUI4/1V2?=
 =?us-ascii?Q?v/V5bJX273dC29d6l90wfrYaHEmr7W/cpz7FfOKCOGe0YlSEg5GPciCRAqT1?=
 =?us-ascii?Q?C1C9i1wfms7RlvXdHwb86krOrKa3BzDz7AYS?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:29:35.9093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b95a6e39-a0f6-431c-f21c-08ddd64d53a9
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7298

From: Hans Zhang <hans.zhang@cixtech.com>

Add Cixtech P1 (internal name sky1) as a vendor and device ID for PCI
devices. This ID will be used by the CIX Sky1 PCIe host controller driver.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 include/linux/pci_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 92ffc4373f6d..24b04d085920 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2631,6 +2631,9 @@
 
 #define PCI_VENDOR_ID_CXL		0x1e98
 
+#define PCI_VENDOR_ID_CIX		0x1f6c
+#define PCI_DEVICE_ID_CIX_SKY1		0x0001
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.49.0


