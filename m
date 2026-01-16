Return-Path: <linux-pci+bounces-45007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 487D2D29AA5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 02:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F5D73082A3F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BA7335573;
	Fri, 16 Jan 2026 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dMPmDA5D"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867FD334C25;
	Fri, 16 Jan 2026 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527749; cv=fail; b=XKrJ80dyqtlDY9kZU4NQAmR44kpRaIe5yQBbzs51uSbgNJ4CAPd8Xeoh/4npoY3a1DOxxNuJblzuEFivJva1ZLU8VEXynxLxo9zAduLsOAGhcLS1mxk71qIo1pLganiomt0pPAfAOLAcDrJg8Y6pdfz9TReYbipQV9HGLRnJnP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527749; c=relaxed/simple;
	bh=viKUNSaAY9scdJD1mGMNfT1eeuRg2jQwh7pS9zxBjVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baMlc//qD4+/NR+0APJWImc9Qdrr/HQ2gn9CnK3sn2w5Fbd5iNth1ML71Z1CypRenGNLhO3rf9aHsJAPPY0MpPWFROAyQURfJWDBkUg1NjcnOHfNnQ7G0Jb5/bGMvA7018QWtJIaa+tGHk/DTUvMkS5/nr4V+VkOXRSEYgc3T5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dMPmDA5D; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1oP1q+dB/2NAxkqCTeYP1OlWYmEgPNAeWrrkg6O31uQI+f9p/4wMnzC7wGUBGAIOOrLr4yX97UiV1ooAULx35sW+ToSvdA4QaZ1KWLvst0eijeRhhfwQBSPke24gYaxzOs8UcuRCdkf7NPjmAIhqAIKM0Uur39wla4Lk1vhGMs6Uc1pCUO7yeULpnwJ+diwPFh4SV6lakP5GF75u9jOBPHKiP4lmogoOPebzWeOIVS1fOg5EbnqiwiKcnOh0IyR9ADixf66dEjiE51NZcSLmCgxMpVpVWzAmfjStKJGl1rRH1mmxGmbXHIVyL68xFEZ0I+x/t6pQ0RD+F2g+ScPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICM4gYCpM/ewENDLTQ55v22JnPiIt79t9deyMPEpNts=;
 b=DL7o6rua4/uF+WLID4aIthOQ4rXkLqbhDn4ylUG1K+NUzextMMrk/M8Ae9sge1yFuJEHhozVNAkmr9Abtz+l+kbEKzUcr6IHTY3Y30AHzYwnpOeyKel+XH7xdk+2dnS2Ud2j6GCSYzpy/X0E/e6jfIHL09yLUmRiPZsE/6ghDSxlbe05frq1ewSy5zvRga1h/lbImpK6J/jrygOa2QB0yMS/3uZi0SmWxJSqDCjhjKY20MygO7S/K4s+VxR2lEojOgeVHZXEIKpA0h0k3f47SmWOzcn3sHiiv0+DX03XCOslaaUtiyNNlISkxZ9gmac2eR2scgB6542G2wraNcrHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICM4gYCpM/ewENDLTQ55v22JnPiIt79t9deyMPEpNts=;
 b=dMPmDA5DN3nSDwCOAn7Aw8hGvpRcOQSpsLfGJDcigqlBH2TqUHCx4cRsrSpHvqOwVz5pPDYUCtCtLt4ejoM5t9R+ezsvFt/i0OeaI2S8j6+9r1LQ4+yt6yRtvL8w8z7PcImQkPvtlEP49eOoiyStKS32RAqaR1IMcuh8J+8NZ5cGDIAPxslDNHnkl5kWPTJlDdaAgUiTm7evswD8pa/akk/1ltxHjXwP5E+PCcLAi4mrG+t4n3hY58PyQPXhO9QFp3GQ2mhO0cy83MRQEOYKcGsScEQ3zbpkFR1NA5sepW4EHCDfjYx87tvEalm54QzVlaOzjvY7iyuOHWDZViBfkA==
