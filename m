Return-Path: <linux-pci+bounces-29376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FFEAD46E8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 01:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8093A58BD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 23:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB2E2820D7;
	Tue, 10 Jun 2025 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MbS5GbYs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391717E;
	Tue, 10 Jun 2025 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598908; cv=fail; b=sPZXtYrQiN4IExKW3QeW9GrGuD6ZWATOLSn3mwnGBnxVEBuWNHgKUixVYvrUMSixQprz2qGflYXYEFcAUmM/bIiwfW5kY/MPJALj9lgqw3g6fwjIrVJ67Q8qz3NAIkK1sLmVQdzqv12Dwc10IzOHjd85O6SfrcR6KiqNC2Nco8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598908; c=relaxed/simple;
	bh=HiMbGkacGCq7UX2PML3r70nyjGHZYbLZUZnvm4X2SMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U1M+3mljr/Nathhf1csWU9WJKnwFZOH4BdzoTfbHo37vqk+nMR2VOI2/g+9lm4nPi7WhGKBG4EJLOPm+LC/5hngZvLwYlXTNKAWKsWjNCof6J3yCFWz/yeYKFwOEs32brrPHJ7nNZzsbuxH38IEKMsIjksbl8cKI4cV4d4mBy9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MbS5GbYs; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiCJxxB8cR/cpumjhMVLVlsshxQElDU97GCJTuhjuaqt301pILoSnEiXNZMob38JOgLyjfk9aNa3hA4n4Waxbe+UiXGCGW6EZI6AF4vuZb2qg/M0hRmM8adiEQ11Xw/u0rz1G1rRVtysxnK3ux7mHxbkLyVQwmNPGYWU7LEWCYjwWDGZjH3Wrdp7jp65BjclIN/9F64qDFSEGkoSOb51/pKFOWq9P3ACctztuOvVz6c3q8ZA+6llo+hkRIi5LPWZU1DMIoPXbjHf4jhNpk08R+6gRnpk1wVB3O72ARDipuguiyM7zMzK9RXOi5h3znoEpzzU63xh+tjT7QmKk+YzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAMnxvPeWQsfzn2DkmwD0IqmhOVmdNl6XX+04itzY2o=;
 b=KScF7SPB5xrNYyQlD20j2AXlhheWBgxegS5dtlTdqaRPqpCixwWDH6ePrDesAZYBTZJsbleetwwX7L9Af7cYCw3RPIHgczMe6dg31DHyglg1Vttj2VCfV7Vnh0wTYNAleh0KzNRYhSBGhbIh2cPA9ZgF9daQGo1OTXvci8AvnyvROOVfDZSHXo517gUYfmt1wCHYWKOtCjFh43mUxs68JTA1ajYd4zGDFjq9pj4AOcOJ6iob1U0qTp/BT5K1xcG7HZQj/NUdl3Pwz85wgQ2tDAr4lWI+JCl9f/7hajSoLWIl3OzUvbGP3LSW7hUiIQsbj51RsRaORmwkBCky7xdSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAMnxvPeWQsfzn2DkmwD0IqmhOVmdNl6XX+04itzY2o=;
 b=MbS5GbYskD+ZgUxP1h1qfhB6Ws8x4u/mXML7tY7zv+3BB98avI0HZ541S9lWPehWYPJtAgwN35yYNIN3vtCEKAGo8cfYbO8fTZt25GCif6h2sJAGpnsNQyRcO66ww7GLoskjqJx08j0r90vZlbPe27d+c1sId2nI+longL/QpUbsiueQMogzWHHMiob0A1AMQm6dvmQeLpYGxfAZwKhDYvNIeHU5rnfgnuPZTXHZxggQIFXE3o+9x21oURGxEAFgnG4R+zb8VNekrOdCfGHx/Zg8LLLn80aVY9YXuw91LC/t7yn8Of6ZXmLGBCCrEk7hOJuJQd5vkFAufPhDvHg5hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Tue, 10 Jun
 2025 23:41:42 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 23:41:42 +0000
Date: Tue, 10 Jun 2025 20:41:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
	will@kernel.org, bhelgaas@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com
