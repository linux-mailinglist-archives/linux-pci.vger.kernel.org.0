Return-Path: <linux-pci+bounces-11685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8C695259A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 00:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E791289D90
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 22:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3095149C76;
	Wed, 14 Aug 2024 22:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aV7GENJ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86814A097
	for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2024 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674060; cv=fail; b=px3cPs++Y6zfllyC7jaQ3DHP/YhAjgqKjR7TEv2GvtqXmNM0lHtcqvm/eVF8N+9muP3imuz2qkVJ6+L+8TaPkWUOzBu9DBdFtHybiLOp7Gt/P3iEyozKCG1ne7i2n2TNjM0X0p6a5Z32c562v8e7re8JNkD0r5IMbr7lIrLCOWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674060; c=relaxed/simple;
	bh=XaeRHewIOdHSizo4YU6HUaVuKGMys0Yl1us2H9I2G8A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SW4mzSsXCKXELbjKOwyjsjKw8hubwKmPhkAUYXzZlssqokj6AMGtiAQcI1f33iNFV6A9LJPqvCggiHyDxvD1VHChIivn1oasqY3V19zlMIn/UZ6Fk9EopoasVFM07jAjwoq1WPFdEJoXy07ds6GaQfB/aJVMVYZAUjJJ7SZK3wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aV7GENJ5; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMNnth83k6pGKwEY0Ig2g3R8dyO+HbzGgyWVsbFvPn7dr9Vz3piXH+Bge6539PM9oBXKkHRnGc56jY2Ls/fXYG7iI2z616Yq/b+pSvWgFXBBIE9xZGyTs6Kyh7MBcqDrrt83mF4UMI96sTgW1U10LGPCTSwDkHa10DsY4vOOEuhHxZcpf4cJ1SF7MR7P8I2gRB3JpfekR07s0jEc0ULGqfyKin5BPxVH9mS5ylxOq4TG3Rh41V7kD9Jojs+HpCoh6RKcsldoS8LVhTZ8vJ5B9hu3ALzUJ4lUU0Kl+hcEqikHJg9nRqiPfwlJWcsHP3EidWrEmbMO1SpxWgAXrOLGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA3GZfMmYw1Bn3OoJ6lWCnIQtRBti7fhqiurhSmVJ2U=;
 b=wxf5yebyPwmu/8O7DWRmZ9DRhhLv+4Su37TbW1GLh6iOOzVOVUMHM0p8ftz3mr3tlVb0Eyh/jI5RlvVOT9KNQ0bSuC8vCiyA0PBopMhk2FI7P4yLrZngLJl8xBbN+3B4uASW4l3uKkCkTWkCLov0qwvm7MDJ7sukBEZmTE4+TIwm5xx4aqB4WEXuSTtpScE4RGKLxDfTt7Lk54cyB7B3d9TdQ7yYRYAWeeCUCB1ydSi25fD04G4jOKYZ3I0SysWPGS21QR8Q7ZGTNh5NRSYKZltMzM+m/ioRwQQkqj+W3o/EFKt25B47sB9VXpqPuimC+SJJrQovJu6JonvwHjDJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA3GZfMmYw1Bn3OoJ6lWCnIQtRBti7fhqiurhSmVJ2U=;
 b=aV7GENJ5STJii65sRtLaWmItAErccOoX5XbWZuar8FZwymDh+kGTzm1S6wUSwac/UOU3L2PvYvZBHEXtNkQ43RDNpgSvQS/tWzr1ebvVcPm9hJrA4gKsEUAiCsyz73wJd9o11OCzZ5A+uwTHb5GdkSyyMRuES+7F/SfIT6OfRkDSJA32w+Z8/QCFnQfTmKlS5RM/NK9G09qM54KrMjq/V4XAuvU3oryeTiYJqcxXmlp8YJFH5ooQQrctBbGfxDA/VRbWT2SQjulL5bw4/OwRsPdX5KeDAxNdKrG78bd1BpMyachl79WJK2Xc40tctkERhdLMUp9ZXGnnE8HzhSHRbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 22:20:53 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 22:20:53 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: linux-pci@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	kernel test robot <lkp@intel.com>,
	patches@lists.linux.dev
