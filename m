Return-Path: <linux-pci+bounces-10337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB36931DC3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 01:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8221C21DFB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E81E14375C;
	Mon, 15 Jul 2024 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j3djY4q0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00CD13D24C;
	Mon, 15 Jul 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721086987; cv=fail; b=TOz91RLllUsqqBbOeTKRPWk+O8FhAcZ9hikXFvd2RjRvPsfYye8w3k+mhkKIlyhJi+6xOMRjf8vxSG1+QATVrx/MdWlRi9UagwgISDoBF06gIFY6Ahh95MDHIiAteruvtXC/uGYAlhOQ/1Q4nzNp5OdkvAHbfbh+DE4x0LGVdeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721086987; c=relaxed/simple;
	bh=Ihi610De2L2xVU42GydtzLvzXFrdsITkVOdcvQ5w2lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=caOCUea3Kb7h7f2oFb/IVseXnySpMyzH90sNeOR/YE4iOmgbvVBbgDRHOD7CnVLS4taoMHnzVx37Vy3VFB31KPxj4FYDOY2ITOYxGk4pnwWtUvnoj5sDwVD6/beU16G77lMqVw4iaqFhdAGHBmA3izTYmKtLQ0I8QBEFKXLK5hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j3djY4q0; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5i4gvYTopNFRz4nefVqNuCOYBTSgv4SBa05cBqIE8AF2RoBxk6OSgMuMqWYjPEJT0xK9Rux46ghtJTbxqcZPDedLPeNljIeQC4Ql6jG/qomV7DshPqhujmrury8QFqn4BQxXi063W247LEwT87MWfLR0ZVTMTZad62fvZ8K2lB3bOEgqtH45/zWWoMaQY75rY2v9zmTc9jKmhZmpmDBUMMs+p7wcCjZUufHCI3KIPEuJJZ9u0CZBXSATvggzzvNlqyr/Uxwcv0JPah2Od/ji3HRNU7M12/s9vEVseAYtzyzNI0DlFOfzWgmYkqF6QiwzQ0sO3GaocBjRUp+S+U9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DysU4+HtAHinVq6jtfcfxRhJzFb3P+2ZIfKpUbWi4MI=;
 b=p/Tgy6vSwqQ5x8FTdmC7ixkeMZ0Oj6G2/KHY5D1shgtLRGPKi7/m+fPARPnnknBA3H0sR795MB2591KR9pJ/2c1zJeCCeWdM629dqQj2LANlGD81wl0FX/DhtH2fTiDAAb1spvTKOGEs6X/PfZAEr77YbzK3LpUotTm3ja3COUltSwY/IsKlOqYw/CUd/DjWzE1xu/Ldh402s114YdILOcRAgEOVGiQwAJObt9awrDQM5YStqvQJRuDAB5hMuoTse3msbz1+9lYSUPde5W7amoOYE11El5AiY5yUC7Y8ESl2EXUdf2xC7S1lgiY+R5b9JTOV0oy0k/RlGgek1reX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DysU4+HtAHinVq6jtfcfxRhJzFb3P+2ZIfKpUbWi4MI=;
 b=j3djY4q0wQ5tPINXJYc4OVgLGZ27pUyG/LGF6dQ/zTcasMGtocBj5jz9BkSKmO/heXlrojUdEvj5zF2HySG8/c0tZ7x3c9b66pdBzmuTAH2tQAgALbvZgZf6pR8k1UEgHbaWbI54pwOyxOf/Cxb+i+AnIs4UBv84M0mHzuUadkj/E93x0MLGnnouzufNwN1bomaqBkD87vNWTnnQkJf2CVbobWKLkBo0bX1bqmoeqqmkCiQlvssQ+ywqfj5K+vPLVqgyzR96mcZUkpe1dY87GkofjTTIrXYpcDx1rzxMdA3VpZXJuSbfdV2ElUtS+ZJiJpcM5z9d8tcEYO9GlF8ZnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Mon, 15 Jul
 2024 23:43:01 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 23:43:01 +0000
