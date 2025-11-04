Return-Path: <linux-pci+bounces-40181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4589AC2E9E5
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15347420499
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F34A1A256E;
	Tue,  4 Nov 2025 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="En337+Cq"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840F619D8A8;
	Tue,  4 Nov 2025 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216094; cv=fail; b=Ht8BnOi+Z5mCHUKyntmLEA7awLeghctDc63Jt+W0cpn8y72MXQJE2C7SFOzU1NyYWMYpUnDQzc/ErVt4LQghnqiSJVLxV25O0Qx3tZGIA+vxiSHqXR1sO8t+OE2UZnbeir+84FP4GUFT0b00dGbpGD41zdOHllxkgi/G+vVCwkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216094; c=relaxed/simple;
	bh=xnt9gfTLF346+n7TGCx6H20NiIYQwRLfWOPixRm0n9c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E5UFP9/dN8pUBKDaAUa4bcsOOufc7XUVbubYN0siAnOjP/NtGqtqu8pCRJpLg6OWS6D3WG4LKlRL5X7fcwaKRI1mfLCuq0aavDeabEuRWHB5Or5PgelYiZxAy5efwOS8xXJhll5oi83KcuuUchQjtJURky6WEZmoL645JwKs2/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=En337+Cq; arc=fail smtp.client-ip=52.101.46.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXqB605NKU+CTChNrB4+RDz8pok6GDozbXmCd8I5tq3CKRVfOuvDm4iX5J3ZDcJrKuNwoIDGuNR8ICH9wo0tt648BFikfzzd/wkZJ3KMzW/23k6gJEwHO2yKER/XPLTzMhT/Ovqtk9TfA9GJtMkB1Yb1CYyB9tvo8gNYogAmjimLoXC0EbPhIC72igcjFlCmw351xthbnG4laQGBe735WnLc/xZA5l6272pkXwpBD9htz7w9mJiwcYBrkOOqQ7TOLV6iegHIr3godNoU0bLU/m5z8KAOOcStU/Wc4/jSIv6tFt79CANsmJZp0LRtwc/gBdtabQ3fIBZKT/8TplgJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ICirNXLLVFMYfDnb5Tr3CWCVcWqcMzrDsF8+eJVA+4=;
 b=iG90d5mW3y6o/HtsIF5YGuZC5snr3LvgxMLvF1omlK+fOwvR/k14ebT2ibh0SGahZODFMW3+kBzD+sFH23RKBfAcvT7gOLstMQuRHB6/tAERCGpdBovycmmbZ1XMydWNucOt+0bU+1FV374eXUpPo+FIUkQIabVbuDAm3l6iqOiZQ6SN4pnRSOI6Cg9ThCZsO+knJZWWg9AdDiA9IiN+tTP+95X/0WShVMoBVAal1SGk0+aeY7N//4m77/MR+AjEruiw2FzkI9LK4813tP1UbIfm5wF0e+6FjRlQiw9VzGQgANIO9bW/MYtjzyElv2UyLG7vfpAHj6MS8W3yOwEa2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ICirNXLLVFMYfDnb5Tr3CWCVcWqcMzrDsF8+eJVA+4=;
 b=En337+Cqvqm88ygdxwtllcv1KB/wfUvig0BsTjKdZnorcFyl2Wso2tV/p7eYIE/mwCBrFxrnq99jYeyMckmbYo/16N60hbzdyu3h79Ao96G0FNZqaWD+X0vBUwpq+ZJbYEnt/bm8NbSEUwrzLaaWGk3XJ5EdaUGiK4uqOrnAAlE=
