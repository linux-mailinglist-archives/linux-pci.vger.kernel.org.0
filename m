Return-Path: <linux-pci+bounces-30854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC29AEA9D3
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CAF3B9A29
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B5A26F477;
	Thu, 26 Jun 2025 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NgKBRyL8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5F4270577;
	Thu, 26 Jun 2025 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977855; cv=fail; b=bUfkEBA+LOYMmcsJ4gN2LIsCQrwbmTKLaNzDmdzcU/ibKik668jVk5VXzQHmasJoXbNnmpKBpomY5kyZ57U2BEh+o1M1ltWS2z6dcPXG3ZujlMTbj7WOVArzFbbvoqVXG6/zO3RACL4m5xSdWSGCXOuuxOtscwT576QB7R2+ZWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977855; c=relaxed/simple;
	bh=gRBof3fM4WkY4QzEiwEizFG6v7hE9az4YSblkZ6vrv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLL+blTbDYdf2hVq1TG6RUMjA+nqcWJwl/WVApl8e54LyU5G5+4ZMSS0iTPnNOz3JalExu2TSdr2HbaBAr7DQpLY0fYt2pvYakK6idKDVuSAxAYqt4pMSghjAbXwwGuYXdPYKYKVZbnAXG6LdmbhJ1maFgcH1CxC/8bvgUW/nOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NgKBRyL8; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjT8A6ojvK46aUk1RbvS+C/cwETG9y/aws9wUxLcz1Fb4mrtGPOG7iAaSYCA++zYFlPwHp11llKxRrVfzPIsdbsmuMtFjTdcncbI0l6Mx6vpZQaFHaPbCzDjIT/YAlCCb0YjZyLmWXe5bE1LmZ5x883uqq6zd5wK7yISn7pEX7Qd6wq+SB7iaB1awliQMLG+mX9ES/fSPrP1dYuL5kkCNyAvXhHFLmzikDNBDTWS9LJrnWO9k9Z1VcFyDEe6eqJwoztEZOIwuwU0DhZfXFq/Fkm/DpPN82+FmJOHmGOI7GY8UrWnLsRc3tAqmFoE6ANaBsu3Ss5eJDSV1RiE0qm/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt3VcGAcvT6VDDQDry0+SxO6s0kB+VV4zD81ifnsxHE=;
 b=YJ6+pqivQ4z6xqeB2Ftd8dDNWhs0kqxOwkptDtRsv3Mb7oSkcAjSTrXV36jZZJHr0EmLEM/uZSiCWyBV71LJ3zLVlS2KTPizBTbQVbx66NT8L3U7Uaz8jiMVge5eYTu+s9FqSqNKPo9t/rpsJjcVkEoXC9MKED4up0k4nEavd33svwPv7tRsmCHWXVlwtevvKv+cZ18eGSO4n7XX8NWMdO8TONe1Eljn5ZgEFphJk0fIVtelduwRIqX4e+XvswoUtsztLPd8aNWXBLX18O3l9mIz8wXEats573F7qB+oWLw8L2d4BM7qDVkPydpOuJX6Zvsw02hWfV2Er/E3IJyqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt3VcGAcvT6VDDQDry0+SxO6s0kB+VV4zD81ifnsxHE=;
 b=NgKBRyL85lh+i5rmx7glVzPCRkd+dYOXGXm7Yvi5Dh5tqbF5URw+X3ehNaBDMTq7rJtDCpUG/GhX6PyqgASt719j8CwfwY/Ffy/W7wQ6M7VsbEdR++Qm1TlhrslbL50eRwUygw6h9QN27q4bMTmuQBCQ4CFzl6rkjAHuOXAfT1w=
Received: from CH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::17)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 22:44:07 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::50) by CH5P222CA0008.outlook.office365.com
 (2603:10b6:610:1ee::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.18 via Frontend Transport; Thu,
 26 Jun 2025 22:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:44:06 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:44:04 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v10 06/17] PCI/AER: Dequeue forwarded CXL error
