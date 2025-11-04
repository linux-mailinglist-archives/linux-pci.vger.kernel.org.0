Return-Path: <linux-pci+bounces-40178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB6CC2E8B4
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71D9134C240
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197C529405;
	Tue,  4 Nov 2025 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CheXSb7l"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269D317993;
	Tue,  4 Nov 2025 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215249; cv=fail; b=GVmDqaVugpyMgWZKtyqZ/UhSKZ9BivuWJVGgz2if8WTfxnlCepq2COWSTANLf1K2gQ1+Ct0Zc7QCzKTAZ1mAvY4A4f7kVG51i2y+n2GcRe2FcxXfbJH9Ixa1rHTWycvpH5Ivz6DG5wFesKbfdUglohc7OKCR39zWD5SJsdn6sCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215249; c=relaxed/simple;
	bh=VNWY/XCnu4ySTA2aXWsf7/cL9GbfyzqKKhXpHDITCog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkevC8IwRRfjSfkWGa9wC3w7e2b62f8otCZL/uwlrZnj1FRupocnKY+kmdtwulIp8X6qj0pw/31gWRY1vVYeuEPltPVsH6dthCIMab5dXdV4rHr+irjJb5Gs/ArJmTTLfxNAoWK9XnfQNn9wZTZJ/03jZA39/To8NHE6d7sVPkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CheXSb7l; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhTJL4SZDV9cgGRYaI6RoAfwZ+OZpYVj0M19I5FKGm4VzuSIy9UetMJ5KAeciNcV1EEkvktdPljkadpxAdSGfXt5ZIte3rFOTwZteA0xNipq4P9AK9D92JZ05oR6ULc+Fp9g2x1xvVEPIfP6fOSht0bah9VKavVZmziSlhyI+ZIDtKD1t4TMdKNpqYk3O/oYIJaCN77dHRtlbc2FaAX2cAoMCehvX24ehppT8w0XBPViM+PGoc7LQV0ahtVMSpjOupiEIlFo9v5PgD0dHLCPYVqHf32GJVKLeqXX5nuXMk2PjxihCtipzVRkrwMXAjGZvmvYZ2DjwFhDUR4k5tKKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSsyo08wIXr1IgbnWib3JqR9hvv8pjfnaZ7ki0aaz80=;
 b=qddQ6Ipz2iQ45Y4M0nZSX6iKinl0MzI1brMpApttysv4vJap5SXjTR46If+ck5hWVg4oWQt2cGBoaSRAzePRQ3V/1i9PGRkLkcMLs/B4edFcwanQor4a/XQb+5u7ZHmP7vKdADy1XusngJ626YexTBT9cylvbnR3Eu6lWBID2PFkHjo4C78MuoV+DaEMUB5EjvylhF/CXrIVkB8LyZVdwt+d1j4O+Jbf1KPeuSrMNXzogCbkx9BT/7xq2u95Hw7PtoowCsiIW4DQPWJER+OYl2VRtkI1KDBdjN5Yh6lKgt002lap0gh9I+Nrd0oc19O/3rgZgx+6BRmQ7iolWOSYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSsyo08wIXr1IgbnWib3JqR9hvv8pjfnaZ7ki0aaz80=;
 b=CheXSb7lm2bqFbPEj6gqFWE3roiRMUvB4+h5W0/53IFly9zSKSbSUkrykOaBFrGaAshYdDEMKuWc54hyWGerazGusA5zQbO86AcJs1PAJ6EEWEUJPz1IR13r69hjtIAVJbil18oAyqlKb7nnJhloYapYrq6RQgQZSHfgc6rYlfE=
