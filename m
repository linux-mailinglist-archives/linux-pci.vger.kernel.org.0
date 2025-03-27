Return-Path: <linux-pci+bounces-24812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D363A72872
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7294E17B9F4
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEB619992D;
	Thu, 27 Mar 2025 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SNsGsSUi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2951991C9;
	Thu, 27 Mar 2025 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040187; cv=fail; b=XlzN/wlVHb4LUAJEqxIFx+zFh0vMjPFXQCd5oWqksmFV0Is6zdgpcN6wv7Ja8Rizyg5cTRofDN0XHwZse2on8Xqry82Y5JoZ2U4WmwZAg/VNjQHOg+EXeH5IdrYkHpFzT08XdAH+ePoBqqSlQOP7cHBLz2xRt+LI4+Fzuu0Knj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040187; c=relaxed/simple;
	bh=WepXOcLM1uEs9pESDv87Ym/p6BYt8twNuiNZ9FdmfRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnn9lIlm0T0cHy+fJc1t8F79GkwEx6Yk4wf8Px9KLuZuB8G8yVrjle0byT0yhhLah8NGRpHg2CUMsHy7+Bi3tZpVnRfinoXJx0nTSfYGIlzg618YOabu3KsiEgbPvP/RvsR2uDr1yX70zP3cP8hz+fY/n8HYY/czfEghyiAJREw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SNsGsSUi; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzJob80QicYLlGbvTJrwwyNAV12GTpxPkBo9bvF3Y2P+836yViaghVjE6sAPazjtU8NZ5u4TCg1LusvB/TUsCTND8WjOVHbMywXOuIU7VZxOArzeuws0hcr2YjzGpzrzQ4SovAxyvO7VUdmF3THagRpjUhg0tIixbATQIWqmpj/jZToFGTgYJjj3P+4gtY6DlI9I3wwjyW4JBLndSw/yKfeUbvk2i6BXz8X6jL3FSHpv7z+OsYEslc8MapFPeJjR5UCQYQB9BUpxkqPX9P5Fy7ZvnO4yYHvsDSsH8JmScgI3YWG7QrOANwSsteKzR9E19k3Sw1E4NoLWjvYYcYlt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1dA8A3QiVtXTMHvQGMJBvGycEyDTnNvWurcj9uH3qg=;
 b=CsjUMLA727tbcX+Jekvy25J0YCic8oGIycmwXEApuAD87HCUIxlW5tolW5aneDLR08Q3YG0OpkE3tJCY4DZxtDBAYAXtVw2lqzGaFdMO2fMrM7NJPJDBLuWZBoGgvBTsYGEPEoHumvTH+kvqp6PqJQrryWRYWVoKhHitvWaXWtKseMpA0We15mmN1wn1qzNdN7mam1RQy1Z1Lqm1/78wjX/cDcMESUBS9/PZpAuIfOQWkZIjEeNuFbcW1iPhyZtCls5eHbD/DtiX8q24H59S3QgTvF3Z+pPeBRq+vuul4IssxY0ceVrtLXn0hecbhjcLmwwhEsFgENb8Mm5NDuX+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1dA8A3QiVtXTMHvQGMJBvGycEyDTnNvWurcj9uH3qg=;
 b=SNsGsSUibrBBIengxi7D7kOPKSjHCxJ6rDAzOdB+v8Rs7eIw/z6fJWfNB14nmTbubfldfclvBelzgBzy/otG40+tEqVtnfYdENAm+dzeSohbvhVwPtjpiRJEvAzI1RcEtHuP/xefqvXVIbY39jbfvyZ5fa1S/Nrzj4to7K9sInY=
Received: from BLAPR03CA0068.namprd03.prod.outlook.com (2603:10b6:208:329::13)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 01:49:41 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::97) by BLAPR03CA0068.outlook.office365.com
 (2603:10b6:208:329::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 01:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:49:41 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:49:40 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v8 12/16] cxl/pci: Assign CXL Port protocol error handlers
