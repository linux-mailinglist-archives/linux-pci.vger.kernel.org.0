Return-Path: <linux-pci+bounces-44798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B68F1D20C7A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F41AE304A109
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D0F2FFF8F;
	Wed, 14 Jan 2026 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BwVM3VGz"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0935335079;
	Wed, 14 Jan 2026 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414946; cv=fail; b=jQx9Vxzr17ExG0NdY60eB+msyqdnyrkP+fyvxa2SZKmC+Jbzr5/BlQrTQo/OryMmJKo04EZrNm5uyHpkucN96OgYjX/Q2ImE1T46L2U8PH442W7iphuhXwyYdBddRzWJfAF8U3uLP6v6z3lg51XGwqgsc4bY3QUj4x2oBi8PBQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414946; c=relaxed/simple;
	bh=YDQKrJBTAW0W1s1Tik6tu5EiiVVWL5m1Hq0/fkdWkQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtZm8wRkvfCSevCNTFtN5PehH7cwh5w3dWzhTj10DwzpnXVx9bgRqkF1cBJicdRK4BKLBeLrpD7PtTdPNYdqEY6lTef5i9dw6l5u9gTL/PkoghQz9o9IYvw9utIyDVRshIA2AEbMybwgL++k4KEAD93F3myP8dnUs4qTHpAA7Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BwVM3VGz; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYyeVJtcg9hka5FsU0U2AAcNdK6U9oEyDKqxrDEAbcZApmueKyDimqm0zhTLtq3lyDvzn9QR5nCi/ZcYkhfkNHJhS+8K7AJ8P+fOdTEj22jgTqjuB78DHxT214esMW3MvgYPfRwe4k8ZLkZzM7SZjHJZox87rp6l+rzaJXfthln1UYvXTxltQDLQVZQXilOkykc9p5gfPshU94BeernIv1X2qbsquGLV4fDUCwqiT66JLk8xphocdn/FwrYgY3ai7BqpBePVi/uc6aR1o5FGoKB4/DI0aEQtcJD5xfhydQV4yixxe8+Wv1rXaDcSkEjK6Hk+WIX+qDX2uXBvzbNqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8W0EFUK81kd2WFXvqYfEpkpJYwX5GF3UdeIjQtjoEc=;
 b=ebtp930alkz3mBNWJ8cPu0Pp28ZaBI7X8MB3+ehg/y8y+YEn9lKSNAU5i1u72JkJ2hJSU5yOtEEOEzPsXurotMwpRMaKmqYo12l91X8QsZNT9irF9Oej6qH9wN/ApkmCz2vggeEIcORzzwGXJGqUQTEeJWtGhwNQk0pJ9/nHhEoHocR+f/XBz4OfnRRnUefqUMRup2mKyXSubYyr7Oa/Qt2HpXUjck/CBKYFaEtI5XbYbFZGzdHXw8XYxdGL4X1lZWVZ3Ma5qubagJ/uMtWP4huOgbOQSbfhlVon/Oxui8zF79W4agETKiSmY5bRXK03DPfU+R/y1SV8F1Hm7SMiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8W0EFUK81kd2WFXvqYfEpkpJYwX5GF3UdeIjQtjoEc=;
 b=BwVM3VGzQylq0t8BcAteFasFv4oPO/TmPf0mL9gYU4REujzEO5rW4WiR/ZBvCRAsPPfu9VWM6mbQHyq058WAhwcqDxWF3w6aZZMYYbHyBoFYCa1lPTuC6lxxhl/y84V7UI7l2O2X2zTJr2niFUhGlIWXY+/gkVtNVUXdWRoNZ9I=
