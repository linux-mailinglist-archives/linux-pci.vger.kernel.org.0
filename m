Return-Path: <linux-pci+bounces-28854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D2ACC62C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 14:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF4E1692B5
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E1222F16E;
	Tue,  3 Jun 2025 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rIMh91a0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73D22E00E
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748952498; cv=fail; b=AMnRX9DB3n5p0MeErQLXU/hG5hjgFnMjKgm0OrV9fpGbh0fqmPJnTsQjrpdEVIqCik/PMxYIaufUUPB8SGfO9BzkGd3AZ0H994+IpkdqNsSpZruoqjPwb/oRSbncj2VZ2Y6xBQaYTftdVPCAywZ3DzjbcChK9TU5dva1gtEunHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748952498; c=relaxed/simple;
	bh=PP95UOYxcuPQ0YdJhuaH1PdR/d6oZHjz0D4BF5xfB0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pkfWWSVHecNYjovblCry7dgkGrJnKd+bAQiSN/e0O7LYEBzh1GMFk84BYHXexOPs/eEpiIALMnGwRwOFSaqYVKwx1kJMel6d7KL8D03fYSw8x+cF18MrU5WrDcRKeBjG7G2fKykgUrDzt4PIkpywIihita6Jc3Glxcm0rP2kvNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rIMh91a0; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftevMVyB+acCVw16IvTsabPpwhP0Za6Zu6UKSGhQyoMMXoUurJ+H8HleGldDMbzG5wgOnSus+okbEWOIF4ZA9Iw7GX8xiCTP29nq8ewvXKuXZYrh9QORpvfLWxqPOosTKWfTtJU7oe31n0jdGB1im6iwwhLiCg0sOPmy2wRYJab4EmaWrZCiQlx3lCjVBBKYVCtXhGgHjrjL4YeMjQzVj3FiA2u8ODCtCm3sH9YtBOL8EKPGjtYVdbDqsn9FBoLOmH5Spn2tQPh2kqKH++EPuZrXpzsQSG08FuRdrHT6xF+06rwXAYFsX8VGGcbYgKwoQUYloPs69paqG/6lbst8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIDC6LgDwUD1j+o/lDpfDgcMVYgdBGeWNR/nuBS9oKs=;
 b=ga8yG9YgDhavTKjRhEvzJfLt0VvETQG0NFJmi5vsYwuzdfHBKoKs1t0bsDssOfUDhqgB/IkJrxzMhYbknHRol4gQZl6QeS+1tQAUmg2i/7jPwvbCaQCFU9I7GXksdUpjIFypOa58AxRNDjYYwbMCXoTPPZWWazI1onDth6YCYhse2W1HnRKc4TnJNZf0O5/GerRqijxDG1/9uBxc4D+zFPc2BNjVr6LwL+NpnLtNq5myE2+De2rZfXXkGkvx4FAe1MT7OxpyR0V3BY7jPJXDgYQLGbi4z8aPkG1kbCubS4p7rAXKzpqDnS2UKf4a4z313P5iZigB30Px7QEXFOAB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIDC6LgDwUD1j+o/lDpfDgcMVYgdBGeWNR/nuBS9oKs=;
 b=rIMh91a0mWgjMhV1JJB6o1OQDQAXmdSlhVxfbdeYdWsVz3QErWpHFeel7wAxWK5GcS3mlk5LgS6Fqz4e6Mab2vuVfhUni534Io6j4x5vd7++RLg7dYXxF6pUra/3mprSSC5JCfxx6Tx0HacgZOD2I1Wbhr06qJ4x8SKpCTqhIaMfUkNFzdpNyTTNpTy2UYWR5yMud1XK3w3gCGe9KgV1doBr3QnZdtFrbW8hOBAbUBmZqkHspk3tFX5d++lKl3GSx8byKivem+T1C9Rkdc6EzbEuS5D4uB5ddj4xjK1mo4YWa7uL/cjVIDOpG6Kja6GzhtzvBnP80rPup9RfD92U3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 12:08:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 12:08:11 +0000
