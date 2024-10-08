Return-Path: <linux-pci+bounces-14009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D359959EC
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A396286580
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080E421643E;
	Tue,  8 Oct 2024 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qe/rSks0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FA14A82;
	Tue,  8 Oct 2024 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425874; cv=fail; b=Qa5ZwTL3TDQby7tnyTi5Civ/ImzCISDLVir7LLsoXgUV/yLorTBARYfgvaHUabKyXWM5ljPlOkW/dwyIxCjKJPaLF0v3xBjlukcPt+qanW/woAqIK6maEJ2J2lovSxIcAkyrNjlQ1ogGSYKyQWOhz29Df53dhtkcJlruzzD7E0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425874; c=relaxed/simple;
	bh=QbiLpf1nxlmgh3430zRD8OWfiRaabwpPK/jw9ikl7y4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FE31vkiM+wAnaomry6N5yysHqLwLd7P3abmu0GwVyDP0wEUQo9OlNSX6Z+Snpr5XrpWQhPL0I0UbLusnCtmK0eAzjU6ymklcWJlV1x2u+CikmfEXcut36IH/a4oWhYFJIxAZKE78YAaeBc0aI+HvVumFoCLPm72qxRYGGeVtDVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qe/rSks0; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDuacETvcGN2s2MxQDKMz0wjdmJ6oNrvvJOjStuhqgtGhu7mcNwcLD/2kVoUasYXXJ/Hl6v5LrCckSm1DanvlPQUOAcbUFlKlE+N876eTkIaSJCqRpPuR7g34/sawmFoB/Hlqsxigmme4cCCkPW0iQL2JjvIsG6aYYw7OGY1y1RhBT5JdC/+VWIjs+SwebM3WVG+WVRkMu2CHH6kPoDVtzkCy3ZmRjHzhP6VyLON4KL4WYrY9Bk7tsbMggH8VYYB8DCegpXzBW1UupU2C4zEznsRgLkHk4+ZoWJwHQ4UnuZDBrZ5u42ZKdWRdbThys7u9Askc8V8QX2K+XpH0fBnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4NymEgzEbnfYrhvaxAPu5Q4T9jwhLX9jJl+5ih2zss=;
 b=QIjGN/C4YACZb/DD7bg7VjWUO6Je04rb7BCSbK+wRUEwWKtloq4vwWE1PZ7K0iT3eFoSgEdl2wk72XU4RL9qu6NH/szSDw03PHOuIfWLs7HT74+xn9iGd3+PBAXjsRmNJHCTtl8PuieJWjm2wtuSP0tMGG2t2G1C6484SVBNb5ZRcy50TP0sEkTtqvX51YqUH7YWBT3HbEu48mSP1s769T+SXfi9HDBXwsRdYjfCyv8yJpELMtnB4GR4+MgsuMzl/Ef2C8f1rSPejlwjCAhwG64H47BgO/9babHtX+f+L/W9UgvALcmtayq5brO9MvhfMhTzjBHQFBoaYjSYwJ8QMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4NymEgzEbnfYrhvaxAPu5Q4T9jwhLX9jJl+5ih2zss=;
 b=qe/rSks07o4ZF0hYFVyWrdcFWsIzUuLBaNOOD8zWu/GVbBwMLaYR6qbiEHR3VBqwA2IE6gsCJnUQuy4R+zIlX/A8n4cFcERLrUnkwFazx7WVnXzbgJxlEtPMCcy3bt35CKC9iAz5YgO+qRR0G7x6g5nmDkQL3JavZUNrzS+EPts=
Received: from BN8PR04CA0040.namprd04.prod.outlook.com (2603:10b6:408:d4::14)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 22:17:49 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::44) by BN8PR04CA0040.outlook.office365.com
 (2603:10b6:408:d4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 22:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:17:48 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:17:47 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 04/15] cxl/aer/pci: Add CXL PCIe port correctable error support in AER service driver
