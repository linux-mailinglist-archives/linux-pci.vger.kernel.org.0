Return-Path: <linux-pci+bounces-13607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C374988C17
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 23:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A7A283DBC
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 21:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8EE1AD402;
	Fri, 27 Sep 2024 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kM+qAp6n"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D01A4B7B;
	Fri, 27 Sep 2024 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474252; cv=fail; b=kgBdXNtZ0FSDEQNm/iXQmx+MJEQAbQTiZe29TKLeE69nfykYBNE0EgFCKg0eds4Y3q+Tqj7283hoymcbEXK8YTAStk5/Svwc6nLfgoe4d805AV18YEjuySi3MG5c+GssMQAWa0mTejMDG6afvuxKqxp9fqGcMEy1UwIpsZupz6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474252; c=relaxed/simple;
	bh=vCE6LoHIljbw+cOmgXJAI7l9jO2DIlhhfm4Lxi3kAU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4S1oTPNQ5EfY3JiaqChsNezFbTm+oBoHYb2SrDi0rkzftPSatxOnpQLVi9wowXs4yDMOKHHclv0NFvLskK97JG0H9QFAsgXrhmhrPA+Tz2h5RQK5BjRljwmoIK9VRzYiuUprmFzpH3nL4DaVevnf31Wlbow9iUMmdl2yOvIjT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kM+qAp6n; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiVyBCcY9WLNGL4w3ukDx0TlaYl7DXaZYQpZ33mfGXMW5EGoSLrSGkbV3hBMRN9XLHspRA6P0K07SLCRA4aOi3yAiNIFBCR+M4gQv1VIife04lXhsq34OhOBn7yaI2gNWuKdh6DP13yGow0RDVaT9AR2UYug52BCCu4yIK6XZ2RdjOI4YvViuN57I+BXp3woZwBhL96GZkCwKWrPRKsZmlWQfyCyBFpl+kYaV6F2XsjOhRuBalakEK9kTx8/WpC26ISSJLPawkobHJXhXGJUTF6j+r3oJ96eeDy1QH03liFHdCzCZ39JAL1Q77LaLaHYWPxdVL1TF2N+ygDepsU9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwdlzrIwqeIFSexEdZrTbPcAPWPuM3h4RgqUXyIeLxg=;
 b=D4bvAV0wmeenjZalAHNCYvrWVUife2L3pWheBUdLeRB0xty+pu3+q9DI7UvE7f+Y/tQoCozd+F7lju7ImewFPo7XrzaNK6EhZw8dpf5vPGeZNNSt0Bm4BzrGT56ywBZnuWQ8FTevrMzy4p97lIt0G+6yIPcYqGI5gaK8nlT1bSE+RIv4GU0bDFhw8y/whxOstsvWzy8MJX3f6UWmPCYrmboF6T3A8gCGdTfJn/bm/A9YIXBFQrk2nFbUh7oBGX0Ra0WRGygUUsPIy+dY9tVYCHrc721438P4CaGaGGOCwCpSXB5Wez2XvSURc4gZ+Mlu0sjI3Q7xvlYYWHGRZNIYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwdlzrIwqeIFSexEdZrTbPcAPWPuM3h4RgqUXyIeLxg=;
 b=kM+qAp6nmy8RkvFr+TrJTokoq+RwQRF4ZsMD3tMtiig25jFTDDmrNG7iDySoiQo68Ad6EMN3kJ01C0tdXCuzIz9nbWdQsVE9BXA80ECXSD1Yq53L9oXVcpcLacF5Q0TpyKHYLWWlteRWvhBVuejwHR68ECRfDXf8qj+UK+tv87U=
Received: from BY5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:1d0::25)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23; Fri, 27 Sep
 2024 21:57:25 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::f) by BY5PR04CA0015.outlook.office365.com
 (2603:10b6:a03:1d0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Fri, 27 Sep 2024 21:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 21:57:24 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 16:57:22 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V6 2/5] PCI/TPH: Add Steering Tag support
