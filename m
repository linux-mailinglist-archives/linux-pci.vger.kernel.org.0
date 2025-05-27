Return-Path: <linux-pci+bounces-28455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878F0AC4F4A
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 15:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBBE3A3A5D
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C282701D6;
	Tue, 27 May 2025 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RPaCWWOp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927F02701A4
	for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351178; cv=fail; b=B5vJ13VMihSNWOdLfa8HN0WAZ3c8d1Wh+PUSES9EqXX5Ad66puXJnP4k0uMALROTav7bW4rNQCfzU7perOUBvqkU5nxtm7Ah+8YUQfVdsvBTO029F/jXn2UacYqT6/SZD+5kTMXbacj8cGWv06o83fN80uSxsyStjZ6rbCnNXOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351178; c=relaxed/simple;
	bh=Nk4kvyeHDKW/+iJgdF7pXPWZsWN8DtOrkD6e2fW74Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GPMxpkUAY0CdvCbuEBXbw7wlXG1ackzv+RIPGUGOrkjLWmiUPl8c6XoHSCHrXX8Rok7mCTf955ZTkHIHQpn1yQyhP7ZqkOu4+G953EilP0yU17Y/7FaqdC4j7fQ+UNZrt/VYKmMyF6yhN7CaeOq1J2LQXM9vpGxiTWd03rqQKBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RPaCWWOp; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TO++P09GdeCOWQ+A9XLROmS/5VnLCAMIQjKVIM/kLAUB7M9JH1fm5V3fJMw8climwnZ/3lkosoceFlSyFludZiupIl9xGV8Oom2WxdN5TBqHXITwVsoWcLdE1y3aSdWBIv1yy99eenJTFzNQIhLLXy+eWDMx4veWoyFOWQTj5H/HtyS40hPUgK3TxeGo0idQtz51s3tFErEbToq14pi9mY328x1u1lsRF1zuwUE7p+o6HBg6IjjGElFb2ow/VHtPLnaMZgg6D+F3KSWtRyN5+X34+x4pyA0zFRPcT9r7b4I636dbJU1HOq3oDMm05p4uPpM8vWgXxt4Ay4gTJnXlfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=havx/Ac5wMKv3UFh0k0/W592XReFIh5KzOkwvJHWutc=;
 b=MGbpCCrlDkr092S6Ptdh63SrXu5yNFX1mZgclflOU3TH8S36MCz7F5V+P/sn2uC8lzp5EC4+jMfKCA3+IakwP9v3XAstob2TAM+K+6GLw4QH2BK2K+uImAPc0D5VUJzOpCDnV77yK9eux5oW7q3P8IXlgl6ThYizHZwAhOv6n/d1FOCf3ajLSNGaIG2Ri9NMalkNPOX5Fe+rPwY7A/257KNfVuLLVSaUnRrbIbtlCMwWHOihgwBVaOJIFqaYGgadNC8G1wrdcR0puZziAF6P7m7ZHrSc/rUIyZQ9ISwkmklmuPXSh0IOlgloIfpgV5XwE5uQ3TN3gCTOchtTGCAgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=havx/Ac5wMKv3UFh0k0/W592XReFIh5KzOkwvJHWutc=;
 b=RPaCWWOpqwoguvfKrm+L1hxA/lms8YVvcSrFjuSEUgkiD4QyZT8sIhi3Aa7C/695xmWdMD/zcqx+ENBXDEK8MxlbtrxO+xu5aJR3Tbbvj7IIIXVw6sFLyTMWd33yV0ETl4M2jeFNuny/+QEdPjZM5hesDjnjAoLzfzyQ73DPnnK80JlhyCjlXwQxkgIRAL4QehhrfEg0iEtAXWdamhWmFbSDGMnPRDuBawm3UbkAquQlI4USi2kMVD34bnmWH+5HLZqw93nDi8gnmI0kUEcnVURHjDK2KLvF+1M18oQ1Te3bOlOsY9i0agh1AeB0IomzzJ8vH0Rb/ZOvXPlOGdyB4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Tue, 27 May
 2025 13:06:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 13:06:11 +0000
