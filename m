Return-Path: <linux-pci+bounces-44795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B302FD20C6B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD7C53063276
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C89C32C928;
	Wed, 14 Jan 2026 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SdRl4xQw"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20455335078;
	Wed, 14 Jan 2026 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414906; cv=fail; b=B+REi05dIFQm4Duymzd+JDHr0XgS5/G0dhOsCMQyhyNv0aZp19AGXCzRYNZh5I34bW1Z5U8jFcBYRO9cSBaQP2vLGXHatNuazrPKbwX/BIKPKlcVsVv+7N8rvx4S0EyMj+4ZS8qmSKEkCYci1G66X5fMRCtSAdDpwTkieoyYi7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414906; c=relaxed/simple;
	bh=pIX9xW5mK0GUDhZ0nzicXRwyEXymXpNvhcQOBRbc3+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbhgB7sZc3e7aqNNbczXacOhJLzP3s+CF8WrPbxdqBkf7f4RnWUiNapU+aHT/YohPcRFtxpshhO5qlFRAx6C8DtYnE/DuX5GB6zwrmXZJiuHfzigAxrXzhW5GT0L3YcP78JBs8/F6DyOPL/Fe9xBGqvNWK5g53kSvo6M9Vs7Fn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SdRl4xQw; arc=fail smtp.client-ip=40.107.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSpazlsJdYX68lD20shyXgBPWEtWLeYGwBssnY7jg2IPo1m04odDqPtFno51E07JyysgobpKPHqTiMDLBDrR5pYQKVRv/VFYN4FgUaOzsiE+dP0mUBTDhqTXW5DxJ3KJzJYZ3735tne129FXGJ0G7gfoOIZXUCxeNiTiqhy7qTm+se+Y4t2vaOiI2wKTVcSWTYYCR7uKbgVxEbu84NqEQygXBwOJQE1mu00Vng/rdTpmcguYta4YA+1HmDBAyYOrTdRrwLCZjA8+khL5UpiffVeDvMSLKKrm9CzX0jsWIDMRuQaD4FFt6ao8jvKU38i1Ev/z8O0fk+qnJ8bGxR0OhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJUi2sbM6SlHDcHyUC8VTTzizLSOzHoHOzAUd4Oj8kU=;
 b=dOhxLFKNBo3eKsj8eCQDy4v53KLbnoKw5HBE/NBxK2xe349SGtXw5zFuFHzdsVDlPBSDpf1E5mnAm2cFgelf3/QQBgqu4MXeyTEvtC5ucW3e7vPx7xtPkUEgZEOxk32iIhCoottEDaFM6+Jk8hKpV9qDXab4eQgST41P4UIL2du6kk5KGVPISdDViDR/raNKUxOVdNZ4Ulx8GgCO8p9mh2HE3E/G5XmucD82q6mm3yIPpLjegPGdDGxyTYBmBcygl8PB1KZiErcHMGSFUqj2BLIrFGvyYQxYkChw+R2Lx+bN+b2x8ZZHFHIaNAtYS2kRbTBNP/HxUHEf11OCk/MLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJUi2sbM6SlHDcHyUC8VTTzizLSOzHoHOzAUd4Oj8kU=;
 b=SdRl4xQwmyVSuM8Oe1PkNMKGDiOO27ifWMPoi/TXjVKlsPAyGrkC1XYydFJ0QNWIucqAmYKERYrnYHaAFFIDh3Ao2at3eL10eb0VqNcH7H0BRWJmdurlBu6KEQFf5R9fYDJfyz5eO/qWsCMjqFYZdgO3IzsWsRlHXTWRgb8l0ZQ=
