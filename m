Return-Path: <linux-pci+bounces-35739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD830B4FA81
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 14:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF4E3A365C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 12:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA77932255F;
	Tue,  9 Sep 2025 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bo7JAqor"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F2178372
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420334; cv=fail; b=tyaY/fakJIzzHK+fRe3cdNJ7w9IzVqecV0zaKhycM639EbLoXAyvCFi5BDCIatArsQt0PIazayGSRf/RyZ6dWzyKsH53ymNQbeCOZFzr7mCpV9DPOoJnINDLVcbfuON5pxl/4Gas65wrTA3/sRt3nYJxuyaVbQ1G+p58pjYToAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420334; c=relaxed/simple;
	bh=K0mqeOV+nkHU5LQyoBCkZr1uI7t4rIWKRQO6PP2RiqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZSmDIeMxzaV2pXw6nfNpwh4Dfw/EGEOX34JI1zOY6hzeFuoNSB3m0MSrboWy+dArGA893CLmn9dmFGHLCohNj2fyNMAqrMw31RogFJ19XEFR5nELr2wnpM5IQPhSSmXhjJ8/7aGQKqTs8hXPQrRb86LdxR3Qr+Rglc6lAXItBJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bo7JAqor; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEFJobra+Fr8XICPrfxsx4jlLJmW4rRnSJyp+ewP/1dUAF0mUGzjbCYznqe0pkIg9HdLK4n/5IjfA5TuO7EpWcavlM3KIzAgo36NA1BjBrvsQOFn8HDJOa3OBpL6hpppwA4uAOLSWwteFH9S24YSvdSK/Z8zyM+hdMQ8yiImcVGPfJbB23vcsT5a5tKER7nrkOAeiPOShzD3LvA6uRCzLjNNeN9w9O0+1qBnQr4m/Rpl+tj2hDPA+be1YMjm1cYjfLgzLwWOEhDlygGIDUJAd4YvNNvpKmKij0RNyeY5Ddx1tWPY3Z250ta6EKHI3LYLUMwtviMLoINTmKedMCD0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVCOGvZ5b5uUBSnjwe3m9l+f/P+cLPmZ+s25le3XI5k=;
 b=Urh92mvU/iY7yH+e/7nJN4eX9DHXitWtg/9xwQzJZAQg/oAgmYm5/j2Umheauh1vvuJjO3OYDT8Nn/qHk5rMpV8GqCkgiQ3JznLq3Moo+Ay6Kh/wuSxZEw5WfkTBq749oGPXgyCwxAe5+99iig9CeySheRyDO4D0MZqtZ6jRDd8bvjUEL3s/BUw6DDJkUGq+zvZgqJkh6SIXzLE8I+vfQabjzxGonyuf39Nx504/GSXFlpA06DIRMO5qk7013G4hj7iH89WQVtW6a02GkyZ7JmEYiA6lDdd+NMZ/JN+i5jKDpk6IQVH8El2a4n/5+UM0spLOaB3I5uaCPfTlbPMaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVCOGvZ5b5uUBSnjwe3m9l+f/P+cLPmZ+s25le3XI5k=;
 b=bo7JAqorrV2kZl3IQdFBZNX+2nNX9hPveb/HuuFhZ16Muzi053mb0lcQ3ihxC1GjS5EcwsqZwl+5VyPXt4y9CVOrlhPg3UEMMroI5sGew8ICtGeVM1fWA+9iVsoxHU86f2MQVjddsUbNbZZWAu1LghcV401AApAQAt6tI8SvHPDGyWMq8mOMaalLDnRgRK6j5BKd5kWFn1XhRBsVeYbKowOiC3FN3xiZZ2S0UyaolOIHwLxNHEJS8SWgfHel0ublwJjxv0xciURbK7OMdxDMSkV2FO/24X5Ud4NPy3nlb6d2m70D0Gznn3PYg1o9AS28R06/ozCHUeTLgGw2cJQLjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 12:18:47 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 12:18:47 +0000
Date: Tue, 9 Sep 2025 09:18:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Donald Dutile <ddutile@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
	Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
	tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
Subject: Re: [PATCH v3 03/11] iommu: Compute iommu_groups properly for PCIe
 switches
