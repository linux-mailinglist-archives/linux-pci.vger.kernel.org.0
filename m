Return-Path: <linux-pci+bounces-21557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB19A37290
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 09:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8161889079
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 08:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B122152196;
	Sun, 16 Feb 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KlsuNfZ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB04366;
	Sun, 16 Feb 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739694820; cv=fail; b=AHqEz84bEEb5ejrAFOP5xGaxdgXeZF0jn7A/CnldoJwY1UPYtVSlgc1RiuVfk+b2o/0ycKatpcM0PwfeMkjG7+xNwG9QogjYNE2fljbTxCAQs54PGZ30aPWNRWjcvi65IGKv6nrKqpI/81ZdCZB1ik/MHanOiZ/olbPUhI8Zu/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739694820; c=relaxed/simple;
	bh=WQtj71kvxocI2eEwkHuTnYDDGrQMzEx3jBPkCyvIwJA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pphZXL16f8/z1WmjEskkH5VnyXs4umt+S8aOLMmqsiA8fvUKWHCR/XLrXq0iZ1uwrSdNeL5z/B6fMyWmuErJzsFpU84ppdcvGzce9qfOF9DE+3Noh64PR8zRdLQH4qv0ci0gRA6nEhP1QAtpASkokl1kqgUxqaMtpOQ8Evyan1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KlsuNfZ5; arc=fail smtp.client-ip=40.107.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cx4SfzXMtKiJlFyklICVEY5p8PfknZQ+I/aO4fLN8WvpUEzQAFpJlhrWyWLtcc1Z+B0UXLCttsP0bvgvIcAZo1p+YyusQWbBzhoIagJly4CpYdqrtX2XiOleNx5LZD0XtXeHZfcBIrW/C5/+/cJXG6wA7WM72HvhDPxG+5Nriu3m49FrQZQu67Fhi30bh7RLNgz87W/Y2o3W/16U25pUC0VihsVPgZV2x/ccaXeBnHVY4Siu4SnIE62ryVqAm+Sa6fpSgoXntEjqb9K98q6abXk6y44t/6yOCBYtl8eC2WT69/u7hkUNBp0oAGTs6dA76gsUXALSbLj/VXWV785eCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rb67f/FMJ/hTLyvC32zc19UHMttFDE+mF1hvav9dYo=;
 b=P87CqzpVmr8ZnSqUh5YMff77cYH+NqdrLkqyMDlsMvDjlRzduMFFyMkwWJC4wQ6uN9i/HpSyFETmhcPEdWPuv8MNvlCOahZdTwGB+h/PlisR0r228dEBlIMRbp0sAIApviHXf+tBU9T8dKMGeVPtwQPCVPzR36hM1SQYZ3L7Hk+eeCoUgQr0E8p/BJe8HAtZGt6HWORs6Izqo7sdRmwGTWulbtEVvvJujjx2fZ2iw1gHIQOhJ8yukqpXjb4Hqh1vj7WPBuSmAtENc+3vqFE7izjOO5e4iS5ennjEajnfs2+jPntL42rBDh/2zd49qXwYdl6S6xPqD0aRdPTVuaVp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rb67f/FMJ/hTLyvC32zc19UHMttFDE+mF1hvav9dYo=;
 b=KlsuNfZ5azZ+VmbID+47lJMFDbecPg2xSh/ApJJQ9Z59SxcWyNfcb2tTolFxGloV73QYubh1//hNmiZbZ2dPT9ZJ1JQe8EJ98vFxGhOvhdkZ4DpgoS3vGDzMR1qsQg1tyrIRheLzDSPMOucJfGKTSpzGVI+He47FBB+0HmanybYVadX0ytwT2hkoM7DBJ7WeyHkiXQ16Aq0dyHT9wZ0Qf3zozmajaOBRhDhAuZofP/pPp9/FsaZ6nhbM1xqnz5QZfwO6ficJ6lHy85H3C4rFSJuJlYfob4G1qS3rwTI7oWmBXGMFOytsywJufyZNVYioaWcfDnJCFpx6V8INtyg4cw==