Date: Wed, 26 Mar 2025 20:47:13 -0500
Message-ID: <20250327014717.2988633-13-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9c80a4-2070-4d5d-6f3f-08dd6cd1a40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2vwxi2BKYzuWbmvL7W5d6uoWnqz9GDXU0z97BTd5XKZ1sZpP0YjI0M84hZp5?=
 =?us-ascii?Q?GGsgSpp602mAvcu0TpRZ3kFADzFxtTiU/IRNxmx3b4Us/ymh2+zxAS2zqrt6?=
 =?us-ascii?Q?jE0xYUvosFNccHcviGafXK7raQDtyEFWYm2ag77hObRWm8yKI2zpTaEF5biL?=
 =?us-ascii?Q?KuXe0Ek3wnd31uFUbp9yBwI6xa6MNJhXS0qpj9bT+VvRVUNEUKtpOP5YZQP1?=
 =?us-ascii?Q?Arsa+1rdYSNhZerOIG/m6sJt8JuHS0CmX3XdiTiv4iIs445EboIZIv6GO0vl?=
 =?us-ascii?Q?0CMi2TspdPkWbO+SudZgWD2n3KVzKep5DBsFyWy9PAZJDlA3IzpNI5bL1hGP?=
 =?us-ascii?Q?dJbSpJkGrIiemnGMZb5KwpeXzvMfDz7/fz6fhMsU4xJhr2zzPNmZarUycnNM?=
 =?us-ascii?Q?XGwh2lrMcowvfeWELEAs/BOLXk72BJrGvB9fG7JHKvFz0y3gQR2/zpLbvT/k?=
 =?us-ascii?Q?+JV+arC0Rf4UoatfaEF0tvWedf7T2yj4qSsK5X39eiBXhsmj9usHnlH29+q4?=
 =?us-ascii?Q?Pgaipyg1AX5Zwbv6lkGBMhl/Zb7tVnJBQ1ODN/1nXzAxdBBcdPhwIrm3kJlY?=
 =?us-ascii?Q?8PcCf6avtVZ4r4j5TLRzBu89U6I5kn1Keeu7Q6P3DDX7KPuEUnQojC0mXEbi?=
 =?us-ascii?Q?rTAolpsGPCdgHsX3SDjjRGe3V5BMT/MTY0V0B4QGO5MLC0GfRsEoN9dwohYg?=
 =?us-ascii?Q?3GxTTzL3H4qX7gS54LCUwlBzvx68fZDcfybOFzYMV+rdGW6htX+m4R5aM7tB?=
 =?us-ascii?Q?5NLGnbP1NJxX771iXmz2MxUG2LD0kbNMzQzCI74KlUIwNQKtKnvz3WinQsP4?=
 =?us-ascii?Q?YbW8HNsQ4xBVEY1OVX0NIRzUqVuXNGJxFi/Phw6SYqxTo+iwMKxlcJ3x47yK?=
 =?us-ascii?Q?ROVj7EppTBC5wHQV0mQ/m3Kd3k67P+SxKDW2bOQzpgQy/ENAk+JiN04R7IZA?=
 =?us-ascii?Q?mcwakgHyX1A246f+WFr5008sEXWcRGLC12l2qBmrMYPVp5zLDYe1tXZVuqr6?=
 =?us-ascii?Q?iOQRBpWC9TnfMCt4pGrrfRGcEl+0IpRdcCGGZZcawCphti3+qdwRvrUMys4q?=
 =?us-ascii?Q?QnOaK/4mr7DJOZQA0v66DtO6MulbQUp8TKdOXxI7PXQngYzK8v1q57Rcqupu?=
 =?us-ascii?Q?Ugacx9racPhZInMC6ZWT5CK5YM3q9nKiN0IxaaBUfnkT9s1CApsWVMRMxiye?=
 =?us-ascii?Q?TRwrhOXQ9p87+cq+X67yerhurpUCjXKGPHR1f5mKsrrZaxHnmweGLhQicfDs?=
 =?us-ascii?Q?6av4IUenT1fEEIu2tJX06M8Pz91VedgMnhbTTXRw/EVrMNn5qi7y3FxfKRuQ?=
 =?us-ascii?Q?hjWZRq4yIMEXn+D5RkuVQ0YXZB/GFHbWm3pXiqjX4hFZjyTHpvwCoSMqzD6m?=
 =?us-ascii?Q?pSsCMoUaXOoAZVSmW8ZpQRBEVK2ROlFtrXootwuedP2M8ZSXPMFLdYQh7I7b?=
 =?us-ascii?Q?EWQ22Z24iWaZ6PLnkGUXfmLALMmIpgDookBsj33pFLd3URs6lPQYisuCOSzl?=
 =?us-ascii?Q?qQiXJHd9tbXDulw9ewya3TXV8ZnDHbRexD89uFLATj0rS9GbjDiRWIXpmw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:49:41.2343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9c80a4-2070-4d5d-6f3f-08dd6cd1a40b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

Introduce CXL error handlers for CXL Port devices. These are needed
to handle and log CXL protocol errors.

Update cxl_create_prot_err_info() with support for CXL Root Ports (RP), CXL
Upstream Switch Ports (USP) and CXL Downstreasm Switch ports (DSP).

Add functions cxl_port_error_detected() and cxl_port_cor_error_detected().

Add cxl_assign_error_handlers() and use to assign the CXL Port error
handlers for CXL RP, CXL USP, and CXL DSP. Make the assignments in
cxl_uport_init_ras() and cxl_dport_init_ras() after mapping RAS registers.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/core.h |  2 ++
 drivers/cxl/core/pci.c  | 23 +++++++++++++
 drivers/cxl/core/port.c |  4 +--
 drivers/cxl/core/ras.c  | 76 +++++++++++++++++++++++++++++++++--------
 drivers/cxl/cxl.h       |  5 +++
 drivers/cxl/port.c      | 29 ++++++++++++++--
 6 files changed, 120 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 15699299dc11..5ce7269e5f13 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -122,6 +122,8 @@ void cxl_ras_exit(void);
 int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
 int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
 					    int nid, resource_size_t *size);
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
 
 #ifdef CONFIG_CXL_FEATURES
 size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 10b2abfb0e64..9ed6f700e132 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -739,6 +739,29 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 
 #ifdef CONFIG_PCIEAER_CXL
 
