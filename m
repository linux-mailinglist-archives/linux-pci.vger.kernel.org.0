Return-Path: <linux-pci+bounces-10393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF3193320B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12441C20AD6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 19:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44681CD2C;
	Tue, 16 Jul 2024 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2n6OCWqB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B34B1A01BF;
	Tue, 16 Jul 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158443; cv=fail; b=AaqDGTebjb2wR5QOpP6FB3ibwJK560AgPfeuLY2vV+aDF4+pyc4EoouaaosqhHHyGVLAqq5otYha/eqOy6kOZoLefP/D73AqpYxwYRqRN5gbzll3TTK+kjrmMq6d5u4ssg+SwVdbAVOU0yFjJsuXFRjKIKo0Oz6dwBywf7PAVL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158443; c=relaxed/simple;
	bh=Lol+t45pncGBscKOp8l89pe71lSJrpqq3ZpYdENqlP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCa2rOp4vU27LA0z8BLjqC8kxlNKKo2EBRaLd4H68ZdbD+NYcRuUlQtpwxbJHuoqU7FxdyCDTJU2Nfp52m+GrBjz15Jgqbu3WgzKlPeRHsjy7BKoOwDbPh5ueKZVfDAhwVriKZHhPLVyiWZd+d27Ii/uwNq0nmQq1xdY5fUlOJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2n6OCWqB; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSS7QrnmLSn/bSOxqxsPSCfhCiRkbiTXkii02YS3KA9CcUXo2pmqrb4ZJ59ASkERJdaZRIXeGFNO0WH9FsZDE/X6qzrVWfxEqz5D6OdVfq1/E1iPGhbiNQ25u4KFx/1zYS5Lte8JOkX089y+lW3Kz5OvlNrsLRxUiQIUAyL2P9N0pE+M8qUhX1fCcQieF8NpVV+/E1MQAbAm4whf4RLW2PvvWEncg1mLFnxI/tt9GG4GkDdbtJaQRxRQCfkuWQtmEyjHpELlKx9HoeftOmmoD44qnxkD+kprt3q8RdE3dfqKrtAdwbhVKv0qgwV9CxCBolc6NG6obaUs9bRlMe5mqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHZ8rE7ZuzLlPkM9bugQIILHFC2fzewUG1nE8V0cQa8=;
 b=MpqtXDMkxW2y0cqicvRubRhDwLbBupXv9S2zoBwr/VCdvj1fCyOibG8Ixy6uuf/mhr7EWJUUtMEaE0GlTpliRkzUQaZq7vHEcJzc+PUHcwBGKDFEu8PSmgHiH4RRFS7wuJrIN6TuIpPN6+0BKxXs9hiWzC9OP1CeamGPtHFXw54fIncWNEjeNVwUjsKfzApzqFnBBrqUDWxSN/dVuNLgyy1N7v5u/vdu7eKSRa/gf0h8V3hcQ6hpf2l6fVYXMdHo4X+bM8Z4O42E6HDF3QY2EVpX8h9tyVBNrRV96nzHkDtgZZrE2+tGST71hbsPaqsiI0j5QgE+IBMLpYDNCnZrpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHZ8rE7ZuzLlPkM9bugQIILHFC2fzewUG1nE8V0cQa8=;
 b=2n6OCWqBVyTBYKOcwPAGL0qmSZpwTKH0xuNcSrr1i8KYXrTw6+WbUM/nsWEArQru2+xSknoGeA5fHquxixe8q9XHCVv5i9ffUXteBKEzdogVEd25u5WSyzwVxhiMbiIyFNvmV83+hTiP5/z6xw+a5RYWAPCjrHTsfJwsWclGRcw=
Received: from BL0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:91::19)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 19:33:59 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::13) by BL0PR05CA0009.outlook.office365.com
 (2603:10b6:208:91::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Tue, 16 Jul 2024 19:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 19:33:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 14:33:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 14:33:57 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Jul 2024 14:33:56 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>, <x86@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/8] x86/PCI: Move some logic to new function
