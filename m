Return-Path: <linux-pci+bounces-34826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4B4B3771E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6023E360559
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003601E5705;
	Wed, 27 Aug 2025 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UsO0dzrZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A92B20B80A;
	Wed, 27 Aug 2025 01:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258655; cv=fail; b=WmmgtXG3dpybLLvS0eJwjLSSgYCsa0sK52U0wUJOh4LlKnNa9Ny1VWH8JZnx/e7JU3fMomwYYXAQxZPqatfbbj/xTh+nPZuLiH1uW4yKHw/vBaUhqBgh+rXFQmRPb/qFJfB++YDb8tsRMj2ueZiX4LKlgqbXVVmJFNJl0Fe+5PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258655; c=relaxed/simple;
	bh=A5kgG2Z9zlrSvwrcEgR0p+rkXNd/4lyd9sAmimgLsow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ha5aeYlol13L/qRGDl9N2xT3LZpzUcSGIPVodOyVjxzlTOTIWCIdo8AcoRAQ7SoiFS3KQlwG0yjWQCdz4fbiKaZOqNGV7Csf4qf6/sdU/bzPw5wJP2EG/gsVq1MfPtRqYvkKHEe6HBJQrxqHLo0oIC3bRymg4emVxUw1DDgFZ9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UsO0dzrZ; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxDXPvMU3QsvaVEkkxatK1JLw9BT2BU9DQB8ZkwRr4hp+JMmQUuBffq0pCI2Mn8U3nl7dtNJm41Xk+2XvcGeWdJQtpxo2KNk5SJ0spYGsJS5sjYqlWYacoUDSvUHPdOU8ubv5l4/IBzoTwZK4rC19tgCWAUGJN5CmHvXSQN+ue4CP9DZqrwFcLActcWwWaAoEVB8x/84lXmJlAamMbJVcM3RgErINA1vYymr0fHJ6TXN8x3Kh11oJHrmD6g60cWjTwgNqOdYIMlMohxYr/ST93U03EArQez4vWdk+egqrKPbXr7hI6s+tIfcUb240O1UWl2UxBPt6XzigFHK6+mHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iijVmb+MV2nP28YNFgeov+CmlL73wV1bqsqDjc5hJtc=;
 b=gTFjsvgsju1mLNH3eTtHhT2F5gpZxDm9cpOR4GSMonHIvn9f+mBzS37HK54zxaVvREEO1PGrfj7UB9RVJKs1cu8NC1KZALf9QTuO6NtSUy7hIbiTh9XSumPhifF1+LFImJTjBLCesTACVQSxmDuI6OTB9omKsbKVu505wdVTz7ZelXBpM65FQw2ja0LFH+NNy+i6oVUj+nRtnnwUleaNRSpVckhr13ax7u81XLyKZIBqfBJ6Cdn3Qs+mDs+h8e5Um47Mh+s3KjcOhYWnN2kV0h5bPfYXXAEdj1kIgKRp0r0LAHsRAFFdiAKABCW3L5Y8iLJQorXhg5hDu0Hv5ed5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iijVmb+MV2nP28YNFgeov+CmlL73wV1bqsqDjc5hJtc=;
 b=UsO0dzrZoVKK9V9gFfDzi8jX27ISjdGotiXARhYs5TEhjF1n3bLcbUbg6Kl2MYZoFH0oiA1uY5pK81B+U73fZFJVlfyrbpQAq5ITWX335nmm3NabMIui1xD6q0cBQG3OR6bjkKbPcDgesCzim2oDrGwhMsJDjmZnLqW/cH4BAUY=
Received: from BY5PR13CA0021.namprd13.prod.outlook.com (2603:10b6:a03:180::34)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 01:37:27 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::73) by BY5PR13CA0021.outlook.office365.com
 (2603:10b6:a03:180::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Wed,
 27 Aug 2025 01:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:37:27 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:37:24 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 09/23] PCI/AER: Report CXL or PCIe bus error type in trace logging