Received: from PH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::11)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.4; Wed, 14 Jan 2026 18:22:19 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::69) by PH5P222CA0010.outlook.office365.com
 (2603:10b6:510:34b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:22:18 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:22:17 -0600
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
Subject: [PATCH v14 06/34] PCI: Replace cxl_error_is_native() with pcie_aer_is_native()
Date: Wed, 14 Jan 2026 12:20:27 -0600
Message-ID: <20260114182055.46029-7-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: cf39c29e-49e0-41ec-75b3-08de5399da46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ziCk9LkVXFT9WAzdVLBwQObmK/qN51t+kyLHEObXWeqrCyzT4m9BhPzvKIse?=
 =?us-ascii?Q?6ADhXIpVdEyyGPSQEg5BnunWJ1bWbrBlqFBwsUCHMA8qxBcHCgkWePdX48IC?=
 =?us-ascii?Q?i6lcA0ZXHSgzXCm17/aDXr9GS6gv4v3Kvg24DdlemruJjlk4n1WwNFkG9xT9?=
 =?us-ascii?Q?LsAGm1nZV6x4nOwLEGAEkOsi4s83fHxasrB5wEDH4YSIgDOefMzhABvp67Ie?=
 =?us-ascii?Q?nT515b69w9uNIveY8CZdPv9+TfWyR+YVeeX8fpmcKsCuk1CmxwVY34JuR4Ac?=
 =?us-ascii?Q?ExH+GLlHK5HvpAUEfhSm92hNOTtayylJNdfqhfKrEWAn39bUOgSm7Q9v7cTv?=
 =?us-ascii?Q?0j8GDQszrHAMjNInK8M63y2gLdj3AdBPz0vfuH1ZYMErJ5kVt+4r2K9LmgCI?=
 =?us-ascii?Q?zhwc/8SpY3jNL0ZeDdezeLW8hN/Y4B+f99iCkwDaDLUEuektQlF/kpQdidmL?=
 =?us-ascii?Q?GUdsDAMEJl4khD2SmxohRjEs+kfgEGw/Scg7eaddDklKDcJT60I6wH9L2FQY?=
 =?us-ascii?Q?KqQIMQvuW0rxm2s9TH58rfYB35+nTTT+fwfT3WVXrEHTalNvuGwMFkJ1D35l?=
 =?us-ascii?Q?BlGO4HuULnsOtVruXSi1oGy6ACqmNtyYHkDJz8P6ma0YHIhFwJbCpDp5orKT?=
 =?us-ascii?Q?PFNfBzUDONlkSWD7wqYvfDx7/VPB78FQqsVcJslhrZasYe8tlZuoJE6j965t?=
 =?us-ascii?Q?bvmjeEj6UOxkD9xNW4LbYdevuAxt2zUKDTuVlB9zq60VsPcE4uhWog5/10t+?=
 =?us-ascii?Q?XWDZQdEb3y6rAFsuImaAw0UegFEi9GxQTPtFAgxZ6Mo9d40dmFgz9qfwtjfn?=
 =?us-ascii?Q?lztXeUQ9xO4HZuSoKPItx0LtvgNgFW0Bdvw2Q9D8JPbpb78Rk/WP/ZVSN1Ki?=
 =?us-ascii?Q?d412TQ5x0gV+YmNpiJYFUKQ/De4n9KUlorAUO2F2N1aVv/TixVzPC6u5byJs?=
 =?us-ascii?Q?TLjtxRURNVZzpIQQOL4d4eCSBYySDBiox5lrpoBNhJCAaMIloc4IS1aLBmrt?=
 =?us-ascii?Q?Skr2Yx3J6Hcriz1qNZ72MRt6sYxZFkkQBYNaQ+FXDPS7ABHVdXsk10dapSA4?=
 =?us-ascii?Q?S1FuGKOShhUEaEH4/sNsJ3yQr+wkUDfs0jCtK+VSyB1k+X9mA68qKPsEHYVL?=
 =?us-ascii?Q?kqcD6IH2uWVy9a52uPhPYvF1elnKSXk/zGY0JsCnJoyaRYMAiGXjHOwuty2G?=
 =?us-ascii?Q?vFR3UN+aoYjJT5GQekB9fT2aG0wXTGtB7kdWp2VkIOkvS0sSB8SmFkpTfwl9?=
 =?us-ascii?Q?MeJWulammgdoYsYyeOsCBAriPseY8v79LczM1xnaXupasu4F5pBFw/DOQ040?=
 =?us-ascii?Q?emEH+tL93WpOLde0DAtc7253cEQxiQC1Cf1JbTJFqNEcRtmk5Ve6e3Zd8TND?=
 =?us-ascii?Q?U4Ysdk5gKYXXJ9XDjnRPcVCW6EGPaZm3s1+0hJ0nQh5Oqt6MtnY1HDybIlMc?=
 =?us-ascii?Q?YDcOD2IKePKvlwmkO8ZRDhN/tgcPGJX498lr0pz57I4SfQuQ+O6faT+GeOz2?=
 =?us-ascii?Q?AzJRcDHoLGIkD5q/YQPSDFDCydHms93T9OhC4zbE+gj9B3vpD0O5/TN7XpyX?=
 =?us-ascii?Q?Af36sX/YzGK9zDvEls6ThEMQHFkqGh5mwFb1OmKxqrjWeCVhUPuI0D2Ewldw?=
 =?us-ascii?Q?PHoDVlt3cKA3qfVL+1wQk8MkJ1jAgL2cg/rjwblqF7MRgBWoSavb/jKrIYXV?=
 =?us-ascii?Q?99jdsYRm4876Hq+o+sXVFGcX0JY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:22:18.9470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf39c29e-49e0-41ec-75b3-08de5399da46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892

The AER driver includes a CXL support function cxl_error_is_native(). This
function adds no additional value from pcie_aer_is_native().

Simplify the codebase by removing cxl_error_is_native() and replace
occurrences of cxl_error_is_native() with pcie_aer_is_native().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v13->v14:
- New commit (Dan)
---
 drivers/pci/pcie/aer.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e0bcaa896803..c99ba2a1159c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1166,13 +1166,6 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
 	return true;
 }
 
-static bool cxl_error_is_native(struct pci_dev *dev)
-{
-	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
-
-	return (pcie_ports_native || host->native_aer);
-}
-
 static bool is_internal_error(struct aer_err_info *info)
 {
 	if (info->severity == AER_CORRECTABLE)
@@ -1186,7 +1179,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	struct aer_err_info *info = (struct aer_err_info *)data;
 	const struct pci_error_handlers *err_handler;
 
-	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
+	if (!is_cxl_mem_dev(dev) || !pcie_aer_is_native(dev))
 		return 0;
 
 	/* Protect dev->driver */
@@ -1227,7 +1220,7 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
 	bool *handles_cxl = data;
 
 	if (!*handles_cxl)
-		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
+		*handles_cxl = is_cxl_mem_dev(dev) && pcie_aer_is_native(dev);
 
 	/* Non-zero terminates iteration */
 	return *handles_cxl;
-- 
2.34.1


