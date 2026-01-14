Return-Path: <linux-pci+bounces-44824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACB3D20D76
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 456593093045
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C303C335554;
	Wed, 14 Jan 2026 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ft4HAVxH"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82CA33509E;
	Wed, 14 Jan 2026 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415274; cv=fail; b=SBEllZqmhMN2iGoPkU8fYXGkRcGzwp26GeZPVRd5z3UF/rKU7ggI8XR+4i9Zq4bWLLsmrZ+f95B8hfEmK68nxZPRpYJ1+rIoS94MBO/C/4VaaAhKhHhH5QXz2d7NdXWCgsjXmYeiFH5NPQpVOT69euo305fuOXyHmSF7bg7KM4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415274; c=relaxed/simple;
	bh=0tO9aXEWTzwgy7aG3PL1n7eEzcL+/wj76JD50Web3Y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwQ4a+BMzoFGrY04prnKpJ3BMU9z5mSkwog2azK4odKWlStwz5uyjNvVO/1BtrX/UjyFbMIGkVIS5rW2ph6vhWFS9aQD1jazsMqYQcMMVSDx/vMP9lzfhWoVAiEvuXu9zRrZ08RuapwbMcYDcNHjLMWF9gnhB7l2CurdySQUz2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ft4HAVxH; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiT7Wcfnc4BcEft8ZLo50qI70GLDeGDvmPV3cUhDVfupbgqfny4RbHGo7+MqI9SqdMoq2V+YnfN51vPDYzNkeXfJWPSc+oquEHvhU0bAlQ2BbfRmXNWtwoCc1LCy1V3llMVvMjTSs2dCWe6JMy/8MPayKmlkgphHjWhQSH/q1Mv8lybHDUow8RYZT63Cs4WNDPQq2MHqtzhACKtoiy//puTEMFy0UR8NGyrMVCE8iV+S3CnccHC58Zcf1lh3Nl7+8g8mankrzYw5Zf75Q26yZrvSpBbQLDQtUMgOCwtuSnUi+bA6qZXEgrZ+YSve39QY3P2hsGsFuhO8qRtTBXLlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqtY9DW9UbkrxI8ykHt9oHc3SlSaOr7wsc2kPZC7KTQ=;
 b=CCRyAxRYOBmnm5ExOIJf7XjvFNg5CVG3i4sJCGlBEHCKMM6gQ9OKdhmKjCmllsaMaxzY6tl+cj428ASNw9gl6/ATV6TZkkSIPujYIfgRpcqyCa7qbK5Oyg1NfwrlnSGXRqjtZQwyXmBPnj0uxWxCyL8dQ2RK4tU+fKWENk9Z3py1mj7OovDcCjj/EJVJY0c1ucIVwIT1kHVz04t+RRdkdGO0UPZFN6dOGMokYXawF3M9sYhSwJzXQT6IFDUrxa68CLNSE+sREy2aq+8qsV9jDJB6VrtY1sRLWh4fagzSVoOH22ckglztUvdquR8/Gq4C56jBo8B+vtTn1mjjlBn3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqtY9DW9UbkrxI8ykHt9oHc3SlSaOr7wsc2kPZC7KTQ=;
 b=ft4HAVxH9J/z8W6bg7y8qVkmwTBF/mf14oXAS9PGbY+eBwXEt08uS+uv2JIQO1inthlJYEXmSYsIxnHHKllnRymyhY+HcQj400mqJjOKCV7iDzU1+0wDiTYER7JC3q5aBRLAUf3oIHdMr2poNdHSxfzE0WD6O4flBfJR24N9sAU=
Received: from SJ2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:a03:505::20)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 18:27:46 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::53) by SJ2PR07CA0011.outlook.office365.com
 (2603:10b6:a03:505::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 18:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:27:46 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:27:45 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 31/34] PCI: Introduce CXL Port protocol error handlers
