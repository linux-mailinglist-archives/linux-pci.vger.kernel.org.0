Return-Path: <linux-pci+bounces-25772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C028A87612
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 05:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AF616C44B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84751865EB;
	Mon, 14 Apr 2025 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ogmK6zHZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D228EB;
	Mon, 14 Apr 2025 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744600141; cv=fail; b=kggyIQFjmHRRd8tupuTLxs6h9DL6/2Fj8Fp+Z2k+PhIK6+nQspaetTu5DqrvZtDUd1FUos1GNDcDzozHO23pnzbxCVUSDZgONpI6kOgDJQrZkULIEpwfqPgnwz9yDCOvkARrQSWc5WWx5/b5SOr3yzkHSdTpl9LPdeXiYmnmZHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744600141; c=relaxed/simple;
	bh=hyryQGVNl9jnenAlsw5KjBIX9ioJgHFs8BVk86PTBLM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GIkcsGL5+Bx50JUU9rGmQhstcVDG7w2tRPhxnasLUahkrAluX/7F9Cx27c7E41Mg3w9OYcMIiaepA7Eg9GbSejzG5snqY383N26GhMiHdP99lblAj9Qr+0pSoOnHJEE+A0ey/WjRwOZO0xe03gUp9S0HIeaH1z8RlFAK98qNLYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ogmK6zHZ; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFAL3cJZR7UUSygcqMTSu2Q8LPbcu55q8x3ZgcNxcL8y15Ygx4tsbpFjsi+7FD7FNrJDY/TbU1SuGwnz2ylfyq7l2M0h/gGSHFO4WJLYntTMwiqVkgjCHjThZPsVwFMEWBqhhFTAxoBghiyzQ53uC2tuR93a/fGwsrQtr0bMOl5Z6ORWtPujIv++JjaAZ+xYBqZW2ZKejk4yLkXI+rBy8eogQL7D8qq3ay7NbT3njsUEQuAetao/HLESXloJlhCS+0tumPjkk3TGOHd393DzczOtHoGvQMgEieRpsAv/byZNjayus6Iq7ZMRACotp3bwBw/9FHmUWj0ly1p9Ib52/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oglVPY8ihSiT3PY3Bxz0zpCQIPEC+2NQrl36+6515yA=;
 b=K4lp3qs7LbAwj0OPkvEKVNtkdFz3JjpaFBYg830RoDl9Ni2OxfmE6s+wwJ52KNiWt4uDo0BnxmECxv5jjU+pkKqYAKlsaxqdw7yFH2uHduHg9M/4px+B1EU7VS0ziEK40eQkxWjGpAmVm6cgvqLb1wEna61IyLsRNkILZy7lx5GI/oTz9kbG+bWwW//AuchIxEzToFjebF/9VPcbmfN8ik+1+/dUD/IcVVClkZvGEV/DkOk2RM4es8uiq9sqYXbQAVtYENk8rJ41vUrZeMYYpGPvbuFC06md0cnQKBA5sdeEhgvbJZrDiQ11bePKR7jbNEQwZJvKBz8izW+9wDiwog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oglVPY8ihSiT3PY3Bxz0zpCQIPEC+2NQrl36+6515yA=;
 b=ogmK6zHZk+gHIHc0GXfxsDOY/4VHW8AatnX0IoBoAAheMAJm2LKoHKrsn37tnldRSLyHNDeOcOFhE7Wm/HvTztmUpK9s+hJIx6ya/8hCNAx87py1ZspjuvmxTguYKKqPqcOnSiGzXVLT/xW02TkMKRjNaPxuliH7RQFt27thKj4=
