Return-Path: <linux-pci+bounces-33111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8925B14E07
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE863B01D1
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3653313DDAA;
	Tue, 29 Jul 2025 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Isu4BC9V"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D3224FA;
	Tue, 29 Jul 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794166; cv=fail; b=l8tvfnVn8vpAup6ZSSyngHFrEYsL+jttsOysRVPtHeben/aF4bdR5wun4yooQPfC7yG40FvOS4+BRbG1tMP48SBJ6v/Gcaa7Z5gJQD6Ltd7OtRYvnOE83Cj5NRud8IC5lwtLQaQQVYvL2RIZeOsKLzgD3GfkItrIYRAyH96ufXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794166; c=relaxed/simple;
	bh=BGojEvqKF2nFfx5gWhSKDTt+iGSZ5WliIYle5nVqejQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H8Rc8U4EUzj2lIR3/evJsXQvKXqYYFLMpG9vc1RBJynfstjvTT4EJ9zwIgxo6S6ujpy12AjUwwqLT3FgUTVCVS3a4LZ/qcOCaMS78IwyLFCAZ1FR1RdSNVxQVUO3k7r+17Kwj8iMfZ3nJPYZf3Zdtx2qgwfXfK45gkeVisSPGIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Isu4BC9V; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsTXfx0Sj2i9IowQInqdhCn8EMBme/VPakG1Ivxxy7zt/XOSDaitamyMsqScfPGe/W/toIjJ+dMbjYl50aKZimsV4iW+Y9CinULmcOxsqBB+X2fXSMn0OpJryTZmOMG98Yz8vOPhXwvpRtbRbGJ81+9HM8yJ2uWvglNK1v9t8PTFAhgypKQQ0xbtRUi+j6K/5MlZBdaC0I+ayuoJZIdbWf3W/q+FVuOY4XitW+OUpeWwZw13A3GwPE7rhpjORAol0J0vi7ahHHgy11tZm/KXy+khI5bj3XdVo9FW2opTz6Qu9ZbEqOrGRnXchvMLGJU09VwlX5c1j283JqOjMHmqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+VSgsbf8UwcL/hFN5+r060OV01hNMa/zCgjQsIEVho=;
 b=YiXjltiB+cj6PFtQFMopcmRvD9xjG6Ol6n8WS3Ki+QjXXzNZqms2ec4BBaYo49bR7H/Bl/OsIde9V0MaJMngkJ1SH5uInDktMK5mhDPjiIkh4E0rM62lZLNXXKcMm2a6Dj+hMCTlBswLbtYflnYOBq4pyhwmoFToBu2FHaFOkiqKSGmDc4FllXLXUwXWuKGEXhu31oCS0XWIZD9e9F86k7vv+34hy7w9XRlBCeShih3YCMC8Z+kFiPVr0Y+VjpNkOlkMxeQ3CLfLsU9EorM5XLOu8Sr7g+ZECWgqZAEBuVVB3GJbiGZLjxTsvvfuoAJPnXjyMzXLgMI6CXBTQNeHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+VSgsbf8UwcL/hFN5+r060OV01hNMa/zCgjQsIEVho=;
 b=Isu4BC9V9IV7mqHm3llrC1GIYhMvotfKCYa+9S83k0gHxStmzbQpEE6/N1LgOQAPBJ7lcEKQ5ao4HUt+mC4tf2Q8wgiyKAuISpKGR/MpsviJHh5V4fPuhC3ZSD+9g7pftGOe6DIRKlMnNBxHI8oPR8F5KZ/QDsnxXQmTrKZRtBgnkdhTKUXTRoAHRQZtGTThtGJV8ThwptMANUOhsNf6iLKSpgIt8FMwM72yHCcrVeOU/Znb1ybKZauypAqG2D+l0qfVjczb0e/bpp07zW5e5nzri6zISvn7gUMkrrLbnVsAD9/0SCkBGdkq7E3eDrlPrCr4QnmPyUVOMrAojJSDgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 13:02:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8964.024; Tue, 29 Jul 2025
 13:02:38 +0000