Date: Tue, 3 Jun 2025 09:08:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250603120810.GD376789@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <20250602124718.GY233377@nvidia.com>
 <aD5wVXINV1QJnMbO@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD5wVXINV1QJnMbO@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: BN9PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:408:fc::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b59063d-9991-4ab9-e607-08dda2974fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1wM0/KQNycqbawiT+be6Be1T3iP9nqwFiTfhAAqgMphGuHBeTjXEPodlKWdl?=
 =?us-ascii?Q?MhyFHKqYFbZ1sppShoGK1YT21nToLJH0qyWLXA/Lue5IfdkfZlO9FPU26Oi+?=
 =?us-ascii?Q?nlf8UJEEL6dJrQ4U+ufkVimT8k/2AiFh9VjO0yOwgn3ocRqWVvVTO8mcrkOr?=
 =?us-ascii?Q?oD6o330F8Ue1+V0HfZWSh074Omxw5Bbc7y/i0lPOxOalLxDzuDDHVVyylLZI?=
 =?us-ascii?Q?n/J4Asaj1ZqJxnzgYKFVhyxvbvttlMHGK4kQkiNH0/g4ZKPWt+MmxorL+k+Q?=
 =?us-ascii?Q?JUwsFEzPgxUMUT2MKRX7LVwYWTYpHNjGxLYxDddRvsiAmNqKzSPJR997cSnM?=
 =?us-ascii?Q?Yk5u+HC+e5f3MkQSNkfa6bc0bIPr/slvnA0b5VzH0hO0zADXiuVo8rrDd0Wo?=
 =?us-ascii?Q?vJkjnXX6j1JsLdMjajc4XXKfMLE1pfYZw5z26qrcwR98gycMGMAhyNFhRZeT?=
 =?us-ascii?Q?Jok32e/r3EAq+2fiU4XGnfP8YNiHBwSnXwklZWMPbNwMyJJk91jN5Oauyzht?=
 =?us-ascii?Q?39dOzDTSa86QCWT38tdBcNIZGtI8YAmjd2N7INGz51ByorY6mDA5ZY+Z9zFG?=
 =?us-ascii?Q?Pxc8vIbYiuflyP3snrQAs5TCqL1XQWuE3YljH9H+9A2IupSxQ9kRMIqbQHXg?=
 =?us-ascii?Q?KmJaekvV1aAU+5xfwF+rVCy9KwJ25+CibtkDAbfwYFKKWRtQT5lj16MnEjMy?=
 =?us-ascii?Q?gDQ75tQagrfGqR9Sjc5ghvE9tSnEYADLW8Qdn52pitv3MQX4lPqwe3OD/rFK?=
 =?us-ascii?Q?8F52q/nYbyfBb1JhmJ2n2KZ+AYUH4PooEfmytAwWhdLOZxRZdXVlaidbzA7H?=
 =?us-ascii?Q?c7bqmJoVxINojSPSth5VOaiQeoqipO8WFVAC4rqKWq5t8pprBi90szECeUuL?=
 =?us-ascii?Q?9gaGYtz7I69eSU8oeNC6OumIYSQkP6OrUDeAFRK5ZHrEOvDYNxZwR2ZznlNs?=
 =?us-ascii?Q?qgQ//Cyojn5TEVofUfNv+wOyli0UjSvPClGWVKPiMDcTOUy35PbZ/baFBGdQ?=
 =?us-ascii?Q?ierIR8DOh0lEd0w0WK0VODXcS5pPuyJnDPH1raakMn7rfSKcCXEHG6IpzR6w?=
 =?us-ascii?Q?RRmA/uTNsGspvjYic824Hls/Q2FXsaoFMMPYvEOvTponyxs64FMGNRhgGs5d?=
 =?us-ascii?Q?UwmbYVH1lTF+kL91pYmPLnA046z5yTTmEZ+HYgkgxhlI7KgtYLIl18iYiQgM?=
 =?us-ascii?Q?53wFx55jQFR+QylUpSFNAy2Hk8q6S76jCUsgrGa9VdDq+s3CF4Cj56WbOmQL?=
 =?us-ascii?Q?slqWC8fCdTaZTqvDyfwkynhzrCRtaABIMEbxlT0DfuzaZ7rfeGcHFO8fd+rg?=
 =?us-ascii?Q?Jj62DVBQwAvqnbGI2O+BoDxW0A31YM3BFHc0WWZ2yotu25PcR7GmNSTpbof4?=
 =?us-ascii?Q?eWgQibgeMypLS5h3zaC5NJRzUaXvAcUpW8Nx45HKl0jRgH13POG5CMSTbMnW?=
 =?us-ascii?Q?KCOvxofjAtU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QuMgyOp9rjqTaiH/N5cc33A8Ud3n2D5b43hq0hkkrg0BcyA8m+hdfUsJ7gmt?=
 =?us-ascii?Q?wOAq4jht5t+6rJILLWuFut9Wm8QP+Om8sBUZUS7X6D1JHn1mve6N4+5iBQuq?=
 =?us-ascii?Q?PiN5Msuzi0SOV4iJcL/JabPtGf3xDTM/7E4VcsT7kIfvVjvLO6QsgqsB1mfY?=
 =?us-ascii?Q?4K9vhEVFv+0Qxqlj1/HYRZRZlkPtzqo88abqv90iaszDjwQH7MVohf4NlO4m?=
 =?us-ascii?Q?BGsyt/duuiGtkZoGqnL20ObFJvhjMm0IJ/+W7/Zn7jUHzQUWJ7uYS9GMsz7J?=
 =?us-ascii?Q?Z4VjHjt2VZGVPesTYy5bMNUwosa9QxINtmg9HfIf3LKgqpbA/NTty9ti+VYF?=
 =?us-ascii?Q?88Uz2Lu5738RhDp7GM9ak33sOyu2Ay4tVLSFS+64Gx5WyD9R/DdDOHuVjYSW?=
 =?us-ascii?Q?2gVF7iQPT8UzgQhcSSkv/Rawdj+CGMYp9PaROiYc+6e+HmZeqXNd+qEJbb3x?=
 =?us-ascii?Q?HPNmVopeRHCJN0oNeDSN6OnkqIvJhcAGdrKV9/Pr+iII//G7Hgi68tgh2uld?=
 =?us-ascii?Q?EbtmCK9/Oa9POz29r4NOj+3nxsNp+4HcOuRzunUeYPyQLRiDZkzgUPNlQ3gw?=
 =?us-ascii?Q?ZJK+ztSSN7rgSS50n4RF/LeP0WIr/mZEYzb8tfbA0YLwO5PFJVBLrk3NQlhF?=
 =?us-ascii?Q?qEqn4qiZPv72prY029BTOM5csC6GFzSDlbdzP11gkg/gN4n1cpTV1F7udi+d?=
 =?us-ascii?Q?M2ynCQX4OUNDCkVH39QgxJG4uQYcoyzYy/m9d6Q6DN8eSwsSraLmPIvJwK3p?=
 =?us-ascii?Q?9Fl3poMRu0ns/S9XJKIWjZTdTkPrO/LS9/f1T8tfJt3sE2fNdCd1RVCqDSYI?=
 =?us-ascii?Q?cgks3kVZ5GLIkt7kbVnhcNOfkGdU4zshP6zax3nlgeRulbfR8k83LyYaiF8Z?=
 =?us-ascii?Q?n1U4pQVnFrOvbG0hIOh/OFaruv+xgQiFfpMbU+IFPwf7BXQ9tUkXTRyMMs2J?=
 =?us-ascii?Q?g5UgLZGMy97iYk6U8Il1SWHQsdGn2dBbfu17lICgBL+EHzwi9r2cd2g9MB2Y?=
 =?us-ascii?Q?mOMl3Tk37rcPq+EDyO4azE76efjo+w9U8j2X+UCXMbJJ3GmC+LDgA/3sLZ7s?=
 =?us-ascii?Q?lrf3MoLChJ6f2vzMt4FV4pSl2hWzBoMtem+dBTF3UVEqE9nzuKKbl6rahWR8?=
 =?us-ascii?Q?1GvMlj/iHFSjZuZ6WReiqEJ9/PxsrEJWcLNwvoGKBPbE70N0DTAButnkzh9P?=
 =?us-ascii?Q?WD5bt8OkWWqZOwasb+5odhG7HCYXuGwvcVr2U8GPi2aGUaznLg8SIriDtpuT?=
 =?us-ascii?Q?+mFcD63Zh/SedvXN7uLIgbze8FHUVC/v8v8o6GEkuaCYXjvAwPq+zstzta22?=
 =?us-ascii?Q?wi7I49A0eOu3ocilmtTRPtnCw3UEiQ0vIfPgTCDyj5zP0mY8W+xGEXT42tzY?=
 =?us-ascii?Q?9mQkB2dRV12cgKmHY6s6PjcBQKHTR+5JO4lOX2uFATqQJ4b0nyIjqF3yR5qK?=
 =?us-ascii?Q?eY2feh/9FEuFSYG49jb/4kHt+WFoON8l+75IWXYty8AA2TftMM5LpL5o5lpf?=
 =?us-ascii?Q?HdtSCOcms/8Z4J7RnXdpC1EEUTVaTM2Z4opO5WBsBSpOORSco0kLdJyHhE0j?=
 =?us-ascii?Q?YgZOpVlopHp57kWzn6nq/EQSSK7yeASEEFNJDt8p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b59063d-9991-4ab9-e607-08dda2974fac
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 12:08:11.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1KmZtNI8hmURDLCvSHvICp3ddbhm7iOoVeLlHEiwuf3PpAaFZhxT0S0uJT7DIvN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792

On Tue, Jun 03, 2025 at 11:47:33AM +0800, Xu Yilun wrote:

> VFIO doesn't have enough information, but VFIO needs to know about
> bound state. So comes the suggestion [1] that the VFIO uAPI, then VFIO
> reach into iommufd for real bind.
> 
> And my implementation [2] is:
> 
> ioctl(vfio_cdev_fd, VFIO_DEVICE_TSM_BIND)
> -> vfio_iommufd_tsm_bind()
>    -> iommufd_device_tsm_bind()
>       -> iommufd_vdevice_tsm_bind()
>          -> pci_tsm_bind()

This doesn't work, logically you are binding the vdevice, not the
idevice, the uapi should provide the vdevice id, which VFIO doesn't
have.

If you really need vfio involvement then you need callbacks, I think.

Jason