Date: Tue, 27 May 2025 10:06:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <20250527130610.GN61950@nvidia.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050>
 <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
 <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
 <yq5abjres2a6.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5abjres2a6.fsf@kernel.org>
X-ClientProxiedBy: BN7PR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:408:34::43) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f241b3-a543-4de7-2c30-08dd9d1f409d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xljRfecWf16CQL8n3UGpUF3/wgdJ/EGTrCGdZNHCvusDH1Satg9wbeEAbuLX?=
 =?us-ascii?Q?8FAcpQOQqLj4a7SoAHiz11gg8t5/4OJsSNvbDfd1B3Ij/foe72SH4wMIktWb?=
 =?us-ascii?Q?+Q8Zn+pHTS93Z5R/xs3Pf8IAn+dMIoMWG9nieGjN9FoF820rMa3jmTisQsZ6?=
 =?us-ascii?Q?s2SrQGQ2xkqioTUgZ+j4gLwIDl9pRjZ40p5NzTK6ftRoVLYkFFv3jAYl59T/?=
 =?us-ascii?Q?X8vwtWqA9fows8YyQwlf4T3kjZDLSb7yQe6P+oavq0wHAGSXxvBKBMGCODkN?=
 =?us-ascii?Q?R0a557UdaQxDjG7/wBfVpzHBcMYECZ6Pzp6HoPE9HahGJQk9GmxQAogRu2GF?=
 =?us-ascii?Q?B9EMz5pszd3lsRSI1eVGRrxtyiJe7EWp6+STMsYTwqdp5iwlt6hz9BHcdcT1?=
 =?us-ascii?Q?Q6AxWaGDO7i7hwfPoy19sLEAE0TyEKLxNw8K6V7yp8wjwSp0XoVN9JNzzOwf?=
 =?us-ascii?Q?2tP8zZi/+mgeeANFhQUTvc1ipPTCaJcn9Ta06PHBtXJ0UOIO6XFXrprk8xll?=
 =?us-ascii?Q?2V/4hk2J5GoXy55kNjPdjAsbtQAUY68L9rDxWZdeTi/G5xL4hpSCx80cgiMx?=
 =?us-ascii?Q?JRRmxqxnh8i9gPqPnVBlI2xoAB5Y9iDpUG/vGX+UxSpqOPnNHanEMtLVRpJm?=
 =?us-ascii?Q?mLmHEFvrBp5Und0VkleXQji1kQXPeOpmsSjKOQ6e0CG2MVwoQdP4ZUsDNp1r?=
 =?us-ascii?Q?XpMkRQsCv6zL31x+9N8bcFrO73rnVeGa9gIeqIUS/pJpwXhV7c7jzW1KsiHK?=
 =?us-ascii?Q?ZDpJkeGEtEG8svSjdWV/BbCKLL7YjTweWJI8s9Y+o7d5JSo7z916DI8TMcOv?=
 =?us-ascii?Q?eYB+0tntlGfbCyayRYccCgtepVormYxQzF4xYzZG+MEcKSO9eIe0Y0RC9w/i?=
 =?us-ascii?Q?xtFtBDJ1+pptTOEJ+sHUrji/Yfu120RQ8Iwaba4/XPyHVUpHvuN/B00r4lXE?=
 =?us-ascii?Q?RxuRDDWe69BEJegNK+Pzm2ngfIrU7y9284mws0wbVv32Ri7CWZVScBAdMhdl?=
 =?us-ascii?Q?5JZj29XrK4zhJdKmoC409aX3B/Xy+jHMqNb3clstvhFRSAtp5X700bzGRWE/?=
 =?us-ascii?Q?BkTrIJqXq8N9r7sLFRla+e3JEvbBRHOGwnbfdJUtaJNIBD9Z3vnKSEMjVG0U?=
 =?us-ascii?Q?zStCs4AK9WKNN6eFx0gETTDCoUmlvNKQbaeAdI1gCmhMR/rzSXJV09XQE9dZ?=
 =?us-ascii?Q?MmIXCLy9zBgcts8OuXJtqBbPF4vt8+r/szWZ3U9QNR546P2QRJtMJAC93LKA?=
 =?us-ascii?Q?v/Z0JHYRm4ajqCQxjUq23MmyD4y3Ttdd9QZjpeJzEKGnv1kOoRSTx3eEAenk?=
 =?us-ascii?Q?aMmZHbL1XUNqMUSvBuz0E5KRHdWGrBnSxevICYM5ox4bjopTfgZENbeeme3N?=
 =?us-ascii?Q?Op30pjz3bM4Xl+8IsOGQp75rOuQNh77G0uOdnM7mCLvIjxjL5ote6lkMh+GZ?=
 =?us-ascii?Q?GgVgJkZjloE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GtwJ3cDQTxI77T/YkrTmJ4ThwaE17Cj9g8bgcg9kz9HGQmj2JLfLRGyzoaQC?=
 =?us-ascii?Q?SE4V5FTkDyvuPo0ydlzjJ4JEuqCoySfGZ8O3h7GIxPk4gigr1zuTSMJafua9?=
 =?us-ascii?Q?VcjVm1kZQ4W8tn4jZY6dTjGWx0gcxjAqEw6Yllqbq1EZyZet9s3Mw/pOJGh2?=
 =?us-ascii?Q?4h2YIXLszeEr5b74RqS/fCGEs3E5OvOo1ULyXELET90O5ahw67p+yQhARaO8?=
 =?us-ascii?Q?emuP7XSXrSmimZQa8chUzeXle0w4EZnKi90dEZoxRwF8v3y1Uq3EvpYZJtWY?=
 =?us-ascii?Q?kshZ6KAYX2d6oCsofBoYGk5gJpKPhuukauWKXyrKI+zoCUPlBfkgX7H2dPOq?=
 =?us-ascii?Q?nclv6RNZRJIyiLtlP55VbxFd97GCtAMnCTTsU3+RUwnw3HQnIb0i1BR2qzq3?=
 =?us-ascii?Q?eRIPXk6W45MRDV32AkclqLOqJIHW5zAUyf2YmPvDUcdVIi2M50g29gjIEuVD?=
 =?us-ascii?Q?YWW/Kiy/raIw5Ml8GbMmc1jW7lKpQQ/jbkAY4mirPYJfiP9j23q4HSqai6cZ?=
 =?us-ascii?Q?0xS2s8MNoydZJQWDcLt5drwIdwkHboy/ZxL9OZxDdfZ5yuzTRmEp0KF/BcU8?=
 =?us-ascii?Q?c8vkzDCx2R6nlycOnz3f6RLGasHEbSphy7C9vbSWnSAlpasFlurmeo0zDgRu?=
 =?us-ascii?Q?ZPeYE2amalMmGelFuzTHdIdpoKxuot069hGzMbN6nrYXqHvL1LullLLrK2uG?=
 =?us-ascii?Q?pXv84gZwKihahqNZjNyJhnl5jOe8SwCK4KXNeLpeNwfbUm64fUuJ0iwCfJqB?=
 =?us-ascii?Q?i8GA+nMk4Iab0B/ZjUyEk4msuYl04OSKEW/yxk7DhjdWlw0gPQccriJvWIEG?=
 =?us-ascii?Q?lSYpRlYFFKRLc7qqiMgRws3rshsJAsL/RHCHI+IaAWr+rD26T9JxNdKnRctR?=
 =?us-ascii?Q?WUeNAKArHkuaqOm6kXwxKiJGMFO/XfXc1OuHJCzVGCM3NKNBRnM/8Kl8Q9uu?=
 =?us-ascii?Q?o9nKR6vqBVSLA3xMBmj6gwI7b9RofvyQuatFqRKNo6IgZRHpTivE4zq8FETr?=
 =?us-ascii?Q?UArB15gp39HILLoXswkZoKJsM04MIkFxnZ0aIOtfq3kzntwwFrS5/9wxoesm?=
 =?us-ascii?Q?wXzbnHTaKQTCkxlWQE0btzM5sexkIfZ8rN9IqZkPZ051Baq8ZIa7fRf77umz?=
 =?us-ascii?Q?nW6tlwBr9UgVnVF/gGNQZ3A2/Ni6ucmYco9B8ovo0Q1wDsSF1msT4NYuyBK5?=
 =?us-ascii?Q?QI5HvdV1kwUJc5CpKVcu1jRSJ5Sa7QM9jnZd4RTv924pR/TqYD74o2LM/2EX?=
 =?us-ascii?Q?UEc/c5INmgC1cLm6IhnEQ50vNNrZ9JPRKPUfxDx8Hc14YsFVhtwsiVLGkEGc?=
 =?us-ascii?Q?aqrl+8Gu/4L6ul6ojwnezSHLhuciuSMKhrwNn2H0JMqBHxF9goZyULeiCYBB?=
 =?us-ascii?Q?VctCxc6ptPU6n+8Ebsxdd1BN0p3QCyzOzWtbFKQtdDKaR30uWi7UyUDgz+Ji?=
 =?us-ascii?Q?C4wbgV3KsoAlbIC6Exog9Hx50SlLweKXH09+cSU+K/BCy+t43b2QIuBAL7ea?=
 =?us-ascii?Q?05han0tloxWrEYcZfy9L241FQfksxnxxbGE0pV89fnoadAvb45HhVTJvtZOM?=
 =?us-ascii?Q?XpN7/k8HQLSBvZz7wR5Z59aqb3HbRvTLaZgFJ14l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f241b3-a543-4de7-2c30-08dd9d1f409d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:06:11.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EjnwYyRWia3Ea/godNRD7K41sH3NOncOfIQhj1kBI+TpabTol9GdKMPYLwxeIsp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870

