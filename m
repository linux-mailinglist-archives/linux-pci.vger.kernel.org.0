Return-Path: <linux-pci+bounces-37057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8762CBA1D93
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E84017012E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED37321284;
	Thu, 25 Sep 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A4cmRpSL"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402032127A;
	Thu, 25 Sep 2025 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839946; cv=fail; b=T8q9DA8p4ms4FBsXKHhwUQIy3yroiWJR223PQA/sxuJsidZLZH9+JyQErqRy0Pv0Pflkis6U6jtUOcbpZH6RncNJgmbtdgVtZLiVwFMZ+o3TUnixoHiw1tJNCfpFbGX0s46okZ6qhzBVoXnsEgzfCEMUDakxrbOBMJFJVP5s2Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839946; c=relaxed/simple;
	bh=fxx+HYVdESNKiDZ+qejj80pNG9tkCbEdcSctVNRPK+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXlTLyeVo+vXpznIMTs6XTr0ZHkUe+kuBDrMbme28apnugqMN9k+ImV6WGbH+VoRql97uubnBGvyGqtUi9apsgXkEsM6xk/dMvzeOzQ1gcOllaHyK8lWZyySsgYNjTgWrL4ncQ0GbicAv2T3+o8sMNIrKYcr5B5ZNqHnXiowqgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A4cmRpSL; arc=fail smtp.client-ip=52.101.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rujRJ5GjbRWezPe/YwxBXkoxYhD914IX9nfh1PIkUWphb0YE945uyXQyqLSIhaJYNWIebEIixv2YnyqOw2F91frM+KDSJF/UOkiq76epzJTGMfJ//dFf0S2uKWR/lEd+K1gU7TDz5AhhEwygYf91/u6No3IvaQ3BA888/yFDP7mUGd3HfNMOFHcN1BGuA78dIsOgxS+ftPnlC4ElFp53gTSvFLxLRcu1QLEHT/Ude+ePiTyEzx6h8RXjDotj+2+LopLDR6p9t/svpyWde6d0DWBdjkh+jjr8Te5FGWK3dRKQDvv2QI2tsvxAIVFg19ubl/H4EvsNdCWSQ0u6SCgFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93NymSKEKzZW1uxmFUneEyAYY8nNLc8NW5OV1yRoMbg=;
 b=jiJzqJalXCiE60qm1MT+W38UP8LsgxlQ5j2yvqoXEN3brgOppM2p2+hyYb3lfM6eEGQJE5CnmehMHl5i2GOQlloWSNZXzuSiWmaY0e93ilN8iYmLi6zty9I7kkamg/SZpLAHhxWdEyP9VbyUYElpkLlJ0izO40q67QzjdAGlo/mud7IsKk6koPD5Jq+/51Lo4dMNTWbrHH197uNpp+ffDvOByqcIcPyMSHIZrD/M9OOIN6QqtBo3DDpjhZaKL1plFWOTIgDOkaiu+TUCR+WNFGQxnTeAPXbnOgAaD5kOsCCkM3FC7wRJgF9vzciqOvsmVE/l3eTfcfvblo3At+Ocyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93NymSKEKzZW1uxmFUneEyAYY8nNLc8NW5OV1yRoMbg=;
 b=A4cmRpSLNHuhmaW6AIO3z6mP4uHsfqYeqvS7qzNpKmFJik9uH9WNFG6uoF+XurvBpInIylzdHQMRO6OrklUnJgcJSvnBwHp5I/np4BtZOIhUrRrcEG3MnVTwMAFULj2C5REsM9gRj8forS1c2F6MxV2vkIf3pCL6gPwPGgC4UwA=