Date: Wed, 14 Jan 2026 12:20:52 -0600
Message-ID: <20260114182055.46029-32-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 2686ead2-b9a9-4ed7-5bd5-08de539a9d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M6w0RcZOgJ+KnDPBgiP0gcZbBNi0DMIslP+YQ6V/2nSIzRZMegCGSpddVTmy?=
 =?us-ascii?Q?vDEOll+VxLjmz3pShxD699njM8PiV+g7brWw5ZsKZjk6ssu4sC8YORXN2tD9?=
 =?us-ascii?Q?gYL7EB9RBDOWameVNP7OFdYwyEfA6ULw/9Wzr9GSZrmU5ukUrAgTb2nZ9+GJ?=
 =?us-ascii?Q?TH+q+by4IPs1dIDIhlHmoJfvIKjmUYXcrHfgSkn3V8Poz5Bxma5nD7YWmEVb?=
 =?us-ascii?Q?pFmQ2KetAwkRY8GX0CCtasniLUR6l6FheVOL0jQVqhCOsLr1Ro5KNeQ/EAUL?=
 =?us-ascii?Q?7eC4GGKoV21rFJpt7lrb/Xaa9JVt6GhmVDvTzPb9so/TzQ3MdzxTez4RP0Fb?=
 =?us-ascii?Q?QMoTGFQGxjgrX2+qGetHWWiTKkExmvZ24ZSGAP+z19kvLa+ufJaLHPSfr9Xc?=
 =?us-ascii?Q?Xv7aGyE6LTD2HVG2p2l7DoYa10nLZZEbgiph30/fxFtHpQHizmh/QhFnLaWX?=
 =?us-ascii?Q?XmmMp7seopQq0n4UP80PENDLvR8Bg2Z8wP5/EFh28JKvyaFrSnl0CKwltwI6?=
 =?us-ascii?Q?w5G+xkhWVTl6ednAQH5ZKl4dk37cbcASdEh/5LAMSlkOjrkRXbXhS+BzAOJQ?=
 =?us-ascii?Q?ZDfLo9NrcBUhcVdXUVuk378Czfdx1wBy8cItfWgXXn404BSI0bHXoMNERV1M?=
 =?us-ascii?Q?k9sIHKTPJ1PjRgwHnPlChGePdJlBrWTdS6syZI0fIs7c2jiOTWVe6Rft6loO?=
 =?us-ascii?Q?9QawLK8u0tbUOIgrm8f1x+yeztNs09Ejey9Jo+sa9cDDu3rLuGLSemIjrBsx?=
 =?us-ascii?Q?qHHMHSuvhxUGs1PyuNXyKeA1c+sYy3WGkwWPACd5kdO48lm2z+FJftfRYeCf?=
 =?us-ascii?Q?Dn3BnIXb/mBxbdl8Rl2tZAGwCx+UKv2ULUNahLTsxiYbp8tQXAFgzf9L3DaX?=
 =?us-ascii?Q?c4e21nu1WDEmW0DMbR4S3sUQ4bA6fu1psaQK9jImqPEv07r1+nZPLVkzCvNL?=
 =?us-ascii?Q?tEslvUcycrDTT2rMJOA9lBojWpMKHSVpO/9MY6NARquS2BSTjFtT+FJWf2/1?=
 =?us-ascii?Q?iqd0X9r3Cax8AB7gkN+Hgo2Y+0ZIqxY1IEx6GSaSxjWh0LxCF4elfYoYZcoY?=
 =?us-ascii?Q?HtvpYKd16HyIv9YncjGOpztiMKTgdBszDhYZH4tQPZfsFWHAi+PUC4KbsT57?=
 =?us-ascii?Q?iBkZutLWWdHm0FJfuFoW4Ne30UD/apLjCAd2FCJt+dCMTDeGZv3I/BNZRF3/?=
 =?us-ascii?Q?lkAyLDEvaBpfguT2Tr00cSuZlgQEs6dJKFHI9lUSd2pkyASV3LVuKDLioqR8?=
 =?us-ascii?Q?Km3YcU/51gDm1qEqZ9SESteFh+2JuMw4GCh1ccRI/u8kV8nlFjbcvfoc/H5U?=
 =?us-ascii?Q?ZkLOhhmUn7CHxx9EIJgzgeA4tN6oWkHT5iqeR+DYECEGR3yWlKgexhDKiV0p?=
 =?us-ascii?Q?X4rmP47v2+YzWmZNffGK/6vpOQAagT6GwglVpGKjaQDp/KAWunPxba14LY5O?=
 =?us-ascii?Q?6vKLzv/S2N1JPfolkwwoB6FuoHrhNQ2i4I6Gl837vP6nQ+6FfFYvIWqyPKw7?=
 =?us-ascii?Q?Vm9LmrWhblPvAcJ3cBpfWeI6bI9ahY9noir3XPkoMdLxBtQeeqp7JBi2yb80?=
 =?us-ascii?Q?JGDmYAnz+qauvdurQ+XAqVC+b9qzRf0nGl2N1R9QIY+vj2mi2H4TMQ04uiSX?=
 =?us-ascii?Q?JoVMAev6Si2o0+3fKBgG+VwzG9JLuvEbU5VqBJ3ssNg6Fzu5LZ76hwZ7bydG?=
 =?us-ascii?Q?V8utpyYSrrB5ygzGx0dE2mUcKmM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:27:46.2068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2686ead2-b9a9-4ed7-5bd5-08de539a9d5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

