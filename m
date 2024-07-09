Return-Path: <linux-pci+bounces-9994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3810392BB86
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 15:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EC81F2406C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C20E16D4CA;
	Tue,  9 Jul 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kRX0CZcj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90F16E88D;
	Tue,  9 Jul 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532213; cv=fail; b=WLO5qjtDHcQC8nAlufA6odc4jtxUKxVTdbikdP2HbA6M4SNFRRzZyhupc7AHYrmOmii9+8kvbtZ1x46/DzUPfVFtFZs0vmW6VyBrVcMkeUy7LP+bfFgof41w5U/M9LC76+RSxfXJFw+mNutD5+QQqN6RoFNXviBp30xiAa9AaGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532213; c=relaxed/simple;
	bh=cToJMfVcDtXVUDDHudsq8fdfEqyVsHsWVFXOER6/2bI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ou9jL5DcspwPmOJY8vDEG8txY1yCfjR4HiEIceQX357Nzl90uhbT83Wr4YogAm3tqxKKSrQcFPObv5nqNw9odkssIvLsRWdz/vhFg0CQn+zhpy6G8IOLJ0Ii21uhJgQ7G1hoS9/nnU97d8taBA8JmwBIFdnUig2iOQ6W7BY0i9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kRX0CZcj; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAto1f0uJ8IkjK5faiJKydK8n1Sbtqukzpb1db0oHE5YByZFc7Jnyocaqfa5UCoroESKiNEdfkOJpAv8MqII1lofWoWELg/4rzfr2KtvZoMNlSNBB4dhiNHPCimS+fl/Vy3TpZ74fjQu5tcmSlzNvACjQ6o1vc8kqOmv1V2bcDEZ6Y/to62aiksldKqYo/tQo5We0Wxgq5jhUu5Kpa34u/uZ/C3QMcqEdCAPHXSyDvk909gvLlZeOJGm3lWItYEhqy1ETh0DY1DfReB7wFZxQKZNBgepDKHjG3UI6SaNNc5Pb+atz62g/vynDpNfqtP4bCWEI/z6eT/KMDIrxGbl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFhJw9czWItxNX+EWwUOFbl1n14SXgTzB1etUFbqobM=;
 b=cWqg7A+k7mI9BhJMUjywEr78pD1yRq5LoKHURQ60tPS4BwpPinxsrf5+WARDvrtK4Fgb6ozpBqIGJawTvvqevM674NkY7a4YCXtIWhtTRPdVoVOsxR0bWR/Kj1q3ZcX+CJ+n4mI090vzQCRhLgNVC/PtiyHeVC5b9Pczof+b6IaPgWBvrBFsRPmUCIMzzYePcObroJUQkPLwPNUdidKCCiDw1z5fZW48QuNPEUkTsShMHHmJdMWC9zjWow3ZXMXldcEzI0SuX98dIVL1o9hLtx9gRnuYVEMY2RAvylt224Tu3q0dpLhxgwRRaTNDWHgMIak1tso3szJUCn0qvmMcQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFhJw9czWItxNX+EWwUOFbl1n14SXgTzB1etUFbqobM=;
 b=kRX0CZcjfnjLftI9xdUMkooB3EVukN5K3Kfa1cKoOrQOh0+WvEX4QIr9sLrrqSVJK3sgn4qET9Bp6KaBcrecF1poMTPPP9KaMv8ZKmo7JTLd5d1uV8+b9CkyDiWgfLzzGSvLlsxfY3IIJqiwzlgc0c+DcRG7rUuplmF35EMMVnk=
Received: from DM6PR13CA0038.namprd13.prod.outlook.com (2603:10b6:5:134::15)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 13:36:47 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::f2) by DM6PR13CA0038.outlook.office365.com
 (2603:10b6:5:134::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Tue, 9 Jul 2024 13:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 13:36:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 08:36:44 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 9 Jul 2024 08:36:42 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>, <x86@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 4/6] x86: PCI: preserve IORESOURCE_STARTALIGN alignment
