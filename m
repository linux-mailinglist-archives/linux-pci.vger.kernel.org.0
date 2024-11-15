Return-Path: <linux-pci+bounces-16930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BFE9CF573
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 21:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFBA1F25A58
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 20:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62318734F;
	Fri, 15 Nov 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SBx3Q2O/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DEA1862B8;
	Fri, 15 Nov 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701067; cv=fail; b=q5M3dJ6GQKlhNEKzZHZT0BkffxwzM2GoeQ0KqBrXtGdCjk4SXO2ZbDMy5qq4TRkVmk2eouF3AKMUyvS7rSz/WmMsjiRykPSXbkGDgUW0w4RQ7XfIKA6XUcW3CrkOEQkEU4PdzFpzgLJHQ6Juz0JbAAotpr/uCvC/xdBhVuw2qsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701067; c=relaxed/simple;
	bh=Q6SJJlJ7zHBhKUqdGVaPjhA7mewritCBGxuVds0fO1U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bAaZEerxl5uDiveBWF3jWuWTpqvmHrB+dW4WTC6d1r3goutvTcqpaBynxvDM8tSzllpeVrEdHBD4Y+3gROvM41xWRuruD+gEVX3yCp72NIPDQeTy8GlL52d5AatLD2oNKqKebIcycbWd5oJyISvw9BjQdt0FumtBGm9HqxmErxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SBx3Q2O/; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cP1yPlPmsva5g3xwG2oUvmrv63YQe/Wf3RdV4JLXmHW8wV+TvvIgXl6ZGSnERGiggDuaESYb8q6M8NviOUUlecl2ACuWutAicbqq8NqRNc4E+0+n5u7BNJSp53XWOVkOKvItxEqcZ7opiW39Z+a2XZKN49Sn1GQlcIpxzTT7uKrG1UPwg6EWOPiHK/gvFlD4lE1cFkl4NHGIfI5wlG4C48/drW1amh0XHwDluRst2JX6asS8A+98jIaOq0wSfJnDE4VVr49Cl5czgKQ6YRiQpwCFO3z/rzI/UzSVILfMDpv49xn6ep0znW3VBZMj4Uk/RP8bCsriHVxKOU9b774/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nCgc6OdGGxtvmALUlv3TLbuzsflx2oxl8Ilruxm+bU=;
 b=zRIKy872nPW/YF2IizpfTeLHyoJsZp+IEBBYXaqMYDLYPM5z2JMT9AX/mhK60miYW7oj+rn3WTe5fGUy31E3LG+pBbPv6HN3nYdPAiNU+v1CWPFSC28lWtpDhnjpdMlSKC4IUCRFwqRXkEJNmpexiTJRpqezKe7iKNsn3LlTpcLSsuwBolp+9CP4PgA7nPsyP0hkhQKN8Th7jrmOv5ENuzMx8iJnMJbKbiZ13TapSlNbIeyo9ZF+c5CELqVxwxxddO7+SbodJ9+j0wM3y/IJEYGpVDcep1zsBsfK1XjTDwBvTChDI1/qb6+DorSJDLPvF7HZCA/7FltZZjSW4s2V6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nCgc6OdGGxtvmALUlv3TLbuzsflx2oxl8Ilruxm+bU=;
 b=SBx3Q2O/RguP9v/3N1nkIHL+z4pHZ4J6mu/+M47ZWLBLfT4XErNSSMAnx19Ie3OQlMuLSlG4qqNBlWy3vtATrvMkBLK8I7SRzYPGLoLFUpmek5YqUyMJK5HO/HG513WXyXKe5WPijwXk59kUQcqorduOL10cyLBIgnZFoLfqMGU=
