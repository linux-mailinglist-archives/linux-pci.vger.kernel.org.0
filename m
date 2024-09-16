Return-Path: <linux-pci+bounces-13246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98A997A87A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 22:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F328B26E27
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AD1165EE2;
	Mon, 16 Sep 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G7+iWlBk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC313A86A;
	Mon, 16 Sep 2024 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726519902; cv=fail; b=IhYlxIl1uukFPe5tX2f2STVRCxbBN/eAFND/Kytn7PAiO2egEjuDeGuGByBA4aEwYS6J9fu+BUoEjctISntoB5MKUhNsopvGuYSpc/7u6m22kUb/MN7RNxeicFjrIhVj599qW8NoRVzk5ZRCvX2Rg2dn2QnkYehq6ct6GTHakyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726519902; c=relaxed/simple;
	bh=QnfquOj+gXkcuHeGLYc6rix0rKS4AOOsJMLq8Z0QO+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDtA64Y4lDewG6+KFf+yFgB1mXgRJTyJUOm3CM+TNVO/BgCL+KwAze0m2s6Ba03J72/qFAusIjINEjDQFTN18u/+iykylApB/WgoJq+IpbRdA7m8rHH4Jv6OkfWEvOHK/Oe+0uCIQsjRnye54qA5DfnEd5rvCPKnPpEwOajHDR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G7+iWlBk; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBWx+sRcO+UcSWTZlu4fDI+pb9GhE4KlytNO9/JpOozEVroABdtheckRaQfEuWJcOp5tTd3HrshgNb1WzvXgNyhP6GQR8bhwv0Y6PY+ZiijXUxhZ0vVUFpEfv+w/PVSctQFry7vdpioMr02kCRSFD7113t7A+cL50vr0zJzQG5YnP61359KWTWitTlRV6j6clbFUMKxCOt40OnyYnu2fU40kNtODblqfn2wAmbH2bgvmNk2xNU5sCIF7nfdAViCA3gOOkg5Dy39uknIjqUou5py+GWALExIbOgHVmJcJxC8T80EN7AayK2t0VRFy/uYD+fkDKKllFCxVdadRnIMC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbL6cqZI0y2u7z0spJ+25eumiGVxbOFvSJYnPrkvd30=;
 b=ohSyReiTyHYy077D9y08PnH9s2HM3TDAYyDyoMyB3eGu/zpPQVBHBTCks1Dm73K9VsqbSoO1CCZVDpvgfVmnqbb7k+t0js+dU+yp/gnNTct6uYtVL30av0XawqRltgdSvJFIdUflGd9VhBT/qx+GFioIkPcHCWZ7TT4jSy1k9tazxEb2hxYA4SR23SkLqVvdl/PQP7SkR1+q7e0G+aCYDPex9kmamPGbe5EwEzs9DVFS+w+V/tB6z1glBE127rwUiw7RXEfZq3EknK5KrYD8iwt99hPOCxHabo8VggJYsHeDDWmcClJfBirl5/1t6jf2wjMyRjYUe/BJeXIhcyeXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbL6cqZI0y2u7z0spJ+25eumiGVxbOFvSJYnPrkvd30=;
 b=G7+iWlBkwpmFT7LPK+0l5l4117gK999Z3RxDa0ujLCpLIztaxqWzCU6hUpFR5aKq6+YrymPnYzhyZWwugdYVqnX+odtGMDCxanIi3G/PX4gF+73/pjkinbbi+OhmHbr4sgYbcRT62HIC9E8Hra07AkK6cMvi7bJ0Jo17ugAp+YU=
