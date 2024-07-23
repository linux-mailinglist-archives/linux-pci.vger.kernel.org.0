Return-Path: <linux-pci+bounces-10639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB1693A0B5
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 14:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6661C22148
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7571A1534E4;
	Tue, 23 Jul 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KvDF2s29"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D426AD3;
	Tue, 23 Jul 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739517; cv=fail; b=qE46HKapO4+AG7yMc16dHhXL4XmscJjkrEVnD1hdL9rsg9CvLZ5fPyvFSnnTMxTavhzCS6kUEpUQFyei69bE+tp2yuBBEEgC3Szp4/5NRjZP7AdBHQG4blk1uo/13ieMV7lP1UU9F93myIMIxB9cRkONDP91Ro0wDAG/0FSqV1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739517; c=relaxed/simple;
	bh=1RiLEFYe+T9epMXAsjZ6aol1q5MeMqyoIzSlP5Wp7pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bjPISDtr4fPuspj+i2CWdoqe1MwJrdPkfXziqN8Cbas3uyN2iQkLo2unDWHGyaF14TV1e5rvv5JiEOv29MAcGutLST7qAQjXFK7a10nG39zFCVCbGGPHLqv7h7j+Od2JoyfP13Fb93U3Zth+h03A1R6Xd2MNlVKv6ROQvptpHQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KvDF2s29; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hx9RUjalB8FDd30bIrnIlmeco/dLNESjl9JHXZYusi1nSU9aeBxomdcCOr09gU0bvL/gKDgfpye2XKkC7IvvDLF+HUFHlLxMU8VKWQchJi/ItkTWZ6YjeFKo0ke4BZ8/S5suWs4lWl4EaNi4NySWQCyHxNYKGaxwu6bvCkGQEF+oySaKNJnQpT0jKla+5nNxEf41q4hviPVYHq/3y3ZautI2JDx43mm3vLgxU4kxQIwBjbgZB8k33ZR1k/DANG2dUqHGCTUBhfJP+nzW2zAgrTTLVOyc32KU+31m/rE8CKZ5QOpryQyovKXaKv+WomKx+Or8tP1JcjO/fxkuAmzrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kV1WajA6dvpKaFYvtE7Oh0Mw4BDh3c0g4hCrwIVwDiI=;
 b=eQBzU5+FVa4BYlmiQxv39eTDt7OEZXxC7eBiAyfnGVNLgeMPBJYkUj2dDkXu6TYVpAiNbe+pDuOrwH5in3kkxTmNkRqL6DxknT6BeN0892MqhCRd0IauGv2cwe/MONoBSxQ12grQmsEppbk7RWT2lREpVGrbIo32zCuinB5EVoPEkTddw2YCOdKqkOZAnfgt+gt6/w34Qrq6wnI6cLLp6OwykfOHt2JcBYQcz8Cqmi7CXKw/SMxGRzLg0Umpkr8ahXb/Mn5VjB6L6Xz56UQEHuVh0dND3OsWRXZD4p8+IT9UFWYKVyxDcUY0SC273Rkm2sHUovy3E5sLl8QgdgjKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kV1WajA6dvpKaFYvtE7Oh0Mw4BDh3c0g4hCrwIVwDiI=;
 b=KvDF2s298c+oyDwDIsASkSwQvaChGkM552FelQPqp9oNsykTahGXsBKqtOQKA2DcGTNg5d/ZQCMIQodbzAqLhAcmplUXLsjXyM1ju6ldiIT1y/fiyGhWNNfAcFreEdvkmLDpLsGbhTEpX/FdCKEtAkEe50mUlp3VjvIgkE1GlB6ZeOl+Dw9xR2hpSHoT6m7uFWHIoYNotZwusSRaIV8k6m+qTCcRJFoaJnwlUjSvhW4gZ6uZGWNmlN9j62e9b7Cc6mOA6J4xxrri9Au2DVF3pWcYmi6JFclU+XWGvn1PutFZdrq5xg1OktBqZa4qyVU1pRm7EBHKMgteWg28fgnaGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Tue, 23 Jul 2024 12:58:30 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 12:58:29 +0000
Date: Tue, 23 Jul 2024 09:58:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
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
	Damien Le Moal <dlemoal@kernel.org>,
	Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <20240723125828.GN3371438@nvidia.com>
References: <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
 <6695a7b4a1c14_1bc83294c1@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715232149.GY1482543@nvidia.com>
 <6695b29d204e4_8f74d294f8@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715235510.GA1482543@nvidia.com>
 <b297cfe0-c54f-4205-b102-ba53ec40344b@amd.com>
 <20240722120642.GI1482543@nvidia.com>
 <de1ca8d1-b876-4b0f-9151-9303317b4d2b@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1ca8d1-b876-4b0f-9151-9303317b4d2b@amd.com>