Date: Fri, 27 Sep 2024 16:56:50 -0500
Message-ID: <20240927215653.1552411-3-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240927215653.1552411-1-wei.huang2@amd.com>
References: <20240927215653.1552411-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: 04150872-cfc6-43c4-2f8a-08dcdf3f5f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c+PrmOk9RS2OXLFJ6t4ZG4um/5sYhvJuJvZ0etMb+04c8CaNHMLHz42viK2I?=
 =?us-ascii?Q?bKxmk9pIMuFCdYHFRlp/mMMwb1NcCKOuJqpOFYvUSi5c4qqiIE56bLrEnwKf?=
 =?us-ascii?Q?Jc3I/Y2K2saE2fSNAxClXrs3SfASBKHgiHdB0VPbxCSmvH5j6QcTmdHU4+cp?=
 =?us-ascii?Q?DJssZL32hRfdI5ZT4CFfFLfWNNZBpOv3x/UNGhW8e5rFkAWc/s3speB3wENy?=
 =?us-ascii?Q?F1GyM7KYVy88/nWHULFxMDh9JSxJAvuYxZg4ie4951gkFcx7nrN1szwEyOsf?=
 =?us-ascii?Q?8Z9hSsXfeCdhJjpuSo6APGFvDW96y1W0RPBxzaDbT7kO05K6OUV6XpGYzaIP?=
 =?us-ascii?Q?aqeZjzRFSG5yn5ZDrtNE2mrs0SOj73jAIpYt9XtvtFmjGI5FYrnvmrG+gWqh?=
 =?us-ascii?Q?4wzzPGbK5V25jVsxFExbQM7WlbC5ITlpgUVxx5tv5SEbOGaI99aDrByR2Wld?=
 =?us-ascii?Q?7s5rXSswoytPxOxAaxi8MsrfccQsUuPq9yujoQUkgkmzohHwlvGt3fsjnEqG?=
 =?us-ascii?Q?WI4mUFXI4fBRy4d6zXAgIFA1dF/uPOVapyIU7JJFdKDYtqJ/1NGLSgUqvoxx?=
 =?us-ascii?Q?yGlP8yww3A19vqK7PQecIF/yOkhCSkazfs03QG65F6fY7FnbpqQErq6j51eG?=
 =?us-ascii?Q?rPIw8BDPN7sQGtHMSUsBeE1qQWGXu9xEJbBLwc0eYs0vs7wk/tQCsMADXS+j?=
 =?us-ascii?Q?iY0vYiez3nCrMg1Ddd6LF+9KC/SXLDzJVBqGYVqlhN8A4YwaoUB2+CXvJzH7?=
 =?us-ascii?Q?Is1Yj+wDNFiBqZH4pUbye0y28qd1cfePZ8++NH5GJy4xzqC9Grnirv1h1ADC?=
 =?us-ascii?Q?2vuu8wSchJLYeshVMFSV0SnE8zkoKSDzBL9fb1T+IRh8PWBhKDknAZFYhlck?=
 =?us-ascii?Q?o08rXMaCRtSwermMA63dcNUEH9n9IQz+t/GoFiNHht5FEk8WwyuYWF/Sq/GF?=
 =?us-ascii?Q?D6VnQbPxZNTa+UqH8/dN+mA01nVicmPzN6J+agJCZFQAsa9TVRwLRUK7XRya?=
 =?us-ascii?Q?mvb1H1dQ9g5vw6ACIoU+bfW649+V/gr68+LcGBg+vnIrG3zd84Z2AH0uYlwf?=
 =?us-ascii?Q?eMGU2/1mrxqwlxEfQ0OKotr2jANYEXRxqyCup12eNCTkFg5rerT/n6KgH3uP?=
 =?us-ascii?Q?lpa77H5JHhhzHGtKxcdWxsnjB0LzNKlLPogGHXQxEqF2UX3MUZYEOq4UDqLD?=
 =?us-ascii?Q?dyOonsz6MCsdGOVwYmPXXjpBAtA1h42QIjjQhfkZAC4tdKR5LwDCzgmWfboP?=
 =?us-ascii?Q?S/oqqlznf49+NXQLQDwF9a8Y3xN89fMO6S2y5c7hdUwvVhKZmK8NnT3IoGoR?=
 =?us-ascii?Q?I75KnmC5E0OgtkqJVkdqhSNZ0jaQa6/AGii41hQSBau8g1E1JvZ4//Elrzcn?=
 =?us-ascii?Q?UoczEPvM4N291425sIwcL93fXoPis3kaZKiT9tkzbXhoYOJ5eVkJtN0BZ3RM?=
 =?us-ascii?Q?6dB3li/jGz00D+DXClSkTj/xPU6lqcq8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 21:57:24.6323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04150872-cfc6-43c4-2f8a-08dcdf3f5f08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229

