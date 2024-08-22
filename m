Return-Path: <linux-pci+bounces-12047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438295BFCD
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F281F247FF
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A3F1D175E;
	Thu, 22 Aug 2024 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KlbZbgJd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CED91D0DFA;
	Thu, 22 Aug 2024 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359388; cv=fail; b=YtBvSlHliTw/fmfuS2Y5BztRxjfVTANPbu/4lcAbw0TY8WC3onGy6zk1qZPwgSM81ieVfihdsRqGFL6HnwpVsejsNp2lILkg+SUsWvlB/W0aUEIAwqWprF9fhzo6FrZmrEXLt85476UZx0yggW23UI5zWfO0pzkdGB/tyQ8EM4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359388; c=relaxed/simple;
	bh=lGpezmEHBOftE9zul+gS+ggitrrrojjj86m3gCKd2+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXKnUpWnKlO6AFz1p/bx6JpPFl4kNB6+YzXmNGO10ha29GUT+yoo6UOm1rUsv3XXX7cJ19vgtLqJYpKNltY53nYkrjGVwxqf/iJVEIb5s7gMoTbbqeRTonxSfzeVsVgAWKxAa9OLeenlXBae2NWjgmzKPFjikOCNsgSu2776/Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KlbZbgJd; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkUO4z7cKpr+n61c7T5/badry6Wb9zxQ6Ll9VmU3M13g0hRy5k3TRCK+GxkqLYiSxcWMt58Z43Z8n2DwG5ylK1CFA2SHxAGr9GhustU3CA09lf5Famp+xp3JA7vOXNyudrF/XvW6vTjbyytEUzABlx3dym1qVpo3X3Wij8m72IFGXhryjqXADqmt3jnCR5WKuzERXJ/pytq0yNXQCZVlYElHUTESD/ElN9OR4L3EcTFrOPc+e3IIoPs5VyZTwSkU6uxxR2WCFvcjCJXAF96Kv5QbvQbbF15H5R5UnQco0JrZQZBhNVTDYAifBsb42SFYjlh5vYFVP1QLV2JH3JJL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tkxORMkLIo/2S9Hc7kF7joPZYPPHM8oLKAMMHTDOVk=;
 b=X/PsdgRSB5+Sv9IWqRc1DWCrqaaMRZujnsHuniSv8zCj6khnQNx7NK03dhS9a8jE6LF8LHVLJ+65I12B4aQPT8RAOBMg9kyB3NEJEZnZdZqhl/FfWSyyJHBN6yCO52NAr6FLtkSaPPMo/rCxj5kmc8tNApd+ssQUlD52+3C9SojxE7pwiqw0L6t5KQmw+XCi2SCUeBAsAdJQce/oW/q8c6BuiXhhWrxKTaiIwtITlQ1yh1k58orMarDpT9cDv/cF8a0dSJCGRaWatyyspLU0UUtTSywIA3AVsD1XLHJ8F37og8B9+aYQvcbwY29yL+C+qtrw3QVwXsWG/2xFRxHGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tkxORMkLIo/2S9Hc7kF7joPZYPPHM8oLKAMMHTDOVk=;
 b=KlbZbgJdPBLDDV/JWlnk4o+rXbro03rHjQJLxmqcGR7dCLDYWMUOb541bsrCPnHFsKxTm86uQoHnR9LudCyyBL9gebhBWdM+LW1oMsUY2snYUsCGhOuUH9arqiDy45ogrHANlOC1eRN2cmSfuh9yCKgdRoQPNNqiBpeW1ZTLJyE=
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 20:43:01 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::38) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Thu, 22 Aug 2024 20:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 20:43:01 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 15:42:58 -0500
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
Subject: [PATCH V4 08/12] PCI/TPH: Add pcie_tph_get_cpu_st() to get ST tag
Date: Thu, 22 Aug 2024 15:41:16 -0500
Message-ID: <20240822204120.3634-9-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240822204120.3634-1-wei.huang2@amd.com>
References: <20240822204120.3634-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: d9930b35-ca96-4c6c-a157-08dcc2eb03ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sIe9L44ToC+uSLN13ZpmCgadKrh3LQgm+1mM1xxXS3kqM/NEKKjvZk7wWJq8?=
 =?us-ascii?Q?lRW+xZBE+Gwzzr2gKW17oGkfE4oeCJTMzgFEStgW/HWAJfTyyyLWXqoSkjGs?=
 =?us-ascii?Q?5dNaR1x5xQM63ZoZuYD9ogRfgyTOXnu8h4w+ZEhWQmc3wtPCtho0bPRWp5gn?=
 =?us-ascii?Q?4BgjcX4G6GlSe9v3IlIcxjR630bU75eM8F3Ue6pjMkc37tM4rofhffDyZubi?=
 =?us-ascii?Q?K+Y69gsBn8zlrkQDxdyUHM4KGSAv3ck77xsmjCZtc+NrLlnQ/uJfoSFF669p?=
 =?us-ascii?Q?L3HmbMquSMIkZJPMKCNnLy73f7Jvq3hcBlz1I85nSzh+www5Qej/QJmeRLpD?=
 =?us-ascii?Q?bbke3KpxLmEaE/h9COhSzxUZ9R1o/0h4MUrcvseoH4BwUFvEEfOxjuQ2yovf?=
 =?us-ascii?Q?UxO0QGKNLQ8XDNRMpCKbEm0VTGoXMscZRRlmURHdYxu7dDUvJnD3tD3aB1a6?=
 =?us-ascii?Q?v1AohT1EhqsQhcn/U84u26XZjDKaYvJo/SYl3z3FMfCFvU6xudVR5atRtGe1?=
 =?us-ascii?Q?AEjOr38DUcShoWV+uYNW7pJfvNyC5o71Z/NF5IMgsYdK/JQpvprzM8IqeyJ5?=
 =?us-ascii?Q?NN4ezSMexWCeMfplMRzeE4iC8aWIClxN7nRrAMrW1i/toTdyhZ0uG3xTHyXM?=
 =?us-ascii?Q?TORn3rgh4NNZ1eUjTFTUCMYYV2mOpRlElDP5KzA9TvUbqoSD5uvXusV0tdnN?=
 =?us-ascii?Q?qLCtPCpilv2phf3eehSwGjIu8OmH+Aw9ZjyYaZYM+E/ZHReY0jCdPcFq7Xjl?=
 =?us-ascii?Q?JDVbt4MZST76nO/hiO7E/nfyUC3FcS/dNZrnXo9nsIhCpkBxBKbto3SmF1sg?=
 =?us-ascii?Q?+KJJTLXsYJqo+qnbKrjAlNyxP05J8gXLgdNdBwFieYWRDXaAG9OMP3MFlybd?=
 =?us-ascii?Q?AcFMX/ym/CAlfyG1UXAm0uYtNfnMVUZhagoMEYNQLMo4eP3vvd7qhu18j5sM?=
 =?us-ascii?Q?/LQVP+VCHaUhPoOntFrHOBFUSszfTH3G6Kg0iEbWSVfwNmBvZZOHEcarrXtj?=
 =?us-ascii?Q?TAlphyGuZmAMDHQX+AS1gsB7pAFXcwxCgWPWyXz0pAxqcr3AlCmiuQYKn8U3?=
 =?us-ascii?Q?7cQ/IcVkYHvZOpGiWTU1AnqR7R4/qFDQN7VtAIgcSRW4QqEGstZ6W8AjUydF?=
 =?us-ascii?Q?X0q/Y3hRzAX0uJyLTUl+gWzMsusakKe96kL9QAeVoq5Y9lD6coUb8E8OXFTB?=
 =?us-ascii?Q?eLQ8RjNhykgNilc6e+aBmkrkREHfPXmJRppECN+mOCdl0CcrPUAXYUnXkcqo?=
 =?us-ascii?Q?LulS7k0A8Sg5RCCN7tA0n3/gjFanOhDQ5YIPav6//RqkHuZMOTo9LmkOi5og?=
 =?us-ascii?Q?CfOovGPHHtP1jbDumA35lHGuF710VMEm5HLmmAR/CKYqcWFHSS4f50OGo51o?=
 =?us-ascii?Q?IkquTg21OtD+WzVjf53A0JkArBEgKolp2oXUEdl63BTmN1yWQVqrrRIr/I6o?=
 =?us-ascii?Q?3RrP4zOtBW3v3VBCMdJA/rL6MMBgxTqM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:43:01.2575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9930b35-ca96-4c6c-a157-08dcc2eb03ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257