Received: from BY3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:39a::28)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 4 Nov
 2025 00:14:01 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::57) by BY3PR03CA0023.outlook.office365.com
 (2603:10b6:a03:39a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:14:01 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:14:00 -0800
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
Subject: [PATCH v13 21/25] PCI/AER: Dequeue forwarded CXL error
Date: Mon, 3 Nov 2025 18:09:57 -0600
Message-ID: <20251104001001.3833651-22-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: c8017664-8697-476f-034b-08de1b370e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b5vDOW6FcXBbvOLA2wQup6VER2h/j4IZLi9ZI1d4ckub8Z2x7JEwRECGvzhP?=
 =?us-ascii?Q?5ZCtSchZHcTlUxn3MniWRrZn+RkCvMqtZWosqTgXwomIsUr/nhfd5zkNNs/Y?=
 =?us-ascii?Q?pvlxa0NL4ce/tbdcd+WB8uFLmDoH7R4+uzwtv05/CNCpUzxaGl/3aDAp4rcO?=
 =?us-ascii?Q?7mzGhE4os7bz/5ifVYpCA4ZJTy2L+nss8ckZSx7MnbdEvoL8hSoiJJg2swwd?=
 =?us-ascii?Q?9R7yGoKh8k+ypZixGXI/w53WgW27YIfr5rL19JdbuRbvgaQYrlwv28LhcNVu?=
 =?us-ascii?Q?UpPPATHXsewKI8NFgs35aJlhlDZlu5skSeHo/D6AOFtM0oBWDOHR3tkQFnhn?=
 =?us-ascii?Q?u6MPo2FRTcWri2uJqu4+ShX6GG+gP9y9NsCqpbWHVElgCn2aEnrmhnWIcm2c?=
 =?us-ascii?Q?4pRbM0fEOygQQ8lE16rXAcwiCBGPVUUyFZTyQU/9F/THCqqr0k8smz9TImP9?=
 =?us-ascii?Q?rtkWG150hozLKfTvPz0MhCsAg/0UYLthYoyZQU31kiLfHBQQprHu/XDOWuG8?=
 =?us-ascii?Q?KU+kqbYftIGFKkSA1LacjQ8qmHI3FsNCFxJ18buGVlVgTo91fuWH6U6RJGeh?=
 =?us-ascii?Q?19XVO/+q7LIHnoFpK85LB83HJqaqG1mrfgZMSpkvn2iR0AAJobCXnYt711ev?=
 =?us-ascii?Q?trWvOMSAUsM4Sb1Q0UpNZo53wVRtIJXdFHWtbRXqvCz5GBlEkQnAKDyyM+uZ?=
 =?us-ascii?Q?zvQRVY5MqdVV/0/TM00JvICX48dm5AmH9h3wJCbOlgnqAqY72Hsg2vVwFfrg?=
 =?us-ascii?Q?hCK8kZyfFfFicfbTubmGSwKu4bZUQk64wQ7oX1cEpbWd0+Dd8S+RqGBlb9Jx?=
 =?us-ascii?Q?S3br4heFt2IhAciCg69frisayLbbXoivA0P+V9/3LlfUFMckmrcGYir1pL17?=
 =?us-ascii?Q?EzQEdiHX4bl+onbyOD8DzBTRWYkwmrtUn/Dqvark87TIGNuoiOMsBEzM05qC?=
 =?us-ascii?Q?toBHyXol4zYN5Pm/psFjwhpiGbwl5gn5dqyO9APyzPkCVww58W1quso2ZMFF?=
 =?us-ascii?Q?vitqBoeqw1OVTlQ5yjCo5NDOVnLIhiW01jraOgRvTuCjkJ+scw9TtfXwBZr4?=
 =?us-ascii?Q?oriezZGQesBjmil7civivvLKkXnAt5LR0iD1x+rIfJpOs/Y8MG/CM/hk0hAY?=
 =?us-ascii?Q?leTO8NSSXA2dQoi3jKAeenbWZ9TrzEpBThqLUTuYJ9xJ9Cerv4P5E5/qzzXP?=
 =?us-ascii?Q?tIS1/ocwSKBgajq6NFV034nRRAFKqTFm3SmU73Z+7MXrkGBQ37Wj/zbuhXOu?=
 =?us-ascii?Q?uiizkmk8WUe339updtAAk9TFOsmjEclRCMp0NKNH9Cptb7Sn7+eEk40S8954?=
 =?us-ascii?Q?aQgA6nTAcb83dT0njh2IBFkBZi9pLL5Ml3ht65cDX+OaccRdAXbWD4W82KD5?=
 =?us-ascii?Q?/onzvhOR8h++j3ydk5IJgtcRmMAB/z1wiI13raMI/iqaC65RLOEoS31JtOlg?=
 =?us-ascii?Q?BGnVl3SDEkwtjaQIP5jKTk4h+wtUKeUMKBO/RHnUY893hnf6k05NB9dGIxwl?=
 =?us-ascii?Q?2JvQdRI1qdIcs+6gWIV41KnfUYzaX2UTpyB6aS9tANm/XoWznpssG+x0U+HQ?=
 =?us-ascii?Q?ZDdu84X8l0E618NK4/CdqsUDrdE7Hg15au4/ubwj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:14:01.0389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8017664-8697-476f-034b-08de1b370e63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427

The AER driver now forwards CXL protocol errors to the CXL driver via a
kfifo. The CXL driver must consume these work items, initiate protocol
error handling, and ensure RAS mappings remain valid throughout processing.

Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
AER service driver and begin protocol error processing by calling
cxl_handle_proto_error().

Add a PCI device lock on &pdev->dev within cxl_proto_err_work_fn() to
keep the PCI device structure valid during handling. Locking an Endpoint
will also defer RAS unmapping until the device is unlocked.

For Endpoints, add a lock on CXL memory device cxlds->dev. The CXL memory
device structure holds the RAS register reference needed during error
handling.

Add lock for the parent CXL Port for Root Ports, Downstream Ports, and
Upstream Ports to prevent destruction of structures holding mapped RAS
addresses while they are in use.

Invoke cxl_do_recovery() for uncorrectable errors. Treat this as a stub for
now; implement its functionality in a future patch.

Export pci_clean_device_status() to enable cleanup of AER status following
error handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---
Changes in v12->v13:
- Add cxlmd lock using guard() (Terry)
- Remove exporting of unused function, pci_aer_clear_fatal_status() (Dave Jiang)
- Change pr_err() calls to ratelimited. (Terry)
- Update commit message. (Terry)
- Remove namespace qualifier from pcie_clear_device_status()
  export (Dave Jiang)
- Move locks into cxl_proto_err_work_fn() (Dave)
- Update log messages in cxl_forward_error() (Ben)

Changes in v11->v12:
- Add guard for CE case in cxl_handle_proto_error() (Dave)

Changes in v10->v11:
- Reword patch commit message to remove RCiEP details (Jonathan)
- Add #include <linux/bitfield.h> (Terry)
- is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
- is_cxl_rcd() - Combine return calls into 1  (Jonathan)
- cxl_handle_proto_error() - Move comment earlier  (Jonathan)
- Use FIELD_GET() in discovering class code (Jonathan)
- Remove BDF from cxl_proto_err_work_data. Use 'struct
pci_dev *' (Dan)
---
 drivers/cxl/core/ras.c | 153 ++++++++++++++++++++++++++++++++++++++---
 drivers/pci/pci.c      |   1 +
 drivers/pci/pci.h      |   1 -
 include/linux/pci.h    |   2 +
 4 files changed, 145 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 142ca8794107..5bc144cde0ee 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -117,17 +117,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
-int cxl_ras_init(void)
-{
-	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
-}
-
-void cxl_ras_exit(void)
-{
-	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
-	cancel_work_sync(&cxl_cper_prot_err_work);
-}
-
 static bool is_pcie_endpoint(struct pci_dev *pdev)
 {
 	return pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT;
@@ -178,6 +167,51 @@ static void __iomem *cxl_get_ras_base(struct device *dev)
 	return NULL;
 }
 
+/*
+ * Return 'struct cxl_port *' parent CXL port of dev's
+ *
+ * Reference count increments on success
+ *
+ * dev: Find the parent port of this dev
+ */
+static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
+{
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport;
+		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return port;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return port;
+	}
+	case PCI_EXP_TYPE_ENDPOINT:
+	{
+		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+		struct cxl_port *port = cxlds->cxlmd->endpoint;
+
+		get_device(&port->dev);
+		return port;
+	}
+	}
+	pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
+	return NULL;
+}
+
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
@@ -212,6 +246,23 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
 
