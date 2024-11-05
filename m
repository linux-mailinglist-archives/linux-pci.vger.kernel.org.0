Return-Path: <linux-pci+bounces-16047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD0D9BCFC4
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 15:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD1C1F233D7
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD91D9588;
	Tue,  5 Nov 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XJlEu3i8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9631D86CE;
	Tue,  5 Nov 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818459; cv=fail; b=O22Pfg7Uj+RnNUMk9T7LEviAMPQLFNnqBib9naUORTmu9jDwhGvIUJsgxRHaUBL5J1dIj8jqO2UQfI2EEsRStzE+dKHdh8EXa9OEWwnIrEsoE0fTYDXkhaQyCIb7ocxJ1a4llZYH/1uIuw+pMz0M7vXVEN/cdvR6Qe4HcxIaHsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818459; c=relaxed/simple;
	bh=d7PnnAl6NTlVxC0jGtQXNzcDi7FVxOgMvSKlxyHKUtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bPc+2DOdMS6YFFwG+Qc23njWy8kEa6BzCUBiAgQFse5CTq7Tn3vpMV+z/JwAo0rN1+RsqpxrpBSIkCgkPe/ahGPRtYpGkEGvLISaejiOU6FbIl9Ht9OmBgYSd1bAcXS3inCiPZlGshyq/HG9KLbWUnD7GR/ZsoU3bwlvPCmE7us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XJlEu3i8; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuX5LiJq0um/lyjxF4nL+gNtkOU5S1RWcfy/AwAmBLYsJBM+d5KHeAn9yu7iCia89yJR+DbTu8XkWmY+sA1QlIrkDBv/Dj/RRNWZkxaB0QXjH/XY3C+fpfGbBrgd72GhuBzBXmapd9OsmX4AmaNdQ/I4Jo7P7gg+WlkSVcCMbIibHjCU0EaxddlDYfrFLafeu8dkeQv6YukZBLYJr0BcYugwevfzlJA5PV8KN1AUIlWIzi9sq5rjqS6HrsC1ob+2SwkYlQIS/inO0sdsNLRqQYu5Gx8y8AWqGAkGws7XL8YcPmE3rlghbHyA1mWfzwpsAi2724GuvF9rjIH2CvmThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug7z6l4J4oiIOE+LqhsZyXuuXr7C103KqxNAlrEhprg=;
 b=UQYXyQLX38AWuqCsXcnU01GAmTPsf05LR1IP8D5BXGSlWQaUmTuoeAAJWcpjdSw8Zs8+gqnmcMdZSTFuj7Lo8871w6xhKMYgjDIVkE9sUgN3oZpkivdVFh6eKchg4cHdhNl9nSwB+7KhkEk/21bB8I6f0uoAUWw7SPVgILSPqMdxGp0+XMg4vFw69zZ2K32eaaW4jab5y3qYQbFlHZV8nR10D3ngVdaosDE1/jSjdIlD0IanzDfpEmBy4lNIz0VUQGtSYMSUfBMY5DbmQHOJ+He82mPS5oZoeQ5NwboVFTF57xNk6HBi4zw9LcE/5Uh8xYg3i49zzqAsS7YmaWvMyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug7z6l4J4oiIOE+LqhsZyXuuXr7C103KqxNAlrEhprg=;
 b=XJlEu3i8F06lrZ0GIbrxZkJblPRibW1Cyl3M+Q+f3ivO/yWS5V+HaxhHU+cZl9DkT+vuQFS4nUGT7M+3ahyrPTmrAhw2kBNwVKkBvE+0d33+lFPyGYOTlVKaSFou+ZP//Q4qF5/JQBcuHrwi8x2Z4/6AV18ayiuy1HphVQ4+m6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Tue, 5 Nov 2024 14:54:14 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 14:54:14 +0000
Date: Tue, 5 Nov 2024 09:54:09 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, mario.limonciello@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 09/16] x86/amd_nb, x86/amd_node: Simplify
 amd_pci_dev_to_node_id()
Message-ID: <20241105145409.GB916505@yaz-khff2.amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-10-yazen.ghannam@amd.com>
 <20241104142329.GUZyjY4Zwb6WyB2JYv@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104142329.GUZyjY4Zwb6WyB2JYv@fat_crate.local>
