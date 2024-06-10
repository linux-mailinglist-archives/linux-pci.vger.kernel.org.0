Return-Path: <linux-pci+bounces-8531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E02902077
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 13:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1781C21BDB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8B67E0E8;
	Mon, 10 Jun 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X0ca/dk2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39BC7711A;
	Mon, 10 Jun 2024 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718019535; cv=fail; b=cTDRtmiIZVZ8JZoI0BQSZfodN+HlO4Oz9redx2P2EdimOuEFpB5t1eEsVzx35FaYcy/er1u/jhYaOHTZi17Zj7THspByuHE2i+NqIKVOfhRbzoRQq/uOVUIHbhYpr1sTRdXS3pDS17B5e9g6x3whTORYtc8JCN5rkG4Z4zptwsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718019535; c=relaxed/simple;
	bh=MsjBzvALUFtVyUD2drzLfvELapq8Bi/nn1rbdXEJZgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y++H10/sOXMSbLTlhOHrUv3s+jHTtJ53o1zWqguvSNkLauvw3nzw6hwy/ycV00tXHYEi2QeN4XfMk9pruWQZ0UiZuN68UVFBO/J3E91nOPNJBkMMjy7heIPacvT4RwPrr0faotrYPE6OawVgb0Y9A9od6qkT/geaoZ+88L6xryU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X0ca/dk2; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UO2BrOwCfkEvLyBWLglC+WzIQdCUoV5QYReshfK5fMX1zlOdtRX/w0Tpa3J8crE3UidFwv+tuL9/1U101hx3GxjfszIsPe5hCytzAsFGred8hAMfpjuZ+/HV3TFyoCcvCEvXgHyOFTWKHUKDLDkX8urRMmF/DRkn0q11LF9+ero6q7VNqUQMGlIqRbORD6e3roB3Zk642C7+y8yAO1tmycFFQzNqtAOb1DutWeawIavDbLE73XKyW85IkfM4pXcYECf6v146gkGheZe3xgUwG7pnyVxq/bLhVM0fNLHTS4EgYz225RKbjt85cAq9l87PM+R+qqIijhwMBI4pRrwUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmBLEIu/Eaj72qY62aMWEE/Kego9tgkSP3qWzJsSFqk=;
 b=h11akyrowpJuL3+/a7IZFWUgGbxiaTLf689D78Ncj8v+mtvAcq4t8DEUUPkEWyc2jSp89qgRb9Dc/HQof2P72idT6vV73c0BzFzhPrPoIyL/fZ9GSk1CqSgN1gvsS5dP5Dg4Bj56x9zDg5Q2vEiK/X5beH0Fheuy1IPWEuRWgqxpve50dg6Ipfcv513VHlTn1wXVKmGZtYL7VMTwugwX48/3qbwvyncsreHDLxRC2/79bgO3ILCoQoUScZFqBPdbdpaVeOaff5zimD5JiVzq7o91nnMSydnIUn4ouzMH9OIOYQzEK46Vto55A8p7u+kdb2ElfFVfiaxLGt4i5slrlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmBLEIu/Eaj72qY62aMWEE/Kego9tgkSP3qWzJsSFqk=;
 b=X0ca/dk2wOdQ52PVdG5nAB7htMvC7gdSDDRkFMLMm5ZY71ItepNRMNKWp++tcAB0hFVMZoH3rjHj57b00AFyqmBxxCZ+i0RWPajXoZrudzRtM4rHdrHBsWeqTnaTHBrgA/m4zNWq/OQ8tsF53KYSfFskgaTilE6uYJ2ILNhD13a1RfvNp506UBjshoY4iZLhn9HVFGpl4e9Fg1vmvYUuZnBtO6Q6z9kA7YVLVy4sea/GT20Wblfml83iIaXksomRZAhPJhoY2Cm7O5h5CN5eZnylYjr1U0WTWBcQnh5JvMt6erovSwrehaxcY74S3hLM9HZIP+6swfeo32YsQFX4Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA1PR12MB8888.namprd12.prod.outlook.com (2603:10b6:806:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 11:38:51 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 11:38:50 +0000
Date: Mon, 10 Jun 2024 08:38:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Gal Shalom <galshalom@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Masoud Moshref Javadi <mmoshrefjava@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Jiandi An <jan@nvidia.com>, Tushar Dave <tdave@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Krishna Thota <kthota@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	"sagar.tv@gmail.com" <sagar.tv@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH V3] PCI: Extend ACS configurability
Message-ID: <20240610113849.GO19897@nvidia.com>
References: <PH8PR12MB667431B8552D271F906F8F4BB8FF2@PH8PR12MB6674.namprd12.prod.outlook.com>
 <20240607193055.GA855605@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607193055.GA855605@bhelgaas>
