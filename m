Return-Path: <linux-pci+bounces-7563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4688C73E7
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 11:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC26B248A0
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A17144D0B;
	Thu, 16 May 2024 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SaPIrMQM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D0A1448CB;
	Thu, 16 May 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852053; cv=fail; b=K/Qz5nm8bgdyzqZLy1srqmj3g5i0ixaOgmww+2Nb2kQGJKUYKkBVeXTw3xrQz3GAVICaqHjNFO69XoA7L/6DAnT/9IYjUVbOr6wLLrNL3Ie4Tpk89SsIexN63Z/Xke8dmCGYQi0C9dk4BkTFjvCvlLnU2HvrfZGZ2oKrXI7iSL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852053; c=relaxed/simple;
	bh=pjH7lWhaoZTYGCJLu4w4YutR368Fcgi2rLFlDTMQre0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V83VfpuBPfOn38ppVPsuak+99shlfyKt2e1QVgFtqMff/VpnCgLNtsiq84S9qhRVm0bx46aHMVclMBS9YyvFUO1HbbQJA9aFGz1JglPqOdt1tyIx1urvkc5iQTSrJwkeEwuHFBQIkE23lckdm0lM3RC0kcwHHLb+eXuhTtdSag8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SaPIrMQM; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/EoogB7lqyb5eufieMMHUG+TN0P4wcnDGGmDGmNRLJ832bEhLrEduXS/AzkQ76pjOv9OVIC4joQm+mqMwI4820nelgcpdIxTAdqOsiKE1dIZ1pq7FPbDCFO/QvCcwEMRMt8WF/cbbWfBi2eB0sh4L9JM98UXLJSugs/4djOvEVXq1thhrQq89x9o7rFWCIewowTkfbjIpIyiKuqA1B3c8UwsvchqWUnGB1Kq58AplE/GRdeQvayo3rzXZuOZ0jENdakVVhO5FUAAbMJ7HkaVAHn2K1wfPZv987BD6JaM7D9XG0rhZvb4V2f/s2L+iNq0iMKqIUUgz8FPctbuYMCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO8KbzV9Wlyu53SmuLGW5u9WmmJdo64UTJ1CpsyrUy0=;
 b=FSqcbDE/910NBEqSjzIRx8M195uveL2vkdiLq3/Ltc+BbCpJRQxKxLyCDp0JRkLcQI8ivZz5gow9bCrzIGPc7amHQ7ORXO5tmFYRfGV+T7sOPVzVAoqenr67WwerwTyLLEUY6TUtGsSKWkzHvNnkkwOc6/HZQfBQkroov4JQ13ejiBIFtwUeo9FTaoWxcrTQPfrBdBz4cFp7Ql4O477oBN6UuzM0Vt0ybT9H86GfdBoCD/ks7MRDX0CZRYLeIY1m1ZPJ141sSUigfYjoQwjeGC8NsfyYaVMwOzYhc8dvzA+rhTAAOuepWjDLjt3S7Y4c2HHKLEoD7SdyinVDZoy+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nO8KbzV9Wlyu53SmuLGW5u9WmmJdo64UTJ1CpsyrUy0=;
 b=SaPIrMQMhGRiJnzWNI5TKYQjj4z5TjIPy739z9mx/RAfi+00+T4i/I++pJMt+44piVk7j+CGh4lrmRMqVzlv0GDNjqpQ2mCyxR3W2EnwDI6OKjsHXGELzi5qNXbeob7tu22nPU9rm+9Wsip5A98WsbOIvLdR3B9LefM5Kt5o+yc=
