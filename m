Return-Path: <linux-pci+bounces-32978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CC2B1306C
	for <lists+linux-pci@lfdr.de>; Sun, 27 Jul 2025 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1873BA9A6
	for <lists+linux-pci@lfdr.de>; Sun, 27 Jul 2025 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD6A21CC62;
	Sun, 27 Jul 2025 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WpezOtRF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FD21C160;
	Sun, 27 Jul 2025 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633508; cv=fail; b=r8vFSJPD6N/yA8ajfk23EUWMsmcVSYCdM4nePCmRPcTH9HZngu4TSGuu6n0Y9TflKqTjwOVZSIt+9oPITopGpbZuq/HJtrVFE7uBPWKl3sjkhoJJ7kt+btFvZgC6d5VMCZFKoJVIv8FtuU25TreubhD0GOuX5cd3EZPkR671CZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633508; c=relaxed/simple;
	bh=eVTggPgAvH0r5WUnRC2rlzijXcTpiAXc4a8HnibQjqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tDJCChj2GIiXSQ077qrXbY6SXdnFNnqAaiQ/tiLCZyeU+cVKcT/p1P+Srmg7CDDoPgjFOKerq7bKCQ7GQyZBsLatZdp3NF38Wwkzpd3vW66l8u32XoK61hBLcr6ESTDLet620B0GsrnfMWGvqbSHIxu0Xqr1iE7IWXy/GCGK/OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WpezOtRF; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTPZoStg10kf8FX2jaZpb89pqozhLbUJZrgVUEYykxeBDnkcvPQVgGup+VsN4GIPg2KgcugvLKQDVd+lQf1MIaXYmV2gpn4e8IFQmt1HFeOQhfkhi+lBVh7rEcSlrbXBkskXtNiUh7Ni4n4oECEicQTcfFlRg9m4apk5rEMlL8MFTogFyvzd10wFn35eeMnvDliBoUlPuGljc2v9/BNcG3rsOki9S/fMEsGFciAb1yF6kdCKI9LC1IcYY5VszPOwCj4fJqxDtwPhAjMtMONadH5I8GpwYVliNo/kJEUjM1xvTwS0mWn0/9/otp5XGWV5iUrZA02YvHOF5cGtWmJsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeBcLBmniWNZyUThaqSA5QcCjoSx3g6oBK51X0m9XVU=;
 b=yWfKBTf7tZeQG9KBMXdfQLWqXZf1yhoBkSUMqJNNMngzfwj5ZlPyYbomo0IMzRRFWjXdBR32g2sRqSPvS5jnLX+un35C0USEIZeUe6Z5o41MdppNUPWDLJAVGT74M3rbH3+CzSYGrCY5hOsvF+b/VQp/yMypccqVskx3gBsIxaqHGoHaXgW/IrACKyo5LqiSLhDH+UX3mH325POQGJd4EETUZXusbTDBvY/NBodVg0gCnqy3JXHXHUUjwqdzq/QkitK8ANUBfsd0WUyPWTyUOldWxh3SvByfz5YClqSEuRt5jVW3d/Sk7IPKbBQPVaIn7os6sseo4uchYArQyk3QQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeBcLBmniWNZyUThaqSA5QcCjoSx3g6oBK51X0m9XVU=;
 b=WpezOtRF+6POvZuM9mFVOgrqHoGBiHfDULLgXBrVuGfTmF+u/RRcA6rwQemqNJjlIa3TQ9n2McxvtpNj6u7SRdargHX0a5bNCw9A0mmeR9B/EnO8UZExRQt1OMj5BD/e3uu56jiGfzUMibaIGQdir3XJ1p2dqGfhivQ4rA9wyScqWHNRHRzGsS/NPm9qrNX7FW2TH2ZZ8BLoGNJsm1vz///YZv+9fNfB1FlfiA98zpze8CshzgJv/W3t7bF8TSkZ3bs4lGVtWvWZoaiYHjikRsJy/fZ4AhKPM0zlxBpuVSuatOSocf7M6A3gHM6PH2sSNsTWJAik3+Wb6SPzmrUFzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Sun, 27 Jul
 2025 16:25:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8964.024; Sun, 27 Jul 2025
 16:25:03 +0000