Message-ID: <20250909121845.GI789684@nvidia.com>
References: <3-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
 <3634c854-f63f-4dc0-aa53-0b18c5a7ea1c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3634c854-f63f-4dc0-aa53-0b18c5a7ea1c@redhat.com>
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DM4PR12MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 12cfdc40-677e-4c83-7ff1-08ddef9b06bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pwr5zWjIgbKUF6jHWlE/eZF7tgoemuH0GFOwXWA4vnoh6VjZfYg43H4LvVNZ?=
 =?us-ascii?Q?Yyagu0VZccrTb0ZIHXcWdqYeJcZ1bgeBwwD7IwCy8GFtvfIqsA1iBTpRUkoJ?=
 =?us-ascii?Q?O9PuftlwRccUCRWi1NaYjovBJca897RfCcps//Il2fu+/xT1o6gtZtcUN8Az?=
 =?us-ascii?Q?i6Vu6btMk5U+6nz1s3kYjcm/bgJVpuePB4SyCnIO2O6qByoq9pvW0Ec2010/?=
 =?us-ascii?Q?2fIu8bNDjFH5hu9raf2panmArB5Mln7TLbHtTq6+IoROsLJqm3yx+XYliluI?=
 =?us-ascii?Q?1YfdRvcvRAFQxXDKFdis+3FIpV+nCkv1DtYX0SG9MV7yyB8+ENOI9Nsvcdpv?=
 =?us-ascii?Q?abTlAC0SNb0Sj1sTabl6J2OTrtagX4cepUMqNzYyv7LWJxaNweHw7eBSOceb?=
 =?us-ascii?Q?9B7RluTmRQ4VyTJZ4fHdbiXhWuxrC/Vt1QWUgAQ20PwvKUTuQKirk1uhLEOx?=
 =?us-ascii?Q?GMUvWJFR2gNu6Uv4YsNZGEC9JbhJZdDi3gbudfagrk10loaBRKr553mnvT7D?=
 =?us-ascii?Q?sl6xT8FQsJHMN9vXwOnJqjXRpNWo4bjfQ06PFqnA1bYSk97fNvStEI+XP50D?=
 =?us-ascii?Q?WswLU71uQKbXBRohY9ev0VplaRl8GKI37y1+i23j/fD4CsPsndkLruCukXOJ?=
 =?us-ascii?Q?L2QikyykuSYiXXR+M9raUPZfvm1Hfo1ipM6WR93CdwEu0KaO7V6j+aH2x/PU?=
 =?us-ascii?Q?n8T6XH3HLlAZBHjyL0c0ugPQZ8vsnqARPBNGTLBcth3e+4XHqH0srgqPAHwY?=
 =?us-ascii?Q?ctiWJ7ZhRhugbF0hwQFV2YM6O2nhjkcFVfTV+YfKyljMReC0E/PE7tCVIRP0?=
 =?us-ascii?Q?x0JOMY1o2jDIp2bT9hzCBnauZVAdMApUMhLHKu1h8vFSqE7IQojgOhA4qJ9l?=
 =?us-ascii?Q?twZYlLtljymanmltq7+f/1SNZFOT8EELDjtseMuwZKAjILYMRflWclXGNfvi?=
 =?us-ascii?Q?mKthGpxeLAPy7SnIQ1z4RywW11uajVP+rsTdFrbXPIPZJu8tm7C7yy70aUPE?=
 =?us-ascii?Q?fnCYH6ViLuTdRsKjKlSBrhRjpcR+suHPv50C+xTDhgrQ5BOD3ix3fIfBXZLI?=
 =?us-ascii?Q?KljHpUwWWr1rmclDi0g/kUY1Yv4EKwOsMh/E9LIG0iSDaJomAaokqoVmCWFM?=
 =?us-ascii?Q?XMUtMG2B4TyE/2YrRmpzg/KFBTrDXf3QPoFUUPJYkPj+FM97UtdJi1LCjdvC?=
 =?us-ascii?Q?mzHlhMvp7RdaFWBQ0LV84sJEUWoGtZ/0eGcaFsjD9tGv82J2rJ2dMiFhdciT?=
 =?us-ascii?Q?H3L2AIjmBPeVQ1sCwsYZMiD+On4y+8epWa5pI3f2SEGrGiqGASc7YYRiH/qi?=
 =?us-ascii?Q?YM090/iUpM0Tii8wKPRhxHeBnLYP8t/P6Flquwb4G9ILuqXW4m7r/f+hKPyO?=
 =?us-ascii?Q?+d4gL6zPRoCkvFM3Sffwn1FpAIv6o2cr7Bek5lPbWCSs1/RIGdejCEaUrnmH?=
 =?us-ascii?Q?pZAVYKF1v8o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bjv3dSmO26curGa3SSDrVyx+yLghndECVdN6SQCQX6FsEHmVomB+GdtZDbjE?=
 =?us-ascii?Q?KrF7Wt/Y0p+AdN41RiCPsXkDQf21mBx6Omz8EnsiPqxBU22kWJmi7JB6N0jc?=
 =?us-ascii?Q?UaWXByHofefQKLSsk531vBCakLOATs7GR4S+hsb6ibheBgxVIzUMMGgtytHT?=
 =?us-ascii?Q?5atbShdjqwRHB2VQQlBZYKSWvUHuegVxmkHEHJhhXDfGSYW75+oPVLLkqmGn?=
 =?us-ascii?Q?qVYGMBckf933n/KTWuEdkQ/ADjtdXHcFOwWgf37OzywytoTiLgIN8PnwYb2z?=
 =?us-ascii?Q?55amv3ojuOgdMnnn9c6Nl3IlQfXt0HN/mqOryJX4aOvVbB8Z4Tch8NvFlVdK?=
 =?us-ascii?Q?KDw+4/kG1B1iMJeCZ7jHKwEDMx2Tyq/xC2LlEB7/64218EyASMX/hRQuyHJE?=
 =?us-ascii?Q?SlNVPHv8yD9kXYaWn5liO3lqqs8+UY9funZbiOSdUbqRps/cFnD+qSp1C54p?=
 =?us-ascii?Q?n8u/JLeSIxEXol7Xu3eO+lIo1Oth0RC+1egrsgGDtOpGTspew2RT58Jr1UKq?=
 =?us-ascii?Q?bKNUl9HEndLvRZE389O5CnrZgE+wqpF6QGmk9m8vtp/QlbJmOwVgRh7p9of6?=
 =?us-ascii?Q?9Q+FVfJubOVpVFm/Z81//+evbr2FNKpEBx1FoLrKUNWqsLJadsjwGylCTY9a?=
 =?us-ascii?Q?LA/EULRMD7VrYxU0UVy+H8ZY9GEk5DPH19J2GgnQkcw0INrT6d+/XWfwZtP8?=
 =?us-ascii?Q?m0s3AghrhF/FQYChnjMVjaj1003JbvzkI7r132RLPodvm0jGPcLWYof9KL1h?=
 =?us-ascii?Q?25vxIyCdGXcdcHOxqttP1eZuO3agBXb+7HjwXLALtQVTelLLNV45oB4puDBq?=
 =?us-ascii?Q?jRCwtCytSJQ5jk7eWPOYnyEi48Qscvm5pLUYdc0y1yxeOECLfz/OU137Une/?=
 =?us-ascii?Q?snoLKs94K5dahRDXy8cJtYoWnWyFLx6CeKj9BSLiiuzQ+iOEe8OSwdZxd0+r?=
 =?us-ascii?Q?VCGkWFiRIFqgPRuLXbbB9JM53haSHLplMFGcQHT35ql65BWctNKcwsyna2t+?=
 =?us-ascii?Q?uwC+r2iX+Ql3+HWynSREmIV3GeUgrIgrEqG7lCsBsEOC++aQU16Cfr84GvR8?=
 =?us-ascii?Q?U8pFH/R+r8Gxpc/6Y91xYSECkaPLkMIubpTiLcjqBHxkWfa3OipMhsp9l4El?=
 =?us-ascii?Q?bCzycX1l0otoPypDF7C1nLkaE90jMtJaGlwdbh08HR7XaVSXbYpShCycngUG?=
 =?us-ascii?Q?fhuuX2M6WbuZYLrdtd/r8d7IRzQ/qlMEggp5me5+7kMkglTFAmXBUomQepOc?=
 =?us-ascii?Q?fohO84c16bKhkFslXYm62UMZOOuUggnyat/MgZhU7QIRHwvib+du5Xki3wJj?=
 =?us-ascii?Q?gqW/PVy5p0+iUWgOYXDDGEui2L+Qb358F2ADbQ4NRhrvNYHTr0lPIhVE0+pH?=
 =?us-ascii?Q?wwiOeGjMTQrVXIp2KBZzfURX+7iksQaBXjlx6lEHds2F9z2Nv2Srin48arK2?=
 =?us-ascii?Q?CLDrumU+DR8V9IiLPZ7rMR74L8k0sxW1dPdHHAQ1vt7LmG2VQW3AzPda2rug?=
 =?us-ascii?Q?SdXqgO0vanm+u9cWEcDpVUZrxhqPcvpyOS7V49cQljWakY01Dj+MW9ZayuEf?=
 =?us-ascii?Q?KOY1KBkVaHi0FX+02Zw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cfdc40-677e-4c83-7ff1-08ddef9b06bd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 12:18:46.9678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uaD61nq4cqQMMSkPOEI1zIzPBzP0DJ8djnEBa3I7QnOu3YTuf+uZgkJbaCuj9LA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061

On Tue, Sep 09, 2025 at 12:14:00AM -0400, Donald Dutile wrote:

> > -/*
> > - * Use standard PCI bus topology, isolation features, and DMA alias quirks
> > - * to find or create an IOMMU group for a device.
> > - */
> > -struct iommu_group *pci_device_group(struct device *dev)
> > +static struct iommu_group *pci_group_alloc_non_isolated(void)

> Maybe iommu_group_alloc_non_isolated() would be a better name, since that's all it does.

The way I've organized it makes the bus data a per-bus thing, so
having pci in the name when setting BUS_DATA_PCI_NON_ISOLATED is
correct.

What I did was turn iommu_group_alloc() into 

static struct iommu_group *iommu_group_alloc_data(u32 bus_data)

Then

struct iommu_group *iommu_group_alloc(void)
{
	return iommu_group_alloc_data(0);
}

And instead of pci_group_alloc_non_isolated() it is just:

	return iommu_group_alloc_data(BUS_DATA_PCI_NON_ISOLATED);

So everything is setup generically if someday another bus would like
to have its own data.

Jason

