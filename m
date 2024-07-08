Return-Path: <linux-pci+bounces-9930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE6192A49B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 16:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061F01F21FEB
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055D613D8A2;
	Mon,  8 Jul 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jqqPs3TD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B113C667;
	Mon,  8 Jul 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448813; cv=fail; b=cCcX+2G3c0TZAXyxg+tEFSEnDiCCVAGq8b/j3Va7jJ9SYiAIpZysJkjRhwrSJvy8PoURpae8nZ2Z8qFqXZERbdjzVDWFZx+EgTKEuBmf0XTTAudGnBN8o6B7lZ/s6XUdzUGFzq0XFJjC25D7+aI3O5GoHKPAjCEWolMhCNkh+Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448813; c=relaxed/simple;
	bh=KX28DEDILzWnnfwqBHPItKkJVz35IYJqmr5HQEu//FY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqDySeZfBnEe2ePM7hrnk5GbQwWvwuulqE4K35Rz3dX+w8YtvC3XRm8K2tmGYD6qJ4q6X3FZPdB4F0+0szx9IXGMIQmDyZkrEaRav2q0IBhTPZNxI5NlJRamqM/FAS9PfpsLF8wsuZToDGXMlPniae863lht49LpPk8KLF4PoWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jqqPs3TD; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYqP+wIDLl4ybZK7Pa/xwOQpSDpsDad7wfWcea6bbmzfeVCuAvT2IAnRhPqp1WRwh30eXE+olFtWWzyhcLJMA4OYkN+tDceC2wh+j22TBAMsv3mRw6zlctbVTN2oAVCmmjHAX4k+hhckrza8GwM8XVrk3vjnuNog05XK1yC+d+6kr+tPIKT5/jOAj3vNYkJ3IpmDltI1NVgqJXSi6rHYNScEje1WXo+PVJ6cMBVRDlXHvauTvP7piYh4PSc3DwE4UDQQ+0pb8d5nB8sjB2Rnjsq+XUYu5/0RlFlZAA+rxGuX1zQZ1sswgZdByTN/ZOj3cHz3W+L5Q/08QtkTSsl4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OEH92MjfxuhwHQODLUjtsLea5pyUD0sfINcSsPya+I=;
 b=LwnD1CGUZ8bhJsQbVHFxDie3WrEMRBHyHm3QAsVeOcwfQCLxW6fp0+dSd6De7cSVVXiLUMIBtzPAv2lSzxcRF+yrPn0PkDZi+Fnxn63e29stwce6JyXA2xUogQzuyhLPOCFLpc6rhntamX+CrGuDaOjo6VB5ZzZDy/B7jnCGKmoyMN9yZ4+U9g9G5Hw1uOCENkXIjzfJ95IqPqwng6A6BtpPYKcFjTsYYP8/xWfKJSSL98V2zQsZWVwOIqQ05aai+Pa8R7Ag97H2J6GlmLpKxBiul+b8080DhJgB1QcglArOg1in82e9EhYlIUUb/43NMNfU7IV6Z5xBOf4Iw9kYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OEH92MjfxuhwHQODLUjtsLea5pyUD0sfINcSsPya+I=;
 b=jqqPs3TDX72LTmcczDopn4LJnevwFZp4h9bz+9jpZwGvGCHnpU4ThCnTY+YoDhgFw5gJmMLRpe2CrbqHUsd6Tz9f11WupBGc2fzfTNPOAVJ8eJhbhSi9ZyuGEiMOiesl4QPvNFbiXti8qyLFJO5D+EotLDmY4oAhyMG9OZk10dm7yq2jz1JB1QurCMDXwUH9zbwfksbE30/mP4GnwamljXFCBKvc9TwveIHohuu0hOTi/JjtiqdnEQqb40QuE3V2eDtA6ZGaCAotawMeNthvO3rpT/N4gAGIkRvN9cTwrOO9S2a0iI4KwaMJQ9jCHOCCl5Rqu88DUwidLoCLIswaug==
Received: from BN9PR03CA0786.namprd03.prod.outlook.com (2603:10b6:408:13f::11)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:26:48 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::ed) by BN9PR03CA0786.outlook.office365.com
 (2603:10b6:408:13f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 14:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 14:26:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 07:26:31 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 07:26:27 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH net-next v2 3/3] mlxsw: pci: Lock configuration space of upstream bridge during reset