X-ClientProxiedBy: MN2PR19CA0053.namprd19.prod.outlook.com
 (2603:10b6:208:19b::30) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA1PR12MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: df7f2763-ea82-4607-5969-08dc8941e5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DrhpAvkvYWurTNc2fPok1xTawM3DD004QCgmSRrrglLV5bB4eNanQESoFJHE?=
 =?us-ascii?Q?UDImAEnYSg1QHI3duNn7D7f6xgrOausXd/kYJGb3YVcOAJO4ibO3aWy2sBkZ?=
 =?us-ascii?Q?AAJj4XtWTjtx68s6E+G4HqzKQA0V7/hvEYEvweQJeM5STnBauJr5qAJdRj37?=
 =?us-ascii?Q?Fp4HN3JdYiOPj2iJ4NkzB5vqg2KcuVgi1xGKU0jEwG7ryBAdrm1e7XB5uCmT?=
 =?us-ascii?Q?RfXNuITDHxi63VeE7fr8kurWJOaZh/x05Ur5Yw6rzISq1dxv8mHTX+3XTpva?=
 =?us-ascii?Q?eD09xCCW2bkssUEoaYmvbkNpoBjwS+oQOC5PNdMxToigPKeext01mlxzOhme?=
 =?us-ascii?Q?2egAljifDExYIpWNVlfGuXPn45cqh0KKxgUyCl9xKCKHOfBRyQU/4+7LYmyo?=
 =?us-ascii?Q?BBtU2GF1XA2lxi3pTY/lxgt9hxNfdeVX9v34+UFBSO2sIxEmILT4ZcJ97fSl?=
 =?us-ascii?Q?l0Dl4ZvriBl4S0OyQos/BUPzBz7Q+1h+tgoNEsOQeHMKEse+ENnK+HnpPU4Q?=
 =?us-ascii?Q?h8MVVOo8NAeQiO5Dd6NdnP9Npb1kSxp7XhzZi7Btsi9tHvC5PRTI87uBccrI?=
 =?us-ascii?Q?Zs1GO5H/aIKLasC9O9qaW+nKA3wjqbiQjSvuikAE/NJ8sCMoN7HS617hhlFd?=
 =?us-ascii?Q?pzt+AH3AkpOrIlzUQNZjMQz6fvZAJm0TYSzIfHIRCnVXRi4xZXUCtUggCfuR?=
 =?us-ascii?Q?RUO+lEwrF6YoJCnukKtZ0Uw+Cl7kaoWF7H9hWFFsB/pnW1gTL1QNrcWuQhZ2?=
 =?us-ascii?Q?6NQyEefTaHynAZ6TNkpujVT4EirRBQzesElte+9qXiAKMMEy9X5DungOv0/C?=
 =?us-ascii?Q?K2Voq1FFBGJkeQoRO6dxnn4Uahaez7oHkvpvsQB04xjPxAY6kyU4TbU7uHwX?=
 =?us-ascii?Q?QoPnXGHBClVQac7EtOQ/a5RALN03pNBscoWsSxI/ObRpWwd+Mi8doxXHl2Z6?=
 =?us-ascii?Q?lr33Zcgi5GdaOX3ZM8/RpjPjcEzGPu+hQUi1LZT7v45au2zR3dbpi1GlHH/b?=
 =?us-ascii?Q?dm2u81A1B9NdVwt9SQeZkOKnSrxx/qgSOycZ3fXgd561BfBjQHxvo6e4BPBp?=
 =?us-ascii?Q?26qEwx0G6CO/iKE+WhyNE399COtSZs1QdvS99ciQIrstAm26L4GFqJ7iWnnF?=
 =?us-ascii?Q?u5m8fIT3sc96ZzsR1tbKXg36YL3wvVyvZwD1UcSHauspnGBB4dp2HZ0JCYz+?=
 =?us-ascii?Q?94cryuZr6Vqg785Dwjrq2TbvZu89cPs0rhrchbf/GjXHvG2NLWjz5Kleol4m?=
 =?us-ascii?Q?r0X8HSA7XYsQ4jjqeVlzlogbd2eiWscwgpBxjC3nIcPAybuml/pxQQ3Yjinw?=
 =?us-ascii?Q?QoCV/sqRmGg1lnQQRyNfKeJH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ALjp9ewB/Bx0dvyCnBgOrjd0hOjGqpSjRGkAJAVsiOxd875Pfozd+oecrXFa?=
 =?us-ascii?Q?UV06UX8gk1IKLQofszg2jMzGNd8QTi5b54D+UK5ovsGZX0nbfNeBnJ7glSB/?=
 =?us-ascii?Q?NikLlWTP+LpqggswDjPrTdzOEYWkDTIitx135mI84uPZj9aC04A2d5DvX1UY?=
 =?us-ascii?Q?bx1kMQwE9irTsGUv/6jsdu5vhXsQNGt1w+SYYOHUeU8rlu7wKljsVGUFGa1r?=
 =?us-ascii?Q?dchX1QdyWVS+nLuT74Uo4XZZ7JQzZZ90lXWGTQaMQhNzma/FlTagvRnAWCfu?=
 =?us-ascii?Q?Na3bXSJwdYBcqJLHwdeoVAhOmF1Kfi7V9gRuoZllO1DzIPpJvRInt99mlykJ?=
 =?us-ascii?Q?FC2aVAmDyfNk24f2tDyAalZUmm7AVXiVZpjsLO7TFriN4/sZEfZJ+N5kcNS3?=
 =?us-ascii?Q?A4Ci+YdpM8kMvKVmPFEfojQF/6n0XM3wVtLoG/FeFs3+pRE8EQhg6zP50Upj?=
 =?us-ascii?Q?7leLcWM7tN9Uc8eEFATc/8mKP7sSjmyqDm3LcgPF/JYrCllI/RQYP2ePI1nJ?=
 =?us-ascii?Q?eUixH+TqM0wHAdWjloDDn0OAHzflRyqU99mnljisQdbwzjEjgAPciIlhmaU8?=
 =?us-ascii?Q?gREtbd1TizRJdyMBleaDfs52N5mTWZoGAMrgEGDq0kV28hGu+eCsBB/yebsu?=
 =?us-ascii?Q?V7Z31B3Cu+USDKYqL1v1xnu3WGBgWtKZjP0gXapXkm2uXd9N5rC6vYOkU9+7?=
 =?us-ascii?Q?9ukokcJ7IrUWiMHPIgDz8jTk131aDY+r8Yrprv4eTcJRqQ1dAr0pQDIoWQWz?=
 =?us-ascii?Q?gvZOHb5TgWHCGg+7JoJWasEiS3FsKjkzosxSPx9RVz91UzAgoPMfyp41bCB6?=
 =?us-ascii?Q?aTg680JH56fwjfiZfrUidndp+CtWyVTQn+AvWz5Gkd0C1up+orGaBgGDaCmW?=
 =?us-ascii?Q?BH0Bz7s7idXKRH4KFly980tNlsWQb697rZv0yBqLI3jFmDzyMq9g8tHIhZw9?=
 =?us-ascii?Q?E5MV3wdqfMwQomXsfbgZhqhCOUAQC9xSvIjO25RwrsPi0tlF0rz/A0qbUuFA?=
 =?us-ascii?Q?AOOARkCCGIZebrCRU+L88MXwtD3wlpxiA5K0yQFCn4SW/yjpDcavkM2vmAOk?=
 =?us-ascii?Q?0SiKvpMhQBKq38vko9l6L1lpFHK2aGDcmva4I6cQTlrggo5T/S6o5koes+p0?=
 =?us-ascii?Q?j8taRjBEo8afSvtAIbeQ3KvKj1E+xqJaF+1TADKQ7UhNhDUHtAgGIlyyLnCJ?=
 =?us-ascii?Q?IwaQ2t1WrbOOL/Ml5l6hySQKP0h1vHSNo9WVJOCCz3U0g+M62s2suJ9Vcx+N?=
 =?us-ascii?Q?R8pByNGSJTvvDc23F1eZzLG7HsrNxXXOVaOTQdBgkhvE4KPjP5AMp5y++6z3?=
 =?us-ascii?Q?+w8Z6gawfxPSQ+cdM51PVY9ZmIRsBvMOoD9wxFhasEkLQWmtYBe2F5yFqQBV?=
 =?us-ascii?Q?rCiN/tDty9nyR9fAMNI2j2ihQe2ALnwYXES+nFrQ+4LRdSKBi6yTQbRanXLS?=
 =?us-ascii?Q?sdYrz6gBzIeITVaOOzkyjP2ieRVsFpXtyiPjmMJRaZyOyRSh2cEpo9df2aJ3?=
 =?us-ascii?Q?N1AqQVOC8U5e8JCqtvJtkj0e0FaVPyFyLYG/HYyXB1sAtPdOpLSHpdB3SryE?=
 =?us-ascii?Q?bJktozx3XG1No46BPIs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7f2763-ea82-4607-5969-08dc8941e5fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 11:38:50.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0ie6jC0Pi82XlzrYpJwENw2I8wTXlZ+HdM0bqF/LunLpfn4R0FQip7yY4v5vrs8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8888

On Fri, Jun 07, 2024 at 02:30:55PM -0500, Bjorn Helgaas wrote:
> "Correctly" is not quite the right word here; it's just a fact that
> the ACS settings determined at boot time result in certain IOMMU
> groups.  If the user desires different groups, it's not that something
> is "incorrect"; it's just that the user may have to accept less
> isolation to get the desired IOMMU groups.

That is not quite accurate.. There are HW configurations where ACS
needs to be a certain way for the HW to work with P2P at all. It isn't
just an optimization or the user accepts something, if they want P2P
at all they must get a ACS configuration appropriate for their system.

Jason

