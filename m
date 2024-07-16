Return-Path: <linux-pci+bounces-10397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C62D933215
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0C01F27028
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAE91A2568;
	Tue, 16 Jul 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IQzCbJqQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847371A08CC;
	Tue, 16 Jul 2024 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158477; cv=fail; b=HdmSSUKLZzykCl6Lc+f3Ov1Wmp2pwPSP5lV/aBbuV6SoibSY+QluFw38YmKH7DIjtmLxbTko31lZh8MVcdJ+Igt+9hJ0awQ6biO44VC63ZbZuBEEtEUB7/rCwYEvAQL9dZEmrmEP2JYfQG5TdJI8hqWBGpiOp1Vr8xD4U2Ud2kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158477; c=relaxed/simple;
	bh=vKUeo3ShzHXKrZBwUIrQGJtH2Isd35wy7uqYdzQhaQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMoce3gCN4T9+sQcn8/UYegFCf/OZsb08RW73+TyAavsFPUQuLCZkJJnps5kPjEU1pq5CLsGN1FoY/lvpEndCKtSFA/cc19bpFlxtLsUdTdT+V6UF4rywrBumXhfHFaAzOE9txwEW1kZs6Jj35yLutT9DY1YAR8Sbyk4fcH9R/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IQzCbJqQ; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqTiaMg2uC/DdkLmUDps7o76jzaOUGdTQMuV+0GsaLFPWos2fsloI5IodqxtdgDS9W4KqJL01J13C/SUPDc4ySyeu2Q7Q4ZE0nokzL4QrzIRimp55VSM0myMmQ13oGiQ3kt4+sgkP7ZD5VZDRzF84q8oO7wAjYA+LHULdXXjjyLq0Q3PLyJqUZGkg684iKax5EOmZvzJ16l5vwxrXAKuLUUg1Rqub9NTl5tggWyXzRA8Rg2hjkIBx90nR2d10UirXCA/xsZUW9O8vMN3XEP3DZAJOMrVmiSSNlqACdqEXXCQ5vW9LsmJkjEU8WGxIJEVop7ay21i6uHTFJo7TBF5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zMxo9JvASDRg6pzKJ03QCy0rll2+8COyUKeiqmPURA=;
 b=U9dsg90VgUDYK6NU8zNST4mhVGvSxdh7BwH6hdHIJLEIr49zMs2WgUoj/iQY40NciJD4H3fOfM6Dx95Xdub9q6sh2yY6p0oGEoENWUApjMcYo9zQJQf/x91YlUsogalF7DtruREZtOorRfHTLug93RmFouIeysFFczNdFiEUliZMLuEZJCgIYEYIWHW8UV9fJ0oFT5RUiGd3pClQtSanOwVRKZUf3MqH/Wx5iTdh2RXmSL2wUxYDbMH3jzIU5qszmnNhMc3dSjZcv39CG5turpup6uC7Edv7swr4IwBeBJSq/JvU8VLBOjdWgfBgMo12b8xsLE7DYTsdkaGy3cSHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zMxo9JvASDRg6pzKJ03QCy0rll2+8COyUKeiqmPURA=;
 b=IQzCbJqQDygP2gq3u1CwWtnaygCMh6fgo/Z0y91BIDEmISVNstn9s+gU4pdbdQ3z5a8XBg47IuJWk07GsMmcTMdQu6QRKwG+pE2hgqRP9gW9cF+jQcKROHDjfx32PcxuDONebq3xM2/wvNSc8HU7Vf+MU63eRundxg6JX7oG+M0=
Received: from BL0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:91::20)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Tue, 16 Jul
 2024 19:34:31 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::57) by BL0PR05CA0010.outlook.office365.com
 (2603:10b6:208:91::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Tue, 16 Jul 2024 19:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 19:34:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 14:34:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 14:34:30 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Jul 2024 14:34:29 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Yongji Xie
	<elohimes@gmail.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>, <x86@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/8] x86/PCI: Preserve IORESOURCE_STARTALIGN alignment