Add CXL protocol error handlers for CXL Port devices (Root Ports,
Downstream Ports, and Upstream Ports). Implement cxl_port_cor_error_detected()
and cxl_port_error_detected() to handle correctable and uncorrectable errors
respectively.

Introduce cxl_get_ras_base() to retrieve the cached RAS register base
address for a given CXL port. This function supports CXL Root Ports,
Downstream Ports, Upstream Ports, and Endpoints by returning their
previously mapped RAS register addresses.

Update the AER driver's is_cxl_error() to recognize CXL Port devices in
addition to CXL Endpoints, as both now have CXL-specific error handlers.

Future patch(es) will include port error handling changes to support
Endpoint protocol errors.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v13->v14:
- Add Dave Jiang's review-by
- Update commit message & headline (Bjorn)
- Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
  one line (Jonathan)
- Remove cxl_walk_port() (Dan)
- Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
  sufficient (Dan)
- Remove device_lock_if()
- Combined CE and UCE here (Terry)

Changes in v12->v13:
- Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
  patch (Terry)
- Remove EP case in cxl_get_ras_base(), not used. (Terry)
- Remove check for dport->dport_dev (Dave)
- Remove whitespace (Terry)

Changes in v11->v12:
- Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
  pci_to_cxl_dev()
- Change cxl_error_detected() -> cxl_cor_error_detected()
- Remove NULL variable assignments
- Replace bus_find_device() with find_cxl_port_by_uport() for upstream
  port searches.

Changes in v10->v11:
- None
---
 drivers/cxl/core/ras.c        | 101 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.c             |   1 +
 drivers/pci/pci.h             |   2 -
 drivers/pci/pcie/aer.c        |   1 +
 drivers/pci/pcie/aer_cxl_vh.c |   5 +-
 include/linux/aer.h           |   2 +
 include/linux/pci.h           |   2 +
 7 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 0c640b84ad70..96ce85cc0a46 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -200,6 +200,67 @@ static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
 	return NULL;
 }
 