Date: Thu, 26 Jun 2025 17:42:41 -0500
Message-ID: <20250626224252.1415009-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626224252.1415009-1-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 56eb3e6c-c614-4f1d-6f97-08ddb502f587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KAzr8eHAyyDwriw3dSfd4B1jpZlZ2XCLJnCsUDMir0tDoj4Kc5ZN3DnfFVt3?=
 =?us-ascii?Q?Mf0NLf2L6VqEhhSz1oxtq0hxSiJ7u7BKPXMw1bdbsexGwar+NLsn7O0vhPln?=
 =?us-ascii?Q?i9S6X3aoCftmthmTi+Fd7kDj4m4XVwvr86aft42BQkjxqYAi/2IssRsrYB/d?=
 =?us-ascii?Q?zXlu0Wr/lNV5tQlbmxbPWybcsKDSbktFVlTQ/P6KsNQe3X1l45JZmtBWmiNu?=
 =?us-ascii?Q?Ta2xvg+6svJSwBm8B2vsNYRvcRVLgNMg2tRG/bxatoBkVhVI0ycCpwXo3TsJ?=
 =?us-ascii?Q?SD4Ffk7Sqjx6a15D5AnRHhcKmMHLx6+M+OItfLKzNzfiSruMrr4jaiLcMTKu?=
 =?us-ascii?Q?x8L8WK4iK53J3kcp3CMZewDpEn3N2cZc00904wPJlcgdzIQ5wVJsUYQZECXe?=
 =?us-ascii?Q?xY1TlLD6sSGjwNppVY+uoZxP2D+ahXRwt1f1l5zYS+4MVcxia1BT4RFTzHls?=
 =?us-ascii?Q?h7PQsQ+EEuXFLH3XUu78nUs0CfoeETIs2mhejFM7nv/b2iHBo6Sf6htdVB1q?=
 =?us-ascii?Q?kWKraHdbhObv9b8NSvMBWWs+9+ZasXhtGZ85hqHdqLJEdU+YK/8PawMeq57p?=
 =?us-ascii?Q?KBTZDAFMAxa1E1QDApucj7/4Fyoc9dnD7o2FhYASMqbfPppNvhVAVYknVAPk?=
 =?us-ascii?Q?6jhLFKM2qOa+v7CZC6KKEJCi1CVnOayrL120IsAPLJK5u0rK0SZTOl22H4UD?=
 =?us-ascii?Q?SOLyOJlwQThZb1Ksqqx6G8hTSmAiVvfbVXjKnqNcwrSMDdTYKmsKbqlBhYyR?=
 =?us-ascii?Q?bBi/YaB3gCScVKiXGir6D0ml1sPJ3vcHfJU1w1hdK/5cJklzHp7c6Hwgej+H?=
 =?us-ascii?Q?LBXRWaH8ri681WC8bs+CmcW+3O+z6petiJ1m6zUzUTcK8wAbcmPi14cbFps9?=
 =?us-ascii?Q?12KD9RPMpBSF3GCq0m3qQUbblWWzK2CL9Bu6BbCUxcFRyw+qduBbILiYOKWX?=
 =?us-ascii?Q?BMwLd0X79jJ1suJkoR01RrAyeF82yTilroxbcP03skCV/XC1JT/R7KC84BcJ?=
 =?us-ascii?Q?Xh7zwtazif/eGb2CZIHFzfi0nknZ/TmC75qfZtozNoYGOLw7u+x9EIQ73Vjr?=
 =?us-ascii?Q?X8Nol9xQOV8ktM6z6IvVY4dfRwWkoEWkHiCInARWeHi3V4s9jj7xz9Pnunqs?=
 =?us-ascii?Q?OW8sqvUPWwmCiNOkhcXd4DbnpKZQus0KgGxfxUFjuFcFVIDWXSyL0Alolm9D?=
 =?us-ascii?Q?F7atlUmqEUE+yBnvt0A8MNEyUVtvWTIcDsUVYyQsV4pxr0XLt9GB0yK1ufXN?=
 =?us-ascii?Q?4iKtnZrkE0qRwY0bDtJhlXD8KCwo9Nsp8cejVRZozmyeIhNcatfvd4XTc2N6?=
 =?us-ascii?Q?b9l0tBn/UNQaXCrAWny66Wyr/7xCPy4heNnhU6imD/cngvUbVzBlPypz0/t4?=
 =?us-ascii?Q?bAv2c5khVTTGgDRW9Aim/YRkW5FMcuX3er4pvc7WGXYKpfPHyv4hugKfASf+?=
 =?us-ascii?Q?F41FYu74VLKH6AYAAPJ8NmK2wHpVPPpQ9JojZj2ykyekQN4qeozyvspmU2Dj?=
 =?us-ascii?Q?b/wGSGbB3dzk6YP7ZwZsFKfpWXOsfWk8mowLeYLYESSzcm0FFOQppJuKhw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:44:06.9521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56eb3e6c-c614-4f1d-6f97-08ddb502f587
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619

The AER driver is now designed to forward CXL protocol errors to the CXL
driver. Update the CXL driver with functionality to dequeue the forwarded
CXL error from the kfifo. Also, update the CXL driver to begin the protocol
error handling processing using the work received from the FIFO.

Introduce function cxl_proto_err_work_fn() to dequeue work forwarded by the
AER service driver. This will begin the CXL protocol error processing with
a call to cxl_handle_proto_error().

