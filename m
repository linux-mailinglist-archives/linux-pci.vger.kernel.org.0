Return-Path: <linux-pci+bounces-7302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A208C12F0
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 18:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3542843AF
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0576117165B;
	Thu,  9 May 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rdCI5zbW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185917083F;
	Thu,  9 May 2024 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272148; cv=fail; b=bY4Oax4p2E9nrlXA4mTCCszrSdnt9ed7krJ7GKB+HHcw9/FR/MQ0NWFAmHXiNGI9Os/Z4wea+ULLbz494AOLDMxtyy+pf4BtN3pMDay9ejim1iAr/796TUHzdzllY0CE+vWo67h+puYg0IIaheM/+NduVqa20+XSqrWAz8eap6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272148; c=relaxed/simple;
	bh=Yhc9s6uYSK9X4v0SINfVpHmcW2DTUb00++1j6VTrzxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odmoQVp9GABJ5sKgn1/1aAv1iG9f9OxvHa/2fE88UAFIb3Actr3FB5ilIwLH0ejExt7+iv1ZRCRfQY9c/x/0rgyD1IUByOW866R/gmpvom7OL2OdWE5/2BXq2GVl+U2F7L6tIs9fvpjtcJmYNUV1AXggblonb7RU7/hiC6tzQ1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rdCI5zbW; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7wTiyLYhBlqBQZjekJtu3PYY6cT+pjHFeJ9XyBVqCQBRTHD/godQfcZP8lRC5nR9Q+gYbo36J7uB6WADiE6Sd3XzzX3toEilu/DecB1uiNWyWjlguM4PbRrFicCZh3qA5dWIpEwU6C1znIpb+mj3bEXcg/jVgM9jLsBxsmMo1pnH7lIDnQge/3xQeIH6zJMEy7dBvz00XPYG7xnNIV0wsYHWNg6LRmUnAkO0wUmTmm3NVQ4xScgQHzPT6DJKOIEQ/RvLRcR+uLeiYLxkRdgQ/+kpGwB3fvKCuxaksjGsfkyGWeNfBgLEBTreidnrl/y76dZ9WOihIo6OM2ro5SYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7nzZkBmis+PVS+pZs1aLLvIsReyfZCrD8K2qr9oL6Y=;
 b=CsD0P2Kz0dcHq1J7+jAxMU30T0EenhC1d4cNfxMe7KNTLjG5fouBudRv0Bbs5DAHuEl5w8hSVfaNHunbd8NH3d+KxSDDjq+QQgBch1I58tgn53e4DTCx2IDYDwb9uSRosWxLg0pTKvSGyXA7dn7eCoUBAapjsDqfdovtU/UD7GDMmCjyE7c2889+SnrjKNJAqsYGCqwHEayavgvxFOHlgLmdfQaM00a1SstiAd4W4NYhpc1VgE3T78MoLCuxc0RhBrSciSSc2TQYBh7xBN85JU5iM4A+DSyllgmNuWDXB/jjyiOB2MxYyaCiQAraH1FnXWlT1WlCqxPSRfVA7/wNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7nzZkBmis+PVS+pZs1aLLvIsReyfZCrD8K2qr9oL6Y=;
 b=rdCI5zbWqCNoNENSNJzfhp8I6xyOQtVxHGFTZjyhA43HEAWhuSyyDVGO9Yug/WMklmnomJwt1myFm/wmxBYgivm3pdcbpKg+Ohi3I20d8Xfva0KTf7+V2EX0b0bifTlLbIKCWM7qlDb4nGTURveMbD/XErviR1LEnnq0bvp1cLU=