Date: Mon, 15 Jul 2024 20:42:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <kees@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linuxarm@huawei.com,
	David Box <david.e.box@intel.com>, "Li, Ming" <ming4.li@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <20240715234259.GZ1482543@nvidia.com>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de>
 <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
 <57791455-5c70-4ede-97d9-d5784eef7abe@kernel.org>
 <20240715230333.GX1482543@nvidia.com>
 <f228526a-984f-4754-8ade-3f998a8b436a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f228526a-984f-4754-8ade-3f998a8b436a@kernel.org>
X-ClientProxiedBy: MN2PR01CA0008.prod.exchangelabs.com (2603:10b6:208:10c::21)
 To DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b692c8-4881-491d-4239-08dca527dd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ySD11YURNlgS1KFB8SbQq9LI+mNy7ET8FBjzjgE4OCqe9VL+acRBvfnlin6?=
 =?us-ascii?Q?kECkMdy/ZBbzlP5CB7MhCck3fdAFtqq4Yy9Fg0HRlltSSNJX5Lgv4RvKIAWH?=
 =?us-ascii?Q?O2hkwsms8isfvGlDgCd9K1Rg5qpUMNdeJJ7sKmXanXHejaHIpuAqLszCYnyJ?=
 =?us-ascii?Q?XV1CcFinYtmVt0iYHCEDlbGWHM/29TGI1j8ommSuqDYLC6K+zhew7H7jc8Wp?=
 =?us-ascii?Q?imP36CJXfX/6qYzakePZE4a4JzeAfdtHFz5nJK+m9AA+h/dl6sLnOtcTWV/7?=
 =?us-ascii?Q?V/dCHQvjMd11xOjZkk5qsV60Rb7Iszlkdv6gERKGs2TVHkvIldwNwsP5J0Qk?=
 =?us-ascii?Q?erokO6gxPXaQZsSZvz8APF9G9Gms7Xi8l+sVgNQSwhiBSpMDys68Ydu4XFam?=
 =?us-ascii?Q?0m/mVklwac67yB6S6Hchzx7KI7Pbf9hx61RPQ4NfzgQ7SWlloHyYTNEYmFlA?=
 =?us-ascii?Q?mmKVU+L5s/nXmj6iuAe8oVTrtc0RmMYf9XRoGDHLZGCA7pPNwWDZmYMKZxg9?=
 =?us-ascii?Q?WLxdZrJpgBqBriZFEtkKYUQtOTnvkjGxtOuyG9HAUsIZVoLKaDhiVunxYGLA?=
 =?us-ascii?Q?1WI8LTkMv/aIWM5tt4kePXra/oTItOeKFfEFKpYmP8BecwSTQQvE1MgY9U7K?=
 =?us-ascii?Q?w5Ww5scK/VaQEq+ELpG4sE83Hm32HxV35LGFabwQfl2l5uTPQvXlFnZ1N5qK?=
 =?us-ascii?Q?gGbmz79cnz7vsW8eUHS7LwXZUvFvpSxgX7+nMClGGUAeVacFjyJP2QGBGSMf?=
 =?us-ascii?Q?WxtD/gIu4MItHOwJE2R/qrkwNwVlYOLjxbDYUtIen8aM9h/ztbpNCowlHMh+?=
 =?us-ascii?Q?Fz+weQZ2b3YrqwOPBwjIT142Ov1Xs4WB6mHRGYvYQxs/xVYPCje5P0u8RMdk?=
 =?us-ascii?Q?ixf3xobqcS6eUoJR1Dx45yjbx8SYbjJ8uBJhIEnVhtt8EMKHWjdsJCx2fxul?=
 =?us-ascii?Q?hNJ0ZT8cjkVy7YN+rjJeucqZ7MNJsBl7VYx2jlbb5g/DUpblotQtc5dSB8Ak?=
 =?us-ascii?Q?Wo47tfSobf+ZhLu+ZCvr+fnXHD9pkWWjnDd18jFV6OgAvFtag5RzCXu3zAsa?=
 =?us-ascii?Q?I9ae5DnyTMJd8drKLGJM/MMXD4x97CFZJuNqZMmCI+jdVr4cSSq8swzwhDR1?=
 =?us-ascii?Q?gDdu4aosdOs2XUmT4q4QDRD5kcLnQhJXdjKOfrO2Me2PHXeakust0N9I3/bw?=
 =?us-ascii?Q?cmyVbnDc8e7UtYA8VqmzRDnC64zMpbuBQ0k+F9nVrErvoM281uMjrYSsXcGu?=
 =?us-ascii?Q?gIAweNXbaiXmiJFnSlXwAbJrqyOAyjVmAcOrJnT76Swh/SVKCf4VH9oa3JsZ?=
 =?us-ascii?Q?ACEermouX0xHrAWqyBepIZdtcrw512VKyLiExVVl3/g98A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?adywjBqtyScOOZIxOzZoO6+lKSG5wsueso5S7uF7ydkR3UPPRXJzpkFX89zh?=
 =?us-ascii?Q?MUjRxOX3Qky7Amy1zOjGCxADP+vngYadI5+cAmEIDOjz4qTBQeQaEbVVOZV0?=
 =?us-ascii?Q?8YvMGZvvARv4nROqE+reUzLrDTYGy453Zf1TM4kDJ0lbxOoEcH5cYHf/obSm?=
 =?us-ascii?Q?yn18mkNwRNJ83PV+aevJle0i+MuLYJ6USJp/VBkzWQX8cmf43n5u5WGe9Cbn?=
 =?us-ascii?Q?tsamrJzt+6teB3w+zB1xv6o/QAt5z8ezwe+pEcaUuV6lMkJN50wvKYjCE3fK?=
 =?us-ascii?Q?2DaUcyHNVNO9RxFwnwdUWZhz9WZwMfBQTX1kPWz6p9X0BZk9ifuE3xhbC45f?=
 =?us-ascii?Q?LoKqJ6oRuPVkZUIdQOY/4kk29SkwnSURm2vjOtJxelXx2PA1Jml+Hlw2B1HQ?=
 =?us-ascii?Q?iKAiQYSRxbSlmyR6utLDmDtX8A7QKhyJ/Pw82elnuIfgNwb/iAIdW+aUMl71?=
 =?us-ascii?Q?WqZJNcMa1kB2Y9B77sKL9NNR9cP1zsG/pICLi6c7rsNLMKTWO9MAyKLuqaSH?=
 =?us-ascii?Q?pn+grRq0XJ0PUJWhmNtS/WNjcgRGzWaKBAe9EllGLnFR8VT4djTxXyHocWoz?=
 =?us-ascii?Q?N9u71TegDwzjF9ihlC0kYCNuw6fEkpZMIQtBcNxuITjLgLMAMQopSw0O348n?=
 =?us-ascii?Q?VdzHvAShEnQCIMdvzts/fvRLddhTyfy67plwRR0qFlz+PDnlzJEFdmr4rw+W?=
 =?us-ascii?Q?ibFe1Z53LXwwhqZT8Fiq4+ENqDooT86BB7ggceWRFUe4SmiL1mXWNUGk+c32?=
 =?us-ascii?Q?S4JTKC/SK0gJambNBIpbmx7p1JxpSe9qdM9ZsFm8L7pHRy29ooZIPujd629J?=
 =?us-ascii?Q?W3TImOPxbaFtjzwtAF6xRDOEUMwK1DmVKM4ThWfs6swJXVWQf+ITJUQkINza?=
 =?us-ascii?Q?sAKpa1PYoVTBLL1BsOKb5Q81cPganYhmcfQGQojqbKFvQiDo7yteIGW0VJZ8?=
 =?us-ascii?Q?dPfMqR34p/1boj5L92CUkYeTGBSHyUzzivhm5zyO5m8894n2hD3otHo/uaft?=
 =?us-ascii?Q?mrlfqa/yThFW8Bcxgfvx0jDI7mtIMrQgHrz2nVsvleDHsNCqpVMvr+RcDcsf?=
 =?us-ascii?Q?GpXj8NExQCuf1wiXRF/mIrSI1svrtsprLU3ajFAh++xA5HdMcG7JPb+IdGom?=
 =?us-ascii?Q?TRhpmHwZ76EG6bupnONbgoQtTM+VNSGMxfA3thiZ6d6E2Ag3ASbixkxlhAgU?=
 =?us-ascii?Q?mLpZweixRnnPw8qIQTWoBqizXKbrrLUw2o1cFH5qtysUl9AXnKt7c8jxmiIK?=
 =?us-ascii?Q?VS0QKNZVt7R1kLGkNPXcMQoaHdhwU7+/d+B/1U9LVgWEJ4dgI2AncCXbAx72?=
 =?us-ascii?Q?AtJVluJ0sfZBPaCTdQKsqkR88XatgPpEVTj5BeuDRHcvRBj+/gkH15fgnGQz?=
 =?us-ascii?Q?7svGCrFS+9fETTMYAkfFgjrx0qOJolcfaYSmq59GDbI3dElLGlZcTYilZ+hv?=
 =?us-ascii?Q?4B6WtG94xSPAYu4H01fcfACXhMaRqxhHydAZ9cH8DadaCMcxgLwTVjCQglhK?=
 =?us-ascii?Q?Z7EoWryCKv82VdI3cWaa9sKQZNTW3pDyMacKmgQ4I/xO5go0AN+JH/0Jp0sn?=
 =?us-ascii?Q?Q8RB1hE8BfpxpjtJ/fujapAo52qzQPMBSmUtbRVp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b692c8-4881-491d-4239-08dca527dd1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 23:43:01.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBdzS4cYQELWq888IvdnMfFvQVuhcEk9ZaUz2mf3ZxXqbrTJEaV3tKvcGS0/0vfD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358