Received: from BL0PR1501CA0003.namprd15.prod.outlook.com
 (2603:10b6:207:17::16) by CH3PR12MB8880.namprd12.prod.outlook.com
 (2603:10b6:610:17b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 09:34:07 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::a0) by BL0PR1501CA0003.outlook.office365.com
 (2603:10b6:207:17::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 09:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 09:34:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 04:34:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 04:34:06 -0500
Received: from sriov-ubuntu2204.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 04:34:04 -0500
From: Lianjie Shi <Lianjie.Shi@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: Lianjie Shi <Lianjie.Shi@amd.com>
Subject: [PATCH 1/1] PCI: Support VF resizable BAR
Date: Thu, 16 May 2024 17:33:34 +0800
Message-ID: <20240516093334.2266599-2-Lianjie.Shi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516093334.2266599-1-Lianjie.Shi@amd.com>
References: <20240516093334.2266599-1-Lianjie.Shi@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: a254521c-275d-45e2-7dc7-08dc758b550f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aev7Fyd08S0gsFynG2oF38SzrrNZko9Gcu5Rb9htfyv8euQ2yvmYng/IPdPj?=
 =?us-ascii?Q?cdKpU0n6f0nzxk5QVv7fr8Ty18Z7rgnBGka8I/2tcuhBwN1Yhp6dpCOSW7sJ?=
 =?us-ascii?Q?ULl+vMQXbqs8L1nWUaDHLpq9Tiqrz8VndbjcgnlnfrH6RcdvY5N8gFITe5QU?=
 =?us-ascii?Q?NnvobrMMjCNchMmnpI5dO+T+XULcP6hUdYOPLqr799u+8tPjEDKDm8fyZh8t?=
 =?us-ascii?Q?sZloc23agrqWQIOJwJOXYyX2FDTR41rgVXnPcMmTJEbDpug+cxantkC9GPN1?=
 =?us-ascii?Q?u79j5UCVUGT+EzGEhDN8cjWLTeOJYHK8f9g4aCSeTKy0iE/fPXYErM22RhRp?=
 =?us-ascii?Q?TE22lJCG3YCh/GIhpFv9bcqGDNr7YhzuXGTT2xdr9ldLCPUVe1QINrfEIp1c?=
 =?us-ascii?Q?0t8Jh56x+/edC0S0GNgQMe2uHKmh8eICgFOIqMnuHuosiBmpTCW5KtyJhOOt?=
 =?us-ascii?Q?R/UQDy87TstAt2mwf8cKm3d20jJ365VTYWiqGn//KZqmzTy3f+xLA+BDgIbL?=
 =?us-ascii?Q?ofeNtsV3ZZpdzhFJ78KyMkQAL1729u5k33Nt3aSV6M+bGfwiMSDvLZIh4VHc?=
 =?us-ascii?Q?jH7Xx4bsipp5S6oM7g0OIQYeRz8JJzxloQ3NvUdX3dAg+QdGg1LL70miqm5F?=
 =?us-ascii?Q?HCSq7jbw68oaFxhQOHipfBCCE9N9nPAmz/RWrTvD6Fa61z67lAYLYizsMuyN?=
 =?us-ascii?Q?95MQEF76zJVI/5aBSgIFvQGaCrlhtqJ97HNbwxBrbN42WeiARuiO9un2iwLC?=
 =?us-ascii?Q?vwXDRpGUlSqogddFgZx/E90aj//LbAlnxc3F7bi+Kz8rvUvBRyyzC5DbXtjo?=
 =?us-ascii?Q?sdOsA8urTI7BcOUqTYwY4L7w8QiexW4Se3cs+m3wRsfQG9EW6f91cNE5Jpx/?=
 =?us-ascii?Q?aoGMVY64DSt2P7ZsJma+0U1xI9A12+11BwhG8XQiKORtaC3LpUh4jqB4yHTQ?=
 =?us-ascii?Q?UEeLPPOLpX6zUig/dWbxXQoVza9qxFq2SwJRp7aF8M2kU1TpoaGOSNSYaG5A?=
 =?us-ascii?Q?toSYAJlk6mCLrsN6fxtGQQibhed+/Tv4x2A2zMTSm8IX7pmEcDBmbdsIub/o?=
 =?us-ascii?Q?W1pzTuRy3C/vTMJivtmI2b+HUX1LCsIzu52j3EHz0FzoARwgV70eETvqxx/i?=
 =?us-ascii?Q?cmfL553NsboAEZ9YDPZGy307oKfKZiOt0cyJBEAOYMAENU9bvTCG7OsTZ44N?=
 =?us-ascii?Q?PoOGcAlQKbw3H9MLCvlFhgczDGkgAFuhfTttoh/CLTrx7lm2TEw/XZ4K6qCq?=
 =?us-ascii?Q?74WkpfBN7wXsLXniViGst3tuhqQonC+GPN8zt6YUUBKiw4sIDtIQKmv3bDxN?=
 =?us-ascii?Q?74xiXx9kxIB9AG0sS5AoYNci?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 09:34:06.7281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a254521c-275d-45e2-7dc7-08dc758b550f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880

Add support for VF resizable BAR PCI extended cap.
Similar to regular BAR, drivers can use pci_resize_resource() to
resize an IOV BAR. For each VF, dev->sriov->barsz of the IOV BAR is
resized, but the total resource size of the IOV resource should not
exceed its original size upon init.

Based on following patch series:
Link: https://lore.kernel.org/lkml/YbqGplTKl5i%2F1%2FkY@rocinante/T/

Signed-off-by: Lianjie Shi <Lianjie.Shi@amd.com>
---
 drivers/pci/pci.c             | 44 +++++++++++++++++++++++++++++++++-
 drivers/pci/setup-res.c       | 45 +++++++++++++++++++++++++++++------
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4..bb9a2f322 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1867,6 +1867,39 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 	}
 }
 
