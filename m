Return-Path: <linux-pci+bounces-31078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 313CDAEDD3D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 14:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A697A7336
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A57028D844;
	Mon, 30 Jun 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MC3aA7KZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646028AAE6;
	Mon, 30 Jun 2025 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287101; cv=fail; b=UiMJl3PvluuSHkGZrlsc4ghZnbIeEMHderCbBJqf4ZBjJ6rfrHaIy3uel2JxYvEMt3PlfPo0dWCHvCEiiWe+Ut/LsfOorLiMP8VBIPuZ6Q9I67iYHHgB8w5dtHGgug4410DX/KakEuyLaLuTjQwdoxOMPT2YZvhUv6FFsSgcsb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287101; c=relaxed/simple;
	bh=Vz3HUg5H/6Yfgd/61fm2ktGC6S35crhTlydg8lVkPtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jiwfhQ3hXm3muAq5Ori5cvus7nUb1hn3a2rRZ0ULNWJ1r4/9CNQ//TOLZB9kJ9dI5qdJvWYUm/i7fbmKXijBnktWb9OuUNoR1RjPUHGrmBcU+bkxxoAyrkJR/wo1Qe4afA0v4B0WrFQIM3NHPHAhYq60/sKGgXHrhMCRGD1JxUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MC3aA7KZ; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW0WKzeF8TMxH70QOEUUji2axfw1EzIcf3MqqEBjLwfUYni25Jer8i2BCGwj9gJISi30yGGKNyRbYwyXXtOgpKzLeAkm263KnxCXdvMsVft2jd+0nCPnhd+2v83oX5ZuUqoJUhkSGPC4z+BvmmHAaFtNjs/ZrZvBqXLH3x48hOw8Dbn60FqlNDQF5zoWVBSb0pwa+QJcPynvbSyjlKlUv4RnjM1SF0+rE9u6jGZS3Y9Ut9IctctsZ1gaDONZBs6SMfAVwC9KyFE+9k+Sz+QECXsLm+xyZOucBfcPcfCp4uOYh5sSYKBvnvXD13VSgRQokm1qcc4f5WYLyD168ZJmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ts0FO/qAWfJ1T4Sk/gm41Eihb19KKbyhtMOqq5A0kP0=;
 b=aZq2sDiwTuwcH3HCoOVBiU+NGPm38fIsjeqT6i8N+nlWMcMK50MDsKnWIDOQ0alfgX9YcQUZXXT2ELaoOnvCAfXnU2cz22UXAHV09jzB3bR3t4c/YgTM01BwhgoDkqWcjiOPSAYIBs7ce1CtKkmoFdhNFQxgMqnentq9FvyNLUOXxE9PUCSLL3W0uC87TjsgdTtLR8smFejYMSgFSu3G7KJfYllw0I+WM78NshJqSujBsYCExdFLtyp8U4ADkVo7zd26Az6OJFQ+BjovvnvUmh8daKwv3DesYo/+aLj22M3aLn0imZJeumQLoFZbJ+9FZBusq1WWY8mV0b+Qv4n0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts0FO/qAWfJ1T4Sk/gm41Eihb19KKbyhtMOqq5A0kP0=;
 b=MC3aA7KZGKlDu8r4gwsjrqFiD5Ua0C/rk90+kxBq6fF6lLrCFXdVHvpW28IxuKxMbTaTh7elaXLT6WKXaUOJULWv5dnllPQAwXai+Q9PLfuHvtst8Uh8xtt8aBgpCa4Id7sm0+rg00u5+JqOrX0NSK+77s3nUpx8tZpz4LiQM8p+DHR0t34CJZM8afnxgr5vLVU63NkQfloqFoKzSL9CLH87nFSitvM8tvnvCyukA91QGNetTvT5/t8ciKuZFkOlaRcHw4VbaEt0IiZtLwmRY2dJ7uUX4Qg1O4+/UFRyX+6Hz60Q1ft8/7OSEU/8ccOkPpS2Z0pB/10IK60Y/IFxjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 30 Jun
 2025 12:38:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 12:38:16 +0000
Date: Mon, 30 Jun 2025 09:38:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, patches@lists.linux.dev,
	pjaroszynski@nvidia.com, vsethi@nvidia.com, helgaas@kernel.org
