Return-Path: <linux-pci+bounces-3544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D467856DF0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 20:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8125C1F2190D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 19:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5DB41A81;
	Thu, 15 Feb 2024 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eCi9N1JX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050CB13A247;
	Thu, 15 Feb 2024 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026122; cv=fail; b=e8lScDPN9IVChLgJGoy09xoL39eTGnlOTxQyA3CJ7m9z7aNqmIq6yQ/er1lZMau4VHCajz/VXexl8XQMGeUvdB4JzUf1cJpxw8/jrxflAfl4mUNqjc6yIyCKczoNyLyGY8nmTHwysy+nQS6PMNPOrVeI5c/gKFaGYZZoZ9yVLSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026122; c=relaxed/simple;
	bh=KRPzBhH3FmzL4XOtT2UpI8z5b+PmIIfW46I0yoHd7qE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddFBsH00psKdWpgA186X3KcYyWTz3v4YRMrJwwcOKL4G9D87A/K+qr85sq4Y0w+brEpSQXqmCEnmKteAG8rjZHZ/VrctAXq9Wf8g59/LSFrepTXInmYacn2w2dq5SLTOBdP2iQ763cRAsTHsJY5y2nqtNxwGzCSlyUaf8yOgquQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eCi9N1JX; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcEgBmJo5ugn/6QcK9ONwRaSHLirf09GtjsZ8V/1lpS+Y2fulaeBwWUSeR/zX9z7IlomzKhGPylxe9e6iKdb056C7sq28j6SFDj+SGIhOyLkgM4rNtkb6h36a1cLgRdxxahAUN/Eq5+uhS49yfbJSk/cB11EzjpoJ+FOp6bRmvJit7CGV1rxJPZdq4D9+we5OV5IOQsT5Jua85xJetgpDK0s/mhv+Ip8jUUzdy5bu/gVARK6nABCgqsIP1T97HgYOYUtgClg2g4b4RX85gsxlnYLCvoE+iQqmOACBSX0uA1KAN36BlMQXTlhaBIk7nBEUcINlbBvDc2VtdTbbxkEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJdRVqxrxQyr23NM4hou47SSqsgwAd9D3gzTgvH0KcQ=;
 b=PL5BOmaT/gCEdqhPC/SHdjcxRSri+8F914KMOp37D8YrGJ5DmQTH76ynm7/qVLBXnpMEXB0okBR+lBcmss8ku31/Cf3QbV9KrL3bWzUdxYbfXc2iMuIpTu6SrRO3VLVgA9DYpBKfMR4bRA3MTuZye7D1wQHSWVhCTJQtINBle/hZ4Rtrtur7kBUZJYD8d9pjTUdbSiGe85Qmxg7txuIaqXfYfmh/jf5EYKLdfBFZUAZVETaPE22JKY7sd1sj78aK1qyfZDeea2xx/h+Vb3aZ/3VAv7jV+AzrME8iSJONNI3EGU0qGx0eTgJ/gnLEAkvyhnK8uCkhX6VyQugp9EO97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJdRVqxrxQyr23NM4hou47SSqsgwAd9D3gzTgvH0KcQ=;
 b=eCi9N1JXkg1WE+dfJIAYgjzjx1yvKxt/gOx5oHNzDkX6DHX/n59F8+G9EBzSzqLmPoYxJZRKcxyx0y6D+apq1vsSRtH2SD48QRPRq2QwWMBsTp1uhExyCVQJEvIpyUNR/1DZYLl8smAU+ppWgdGcj6c9gklc8lUxUnCKHX5Qk6o=
