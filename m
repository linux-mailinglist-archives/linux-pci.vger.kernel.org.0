Return-Path: <linux-pci+bounces-10396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61799933212
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4C72826FD
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 19:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AE619DFA6;
	Tue, 16 Jul 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QvrKWOlq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B74419E7F7;
	Tue, 16 Jul 2024 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158468; cv=fail; b=Z56ce9cCwrvPgecyUNaE7yQRc0rStGHxyRJPPoIET9I3Nu9vw/MkenTNwHhCRy+8QlPN9kWqn+3bpj3Au9ePce3TVYWBwCempwDGSbNymZZOnGgaY2P+1RTrFUAcji386msVsjtx8JzhROJEoQtBGYMHl4HYT0mbWOM3S0iSpsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158468; c=relaxed/simple;
	bh=6rwqamannBU5g9+R4FnW3gQzG+TV0cLcY9Ynb1AeUTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNZUtyCahp1yyKJ/nklw+FExAM5VVmHvoNGaMlO2VJ7EcOGI4KOOHPL0QPsb+jKY1RPvHOcW2TEjy6WSWSOtlCjJE/wEENyX62iFcvGGwefy7VOrW18nsqFUSAGnCccqoB/vGCJO/vIXObTRnBGa7N9/aa7vvF0vK09SdlBb4Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QvrKWOlq; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzZsMWQ2pmZRg4QCDkQBBOyRP777YiY3c6sjIv9WZC6kNpbvxpI97c3/7JCPk2TV9A+Mbjko9UZpWKANE+CbFjejMWd89qVVpbg3Pe+rZ7VjUiN0fjy3b+7Iu2/l2WXM/RAJSWPNtLXAcJgwIY7bCRvbVeDZ1DJb+dUJcGfVjrObSOiB4g+MO31+p6LPdxU9McbKdObw1po0gFYApNvYbgwfjba0/CtxQv/ciIuOp47pI+IzcthmpH4wEsAI2hlWLxspe0JvXQItGB9yK8Cza4gZElN6yPuSerV/tp94+TxIbDZMdsAZnf4qDg9Umj5cBR1pjhbllRj/uiMD7f2dSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F58jKxowfvxFVDum2puPgnHssvMZbphujfInpzZHMnk=;
 b=q3J4fvDpya9GYsiigCPJp6QN4vX08h/gQc0ftY5UfLK99bWEEVRqf6DQ/wco0JHgpyiNFzcLB1vIRVQE3YxcQfdeqQLd9FYvFPcLKzMNf7iWXb6Rj6GqVCLiFQKnzR4yFM+1BJhllncmbQp4vaqCoWdDciTy4OeeLJgECUsaw+QQ0tr8So5VScLnuuZdIl7G33kVIrYFZnw872sxYHkWc6JHBCp9jxFCIOBIdkqfvVQFYr4mJFvhbibtbwTNhXYVtKoXPq3bHbLvtAFfZVlOfuUjDIlC6DsAqJxVuAlwB6pCREJCf3CHoS69KzUtOUJncDJiQIvfMQ/A+uEyVNZk+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F58jKxowfvxFVDum2puPgnHssvMZbphujfInpzZHMnk=;
 b=QvrKWOlqQFbumi+amlpbS06Nfx8UbQaAWDxk6BgfCbf4gSKfk4N5qXFMkYxaTdnyUoiFgr3H8w9N7OTLsg/XYm/5W8KQXDzss5zLwFVpckQjaKnKeWw5bj+oHv7y2dXkBlhE35JUxBFHpRMZvkL363/d1XmWcRjApU4o6vISBZE=
Received: from PH7P220CA0115.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::32)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 19:34:24 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::b6) by PH7P220CA0115.outlook.office365.com
 (2603:10b6:510:32d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Tue, 16 Jul 2024 19:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 19:34:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 14:34:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 14:34:22 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Jul 2024 14:34:21 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/8] PCI: Restore memory decoding after reallocation
