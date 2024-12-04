Return-Path: <linux-pci+bounces-17620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0925B9E3163
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 03:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4174DB23A90
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 02:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354E17548;
	Wed,  4 Dec 2024 02:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oJSPZM2f"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B13848C;
	Wed,  4 Dec 2024 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279115; cv=fail; b=AaO9W0qaPnGp4WGYobR8XkECHoOxe9PrVXRWknDZUD1qmDA08Zuqj9bYepQFbzvdl47481Vaz48fmWIgaepbTW43cNsHphxCLa+mXn2gvLcllswHZ4dLuXF3Jo5BR2RQKRoyg2IO9unxqdJNnVcadjkvy4Xf3MxP0ICuuRJrGhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279115; c=relaxed/simple;
	bh=J9bkq/nGib0i8i1OVdo/qciMU+XmVdJdXUDlxBumTF4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tJ5m7GONZFfW7n408zVbQR+9eIp6SCfXukpUHVSkcw6eQUPSJ2Ip5o6pbU2MYE09EzYjnlKGJa3W3p2b8VYAEpH/iLFsg+guEE0Xp4s9NzOhNrqNml9AFG5OdU01RfZqvfHTEEu5emlwvVf7FqZlWWjPt2vRqFOOmNE8i3pMcM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oJSPZM2f; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqvuCefgcyxWHyiUfpjGypxgUWMlDxoEhMe1KQw4/0CMpLwiTRvMoCg2lFjwaV5tdcb8eNyDxN5YenVoCAzX1LnUEOFLO8z+CC6DnxxOPfhoP1RrnZpk/Fepcx42Qh+ej5U+REB1Y1BNrC9ZDSaAGLkFJ6CzB5pHb9G9PaFOO8XpR1w+w9EvClAXw+/x7GWmXQTnF6Hlv94JJMcFhkxQNp9HUtoycLjoVq+gL6/8AsiUJLeVqSh+Y+u63apZGdCShmzOnss/ZlMolFUYgg8ipjMLOc+JnG/KozfYmLLPwl59rLzG9iKqzYYHTdnB6MAOSIt2cc3F1cLiNBTqOAZlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Sw+qIvZypGRapyMajRxDKrksCmztBDt5ptWqdGB5es=;
 b=QdWe2mIpV6+Hz8DJJleDczyPBnrAJKU2j4hKjXVYupRpXKxjZpUFEeCqgeabLsHW4uu0taZopKLXW1VPcK31zHrLNqPDKDdDxegrXKEypOx6RJW3x4uMamrH88P38Ospjhqe7goCJ7la55cEF2pAEqqv5dJpoXDjZT/JtvzJ2qcSOVk4ii9xh1N8shgh7DGGtMuX6MOu1Al09Rb8hHIyOBm19eTd+PhVpVRJvK8f6V6saPMTdk1PQW4pnimK1REXtZKtPg34AJP5kFe7ij7o/HAYEpQbgrwbM12bIwCiOLM3P0s2RYaog7E/CaeSEkMIt4wXNiORGP7voHJ4RsQNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Sw+qIvZypGRapyMajRxDKrksCmztBDt5ptWqdGB5es=;
 b=oJSPZM2fH8ZRXG7WLTxIc3FZzBBwKHhx5waSmMbrdyqq21slcnSdIls8kRFg85uVo90Gmv5EOkPRtBWGHW41ge27bWPJshQ0o23/lZ7xmFoxF68CUHuu0yYePxqT2sG2pggGE+d4zdg0IfFBGo5HwAY1KdHti7rl05XxOdo2rpDDMf/+2BUqJf4BrAYPmrUCN6atrnj6aCC7utQcm4l1rsnS+5ox6wTW4+ckxMs+AnCUL6KLwQ0pnENSbIbgAeM2mrb43NT4AfV6E12ipkSQiZzZ8VlwnwuQvM/iRL99maBqahKh2dJFJ2PWTQiZqVZKWuw0+w2Vac5T0NQkEZY6OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 02:25:08 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 02:25:08 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: bhelgaas@google.com,
	mika.westerberg@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Carol Soto <csoto@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Chris Chiu <chris.chiu@canonical.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>
