Return-Path: <linux-pci+bounces-20260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C7A19D59
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 04:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FCFE7A1493
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 03:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C78528E;
	Thu, 23 Jan 2025 03:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UnvJlXVJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517BE83CC7;
	Thu, 23 Jan 2025 03:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737603468; cv=fail; b=j6mTCoCWPm8BcYDSOTm1jqI/2SefKoqwRuAW6uy+TR5164WrWRxu7FYQhv/dBPeyDE2kBHpF5cHegZtWwWWIl4AcX3nuw3nJxzIe7xZlfDNjhq/1J969bISgJgiO27jb5yDZzkJApKkSqMCPB1nH8X863p6H8s8GhKUdGVx7O0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737603468; c=relaxed/simple;
	bh=6r7abeHOFiIatiPuqwPpWEIJ0Rl6EPfbls9wDx8mTww=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tq9gO0H7ccv7PbW0M6hrxhPdSx448NmzG71UI0ZU4qOKDvmebovMxZm6bB1eY/UFoxsmdLk3HJBcsA6dc1+8JTeFPktgwu5ArAL9YQTb3IpDJRv8jyfohR67JdDFQI75y8aQNIaDngRukf17zBu1lDAmsQdrQduo8yWpkzsgB+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UnvJlXVJ; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9exQpJBKy2lulF9bBSuJFx7k7coa+o5MDgFPaeejbcURFg77bnuu3lwI0rEVXe0OwjIrDwPOQgz9EfmmfKoFnh7UVvh1KaP91GmX2zdDFTJCgmxk+6IOc0mYZFb0iHvNnU2cM6oxIkB94Eln3xUoeVpqr8xJcPThcbabR3+4R8PU9fJ9hvSWqd5hb/dGgufNu8C6eKHNBPHbGTjFqcKwmouS4ITkOg7eRNvvMBc/SJz6cIvds5QKp9czak/X3Q+tNgCfCNTi/3HDz1ZTvCOX5YwC3zl/SCzkQhk++HTkq90EdHgUvfOsyqYMF4O3TiL2bO5ieyfZA+nZD3sRiDF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLVrN74L/148qaYer+txTiJRLeMbTWiy4PdCbwcbggM=;
 b=u2WdvClX7qNscH9DKiWOWSPvhg0VAl2BVzc9rHL3KRVPXzid15YJ0L+a1BD/z+n+6G8PARnJ1N2nAc2RSeT4Ae0fBU7mzjjzwxwTJYXgVP4QXzrOEwnnMRzdS6B1x49Abbby2VrFWKlMTR+DFU4jga33CdOoHmYfJZvGk5gazCt2rmyJFKtPcbAO+Hsl72QsoxAKwjTgaZxI9g3KqRsM5hzE/Tge1Vhs+VngOukk2CALUDwiIxpIBUl3HPWMeZsNI+oWiC/nDfAXauKIeIPxsVimxwBpU27jgQn82SUDtwXbROXfLrJ7BjEJdroNrBQ7jtL16BxZRvysy8UZt3CUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLVrN74L/148qaYer+txTiJRLeMbTWiy4PdCbwcbggM=;
 b=UnvJlXVJEON9kXwc86ERMv+aDy93NebHhEkPYjWekiyhMQGJZ9keekTxhO248XWawZf2DDGDNEuRFqLv7liYpmvPp1l7B5fUaobL9VT2G7TLOVtnS2PTfuXR5XyL4fDClGYj7akxhhhc0Nhjmh27NPcS9gqyQztxO8aOcFzCgdEjqhq2Rq/fztL1bupj32aV09DqQGANJR6Q3X8cM4PrTHgiHSdV4aBjXWKdBmwC+fbd6oRwAFQQ8JmpGLwGA7ma7mT+eaJoeabdw6LcqmaEUFPCBlq+yPic0Wq8JiTjan1DH136Umx+gpDPRlrffIOMyeLepN8At4R0s8Qzyz544w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 03:37:42 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 03:37:42 +0000