Date: Tue, 9 Jul 2024 09:36:01 -0400
Message-ID: <20240709133610.1089420-5-stewart.hildebrand@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: c0223e0c-764d-4f0d-bb05-08dca01c2e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KKNvhN/WTTj2j6v49eR1VScg/XCTjlijmfKSy0QJvjDKVklRSvvKW/fWsiTK?=
 =?us-ascii?Q?AwwWPosH54LURhJOrGzUXbBZZa/D2M1OyUDib/WaR/wb1qWHXsdw3YabFpkD?=
 =?us-ascii?Q?YDxK61B+1OCmJw/e5KCNZHjOwLsVD7xmmngku5KM52ZfOQRi68zFpXKbwDxH?=
 =?us-ascii?Q?RoBoqnfR30QrFmJa3x00i5WqUeEtJ6kHB3truItRAxl76BTwdq3XyN3qS9k4?=
 =?us-ascii?Q?3EbXAPVzBlO6PPTKTY9pZcA5mgWYfAOiZO2i9W/cWsK5uwyhRi/jlP0TMTFu?=
 =?us-ascii?Q?LbhOGF3s4CD7Jmfv9NgYTXrAQWQIrRzi3jZRR9VzUuDbROIeApb/Cizfnx83?=
 =?us-ascii?Q?6WaksoPkr4k9yJLJMRpesaVXx0psk4sMKTYGOQitxm5wTTrU07GvkZae9eP7?=
 =?us-ascii?Q?0ZbTtZaTlcOr0MSt3S3TA8DeskAT42DHaVPlnafgxg9ro8/H2mRt0RVhesRs?=
 =?us-ascii?Q?dpX4egYeobU5yihPlhepQRaW2YMi6/QhJFqr6bdIah+dyQePhLTCSxR8AiP0?=
 =?us-ascii?Q?pkycibpTLIQckagBMOxIykfLiq2/NtRPDwSxGV1WDsLVWNYGJErA/oG8gREe?=
 =?us-ascii?Q?nM2+a/hhIa62k7LVQ8xwW5ms11f4Dum5QKAF8Ir0rH0sz3Y4k1FrTbUm/a/0?=
 =?us-ascii?Q?d+gdeSR4H9q71gn0XmFpaQalK1XBIEzmpzLjHUGrOYLamTmPFhN6Hc8tbY/f?=
 =?us-ascii?Q?b8JHMIDHiNJjPzVf14fyLO2bRPsmQ8D5QXhVGw/iZTqsmP/Dn1fVrfeQNkYm?=
 =?us-ascii?Q?sjX68dPJbe65XWgd1piQh/QFNkOk5fvcgCgNoH6s0yTtVBmItA6sKVhCu+wB?=
 =?us-ascii?Q?5H0qKHFRdEgcf6d8FLxgxc/hR8FV3O68R1o++hV5d03tuM9m8glZtM6cvnq3?=
 =?us-ascii?Q?cW6Xck/SE1lyFYTE3vd7F0tifEQ8mIa7Kyge6kA7YKGrXaNp5u6HMSsMrJ+U?=
 =?us-ascii?Q?CKP1R4E9/TSiZ9SfvDyed1n2oYPV/s5OEUGC0JFIOuW6kpEOZjsAS5mNWiL8?=
 =?us-ascii?Q?/9YyKzLqv83SnNBDeAnVH2GnK3362Ek8oHJVmTSIp3q6QwaDLkbV7m4TEJtl?=
 =?us-ascii?Q?CIrAEbbXdc7llzDUmRYk8tw3A03BKzDKqlWxlzsOc0eFy59rCI/AtnNhcJAl?=
 =?us-ascii?Q?ceVRD1EBYEjE8Wu9D+/72el6qMjFpcLTR/US3oRCAXNUppUzilftkXsrR+yl?=
 =?us-ascii?Q?E21ZvSY4Qy1Nc9XYdZlui7kZlM9Nb8hy2B6xvbIrGs6rOiBZfSTJMMPdTuf/?=
 =?us-ascii?Q?MAaNQ8amG5CbfvVkRExiXuQSKB8293J4I5omswwkCwqg3jKo2Pipv5BjBNTA?=
 =?us-ascii?Q?i8/A+4AyjTfnQXC5dq8X0wf+Vv/MQCdipp1f88PEwH9fSoStfaytgDH5k2WO?=
 =?us-ascii?Q?PoOvZaQc4vkiJpx1nnJu1WrEHqAOaJevwUPRbwMhrnAqT3ErgpPaoHW+1aly?=
 =?us-ascii?Q?bivz4jal8jd8NYEGPZMP1Pn0y1exBKE5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:36:47.6424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0223e0c-764d-4f0d-bb05-08dca01c2e62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126

Currently, it's not possible to use the IORESOURCE_STARTALIGN flag on
x86 due to the alignment being overwritten in
pcibios_allocate_dev_resources(). Make one small change in arch/x86 to
make it work on x86.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
RFC: We don't have enough info in this function to re-calculate the
     alignment value in case of IORESOURCE_STARTALIGN. Luckily our
     alignment value seems to be intact, so just don't touch it...
     Alternatively, we could call pci_reassigndev_resource_alignment()
     after the loop. Would that be preferable?
---
 arch/x86/pci/i386.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index f2f4a5d50b27..ff6e61389ec7 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -283,8 +283,11 @@ static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
 						/* We'll assign a new address later */
 						pcibios_save_fw_addr(dev,
 								idx, r->start);
-						r->end -= r->start;
-						r->start = 0;
+						if (!(r->flags &
+						      IORESOURCE_STARTALIGN)) {
+							r->end -= r->start;
+							r->start = 0;
+						}
 					}
 				}
 			}
-- 
2.45.2


