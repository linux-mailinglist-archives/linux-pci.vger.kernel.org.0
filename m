Return-Path: <linux-pci+bounces-11022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70B941360
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 15:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDB1282773
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 13:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5D219F49B;
	Tue, 30 Jul 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H7bDSEpY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD45173;
	Tue, 30 Jul 2024 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346984; cv=fail; b=sBjhjKPtYC1nCEyphkMAjpnJYR/WvOpyyY3z1azRNfgdTRe6Mi+V+h0/n75QuV7bY4o/BOyj7UmbMMlfzgjT/NWOgZz12wGBgIQhMspkSmGbw7VCqP4Fz7kq8TbpuA3DzGnlCoXL9AuhgP+8J24+vv6x8jmzKQC7c0JHuZT0d3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346984; c=relaxed/simple;
	bh=b/gLGTMqkDTYmSundrpD6b5RoLMkFdl+uGVWELdX+vw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hzYjuSKjOqHEB2znEsBcFEwq/bES1rLlKxICYvK8VedVyYywRz3U63F6kEoSxmvuyyxVGSPajGRrwBGN+/t+pk8VNghTLan1pdm72shQmjAFlsJWTHrpgkTAvic/D8BkKPiU6u1uAmkrlXXr4R1nenWsbnqCvGHdn0Z4jZt26fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H7bDSEpY; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXCYicjZgI535Q9lqVCGTWnb1FSLPbI8iWehAJa/A5p+ghNHDbcf5V2/aE2I5cId+eW3bu9j23Tm3PUG8dSFhEA68JM+GdkGksixGN8tq9krZmGmdlCxd/i6Kr4ROOFr6G/zPcqdfTW7N0Q8B+P5UpyJO+wB2XPZTiHnnnpPamNgmMJ9rrUGEkZXCXTwc2LB0qtB3DyMKXyG/RL+bshHrSmQ78fFTKjsWvS+f5h6+dkpnG7CH+0JHF+8T8C16dZHeLIg0ZdF3q96V7k7Tq/1ZiQT6ZzCwU/T8BM9y1iR3pPxBns7Sm3GGZigaSDR0kBlqX6xoHo9z0co1noJXmwnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC2EzVqHRwb0puZMVkmtKpEyaaotATYO6Gv8DguYF7A=;
 b=k2+a33dqTYloUglzxSWwrExz+viBSk58C0fvNvh/vGaSuzzgASX0iDYpnjHqgPFnX/bkSuXsatWNfe9DdfyMqRyQThhEjb4sq9wfXlYfMAQrj9JImBrIRBXKcx2sMJ5RF32jWaHCNA1oOROUZRrVOtbvc06WVCznqC+QtPKXk3jb55dWFdbspjkz751EYNwx/cWUAr4s03XjBwtzreuNpZQUkjS9eqH2gEE6Xrtw8JWJp68bKrA91BYtwiTWtuk2+BH2eHy7aWBg3+guFt3fLw3PmplRcmJrbRMrxvRnvLYUs9oJlvXIU8xsSZiHps9dhIoRpqgyb+pcUtZwyYYU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC2EzVqHRwb0puZMVkmtKpEyaaotATYO6Gv8DguYF7A=;
 b=H7bDSEpYQX0dfATbOkWBqXjgQtWEHBpT7oIWXqJlMXAb67Fuqn3Pd701/h5T8t9x91UxhgrQqEyc7KHzyQu8m1B3+bc9esKQxPtClXR7jONOrLKdNFrfhSlAv1uYuDDn35SgBscnvbhHOHXCfyw79vXWe5T44wUJcmHedXPLERzuPR9pi4osay7c+QsILmPWhQ3XuBUWzScEZHE0OVRQZd4If/ijUX2oJvYbha9h9gwhlCXp/J9r2ApAgEzWSejx0+fLdz0eKcPUnpqIfAEZdXl+6CTtqTYtJQ06HuVFbqXeU+RVtCx163R2uvQJ085uifd8XtsoSsc+HznxpRNYfw==