Date: Tue, 26 Aug 2025 20:35:24 -0500
Message-ID: <20250827013539.903682-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 568d924e-68ec-4d58-b27c-08dde50a47b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cRJNMz0567cB4Z0KnHDwOugesCbFPfwTX9GhQQrVSq2yfDPMH8DPEzZxkFFr?=
 =?us-ascii?Q?bFNT/IPYKZ0YAZtvwzrMg2W0pGJMvGkOeqzRayryNBtblvqgSic5fwYD39vY?=
 =?us-ascii?Q?N3rUoEtoD/hDwM4WZ8mNvrLTswRJThIB/liZRrK7B12ULociWcla5ZdCsWJG?=
 =?us-ascii?Q?vjOwEXArZAHgBEe4MQV8MOoP7ZWQIqofO/cUn3FV0JTUJjYBnV03t5pNDYzr?=
 =?us-ascii?Q?Qcoab+gXsIUdRvvVW8j2x0LXLKh151CZD8F8v1WJVO59S6izaqWceaUWx9jA?=
 =?us-ascii?Q?Rzq2nOI07Fq1cV31hR8HnXiHfM7wASVPrCjPVonamDoyJAX9266HDw5qRKKT?=
 =?us-ascii?Q?aU35jDkNxGboezMecyi9cqBGwWbOtUKrxOtVF5b7IgzFGMfCivbgdPuS2Z4U?=
 =?us-ascii?Q?sIB2aIP4hVQXFdjTB8/t9JkVS2zvSZ4laS+Gd19+JoE5LNNr6XT23yGtx058?=
 =?us-ascii?Q?ycJ3VBjtlSphUo+5QHoakPaWr1iRQJhPkZXSGg0iGnY1KJ0Cf9EnKKUhu6nd?=
 =?us-ascii?Q?ad7kEX1OX+azw+7fCJZbAMArhQZe+6UKncIF0+7C5gijRRvut4YLH9BSAN2g?=
 =?us-ascii?Q?SLHpN6V6L+bRfGeyf1bUa91HpKEd1iT8tJjHcc4FjJEyr1MS0JGyb7YPOu1e?=
 =?us-ascii?Q?loKJXojljgzrGlUftfeuwmIUNdWOlV8phEfX4fE1m6GCOZ+xeLkLANsO+Z+h?=
 =?us-ascii?Q?jn5FMcKYbE0JyYNTnOIz1soDINVUi8ROkLNl8OsDMMHPOLPbDpmYNG4Z2TTL?=
 =?us-ascii?Q?VosPhKX1OKpBq/l4XGSAPGHJKlB/d1pCL+WnFAZ0z2jcjC5rWJY+GZ8tJisU?=
 =?us-ascii?Q?UUXWXhrr31yhDf/nN1mFrAPO0tLwKd+g0nKj689QzFEILnzjUrgIForswZ56?=
 =?us-ascii?Q?n+P9FzlkRQzJ/FEnFkKwuVtk6iwWxMvW0qCJ3zGUAcHKpbPWabqduUFtQhh1?=
 =?us-ascii?Q?1NSJdBEmGGFrl/AJv7USWqmdZrwaY6wTLZhIHrzhuwMYMeJTLh+foPbB9iyg?=
 =?us-ascii?Q?fiMKlmj9dc+zsaXSc16ZFpriXe90fsSfRfLgyuJyz1zwjPi2X3wszFvhJE65?=
 =?us-ascii?Q?wijDJwn3WDvR1JgO6znK0PgK15xc1urLV0TW2DB3ShASbMorGnBWR6OnpCbT?=
 =?us-ascii?Q?eCRc5hQSacVR8lU1SQlUZ0PNGB5XywJaAj2bqXxWjDfpU0gP6Mp0g7QWGFPg?=
 =?us-ascii?Q?jUtO34liE/IAyoC/mGBIEJwJZPKHWiDzl/qLRU0H/4Y96IfAeTEj5FGVLAna?=
 =?us-ascii?Q?5AMFn8xrbGvb3CWetEGzzm71doza+9ivgs2jOKo31NWOOWXFvv+OQ4w+qOPx?=
 =?us-ascii?Q?+GRHPgmwuk1HTYiZWAxBByODSDetMiAhnsy9pWtpJ0J9pIpsUKVFKp7kG7ki?=
 =?us-ascii?Q?5sYGA5RrxqXmG5ajyt8y80AvnC/eg49zB2gts7uVmzHJFmfsyc0JSqBQAsPc?=
 =?us-ascii?Q?BUiDg188IE1Xu+AXaHVxvtpbx/Z40/VZyUSZTz8PPGmQF94BZ/BOEMzdCHfG?=
 =?us-ascii?Q?Hoovm2x9yidARUtKCjReukJwzF4YC6lqsLRw7waSukxmqBmNWGFX/VVI+Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:37:27.0775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 568d924e-68ec-4d58-b27c-08dde50a47b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167