Received: from CH0PR03CA0372.namprd03.prod.outlook.com (2603:10b6:610:119::10)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 20:04:19 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::2a) by CH0PR03CA0372.outlook.office365.com
 (2603:10b6:610:119::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 20:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 20:04:19 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 14:04:17 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <helgaas@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <asml.silence@gmail.com>,
	<almasrymina@google.com>, <gospo@broadcom.com>, <michael.chan@broadcom.com>,
	<ajit.khaparde@broadcom.com>, <somnath.kotur@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <manoj.panicker2@amd.com>,
	<Eric.VanTassell@amd.com>, <wei.huang2@amd.com>, <bhelgaas@google.com>
Subject: [PATCH V1 0/2] Enable TPH support in BNXT driver
Date: Fri, 15 Nov 2024 14:04:10 -0600
Message-ID: <20241115200412.1340286-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 460567fd-6516-44ce-6282-08dd05b0b0a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LgRlAX6qE5jKl3LFUpMcxCRA4Pqq6MU/yPGyNIqpx6NIjUvUBnGXme26+X5k?=
 =?us-ascii?Q?C3QV1HnahbXVJv3iAf1Nv7TS0Xvy8/ALXwCILIzYNXylszyyZuLfEbN0XLxp?=
 =?us-ascii?Q?uiBOCDyTPdCK0BXKvXEcyx8RF6E1pkgFvupqDiZGX8UTnTlK9SuXlnvoIbKV?=
 =?us-ascii?Q?ffa4e1ldJIafzYvD0P4ue253Gah42n6drr4zZOaT3/AZWST4iYacICKIi3ea?=
 =?us-ascii?Q?fuoThTkv7cRgCILHTY+4WrPtwtzSTSXuVFa2WJWiGrniC1Rja7cCC7BH9SCI?=
 =?us-ascii?Q?AfF2+ik5TlKBbCgqAeLwQJv1aK/Oq+j2VCz1RF/GGEssVMKRSBNYsfRhU7sE?=
 =?us-ascii?Q?EVsQhxrTnFK3BDakHp8mWGFRXW2+jXLx/elHYTpfW/AyeedTxWtTrG8YtVOe?=
 =?us-ascii?Q?tWfU/XdfaqkvoorL8dtYaXSPdNQoH5e276PUV6nXZCQoCB98/rRnBPT2U6cE?=
 =?us-ascii?Q?KQLFLZgepmBgfTx5yTezO5wFYYs27tcK8WvEW2C8peQEX/lExTs7bGfinBpK?=
 =?us-ascii?Q?OhL/ZejEBTd98jFRL7qCB1vCBvmP87tyvXAia5WLSG3S4cfLNXZif/OjudhI?=
 =?us-ascii?Q?bsNQPoaO7eWU1JNekshnmOc6OiTknM17tcc99XnfkCK7Hu4ExhVhB0ysW8P7?=
 =?us-ascii?Q?o7SNg70XzsSUrqBgcR25qK3MZ3T6CM+/Qf0/Vro142GgaDIPFW/gX0z7grTg?=
 =?us-ascii?Q?knSW25S5xzamaiMQr6H7buL0HuDGZ1a2f+GG3aH+hx3Mp37oCq98K260SVec?=
 =?us-ascii?Q?Cu2Ng4aZZgtATviQ9CTzRFhuyUlFCD8B9GMUKkBPZQBge3Heh1DGnT99b4dS?=
 =?us-ascii?Q?WrEuI8T/RJPiif+MSJn2tumrjx++kkagTK6jgQEXaGjOqZeBVVLTy+LZZtMV?=
 =?us-ascii?Q?faxhumhnw4bl4cg7zHb7CAQEN5GRf+2IZXpKUqO72FBf5xH/18kLwjuDS8S9?=
 =?us-ascii?Q?GurWYFl8eCJBmqfoF5XQyq75EfaU5EpFBwGTVfXGPUlXrWz9AwMAlF3DSn7f?=
 =?us-ascii?Q?6u/UhnIgAarWjktdO4A5qOjfwO0uvKI4A1TwpSo5KYSzbve1xIaYWuyC1/kV?=
 =?us-ascii?Q?c2rKNxZTUY/Ngx4EBbMGRNuZMz2aQWwCdxwiGOgkZT173hmKk2wYIy55jGxW?=
 =?us-ascii?Q?9yyoOc04IT8NUNbn+ykL1SQMWyJYGZ+TajUZbmIFhcgTg+jRSd//UCblzU/E?=
 =?us-ascii?Q?8DL2A+lVu2vpQ61UXSbAcdalh/3r7FyHDbtkoH2/eYh4A6w64z0KPPW+/2rC?=
 =?us-ascii?Q?ZhtEHCDEaPFvhLRC48lHeAnKnyfvvjiUQ6X5yqYszAkSil1S1SYlcUbHpEK6?=
 =?us-ascii?Q?PhKRsnMZ5RvuAnnXNDOMAFuK06GW+8LkkPSBFkITUugd8lrs42HljJcuSDXH?=
 =?us-ascii?Q?iS9piBo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 20:04:19.1461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 460567fd-6516-44ce-6282-08dd05b0b0a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684

Hi All,

TPH (TLP Processing Hints) is a PCIe feature that allows endpoint devices
to provide optimization hints for memory-targeted requests. TPH support
is now available in pci.git/next and ready for v6.13.

This patchset enables TPH in the Broadcom bnxt driver. Through the IRQ
affinity notifier, steering tags (ST) are updated when the driver's IRQ
affinity changes. On Broadcom NICs with compatible firmware, this
implementation improves memory bandwidth efficiency and network
performance in real-world benchmarks.

Note: These patches are follow-ups from the earlier TPH enablement
series. Patch #4 (IRQ affinity) has been updated based on feedback from
Jakub Kicinski. Since net-next currently lacks TPH support, we propose
these patches be merged via pci.git/next after review by Jakub and
others.

Thanks,
-Wei

Manoj Panicker (1):
  bnxt_en: Add TPH support in BNXT driver

Michael Chan (1):
  bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 111 +++++++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   7 ++
 net/core/netdev_rx_queue.c                |   1 +
 3 files changed, 117 insertions(+), 2 deletions(-)


base-commit: e031efeb3a3a65673086d8f148da53f22c6f8ae5
-- 
2.46.0


