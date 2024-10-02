Return-Path: <linux-pci+bounces-13720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F10498E15A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 19:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4687A1C243DE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CA61D1513;
	Wed,  2 Oct 2024 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aKndpXxy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796501C36;
	Wed,  2 Oct 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888436; cv=fail; b=tVCVyhd3OqPCwKgqk5bzTpcTcM0p5D3yiWazCogVwlTkvLYBciUtiHENpJ/F5Tvbkk6TQ0Jdt4rSTZfvM7lJAlDFGJN8/IlE1PYOe2jaSrHmzT6+VFObJE2wPA/Od+l7zxwjiVwaXKMoJZmppdZ/pOitabB41zm9nj5nfDGORRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888436; c=relaxed/simple;
	bh=GE5Ak3Esz5diDdcR6RL8mHrTmVXTprZ65lPEZbSYJKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIhfh1m5H/fbCyWYjwAXeYUQxKEbbexH2S7anYgBhxbSI73zwKOi0sFgLZT3uI2L/qIQGc+jF575r7Hw+wWHyoaT9GHS6uEXXPpSL/+W+9GVnLI0VZ10xVglceCcs2RpHkVFS9SyRFHT4Xv71YvMoqzKuUs5piT3U3Q+YxymWUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aKndpXxy; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DL69zKYBOHLPIEJIzUkANktvpbY3JQVK56uY5GHmukKEn2oDvXMhRieCL43Oj11ZYivqYcEWfQ51TRey0OMA5YbeepkYpZZDBKBx3/bqqoBMOnwKgFf7ep3Gm6D/IJays7JWGtd6plGP2OOWRwSy2bHPaFkS1HPnae1JxqfkFgVbbvOqStNuLQSujNCl7Lo2E0Gz0UYpobYfFHlhnuJRHt3Lr5qmnphDmS+4+XMZqEtykONutvkS+qNphQP9rNE6Wqn8OHnEbGb8aRrjbKqS4NyTihdGsVJ+HMeCFwEgUFm4t9nV+qUGWjhcDeGL8D7nVCjUbU43/SAnP0xZsNkMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0voJwfotcDxcQN1wVl74vw1W/1iMW0A95SuITVkWQw=;
 b=BCFj6f6G8+4Fzzdf5ec5Lt7GRIqE+bk/h2ynXajpgtU77hOQ2+a+jAqudegdJJecRdZ5C/WLa0y+kunEKUxA68nDSIziU4CKdnmZJivzaRhutQjqZ/gDMAvgveNjAaQqgQ1AVlAfrPEIsCwT4n1nEvPVRVOjHJcr0Id6/3SIVDp+v/BDfCtyM20nWyG9heZEWawetU9W/F9Q9CvgCWS/v7SY6l2/Hc5G32Q7Gh3jK2aPScb8H+hMs01s/m8kBz3mF3M6S7fqtFs5leDa+M6nxkW+gCb7/TOk/0KnHAQR5kknL/37yygBZ5gOryP2kqJi2nEcam1lvd0jDeAU2jPHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0voJwfotcDxcQN1wVl74vw1W/1iMW0A95SuITVkWQw=;
 b=aKndpXxyTTq966+bTmSJpqfugqYs+SLbqGVrr/7hPS6UQc0B9CizFLTs0a3pyVC7Z6iDUYtlVs5Pv64EtXJBgKlukM0UY9qhMANAUiNLMy+HAyWoqEwDnOCHZzeEHIqvMpSEudKtafhBh/B5b6Zh1Jx8sS9AkX7W60sHtyzgQsY=