pcie_tph_get_cpu_st() is added to allow a caller to retrieve Steering Tags
for a target memory that is associated with a specific CPU. The ST tag is
retrieved by invoking ACPI _DSM of the device's Root Port device.

pcie_tph_set_st_entry() is added to support updating the device's Steering
Tags. The tags will be written into the device's MSI-X table or the ST
table located in the TPH Extended Capability space.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/tph.c       | 349 +++++++++++++++++++++++++++++++++++++++-
 include/linux/pci-tph.h |  23 +++
 2 files changed, 371 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 6c6b500c2eaa..3285763a7c44 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -7,6 +7,8 @@
  *     Wei Huang <wei.huang2@amd.com>
  */
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/msi.h>
 #include <linux/bitfield.h>
 #include <linux/pci-tph.h>
 
@@ -15,6 +17,133 @@
 /* System-wide TPH disabled */
 static bool pci_tph_disabled;
 
+#ifdef CONFIG_ACPI
+/*
+ * The st_info struct defines the Steering Tag (ST) info returned by the
+ * firmware _DSM method defined in the approved ECN for PCI Firmware Spec,
+ * available at https://members.pcisig.com/wg/PCI-SIG/document/15470.
+ *
+ * @vm_st_valid:  8-bit ST for volatile memory is valid
+ * @vm_xst_valid: 16-bit extended ST for volatile memory is valid
+ * @vm_ph_ignore: 1 => PH was and will be ignored, 0 => PH should be supplied
+ * @vm_st:        8-bit ST for volatile mem
+ * @vm_xst:       16-bit extended ST for volatile mem
+ * @pm_st_valid:  8-bit ST for persistent memory is valid
+ * @pm_xst_valid: 16-bit extended ST for persistent memory is valid
+ * @pm_ph_ignore: 1 => PH was and will be ignored, 0 => PH should be supplied
+ * @pm_st:        8-bit ST for persistent mem
+ * @pm_xst:       16-bit extended ST for persistent mem
+ */
+union st_info {
+	struct {
+		u64 vm_st_valid : 1;
+		u64 vm_xst_valid : 1;
+		u64 vm_ph_ignore : 1;
+		u64 rsvd1 : 5;
+		u64 vm_st : 8;
+		u64 vm_xst : 16;
+		u64 pm_st_valid : 1;
+		u64 pm_xst_valid : 1;
+		u64 pm_ph_ignore : 1;
+		u64 rsvd2 : 5;
+		u64 pm_st : 8;
+		u64 pm_xst : 16;
+	};
+	u64 value;
+};
+
+static u16 tph_extract_tag(enum tph_mem_type mem_type, u8 req_type,
+			   union st_info *info)
+{
+	switch (req_type) {
+	case PCI_TPH_REQ_TPH_ONLY: /* 8-bit tag */
+		switch (mem_type) {
+		case TPH_MEM_TYPE_VM:
+			if (info->vm_st_valid)
+				return info->vm_st;
+			break;
+		case TPH_MEM_TYPE_PM:
+			if (info->pm_st_valid)
+				return info->pm_st;
+			break;
+		}
+		break;
+	case PCI_TPH_REQ_EXT_TPH: /* 16-bit tag */
+		switch (mem_type) {
+		case TPH_MEM_TYPE_VM:
+			if (info->vm_xst_valid)
+				return info->vm_xst;
+			break;
+		case TPH_MEM_TYPE_PM:
+			if (info->pm_xst_valid)
+				return info->pm_xst;
+			break;
+		}
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+#define TPH_ST_DSM_FUNC_INDEX	0xF
+static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
+				  union st_info *st_out)
+{
+	union acpi_object arg3[3], in_obj, *out_obj;
+
+	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 7,
+			    BIT(TPH_ST_DSM_FUNC_INDEX)))
+		return AE_ERROR;
+
+	/* DWORD: feature ID (0 for processor cache ST query) */
+	arg3[0].integer.type = ACPI_TYPE_INTEGER;
+	arg3[0].integer.value = 0;
+
+	/* DWORD: target UID */
+	arg3[1].integer.type = ACPI_TYPE_INTEGER;
+	arg3[1].integer.value = cpu_uid;
+
+	/* QWORD: properties, all 0's */
+	arg3[2].integer.type = ACPI_TYPE_INTEGER;
+	arg3[2].integer.value = 0;
+
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = ARRAY_SIZE(arg3);
+	in_obj.package.elements = arg3;
+
+	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 7,
+				    TPH_ST_DSM_FUNC_INDEX, &in_obj);
+	if (!out_obj)
+		return AE_ERROR;
+
+	if (out_obj->type != ACPI_TYPE_BUFFER) {
+		ACPI_FREE(out_obj);
+		return AE_ERROR;
+	}
+
+	st_out->value = *((u64 *)(out_obj->buffer.pointer));
+
+	ACPI_FREE(out_obj);
+
+	return AE_OK;
+}
+#endif
+
+/* Update the TPH Requester Enable field of TPH Control Register */
+static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
+{
+	u32 reg;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
+
+	reg &= ~PCI_TPH_CTRL_REQ_EN_MASK;
+	reg |= FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, req_type);
+
+	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
+}
+
 static u8 get_st_modes(struct pci_dev *pdev)
 {
 	u32 reg;
@@ -25,6 +154,37 @@ static u8 get_st_modes(struct pci_dev *pdev)
 	return reg;
 }
 
