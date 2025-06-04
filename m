Return-Path: <linux-pci+bounces-28971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D47BACDDF3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9531890327
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB4728ECE2;
	Wed,  4 Jun 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sC5wVPAz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38428F518
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040283; cv=fail; b=oBfRfci83EbfuKJN2SzLUzw7eDdE08Ycy/he7J5kRLLUTByuo/qaKAK0cGTkGcYMLF/2M9KdJPNzsjFkXaTqH42Sag6QzDAGcf6uvzJbynbdYR6AYGzy8j2onbjzT1Z15JUOxyT4Be8OGQmVVBadg5PQOGAPDo/+w1y5V4jVLPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040283; c=relaxed/simple;
	bh=BSC+tveLqsXTT0sVeb8NUT1bCXzw2T3IHas36BSjMyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ugC5zmYMqKrDloa8zvmLbtoSERoljYvw0xH+FIn3qb/JwP7ctleiz4zqe7aEwyjOfweBOVVzaUI6GL+Upp4tGdHOdGdpDfvyPG/utt8VY6WKRPbx4kGofEdoxJtytOwmi10mFzCtB7B0CKtMr++JR6xrSPPDHic4EJJmUUQyvT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sC5wVPAz; arc=fail smtp.client-ip=40.107.102.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIlBAdI63JAs7e3KFAaY0rVs6dRxlUl4HBoXMn21y3ePhCuOekIGPvwbG4Q8YkaocODS41KQpAM92z04UFOynrbqZYoa9d+lKbbwXfZqLIQEJb8vfsPCQ6ELiCpp+zipLaUX22I0xrX63zv3KVmGGG0qjSzAQyc9ncRu9OhwebMeGsoA05yRQqnjwKxte/yBcyGLibC2/Fz4iwClg1eiDyRiRovEVQO0AiDBQnmqH9msV9rhwBPDlPugqI40vvmO+lcWOXr/UiesHRT9APAePRx+308HazrqqNZOa62luopLt7jHpBrS0zOy9RjU8ACpghV04vsjpkmkqgUyvWaX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzAZOg5koqdJ8NV8apblUGaSyCLXt8S+pW8sOAhjgZ8=;
 b=sSRUNRyJ/5fxUtYXHC6sFYPF6Res8QH+oUt3NN4rpC0/3ZwVga2O7N29vmVKepOkIkXZfnWouY7nW4sY4+I/aNlQs9dN5G7tfNnCfIuYIVkrTe5O3AejBrhFviWkpV0Z+QyapfmN9Jb80DVyFx37m4GnlPyO6EddlbsgYfn6MrnmcC/oBVBrqGmi8XQ0lWw4dlvFlo7BauFUT+Oa9QUinqvNhM2/de7fZIhSMRZUB7DbB0K1q/isDxtAQeWD7ndt+dWQAmOhrw9iwFJddDE+z0h4m1bdNZM+3cjPxFKyf3sxqCzwACFeTAMJ2ZCR9lt8dxziaBPIusaQjfrKvrOmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzAZOg5koqdJ8NV8apblUGaSyCLXt8S+pW8sOAhjgZ8=;
 b=sC5wVPAzPmH0ZrpJq9jLHq4T3esmU/dHVYEDsTQJ1Ex6JYyhYTVkXXhg2SeLuQswmDMOL30IDbLcHOq2ta3IKGDNtUdTQ4DSMpMWLdr1gBMW+WabVv9MRmf4XriaY2onVR+RvOUz13l/iOHr66aHBoSsxQSMIcv4JEaTiGZdwVoJx9EO0lQIWqdrtR7mS+eOdc99gWIPO7We/LSgrecwQBMnyAKzjjMkmlm7n4ea2AadHxKCxJojmQxXKBlo/gGMW7m1sQuuWZ17xuBTMAUCBYRa/viZ4j5tLsT7mGTCSK/cy/g9qpgrkK/7ggY/WyV2KkhuCd7WMYcEzWAtSFxxwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PPF95ABFC125.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 4 Jun
 2025 12:31:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 12:31:19 +0000