From: Tushar Dave <tdave@nvidia.com>
To: jgg@nvidia.com,
	corbet@lwn.net,
	bhelgaas@google.com,
	paulmck@kernel.org,
	akpm@linux-foundation.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	xiongwei.song@windriver.com,
	vidyas@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: vsethi@nvidia.com,
	sdonthineni@nvidia.com,
	Tushar Dave <tdave@nvidia.com>
Subject: [PATCH v2] PCI: Fix Extend ACS configurability
Date: Wed, 22 Jan 2025 19:37:16 -0800
Message-Id: <20250123033716.112115-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:303:dc::6) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d6ca8d-d818-4af4-003c-08dd3b5f4b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Z6BLiX5gJpa2OwvmaCzgqCU8Ii9pe0AgFZtmeXyQiDmq6z1ELQyxyDEMYiY?=
 =?us-ascii?Q?Cr/idQaMy9HienS+rKtBI/IJMmzbp4AW/GcvBFnCSqVlyL4b66EY0bxHcZPo?=
 =?us-ascii?Q?bFkkhTAmydhFkt3N9dMVTSH2TXaxJE3BASk1xhocKazdVgiBrjTb34IeVP6O?=
 =?us-ascii?Q?vsVbEWhBxnhAu6s7V4Rkhgbba7e5t36zwvieUpzx4/cLu1dpJsnJEdhlAvUo?=
 =?us-ascii?Q?f3JHyWeXCFH+dbgfJ34qmggwxz6RH8B5Z0PHiLdo2XJGsMSJAh6kQtLsrr/h?=
 =?us-ascii?Q?EiAcuHT6W5m9z5J6lG0G0NHWKBawtX3VQg69IIZCjjtYQNAKmMYQJnyy44AE?=
 =?us-ascii?Q?dcuqpFxsFrRpSh5fnLPwp69iy+vp5qnTlE9dhXPuY/Qr9KAYtdcive9g+lMV?=
 =?us-ascii?Q?t/HgpliFITepWP20HIxMcnuocjZYl+c01fpFOUoT7XWohKiKS1r/wE3tR59S?=
 =?us-ascii?Q?VrpvewtOkBwvikHg9YWTYCCW6z8ZYDvPWh0HvDPDIRpT8Y2Fr4WA5abglrdi?=
 =?us-ascii?Q?xXN4V1htwijPVGTnKCRN74tKDPUt7ImQE6QpmeLyoejesGlqgIN7lQaUj435?=
 =?us-ascii?Q?AKhHxVsvj/qtPjwsNVcaE7UioT9MdVWtlEGlVrDPuUaVZkiWXwnaP7krR4H4?=
 =?us-ascii?Q?uxgPrkcwxIEk4RfrU9ne6cgEc04il4aL146YB2pjP7aDUPjZhIticwqb/zDN?=
 =?us-ascii?Q?v1WX77zwS7cyDc9SmEXJ1xCqeTixVrRzcqeN5TdMdwEMn6yU/plYY/VBN0yZ?=
 =?us-ascii?Q?X94QjQwH2atARYj+3abGX0YU+mGSGp8A5hXhWQfOeOPO7XlNtcS34wJq4iWr?=
 =?us-ascii?Q?1WjoTJIGmNq6wqEd0QlMuEgxj/WJhN0uEEwcUF78edCZ7dtbTwm5Hogxfz11?=
 =?us-ascii?Q?hGVjb40YUFO7ufdJOFtnBYimLUCBOs4lTjru7hnaGZbsQdL/rcaN7fLicA00?=
 =?us-ascii?Q?LH2wADilAFfaNQaxqzFlWvfCmZsob6kgR5fypKHIv52bLi1MXZyPAUfvXDC7?=
 =?us-ascii?Q?3SeT6anI2ntvORR80wRDIVt6Mr6xoqqDvWv38XZOYD9xsY3tefa6LX101r0l?=
 =?us-ascii?Q?6S/V1pp7v70IrHixbB7+Cc/8ZgcFmeOJFleCiiHtWkpeQQvqSyCRuwqYx3ZJ?=
 =?us-ascii?Q?B8OSHZE8JEXKJ5MHmF9gipL/VEy4agGTcUSR1r47j01jeGh4XDXSRCdukG1E?=
 =?us-ascii?Q?MUROnwdYo+6RZfFUYX6IsY9n8DlOQEki3Qm3sAU9RQhBpJ4+k0+iRl+UH0Lg?=
 =?us-ascii?Q?XqyYVL9a7fv3Uu4eQ+ML/5gRupVcOFgSlfMdOP83tOMLx5G8QKROnXb3Z2kn?=
 =?us-ascii?Q?BpM72/z9YQOfDoBskzWaxtEtMj0LoqgdL3RWG7SEVrcLnAGWO4XDhioatSNW?=
 =?us-ascii?Q?/hsbYvZOk9xZ7L2tijdE204lhc4XN0mxwHLiGpzR0OfGLdNjiivv4QPn8Tug?=
 =?us-ascii?Q?K4SPMr7WQ8A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gvdm1GtKrP4dXH3kVFFZPrd8wGdrFzvRUU8M5fsWw/t7F3Kso481hGBquvTc?=
 =?us-ascii?Q?/hEtJBGysQys7gEo1NVQ2ZJmXvi2vLq3gjNs1qOJxFDM/s03ysTCLD2cL2Ab?=
 =?us-ascii?Q?nnq+DeOdUBl2NBBSkFFb9/fn+t4WSpOXfu6tifzykdPSEgdXbQdSpTvpqC+9?=
 =?us-ascii?Q?EIeFu6TSmSFT2XXV33LA3Btk+52B1mUo5yjdS/X8PUqmB3RnkHQabgkhNe3h?=
 =?us-ascii?Q?V6HNuOEK/9v+rWviGWp7Lhe5NbkWOdhkVuAkDOGqV0uGiO/ujWsRiAv+mz7p?=
 =?us-ascii?Q?5UUIl3YSB0pkJLwglj1edF2zZ0GN0naUUpHhFgeNmpSvX8ISmCEKX69cQUR1?=
 =?us-ascii?Q?mCAUhGlpNlq8z0aBeaw+neMP55GbTreNgCeeUPOjy+vCsQ1AqtEKv60giVXv?=
 =?us-ascii?Q?RfSczruytXkx/XsTqJKmxP3E3xFLbk12iNNh4DDlneRjb58+TLNF4kLIfMxS?=
 =?us-ascii?Q?gD3nGy36xmp1nizIWY3Broh17jMqNOvKhYFTlvmsu5ESvFdTEtVpwMJQeBt8?=
 =?us-ascii?Q?VNrIuXML01UvGJLfSQnLvFsM1HwVvIzBwbwsBdx28fcgPnRIqInzGADDOOOF?=
 =?us-ascii?Q?12zm/eRc0ClSh0JoeCixIDGwf7ngCRD4M6af55+NIFjY39dzdlGG5sARQISE?=
 =?us-ascii?Q?EzdvSSbdeeoId8Z2tJAS8dtt2wCKO75xPuveyqKO5kZsHsxTYFttuFA0pW+4?=
 =?us-ascii?Q?IY3f3KttHWwPBejSh9pQ1ULodAitfqjMsQ2qSQr+1umw92JuN2nqqxcgu0t/?=
 =?us-ascii?Q?/FlyLgUA31jQ3jfsSGWVzuoOdpT1DsZqsyaXnXs//p+g7hWjHhJaMcdszhdf?=
 =?us-ascii?Q?DwRgvg6sUKessZHwByFqLDYKsbR2nA45f3atdeEHn4AsOLJRp2Z7PmVxE2DO?=
 =?us-ascii?Q?SQV6yZMSQYzqq9GKZwHAKftrWB31ffGLjpjxJp1g10T7OXMBcldPqdm3kEcj?=
 =?us-ascii?Q?al5ANQRHyOhEcuVcBKLh2C4q/mRppqFidyO9YJjxXsDRCTO7oxTjdcDUoc7l?=
 =?us-ascii?Q?TUcZyxvzs2ubakb+RZgM9jmBzyor0Lt1x92UkVCVltv4AZHXSdUbIPjrSdU5?=
 =?us-ascii?Q?RLSGCxIZZIxCjIo+c9LiwSvLpMTUGx8rQjBldTQbnn8Paf6VQWrVYSuqKTek?=
 =?us-ascii?Q?QemD73JkKvwcuXxlKYQ+xVfOLFmrXBbpjPmdWnVdeG1qqA9g2YRnsSfKc9kJ?=
 =?us-ascii?Q?F/nIitCLLjprZBEZDe2m+CcrkKLdH8Ti8e6kjynquOJBNKLH3TE/H81//HW/?=
 =?us-ascii?Q?m/QvcK7eVRp6uSgKhQqbh9Usoz5ALSi84ggCL5yyT9rqh9g9HUs9jMsYiSzy?=
 =?us-ascii?Q?VCIrVljocCYFeMnl26zvuvVhZKQ/qM//Z+Kg53oiP0OAndUyhJbxPp41qfAh?=
 =?us-ascii?Q?UKymvsZjgl0odQmSVa6s1Uf//n1pis4Brtgw/Olqpgn0uq4byseyZ+oI7KTO?=
 =?us-ascii?Q?Q5PXmBf57hbdqFgNWMV9leOGk434rVjfGdP2ardNXyMLDT1/Svh2QCd+VQRJ?=
 =?us-ascii?Q?tVS3dElP89VTr7Yttp5GzfPUUw6ttqRs/v9+TK+2e3t+4PLFutQKRdb/AgiW?=
 =?us-ascii?Q?EBxYcl6mGhstQ9Gml6ybPAhdEe1ZCmpccWlvH1VT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d6ca8d-d818-4af4-003c-08dd3b5f4b30
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 03:37:42.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiDkd8X66KTJypxW5O85zyC2LRAIQkeJ+CrETZ5T9bTKBSVOPIc8klwjlLURId0QdJqGFsh2gtO0CSemL0MhAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425

