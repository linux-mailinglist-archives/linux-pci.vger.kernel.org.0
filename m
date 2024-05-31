Return-Path: <linux-pci+bounces-8148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C76F8D6BCD
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 23:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9AE1C24AFB
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 21:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055E680626;
	Fri, 31 May 2024 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hBOnZnT9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A3880043;
	Fri, 31 May 2024 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191633; cv=fail; b=CKMy+t7TZYoG0ra2kvYTiHIblyEneGrKggdA2UZYQkt1jy4cToD7yjvtjjnipmHM4t6LG6MMvBiGJ3FKHsA4ddFJNjC/yf7leD3HYoe7XH3022VjPNgygzSHpW2Nso8Rgb4ptnK9Zb1H8Z0l0caDOWQf6EWm7KvIOeGsbNzKzwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191633; c=relaxed/simple;
	bh=DukWMzIob+iLaT8VORBQPoAb3+xYvQnMu0pPzp0UjUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzSQqsrHfk9VC0/BvAtRfmaQn68p2YJUPTSPwLBg+2mPOs63ahMdIm9eo8awd3iPyNTUeNyL4Ogtgzz286d3CWGHbB3Zz1K068rjFoXbydr4NGERZO9QtMgY23hWTRvNJ7W3rXNhz6UfZFoJI6gu6w/gM5r5zN29GW63B1kVCmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hBOnZnT9; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieulYGWmmOTp0bQE5mhmTFLHK7TOHJ9uSymUiyuSMStiQfHIMhd7iqa2b9UHsMTxQmvokoYVEwuDalL34G6JO0nmrwoXz6LG0jFXKifqpPpsbTeB5y/hUccSWzGTxjMfTLA8Cqklksj8VhXsnaLBcqY4tlwMZ3pynr60mOfqUQY/42D2o1ilNHTbJTHRT3Ju+Qw5klkNkaWjgO9sYfYNadOal7q0Z43UNaB0b6hzXH4uzGZdbZ1/8ibAUNd9H/QWnaNXpgmLII9ILBCaswLg2vLgpHz90CbQpxrd96zmgLgghFGFAwAl/mDD/f4qEYtCqqY8VZIh/HYoYqgp0QXwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw6JZNUpyHIwJR2o+d1zz9gOLAtHgXaxRHZt2MGu6BQ=;
 b=U93cFhoxjGVNgI3TQsWgcPqO2qSTpZxc+woWbbS6tCw3JL+K8id5ktT1JiVuJGV/Ltx/Mb4pBEp1k5Zmd+TDfLFUcitV0/IzMJV+whW4s2hXhfnVdenSHvZPst2+eO+VFm/TdaP/kAyPRTkD3CAAiYEHWQLHUZ8FSvL46TWskpr1gSlDtKGi+2IFBZD6dr/ri7Bfjfgkdo9OHu8C2mv5RHHvAa+X6714T6GJmSFC+QsqsQBoz3EAem4d8r0JBkkk5FSLm0YNkU9mTsujRsamkfXFMQJO6AV/gIjt2Epga6VG5Lxfxov2w4RxLHwdspsYllCM0FpXIu4Kix8AXVfaJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw6JZNUpyHIwJR2o+d1zz9gOLAtHgXaxRHZt2MGu6BQ=;
 b=hBOnZnT9jWqstM6nnUo28hgLm5/fffVWW6vS7WkvB5DE8m51PEwLtsdu9tH6y5NWVA+/ga482uHK8PuCKLycP7Zywe3ZrnYBgZ9ZUmuPM4AZTK1pXBqLAXPvrYR2pQFR7Vy1DC/VM7JCrNISbt6lVcZazPX+vauIePskaUHoHHM=