+static u32 get_st_table_loc(struct pci_dev *pdev)
+{
+	u32 reg;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
+
+	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
+}
+
+/*
+ * Return the size of ST table. If ST table is not in TPH Requester Extended
+ * Capability space, return 0. Otherwise return the ST Table Size + 1.
+ */
+static u16 get_st_table_size(struct pci_dev *pdev)
+{
+	u32 reg;
+	u32 loc;
+
+	/* Check ST table location first */
+	loc = get_st_table_loc(pdev);
+
+	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
+	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
+	if (loc != PCI_TPH_LOC_CAP)
+		return 0;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
+
+	return FIELD_GET(PCI_TPH_CAP_ST_MASK, reg) + 1;
+}
+
 /* Return device's Root Port completer capability */
 static u8 get_rp_completer_type(struct pci_dev *pdev)
 {
@@ -43,6 +203,169 @@ static u8 get_rp_completer_type(struct pci_dev *pdev)
 	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
 }
 
+/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise -errno */
+static int write_tag_to_msix(struct pci_dev *pdev, int msix_idx, u16 tag)
+{
+	struct msi_desc *msi_desc = NULL;
+	void __iomem *vec_ctrl;
+	u32 val, mask, st_val;
+	int err = 0;
+
+	msi_lock_descs(&pdev->dev);
+
+	/* Find the msi_desc entry with matching msix_idx */
+	msi_for_each_desc(msi_desc, &pdev->dev, MSI_DESC_ASSOCIATED) {
+		if (msi_desc->msi_index == msix_idx)
+			break;
+	}
+
+	if (!msi_desc) {
+		err = -ENXIO;
+		goto err_out;
+	}
+
+	st_val = (u32)tag;
+
+	/* Get the vector control register (offset 0xc) pointed by msix_idx */
+	vec_ctrl = pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
+	vec_ctrl += PCI_MSIX_ENTRY_VECTOR_CTRL;
+
+	val = readl(vec_ctrl);
+	mask = PCI_MSIX_ENTRY_CTRL_ST_LOWER | PCI_MSIX_ENTRY_CTRL_ST_UPPER;
+	val &= ~mask;
+	val |= FIELD_PREP(mask, st_val);
+	writel(val, vec_ctrl);
+
+	/* Read back to flush the update */
+	val = readl(vec_ctrl);
+
+err_out:
+	msi_unlock_descs(&pdev->dev);
+	return err;
+}
+
+/* Write tag to ST table - Return 0 if OK, otherwise -errno */
+static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
+{
+	int st_table_size;
+	int offset;
+
+	/* Check if index is out of bound */
+	st_table_size = get_st_table_size(pdev);
+	if (index >= st_table_size)
+		return -ENXIO;
+
+	offset = pdev->tph_cap + PCI_TPH_BASE_SIZEOF + index * sizeof(u16);
+
+	return pci_write_config_word(pdev, offset, tag);
+}
+
+/**
+ * pcie_tph_get_cpu_st() - Retrieve Steering Tag for a target memory associated
+ * with a specific CPU
+ * @pdev: PCI device
+ * @mem_type: target memory type (volatile or persistent RAM)
+ * @cpu_uid: associated CPU id
+ * @tag: Steering Tag to be returned
+ *
+ * This function returns the Steering Tag for a target memory that is
+ * associated with a specific CPU as indicated by cpu_uid.
+ *
+ * Returns: 0 if success, otherwise negative value (-errno)
+ */
+int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
+			unsigned int cpu_uid, u16 *tag)
+{
+#ifdef CONFIG_ACPI
+	struct pci_dev *rp;
+	acpi_handle rp_acpi_handle;
+	union st_info info;
+
+	rp = pcie_find_root_port(pdev);
+	if (!rp || !rp->bus || !rp->bus->bridge)
+		return -ENODEV;
+
+	rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
+
+	if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, &info) != AE_OK) {
+		*tag = 0;
+		return -EINVAL;
+	}
+
+	*tag = tph_extract_tag(mem_type, pdev->tph_req_type, &info);
+
+	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu_uid=%d, tag=%#04x\n",
+		(mem_type == TPH_MEM_TYPE_VM) ? "volatile" : "persistent",
+		cpu_uid, *tag);
+
+	return 0;
+#else
+	return -ENODEV;
+#endif
+}
+EXPORT_SYMBOL(pcie_tph_get_cpu_st);
+
+/**
+ * pcie_tph_set_st_entry() - Set Steering Tag in the ST table entry
+ * @pdev: PCI device
+ * @index: ST table entry index
+ * @tag: Steering Tag to be written
+ *
+ * This function will figure out the proper location of ST table, either in the
+ * MSI-X table or in the TPH Extended Capability space, and write the Steering
+ * Tag into the ST entry pointed by index.
+ *
+ * Returns: 0 if success, otherwise negative value (-errno)
+ */
+int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
+{
+	u32 loc;
+	int err = 0;
+
+	if (!pdev->tph_cap)
+		return -EINVAL;
+
+	if (!pdev->tph_enabled)
+		return -EINVAL;
+
+	/* No need to write tag if device is in "No ST Mode" */
+	if (pdev->tph_mode == PCI_TPH_ST_NS_MODE)
+		return 0;
+
+	/* Disable TPH before updating ST to avoid potential instability as
+	 * cautioned in PCIe r6.2, sec 6.17.3, "ST Modes of Operation"
+	 */
+	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
+
+	loc = get_st_table_loc(pdev);
+	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
+	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
+
+	switch (loc) {
+	case PCI_TPH_LOC_MSIX:
+		err = write_tag_to_msix(pdev, index, tag);
+		break;
+	case PCI_TPH_LOC_CAP:
+		err = write_tag_to_st_table(pdev, index, tag);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	if (err) {
+		pcie_disable_tph(pdev);
+		return err;
+	}
+
+	set_ctrl_reg_req_en(pdev, pdev->tph_mode);
+
+	pci_dbg(pdev, "set steering tag: %s table, index=%d, tag=%#04x\n",
+		(loc == PCI_TPH_LOC_MSIX) ? "MSI-X" : "ST", index, tag);
+
+	return 0;
+}
+EXPORT_SYMBOL(pcie_tph_set_st_entry);
+
 /**
  * pcie_disable_tph - Turn off TPH support for device
  * @pdev: PCI device
@@ -140,6 +463,8 @@ EXPORT_SYMBOL(pcie_enable_tph);
 void pci_restore_tph_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *save_state;
+	int num_entries, i, offset;
+	u16 *st_entry;
 	u32 *cap;
 
 	if (!pdev->tph_cap)
@@ -155,11 +480,21 @@ void pci_restore_tph_state(struct pci_dev *pdev)
 	/* Restore control register and all ST entries */
 	cap = &save_state->cap.data[0];
 	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, *cap++);
