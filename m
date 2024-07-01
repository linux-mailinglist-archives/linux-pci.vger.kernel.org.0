Return-Path: <linux-pci+bounces-9520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFFB91E5B4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 18:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D630928455E
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE95B16DC3D;
	Mon,  1 Jul 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h7p96q6m"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162716DC31;
	Mon,  1 Jul 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852321; cv=fail; b=BR9tCvJ+l8d9toC0b5Z7Rq0kdq/4BlCniwWG16JZrYe5mWW22Bdm9F69i+7Ie+UqgzSPelYc8EriKM9V6smm5eT+elu9/CRKGx5o9MsOD/osVjM1ZY7Wmp07sUpR2W61YWb4txx9uUWKiv7/f7uqRvhmeb6jFOQyNPBk9/cYxBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852321; c=relaxed/simple;
	bh=VXH/KeVD59jMhmifiQWBp7H5t8Roew66xBKCsB1oeYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOzIJdUASsvhBAQbfKOJj9+DErG8cCGkLC33pCIgrNFnnwi9uDLfRgfta51YApKrX82mQ/5UwY8EjtlDpbbsdb8vwKAKOQITurQt9givNef6g2GWzxARe18RowOOG1kAujb6ZTGwdqVZUTU69/AfLmEtv7drSmwpMORZZL8Pf10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h7p96q6m; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BC5n/iwBgJxA9jaUmRR++cyKFhhSsLjc9MQAhjK83rfLUUxhR98VTzav0lLKUA4Lt7XzIo1Qpo/cpgnyZ+Ia4Pq6EBFrSVareKWtw5mvSeMbWCUOl6pzuABulgGbznZm68MTklwaxfe0yJHNhx5N1qT7AGl3+7SrD0yD3Ld/lE4nWERN4oR5avjTC1uUYnraPQ6n5fNqCnUXKbOduhv+iOK00Gl7SCQBJOHjcj4tjvU8YkCiorJ1aLtGfSwzmgNb67HTn+Ge9Uw/qdN9SLnDMIMfzCcQryU5RMbTN05r8QYnw/Q4tkp2kSUNEbCg1kq1sHB6eXWuMK9SL3Dj/1fAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsuL7zImX5SVWDHBqmPiKJL4kq2ho3RLg3yeznFzdTk=;
 b=LWFvSQFeTgjZZ7uk06ZVGYuIKtJM/vdzZg8QQG5T53CIYjMKUB56bm7ByFQbsIbQOSjsuQ105t6Dj4f6p03GfG0NhNUIeifYTfs5sAbe/FmwA3RCUX+xAVrGf++d/WEaSfnOuqpq9g/KNRV0HXPA0pQ3zw0U67ah3ADLJUI8j/Svcz8lM4ai4MeWJR5ZUCwWas8WgTXHXT4xrvnh2SzfWK8qd41mY0UkJAjvOqF4mi0kfdxD0a2nyPsquG54pEsns0lrTVSPQB1uAt8SuztUMXOJzjapPi1pC5LhxS1QrZ7VOC5YHcIoD+NQ0Q1FZM2LmRP95Xb8hP/w+T8yZAXhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsuL7zImX5SVWDHBqmPiKJL4kq2ho3RLg3yeznFzdTk=;
 b=h7p96q6mst9/8mRN5Ec3aVDH2nhWdwOby60MJhhDbzDROICGYKCrA4pxl46B/vPeILW+R7ovXe8btiqo87E0IYbVyVbc1Te8JAl4Zc1hi3trjuL8wm4BtVhl/xLMV6JXrjvSim7170RHZ/uQfwRbmQOu8PDruBs+PKHacUW6+MqgpYk9y8U5dgnBPmUzfNWvNGjOFTmEpaLRn6kqtj8n0obymdXWP08t/pV0SKnlp6veYHUHhrBeo4U8ueiFU8/f32EzJDLZcX/Yzkw8rYD9BxLeUe+PaIrqqoCKavelUoLiL0y6ZaWvZTUow63o6QexnLnaZFfOLyt8g3usxzM8ZA==
Received: from MW4PR03CA0054.namprd03.prod.outlook.com (2603:10b6:303:8e::29)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Mon, 1 Jul
 2024 16:45:14 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::98) by MW4PR03CA0054.outlook.office365.com
 (2603:10b6:303:8e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 16:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 16:45:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 09:44:48 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 09:44:44 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH net-next 3/3] mlxsw: pci: Lock configuration space of upstream bridge during reset
