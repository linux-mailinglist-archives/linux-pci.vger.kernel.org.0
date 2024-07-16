Return-Path: <linux-pci+bounces-10395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01372933210
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F79B22795
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9134E1A08DD;
	Tue, 16 Jul 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DQ0Vd+wA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1E81A072C;
	Tue, 16 Jul 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158458; cv=fail; b=OySajUf19S5YYq/JiiGbF9VqRSgQYBTH2oDwWHRHA3h+Ct39sPPg5wIYQPsQrTA5Fz6H35avwJNkTunUFMv+opDFIv9nRQu9u/04AbIuUsno/LZs+1bH7W5zt0x3fQ8QRA2HMaIiMI7W5PY1GAB0TUMrxhQEe2JlfdsVj1LFaYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158458; c=relaxed/simple;
	bh=vnwBRNu51G4ZH9fQPGBsCKxVaJEG4DR3nZUJcUMYD5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Drfs13tcj0onFbaXDSEfWnw4zxFVGO6EQtxr0F+71iL0WhhMNfRXJ8I5MiWKiui4qo/KOfNa7hqRHSp6M8gdRNUOnRPqinEZcVjYehVmlIVNqWbwY/pL1UtBCt1cuutKzeYeOcA0zmdgYmiad/lci/TSIxFJ1vIC4+eWN9fUaBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DQ0Vd+wA; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QblhzM4nEive1jNQhqf+yPXrxkHHL5CQpElcmP1zLUmMchASRjs/rk8CN/y36XA4AtZ4sGs2XWF0bSKrJx4nKuOK+f8HY1t+I1PwdHOoBq3qq/EkFkwM3S9yCjPO9rn1NZu6lSET5Dkjnxmb6ftUXa+clljQTkOqMO6gfygs/qfZ7A22Q2KkY91cJS/4zgvn5mfBnmYVQwlB4/0MRj1p6aPxBI6N1roXlgc5b6ferfA3bV9h/0jKFUSDTLMZa0QdQelAz70Mq5r8sB93+a0C/0apHlgvYfSUV/5B6MezdmBU2c0XUhLt7O7CL1BJX+9612SyBou3Ica32DZPjuzf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny4IGFDg/oYclmZPql5mbl9efU5aukGNFw244Tc7Ej0=;
 b=O37TZfWSo2NKxDGqNGJGOv3zQp1WQXxv+q56g3pAGACtTbPAZDmJmheCGYVr+O26ry6/oM2rC/YL5RcmAWqA/FdthuMVE2j6IIx3WX0F//ZkeaRrq14cu6YTeUh1/e1ZPmJQOs0i6XBLT9DO+Bw75PlEwtoYu7zD/bNv3euyviFj98NqUSJNCE4JswuosuDFXLc5Q6hbzGFGqsFChmX3vuTCSbZOsHVlRqRkFZM98fqNbce1BEtwUK9x5JCOdnL+SSK4Qt/dDfZWWz6t+PjJaJ9iiH0Zr6JCrs1WUAYBPIsn5IeZulXJe4+SksjJ02YKYdd/C+Wht9nXmkoKchygvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny4IGFDg/oYclmZPql5mbl9efU5aukGNFw244Tc7Ej0=;
 b=DQ0Vd+wAN883GidQ+y46+bIv/GMjnO9s5P5Q4VYOnel9ITN7VXdRNIFwubQ/jhv2Aryy+HuZVggC1xhWV2ck/5747Fh855svoPvpRrrRZf/VN1kItum40McITSBPazjj0g8Dk//jxCj10SXGqUcpd4Exmrft697MUR5Q03M5t1U=
Received: from BLAPR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:36e::10)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 19:34:14 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::83) by BLAPR05CA0003.outlook.office365.com
 (2603:10b6:208:36e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15 via Frontend
 Transport; Tue, 16 Jul 2024 19:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 19:34:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 14:34:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 14:34:13 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Jul 2024 14:34:12 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/8] PCI: Restore resource alignment
