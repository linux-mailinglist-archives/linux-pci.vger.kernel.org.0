Return-Path: <linux-pci+bounces-19546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B6DA05FAB
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 16:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C184C7A1FC0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F3815E5B8;
	Wed,  8 Jan 2025 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OOM7cKny"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A51FC10A;
	Wed,  8 Jan 2025 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349027; cv=fail; b=FY2leUsIDNDUfO4tJ8hRdwEK/TDgC5VjFZK9VEZczN88nhtZJPDkz5fWzJPUBZLMgpUNE0Ej107/Al7LoDro1WrIFFS2uIJgeY83f6JXsnJfzSWE7D8pHVFARlSwRE4Jnep5ocmzu1Wrp7hKmXiQq1cU6+wl+I/Nuu3mq5pUn20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349027; c=relaxed/simple;
	bh=ZDQQKVhfmJCNf7tnN/L0ZPfdVn1Uw3AxCUadNk2DS9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OweWw2zyjAo6Mu6ZgnnD/i4qfn+AF0C1dzBcLs7/Rjz3gCnYFh2WcduncmIT7KTxiMKjl4SyGKLjOyWBpSnE5hJMjowWc8giJH6RzEYEqYeA4qGr1Mr8U/BsqE+PgTJ553TElE39bm53PuJhiWhikonxhP7ps4bvCM2qhUwBkUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OOM7cKny; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvLj0b4ghoUppMcXYKPJLTmq7qozYIC1V1G8r2BRhD27JdoP0mlpVnuOeOuq1mcjaYI/uMTze2oX2VqiA8BcVpnnUbCDEspRsWXWhJGGcs1jzGromMq0KY5CrKg9VLruJubnfXbPVezXahNhioi6KsFbljCFMD6bK1lbjN4ySmTFS1Rsu6x7J2DE2xC9lvmKePJ13MmcIjk9o9xuPEauFMCsVxjoGKm7iEeMUeZM0LOX+dLeCLbDii5gDXxlW0wYK5LwxEu81k5DwUhaxsvP0FUrx7lncXRlE2ZyMTmaJSedqdqudcxLgzmL7jD1ceez/O+x9KtF0CbQGENMjwIsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGq6oq3Ix7ZMgrD59NYmOx+3mYc9TxKT603gNPEQhhI=;
 b=ZbXWPIWQ2sujENoyKxOF9eVmMPBjagv4rw9GwzAyUgBkwkXnb8zUP8307pB4YLamI8YF6G/S92mNmCe6L8gFwh3EmPiqXDxxuoCNxNq9nx+nd121RZbJHkGCkAqlFjq+Om7Y+w/c/CQ9lIi713M4rPpzCYfcZ3j9++UDSNzVEQQLTirvJM5yJhnj4jYHeAxyLzDI5nh3VFxiBdHFi7OTCDLPruJy5s8LNTKjoms+lY8wv3cRkztCkDN6s2OYsxQ2YID+NJLq15gEXxOes6OvmRDnP9ew2ear70rvlflGN1WZtM/Qcdueh5mPMyRmy79xmoYFrVNTZQ2nkHsz++60IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGq6oq3Ix7ZMgrD59NYmOx+3mYc9TxKT603gNPEQhhI=;
 b=OOM7cKny1lDZA7nNL6Dy3DWty3jDMHd6M38BYPv/CK9HSbKwJDzBsQd9tKm8ZlIlrM51LjZAyIBiOlkX+vhhmPTe3Um+FaYrGF64S9r5pcwslI+ltcwxC+hpJ6Q1l0SFMdHHg+ad3nEqDpglTa0DjVtGI7xew55YV/MhbbE7vhiXVRPhW3mux5K/9K5IvEVWylvZ8ji5kLeMdbAKuOcN/tnUX397X6lTLtvF3GjZFWf/oabxvb/LkZ4eZoyKLyFfAGewhV9bYsx5kzoLt1MyY3wzCfeQ8dVAggxHo3YNOjsOhT2A/cfHNBaISv4QIrsNuwmTDa1qic4CdAj/Xyaffg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 15:10:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 15:10:23 +0000
