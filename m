Return-Path: <linux-pci+bounces-7771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DA18CCD93
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 10:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C92283102
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 08:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EFC13CF9F;
	Thu, 23 May 2024 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="egzq9hJU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727D13CAA4;
	Thu, 23 May 2024 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451128; cv=fail; b=EIbNEnPttEFT90r3whwEXQ8On5wyr3QojjxuS5eyzoBlK37RXt1Fz3pLIy5+PQkCN11BgqgG7uKA1FPFvy56OOjRtZ17UuT5f85SXWloTie41AfUIVUZxog4k0j6Nr6dh0wSoXBcNArHAe9kpfE/3oBAX6m4l7vVLTrrrhSAnyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451128; c=relaxed/simple;
	bh=8DvQRcXgNZ9vKxuQx3yVU8Z9Lx492kxWSfPkF6fVG/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJ9IggAKFVtPibHy7VZ+eWAojWYuVzQi+fcISfXkihbuDXxlo45R9wOG7yIGXu5xH16PfREaKgqq9o/zq80KDDCvzerAjNJgAs6LZbjMlepHEDEqvSs73kgmDT4TRlL2aLr+LgesTvh/UWdGjZjJqz2GCdBo/6AOD+bdLb7tYjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=egzq9hJU; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcT/6REMN2n+4uQUb04hr/ldtuPuqJ/TOKSVyqFNtWqo9No1z3IqJuJBnitOjJSl2GZbbuqAy/ZBJWjWDxrPkcilovNZKjsRJyr+Q4hRhT8hS7ArGeGm+/IBXZow6uD1q5SbVMJB4uAhK/zzmEUdnx7Sd/Fmb4/0aFkSTBlfgVheMVa15lJd4Q8hEuGz4KrZnx01jIecoPQeF2bgzwpS/HnIgLZqRwIsyS7x+2B1+dO1I5i7FsycV94qdwKuKU8WMQXT1AlRFxoN2NJOnrW4vH421phG4Ljj5Uht6J4IBxHVZ44MaNqpMKm5N21rKSw26dksbho9nFXkx5KMoY255Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37ld/qa0yyFk2uQWcIG0Wym/rJ6+yOYPOgxR8FOOtrE=;
 b=eWaP3u/5vpx81PnBXCzlgw/o6MB9cGxTyUDL9LquxsGAsZc6EMCwItZjWRSMVgx88cExOddLGHdxC46DJCqdjAdNfLynMPCBl8/C+D7iizt5PEE9k7FxNQlT/qXG53P8kgVZZD5aH5Nh89ixmF/OivGuCwBuymi3SgLEZ+mLVOHr8LggA2chF6EE6qI8/QZq8Nn/6t6i/zUqFaHJoq6C0QdBAJQkVmOobkNub3hddhMrjsafQIY2NF5uqh2CW8JHQvoQjqiltN8XBYhEnTQBgGGk9LixWn0vrZtcbMk6mNJqUIFutrWVcn+phC3EBJelh2zvnHDngSF4iRtcDtj/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37ld/qa0yyFk2uQWcIG0Wym/rJ6+yOYPOgxR8FOOtrE=;
 b=egzq9hJUMVXSWfTfFvXFbcKUBl4+O3bYjXFkulYq3i3MtqeISB7zgvAqh2nYIRH4lnXtdygBcuyFz8x9n1DtLfkKPEgC0QV3RdlQeSvpGLTvG9FM9Lb7d0uFeyFDHynLwSXPPtNSQA4hdpfnVz4b5kKi1nefzL/thB4+f0yiSwI=