The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
for all errors. Update the driver and aer_event tracing to log 'CXL Bus
Type' for CXL device errors.

This requires the AER can identify and distinguish between PCIe errors and
CXL errors.

Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
aer_get_device_error_info() and pci_print_aer().

Update the aer_event trace routine to accept a bus type string parameter.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---
Changes in v10->v11:
 - Remove duplicate call to trace_aer_event() (Shiju)
 - Added Dan William's and Dave Jiang's reviewed-by
---
 drivers/pci/pci.h       |  6 ++++++
 drivers/pci/pcie/aer.c  | 18 ++++++++++++------
 include/ras/ras_event.h |  9 ++++++---
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c8a0c0ec0073..417a088d815f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -608,6 +608,7 @@ struct aer_err_info {
 	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
 	const char *level;		/* printk level */
+	bool is_cxl;
 
 	unsigned int id:16;
 
@@ -628,6 +629,11 @@ struct aer_err_info {
 int aer_get_device_error_info(struct aer_err_info *info, int i);
 void aer_print_error(struct aer_err_info *info, int i);
 
+static inline const char *aer_err_bus(struct aer_err_info *info)
+{
+	return info->is_cxl ? "CXL" : "PCIe";
+}
+
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 		      unsigned int tlp_len, bool flit,
 		      struct pcie_tlp_log *log);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 29de7ee861f7..1b5f5b0cdc4f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -837,6 +837,7 @@ void aer_print_error(struct aer_err_info *info, int i)
 	struct pci_dev *dev;
 	int layer, agent, id;
 	const char *level = info->level;
+	const char *bus_type = aer_err_bus(info);
 
 	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
 		return;
@@ -845,23 +846,23 @@ void aer_print_error(struct aer_err_info *info, int i)
 	id = pci_dev_id(dev);
 
 	pci_dev_aer_stats_incr(dev, info);
-	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
+	trace_aer_event(pci_name(dev), bus_type, (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 
 	if (!info->ratelimit_print[i])
 		return;
 
 	if (!info->status) {
-		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
-			aer_error_severity_string[info->severity]);
+		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+			bus_type, aer_error_severity_string[info->severity]);
 		goto out;
 	}
 
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
+	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
+		   bus_type, aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
@@ -895,6 +896,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type;
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info = {
@@ -915,9 +917,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	info.status = status;
 	info.mask = mask;
+	info.is_cxl = pcie_is_cxl(dev);
+
+	bus_type = aer_err_bus(&info);
 
 	pci_dev_aer_stats_incr(dev, &info);
-	trace_aer_event(pci_name(dev), (status & ~mask),
+	trace_aer_event(pci_name(dev), bus_type, (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 
 	if (!aer_ratelimit(dev, info.severity))
@@ -1277,6 +1282,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 	/* Must reset in this function */
 	info->status = 0;
 	info->tlp_header_valid = 0;
+	info->is_cxl = pcie_is_cxl(dev);
 
 	/* The device might not support AER */
 	if (!aer)
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 14c9f943d53f..080829d59c36 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
 
 TRACE_EVENT(aer_event,
 	TP_PROTO(const char *dev_name,
+		 const char *bus_type,
 		 const u32 status,
 		 const u8 severity,
 		 const u8 tlp_header_valid,
 		 struct pcie_tlp_log *tlp),
 
-	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
+	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
 
 	TP_STRUCT__entry(
 		__string(	dev_name,	dev_name	)
+		__string(	bus_type,	bus_type	)
 		__field(	u32,		status		)
 		__field(	u8,		severity	)
 		__field(	u8, 		tlp_header_valid)
@@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
 
 	TP_fast_assign(
 		__assign_str(dev_name);
+		__assign_str(bus_type);
 		__entry->status		= status;
 		__entry->severity	= severity;
 		__entry->tlp_header_valid = tlp_header_valid;
@@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
 		}
 	),
 
-	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
-		__get_str(dev_name),
+	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
+		__get_str(dev_name), __get_str(bus_type),
 		__entry->severity == AER_CORRECTABLE ? "Corrected" :
 			__entry->severity == AER_FATAL ?
 			"Fatal" : "Uncorrected, non-fatal",
-- 
2.51.0.rc2.21.ge5ab6b3e5a