Received: from CY5PR18CA0003.namprd18.prod.outlook.com (2603:10b6:930:5::10)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 13:42:58 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:5:cafe::e6) by CY5PR18CA0003.outlook.office365.com
 (2603:10b6:930:5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 13:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 13:42:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:42:45 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:42:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 30 Jul
 2024 06:42:39 -0700
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
Subject: [PATCH net-next V3 0/3] mlx5 PTM cross timestamping support
Date: Tue, 30 Jul 2024 16:40:51 +0300
Message-ID: <20240730134055.1835261-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: e44a10a5-291e-42f4-10e5-08dcb09d8589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YYCnM+RM+pIr8pYtmb5r4N8ufd6IZ/T/Yvc45b4VORvicIMYePcb2cpodKWU?=
 =?us-ascii?Q?TA5rlzyHhz4dZu9jxpzd1DTft3hzIJG8bFIFs5Kd/iiQmmzXg0UuLcWQqP9y?=
 =?us-ascii?Q?3bUb/7rbgwjRGx20NojnWRpSM9fNAcGQQ+V7uMisjx5+l8eMIOmqaUfO60t2?=
 =?us-ascii?Q?+gvtsYvguqt6AsbJGQ+V3dciKS604aTD7Q/cQVY9PbHVXkG8u+XO9UFwzb8U?=
 =?us-ascii?Q?mIiA0xJUberdgMiSsuuBUqITO6wiwZ0Vw34e6qR3w4muTA8AgjXH2ovYb4w4?=
 =?us-ascii?Q?LlgFZ26ub0NYNI3mhsmvJI1MV+Sx788a66+ovhkz5z9RaSMEz0apcNEcEgzI?=
 =?us-ascii?Q?e+XKGRi0Oog72oZjRIOKoz6PjwMOBY8ZHRltFjKX2uniEz22UHxTSRxwR6MI?=
 =?us-ascii?Q?3c8G0KvxrPud8fFDHVSxm41XN7eDUR4po55gpwLTz7ukVrthhigG/Sxykank?=
 =?us-ascii?Q?r0NRem28CFlLB0zfhFM71jdA4G0SROYJ/w/GNrZHqtXjr1FuHwDbvHATOa2M?=
 =?us-ascii?Q?rSBkPeQn/+eyCYNYXV3yX4boBUIL274vApyMI51d8zMgDyI5ENCPwuxHXKFB?=
 =?us-ascii?Q?3v2PWh6KVrjm2T3Cl1AlUTbRtny8muMk4l4pbt4YXjHC8VvofD84KnTV8i8+?=
 =?us-ascii?Q?jOro24hsw0BVuJGXTDj4H2xYc6+gwsBzM1fI6mX1k6YWaHSP/I9nW/vaseFK?=
 =?us-ascii?Q?ZMNEYJwWvqL+3zUHQVKajADDIRitFxFlO0ZAIZ4uzaybQMf6apjmDoUchtFT?=
 =?us-ascii?Q?tBHNHwfd4cQJFviKV/NPJ20+wHSaXDigd4wuU0fb24oLXMQoYVXFSr0k/Z8t?=
 =?us-ascii?Q?MiCeTfDml0GrSuToBq3OlDC3k+DbL5IUuLNXLfeNVFGyzv0cEj7KbKZwo3Jk?=
 =?us-ascii?Q?xO29t8omgAI3jVhClHnMFQHqPy/yDpizvyVyJnJ1cvUhpV5HwfFs5qk04/2r?=
 =?us-ascii?Q?wMJOk2/AiVGBFzk4X5+whhay0s31AG9iS+kZlTEWMylfkVcKOIzgrhrT+D2D?=
 =?us-ascii?Q?/zi2Wc9vBNrpt22iBiShn+7aGQLwxtgOe73L+qV8SMGJrvHgJaf9seOUzwpl?=
 =?us-ascii?Q?Omt2PAbhcikXrfrXA/6YpCnkZqe8Vcbi2x4Zgiypoyhe/FHL1jMhfly+AjnQ?=
 =?us-ascii?Q?NIcjMM4bcDhpa8EhFDmzMkJnNYm8niY6jK/QNOnqO/wtiaq3BRU/z/GQyPmk?=
 =?us-ascii?Q?+XXJdUX/wEYBECLxM4hr4x4OHOxpM2q1pcwzP7hDAj9JA3kS8ZZmCdwmZaxS?=
 =?us-ascii?Q?fkw5PJXnJ+KaR91HLQ5M0Qo8y+kvcBheXXHHK0ywOBK4msId3DnrUq+YavYO?=
 =?us-ascii?Q?Tpkd6kmLIfcaN+6sRD/u4vrE7JDCpq0MwmSYKJv31t1gCuObDvbywYxYE0Nc?=
 =?us-ascii?Q?bJRP4kYQFPdOk9wPZiDI4XD0gApE6rY7zmklLuDJsydKL7rsAd9H3/Dex+Bt?=
 =?us-ascii?Q?cwFbqqoeZmkrNQbM8/SLYI/4/eHHOfxA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:42:57.5380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44a10a5-291e-42f4-10e5-08dcb09d8589
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244

Hi,

This is V3. You can find V2 as part of a larger series here:
https://lore.kernel.org/netdev/d1dba3e1-2ecc-4fdf-a23b-7696c4bccf45@gmail.com/T/

This patchset by Rahul and Carolina adds PTM (Precision Time Measurement)
support to the mlx5 driver.

PTM is a PCI extended capability introduced by PCI-SIG for providing an
accurate read of the device clock offset without being impacted by
asymmetric bus transfer rates.

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


Series generated against:
commit 1722389b0d86 ("Merge tag 'net-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

Thanks,
Tariq.

V3:
- Rebased on latest. As a result, had to replace the call to the recently
  removed function convert_art_ns_to_tsc().
- Added more CCs to the series per Jakub's feedback.
- Added perf numbers.


Carolina Jubran (1):
  net/mlx5: Add support for enabling PTM PCI capability

Rahul Rameshbabu (2):
  net/mlx5: Add support for MTPTM and MTCTR registers
  net/mlx5: Implement PTM cross timestamping support

 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |  1 +
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 91 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/main.c    |  6 ++
 include/linux/mlx5/device.h                   |  7 +-
 include/linux/mlx5/driver.h                   |  2 +
 include/linux/mlx5/mlx5_ifc.h                 | 43 +++++++++
 6 files changed, 149 insertions(+), 1 deletion(-)

-- 
2.44.0