Date: Wed, 8 Jan 2025 11:10:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, vidyas@nvidia.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	sdonthineni@nvidia.com
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
Message-ID: <20250108151021.GS5556@nvidia.com>
References: <20241213202942.44585-1-tdave@nvidia.com>
 <20250102184009.GD5556@nvidia.com>
 <2676cf6e-d9eb-4a34-be5e-29824458f92f@nvidia.com>
 <20250107001015.GM5556@nvidia.com>
 <c9aeb7a0-5fef-49a5-9ebb-c0e7f3b0fd3e@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9aeb7a0-5fef-49a5-9ebb-c0e7f3b0fd3e@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0680.namprd03.prod.outlook.com
 (2603:10b6:408:10e::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: f34edbcc-968f-43dc-250e-08dd2ff692d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7gmsd2rwP3uqBTc+lxaJkMa5Vrhd6N4N4Bkzh5/qob+v5noR5PFS0ndTyEbB?=
 =?us-ascii?Q?7W3fCMREz+4R/Ag/sQNLHQ9/hWFz7toLqFYA0+CodfEUV5gZO0+9k5KMIfCx?=
 =?us-ascii?Q?URVTUkaNCuZ+rqgucvZ2GUWmij0cEWpXgU58DxLFjuNyXqGJ3AD0EvuB7c0b?=
 =?us-ascii?Q?rVrx9dP4dHaPe+yixkpLkQgbFniXloBlKxSrCeqjv0FmSx0jACziMslujeQA?=
 =?us-ascii?Q?ZKWtm2q62Yox6KzpDQTXxyU0reFW4IdPXwkI7ajuVucyVU5boiUqfdeNDI6Q?=
 =?us-ascii?Q?77Cal8sSqs2DC+9XUC4cvDaKR3KNqGeu0YdNWRxbsUY+Wf9jFYgYXuXAoviK?=
 =?us-ascii?Q?3I78ENCxkUYkWN/6tdwDn7t1swFFq5jzUUhUeDTu9QCseC8YN/ddS7UjM9Ap?=
 =?us-ascii?Q?rglVtD/qgh59NLzO9CzE/sTVzsYDeJPIeeK5b58y88TDRpq68ZImr9Xit3Lr?=
 =?us-ascii?Q?j5MNRfi+pamGGXRi8mYhpveI7Vy1cJ0xaJ4+08q8hGmk5ix/nE4JuSrM3nxL?=
 =?us-ascii?Q?oqlRwLB1mi5pqEmKuoBfwXzo6Lpgh4H7M2ulGqnNU/Zhpo9XJBI3yYbjFF4Q?=
 =?us-ascii?Q?Hc/enMST0uVOgSEfiq4ILUzDyx+WxXlW0SnNCxkqSzBqt9y58rTDIovoILAN?=
 =?us-ascii?Q?+wBZk2gSD5mfDG6L/smjKmtDiaS2yeKQFMGmSbRsPFrvFHq8ox3toFgUzYyr?=
 =?us-ascii?Q?GrhG7uR8dAbnLsqgB489Vr6dxjb3P4bxY6jOcW0qjfHxOupLctBvQemmLYme?=
 =?us-ascii?Q?KyQEd6Amvz0XiQNjQdtbRaAeKLEcbyTDVe9kqF4SROGWQp/mNeUDBMEZTIwF?=
 =?us-ascii?Q?YU9LiPp3uRzpPcgZ7tBTdhu3Q4d5s2g7l/k4H1NEoeNFNe5eaGe9VgRwrDGW?=
 =?us-ascii?Q?uV4kr7RxURW9oVsnsLoVK0QIRRjyMe1Boa5r92aXKvTUZxl+DWwskkh9mDuu?=
 =?us-ascii?Q?MHkXrcw2BPFRuPP88cUnz5XhXGbuCqH6rSrc6NrIb4KfdOfqxz68zoqsUuu+?=
 =?us-ascii?Q?6STzKxxyKOc6y7FvBDn+gJHP2G+VkWcj+Bugagm5UUaO7yIFe150oR6fzyL0?=
 =?us-ascii?Q?7+Cmiioh5UqqGKVF5za0385w7gHTx9rqgzFKDJkdXNrl+SfGvKN0oznCxXoV?=
 =?us-ascii?Q?TtIkqT4bRVtltmfHo+irig3NDATYBK1mOTG2ebsbsG4cPNfuM+mBdrNJkfNi?=
 =?us-ascii?Q?H2qkPKWBouV2rOlN1iWiwe7/xJO+bQEQGVT47ilJr+UM23KC+SV2T9q1RXVh?=
 =?us-ascii?Q?dPveSnDByZqzzwLHzfrWfvHRPvTWUsWlJkOVF60syW8tf8k7t5pEXxJh1wBZ?=
 =?us-ascii?Q?KMcxzmS1KRqPnD6SJaXb5HFVNF+FlBj5aPtGl0L4L30WToSZsoxzCP4jU0UW?=
 =?us-ascii?Q?bk2wruMEDE8yYCJDFpouCKh383wS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c+LS1mLr1pPgkqhfTywdBvIkc3W3Mjmy/JPgHWle9gjMujO5J3vxuBfJ16X0?=
 =?us-ascii?Q?WLqJ1srRECHITgP40hwM/3ehTsKV6JTjxSPOFL9vMZZkfwFVUXR/6tDgkmKg?=
 =?us-ascii?Q?dscJJupbXyig+Y8AhFeJad6SotYpW/bQ4zs/KwFDIlVWqL6Fz7/do7NH1JmR?=
 =?us-ascii?Q?5dMhpe/yoH2ArFRwXkUeNTJvbr7EcStjB8eqeqIRW9/PuLEezfzscpzmhzRm?=
 =?us-ascii?Q?DY3TGEVi/+cq3acuxocaNx0FxqWULIgGMe13eF+JQ0nctCWDgEkFd2YDkxXQ?=
 =?us-ascii?Q?d9w0l5vYs4FO9Pz+IfbBY0KVTELIIXducAvOv4OeeWsHWYwDZbDDJlTwDLjr?=
 =?us-ascii?Q?iEeSRlPOgNX2O2h1aKKtJX+1eAJUupqrO3dMF1AGfjQc/2LUc05o4Xmge8jq?=
 =?us-ascii?Q?dmQmPEcCgbIxFK+kh6PiRWBtci7yN2PjSjLEoqVUR/tte6RcR/kcNsabr5gI?=
 =?us-ascii?Q?yq4466hQe6UOhdKIR7jB/dZQFshnVEjvXz6ZGOYqR/IRQ+yxLwb3pPPXMfiq?=
 =?us-ascii?Q?tqL9y8iqYYRMFZbVPdALG48vDekpkUmtLlDfjz74l9uoKpqMmzm1ljCY/S1M?=
 =?us-ascii?Q?WWiurz2OUiJZ3pbvXKiKOw2jfhCW7VbRCy6SjE3mZTEuMvvK8XMbwU3LHY3C?=
 =?us-ascii?Q?5tlapaIqxAjFHXHRWae+VOKSSb54c9lC0EV7uMZKhAi8pZPJWKYXp2hzdukb?=
 =?us-ascii?Q?ZTqtEa1norNTJgfJDnP6L+eFd872FPmT91Cm41x3uWEmMUzXNsJuSVS6bLxT?=
 =?us-ascii?Q?V/MSfxvcxVnOt4RlKGkpwxppNXRLs2YmF4leeHTiz6UIdyYJW0FrnldhGV2h?=
 =?us-ascii?Q?wd5GNsIpuhPdCra6MhqE0qPAdAOQBHc/XoZMWYN+BzSpOyVH/hoscXG/ZVMb?=
 =?us-ascii?Q?JgKPfXol28SEHyge4g6BDoSd32115aMybXuqa7BwVtwEtphyuW5LjaDzJ7WR?=
 =?us-ascii?Q?exClH+o70abbJBO/K8e4AG93PxuPDMDBsZX1pMreM/2JcTzuTVSOnzcUvb3p?=
 =?us-ascii?Q?uswkNY/lQqpA0ODjAL6F3QTTZ4320FPCyl1OlsWzd0Lkb9Bdo6MG9/9unhym?=
 =?us-ascii?Q?TKu9ZhXydjyDGnIy1ZKGYJLmTg0BlOYWlxIQEcm5XH+PzNZNUo2GeajeB1v0?=
 =?us-ascii?Q?2AkFqw2WisIjuQEt7L5Qo3rwznrXt2zvaKcbkUxPB6Zf3pvBI6AvrKhNbepF?=
 =?us-ascii?Q?G476s8Amb8BRUQWaH+HRxG8XYWaDS3dwdEAVF1loT11RNSJhvW7elhPHhaGk?=
 =?us-ascii?Q?izWG51Fd4wT6nOX/HdppP9vtrJdCySb1Fa3cnKOBUvi5IIAJCUheccC415DW?=
 =?us-ascii?Q?OflxSUVXhkm9uzo8/AAavJx3klm2A6Ueh1j6suKmhAGRa8H6BSgCQHLNrZsc?=
 =?us-ascii?Q?dOGZaccX095RJEbLII2dl0W/WExbZSGM3ZfUq0Sk9VPhm0eEbFsV5yLFErx4?=
 =?us-ascii?Q?bVzJHCGZEEd6POEzu3+rs9XfWoj7wONgN8lfysuGjW0OzAawwwjyim+Zf4EC?=
 =?us-ascii?Q?6MEDkyyrBNPvOAHs0RBiSNJjUoULEd+4ftIfxzGM0Yiq3AujWypLPemQo2J3?=
 =?us-ascii?Q?ps78lOQ879u/kY+z0nT1m1hY4AjQxbCE57XNUNPO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34edbcc-968f-43dc-250e-08dd2ff692d9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 15:10:23.0190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhiLUMXuOQ+pKbllOCB6MzrnZSbbHcMeWkEuH7ppF0DmzT4CfQlp2rzet3d/H0xA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265

On Tue, Jan 07, 2025 at 06:32:42PM -0800, Tushar Dave wrote:
> 
> 
> On 1/6/25 16:10, Jason Gunthorpe wrote:
> > On Mon, Jan 06, 2025 at 12:34:00PM -0800, Tushar Dave wrote:
> > 
> > > > > @@ -1028,10 +1031,10 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
> > > > >    	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
> > > > >    	pci_dbg(dev, "ACS flags = %#06x\n", flags);
> > > > > +	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
> > > > > -	/* If mask is 0 then we copy the bit from the firmware setting. */
> > > > > -	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
> > > > > -	caps->ctrl |= flags;
> > > > > +	caps->ctrl &= ~mask;
> > > > > +	caps->ctrl |= (flags & mask);
> > > > 
> > > > And why delete fw_ctrl? Doesn't that break the unchanged
> > > > functionality?
> > > 
> > > No, it does not break the unchanged functionality. I removed it because it
> > > is not needed after my fix.
> > 
> > I mean, the whole hunk above is not needed, right? Or at least I don't
> > see how it relates to your commit message..
> 
> Without the above hunk, there are cases where ACS flags do not get set
> correctly. Here is the example test case without above hunk in my patch (IOW
> keeping fw_ctrl changes as it is like original code plus pci_dbg to print
> debug info)

Isn't that because the bit logic in the code is wrong?

> -	/* If mask is 0 then we copy the bit from the firmware setting. */
> -	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);