Commit 47c8846a49ba ("PCI: Extend ACS configurability") introduced
bugs that fail to configure ACS ctrl to the value specified by the
kernel parameter. Essentially there are two bugs.

First, when ACS is configured for multiple PCI devices using
'config_acs' kernel parameter, it results into error "PCI: Can't parse
ACS command line parameter". This is due to the bug in code that doesn't
preserve the ACS mask instead overwrites the mask with value 0.

For example, using 'config_acs' to configure ACS ctrl for multiple BDFs
fails:

	Kernel command line: pci=config_acs=1111011@0020:02:00.0;101xxxx@0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p"
	PCI: Can't parse ACS command line parameter
	pci 0020:02:00.0: ACS mask  = 0x007f
	pci 0020:02:00.0: ACS flags = 0x007b
	pci 0020:02:00.0: Configured ACS to 0x007b

After this fix:

	Kernel command line: pci=config_acs=1111011@0020:02:00.0;101xxxx@0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p"
	pci 0020:02:00.0: ACS mask  = 0x007f
	pci 0020:02:00.0: ACS flags = 0x007b
	pci 0020:02:00.0: ACS control = 0x005f
	pci 0020:02:00.0: ACS fw_ctrl = 0x0053
	pci 0020:02:00.0: Configured ACS to 0x007b
	pci 0039:00:00.0: ACS mask  = 0x0070
	pci 0039:00:00.0: ACS flags = 0x0050
	pci 0039:00:00.0: ACS control = 0x001d
	pci 0039:00:00.0: ACS fw_ctrl = 0x0000
	pci 0039:00:00.0: Configured ACS to 0x0050