+	st_entry = (u16 *)cap;
+	offset = PCI_TPH_BASE_SIZEOF;
+	num_entries = get_st_table_size(pdev);
+	for (i = 0; i < num_entries; i++) {
+		pci_write_config_word(pdev, pdev->tph_cap + offset,
+				      *st_entry++);
+		offset += sizeof(u16);
+	}
 }
 
 void pci_save_tph_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *save_state;
+	int num_entries, i, offset;
+	u16 *st_entry;
 	u32 *cap;
 
 	if (!pdev->tph_cap)
@@ -175,6 +510,16 @@ void pci_save_tph_state(struct pci_dev *pdev)
 	/* Save control register */
 	cap = &save_state->cap.data[0];
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, cap++);
+
+	/* Save all ST entries in extended capability structure */
+	st_entry = (u16 *)cap;
+	offset = PCI_TPH_BASE_SIZEOF;
+	num_entries = get_st_table_size(pdev);
+	for (i = 0; i < num_entries; i++) {
+		pci_read_config_word(pdev, pdev->tph_cap + offset,
+				     st_entry++);
+		offset += sizeof(u16);
+	}
 }
 
 void pci_no_tph(void)
@@ -186,12 +531,14 @@ void pci_no_tph(void)
 
 void pci_tph_init(struct pci_dev *pdev)
 {
+	int num_entries;
 	u32 save_size;
 
 	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
 	if (!pdev->tph_cap)
 		return;
 
-	save_size = sizeof(u32);
+	num_entries = get_st_table_size(pdev);
+	save_size = sizeof(u32) + num_entries * sizeof(u16);
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
 }
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 58654a334ffb..c3e806c13d64 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -9,10 +9,33 @@
 #ifndef LINUX_PCI_TPH_H
 #define LINUX_PCI_TPH_H
 
+/*
+ * According to the ECN for PCI Firmware Spec, Steering Tag can be different
+ * depending on the memory type: Volatile Memory or Persistent Memory. When a
+ * caller query about a target's Steering Tag, it must provide the target's
+ * tph_mem_type. ECN link: https://members.pcisig.com/wg/PCI-SIG/document/15470.
+ */
+enum tph_mem_type {
+	TPH_MEM_TYPE_VM,	/* volatile memory */
+	TPH_MEM_TYPE_PM		/* persistent memory */
+};
+
 #ifdef CONFIG_PCIE_TPH
+int pcie_tph_set_st_entry(struct pci_dev *pdev,
+			  unsigned int index, u16 tag);
+int pcie_tph_get_cpu_st(struct pci_dev *dev,
+			enum tph_mem_type mem_type,
+			unsigned int cpu_uid, u16 *tag);
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 #else
+static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
+					unsigned int index, u16 tag)
+{ return -EINVAL; }
+static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
+				      enum tph_mem_type mem_type,
+				      unsigned int cpu_uid, u16 *tag)
+{ return -EINVAL; }
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
-- 
2.46.0


