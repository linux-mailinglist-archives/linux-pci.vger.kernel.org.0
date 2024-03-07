Return-Path: <linux-pci+bounces-4589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F105987460E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 03:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0378BB218D1
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 02:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D1829B0;
	Thu,  7 Mar 2024 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iQzfVNPp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB72F2D;
	Thu,  7 Mar 2024 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709778063; cv=fail; b=T4AO6JM4TjkC3O/f4tMx6JG/N527IWvDeyQjo2KsEIiClvszphpOtBjFyL1KT8oHF4oZROZXHcNWxIN7NxFAlAfZg+5+21uKtXDz7OeujZXgFAf1hk7UjrOy5uLL1Cn6+Z+Y5AztkHrlhnHISrkguOJDMrTPS1j0hG+XJrylq9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709778063; c=relaxed/simple;
	bh=UZAe3RZwsMGfe9Ts+9IUz5Mx8BhiisFGZrg7MJtN7t4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UySJxrewBuZNn4jioOIZoO7UEAffF558cZWSWsZ32BF7qKdD+ji2nbUulmyg3UF2W/VLehu5SQse1nGR7+AssS7GiMyiVohenPHtm4lLakznLaDNLmP4iCpG5VS5oOy+YwYPC17RJrA6HH2dfMWpB5Izl5FZJbpq7w00f0aAgiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iQzfVNPp; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxC2wGA2AmecQ2TyzMHdG0r05ySateAkBPe2QZY6vASW9565XWGANWScwacZ7P+a7ucgtJnOMYmKZWba8bhlOUcmxoHpMCN46Q2xQfsPbi7rZq5836fE7nHo44N9vXGNWRG8SalsctAKhFBEh6NfSzSZe3Cgwr5KE524Idh11DYic0FBdSf43PnwwpN2RxkSOwJOpSXhpzDVCAgzrVWX6hs9W52dBLT78uqTZQNDfFDBWznf7JLi66rD15iAAD6Lhopf0g2x5u42YnfsreWqwAYb3T0Vs0r89Lu4xPgFFpJpsWKojpkSOJLO2dK671YTf9L8DuWNQF1ceZx6Rt8kxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUzK8ySI8pCSiG3NjraU41ibWHGSnF4nYzXJkSAAR2A=;
 b=c+t2ZgglDsYoJpowG6u6qC4Ku25I681CxIxUJZ1XXv1KR9RwxKWLJLl4q6EtH1+kJS/Yd20PkYd3eqZfLWf6eCdf/dCkiTIYv7Gqk2N/Mdr4UTkSZpAoMTBVXWc0S/pvwYXA1nyt9LfRJaCYr2R+eZbQBIjCGAlkmKABQ0jfPEbJSRE8ZPBLjQqCdzc8m0TaiL2OO1PY6k5NSafEq2Yj5YN9pnzeWPJ6aRfBhOVSdNXaEpOcM9FDExZSrRRdhdzStq2Bq6BqGnsVmVWmb53Qf24pAgWsgiofvcf+yzxEy7gSzCEJQJ0YZjUxRTuN+KTjzCECKTYEX14o3UEvtBSVVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUzK8ySI8pCSiG3NjraU41ibWHGSnF4nYzXJkSAAR2A=;
 b=iQzfVNPpsq46Pmqt2Yp3gYbhaeg/+eGDP+n5gDifDbvBfotOzgJDv71l9FS8vutcxmY/H+0bBrUd/VuEMLhgDdVd4ez0vapUro4b8rOVKD1s7l9UqBDFN+KjFYrZMp3e8ma9+yozbbQQ7zYOr/EdNrEhvTNv/u6BEs7fPTZ8SS8=
Received: from BN9PR03CA0767.namprd03.prod.outlook.com (2603:10b6:408:13a::22)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 02:20:58 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::b2) by BN9PR03CA0767.outlook.office365.com
 (2603:10b6:408:13a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Thu, 7 Mar 2024 02:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.0 via Frontend Transport; Thu, 7 Mar 2024 02:20:58 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 20:20:55 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lukas Wunner
	<lukas@wunner.de>, Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH kernel v3] PCI/DOE: Support discovery version 2
