Return-Path: <linux-pci+bounces-40255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5F1C323D5
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6244134B0A9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454E833E35F;
	Tue,  4 Nov 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lVfQPRSo"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724833FE18;
	Tue,  4 Nov 2025 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276053; cv=fail; b=s8UAxWDVkK0WZXEy8D1TwMHbtEHm8+IERJLHDHebyUHIRGYT4Jkw9cE8uX4FEASrGl1JG/fp4vrhVy3argQr8RvMV2XghiNA3rIJF5wd3nOy0FOM3c8sKG2pGH1A70UWoR9m02yT8pmK9hxinyb6IGCrObzIaIFsFhLN5U6AA2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276053; c=relaxed/simple;
	bh=xnt9gfTLF346+n7TGCx6H20NiIYQwRLfWOPixRm0n9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKSn9/QpK5iANtmj5p6AtxfhbepXTspK/5jyd7nxOctJqjXlkAwivw4abL42BUBBJ7amqrP9sHgDi9e7s3qwt93raAECnercLQLaQOWtWiDN3bFCIyOAv8JGzaxV9x/mBmzDrNT5LyyE9ISIGGyLCt749jM5PmtQ9D8BeTmdH4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lVfQPRSo; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxAWu0Hk+qThJWpEggJAoq+QyPhBy864jB151gg9//AH1fMpydjIAnOCIoAkouPPrvUlGuHpfQ1o96w4PmRwWSoOEmw+YWXk9b+kasR9lzx5yBY/gw21rGuTN1UJyI1paUM6GwPQZ6QtE2cND/8lmcSWXOI2buh5BGV5yNKhb3w2sBc6N0q4+TgWQgHDGtRceKWr9v5kpSVvass4S2/j/ibS1p4QiA+6qxb8x7oYnrtVUL+ZtPCrv1MDBNy+GikxTVjt1FlE4spbn45CQ0NjnAjoDEe/YpAqMEPzId+p61XvX3avcPMwCyg5WGvwaSBY6f3lIhJRRHCoUZj/TKYSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ICirNXLLVFMYfDnb5Tr3CWCVcWqcMzrDsF8+eJVA+4=;
 b=lN4DuIrneS766WL4qLSolyzUCrijFvq7s+7iHVE64P5FFLmy6+4ZfboI32iKpGA7oC24VWNe8dlwyRhXjirT0XCo5q4rxGcKjtc08x16nxZpYiGlSYyL2Q26DGMalcZgILZp9HrH2bCNTFLW/xig2i6emtVbsDniddGJi62Ux8yTfQYUPF5F6gXQ5rAlqtPVZg+FsLVlfNPZ7khVzzozCBJrc+AZ8AWrkwO5Wv0UwsiuO7aEhOmKCUzghiV62C9mDY2ji2i0XF0u/EkvmyutDEX4uib/w0/7BX11IqoAYO6YWsPGSJXDDH2HrzF2DoLdAIOPEdBQ/e9pQPbRY1c/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ICirNXLLVFMYfDnb5Tr3CWCVcWqcMzrDsF8+eJVA+4=;
 b=lVfQPRSo4lEAfjzmLV6z3r/xb3T+VEV42bV4+tymFGGh19jB839k3ZiurkbdXkgEIvt2CosgW3zMXaBx9txnK+jB3742kqOCLDmwQOWVdxvlemqOCxYj+0j4Ijj7xQPjGpID40X+JEH/wmTA4JQRroTD5Tpa8kuQIc4Xs5+IQck=