Date: Tue, 16 Jul 2024 15:32:34 -0400
Message-ID: <20240716193246.1909697-5-stewart.hildebrand@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 430d85f6-2e81-4a03-28cf-08dca5ce4c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C7+S+MwHzDGRJF4GdPT7jVaB7OfLiOO/2pO72ddhwUBrR2QWa4c5KJt1xAUz?=
 =?us-ascii?Q?TLIvI2dEBjajkuR3XsDhBfddunkbia3b5UaxMKlNxtlfiQ+s0NpOp/w5S2on?=
 =?us-ascii?Q?jy3YlySJsDtXQc/bHt/vZQXdcNscc2M/2VR0L3GKleuD0d0LowkWqACPXzQp?=
 =?us-ascii?Q?KklPAoGstL7jHUIP1Xtwpm5T7qG04ahrxZa1f/zZSWJoGMTkVWqjMy897Y/d?=
 =?us-ascii?Q?QuBBuJwcbk8KqTI4Q4jQjIvAGX4LL367EEqQTR+nAkR8h3st74vQvnLpPD2L?=
 =?us-ascii?Q?QEo3o2Qaag3uTEm8kPkc5on2sVWm4bTTc2qtgKxJYd5F0puoBoZP6vN1dP9n?=
 =?us-ascii?Q?1JwlWMfueqM46+EDRMu99qmKYMuVFSu8L9kKyDrafVjLnYIM99UC1cdhudAR?=
 =?us-ascii?Q?kfEXxuuVqSafyjwrLghzZtocVSv2EdolKKwcWLL3UfSlUmnrzS1Ae3iA6Uf7?=
 =?us-ascii?Q?x7t0iTVwJBiQadQ9hpRQyx6/dBaoJNv9XnvMNGIJ8x93PEk0TLSIUjSokShc?=
 =?us-ascii?Q?cPMGrq3E2ly2qbs+nwT50MkI7Ml3LzH9zLauLwvugLKbQnBBV0LH/fF/oHB6?=
 =?us-ascii?Q?+CdksFszhbk1UDD0wtNCvWgxLhDPWDxgVTLOVdu11byiRm84A96DsM4HA6YL?=
 =?us-ascii?Q?62tEBgC+s6YSaxGGpKLQsax4tinMNQGiJoDQjZxmE/ARKjpED++skh7sFRtp?=
 =?us-ascii?Q?fSPpZ3nrtfuA3j299B/pC/u6fR2MNxKnx7RBSnEYvR1M0Nc852qstrNBNVHP?=
 =?us-ascii?Q?ZThLd/Q6WGEwUYlcOlA6rXkHkETcuUlfH7nZY0xgpKnSWFgBN0m1CxZwunXR?=
 =?us-ascii?Q?eyFSA/Gp6rE8GHSCHiPTs9a7HeJshJiF0JUjKPvO43jdl2VJbN5QJ+RTfC9S?=
 =?us-ascii?Q?Hiz3V+9SO5FZvLlZmg4DIBvXj/JWP/ZfRwutOgAhGee6lDebqfDJVfAtHTKW?=
 =?us-ascii?Q?eYXqg/Nc0cxTnr7y0s0CLZUEzYbn0gN0rR5XazolNUNrUnE1VdF25lwFaxsu?=
 =?us-ascii?Q?Zw3qiyCrngyGO/i1FwTf+pAyNvU7Gnjhs2TOSeQhp3WT7U+lBEHmWTwHwYOZ?=
 =?us-ascii?Q?4EzFYi4z5RZP4I3c0Ye+JvRPW7KFLKCRj3bS4oMhHnHARYY/fsmb35v2aQzq?=
 =?us-ascii?Q?yK/G3sX04jofF1T3uNivW0h7PAM2g5jly4njBYhZAP+jsIfDdWO49Hvjo/i4?=
 =?us-ascii?Q?U4PltFlnkqcViT1E3QtKJbb1mrUBXFCDtmRQEsmF4dMn68PuAlZNeoriUjJq?=
 =?us-ascii?Q?W6b1a8tF/KmpsD5KS3o7E1liTE3+hsxYSfBqhlG0jxeGA3z7noLtz3kQc1Vs?=
 =?us-ascii?Q?irYE0YaiTbosNvhAxbXJQD/0r9DZuTWj2erUng4LgPv/iNZJGaxytkyCoRaB?=
 =?us-ascii?Q?WaWgxwdOuzgO3HXg8qkZk1ftVtL9CTLYg8U9RfhtZDQ/X6nqsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:34:24.2848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430d85f6-2e81-4a03-28cf-08dca5ce4c71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

Currently, the PCI subsystem unconditionally clears the memory decoding
bit of devices with resource alignment specified. While drivers should
call pci_enable_device() to enable memory decoding, some platforms have
devices that expect memory decoding to be enabled even when no driver is
bound to the device. It is assumed firmware enables memory decoding in
these cases. For example, the vgacon driver uses the 0xb8000 buffer to
display a console without any PCI involvement, yet, on some platforms,
memory decoding must be enabled on the PCI VGA device in order for the
console to be displayed properly.

Restore the memory decoding bit after the resource has been reallocated.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
v1->v2:
* capitalize subject text
* reword commit message

Testing notes / how to check if your platform needs memory decoding
enabled in order to use vgacon:
1. Boot your system with a monitor attached, without any driver bound to
   your PCI VGA device. You should see a console on your display.
2. Find the SBDF of your VGA device with lspci -v (00:01.0 in this
   example).
3. Disable memory decoding (replace 00:01.0 with your SBDF):
  $ sudo setpci -v -s 00:01.0 0x04.W=0x05
4. Type something to see if it appears on the console display
5. Re-enable memory decoding:
  $ sudo setpci -v -s 00:01.0 0x04.W=0x07

Relevant prior discussion at [1]

[1] https://lore.kernel.org/linux-pci/20160906165652.GE1214@localhost/
---
 drivers/pci/pci.c       |  1 +
 drivers/pci/setup-bus.c | 25 +++++++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 53345dc596b5..1ac1435ad91e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6677,6 +6677,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 
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