Subject: [PATCH v2] PCI: Use downstream bridges for distributing resources
Date: Wed,  4 Dec 2024 10:24:57 +0800
Message-Id: <20241204022457.51322-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0045.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::16) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: d5415e4d-e537-42c4-e8a2-08dd140adf24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rmRZv5K6NZMIEo9ySVGfddCAB9NaebE/9BSEU/1sOdXJRG3gijr4CT6h1Ov8?=
 =?us-ascii?Q?z0CWunLFweEFQGzYvl6D2wKdhWJvc7ADTpKFz5vl2E9lOQ1j827qhH3vGNh0?=
 =?us-ascii?Q?A5kfOWst28uRgJu9vYc1uR5nOeHGyyV0M5EmWua8PqE86VQl49gx6pInXVq5?=
 =?us-ascii?Q?NEatsGuulgayxrdMuqfopOBrZ1BHG8w6+g94RH8h06NwTQdz6HK8Ju377v7e?=
 =?us-ascii?Q?nL3WMkmq++xU8Va+Ybcom15VEH5IjjH7a8lNVXKDPKOiPLqz2Nnv7M8Ez1+p?=
 =?us-ascii?Q?aKOXQEUfdHe3Oj/Fm1Fc/z1pHPkvAjMjwZliFoE2+hcGSKVB+ASrLRWNOdkz?=
 =?us-ascii?Q?6TkpSx48VlTgaE1lsWlygxgr6Wv1HShl6tQXBizJkqGHc+SLXa7GzcS42ZMI?=
 =?us-ascii?Q?hg+KCap3m078oGOjz1gCiaWknEAesNQRViAmway6eNaYGZ670iKPP7LxWcls?=
 =?us-ascii?Q?ighaIqdjsZdnUDQiMZOE19DvCBFzuCnQQv/SoB7ncEL3VZJ0l+wugEi/3JBY?=
 =?us-ascii?Q?BiHtPZQdwgCZ91R5hdYIrKdBZ15RM9nzWnSx1eFDbDkB3v57BX5Fn95ObjCy?=
 =?us-ascii?Q?/GaY6eYrALnaDqITsWQdSu8/rrh8VaUNd31yTfLvlPeKJ+zIAgzcLfSR1Rzc?=
 =?us-ascii?Q?IU/wqreheTRKN4/7RoFduVWMrz0jA2dV0L86NN6qTHHxqgFPR/vINxq9fw0J?=
 =?us-ascii?Q?OSElUYv2jyK+fsqUVQ1jLHqXIrmhIHjV6sxtUW8SIN7P2eQTZcFjRAOVO3In?=
 =?us-ascii?Q?nyxF43UBWdh5NROVBRFKgcrK9qRHv/syV24CVM46XsHSNi6aQmbcLb8eByea?=
 =?us-ascii?Q?XZt/1xlEL+w5AS5Ii3YK4onSmxuIK4tw0+RkmFtzfS1IP/rzWihA2UuN63fH?=
 =?us-ascii?Q?tMaHv+U6Q/tRW4Ps2tsvwMWvKf10Mclb+Y/mOXoy25spAy/fctr3NkW6cCNL?=
 =?us-ascii?Q?15SiiIZTt01Iu/jU6TDh8Aqb4EirNXsMoYaJYOLyxLoDsc4FGjx35W/GS3VK?=
 =?us-ascii?Q?KV2Mm/mjCMTsGX4QLsw4JU6Hppij3LjbnE8JSRtfFX9VQKCg0K0BxRxEbAvx?=
 =?us-ascii?Q?ndF7QcjHys8idPReI2zOFsFs+3UxMRfknw7M4UeYn9GJ8FJzIyZxXKfHLvka?=
 =?us-ascii?Q?DuLRQCOkk8Q8/OPo4cMjpD6M4RSEeVX1qPkgf0eSvuxgKo03nymvt7gVmAm9?=
 =?us-ascii?Q?MfcI7+3eJhj6/IWbTLMAtmFxT1kZhtNgtDguSM3OY1CPX5hDseuFUfvOK1lR?=
 =?us-ascii?Q?D+4RisLebqSDAXXaQ+YtXv9kTbLAHgoy3mL/US8IIiqJbAegCRY/zHsZ8fTW?=
 =?us-ascii?Q?z5zUd0KUQnnJiBKqyHFMY4BbofGqzRHY106B1qOYeMmFFJknyY6cw9qDvVPb?=
 =?us-ascii?Q?pMoqJII=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6OrqhNxvBiPNVdzBaHJrumCpeOrTbcP+zurvOI8wrnibDP3IkXHeYTLdD93X?=
 =?us-ascii?Q?ZOygWG80Ip3jxb+XBF3wrz7Q0uS/mOS4GMxkY3AGjv6pKM5y8WG9hG1G94QF?=
 =?us-ascii?Q?PzyWzMotjX4qaVEAma5kVuMZYbps2FMdhXy2g8ZlD/Aeu6Q0OQtVOSnyXyQ0?=
 =?us-ascii?Q?NyTAfi2T4P97+rrZbRt0UiCKdTcQecWua4h44yCWCkTqtw1AAoL/SzcsyuSm?=
 =?us-ascii?Q?SuYwGIjSjTidFDOhBD9lnpUmerCzO0uirRFvw37h4tHsyhIkh58AJCADJW6P?=
 =?us-ascii?Q?SajlGhECK+2aOV/95Waxi4kmTzWEWU8Z+wnpQiOxHnBuhwQvZ7wdoiD1UY8Y?=
 =?us-ascii?Q?SQgu5VZ11cbn9Ck1jlKJpeydfvv6QEbRppRj0Zlp9+fBr8xvC4GiGI/eaD7f?=
 =?us-ascii?Q?/p0ER15q4FZl3ybeHtUPtxD7XTZW8Ls2wJvAk+pUnBx0WkMuhrsZISTpnnhJ?=
 =?us-ascii?Q?D4OcvS2DWN/zUw/XfwSymA+rCU+XA/UJYxVr5asqsUP0RukiXmwGD/BHMHOa?=
 =?us-ascii?Q?us47Nr+NklxCIXpoGv4hD8xuSodNLnljVjN2YKaM8tkXWy4cbS+fOXmPR8Bi?=
 =?us-ascii?Q?d7F2pj3yX+90bwXizAK9rZliz+OPqfpN/irpcswF1vDNsYbodIcjk1IJw1wu?=
 =?us-ascii?Q?Yrfj9jToM32tzn7kV58/5dXyr7utWrkdwHS2OFI5YFQo6Ats4zlrV4KpKKvm?=
 =?us-ascii?Q?Ajc4swYmKGWsXK7W6LCS559v5Dm4FXaWaNDpd64og3/83FbD0ZNbZzA/t/Pe?=
 =?us-ascii?Q?CZI9dmwBf0AOqFgq2MWdp7EkcUh5LI7q4vMalQ+qZaVyAQHH1Q51bnlB5zGe?=
 =?us-ascii?Q?lsynPpP2rWGxXcFtxZiq6rfFhBldHUvp8dhXK2MSWM36a0C7pqXJ/VH7w9Y3?=
 =?us-ascii?Q?oXVzMoZMvcYMLAPe9k/CmU1LkuidRADUPQD8mevDUKDFsv8bzILki6A6pt2e?=
 =?us-ascii?Q?gvpP+lcbVUh79c0DWbJU0j3sm9BTqW5Ow7mJUP531NdEogdJvnI+N52+EtAY?=
 =?us-ascii?Q?WpMFl+Z0+p+SU9itrDWhKA7TrnowIktqlS+0AycA/ViS1E0U3S+VTRQajmRp?=
 =?us-ascii?Q?ACK4yRbeVuxTztifLTiZtN1JnIjiOFPoqjvzy0tjBL8cKnftTVQ+VakSZZN8?=
 =?us-ascii?Q?mVe4/3ndnmhQ/gcVYZ7jtc76UNrJT2r0LYhyJFvhQqO6cQIqzpExOxzv2qGF?=
 =?us-ascii?Q?QXPJ5XmkrSE+vz0dQ9dSp8FjXeIp5+R8oULe0zwnERZ4ZnzD4oY5NkG7BlOU?=
 =?us-ascii?Q?9uNIiPg3VQ5WsM+PrnNbUKXTcoDYKcXmH93txFT7DsAT1VdWEmMDbcvIuQMB?=
 =?us-ascii?Q?mzZJ+2uBeHTZhX8rD6sVxOYySpiETqBo30W+BevL79WLuGkZV16a5AWL11Kn?=
 =?us-ascii?Q?19iaQB4K0LrzP/YFhffLElNIJowdH56WtMGtF8+aras7lHfT6M6sAMko6w8V?=
 =?us-ascii?Q?VZFJ463rQkjh7NemgeD5gybfpMANLmwC+vaHtTTUgyzTQgTK/IqwB2RYOseA?=
 =?us-ascii?Q?OBq+NZlM/OpCpyOp33rLi6ZsLx5fDlTum4AcGzVxfB2UJZX4EnenrPtYJKCG?=
 =?us-ascii?Q?XOaSaLivd4p+T1vOse7upCtFtJOk+U7BVfARg6vv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5415e4d-e537-42c4-e8a2-08dd140adf24
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 02:25:08.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaZ+Mpcdd7S2SgSNqfz8NltZHtk5Y9YFfk7+B7ryO8JLf35OAAoO4v7uPPlLPIKIH3ibbRFiNOLSCf0FBWG63g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454

