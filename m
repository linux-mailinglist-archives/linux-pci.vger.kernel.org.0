Return-Path: <linux-pci+bounces-10468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0198E93437F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 22:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA96B2133B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0AA1862A0;
	Wed, 17 Jul 2024 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y3lzUzat"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8674D1849C2;
	Wed, 17 Jul 2024 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249798; cv=fail; b=at7/Ef3TfE+htLXBrpwe8zu25Lk7o9/CVXvmu2kCaTRQ8Z36P5PKVdbfqNccO5jc4idvArDwIqZGGA3TIksUwM27qC2YhX5cI9+kWUuXEBIsWcrk0v/sIdS2RO1Y7v36B6Qj3D8BdZg2E3rayYRxaDjYIJt49EAl8d9DBO9Bxl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249798; c=relaxed/simple;
	bh=zP4Fhvctdx1Vo8lXlwKkZmqfD+kN4HyOrQHrIQ7L1Ac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KamiXTtONvSTqWWNI4bkh2u/Qd00sNN6xPDm3pJYCDhRoY03tonhaMpM6jNZ1KcTcolpobWOMIwWw6yJQXlVGKURMt0BbntD9ZmEgDBL+6BAmO1AqoDJgeoBb8SNMGyr8/QJU27iovbyY3jY87CL03X6e6WxZ7Uk+aODMcRU/mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y3lzUzat; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRQF6oT0dxRbUJNj1EU/dL9MdPoiO6m0zLCvvsUu3XvEaVfZjLgFLr9v2+LHB5oJhElJvsa7VA0ZDNyYaVMO2PZ6OD21ASL1hfUr3rcNFVZSN0KN1aZiVktVY1hF/e9pSf4VUvgVquvCcxSZWLrSPwVbnq2KdmQqe2Qzx7teaZvblNuw04OXki0ckqKsr7OwxPDdEOvyP+H5yBR/iZC2hOes/KhK7lpMXwDbwlfINqaqOCeIfgNlQI8cT3O0wz2YZuvoABRVp5DCypIifZohkgr6nbqQohNA2oXeueEz0tkc7O4PO7i9st6YXvRuhdI6sg2xrYD7xfMhnEkx5SGOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5izINN96DgP2b6cdjJtmDyGA3yyxTLn97BWbABQ8iI=;
 b=pJdC6HKWbwRZT66HtIq2xFW8kD4yErbZ1OsMj8UdZbvazgjCjNOVeH4ieKaJHb9NN6nbVDVDYb7CmPBtup2kD71CQ/lUzNrKvEB8qpegj3fWOBt29rURfKF0nlurJVe2uwID1xU1yj8h2KHiseJ9VrxW/vDTHWZT/EUZxykPVMVCB1BmEy28NpeFCU8rzeHdyTlrsd43ioW8twrIX9OYg4gAQCTExOdAwyWr2jd+gNrhnV3JSSwX79MJpmEbWr2BppPTARe64OdKCzmS/VUmEg+gASSIeYhzZWmCmRUs+hLTESKkpiDFGALDYrU6s7Vq0smD+YjaxFqekKPZuYu2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5izINN96DgP2b6cdjJtmDyGA3yyxTLn97BWbABQ8iI=;
 b=y3lzUzatKiqDMKMWsKaoVbAiSYnAT3pP52X4/ZCCvbZgkvUG8LSuoIR9rrJc9amI34gqe3D0zrP3f7Se50eIyqNOMNP1Z4dAp0XkTwF5GDRw+z3DQWEqCziArCwjrWqTdFYrJwXQmXtZG0k+UfWePy+FzHAwxAc+LdXl0L6QZSE=