Received: from PH7P220CA0085.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::26)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 22:39:02 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::12) by PH7P220CA0085.outlook.office365.com
 (2603:10b6:510:32c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 22:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:39:01 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:39:00 -0700
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
Subject: [PATCH v12 23/25] CXL/PCI: Introduce CXL uncorrectable protocol error recovery
Date: Thu, 25 Sep 2025 17:34:38 -0500
Message-ID: <20250925223440.3539069-24-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925223440.3539069-1-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ae7286-7e4c-4a46-6dcd-08ddfc84533c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a6/kJ5DJB2ZMUaj0NRjd+SwTBm9W7BrOblRHTRwjo2nIt0CRwpz1RIQh9mMH?=
 =?us-ascii?Q?yLbTv/pYADB/o0NcGVabR980dXicU9mLnQsVRUA4mD+dlSSDGslGghK/fOto?=
 =?us-ascii?Q?wwEBuwxScXSN2Fm8AL7xjbxK8xffDQAvEHUs4BDjmbrlBwEK43S+8my+9i8U?=
 =?us-ascii?Q?YFG9LEEWhLByUkcl2ZKvhUVL7MXMfScy4YB9MwfkD+MuYnE5Xhhx1e5+GsTp?=
 =?us-ascii?Q?BewXkyoEvupJyL4GVEyKpNn6QDNPZtyzN4tiqWyiCOxG5wYD3QeCBdffNhcA?=
 =?us-ascii?Q?rO3rYvRSGeY//lCvylGr0fx0SdKwYCs59IYwZPRCYR13x7/ioVr2dClNk59H?=
 =?us-ascii?Q?X+1zZ+zg2eaN23Zv+gkt8O+2aCgeSKcXqYDIks7IHEOoERdK75P3hi4VfVBb?=
 =?us-ascii?Q?HKiDFDDyJiX+anUBJND2323nZORpLe1zrgIVrIHUxdpxDLqlokLUEgPRAmxX?=
 =?us-ascii?Q?u19PEabFsRAZGC1aNUU/CfB9qIEewLKqWOBLxcl42iDegS08bEBa/MHLtHTL?=
 =?us-ascii?Q?p/HVCacJKqUrFXbFwEmyK4uoLXOyY6NEJH+JiwYGCnJRAvKXgKPh9Ra87UmJ?=
 =?us-ascii?Q?awXZP4QfFKwH6YlQo72ELcOi8yLQms+mI3nqw/e/lrAedX9Ybj+3faDHfkGj?=
 =?us-ascii?Q?1Aw7GpRREjcMpRz5KEbQAoGQZ2jFlsJW6Aec8t26yvpTGb1/7Dd3IQ8UG7xP?=
 =?us-ascii?Q?E0sEUB/+u8Xi3x3QnWC9qTQxwXsIuVsiNI5BsMYDPcyCyRGWUZ9rr5OqNzgg?=
 =?us-ascii?Q?/3CH7ucMy27ImZbTJLRb1aWysCqKn/4O38B7cO87Kszlu9v0qwrIpe+TYc2T?=
 =?us-ascii?Q?tj4VhdGHyXfPM1tbdWULA0gGx52tkrn3fRe8h0XskLKcAYRKMpDJqcUd8ech?=
 =?us-ascii?Q?UUp9PD5iglGDzchIPcWJizgHEn62AOVApfy01EbT5cE7fkaTdRTKhAoU4iWG?=
 =?us-ascii?Q?oo5BSBnIDpOyq0d0cbA+olI9HZjOiw34rAGDnCBPZq3JW363ZLpGWhKkg7tH?=
 =?us-ascii?Q?GLFvftWVJ/hm+faj8yo0Igtn4d9q0owb272OR5y9fzbY6R1SPQVVNpfSVNEW?=
 =?us-ascii?Q?Da7J7Jg50WKjkaAAcSzzJzrmBz2bfGUvZOA2vAAaRh49BuaQJcjfF3mZiYpB?=
 =?us-ascii?Q?97NmaXdYljw04P5z9zKKbMqfZUWmn9P4CGB7fPMngMtd+lLM5TqBEXjkhAtN?=
 =?us-ascii?Q?+Csp3tomB+xGu+Qm1boSrwhcyLPMAJ2Px5YM/XirRo/1KRMEbwkhEGdsppqq?=
 =?us-ascii?Q?6i6NWknAK3AAvhFtJ3oLjDSoERB3ku2Pl0Ub9iE6w/W63KoqrFkUbhZNVBQL?=
 =?us-ascii?Q?FSUTDsyLSQNxhAzj4leZ/JbSBrUQ/OXB6gEsiQUc9eHkTtPA3O7CEKvSCvkg?=
 =?us-ascii?Q?fotXdRyYhfl5PBr16sAVDST5ASlTwfio2JS0rJLh4iRSNRHkAX3SEacfRr5F?=
 =?us-ascii?Q?CWYmDiMI7lx/pA/7ujD3flsoHEcYVuitrswX09pz62y1jE2e8dYuuV55w9Ca?=
 =?us-ascii?Q?WJ1448imuLVuC6YEw1Kq/qyO1/vrFUgjFF6r7obEmPaeG26a09r9re50og?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:39:01.7952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ae7286-7e4c-4a46-6dcd-08ddfc84533c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662

Populate the cxl_do_recovery() function with uncorrectable protocol error (UCE)
handling. Follow similar design as found in PCIe error driver,
pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
as fatal with a kernel panic. This is to prevent corruption on CXL memory.

Introduce cxl_walk_port(). Make this analogous to pci_walk_bridge() but walking
CXL ports instead. This will iterate through the CXL topology from the
erroring device through the downstream CXL Ports and Endpoints.

Export pci_aer_clear_fatal_status() for CXL to use if a UCE is not found.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v11->v12:
- Cleaned up port discovery in cxl_do_recovery() (Dave)
- Added PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()

Changes in v10->v11:
- pci_ers_merge_results() - Move to earlier patch
---
 drivers/cxl/core/ras.c | 111 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 7e8d63c32d72..45f92defca64 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -443,8 +443,119 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
 
+static int cxl_report_error_detected(struct device *dev, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	pci_ers_result_t vote, *result = data;
+
+	guard(device)(dev);
+
+	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
+	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
+		if (!cxl_pci_drv_bound(pdev))
+			return 0;
+
+		vote = cxl_error_detected(dev);
+	} else {
+		vote = cxl_port_error_detected(dev);
+	}
+
+	*result = pci_ers_merge_result(*result, vote);
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
+static void cxl_walk_port(struct device *port_dev,
+			  int (*cb)(struct device *, void *),
+			  void *userdata)
+{
+	struct cxl_dport *dport = NULL;
+	struct cxl_port *port;
+	unsigned long index;
+
+	if (!port_dev)
+		return;
+
+	port = to_cxl_port(port_dev);
+	if (port->uport_dev && dev_is_pci(port->uport_dev))
+		cb(port->uport_dev, userdata);
+
+	xa_for_each(&port->dports, index, dport)
+	{
+		struct device *child_port_dev __free(put_device) =
+			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
+					match_port_by_parent_dport);
+
+		cb(dport->dport_dev, userdata);
+
+		cxl_walk_port(child_port_dev, cxl_report_error_detected, userdata);
+	}
+
+	if (is_cxl_endpoint(port))
+		cb(port->uport_dev->parent, userdata);
+}
+
 static void cxl_do_recovery(struct device *dev)
 {
+	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_port *port = NULL;
+
+	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
+		struct cxl_dport *dport;
+		struct cxl_port *rp_port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
+
+		port = rp_port;
+
+	} else	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
+		struct cxl_port *us_port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
+
+		port = us_port;
+
+	} else	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
+		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
+		struct cxl_dev_state *cxlds;
+
+		if (!cxl_pci_drv_bound(pdev))
+			return;
+
+		cxlds = pci_get_drvdata(pdev);
+		port = cxlds->cxlmd->endpoint;
+	}
+
+	if (!port) {
+		dev_err(dev, "Failed to find the CXL device\n");
+		return;
+	}
+
+	cxl_walk_port(&port->dev, cxl_report_error_detected, &status);
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
 
 static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
-- 
2.34.1