Date: Mon, 1 Jul 2024 18:41:55 +0200
Message-ID: <b2090f454fbde67d47c6204e0c127a07fdeb8ca1.1719849427.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719849427.git.petrm@nvidia.com>
References: <cover.1719849427.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: ba682a5f-c9ef-4b06-35a1-08dc99ed2e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a7J3gfaOvoN81ry7IQs2N5TSSLk/XQrHdS52vJ6BjQXElQ1m3Xs0YeQnyqQ4?=
 =?us-ascii?Q?YIkC4fvNfOkAffnrubRF98GBooz+utP3UEI5ctZzfGOMXwhbRhH4YSzchPSu?=
 =?us-ascii?Q?CHnYT0EcwMkfgVE0bfJydBZkiccWdVdRw2eJElecE9zDLtHlgHS1LdJI+uy3?=
 =?us-ascii?Q?8qzKv+2NkGeEQ2ex+UC2J2kI1S8ONYpbrFjKQ6kwRXMJF2Al6hRSHNV8IXvH?=
 =?us-ascii?Q?60kI9dWH0sydLhGtTYdIF9MlssuvfAptzUQ1Pc9xSkH3APDXjRcuEdGXKTjH?=
 =?us-ascii?Q?K8qGNzfLXg1A4KasSvQIMfnNCVPx/b4d6vtt+CLsQuuqow5dWl4a8mZFuUKS?=
 =?us-ascii?Q?NfUOeybYyqeF9XKwiNujh89HjdTsfbOAcFUrabLLdJ16tANkMPGzWcnyb6Fv?=
 =?us-ascii?Q?ge7gvhlMZfCN0Ymh8wTb57UhFCJGKwX3tOGqBXFhZzApRromFj2o121QXH+I?=
 =?us-ascii?Q?2RgqIDaN3BJs2quFXYPLOTR85iZRaj7KYKeaqJEl8feiQf7RkeWZ16LMZK99?=
 =?us-ascii?Q?ZbDCfZiNFITMrDEjW9kakPk7KuUHkEVaYc95fjQvYfYAXZALJ2/5julOJDt/?=
 =?us-ascii?Q?oO5YxfMP0EqRzlrA8QHh0llzdbdhwfhDKy7kA0VNWKITfM8n9/SB0ZRM3lck?=
 =?us-ascii?Q?eAhCHwxdRNvIGt9E4H+Ia5e4xux/LwIAKKvCnx8VUAmCcS9DWU2UrZXMjU5R?=
 =?us-ascii?Q?5eRBXh19rbQqXuEbNh8lYirVzxZoL9eEfqG7g2ewWjr36/UVhQzTnDsm/k29?=
 =?us-ascii?Q?mkB5hQf05ZX628fhyIqV5qYiks6j+277IdEAYJIDfeuGP4PGYu4l6qLawfrX?=
 =?us-ascii?Q?ttjJoIv1nLqz85B0BxkPA4GT46hqyhbDFVUyo+UTw7vU4DUJkefBhJ4s2m4w?=
 =?us-ascii?Q?ZwzKaOLj/CtT342DSEtqhsOUFS59UUdxuwBAzWYi6pA6l1b5QJoGBpO1PBEU?=
 =?us-ascii?Q?6SArf18tn3qsmAtQeU3btKZWmAYc53K/kCSdVPxiPlE8M+xkMvYYEGxd+qzg?=
 =?us-ascii?Q?qv/byRwQKNmF3dnBB4+SlFLqgjSHePZaFmK+9r0T5sX6djS0BIFdtryCDwjr?=
 =?us-ascii?Q?yocY226Z8Dwf3jbD7QOF5cz6eyT4AjpeNAgWM/74IeW3jCZF3LrV1CwnpVJ8?=
 =?us-ascii?Q?sLCUeGZ8/W3E6nyErf63xegl+96ZvFU4obmiiaKMb+0W9JhzpG1pmezt7WdY?=
 =?us-ascii?Q?bP5yRKRLwBi3n+9G2biv82bwD8IuyE7KmBDgXbjjCy1FZQXr+SV8fLqOKC/2?=
 =?us-ascii?Q?MYWUzEZGKs8yBFWbUAr9hxu1wuwPQ+UXQFLTEWgvNFbX0b1dE3gZj3rvR/mF?=
 =?us-ascii?Q?N2KHfaJycG0StxdvDi4RipeHE6w+oJbpOyMuzHi8+Hb+bc74USH5rPRi2I7c?=
 =?us-ascii?Q?NTxrbe83A77YnqqzoLDRK39nfo4mCXlZIMClqzyFgCABHuZiV6M6LMvYQNfy?=
 =?us-ascii?Q?3qC16AyYDcE8taPcER/DzTEE0v0VUm6uaZV38kwrWtlkTqK5b2j0ZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:45:14.0070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba682a5f-c9ef-4b06-35a1-08dc99ed2e3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496

From: Ido Schimmel <idosch@nvidia.com>

The driver triggers a "Secondary Bus Reset" (SBR) by calling
__pci_reset_function_locked() which asserts the SBR bit in the "Bridge
Control Register" in the configuration space of the upstream bridge for
2ms. This is done without locking the configuration space of the
upstream bridge port, allowing user space to access it concurrently.

Linux 6.11 will start warning about such unlocked resets [1][2]:

pcieport 0000:00:01.0: unlocked secondary bus reset via: pci_reset_bus_function+0x51c/0x6a0

Avoid the warning by locking the configuration space of the upstream
bridge prior to the reset and unlocking it afterwards.

[1] https://lore.kernel.org/all/171711746953.1628941.4692125082286867825.stgit@dwillia2-xfh.jf.intel.com/
[2] https://lore.kernel.org/all/20240531213150.GA610983@bhelgaas/

Cc: linux-pci@vger.kernel.org
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
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


