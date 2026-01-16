Return-Path: <linux-pci+bounces-45010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1774CD29AC1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 02:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0956C30B1C74
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA5932D7FB;
	Fri, 16 Jan 2026 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sqq6/RCS"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A03242D8;
	Fri, 16 Jan 2026 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527761; cv=fail; b=cfSAgbeCbEGq91TQnrrJrt772dk4LP1aEEwQyanQaTXopakZKyl66I65vIMzsT4jXXzvuYfJ0gNQ5S/bFNRRbXIl4s307884dv7bCs+VmuSw1ozi5/kRzhdZPmQKDSbjHY35gprOPOFTbJUdbDdeYIOU+oz3bSUQAi2ogKJD+QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527761; c=relaxed/simple;
	bh=1qIBbZyubBH/ciUlB4RJNZVxaHD5tx957Cp1hObVuBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izG1Tw96q3NxI18pFCas7dA33GmDaNii1Up2uZ6s3nBiV03Lq7XAsUMSzKujnrbmHWtq8qfDEHLlMeeNrScKljUiVXW0faOOpF0OMQNmVJyKugeO7aGcXB67K5mXz4KQuzbaMiue6KcL5WIxyuMRHrMTurl6zlO/Wdkh/tEfiio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sqq6/RCS; arc=fail smtp.client-ip=52.101.43.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynRvxqlQAg+GU4QZNjV4+ayVwQoxyHv61vaMlb2avjaes49/TRsiuWtkoyU9OuVNSLpp+gWxP2ljKa04BHYzlRGOe3NNYMOacNsQvGW3ql8LAcomqs/gOng2A5y56qJcrw1jJQr1IKrgMcV2/P61DMhf8HhxtQDt357awXdAJWsllTnNXNTGVsoZ2WMK7LGkTRjZaQkwry6VECm0TDoj8VTb71XIQ7/Bf0MQyxJ+Tbclr05l8mbbMzPhzjSPdLKsjcy1r2TaBaX/mJYQtwDKJzmCBVDxynZ1H3g4bQcPllQFo7ClourL44gh3CRUCyavtNtVvSLJNtWM/2C8MIchLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lhe2srLEKZHIVSuMI50VI+UIurkTqycl+rpa8+CDsSE=;
 b=Hpide6nVVEeWPhwigHdRbJhGHl1NyCJznezX669fUYIfRg7qaXjLRIZKiHfCBRLSafeQo47Yz4S1sqPt6I4E0ZkVYz2xMdBQ5QjG3Ut64XejA9K3gn0IINdIpCnT3bksbWBWhXXL4I9oSebMEmAMIwFLysWIauyGtpnV0w+9ichGN3Nrhlln9rUCGT/Ir8tTyJPBWRz2BWsL4c2bdWiGRPEalolGiHOuF7Stqmg/pgEsHZQeAbABnj7zA1FBV/v+d2qR3QTlya+70gRO9uJem8GnrHiLT7vBjq7WVDoDpHLZGxhEcrc/4KJYucIJBl8Gx2c+El0lF/eRW2sCJ/iMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lhe2srLEKZHIVSuMI50VI+UIurkTqycl+rpa8+CDsSE=;
 b=sqq6/RCSpLmjF7t29GPzvCVytkpoG4kG4oGJX+CZtWdcUWTOjHX6OAAlnl4vPf1muKO0Cv9rcHfYgcywuBOxzrmWnjKBpmNmF0gXM+0Mfo3SpyEisZQQ7r2++Ugr+WgVsjslIzjcAQyJlPGlAKdjD7ihxjVBjOdh3mFvIjOSeNC+qdMF9qab36MxtfGvHCz6Do6YRptSdLgiT6E7/2nbRwPpkmltRYBhFGB6MXmOOW7hR8ur8m7STzZOxG5En2C0Ea5JFPm32jhSEe0LgCkWBPjzwVNTHl2wYDuxpE3OI3G2DFOA7Sb75vy5tEGmWaD4hy5GUhkRVjMYJFsudXgqzQ==
Received: from MN2PR01CA0005.prod.exchangelabs.com (2603:10b6:208:10c::18) by
 PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Fri, 16 Jan 2026 01:42:21 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::b9) by MN2PR01CA0005.outlook.office365.com
 (2603:10b6:208:10c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 01:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 01:42:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:42:03 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:42:03 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 15 Jan 2026 17:42:02 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v3 6/10] PCI: wire CXL reset prepare/cleanup
