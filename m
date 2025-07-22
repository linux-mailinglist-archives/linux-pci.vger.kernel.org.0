Return-Path: <linux-pci+bounces-32759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD85CB0E5EC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 00:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07501CC0CDE
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 22:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF15286D5D;
	Tue, 22 Jul 2025 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQFa7Y3F"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443B2877CD;
	Tue, 22 Jul 2025 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221532; cv=fail; b=J4spFX/0Ihwm0yUA61ujvj6/Zw6p5YiHAN1au5PvGZP3NX7z+Gh5Wh+Qs3XD+tce4W/GqPC5Qmt/6HA2Iw44dcmhosN11tJ3u+Czm6i4hzYl8hZgAK2BVmhqRhlViPqrukNCukqf39LA9061bHba1jq8fRBuqKHKfB7fM5C/7eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221532; c=relaxed/simple;
	bh=bDHld0j8ntX8C8I2H11YY53IJN47dRm0cVLefn16Zxg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxQECllnUN01XInSxJ2gXGXnk52jzhLMVFEieF9iaJGHbPQu3tF2zvZjzF6eap/pT399VZex6XOA+E2ZHPgFGbDb6Oj3MXPGEUtgvGgsV3VoKJ6668WN2cEncswySABNopQ0puwTXR1sHLKipB1obhL7AMTUhodwO6z6CK1JDME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQFa7Y3F; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Euk5ZvHK+svHpzQ8hmcJbOuiPa/zUFCiCS5l6B1aSpZo0aSTT5zSLh7AJnLNygkAucpRmhp7SgI2tXpTDTJw2gL8xsybsnam3dHFh7mieDkp6bgfbuQWhnKwxs2Y+txLDDzEyBIMq6oSZbZ3Sxr1aXSgfY0NrHWSXi6J4wvIsZf0AZFvMPKSVbo/TWlJLD3V4ORrggN4kg2Dhm4G/CM/vhdS8DnTNftdNFRIS6dhF5oL966ir7qK7qZwK6h3luft+WvGSSjm/yX9pWuJy0wr0L5g+jV1FL4/AeY9Suy4mrwp04umbidPzc9NMXXY6XmwCXxm9NBGC4crLNaO2Ruz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ACwBC5SqjDz/oMiKgIqrpOL4wjOCxWWxb4h4V1WLMY=;
 b=hRVgx6EMQiez7XX4VhtBf9fizaGg3hl70vjzd0HLZ8IH7iGFiV0zz3taHT95ibOHyxJ/PLOqzplVGZoRlrxPvSBTjen5yoVBKrfRRUcWzBPn0ambqCFA1XpkeHZAC0nX51a7I+Ww7YBVgW2N6AG0PWuAmN2RR2XqC1pOTS6wbKSBsZ4qK9mn/KSw2kTEyTqmtvf8M88vnT/wKVV48yMeaCYXYchxoLH7ZN8MuA+cJTZQWBYdTJE06uviqD6J1YHzx0h+iWKl6RUSJIXyCD/FZHz4/je5HGe1HGDdO71g8REjgRX5XkXe+1rqV2Ln3/BHZmH/UodNg4L/UvDQqxRn/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ACwBC5SqjDz/oMiKgIqrpOL4wjOCxWWxb4h4V1WLMY=;
 b=mQFa7Y3Fo8PATdUmTTREY8RiCx2wfgHq7EdOFuNwj51aHa7gXKFeRxtHYJvtasDnKhxsyeIZXo3qLRjLw0iEO0dKPOooUwvHuq2NPnwhGPXLQPhSW3U3hPVvvQBZ19CpPnLr8+rbfA65D1mb7UxFVGSSzpUf4o5bezfDGgMK7OZb7NE5bmxT2uvg1NvKLXywC/SIz6rYY9J86wusZuSrrsnaK/GsWrdVvL94W/vHu7n2DyC6JzOElWa3ioNekqobzfxoXCaY8FTKP4nlYPV8pSffcFc9btPL5XM7jYB+49KkAtRSjnQA+QpMWXtiLH1hShPq0IqKniaOhgxRdj+cQw==