That comment doesn't match the calculation at all.

> > > If it helps, using 'config_acs' the code only allows to configures the lower
> > > 7 bits of ACS ctrl for the specified PCI device(s).
> > > The bits other than the lower 7 bits of ACS ctrl remain unchanged.
> > > The bits specified with 'x' or 'X' that are within the 7 lower bits remain
> > > unchanged. Trying to configure bits other than lower 7 bits generates an
> > > error message "Invalid ACS flags specified"
> > 
> > But the fw_ctrl was how the x behavior was supposed to be implemented,
> > IIRC there were cases where you could not just rely on caps->ctrl as
> > something prior had alreaded changed it.
> 
> I read your comment in https://lore.kernel.org/all/20240508131427.GH4650@nvidia.com/
> 
> Looking at the current code, the sequence begin with function
> 'pci_enable_acs()' that reads PCI_ACS_CTRL into caps->ctrl and invoke the
> below three functions that prepares caps->ctrl before writing to ACS CTRL
> reg.

caps->ctrl is supposed to be the target setting and it is supposed to
evolve as it progresses.

> 	i.e.
> 	pci_std_enable_acs()
> 	__pci_config_acs(dev, &caps,disable_acs_redir_param,...)
> 	__pci_config_acs(dev, &caps, config_acs_param, 0, 0)
> 
> Here kernel command line takes precedence over 'pci_std_enable_acs()'.
> 'config_acs' takes precedence over 'disable_acs_redir'. IOW, if config_acs
> param is used then it takes the final control over what value is getting
> written to ACS CTRL reg and that is how it should be, no?

Yes, but X in config_acs should copy the FW value not the value
modified by disable_acs_redir_param

Jason

