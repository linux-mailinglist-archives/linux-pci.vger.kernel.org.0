Return-Path: <linux-pci+bounces-11025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 830E694136A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 15:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102441F218FA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2651A08A6;
	Tue, 30 Jul 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UtYS69Bm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6E1A0737;
	Tue, 30 Jul 2024 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347003; cv=fail; b=Q7Dwk6g6rgtjUqUBExH2cTFgy3EYCUoANBE93Wa59GGK7FdxPogVucHMq/8yAsHlugmgmZl+KNODPNVRHcCSylDhhLOmAj4Pq/mdR2Chl2dcL6VzRntJ7FrtOyJaEHMptfwpdmStZ+bQZD8VogQMJUA6A1aPQiuuAkOv5gbH30k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347003; c=relaxed/simple;
	bh=HdsN0sHVE4M5/RjC0GcRXT0unM9Q6sm44LV+ItizNMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddgwSfIKrzjwY2Y4LqoeJpixVs+4GPVQcesCm4nfk/Ifu/wsO+K71a+q5v7k31ZCteRkNdab1JKy/Z8P830vG2jXINIyHjqCkVNNrVgwG1EGrF/dYY3NeslNbpOA+gKlNgPych7znXEVsUEt0QTXt7rp3IF1kJI4dXIp8KRjvd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UtYS69Bm; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en7Oj4IOmHU3lMoq348UlKcPPDD0dHRY71xPRrjRfyoTX66kT5VCUfruIuoZgTMBKRBCcBkRIoxBcJI7lELlLmzOaUGBBdJ7N0g5GenBhvqviMFVYcE9GPhskggyDmDx8pY+asurUG/5v4/smSYaBTYn3oHUI01cliCNGr/K8jZDkmpWfWYHyIqbfGUJNLfJyW3pvoCi/frvpTUeAoRkmelQmM2ogJygzABC75+pLlC6ZpGzQyxce0LxK4qj4M7EPEbx2nR8xUtBQhPndl3kUz+ywp1yoFhd0U3GpnMuRph+ec+/rt3kVb46wjkONWj2VL9q2DG3OTD1aXDJbo/Azw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmeXdBkmT7zNUEHfrc60/eljTmO3aVoQe6MbYJZZXiQ=;
 b=GMGDBIJjJvBJZGGBZfiw8LuXa46D/7e8Hp1xBHucdNRibHnOdt6w0uiUKF0vMEB2JOrY8TNCbK5PTeoMntG1BfAPX4USpTgamCW64tGzk0BIAeWtaMSWQf26AJll/n0knGmF7r+SPFu5QBqIi8rXONv1RI90eVNQYHGPyeYlW7NdD9NoYp5zkglff+8opLejr/OA0snGuU1BkLhUdY9dmy4SQbwWDrOlyMaba6kJRfHZjnR5SUJ5Fdm9ayz9aDR9j0Fr39trrwLovV8m74HWhNiBMEMuOKISmyry1K6yNE2hmcxxPq9WQZFfdq1vgZhd4EhZSDsslvvW/z+zUeq75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmeXdBkmT7zNUEHfrc60/eljTmO3aVoQe6MbYJZZXiQ=;
 b=UtYS69BmPGXxyQuV0kxg1I/e9GzQdSrPdliJM+oUCy4fP7sCwv41DU3c8SC2l6t7EkpFRRjkDzJYJMAWFiUvnIytqEJFk35vPS4xGOq3TiYpaWihUvz7tciKW0wa3g66a0UUlruXP182r1Fwu3M1JAjVJ1GYpriTTThJYXQx7e6h/ytTic7sSU2rxKXA+jbTzF8Q2kowohBH2tVOm0bzOjOGApxcElQ1/vTqmxTUtEiXDKSfNoOsI/bBBg6i/hyxGgYdX/qfydImYcptflzLgHBJMIz1kQKMupyPM+yjaBwGoprGsA+jzNXpQAziYu2uwXTgbtceKxpkSOsa3rOhqA==
Received: from PH0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:510:5::6) by
 CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.21; Tue, 30 Jul 2024 13:43:17 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::9) by PH0PR07CA0001.outlook.office365.com
 (2603:10b6:510:5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 13:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 13:43:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:43:04 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:43:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 30 Jul
 2024 06:42:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, John Stultz
	<jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Bar Shapira <bshapira@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 3/3] net/mlx5: Implement PTM cross timestamping support