Received: from DM5PR07CA0050.namprd07.prod.outlook.com (2603:10b6:4:ad::15) by
 PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 07:58:30 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::4d) by DM5PR07CA0050.outlook.office365.com
 (2603:10b6:4:ad::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 07:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 07:58:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 02:58:29 -0500
Received: from sriov-ubuntu2204.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 02:58:27 -0500
From: Lianjie Shi <Lianjie.Shi@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: HaiJun Chang <HaiJun.Chang@amd.com>, Jerry Jiang <Jerry.Jiang@amd.com>,
	Andy Zhang <Andy.Zhang@amd.com>, Lianjie Shi <Lianjie.Shi@amd.com>
Subject: [PATCH 1/1][v2] PCI: Support VF resizable BAR
Date: Thu, 23 May 2024 15:11:14 +0800
Message-ID: <20240523071114.2930804-2-Lianjie.Shi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523071114.2930804-1-Lianjie.Shi@amd.com>
References: <20240523071114.2930804-1-Lianjie.Shi@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Lianjie.Shi@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|PH7PR12MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: c0689b4d-365a-4ab7-c512-08dc7afe22b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9WftnAzCjvwHFy5GYVH0BfW7zCw/c6F5lnAtdajYVrIceYkLzWN3s/mxxXu6?=
 =?us-ascii?Q?0JZ7N2ZeWU6Ocw8t8AhwuiMtabTS/8jzp3yfgZrC9thRFgUEYxODEMw/ukWo?=
 =?us-ascii?Q?enaeOkHNh7xynQOKg19G2U2NWyxCvmKy3BipHAHtKZZ5orF7/6u3JRHlj6i3?=
 =?us-ascii?Q?Llc6D9vxNUxTMEQg70p7R6g1VNwoxGXOT1GFOBGEPNjH85dmkLfKbPrviNMu?=
 =?us-ascii?Q?wX8Hz4pKulfVXBBKbR6xAgX46HYMgClXCBKlhBbq1zYpxAnXroZU1FBQnvw3?=
 =?us-ascii?Q?mZmCBQ3nQ/SV6+EhfqwDL0dkMa25cbueHOILXoesrpsIqknN5UrnK2cRqG1t?=
 =?us-ascii?Q?I4XMl+5iVGvpRJqbtlRByCVSMrQ+C2qiZN32tsGoYKCb1XyjVS/jSfyd2prU?=
 =?us-ascii?Q?RICMPpHW7/pc4RALV7buaA2xP8j5piXtDBFbfoImQ9mzkxWrzbO6yENuozVa?=
 =?us-ascii?Q?spwMFClwiyeKc+khrAoop0PC5xy0r7oynGHdtUqESgwaiFyx7EWBr+2aTz1Y?=
 =?us-ascii?Q?UgLV39los/tOKkBnT3DoXHwTyGw7dIbKnjea6+E1YKQoLLUP56Ps5Lm2Z4G2?=
 =?us-ascii?Q?9fZo0jKD33KFKOqbw/C+BKMwlv0kWOP2xSoK8/Bi+190aTL47VR4xRV1XrHm?=
 =?us-ascii?Q?QbMRNBUekyNRS0Iz+htz/nrZNkI8yTljL8oAVjq1A4Cqkp/kIcfK+kJVxlhl?=
 =?us-ascii?Q?eqqPUhued3K6unx9XHQfv3yS0isCpcT6+Qba0pxESFoj4GEW0HmCKKx+igOU?=
 =?us-ascii?Q?ABru0xSKLYCYpg8tDCLyZp1izCcb+z254xxeNY/6YdxhRqu+uD2M9qHGhWpp?=
 =?us-ascii?Q?ZqcqfXYNWqNyP4m+/VpwgJlOYficVslcAXLEnJPnqVq/QT8jJl+ebNnodnpj?=
 =?us-ascii?Q?AYEfYDjvigm940pU/Dd28FT7C8IziTcJQWhrYCS8MzAJajdfF5IjoevJfBW9?=
 =?us-ascii?Q?T7uJsMVU0kkHM3gZwSKpjL71sEHIx+IjUB/qzFuclY/XbEjsP7cpBuTXwZKM?=
 =?us-ascii?Q?yYTBsuNVbYVooOfNhGm0CNX7jjyExRJxtUY01lrK77+u5AYNBsjkMRkuz98y?=
 =?us-ascii?Q?Es5tP6CAHdvDKulGL+ASkou3PLQjQ713pyWw1kA7akQv7mddJxBam++CTOie?=
 =?us-ascii?Q?qa+WQsRWwP+caMkG7gXgoG1a1IEitkDU8vmIXmUxqIx6ejmTT8zgW7tmmBAu?=
 =?us-ascii?Q?9xbnWLxWJT73xFiBfqncv81dU1Jy968rW/ulfwAb1HhinfQ7dTN2GNoQs30p?=
 =?us-ascii?Q?/AsPQA6l3v3RuRs2/+cDRZ9AQrPLKshEJPyjKkILPBb58cKqAtxMlJ8XSyI+?=
 =?us-ascii?Q?A/UIQ4zpopODEy3JVZ85F6nK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 07:58:30.1646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0689b4d-365a-4ab7-c512-08dc7afe22b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156

Add support for VF resizable BAR PCI extended cap.
Similar to regular BAR, drivers can use pci_resize_resource() to
resize an IOV BAR. For each VF, dev->sriov->barsz of the IOV BAR is
resized, but the total resource size of the IOV resource should not
exceed its original size upon init.

Based on following patch series:
Link: https://lore.kernel.org/lkml/YbqGplTKl5i%2F1%2FkY@rocinante/T/

Signed-off-by: Lianjie Shi <Lianjie.Shi@amd.com>
---
 drivers/pci/pci.c             | 47 ++++++++++++++++++++++++++++++++++-
 drivers/pci/setup-res.c       | 45 +++++++++++++++++++++++++++------
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4..12f86e00a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1867,6 +1867,42 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
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
+		u64 tmp;
+
+		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
+		total = pdev->sriov->total_VFs;
+		if (!total)
+			return;
+
+		res = pdev->resource + bar_idx + PCI_IOV_RESOURCES;
+		tmp = resource_size(res);
+		do_div(tmp, total);
+		size = pci_rebar_bytes_to_size(tmp);
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
@@ -1882,6 +1918,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_ats_state(dev);
 	pci_restore_vc_state(dev);
 	pci_restore_rebar_state(dev);
+	pci_restore_vf_rebar_state(dev);
 	pci_restore_dpc_state(dev);
 	pci_restore_ptm_state(dev);
 
@@ -3677,10 +3714,18 @@ void pci_acs_init(struct pci_dev *dev)
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