Date: Sun, 27 Jul 2025 13:25:01 -0300
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
Message-ID: <20250727162501.GD7551@nvidia.com>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
 <20250704154342.GN1410929@nvidia.com>
 <aIAJfYMKYKyZZRqx@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIAJfYMKYKyZZRqx@Asurada-Nvidia>
X-ClientProxiedBy: YT4P288CA0057.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e08fd8-9393-4b19-30f4-08ddcd2a240c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+yti0xcL4+zIPn8Kgzbebb+0qGnDBZzw1UbI1lwUuCpmcvNsScQu/r6qeTnq?=
 =?us-ascii?Q?6RJxDcR/Erkrlx5WtGT4B3q/MjWcBGgxYn5ykrQfFlOCljbZBqxt043HxvX5?=
 =?us-ascii?Q?uYJBHTg/VzPPWaJ3ucB2kDb87kJoUG58JIsvTyneU6HtrWxMYhHuMdGhx/Bw?=
 =?us-ascii?Q?LUJXWVBKM8+xkIkbRdU4wW59TOFMDnN6zU1aP9/+wYNpZCF4IOvRoL2zux5B?=
 =?us-ascii?Q?BljN9u1v26fZGwEqpnxhhRPYozl/MTzXNs4f9ewFaou1XMQwjMHq8PTDMpg+?=
 =?us-ascii?Q?M0rQzac2Ldo8mn5weJ6/GGJno1blE/Dco9IOhSx9DUILA/f4pweqi1kKeUpA?=
 =?us-ascii?Q?JVlNdNg3a2IDhkgDND+KLOKruhVN7rMRD80Ux5a3GCfj4EAwJn+3omWAu60o?=
 =?us-ascii?Q?MeVHlKj49KrnW8j0jQkkCOYWUffa31sdawAYcLh0tNkARdF8lazPB3yAug0l?=
 =?us-ascii?Q?9lcb494bbWFsXpC13NT0XBIGkzZljlzn9SdwpJ+eqkz0TUBLpLb1bJ9IqiPX?=
 =?us-ascii?Q?v9xxTyjKYUsdxFdjaGN5Bm507XmJ4F/AKlQxX7NLI1TKhRtthC65ibu+pS1V?=
 =?us-ascii?Q?X8DH6W9AL6XhHssqr6hHsy2eBK4tkGYPlXVvyB1XDeBIz17H2YBPe0zMabM8?=
 =?us-ascii?Q?zBua3a2jEjasBKafNoGC4yxa5ENcfqkg5HAfo94NuMgLrzCbH7vf9GkZaxNf?=
 =?us-ascii?Q?J7r5FAlA7nZnouXoqvuwTJ/uNsGwr9IeDKex70jZIWObqkqDtrpDwnlVUSt2?=
 =?us-ascii?Q?c6pSnsy7mY8Yte5EgV+oHj1vWDFdtTlCM32T15VqHRZOhpZ9APMzEaWFEF4V?=
 =?us-ascii?Q?Y+pFAISDyKYh/VEFv1P1JewA1vGOGl3LKaU9yALWh3T7jhqkywn9AEOPVn67?=
 =?us-ascii?Q?fi+yoC9nN1d/h/SqHgFRFPz7SaCv7Rcqw6UwF17aH1DyzHl8gkyT0hCIUd5Y?=
 =?us-ascii?Q?ecVc7jynZgohXpn82jfB5hOFjE+6ocgNUEIstrgsHCRvlsEu0xTfPm+5gxEa?=
 =?us-ascii?Q?tG91lFopuQZYIC1LWShVid2eJhJ/CPxBeU5AgMeE0w36yvSqZ8XU/hsjX8zA?=
 =?us-ascii?Q?SdiEgmkv5yALMXY4Q6lI0XpMPnAGBbGXNQP+HhCe5WbktTjyt4kUvh21VAzF?=
 =?us-ascii?Q?VlNLwknsYz2+EjWFT+FFP4Px3zJJN08N8g2N40E2vHRDMVL3lS5UkdwfRs/3?=
 =?us-ascii?Q?CC8IiLYcGk7+zfRvRsKaW1Tu64l1QKCY0XouKydJLnXSg31wC31zTlJW5h/t?=
 =?us-ascii?Q?B1ot7ioQtOxt+De72Exl6Qyvv7NwzT97dprqf65Jc+wq2Tsxc6PdMGEOm7B0?=
 =?us-ascii?Q?WubI/C37mkNDqQL4fWQK6wDiSowN9dJdUqF9oHc3CFC7HKyPOMr+lVdusMjf?=
 =?us-ascii?Q?D/32YrboJHGAi5+QnPYSg3lfXViHj38hM1lr2c/OCl1w98bZXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gR+QFk9i7n2eALnugIGKc29cr0gpe8IUFAXJUoPvCtFKf4Z0g5ggR4NhW/KU?=
 =?us-ascii?Q?3EhATK1bkDMqX/8F9m5KKXaWVyL60p4kNHmxaP+smM2ACl/opozmEPJjjomS?=
 =?us-ascii?Q?5rel5Vq9Ph+uRC2ce6bKbGxQxajf+1lgxXx8F9PhXYTtaSvcaJWwQKD/beag?=
 =?us-ascii?Q?omyMUHga5qan67dF1fdoSjY+YXD5Ululr9CNui6RH++efIXDdoKYs5J3bx+1?=
 =?us-ascii?Q?sdqfkBv/zBOp74CFynB37bSFav0To9U8UrF+IjRa1ANLG1QCcd0AnLepXgz4?=
 =?us-ascii?Q?Zt5CSme1jwIBiGO19xwFgmyOh7GMkBNHFcmbbUmJq/3bmznq9eunHndSKceQ?=
 =?us-ascii?Q?KPEB6LNmNNv8lxjV3EEuA6JqbAcMiKuFq5QZT7Z1DEc3EPxD9b8ybtHfVAcO?=
 =?us-ascii?Q?CoKyF7afr50letUmFrFv4vLXby2BSahrO6kF77YidGW4TkmMbFUHPzr7yNIa?=
 =?us-ascii?Q?Pfm0z8klLVEMrbgL7k5oOBVLRKeT/bv+0qfEm3Tz6Z4NzYarRfgoi5MjCx5+?=
 =?us-ascii?Q?seJIa1bRC2JltOlrxbGdSwBTCPOn/GcD/2+gZesgZfGFr5/jeTUXqJcv7hl2?=
 =?us-ascii?Q?ly2vth3hsx3kNVmjJd6aT2kUWLG8Cr2+yJRUoghaUBubRt4+aAYTdib5h86n?=
 =?us-ascii?Q?8V8ZeBvoiqjxru808T4BjE/gAUB/NWDbqisgBWLgFaUN+wgeXGqkJorWRg+i?=
 =?us-ascii?Q?gVvY2F2x1c+E4rUMJJ3UjZslP4haXD7bXfmzUdjjTnj93qExhVR97bUyDyQO?=
 =?us-ascii?Q?WPq8mlvJAiTlfG333hdsgza370ojsTHVTtG8q1ZTf/q7icc4Rx8RShtX1mOx?=
 =?us-ascii?Q?GACRJATs2huk3meVQXnFTO4oVoHc1vzUhVrXjA4qQnm5P8yPcmDnRxvheKvi?=
 =?us-ascii?Q?Xk4dq6cz2KhNl9NAFfdQSA1SJUJud3EGI+QW9L52mfNACB9/1MrdyfPcxhit?=
 =?us-ascii?Q?jdSGW5FBPcX7onRfWV3dAf07qPOYwVAeueN+w8ZKRdBzTWl1N0ZTWoYFodtK?=
 =?us-ascii?Q?ik5/PEt26ZVe13nWQMWFkvIfrOWUoG4W2vgkI0IruljBi+eEW1MupuLvjWON?=
 =?us-ascii?Q?itptOAGk2lsqsrcWP2UXY1Iv2W1ZTaPtnhkS01TtAhYqiadFW8nImhV6AlDm?=
 =?us-ascii?Q?iyZeZ+Dh0kzs06uhrMl21Xfprw4HRyO4/mLzy6FixitohPd/G8R0WRtHWuO3?=
 =?us-ascii?Q?9QX75Oi6PJ67pdQs3wwD15kheRxb2anCoUNmZO1mtyS2XxU3r4vht+ASH3nJ?=
 =?us-ascii?Q?yVLPa1+V6+pwKu9NW1lKsPPz7hmkVy80MnGK1P1irIodurbUiA8RbciEucEo?=
 =?us-ascii?Q?0xa63thXj3TOPo63xWxdDYYlZ9TZyw5JFSCWxghRssDhhkkgcaASczGS/49z?=
 =?us-ascii?Q?BwPTuBhHyxWihzUOaplIEFsadolCRh2Ul85RR3IZ301xe4/oAl+fE4r5Wayy?=
 =?us-ascii?Q?nVkB8BWzG0W59MXWOlb1FvngF7Ham5/iMHfL/2m4L8/g5LM1nIozULxfIxPo?=
 =?us-ascii?Q?uCyCcUB5/wl3vl+eeJvSrRb39t/XK4m3I3ILP82pR5r89N3Jas0UHoM5zJOu?=
 =?us-ascii?Q?tEJvYM5VxDfRqV+J6G4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e08fd8-9393-4b19-30f4-08ddcd2a240c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2025 16:25:03.6487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JMX5kmVJ8/ZpXyPWRl2AKL+IEMhUBnAsBl7m8oaB4gx+QwJWgrLFjHOltruxA6S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739