Received: from DS7P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::16) by
 DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Wed, 17 Jul 2024 20:56:33 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::7f) by DS7P222CA0020.outlook.office365.com
 (2603:10b6:8:2e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 20:56:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:56:32 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:56:31 -0500
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
	<bhelgaas@google.com>
Subject: [PATCH V3 06/10] PCI/TPH: Introduce API to retrieve TPH steering tags from ACPI
Date: Wed, 17 Jul 2024 15:55:07 -0500
Message-ID: <20240717205511.2541693-7-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240717205511.2541693-1-wei.huang2@amd.com>
References: <20240717205511.2541693-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 67aa6001-74b3-4723-f5a8-08dca6a2f08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ScxBXa1HxKW7pJIlQ127Cgitz2CzPsKVWblshQ9xWVwceEa/DnZJtGV12uq?=
 =?us-ascii?Q?yJITxZVSw6EVFVrTVoQgEWlXVarGG0Z92C3N07wTnqYSdIdMgUszDETZXJ2t?=
 =?us-ascii?Q?io3Fu9E4FEdXiEWnHWzGQrTNomjv1T2MC9duWAM92/vNxu+ccYV70yQN1FDe?=
 =?us-ascii?Q?CKhiDir6JOZVeZzGj51Y5vsH3om0fQjQ9R2eK+aQDlJb+EcSCb2mBdxL95OE?=
 =?us-ascii?Q?8CKzGdt8eRhj4bfDoJIxB4uvPscKsFkuUfYcJrXB4vp8zrlM/BgweTe/6m8B?=
 =?us-ascii?Q?y3FaSqIvMx5CsFmZBtHW1p6yO2jCiOJUjmqjn8RiQ8tx9hWAaKGGL9YJYJpv?=
 =?us-ascii?Q?J6uZ/Obqt8b46kiQ3102vuPHH185QBrxiWdhjrR++J+Q7fU0aRUfQbzfOweL?=
 =?us-ascii?Q?eyakXswUvNXuQ9+TgLxnYEWyIV3T6d5NGENnvf8PrJ+MmWcXgAE41Fl/1tR5?=
 =?us-ascii?Q?rrIlaHQHqwH381yQnBmQ+GVrm4xHbcN0WEXm7pyTTVT7b0J2Vj1W1AskNpWZ?=
 =?us-ascii?Q?bCICwUZuunjqQnXslIOycis5cizFwhUbZS91VpqdT3XJRtNI8Q+G+E/KnH1X?=
 =?us-ascii?Q?DfnQJzRuNEFVAfO6OvLCVUdmwGeBl2rTt4Lk2MfNAttyxZ6dNEZ8Mq3ix99/?=
 =?us-ascii?Q?hngi7b9+JF+sID2q4upQpGBjeaC1N7omrbkkrGh39mUoHfQOuM3qK66jfOPE?=
 =?us-ascii?Q?MbMUmIdY2uJoz2Y9qCnMmTfW0HZ/Zo+IlvATwSVw016VNBzzNh5a4AgSNmfu?=
 =?us-ascii?Q?/AijNU9cW2l+saTPCAd2h4FR4/cqoPrfGd8zrqBw4MRFkV3DSCZcg58LwKEa?=
 =?us-ascii?Q?HFDtBPGwOx+oxGX4htBbq/ltsz1wSYsey8YFkq7jPNr7fB3dsMeA5QHkkTyP?=
 =?us-ascii?Q?5fZgGQYJSwCWcpycxSG2kJcV/j+xe1WHvMjXfXZIiPRhLOlCS3eyQQWPsH0j?=
 =?us-ascii?Q?dBVaD6arTGjeWpuq+3Aud0PZFRHztEdiLW1msI62xlSFwKOJw6pMciPf+aOP?=
 =?us-ascii?Q?h4coqchdqXMdVfNPN1UMocB0Qi4jSnbCz35UL+u2wVNvFCFjUDOSWLMx2NAV?=
 =?us-ascii?Q?UqjwKU3M+lka7L3R9ra7w/otu/BnuhlqAIdQvZvZwRCXVx7HZYb6OzC2/a6f?=
 =?us-ascii?Q?fUnxuv2chYEXVrOJ8MhyXJMRmcoT9Y6T+JVVRO/uWzlLhuZvdnas2kfIcv1A?=
 =?us-ascii?Q?BYdojP9Ya41s7AWQ0nA/FghkHIkyOdk2auRJXxqdl0KwUQfBu+RtZx8kXAxp?=
 =?us-ascii?Q?CcwbFPOwlO2olug3ehRPa7UIhgrshJrOxIcK6a59zxXb5GtxsgHl4jJJWKQf?=
 =?us-ascii?Q?4WiLyyKcclYrZE8lrrSw7zQt7n8Df3gEs8eBoWB7VB4B3gxitNtuVAv7hx8Z?=
 =?us-ascii?Q?9tFQE1mH78sWlaWbaU0Dw32M6SKTnCdJsU1vfBr8j0qk7jVxaR6nvAWlZ9Ja?=
 =?us-ascii?Q?qKkx4cZWyo95x1cLS5XwIJ1qm5Drq6Ox?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:56:32.9265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67aa6001-74b3-4723-f5a8-08dca6a2f08d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140

Add an API function to allow endpoint device drivers to retrieve
steering tags for a specific cpu_uid. This is achieved by invoking
ACPI _DSM on device's root port.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/pcie/tph.c  | 162 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  12 +++
 2 files changed, 174 insertions(+)

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index 7183370b0977..c805c8b1a7d2 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -7,12 +7,133 @@
  *     Wei Huang <wei.huang2@amd.com>
  */
 
+#define pr_fmt(fmt) "TPH: " fmt
+#define dev_fmt pr_fmt
+
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
 #include <linux/bitfield.h>
 #include <linux/pci-tph.h>
 
 #include "../pci.h"
 
+/*
+ * The st_info struct defines the steering tag returned by the firmware _DSM
+ * method defined in PCI Firmware Spec r3.3, sect 4.6.15 "_DSM to Query Cache
+ * Locality TPH Features"
+ *
+ * @vm_st_valid:  8 bit tag for volatile memory is valid
+ * @vm_xst_valid: 16 bit tag for volatile memory is valid
+ * @vm_ignore:    1 => was and will be ignored, 0 => ph should be supplied
+ * @vm_st:        8 bit steering tag for volatile mem
+ * @vm_xst:       16 bit steering tag for volatile mem
+ * @pm_st_valid:  8 bit tag for persistent memory is valid
+ * @pm_xst_valid: 16 bit tag for persistent memory is valid
+ * @pm_ph_ignore: 1 => was and will be ignore, 0 => ph should be supplied
+ * @pm_st:        8 bit steering tag for persistent mem
+ * @pm_xst:       16 bit steering tag for persistent mem
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
+			   union st_info *st_tag)
+{
+	switch (req_type) {
+	case PCI_TPH_REQ_TPH_ONLY: /* 8 bit tags */
+		switch (mem_type) {
+		case TPH_MEM_TYPE_VM:
+			if (st_tag->vm_st_valid)
+				return st_tag->vm_st;
+			break;
+		case TPH_MEM_TYPE_PM:
+			if (st_tag->pm_st_valid)
+				return st_tag->pm_st;
+			break;
+		}
+		break;
+	case PCI_TPH_REQ_EXT_TPH: /* 16 bit tags */
+		switch (mem_type) {
+		case TPH_MEM_TYPE_VM:
+			if (st_tag->vm_xst_valid)
+				return st_tag->vm_xst;
+			break;
+		case TPH_MEM_TYPE_PM:
+			if (st_tag->pm_xst_valid)
+				return st_tag->pm_xst;
+			break;
+		}
+		break;
+	default:
+		pr_err("invalid steering tag in ACPI _DSM\n");
+		return 0;
+	}
+
+	return 0;
+}
+
+#define TPH_ST_DSM_FUNC_INDEX	0xF
+static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid, u8 ph,
+				  u8 target_type, bool cache_ref_valid,
+				  u64 cache_ref, union st_info *st_out)
+{
+	union acpi_object arg3[3], in_obj, *out_obj;
+
+	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 7, BIT(TPH_ST_DSM_FUNC_INDEX)))
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
+	/* QWORD: properties */
+	arg3[2].integer.type = ACPI_TYPE_INTEGER;
+	arg3[2].integer.value = ph & 3;
+	arg3[2].integer.value |= (target_type & 1) << 2;
+	arg3[2].integer.value |= (cache_ref_valid & 1) << 3;
+	arg3[2].integer.value |= (cache_ref << 32);
+
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = ARRAY_SIZE(arg3);
+	in_obj.package.elements = arg3;
+
+	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 7,
+				    TPH_ST_DSM_FUNC_INDEX, &in_obj);
+
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
+
 /* Update the ST Mode Select field of TPH Control Register */
 static void set_ctrl_reg_mode_sel(struct pci_dev *pdev, u8 st_mode)
 {
@@ -89,3 +210,44 @@ bool pcie_tph_intr_vec_supported(struct pci_dev *pdev)
 	return true;
 }
 EXPORT_SYMBOL(pcie_tph_intr_vec_supported);