+static bool device_lock_if(struct device *dev, bool cond)
+{
+	if (cond)
+		device_lock(dev);
+	return cond;
+}
+
+static void device_unlock_if(struct device *dev, bool take)
+{
+	if (take)
+		device_unlock(dev);
+}
+
+static void cxl_do_recovery(struct pci_dev *pdev)
+{
+}
+
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -388,3 +439,83 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
+
+static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
+{
+	struct pci_dev *pdev = err_info->pdev;
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+
+	if (err_info->severity == AER_CORRECTABLE) {
+
+		if (pdev->aer_cap)
+			pci_clear_and_set_config_dword(pdev,
+						       pdev->aer_cap + PCI_ERR_COR_STATUS,
+						       0, PCI_ERR_COR_INTERNAL);
+
+		if (is_pcie_endpoint(pdev))
+			cxl_cor_error_detected(&cxlds->cxlmd->dev);
+		else
+			cxl_port_cor_error_detected(&pdev->dev);
+
+		pcie_clear_device_status(pdev);
+	} else {
+		cxl_do_recovery(pdev);
+	}
+}
+
+static void cxl_proto_err_work_fn(struct work_struct *work)
+{
+	struct cxl_proto_err_work_data wd;
+
+	while (cxl_proto_err_kfifo_get(&wd)) {
+		struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(wd.pdev);
+		struct device *cxlmd_dev;
+
+		if (!pdev) {
+			pr_err_ratelimited("NULL PCI device passed in AER-CXL KFIFO\n");
+			continue;
+		}
+
+		guard(device)(&pdev->dev);
+		if (is_pcie_endpoint(pdev)) {
+			struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+
+			if (!cxl_pci_drv_bound(pdev))
+				return;
+			cxlmd_dev = &cxlds->cxlmd->dev;
+			device_lock_if(cxlmd_dev, cxlmd_dev);
+		} else {
+			cxlmd_dev = NULL;
+		}
+
+		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+		if (!port)
+			return;
+		guard(device)(&port->dev);
+
+		cxl_handle_proto_error(&wd);
+		device_unlock_if(cxlmd_dev, cxlmd_dev);
+	}
+}
+
+static struct work_struct cxl_proto_err_work;
+static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
+
+int cxl_ras_init(void)
+{
+	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
+		pr_err("Failed to initialize CXL RAS CPER\n");
+
+	cxl_register_proto_err_work(&cxl_proto_err_work);
+
+	return 0;
+}
+
+void cxl_ras_exit(void)
+{
+	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
+	cancel_work_sync(&cxl_cper_prot_err_work);
+
+	cxl_unregister_proto_err_work();
+	cancel_work_sync(&cxl_proto_err_work);
+}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 53a49bb32514..6341ca6515a5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2277,6 +2277,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
+EXPORT_SYMBOL_GPL(pcie_clear_device_status);
 #endif
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a398e489318c..2af6ea82526d 100644
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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cffa5535f28d..33d16b212e0d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1886,8 +1886,10 @@ static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
 
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