Date: Tue, 29 Jul 2025 10:02:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
	helgaas@kernel.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH RFC v2 3/4] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <20250729130236.GI36037@nvidia.com>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
 <20250704154342.GN1410929@nvidia.com>
 <aIAJfYMKYKyZZRqx@Asurada-Nvidia>
 <20250727162501.GD7551@nvidia.com>
 <aIfKjyvMeIYac23A@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIfKjyvMeIYac23A@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0408.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cfa3e50-6e59-42ad-20a8-08ddcea031c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/x9Lq1vDs+xspyAa+wLQC+JGsIbZ/5ZEqPinCUKVaYQG8hSsCWZt2WJHYnq?=
 =?us-ascii?Q?jHwOHzBxiq1jHOzQITTA8Z9+HywaNkSAni2CwQ3M1KrkCDIWY4/ltgyQA6n2?=
 =?us-ascii?Q?urhshTYsjew6Qhb84E6BAQWOcjKoc+AE6LGWOSVjssp+lBK7LoPC51iT3rw9?=
 =?us-ascii?Q?ohW0vccYra+Ikeq/0tsVSnh6pfI2wz5/OQs7OhDJ2Z2N4mvmI/OV4Zy1ZTdN?=
 =?us-ascii?Q?MPoqDbcM8NhoiQ5TU0g4/FNGUWNneSaCajCAiMjolaIm2M01FpAMFyoZQegd?=
 =?us-ascii?Q?uqSbLK53pU41Y0fz3uIF6Kd6XRw5b+SIAksqsbgufiTaAJSyWnrLxtruB2ZT?=
 =?us-ascii?Q?v65u9hnc9dulbLati8aT9p77W0bYn0UuWOCpug0dPtfAbdwGQeS6auYC42BI?=
 =?us-ascii?Q?yHWRq9W1BWLo8Qykxey6aXVQJb53WSkaBZ0Q8tly1d9O5qyy5DbRqMv/W/zV?=
 =?us-ascii?Q?JghfhI8T+GYcQB+Ybpx/LfXYNEPiJBY7NM70Ngc2jbkl7a1VJHoVIq81WxfY?=
 =?us-ascii?Q?yupKWT9YYY1rVzX00t7Uee7cSgB7a4dJVhjMKuNcmk0R02LatbIK5nrJG6Rx?=
 =?us-ascii?Q?BmtblQej7n0bsBz0UVnJG4ZSFMnZZ9dSNnyQ+J8xIfEpWlYqAajh0jnB+DSD?=
 =?us-ascii?Q?9DiPRUMwe2rVBoxnFZzvWHgGCBJgVwxX9jEQcpfPKB8Me8mCYPfbP5FSqBGt?=
 =?us-ascii?Q?uDgDA+EFqKc9uyjZbThj83LdEgz6KC91riz8L6MLCbFwleVKKcQ4tue0i/hc?=
 =?us-ascii?Q?4wmW1Y4ifivfFxPlXGUWsXNS/QrbImVmehrR/Tr/QFSmri4Hvd3AL+glxD2n?=
 =?us-ascii?Q?AZdRrdT4EpEBWw0eCRGUvGEGoPL9N8D8Q7bS5KXYOPuLuNxlv0+RWbrukAV/?=
 =?us-ascii?Q?MsDrMPowGCC3acYMkL6sW7kpHExyne1ZIpT5oOuIfcsKprzacAWJ3fGbfXSC?=
 =?us-ascii?Q?/Av6hk+NwJjlwghQb4oc0wPnKabvFwUXgL1aWKRpuNBaZL1II2x/syFmx8C8?=
 =?us-ascii?Q?rtxCIHNVzekBo5wuk/qb7IMj0cptb82zq31XjqvO+Ib1QujRfVZ2n+acuTDI?=
 =?us-ascii?Q?oLVBp4KmXcsGzyjYmQJzOEfUmvW7nJoJqKr9oXFHM40T5Y1Ve7XYpt/zt2P9?=
 =?us-ascii?Q?5IlhHazcaOC5Ptq406tH7UUfnIzRrQmuTfD/2yO/LFsq84oTc5y3cUBg2yWM?=
 =?us-ascii?Q?cxIIazTRo2UfYjw2uIKgU19eVqI5Nb1j6EDOGYJyLI9LcxZilWY7gpvI+Nk8?=
 =?us-ascii?Q?py+GoSh+0r7qFqjhaf/IZgd+RujXNtYPN4hih/abUKDzUE4F+TBXADltAKwm?=
 =?us-ascii?Q?1KNucIvzOazYTdW7K8TXE84qddbF17cRGW1qvLgnzJUp6kNAjwcxMAqWF6by?=
 =?us-ascii?Q?lKqDOhXKFsxtrv5u93fA6xm9QwzuL0Uz9tm3Kd8c1KLv2yQvfcuahxknSJ6b?=
 =?us-ascii?Q?6zmbp/BoIJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vCACplZDCKTXYXUsALKGCKKN0xYGHzGYl+Cr0JIUBDM7xy5zFFsvv7giIdpf?=
 =?us-ascii?Q?PICwwQxY65hzGQt8UKQZtzVQpxPyXoGjSQcg+RAFBMiU8nTbC9S9dqXjWgDZ?=
 =?us-ascii?Q?zAfkbRcQQu2oNsuJ4b/q2MrDhYmLj3aCbSLPrSQlOMHKV+XysOf61Biv95ZO?=
 =?us-ascii?Q?uskA8+jIKTBoXkI8VMq4vWIoycAJlgIUM2D/EfoDMn3wAMpRDypK7N2aavQF?=
 =?us-ascii?Q?yvImnMGqi30FiTvmKUBVZZfndB6ejJdZ29H4e9ln4Uc0vtTBmSE2SX3GYnFV?=
 =?us-ascii?Q?vsI9JooTN3WHMpcW+pDeM9D1bFjcXOZK+dFb4erw4eJHjlWpC/dk2LeElFvU?=
 =?us-ascii?Q?UPVdZjjkqX2VfunPv0I2oiazhOCGnf2CbuTz4Yt+8qgiYPqm3z48CqiC1nlr?=
 =?us-ascii?Q?1VxdQiZB39ecfNWdTIiBUnsUxu5w0tANGOZ1qJDfvhg8cDyWlGKo99RjV44S?=
 =?us-ascii?Q?QdthN4r+uDpHaMmmG0XWrviB+HgzCBdMQopQk0w7LVxsNuXkzkGaFSyS6Q3y?=
 =?us-ascii?Q?QKhDnH51Wohws8H17zTwpnCCXI9c8MpI/N6JfSFPFdhGlRFkaEKNLxkkZoE6?=
 =?us-ascii?Q?rqc39V2z4nUyJYSmeQ0qU/hHvDmLEuhZ9rf1ZXodOCf4eK6m3CnhcMg66TIT?=
 =?us-ascii?Q?wFQ7BJkMUDgH4dtocxY5jnhL02hMKDEWVMvGJuevVGFSMPX4koyjc7OFztk/?=
 =?us-ascii?Q?9xZbYYewAx/rRIJqKbwzZOtkH9hXQoJhpUkryMIgvwln6b+Xlyae5dfmMffC?=
 =?us-ascii?Q?YPOOZ/rPHC2HH3VC+eESQvzDdwYikpakF2CkPPZ7x5bKjBPx2t97xVKiodSW?=
 =?us-ascii?Q?sW31CxRBdsRDO10sWsMnNmFoIjOlkW3yMLf3reuH9+8zS3v9rhBlvRnktuBM?=
 =?us-ascii?Q?20i96GMnyXvTiqDErN7GKQF+D401jkkxe0pa6aNBJYnI3ZgneVf2KBXAkAwA?=
 =?us-ascii?Q?n0NARKlYxl0qM7P9oQocjGcLprgR2vk4cEyMVQS2YvcuucbLDy5HCMEtP4t5?=
 =?us-ascii?Q?BIU6dSLTlj7O3cbDNmbPN9PCImZwqblG3ZaW3cunBT9EgCJS8fnAmrnIXbYf?=
 =?us-ascii?Q?wptg9ZeZdR7DJ6ihpTAksD3Eci92GSGWCQcBUMolI21VxYNShFUjfMv4Jnrv?=
 =?us-ascii?Q?bpuUCdC2qbx+ODOPeR7EOE5dYZ/KGCmswoWks2BnX4XaefQAqhKU4YqBO7ic?=
 =?us-ascii?Q?1gbP+u6aTL2nHJpvxrxVe7WUnsLkdpaWw1sZBbfu7CFd7QF4zsWgRZiXPKaM?=
 =?us-ascii?Q?FY4HgeBMAh+/FDYbzA3oT1CViqJ9hqEdJrzJPpiKfByPhLgqnv2fy+Hn5H04?=
 =?us-ascii?Q?lJE6tOFWOMj2gsig+QLaDG82x0/gBuJM1fGkBj1gGieZ/O8NRJk8jA7r5v6G?=
 =?us-ascii?Q?4QUHG61asS6py2f2535LeqXmNiFEELo7jR0C3eCDnkq5LFvwnRjDY2RYiUMu?=
 =?us-ascii?Q?3yI47o6CaTC++Ivp2ru9F/E8i+pgZwMaa331fFUiUNRn49GHQ80ffj/B3H9c?=
 =?us-ascii?Q?DkdRaslq8wa8oykPqY6XvH7CFkyz90O8lBoxmDk6MTe2sGMnO8UpTXU37lNx?=
 =?us-ascii?Q?rjw/yRKDxbO1bmqIUW4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfa3e50-6e59-42ad-20a8-08ddcea031c1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 13:02:38.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEzkb2/j1eNM0kSs8SX1RWGdzpkxN/kdGKRW/uH3DzKOvrXJi1dQ1JS5G2uQBak3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

