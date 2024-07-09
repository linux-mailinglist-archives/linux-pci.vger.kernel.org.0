Return-Path: <linux-pci+bounces-9993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B525292BB81
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 15:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D15B258A8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716671684BB;
	Tue,  9 Jul 2024 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WQ4Bzswm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0815EFBD;
	Tue,  9 Jul 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532205; cv=fail; b=NvKMZTwmY40Vo6Esof0oBHwjrcN58Ip1moU8r6nb3ZCC74BBJrsgScJJ35toZDflHQmYs2r7EnzxrauJTiSRMwhb1rnNLOj+mjbCrJ9RjQZBr9tREP/06m45XzWtpw1Ks/w6OVGXSCbyhncRodrKFVqLvxxCW+iZVGMajfn2U0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532205; c=relaxed/simple;
	bh=yS5YUwNwvGunpsYqywsf0HPFXmSzdF1m3kf2HAepR9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bs2eRYZpgERQc0niz998n3M9SZCLMQs1E/6Z/ZPQ4viNK4PGPkTLj8Gswb2+ReEOEdtFU9notI/KjYstOv6MJj0j33oUDvtBtGBGXi3ilLa0Umw3vzfUokgWRCfu2pjbv6ZOLZgkCZOQqOtWJ4foXhZJGpCD3fSB4qy3DmqczAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WQ4Bzswm; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcGoUA7TD/evxLkD79Gx2gXsSaJw4/2kM6bolV9Zi1eZusbpEyzdrFggwNL3K/HJKkErQgDNkX4W38RZwfHXlFvwx26A7385UOHbK6XH+t9pQ8LGR43Ty4faHfSXNkoUSIiFhXTww6jZ7/m0hQU796Vj7BHA91tFLEEvi7cTFFuw4f1Bm+J5r/xgh3Y9Rfmy2cJWzlYrFbTc+JfU6C5E7qNr8DyrZUrDWoQQUyNLdJ4QM3QN5jQ+USZNJnEd0QlUH9mkR6yOPRFpfN5F1W80K/RYBHd+vyxzvm8xBqqLy+1FuidxalCXCs+eQeihgGxseRG0AMgV4SI8nfu6oXjAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40DTTpS8PowNjXj5rEF64iHwiEQlRXNuqEkX8hZUV48=;
 b=ZLFqhvJlTbe7mRwYwxc1pANK+bZbpOgmwEPayIl8TQUTxnCD/IX4RgSDwgzF/bQV6qpecuR1HWi8E6Bx8ecLLXbdv+bUXbLrQuKeyg08lONkILpkOVdiSsc9j9jJ+Ok2Q5foP/BX2aV49dWjTnasdUQtDT91jtv6AEGSRRKdMzuYKqCHB9OIj+CaJ/0cNWbgFqIiMxiXwRj+EEtizTY8ji0c6143r1YbmmCvGIOnOzJIhcYojUFb9WBbO3GmkfrjLXz9xTQq+rRmOU1y9xhQKimzgZyUfVMHzHE38QDtbqn6ZGj4RqSUpF+VxrSC3mjWNcRMsejoimkfKrL7aXNt+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40DTTpS8PowNjXj5rEF64iHwiEQlRXNuqEkX8hZUV48=;
 b=WQ4BzswmH/R1FnvGI0nE3W4VEO/B+qSGn36s0F8CwTfk7oH3eSwCGHhghkXHrpFHOA7EG+gv7vhghd/Z6mRUJd5DCPjtkiCJjNxJvwZn/+q2iEnx1pTlJwEdN8hVl6m9N3RdbS9S9b33NKxf4SlKPjR7UMigGRZeG7m5E53IacA=
Received: from SJ0PR13CA0043.namprd13.prod.outlook.com (2603:10b6:a03:2c2::18)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 13:36:40 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::6b) by SJ0PR13CA0043.outlook.office365.com
 (2603:10b6:a03:2c2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Tue, 9 Jul 2024 13:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.1 via Frontend Transport; Tue, 9 Jul 2024 13:36:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 08:36:36 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 9 Jul 2024 08:36:36 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] PCI: restore memory decoding after reallocation
