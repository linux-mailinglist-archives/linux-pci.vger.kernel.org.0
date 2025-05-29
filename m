Return-Path: <linux-pci+bounces-28677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CC1AC7FF3
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 17:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DCE189A861
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A5922B8B8;
	Thu, 29 May 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W0DJnHvB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC41CCEE0
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748530842; cv=fail; b=sF4dPigMqQGO5sQ5uzLaZyZ8wGFVw2UJlESEB+oTIJnxLdUxlKb8yviU9VV03CfHxdsp54MF1EGH7KUCB8t/PFCjCpTVgzFzW53jr9zSLxj87FwEh8vTN37YaEssOlw+XqtWJj7535hsH0rxbPjxL7HtwzzPxeRy02GDEOp95Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748530842; c=relaxed/simple;
	bh=wXVgMavoW8oqhw0N0n2r0vXva22IdoGmFWxG8FuiTD0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dgj8ygSIdiTyFUfW6SlVDM+R6WGdTxcoN5Db6jhDVbFiRPpmZ7gYFloUhpJUfpifoLLufMiqJzWWV0VvdvTuEzWzYox8FWSrUdRrXCzPtRl8dsZKUvNUCJ2y8dZRJKOa4SFg57CtX5hLOQxhcycETdUntrq/cuHag+Tcvd6RqI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W0DJnHvB; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CR3CHtMeuhN1m4yg4ruLpTwJtJxgq5eclMQFOF3l/VstEagAlAabAeMzMLr61VflYGLU9TcnFCEhPPT8LnSTXQ2+WX27QKi6dBE19rSPnz511+cIKY6sINJ37Iz17nROYr0YnvY6+W/DPHvDBXhvYjtw/D4ns+z47gaaVJbDcrWosEsiyMICnae3XWo2VildiTSbLLA5yuAu4f5eMOaFSR0OKronu9ftG9Pp9H5zHLLdotdTJFkIa4Vvolx4xS9VtgGADdTDjSBDQTnxnWoYvDPXl3cTPKw6L5pIUKzeAPOXCRJwUN5BYu6D1h/Az4C7z/i7pllGOanEdNJ6g3RqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAvfSmjGidT97230lssYqG+1EmYsfRLUskC7OTx/zBs=;
 b=jwDw4QAZLAy/5T/Kc9Q8Jidfgyt+dwcXTAw+/wp3YNhA05iKU2hC2Gp1NrkoNM6wlLdf2MTp51mdxHXVoxoppJMkg3BZix1SYFX+4/XzTsxl3aba8GxaaCbhEOHErAYUGr/GBAUV2qtszDkGFkq9barBTOPMdJye6kiyDhols34wxOPffllYMN4nsHYGivcsit0bRfnXY+sLYV6jnp9+FszNnneV291V7KE66e4M3HSrShROEyZ/BGGLIZoF+LwKTXnQoyqyXCmY5TsZVQy8t6ny2a3p7x/2PQaiNOK9jG55rOOVJKUtdMMcllGKNNa4Ls05u5u2DBkQiqUWmE9kFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAvfSmjGidT97230lssYqG+1EmYsfRLUskC7OTx/zBs=;
 b=W0DJnHvBx+KoWLuZemv54p6GohyGg/aPyKPgxqPVbmSnqRfhVcsEfaU9IqG9FnHo5kLGDTB8EHpUT3+OkjquNJgvkbOXNzURePw3hU4svvOJJkLB4WVH6u55XDY1VRZTz/fLhP5TIK/4Nkm5JprhPuCeETcHYkQalg9Rli4KJOHe7FKUM4zA2uELcmJ45GAIpj+U5YauBNzxclyhRJZFr3nBwq9xv1sU1bEuuEafE4v5TqwJhQYvPwGFqEvAPUbF81EBJ+tyVN/RLeq2S/4cPkK7QLV8C+QpSPruyOjnfj+xl0pnionn+FR0EWCFnqUY9uGgoz73tmG59ZBWzb7zGA==