On Tue, Jul 22, 2025 at 02:58:21PM -0700, Nicolin Chen wrote:
> > /*
> >  * This is called on the dma mapping fast path so avoid locking. This
> >  * is racy, but we have an expectation that the driver will setup its
> >  * DMAs inside probe while still single threaded to avoid racing.
> >  */
> > if (dev->iommu && !READ_ONCE(dev->iommu->attach_deferred))
> 
> This triggers a build error as attach_deferred is a bit-field. So I
> am changing it from "u32 attach_deferred:1" to "bool" for this.

Bleck, that seems undesirable.

> And, to keep the original logic, I think it should be:
> 	if (!dev->iommu || !READ_ONCE(dev->iommu->attach_deferred))

That doesn't seem right, if there is no iommu by the time a driver is
probed there never will be an iommu and this device should be running
in direct mode only.

> > And of course it is already quite crazy to be doing FLR during a
> > device probe so this is not a realistic scenario.
> 
> Hmm, I am not sure about that, as I see iommu_deferred_attach() get
> mostly invoked by a dma_alloc() or even a dma_map(). So, this might
> not be confined to a device probe?

Once you do deferred_attach the first time it is done and won't have
any further impact. So long as the dev->iommu->attach_deferred guards
any changes to domains it is unlikely to be racing with FLR.

> > Either ignore this condition with the rational that we are about to
> > reset it so it doesn't matter, or we need to establish a new paging
> > domain for isolation purposes that has the RMR setup.
> 
> Ah, you are right. ARM MSI in a VM uses RMR and sets this.
> 
> But does it also raise a question that a VM having RMR can't use
> the blocked_domain, as __iommu_device_set_domain() has the exact
> same check rejecting blocked_domain? Not sure if there would be
> some unintended consequnce though...

Sounds like it needs some sorting out.. For the purposes of FLR I
think the blocked domain is OK, so maybe just move some of those
checks around?

Jason