Second bug is in the bit manipulation logic where we copy the bit from
the firmware settings when mask bit 0.

For example, 'disable_acs_redir' fails to clear all three ACS P2P redir
bits due to the wrong bit fiddling:

	Kernel command line: pci=disable_acs_redir=0020:02:00.0;0030:02:00.0;0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p"
	pci 0020:02:00.0: ACS mask  = 0x002c
	pci 0020:02:00.0: ACS flags = 0xffd3
	pci 0020:02:00.0: Configured ACS to 0xfffb
	pci 0030:02:00.0: ACS mask  = 0x002c
	pci 0030:02:00.0: ACS flags = 0xffd3
	pci 0030:02:00.0: Configured ACS to 0xffdf
	pci 0039:00:00.0: ACS mask  = 0x002c
	pci 0039:00:00.0: ACS flags = 0xffd3
	pci 0039:00:00.0: Configured ACS to 0xffd3

After this fix:

	Kernel command line: pci=disable_acs_redir=0020:02:00.0;0030:02:00.0;0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p"
	pci 0020:02:00.0: ACS mask  = 0x002c
	pci 0020:02:00.0: ACS flags = 0xffd3
	pci 0020:02:00.0: ACS control = 0x007f
	pci 0020:02:00.0: ACS fw_ctrl = 0x007b
	pci 0020:02:00.0: Configured ACS to 0x0053
	pci 0030:02:00.0: ACS mask  = 0x002c
	pci 0030:02:00.0: ACS flags = 0xffd3
	pci 0030:02:00.0: ACS control = 0x005f
	pci 0030:02:00.0: ACS fw_ctrl = 0x005f
	pci 0030:02:00.0: Configured ACS to 0x0053
	pci 0039:00:00.0: ACS mask  = 0x002c
	pci 0039:00:00.0: ACS flags = 0xffd3
	pci 0039:00:00.0: ACS control = 0x001d
	pci 0039:00:00.0: ACS fw_ctrl = 0x0000
	pci 0039:00:00.0: Configured ACS to 0x0000

