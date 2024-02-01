Return-Path: <linux-pci+bounces-2907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8013845125
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 07:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D641F2AC96
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 06:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED4A6FD8;
	Thu,  1 Feb 2024 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3nWMdCh7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075D79DAF;
	Thu,  1 Feb 2024 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706767494; cv=fail; b=AsnuBPCBiLqvzJKM2MhRegOp/eL2fFz2+LfXlIzATroxRwlFzWYmOoT1sljtnePFJyrj42iXFDZtM89HqcYAz7zyLfqHmo4aHf837ZAqkz5MphyDKrEK3twL5Fl2j61jGUAvX1+iYJeFbTRE/HpBEeGcmHiEEwL8ECCSsloB9vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706767494; c=relaxed/simple;
	bh=vXROf/Qllj1JkDPySf7PMD2+BmNiZXCfXed0rMDwVz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvfZRZTebUM/FGrO9zQoGG70fN82NJGwq6Pg/abkans5hfAAaWUUCWsa9EFc4DwF+ztc6XEK1BTloWpmhImlbngbpT9uwZQ4xdFzN0/3VB1ktdhDBHW68tva8iq8nkFNzG8YtGJJbAYw7/gGJLkjkoSrOCXxSYZT1zIIowIVxwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3nWMdCh7; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn6cX36/MhVkO/LCiFONMYukGmst/+AedDuO9Lym199WqyjLgskJe/p+u0uLwQiLtzmWNFXr3yjvhxD22dPtWZDNOBuo4kAnaJVhMQLC/95T0g0oSS3xDhw1Z2aQyIdS0GRAQH6yJDpzTL13AHn8iupG3mNbKgMKkjByZ+xLF/LmqM6PChXzV9TzKL2RV1E34BQdsR4O4/VbNM9+saCys0No5AR4mbuPTD+qO3J4wWbeZJ+hnoSu8lZzMg1/0CCTAn2Ire/jt0AJsnpqRel3wdmWDyfH+0RZnHm7tdUVY0ve5J/yKyg56o+Lb760k8phnGv3alpl9D+tFjLSDDYn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4DoY0zC2gfPeAGVFFqCvQSjwnNvTyXZNI+w9qC2jA8=;
 b=LPaHRthXbmETR6Ijs8a6btksaql8/DLpX0yLxPH0/8eqQMSCP1FMroXoN9X9ZwvJ1JeKBS1DIH2q/ABqGJ8Xcoc3LKNPuwiewSLMU/MW8p0sR1BKBeKEhRMhDqf/yzLzRFiXG5JUU2C37c483zQFNJ5noDohLO6/qzz+ll6/X6ymvPL0eb8VlKyR6aW5YUhiJ3kRkOHW9kjeku1DLSUugkM2lgCmR/zShGAqqj9+DUO3q5XzmFjXJJCPRVv95VQVse4Es9u7Qp1fpz9xZ4tXemBBRVCRDGIjSUM+ifeztmGs0IckWts+qISzHvTWebFrD/1XSdyy0SYjXmBUXYMNmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4DoY0zC2gfPeAGVFFqCvQSjwnNvTyXZNI+w9qC2jA8=;
 b=3nWMdCh7iQBZzMDWF9F+I4VJnY1ok92ODqPfNMYJvGAPUTG7rggeavCd9Fyvw5HN+T/h1MRNSqW7fEgIhDwefpHyjofPFCNkO7HnUPEQKV55DwI8jMTxxn0nhYBvaTyQlfCkXQ+oC3Et52BFVMRhk+1FSYxyET0aGZZQrWi/aIk=
Received: from DS7PR03CA0224.namprd03.prod.outlook.com (2603:10b6:5:3ba::19)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.9; Thu, 1 Feb
 2024 06:04:50 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::e6) by DS7PR03CA0224.outlook.office365.com
 (2603:10b6:5:3ba::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 06:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 1 Feb 2024 06:04:50 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 00:03:50 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Lukas Wunner
	<lukas@wunner.de>, Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH kernel 2/4] pci/doe: Support discovery version
Date: Thu, 1 Feb 2024 17:02:26 +1100
Message-ID: <20240201060228.3070928-3-aik@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240201060228.3070928-1-aik@amd.com>
References: <20240201060228.3070928-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd4a0d7-3f19-42c4-092d-08dc22ebb362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YjReGr02YiaHXQRuAId7kqFeD6oV6gCJnNUGZWXDH8PgD74WkwbfBQUnFXbxJThpbjfgmvaekbgM6kIBd6MlNaYVxFpwqMTHl+2KZVEdlk9BdgzRa63q3Fz+vdWVdaqWcUm35Wl1KMleDBSqcRxpdYNt0qVDwh31kcV/hAgmZ22TcUBMA8H6aEiRMY8rkb4CAwO4+aUZ8qh+Uek6JO6OyOTvqgRKQXQ4x2HUN/zQe79gqTMvi9k7AFmomDsiGiwVKP0uG16f9OQ4rHYMCujF5v83OVCCITjq6JhEaX+PRMIsHaW6ME7CMCi05VcCkwBqYK3YSb9r3q/8AItq+FuNwlP6WUmz8Kfoh5v/EW8q8Av1DGMK37QMtfxseZZx4c1tgn1ShGqz1VHT7/G0z2y+IZ6GRMyjoEteQfG/ap3zc2Go5eR9qntZIB4gTuKw/hZpQwJ+XKyap7req7DoYXA97M+Fuo5M78c9T4HXLYhH1MV/GlhLAeCswS9Vukxnce9uAukmefIJ3h91QD6JkeCKR1yXXr63phUGR2tVulRsiOuHqlq6h2/6Ivjzw4n+w5clL1pgKL8QsuOmtr5SgRvsIVDaDoF7QZ187nlWWwma7Xvm3mhYy7P92zOXnqRUM/z195UYJOOa1iqolyC2eYVePWEmy6M/cabChH8R7J6S/m6kFiG5sAH6UfzP6ssZuVw8dhLvKvlMQ7E5fClvVgzKo+NJI6JbS3zl+HE4BL5ogMz90m3yzrZUtverHZOreVC9bVPSrZqErg2g8YAYpea91A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(316002)(70206006)(70586007)(478600001)(6916009)(6666004)(4326008)(8676002)(5660300002)(336012)(2906002)(1076003)(16526019)(2616005)(26005)(54906003)(8936002)(83380400001)(47076005)(36860700001)(426003)(36756003)(356005)(40460700003)(81166007)(40480700001)(82740400003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 06:04:50.0879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd4a0d7-3f19-42c4-092d-08dc22ebb362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526

PCIe spec v6.1 defines a "DOE Discovery Version" field in the DOE Discovery
Request Data Object Contents (3rd DW) as:

15:8 DOE Discovery Version – must be 02h if the Capability Version in
the Data Object Exchange Extended Capability is 02h or greater.

Add support for the version on devices with the DOE v2 capability.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 include/uapi/linux/pci_regs.h |  1 +
 drivers/pci/doe.c             | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a39193213ff2..b9c681f14181 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1144,6 +1144,7 @@
 #define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
 
 #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
+#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER	0x0000ff00
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 61f0531d2b1d..f57def002175 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -381,11 +381,13 @@ static void pci_doe_task_complete(struct pci_doe_task *task)
 	complete(task->private);
 }
 
-static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
+static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u16 *vid,
 			     u8 *protocol)
 {
+	u32 disver = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER,
+				(capver >= 2) ? 2 : 0);
 	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
-				    *index);
+				    *index) | disver;
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


