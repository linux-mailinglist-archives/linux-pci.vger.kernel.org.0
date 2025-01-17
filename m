Return-Path: <linux-pci+bounces-20057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D33A1508A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 14:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713BA165DE9
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 13:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3691F9F55;
	Fri, 17 Jan 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lkrrLF5k"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2551FFC5C;
	Fri, 17 Jan 2025 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120487; cv=fail; b=R6bGfzMIRhyFxF4BkHkhjAdqBLE4/xihceMUc5jTEKRGdrcmCoH+gAN5AQ5i9k/EW85tVKY7oNzCQFq4LvL1Zccal8+c7T6r1DvpRYkWllnkhMrnT/1yo5e4DZ/qCy8MbaKV8ki5ObF7EGaEZPKPouLnb/+k18Xex2qmRRDPVlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120487; c=relaxed/simple;
	bh=yDO6n0Tm4DpBqRM/FmxFFvOFKdSRlmtZwgi/SZ3Emkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sAmEeQlIMfcpWcBXLrVPKV0pAe3XuRBNACZhBTvxz4Uo0u/VrDxyGLEry8+gF6IRvWSGBbnT7gQbPGNWZNMUZLVBAKuCEnWtCJ+EbFiqWcL1NMmTBXHHHWf2WTGQgdzcJFgd2Un3tw2qoXWmkN692/RVmN3zWYdIGkCPkkoYxUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lkrrLF5k; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dl5d1vqD1L2j9wHZxMwiF7uz0cHe/8L/PJwoLI8y3boHg6bhwcIWte6Q1cAJJAJeacL6/Tgi0uUE6XTpzhT0D7aLkPB2e2++4dbph9x8dHmCWmxZysec9F0K3upMUQvRNPYVtc9fnwRuWeWPywWdH7hZYDkxBZCdLVmMsFJvNpinyMyqei/Cx/8ylG1CPXcsvPQOcNYc9E5eaPPOgMfmntyLzyxLL5vbPbehkMic3E88fjIVL6Z7G/FVeEi2B0WZfNJYuPE1baR7cOr6/iPF7t2dpFx9E8VK7fDWC2iWdtmiCTNBjQslEqT6ssQzKpkY+yKAgf2v0DZZKIu85J2aUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cy2nkjRU9MKLTjqXLgvFHuDIfkYQ8E9FEce0szHWt4=;
 b=o1Y3bdy69TE3eiMWH9SQ6/P1TEwWKWLJ5NOgQHyApxg22jxEcp9RmL9NjMXP1YBMPxOiATZ5Vd8VW4SyctlyVKLs7deEBHWpRWh5RONPntuAaalD1qqZR1HSPRefVnAqX6xe+jAGThU3My018064fahlYVG7djcbfQ/+rhngjE7TqAfu6K4j5+TjEvfwomFaYync8ejpdp+1YNeyN9FwRartszTj5Oa1IpemZs5pHCEg+CkRMhNMk1O/Ol74EhbcSlq1D+vKw+R7Tsa2AeRLut1v4XGEeSp+iO+j78+PuBxmV6zMT8HJ1Tlvxm0+UjWQSXdPpD2E1T+n4UfxDwbq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cy2nkjRU9MKLTjqXLgvFHuDIfkYQ8E9FEce0szHWt4=;
 b=lkrrLF5kBRu9rR93NIhpzld4+qrb0h+Qfqy3vOwyS+n6+HhctWrFI2I2KR9dBfTcHBn42ZVG3sTLsJ4d2xb4IJGZag/JkYnvZqORFOYVAmZvEd5b+dirnuy9ztMjlysIPEF3Zt7q1rhZRJ2CwuC72iC3aCphft2snDTjd0cHwHuSMSrtSGGwqIAeFin3ze43FsiYq2VVwpwPuTfPz+xPdMqziwHB6/nZycRo0436EVl39h6A8xfYMAIZ8V1GjEIsF1KkxiH9TSq7rCGTIf1f9Mepnb1vVWDY+7suqfMVGsOeQPtk7x20FJjMCuR8r3c88HX3+N/8RqwPOBhAYLHeJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 13:28:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 13:28:03 +0000
Date: Fri, 17 Jan 2025 09:28:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, vidyas@nvidia.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	sdonthineni@nvidia.com
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
Message-ID: <20250117132802.GB5556@nvidia.com>
References: <20250102184009.GD5556@nvidia.com>
 <2676cf6e-d9eb-4a34-be5e-29824458f92f@nvidia.com>
 <20250107001015.GM5556@nvidia.com>
 <c9aeb7a0-5fef-49a5-9ebb-c0e7f3b0fd3e@nvidia.com>
 <20250108151021.GS5556@nvidia.com>
 <0ea48a2b-0b6d-49e2-b3f7-ab4deef90696@nvidia.com>
 <20250113200749.GW5556@nvidia.com>
 <6ea9260b-f9cd-4128-b424-11afe6579fdc@nvidia.com>
 <20250116190118.GW5556@nvidia.com>
 <4d5224c6-bc0b-4ca9-9f1a-71d701554b3d@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d5224c6-bc0b-4ca9-9f1a-71d701554b3d@nvidia.com>