Received: from BL0PR02CA0051.namprd02.prod.outlook.com (2603:10b6:207:3d::28)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 20:51:34 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::34) by BL0PR02CA0051.outlook.office365.com
 (2603:10b6:207:3d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 16 Sep 2024 20:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 20:51:33 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 15:51:31 -0500
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
Subject: [PATCH V5 2/5] PCI/TPH: Add Steering Tag support
Date: Mon, 16 Sep 2024 15:51:00 -0500
Message-ID: <20240916205103.3882081-3-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240916205103.3882081-1-wei.huang2@amd.com>
References: <20240916205103.3882081-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: c3cd4159-ced4-412b-3c4f-08dcd6915980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Se8EG3GFE4xk0nbMJwR2CVUnc114wRnImUqupW1TFvlEHbTUsryauAbrpF3?=
 =?us-ascii?Q?9Q03FM0M0iHl2AVgrTFS/IhP3ONmoNOSvF10za7LBvG0jnXuhtp8cJSNZ1gx?=
 =?us-ascii?Q?CmMmlulLQFWosxnJKEfOpKGdecWzk7lQaSoYEHW6pL42wtPeOfcGS1lS7HlW?=
 =?us-ascii?Q?mwoTH/tgfgGptGBAA+sxhpISdQKxthJj1Ggf5fHrwHpauiEDMonc1bLMtyPQ?=
 =?us-ascii?Q?IsiTXYpMN6oqW7fo3DlD45WeEgTxoRh60jOaTEx1/fLMWeC8TGk/trwpPUTR?=
 =?us-ascii?Q?qy7cohl9Jy+8J26MqaB7NsMhHAjjWsbGkN51ioJomE/eg2cqjeK1+F2zMv41?=
 =?us-ascii?Q?qvIGuCfcwZItVnBPnN57+24wusuFHnaQDpWrEs9ifVvs9/XycVUfSWhUntMB?=
 =?us-ascii?Q?MzQ7jZ4QpwryiZiZHYfNWhpfK3pVi/cKfIWqes1aYQDuHRmve2MlPCCt83wY?=
 =?us-ascii?Q?B3JDDdaOeixiDSwmysCSROITkGkxvhvQcZJz+s3N09d06Qfp2mnQw0GwU2j8?=
 =?us-ascii?Q?cOQENSV+2ML6fVNHiqY7B4c0KzC3q4zFtPL193unwJRxjVPp+WWqb4XIzUxy?=
 =?us-ascii?Q?DYPedLvCzag+HkpgTPCI1yQ+vC3d/Bd1njKdlzh0QdHi83cl1Hy6mhTv/rwx?=
 =?us-ascii?Q?dJEH2XYWwqI900Vid6SmjGEBiQzjJPXBXIjDdAhQCTqVoH0nvkVb2bDvBnUL?=
 =?us-ascii?Q?1hW2wGMHT2tjTWzbqHdTm7P+XdF7WSIeX03FvSL2xJz1YQLrm81xjLi3idJK?=
 =?us-ascii?Q?/sbrSgo1v10FgQCWVzJfeXzUl4mJ0rZwB28n7sVSbb0xm6EA+sGXwXlEg1pN?=
 =?us-ascii?Q?nhRbjzd6TQvY4BP7uCgqzqy1VycDqGqC0J5hvZhHCa6ORKq2Fp6P1Loep7nS?=
 =?us-ascii?Q?68m75RVBaBvWYt6JmmYW83WSNfULR9WfpT2VAcm+deNzlZQivvutxxPftge+?=
 =?us-ascii?Q?fkQ/DF0fCbRz0gRu3WyMFgSBKjwVogNvxS6iXBF4iCN//eyrlfUgaVg5G698?=
 =?us-ascii?Q?AFI4HnZwoqecTiFCA3DScGXYONWd9vYeJ21SqUqPyhOwQKM1pS9SWRqz9khZ?=
 =?us-ascii?Q?WMowRXr58DVgnben0nhRy2+gM0GHPjWWb59x0USzUoiN+bqVO4hcNMdI7k+F?=
 =?us-ascii?Q?/hv+rRa1NwtnyPa7r5nOm5Ok6padj8BkqyanHK7a1loWkTVfNn3U3ftwjANp?=
 =?us-ascii?Q?KLqIKyYZzP7zAYQpa41OeMLHWqiOE9W+WxQd1lOFwj3einy3utFwsoqep8kC?=
 =?us-ascii?Q?Kk/WM9B7HQnl9rcFyBQzDTpRNrrBD9B2UvQdgtZJ7c0gbPI86lkdtzFHJ+nf?=
 =?us-ascii?Q?0LEcViCE/AI/IKBsY6BNQ0hD9lIdsNW0f732rLFVtP/W+smXz8v4qWblupcb?=
 =?us-ascii?Q?ucz3AFtFh+Ank9FJaDduHVBLcMT39nTsDZNDzyCIi16ZwhK+L90GYyMyxVNA?=
 =?us-ascii?Q?2VGsolc6iToZdkK52wJArVI02QoH5PxE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 20:51:33.7602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cd4159-ced4-412b-3c4f-08dcd6915980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998

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
 drivers/pci/pcie/tph.c  | 339 +++++++++++++++++++++++++++++++++++++++-
 include/linux/pci-tph.h |  23 +++
 2 files changed, 361 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index 1efd76c8dd30..4b386616fc28 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -14,9 +14,134 @@
 
 #include "../pci.h"
 
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
 /* System-wide TPH disabled */
 static bool pci_tph_disabled;
 
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
@@ -27,6 +152,37 @@ static u8 get_st_modes(struct pci_dev *pdev)
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
@@ -45,6 +201,163 @@ static u8 get_rp_completer_type(struct pci_dev *pdev)
 	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
 }
 
+/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise -errno */
+static int write_tag_to_msix(struct pci_dev *pdev, int msix_idx, u16 tag)
+{
+	struct msi_desc *msi_desc = NULL;
+	void __iomem *vec_ctrl;
+	u32 val, mask;
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
+	mask = PCI_MSIX_ENTRY_CTRL_ST_LOWER | PCI_MSIX_ENTRY_CTRL_ST_UPPER;
+	val &= ~mask;
+	val |= FIELD_PREP(mask, (u32)tag);
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
@@ -142,6 +455,8 @@ EXPORT_SYMBOL(pcie_enable_tph);
 void pci_restore_tph_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *save_state;
+	int num_entries, i, offset;
+	u16 *st_entry;
 	u32 *cap;
 
 	if (!pdev->tph_cap)
@@ -157,11 +472,21 @@ void pci_restore_tph_state(struct pci_dev *pdev)
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
@@ -177,6 +502,16 @@ void pci_save_tph_state(struct pci_dev *pdev)
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
@@ -188,12 +523,14 @@ void pci_no_tph(void)
 
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
2.45.1