Received: from BY3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:254::17)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Sun, 16 Feb
 2025 08:33:33 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::16) by BY3PR05CA0012.outlook.office365.com
 (2603:10b6:a03:254::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.10 via Frontend Transport; Sun,
 16 Feb 2025 08:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 08:33:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 00:33:22 -0800
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 16 Feb 2025 00:33:20 -0800
From: Shay Drory <shayd@nvidia.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Shay Drory <shayd@nvidia.com>, Keith Busch
	<kbusch@kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH] PCI: Fix NULL dereference in SR-IOV VF creation error path
Date: Sun, 16 Feb 2025 10:32:54 +0200
Message-ID: <20250216083254.38501-1-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: a06b8e82-dbd7-4945-d8f2-08dd4e64999f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/q9oar1rT2p7vFJsheuTNJRzVe+b0pEAVHtSn5cN0t6EX0jSIfzsryAnT6s/?=
 =?us-ascii?Q?CnCProxCewZBGnImghbVmwlaTheUQGXC8efovZB7oefKFhyJg0hUSE4oB46U?=
 =?us-ascii?Q?GFwxfNVmf+cCcF1IsnehacQWttkhG0YBHJOz20A9EcqrsTO5B90UCfFtd+7R?=
 =?us-ascii?Q?qgMtPpjpVzHtRVzYL/z9uQOz2bCC9jqCWOuexYvyeuD3X06Der9oHeIXKZLC?=
 =?us-ascii?Q?TrtG7InfM+Jiw5SMV1p60WmloqTNVy4wW4YadgzG2w6RVs6dGflQTpQUFq/i?=
 =?us-ascii?Q?7wY5RA2dPjtDsf5wdD82Ga9nDXGi6LSFMaIyKNnNJf+f+vcnRSJO09l+FNex?=
 =?us-ascii?Q?ZveJ0dKeuoV9F0pM4oZroYJJ6OyIUgQjUKxp6RRtoMVMepCssTlrt6wWq8pV?=
 =?us-ascii?Q?GVxVS5TllkfGwBCtmX1VwYUzuKAas0BWJ7+buCWsqx54tqA86WwCCW586Jg6?=
 =?us-ascii?Q?nch+zi88sgtedS1GymfGyCqocqqLvJtqNiCTyuM3lYa1AR7Jk8dkXWgHK8gp?=
 =?us-ascii?Q?ahib50hDCJ80lAbUfXqfIDOIOdrRW8ZZ4xEKr4zSw/spKF9eJeroeuZRHxww?=
 =?us-ascii?Q?rztgLqFQ5Y33DXoG5YD678az1+a3TOeRKzW1KVfvCXqvP1lCPV+u7xJHIUul?=
 =?us-ascii?Q?oFFF/fBjcCHImuUlt6R+/v4uwupO2aHcDAS+FasU/skZq+Lrb7aYozK2/UaZ?=
 =?us-ascii?Q?HWr49JrxY5kcaCKNZPvNELgGNxYtNKtdOJqzRUoaOeIzWvWjxXWx8B8lws3X?=
 =?us-ascii?Q?5Er8AL69+ndDMooyQj0NLx7Lk2putYEyJ+t/h8MFeDD31OwQ0JOOY/lHygKh?=
 =?us-ascii?Q?Wlet3M4izTG8lCQft/rMVWViW7SpFLM9hNXI8qnSDRNJmIXHD4t0ABDQr0HU?=
 =?us-ascii?Q?Gygq4Vs9seTIzpaWrlzHWli5fgkKXVPJ3CXj8ntwxhDPRR9ic25APirP/PDy?=
 =?us-ascii?Q?hDEzKF5zVnSPsAsFkdwuXjclIluqWowOr0jZJ5I9wlHQk9B6T2g++FNpfGgN?=
 =?us-ascii?Q?iR3C5KfvC+aaVvv9P8iql6FQR2RoxbJuDm5yw6zDkfZez19JLMDmSE8xoWYT?=
 =?us-ascii?Q?dj8IXdPJ1tGP3Bw01PWe3EHVsH8h7RHaz55Bf8TDJhcgoSUN4569Dtu6gbql?=
 =?us-ascii?Q?jCiNl7RCJ2WFT4yN8qZpmEiccWh6oqiskcdTkw82CaKWnMnneCfG9JqY+SR7?=
 =?us-ascii?Q?YcR22kUYEr1ayD1Mi7qz6s2FNArKJ3filBVyyPr0JggI27FUB1bcSU+8rd2W?=
 =?us-ascii?Q?v3fl1yE3gqGdo4vBvM8IqxG9JIKwXBqsvGpEZwrvlmR3xDSqnA9BWYztkt0e?=
 =?us-ascii?Q?cD70ZooO47Lyfwj9yp1CP4Nvhka4ChsJcQ6o3yy+Fe4Ah+hJRAh6TD0t5Oob?=
 =?us-ascii?Q?3AaZjNmEd92PwR2IixFHgxvNHIUJeF7ZlBJDFrb1xi3v6f8AVRVuyLsiBFvF?=
 =?us-ascii?Q?YXeNLHy7ShV0Lx7OM+i+bfDkP63KK9jPGLk1A69nzSmcP9m0xe4Mg34XAMlN?=
 =?us-ascii?Q?JLd0vG/Izl1jCpY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 08:33:33.6783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06b8e82-dbd7-4945-d8f2-08dd4e64999f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615