On Tue, Jul 16, 2024 at 08:26:55AM +0900, Damien Le Moal wrote:
> On 7/16/24 08:03, Jason Gunthorpe wrote:
> > On Tue, Jul 16, 2024 at 07:17:55AM +0900, Damien Le Moal wrote:
> > 
> >> Of note though is that in the case of SCSI/ATA storage, the device
> >> (the HDD or SSD) is not the one doing DMA directly to the host/guest
> >> memory. That is the adapter (the HBA). So we could ask ourselves if
> >> it makes sense to authenticate storage devices without the HBA being
> >> authenticated first.
> > 
> > For sure, you have to have all parts of the equation
> > authenticated before you can turn on access to trusted memory.
> > 
> > Is there some way these non DOE messages channel bind the attestation
> > they return to the PCI TDISP encryption keys?
> 
> For the scsi/ata case, at least initially, I think the use case will be only
> device authentication to ensure that the storage device is genuine (not
> counterfeit), has a good FW, and has not been tempered with and not the
> confidential VM case.

Oh, I see, that is something quite different then.

In that case you probably want to approve the storage device before
allowing read/write on the block device which is a quite a different
gate than the confidential VM people are talking about.

It is the equivalent we are talking about here about approving the PCI
device before allowing an OS driver to use it.

> 100% agree, but I can foresee PCI NVMe device vendors adding SPDM support
> "cheaply" using these commands since that can be implemented as a FW change
> while adding DOE would be a controller HW change... So at least initially, it
> may be safer to simply not support the NVMe SPDM-over-storage case, or at least
> not support it for trusted platform/confidential VMs and only allow it for
> storage authentication (in addition to the usual encryption, OPAL locking etc).

Yeah, probably.

Without a way to bind the NVMe SPDM support to the TDISP it doesn't
seem useful to me for CC cases.

Something like command based SPDM seems more useful to load an OPAL
media encryption secret or something like that - though you can't use
it to exclude an interposer attack so I wonder if it really matters..

> > Still, my remarks from before stand, it looks like it is going to be
> > complex to flip a device from non-trusted to trusted.
> 
> Indeed, and we may need to have different ways of doing that given the different
> transport and use cases.

To be clear there are definately different sorts of trusted/untrusted
here

For CC VMs and TDISP trusted/untrusted means the device is allowed to
DMA to secure memory.

For storage trusted/untrusted may mean the drive is allowed to get a
media encryption secret, or have it's media accessed.

I think they are very different targets

Jason

