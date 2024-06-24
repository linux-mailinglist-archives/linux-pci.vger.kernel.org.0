Return-Path: <linux-pci+bounces-9176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F039147BA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 12:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD39A286CD1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2311369A3;
	Mon, 24 Jun 2024 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yQy5adox"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB80130485;
	Mon, 24 Jun 2024 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225770; cv=fail; b=ZO3ZwBsoe/qT37ePKKDI5gdbX69zMnmErbF0uyjIZQyzl9fnIqQ6tOh7M1B9QfIjMVvrCZw6MGSGpxJZWR6VTH30iP/8/f04QM4yh9eqWqtbxFL5BKZqMgDP/pTnqRCR7yQKGr6OhynWwLkVcOAx63903QhNNXJWDpGQBv1iHb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225770; c=relaxed/simple;
	bh=ldSr8n/6t6+7cU1NLJhmTy/OZYzJJfGvKxRumQu/+l8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m1BHVPguXm/eWw7sZG7s48R7x2NBNnFLdgy9tRXxHo9rtBr7PaC7d9kUlLKe5B8XFNUekaQO1YSRnXxPAKTKvLvE6Rk9kePLWy/lovZoAw2GVFnKy2dVSbLAPqNmArRuHJiN1M+nsb5ozUBfmC71n96miKGs8DGqkzmzNRC8wOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yQy5adox; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0cvkydpU1ijgmkoCmCDpGN0xV0+tP96YDOjqwYopqVtu4WVS8ekudMCY6qQ6bYpH18d2RLouQd/m9LRVaObcdk/wC89qQBO7OFQc+/wnV5NBXoX6WAOl/1vZ/araZTmRhUcSbx0OszA/UNcYp3p7ugOx5wEPOL0SX9bo6zk9ItN3Asy/mMANIJlf78NhU4B4QEDzf3JGdpwlR/DS2ZggsVMdeh5X3KcjIZclCFYGFWocJMV7rCiS98cI4qGw4ue5LVlZ1efA/sWia7j7ArSVkSMZD47ff7ZhUzX03FwuHo9bpoUr8IH5m004OfxYPEFrkrkLJK7upzv/gZBz7YwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hvso3/X6AUqqRquNnZnjSNR7EFPfVLWUVXjHPHcVjqM=;
 b=O/+wgSKz+DiqBM1BZC+PJu7YdR0q5R7y2El8lKSLDBxFEph+GTImWMJ49xVclfqr+um8nsUVomZosdlkZY53LnkQDnb79FXiy8cTR86+vlhMa6vUUPFVIAokswqhPko7ex1gq5p898dLJ9wdEfBpvNE+RTnwvGNp62RUwxNKssJ8gSAb18c5U1b7jpwedwh06f6wKVsog96ptUC40UfofSKmHd6TYU04oby/SwWZpn2xEsAoK+8gBaqvCL0vQ2UglXTJnAQO8C/vDZfEJyLQ/HXty/Z4pOtZ8ruaTpc6WwGYgiv8oQ0QX91Jycn+Y7lZ0rLRWU7/JqGtx+q8lKglJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvso3/X6AUqqRquNnZnjSNR7EFPfVLWUVXjHPHcVjqM=;
 b=yQy5adox75RG93DT5STgKl+6opW8PaFiT9DlqSyzR7Vbut7PfLiCYFPj+iOCB5A9iA6KW2p1hyzpWk0LKjaeW7eYi+HcjUu2nM/ttfaO/WdiR5T/xJ7IxBwUjlPxjvyv4JWx8FTDvYOGCftErR4ZMWx98t+TIwTdWaRaHOUXFjo=