Update cxl/core/native_ras.c by adding cxl_rch_handle_error_iter() that was
previously in the AER driver. Add check that Endpoint is bound to a CXL
driver.

Introduce logic to take the SBDF values from 'struct cxl_proto_error_info'
and use in discovering the erring PCI device. The call to pci_get_domain_bus_and_slot()
will return a reference counted 'struct pci_dev *'. This will serve as
reference count to prevent releasing the CXL Endpoint's mapped RAS while
handling the error. Use scope base __free() to put the reference count.
This will change when adding support for CXL port devices in the future.

Implement cxl_handle_proto_error() to differentiate between Restricted CXL
Host (RCH) protocol errors and CXL virtual host (VH) protocol errors. RCH
errors will be processed with a call to walk the associated Root Complex
Event Collector's (RCEC) secondary bus looking for the Root Complex
Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
so the CXL driver can walk the RCEC's downstream bus, searching for the
RCiEP.

VH correctable error (CE) processing will call the CXL CE handler. VH
uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
and pci_clean_device_status() used to clean up AER status after handling.

Maintain the locking logic found in the original AER driver. Replace the
existing device_lock() in cxl_rch_handle_error_iter() to use guard(device)
lock for maintainability. CE errors did not include locking in previous driver
implementation. Leave the updated CE handling path as-is.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/cxl/core/native_ras.c | 87 +++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h          |  1 +
 drivers/cxl/pci.c             |  6 +++
 drivers/pci/pci.c             |  1 +
 drivers/pci/pci.h             |  7 ---
 drivers/pci/pcie/aer.c        |  1 +
 drivers/pci/pcie/cxl_aer.c    | 41 -----------------
 drivers/pci/pcie/rcec.c       |  1 +
 include/linux/aer.h           |  2 +
 include/linux/pci.h           | 10 ++++
 10 files changed, 109 insertions(+), 48 deletions(-)

diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
index 011815ddaae3..5bd79d5019e7 100644
--- a/drivers/cxl/core/native_ras.c
+++ b/drivers/cxl/core/native_ras.c
@@ -6,9 +6,96 @@
 #include <cxl/event.h>
 #include <cxlmem.h>
 #include <core/core.h>