X-ClientProxiedBy: BL0PR01CA0020.prod.exchangelabs.com (2603:10b6:208:71::33)
 To DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 5761aa31-ec74-494e-0cc4-08dcab172654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YAbS22pHfx5qXt5wQYFLx5du98zMx/fPWs+cGli79oGM6qfx1riSN9RLaHpa?=
 =?us-ascii?Q?SSMH3sgnOtanXEy+dLJO0WhG033uTZvsluLFqaWXAGxRO8bejRvZ/v8nr1iP?=
 =?us-ascii?Q?Zqm8eVO6cpF3eby55TxtFYzLj5CyKeA8p/MYTOf40Cp+ujT2Zg10I5+gWISE?=
 =?us-ascii?Q?37KYcseH+8zjk5CjdOwLgKn/FYMsne1BMtTix7QpGLtjQs7/Dlt8FMIfJ4+k?=
 =?us-ascii?Q?+UBi3ug+gE6/rWAXDBZyftF4ODXcEhJzWHPHWtb40ieUNd5Uzigx2TjUybq8?=
 =?us-ascii?Q?+4ns0xMhHGfeIYxm9lxXy35RMP1WUNz+MejLPYX/mgEgoLMp0erT2zWTDTyQ?=
 =?us-ascii?Q?J61koadQRPcHObDFB1ainw+pCphCirayI+yA4Xz6S/X7Wy5sLmZkmU/1xXQ8?=
 =?us-ascii?Q?pp7WaStRc3MqBDZHo/28AMGccEavc4fZtV0p8H50f+ZP/HNJRvYjbmR5b0Sn?=
 =?us-ascii?Q?3fl10Mf76EAyYjHV7lw9Bos0+kBGj97YWXRwxzYlVa07o8O084Rwv4kQm2cj?=
 =?us-ascii?Q?6Uke0sKyhUmj1AdMr2vogpNs5RKxS1J7FJ0lZhl0W90XhmmCH3Veo3JL0jBl?=
 =?us-ascii?Q?LDwYkWCqwDPK9MN5Kq89K0zELrp9OPeT+rtudAzXmaZ0ktClyjTSobWYKt1h?=
 =?us-ascii?Q?ZTpoJkbhdcO+q9YepZ9RbCmW2v0cGrZLBdsVeY8N5ql7HXNtC46sgmmEQLZc?=
 =?us-ascii?Q?Q3qPJw619DxTc0B18yQOtE6AQz5lN9j5EvQ0wytqYjctufy/cDmkxEWTMr4I?=
 =?us-ascii?Q?8VP6J6n2n2stiULjWRX+sPwu9GoOdBBs69NVJAVi8c1j9MPnia+nnUA9OhjT?=
 =?us-ascii?Q?Iu+nyQADwiZdcLusNEP+mduE5BtB9AwcUuSOz/l8pTK/P4KmLRXe9xSAibfp?=
 =?us-ascii?Q?i0+lYH7kFmAeclmUMF85li5aQAT3WHhgtESINITVY9qRQM8F5ggbk0cRr0ha?=
 =?us-ascii?Q?14WheIANgfIEa89Vt+BkmOeBJUPmJVAeOoBI4q8GoyEQDQoLCI7uEGsWlUha?=
 =?us-ascii?Q?Dool1ivc2Ju4ubiPQ9qSlH9XUHb79wGcryIHtit2Lms+aj0fAVFcPNySUVcd?=
 =?us-ascii?Q?gz00jKYUCVVTVAfKIqoCSBjwTFyHav4zjbB+e9K5d7ZxeEe/7slALiI7EyiL?=
 =?us-ascii?Q?DxSvI6YvLOyiHs+f1xOlbcdh0Ljsx6S11lg+zyS7eaeXq208icyqcMxtCcTt?=
 =?us-ascii?Q?qZMuwSmk5Ocj05zvqWQXJdGMD508opkLZjBCHV9roFfFRRdEdI472E9WZsqP?=
 =?us-ascii?Q?NmQr5XGYItTrsJR/M66KG9brTjBRFXZSwVCT/7dOqVJvHtxwpRanebJUKZct?=
 =?us-ascii?Q?KLcadlZc09gVhleO5f4AD6JtU2QwSR6qF+P228QgRNs40g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4OkarTHbzXndgzatRYBywyI8aF52jKJE5NKjrdEdgmY4afXFvBbQff3fS7hS?=
 =?us-ascii?Q?Mh8EkG5k1znYCNpPwR4b+Wxp4V6n+XDQPBaOGfC2rWAYCXZ4Pa67c7XvI5XF?=
 =?us-ascii?Q?iqVENSxle+f7UBmkBeYgHRMlVTXc0s78RtOk3cA56OfWRvfJMpQCAd3BTxMT?=
 =?us-ascii?Q?5WRCdJA4kJ1dDZcKVJgHtJEh5Q9G1BTI1Q3yiuB1qkIcow6V5Kll6fn2ZF/0?=
 =?us-ascii?Q?DxkF4nTwtbLjX3z3PjwdOAWKCU5r9bUY/YLIQWqIU5TBk+XSgwJHyoEjkoCi?=
 =?us-ascii?Q?vdR0owNKkmv14+SERuq9hi3W0UlxL9wsKEl/Cy/ERCyW2dGMDCN9jy7DG7R8?=
 =?us-ascii?Q?UdVCAga7p+f2cElC5kg0a087trNWqdSpkBsCriQhmdr+rMj4NVKKHlYd+L+3?=
 =?us-ascii?Q?VMaIZL9EkkjSNZ47gCD/wYGJz5gFmrlF2I3CfCL0XWQ/LEIUrRx/1KMOh06x?=
 =?us-ascii?Q?ZeK+fvbxMH2ur857JrslnlO5QXLqRLWF7+4Fhg2fJ2mRbhpu7CiYAR//OshU?=
 =?us-ascii?Q?mqDgz98oZmZf816BieFXwaNvPSy8J9K/bhBJj9MflIvBwkGlBBNGv+9+xCqZ?=
 =?us-ascii?Q?vz8CBhJITG8bNOq7laSmxL0FZmaENOsgXo7GZwv1Tbz/q/5aAM+HcfaI0X2r?=
 =?us-ascii?Q?S57x+n01dhOXxfR2THWV0mgb2zOC3OSfplYA9CA39eRvE1vKXVP95vKODWWH?=
 =?us-ascii?Q?UxKp0ZZWU38QofK4R3XwKdKooSI5ZF4aU308ZiMH6xxtbp4pHoWmIYrJu4fD?=
 =?us-ascii?Q?Xc4Nn3Z0Oh7VgaWHiDgekYAo90QZnWFcZMyOF7eQ1PuakW6siGtAYHff67S2?=
 =?us-ascii?Q?mZygPmpE6uLFKY4+Tv7XcwRDXNTMK4KOFbCrNOqTxsFWJdsj+5dU2c4cTj7+?=
 =?us-ascii?Q?OBE4OYrHat5tkMCRYsU860GB+fQqTlZ6vgPB5oPRQ0M3KlB2Tf0sJLnuc1kF?=
 =?us-ascii?Q?0KJc10uf+cb8CNRlSAYpoOCCCOwHxyLTuEaR0e/FGvWUYYocJPkt7BSqg6kC?=
 =?us-ascii?Q?J0O/oKjSlnWoF9lsupPkTVOYbfXBPQ5WsgU/SdmPNFcV4/GoxddEoGwMVxb2?=
 =?us-ascii?Q?jTPU1vStRShKbCMlv7Flg240ZqfpBwDtFl9RNMuCmIQ+FL9b9brHywYW6ihr?=
 =?us-ascii?Q?0H1KOmVoNlk+h3Sz1gsUDjMiRobUE12uYFL2fugLM0D6loFfcnRXkIbIf88j?=
 =?us-ascii?Q?+yxpHiRmMnVXaDADlJC7CR9d3luC7vuZcLxV6Vm6c8njOmrT0er/ZKbY+ZCH?=
 =?us-ascii?Q?xRUVF9l6IwN04QdOMBNM3DMGxF97Weir7RDEeSBhqdWq+0T7pWpxr4sQJYhP?=
 =?us-ascii?Q?C03dZGWYXtbAAbjBlO+A4xUAZMqKk00srOEKhDhr8FfUd5Y1Z3yNs0snLD7K?=
 =?us-ascii?Q?p20qoZwG1RzUc3+sZ2FbuA8Ua6CyRupcqSe5l5xZUOZfhrLcKvxetTBb6vW+?=
 =?us-ascii?Q?pSMBngeIRBtTuMenfPsZeleYfGnkPhK4w70FhlgA11ZoARqwirPNUITAQ0Sv?=
 =?us-ascii?Q?slvGWlKuGp6IzQ2Fej9Yi8IIPA2WVpG2jgZk05adk5F2vdMacd4EMN7HQYTR?=
 =?us-ascii?Q?7RXNJ08CkTGtOtzdrSBMS0qZX4A1pluo3vvsOJQN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5761aa31-ec74-494e-0cc4-08dcab172654
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 12:58:29.8728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUefpdFbuS4ni5PtGpmWunBhjr4hKkXkNcqmH+xcP+og82viAdejA/d2m1EqP9GK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061

On Tue, Jul 23, 2024 at 02:26:23PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 22/7/24 22:06, Jason Gunthorpe wrote:
> > On Mon, Jul 22, 2024 at 08:19:23PM +1000, Alexey Kardashevskiy wrote:
> >
> > > If there is vIOMMU, then the driver in the VM can decide whether it wants
> > > private or shared memory for DMA, pass that new flag to dma_map() and 1)
> > > have DMA memory allocated from the private pool (== no page state changes)
> > > and 2) have C-bit set in the vIOMMU page table (which is in the VM memory).
> > 
> > Not all HW supports a flow like that.
> 
> Fair point but still, under what imaginary circumstance a driver could
> decide to flip T=0/1 when up and running?

It seems some people are thinking they need to do T=0 stuff before
doing device attestation.

But that wasn't my point, the issue is that the translation is
different depending on T=0/1. On those implementations T=0 means "all
shared memory with no vIOMMU" and T=1 means "all memory with a
vIOMMU".

This is quite different from "the VM can decide whether it wants
private or shared memory", because it kind of can't. The entire device
is either T=0/1 and that is that.

Jason