Received: from MN2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:208:23e::14)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Mon, 24 Jun
 2024 10:42:46 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::c4) by MN2PR14CA0009.outlook.office365.com
 (2603:10b6:208:23e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 10:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 10:42:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 05:42:45 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 05:42:42 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <bhelgaas@google.com>, <kw@linux.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <lpieralisi@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <bharat.kumar.gogada@amd.com>,
	Thippeswamy Havalige <thippesw@amd.com>
Subject: [PATCH 0/2] Add support for Xilinx XDMA Soft IP as Root Port
Date: Mon, 24 Jun 2024 16:12:37 +0530
Message-ID: <20240624104239.132159-1-thippesw@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippesw@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 71005075-b579-4a56-6939-08dc943a627c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yfcaXr3dU6sQle25IAogKv45MqFdFKbWwZpeRl7paVAhzO75ltaJYp+Qt9ze?=
 =?us-ascii?Q?U8hWCQnKA11IAkowh+PtSKTRIGUxrLQnXHqk00xunWkeSeXzkJLZTMy5LQcx?=
 =?us-ascii?Q?YR7gd/l8FdxhSAa0ruHfH9ZDxfQB2cY2Mg3J/O9Q4W6ifrZdsQrN/Dsrkvr7?=
 =?us-ascii?Q?a9k8fbo6jKPnsOUx1NX7PBfLM69obrFBLMSt954PpxlI/2f1KhSd6LbNi8Lw?=
 =?us-ascii?Q?An74XqY/CAHz0FJWpLnXHlxO0tnN738mycZAkU9RDlbq5wg53FtRqUSyejNp?=
 =?us-ascii?Q?qeeIHKWCN9EeMvDJ+AF0ZENU+CtpTYpjgFZCQN57tGvKVnRIYLe5nBtQhjdu?=
 =?us-ascii?Q?WGt7aVm7UmcgA5BVBciH0UVWFaVo0JKgDbc3KV5lhFDNDQWkP856nYcGioxP?=
 =?us-ascii?Q?ZOprqdGBFOM4pABfzqunSTW8XMRZt28lZ9KMIEjlv/ElRoxZJF6kdchaC/Fa?=
 =?us-ascii?Q?F49Ac/qoW8EY8+f5lc5nvX7HoHU79qdGPjE9JKFwO1aIfGeGVvh3m5CzRr9v?=
 =?us-ascii?Q?BVd8jIotGMqnoo5DBhf2R4D2MWqIzY3q1R7FrYsptQRcR2INvMSqTvGg9VUh?=
 =?us-ascii?Q?aOi7bj+rk8baC7xXHHMNL6+q9qviPXpGehSiPUWGOOJi+c3GmehOHqakRxcK?=
 =?us-ascii?Q?AcBrkdBrGo1iWLT3bW3XKsSc/pB1qImMVP/WnaYfxJNwpWn/8xy8m0O2lwvn?=
 =?us-ascii?Q?F95YklVH/iDg79F2HDUEoY8/pBx3kJDOGCH+dmOI3Yppp8bgARSlrRGxuPQL?=
 =?us-ascii?Q?M8aN/MT20AsGPpzNWssKuHCRazDFetq5H7/8oaBIz95LR5hIJmQDAixfZM3N?=
 =?us-ascii?Q?b9LPQ1hP3WB7KwJnzyUw2d65Z5OS1RTfMasby9SzCFYKL+QBu9Pz1RDoYtBR?=
 =?us-ascii?Q?xsTwuyKn13dyqXQoHrLSkiS+ysPTf5cCLmg23qkbVki4fgVBAfzL/AyMI9ZR?=
 =?us-ascii?Q?98O81Cz3mp5FsIyPLT05shZN1IY+F4So17sqspGXckcQfvdvjODvTSW/eGBN?=
 =?us-ascii?Q?fqVSflhHGtMRavkjPUPYdGxZyB/mIkWt9O4vU42yelZgYWJ+14XCYXEwx8wo?=
 =?us-ascii?Q?VFSY34B81xUBUYompDeTzAjzbpsttglXRQnT53lrnKrlD67bomVNJSYnx76H?=
 =?us-ascii?Q?ninNyAwFlQSJNUGTpUYG7GOEcIpNJz6nEhm/3gL9ggFfThA7ftMNGDdzKt39?=
 =?us-ascii?Q?pHCd2oDdobuM0I5Mc+8KaAkfAw+HMWJK+/qB2m3reoXWLs9s1n7Yh70B78RF?=
 =?us-ascii?Q?jTidF/l1IEz62LQkq+PoaOTHkEP5bHUn2qQp4p4c6VuYE+DBErtTG7ZTgs08?=
 =?us-ascii?Q?flWDAY/sy5EP9R+9WXA8enCVOt0VBC4UYDfJdeM11Fs43HJQdj0yKhvNKElS?=
 =?us-ascii?Q?lDkH4YzKHuVrIDEVkoJOi7Ghn2cgKTuV1JEV8YoV2+onG7LDZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 10:42:46.0321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71005075-b579-4a56-6939-08dc943a627c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591

This series of patch add support for Xilinx QDMA Soft IP as Root Port.

The Xilinx QDMA Soft IP support's 32 bit and 64bit BAR's.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx QDMA PCIe Root
    Port Bridge
  PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver

 .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 41 +++++++++++++++-
 drivers/pci/controller/pcie-xilinx-dma-pl.c        | 56 ++++++++++++++++++++--
 2 files changed, 92 insertions(+), 5 deletions(-)

-- 
1.8.3.1


