Return-Path: <linux-pci+bounces-28671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 436B9AC7F84
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 16:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F023D1BC03AC
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 14:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FDE14EC5B;
	Thu, 29 May 2025 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qKy7MfdS"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5BC147
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527552; cv=fail; b=aOqHQNpb57jhIZk8u/Ssd65yUXYyFHJXJ4s7E3y+hT4AAmwAMj6oLqYecsrB63ipcvbTaiG/VqKropMCAlt4Q08N/JbFlWCAlMqeoFWhK//yIgoeTjXiiOg28gjB+lZGWaHxfchMD9e/BxLnw4miVB94xwKBg1b1iA8nRXW5hNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527552; c=relaxed/simple;
	bh=NIZYgUW1xrJtGsdd40eumfxDvlSwv9Xkp3JILRJIijA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hiJJbQ+0CfqHdfFw8Nck30rIeMU6Z01OTmrj36BBUB+OB44YXYSPXDT+HBKDiestqXMXumYTKh9qp6tXIMlZ0VM0IRvYkMNm+TUkLi6zhiwLAHhETPxXLRNt2eqdoGenPyBu7joIwnHYFmGPwwLuRmbF90j6ynRhLI3LoTJJOh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qKy7MfdS; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQ/LHWrV6SsqBkuRTD+NuOPcuLI3wtDEuLLLVtgByUmE80RDmgHDlJ/MQcqyXSHwop5eLo8JG7sTGr+e6C6O0Jr1R/oUTfpIznMJitfwkt7Ol1VPXFjNDMr4zE8YwCwb2unIYxTM33Jqypd3IEcWD8Qg6rt7c6phbpp5uzDSubKnH94HPLx23iTsZXtDL6ox69dOJlv8MZH1yV66vhV0tPOCrC9PP9E75Hlfpd65bmEW3nSihxK+RAtzv2JGqjt3VA3YrTCPVCCaFOEadekp0WEfqQ6oACFCicHRLxDIvYiVTpoyZL4wR49mjhrwV6fenzjozkYOGPKEx+3FTcxzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s6IFoEuNz+IWiT7TapFhyTJGPoohs5noq+lcap+Z7k=;
 b=UOzBTtHGC4yiWguUjxXAx2kWvdHjcnAxlOGVj7Fy/FnQfIEMSug/rhZkBZJBbOO7FnOcxUUysVyv397V1hhS3ZDOPlH/U+6umPh2EIqusHtfw6MVL1FKssaVKLZX077MqcLY12BV/cLscwLDAHceZimlOcMALG/xth7aWHYi5HJF02Q59GnPx44rbsbmFVUA65FmRp/SBJhkX7OF0ftpNjbgmxbkJNr+LaH4zdfovUorsZONKEATHLufGEe/MhBT99OIeW5LyXaN6yRklMGoWFdk3NcdpsfRknnHcRRriYjB6bPqDtNJz2S3sANpZgLzSFLDCPQyRKWbhd7qs1fpaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s6IFoEuNz+IWiT7TapFhyTJGPoohs5noq+lcap+Z7k=;
 b=qKy7MfdSZTRu/Tb7jj8L1N2Ke/ObT91A8GaMbWFyi/ft7JKSc5tKT7q5PvAltP+SLXn3bbTV2Nd9raZvvbS1Un8hyZVNSocXI2Lg6W0ORsKhDsQAKynuW/Vh/jTbZCMg3qfivZ+EAMTfBTTF4b9IDk0VRsjmFo0YX3iCnDZyI/tiFsSNu27m5ILPEteQq9MP7tPL4ddTOIB3WfiqRpNu7ABqrRDVeO5fNOZrdWW1+NOJHWJS49uQ3sgp/M0EXc5dszhGpoq07KevWF9xmp07IWftEDW5/jR2wJ2rriYdsm1vT+8DWKY9IqyW8m5WEDjM2z4HYnR/CAeDsJovcJZrvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 14:05:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 14:05:45 +0000