+
+void cxl_port_cor_error_detected(struct device *cxl_dev,
+				 struct cxl_prot_error_info *err_info)
+{
+	void __iomem *ras_base = err_info->ras_base;
+	struct device *pci_dev = &err_info->pdev->dev;
+	u64 serial = 0;
+
+	__cxl_handle_cor_ras(cxl_dev, pci_dev, serial, ras_base);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
+
+pci_ers_result_t cxl_port_error_detected(struct device *cxl_dev,
+					 struct cxl_prot_error_info *err_info)
+{
+	void __iomem *ras_base = err_info->ras_base;
+	struct device *pci_dev = &err_info->pdev->dev;
+	u64 serial = 0;
+
+	return  __cxl_handle_ras(cxl_dev, pci_dev, serial, ras_base);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
+
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0fd6646c1a2e..83d331c82d91 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1348,8 +1348,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index f18cb568eabd..fe38e76f2d1a 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -110,34 +110,80 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
+static int match_uport(struct device *dev, const void *data)
+{
+	const struct device *uport_dev = data;
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+
+	return port->uport_dev == uport_dev;
+}
+
 int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
 			     struct cxl_prot_error_info *err_info)
 {
 	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);
-	struct cxl_dev_state *cxlds;
 
 	if (!pdev || !err_info) {
 		pr_warn_once("Error: parameter is NULL");
 		return -ENODEV;
 	}
 
-	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
-	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)) {
+	*err_info = (struct cxl_prot_error_info){ 0 };
+	err_info->severity = severity;
+	err_info->pdev = pdev;
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport = NULL;
+		struct cxl_port *port __free(put_cxl_port) =
+			find_cxl_port(&pdev->dev, &dport);
+
+		if (!port || !is_cxl_port(&port->dev))
+			return -ENODEV;
+
+		err_info->ras_base = dport ? dport->regs.ras : NULL;
+		err_info->dev = &port->dev;
+		break;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct cxl_port *port;
+		struct device *port_dev __free(put_device) =
+			bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
+					match_uport);
+
+		if (!port_dev || !is_cxl_port(port_dev))
+			return -ENODEV;
+
+		port = to_cxl_port(port_dev);
+		err_info->ras_base = port ? port->uport_regs.ras : NULL;
+		err_info->dev = port_dev;
+		break;
+	}
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_RC_END:
+	{
+		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+		struct cxl_memdev *cxlmd = cxlds->cxlmd;
+		struct device *dev __free(put_device) = get_device(&cxlmd->dev);
+
+		err_info->ras_base = cxlds->regs.ras;
+		err_info->dev = &cxlds->cxlmd->dev;
+		break;
+	}
+	default:
+	{
 		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
 		return -ENODEV;
 	}
-
-	cxlds = pci_get_drvdata(pdev);
-	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
-
-	if (!dev)
-		return -ENODEV;
-
-	*err_info = (struct cxl_prot_error_info){ 0 };
-	err_info->ras_base = cxlds->regs.ras;
-	err_info->severity = severity;
-	err_info->pdev = pdev;
-	err_info->dev = dev;
+	}
 
 	return 0;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0d05d5449f97..512cc38892ed 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -810,6 +810,11 @@ struct cxl_error_handlers {
 				   struct cxl_prot_error_info *err_info);
 };
 
+void cxl_port_cor_error_detected(struct device *dev,
+				 struct cxl_prot_error_info *err_info);
+pci_ers_result_t cxl_port_error_detected(struct device *dev,
+					 struct cxl_prot_error_info *err_info);
+
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
  * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 1b8dc161428f..30a4bdb88c31 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -60,6 +60,24 @@ static int discover_region(struct device *dev, void *root)
 
 #ifdef CONFIG_PCIEAER_CXL
 
+static const struct cxl_error_handlers cxl_port_error_handlers = {
+	.error_detected = cxl_port_error_detected,
+	.cor_error_detected = cxl_port_cor_error_detected,
+};
+
+static void cxl_assign_error_handlers(struct device *_dev,
+				      const struct cxl_error_handlers *handlers)
+{
+	struct device *dev __free(put_device) = get_device(_dev);
+	struct cxl_driver *pdrv;
+
+	if (!dev)
+		return;
+
+	pdrv = to_cxl_drv(dev->driver);
+	pdrv->err_handler = handlers;
+}
+
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 {
 	resource_size_t aer_phys;
@@ -118,8 +136,12 @@ static void cxl_uport_init_ras_reporting(struct cxl_port *port,
 
 	map->host = host;
 	if (cxl_map_component_regs(map, &port->uport_regs,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+		return;
+	}
+
+	cxl_assign_error_handlers(&port->dev, &cxl_port_error_handlers);
 }
 
 /**
@@ -144,9 +166,12 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 	}
 
 	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_dbg(dport->dport_dev, "Failed to map RAS capability\n");
+		return;
+	}
 
+	cxl_assign_error_handlers(dport->dport_dev, &cxl_port_error_handlers);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-- 
2.34.1