Date: Mon, 8 Jul 2024 16:23:42 +0200
Message-ID: <9937b0afdb50f2f2825945393c94c093c04a5897.1720447210.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720447210.git.petrm@nvidia.com>
References: <cover.1720447210.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: b90634eb-505e-4f7c-be41-08dc9f5a00a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mHqvjKLvBBPc20BG532m36owGXgxnIHrPdee3jfAr5lGeh3++XW+Klxyl3e8?=
 =?us-ascii?Q?6n9UTGtOwTV57vufKbTT15he8caYqk/Fz54SGAzE0wcdLK66ktERo/eA2aQ1?=
 =?us-ascii?Q?XulmSsXCIg9c9aTIeonGhaND9nb7ouFK54LsnGdEX7BI8lBElBBH3FaR5z8a?=
 =?us-ascii?Q?+rk98efldsRVvm6gh4P3BIyJZTJtB5BNk5Tv58xxL0meIn7whVs9vWIuj0NH?=
 =?us-ascii?Q?Ko72FjSaq9vWPuZNg4ST94yFDS89I3U9ECwF8Xdcr7e1LYAILMUKfJZsYrEl?=
 =?us-ascii?Q?4nlYkYXCXAX61Eb3RDepJAYIWm/eWyC5Xe80IecFk/3hF66m9pOdJKOBO+jf?=
 =?us-ascii?Q?Tn37BStv8kjlSj4LxRpcJbxe20RnXQAQNIaFazuim7KaEGUg8PuolG/AioC3?=
 =?us-ascii?Q?bh1jq7EYD+ixO6JLbk7BFuCmx3t0FIoNeKTfd5c5sFv+VEVr1BjmjNm8KnfC?=
 =?us-ascii?Q?5/eEUd/qI8aGnrDW7fQ/ZweD2RZ/HwvYL0a+2tbj9hVXmPrIXM6Ejf39mDRA?=
 =?us-ascii?Q?Zrg+rG9ClBSglWRLx21Fr0JRa/gAOlD36G8VkNNlNUpnauPKcMdi68f9LKbv?=
 =?us-ascii?Q?6LddIeDKeUBCPDVHXqnJuXJvit7bI6zL7rbZau0IHEycPOMA70qZJJdwdk2a?=
 =?us-ascii?Q?OGSoJNuBRIVBdU4vXxCQjdfB2Uh8Ui0pWdfwwjgLF5y7LxkMU0u3p1yu8oPO?=
 =?us-ascii?Q?3UmnYTR8wXbCYb5P973f00NepW+Nlbuv+BlfDizOP09TQ64SGO4mczxqSlqy?=
 =?us-ascii?Q?l3mMdoVkmYMGlGVGBLMRRWXWdOPQC79qK5JeyX5qZLMBxLY9rsDPvd20J+qq?=
 =?us-ascii?Q?UGry4n4hUcRn73aHU+Cp+y36JPNA5ikMfaIhM1aKFBGZ02aOZ3tH6h2v+Nm9?=
 =?us-ascii?Q?0ENzOgI24MXbww572WpzMX8KG792cV9QmOS/j22xSrNEUY+7NgTmWmDb6Lew?=
 =?us-ascii?Q?+MG866JNoqX0pJcv5J/WvqtiLzqBo2bsXzYA65oqe7ZbN479QYfp8/gG2GYv?=
 =?us-ascii?Q?0NV4IJo2or9vY7A0rDqqyi6r33eNt/5OjLLm7F6TMJ2mfLzXvYP61JOT/rs/?=
 =?us-ascii?Q?se86bzMaZubg9sgT+/IFta+98ypAozpN/Lff7Ia0K6qwH+CK39WqB1mc0jjj?=
 =?us-ascii?Q?RxONZDVLTWmiSxqcT0NaHiLAXwonmfnEz9D9AyNMOZfMqlyc4DHCj3yeevQn?=
 =?us-ascii?Q?HVK9FVb8Vwe0MOVlFggLtmTXfrINZUOQ2iAcKMJF+9Uu45AteGyuEq1bnRsD?=
 =?us-ascii?Q?wrsFqaekgAO1qkLkRBDEOc1pqocGfM1E5pBVUvTwTEgCEKIQzJD6gG2puwvP?=
 =?us-ascii?Q?pMTCaDOo6gMazjlLVl4Piyhu2aIM515uXiXKnzCKWCBr1RmoLH+txU16n+QZ?=
 =?us-ascii?Q?AT1HLivur3/FhsX2jcGmXYQ4MNAw+RqbsdHKr5oH1cPz32Iczo6xmwQxIQ27?=
 =?us-ascii?Q?OPyD85D8J2r4ixfDcBomTDWYIM/mEukj1qNuh6AfqlFCKa10DUtHKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:26:48.4300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b90634eb-505e-4f7c-be41-08dc9f5a00a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

From: Ido Schimmel <idosch@nvidia.com>

The driver triggers a "Secondary Bus Reset" (SBR) by calling
__pci_reset_function_locked() which asserts the SBR bit in the "Bridge
Control Register" in the configuration space of the upstream bridge for
2ms. This is done without locking the configuration space of the
upstream bridge port, allowing user space to access it concurrently.

Linux 6.11 will start warning about such unlocked resets [1][2]:

pcieport 0000:00:01.0: unlocked secondary bus reset via: pci_reset_bus_function+0x51c/0x6a0

Avoid the warning and the concurrent access by locking the configuration
space of the upstream bridge prior to the reset and unlocking it
afterwards.

[1] https://lore.kernel.org/all/171711746953.1628941.4692125082286867825.stgit@dwillia2-xfh.jf.intel.com/
[2] https://lore.kernel.org/all/20240531213150.GA610983@bhelgaas/

Cc: linux-pci@vger.kernel.org
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - reword the commit message to reflect the fact that the change both
      suppresses a warning and avoid concurrent access

 drivers/net/ethernet/mellanox/mlxsw/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 0320dabd1380..060e5b939211 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1784,6 +1784,7 @@ static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci,
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
 	char mrsr_pl[MLXSW_REG_MRSR_LEN];
+	struct pci_dev *bridge;
 	int err;
 
 	if (!pci_reset_sbr_supported) {
@@ -1800,6 +1801,9 @@ static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci,
 sbr:
 	device_lock_assert(&pdev->dev);
 
+	bridge = pci_upstream_bridge(pdev);
+	if (bridge)
+		pci_cfg_access_lock(bridge);
 	pci_cfg_access_lock(pdev);
 	pci_save_state(pdev);
 
@@ -1809,6 +1813,8 @@ static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci,
 
 	pci_restore_state(pdev);
 	pci_cfg_access_unlock(pdev);
+	if (bridge)
+		pci_cfg_access_unlock(bridge);
 
 	return err;
 }
-- 
2.45.0