+#include <cxlpci.h>
+
+static void cxl_do_recovery(struct pci_dev *pdev)
+{
+}
+
+static bool is_cxl_rcd(struct pci_dev *pdev)
+{
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
+		return false;
+
+	/*
+	 * The capability, status, and control fields in Device 0,
+	 * Function 0 DVSEC control the CXL functionality of the
+	 * entire device (CXL 3.2, 8.1.3).
+	 */
+	if (pdev->devfn != PCI_DEVFN(0, 0))
+		return false;
+
+	/*
+	 * CXL Memory Devices must have the 502h class code set (CXL
+	 * 3.2, 8.1.12.1).
+	 */
+	if (FIELD_GET(PCI_CLASS_CODE_MASK, pdev->class) != PCI_CLASS_MEMORY_CXL)
+		return false;
+
+	return true;
+}
+
+static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
+{
+	struct cxl_proto_error_info *err_info = data;
+
+	guard(device)(&pdev->dev);
+
+	if (!is_cxl_rcd(pdev) || !cxl_pci_drv_bound(pdev))
+		return 0;
+
+	if (err_info->severity == AER_CORRECTABLE)
+		cxl_cor_error_detected(pdev);
+	else
+		cxl_error_detected(pdev, pci_channel_io_frozen);
+
+	return 1;
+}
+
+static void cxl_handle_proto_error(struct cxl_proto_error_info *err_info)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_get_domain_bus_and_slot(err_info->segment,
+					    err_info->bus,
+					    err_info->devfn);
+
+	if (!pdev) {
+		pr_err("Failed to find the CXL device (SBDF=%x:%x:%x:%x)\n",
+		       err_info->segment, err_info->bus, PCI_SLOT(err_info->devfn),
+		       PCI_FUNC(err_info->devfn));
+		return;
+	}
+
+	/*
+	 * Internal errors of an RCEC indicate an AER error in an
+	 * RCH's downstream port. Check and handle them in the CXL.mem
+	 * device driver.
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
+		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
+
+	if (err_info->severity == AER_CORRECTABLE) {
+		int aer = pdev->aer_cap;
+
+		if (aer)
+			pci_clear_and_set_config_dword(pdev,
+						       aer + PCI_ERR_COR_STATUS,
+						       0, PCI_ERR_COR_INTERNAL);
+
+		cxl_cor_error_detected(pdev);
+
+		pcie_clear_device_status(pdev);
+	} else {
+		cxl_do_recovery(pdev);
+	}
+}
 
 static void cxl_proto_err_work_fn(struct work_struct *work)
 {
+	struct cxl_proto_err_work_data wd;
+
+	while (cxl_proto_err_kfifo_get(&wd))
+		cxl_handle_proto_error(&wd.err_info);
 }
 
 static struct work_struct cxl_proto_err_work;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 6f1396ef7b77..ed3c9701b79f 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -136,4 +136,5 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+bool cxl_pci_drv_bound(struct pci_dev *pdev);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bd100ac31672..cae049f9ae3e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1131,6 +1131,12 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
+bool cxl_pci_drv_bound(struct pci_dev *pdev)
+{
+	return (pdev->driver == &cxl_pci_driver);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_drv_bound, "CXL");
+
 #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
 static void cxl_handle_cper_event(enum cxl_event_type ev_type,
 				  struct cxl_cper_event_rec *rec)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9448d55113b..8d78d882bf78 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
+EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
 #endif
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 29c11c7136d3..c7fc86d93bea 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -671,16 +671,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
 void pci_rcec_init(struct pci_dev *dev);
 void pci_rcec_exit(struct pci_dev *dev);
 void pcie_link_rcec(struct pci_dev *rcec);
-void pcie_walk_rcec(struct pci_dev *rcec,
-		    int (*cb)(struct pci_dev *, void *),
-		    void *userdata);
 #else
 static inline void pci_rcec_init(struct pci_dev *dev) { }
 static inline void pci_rcec_exit(struct pci_dev *dev) { }
 static inline void pcie_link_rcec(struct pci_dev *rcec) { }
-static inline void pcie_walk_rcec(struct pci_dev *rcec,
-				  int (*cb)(struct pci_dev *, void *),
-				  void *userdata) { }
 #endif
 
 #ifdef CONFIG_PCI_ATS
@@ -1022,7 +1016,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
-static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 8417a49c71f2..5999d90dfdcb 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -287,6 +287,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (status)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
 }
+EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
 
 /**
  * pci_aer_raw_clear_status - Clear AER error registers.
diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
index 846ab55d747c..939438a7161a 100644
--- a/drivers/pci/pcie/cxl_aer.c
+++ b/drivers/pci/pcie/cxl_aer.c
@@ -80,47 +80,6 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
 	return is_internal_error(info);
 }
 
-static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
-{
-	struct aer_err_info *info = (struct aer_err_info *)data;
-	const struct pci_error_handlers *err_handler;
-
-	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
-		return 0;
-
-	/* Protect dev->driver */
-	device_lock(&dev->dev);
-
-	err_handler = dev->driver ? dev->driver->err_handler : NULL;
-	if (!err_handler)
-		goto out;
-
-	if (info->severity == AER_CORRECTABLE) {
-		if (err_handler->cor_error_detected)
-			err_handler->cor_error_detected(dev);
-	} else if (err_handler->error_detected) {
-		if (info->severity == AER_NONFATAL)
-			err_handler->error_detected(dev, pci_channel_io_normal);
-		else if (info->severity == AER_FATAL)
-			err_handler->error_detected(dev, pci_channel_io_frozen);
-	}
-out:
-	device_unlock(&dev->dev);
-	return 0;
-}
-
-void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
-{
-	/*
-	 * Internal errors of an RCEC indicate an AER error in an
-	 * RCH's downstream port. Check and handle them in the CXL.mem
-	 * device driver.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    is_internal_error(info))
-		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
-}
-
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
 {
 	bool *handles_cxl = data;
diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
index d0bcd141ac9c..fb6cf6449a1d 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
 
 	walk_rcec(walk_rcec_helper, &rcec_data);
 }
+EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
 
 void pci_rcec_init(struct pci_dev *dev)
 {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 24c3d9e18ad5..0aafcc678e45 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -76,12 +76,14 @@ struct cxl_proto_err_work_data {
 
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
+void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 79878243b681..79326358f641 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1801,6 +1801,9 @@ extern bool pcie_ports_native;
 
 int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 			  bool use_lt);
+void pcie_walk_rcec(struct pci_dev *rcec,
+		    int (*cb)(struct pci_dev *, void *),
+		    void *userdata);
 #else
 #define pcie_ports_disabled	true
 #define pcie_ports_native	false
@@ -1811,8 +1814,15 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void pcie_walk_rcec(struct pci_dev *rcec,
+				  int (*cb)(struct pci_dev *, void *),
+				  void *userdata) { }
+
 #endif
 
+void pcie_clear_device_status(struct pci_dev *dev);
+
 #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
 #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
 #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */
-- 
2.34.1


