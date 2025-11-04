Return-Path: <linux-pci+bounces-40174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40038C2E8CF
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41C54207BA
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3101A9F9B;
	Tue,  4 Nov 2025 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YgwkC9z9"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1586E13B7AE;
	Tue,  4 Nov 2025 00:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215212; cv=fail; b=ZOXafSKrfcZ5u6X0lpb3zs8Ndnnp24hNmHXQl/QKqZuEuimMZQ89gAZm8bwuIsWBcUhUTa4tnzT4RToTnOHFl3/0ljcoi+QmblgFE6YvYRVSJsC3zz9ni+pm/SIMlJPzs4i/FE07Hb0SmdQQvNJMYzY465tkv7RiSenV7jM2o/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215212; c=relaxed/simple;
	bh=UDnpf3J98Kq6yY7pqQx6LwO+gk6VO5Jk30+LB0JALEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuBcX+Zt6OVR9oWWFDCM05r/0RorDh/EGHJPMXz1jb0pqZXalC10YpGrX3BZZ7fQagoEeB1bYvfF21EjoUQVy+3dA271aUy7VoNfi2kC+9DULbdiREtNelTCpid3DNY4we1ZviwyqucqY5wqLGq7Q1wZYDpojv+wMJB/OeGxI5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YgwkC9z9; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h02aTcJ0JH6wB9PCEQ17x5OnAQubn9D7X6Q4RLIhyAtr1f5wRkPRjEHn5js+ybKrYry2ZZIGtD8v+aXqrwrG6aUu5Fvp7zQI0dfj6Vp+O2YRy5XT/Hf2G8OKnDyXcy61ARgH7ItJxAgeGuDs3m3J+JJg2P5Toyd6VtxCS4xX6/wlxkZOcijuw6ubq/mSZBL06rJZZYtcS89zJ0lVZZAHmCy80Eo/Vn6PxvjWkKjO0c1Sg381aTYubCwxkKp8e5fqUSF/WbgifvmcfkZdGRP4Npd/gdHb19WXRqnm5+oUURUQVQBQ7CPRVyppvodw/iZuf82iXh2cutv9e3sgYnh6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1V1ht0eAPCC7n3ZuPQAZun8SUgK9lddep/56siyTptM=;
 b=qa8rFb/vMzt81PuQ4dkS7s43c61K3KTYNsjjZFMprKwaHJO8mx9db5DuuUvFhIRcFAEckXZBweJWeJ/qQw7u2JmncAEMZTpY3LGXgr4RDNX3LDCTaw8pbMnBHIa5dzu3JVSbvovhyC9QrjfkQcjrL8KIv4oZ2CP4aQywRGHgyabstrK8JVvXPByMlfxPZ7Kq/CFLX6JGFePWru8Qu6VyAUNLAop9DZLd55/CCutk27Wc441VI4SoO0FzSqE7kAHF9Aajkcm/cIA2U9iuOPtPgHDN60noL935YRdwdJ1TaWzDJarHvMNGrp/ABrZckEGIv2oR/pyoUdNkUL7mQVnI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1V1ht0eAPCC7n3ZuPQAZun8SUgK9lddep/56siyTptM=;
 b=YgwkC9z9f1GykpDrIJ51rO0R1GmmhCtAJgSqOHcExadsQa1wZeFkOqDxFqQafogAAVuD4xEzo360pA1b3ocDgLIIZ3mEwKs9G7QumfjwQ+VBziCC9MkwG7oibVsUJRsdkGhSPI/5jb5xy5jzl7oqk1sNLjeggXPQI665gCUHyuo=