Received: from SJ0PR13CA0228.namprd13.prod.outlook.com (2603:10b6:a03:2c1::23)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:28:07 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::1a) by SJ0PR13CA0228.outlook.office365.com
 (2603:10b6:a03:2c1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 00:28:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:28:07 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:28:05 -0800
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
Subject: [PATCH v13 23/25] CXL/PCI: Introduce CXL uncorrectable protocol error recovery
Date: Mon, 3 Nov 2025 18:28:00 -0600
Message-ID: <20251104002800.3888113-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: d99a1ac1-5cc9-4db3-328e-08de1b39069f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?adrx5GkFvwvnniiPSDZcLDmDNvHTEvnDn8V/pXJ+M8mO/IzACrmwKP5/AB53?=
 =?us-ascii?Q?4O/5qmfQ3EaQKBQyQjhx6bNjwNnQuY0W8mWZiy3XipKBWTpg7UveOu25cgKV?=
 =?us-ascii?Q?paCwHP0d8fJR0ecGjLIK251TGoadHJ+aoDpshMYnpCXMUuS2QgJpg9k/jJvm?=
 =?us-ascii?Q?lPVF2Ak8ZTf/4T2Ucm5Izr/QgUKg92jdVzOkVZqYbYt3a8moFc0h7RExo3Pu?=
 =?us-ascii?Q?D6wIBpA5FdSfkm4kSgV6T6BL5wiuHK5jruUE60Yp/0FBeOeBh41W6/9btnWC?=
 =?us-ascii?Q?S0/IDKEW4LcNJAbzNhA4hMpkQSpQ+yTBl/A8BGuTsN2HYvqhvR9FRKjaPSL/?=
 =?us-ascii?Q?LIaOc4eksDAMhfPxEUeNnJrKhHSZrrdqw25/srEqEYlDuXy2+qwnKMLoHk9N?=
 =?us-ascii?Q?TdPFrnMeaR8BDkUNfs3secIOHm6gIkZ1Q1OAtjl1jGh1OzRkiTo2ihhtqP6I?=
 =?us-ascii?Q?Mf3iY/Zyeom7cTFKFwmTNqAYXkZvU5dnZO6Fu/z1HrEjv/Y3i7vIuiNDd1YU?=
 =?us-ascii?Q?qQ7wUPh35+8F5oa5eUTnwzG8h/N8G2XARi3FVYVyG/4Tep8ZfDHlier4BxgK?=
 =?us-ascii?Q?4rkkfZYbKyjS9JaNjkhvUaC3oMIl6WRZkNu2gvvYsWh2psHtL+76HWrfzSY+?=
 =?us-ascii?Q?JXhU/Qt2VvpPjxiIHq7DQrRwSLpIjZymW4/5lBPZl1eYoWZZjSBG3esU1axk?=
 =?us-ascii?Q?AUQwqM6msivOdb/zFUGE8H55fREV5hP8zzRzD+1kYKvnhhr9c89ucC8/paGS?=
 =?us-ascii?Q?dLoLex0i0efcUPwLP3fKCmkrRC1QGIRy9BH/mJ7SfHOTfXKw7/a6h+l2ZZJB?=
 =?us-ascii?Q?MBao1UtNYdmcTg1dzML2pIqZCKRHL4cQyDZXlgym+FxT+2+GLn+32+sJkk18?=
 =?us-ascii?Q?2uMDv12+wigyRiP4zqJBE210//eAH08NvAUPAWwx1Q1Zr6u+aKWhVuTOfmPR?=
 =?us-ascii?Q?mT3qxzlK4nfZD7BAjFH0gDMi8uvfmWlJga1UJ/X7gqZNaz12JegmlVMORRQq?=
 =?us-ascii?Q?rfMr3wyeF/kniS5VXU04NxBKZ99Jtg7DtqmXKAhd0zq1s68GX/yxtXs1IqXR?=
 =?us-ascii?Q?MBFY3IphYCY94U/h7osBbTVUFOZeoYRUyqBz5paxc7IRvHAnF3jaISjnqpc8?=
 =?us-ascii?Q?A5HKtcjFLOGjqw/yK7p814VyEHPe5+7AMoGrAPMD5hIos++hbXbA+x7hnQiJ?=
 =?us-ascii?Q?gFMmbYfO6BuC3aIpW9HQM78YLIE3aqWNNZegrRMkuSWEb0AIXz4D7SRGo9hr?=
 =?us-ascii?Q?Jx7VUzZBLm2RWKefTc/mQoXETtKAJ+PAD992fb4FaB+EScf1Nsr1j4p+xQ6d?=
 =?us-ascii?Q?N/9L1qD17PkuYj4/c+6i+cFxlrdQPIsdv2r6b52VvCatUwlEfic38juu4N1X?=
 =?us-ascii?Q?TBROXfQZnmEHSj99bgQnSBJJz9PnoBGjXHMHeS36gYQi9r2WKBL+O4QCL1uc?=
 =?us-ascii?Q?p3T9PitxUc+2vnkfc2Y3QUNgGwgKv1Ik7PsVmhfFgYeDVALnM0SdhjTYK5bb?=
 =?us-ascii?Q?FJ32op+Umarj2VMsGUo+jqcO0fa5cc7z4heFdE7bU0dcM9JX/sIRsWUOJqyT?=
 =?us-ascii?Q?RP0VHgKSFSGA0qwU10NT26JvHdtmnHCodrgJuCxy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:28:07.0035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d99a1ac1-5cc9-4db3-328e-08de1b39069f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448

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