Date: Tue, 8 Oct 2024 17:16:46 -0500
Message-ID: <20241008221657.1130181-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc0c316-2105-4fe0-9291-08dce7e70ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ptiPZ+PGN7KbxApiYVHw6Zy26jB34QOIO6ZO/v13fZdN6ZUz2U0xiv49JO7y?=
 =?us-ascii?Q?06KNqWrr5osipkeujnG8sONl+gZqs/EdMtDv4vTz0R6dPZpR38ikJTElWZPq?=
 =?us-ascii?Q?qxE8Tknik8+/MdNocr45dYGg9dLJFT0PmkEL6S8Wym+yNm7vwpTZ4QSj5c4r?=
 =?us-ascii?Q?pSMy0sdFkNeo7EtNFoE2xNgwbJRwEg+2N32WEe8C06zVC9euHhsP0Y3TzxHW?=
 =?us-ascii?Q?qidjwRFuUomBUK/2bcV/9nOKmJoo2ACEXDmnlbrJWup5RMHf5rj+RvwkJ6SV?=
 =?us-ascii?Q?bfNrjMc+EXUJIr08e5O91gNT2FEUkqHCbFd673cZLVQ7f5En+utnEPcwEB33?=
 =?us-ascii?Q?/X/zLhDqiK+7y3g7No49oZxNnztXazW6iFM4zY7BOl6q+rrqW48gMpryWd+m?=
 =?us-ascii?Q?zpCJFTno9I+Z0dnVd2p0V+awrdPA/D2DnitEjZgvdxhYog6+jPrOc4X9kRdh?=
 =?us-ascii?Q?+3UunEyQSfhM1+m/1eii4hiGaS8Ey/toMiOPAe0g84TPbJiWI7/D89OIUgTn?=
 =?us-ascii?Q?FrMPhRtT153zFe2zQakS/g1Cr3uV5bo+XBMTo5/i3v1WiSE0maxBdHQP2zUO?=
 =?us-ascii?Q?KP2cDqIarenoehXo/m/0aBQHRe9NdnQ30JUilCtUB2sSjDqyvCNssmw9kJss?=
 =?us-ascii?Q?NRQhwAz5RLuUnGQXbOp0A9JQOjcV8b4+PWQQZk0pitpsQ1mro5/It0NZmQg3?=
 =?us-ascii?Q?l4GIAN5V1VRU/jpJCirERFC+shvJRm10PQ532deXmF7JqKYOtOeSlXEwHGrr?=
 =?us-ascii?Q?uZ05KdRfIlhzts3RYCWM+yeFHowhn0YEttUlJk0q7fV5ipW3BHxZpO81X2LU?=
 =?us-ascii?Q?dw1dbZAD9f1YYJTx9hEJshjsTWHkktXqW1br3n97Rwne0zK54L0Z4UOo+MM1?=
 =?us-ascii?Q?1xIfOtDuYSCNoCmOMXRV/KAuJEoJrOgnsf9FT5aA8Z3TurWMqstYK4+7SmCA?=
 =?us-ascii?Q?4vEw0kotHPLRjZhPY9AZ4qYZKV6swD8BNKnqpxE//2VspTCaLg+C3eRnfZTm?=
 =?us-ascii?Q?gL7YoNAPOfLsWun/NY6BjCkP/BaMH67aUuj9YhZ14fO/bYQdaXHPS79OAfol?=
 =?us-ascii?Q?Sh5KRByPi5cL7pPkBep2splmPPH71TY692z4UkD+Je8ZTw44Qj1x1fGuhoJw?=
 =?us-ascii?Q?7sKNQRt4eSqPfNwxF9qhxB17HSowOazRtAYlg2ooqXXNy8jRZIvMdAGbYpKO?=
 =?us-ascii?Q?grEbwbXdBOiA65ORXzcCz97c/viC5vZpBM5CmqPaZZ77PrttGzoc0HkaQvty?=
 =?us-ascii?Q?B2Y/S0S5PrRIvUNbVNGJFVzc6GDHqeTl9KO+YPRlAeZorBxiWeL3CJyeC+eg?=
 =?us-ascii?Q?d4KIovOqTOIdlBTFlkH+ZLNPbYl0BuLtsU5Z2qmHPxr+RJXo7SVTzSNj78U8?=
 =?us-ascii?Q?tAzIS6Hnb0uSasv/UY+AE9NboC0D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:17:48.3758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc0c316-2105-4fe0-9291-08dce7e70ace
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577

The AER service driver currently does not manage CXL PCIe port
protocol errors reported by CXL root ports, CXL upstream switch ports,
and CXL downstream switch ports. Consequently, RAS protocol errors
from CXL PCIe port devices are not properly logged or handled.

These errors are reported to the OS via the root port's AER correctable
and uncorrectable internal error fields. While the AER driver supports
handling downstream port protocol errors in restricted CXL host (RCH)
mode also known as CXL1.1, it lacks the same functionality for CXL
PCIe ports operating in virtual hierarchy (VH) mode, introduced in
CXL2.0.

To address this gap, update the AER driver to handle CXL PCIe port
device protocol correctable errors (CE).

The uncorrectable error handling (UCE) will be added in a future
patch.

Make this update alongside the existing downstream port RCH error
handling logic, extending support to CXL PCIe ports in VH.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pcie/aer.c | 54 +++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index dc8b17999001..1c996287d4ce 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -40,6 +40,8 @@
 #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
 #define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
 
+#define CXL_DVSEC_PORT_EXTENSIONS	3
+
 struct aer_err_source {
 	u32 status;			/* PCI_ERR_ROOT_STATUS */
 	u32 id;				/* PCI_ERR_ROOT_ERR_SRC */
@@ -941,6 +943,17 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
+static bool is_pcie_cxl_port(struct pci_dev *dev)
+{
+	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
+		return false;
+
+	return (!!pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					    CXL_DVSEC_PORT_EXTENSIONS));
+}
+
 static bool is_internal_error(struct aer_err_info *info)
 {
 	if (info->severity == AER_CORRECTABLE)
@@ -1032,14 +1045,22 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 
 static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
-	/*
-	 * Internal errors of an RCEC indicate an AER error in an
-	 * RCH's downstream port. Check and handle them in the CXL.mem
-	 * device driver.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    is_internal_error(info))
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
 		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+
+	if (info->severity == AER_CORRECTABLE) {
+		struct cxl_port_err_hndlrs *cxl_port_hndlrs =
+			find_cxl_port_hndlrs();
+		int aer = dev->aer_cap;
+
+		if (aer)
+			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
+					       info->status);
+
+		if (cxl_port_hndlrs && cxl_port_hndlrs->cor_error_detected)
+			cxl_port_hndlrs->cor_error_detected(dev);
+		pcie_clear_device_status(dev);
+	}
 }
 
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
@@ -1057,9 +1078,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
 {
 	bool handles_cxl = false;
 
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(dev))
+	if (!pcie_aer_is_native(dev))
+		return false;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
 		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
+	else
+		handles_cxl = is_pcie_cxl_port(dev);
 
 	return handles_cxl;
 }
@@ -1077,6 +1102,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
 static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
 static inline void cxl_handle_error(struct pci_dev *dev,
 				    struct aer_err_info *info) { }
+static bool handles_cxl_errors(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 void register_cxl_port_hndlrs(struct cxl_port_err_hndlrs *_cxl_port_hndlrs)
@@ -1134,8 +1163,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (is_internal_error(info) && handles_cxl_errors(dev))
+		cxl_handle_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
+
 	pci_dev_put(dev);
 }
 
-- 
2.34.1