Subject: Re: [PATCH RFC v2 3/4] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <20250630123814.GS167785@nvidia.com>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
 <e505c970-e519-44c6-a316-e5d186f216ca@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e505c970-e519-44c6-a316-e5d186f216ca@linux.intel.com>
X-ClientProxiedBy: BY3PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:217::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e3d0cc-16d9-46ee-3e3e-08ddb7d2fc48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LQNBiecb1WvNXyD9jCgMro3UlDv75gYItYs8m+KekseVNUf32MY/+Ayo1gOA?=
 =?us-ascii?Q?/1TSNeTnCKOmvAQTScpGuVmRBW15l68tjIrxYfMJp0//UgGNZZhbJt5m+9Cs?=
 =?us-ascii?Q?Zdgfb/79OjRAUMlveSEIqYhPLDEp/T+V0XryaIhWzy5UR/eXAeZodPo23CuA?=
 =?us-ascii?Q?hit/VkRUp7s/CJZI16iOnR5TlRa2jcWGKAd2knb7uMnUz2277taACGDuIE+I?=
 =?us-ascii?Q?TBvT41+R1VWXdDQXLxhnDv1Lb2nk17Cuvvx7baqxKtKCba/zxO5Jmfk5/Ohv?=
 =?us-ascii?Q?Hlurw3j2eZvREGqcbniEtA9wld7TcAXKILL+C5PfJmm4QI8icuCc9dWPbbK/?=
 =?us-ascii?Q?bxu9nw7pSJFEjCLIH4K+LpLVUrmYq7yu9vkAJMrjTypVkzUwbWl1yoqZK/Tu?=
 =?us-ascii?Q?NT3TJagon9AJvjmjHzkrGh1guaqQG/96JX9el/GQzvDVBknrSHhGogZBWHdd?=
 =?us-ascii?Q?/QKB63rZ5z+uI8QUenkcFOhHXJCouQtnSXAr2X/AUhFUG/1g9QaLyq1ys2EW?=
 =?us-ascii?Q?/1QIRShHoOopG4H27YJEG4wmfC6kRXsCaYSMHJmmvIccpAakoG0fJE02xXtu?=
 =?us-ascii?Q?cU8f/Vok06xrN0MK5qbAlLLdYQwMqGAIV1zeycN2EcPPFEqPZv47qzaa6g+x?=
 =?us-ascii?Q?piBdOnVyEwJDPaibGwG/Zdd2RORPlHQJyTMJkroICtKyREIAbXkoB/tcvsQr?=
 =?us-ascii?Q?jrnauIpWJrhjkYwUBU0aWR7cAWSYRIBZAZKwbmFyz/pwQeNh3l75xDzbxXUU?=
 =?us-ascii?Q?zv9m1OvyyObBNjm86czl/eGIp7tJgJsR6x+I+mRnkZPU0sgm3CAAPbO6IX+I?=
 =?us-ascii?Q?wlVhwVyBX1ETnLJfK1KKGP7eoN12F91lI87To3sqPgzdufbw6iUsSnb9ohTC?=
 =?us-ascii?Q?z3lVQLFG0dTELrJizY8gbVWFWELVVA4wRU82zvcugB5ZXaotPawwFpxK2nog?=
 =?us-ascii?Q?4iRsWwjo+1duGDtvkv10eGp5UPc2AsWf51pBIa+xxfVsOL7gOhGEe8mNBFfR?=
 =?us-ascii?Q?sxG4IPtO51Bqnk3ZgD3/Rbff3l+nirf/d8jp337Z7RRg/0PGZlWacvZyE+lE?=
 =?us-ascii?Q?lizqXTMFV4CpnZ7Or4kofI54eHxtIBJ+yaGTquUfW+ZHpwWm8JjNS/zo7Zf7?=
 =?us-ascii?Q?3lbqCejj9L9tO4V9bb8INRCP5/3nBAvCCZMipFB8d0Hcr14IkZQrQtvQePx8?=
 =?us-ascii?Q?v3iaG2g2PHeUzcqkqeyw55KR5YICqULQ4pMxmmo1E9SvmsLdZecFvEjVFVKT?=
 =?us-ascii?Q?OXSndWDuoqBDD+ddSySzviWK5IKZk9kTwgWmM+iQMRwnF4BK3NrgeLZX6vmz?=
 =?us-ascii?Q?e+EkEWuVgovIICseZ+AayD3BYK3HNqlDWj+gsAlHThq0HnVUdo9vMd6XB4bs?=
 =?us-ascii?Q?JC5t5WstFXsl9h8CIESxeJfATTntFElm49zEhczn8/9fKVeLqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MUdFVkTjW7MvBu/JWMSJ39sFQdjScFjLxE5u8GIE467JtZPLQib/aS8UxDGL?=
 =?us-ascii?Q?fO4LE6lpH9y/afZazBnjzJ+na9RpMmBJstlxE8tkwE8JwNBlyfuGxPYxGceo?=
 =?us-ascii?Q?6CARA8Kkbphj6kSjXyLIcurLVUncVlvQSsJ6jNoJMOo14zGum4r35MmmwrdL?=
 =?us-ascii?Q?ZNOHjQDbp//zJKFWH06LTac/dTxyiwS4gWE3tODjUh/XZX9mN7f1Zic72vVr?=
 =?us-ascii?Q?SuprcYd9pbyqkuGX/rMZtR/VCZT9BWuaJT0RBdT3wsdstzlpTe5fivnAWUNd?=
 =?us-ascii?Q?NrJ23+KGnmt//fJc+LBdadqhnxJQesxI9hilcTPpwEOcize4ezvAlB7rejKZ?=
 =?us-ascii?Q?h3BUV2ES38ZJ/cLL92/OHGR+kPc2+RNxSdW0Pja5BLZqFwkjmu8v7JcXBget?=
 =?us-ascii?Q?0gMN/Q/Q02uh0wkCA3oagU/u9YfjtrpCQn196Imz6MW5D4Rqu15bTpCiXXqI?=
 =?us-ascii?Q?J+lTc6Q71ivnmrwCUgn1GMf5xsu0onlC7Cjvz/8H1Fk70BPHu/ZsktxNJ4by?=
 =?us-ascii?Q?jstn9PrgZB7WXIIw1gvTkqzf+MRp3FkFlslik+33Mz61CvyR7ie1tWfRT2y6?=
 =?us-ascii?Q?1uimF+v/QSN8ZIO2SLy33RFEpi2a18FOy3QX3ikkyds7vyROiBNkLWV5tozl?=
 =?us-ascii?Q?jeKGnGxhTSoxDoslTSbmPxP6HWYKqKbPD82GNKBRNH/+4qAGx80hP9VzL/Ka?=
 =?us-ascii?Q?Wk8bs2D5Mh8z0XGVeq65GNkjizxSh7cR711JWVaqFG32KzHF6sohXDzOK+8E?=
 =?us-ascii?Q?YI0wt4rEG+FYaKhORjW+EyEkeEZ8MrtcevXU5ZQaKrXQ1+jXtfYmfHsuN28I?=
 =?us-ascii?Q?5AJ5vP9MJA/cmUBbU5FE5Rj4/PLgIHRzK7E46rDmuQOhVXISJHuPNeLoKgUw?=
 =?us-ascii?Q?5mdcKfsAKEviCiRPA4g4HnijGSIm4v/8JZMeDo5piEKwFlDWiPK/fHl8ZEVW?=
 =?us-ascii?Q?bqC9hahNMjv2TwfhYP4rgnXVApYGJyeQLL3hKRaQnkwIGk1FPgJFmcUKHdlZ?=
 =?us-ascii?Q?uoF/0OiTfgE+rOYFdgigxZagh6Flp0TQMAdPPUiWOjQZ0FhUinWQJiP95MTP?=
 =?us-ascii?Q?5kQQfy+Lyg6MfmyFDpZp8cUPzVUbqr63lmAv6UFWo0DbnLjiO292IS9jutEU?=
 =?us-ascii?Q?Nc6luCIpMjPE0+4lCdi1ZZ+EwZu/l+d+qgdESDDZi7/lXb5Hms+epZXTVv83?=
 =?us-ascii?Q?hvdeRU28g+XQ2mSYjrjoxt2IbdQsP+SMScthJZ+sW/fBrvcbgUoVckN8mt7u?=
 =?us-ascii?Q?TfqAZVrpRUU5ingWJ7Ms5oKNZE7e6I0Rjqy2e8TQUkHRplscMqDfuhDGgVOW?=
 =?us-ascii?Q?CVMw2FaOBHMDnfllLnl0SpmYxmBRQX0ZUU0a8fyDCrO7NM918D0EICmseRsQ?=
 =?us-ascii?Q?eWIRGd3iX1hDv12EdugnK9EB7w7wcQuz/nxSZ779OJlhz43u7Qk+U49PsfHv?=
 =?us-ascii?Q?9UC0Mkk9fuCahZnskA6V4V4QDdqpaNq+e61VLJJC9/G/L0a9RbjjzbKKt64F?=
 =?us-ascii?Q?bh4y/71ulw+0L5N/i/kDj3Fivco4JOyx6q1/OolUnYkg36Lh+X1A3MALStcy?=
 =?us-ascii?Q?/JFKJCQDrtU2hKJMcC7EOBOzlKRS0fy8CVZD1uAa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e3d0cc-16d9-46ee-3e3e-08ddb7d2fc48
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 12:38:16.4936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U89lxLOmxNNaGk0qzgftxhRa9rQvG3pNGAZ0RSUo0Y5VkIQMUsBFtWaqk8bws837
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183