Received: from SJ0PR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:332::23)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:07:28 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::3d) by SJ0PR05CA0078.outlook.office365.com
 (2603:10b6:a03:332::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 17:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:07:27 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:07:26 -0800
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
Subject: [RESEND v13 23/25] CXL/PCI: Introduce CXL uncorrectable protocol error recovery
Date: Tue, 4 Nov 2025 11:03:03 -0600
Message-ID: <20251104170305.4163840-24-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c34764d-eb9f-4f44-d959-08de1bc4a1fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q6y8aDv6N8BC0cQwS+mhfEg/aAPH8XInB8Ne9+UYfcjfTJqtVz95wPS74sRk?=
 =?us-ascii?Q?8xylSRi9OhWnU5/3YKquEcDZ8cU/JZNJIf7H17NaUkver0A+Ioh5yZQ4/pPB?=
 =?us-ascii?Q?pF71WHSyh/M1jn4s/1ggcZhPJfRL7Z9u0PB2XJqFGwDgsM80DjTAspdl+0Hi?=
 =?us-ascii?Q?iPD50vhdvMFvTFq5Pb0zTR6UBHLS3i70NDz7oWtJrcKgABOBEU4Hs1+PG5uC?=
 =?us-ascii?Q?vLRBooNzAg5kvntY5RSE1NDZSvwOYtGUJcBU9Eu6Qs2eX2T0FIfUmfOrVlS7?=
 =?us-ascii?Q?2NVNyj9JDTmeZywDCQqs4LN3lL2kZorhC2czRrp7tE3H8q8sqeyEKJmcFfHE?=
 =?us-ascii?Q?OFTqTMCKWtz0ENSkYTz5KwflLHVpS6x2zdvnSrI9ktTWzPID9H0eyRTHPO93?=
 =?us-ascii?Q?Qtu+q6jFJT9Z2Ua9r9qr20x1YTTYTMUqaRHEK9BG+qxR3A10oqE5sBlgdB95?=
 =?us-ascii?Q?Cp2iw3255hJiAqakP7keTVC+ywRDOcTnyAakOj120RQitdjFPpN4T+Px/7fe?=
 =?us-ascii?Q?ZsF9Ebij/VcuXPDtxvmXQ83d55IZwkDT6Xi3vyF1yZeQpl8DelIGoTkSPi2a?=
 =?us-ascii?Q?nDr4xWfDyqMEe7E/4T4uKjdjlidsz9owNn75N91qLpdyggDZci985r5PA00W?=
 =?us-ascii?Q?p6KgX58Qt9Y7RqG6xaFKfpTihprgu29kgPvtPuDeGSU9w8xQc7BwhwfZC/HM?=
 =?us-ascii?Q?63P25Wsds9Y+TwD2bZpBeQv4JIvX7dYL4GxoVQNMWRwna4jYEpiuMNuxiRJd?=
 =?us-ascii?Q?jw9yIsubJWEGT6GA76u8ml2D35MJqgiMgrXZRFpLZxo66AVH5qQdlaBhGnT1?=
 =?us-ascii?Q?LprcsVrVXDuNrP28QcHKP5Y3U8X/wySIK/HQBWzFOfOIV9pjv1YQm/sEAv0a?=
 =?us-ascii?Q?VivRrxZTId/L6xEHfIn31xW1LomN7DQIJ3m6HUr8WSWxUVRvZBbqRX/bH2n8?=
 =?us-ascii?Q?i5J40PfvyP/jXDdBB51909woPS1tDLQCqUuMHcSQ8DJ3+FJ9rdcoUgIXXGVq?=
 =?us-ascii?Q?DBhnF1zDb4+BRw15K1NWOMaBbRejtQ6EOGlXeyL/tiF5+vAoPh7l01zwNdcC?=
 =?us-ascii?Q?E0z7zMbGW1VUTS92I8G1bSwQwxd/GaWjG5QPW4fXN+idpWoqJydIucFeYZ4Z?=
 =?us-ascii?Q?1wpML9CpsrOxDvmhvAIzwwKfU/934U+p8UhhLELob9X1+p5dd+Xll+bNviVr?=
 =?us-ascii?Q?xW5vIn6G5nEa2X7BkXZIRYxKxjynRXg+Z0WtQEZxWfgkXGsbAQQsPC5gbTKz?=
 =?us-ascii?Q?wFTz5vo5I6Bha3Sxw28kwGy05KJKOdH+10nBoQ44isHd7738rgcjOtZ3EPML?=
 =?us-ascii?Q?QeHpOUu/Bdlie59btW9BYxXjYmtHKbTUWL5uq0Q1nbbTp4KQnbyW+0NRUf5H?=
 =?us-ascii?Q?B4RzeNLmofAwdpk/wDTVuC++nU67mHp+WsNKOQObSUoZljqlAUxyeYmQlwGB?=
 =?us-ascii?Q?0MhI61uq50lEcQ22RfbPjDtYCrSjqet7HbH7IY/nRWVOBJ6BIN1O/g+H3K+D?=
 =?us-ascii?Q?QKK0ZcZ0kALdI+HDxuC+HkhYPTV4o1cCSs810jqBL8lwxooMGqiVxP5pG0No?=
 =?us-ascii?Q?9BK6yp+0Mts7Qfzf90t1mNmFpnp9i8oMYGGfFQeR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:07:27.7155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c34764d-eb9f-4f44-d959-08de1bc4a1fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888

Implement cxl_do_recovery() to handle uncorrectable protocol
errors (UCE), following the design of pcie_do_recovery(). Unlike PCIe,
all CXL UCEs are treated as fatal and trigger a kernel panic to avoid
potential CXL memory corruption.

Add cxl_walk_port(), analogous to pci_walk_bridge(), to traverse the
CXL topology from the error source through downstream CXL ports and
endpoints.

Introduce cxl_report_error_detected(), mirroring PCI's
report_error_detected(), and implement device locking for the affected
subtree. Endpoints require locking the PCI device (pdev->dev) and the
CXL memdev (cxlmd->dev). CXL ports require locking the PCI
device (pdev->dev) and the parent CXL port.

The device locks should be taken early where possible. The initially
reporting device will be locked after kfifo dequeue. Iterated devices
will be locked in cxl_report_error_detected() and must lock the
iterated devices except for the first device as it has already been
locked.

Export pci_aer_clear_fatal_status() for use when a UCE is not present.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v12->v13:
- Add guard() before calling cxl_pci_drv_bound() (Dave Jiang)
- Add guard() calls for EP (cxlds->cxlmd->dev & pdev->dev) and ports
  (pdev->dev & parent cxl_port) in cxl_report_error_detected() and
  cxl_handle_proto_error() (Terry)
- Remove unnecessary check for endpoint port. (Dave Jiang)
- Remove check for RCIEP EP in cxl_report_error_detected(). (Terry)

Changes in v11->v12:
- Clean up port discovery in cxl_do_recovery() (Dave)
- Add PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()

Changes in v10->v11:
- pci_ers_merge_results() - Move to earlier patch
---
 drivers/cxl/core/ras.c | 135 ++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h      |   1 -
 drivers/pci/pcie/aer.c |   1 +
 include/linux/aer.h    |   2 +
 4 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 5bc144cde0ee..52c6f19564b6 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -259,8 +259,138 @@ static void device_unlock_if(struct device *dev, bool take)
 		device_unlock(dev);
 }
 