X-ClientProxiedBy: MN0PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:208:530::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: dff643d8-03ae-4551-ecd0-08dd36fac513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DD6Tkaoy03wEJqKh3+a27sFrJp7gtmdbjnBHx1sb2FMBZp7hqNHKFyUO1wHc?=
 =?us-ascii?Q?4H+TdzFBUBdGbds1PCcY4uS4rN8Sh24nonAK809h+QilCMiJANs/zSQyEkZZ?=
 =?us-ascii?Q?Wp8BoS2mk40JUnhyxTKQkrqCggiyCKzwPN9CE3XfQw1GeqOYwD8FY/qd3Q8q?=
 =?us-ascii?Q?AZqimYkMoPVixT7zrGOA/K3Bwn4sN1nm0oJ/pFFzODZSdL9BfF0M3nYR6fxQ?=
 =?us-ascii?Q?+NkKqhCudYKaec0cka66HSa7XdR1vg9MW5XE0mNIplr96/4zxRRKDHLgFf34?=
 =?us-ascii?Q?FFu/8+UT3K5d8QUv9cUG1fTtsgJjJZkmpbqvxGIGAOvWEIQzIl9XjYFZObEK?=
 =?us-ascii?Q?psWevXcSzCJqx5s/OH/PFZ7HpCrpwJUqYlAIDhPHKQTbeByXqyB1Wqmq2YLI?=
 =?us-ascii?Q?M0feqlI0ujDVJVgy95fYURxQE1LodOUeTYHWfNhgGC12c5N5gpakFmk2o0qG?=
 =?us-ascii?Q?pwn7rDAlZ40lETAf1FtxIp6RpDME1Nx5MtZaeOynKrTlEVtw86yNPvhBuD1a?=
 =?us-ascii?Q?msALd+W0GLkKJ/JOomFAs6sTpbDpLLm/xIevdRTiGwUWw2uBiHnCjvJ1BoMI?=
 =?us-ascii?Q?GqJD6de/KWkevvvT/XJfppuAFnndgyf4aapcmKoIkAQCuo3m0leL7VqpTNQH?=
 =?us-ascii?Q?SORrXSGpftYURZMgkV03vOHHu2WFsSi0IQ0cPVpc/C23XEkTioG3F5FqEm/Z?=
 =?us-ascii?Q?COBtIWFnhspR2H+gPe3DjJB7enn7cazCUC+9AqP0om5xzS2yScTRNrZJRN0b?=
 =?us-ascii?Q?CD/ql0eK2x0Q6wx68a5ZS4ZSy2iZ4wlcQeFvZf+CyGuZu1eX7BJ8hBnFNanS?=
 =?us-ascii?Q?fQE7KoslyW5uC6+ZqArb/vbM9RQUDL6F6sENnUk9tUnDT26mQyGUAlfW8pqD?=
 =?us-ascii?Q?cEf+XiAM271UP4swx245IaoMnLiEt9XIfzIfYrHTa9RUsXNOi4zrbJP02ie/?=
 =?us-ascii?Q?hhNcRroU7AKx06jyCA1VpEFzu/Ik9Au6kjwAuhFFT7IkOv6fTrcZAO4RWKSI?=
 =?us-ascii?Q?YPlgP9lG7ILQwluGvg6ad6eg09E5nX72qFIKcXNWI95UirWtAnN7s+mBl1d5?=
 =?us-ascii?Q?xJBU58qVkV08HgQ9Mp51se0Qn1ate2jVit/Fz6X22r2VcILBztkUeAregzTD?=
 =?us-ascii?Q?uR+KJpEAn+4auMMK9OvKKUQ1I+/xAjrQcNP8tq2xVrC8ER15ev7/OPEkkHIB?=
 =?us-ascii?Q?MSdUlA7z8dJJNuk3og0ZFkf92FKsLVtl5mA7AwKL2ZxdLXz0XmCBpPbbzWmn?=
 =?us-ascii?Q?5cXr5MtEsby42FBO7JMS75Mt/MKuimDqdW0ji8yMV37HBzcAblRB2Rf+Sehk?=
 =?us-ascii?Q?AQnxQhE5ztS6lrogQ9m993oXAThTUafOSjHrCFvDV1stVElLRKdnSIQ/BtAP?=
 =?us-ascii?Q?hkoT5xMe+HwOaH2KIjAyNGv5Y4eD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EBR5E1QdEuBEnYCelbDFFB736ppKF/BF9R5DWoYlmpey99L0Ly3d3R1+KmAw?=
 =?us-ascii?Q?4EHzE3g+JLWgvcZ+HlaUAMsTGCN2yAoO5bvLZ4CiNkLdlL4F+iaFMfquhZDJ?=
 =?us-ascii?Q?hOtAzSHwuX7aO2EjkRDJUjUYFZTdnZLrqxPpCtg8DGF6FWdzT957hVxhtkRw?=
 =?us-ascii?Q?/xEi77d5slQkqYWzRYzHVtYQI+B4tU0gpRVueimTnofKf7g45wK+1r0BhI/G?=
 =?us-ascii?Q?EyitxhczBZ3DB63KYcIwitk8DS7czko22LCuQzlJINW7dcJDP7WGjuIQpzg7?=
 =?us-ascii?Q?kF1bNw6VcjFmICjbjJvACOV8uWNDhK8o2X55eAYgkdsW150J9KbxMXGZaa6c?=
 =?us-ascii?Q?D36KNR1jl6k6WNuwfzy0EfTLLyn6DSHBo0BXFQvTsrOmDcetW3gv4MYf/ul+?=
 =?us-ascii?Q?oLDERQOiT8Dp6ZAVKC9azSs7/5n+WwqB66lvwJYT1z3jXdYUi6o4J+NhHTe5?=
 =?us-ascii?Q?1doCCh0naFHgi1TePYcqttXNiqDkDmKEgoCBOiU4j1fDZeux2mHGy76IW0vU?=
 =?us-ascii?Q?KtCXRGPEectpk4O7rlV1avp3oB9EvRkpjKoeLByzmM4/MwdbDf/2Uzabn9Ew?=
 =?us-ascii?Q?j+5XSIrotaQ4e84ZNCkLuto0dNv7dln3YIYJfAl2bo9I+UjzGR2ekOPukHdl?=
 =?us-ascii?Q?MEFYr4QN4gSMJtedEVDgXU8x3U27lyQYc86T28daU3M2CIZEE+lt1xLMRi6V?=
 =?us-ascii?Q?cvM4Hyca1udcpotK0l13VO1tSG+xcH76WeB2mWMDWixI7lTLSmqTGSc5vIZQ?=
 =?us-ascii?Q?jraaNPXo6fQgrSEZVanUMKvO1hKMs6xLKYxj54WNS+QSbbVpaNoK8zI83553?=
 =?us-ascii?Q?aw2O6v4eZPDdXeZxZqPRtRhn+CyW2pOuH8TSvwRB492DLCddPX2TrsW+tLF8?=
 =?us-ascii?Q?E12LCvvLYVbIpHqTvQ0MOeKNmkwrpyN9HxAkcFQ7bQCmI27UolXNIJuHdrck?=
 =?us-ascii?Q?AKXdm9EG3VVi8d2dTG2NucAjXMIJ/pVc9NBd2WXO48oEjtESX96QMSnaLkmz?=
 =?us-ascii?Q?C0TW98nDCIz7PBWmaId25zVXwThbNaHiiyGkIuV5bsUx1aLy762FjsrQzBLg?=
 =?us-ascii?Q?74ItfWkRw9pLBmIW6ehnZydONoLrow+F6iqaSbad38TCmRWYsqAGUHiLmodZ?=
 =?us-ascii?Q?PmP9prUFb1ZltYgRXl+GF8awib6dNfMMHizpv+qwearOKoVmbLEh/UUwVsHr?=
 =?us-ascii?Q?cBlg2vS9AyfKVP864qBNGJvuljktpiEMQTahoJbUHCBoU/Ypfyg2uDCuSC/A?=
 =?us-ascii?Q?YQwE952qhVQBCoglRiio0FEKTgIngmUTeAzD5769UX57SjaT8ih1lX4PAoQt?=
 =?us-ascii?Q?DFcafwDLDwk4G2FuQSIvqzW2dR1YsqJoLz3Gn4YG7DbreDEpn5XATJehMukx?=
 =?us-ascii?Q?vjAbyNPNiRnql6OwhQRaSzzfsJHjghFBydEqmYQ8L06anH6/nP8O1xnc6gXD?=
 =?us-ascii?Q?cTajxOevY5J1E4FOsASXM7sbVkolNzfCOcV6axxvdxUJR3HfSYvMJmz8OOd4?=
 =?us-ascii?Q?0gSTYlnIoXzUMn4GC+VRVP9BQtK6vPPNBKr+ijmbCSzMJVh7Q4CRoTYJxJyc?=
 =?us-ascii?Q?syssu3txTwZX3rqV1xTGfcaSLTBkrpkwetOf8HBp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff643d8-03ae-4551-ecd0-08dd36fac513
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 13:28:03.4531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LQo1hPSmDyECUk0Ze/MKMpjPyyq2qKToxqmzIrkO98EQO3NI+Y63yg458CP+2Qo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111

On Thu, Jan 16, 2025 at 05:21:29PM -0800, Tushar Dave wrote:

> -       /* If mask is 0 then we copy the bit from the firmware setting. */
> -       caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
> -       caps->ctrl |= flags;
> +       /* For mask bits that are 0 copy them from the firmware setting
> +        * and apply flags for all the mask bits that are 1.
> +        */
> +       caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);
> 
> 
> I ran some sanity tests and looks good. Can I send V2 now?

I think so, I'm just wondering if this is not quite it either - this
will always throw away any changes any of the other calls made to
ctrl prior to getting here.

So we skip the above if the kernel command line does not refer to the
device?

Ie if the command line refers to the device then it always superceeds
everything, otherwise the other stuff keeps working the way it worked
before??

Jason