Received: from CH0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:610:b2::19)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 16:29:03 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:b2:cafe::d7) by CH0PR13CA0044.outlook.office365.com
 (2603:10b6:610:b2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.13 via Frontend
 Transport; Thu, 9 May 2024 16:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Thu, 9 May 2024 16:29:03 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 11:29:02 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>
Subject: [PATCH V1 6/9] PCI/TPH: Retrieve steering tag from ACPI _DSM
Date: Thu, 9 May 2024 11:27:38 -0500
Message-ID: <20240509162741.1937586-7-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509162741.1937586-1-wei.huang2@amd.com>
References: <20240509162741.1937586-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 808542cd-1255-4daf-ed67-08dc704523d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eSeLZ9ncmOVcjwY7tiElJr4v+LnuZFJKgy/BJk/0rfg7PqO1X6gjoEBqepUq?=
 =?us-ascii?Q?uZp2WPwrzV6I6p84i/x2WM/gNvtGJPv7zJXcGSX/yL67SFgzEBov+X8+xBye?=
 =?us-ascii?Q?OK2sa1+c9q8GXoJCISLfdhmieoqoP0JgQ8CotcvLW1UlUX3+OQKzhlNFlV2W?=
 =?us-ascii?Q?qds3nQlUp7wqh2ChefxtOSEWzcRkQjJ96otqYIvd2wF7MqcDMol4v1rL8re/?=
 =?us-ascii?Q?yn6KN46uv/4SUcs7S6fxg1Wed33QKFkDcyt0mnmYNOCk3eQ5Ecm8aI4a+4pY?=
 =?us-ascii?Q?QyTvYWCum76Z77BKJFN17il2hsZcLie/zPLHMzhnhFaxIPCXRMVdVs/nZiDf?=
 =?us-ascii?Q?h4xU2tb11Cf2wxgS/uRF5CSoPYYbkhLHU9mixJBqDNIiGt/rw6LqCQjvd7eo?=
 =?us-ascii?Q?zQLAed+6TrkIGNKUQskCvcwZtr8ytPCuHJMhvFjShbJmoQY+dVChPz+lZIYA?=
 =?us-ascii?Q?Lj8naP5Hd0Sv+3i+ecIAxfi7wSsncOg7gLpuxRyBLOaHpxO98zRj4iTJxtzR?=
 =?us-ascii?Q?oAZjujCzir81i3a72ppRF3U6nboOj/cdBRVSUh7s6o5oBYufSeHDTBZW5auN?=
 =?us-ascii?Q?QjcB9keBE1rv7BlQbgX5VMIKcG/nW53/6DNMVJg6JfRKLLexo4j7hItPPVmi?=
 =?us-ascii?Q?60iqLWprRHLW8KpKyZzAQ2dNAzmnyvXdWTsWpilimHdzbkYbakaf+R/E0SQS?=
 =?us-ascii?Q?bQOFPUPQo7YOk1p1Ly6rvIJCRh8lEkC1WXMcBtt+tCi6t1TSEnEBB8sVfSVD?=
 =?us-ascii?Q?0Y8Adpr1q2+/HTH/LJ/fi+2UbJ4XRQFKNeFHITZEqLGH1k4oQJjsFtMpMfh3?=
 =?us-ascii?Q?bwpDE/HFWMElQzOBS+YU7KB271DCrCxCuJ9fihzyzdAnv1Vnilm+ikqobhWe?=
 =?us-ascii?Q?FxZJjo5ss+K3UJDMWwxs8F7CBeatTAYC5aVBwnnxQSIFS3nRxiLYLPHrEaWs?=
 =?us-ascii?Q?XaMyyya/JzYRZVvr1l14fhPvZgHhwiiLtbSFFSzKnmOY+3SagYQdOLhfN3oh?=
 =?us-ascii?Q?2K2p13DkRX5u/DnAvHAI6JlNZhhJawMiHJPoyqHIMAFs7OsfV7g5R9b5HPOl?=
 =?us-ascii?Q?be1d2h/Fi8lzFy4oqK/hQ7KCBMPU99su2/D1Ehj3BXLEiukjCQnQvGEpiqnz?=
 =?us-ascii?Q?QpM5PLGGetq2b1s3kjDrYSK/s7mEZ83ahIWdUUGuT4QISRSS6rZjR/FiZlyy?=
 =?us-ascii?Q?yX+Ke1zBX89Nne63yeTKV+IUuPH2PeNp9B5c5bCGIV02uX8oR2PL8z4NTCy3?=
 =?us-ascii?Q?4usWcZcm3+4VgcD0McJVNRv+n+WtiZottzJbJuFAL6yP0rR/pobFOH8PulIh?=
 =?us-ascii?Q?HQNxesaZNyQ6BO7/zM0np4aR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:29:03.5157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 808542cd-1255-4daf-ed67-08dc704523d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517

According to PCI SIG ECN, calling the _DSM firmware method for a given
CPU_UID returns the steering tags for different types of memory
(volatile, non-volatile). These tags are supposed to be used in ST
table entry for optimal results.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/pci/pcie/tph.c  | 103 +++++++++++++++++++++++++++++++++++++++-
 include/linux/pci-tph.h |  34 +++++++++++++
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index 50451a0a32ff..b9d61e1cfd88 100644
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
@@ -423,7 +515,16 @@ bool pcie_tph_get_st(struct pci_dev *dev, unsigned int cpu,
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
index 42ecd6192e69..ed5299a831cb 100644
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