Commit 7180c1d08639 ("PCI: Distribute available resources for root
buses, too") breaks BAR assignment on some devcies:
[   10.021193] pci 0006:03:00.0: BAR 0 [mem 0x6300c0000000-0x6300c1ffffff 64bit pref]: assigned
[   10.029880] pci 0006:03:00.1: BAR 0 [mem 0x6300c2000000-0x6300c3ffffff 64bit pref]: assigned
[   10.038561] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: can't assign; no space
[   10.047191] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: failed to assign
[   10.055285] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space
[   10.064180] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: failed to assign
[   10.072543] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space
[   10.081437] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: failed to assign

The apertures of domain 0006 before the commit:
6300c0000000-63ffffffffff : PCI Bus 0006:00
  6300c0000000-6300c9ffffff : PCI Bus 0006:01
    6300c0000000-6300c9ffffff : PCI Bus 0006:02
      6300c0000000-6300c8ffffff : PCI Bus 0006:03
        6300c0000000-6300c1ffffff : 0006:03:00.0
          6300c0000000-6300c1ffffff : mlx5_core
        6300c2000000-6300c3ffffff : 0006:03:00.1
          6300c2000000-6300c3ffffff : mlx5_core
        6300c4000000-6300c47fffff : 0006:03:00.2
        6300c4800000-6300c67fffff : 0006:03:00.0
        6300c6800000-6300c87fffff : 0006:03:00.1
      6300c9000000-6300c9bfffff : PCI Bus 0006:04
        6300c9000000-6300c9bfffff : PCI Bus 0006:05
          6300c9000000-6300c91fffff : PCI Bus 0006:06
          6300c9200000-6300c93fffff : PCI Bus 0006:07
          6300c9400000-6300c95fffff : PCI Bus 0006:08
          6300c9600000-6300c97fffff : PCI Bus 0006:09

After the commit:
6300c0000000-63ffffffffff : PCI Bus 0006:00
  6300c0000000-6300c9ffffff : PCI Bus 0006:01
    6300c0000000-6300c9ffffff : PCI Bus 0006:02
      6300c0000000-6300c43fffff : PCI Bus 0006:03
        6300c0000000-6300c1ffffff : 0006:03:00.0
          6300c0000000-6300c1ffffff : mlx5_core
        6300c2000000-6300c3ffffff : 0006:03:00.1
          6300c2000000-6300c3ffffff : mlx5_core
      6300c4400000-6300c4dfffff : PCI Bus 0006:04
        6300c4400000-6300c4dfffff : PCI Bus 0006:05
          6300c4400000-6300c45fffff : PCI Bus 0006:06
          6300c4600000-6300c47fffff : PCI Bus 0006:07
          6300c4800000-6300c49fffff : PCI Bus 0006:08
          6300c4a00000-6300c4bfffff : PCI Bus 0006:09

We can see that the window of 0006:03 gets shrunken too much and 0006:04
eats away the window for 0006:03:00.2.

The offending commit distributes the upstream bridge's resources
multiple times to every downstream bridges, hence makes the aperture
smaller than desired because calculation of io_per_b, mmio_per_b and
mmio_pref_per_b becomes incorrect.

Instead, distributing downstream bridges' own resources to resolve the
issue.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219540
Cc: Carol Soto <csoto@nvidia.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Chris Chiu <chris.chiu@canonical.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Fixes: 7180c1d08639 ("PCI: Distribute available resources for root buses, too")
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
 drivers/pci/setup-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 23082bc0ca37..a6e653a4f5b1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2105,8 +2105,7 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
 		 * in case of root bus.
 		 */
 		if (bridge && pci_bridge_resources_not_assigned(dev))
-			pci_bridge_distribute_available_resources(bridge,
-								  add_list);
+			pci_bridge_distribute_available_resources(dev, add_list);
 		else
 			pci_root_bus_distribute_available_resources(b, add_list);
 	}
-- 
2.47.0