On Sat, Jun 28, 2025 at 09:28:12PM +0800, Baolu Lu wrote:
 
> Does this mean the IOMMU driver should disable ATS when ops-
> >blocked_domain is used? This might not be feasible because ops-
> >blocked_domain might possibly be attached to a PASID of a device,
> while other PASIDs still use ATS for functionality.

No.. The above should be setting everything, including PASIDs to the
blocked domain.

The driver doesn't have to disable ATS at the device, but ARM does.

It does have to stop issuing invalidations, which is part of the
definition of blocked in the first place.

> >   - This only works for IOMMU drivers that will not issue ATS invalidation
> >     requests to the device, after it's docked at ops->blocked_domain.
> > Driver should fix itself to align with the aforementioned notes.
> 
> My understanding of the requirements for the iommu drivers is: when all
> PASIDs are docked in the blocking DMA state, the IOMMU driver should:
> 
> - Flush all outstanding ATS invalidation requests;

Arugably driver needs to have serialized ATS invalidation
synchronously during the change to the blocked domain. The prior
paging domain could be immediately freed so lingering invalidations
are probably an existing bug.

> - Stop issuing any further ATS invalidations;

Yes

> - Configure the hardware to reject further ATS translation requests.

Not required. Blocked domain inherently responds to all ATS
translation requests with no-present which is not allowed to be
cached.