Date: Tue, 16 Jul 2024 15:32:31 -0400
Message-ID: <20240716193246.1909697-2-stewart.hildebrand@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e5af91-334f-4aa6-9618-08dca5ce3d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KeWIxDpZnLzKsYQSjkQYwIrQpcUI9UUkrY/pFINauygLzt6lnWwBPMU37BBA?=
 =?us-ascii?Q?unSbb5KGpyoeH85NUrY/QVzR4GarQ7VljTZwdU8uwe4O2QL66I4iTFNUgw26?=
 =?us-ascii?Q?/3kMQKKYsmG+AAOuvkqPnPMFCsE2LlfBq1sRtIO7+FW9fGqAe/e9+2DQD4AK?=
 =?us-ascii?Q?CRJb+SX59Rs7kJeAcBrPi2znYL/2+xjo9UKjaqRKJ/BfgkxGxAco1f5SKnt0?=
 =?us-ascii?Q?lvsWBCwaa8uz9Ar5Ltni/cFIjxbvuAevUJahDRrT9mXRIEqn0RInFnwcQk2y?=
 =?us-ascii?Q?gS19zL5BWhTdA6kROg/v02kbukt1PNckWi0zy06dxpLnxflfVXqoK6lZ/pxi?=
 =?us-ascii?Q?TUexlO4cVhehEJbEE77FE+0hcxAmDqd+MIWjyj2DRJrz1UlGv2d7Ptk3OXZG?=
 =?us-ascii?Q?m/jjQzYeKpFzgjYFFiU/96cVh4cLZ7LtbmgNoquftJxQqIVZCDeHEnbfiOZK?=
 =?us-ascii?Q?FFizqa3A0I15nxORyJjbOByT3qtor1I55LmwnLYfyRqQgF6jhHXngX1xgUW7?=
 =?us-ascii?Q?bgC4do/7v1dJUz1y8h+vgh7SdLZpBR7hUKAePjw5Bvi2JfRroP2bMDFqiKRu?=
 =?us-ascii?Q?CxFyWj/bxiYmprVD3XbaSvITrTPmSpR7jV1aEUVsriTJZZHzoh3iTOQayLUe?=
 =?us-ascii?Q?JR9p4fht5cq+7FioAT+suENciPhgOShf8oyhx1AKJvr1iBBV3dDTaiJ680N4?=
 =?us-ascii?Q?sdlFPF1yIc3q7IvyQO6YzQVRDQw6Lza3zAuhjtkbgHNFBSLaemhlyQkJZTHi?=
 =?us-ascii?Q?3qkjkPUiUi61fenDLt6hB4KaphZmMf8SjmuTAcU90Lz36Lmtu6k2/b8k7oXb?=
 =?us-ascii?Q?IJgAzAllfpBDfswXJ9waN6HO3qSoSk+Pknnuj4nmP/KXm8MparkmYjVCdsKx?=
 =?us-ascii?Q?6pfAhR/CJdTlAKpOwTzakdvClbB9AVrL3F1lMT4KkX20TbNjuLrZYc34wMG9?=
 =?us-ascii?Q?aMEmpzhuyEionSlWxcPHibj+JsB0RFG9ztTVnuG+Vpiin02mDGtmVtU0jlJt?=
 =?us-ascii?Q?c9mRParL/gxNuZmfG/WA28pMbY92tXZvZreHecOrtuI3+kcOpD1BUj4rVHU+?=
 =?us-ascii?Q?lpdhsza6jq4jlMQa28x1k2qX23DKWscb4BBqHD5YGIkpLruPddJpccKPu4hD?=
 =?us-ascii?Q?f8oNZ5qLc90Zk9hBi5TgbTkhGuhyibCddkMC4O9JrGJznwcpaKrJSFc4KXmy?=
 =?us-ascii?Q?Ltex46ji2c2OIdPH28uyKgOKjUgWZoowbKSbzK2QYPn7wF9gQe5cQEuQXQ4m?=
 =?us-ascii?Q?XI4qwbjgYre8ev/xN+292fMpnQak1K/hZ78FNCNhONleByHdma9chk/gwCLS?=
 =?us-ascii?Q?yHaKYP6d3lo5r++/9icsgOMxQ8xA/vcHj6wsb2fzQ62kqpgZJ/NdHYXXtRrS?=
 =?us-ascii?Q?MsR8zCsHCqr1UFBO9GoMC/EuNNgv55GjgZy+XFZy0OBl+RsoTAHxiRqqFDaf?=
 =?us-ascii?Q?5b/+V8mFapogm4I3Y1KK5kwGMRYkFt07?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:33:58.5264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e5af91-334f-4aa6-9618-08dca5ce3d0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895

... to reduce indentation level. Take the opportunity to remove
redundant info from debug print string.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
v1->v2:
* new patch
---
 arch/x86/pci/i386.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index f2f4a5d50b27..3abd55902dbc 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -246,6 +246,25 @@ struct pci_check_idx_range {
 	int end;
 };
 
+static void alloc_resource(struct pci_dev *dev, int idx, int pass)
+{
+	struct resource *r = &dev->resource[idx];
+
+	dev_dbg(&dev->dev, "BAR %d: reserving %pr (p=%d)\n", idx, r, pass);
+
+	if (pci_claim_resource(dev, idx) < 0) {
+		if (r->flags & IORESOURCE_PCI_FIXED) {
+			dev_info(&dev->dev, "BAR %d %pR is immovable\n",
+				 idx, r);
+		} else {
+			/* We'll assign a new address later */
+			pcibios_save_fw_addr(dev, idx, r->start);
+			r->end -= r->start;
+			r->start = 0;
+		}
+	}
+}
+
 static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
 {
 	int idx, disabled, i;
@@ -271,23 +290,8 @@ static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
 				disabled = !(command & PCI_COMMAND_IO);
 			else
 				disabled = !(command & PCI_COMMAND_MEMORY);
-			if (pass == disabled) {
-				dev_dbg(&dev->dev,
-					"BAR %d: reserving %pr (d=%d, p=%d)\n",
-					idx, r, disabled, pass);
-				if (pci_claim_resource(dev, idx) < 0) {
-					if (r->flags & IORESOURCE_PCI_FIXED) {
-						dev_info(&dev->dev, "BAR %d %pR is immovable\n",
-							 idx, r);
-					} else {
-						/* We'll assign a new address later */
-						pcibios_save_fw_addr(dev,
-								idx, r->start);
-						r->end -= r->start;
-						r->start = 0;
-					}
-				}
-			}
+			if (pass == disabled)
+				alloc_resource(dev, idx, pass);
 		}
 	if (!pass) {
 		r = &dev->resource[PCI_ROM_RESOURCE];
-- 
2.45.2