Date: Wed, 4 Jun 2025 09:31:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250604123118.GE5028@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <yq5ao6v5ju6p.fsf@kernel.org>
 <aD7TZRnFualizeXk@yilunxu-OptiPlex-7050>
 <20250603121456.GF376789@nvidia.com>
 <aD/aOk9jHryygiRG@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD/aOk9jHryygiRG@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: YT4PR01CA0504.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PPF95ABFC125:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbec663-60bc-407c-dd2c-08dda363b4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KdOiEHKk3MNuAjovnUBrJWFhQTlO+2ySbet1iCmg7YFftp1o0munrERzFNWr?=
 =?us-ascii?Q?1DJiPguHZgeTEckvGwhKCzv4AQGfKMfm9BoO1QziTwr0zAjf04/m6uzRdEV3?=
 =?us-ascii?Q?EU3Qa3LoV+q+RBAQpp3qzLQm4hS2UUDTjIrEx0xmcppHLy4EbbLGRfMPiOlS?=
 =?us-ascii?Q?lUfNIj3ci5TqUE7JIJZ5Wct2IxvQSbYFyrmypX5/iCn4PrZl6b1zS7JsjHwL?=
 =?us-ascii?Q?Uuf0S6vL17d6tBUTwW/XlZiMrvjdxQO9RDpLx8RwSra/RnKtArZC4GRA7A60?=
 =?us-ascii?Q?Zhqsc0fP2xy73ZLWFYuvaegNvjCIpjIiZtxPPTVToQ0/gV+ZNGgm7dkH3jcr?=
 =?us-ascii?Q?0oYD7lBT/bVBvWMB5D7UOmNOENtLT313j2M+04bUGCjuVPCxnma3eInKr8Ts?=
 =?us-ascii?Q?2EjI4JubNNbov3cmipGDBKf41t2ABiPWJBWWAP4nWVMyDEry7hN6zeJ5BewQ?=
 =?us-ascii?Q?UF87gJ/bJauVuHzAQ2Z8UroigystOJhChXaNZNXcgcUzGChT1WaeXlnlMpvR?=
 =?us-ascii?Q?53SVB+ifyz+brxh4MahJMLnZylVpgPKGYVJ6IvitTBS1B/CXQ9lpMkDooOju?=
 =?us-ascii?Q?92qDZR/4WSztzPs0XqGFo7CCPW2FTtBV5ZaDbUie/8oMPnonwgOcyr8vaB92?=
 =?us-ascii?Q?GkFJTQuckDniiWbsQ+JHotKq9lWjeIvIeeymJC0FCiWwdWC8nrT+O0qUGSgj?=
 =?us-ascii?Q?92JugDP0AXvSFrmQayZXAXeBC/NUbIXA8a6/+ON11E5L1KFP8U6fSLDG4Qul?=
 =?us-ascii?Q?r1P4jFRbNsrGiO5WBlyvpm/dx60Mutc7UnqK2Bujo2kOPfch3TCDolhnJdmy?=
 =?us-ascii?Q?S5Dj4X4UkT9mN+a5eLtYRjo6OK/YI95AYsOx6aVnbKTTb9THX7MngN8gbglc?=
 =?us-ascii?Q?cSj6sF2S+iVTjnlWIZ/GboINsWat5e4MQarui4Q2wnsCTqs8A0BWkbTw/sQ+?=
 =?us-ascii?Q?imNw5ERjyncswIsNXQBHZ8TYCb4D6HSI1x/kTUCxAnB3pibushKZaAeX+Aiv?=
 =?us-ascii?Q?IzcZ67HTDn7IjeFYJtYIqlX4o6BspMH2jP6idu9La0j/Qnhkqvmhzc+8gdQa?=
 =?us-ascii?Q?hUL7DBYUA56G587r51kixYi9asqP2FbwDOpkyaZBXtAoSjsN01Fhn4M8Ta0D?=
 =?us-ascii?Q?9CYZNCwZaMRx8HAurcvGmOF1sOZV8N5iJi5qjMWIHAX3wqSWNwyipf/AObUO?=
 =?us-ascii?Q?pLBjk6pwPqNoKQyKXkrlOutNTMt6cZip3G2v4ox7/r76FlgN9xLsEqN+6DTG?=
 =?us-ascii?Q?pMjbGY/SCEAVyLYIVTIvXGc9RKxzlYBzmmBi//G1CZ2h65sS8M3VSWVBwZjF?=
 =?us-ascii?Q?BXf8lyWyGifpMAatlE7odd3tTv6R9svp0Gxpbiz7iY2Eya+IrrlyTgF30tqL?=
 =?us-ascii?Q?QkoWE6kr+mZVbJjUwRL4z984BPPGGfdimZTA1TyQ8OItqiuOhubF/7Fpvt7S?=
 =?us-ascii?Q?DZChbnOiemk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X/GiTBM0HR7nB5pQfXAXtSChYjKhAop8THuX9rNJZOpC4moPaq7E11b8TLp4?=
 =?us-ascii?Q?uRPRfrD+JRI2UPAD2fHKT75bu3qh9mn6MFJ4atu6p6JCmKDEEFnHDooMGZ3Z?=
 =?us-ascii?Q?dBRLSf5i9qXpGQiZjI33Gn0PgXzoRJiqsNkNX6I56ZJO7D7+mBjrkwsw3w/P?=
 =?us-ascii?Q?YWx4BCHmkVp3ioidX5Nuf6YRsyEMmwr7swBzOpks81phQg2nNlZojfFljO+R?=
 =?us-ascii?Q?9qfPvivmNhLYcgMT12wnnsaE5Bw+4dQr+0NM4Kx0GUzWHYxr0mLNHZ+F1IRT?=
 =?us-ascii?Q?xf/u6QQiK5wjMmDKw8k1Vyd2tye7a9eoCL4pOq7hkEtJFkiSN7iKEwKdUW96?=
 =?us-ascii?Q?cHEiqyQvv++B8MzLqk8eg0xbrsPX9IK5sFJI7tmVpExRYagsyUZcEAoEL8M7?=
 =?us-ascii?Q?/LpykxqZpHnu+bAngx10EhDJOEhrWczQ9Rd2HVX+p1sLKNZuMZ2z4xRBcXLv?=
 =?us-ascii?Q?bvUpBmcaWsCGTGjVICx+kL+ezZYpKsNEEgA17zmX6mNDUlTL8GWus+nDi91X?=
 =?us-ascii?Q?ZuQvKFU2ziirEg8k2OXLz/f27jPwAw79Ch60Dv51lH9GMOXqDfUKxC8Q60WV?=
 =?us-ascii?Q?cVf3Kk3vH9Vm15TswaHlIxyGQqJWW/MJMhLE/Bi+C+BsiGxdXdtHVbKan3Hx?=
 =?us-ascii?Q?mmGyusvFeWFzzZZcG68+bneeIjF6+xltu4cF8P9TT17jCgWPv/tppDt+B2zU?=
 =?us-ascii?Q?6cNtj2suJI/STaNrVDocaqSxOf+Eg7Wrb3wg9nZz8HboYNiuRvJB8Bi6m0ui?=
 =?us-ascii?Q?HXwmji6kdtpa0GFsIjYnGZ7lu4PaQUzOw6erL9VaZBaGdnXAWiJDWn5wQv78?=
 =?us-ascii?Q?z5ejbv4X5kAGZ0qQkLSns47eYF6QVKEMyiGruy1zPIZQ3B35i0OtBmFgx1JH?=
 =?us-ascii?Q?jMCsuZbdU5JujoM/+2CfuYLOyQ4GUzCULGGyMH0uX0QIVGb6HydqNCN58o+a?=
 =?us-ascii?Q?hRjoRywY5cXh5YHrbmN1hejjzgG8CFbPZTnV5Y6h7wiBePyiqXmafchPxGH1?=
 =?us-ascii?Q?fyYq4Gg7PU/72QyMuocQtHbJ/GCkrsLdPFUfghMqk6X/eKsENKnNhW+F8vqN?=
 =?us-ascii?Q?j3g1zdVd4RvhnojCf/d7k2gsPkQxyLsMzRzMyQ8kzym7EeP8yNiNEyhsbNjI?=
 =?us-ascii?Q?P4R4sHamG7Wv9Du9p0lJWvIKZI8B79TT/heqT3brMC4k3Jnp3c9D8hfoxaGh?=
 =?us-ascii?Q?21R428iYUEtsFLyD1w/xkjBsr8OOztTEP5dduD9X0/JejOPH3uooiWUtOvBL?=
 =?us-ascii?Q?xZuBAT71fmmzN2sg+aUgg3RcpwK1f3tVISnjvbDAPtOIwQMKQTb9vilFx5K5?=
 =?us-ascii?Q?AktUtpWhMZzulHFvxQhbnsFklygQrHgfZ9jy9KZT79t3vaSKwnd/OtdXVH1n?=
 =?us-ascii?Q?pLVaS6n5h8AgBKl0xvINyTIKTai0v6RdIuaTsmuoWrjZgGNznIe30c4ZpqW6?=
 =?us-ascii?Q?aokVIP3iobKS63rI4QJc8nAO+juSHvcMgVelmKzvu0ozBxHGTTfwv9L1vtW1?=
 =?us-ascii?Q?jxgs/K03H3vK80kPxhcey+nUpC/LOhQXVqonyk/sTEoFS9sa9Q87IBbPhPVO?=
 =?us-ascii?Q?PqOFnCWeN6oJFd9YHrOniVFh4lATn8bJpvTToBVB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbec663-60bc-407c-dd2c-08dda363b4ed
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:31:19.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXJa+CblN1QgpDcB7hdJXE03hfIW+zI6LX7ZWtk6kQyAp16P0BXJKIQujUnLUJGJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF95ABFC125