Date: Tue, 16 Jul 2024 15:32:33 -0400
Message-ID: <20240716193246.1909697-4-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716193246.1909697-1-stewart.hildebrand@amd.com>
References: <20240716193246.1909697-1-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 6629c9e6-e5a5-4d14-b53f-08dca5ce4647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hosNwZlmrtObrwucpjQ9S+Hq4NkmZpeERe30cHiWVLkK1MfmbskKhJW2Zy6Q?=
 =?us-ascii?Q?KUeNrxhs0beIJfCwlJ7fx9CnCorsPam3TIXW6XgxZ8M23VZjjmW+o1xz9eNK?=
 =?us-ascii?Q?KlSS9pJJ6dd2FPtzx2JpAwsCUgJS1ML9OtRp5D4q7ltA0WA3lAQZOY/gp3OH?=
 =?us-ascii?Q?ywD2U8SogY2oa4qVXWi/r3o/CHQqAUqKND0og/lTcwRpDiDzT1Ogx1grkZY8?=
 =?us-ascii?Q?SugDXozz8llt9kXHGEMTU+8InSGEIkKf4kGMw9aOVzBbAlgSe1E9r2F2ZiBB?=
 =?us-ascii?Q?6NJ+4SypQekSgvYFyxKxhBHJo+iQYp78MYMzJdfp1+V9Py2plzy8JwdwPKNA?=
 =?us-ascii?Q?RMlJm4329esGuc7jFmZSqYUDYr29T8O9AYXZj0lolY/vyGqeAgrgNDCn2og5?=
 =?us-ascii?Q?8I3BCZK8Yr+kLOvufwT7TBbiQS5C5JogprHPJ//gHLcQqrRX40ainLVcN9iD?=
 =?us-ascii?Q?JZ1K4qT+jzXpEWUYzKuH1L8lY/9QbuABiO7AHMpuheq0tQSfTM1K99sRvswf?=
 =?us-ascii?Q?oNg+cBjPmdpiZ+vuu9L2QHuslSJ9+SYRAdKK/E/yQWU8SesQmGo6uqRxkf8Q?=
 =?us-ascii?Q?7QpS/8GBACIFI9xszP7VB5fmxvZt3i5SWwiIWYbXLJoZCl8J+4ubvtZFkF3C?=
 =?us-ascii?Q?ujlqYiZ8lIhHFalboMHbzhvcX1EeWaM2Clfd02/JZ4sA3ljilhqp4iob/sDz?=
 =?us-ascii?Q?caM/g3mQoyiLNFUUNucENDWraU3uxaADI2cb1iiDPcSsiV7zNc60LwGZhwsI?=
 =?us-ascii?Q?BpXCkU1+ukPxERHbafwEtIkzlJXOIzvn4b+DOTKkG5XbJ965jAvpAWdnt2T5?=
 =?us-ascii?Q?I4QP7Foigeblc9+bbPgGIkKrcCLso1EgxJSYYTQDokIcsA6bweeK8XOTUkOf?=
 =?us-ascii?Q?QDfSRISs1CawQoQiLTk7OmcHiSCdeN1w+EH27hqADHHmO1dr196ZgDWkEC2Q?=
 =?us-ascii?Q?VOw5IK3qak7yrPo0wiw2bG4g4E0Ru2trY+wR2W5cnkvU3biEQdNhT6q2WZgK?=
 =?us-ascii?Q?dnITlGzfApjxblFw/4NqslMbdiM8CHflEc7+sPjwbOb5Sz6sQ/CxHKcct5MM?=
 =?us-ascii?Q?p2GadGK75TXdbvVbUnjq3Q+AT2GyBmErXL2B/C8lRHD/08rdL7MEEBDMBpJN?=
 =?us-ascii?Q?zuF13faIFPAJy2zhuyRAfaiZeNpl2CTC6YYe2RFMPwZ2XORaTbJThPMTFslV?=
 =?us-ascii?Q?vjgNgWzC5UJriWtz6kkx8/OE7FFwGm0oPYj37YtYIgPnuOvgMR46pwDaps6o?=
 =?us-ascii?Q?7SwcSqDHhLEknk2zfjsE46l9u0tT4sF/5K1xa4/f5000DZ2Lc07v8wP5DA+3?=
 =?us-ascii?Q?nEt8rCXivF/pE+UD1tSw9OUmK3YTz/eD6H8SroayZO0z88U+HR0GKdixuP1C?=
 =?us-ascii?Q?lj3LWcBd0Mgnps5bX264bZcZubaYge8jAKVOFebh8toYlUAVH6d8XYIrT+Fg?=
 =?us-ascii?Q?ClNLJ4T/Xo3eiueXNv41cIGXDOkuQRKw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:34:13.9624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6629c9e6-e5a5-4d14-b53f-08dca5ce4647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655

Devices with alignment specified will lose their alignment in cases when
the bridge resources have been released, e.g. due to insufficient bridge
window size. Restore the alignment.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
v1->v2:
* capitalize subject text
---
 drivers/pci/setup-bus.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 23082bc0ca37..ab7510ce6917 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1594,6 +1594,23 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 	}
 }
 
+static void restore_child_resource_alignment(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *b;
+
+		pci_reassigndev_resource_alignment(dev);
+
+		b = dev->subordinate;
+		if (!b)
+			continue;
+
+		restore_child_resource_alignment(b);
+	}
+}
+
 #define PCI_RES_TYPE_MASK \
 	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
 	 IORESOURCE_MEM_64)
@@ -1648,6 +1665,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		r->start = 0;
 		r->flags = 0;
 
+		restore_child_resource_alignment(bus);
+
 		/* Avoiding touch the one without PREF */
 		if (type & IORESOURCE_PREFETCH)
 			type = IORESOURCE_PREFETCH;
-- 
2.45.2