Received: from CY5PR13CA0030.namprd13.prod.outlook.com (2603:10b6:930::18) by
 CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 21:40:27 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::8a) by CY5PR13CA0030.outlook.office365.com
 (2603:10b6:930::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.10 via Frontend
 Transport; Fri, 31 May 2024 21:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 21:40:26 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 16:40:25 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>
Subject: [PATCH V2 6/9] PCI/TPH: Retrieve steering tag from ACPI _DSM
Date: Fri, 31 May 2024 16:38:38 -0500
Message-ID: <20240531213841.3246055-7-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531213841.3246055-1-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7152c140-1b3e-48fe-7fe1-08dc81ba48e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cNtJ1aYrsM/uneCIgbyBdtFNgfbcN4M6ESeUVYHWto+uTYYjduiLfd1bSY/P?=
 =?us-ascii?Q?zBkA0rGW5AfH9xbPA6QB+TUQRxn3ERu1/Hsn1pcJk9JquEAgB57OXW1K8Zwe?=
 =?us-ascii?Q?XWvDM6SM5dHxRIZhKIoVWDeDoRfUbKYAiIa3vOEWvD6gUagnDvo9nIz8R4V3?=
 =?us-ascii?Q?tvIHZOVtLX0IfVd7wL/nb/rDN+hg5Erbz5hodRa5hIQCF2mfVCGPhi/82Xwa?=
 =?us-ascii?Q?d7zyO+DZeDafAMQtaeCCM9vWvBxR13Q/OWhn9wJIkkAJ7iBaaPR8za6rSr7U?=
 =?us-ascii?Q?sUlwgwZuxT39OHMmVhoHhxQF97X25rLBV1UABktgxZh5FtcFobaW5pJNGmhB?=
 =?us-ascii?Q?rH0oIwDBrSyWopAobNvDnHLhIRD2Y0V1PVC9xNYCawgRmQGhmok4vhw18+eU?=
 =?us-ascii?Q?P737b55CAVBSm1VRyFddN1R1C6huDbiSBINb1ThR4Iru2eKgnvBhul6OC7eO?=
 =?us-ascii?Q?aTJCtlRnA7mKXhuhWkE1Rec7y2oLI4lejWKgtNM5UklcmW6wfFOM9XxNmxBq?=
 =?us-ascii?Q?09XZosWiCdfFZcHy79OkgIOZ1O6BzBamocbZORNjERxqR/J8H4RErxXPaM04?=
 =?us-ascii?Q?5LJqLSUd6FsDaByJ4lNd3qB0M9s8DjRrryJ9Da2jOzyFziBruCR7ajVyDVLb?=
 =?us-ascii?Q?41pgLyr8CK/xhPgGSKcNsBloOpGO0hhnrel2I0HlmY6bxW4B4uFlgvv76vi9?=
 =?us-ascii?Q?RKIgTP4n5Cnj0TdOGQrpNlTJ4uWLvVLpG/YkG3dVYJgCNXCAv8+5EC30AaN4?=
 =?us-ascii?Q?domX1mgfpMkrOp3acKz4teZxf4QoCZKvADO6SB/sjfGDEG4+f8ucOToQpNBm?=
 =?us-ascii?Q?sTxk9TlVsXzMn2MExG/24mouzLBUzZnK31ZRW+TSXuHIezO+F9jbu6ZdQcrp?=
 =?us-ascii?Q?+/tDkeNAIh+WiH4xdskqSF8mNMEPznt2P95LfBdjO2tP+68xRgLZzd0WFb9r?=
 =?us-ascii?Q?MBDIs3C+CNxPRVv6TyvqpdqJXT6Vzd9/Mmoftp7t1Linhja/5/nXcSCkYFHr?=
 =?us-ascii?Q?JsAf70udRI9Xjd1mN6fEwjlQTLaiiL6T/RJcyhoEasWjbTf8JTzyf6JwALPf?=
 =?us-ascii?Q?ob5OrAmwrKWFNhj3AzX05SCVqFz2mWbY0M9sAC766qkrHjG31zyOaI/eo2bM?=
 =?us-ascii?Q?B42Sf5/T2bOnwC71+vekTyGWzBcLVkQUsSnGDRwhMoKa8oXiJS4nQN8zsF+I?=
 =?us-ascii?Q?UoxJANg5kc3RTFh3L9UOX/o6RojP1T19kxIrNCNPmRO2IlSMC7oNNiIdSiWW?=
 =?us-ascii?Q?/WBuUB7AHQv6cXyKfsChVYmAWDor1PuVOiy0PAgWsywQyNMrbWw7BPtt9bed?=
 =?us-ascii?Q?/CTFBk3N50oXjlpyBUrh5hTQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:40:26.5836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7152c140-1b3e-48fe-7fe1-08dc81ba48e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341

According to PCI SIG ECN, calling the _DSM firmware method for a given
CPU_UID returns the steering tags for different types of memory
(volatile, non-volatile). These tags are supposed to be used in ST
table entry for optimal results.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/pcie/tph.c  | 103 +++++++++++++++++++++++++++++++++++++++-
 include/linux/pci-tph.h |  34 +++++++++++++
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index 320b99c60365..425935a14b62 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -158,6 +158,98 @@ static int tph_get_table_location(struct pci_dev *dev, u8 *loc_out)
 	return 0;
 }
 
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
+#define MIN_ST_DSM_REV		7
+#define ST_DSM_FUNC_INDEX	0xf
+static bool invoke_dsm(acpi_handle handle, u32 cpu_uid, u8 ph,
+		       u8 target_type, bool cache_ref_valid,
+		       u64 cache_ref, union st_info *st_out)
+{
+	union acpi_object in_obj, in_buf[3], *out_obj;
+
+	in_buf[0].integer.type = ACPI_TYPE_INTEGER;
+	in_buf[0].integer.value = 0; /* 0 => processor cache steering tags */
+
+	in_buf[1].integer.type = ACPI_TYPE_INTEGER;
+	in_buf[1].integer.value = cpu_uid;
+
+	in_buf[2].integer.type = ACPI_TYPE_INTEGER;
+	in_buf[2].integer.value = ph & 3;
+	in_buf[2].integer.value |= (target_type & 1) << 2;
+	in_buf[2].integer.value |= (cache_ref_valid & 1) << 3;
+	in_buf[2].integer.value |= (cache_ref << 32);
+
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = ARRAY_SIZE(in_buf);
+	in_obj.package.elements = in_buf;
+
+	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, MIN_ST_DSM_REV,
+				    ST_DSM_FUNC_INDEX, &in_obj);
+
+	if (!out_obj)
+		return false;
+
+	if (out_obj->type != ACPI_TYPE_BUFFER) {
+		pr_err("invalid return type %d from TPH _DSM\n",
+		       out_obj->type);
+		ACPI_FREE(out_obj);
+		return false;
+	}
+
+	st_out->value = *((u64 *)(out_obj->buffer.pointer));
+
+	ACPI_FREE(out_obj);
+
+	return true;
+}
+
+static acpi_handle root_complex_acpi_handle(struct pci_dev *dev)
+{
+	struct pci_dev *root_port;
+
+	root_port = pcie_find_root_port(dev);
+
+	if (!root_port || !root_port->bus || !root_port->bus->bridge)
+		return NULL;
+
+	return ACPI_HANDLE(root_port->bus->bridge);
+}
+
 static bool msix_nr_in_bounds(struct pci_dev *dev, int msix_nr)
 {
 	u16 tbl_sz;
@@ -441,7 +533,16 @@ bool pcie_tph_get_st(struct pci_dev *dev, unsigned int cpu,
 		    enum tph_mem_type mem_type, u8 req_type,
 		    u16 *tag)
 {
-	*tag = 0;
+	union st_info info;
+
+	if (!invoke_dsm(root_complex_acpi_handle(dev), cpu, 0, 0, false, 0,
+			&info)) {
+		*tag = 0;
+		return false;
+	}
+
+	*tag = tph_extract_tag(mem_type, req_type, &info);
+	pr_debug("%s: cpu=%d tag=%d\n", __func__, cpu, *tag);
 
 	return true;
 }
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 4fbd1e2fd98c..79533c6254c2 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -14,6 +14,40 @@ enum tph_mem_type {
 	TPH_MEM_TYPE_PM		/* persistent memory type */
 };
 
+/*
+ * The st_info struct defines the steering tag returned by the firmware _DSM
+ * method defined in PCI SIG ECN. The specification is available at:
+ * https://members.pcisig.com/wg/PCI-SIG/document/15470.
+
+ * @vm_st_valid:  8 bit tag for volatile memory is valid
+ * @vm_xst_valid: 16 bit tag for volatile memory is valid
+ * @vm_ignore:    1 => was and will be ignored, 0 => ph should be supplied
+ * @vm_st:        8 bit steering tag for volatile mem
+ * @vm_xst:       16 bit steering tag for volatile mem
+ * @pm_st_valid:  8 bit tag for persistent memory is valid
+ * @pm_xst_valid: 16 bit tag for persistent memory is valid
+ * @pm_ignore:    1 => was and will be ignore, 0 => ph should be supplied
+ * @pm_st:        8 bit steering tag for persistent mem
+ * @pm_xst:       16 bit steering tag for persistent mem
+ */
+union st_info {
+	struct {
+		u64 vm_st_valid:1,
+		vm_xst_valid:1,
+		vm_ph_ignore:1,
+		rsvd1:5,
+		vm_st:8,
+		vm_xst:16,
+		pm_st_valid:1,
+		pm_xst_valid:1,
+		pm_ph_ignore:1,
+		rsvd2:5,
+		pm_st:8,
+		pm_xst:16;
+	};
+	u64 value;
+};
+
 #ifdef CONFIG_PCIE_TPH
 int pcie_tph_disable(struct pci_dev *dev);
 int tph_set_dev_nostmode(struct pci_dev *dev);
-- 
2.44.0


