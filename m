Return-Path: <linux-pci+bounces-15366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932239B1172
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5606D284CB8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6DA2161EC;
	Fri, 25 Oct 2024 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xfuojr6F"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BF120EA27;
	Fri, 25 Oct 2024 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890354; cv=fail; b=rjbEU0b8nbHCZMBEzuM7u+mYWo6Mvx/uxWuxWE/0LhrRVaJ5giW9rsd963eefwSvSE9PKpP4prwr/kc3EbzeXpp3u3YOepsW3AUI6LDLrMHn5tCodwyQGbHkNKslQekoSM1siDWiTaBAVTn7uX5fH8DWOtX+tFSg8Im8EIwPu6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890354; c=relaxed/simple;
	bh=QwmU4aamTKwOqXSIIHut5wxttWDNqtUGvIOD4OwpOnU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jj7UuQDVlsI7EyF3YcNKlQasEv13jIu1q7NMYjKwpiHuTlducR4ucgZmF7Th5c5E2syI9FfzsjVclyjlDjs4KzXw9wCwu1oIkA8T/Xm2q32Jes5Ld35MefbkEPnHxDTjaNMhokE2j3FjTnkzYVYf7SgdEZxzkkEFRJbcSyo3gio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xfuojr6F; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwWtJKNMfS/04Wj+X/sSQrygvdlSSZ/pd4zuD5V+9Oq9kYjvzs3IOht2W/RYVa/wsn3mRq/ZUfXXd0FMCoy6sZlDQ7BwLolSxtmW9RZX/Nju+p4w2DREZw/w7eDGVP4pN4qut16sJcY04Drg1pwa0Xh3OZ4IOKTaN07sEXqsSxodDA3ajTkPBoaDOo26UznJzWG0oNK5dzot7BVzOuQoTeml1IHGOlC+OakiNqPLlG3HnnWGuUNAUk1Jo1X4R1U/8E0A5qS7wIsfNZWB7t3YwxO1XvqfmRZoE1rixS34OKUngEl+38W3HU4WG9l3YOH8a1rRDktzTxitDpZu23h4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkHkW2x6pc1dmmvxlTCsggWBfgCbm/GbyOOLZ6im680=;
 b=elCvVCCWQTOTm93r1WwW+R+rQW+dEVe5Kmw09SXs9xCL2Q1UvpSwkfvDpLIJVIsRD+kXigsm4a55pAOJ2etY71sS/xrehtJnVlVucBIq2xcHjuP8WbQC+COnoOJuImCq7qJuEtDIrK9zMQNkNA0Nb9GLuFC2+srsaKg1yTXI0LDP+ODQ480/cpEtgwkrL+ZSKdVu5U2vQpVZ2J7IdwSFVYzmEJj3M/eUWbB+LVLIhaibEUbdctDarzbeSbEyY0GcrNAJbY9WFs80rXzuPRZp5alhCGXvpAlaE1Rys+H+sZzU4KTbtJaj4nNmjPLV0hLmLrtLlzoTwYmI5o74ug4C9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkHkW2x6pc1dmmvxlTCsggWBfgCbm/GbyOOLZ6im680=;
 b=Xfuojr6Fp0vhWVSK2DqDbKqGzeqEyCcjnpbAduueVjAPvvdfjO+PtyTnJzHzP/++tDvXoZ3UwnnhXe629cz2sGBx276FYuo9x8ZZshpNUPZnVXYSC/G8FtHm00DCct1IITyqXK/KLvG5NtL/HcDFW3Hf6HE4GYWeCkLHZigrcoI=
Received: from MW4PR04CA0296.namprd04.prod.outlook.com (2603:10b6:303:89::31)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 21:05:46 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::22) by MW4PR04CA0296.outlook.office365.com
 (2603:10b6:303:89::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 21:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:05:45 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:05:44 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 14/14] cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers
Date: Fri, 25 Oct 2024 16:03:05 -0500
Message-ID: <20241025210305.27499-15-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0fa4dc-03c6-4606-2fce-08dcf538cb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pvAbYul0Tz640cwlwg5vAlhTNwn+u2lb8l76RVKhNlS1vGXAvXXDURoCNneo?=
 =?us-ascii?Q?ob68edNM5oiXnjNzOC0pi2EllbqsJHSS8oV3YVi/Hv0E40Atz6dmnhop/7ON?=
 =?us-ascii?Q?+p/12k1DZToIZYlzQmlPTPup9BtDyME1vIPmDKvSDx6vXELyxqQKWk1fIjcf?=
 =?us-ascii?Q?2Y/yE0SuBeqIoa4k+XXnOTZaTli6zl6kW9htnKK9Crnrg74UMxmCkB19wz5Y?=
 =?us-ascii?Q?4aaEnog++7/gi7WsYCVNxDtiivcBW9htiZVAlNaGZiICLeMCEnjP3fQsLdLK?=
 =?us-ascii?Q?9alJ8CMiSE08EvdOmpL2bPt8MoGcJtY5znFi88x+TSD5kfq9E/uMEltdUWSA?=
 =?us-ascii?Q?7cBOfdSTXNG4Eos7d8D6WjV4eQ9jmCpRWsIOYtDx35I4rfUAX3mfjYp9fCCj?=
 =?us-ascii?Q?5Ds6mS3bgsbwBD9VD+JDutKDkQNrHvKpvXAW0adwl2ko6O7yT9wIFImhrW0u?=
 =?us-ascii?Q?46PiFCY/ckIZuonaA95fPykMekNVyT4pxSdNr6Sc2OOLAlLlIOO+I1A035BY?=
 =?us-ascii?Q?ngV1v2sM1oxrxBgBkVL8Q3pR1oy5Iybat05O3I0ck4wcDPwpyH18/4OVpayh?=
 =?us-ascii?Q?WsXeAOSZVXRakYB4ZVEbElqkBqKfDih8uIPaDwBhkSCH58oUVoSN9Oy0goUE?=
 =?us-ascii?Q?OdHQSxX/zyu58RjHYwMlPiHuxsJgXR/LOKLEbNeWGyPsc09clnL2x900AR9Y?=
 =?us-ascii?Q?Re66n0WuKYsBTWLMZoHEIbUZWzJk+8tH0qwSPtJ1550KioSVVEy9ECNyJ1Z1?=
 =?us-ascii?Q?841RkFI2mMsC/We0nc6tPguYJp/Ahn0vV7fQQf2PdulFzq2EIMjflqRyswfT?=
 =?us-ascii?Q?zW8wVjyzincI5iXT32kQ3TPYK+9YTIMsjRI56QG1mo/EH9M59k5xyDY/gItZ?=
 =?us-ascii?Q?c9S3Kz8/7KZ9TIgwr8I4yKyly6i+HUcG35qQvFjNa73QLl+B/BDsJY8ylVus?=
 =?us-ascii?Q?SvMtb7J76Sl+jA+VIflbUkdH+kHgLp8LLCDEbnYkVes6ZOXoLfkC1g/P4E4b?=
 =?us-ascii?Q?QOUJejER+Cr7RNRUR8RRN/DRgp7qCsaCzkVE7QfDxIqC9uZTFozs3g7wAW27?=
 =?us-ascii?Q?mizH3yVGcRaOXIDNxBlzBKqemgrSy0eA6AParZiT++2jX0l00dNIpWl3pGGl?=
 =?us-ascii?Q?FFJJxPe+H6Umt5Ao+H7QN+oZQC0b2g3471zkr7pHGcLueFMvEtQSNDpFwej2?=
 =?us-ascii?Q?7mS1ImpgUHCT83j/Af6k142SUrOaAtbxl3P0x9rAt5rpGy7ZaSEVuU6vL4w9?=
 =?us-ascii?Q?CcNQvmrkWsLJsDLGFUwgLjiUCZpXQ9Lx5Nwe3n7/Ttroom+f44IGqr4GQ98U?=
 =?us-ascii?Q?LqVXc608lorClO7vt3pCTXp08YcRVqD3i99T6fshNIbwZHb0eCqwb5TU3Npd?=
 =?us-ascii?Q?4qYhB8JNJhPcsABvEmOtT13XVeQB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:05:45.8583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0fa4dc-03c6-4606-2fce-08dcf538cb79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327

pci_driver::cxl_err_handlers are not currrently assigned handler callbacks.
The handlers can't be set in the pci_driver static definition because the
CXL PCIe port devices are bound to the portdrv driver which is not CXL
driver aware.

Add cxl_assign_port_error_handlers() in the cxl_core module. This
function will assign the default handlers for a CXL PCIe port device.

When the CXL port (cxl_port or cxl_dport) is destroyed the CXL PCIe port
device's pci_driver::cxl_err_handlers must be set to NULL to prevent future
use. Create cxl_clear_port_error_handlers() and register it to be called
when the CXL port device (cxl_port or cxl_dport) is destroyed.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index eeb4a64ba5b5..5f7570c6173c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -839,8 +839,36 @@ static bool cxl_port_error_detected(struct pci_dev *pdev)
 	return ue;
 }
 
+static const struct cxl_error_handlers cxl_port_error_handlers = {
+	.error_detected	= cxl_port_error_detected,
+	.cor_error_detected	= cxl_port_cor_error_detected,
+};
+
+static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
+{
+	struct pci_driver *pdrv = pdev->driver;
+
+	if (!pdrv)
+		return;
+
+	pdrv->cxl_err_handler = &cxl_port_error_handlers;
+}
+
+static void cxl_clear_port_error_handlers(void *data)
+{
+	struct pci_dev *pdev = data;
+	struct pci_driver *pdrv = pdev->driver;
+
+	if (!pdrv)
+		return;
+
+	pdrv->cxl_err_handler = NULL;
+}
+
 void cxl_uport_init_ras_reporting(struct cxl_port *port)
 {
+	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
+
 	/* uport may have more than 1 downstream EP. Check if already mapped. */
 	if (port->uport_regs.ras) {
 		dev_warn(&port->dev, "RAS is already mapped\n");
@@ -853,6 +881,9 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
 		dev_err(&port->dev, "Failed to map RAS capability.\n");
 		return;
 	}
+
+	cxl_assign_port_error_handlers(pdev);
+	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
 
@@ -865,6 +896,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
 	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
+	struct pci_dev *pdev = to_pci_dev(dport_dev);
 
 	if (dport->rch && host_bridge->native_aer) {
 		cxl_dport_map_rch_aer(dport);
@@ -883,6 +915,9 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 		dev_err(dport_dev, "Failed to map RAS capability.\n");
 		return;
 	}
+
+	cxl_assign_port_error_handlers(pdev);
+	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
 
-- 
2.34.1