On Wed, Jun 04, 2025 at 01:31:38PM +0800, Xu Yilun wrote:
> On Tue, Jun 03, 2025 at 09:14:56AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 03, 2025 at 06:50:13PM +0800, Xu Yilun wrote:
> > 
> > > I see. But I'm not sure if it can be a better story than ioctl(VFIO_TSM_BIND).
> > > You want VFIO unaware of TSM bind, e.g. try to hide pci_request/release_region(),
> > > but make VFIO aware of TSM unbind, which seems odd ...
> > 
> > request_region does not need to be done dynamically. It should be done
> > once when the VFIO cdev is opened. If you need some new ioctl to put
> > VFIO in a CC compatible mode then it should do all this stuff once. It
> > doesn't need to be dynamic.
> 
> But the unbind needs to be dynamic.

That has nothing to do with request_region.

> > I think all you want is to trigger VFIO to invalidate its MMIOs when
> > bind/unbind happens.
>
> Trigger VFIO to passively invalidate MMIOs during unbind is a TDX
> specific requirement.

I still think TDX is making this too hard, the S-EPT is controled by
the TSM right? Why doesn't it do the map/unmap of the MMIO as part of
the bind/unbind instead of this weird thing where the vPCI function
creation is split up between KVM and iommufd?

> Another more general requirement is, VFIO needs to trigger unbind when
> VFIO wants to actively invalidate MMIOs. e.g. before VFIO resets device.
> That is the dynamic unbind thing.

Alexey is right here, this is a userspace problem. VFIO should block
FLR on an bound device. Userspace has to unbind as part of its FLR
flow.

Jason

