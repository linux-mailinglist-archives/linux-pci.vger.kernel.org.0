Return-Path: <linux-pci+bounces-42723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CA3CAA663
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 13:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C395430164D7
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703BB2F60AC;
	Sat,  6 Dec 2025 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XFS2P6FN"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012001.outbound.protection.outlook.com [52.101.53.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F12D77E9;
	Sat,  6 Dec 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024948; cv=fail; b=lcQxGF/dBcLBwIiJuy6UKHczNeKa3qO30BAF9wdBp3Ck9lQ0PYXxcgwyW0V6FH/JehlhpEi4zpMRoZzYuJaT+UKaFeelDO0juMCswLPZuOKKSn6M6DY83oRXBXjcgWasFChrSsO6WWX2ygtoQcE5V4akpN79DCV6LB9CY/zSLuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024948; c=relaxed/simple;
	bh=9eCJ5lBK2fJOrYT8IdHYj3tXqCCQS6T6OUMatewbkgA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mna18TsqecPKmkKjTMpGBGvUpK+HKhhzU2ZR8gzWcC8RQ0Qtqh+ex5vsbBzZAESCDDtP3PJU//cDw/2btB//misidRxwAArTNyZcDhcGaSrcLCxnZMUu91JBf6IwR/+tkXmpmRhLgnk/6IEwU/3Pd3jAaW6yVVo6KpJKlPQNY3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XFS2P6FN; arc=fail smtp.client-ip=52.101.53.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAIyMu072RKoG0MLD3UIknviKCBeki1It8bV4Fzubvb7NUyQGlOdsGdbzrbTgeep8F9Jilthz2mpyxZMjI2Sle3y0y2td6XVG8uOS4Itg6JuUTdgA5EkrR/lL4K2BUb6mZHDy8/i2KPYzvTmZzYoqxDq8gDo/oZ9wPP6RwRDEl7zNXvjTH2th18k31guZgKzH2bemO1b6UBMBTPwRqnajiWikhp9GCswmruERyI8+7W647nDj2UyW96lYhhY1MLfYTJFBaEGLqwwDVaRBwhPVkj+FT2jj9ye/OYaJ3ZDe+1ry3Cpb7sWQoF6Ar0RD0oE0k3u/8UwsvN9bZXcUIUc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WrgadsETTOF2eZX3HMMjobUFVUF4mJ/pc7Mx1O9j68=;
 b=jIXv0bAXAklYoYQGZHaGvIsuApxuMI21OgT48X2Of8N8fvi4V8Kl9Wh30b6bQuEx1Qc/ZxiIC5CpZLOetxFXE1CssP1ib8jLgVOk87H4y1/5NMtgVOuolB18fIx6ankCMeE7G0Dazp3dSYrjWKEiKaOHuIOHK6jesKQ0tuZattcKz2uaOr/HmU1Nb/gn6oXLxQ1/lWyPxHVvOEu9HS+Cu8cU62WZJcRkYNAG9S33q1MX6xHJ9OJlHMAx1E0FysmsS6GPBXwewFhqgDj9wpsHlcxvFuNJA/nCKQ0iYtGlzxspshczyUrX1kAnf8ElG5xGAnSyriZ3x/ly8qouFlO4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WrgadsETTOF2eZX3HMMjobUFVUF4mJ/pc7Mx1O9j68=;
 b=XFS2P6FNYSIf6+kJSC2KrXzLqo6qaHWkBVneblB8x8s1CbP3qt5+AXll6EXDk0j/xjwqW5r1WUy5R3UcM9ecXZ7fMBNlQGoqWSS9EzZVdGXdy5S5NRCAurnvmTnygKjfPRmY1dq1JHaKTNM131cI3U4ZvuvLzdbqLRrB/QC42QVBchSfT/2shTZLJyGyqKtAjQUq35QVAZr2ZV+szYRvW5nLr4TDgD6g29cYZ9Kxu7l6vVaJtcmxMgVGs+ygcW9aSYo8H75EbqERqXWVCpAPR/Z1JLywRXAJznwL7t53/GdgngMnoB4yr9GgRDXCJslSOIp8TLXLVgX6KOQfu35tKw==