Received: from BLAPR05CA0041.namprd05.prod.outlook.com (2603:10b6:208:335::24)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 22 Jul
 2025 21:58:46 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:335:cafe::26) by BLAPR05CA0041.outlook.office365.com
 (2603:10b6:208:335::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 21:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.1 via Frontend Transport; Tue, 22 Jul 2025 21:58:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 14:58:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Jul
 2025 14:58:24 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Jul 2025 14:58:23 -0700
Date: Tue, 22 Jul 2025 14:58:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <bhelgaas@google.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 3/4] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <aIAJfYMKYKyZZRqx@Asurada-Nvidia>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
 <20250704154342.GN1410929@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250704154342.GN1410929@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: f04f6bbc-0a4b-4717-6ce6-08ddc96aee54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gJHN+yYg3IuZZaa1c8DQlDsHXsEcMp7hGNFPuIsvUg2Z7ZBjAGvt2xjcNjPB?=
 =?us-ascii?Q?43fe3+N8E0yjLpqYXik70D8mXG0XBawKuZft+f6+8XXD/y8eUMKmqzpe/DZN?=
 =?us-ascii?Q?tloBILsfWvh2GPJ1rXMNvd4P4hela1lisN1yCS66U3eTckswDFESmUvbXwLG?=
 =?us-ascii?Q?mD+Em5KWjxa4EY7k9V4NaCDtGztI6nFfAf3ZspNzLdIZm4Xq4QdJH/PHxCAj?=
 =?us-ascii?Q?XJTtkqS977KzKKrhXNi8nLIQOUtou6myaeHbLwt7il9GH6JDUfOm6YIHZl+X?=
 =?us-ascii?Q?PWG99DcbLf+IP/pGIYv5b3ZJ/bVRp8dnDT56hUg3fM38wu42Iro/j7G7DSwK?=
 =?us-ascii?Q?OUk/e1qK8qhmoIse+wXKrcLf/hEloT3vwViZ76wa7mYaXQBxriTJJHdh6BPv?=
 =?us-ascii?Q?S/rMfiMmgsGDWXs2Kh0BodCM6psOD6T5Id8NthI2FtFeyRdZRbPg+g8GjpuE?=
 =?us-ascii?Q?guz46aiX6MQ+C42M99/F4Awkc8ceAb6w0ZjYz/GeQeJ03c9TkIDbEq0tOpAw?=
 =?us-ascii?Q?KsRW7jfztE6aS+rx18CUxGY6ya8iA5iHP3Dgb3EHc+QanjXjcaccZj60eQxy?=
 =?us-ascii?Q?fXX+/GdhXUn5dYs2xE0xC+DO52b3M6TdLs4yNb7Muo+hkPcvVde8KWpl7iN/?=
 =?us-ascii?Q?Xf5utSDw8Rl7Z9Ji1ZC/m0TUqsQyG9JDjrKArxPdcXtY04QdVlldR57DKNzw?=
 =?us-ascii?Q?dp8IHPsF/2GxH0ibh7d3PfbJ7HArO5uWuHXgV4L88as+85G7nWeXSVSMkGEr?=
 =?us-ascii?Q?BSOomFy+BXUHJEscii2YF1s7faQkzC5qtS/65TuMtdPQEl7D69wE1LzXaHRv?=
 =?us-ascii?Q?qn0PF0/DYHhmHtN3TrTJKbQKKD6d5Ti7fvN0ZhNjKVlEZr4BwUcbMD7e/CqC?=
 =?us-ascii?Q?1kX/5UfwR+hhjSN0slQpGFLEjqlUJ00CWnVanp9Fwm7ip0XIUAg6ka7s9fje?=
 =?us-ascii?Q?BnGLZ0ze02Z5UQRKWltjVtRtUpfkB9uEU9sn34uh/z3Am6YQn53pFaKUcblH?=
 =?us-ascii?Q?Qx6FXxOQlbuZC4lCJyFbwvTdhJLwqf9M0TUOkD1cN0Ku7TSO8gYZUwVCexV5?=
 =?us-ascii?Q?L8W6pRvH/rWx0Shjh9OfzUS4UoQheqkJrQuv/UeweCbsEiqDs/3grWpwa9Ha?=
 =?us-ascii?Q?M09XnAzxsQLTuywIZIVkQbIMs9w0BFpbItfdtmBl7uJZrit76KCP+9SPbZcf?=
 =?us-ascii?Q?2AzYaFSgfaDe91UZ3tydC06w4O+ZcQX3KOVIDR6Nju+734aCyxVeDxQoXY6P?=
 =?us-ascii?Q?+gOpclGK00ZPyvrXI2MGrqEIEQ48SjLOqH9VjJR2KAuckXbkSaqzh/thbn+C?=
 =?us-ascii?Q?eIvrjzzu6/iiYe+6QpsW08FBmJsLC8W7M0zeh+QRLloHxQ+oFSrBdPTBNSgm?=
 =?us-ascii?Q?mwzBu+BxwFK9g4/hH478dBAN/Egym06hIM5bfiN47jb0RvjGRnmzLV7Ddoa2?=
 =?us-ascii?Q?mbkIOvWyVUY+/5ZL9yOP6q0Df3z85bC/+iM1f1qYpSYmeTpyos843AcAyCjN?=
 =?us-ascii?Q?MnkbKmxHlFGR+iznRbC4qhq7FPzS6KCDzMQx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:58:45.6334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f04f6bbc-0a4b-4717-6ce6-08ddc96aee54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753

