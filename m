Return-Path: <linux-pci+bounces-11442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACB394ACA3
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 17:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2158B2793F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7987A12F5B1;
	Wed,  7 Aug 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fpEoRqMp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C285270;
	Wed,  7 Aug 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043873; cv=fail; b=jq2ed2JLy1aJu6/w9NTjGtMD2PWzg6U5Lui7TkqhMFkUZ5KPyS6ezCfOZWApNbyqZM7mGiSefd13ptneq95ayNXSFXBFAdBP7eosKFbCYLGmlq7sto6dqe5g1Bh4l52tdAp8809eWlOLXPadLmCIPo8G6Tnl1RrFqm06gwxKp9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043873; c=relaxed/simple;
	bh=+yBJp+Opjza7bjckqM7BPGv0rw7vCNSvXGRyuwnugto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVFayKsGFeomSsSQYel35Y4/cU9zGXdSpZvkdyV3tpSfLNHUZ/PnjgifT8DuUGYJ6OafavGZd8zM3RNn8MWupS+S1VDkgOt0WByS7kDPtvk8pqRpiInfDc0ssL6Tb8/VZ6nwVsDPRWM8cnQXO6InMXpdRhMi8+a4PPiYSkGq4w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fpEoRqMp; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9F+wWg1xlR4HkjjMn+M73rMkNsqRCz99KjxrwxRUVDMub0bMsovpbwPPvT+T8u4MQf85fHv+hx+mOefXggNxP52CZUmlS386BwfzKoB36bBapMWWWnLkvPlx7Sm3b7I6MVCTJe2LMqnOld308Ylzoy8Iyz5tFD2cNFja9psk1iAzMS/gCyyIFYUipx8kQrf6JVbzbc4zFyetVbPYOuTL/D1rWSY00M1krDdni6Y5nV7yh8GX8PAHcYtphVcu11l34Ntfce9K1i3irNZr4O99hWxXlgpdCEVgnXAKw/waruUhB5jlJxjubD3pdOLFD9zXGCrBfLWf+xTRFYz5GRNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzfAhHmogGL8Mx/oaR/dEuCCwVy+hR/mxT507XLJLfY=;
 b=r9RMTvXbCg+f5qoq3nJeGxDGMqx4oOvDGoAs53VcoTBN8GkoMeidngf4pDDy2uNcfBeWbdQ9bySFFwxb14EZrOym+GMGOroyAMWP1d/kot5iVMHmNHqdRlxF2uU4Kie/NEUulcGBhIiC170wfxwLcAyB4d3qz6ydfsBgkTXS/yd+pLTRLBvMISm+SLy7lFmQlgzrCc0V8u2Z7Sbn21/DQBiyEpv1+LErSY+tHLb003DYcHB4dIWPOPKx5Qdg0RGXSNZA3nffM02nqNXYM0K2SEVa11pkhJL/rsFso1n5X2LL904SwDX2jXUV39V0S9ASabWPBig860rHbvTn8qsqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzfAhHmogGL8Mx/oaR/dEuCCwVy+hR/mxT507XLJLfY=;
 b=fpEoRqMpNJ8Gqq2rjn0Od8F0YNDItJlyKbfUv6SCcWT7WSFL1xHQ2N3tuhFtg7PcS/PwjEeyLjwNvT1VplmTGFHhi4drRrpF7AfEIM+RgvKv2Manj1GWd+BHfIwH0Z+zXAxVg6Cf9Xcsg53YWgiiydyCI70hGGJItSgIjAy6x1w=
Received: from DM6PR07CA0104.namprd07.prod.outlook.com (2603:10b6:5:330::30)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 15:17:48 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::83) by DM6PR07CA0104.outlook.office365.com
 (2603:10b6:5:330::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12 via Frontend
 Transport; Wed, 7 Aug 2024 15:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 15:17:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 10:17:47 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 10:17:46 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/8] PCI: Restore resource alignment