Date: Thu, 29 May 2025 11:05:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <20250529140544.GC192531@nvidia.com>
References: <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
 <yq5abjres2a6.fsf@kernel.org>
 <20250527130610.GN61950@nvidia.com>
 <yq5a8qmiruym.fsf@kernel.org>
 <20250527144516.GO61950@nvidia.com>
 <yq5a8qmh53qo.fsf@kernel.org>
 <20250528164225.GS61950@nvidia.com>
 <aDhl//XH8HNwJPJ2@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDhl//XH8HNwJPJ2@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: MN0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:52f::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: a4312d93-4096-4cde-eea8-08dd9eb9e81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/RxpsPlG7/LEkOc8YBKybOgT9y1zZQhNbOFFJiRmx5xiOym9rKZ1E/yO7yhj?=
 =?us-ascii?Q?v1Cz7q7wTl5xO/KUe/qD+UAuVv/iHV5fNbZ6YO9IccZEUmcJKxfbGYAw8DKE?=
 =?us-ascii?Q?0gBWxyscDnp/sJIFyrafkAlX4NvqanDYEW2P8vdE7pYwxpsNuLrYs9PWDiLw?=
 =?us-ascii?Q?FJXmd67DIfcSAbBTHciLSlcEPSKGeaj5KyvSpgTkKrZZxHwMhvsV8JN2koxH?=
 =?us-ascii?Q?r+pg5iBTqWTyA1R48DvdBBNVLvOqI/YnGlqbHIu8yhuhiu+Sdvx7WZjLjPyl?=
 =?us-ascii?Q?Fu4mwIzxUKKnWNWrvxT3RJ1JSoXggP3meqEIl2Vakn18DUkl6anwiSGVmjxu?=
 =?us-ascii?Q?T+3EJg3YtAPdXUuJHodKE4GgGkMO+nQQPqw+7X+gtkA5SVeeqavaRRMdvxBT?=
 =?us-ascii?Q?kHyZgpw4R7ofXLQl+wA44eLPHCSpBD2mUETloIP08VHZbrqBRPEC4Uk8EbQ2?=
 =?us-ascii?Q?tbzMWIhBP+cI33pRN9JQDWV8HwCYEbAd5zcE2MJu6gGRAu/oR4WBJetKxCZE?=
 =?us-ascii?Q?2fUue9VJ758LiZ/ssWDTK+Q8FZ7+YiKVTmyo1yVwOhKCHXfZqUIDihST+cCe?=
 =?us-ascii?Q?Nk6w+0wmIJjQjdWr/X29mkYpHgMDzDU4nSvAYjHLQ0+PzvGDNxVD+H6FjyHL?=
 =?us-ascii?Q?n/iTQmBqSzTN5eKYfFam1Sjh7DETauzXi7tzdqYOl5hdL/E2WCniF0mrEztl?=
 =?us-ascii?Q?rLMWA0TsZDJfFD/QImFevTqA/POiXpfsp+TdosHu3CAN8coTpfFsBAVaj/DB?=
 =?us-ascii?Q?Gz5Vlol+3OyvW0bzJyS/aL7Bi2TaKPK10KAU8EAo/CPS8UPOtvarORemcnah?=
 =?us-ascii?Q?z4AVviwSiI4OoJ3Y6NPPgF2Q66Je4+2NAm6dPI465uNxJy9m2DuLeOMgnfPF?=
 =?us-ascii?Q?mRDeEQXNqkUTcQUrpmSLaUhMLmYaKohDp9ZhJvJREpf6zSI/Br4CWxb1TweO?=
 =?us-ascii?Q?iukflqcFHGTcqH3ZW486GugyxsRa1qSrd6nwdOsUU+Ky9dGm2BTn+VzfFnYY?=
 =?us-ascii?Q?+nClkB95WKdJ2ryX76ByhaQo6heBYFjCWon557xNziCLDUlnMEKfEu/08OEu?=
 =?us-ascii?Q?jafiMOe3tiU50pEdOhKyaoaAMDqGrAe9OGhdW/9iOVl+XYYJYhQCX2ClAdjY?=
 =?us-ascii?Q?pM5TLWbG2kmp/MxwaCpJy00G/r7gyXNgDjzbF7AMD6D9adDQie7SbSBj2cs4?=
 =?us-ascii?Q?Kff+MrwJh78kaeEwSDvUg6MTMkPz8bPNFyu9xCVneNXAcJO4oi7DElNm0Fev?=
 =?us-ascii?Q?cvNlQd6uvDKmd80Ye4UWHzltp4hUzqXWLndMEazcQv85KIdY2Q++37UIgEaA?=
 =?us-ascii?Q?dKmMuB/Z0juhK87xQYk5I8zlWlU3m6pM0Z6iJo+ZxXRe9R07NLJnlW/CANw6?=
 =?us-ascii?Q?polqzPyLWcYaG81ZzSQHdmS1j0zFeg4Ng05eonFeYHSQSPyPgXkQi633m6TS?=
 =?us-ascii?Q?tDLSUFAEM+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VTT4F3UoC80cfal0OQaDbippF7PyjuGiBd41p3vaFSjhwSMXbFFZ7HkPVeCw?=
 =?us-ascii?Q?aiSzwPt7wwEjFcBRZqxy5Y0otD75jXa5Z/qxCa7HhLz+Qj8TySgvwdY7pIjQ?=
 =?us-ascii?Q?Z2wzbL7dKHe19erYuZnYCfducjr3K1GPjEPR/fB+/BRtPLAARi1Hlv5oQcIe?=
 =?us-ascii?Q?gzt7E98EBMbaTLcOAb4tkSBUS4gfZmWZPuz4U7qAktyKCwx2PNtDt78Mhbkn?=
 =?us-ascii?Q?cXULyXR/PNU3B9tMIZ7kuropPqR4CMli8XrmYd8Dp20ttLRoV5mwmCq+IaPV?=
 =?us-ascii?Q?z+4dWS70q19EWsqhbMZbUoTuxmI2ub3zlMAyT/YQLzL95UwQ9jT6VV1aV8R/?=
 =?us-ascii?Q?Tq/szTcHxo/VkaQzW0P29MrFHTWkUyohkJOLWTOT4Xux9X2/kT4HM3ik9duM?=
 =?us-ascii?Q?IkYw/0xg5G5bz0gxAQZ/4gEemHlS56hQzIo5aVa/eqStszKQBwHcuHoiL70f?=
 =?us-ascii?Q?Pj7QjVj2yy//O+dGJroYj2z3H5Ev8VewAT3y2x+6uhr+bYqkPXLk4D1ccxoK?=
 =?us-ascii?Q?ryj1T92Q2NsZ+x8niA0+m/4Esjl7D15Npo6RpFjNaTH+jhWippQWBECo/ABd?=
 =?us-ascii?Q?hL37ZTypkQ40ezLiHjlq/QLsQ6X5n+8JMvhiCizo6nt60iCGblsQIa4GXdC0?=
 =?us-ascii?Q?5TfVkRPSxsS8pFJlz6uMSFg4csDpnk+R8RhC4fszXzlQtPR8b4N3H7p+5opr?=
 =?us-ascii?Q?wAZAWZ70RtY3wxlSfX3QaYMbQn3hv6RRkgDml5KT9wcmtVTr+VN+xS2lo9oX?=
 =?us-ascii?Q?G3OZTeaRuPVjGlGE6fNzEQoETnekBGLoG9tiW5u4vQsHc5I7AIrBRPhCvtxj?=
 =?us-ascii?Q?z3bX/UM7xGL9kVQqlUleL1+BgOwmsbO/EDgNc+tt25U9sQ/Tjc5X28chLsVi?=
 =?us-ascii?Q?+ogYQuOgHEXN2o8wAvSWCj0YnPZUocBmWRquL3HZ6bUhdzSIny1k78Wpnl7X?=
 =?us-ascii?Q?YfIZ0NHMgXqGyJsoIYyG0Dkr5eSmeEjMsrZU14JlvwGNuZ7Xnl5FDxfCIqb0?=
 =?us-ascii?Q?BBxZmyee9EACX4nGdRHmkSmSJmi5HS6jYpJzWn1/o288G5xZdx3NZU+cJ9Z5?=
 =?us-ascii?Q?k5saHnIFJdqbcXEy3f/6dkUeblIJOkPGWjsiB6AkhjNwjYTPWJFVTxXbMacj?=
 =?us-ascii?Q?NXtyya40YeGEc4u3cvK/AxZ5yQso9pg5rBmb/a4TwXB1CvwimJOqa4YmSrZb?=
 =?us-ascii?Q?J0h3VkiQ8Z+bbuOABgiYw47AXoFDZpqBujrZhfPhK7poyLcceWw3MoaF+LJh?=
 =?us-ascii?Q?nGz8E6bUgLVHwPEbmZ0eTXkK41ABjbd4e9xDd7MJ5qrlbwnVzLf5jwRcCY8o?=
 =?us-ascii?Q?6eqDMZd1EkWZA1WkQJW6xfWKae3Lkt/1NtRcCsv44chnOsxnYtMdJi4iAenu?=
 =?us-ascii?Q?JjDM5KR1oh8WSEnwPuXJO+oE1UCfDFciIRlNk1h1KhJhOHOKSo9xu0fhgqh1?=
 =?us-ascii?Q?hAhYg0uJxTc0cXcwHdXWS/q1Lpu3cgQ1pEEnAGEoUVqW2CZZ8tEsD9VpB7Uu?=
 =?us-ascii?Q?+wJyN4dupVKue8nSdyYB2xo+aL0dQLjDGxMRlIAEI9s0xe8a1Q4dp5dxzyaR?=
 =?us-ascii?Q?ir8wRPz1lQ4hUolqpWtO4w1cKh5FHEP0BBASZQxy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4312d93-4096-4cde-eea8-08dd9eb9e81b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 14:05:45.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLMfGUJgHGXkBKo+CcBFZXGXVE3N++ILsgRa+xK2lt22js7TmG8GYYyunqLT9Kmx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471

On Thu, May 29, 2025 at 09:49:51PM +0800, Xu Yilun wrote:

> > > @@ -68,10 +121,32 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > >  	 */
> > >  	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
> > >  
> > > +	/* get the kvm details if specified. */
> > > +	if (cmd->kvm_vm_fd) {
> > 
> > Pedantically a 0 fd is still valid, you should add a flag to indicate
> > if the KVM is being supplied.
> 
> Did I miss something? Shameer's patch passed in struct kvm* through
> iommufd_device_bind() then to viommu, and has your Reviewed-by. I'm a
> little confused...
> 
> https://lore.kernel.org/all/20250319232848.GD126678@ziepe.ca/

He was doing something different, and IIRC posted it before viommu was merged

Jason