Received: from PH8P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::29)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 18:21:36 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::93) by PH8P223CA0004.outlook.office365.com
 (2603:10b6:510:2db::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:21:35 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:21:33 -0600
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
Subject: [PATCH v14 02/34] PCI: Update CXL DVSEC definitions
Date: Wed, 14 Jan 2026 12:20:23 -0600
Message-ID: <20260114182055.46029-3-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bec615a-7ec0-4931-9d0a-08de5399c07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aSYbe+gwLN5QGo1nnzecFOPttX8gKryluGBeFbMQvvNzyQKJvDCK9mDIyyEt?=
 =?us-ascii?Q?+evN7L4Wn2yny7SxoFi+IduevX2Nre17nXt8YEIKEweYiqhTruHU2/Bf+J5b?=
 =?us-ascii?Q?jcsLqqbfzUPPZ+RJ40Y7mTfOqgD9D0AnVLIcLynGwQSfxWknRQaWc+sH6J5s?=
 =?us-ascii?Q?Wm+0m42T/cZzN32pr6Cbw/CJL/ObL4ptKdZLYY/8/cIZOLM21yVmrilghFCT?=
 =?us-ascii?Q?Uq58qvWE/BFprnvsnnJ77P+UfEpEiHhA21oe3KpUAaEC+140OikKlpsAxNdZ?=
 =?us-ascii?Q?coTzfs4+pQcw3/DomlbXVz3xEY/9+nG+MlU1hZjXhMPl0MQ/rB9vRlKX7+rL?=
 =?us-ascii?Q?hyxxqht0CMeichL7NVEuoNUDKQuRt42IKrTgyGZAel4uOMDHHdTXEfOfW+X9?=
 =?us-ascii?Q?eVOklBBHDZrSiLgJSIpwHofOdclCNyAWBD4l5wK0UCIA8iGFl5v5+BetS2Cg?=
 =?us-ascii?Q?3ECIddQFlxThJgqvNy1mr6zyc+AM3IxPXcSR2gH3FQCFl/5ao3L5rji+//NN?=
 =?us-ascii?Q?uEyZDYkDG4yIHo2Jx8RCP1N8LKi/3htaqi57fTh2cyBWNzLdNeviNQ4+szIR?=
 =?us-ascii?Q?PAM/gVcv6UHNxFmkPmRTbyxoaeyBNdWpvZanVoc7g6KWQXmKAqW1+23wTKIT?=
 =?us-ascii?Q?ASpj2k1eKWkVSZmHMu9y15XvZzcgq5qnc3H7wjCz+X3q3P+/vgo8NYZrqCeQ?=
 =?us-ascii?Q?//OVR4uCgU/Vz4F0iT/YZ2OepbUwGVBVllmiimZF2TvMpPh5A6QwCX9Jaoyi?=
 =?us-ascii?Q?/Yb1AWWWfQ2YxdeWSRIUemYAtxX05V4h8uD52Yhg8mOnENNIQIANDE1nZYB0?=
 =?us-ascii?Q?u93h3tKv7tOoCr95WVd1xzvOjJay70R3mSNxMAsDmcsKUGNJNSWSDT/aEWuf?=
 =?us-ascii?Q?cNrt+uluIAXi7yfSWIcOA5iQDwDo9lylFTr1RuPAZxI8BLc6WhDq9zKWfHIE?=
 =?us-ascii?Q?TJfVL7U033Ib24VL3ql1N6aIdO3t1bkviF7GDAVLOCW/CmA/qJzqVsqhQy2k?=
 =?us-ascii?Q?aX8qn7gTpL6K/pEAcus7V9jU7jBOnN2raSzqlZMR6uqCW+uBhZZcM9sygxzp?=
 =?us-ascii?Q?Yjjq2VAgYUr02Wq3Kbk2Rgj2SPuILs/Pw1pxLAoKcc0x/npd85qOUBY1wIoD?=
 =?us-ascii?Q?lmIql7zcJRgbr1NpWTw2mj6g9QbGAslVu7TK33DyCotMgAbNwR5x7l1N4ix0?=
 =?us-ascii?Q?kxPVMyQXC3x3MyGtNxcsu1IyuzNZj6DE3A5rwejtAFo6Rx5b/tRNUsDNWv4m?=
 =?us-ascii?Q?DWkPUOkexYZXtLqyEbWebqmk2pXcvLTpfRE4t/rRkPk14zEvRPwcodd6h/gH?=
 =?us-ascii?Q?1VOY1a3jzz5Xno4npgLD3SPLI9QntTBgN/fJk4MWEPeAFyz7AUHGnYaDImiP?=
 =?us-ascii?Q?XKtMMBGCM3TejpA7d2Z1zo9wtckYq/RY6V9fDqqgw9QQuP3B8cRyIgpIicZM?=
 =?us-ascii?Q?DyrWOj4i1y2bGVtHJD2cniPh1ploAMvRdaN/2kVPXGll+bR5+hJAFDWMfz/t?=
 =?us-ascii?Q?GYqEz/3N39ytK0pn5VdUZYcFxOM6SvDSaREdXt375DT6TxcCt7XG5886i9AC?=
 =?us-ascii?Q?uqLP5C6flNhjChDHfksCydJd2v2bT0K4sbsIYaiF18m/OYoWRsfnDAhxwvsQ?=
 =?us-ascii?Q?eu05IJlPv/l2ePhCD6KeiHcSsVEmQ/2vIJ5UxVTx+ztPGexrCVRUAVtav0JK?=
 =?us-ascii?Q?QKkCGo28IPs4pbsbb0gEOoRgdHY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:21:35.7004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bec615a-7ec0-4931-9d0a-08de5399c07f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059

CXL DVSEC definitions were recently moved into uapi/pci_regs.h, but the
newly added macros do not follow the file's existing naming conventions.
The current format uses CXL_DVSEC_XYZ, while the new CXL entries must
instead use the PCI_DVSEC_CXL_XYZ prefix to match the conventions already
established in pci_regs.h.

The new CXL DVSEC macros also introduce _MASK and _OFFSET suffixes, which
are not used anywhere else in the file. These suffixes lengthen the
identifiers and reduce readability. Remove _MASK and _OFFSET from the
recently added definitions.

Additionally, remove PCI_DVSEC_HEADER1_LENGTH, as it duplicates the existing
PCI_DVSEC_HEADER1_LEN() macro.

Update all existing references to use the new macro names.

Finally, update the inline documentation to reference the latest revision
of the CXL specification.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v13->v14:
- New patch. Split from previous patch such that there is now a separate
  move patch and a format fix patch.
- Formatting update requested (Bjorn)
- Remove PCI_DVSEC_HEADER1_LENGTH_MASK because it duplicates
  PCI_DVSEC_HEADER1_LEN() (Bjorn)
- Add Dan's review-by
---
 drivers/cxl/core/pci.c        | 58 ++++++++++-----------
 drivers/cxl/core/regs.c       | 14 +++---
 drivers/cxl/pci.c             |  2 +-
 include/uapi/linux/pci_regs.h | 94 ++++++++++++++++-------------------
 4 files changed, 81 insertions(+), 87 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b023a0178a4..077b386e0c8d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -86,12 +86,12 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
 	i = 1;
 	do {
 		rc = pci_read_config_dword(pdev,
-					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
+					   d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
 					   &temp);
 		if (rc)
 			return rc;
 
-		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
+		valid = FIELD_GET(PCI_DVSEC_CXL_MEM_INFO_VALID, temp);
 		if (valid)
 			break;
 		msleep(1000);
@@ -121,11 +121,11 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
 	/* Check MEM ACTIVE bit, up to 60s timeout by default */
 	for (i = media_ready_timeout; i; i--) {
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(id), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id), &temp);
 		if (rc)
 			return rc;
 
-		active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
+		active = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE, temp);
 		if (active)
 			break;
 		msleep(1000);