Add proper cleanup when virtfn setup fails to prevent NULL pointer
dereference during device removal. The kernel oops[1] occurred due to
Incorrect error handling flow when pci_setup_device() fails.

Fix it by properly cleaning up virtfn resources when pci_setup_device()
fails, instead of invoking pci_stop_and_remove_bus_device().
This prevents accessing partially initialized virtfn devices during
removal.

[1]
BUG: kernel NULL pointer dereference, address: 00000000000000d0
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP
CPU: 22 UID: 0 PID: 1151 Comm: bash Not tainted 6.13.0+ #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:device_del+0x3d/0x3d0
Call Trace:
 <TASK>
 ? __die+0x20/0x60
 ? page_fault_oops+0x150/0x3e0
 ? exc_page_fault+0x74/0x130
 ? asm_exc_page_fault+0x22/0x30
 ? device_del+0x3d/0x3d0
 pci_remove_bus_device+0x7c/0x100
 pci_iov_add_virtfn+0xfa/0x200
 sriov_enable+0x208/0x420
 mlx5_core_sriov_configure+0x6a/0x160 [mlx5_core]
 sriov_numvfs_store+0xae/0x1a0
 kernfs_fop_write_iter+0x109/0x1a0
 vfs_write+0x2c0/0x3e0
 ksys_write+0x62/0xd0
 do_syscall_64+0x4c/0x100
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: e3f30d563a38 ("PCI: Make pci_destroy_dev() concurrent safe")
CC: Keith Busch <kbusch@kernel.org>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>
---
 drivers/pci/iov.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9e4770cdd4d5..3dfcbf10e127 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -314,8 +314,11 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 		pci_read_vf_config_common(virtfn);
 
 	rc = pci_setup_device(virtfn);
-	if (rc)
+	if (rc) {
+		pci_bus_put(virtfn->bus);
+		kfree(virtfn);
 		goto failed1;
+	}
 
 	virtfn->dev.parent = dev->dev.parent;
 	virtfn->multifunction = 0;
@@ -336,14 +339,15 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	pci_device_add(virtfn, virtfn->bus);
 	rc = pci_iov_sysfs_link(dev, virtfn, id);
 	if (rc)
-		goto failed1;
+		goto failed2;
 
 	pci_bus_add_device(virtfn);
 
 	return 0;
 
-failed1:
+failed2:
 	pci_stop_and_remove_bus_device(virtfn);
+failed1:
 	pci_dev_put(dev);
 failed0:
 	virtfn_remove_bus(dev->bus, bus);
-- 
2.38.1