Received: from BN0PR04CA0203.namprd04.prod.outlook.com (2603:10b6:408:e9::28)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 15:00:37 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::85) by BN0PR04CA0203.outlook.office365.com
 (2603:10b6:408:e9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Thu,
 29 May 2025 15:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 15:00:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 May
 2025 08:00:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 29 May 2025 08:00:10 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 29 May 2025 08:00:09 -0700
From: Moshe Shemesh <moshe@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Keith Busch
	<kbusch@kernel.org>, <linux-pci@vger.kernel.org>
CC: Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH] PCI: Add missing bridge lock in pci_slot_lock()
Date: Thu, 29 May 2025 17:59:42 +0300
Message-ID: <1748530782-3332079-1-git-send-email-moshe@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: ea712c50-74ee-42f7-814d-08dd9ec19205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fOYqJWnFn2RzmMhYTHMFVxZWkb3PSp15B4HjxWQ7ZzNpD2bIdUkaF+GxxjuU?=
 =?us-ascii?Q?TWi2HVce7qGcHPcdoJdRwBXijVgis+TRkX5300SmW2qz4BRU6gFl9WVzoVuv?=
 =?us-ascii?Q?3x7ZUObHfQRtHv1iCg5AFlAqNPqqVPJgUQichC+vdN+ZiNMWpyy18XxU5m5l?=
 =?us-ascii?Q?5Ak43FSveQjyfkN0clhhMfASHyTzOdljYyKE9Td+s4u1CqAvV61TWvTSsn28?=
 =?us-ascii?Q?3tzBm6s0kCy0tUoJFtBZVA4yRPmQirHa7K68NcHip+mvjte+c57xIgUQRRvn?=
 =?us-ascii?Q?Cwpv1NFRxFIwzA1kWWn3446l0eY0Qn8KT1SjfF0FbQUEft787/PQERUje+HY?=
 =?us-ascii?Q?Ktw3H7Zh/slafUhIq/lPEDuBShcDnH54rgr8vBlT8s1TZ3ZP6JwIUnCSJIbq?=
 =?us-ascii?Q?AhoWl8qGnA74BMxTtl1G2h1IsBoo1diln+R50Suqg2BPGW25Jt1ugB+4s05i?=
 =?us-ascii?Q?p85S25FVw1Y43FElw4BUrKgcumzgOWZ5yImHUIhssXXuUBKFRJYWfx5bVn7O?=
 =?us-ascii?Q?RPrFHavXR6Si/Is8itJWKmwnhY/BZMlCFcWpFn+986ngIRxOISnITeA0RCqr?=
 =?us-ascii?Q?E0JYhimLSCkLRjPMECFreN5MLDMweHvKuunueJlEdJ6rOxLtDC1F85SUddU3?=
 =?us-ascii?Q?exupVkIWaOcnPRkWdQkT9brMWNH9tSQ/BcohgZYu2mj6FFZ5F5Q4KLCmzDnY?=
 =?us-ascii?Q?V0eOUxHcECWARCNeCYfrcOVAid60t8U7kBphYqd8W2PlonXhWRo7l8BwV0qi?=
 =?us-ascii?Q?45vcPg5kHpJxJ0LvVm4HQ3q2E6XyreeCb8TgSXPRoWEBzeFhvKE8J/7k2a6G?=
 =?us-ascii?Q?Ivc+m40QBJ3amsEJtsyrMSnyPY8oD6vb+lCWY5VYuS5/QHPpxZjuRozwijM1?=
 =?us-ascii?Q?pzknppxWM7Ddyt9mWKrsd9TTgtnCmMXqhJXc1D4cPa7L72nBAF46cf9+Y5n1?=
 =?us-ascii?Q?sSUVwQiNCc41rQmr1AatFAWPR7d1QSO9V86sfu1/7MhmvSwlgH6Il5hU/bQl?=
 =?us-ascii?Q?jkbD2uMxrzAB3czSOORHONQCc6ULR8IjZVliWEICZ9UB9a3EiHH+unqT7p4K?=
 =?us-ascii?Q?lQAhldXCpBt5kF8nMdy4BZknbgn3azUluQPwoKlcMY5f7BLnFi2tiU04jMdp?=
 =?us-ascii?Q?GS+wWhorGgY+xtA990ejvuhV1tCvaWuV9wqHtkYhF4ynRhKfgm/zFOW4AzFa?=
 =?us-ascii?Q?u4SPlITEVknDmJU1p7K1irOWJkUXukD5LsR0k/2aOLjL7Qh/utqMkW+T0QEY?=
 =?us-ascii?Q?M8k1GA+7ulSxc0xw0Gab2rzLWWfgtXnXGybrtCsIId9ZrfFlf0+hcB0ZG1iN?=
 =?us-ascii?Q?CQ74rPAVigeVQ2P9/4PZJRny8ITE3GjUSfuZTykBAhst3wq8zNAG5DrRlJTX?=
 =?us-ascii?Q?RF5m6W974rBvHpdBoR1CvmECxktAgL1C2sQen5u4SRFyohWn7Oo3ESyyOgbc?=
 =?us-ascii?Q?oYkrZ9cdBhxNV/NFjc464LMG+B1SU3ZNRUW8YIKQgwcZPq0qoMcq/SdivKc/?=
 =?us-ascii?Q?LYzgvMU7omeNUqavPXVfjAmzEgsMgyWaTKm8?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 15:00:37.0201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea712c50-74ee-42f7-814d-08dd9ec19205
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959

Unlike pci_bus_lock(), which acquires the lock on the bus bridge before
locking devices and subordinate buses, pci_slot_lock() currently miss
locking the bridge. This may result in triggering warning on
pci_bridge_secondary_bus_reset() [1].

Fix it by adding bridge lock on pci_slot_lock() and pci_slot_trylock().

[1]
pcieport 0000:c1:05.0: unlocked secondary bus reset via: pciehp_reset_slot+0xa4/0x150

Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
---
 drivers/pci/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e77d5b53c0ce..c31929482122 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5518,6 +5518,7 @@ static void pci_slot_lock(struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
+	pci_dev_lock(slot->bus->self);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
@@ -5540,6 +5541,7 @@ static void pci_slot_unlock(struct pci_slot *slot)
 			pci_bus_unlock(dev->subordinate);
 		pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(slot->bus->self);
 }
 
 /* Return 1 on successful lock, 0 on contention */
@@ -5547,6 +5549,9 @@ static int pci_slot_trylock(struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
+	if (!pci_dev_trylock(slot->bus->self))
+		return 0;
+
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
@@ -5570,6 +5575,7 @@ static int pci_slot_trylock(struct pci_slot *slot)
 		else
 			pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(slot->bus->self);
 	return 0;
 }
 
-- 
2.34.1