+
+/**
+ * pcie_tph_get_st_from_acpi() - Retrieve steering tag for a specific CPU
+ * using platform ACPI _DSM
+ * @pdev: pci device
+ * @cpu_acpi_uid: the acpi cpu_uid.
+ * @mem_type: memory type (vram, nvram)
+ * @req_type: request type (disable, tph, extended tph)
+ * @tag: steering tag return value
+ *
+ * Return: 0 if success, otherwise errno
+ */
+int pcie_tph_get_st_from_acpi(struct pci_dev *pdev, unsigned int cpu_acpi_uid,
+			      enum tph_mem_type mem_type, u8 req_type,
+			      u16 *tag)
+{
+	struct pci_dev *rp;
+	acpi_handle rp_acpi_handle;
+	union st_info info;
+
+	if (!pdev->tph_cap)
+		return -ENODEV;
+
+	/* find ACPI handler for device's root port */
+	rp = pcie_find_root_port(pdev);
+	if (!rp || !rp->bus || !rp->bus->bridge)
+		return -ENODEV;
+	rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
+
+	/* invoke _DSM to extract tag value */
+	if (tph_invoke_dsm(rp_acpi_handle, cpu_acpi_uid, 0, 0, false, 0, &info) != AE_OK) {
+		*tag = 0;
+		return -EINVAL;
+	}
+
+	*tag = tph_extract_tag(mem_type, req_type, &info);
+	pci_dbg(pdev, "%s: cpu=%d tag=%d\n", __func__, cpu_acpi_uid, *tag);
+
+	return 0;
+}
+EXPORT_SYMBOL(pcie_tph_get_st_from_acpi);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 854677651d81..b12a592f3d49 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -9,15 +9,27 @@
 #ifndef LINUX_PCI_TPH_H
 #define LINUX_PCI_TPH_H
 
+enum tph_mem_type {
+	TPH_MEM_TYPE_VM,	/* volatile memory type */
+	TPH_MEM_TYPE_PM		/* persistent memory type */
+};
+
 #ifdef CONFIG_PCIE_TPH
 void pcie_tph_disable(struct pci_dev *dev);
 void pcie_tph_set_nostmode(struct pci_dev *dev);
 bool pcie_tph_intr_vec_supported(struct pci_dev *dev);
+int pcie_tph_get_st_from_acpi(struct pci_dev *dev, unsigned int cpu_acpi_uid,
+			      enum tph_mem_type tag_type, u8 req_enable,
+			      u16 *tag);
 #else
 static inline void pcie_tph_disable(struct pci_dev *dev) {}
 static inline void pcie_tph_set_nostmode(struct pci_dev *dev) {}
 static inline bool pcie_tph_intr_vec_supported(struct pci_dev *dev)
 { return false; }
+static inline int pcie_tph_get_st_from_acpi(struct pci_dev *dev, unsigned int cpu_acpi_uid,
+					    enum tph_mem_type tag_type, u8 req_enable,
+					    u16 *tag)
+{ return false; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.45.1