X-ClientProxiedBy: BN0PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:e5::9) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: f1529b84-1d38-4770-2482-08dcfda9b723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fS125CHwkce6fN22dtpkMrr+Q+y7ZTZCHxjhjL1V2Mr3aAvKvBsi76v6279f?=
 =?us-ascii?Q?4l88PBHMASuZDgl4GQ4wHGK3eF7QstP83XG5foCjbxV3FnPiCrT0tEVuj8eM?=
 =?us-ascii?Q?ia0kLQ2nG/cbBlN9eEKFW5qjXlAPdFe9aCXlUW6CUJFBpQSvzyxHB3dnxwwG?=
 =?us-ascii?Q?NIT8n3g63XNeiDvmyu5uSR1ZyZWYvGdT1Jez5kn5IhM0mJx75gYNtBlXUuv1?=
 =?us-ascii?Q?S44sehQBc2UKe8s4VjoDaz0C+jQxhCbuB3POJAzLJGJ26hQ5X0PziOQfgNOy?=
 =?us-ascii?Q?cqcfBy2a3ayeV0pAvdu2N6ed8TxmdSQGeD8RyWM8A1/uerMR7OWT8Qj5jAQP?=
 =?us-ascii?Q?+QgqI/uKBePvPSnVMHulBOwS04eQ+D4hOrRZcj/to4CoPeI8l2+Wff4A/4p+?=
 =?us-ascii?Q?4et6JdYjEczd4gq5TV7a9L1wrM9z79jkXl1ojSCYuxil2X7YEC83eHSO9Tbt?=
 =?us-ascii?Q?aFUgpQOLgNH3C25FdmcB4+aKlJERckXozsIF9++TCI8phiTJG5/3TeX7f4+A?=
 =?us-ascii?Q?NUbglMCek46AfIrLLukxrtxleND3ZLADB4iX6gO/RYG7eKTqAssLOUdPVmoM?=
 =?us-ascii?Q?lTuFoR6iFiSN5l/vrSx8lpm4QiyA7TVTQUDZ6O5tuOMLJHew9/LxiCNudpiF?=
 =?us-ascii?Q?4IaKPNr7YVvwJXlGVne4qh6GjyfPXAeRWWT7PBqKYJiNT8grosuJWOJlsbh/?=
 =?us-ascii?Q?2LAEGOztp3+lJXPhM8877Dmhn0zFJgeBQNwSDMfJzzERqTTw4cJfFbj60t7l?=
 =?us-ascii?Q?nuiG11iIN1ac293W56cpnhVFcMXApztaSG39J2D70LDI3nScUcrpphEBpZdn?=
 =?us-ascii?Q?7DS8y4VgLwQ+Qq90UrCPA9AOYWFI8GSBqRLxktELntGin6W9qiIxoz5UQKMN?=
 =?us-ascii?Q?SIvSK27R8PC2teGkdnWDDg/nQ9viZj991MR1MPEcQw+7uIQM+wsKHIlcHnJg?=
 =?us-ascii?Q?8NaPwXOKSgwVwwCJL9zP1bkEd98qxgGgXc4+PmZ8e1gVq82qdu5Bpgck3H0E?=
 =?us-ascii?Q?7PsQv9TwvWZlPbV9PiPGZvyoPQdmLUEbj6l/wMcmpMiqzBMw4BWUFllqkkeG?=
 =?us-ascii?Q?L1JENAFG4O/KALbHToCVMNWZeOBe6xyyBR223xZHcKgXhZpjFYSTIRaoCaSy?=
 =?us-ascii?Q?vc5dnjU3D+JFk1TxSBuReX7Pd6l90I95tnLCfRfEXMtobLPlbL3AswtmVr1y?=
 =?us-ascii?Q?ZCUgbT7zbvEkJMZq3EQ8IKU1Tfk4lTqOxKs7lYHkgCRhtqSumi/UvdYndg9E?=
 =?us-ascii?Q?jbh9xU6EvfABnwmgHhfxU9XxO81p74dglKllZpd0L0tEwznHcBjKNSj24bKO?=
 =?us-ascii?Q?IgsbQ83SRcrgLITM2qXMzr3b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jGwboCMmHxu3wsa2NjfWJPREgDaU91qPWCHj8j9A7oqHv1pYYsIN2oOfqJ6u?=
 =?us-ascii?Q?OXdpcVSQKRfZ8F+AmSHq2hZOEADmKFxJeEBjWZq2CqoVDAIK+srU6UV9EO2p?=
 =?us-ascii?Q?RPBVy+xIijsslX04YwXuCezw1YpevKaz5r/yPhmd5PJ7QB4a5R7kglQZOXgG?=
 =?us-ascii?Q?AscWN2ND7Pw6SFLLxHwEl+db7ihCmoxiGnWvrod7nCbznak9tX0RUR3xeouC?=
 =?us-ascii?Q?+YwmTL8HZcpq4mh7diP3DYJzzUbxeD4i8oQnUbWkWZgl835dUwY6no3B8Q88?=
 =?us-ascii?Q?oOAGxtoqbyFHGph+UdriUKLE/1BBEwqN/2bAoUx9BUa0pYPSzwPzImEqlKjN?=
 =?us-ascii?Q?Q4tAbhB6mzgEEs0Hne3rxAHR427ueeS/QugZN8qxhDSD8/Ur4/daNPdruKAQ?=
 =?us-ascii?Q?98GNgnhwADBZy0PS0rdkDwjXBwv2Bs5X2FabO0cNdxQNwO0S41KYxRhoHAnp?=
 =?us-ascii?Q?4jhi6YJgR3Q1A78S02PGebTbbZgNC+nyDHS68GwCxZV1Fb9VDc/U+T+WtJHi?=
 =?us-ascii?Q?BRhrf6/P46Mns8Bhdi0WyIfSfML1DIp846idnzr9R73M0GdWDqUHfMd1/vnd?=
 =?us-ascii?Q?Y6Mhc4bwVNGn2ktQYlwWRTIMmVXqCV6+2/S7lahdf+P5gSQmQnvMFsOpth3C?=
 =?us-ascii?Q?24d1QdhfAnE9kBYm4twZmC3VPPceD+xDNvkqHEqWQKpBWqugZ0kFMXL6WjvP?=
 =?us-ascii?Q?egUerd03tu50VH44io4pxJSvZA3uMDjrlx4Fsjvnm6VnlUNXBZNF6YVewucv?=
 =?us-ascii?Q?uozBUjpPm8WgUjcViVUwnDjRBOOZfzFB7tn8jzt8xaRVS8iYQyAv1XDXtzJJ?=
 =?us-ascii?Q?iL+YZ+lumpeg9KmWsTKd8LkXGrZmsuqXmKjmHWXWTXjDnjfadtytAyVgoBOA?=
 =?us-ascii?Q?Lb35rgZyzP2k8/wzgo39n3wdcbz7tagxUJkX61wqja8F9yifOcCZ2bGXILmP?=
 =?us-ascii?Q?Ms7PpD3c2NRg+TbJj3pUej19Gk66uxJSdhmp2CdGf+YpqjOHOg7jTGVSdb8w?=
 =?us-ascii?Q?87ncRhToDbHIL9QXCTzrD5e5+2LeF4v9jYqxrXo4ZcxIPPKnuTdRZOuIoC0/?=
 =?us-ascii?Q?fNyxBhnnxiqvbRVdxEMG82mK+Hpo/ryqmRSb4hsYOGH3A2vNPVc48IkhFGMM?=
 =?us-ascii?Q?4Yqk2xG8vS9AXqwQGFbO+TDMQz8MUfGVcLw+mK509zWetD8iuAkcy3LfVUd1?=
 =?us-ascii?Q?7w9zIZk7oRpA748Ays7VcFK6e6WkbMk3fxxDv0/3JdJz93ZQqjdyuDtouW4x?=
 =?us-ascii?Q?80YYlKOgvMAKStdZ5ZwLHgAHdrB+Q50L/6lZcHxipwXxouHqMOfzcnfRpCrT?=
 =?us-ascii?Q?3nal9W2kFLF7ugmA8qUTrPvnwCnrHJenzRf2lfAxV1PTwKFvBM7hqbo8B3F9?=
 =?us-ascii?Q?K/tIlxKjU49rvEgVJLbVRWPhr9KbaoTnzR+2chpobtb0EahlIQZNbKOrjMYd?=
 =?us-ascii?Q?NS3pwmNSbg8UDF4PnD3O9fp5EGRgcmHW8MhZOYAq2KI5LND5lpY7zTMqVS3C?=
 =?us-ascii?Q?60SHG1y9vxIMmF/M3bPaUMdPndAIDfEGjGOkSwuZTQuNK+RdzZrItm6RoGei?=
 =?us-ascii?Q?dglWkv99HpjlcYZrBFzBEDEa8aBT4kxVCTL8hyix?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1529b84-1d38-4770-2482-08dcfda9b723
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:54:14.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VUUMqzFpAaVlY89iRjP8JjFWrTaOsxAb9yNpp4ol5pxsFGlcAi9yifkD8vktWJwZQc67+gp+eMAAYKQpd3rzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351

On Mon, Nov 04, 2024 at 03:23:29PM +0100, Borislav Petkov wrote:
> On Wed, Oct 23, 2024 at 05:21:43PM +0000, Yazen Ghannam wrote:
> > diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
> > index 419a0ad13ef2..8e473a293706 100644
> > --- a/arch/x86/include/asm/amd_node.h
> > +++ b/arch/x86/include/asm/amd_node.h
> > @@ -30,4 +30,10 @@ static inline u16 amd_num_nodes(void)
> >  	return topology_amd_nodes_per_pkg() * topology_max_packages();
> >  }
> >  
> > +/* Caller must ensure the input is an AMD node device. */
> 
> You can ensure that yourself by checking the PCI vendor in the PCI device,
> right?
> 
> IOW, pdev->vendor...
>

Yes, there can be a vendor and/or bus,device check.

I'll add them.

Thanks,
Yazen