Date: Tue, 30 Jul 2024 16:40:54 +0300
Message-ID: <20240730134055.1835261-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240730134055.1835261-1-tariqt@nvidia.com>
References: <20240730134055.1835261-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: b8241b21-0d47-42d7-bdca-08dcb09d9129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gFMKzkNxudx9s8aDItwr+mER42SJb1YKXoPSNHETyBUH9Kv17gP7Zg6Ng2j5?=
 =?us-ascii?Q?zXt6Rp8OYLTPrzZ/q1XeoGYhONObJfoH9FdeJK8UalJVUQ9thy1I5tvujMT7?=
 =?us-ascii?Q?YEnWotkOMv143rbq4aa09ZwdHfIl4594snTQGC/u3VUkO0ks7IgniCMa5wAW?=
 =?us-ascii?Q?d7b2FaEwisaMvkO1zio2RN1CDQAzSv1+jfM/utO3i39CRUUERgQuCIkzBOhm?=
 =?us-ascii?Q?HY8MY66FfKndkKmM/dfQTcEDQh4+ITp2+tsBqvcNt9CZgW8gw9N1fEXBzlPS?=
 =?us-ascii?Q?4nKxRo8GQpvwXaHDRKl78q0RIIZvdSyZod/d/mIP7eP5rXb5rNK+HF8SB18E?=
 =?us-ascii?Q?EIzfr26PHFO4Kn2PfYfbhGFl+DCVAhFUB0WicQhP6rjrUPAQ3K7mzcBqSSCJ?=
 =?us-ascii?Q?/oqzLbK4Mh5AIGtb3so04Umqhqa1s+P6aXT9oNe441qQgGjFmMFQJzLG/szw?=
 =?us-ascii?Q?jKnOgS6pTSy7fNgUy8VtH8+vkFFhnq58dc/SnYE8I39mV2BRgd9JVh9n9gBL?=
 =?us-ascii?Q?i8208waT6wNyWYBSm2RNFKITTrOrT+8S7DCXMabxnf7LmULCtW7yLZrvZ8lQ?=
 =?us-ascii?Q?RkJZXiDbeLw75IrS9mY3oqkfdBEf1jkTMo7vG0KP81iOh7wY5XlkYrYQsKXW?=
 =?us-ascii?Q?kTYSG1XJjlys+3jQ5/KWZU/H7H+43VERaNBuk5SNhsXZ8Z41Y9dqpfXEoHr2?=
 =?us-ascii?Q?26xjEB2Tqmi5LK0fIZMx+WgUDxTEDXNqJIvXawuHY/9W8SmWfia0/1qBoKXK?=
 =?us-ascii?Q?M8XgQ7vks7wv78LikBKD4vADKi9hTYO6y0A64fwwbBdabcDjkTZHVWpXCBrE?=
 =?us-ascii?Q?0BnOwO5YaYjZ0IlLJ//qrGqF6YuOCOapj+0qd1BVyTvSIBZLeeeoEnjo42sP?=
 =?us-ascii?Q?Ku2q4OnX19IBMmxk5dQEo6V6xzuLF6lC+vlGkdU/OHpMaqmO2VdrhmYV5NHz?=
 =?us-ascii?Q?x/GCMTSvG9r/A60QWgJHQCYA3H7YWv1FUlfVK8P/Gw5wEDkIeO9GGkhcrcMb?=
 =?us-ascii?Q?KMcGI++P6/qzsZZy7pVK8waDU8N5l2Ipmz8xzdnDTJiUGTC0dtDCu4dz010I?=
 =?us-ascii?Q?gLRGQaxEUQYlg+Yq/9eApMyq6wfjL/Vu9NXEMzQ/+/TZZs4Z7VLLC0qaT0rm?=
 =?us-ascii?Q?AUinJI5ff+RHzK/jeDMyQb9lowj6VVwbgRWbqpOOau2saISanhwnOLwUiTWr?=
 =?us-ascii?Q?RVPz7XMkAcsCdNs+A2CqFbg+F54fgm2St3WjSgtm/+4lv1jSzMGosaBMN7sr?=
 =?us-ascii?Q?efZtCthNcG1uUTgN5TRoSl/NjkDYdvM+sjdZUZqzmc5eq23NtSM21sHFGub3?=
 =?us-ascii?Q?rKGO1YP28CxCHbVP0fRKEXlKm9bNyaRw/W92YynU1uP3ixi7AbvaNKtpvnne?=
 =?us-ascii?Q?QP/5xM716QjRjORlSkIZmWexREJBUlBCTJGElfwGu/xGYpyPb+2aa5nLq2By?=
 =?us-ascii?Q?zUjvpAzpsaW1cRLlpvj9AjuZ2cn93Z0u?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:43:17.0459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8241b21-0d47-42d7-bdca-08dcb09d9129
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Expose Precision Time Measurement support through related PTP ioctl.

The performance of PTM on ConnectX-7 was evaluated using both real-time
(RTC) and free-running (FRC) clocks under traffic and no traffic
conditions. Tests with phc2sys measured the maximum offset values at a 50Hz
rate, with and without PTM. 

Results:

1. No traffic
+-----+--------+--------+
|     | No-PTM | PTM    |
+-----+--------+--------+
| FRC | 125 ns | <29 ns |
+-----+--------+--------+
| RTC | 248 ns | <34 ns |
+-----+--------+--------+