Date: Thu, 7 Mar 2024 13:20:06 +1100
Message-ID: <20240307022006.3657433-1-aik@amd.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 5548f249-1c31-405c-7577-08dc3e4d39da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3DTsmqPUCaUoQ82Tdj4xgm20BuF18d15eUeDjO1MllvAQEBCcngUWWCwFLmE41ECN3bsJt5xf/QcoRj3t6/CR+F+g+Y5l3t9BwHy6ei4bypuJGAgmOiSOQ6dAFShvKENAJkA50NgzGxZhs87gKnL/hc9R7U5JQsYSQvH6njPt+y/CzJl/NuPftCzxhy2EA8CnCxZomlOP/bBIQtY3bt7/U+TxLqP7PdUuirq1dw7QbHBRz4sGHUhqF78lu4ilQ5H15kNMOAXl35EE7qo13DYyYAzeUDnukTXzUWuJVZvTsyLrq/DPHP25I50moLB6R7TsBjcVED3jwDudSjB/VBj3qpL5tg7ynxZNGmGigYYqzIrgluqi0Wi4CFhHMu3lfbnsjjrAbbJd80Dx+elD0JGVePrpGnG+D9tNTpfJUrhpKsbO752cAh5i6OiUIyDGxvj1CmFvYutzYpBmPiDmq+3cvJUTVFDHixthO16+EfIrjHu6+6Tyffq6+bdDO4yBAc6U+q6IpyPAl5NW9znDM+jH3z2I/p0JtdSTQo3XJeGqnGnNS6QO+0tfT3B9FDDUl6apGVTMSnInBkGKO3XmHSpj2IZQsyyKndQ9OsVpRfWy3IVjvhF03c2xjMYsOOhoE1a8C4fRQRL4z4QRScT1t9jIDLXlH1Gk1wtQM7J8hkbQUWUjCLEchYF5719S6sJAX5F7L6Uc+WpcD8tptzbck/IILAQZ5DcmEOts0nBf8OeIk8g9UlplHxCQ3VvlneUJHew
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 02:20:58.3477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5548f249-1c31-405c-7577-08dc3e4d39da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621

PCIe r6.1, sec 6.30.1.1 defines a "DOE Discovery Version" field in
the DOE Discovery Request Data Object Contents (3rd DW) as:

15:8 DOE Discovery Version – must be 02h if the Capability Version in
the Data Object Exchange Extended Capability is 02h or greater.

Add support for the version on devices with the DOE v2 capability.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
Changes:
v3:
* updated subject line
* dropped "DISCOVER_" from the new field macro

v2:
* added the section number to the commit log
---
 include/uapi/linux/pci_regs.h |  1 +
 drivers/pci/doe.c             | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a39193213ff2..fbca743b2b86 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1144,6 +1144,7 @@
 #define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
 
 #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
+#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER		0x0000ff00
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 61f0531d2b1d..c94c2b0767f3 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -381,11 +381,13 @@ static void pci_doe_task_complete(struct pci_doe_task *task)
 	complete(task->private);
 }
 
-static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
+static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u16 *vid,
 			     u8 *protocol)
 {
 	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
-				    *index);
+				    *index) |
+			 FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER,
+				    (capver >= 2) ? 2 : 0);
 	__le32 request_pl_le = cpu_to_le32(request_pl);
 	__le32 response_pl_le;
 	u32 response_pl;
@@ -419,13 +421,16 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
 {
 	u8 index = 0;
 	u8 xa_idx = 0;
+	u32 hdr = 0;
+
+	pci_read_config_dword(doe_mb->pdev, doe_mb->cap_offset, &hdr);
 
 	do {
 		int rc;
 		u16 vid;
 		u8 prot;
 
-		rc = pci_doe_discovery(doe_mb, &index, &vid, &prot);
+		rc = pci_doe_discovery(doe_mb, PCI_EXT_CAP_VER(hdr), &index, &vid, &prot);
 		if (rc)
 			return rc;
 
-- 
2.41.0