Received: from BYAPR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:c0::47)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:00:26 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::85) by BYAPR05CA0034.outlook.office365.com
 (2603:10b6:a03:c0::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 17:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 17:00:24 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Oct
 2024 12:00:23 -0500
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
Subject: [PATCH V7 2/5] PCI/TPH: Add Steering Tag support
Date: Wed, 2 Oct 2024 11:59:51 -0500
Message-ID: <20241002165954.128085-3-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002165954.128085-1-wei.huang2@amd.com>
References: <20241002165954.128085-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdb56fb-b0f3-46cb-ed8c-08dce303b5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bl69QnVEXOfJPkmt2LVqS8h3nni2F3HeOJpCtIRYqI1kOKBBsm2WO+4xuvqQ?=
 =?us-ascii?Q?GzfPvtjAA5xlucCaJ9dlfbzb5o8iE2QZw4cRdeZjuZ9eb3bGqErJsnTKJnRu?=
 =?us-ascii?Q?LD5N4mkw0cxyieZzIb3h8XhJ0e2XbxtIAUIvI/CV+3/gGiOnRCOn6Aq1j/hl?=
 =?us-ascii?Q?X9FejSSeU7GApu99kJwPSc94VztcLyihg/45//LZN4ey+aeZ9ju0XRz81nHc?=
 =?us-ascii?Q?Rzy9Kh4xvEReWuAdAmdnp8SLf3t6VfYsBrZPVDu8siVPDILUBw0+rGAgB70f?=
 =?us-ascii?Q?R15u9VfM8ZkWN2jfy/nK/wDmNOq5Ls0qJEvRw9WEQ/yi8sD+6a6djZGYO0Sz?=
 =?us-ascii?Q?p+rJoGtfamnZIDFkg0bYtZhTDi7ZB0nddk00X+6jJjM+5IaNNTEsh1S7m3kz?=
 =?us-ascii?Q?Gu9jERPgKHRTbSLgqF9T1OJq9A09S5vXkFTzvNk+5N3w+lA0MUrd85sRDP8Q?=
 =?us-ascii?Q?Ax6bhQd0BZA9QWP42newdpg/f+oOxI8D/3aMbK1vU2iw9bmG9uhxsBmhPnHi?=
 =?us-ascii?Q?1o/BpK9DqQV9rfKmOjtIFRH8sTpjWU7K1DVnLxqq75zCFcoPmvkpF02sD4K6?=
 =?us-ascii?Q?UCTO6l0ZJWj9WNyihTBCgF02aZYdGhBNKOfnqPLGH6yhTze0Amp+UAFxGCsI?=
 =?us-ascii?Q?h3aZ/vbbBf8GiIsP6k7Pz5wmPpS2/nc5v/X5Kf3rrpHGssqm+E4BrQOmp2+t?=
 =?us-ascii?Q?T6yaMRYgNNdZUtyYAI6+QjPxRjzYcULKT0m/9/LQH135TdVIGRBX8lnvm2KD?=
 =?us-ascii?Q?whC/gufGnJsWPEgqzcFL8tX0vm9SM9dGIcsYK6XV2vF+dJqRegf2XLwXB974?=
 =?us-ascii?Q?vCuuQg95uznPbu+YdBGakHxs9bmCq8wxDcHdPRacQ6Yt6+MLrRcKkLi1dulC?=
 =?us-ascii?Q?fXnJKyyogxCMQtzktxjrKPVDnLAP21HxHeVb7FsCO0b0S3HTU4u8pbnKBp/+?=
 =?us-ascii?Q?1Q2eoz3vyfwCg+u9sbqdQnvOIG8CCWhb+9oraV8bIdYr34iGGVlqNe+jBywL?=
 =?us-ascii?Q?HsGD2N90rafJPYhvFoYe2G19lL2/rTOyoAtWYwNLFVHRFxev4r0qUSXgXhbQ?=
 =?us-ascii?Q?oIlp/RKKza90MWkBtrPe9U2bJUrvGaRCWH9ysYEYpN7SftOf6eTUUYzSSWG6?=
 =?us-ascii?Q?S7jGPs+fxFbZVd+NWEILq+GrhJl10FLagP0L2m98kt2hkUYsO5hruogt6G1J?=
 =?us-ascii?Q?WcFzxkc2J5ukVu90TVkBSdfNOYewW9AD0ct8d+FfpthL8acxPBxQ+dZNd0/s?=
 =?us-ascii?Q?K3SvlQ+rIzbL5MXVhFYTDrtvOwCeJDUtXCAI3n+odr0UYk+eco1is/X037DE?=
 =?us-ascii?Q?nyNVp5LBBzfMpK63CE5VfStdBjLNtvvqlwF3pODsZmw263xaCo1lnOVROoFm?=
 =?us-ascii?Q?qspYk82jm7npv60GQ7HupGkdIOyW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:00:24.8756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdb56fb-b0f3-46cb-ed8c-08dce303b5a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885

Add pcie_tph_get_cpu_st() to allow a caller to retrieve Steering Tags
for a target memory that is associated with a specific CPU. The ST tag
is retrieved by invoking PCI ACPI _DSM method (rev=0x7, func=0xF) of
the device's Root Port device.

Add pcie_tph_set_st_entry() to support updating the device's Steering
Tags. The tags will be written into the device's MSI-X table or the
ST table located in the TPH Extended Capability space.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/tph.c       | 351 +++++++++++++++++++++++++++++++++++++++-
 include/linux/pci-tph.h |  23 +++
 2 files changed, 373 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 6c6b500c2eaa..9a268653866d 100644
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
 
@@ -15,6 +17,134 @@
 /* System-wide TPH disabled */
 static bool pci_tph_disabled;
 
+#ifdef CONFIG_ACPI
+/*
+ * The st_info struct defines the Steering Tag (ST) info returned by the
+ * firmware PCI ACPI _DSM method (rev=0x7, func=0xF, "_DSM to Query Cache
+ * Locality TPH Features"), as specified in the approved ECN for PCI Firmware
+ * Spec and available at https://members.pcisig.com/wg/PCI-SIG/document/15470.
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
@@ -25,6 +155,37 @@ static u8 get_st_modes(struct pci_dev *pdev)
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
@@ -43,6 +204,170 @@ static u8 get_rp_completer_type(struct pci_dev *pdev)
 	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
 }
 
+/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise -errno */
+static int write_tag_to_msix(struct pci_dev *pdev, int msix_idx, u16 tag)
+{
+#ifdef CONFIG_PCI_MSI
+	struct msi_desc *msi_desc = NULL;
+	void __iomem *vec_ctrl;
+	u32 val;
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
+	/* Get the vector control register (offset 0xc) pointed by msix_idx */
+	vec_ctrl = pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
+	vec_ctrl += PCI_MSIX_ENTRY_VECTOR_CTRL;
+
+	val = readl(vec_ctrl);
+	val &= ~PCI_MSIX_ENTRY_CTRL_ST;
+	val |= FIELD_PREP(PCI_MSIX_ENTRY_CTRL_ST, tag);
+	writel(val, vec_ctrl);
+
+	/* Read back to flush the update */
+	val = readl(vec_ctrl);
+
+err_out:
+	msi_unlock_descs(&pdev->dev);
+	return err;
+#else
+	return -ENODEV;
+#endif
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
@@ -140,6 +465,8 @@ EXPORT_SYMBOL(pcie_enable_tph);
 void pci_restore_tph_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *save_state;
+	int num_entries, i, offset;
+	u16 *st_entry;
 	u32 *cap;
 
 	if (!pdev->tph_cap)
@@ -155,11 +482,21 @@ void pci_restore_tph_state(struct pci_dev *pdev)
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
@@ -175,6 +512,16 @@ void pci_save_tph_state(struct pci_dev *pdev)
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
@@ -186,12 +533,14 @@ void pci_no_tph(void)
 
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