+static void __iomem *cxl_get_ras_base(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
+
+		if (!dport) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return dport->regs.ras;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return port->regs.ras;
+	}
+	}
+	dev_warn_once(dev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
+	return NULL;
+}
+
+static pci_ers_result_t cxl_port_error_detected(struct device *dev);
+
+static void cxl_do_recovery(struct pci_dev *pdev)
+{
+	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+	pci_ers_result_t status;
+
+	if (!port) {
+		pci_err(pdev, "Failed to find the CXL device\n");
+		return;
+	}
+
+	status = cxl_port_error_detected(&pdev->dev);
+	if (status == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	/*
+	 * If we have native control of AER, clear error status in the device
+	 * that detected the error.  If the platform retained control of AER,
+	 * it is responsible for clearing this status.  In that case, the
+	 * signaling device may not even be visible to the OS.
+	 */
+	if (pcie_aer_is_native(pdev)) {
+		pcie_clear_device_status(pdev);
+		pci_aer_clear_nonfatal_status(pdev);
+		pci_aer_clear_fatal_status(pdev);
+	}
+}
+
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -214,7 +275,10 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 		return;
 	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
 
-	trace_cxl_aer_correctable_error(dev, status, serial);
+	if (is_cxl_memdev(dev))
+		trace_cxl_aer_correctable_error(dev, status, serial);
+	else
+		trace_cxl_port_aer_correctable_error(dev, status);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
@@ -265,12 +329,27 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
+
+	if (is_cxl_memdev(dev))
+		trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
+	else
+		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
+
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
 }
 
+static void cxl_port_cor_error_detected(struct device *dev)
+{
+	cxl_handle_cor_ras(dev, 0, cxl_get_ras_base(dev));
+}
+
+static pci_ers_result_t cxl_port_error_detected(struct device *dev)
+{
+	return cxl_handle_ras(dev, 0, cxl_get_ras_base(dev));
+}
+
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
@@ -346,6 +425,24 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
 
 static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
 {
+	struct pci_dev *pdev = err_info->pdev;
+
+	if (err_info->severity == AER_CORRECTABLE) {
+
+		if (!pcie_aer_is_native(pdev))
+			return;
+
+		if (pdev->aer_cap)
+			pci_clear_and_set_config_dword(pdev,
+						       pdev->aer_cap + PCI_ERR_COR_STATUS,
+						       0, PCI_ERR_COR_INTERNAL);
+
+		cxl_port_cor_error_detected(&pdev->dev);
+
+		pcie_clear_device_status(pdev);
+	} else {
+		cxl_do_recovery(pdev);
+	}
 }
 
 static void cxl_proto_err_work_fn(struct work_struct *work)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..b7bfefdaf990 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2248,6 +2248,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
+EXPORT_SYMBOL_GPL(pcie_clear_device_status);
 #endif
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index dbc547db208a..8bb703524f52 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -229,7 +229,6 @@ void pci_refresh_power_state(struct pci_dev *dev);
 int pci_power_up(struct pci_dev *dev);
 void pci_disable_enabled_device(struct pci_dev *dev);
 int pci_finish_runtime_suspend(struct pci_dev *dev);
-void pcie_clear_device_status(struct pci_dev *dev);
 void pcie_clear_root_pme_status(struct pci_dev *dev);
 bool pci_check_pme_status(struct pci_dev *dev);
 void pci_pme_wakeup_bus(struct pci_bus *bus);
@@ -1196,7 +1195,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
-static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c2030d32a19c..dd7c49651612 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -298,6 +298,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (status)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
 }
+EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
 
 /**
  * pci_aer_raw_clear_status - Clear AER error registers.
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
index 0f616f5fafcf..aa69e504302f 100644
--- a/drivers/pci/pcie/aer_cxl_vh.c
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -34,7 +34,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
 	if (!info || !info->is_cxl)
 		return false;
 
-	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
 		return false;
 
 	return is_aer_internal_error(info);
diff --git a/include/linux/aer.h b/include/linux/aer.h
index f351e41dd979..c1aef7859d0a 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -65,6 +65,7 @@ struct cxl_proto_err_work_data {
 
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
+void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #else
@@ -72,6 +73,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ee05d5925b13..1ef4743bf151 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1921,8 +1921,10 @@ static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
 
 #ifdef CONFIG_PCIEAER
 bool pci_aer_available(void);
+void pcie_clear_device_status(struct pci_dev *dev);
 #else
 static inline bool pci_aer_available(void) { return false; }
+static inline void pcie_clear_device_status(struct pci_dev *dev) { }
 #endif
 
 bool pci_ats_disabled(void);
-- 
2.34.1