Received: from BLAPR03CA0158.namprd03.prod.outlook.com (2603:10b6:208:32f::24)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 01:42:14 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::d5) by BLAPR03CA0158.outlook.office365.com
 (2603:10b6:208:32f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 01:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 01:42:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:42:01 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:42:01 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 15 Jan 2026 17:42:00 -0800
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
Subject: [PATCH v3 5/10] cxl: add reset prepare and region teardown
Date: Fri, 16 Jan 2026 01:41:41 +0000
Message-ID: <20260116014146.2149236-6-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4680b7-8b5f-4c32-1cb4-08de54a0796a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C3D/y1tv2m+xr/1e+MnpchlZiJqDjaBCNppWIGu54DIc39TGG6j2JZ00gMTc?=
 =?us-ascii?Q?aLV2ozWwu8bffloF9wa8Q52zEOcaE3fyjn/jzBZd33gkWQPH1mGcoXb6LOrv?=
 =?us-ascii?Q?XX5mHCk5IIr4kgTdrqnu+iytUOgm/X0JjLcfGWnEeU2yyVDGagUT3x0pd/+o?=
 =?us-ascii?Q?gkkmZ/hBW5v/tK8SqViQ8WGsbkES8ldSPy3UhOHvvw7MSiHu+lI4Zz1EsuTf?=
 =?us-ascii?Q?CE2zGZQdrOiVjSBH9c1pAZfGPBT37RWVJfRm6d4xK8a5K70sWPMc21E48QEg?=
 =?us-ascii?Q?haYPvPmahMPYFC8ZnMQpGq8Xz1iAl1IgKfart11duacOAObapHecS3bw/pCZ?=
 =?us-ascii?Q?ndnrxtDSqk48d5ftkZKb0WDkVtXe5V+5MWod8KFZs1rIKwp37B+33/Kxburw?=
 =?us-ascii?Q?hDNi0UyXrCu9nDUmHpATm9aAsbIiinxYsw6yFopagSMTfL2q2/Jv7dMC6MIT?=
 =?us-ascii?Q?JzWdM8B5jfLPnKGkiku3fyQ7xYBiIao208psu0dU4xsxooRtaZvAmgthxIwq?=
 =?us-ascii?Q?9+Y1vU1S6h+fiLqSxWY8MPbS7N0z7EpSpNNCNuhRje9lkJ+LIRO4of76Tja4?=
 =?us-ascii?Q?G6l27AGMiYdClVEB51CFjdY8TY9JMxzQE9ZKnGmxTvB1WwFLsyvcmkR0grNP?=
 =?us-ascii?Q?0ojODhpYr4wNGg8b9PePXNl905jQvFBDR8gWEbNrygjyAekge0uCHMFfH2XM?=
 =?us-ascii?Q?hiTYlU8GK4h2JUALSmEXAocVu/wC5TyH85c3L+AeC3I0cA8TOzAg83q9SoFU?=
 =?us-ascii?Q?+Ics272jK76nogb9hYHtruYjlZWogTpKv4QRdsALdVoxIMnGhal7zZhyLsGh?=
 =?us-ascii?Q?+9j9QYkH6iRVumncRXRLPUEvwqp/BdqFFpBDMFZCzKqBbWvxUgh/RS9bD+5s?=
 =?us-ascii?Q?+Gb4PiYcrAe82mum5qKOUJgnPBujS0+dL4dWqSaZ3SB97OJkpuNFe7RsLYc7?=
 =?us-ascii?Q?zlrDD1ydX/wNJPA2USSkRXK3iUI31M22vmKJ+B3tFReSCEeq2e0R99H98V9F?=
 =?us-ascii?Q?3bF2ZsEFBqc81UVp4fu8xvOoMfyHjvmq9W06aOD2C2ws54ouzKJONzHEM1YO?=
 =?us-ascii?Q?Mwry4sBd1Rrc3BQ1VQ9diy6bdU7Dl7UBJRmWVZWTujbx30QY8c5Wws8+7q5u?=
 =?us-ascii?Q?Xv8UVAwkIbY0vO/nNPY8JHQW/Zzde4y0ugCsqig5kqw2oYrpl9ob7/04yTNM?=
 =?us-ascii?Q?bc7TvLBBWqEnlQ72AEE+HPmzVJbVFhX3hbFHfLotDGtnHzPCygwk3C22qu1H?=
 =?us-ascii?Q?zKRoue5g/rFtPaXWG41tphY/w/KtLl5SJrIkqm49XF3zvZzbwkXPFazZxpW0?=
 =?us-ascii?Q?m5ED+9qVJJXyD14LSTY0iW36QjugIT5iS4Cmo9TpGOSbRRJlH732o+QvTke6?=
 =?us-ascii?Q?L3tdu7SIdE2fsC4f8wZ9ZJPnB7xGoFka6eqng0I72i5g1UdGE+MbfFbe31Up?=
 =?us-ascii?Q?5MTEidILbLsGOLIVFlAcubh6ps4yJYNtRuHGCtMMhjo24+dTadLdn2lJsyeZ?=
 =?us-ascii?Q?AR9TCIRQeOCHKE0Ab6zXFiFiM16dCpU4hvWWdQhecPKm7tdEP+KalaQApyTL?=
 =?us-ascii?Q?L6kVOgXewyT7B+QzCyl4DpukR+eqYwkcNehMX+ypdgrLbuqdSr14Fksu0bCH?=
 =?us-ascii?Q?fHtgOisJ96NF18yMfdP+jeyB/fYsc73Qp8V0RX3Z7By8Cy2kMv4kL0DztrRc?=
 =?us-ascii?Q?8dVf4Z1YuSxKilMVlP0rC1SXti8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:42:13.9731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4680b7-8b5f-4c32-1cb4-08de54a0796a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003

From: Srirangan Madhavan <smadhavan@nvidia.com>

Prepare a Type 2 device for cxl_reset by validating memory is offline,
flushing device caches for region participants, and tearing down decoders
under cxl_region_rwsem. The lock stays held across reset to prevent new
region creation while reset is in progress.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/pci.c | 214 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6fedeaea6185..8da69c2125af 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1092,6 +1092,220 @@ bool cxl_is_type2_device(struct pci_dev *pdev)
 	return cxlds->type == CXL_DEVTYPE_DEVMEM;
 }

