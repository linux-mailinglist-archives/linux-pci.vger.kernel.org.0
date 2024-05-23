Return-Path: <linux-pci+bounces-7787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB778CD6D6
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 17:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175E7282F00
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4293ADDB8;
	Thu, 23 May 2024 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fFqKmqRc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565F847B;
	Thu, 23 May 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477378; cv=fail; b=ZkkfZiR80epShVuskCkaSVPmdZzoZ1+sq0enY+c77hVeYhapJc2ygUJCNN/GS6RpfoZcFy8l0OWeeF8ScircEEhhFxPAWlSJOmWm5fPC2RAbAfpkaFh2/ZwGJ5YpMKwweM+7ap/s0F3OQVsPVu4uUy+//+WlRc3LpFqQLVzszsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477378; c=relaxed/simple;
	bh=klOTExRgwtT+r0FjMGtEWH+d8J4VhqFY2BmGqD6NCWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uwTUjirCJturKoLsj64d0YasqXOln91Rdnioi3QVUgrdmnBOZIv+N9iaj7U6+g37wGHa8uYhG0PKTtWWcj1uRf/0Nj5FN6hxYhxaVTvv4mt10MYH/nOYvizi900PNmlaOJ0/WNFnOjcAa/vJDidZr3eU/Egm5mRvJG4qBWOiYz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fFqKmqRc; arc=fail smtp.client-ip=40.107.212.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxQE4iO+q+8gxYou3rL2s3UAmfu5KdTd31wHLC4l1CCGwk+FZC+FGp15ycb2Ypb2xv2jD7XIAdd4jgaccLCqYG1lBLhI3Bxa5v8g/INq6nrbUyQaGdziP1743p4qf1UfXZ75wTD7+DcpIWGrrWV7cLCqchbiYfZrCNgK8DYy2xxMleWqUMwURBt3wbFb5DNkhg9oX7FB6FDL13onbT24Ap738G7ub8EVnqFAZYC/16GkU7+EUwdaZAyJKSl5SRCMMcoiJg542WS89j0H9NB6205V3eHCQO4E+FPIjAYJiDqY8MKvgKQjWnX2Gjk2U2tvjc4p85xHWr1dXirIL/en1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTeE+XxXlR4JbX3Hj7xP+90RhgfjP6o86858gZVy/dA=;
 b=ICw2QfxKWGOotvlfS2VCQuWke8jDFVcXW5ZSrQ88WEbsa4ocYpsI3YXkvQrdQqzFCSsdj21ZNDzquNHo8zfSpjiX0JudLrY8INH8icqzfhCHRhBpAEk26Xf1oet3DhhCYcZZod7/MNpWdKtqrOUgQb1bOI9ZGC4zmxUlXLfdjwSnlTW+rM9i88qDhx3cnMNLavh1jQOr1DRl6oVR+gmX8ZF7f/53bFodtU/OyReIJsSFpg4nPH9l4b4CeWQJfvnHhOofg5zQpAyaMp4+KD3KrH/c4IRxAq25eawdzg4Df7gqyRAG7JZqLWW5AFxFQaKZomClf/UsxlkKlKhwyTIeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTeE+XxXlR4JbX3Hj7xP+90RhgfjP6o86858gZVy/dA=;
 b=fFqKmqRca1coY4WBZDPQ/z/0+m/qqvTijBtAXa7EKCFFWWLwL2xR5ivmFXSK5W0j63rz/7borGSsuWaAD/K1sUr3ZMzXRKxU+k7g+rVfDFoHuJXMl9fAEJb3+CeDSocmN+C7F7Qjl0WqUbf8IzuIgQS1BJOWu9VEMx2EXiv6I77ansN4wCMa3KAKu5ZHEAWgWyz0E76SSv38+QMDbiF4SQOYm2JllApmM4+odkJfJ4B4LcLyu2OSboIid5ZG+ZnJTIrmlDWLnao90obBrg0DEEUS9R5/rmhGfrcKI5PBCLjmi3ctecro84G5IFLUvMS32DRa6sPyXX2NNoryzgvizg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 15:16:08 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 15:16:08 +0000