Fixes: 47c8846a49ba ("PCI: Extend ACS configurability")
Signed-off-by: Tushar Dave <tdave@nvidia.com>
---

changes in v2:
 - Addressed review comments by Jason and Bjorn.
 - Removed Documentation changes (already taken care by other patch).
 - Amended commit description.

 drivers/pci/pci.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0b29ec6e8e5e..19fbdd8643bc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -955,8 +955,10 @@ struct pci_acs {
 };
 
 static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
-			     const char *p, u16 mask, u16 flags)
+			     const char *p, const u16 acs_mask, const u16 acs_flags)
 {
+	u16 flags = acs_flags;
+	u16 mask = acs_mask;
 	char *delimit;
 	int ret = 0;
 
@@ -964,7 +966,7 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 		return;
 
 	while (*p) {
-		if (!mask) {
+		if (!acs_mask) {
 			/* Check for ACS flags */
 			delimit = strstr(p, "@");
 			if (delimit) {
@@ -972,6 +974,8 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 				u32 shift = 0;
 
 				end = delimit - p - 1;
+				mask = 0;
+				flags = 0;
 
 				while (end > -1) {
 					if (*(p + end) == '0') {
@@ -1028,10 +1032,13 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 
 	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
 	pci_dbg(dev, "ACS flags = %#06x\n", flags);
+	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
+	pci_dbg(dev, "ACS fw_ctrl = %#06x\n", caps->fw_ctrl);
 
-	/* If mask is 0 then we copy the bit from the firmware setting. */
-	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
-	caps->ctrl |= flags;
+	/* For mask bits that are 0 copy them from the firmware setting
+	 * and apply flags for all the mask bits that are 1.
+	 */
+	caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);
 
 	pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
 }
-- 
2.34.1


