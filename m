Return-Path: <linux-pci+bounces-40253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A63FC32429
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1C544FC991
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47D32E8B9B;
	Tue,  4 Nov 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y7BtC6kk"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A9033BBA6;
	Tue,  4 Nov 2025 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276034; cv=fail; b=Nxcpwg7AwUtl/DVheMz9cvJt6QEsb/6FsbwIm79N44noqtnnelI8DduZjC2VquiWVwIU9rrDlgHyDh5wp9MOhZhgCQG7JqzRtkJV53mx7rBLXpRlp3GtNIg7zhHc27EIaAXTLEsI4CQDgCV0c28kSF1glU+RdKllquIxPO4LZso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276034; c=relaxed/simple;
	bh=VNWY/XCnu4ySTA2aXWsf7/cL9GbfyzqKKhXpHDITCog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwIH3Fj99s2Pgun5K8O8bYNIxHX++n98XEod8o4MV+sZiIb75xDKfEmAHggcTlxELRz1kfHaT0Nkn6zJ2AklIolWL8YfwyeSkkDRaQ907MvUSq1FXSG1VKw/Zn+kXsBroFM5OTyo9kQR8QwrrerTLgU+Umno03Cj+EhDK+UULLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y7BtC6kk; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGvY5ntM37wtVRVZenRKgpKAU6EcyubS3Xpi8Qm8F8gsGI72d0vhK+klFe7plTD2V/+V5dLvpGFK64H6+UgBjNHWpLtU+8qhJGcYARTRddnsrRbHU6aAhGkMZl5YeThGozyVUtSi7Rk09y5Zna+gWA35P5ksCBb1C5TLGc+a16yCQrVx7nkuH55RpPs32sv74T70NvixCiXUbXYAqWZtW7CylbQncK80GairgmnNzHGc7qqG8rLJQUebbYq6vzQlQOTIJ0k2uABuEIsic5tCou8xOwi9LMPrghoVN4f0/djsWNSoCxIs9k/s/KSvLAGobobOlaVcL4gJiYOGd75oig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSsyo08wIXr1IgbnWib3JqR9hvv8pjfnaZ7ki0aaz80=;
 b=BJlbkef5CaMajtdbumICCO9/UB9LQxP/zXo81kUJ+8LNKkqWoaz/+LduQ40ROy0Kc/lRdoiuZD9f6N9y9XzalGjeGghU68HUer7jZoJSFnG/eSla3r1fo1looxeW+xFHScLz9MozvFAd3lIy4AsUJvAzqTxQjey/Ch6rZdC8MLdRBqhLNJLb6hbW/2rnGboOtKoqDzPUXqbaHlX19iB3PwCJ1xzw6XoX5IieD4pdIhbCuYj1Yfos7C/KIaxVmM0ngNlsvi/DI6kZ6wOPcarBXA6ZhPVmbl9g+CnZCYj55VCr2p+zhExsolK16PriU9VE0YBYoAZM14oWGrf6LaJXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSsyo08wIXr1IgbnWib3JqR9hvv8pjfnaZ7ki0aaz80=;
 b=Y7BtC6kkrjiDnA6ss0n+e/oBjJfq2c6IT+uwW4IRwKTICvxigdxLWK7ySdpDkwaNufWLOabVCN8bhprdwIU4JqlXBtvEizWzy/4PrCwFc04F5m2O42dEqzUAscESClRvQsqXyRDjs8CQ6DyXyT2lmTSdPdUXgRqVjR/a6jpg0qQ=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:07:06 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::2) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 17:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:07:05 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:07:04 -0800
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
Subject: [RESEND v13 21/25] PCI/AER: Dequeue forwarded CXL error
Date: Tue, 4 Nov 2025 11:03:01 -0600
Message-ID: <20251104170305.4163840-22-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c55aac5-8eed-4065-70b5-08de1bc494cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?InhFcod5rhMZzUrWa1P1FVl0fHM50MQWyfyXsnKhM1aZf/AQpAMyxLpbvV/V?=
 =?us-ascii?Q?vF/qILM76uWf9CgtiwG5O6TbZRb0wmuXeAKdx2GOEhjf12lYTRsaQ9n5GXaO?=
 =?us-ascii?Q?zpMhS8qfG8eUSR+prysMN+Izt63uSXPIbzsioMPLWUrxPwV4B9FUNTmgfU3s?=
 =?us-ascii?Q?efa8HpiXKyMxx+OTZINbo4uFHHzJvFMNoOYoKc4UIRQGy2Smpe1P7pMT2fem?=
 =?us-ascii?Q?L62l35/Ii1eE8CckAaQxgAlX07pO+hXLczjN79o54Ur7xF5BxGUmFW14ym9b?=
 =?us-ascii?Q?JSeten6s65LlaY0rrYIAISZow6LjwrNsA4ZpYqbcTrayTPuC6QuFqNQhJdUi?=
 =?us-ascii?Q?AsXn1ZdGKQIfLqOOBj3+0zauUut5MQyS6HIS5ZhDPpR4ZLWXGZkBo7TL+NwA?=
 =?us-ascii?Q?GHcDqly4GLhDpkYiIFK20x4u+16Jiwwwspko2zCA3GUQ3rZmjBiGilGGOAU3?=
 =?us-ascii?Q?4k8vmw42gCA+YtF1taeav1eeRvo86gx+UakHALnM5V/38360JiIa/+BZZ+om?=
 =?us-ascii?Q?Og2Ss/1zmvCun4PsWZhie5stuwlEvjYRQSM8iJgHVX2RvYj7Rl5V34ya4CUl?=
 =?us-ascii?Q?c01LZxPzNuZ8/zolYJ5MysEr2rfngoRKel/zyBzj/q3F+MmVwEVlJAihF9Fx?=
 =?us-ascii?Q?3aNKBTeGbvIjIEMeycbv0YjjHdaIFnGPLIEFM6k/mIPtLSzUh9hLN7fGFX9U?=
 =?us-ascii?Q?BFPEZEQWUCmBE20BpUSGXzqkn6A6ft3aVQIGQ3io7sD6j6aGnVMM46k0mLmY?=
 =?us-ascii?Q?ZxlJpj49xM+Jec2BUzv2z2acV8HCBaDRQISGK9em/dWZUh3YCbXBon/7lQHu?=
 =?us-ascii?Q?foP6xQaznHEFVMWF0G+dHzjHcZ8LA2JLFVSmFEKhzFvdrJEhR29VXYkVpYZg?=
 =?us-ascii?Q?hv0TIo3RKhig/mpNuew0KQ8gARy/tEtuc4zXTpDf89CWxA1uma8VYJKNYrks?=
 =?us-ascii?Q?LYtCwMpYs6WOOlZmFPPs8C5djJtEYxqcOYfEgW8n2HqtTPJbjNIDMlq9IFbf?=
 =?us-ascii?Q?4UfUfULzl6d/JwqbHio4Y2HB5MGABd5tQk0+N3H+iAEKU03w2G0xAu7zQGsN?=
 =?us-ascii?Q?MtKS9x9FiLJo7gguOxKcSXdjVTOAG56sYmcU4S+di12Z4+ctCqNJb/7pjKWj?=
 =?us-ascii?Q?ipklRc9oykOLZT6ZDLKULx8QD4d/j/h8AAU8aUN9YQkVReKGHMCuFE5KCns6?=
 =?us-ascii?Q?dXBEC8mDiuvoXsjKrfq+lv+Vaw+XKBqCgyOf501WreGzlSL49MrfhHwy+nDM?=
 =?us-ascii?Q?1AyE+HX4VjOFacTE9GsPOXKo1wSkhMtknYdEceh/I5DbhKiKRtOEhZAVG7OO?=
 =?us-ascii?Q?GJZgQJQnVGEPWSmBl1XDCB8uv5N/fWPgjt5qSqyI46iko183xsE4/R3uGujI?=
 =?us-ascii?Q?af/pc4gNibJ6dn3lpzmbjKs83fUWyB4oNeuk0rYGao22DfRc4WC9e3rFV9c0?=
 =?us-ascii?Q?enWAf0mMvqzJg28r54V1EUqLP4hXeNXt8p9P0S/wsU7dYEpNRZhVf8j/WBQF?=
 =?us-ascii?Q?6AwGLF310Ql5ZDQJvpgKqZnCh63KUGjOG9ap+Ii52cKeS6Jn+xhA18H6al2b?=
 =?us-ascii?Q?aGxNCMunmUJ9Griy7URlc7A+kcUL7ip9iTcfeluV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:07:05.5779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c55aac5-8eed-4065-70b5-08de1bc494cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

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