Received: from CH2PR07CA0046.namprd07.prod.outlook.com (2603:10b6:610:5b::20)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sat, 6 Dec
 2025 12:42:19 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::11) by CH2PR07CA0046.outlook.office365.com
 (2603:10b6:610:5b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Sat, 6
 Dec 2025 12:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 12:42:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 6 Dec
 2025 04:42:11 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 6 Dec 2025 04:42:11 -0800
Received: from ipp2-0489.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 6 Dec 2025 04:42:11 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <airlied@gmail.com>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <alex@shazbot.org>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [RFC 0/7] gpu: nova-core: Enable booting GSP with vGPU enabled
Date: Sat, 6 Dec 2025 12:42:01 +0000
Message-ID: <20251206124208.305963-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f309ce5-5500-4405-9159-08de34c4e4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P+4RDPeYb2H1hkhLNqQHovyN8Mk/bri4iKxFXiYw6POY+NSbgJzX98mCHnRZ?=
 =?us-ascii?Q?ABWZFeEEEmFV4klbYYjAOmsphHGja6oqWztmpq+9X9IcjOOhS+agLEd3bBez?=
 =?us-ascii?Q?RtBhasRNU7oQ1W4dO6oArmFrBSaAmYaPIzxGWYWtL4WiZu2hbxjg3V6tT8Jk?=
 =?us-ascii?Q?kUYcWM6eZnfRFPqCNK7KoJ0XQ2t+ftQ2zS4sblHzAxZzyq8vlFZKoDjKssQ/?=
 =?us-ascii?Q?XEzR1EGlui8Qvn+pcgl/SfAm6xrOpIMHwa71Ln0k2dbL6NuVEl/ycxSCkNJK?=
 =?us-ascii?Q?RRjP6J19lW41zh9zVzpBpBD8vNBnum0gLFdmTgygy5imTIy+KBgXz3Fp4dPp?=
 =?us-ascii?Q?/DblKSU7ptMhwGvwkgmlzcO7f5ly4GN2G3fxHwJLl2uaLJlZeb9KeUIb2OBy?=
 =?us-ascii?Q?nb+V4wF7WUG93xMlHykdjNYt2gnfMM5eHOZOAu98QBkCJjOfT37ev34Lppsx?=
 =?us-ascii?Q?4jAY0oPnKOCvDMdu1ozOqqtBktrQ7cVG0R3onkEJRSJ9hv8A0g2Zpw96ZvdN?=
 =?us-ascii?Q?GXUf59cIObxFPF68Tl5CM2KSc6a1dwb+zLrtyoYfainiq6b0b7uS6/wEPMQa?=
 =?us-ascii?Q?XAA0UlFZKaqN8C4x5VZB2Q60l/fu9OvsSD768uo6CXirDKA7NIVY90uMaBhR?=
 =?us-ascii?Q?SHij5fcQlsGrIXbkc36k4LHpkcvnnsnyq1qKC6QW/za2O33nC5Pc0Zt+s7q6?=
 =?us-ascii?Q?+ZDzJ9xKzh75t7DHZb2qsJ/UQNfS1+gUULuIAaL64K0YnvFbmbnc2FBn/2dD?=
 =?us-ascii?Q?UCKVt1+b6M6agv/tBtiIOovUC/NKZWCHTabRkWwq0KNZcu3tt6Fz0OSO9ATS?=
 =?us-ascii?Q?na3YveitJuiIvAK4MQDdr6WL/wKY+kgPNDFxT3pWYz/UkXuJDo3ojNlCOVpZ?=
 =?us-ascii?Q?1cq+qOD8MdH8SJFXT1YUF1G2ePFPBsaRFn+inSI31ludrHBYRmEzXBaXUVp/?=
 =?us-ascii?Q?9AY3ibR7IgjiPairV5GNV9sK6D02lsCmuQZHnO4sH7dTA7O2U1qlBVANmaTo?=
 =?us-ascii?Q?SpwQV49ZFTxzot/V8VN5gf6ryGe34sZwC5yV7vJZo4vy0l89WcqmAFGQeWee?=
 =?us-ascii?Q?xGgPc7D2AC+4H0Z8pElNUjIKZBQDZzNMEIqS67zf2sbRig4BemE9W/fItKIj?=
 =?us-ascii?Q?QPTuuCDRUTkt9Tf99d6SnYzJNnrcH1AmM3MoCa7k0N4hmEdCpYOuQ3pPRorw?=
 =?us-ascii?Q?7DN7IuLb3jl9QLXmqoJjqlbyW2ZUIL7xNfF5ZYyRP36k/oeeGofo7GQV6apT?=
 =?us-ascii?Q?cm0gQ4Q0OxoOxX6CqMDJ91Fv5X8iHpRbN037+zsKi7ktEbZVNCLQMivGK7IZ?=
 =?us-ascii?Q?R0ooVGC4PoQecwBZglW8teoutzvsbDMx1RwfikXHrFRv9XGerHkAs51+9qfw?=
 =?us-ascii?Q?knVf6c00nWKmSLKSyg132yO+Q4eTPcTAQBiEbczsEIpifk+EZTsfxHLv/ChW?=
 =?us-ascii?Q?A47U1uu21HMj934+KEme4PlJb0OrrSCgc6JTCPcTNA34uM8D/TB+BaCv87v4?=
 =?us-ascii?Q?fhN/O7ch4IEaZidK1sGF8nlLOiQAe6sExaeMKhRRQ3Uz41oBFR16KUDWUFIi?=
 =?us-ascii?Q?e0Zu/nRXGtaQRm5CW83CAJeAbbCzILAA/+e3N3jM?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 12:42:18.9312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f309ce5-5500-4405-9159-08de34c4e4d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164

The GSP boot support [1][2] has now been fully merged into drm-rust-next,
which puts us in a good position to start discussing the requirements for
bringing up GSP with vGPU enabled.

Booting up GSP with vGPU enabled is a key short-term milestone for upstream
vGPU support, allowing us to validate the basic GSP boot flow with vGPU
enabled even before the remaining nova-core dependencies are ready.

This RFC series builds on top of the latest drm-rust-next with kernel
module param support from [3]. A tree can be found [4].

[1] https://lore.kernel.org/all/20251114195552.739371-1-joelagnelf@nvidia.com/
[2] https://lore.kernel.org/all/20250827082015.959430-1-apopple@nvidia.com/
[3] https://lore.kernel.org/all/20250924-module-params-v3-v18-0-bf512c35d910@kernel.org/
[4] https://github.com/zhiwang-nvidia/nova-core/tree/zhi/rfc-boot-gsp-with-vgpu-enabled

Zhi Wang (7):
  rust: pci: expose sriov_get_totalvfs() helper
  [!UPSTREAM] rust: pci: support configuration space access
  gpu: nova-core: introduce vgpu_support module param.
  gpu: nova-core: populate GSP_VF_INFO when vGPU is enabled
  gpu: nova-core: set RMSetSriovMode when NVIDIA vGPU is enabled
  gpu: nova-core: reserve a larger GSP WPR2 heap when vGPU is enabled.
  gpu: nova-core: load the scrubber ucode when vGPU support is enabled

 drivers/gpu/nova-core/fb.rs              | 19 ++++--
 drivers/gpu/nova-core/firmware.rs        |  1 +
 drivers/gpu/nova-core/firmware/booter.rs |  2 +
 drivers/gpu/nova-core/gpu.rs             |  6 +-
 drivers/gpu/nova-core/gsp.rs             |  8 ++-
 drivers/gpu/nova-core/gsp/boot.rs        | 38 +++++++++++-
 drivers/gpu/nova-core/gsp/commands.rs    | 31 ++++++----
 drivers/gpu/nova-core/gsp/fw.rs          | 75 ++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 11 +++-
 drivers/gpu/nova-core/nova_core.rs       | 15 +++++
 drivers/gpu/nova-core/regs.rs            | 11 ++++
 drivers/gpu/nova-core/vgpu.rs            | 26 ++++++++
 rust/kernel/pci.rs                       | 46 +++++++++++++++
 13 files changed, 267 insertions(+), 22 deletions(-)
 create mode 100644 drivers/gpu/nova-core/vgpu.rs

-- 
2.51.0