Date: Wed, 7 Aug 2024 11:17:12 -0400
Message-ID: <20240807151723.613742-4-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807151723.613742-1-stewart.hildebrand@amd.com>
References: <20240807151723.613742-1-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d20451f-6066-4a53-280c-08dcb6f418b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GGKRK3zvl2UhbZ2KPr1ciNUk1c7qTAP2Fv1XrdmN0+fSG7ZHmGvXPSWtiNGL?=
 =?us-ascii?Q?wQwbGra1LmvYRx+2I2IibPze7O7EhVwYOaUus0KfyRdv7k1EZpMho4KNJNA0?=
 =?us-ascii?Q?IJL6cX2AAW5FhqGLBg3zF3NfG+nKxtzvt9erreLLitI0llaAYRtiIz0P9Yg2?=
 =?us-ascii?Q?sLej+ny6m0M6F2lXNB+pvwjga8GotHkl1wTBnHeMf3A2SLOBvGNrBitifER+?=
 =?us-ascii?Q?1HVQY5o2hu0VvLY93GqxIrjLfgWBA+L0OPK0dxJBaRt7JskRwRLEgtWeJyGX?=
 =?us-ascii?Q?MV1AjmoXA9UjXarqpUG6pFgCQbIMvoQpvXPJc2/JoPPY6fRf+8FebDaaYeiy?=
 =?us-ascii?Q?xojw65JXIAzfnXnCCjLKN2AaJDSpvZPdcG1YtsfjQl7uZ43HCbF3+mw51jvu?=
 =?us-ascii?Q?/M4hww9tf5rPLTPj0UgcpnH4FyqAiCqSHncSoFfwY/UjnYk4aONtebTkXSYZ?=
 =?us-ascii?Q?QYO7oT0FDmcpZBqygkh42Mu15xb5cWvusxMB5lpzoIcK3OoKl37hhOhMwXkx?=
 =?us-ascii?Q?sPIm/G0osaJEJTY6B8d+wxAh/jngQFRijiBI+vLwVjgBUzmQVaX2DnfuLbXU?=
 =?us-ascii?Q?2yaz8nUuK61XnZzOk5d55nZoEuMox+9FPa0A6VRgjziTXwCE3s1LOJ2Hd1Hm?=
 =?us-ascii?Q?S65hnWevU+6PkJSKDGjE6I7nP/37V8KiJXpG+tWfdOnns9E7/5YD4SNAQbFP?=
 =?us-ascii?Q?HaXwUMQnk0TTbmOofdENoAilE48DR/CZl9zDA3lYSMohWFMZVzvQz62ui7Xr?=
 =?us-ascii?Q?EqC3zs24OAKR7bCQxQrNg+azeJSSYOeerxNZJEzpmvh3V8ctLA/LRBmPOA8g?=
 =?us-ascii?Q?duYrviabqknDz/UekaPDxVQqUM6jI9KX9+R4LalJZGnJUEnuUNp7VNHSk0gI?=
 =?us-ascii?Q?Kn+NIswRQ2zAq7b+TvymnyQpiR2575+d5vXaRkQDOY01kEN6EMWNb0awaPez?=
 =?us-ascii?Q?8nGLSnQzcJeV+yRr6ZCMVtK00h8MXqBASTTj3X4btbnnzXta3s073SPfqNBv?=
 =?us-ascii?Q?3GjVrbXaenxctfDAqn+STemJ8i7imPrJ5WoTahlGxSZ+95ucLFNdBNTAXdc3?=
 =?us-ascii?Q?rmxBAUKk5DuWEGgrnik0+UEXiMp+hSBHyjVePGfe0wV7kPSgwBmeePj9NYPU?=
 =?us-ascii?Q?w/HlKx29bHRGekP2oOrkZnYfzcn7O11736wW2u+BC6JQpqTP/CRuy+xxTXqR?=
 =?us-ascii?Q?6CwfA8PvWLaINnVjXsFDood6ziw0APoagEhBKewY6Xu9xADBlFef0KWDBy4X?=
 =?us-ascii?Q?FFZxbnHk4W+ETUh7/tbQFU0Ss0vh5y5TTwqCCPYD4O49YpQrGdWwic+BmeFF?=
 =?us-ascii?Q?95Vc6kmytBv7yjzjAlZatdmozVJ3Bzn4MYny2EF37m9WXcpif0e4LmwhwM79?=
 =?us-ascii?Q?5ZD230DspJEwzdYkweS4XBbZQrL4SFLmIwRY18GsxR+1sviO3DXeULbmsP4Y?=
 =?us-ascii?Q?XAAZ4PG5Gak4IlBYTe4RNdnOYOFIfiTu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 15:17:48.1737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d20451f-6066-4a53-280c-08dcb6f418b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405

Devices with alignment specified will lose their alignment in cases when
the bridge resources have been released, e.g. due to insufficient bridge
window size. Restore the alignment.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
v2->v3:
* no change

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
2.46.0