+static int cxl_check_region_driver_bound(struct device *dev, void *data)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	guard(rwsem_read)(&cxl_region_rwsem);
+	if (cxld->region && cxld->region->driver)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int cxl_decoder_kill_region_iter(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	int rc;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	if (!cxled->cxld.region)
+		return 0;
+
+	cxl_decoder_kill_region_locked(cxled);
+
+	rc = device_for_each_child(&cxled->cxld.dev, NULL,
+				   cxl_check_region_driver_bound);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int cxl_device_cache_wb_invalidate(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	u16 reg, val, cap;
+	int dvsec, rc;
+
+	if (!cxlds)
+		return -ENODEV;
+
+	dvsec = cxlds->cxl_dvsec;
+	if (!dvsec)
+		return -ENODEV;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP_OFFSET, &cap);
+	if (rc)
+		return rc;
+
+	if (!(cap & CXL_DVSEC_CACHE_WBI_CAPABLE))
+		return 1;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &val);
+	if (rc)
+		return rc;
+
+	val |= CXL_DVSEC_INIT_CACHE_WBI;
+	rc = pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, val);
+	if (rc)
+		return rc;
+
+	do {
+		rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_STATUS2_OFFSET, &reg);
+		if (rc)
+			return rc;
+	} while (!(reg & CXL_DVSEC_CACHE_INVALID));
+
+	return 0;
+}
+
+static int cxl_region_flush_device_caches(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	struct cxl_region *cxlr = cxled->cxld.region;
+	struct cxl_region_params *p = &cxlr->params;
+	struct pci_dev *target_pdev = data;
+	int i, rc;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	if (!cxlr || !cxlr->params.res)
+		return 0;
+
+	for (i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *target_cxled = p->targets[i];
+		struct cxl_memdev *target_cxlmd = cxled_to_memdev(target_cxled);
+		struct cxl_dev_state *target_cxlds = target_cxlmd->cxlds;
+
+		if (!target_cxlds || !target_cxlds->pdev)
+			continue;
+
+		if (target_cxlds->pdev != target_pdev)
+			continue;
+
+		rc = cxl_device_cache_wb_invalidate(target_pdev);
+		if (rc && rc != 1)
+			return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_reset_prepare_memdev - Prepare CXL device for reset
+ * @pdev: PCI device
+ *
+ * Validates it's safe to reset and tears down regions atomically under lock.
+ * Acquires cxl_region_rwsem and keeps it held throughout reset.
+ *
+ * Return: 0 on success (lock held), -EBUSY if memory online, negative on error
+ */
+static int cxl_reset_prepare_memdev(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd;
+	struct cxl_port *endpoint;
+	int rc;
+
+	if (!cxlds)
+		return -ENODEV;
+
+	cxlmd = cxlds->cxlmd;
+	if (!cxlmd)
+		return -ENODEV;
+
+	endpoint = cxlmd->endpoint;
+	if (!endpoint)
+		return 0;
+
+	if (cxl_num_decoders_committed(endpoint) == 0)
+		return 0;
+
+	down_write(&cxl_region_rwsem);
+
+	/* Check and error out if memory is online */
+	rc = device_for_each_child(&endpoint->dev, NULL,
+				   cxl_check_region_driver_bound);
+	if (rc) {
+		up_write(&cxl_region_rwsem);
+		dev_err(&pdev->dev,
+			"Reset blocked: device has active regions with drivers bound\n");
+		return -EBUSY;
+	}
+
+	/* Flush device caches and tear down regions */
+	device_for_each_child(&endpoint->dev, pdev,
+			      cxl_region_flush_device_caches);
+
+	rc = device_for_each_child(&endpoint->dev, NULL,
+				   cxl_decoder_kill_region_iter);
+	if (rc) {
+		up_write(&cxl_region_rwsem);
+		dev_err(&pdev->dev, "Failed to tear down regions: %d\n", rc);
+		return rc;
+	}
+
+	/* Keep cxl_region_rwsem held, released by cleanup function */
+	return 0;
+}
+
+/**
+ * cxl_reset_cleanup_memdev - Release locks after CXL reset
+ * @pdev: PCI device
+ */
+static void cxl_reset_cleanup_memdev(struct pci_dev *pdev)
+{
+	if (lockdep_is_held_type(&cxl_region_rwsem, -1))
+		up_write(&cxl_region_rwsem);
+}
+
+/**
+ * cxl_reset_prepare_device - Prepare CXL device for reset
+ * @pdev: PCI device being reset
+ *
+ * CXL-reset-specific preparation. Validates memory is offline, flushes
+ * device caches, and tears down regions.
+ *
+ * Returns: 0 on success, -EBUSY if memory online, negative on error
+ */
+int cxl_reset_prepare_device(struct pci_dev *pdev)
+{
+	int rc;
+
+	rc = cxl_reset_prepare_memdev(pdev);
+	if (rc) {
+		if (rc == -EBUSY)
+			dev_err(&pdev->dev,
+				"Cannot reset: device has online memory or active regions\n");
+		else
+			dev_err(&pdev->dev,
+				"Failed to prepare device for reset: %d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_reset_prepare_device, "CXL");
+
+/**
+ * cxl_reset_cleanup_device - Cleanup after CXL reset
+ * @pdev: PCI device that was reset
+ *
+ * Releases region locks held during reset.
+ */
+void cxl_reset_cleanup_device(struct pci_dev *pdev)
+{
+	cxl_reset_cleanup_memdev(pdev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_reset_cleanup_device, "CXL");
+
 static void cxl_error_resume(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
--
2.34.1