Subject: [PATCH] PCI/ATS: Add missing pci_prepare_ats() stub
Date: Wed, 14 Aug 2024 19:20:52 -0300
Message-ID: <0-v1-3ff295fa1528+d7-pci_prepare_ats_proto_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:335::29) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffb2c28-a8fe-4298-abdf-08dcbcaf5c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AyTX9gjbfANdEXKYP0QLPdWynEQHaztxgYA4FYJxYTsbxyxNIcfICaY5aoph?=
 =?us-ascii?Q?td/bKMuxjXy5zWMukwScpsbuOsqGmKMYdhNnZGLxFOOc9gXYDMshCwP1lhgh?=
 =?us-ascii?Q?xWw6PtCvuGLIXHgqqKQCAQLqPyqWbfcwrrk8eZgV3ha/9+jVKv1kAumYFZ4T?=
 =?us-ascii?Q?tQG4bRAepQNawAz8WuWx3LehN9yjaM+zIX1PEzNR38u4FkauitlKMcrhA9+W?=
 =?us-ascii?Q?V9rqc88pKH1LrkIV4zFffMg1UhuLy5ZPZWV8RJFdPPdAXPSrm2GRHDx+1scR?=
 =?us-ascii?Q?oG9hAiB9AQw6EF5hhmYnVm73f/ejo+FL6xYPlPe0RtE9cO+djlB6wi+b7X5q?=
 =?us-ascii?Q?udICWcdTor6kWuCxzRQlnG6T1PeG+IJuh+CrXwxZ9y1+7Dt4dVELsiE+BeXN?=
 =?us-ascii?Q?6bhBFstp6msF9Yxuu+eTql1eft06ey7oOQM9pRZ3TVabdWCmx75KgGk1xtod?=
 =?us-ascii?Q?9XXzjr36NOBZLOwS+ur7TvPtQHsaxRTGz4aY48B0zKt4fYaQW0T5s00Z0yYq?=
 =?us-ascii?Q?2XWFshqc5IiBChow9UufFGMqHVi0X92fUN2P4Fd7GOJnFaBFgSNAGIYaJMnb?=
 =?us-ascii?Q?GR0z5A1k6+gTnpsi6QzxbUI+7fp9syvz3eN14DcUKYHMKsw+cXhdSjxNdjtq?=
 =?us-ascii?Q?TbaTMKwYXDrw7fityxLowH75gCHNcg0VGqk5UoEMqhdPyULFb5SOMFqVW6a4?=
 =?us-ascii?Q?b4eLWbX9Cnd8MOBGKcKM2Lbrn1VETSDX/ExzY0fDcm08Sl6+DfRvKY5/G7bt?=
 =?us-ascii?Q?uoYWwm1/T0/t2tjMVoBr+btQN2BAFUn6K9Fiz+l+NmsDToD0yr5s1Tt44d/O?=
 =?us-ascii?Q?RGzCTXGLRgFaHeR7b+pR1zh27Te0DQEmoJq/QJnneIokKM0Mn+cfFcniNeru?=
 =?us-ascii?Q?JN7CBdtf7PeWsoqwlUHvFjGhZZczPR/klK2shvHOAwwow/JUWQ8GoQ236O6v?=
 =?us-ascii?Q?uGEXY+jCnSg16sPmy5iGn6d2GmOX0elSn1qaRr/aD+wcoJwtiZXg4/HSsvnW?=
 =?us-ascii?Q?gWb6mbOGvL7P9lk0rFtpsk7FSHzcts1+BKEbMf0MjpjkgOHO/LIr8QSWtkOf?=
 =?us-ascii?Q?uyPJdYIMNR15ha9bBXBzkNgMN5YUXtnwpXxJ5sp6e5iZsUZdH0N1SGfZaOuE?=
 =?us-ascii?Q?06i3dMZtLo2X1LMED/SLqXIxxW8qAOA8RL7AWm84/QNzZV4610Y8qCeBhgk9?=
 =?us-ascii?Q?N4IZVejvD2jfQjCFVSbpEATh8u8mp5nzH5QBHvbF/dlvwhRrGt1LrMSETdIe?=
 =?us-ascii?Q?JgPKE8QK5Tp3Gz0TtzcqITPAGRNethRsHllhsMrLIHZOMg8cjmZuK9r8EpjB?=
 =?us-ascii?Q?52if2On37kvry6EPlhKYni/RhmKG4TZuztWDcaIG0q1LEM0QcVfs7Xp2j3qx?=
 =?us-ascii?Q?sIrkUfs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XKxqFdrzCeA/YIUruMjaBC+XHfZkM2XdlV1xagXGs/xFLcji83OV/GiZYNsS?=
 =?us-ascii?Q?EXrdiBvfYvx6r39/zyJxERMFvhf16eEBVYeyToDkTFL64QXsPo+S7y3i4Lb2?=
 =?us-ascii?Q?l0Wur0PA+8glGptIkIkkcnGhhp5ZkmDtN53tqWYv3w0wnNWNwPqOBenmqV0q?=
 =?us-ascii?Q?3cknaM76SOGmDEy8Fn8pb26vkqXVprZjlNQZ64JiQYbjMmz8+I/GNbU4mTWU?=
 =?us-ascii?Q?mRlhpoxfBNR/00XP2BAcz+Gqfv0R4wEmsIM72a3sqML/vbwMQVEFSXuKaO+P?=
 =?us-ascii?Q?+n2KbQdWs1MupkgJoLo/g0QQse7/j/HMKrsOJgkj6EtrDdvUwptxS+VWwMdm?=
 =?us-ascii?Q?zuBSKrqGtxPFdqrSxqoyj26mrA2wpdzhPoFOG0fXvXI4yrePZwrPL0mZgLsZ?=
 =?us-ascii?Q?soJ1fKPRbSKF16LSksWLAuSKo92vwmRKYms6mMYdW3cxWjCVJj7Y1Bo+6k8A?=
 =?us-ascii?Q?TiNYz6vNPHMkhDq4GNebNVjXRhYzSjYjEag7LCmGAGgh8WqgOI9jbSXQfEFZ?=
 =?us-ascii?Q?fj+Tf2V3mKDBfsZvE7UWdn/fiKawgRZ+ZT36AKvkq70vKikSjjIon8DUgv5K?=
 =?us-ascii?Q?xwOdXl0sr2yDrkz4D9YyITaeXLxpnXd9s/ZRFFZi6Sd5PKsT7lVkwErjy48z?=
 =?us-ascii?Q?YqggqMpn0VwTV5f+YSBvRH+1IE11ZK9JCQ70OzU8g64KevhnCMzdsvuasNZb?=
 =?us-ascii?Q?ajNpegz19K+QcxjgEaeMyV1sQkUDOMXTHBn0RGzrhxjz/D+584sNjOhU0lpb?=
 =?us-ascii?Q?F7/M/vY9QsjUYGeiIjClsoMDond/gbBGZ/jFw5DeI6rUQQPvzbvgdEiCrdSZ?=
 =?us-ascii?Q?biW+s2lG8yHspPTjjck/LXs6e/aq09v+UKz4AMJnqV1QrTeomX62BfBdO5MX?=
 =?us-ascii?Q?dx5hIt4WymVwhWHd3YIgV4YrrNLBi/4YQDsd8qPT4l1CNItgXVakSAxRm9KJ?=
 =?us-ascii?Q?OwzSCkGwwtnKhiutfb+cnbusmoWPxgOFAmgK17BqAysaxSWeN1/Hf1QHjCbY?=
 =?us-ascii?Q?XiW+iQOSt5dvPIIFYibw3GnztqKreo+ijnOcdSEgdCDar2M/cm0UYRShQltb?=
 =?us-ascii?Q?cNeWLrkhVHltc1bzNoE7/vMSlvYsoFLmEQk0NGbkPdEUVdl6wDI6ingM3dI6?=
 =?us-ascii?Q?CAd+PNrjcANsiApuEBRak9SGp9Bmf5sqgCNrqbCu8udZzQBl8FRSeweO4OAV?=
 =?us-ascii?Q?SxHwaMxw6hQjT0wBCCbuD16h8drms5AQUKlUP5g6Q9GmO0wAzgCBwxU3D8AH?=
 =?us-ascii?Q?IVox/FZ8sxfq/sEHCTA+3FBEijIkbTJxPRG5KXbF2DwO9NHYjrAokden0c7l?=
 =?us-ascii?Q?aOzEzUy7v975ND1e97o1XRPNWObF+f8bonsmA28NvTd+dQFD46G/DxfEZ5Z8?=
 =?us-ascii?Q?AnAxneD8Nnqtv2uucufUfNNADusc4f8qxjq74Amu1inecYHdc1JLzq/pPgm4?=
 =?us-ascii?Q?kEzCY2Odjap+E+B+Bqt/RsIPVHwgRTEx5jFtS/sE+XqtyxL0XDrpQ3GP6j4Y?=
 =?us-ascii?Q?yAmMbjCSyQXDlHg90KtlOgyijOrL8e27ffJrlXmMWOiAJQcXXStgLneZLSsX?=
 =?us-ascii?Q?K+AUib+d9uHk1KlAdqA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffb2c28-a8fe-4298-abdf-08dcbcaf5c61
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 22:20:53.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiFC1xdBo3WL4IQiOcVuHk126x+cYXk1iln855NhICcBxqXgjyxMKLAetX++ftxy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007

build bots report that CONFIG_PCI_ATS=n compilation fails, the stub was
missed, add it back.

Fixes: 2665d975db35 ("iommu: Allow ATS to work on VFs when the PF uses IDENTITY")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408150626.4kndgpL3-lkp@intel.com/
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/pci-ats.h | 2 ++
 1 file changed, 2 insertions(+)

Surprised 0-day didn't catch this before it made it to linux-next, but here it
is..

Joerg if you can squash it that would be great.

Thanks,
Jason

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index d98929c86991be..0e8b74e63767a6 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -17,6 +17,8 @@ static inline bool pci_ats_supported(struct pci_dev *d)
 { return false; }
 static inline int pci_enable_ats(struct pci_dev *d, int ps)
 { return -ENODEV; }
+static inline int pci_prepare_ats(struct pci_dev *dev, int ps)
+{ return -ENODEV; }
 static inline void pci_disable_ats(struct pci_dev *d) { }
 static inline int pci_ats_queue_depth(struct pci_dev *d)
 { return -ENODEV; }

base-commit: 0fb4d2ab67703caed2b909d4b4f95d3afc56baf3
-- 
2.46.0