Allow a caller to retrieve Steering Tags for a target memory that is
associated with a specific CPU. The caller must provided two parameters,
memory type and CPU UID, when calling this function. The tag is
retrieved by invoking ACPI _DSM of the device's Root Port device.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/pcie/tph.c  | 154 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  18 +++++
 2 files changed, 172 insertions(+)

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index 82189361a2ee..5bd194fb425e 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -7,12 +7,125 @@
  *     Wei Huang <wei.huang2@amd.com>
  */
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
 #include <linux/bitfield.h>
 #include <linux/msi.h>
 #include <linux/pci-tph.h>
 
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
 /* Update the TPH Requester Enable field of TPH Control Register */
 static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
 {
@@ -140,6 +253,47 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
 	return pci_write_config_word(pdev, offset, tag);
 }
 
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
+ * Returns 0 if success, otherwise negative value (-errno)
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
 /**
  * pcie_tph_set_st_entry() - Set Steering Tag in the ST table entry
  * @pdev: PCI device
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index a0c93b97090a..c9f33688b9a9 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -9,9 +9,23 @@
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
 int pcie_tph_set_st_entry(struct pci_dev *pdev,
 			  unsigned int index, u16 tag);
+int pcie_tph_get_cpu_st(struct pci_dev *dev,
+			enum tph_mem_type mem_type,
+			unsigned int cpu_uid, u16 *tag);
 bool pcie_tph_enabled(struct pci_dev *pdev);
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
@@ -20,6 +34,10 @@ int pcie_tph_modes(struct pci_dev *pdev);
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
 { return -EINVAL; }
+static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
+				      enum tph_mem_type mem_type,
+				      unsigned int cpu_uid, u16 *tag)
+{ return -EINVAL; }
 static inline bool pcie_tph_enabled(struct pci_dev *pdev) { return false; }
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
-- 
2.45.1