On Tue, May 27, 2025 at 05:18:01PM +0530, Aneesh Kumar K.V wrote:
> > yeah, I guess, there is a couple of places like this
> >
> > git grep pci_dev drivers/iommu/iommufd/
> >
> > drivers/iommu/iommufd/device.c:                 struct pci_dev *pdev = to_pci_dev(idev->dev);
> > drivers/iommu/iommufd/eventq.c:         struct pci_dev *pdev = to_pci_dev(dev);
> >
> > Although I do not see any compelling reason to have pci_dev in the TSM API, struct device should just work and not spill any PCI details to IOMMUFD but whatever... Thanks,
> 
> Getting the kvm reference is tricky here.

The KVM will come from the viommu object, passed in by userspace that
is the plan at least.. If you are not presenting a viommu to the guest
then I imagine we would still have some kind of NOP viommu object..

We need an association between the viommu and vdevice to tell the TSM
world what it is when we tell the TSM to create the vPCI function..

There is a missing ioctl in this sequence, you have to register the
vdev with the viommu to create a vPCI function, and that may trigger a
TSM call too.

The registration should link the vdev to the viommu and then you can
get the viommu's kvm for a later bind.

> +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_vdevice_id *cmd = ucmd->cmd;
> +	struct iommufd_vdevice *vdev;
> +	int rc = 0;
> +
> +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> +					       IOMMUFD_OBJ_VDEVICE),
> +			    struct iommufd_vdevice, obj);
> +	if (IS_ERR(vdev))
> +		return PTR_ERR(vdev);
> +
> +	rc = tsm_bind(vdev->dev, vdev->kvm, vdev->id);
> +	if (rc) {
> +		rc = -ENODEV;
> +		goto out_put_vdev;
> +	}
> +
> +	/* locking? */
> +	vdev->tsm_bound = true;
> +	refcount_inc(&vdev->obj.users);

This refcount isn't going to work, it will make an error close()
crash..

You need to auto-unbind on destruction I think.

Jason