Sorry for a huge delay. I've addressed all, following your remarks.

Some feedbacks inline.

On Fri, Jul 04, 2025 at 12:43:42PM -0300, Jason Gunthorpe wrote:
> On Sat, Jun 28, 2025 at 12:42:41AM -0700, Nicolin Chen wrote:
> 
> >  - This only works for IOMMU drivers that implemented ops->blocked_domain
> >    correctly with pci_disable_ats().
> 
> As was in the thread, it works for everyone. Even if we install an
> empty paging domain for blocking that still will stop the ATS
> invalidations from being issued. ATS remains on but this is not a
> problem.

OK. And I am dropping this validation in the PCI patch:

	/* Something wrong with the iommu driver that failed to disable ATS */
	if (dev->ats_enabled)
		pci_err(dev, "failed to stop ATS. ATS invalidation may time out\n");

> > @@ -2155,8 +2172,17 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
> >  	int ret = 0;
> >  
> >  	mutex_lock(&group->mutex);
> > +
> > +	/*
> > +	 * There is a racy attach while the device is resetting. Defer it until
> > +	 * the iommu_dev_reset_done() that attaches the device to group->domain.
> > +	 */
> > +	if (device_to_group_device(dev)->pending_reset)
> > +		goto unlock;
> > +
> >  	if (dev->iommu && dev->iommu->attach_deferred)
> >  		ret = __iommu_attach_device(domain, dev);
> > +unlock:
> >  	mutex_unlock(&group->mutex);
> 
> Actually looking at this some more maybe write it like:
> 
> /*
>  * This is called on the dma mapping fast path so avoid locking. This
>  * is racy, but we have an expectation that the driver will setup its
>  * DMAs inside probe while still single threaded to avoid racing.
>  */
> if (dev->iommu && !READ_ONCE(dev->iommu->attach_deferred))

This triggers a build error as attach_deferred is a bit-field. So I
am changing it from "u32 attach_deferred:1" to "bool" for this.

And, to keep the original logic, I think it should be:
	if (!dev->iommu || !READ_ONCE(dev->iommu->attach_deferred))

>    return 0;
> 
> guard(mutex)(&group->mutex);

I recall Baolu mentioned that Joerg might not like the guard style
so I am keeping mutex_lock/unlock().

> if (device_to_group_device(dev)->pending_reset)
>     return 0;
> 
> if (!dev->iommu->attach_deferred)
>    return 0;

I think this is redundant since the fast path checked.

> return __iommu_attach_device(domain, dev);
> 
> And of course it is already quite crazy to be doing FLR during a
> device probe so this is not a realistic scenario.

Hmm, I am not sure about that, as I see iommu_deferred_attach() get
mostly invoked by a dma_alloc() or even a dma_map(). So, this might
not be confined to a device probe?

> > +	if (dev->iommu->require_direct) {
> > +		dev_warn(
> > +			dev,
> > +			"Firmware has requested this device have a 1:1 IOMMU mapping, rejecting configuring the device without a 1:1 mapping. Contact your platform vendor.\n");
> > +		return -EINVAL;
> > +	}
> 
> I don't think we can do this. eg on ARM all devices have RMRs inside
> VMs so this will completely break FLR inside a vm???
> 
> Either ignore this condition with the rational that we are about to
> reset it so it doesn't matter, or we need to establish a new paging
> domain for isolation purposes that has the RMR setup.

Ah, you are right. ARM MSI in a VM uses RMR and sets this.

But does it also raise a question that a VM having RMR can't use
the blocked_domain, as __iommu_device_set_domain() has the exact
same check rejecting blocked_domain? Not sure if there would be
some unintended consequnce though...

> > +	if (ret)
> > +		goto unlock;
> > +
> > +	/* Dock PASID domains to blocked_domain while retaining pasid_array */
> > +	xa_lock(&group->pasid_array);
> 
> Not sure we need this lock? The group mutex already prevents mutation
> of the xa list and I dont' think it is allowed to call
> iommu_remove_dev_pasid() in an atomic context.

I see only iommu_attach_handle_get() doesn't use group->mutex. And
it's a reader. So I think it's safe to drop the xa_lock.

I added this:

	/*                                                                                                                                                                                                                                                                                                                                              |||     iommu_map_sg
	 * Dock PASID domains to blocking_domain while retaining pasid_array.
	 *
	 * The pasid_array is mostly fenced by group->mutex, except one reader
	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
	 */

Thanks!
Nicolin