@@ -154,11 +154,11 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 	u16 cap;
 
 	rc = pci_read_config_word(pdev,
-				  d + CXL_DVSEC_CAP_OFFSET, &cap);
+				  d + PCI_DVSEC_CXL_CAP, &cap);
 	if (rc)
 		return rc;
 
-	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
+	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
 	for (i = 0; i < hdm_count; i++) {
 		rc = cxl_dvsec_mem_range_valid(cxlds, i);
 		if (rc)
@@ -186,16 +186,16 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	u16 ctrl;
 	int rc;
 
-	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
+	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
 	if (rc < 0)
 		return rc;
 
-	if ((ctrl & CXL_DVSEC_MEM_ENABLE) == val)
+	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
 		return 1;
-	ctrl &= ~CXL_DVSEC_MEM_ENABLE;
+	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
 	ctrl |= val;
 
-	rc = pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, ctrl);
+	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
 	if (rc < 0)
 		return rc;
 
@@ -211,7 +211,7 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
 {
 	int rc;
 
-	rc = cxl_set_mem_enable(cxlds, CXL_DVSEC_MEM_ENABLE);
+	rc = cxl_set_mem_enable(cxlds, PCI_DVSEC_CXL_MEM_ENABLE);
 	if (rc < 0)
 		return rc;
 	if (rc > 0)
@@ -273,11 +273,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 		return -ENXIO;
 	}
 
-	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
+	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CAP, &cap);
 	if (rc)
 		return rc;
 
-	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
+	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE)) {
 		dev_dbg(dev, "Not MEM Capable\n");
 		return -ENXIO;
 	}
@@ -288,7 +288,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 	 * driver is for a spec defined class code which must be CXL.mem
 	 * capable, there is no point in continuing to enable CXL.mem.
 	 */