On Mon, Jul 28, 2025 at 12:07:59PM -0700, Nicolin Chen wrote:
> On Sun, Jul 27, 2025 at 01:25:01PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 22, 2025 at 02:58:21PM -0700, Nicolin Chen wrote:
> > > > /*
> > > >  * This is called on the dma mapping fast path so avoid locking. This
> > > >  * is racy, but we have an expectation that the driver will setup its
> > > >  * DMAs inside probe while still single threaded to avoid racing.
> > > >  */
> > > > if (dev->iommu && !READ_ONCE(dev->iommu->attach_deferred))
> > > 
> > > This triggers a build error as attach_deferred is a bit-field. So I
> > > am changing it from "u32 attach_deferred:1" to "bool" for this.
> > 
> > Bleck, that seems undesirable.
> 
> But inevitable for READ_ONCE :(

I guess drop the READ_ONCE change
 
> > > And, to keep the original logic, I think it should be:
> > > 	if (!dev->iommu || !READ_ONCE(dev->iommu->attach_deferred))
> > 
> > That doesn't seem right, if there is no iommu by the time a driver is
> > probed there never will be an iommu and this device should be running
> > in direct mode only.
> 
> Well, the current function does:
> 	if (dev->iommu && dev->iommu->attach_deferred)
> 		return __iommu_attach_device(domain, dev);
> 	return 0;
> 
> So, matching to that logic, it would be:
> 	if (!dev->iommu || !dev->iommu->attach_deferred)
> 		return 0;
> 	return __iommu_attach_device(domain, dev);
> then add guard(mutex).

Yeah Ok

Jason