2. With traffic
+-----+--------+--------+
|     | No-PTM | PTM    |
+-----+--------+--------+
| FRC | 254 ns | <40 ns |
+-----+--------+--------+
| RTC | 255 ns | <45 ns |
+-----+--------+--------+

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Co-developed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 0361741632a6..b306ae79bf97 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -38,6 +38,10 @@
 #include "lib/eq.h"
 #include "en.h"
 #include "clock.h"
+#ifdef CONFIG_X86
+#include <linux/timekeeping.h>
+#include <linux/cpufeature.h>
+#endif /* CONFIG_X86 */
 
 enum {
 	MLX5_PIN_MODE_IN		= 0x0,
@@ -148,6 +152,87 @@ static int mlx5_set_mtutc(struct mlx5_core_dev *dev, u32 *mtutc, u32 size)
 				    MLX5_REG_MTUTC, 0, 1);
 }
 
+#ifdef CONFIG_X86
+static bool mlx5_is_ptm_source_time_available(struct mlx5_core_dev *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(mtptm_reg)] = {0};
+	u32 in[MLX5_ST_SZ_DW(mtptm_reg)] = {0};
+	int err;
+
+	if (!MLX5_CAP_MCAM_REG3(dev, mtptm))
+		return false;
+
+	err = mlx5_core_access_reg(dev, in, sizeof(in), out, sizeof(out), MLX5_REG_MTPTM,
+				   0, 0);
+	if (err)
+		return false;
+
+	return !!MLX5_GET(mtptm_reg, out, psta);
+}
+
+static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
+				     struct system_counterval_t *sys_counterval,
+				     void *ctx)
+{
+	u32 out[MLX5_ST_SZ_DW(mtctr_reg)] = {0};
+	u32 in[MLX5_ST_SZ_DW(mtctr_reg)] = {0};
+	struct mlx5_core_dev *mdev = ctx;
+	bool real_time_mode;
+	u64 host, device;
+	int err;
+
+	real_time_mode = mlx5_real_time_mode(mdev);
+
+	MLX5_SET(mtctr_reg, in, first_clock_timestamp_request,
+		 MLX5_MTCTR_REQUEST_PTM_ROOT_CLOCK);
+	MLX5_SET(mtctr_reg, in, second_clock_timestamp_request,
+		 real_time_mode ? MLX5_MTCTR_REQUEST_REAL_TIME_CLOCK :
+		 MLX5_MTCTR_REQUEST_FREE_RUNNING_COUNTER);
+
+	err = mlx5_core_access_reg(mdev, in, sizeof(in), out, sizeof(out), MLX5_REG_MTCTR,
+				   0, 0);
+	if (err)
+		return err;
+
+	if (!MLX5_GET(mtctr_reg, out, first_clock_valid) ||
+	    !MLX5_GET(mtctr_reg, out, second_clock_valid))
+		return -EINVAL;
+
+	host = MLX5_GET64(mtctr_reg, out, first_clock_timestamp);
+	*sys_counterval = (struct system_counterval_t) {
+			.cycles = host,
+			.cs_id = CSID_X86_ART,
+			.use_nsecs = true,
+	};
+
+	device = MLX5_GET64(mtctr_reg, out, second_clock_timestamp);
+	if (real_time_mode)
+		*device_time = ns_to_ktime(REAL_TIME_TO_NS(device >> 32, device & U32_MAX));
+	else
+		*device_time = mlx5_timecounter_cyc2time(&mdev->clock, device);
+
+	return 0;
+}
+
+static int mlx5_ptp_getcrosststamp(struct ptp_clock_info *ptp,
+				   struct system_device_crosststamp *cts)
+{
+	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
+	struct system_time_snapshot history_begin = {0};
+	struct mlx5_core_dev *mdev;
+
+	mdev = container_of(clock, struct mlx5_core_dev, clock);
+
+	if (!mlx5_is_ptm_source_time_available(mdev))
+		return -EBUSY;
+
+	ktime_get_snapshot(&history_begin);
+
+	return get_device_system_crosststamp(mlx5_mtctr_syncdevicetime, mdev,
+					     &history_begin, cts);
+}
+#endif /* CONFIG_X86 */
+
 static u64 mlx5_read_time(struct mlx5_core_dev *dev,
 			  struct ptp_system_timestamp *sts,
 			  bool real_time)
@@ -1034,6 +1119,12 @@ static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
 	if (MLX5_CAP_MCAM_REG(mdev, mtutc))
 		mlx5_init_timer_max_freq_adjustment(mdev);
 
+#ifdef CONFIG_X86
+	if (MLX5_CAP_MCAM_REG3(mdev, mtptm) &&
+	    MLX5_CAP_MCAM_REG3(mdev, mtctr) && boot_cpu_has(X86_FEATURE_ART))
+		clock->ptp_info.getcrosststamp = mlx5_ptp_getcrosststamp;
+#endif /* CONFIG_X86 */
+
 	mlx5_timecounter_init(mdev);
 	mlx5_init_clock_info(mdev);
 	mlx5_init_overflow_period(clock);
-- 
2.44.0