+static void pci_restore_vf_rebar_state(struct pci_dev *pdev)
+{
+#ifdef CONFIG_PCI_IOV
+	unsigned int pos, nbars, i;
+	u32 ctrl;
+	u16 total;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_VF_REBAR);
+	if (!pos)
+		return;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
+
+	for (i = 0; i < nbars; i++, pos += 8) {
+		struct resource *res;
+		int bar_idx, size;
+
+		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
+		total = pdev->sriov->total_VFs;
+		if (!total)
+			return;
+
+		res = pdev->resource + bar_idx + PCI_IOV_RESOURCES;
+		size = pci_rebar_bytes_to_size(resource_size(res) / total);
+		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
+		ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
+		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+	}
+#endif
+}
+
 /**
  * pci_restore_state - Restore the saved state of a PCI device
  * @dev: PCI device that we're dealing with
@@ -1882,6 +1915,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_ats_state(dev);
 	pci_restore_vc_state(dev);
 	pci_restore_rebar_state(dev);
+	pci_restore_vf_rebar_state(dev);
 	pci_restore_dpc_state(dev);
 	pci_restore_ptm_state(dev);
 
@@ -3677,10 +3711,18 @@ void pci_acs_init(struct pci_dev *dev)
  */
 static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
 {
+	int cap = PCI_EXT_CAP_ID_REBAR;
 	unsigned int pos, nbars, i;
 	u32 ctrl;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+#ifdef CONFIG_PCI_IOV
+	if (bar >= PCI_IOV_RESOURCES) {
+		cap = PCI_EXT_CAP_ID_VF_REBAR;
+		bar -= PCI_IOV_RESOURCES;
+	}
+#endif
+
+	pos = pci_find_ext_capability(pdev, cap);
 	if (!pos)
 		return -ENOTSUPP;
 
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index c6d933ddf..d978a2ccf 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -427,13 +427,32 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 }
 EXPORT_SYMBOL(pci_release_resource);
 
+static int pci_memory_decoding(struct pci_dev *dev, int resno)
+{
+	u16 cmd;
+
+#ifdef CONFIG_PCI_IOV
+	if (resno >= PCI_IOV_RESOURCES) {
+		pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_CTRL, &cmd);
+		if (cmd & PCI_SRIOV_CTRL_MSE)
+			return -EBUSY;
+		else
+			return 0;
+	}
+#endif
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	if (cmd & PCI_COMMAND_MEMORY)
+		return -EBUSY;
+
+	return 0;
+}
+
 int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 {
 	struct resource *res = dev->resource + resno;
 	struct pci_host_bridge *host;
 	int old, ret;
 	u32 sizes;
-	u16 cmd;
 
 	/* Check if we must preserve the firmware's resource assignment */
 	host = pci_find_host_bridge(dev->bus);
@@ -444,9 +463,9 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	if (!(res->flags & IORESOURCE_UNSET))
 		return -EBUSY;
 
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	if (cmd & PCI_COMMAND_MEMORY)
-		return -EBUSY;
+	ret = pci_memory_decoding(dev, resno);
+	if (ret)
+		return ret;
 
 	sizes = pci_rebar_get_possible_sizes(dev, resno);
 	if (!sizes)
@@ -463,19 +482,31 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	if (ret)
 		return ret;
 
-	res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
+#ifdef CONFIG_PCI_IOV
+	if (resno >= PCI_IOV_RESOURCES)
+		dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = pci_rebar_size_to_bytes(size);
+	else
+#endif
+		res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
 
 	/* Check if the new config works by trying to assign everything. */
 	if (dev->bus->self) {
 		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
-		if (ret)
+		if (ret && ret != -ENOENT)
 			goto error_resize;
 	}
 	return 0;
 
 error_resize:
 	pci_rebar_set_size(dev, resno, old);
-	res->end = res->start + pci_rebar_size_to_bytes(old) - 1;
+
+#ifdef CONFIG_PCI_IOV
+	if (resno >= PCI_IOV_RESOURCES)
+		dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = pci_rebar_size_to_bytes(old);
+	else
+#endif
+		res->end = res->start + pci_rebar_size_to_bytes(old) - 1;
+
 	return ret;
 }
 EXPORT_SYMBOL(pci_resize_resource);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a39193213..a66b90982 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -738,6 +738,7 @@
 #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
 #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
+#define PCI_EXT_CAP_ID_VF_REBAR	0x24	/* VF Resizable BAR */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
-- 
2.34.1