Date: Thu, 23 May 2024 12:16:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, corbet@lwn.net, bhelgaas@google.com,
	galshalom@nvidia.com, leonro@nvidia.com, treding@nvidia.com,
	jonathanh@nvidia.com, mmoshrefjava@nvidia.com, shahafs@nvidia.com,
	vsethi@nvidia.com, sdonthineni@nvidia.com, jan@nvidia.com,
	tdave@nvidia.com, linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V3] PCI: Extend ACS configurability
Message-ID: <20240523151605.GP20229@nvidia.com>
References: <20240523063528.199908-1-vidyas@nvidia.com>
 <20240523145936.GA118272@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523145936.GA118272@bhelgaas>
X-ClientProxiedBy: MN2PR19CA0004.namprd19.prod.outlook.com
 (2603:10b6:208:178::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a0a0df-bc4e-4b98-dc97-08dc7b3b4599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?58ap8wQFKFJyLnbREGsdQeqnFSs5XdLXxIlgp9NuUbjPiDdXANVWpKoLPf+7?=
 =?us-ascii?Q?0r8HEdICqXeRuNZ5/FSlHQRWF9ps3xuIM3epzV0jCUHT7uG2H4frXtX9jDYe?=
 =?us-ascii?Q?m/7dCR5VShAHue6NRu/APVpfh0eGmkD2ob804BZQiCatjGQtkbFF2UNXyc3M?=
 =?us-ascii?Q?vz6WLO2HxzIxOSWOniMmv/mSQ2LG9E4akIDtWgMwAJbYm3fXH46jD0Xw+1fr?=
 =?us-ascii?Q?ODfz6K5XjyH41MOIfz6K2dqLLskxD03gh4q0jUfEGzMY9NufHshG7L26+Wy0?=
 =?us-ascii?Q?DGeWOcXTgGEuM4fO7pj5rYlJ41RYAp2M+q5UN8WcuN5DOQ39/UFKpxdzBCyz?=
 =?us-ascii?Q?WKYPvqGH5fgSMzUKYxTdKHa6CzqvLHBtcjOT2XRqNE1dQiZbszNxqlK9j/tR?=
 =?us-ascii?Q?FJ3V10uCnJMNif3H2hChiirqgt2HIkQXJsTIfLO7CMZBfNMxAi7SDBvx19DJ?=
 =?us-ascii?Q?JklUVFHBpwuQmd+mQ0f6seAeYj8ND2D3DbqhJnNUZtViXgEeS4GnyRQ5odwE?=
 =?us-ascii?Q?w4NbHQeAUBG3s/YfslSbQ51HwvA15LAnmuzuiBxR26RfKENANdMwi8bEyyxH?=
 =?us-ascii?Q?cikY5czHe++ufYk6ohxe2EhrxbdBQjHnYxrUlV24KFHfvHgQ2anJX5HmbGyh?=
 =?us-ascii?Q?tKfH1PrIjU5gB7oLbdePUsDjZQB8YLv5meWRt1EPBoLzhf5+VIF5v0eBqubM?=
 =?us-ascii?Q?kc0rv3oCBn8lSoqZ5ngYp5KBji816rz6uZk6ciOgLzINHXKvDvC8p0DI6UwP?=
 =?us-ascii?Q?TXv2ncelHJtR7GI9w5qrtFzr/ZD63pdsO3/COKGZz5V8rPp2OLxwQtqWPSyl?=
 =?us-ascii?Q?Q3wLOBLwYYVk75tOwMbmz6HM3OHaceKVBNvZpNAZlCX0xzzwlEaYqT7sK5cz?=
 =?us-ascii?Q?wtoolzPOzuz4txw/6t2brzvv1EadvkN53kMm/HlrDQ+pYnOMt2p6FBpSjkkz?=
 =?us-ascii?Q?+l9NjKz9iyKzYdOQ/IYVmBA0DhTLoLDO41YL5kYPnENcf8f84yCIg3C2PnOc?=
 =?us-ascii?Q?xvCD3rKJf98iW31SeZtIc2oTV+aShN4Iy7KIdIZnZ6c/ZMcnP2zXNp9UZkJv?=
 =?us-ascii?Q?OG4Yi3bHfQ3CLhUVQPece7xX1I1Alr8Hd5djk3LYmII92QJBqUTtmbyzSZ4t?=
 =?us-ascii?Q?dQs4+mGAnxft+cu9Ig+n9ZGOdsP78Tu4kWOpbsnEA/3BpCsUBhnGCw0K2dlz?=
 =?us-ascii?Q?2E4xxsTd7m+xt5FStK8w+DD+YNrMXGHVxcnzn6YAnKNF5BKzi9bG+2JNrliB?=
 =?us-ascii?Q?is5Dajeb8c30O6Gnu/4YBGbhmFxqHx7c8QeOmQGX+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qk2qnUvO/ZvwuNenEfO6mmgyOGF/a8l4G7236ghsMN0kaH8SOCxdeDipv4mW?=
 =?us-ascii?Q?buRQCpVYOPh1bzdFJJrAkI5zd7aKKZ1uEQA6HpaQIQnvE9xN9IGSA1wfJ733?=
 =?us-ascii?Q?0Fyg5LZrigSWSJLFDOq0KaPTbxWnI+yzUhPF7MwDvF2v3+5E4EDRyOCDq+X7?=
 =?us-ascii?Q?8kc2K+9xLUN3xvUooHEIWAPeN2oznjp27oZQ+TVDQkz4Ivz4OD6GfX2Hjdkq?=
 =?us-ascii?Q?Iq+Y67NVUlcB4DCp+gxK/xOAWyIOgCGerEKtehF7TwPUnIR7bmGq5Vd8LGjI?=
 =?us-ascii?Q?6laEOy89rBjV59scUGcQY3ICadcrdg6NH/43NihGQJdlUdLFD05EF90GpCoH?=
 =?us-ascii?Q?nfffsHvEOgBN2XO3o60rbNujVrNUXQ8QGhkq8K9zlqBQRdVv60jZ2/zUjyjZ?=
 =?us-ascii?Q?swAsRXvv/oaf9xovBSY2cmWJsrELv0o758TtljXlA5/8F1vEDOI8FaxNMDJc?=
 =?us-ascii?Q?neqXeRdkhA0141QAQ0WlwdlemH+INxWV+io5OE6aybviaJ6/73i8BxzE3Kvp?=
 =?us-ascii?Q?tCgVXH853r0nuD0hpz4k0SCjvthspe1/FKqH4KLu6G4w64Xbpgu+WV/4v3lb?=
 =?us-ascii?Q?BXD/lp3xa8k8PJyfoxFYNbLsMhtC0llySWkrj2M3Pqm84VHESaYiU+SScyKH?=
 =?us-ascii?Q?jODK7iBuZy8RkFREX5FEFUboSLlWY0gI37HfT+9UEjQQsp31xlOIcuYzrytj?=
 =?us-ascii?Q?m8/OrjHkRzmfn9sXXkrMwIPMNb0f5EPpfdW0Qw2VJNWlX6I4pTtEK5R4ZZjy?=
 =?us-ascii?Q?YVpwsil8dhMvnVhLKMMLLxcAyuMZAXgR6QWDamTgk96Pe/F69McnDHSqVZpB?=
 =?us-ascii?Q?XrhLv2Ajx17Zi4MGarlPP6AV+SasgCxkyQtujoC7pNF1wnxB0/L4hGXq/HS2?=
 =?us-ascii?Q?YjOOYr+n0Dt01BDCZJcdrDBtfNILzY343U9Ayl+tt+8eMXI3++Yu62zTyIP7?=
 =?us-ascii?Q?5rN1B1VnH6S0Nz2TuujI4g0cQjkoSKErUWfnRpcX2nUpYiYj80ILYNLnQsFN?=
 =?us-ascii?Q?IEBoLgsT8pQdsXH/PFInKSWj5OUXuXpr+SbrKSAjS7xd2GLOq/g3CNX7/kFn?=
 =?us-ascii?Q?5+oXbdDrlG9GQlCGAm63CTpEefqgo+8IML86Uzmm5+nDzD8APcMK9Zv2GiKB?=
 =?us-ascii?Q?A4wAASyuqoyHG+3Tobvn2huuE8QvOVH9asfiYQvX5MjTM/Yq+hCHbk8gvcVW?=
 =?us-ascii?Q?KB98R3AshHexSuOs6GJojLdyu56CMd2s19XOQTTQOG8OR0tdYRbBHHV2pfee?=
 =?us-ascii?Q?P6ogw2Gfgq2BFJvmKw1d/Bo722kgH9HpsRLfUeN6R8rKee0big4NsVnfgu+b?=
 =?us-ascii?Q?LGlCGepTHFCndumlx4tEN3iZooY8QHtT37HDe9Osqk3dYIooXrSh6z0O19GM?=
 =?us-ascii?Q?tcmiGRxWDcNwRW9fC/Z3Sz3eIIzkmtXHijYAGhJCQFvTuKxy+yClnnK0xMxk?=
 =?us-ascii?Q?ApvSgXnVl5EmbWW5Wd8PrYqsVxeIHtqXiaLBNBnNnPJEVIcoviXdS/8C9gUS?=
 =?us-ascii?Q?+TvRyIoTnnqppCSvOw+Z7aS/cNnO95dh+ZhtUdJ/SljOVP66QbkxeQIhsn8i?=
 =?us-ascii?Q?zX/VOGvwKcTpSwYqcdo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a0a0df-bc4e-4b98-dc97-08dc7b3b4599
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:16:08.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkuQyvRZTk7emY+speGnHFovBD1jOcDM+B6t+Oeuoangt59sLr3sxt6YCK0cjasT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658

On Thu, May 23, 2024 at 09:59:36AM -0500, Bjorn Helgaas wrote:
> [+cc iommu folks]
> 
> On Thu, May 23, 2024 at 12:05:28PM +0530, Vidya Sagar wrote:
> > For iommu_groups to form correctly, the ACS settings in the PCIe fabric
> > need to be setup early in the boot process, either via the BIOS or via
> > the kernel disable_acs_redir parameter.
> 
> Can you point to the iommu code that is involved here?  It sounds like
> the iommu_groups are built at boot time and are immutable after that?

They are created when the struct device is plugged
in. pci_device_group() does the logic.

Notably groups can't/don't change if details like ACS change after the
groups are setup.

There are alot of instructions out there telling people to boot their
servers and then manually change the ACS flags with set_pci or
something, and these are not good instructions since it defeats the
VFIO group based security mechanisms.

> If we need per-device ACS config that depends on the workload, it
> seems kind of problematic to only be able to specify this at boot
> time.  I guess we would need to reboot if we want to run a workload
> that needs a different config?

Basically. The main difference I'd see is if the server is a VM host
or running bare metal apps. You can get more efficicenty if you change
things for the bare metal case, and often bare metal will want to turn
the iommu off while a VM host often wants more of it turned on.

> Is this the iommu usage model we want in the long term?

There is some path to more dynamic behavior here, but it would require
separating groups into two components - devices that are together
because they are physically sharing translation (aliases and things)
from devices that are together because they share a security boundary
(ACS).

It is more believable we could dynamically change security group
assigments for VFIO than translation group assignment. I don't know
anyone interested in this right now - Alex and I have only talked
about it as a possibility a while back.

FWIW I don't view patch as excluding more dynamisism in the future,
but it is the best way to work with the current state of affairs, and
definitely better than set_pci instructions.

Thanks,
Jason