Date: Tue, 9 Jul 2024 09:36:00 -0400
Message-ID: <20240709133610.1089420-4-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
References: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4cd595-f5d8-428b-c2fb-08dca01c2a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k8lxccUkaUnDidP69kSpN6RWxMp9QsfplrUHBCgDHfwUcQ6/xBwuk5xY2ll6?=
 =?us-ascii?Q?DKxaHxSNgkzYUk9o26dLVmTADIUTS5GleSFl7+FOo62X8KX4Wks8sWNjLOsD?=
 =?us-ascii?Q?wQZSB7i/9spEPwRv4ctEGunLrWZ0I0Ld2cX4T/+AUg/t38mLeYIg7p6VQKcJ?=
 =?us-ascii?Q?gW1IrrPIOUlPJX3Sj04oPAi9UCZ/frrACxpRQerd2hWjtyJrwv3MC1WZyGcL?=
 =?us-ascii?Q?d1241gloSsACs97K115AV+km/AWjz9L+NaZkrAoYiEosjTfSOGh2T7mpsTvo?=
 =?us-ascii?Q?QFH4EYtOxTevwk1zYvdcHoy0V/o8Xj1ZHuw556so20YCnFwy7MpuQNcPruzJ?=
 =?us-ascii?Q?CcXqhV8c8b0ovN1RO2kdPQSOJSiusxcKiOWu50iLJTQOkbhsZBFxK/TrJRVg?=
 =?us-ascii?Q?+oyva2L14p4zp38LUrwby/ns4DPbRnAvVBJygfO6MyphXinNEgpFW9xEIAjP?=
 =?us-ascii?Q?VxYcSShjfrkE4o8RpReigXoaqthJF2FwVA4KnlsEl6I1wzf4Q+yS+wFTaMeP?=
 =?us-ascii?Q?8NI2L4+naQ+gVub/YtP+fk6S0oYseAP08t8FvoB3KZ0GKRQdpOQgJtZUrrZu?=
 =?us-ascii?Q?JIoErV4aD7ypIwM6Vd4qB5agrIecRii2iRCMyGNNtyTG9V+CK2dSCb3hSq9g?=
 =?us-ascii?Q?t+Xt4JFZy9HDXrSSWhyluTTn1T0NHbFwyNup6Z6LO1YpBdgkMyCeoLAiPIci?=
 =?us-ascii?Q?1UsYU7OAccLRuzNEjJKHuc/mdgpNr++IdQcPMyGvQDkGZqWNs66Sddc61Nl2?=
 =?us-ascii?Q?VR2GX7oQEzugMx1g7cvKj+p0kiMA8BP4/3WpQdKeGPlvVmLStOIZeuj9m0q4?=
 =?us-ascii?Q?d5+HHdekYhtZShawwUUh+iZ8qPwT9/qTlcKfx1Q/t8i55mNSz71tH1Mp2Vdc?=
 =?us-ascii?Q?gf36PTLCrvJIdA0pvZsCU2XyouKzQ78j1wyI9CgfgRQ0nO0KpcrNtXw8nYV7?=
 =?us-ascii?Q?K/G9xKEN5dafvaZhBBBs1onO/9UvBc1mHEU4XlRdzqiLlSkV3SEaoTi7qZBY?=
 =?us-ascii?Q?v20v/IRup/l3qdZRg+CLKMyVl995ADPBSQXLD2uZw6C4lMpuQ2XL/BNB8z0i?=
 =?us-ascii?Q?aONeNGrd8UR8NS3/2k0WtHukgHxXEkRGmBAhTMGG7hkB1Mg/7ZBA/iuM6M4Z?=
 =?us-ascii?Q?FLqFpORle6mYW0JK7WFqoE02dgmknJgCBbB0Jg9EJT1ErvLe4UqENzEe9s3P?=
 =?us-ascii?Q?queIBTzTyXFvsqdQZNO9ShqI4p68tQ0auhOQJ4J8H5ip0QXSd+HIdQ500nb4?=
 =?us-ascii?Q?1REl/Qyxxah2x9VAq7ScPiL04rowhCsZaASQE4vWeWkqsuHP2VzKh526cq2b?=
 =?us-ascii?Q?dbTQjWYp7lxC2tL95tVfolJPahaSwikRm2VqOZL/d8COGFaqhTyV4b5q17I2?=
 =?us-ascii?Q?HdlmjReCfRbd0hDoW++PezcJ4f8o2PqdCKfBxR7drn50roGJaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:36:40.3576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4cd595-f5d8-428b-c2fb-08dca01c2a27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329

Currently, the PCI subsystem unconditionally clears the memory decoding
bit of devices with resource alignment specified. Unfortunately, some
drivers assume memory decoding was enabled by firmware. Restore the
memory decoding bit after the resource has been reallocated.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
Relevant prior discussion at [1]

[1] https://lore.kernel.org/linux-pci/20160906165652.GE1214@localhost/
---
 drivers/pci/pci.c       |  1 +
 drivers/pci/setup-bus.c | 25 +++++++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f017e7a8f028..7953e75b9129 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6633,6 +6633,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 
 	pci_read_config_word(dev, PCI_COMMAND, &command);
 	if (command & PCI_COMMAND_MEMORY) {
+		dev->dev_flags |= PCI_DEV_FLAGS_MEMORY_ENABLE;
 		command &= ~PCI_COMMAND_MEMORY;
 		pci_write_config_word(dev, PCI_COMMAND, command);
 	}
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ab7510ce6917..6847b251e19a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2131,6 +2131,29 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
 	}
 }
 
+static void restore_memory_decoding(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *b;
+
+		if (dev->dev_flags & PCI_DEV_FLAGS_MEMORY_ENABLE) {
+			u16 command;
+
+			pci_read_config_word(dev, PCI_COMMAND, &command);
+			command |= PCI_COMMAND_MEMORY;
+			pci_write_config_word(dev, PCI_COMMAND, command);
+		}
+
+		b = dev->subordinate;
+		if (!b)
+			continue;
+
+		restore_memory_decoding(b);
+	}
+}
+
 /*
  * First try will not touch PCI bridge res.
  * Second and later try will clear small leaf bridge res.
@@ -2229,6 +2252,8 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	goto again;
 
 dump:
+	restore_memory_decoding(bus);
+
 	/* Dump the resource on buses */
 	pci_bus_dump_resources(bus);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e83ac93a4dcb..cb5df4c6a999 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -245,6 +245,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
 	/* Device does honor MSI masking despite saying otherwise */
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
+	/* Firmware enabled memory decoding, to be restored if BAR is updated */
+	PCI_DEV_FLAGS_MEMORY_ENABLE = (__force pci_dev_flags_t) (1 << 13),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.45.2