Received: from PH7P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::6)
 by CH1PR12MB9693.namprd12.prod.outlook.com (2603:10b6:610:2b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Mon, 14 Apr
 2025 03:08:56 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:510:33a:cafe::88) by PH7P222CA0011.outlook.office365.com
 (2603:10b6:510:33a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 03:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 03:08:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Apr
 2025 22:08:54 -0500
Received: from xhdlc201369.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 13 Apr 2025 22:08:51 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [LINUX PATCH v7 0/2] Add support for PCIe RP PERST#
Date: Mon, 14 Apr 2025 08:38:40 +0530
Message-ID: <20250414030842.857176-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|CH1PR12MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f695f5-90b0-465a-79b3-08dd7b01b198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TH52HhSmFu97KbpZX8rtxclUyNzzBWDa8Mk8btkwImFYM5n2pNMU02stJDLG?=
 =?us-ascii?Q?r4wOvbb5fVjTPkbycYzvDVN+18gIj817rRf1zuciMQBQZyoJ2Dg8nt6hL09f?=
 =?us-ascii?Q?lom+NlgPoyz/n3hNEOU4ABIvIxAQ/P8R+8gmyJ8L26XuiIm3Psb8BdIIbTSr?=
 =?us-ascii?Q?WKaZPWfiWliPYTc6O48R0uB0XKHJjmBQ3HVFdPmu7Z6kKfVopkl9WAi860i2?=
 =?us-ascii?Q?COMzs8XMpqH6h6N8NFUZdKCcdQIyW4hhsOiR7ffcIPr2zCe01pcEttcsToqy?=
 =?us-ascii?Q?kuD1Z5mfqb6reeFiBCyfjXCGTMwk5bzVULY5Zaj4s8amsQ7AEMZHBblIX1fA?=
 =?us-ascii?Q?9tIG+xkXEBm2Wy0epjNqCK5Seq1fNiRPPyvrpSO6tn7imX2u4BSA1NEIjsrr?=
 =?us-ascii?Q?TehiYBrvK5Y8jXqo5cNw3z4+XaF66EvQxBfBr7xF962C/Hg4QW8BgTfleBBD?=
 =?us-ascii?Q?o7uRKCv7ghnDETUFNLJ/xhX24ojBeVy7cdC/W6FrDqLa333aILG1k0BSXobj?=
 =?us-ascii?Q?jiIkIYgB+BhtGn+9ek9rE9siO/+FIev6ckhWzWh/sxNjqt4ZpKXLPpr033fa?=
 =?us-ascii?Q?Si1/grNrrxASgQ8bVzxmJC9ryYYktQMlJAiIWXEw2/gw2Hsn21FvxDdjpTWZ?=
 =?us-ascii?Q?RxLDHtv7ri4nFr7nE2MGSMMZQ7G6IE7ugwkWdZtiZITia3Lk0dIrzNfjIZrl?=
 =?us-ascii?Q?7nffbvIMOwzj9Kihh+ob/CGDlwUM0OzVUGahbf3yBHFfAzhwcIKMuiqtXSQH?=
 =?us-ascii?Q?XdHqX2rVSe9hH/e0PJ7/2wWWTSffzFBY6+6OQ+0ghlKmdGgRfI1aeFviWhrT?=
 =?us-ascii?Q?4+HtI5nt2FcaQPE5+FtWcd0x6ARLT1IFFwfVtYBy7xqgA41l0uIvmhTNA7ST?=
 =?us-ascii?Q?gsmOjOEM1gOu0mtCPbt1v4Kh06pTn0ud94lhXkuaS2gmAEMSmebwUOh+/hNa?=
 =?us-ascii?Q?hQBbTpfUXYNOsc1jFZuR6ENd+HtRVpP6stRakF3p4vc+v4zMdt2uoVK0/hfB?=
 =?us-ascii?Q?RM6qLUoPTpFLcVSxX8KN2IGMfVucXHQq7DNnXMf7HrcFUWP/nsW/is9yUrl9?=
 =?us-ascii?Q?iuacof2I0rGn8Rx69V/tJ6aDPLNVZOrahvuUKGcMrkVH2chcIaN2RmgBzArf?=
 =?us-ascii?Q?Krhn0ygkR6qA9B+kCT9Y9flh1qHR8k+yp8Yk2j0tyxcXSLudEFYvb84m24MP?=
 =?us-ascii?Q?Lw7Wg/g1d/W4ug+6p1yF7RKUtQrW1rzswKMmGyOOKQVhICYXUT764pjBqlJ8?=
 =?us-ascii?Q?/DmY/5Csfn6JJlUlVgKWZseLIEkC5oyofVkgzG+fF6v4KQPKLc0/Qh1zxPVt?=
 =?us-ascii?Q?BXZAk61vDd+mrhtQmSIAFSe+6ELxN/wgsFae+mM0b3/STRsaT9PJ8XN9dcOB?=
 =?us-ascii?Q?w3Q0vzhEJuiZlz0PRCGgYSbDF4dYBoJtvYBoOJ2xbwmHTx7UCAf/+ydvklY2?=
 =?us-ascii?Q?XaSf6w9n/7r1PbY9G+/jGMHYfFoUEGfYY+/5J1phjLVrxfoFpN6CtXJisaCZ?=
 =?us-ascii?Q?8QOi3g2IBIkJsKFgY4ecvAr8mlDcMyaZhSEm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 03:08:55.9659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f695f5-90b0-465a-79b3-08dd7b01b198
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9693

Add support for PCIe Root Port PERST# signal.

Add `reset-gpios` property to the Versal CPM PCIe controller example
node.
Add CPM clock and reset control register base, and CPM5NC firewall
attribute base.

Sai Krishna Musham (2):
  dt-bindings: PCI: xilinx-cpm: Add `cpm_crx` and `cpm5nc_fw_attr`
    properties
  PCI: xilinx-cpm: Add support for PCIe RP PERST# signal

 .../bindings/pci/xilinx-versal-cpm.yaml       | 129 +++++++++++++++---
 drivers/pci/controller/pcie-xilinx-cpm.c      |  97 ++++++++++++-
 2 files changed, 203 insertions(+), 23 deletions(-)

-- 
2.44.1