Subject: Re: [PATCH RFC v1 1/2] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <20250610234141.GM543171@nvidia.com>
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <4153fb7131dda901b13a2e90654232fe059c8f09.1749494161.git.nicolinc@nvidia.com>
 <183a8466-578c-4305-a16b-924b41b97322@linux.intel.com>
 <aEfZlKNk4xfb41RR@nvidia.com>
 <20250610130416.GC543171@nvidia.com>
 <d22320dd-2695-4f9b-bd72-38eabc1d934f@arm.com>
 <20250610153646.GH543171@nvidia.com>
 <f66bf027-5dbb-473b-b57f-ed3ed7914800@arm.com>
 <20250610164306.GJ543171@nvidia.com>
 <aEiTSgK/PLVJ1XEz@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEiTSgK/PLVJ1XEz@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 525dde14-f228-4794-3c37-08dda8785a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GeS+7/Xd2iZR5OaZgUfe94RBQY5ovFiXbBWwFmMfrB28EULBYJ/l1nTYYn6u?=
 =?us-ascii?Q?aB8fB7zJdAQAWvoXH5tSceAs7TsYDG+mhl+XqzTEusTeDyXV9RpG697AV/7/?=
 =?us-ascii?Q?80oidtPpZm/kdrhYYKv3WWj/W4B1zGS0LbXAJ9qSYcvHI9FblENwR3ZM0s0b?=
 =?us-ascii?Q?p4pBrvxUJatM2M8VOC57c5FQIznYf/GGFF8kjB5EvBBbS2AZS6JNMVCtavwe?=
 =?us-ascii?Q?bfymTxKPIQE4ZIpPUehw3Xdq+YMmLiqsGozho0BHuR8WCPEVOmPtsL2f8pY3?=
 =?us-ascii?Q?LAgmFJKw9qrzmU9Wr3r5S0cwQLbmAKL9kp3PPG/K5xFtmRlN8FniLwQLFTjf?=
 =?us-ascii?Q?+I9uGI5ffljECCl0noW0fjLcO3QPqY8C/IjM045gWWa7Ru4KKxJpHaAQjEv2?=
 =?us-ascii?Q?73dWEkDzhVK+ZsA9ASlHCpdSE/jgU6agUN4ijEL1mVWnZaBB3aNVr2fznVH1?=
 =?us-ascii?Q?dO9ZVb2PWSpCW9Af9FvX7ngvbX3r2nbAIaLMUfIUCIh61Siu3VgdjPzPSKdz?=
 =?us-ascii?Q?eTmNnr/kfXysThC/+2eHS7H2fonihNQSuWbfrGKEvy7A8iWyl2GMB2nFnp8R?=
 =?us-ascii?Q?/CrUo8NMRNhC/4UgGMqPoO9d+I133YGPTOSIAq5bL9hfU0FfU2EMHd4cQeST?=
 =?us-ascii?Q?rpKde9St6NZXq2vDdV0LNt0we9/yTazcaAGwf9FtZ5Jf6UhXS/WQDPYR7isi?=
 =?us-ascii?Q?timGKNRoYrXdqoe9CxDNFfd3iTTKib6JkDhNpUjEg6a9agj/rS0hKjPS0AWg?=
 =?us-ascii?Q?Z+zZo938ggJ/k7tUfs+/4FGkKtKx1Uo152WyuIoS2kNlny36v9XKfA3rwwTg?=
 =?us-ascii?Q?9msky+XNBU87mvuKJvtC5B1YxN2/su5qabfipiUtEYytBYFxi/g3eKCco9AJ?=
 =?us-ascii?Q?zGTvX6eYFdmeTvScDtmssIZhdyzBumqbWmpIxgPMIs6QN+fHdgy3nAKYoXAi?=
 =?us-ascii?Q?PYQdUjhCLLtPB6gJZSbeE4oGq3BYpuW2DJrDB/hwvAciIAXdcu4aNECUNZH5?=
 =?us-ascii?Q?QzHC5LpZfT2weltnqa3QmyF+pdvNjra8gLPr/xdtz+D5m9EWGh9ChccZoc1J?=
 =?us-ascii?Q?2FBur8N0I4C1k8uTEViCOaw1T3HUwlQVKZrmTFTUCxzk5U43WG101OmVUTXN?=
 =?us-ascii?Q?C5xrWZYvxSnkHdDjlPLGzkQIz7QWjNC0mIZTeHrVWE1fJ3BgbVYuhiz3yPVv?=
 =?us-ascii?Q?J8KEFv7rH5AJOO56yG0joM7ngcdgcSqfRJJ+5ynPta+46LlvJO/8if38zh55?=
 =?us-ascii?Q?g5oWsRt+TUk9QX/cyQlePmNmbnspPTCNgXnoMW+0G7Z63ZdLZMml1H9ZzqyH?=
 =?us-ascii?Q?5rvebWAZIhnD+p/S6IkQ7QQpLPaj9ZsCPDZmT4JA0fF0Xrpf5P1VdzhEYrM9?=
 =?us-ascii?Q?rRkcfs/kDqg8NPMbGI7aD70egWqiwx3SwKyaEOYqMTS9lMiChA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4c7RxI08uL3DpSV8z48KmD+M5UB+CiFPs7VB4PARUJrHtkIc8K2CdAjx8Kco?=
 =?us-ascii?Q?ZfTq/PeysF5cihhToXgiPUleKrlXBTLrsVT1kp8v0fT1ZL10X4NXOP0BIQSV?=
 =?us-ascii?Q?0SCBX8LDlD7uNS9iAKCXP67C1jvP62RTMik3+A4xtL/00kmvQjZD2+hkwAOJ?=
 =?us-ascii?Q?PRfUe91W/Yh0kk370ZOM6LLlUMnqcDCEZFqGDy6AIQFM92OCWVX7K5Hzn6Qi?=
 =?us-ascii?Q?JcMGOytcSS+hSzgpUssvWbtYGzNRK18OXcthRfddfv8gv1AHfCQUmCOGM7IE?=
 =?us-ascii?Q?eDBSYWXumfaqDhDvivSPU7CKekySeTjca1vdwrnKaFu+Yq+4o13aUBSnGiC0?=
 =?us-ascii?Q?FDOYqolDw+wZWYbnXa1TH5+I4txFN4YLY/mVIRDlAQJ3yP/BBg7g8TMQwEjb?=
 =?us-ascii?Q?4rYAK6jhg9sCX5iRnlZGYHWaBnwIjYKQiXfbEkthdp71Bt0jeO9B8uPOnWHc?=
 =?us-ascii?Q?jJ+WbZkhkW4cde6vvqMrJORgzYhjRpzUFYjrwEOhwnfLsBnIbHnOBG7L+Q5w?=
 =?us-ascii?Q?uZxlAg2imVYHabRbePhqRXvzkGC7Um6DqITlNqKkkd/S2XmuQDDEulPwxRj0?=
 =?us-ascii?Q?buIfvEyoHck0IP6ezNVTY9B/0ViJevpah2QbKsGImvFF4Lvq2RVwmIhqLPxu?=
 =?us-ascii?Q?DW4DVXPEc1b+hd5Bus7fCcj/a7Urh/kfRoGFow9z7aW9202If1mSndj8rTlC?=
 =?us-ascii?Q?tQuDxspymUpuHSnEiQotzHn+BdMFn4lDtb0vSU8KQsKfByv/DC8BMXkWR9u1?=
 =?us-ascii?Q?fzRoO1zU99sNFYoryKJwiY9TRuSEJRcMk7mswYdeWhR0kvhtLk0K2n6jqKhz?=
 =?us-ascii?Q?LQYhfH31OR6wY6vHeYu/mnToHNqC2PY1rQC/p6arPtk0ro8Jz+D/s8RD6cW4?=
 =?us-ascii?Q?2gmpM/hWYOFVoFSqNkh5mZNhUgaMUiBlPEfdiKmC+qKGCwVFYQPwfpRID2nW?=
 =?us-ascii?Q?VC38vsG94c0AigbvI42jmqlsVAxB0+PJvrLPoasO5uaysu0hW8y/5ZOV6irD?=
 =?us-ascii?Q?vi5jAXWILBtheGD9Gz2JOXXkYPYsrnOT3nDN3V96HsHtdYhtBvMQp3Jue92e?=
 =?us-ascii?Q?zhXUwp9mNFGGsxCmNsdxnpb2tv4ByzToHKRfPas/VybaDAb09PbEOUwGoQYu?=
 =?us-ascii?Q?Sta93q36PtkkZS+z/ql9HO7p4f/5zkG9GHLJ1e3uOqu9+vb8UoBgagMgpQnm?=
 =?us-ascii?Q?h6bg+rPueyFtGlRa27Um44zKXTFtTIqJfwGbvRxLA47w9fAkxzHZ/bOMaN0r?=
 =?us-ascii?Q?U+moAdKWHzHzbP4sQ+jK9JDRz8xjaOO7DXAMSYYhhdWjJG9O2a79lIYFRH9S?=
 =?us-ascii?Q?x3Jzc3sG3ixJtfe/U9dz5vvvA2yq/Lk0u+DzldiZV5uuxUPVxrf8DNnDOYLI?=
 =?us-ascii?Q?lQ30+awGmJduvYb0iZvgs8vXh7CASQKvRnpg/ijPrEuoZNwfhwHS5oWr08G5?=
 =?us-ascii?Q?C7tThycq1bKdEnfS2FvaHJriDPlwsIwwDobMCDKcfiQ5WnRi24G6QLlup7UF?=
 =?us-ascii?Q?Cw9Uyyn7JocIArvS3x3Cm3ZxVFcvK4ZOPJukIR1NRVC7uU0H61WmwWUmtZtC?=
 =?us-ascii?Q?DIyK10LXHcXs38bi0arR3kdp60B7S6cOriBDPGMr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525dde14-f228-4794-3c37-08dda8785a65
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 23:41:42.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvqSsntI0HhwKIjH78WFi4DABTV37eLGLDZH9KwIYh58GF0jCz2Ao6uXFehCpSOk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221

On Tue, Jun 10, 2025 at 01:19:22PM -0700, Nicolin Chen wrote:

> > > And on an unrelated thought that's just come to mind, if we ever did FLR
> > > with PASIDs enabled, presumably that's going to wipe out the PASID
> > > configuration,
> > 
> > I've always been expecting the PCI FLR code to preserve the config
> > space that belongs the iommu subsystem. PASID, ATS, PRI, etc. Never
> > looked into it... Nicolin??
> 
> Those are the flags in struct pci_dev right?
> unsigned int    ats_enabled:1;          /* Address Translation Svc */
> unsigned int    pasid_enabled:1;        /* Process Address Space ID */
> unsigned int    pri_enabled:1;          /* Page Request Interface */
> 
> And pci_restore_state() does the recovery of these bits.

Yes, that all looks like the right stuff to me.

Jason