-	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
+	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
 	if (!hdm_count || hdm_count > 2)
 		return -EINVAL;
 
@@ -297,11 +297,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 	 * disabled, and they will remain moot after the HDM Decoder
 	 * capability is enabled.
 	 */
-	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
+	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
 	if (rc)
 		return rc;
 
-	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
+	info->mem_enabled = FIELD_GET(PCI_DVSEC_CXL_MEM_ENABLE, ctrl);
 	if (!info->mem_enabled)
 		return 0;
 
@@ -314,35 +314,35 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			return rc;
 
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i), &temp);
 		if (rc)
 			return rc;
 
 		size = (u64)temp << 32;
 
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(i), &temp);
 		if (rc)
 			return rc;
 
-		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
+		size |= temp & PCI_DVSEC_CXL_MEM_SIZE_LOW;
 		if (!size) {
 			continue;
 		}
 
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i), &temp);
 		if (rc)
 			return rc;
 
 		base = (u64)temp << 32;
 
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_BASE_LOW(i), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_LOW(i), &temp);
 		if (rc)
 			return rc;
 
-		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
+		base |= temp & PCI_DVSEC_CXL_MEM_BASE_LOW;
 
 		info->dvsec_range[ranges++] = (struct range) {
 			.start = base,
@@ -1068,7 +1068,7 @@ u16 cxl_gpf_get_dvsec(struct device *dev)
 		is_port = false;
 
 	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
-			is_port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
+			is_port ? PCI_DVSEC_CXL_PORT_GPF : PCI_DVSEC_CXL_DEVICE_GPF);
 	if (!dvsec)
 		dev_warn(dev, "%s GPF DVSEC not present\n",
 			 is_port ? "Port" : "Device");
@@ -1084,14 +1084,14 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 
 	switch (phase) {
 	case 1:
-		offset = CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET;
-		base = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK;
-		scale = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
+		offset = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL;
+		base = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE;
+		scale = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE;
 		break;
 	case 2:
-		offset = CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET;
-		base = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK;
-		scale = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
+		offset = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL;
+		base = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE;
+		scale = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE;
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 5ca7b0eed568..a010b3214342 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -271,10 +271,10 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, "CXL");
 static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 				struct cxl_register_map *map)
 {
-	u8 reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
-	int bar = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
+	u8 reg_type = FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID, reg_lo);
+	int bar = FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BIR, reg_lo);
 	u64 offset = ((u64)reg_hi << 32) |
-		     (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
+		     (reg_lo & PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW);
 
 	if (offset > pci_resource_len(pdev, bar)) {
 		dev_warn(&pdev->dev,
@@ -311,15 +311,15 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 	};
 
 	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
-					   CXL_DVSEC_REG_LOCATOR);
+					   PCI_DVSEC_CXL_REG_LOCATOR);
 	if (!regloc)
 		return -ENXIO;
 
 	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
-	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
+	regloc_size = PCI_DVSEC_HEADER1_LEN(regloc_size);
 