> > +int iommu_dev_reset_prepare(struct device *dev)
> > +{
> > +	const struct iommu_ops *ops;
> > +	struct iommu_group *group;
> > +	unsigned long pasid;
> > +	void *entry;
> > +	int ret = 0;
> > +
> > +	if (!dev_has_iommu(dev))
> > +		return 0;
> > +
> > +	if (dev->iommu->require_direct) {
> > +		dev_warn(
> > +			dev,
> > +			"Firmware has requested this device have a 1:1 IOMMU mapping, rejecting configuring the device without a 1:1 mapping. Contact your platform vendor.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* group will be put in iommu_dev_reset_done() */
> > +	group = iommu_group_get(dev);
> > +
> > +	/* Caller ensures no racy iommu_release_device(), so this won't UAF */
> > +	mutex_lock(&group->mutex);
> > +
> > +	ops = dev_iommu_ops(dev);
> > +	if (!ops->blocked_domain) {
> > +		dev_warn(dev,
> > +			 "IOMMU driver doesn't support IOMMU_DOMAIN_BLOCKED\n");
> > +		ret = -EOPNOTSUPP;
> > +		goto unlock;
> > +	}
> > +
> > +	device_to_group_device(dev)->pending_reset = true;
> > +
> > +	/* Device is already attached to the blocked_domain. Nothing to do */
> > +	if (group->domain->type == IOMMU_DOMAIN_BLOCKED)
> > +		goto unlock;
> 
> "group->domain->type == IOMMU_DOMAIN_BLOCKED" means that IOMMU_NO_PASID
> is docked in the blocking DMA state, but it doesn't imply that other
> PASIDs are also in the blocking DMA state. Therefore, we might still
> need the following lines to handle other PASIDs.

Yes, we always have to check the xarray.

> On the other hand, perhaps we should use "group->domain == ops-
> >blocked_domain" instead of "group->domain->type ==
> IOMMU_DOMAIN_BLOCKED" to make the code consistent with the commit
> message.

ops->blocked_domain is not good, we support devices without static
blocking domain. But yes, using DOMAIN_BLOCKED is not greap, there is
a group->blocked_domain that should be used and will dynamicaly create
an empty paging domain if needed.

Jason