Date: Fri, 16 Jan 2026 01:41:42 +0000
Message-ID: <20260116014146.2149236-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116014146.2149236-1-smadhavan@nvidia.com>
References: <20260116014146.2149236-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de42418-d652-4ef5-5b33-08de54a07d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OlKb1fP8eqOm0/gWZD4V2L/oEJqm8Gz4H2LYmdPAeb1QXzv5O11MUIY9x6TE?=
 =?us-ascii?Q?ajaVq/Pj38qQxycC8oq5a14ynzcwAT9alYrf7nvLcLL6nUOKsXKaCaLacQG/?=
 =?us-ascii?Q?dYklUbXJUz6ZWRWowgHQpmwYlp7deedplDEkbg2uYOB7chRnuApZOKjvjFvp?=
 =?us-ascii?Q?SuClflSBPy0rgTZFHmqg9BdR0Q4ghOm9Bq4DJXfu6yb15Bq4jJyfTlYyIJNx?=
 =?us-ascii?Q?FwMLyZKtM2F66L3JGt92sO+tcawQHJZrJJSoF9EfTNpkmi4zZ/mzCDM2Rw/2?=
 =?us-ascii?Q?/8w1jN8UM0iCMozRrjat+/liGMb/+jDW0nZICDU1o2p7Brd+EjkKniuR/Bb7?=
 =?us-ascii?Q?jKENphNU44LbKdcqAg54voeWKBSLmq/pd/Qj++YDUEAdtG0HnfPicodfokZ7?=
 =?us-ascii?Q?waOBvD2GLwrIZn80bLrADe9B/Dm4SqrV4LDfXLpssCenPqco1bxkJVRepWhw?=
 =?us-ascii?Q?zOmqqf83hGTWh/U464Y0VIlNxWw+ROtlQn3/SWPKWeZag7E/4cQaY1LZJWqt?=
 =?us-ascii?Q?RLyv9duIh3+UAQGjKWSe9uxbg7jogDqOTRb7DKTaNNb/vf2A6WJzhQwpCgR4?=
 =?us-ascii?Q?5ClIgT/QSrkL3X2/r8jenWdrSE9g7WqZ/c/H8UlqY6Aj1eH5+0LqqF8UgjPk?=
 =?us-ascii?Q?hvkDV2vBCffdhEk0Wbt+6t/5J5LUixwQ0yunRnpIauOoQDBeyHMa2jtQ7liX?=
 =?us-ascii?Q?THscn++aTRFjEVL6dkoapijPjFobrsxji692Nn+QNxDXiiN/MlxhEsLOOu7n?=
 =?us-ascii?Q?piv3fxCsfxItqi7/Obf+dSUo2s7C8uwNwblYo1XEY0Kg+pwj5b8Q/EkLXewp?=
 =?us-ascii?Q?XY00kP0oSUia3v9mjtzmAOC4DLZdv1D1/hF+nPRpXIKepeMsjh7tgURCF5Lr?=
 =?us-ascii?Q?2XDtmpuVHdCmYsWn7dgankJmUyzi4z0FAOaoFw/R1dPjZJEB7wZZX2JbEoPy?=
 =?us-ascii?Q?eYDqUx1lRtuDL+Dmlx5NY7rHFYWhUv3dmubD8pbWxVOpjeyw0y1rpdd0S3HW?=
 =?us-ascii?Q?pYzTC1xVSbfgFDqwfNMCTM9vtqq6kMpNnqryc8kkK59ND6vopJ1XI/v9eAjm?=
 =?us-ascii?Q?JPrU1uSlBDhhqpf/TA63J7Ptm+nwypZ0yr1J0JfU0JLZSLVt/dPodj9SAeCR?=
 =?us-ascii?Q?ef5PtKke3KVEh8If5/Ya285FLVYLyac3M7V7iGAPlBHynyVwoSTkl74t4AoT?=
 =?us-ascii?Q?JfMtbx38RZYZ0hOeHK9luEeMqY6a2sqfhKYpZ51kUbdohbrqeqrhS6kAHUWJ?=
 =?us-ascii?Q?I0YOm+mXqu9Hj3It5FZv4daFPTl7CsoKIDeceWk44VpyDvyCXM0x4HdO8wtv?=
 =?us-ascii?Q?RElKvhMvhkgb0wGKFVFll0gDyQawEdHhlUNqIUAs3O/cemv2kfwyRukTIQHY?=
 =?us-ascii?Q?fH6/HFsnxBbxyuS+UFTfiTvT4BpN/fOT/TgjSKYN1CpoNwOFchUlkKgnMT8t?=
 =?us-ascii?Q?7DCXrkrC7rIYUdEIW+wBtrSnbZlh8HZtTX2G5VQwDOdr/Mh+O1BNDLheCtjY?=
 =?us-ascii?Q?7Z0oEN6XTasgULyluKPNwYePOaSpa3TlnwgyH8kP1zLGPuQT2vEq+lyJFq90?=
 =?us-ascii?Q?bbhRnfy79qZD/KVe8PmaFRNiBjPLUek2uP65kEUnp8r5YXBIlw5oxsjH9WV0?=
 =?us-ascii?Q?dbYCchmIWKaNMlhfI90eJd2VV17IWiC4A1anubUSCHfi0u2fTls/1nMXeWhu?=
 =?us-ascii?Q?+Zc7rUs6gXbjHHJrmMJg9H3lOu8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:42:20.9350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de42418-d652-4ef5-5b33-08de54a07d8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

From: Srirangan Madhavan <smadhavan@nvidia.com>

Wire CXL reset preparation and cleanup into the PCI CXL reset path.
The flow now validates/offlines regions, performs teardown and cache
flushes, then releases the lock on completion or error. This keeps the
common reset_prepare flow intact while adding cxl_reset-specific quiesce logic.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c   | 19 ++++++++++++++++++-
 include/linux/pci.h |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b3eb82b21c35..83fd7e75a12e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4985,10 +4985,27 @@ static int cxl_reset(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;

+	/*
+	 * CXL-reset-specific preparation: validate memory offline,
+	 * tear down regions, flush device caches.
+	 */
+	rc = cxl_reset_prepare_device(dev);
+	if (rc)
+		return rc;
+
 	if (!pci_wait_for_pending_transaction(dev))
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");

-	return cxl_reset_init(dev, dvsec);
+	rc = cxl_reset_init(dev, dvsec);
+	if (rc)
+		goto out_cleanup;
+
+	cxl_reset_cleanup_device(dev);
+	return 0;
+
+out_cleanup:
+	cxl_reset_cleanup_device(dev);
+	return rc;
 }

 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 056eff0b1e86..d29f0bfc84b5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1465,6 +1465,8 @@ int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
 bool cxl_is_type2_device(struct pci_dev *dev);
+int cxl_reset_prepare_device(struct pci_dev *pdev);
+void cxl_reset_cleanup_device(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
 struct pci_dev *pci_real_dma_dev(struct pci_dev *dev);
 int pci_status_get_and_clear_errors(struct pci_dev *pdev);
--
2.34.1