-	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
-	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
+	regloc += PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1;
+	regblocks = (regloc_size - PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1) / 8;
 
 	for (i = 0; i < regblocks; i++, regloc += 8) {
 		u32 reg_lo, reg_hi;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0be4e508affe..b7f694bda913 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -933,7 +933,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	cxlds->rcd = is_cxl_restricted(pdev);
 	cxlds->serial = pci_get_dsn(pdev);
 	cxlds->cxl_dvsec = pci_find_dvsec_capability(
-		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
+		pdev, PCI_VENDOR_ID_CXL, PCI_DVSEC_CXL_DEVICE);
 	if (!cxlds->cxl_dvsec)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 6c4b6f19b18e..662582bdccf0 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1333,63 +1333,57 @@
 #define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
 #define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
 
-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
-#define PCI_DVSEC_CXL_PORT				3
-#define PCI_DVSEC_CXL_PORT_CTL				0x0c
-#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
-
 /*
- * Compute Express Link (CXL r3.2, sec 8.1)
+ * Compute Express Link (CXL r4.0, sec 8.1)
  *
  * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
- * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
+ * is "disconnected" (CXL r4.0, sec 9.12.3). Re-enumerate these
  * registers on downstream link-up events.
  */
-#define PCI_DVSEC_HEADER1_LENGTH_MASK  __GENMASK(31, 20)
-
-/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
-#define CXL_DVSEC_PCIE_DEVICE				0
-#define  CXL_DVSEC_CAP_OFFSET				0xA
-#define   CXL_DVSEC_MEM_CAPABLE				_BITUL(2)
-#define   CXL_DVSEC_HDM_COUNT_MASK			__GENMASK(5, 4)
-#define  CXL_DVSEC_CTRL_OFFSET				0xC
-#define   CXL_DVSEC_MEM_ENABLE				_BITUL(2)
-#define  CXL_DVSEC_RANGE_SIZE_HIGH(i)			(0x18 + (i * 0x10))
-#define  CXL_DVSEC_RANGE_SIZE_LOW(i)			(0x1C + (i * 0x10))
-#define   CXL_DVSEC_MEM_INFO_VALID			_BITUL(0)
-#define   CXL_DVSEC_MEM_ACTIVE				_BITUL(1)
-#define   CXL_DVSEC_MEM_SIZE_LOW_MASK			__GENMASK(31, 28)
-#define  CXL_DVSEC_RANGE_BASE_HIGH(i)			(0x20 + (i * 0x10))
-#define  CXL_DVSEC_RANGE_BASE_LOW(i)			(0x24 + (i * 0x10))
-#define   CXL_DVSEC_MEM_BASE_LOW_MASK			__GENMASK(31, 28)
+
+/* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
+#define PCI_DVSEC_CXL_DEVICE				0
+#define  PCI_DVSEC_CXL_CAP				0xA
+#define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
+#define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define  PCI_DVSEC_CXL_CTRL				0xC
+#define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
+#define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
+#define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
+#define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
+#define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
+#define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
+#define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))
+#define   PCI_DVSEC_CXL_MEM_BASE_LOW			__GENMASK(31, 28)
 
 #define CXL_DVSEC_RANGE_MAX				2
 
-/* CXL 3.2 8.1.4: Non-CXL Function Map DVSEC */
-#define CXL_DVSEC_FUNCTION_MAP				2
-
-/* CXL 3.2 8.1.5: Extensions DVSEC for Ports */
-#define CXL_DVSEC_PORT					3
-#define   CXL_DVSEC_PORT_CTL				0x0c
-#define    CXL_DVSEC_PORT_CTL_UNMASK_SBR		0x00000001
-
-/* CXL 3.2 8.1.6: GPF DVSEC for CXL Port */
-#define CXL_DVSEC_PORT_GPF				4
-#define  CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET	0x0C
-#define   CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK	__GENMASK(3, 0)
-#define   CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK	__GENMASK(11, 8)
-#define  CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET	0xE
-#define   CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK	__GENMASK(3, 0)
-#define   CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK	__GENMASK(11, 8)
-
-/* CXL 3.2 8.1.7: GPF DVSEC for CXL Device */
-#define CXL_DVSEC_DEVICE_GPF				5
-
-/* CXL 3.2 8.1.9: Register Locator DVSEC */
-#define CXL_DVSEC_REG_LOCATOR				8
-#define  CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET		0xC
-#define   CXL_DVSEC_REG_LOCATOR_BIR_MASK		__GENMASK(2, 0)
-#define   CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK		__GENMASK(15, 8)
-#define   CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK	__GENMASK(31, 16)
+/* CXL r4.0, 8.1.4: Non-CXL Function Map DVSEC */
+#define PCI_DVSEC_CXL_FUNCTION_MAP			2
+
+/* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
+#define PCI_DVSEC_CXL_PORT				3
+#define  PCI_DVSEC_CXL_PORT_CTL				0x0c
+#define   PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
+
+/* CXL r4.0, 8.1.6: GPF DVSEC for CXL Port */
+#define PCI_DVSEC_CXL_PORT_GPF				4
+#define  PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL		0x0C
+#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE	__GENMASK(3, 0)
+#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE	__GENMASK(11, 8)
+#define  PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL		0xE
+#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE	__GENMASK(3, 0)
+#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE	__GENMASK(11, 8)
+
+/* CXL r4.0, 8.1.7: GPF DVSEC for CXL Device */
+#define PCI_DVSEC_CXL_DEVICE_GPF			5
+
+/* CXL r4.0, 8.1.9: Register Locator DVSEC */
+#define PCI_DVSEC_CXL_REG_LOCATOR			8
+#define  PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1		0xC
+#define   PCI_DVSEC_CXL_REG_LOCATOR_BIR			__GENMASK(2, 0)
+#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID		__GENMASK(15, 8)
+#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW	__GENMASK(31, 16)
 
 #endif /* LINUX_PCI_REGS_H */
-- 
2.34.1