Date: Tue, 16 Jul 2024 15:32:35 -0400
Message-ID: <20240716193246.1909697-6-stewart.hildebrand@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1365cb-ee93-4df3-4d9f-08dca5ce50aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1rbbrFjQ4HmHo6rE0nvMKOKHtQ+ZKJ0QQI5O7fOLzxKheIdepmEbVZXZMy52?=
 =?us-ascii?Q?Co/ixmymfAcvUraKQNCtisj20wQqIJw+caeAuNlWQgXLz9qTfD9sdK5ET1oC?=
 =?us-ascii?Q?VCHJtbMq0ndEN4qW4Ouq/pZUSvdiUom/Olkl4/9FnsEPhI2ovaj6DX3FASRY?=
 =?us-ascii?Q?YuzRCZxM/HHpcLEvdvzJ8Sr6lTIrApxQkHbIACSl63BcE+GjO/4xPaJRuNh3?=
 =?us-ascii?Q?qz1eq0o3qyPOHQwatYsQJGefWXu+TwQcr6gJjzXdc+ehCnsHui/k+ktpMykQ?=
 =?us-ascii?Q?DHlMBJU10Q2YSEGCcVliKKc4w3OWuKV1tmE0r0GSHYLG41CxENVMd1rh1PjK?=
 =?us-ascii?Q?a7UGR6Ghz+c5prrsDTBv1iAjAp2wFYnSHtsEkwBeBaTYZP474pqC9961fVpG?=
 =?us-ascii?Q?XDbKDTXsR/f8EI2BVpSKhsNfzOuTWJFnKxLFLA1RtUi83455E4dZOscPT323?=
 =?us-ascii?Q?z9WLH9KZxcjBnTV2puaOsORm2GgIPP2RbPyFUZ78l7sbS+E2B6bS8jedS2+j?=
 =?us-ascii?Q?383bD50cJfuuFRsmEl1iEuh9yoOrocofq0Hwh1p3m0i6ayKJwWoGVk4gpG3m?=
 =?us-ascii?Q?/VRk7gOQ0G9MOgamRjuYxjLtDTMDPGhDxsasSkJlI4xi9u1RKITgUtUOc4AK?=
 =?us-ascii?Q?gnNOjo4iIrdka2IQqY+riAiZdiF1P4WR6elm+vgH4X9HyYg1GM5943Umxkio?=
 =?us-ascii?Q?HWDwxIoatyKmiNMQnz7wPlwtXo2elNKPkcjmneyVAzREa2OOIjt5F9dUDDLe?=
 =?us-ascii?Q?/Ht4XLeYwPoa+92GpX5gXBNcQ25b5CxFZlTTeIbpQwn4pPXiqqn2/nXzcvo6?=
 =?us-ascii?Q?Qw1r/CYxUM+Jvff8ULwwwzhddDUyaEVoB5B5jvfPorK1dfPf5xFA4Ap0sQ5L?=
 =?us-ascii?Q?Se8r6T6SoH65h6wS79Owp16Iq9IQB+DAgJNPnRvqTN6bL7o9j/GDtKfNeywd?=
 =?us-ascii?Q?1QfOIFsgMK1G1QipbP81wd/jk9CZoZD3AOb6o4JJevS4POrRXIMpJEGz507C?=
 =?us-ascii?Q?rhSNELctb1TOvTdpxGkZsbB/xYD3rt7RcIxi2PnF5/SdwBq8Bc/gBqNEJMMg?=
 =?us-ascii?Q?vSIZ4W6Y+nwjIwXD2w5pbYLalYH04v3r9ZdOgKKsFP+pvpVR+qqkEx5bEsxY?=
 =?us-ascii?Q?ElrIM/2mT0xNZC0Mnjfaxitj1uIfSq58imMyk2ZVlh2V/LPGusjcjyz3t1h/?=
 =?us-ascii?Q?ks+Xr3QvLPSn7GV9xs0ttYmGvp3T2CwYpdI0Phb66S/B97GtAu/DUWoCmaXn?=
 =?us-ascii?Q?CqyWaqtOsp3HXWutYgQurTPX1BxYKudlX8BYq03mflh3DoCPyXpvyt82OuIL?=
 =?us-ascii?Q?cKN11i0673DqS3sZMTO3C47YmYDc71LGWqHmwWvpoJ17TqtZzjYQa3uVS4YF?=
 =?us-ascii?Q?7ft9D7XpEYZH5dbVBfoUCKvKmc1dj0aZntiPDvcAKZg83NCQFpzvJsRF0KEZ?=
 =?us-ascii?Q?U6i8k9JCaq/wn/XIf5HUxXch4dDLtGdo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:34:31.4170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1365cb-ee93-4df3-4d9f-08dca5ce50aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119

There is a corner case in pcibios_allocate_dev_resources() where the
IORESOURCE_STARTALIGN alignment of memory BAR resources gets
overwritten. This does not affect bridge resources. The corner case is
not yet possible to trigger on x86, but it will be possible once the
default resource alignment changes, and memory BAR resources will start
to use IORESOURCE_STARTALIGN. Account for IORESOURCE_STARTALIGN in
preparation for changing the default resource alignment.

Skip the pcibios_save_fw_addr() call since the resource doesn't contain
a valid address when alignment has been requested. The impact of this is
that we won't be able to restore the firmware allocated BAR, which does
not meet alignment requirements anyway.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
v1->v2:
* capitalize subject text
* clarify commit message
* skip pcibios_save_fw_addr() call
---
 arch/x86/pci/i386.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 3abd55902dbc..13d7f7ac3bde 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -256,7 +256,7 @@ static void alloc_resource(struct pci_dev *dev, int idx, int pass)
 		if (r->flags & IORESOURCE_PCI_FIXED) {
 			dev_info(&dev->dev, "BAR %d %pR is immovable\n",
 				 idx, r);
-		} else {
+		} else if (!(r->flags & IORESOURCE_STARTALIGN)) {
 			/* We'll assign a new address later */
 			pcibios_save_fw_addr(dev, idx, r->start);
 			r->end -= r->start;
-- 
2.45.2