Received: from CH2PR08CA0024.namprd08.prod.outlook.com (2603:10b6:610:5a::34)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:13:27 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::15) by CH2PR08CA0024.outlook.office365.com
 (2603:10b6:610:5a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:13:27 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:13:26 -0800
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
Subject: [PATCH v13 18/25] cxl: Change CXL handlers to use guard() instead of scoped_guard()
Date: Mon, 3 Nov 2025 18:09:54 -0600
Message-ID: <20251104001001.3833651-19-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: ff382307-b9ed-49ad-a672-08de1b36fa67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|30052699003|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6BNzYWZV0EQ/p2PJhCSCj5w2nbpJKmhc5Gu0ZxypZZC8voL96TS75khzdD1r?=
 =?us-ascii?Q?y832LJyI+rhydKqtppTwTDn9pneC+sY4lkRyOWa4aAfQ84sqES3xBFixLU6R?=
 =?us-ascii?Q?AsiDLQP5qZw4115TQ5cuGsH9l4KJqWC/x3cmO7fGZIOLeyO4BSPMK29JqdqO?=
 =?us-ascii?Q?xo/++DU779siDqoSbaP6F1FdDWTOH7PrAOBK02NYq8q5VgzIOuzRsB26rIv0?=
 =?us-ascii?Q?T3wUoeDrKoo6UHR/Avx/Rp1y3q0+heFvr8fHugTECIg6FKgff4J9RBdCbycD?=
 =?us-ascii?Q?57MrH43dW3+QD+0HCPhngKRY2rfHSM38Bix/MgvjjImTpbnRv3je1qUT/2P2?=
 =?us-ascii?Q?RHOL0Rolig8A8PSLeSTNS4WiCwnroeyXl21KxUG04Ov3q6pvkccs+ATIsVQl?=
 =?us-ascii?Q?4gc1of2+frIPW1x/RtoQc0T2y18Y8VpPImie4BsTS8PRO4XHfGNqP5nNYq8r?=
 =?us-ascii?Q?31I1AKNh4V/UXQjX7JDPj4w4BgEa7opx1OO1wOW/GPah/QD4kWt5EpEAZ59a?=
 =?us-ascii?Q?VNHTkBdzU87+OZjokAqaVvh+7IXYRMhyS+BkLroiDTYxqZSj9WdZ1Mu2n6/1?=
 =?us-ascii?Q?z1JLuoxWhb3lB3NDtWomiDlkdVwAeQ5mprEDtVMjmEKqeogLszEvTql74crz?=
 =?us-ascii?Q?sYrsui1zW9Yg7rlKA/oBKox1eA7QWB3cwnZWyAsU1Wpung3HaLxj1K1pv0ke?=
 =?us-ascii?Q?Vjh1/aAI5/EoFz7HJHYTqWqewnndB7cXRLr49+p5s6mJcSS78zb17iMvFcxz?=
 =?us-ascii?Q?qr97+GLERUJD9JMYDjSZfThMLht70n8ICA1drYeaQ8+MPzbqEkKzFCxzEeoa?=
 =?us-ascii?Q?V5tgxUOHdNczS4JO4IDDvvSfWfWKb8hSaYyDk58+Oyt8SKInPZgxv2kLvMh4?=
 =?us-ascii?Q?9BW3FIc/+94ZaiUNv5e/fgVJuaNrFuYJddZVxnMtiEX/BqhHPDtH/oryVrVf?=
 =?us-ascii?Q?l32zwaTGk+N0tSd4dxt8T5gCPZM1ofnlefj8Zlc9yLyg2yAlEqeXgk/MvwC7?=
 =?us-ascii?Q?ZZyEpQcw4RxFEu4gLkes6REqOJEvhxH6xpUUIW+CBmrDyaFas91vzMRijDtq?=
 =?us-ascii?Q?EZfIYHwWOxE2LlG8bIvg8VOhv09UH2cY8fgxRYFyzEBziLu9txchhc+8rwjD?=
 =?us-ascii?Q?b9CjCz7E3gdjdIgkjPmAEujdnYN2URmYNCYmhcVWLjGBrCmnQZwxEPyQCcMP?=
 =?us-ascii?Q?rfsyrVSD5YNEvmcrukVUTn5VKWUxEaE87la3MDRIjchCNIOwBLldd5zIrQeS?=
 =?us-ascii?Q?CLyZI3AGxQGMijNQISGjz9L9Aek7D7LxjAtzVn7bTcNYnuOyM01BLVaKfzFH?=
 =?us-ascii?Q?Tin/9M/dEfEUCPB0SVjn00Gpdc0awkcCxrPiosNfygUutEvvNYPn3Ot8Bp5n?=
 =?us-ascii?Q?KjZm0U6NJj8eifPehFLEHigV+/fYOE9Exa9IhUQ12tb0CXA/H9YUnquoTTsS?=
 =?us-ascii?Q?n+dg6ZIFaKWeL0CjCyldDU9awjxIh4YyrD+xkPGS8O8k7Nf7oxjy1KdWbq+R?=
 =?us-ascii?Q?LCBikdGVIgICMg3cWFgz5E7LK4e67ZmpYGjqLAB6EjGItgltK7PmE+F5obOW?=
 =?us-ascii?Q?Mth+Gc2M/GUrqaJcCe6RFzYzAvF5C+fV49L9WPez?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(30052699003)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:13:27.6182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff382307-b9ed-49ad-a672-08de1b36fa67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407

The CXL protocol error handlers use scoped_guard() to guarantee access to
the underlying CXL memory device. Improve readability and reduce complexity
by changing the current scoped_guard() to be guard().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v12->v13:
- New patch
---
 drivers/cxl/core/ras.c | 53 +++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 19d9ffe885bf..cb712772de5c 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -254,19 +254,19 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	struct device *dev = &cxlds->cxlmd->dev;
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return;
-		}
-
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
+	guard(device)(dev);
 
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
+	if (!dev->driver) {
+		dev_warn(&pdev->dev,
+			 "%s: memdev disabled, abort error handling\n",
+			 dev_name(dev));
+		return;
 	}
+
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+
+	cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
@@ -278,25 +278,24 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	struct device *dev = &cxlmd->dev;
 	bool ue;
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
-		}
+	guard(device)(dev);
 
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-		/*
-		 * A frozen channel indicates an impending reset which is fatal to
-		 * CXL.mem operation, and will likely crash the system. On the off
-		 * chance the situation is recoverable dump the status of the RAS
-		 * capability registers and bounce the active state of the memdev.
-		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
+	if (!dev->driver) {
+		dev_warn(&pdev->dev,
+			 "%s: memdev disabled, abort error handling\n",
+			 dev_name(dev));
+		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+	/*
+	 * A frozen channel indicates an impending reset which is fatal to
+	 * CXL.mem operation, and will likely crash the system. On the off
+	 * chance the situation is recoverable dump the status of the RAS
+	 * capability registers and bounce the active state of the memdev.
+	 */
+	ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 
 	switch (state) {
 	case pci_channel_io_normal:
-- 
2.34.1