Received: from BN9PR03CA0640.namprd03.prod.outlook.com (2603:10b6:408:13b::15)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 19:41:57 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::9b) by BN9PR03CA0640.outlook.office365.com
 (2603:10b6:408:13b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Thu, 15 Feb 2024 19:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 19:41:57 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 13:41:55 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<benjamin.cheatham@amd.com>
Subject: [RFC PATCH 4/6] pcie/cxl_timeout: Add CXL.mem error isolation support
Date: Thu, 15 Feb 2024 13:40:46 -0600
Message-ID: <20240215194048.141411-5-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
References: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: c6779b49-ccdb-415f-ddf7-08dc2e5e2beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	57mr0ieBlEGSMGCHlkHx+3KbZDPgL/n22d4Mi3CyMRC57eduP3INvL0b2MprTCI33Kg2b3vMiGXpXUB/K8X9JTyaFkvO300h5HRnwlPqhqGwVltjqWRy0wSMv4cTlj0/g6ln6MbWZM2gMzsmparBSDaD8SsE1BEttypLjI6lLZOU6srukiVXkA+SMbKidMxcPTGGZXmG0TMZKQZQ8MQb8dKpwDYWRJxT7a8G2zPr0W4cyLU/kdMi073Fpay7rcFpybDQhmqAR+B2YHmFFjXyuJIe2nqtjlJHwh2h+envpWoPRnjIlEy/wkeDrvOs80cNb3rGCprOyj+34WQQ+dtV8lARvsWU0tDLMJnob/wzNOlLRRTLEd73s1/IyOJTWl0H4vMrOx6bQuKipo9pgeWTppsZMeyC1mNHohtnJSv2MGIdsUnVMNrM2pGr30aWfxiELvaq2rK0xoOk9shPnwb6vIsXj5ymNyBv+qUMdX570jxolNqEpmkw851zcq7ImVTyvvX9FizbYkShxRe5UVdvqZ3a51wX0etAvsoqmbBmzdJ5PKaSO7FAi8/78Xlr/Nz6uB4vh9IB8IpK0EfHFzzR2w3qzsxCPB/cmKbB+OLZxfBqQu0ZiMY/t7ZXjrXfds/LqeYrtIL1UHSkvXAhYYTwy2hE9ZeabTvK1w/kihq8vZs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(451199024)(36860700004)(64100799003)(186009)(1800799012)(40470700004)(46966006)(2616005)(7696005)(478600001)(110136005)(5660300002)(7416002)(8676002)(8936002)(2906002)(4326008)(70206006)(41300700001)(70586007)(316002)(26005)(86362001)(83380400001)(426003)(16526019)(54906003)(1076003)(36756003)(336012)(356005)(82740400003)(6666004)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:41:57.7980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6779b49-ccdb-415f-ddf7-08dc2e5e2beb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207

Add and enable CXL.mem error isolation support (CXL 3.0 12.3.2)
to the CXL Timeout & Isolation service driver.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cxl.h              |  2 ++
 drivers/pci/pcie/cxl_timeout.c | 40 +++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4aa5fecc43bd..b1d5232a0127 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -131,9 +131,11 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_TIMEOUT_CAPABILITY_OFFSET 0x0
 #define   CXL_TIMEOUT_CAP_MEM_TIMEOUT_MASK GENMASK(3, 0)
 #define   CXL_TIMEOUT_CAP_MEM_TIMEOUT_SUPP BIT(4)
+#define   CXL_TIMEOUT_CAP_MEM_ISO_SUPP BIT(16)
 #define CXL_TIMEOUT_CONTROL_OFFSET 0x8
 #define   CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_MASK GENMASK(3, 0)
 #define   CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_ENABLE BIT(4)
+#define   CXL_TIMEOUT_CONTROL_MEM_ISO_ENABLE BIT(16)
 #define CXL_TIMEOUT_CAPABILITY_LENGTH 0x10
 
 /* CXL 3.0 8.2.4.23.2 CXL Timeout and Isolation Control Register, bits 3:0 */
diff --git a/drivers/pci/pcie/cxl_timeout.c b/drivers/pci/pcie/cxl_timeout.c
index 916dbaf2bb58..5900239e5bbf 100644
--- a/drivers/pci/pcie/cxl_timeout.c
+++ b/drivers/pci/pcie/cxl_timeout.c
@@ -207,6 +207,31 @@ static int cxl_enable_timeout(struct pcie_device *dev, struct cxl_timeout *cxlt)
 					cxlt);
 }
 
+static void cxl_disable_isolation(void *data)
+{
+	struct cxl_timeout *cxlt = data;
+	u32 cntrl = readl(cxlt->regs + CXL_TIMEOUT_CONTROL_OFFSET);
+
+	cntrl &= ~CXL_TIMEOUT_CONTROL_MEM_ISO_ENABLE;
+	writel(cntrl, cxlt->regs + CXL_TIMEOUT_CONTROL_OFFSET);
+}
+
+static int cxl_enable_isolation(struct pcie_device *dev,
+				struct cxl_timeout *cxlt)
+{
+	u32 cntrl;
+
+	if (!cxlt || !FIELD_GET(CXL_TIMEOUT_CAP_MEM_ISO_SUPP, cxlt->cap))
+		return -ENXIO;
+
+	cntrl = readl(cxlt->regs + CXL_TIMEOUT_CONTROL_OFFSET);
+	cntrl |= CXL_TIMEOUT_CONTROL_MEM_ISO_ENABLE;
+	writel(cntrl, cxlt->regs + CXL_TIMEOUT_CONTROL_OFFSET);
+
+	return devm_add_action_or_reset(&dev->device, cxl_disable_isolation,
+					cxlt);
+}
+
 static ssize_t timeout_range_show(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
@@ -341,7 +366,8 @@ static int cxl_timeout_probe(struct pcie_device *dev)
 	struct pci_dev *port = dev->port;
 	struct pcie_cxlt_data *pdata;
 	struct cxl_timeout *cxlt;
-	int rc = 0;
+	bool timeout_enabled;
+	int rc;
 
 	/* Limit to CXL root ports */
 	if (!pci_find_dvsec_capability(port, PCI_DVSEC_VENDOR_ID_CXL,
@@ -360,6 +386,18 @@ static int cxl_timeout_probe(struct pcie_device *dev)
 		pci_dbg(dev->port, "Failed to enable CXL.mem timeout: %d\n",
 			rc);
 
+	timeout_enabled = !rc;
+
+	rc = cxl_enable_isolation(dev, cxlt);
+	if (rc)
+		pci_dbg(dev->port, "Failed to enable CXL.mem isolation: %d\n",
+			rc);
+
+	if (rc && !timeout_enabled) {
+		pci_info(dev->port,
+			 "Failed to enable CXL.mem timeout and isolation.\n");
+	}
+
 	return rc;
 }
 
-- 
2.34.1