+/**
+ * cxl_report_error_detected
+ * @dev: Device being reported
+ * @data: Result
+ * @err_pdev: Device with initial detected error. Is locked immediately
+ *            after KFIFO dequeue.
+ */
+static int cxl_report_error_detected(struct device *dev, void *data, struct pci_dev *err_pdev)
+{
+	bool need_lock = (dev != &err_pdev->dev);
+	pci_ers_result_t vote, *result = data;
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return 0;
+	pdev = to_pci_dev(dev);
+
+	device_lock_if(&pdev->dev, need_lock);
+	if (is_pcie_endpoint(pdev) && !cxl_pci_drv_bound(pdev)) {
+		device_unlock_if(&pdev->dev, need_lock);
+		return PCI_ERS_RESULT_NONE;
+	}
+
+	if (pdev->aer_cap)
+		pci_clear_and_set_config_dword(pdev,
+					       pdev->aer_cap + PCI_ERR_COR_STATUS,
+					       0, PCI_ERR_COR_INTERNAL);
+
+	if (is_pcie_endpoint(pdev)) {
+		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+
+		device_lock_if(&cxlds->cxlmd->dev, need_lock);
+		vote = cxl_error_detected(&cxlds->cxlmd->dev);
+		device_unlock_if(&cxlds->cxlmd->dev, need_lock);
+	} else {
+		vote = cxl_port_error_detected(dev);
+	}
+
+	pcie_clear_device_status(pdev);
+	*result = pcie_ers_merge_result(*result, vote);
+	device_unlock_if(&pdev->dev, need_lock);
+
+	return 0;
+}
+
+static int match_port_by_parent_dport(struct device *dev, const void *dport_dev)
+{
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+
+	return port->parent_dport->dport_dev == dport_dev;
+}
+
+/**
+ * cxl_walk_port
+ *
+ * @port: Port be traversed into
+ * @cb: Callback for handling the CXL Ports
+ * @userdata: Result
+ * @err_pdev: Device with initial detected error. Is locked immediately
+ *            after KFIFO dequeue.
+ */
+static void cxl_walk_port(struct cxl_port *port,
+			  int (*cb)(struct device *, void *, struct pci_dev *),
+			  void *userdata,
+			  struct pci_dev *err_pdev)
+{
+	struct cxl_port *err_port __free(put_cxl_port) = get_cxl_port(err_pdev);
+	bool need_lock = (port != err_port);
+	struct cxl_dport *dport = NULL;
+	unsigned long index;
+
+	device_lock_if(&port->dev, need_lock);
+	if (is_cxl_endpoint(port)) {
+		cb(port->uport_dev->parent, userdata, err_pdev);
+		device_unlock_if(&port->dev, need_lock);
+		return;
+	}
+
+	if (port->uport_dev && dev_is_pci(port->uport_dev))
+		cb(port->uport_dev, userdata, err_pdev);
+
+	/*
+	 * Iterate over the set of Downstream Ports recorded in port->dports (XArray):
+	 *  - For each dport, attempt to find a child CXL Port whose parent dport
+	 *    match.
+	 *  - Invoke the provided callback on the dport's device.
+	 *  - If a matching child CXL Port device is found, recurse into that port to
+	 *    continue the walk.
+	 */
+	xa_for_each(&port->dports, index, dport)
+	{
+		struct device *child_port_dev __free(put_device) =
+			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
+					match_port_by_parent_dport);
+
+		cb(dport->dport_dev, userdata, err_pdev);
+		if (child_port_dev)
+			cxl_walk_port(to_cxl_port(child_port_dev), cb, userdata, err_pdev);
+	}
+	device_unlock_if(&port->dev, need_lock);
+}
+
 static void cxl_do_recovery(struct pci_dev *pdev)
 {
+	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+
+	if (!port) {
+		pci_err(pdev, "Failed to find the CXL device\n");
+		return;
+	}
+
+	cxl_walk_port(port, cxl_report_error_detected, &status, pdev);
+	if (status == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	/*
+	 * If we have native control of AER, clear error status in the device
+	 * that detected the error.  If the platform retained control of AER,
+	 * it is responsible for clearing this status.  In that case, the
+	 * signaling device may not even be visible to the OS.
+	 */
+	if (cxl_error_is_native(pdev)) {
+		pcie_clear_device_status(pdev);
+		pci_aer_clear_nonfatal_status(pdev);
+		pci_aer_clear_fatal_status(pdev);
+	}
 }
 
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
@@ -483,16 +613,15 @@ static void cxl_proto_err_work_fn(struct work_struct *work)
 			if (!cxl_pci_drv_bound(pdev))
 				return;
 			cxlmd_dev = &cxlds->cxlmd->dev;
-			device_lock_if(cxlmd_dev, cxlmd_dev);
 		} else {
 			cxlmd_dev = NULL;
 		}
 
+		/* Lock the CXL parent Port */
 		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
-		if (!port)
-			return;
 		guard(device)(&port->dev);
 
+		device_lock_if(cxlmd_dev, cxlmd_dev);
 		cxl_handle_proto_error(&wd);
 		device_unlock_if(cxlmd_dev, cxlmd_dev);
 	}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2af6ea82526d..3637996d37ab 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1174,7 +1174,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
-static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e806fa05280b..4cf44297bb24 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -297,6 +297,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (status)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
 }
+EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
 
 /**
  * pci_aer_raw_clear_status - Clear AER error registers.
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 6b2c87d1b5b6..64aef69fb546 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -66,6 +66,7 @@ struct cxl_proto_err_work_data {
 
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
+void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #else
@@ -73,6 +74,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
-- 
2.34.1


