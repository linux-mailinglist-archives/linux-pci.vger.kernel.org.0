Return-Path: <linux-pci+bounces-34118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D99B28689
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 21:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD390AA7CD3
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 19:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF57B31770F;
	Fri, 15 Aug 2025 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D8h8nAWJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4545C26AE4;
	Fri, 15 Aug 2025 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287165; cv=fail; b=jDqJRdEStxpCAN/D6L+/ZmzF4ZtAWDUPg/DmtV82Tn+WMDJuCFpRlAsV+i1PFdGeRG15e8IRZjGcwFOmWRUNTAKr3G3UbcsNBheDxdIBmim57szWUIElu/qgh4C2c6x2BookDM5jmxudwjOuS9YE+o+bBsWhqOczWKMeLdtNAUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287165; c=relaxed/simple;
	bh=2IPy5j1tCVy2eAbbls0tE7GRgQ73Pq2qYHkKH/yGgBQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDVxGbSgfNbwaeMagNlW25KA2j/BQdweGZvC1EnXB5nH0yEdkaKDVD7Fg3ru8F15uefCWUG1bGgc/wHILenQ0lxMSe1dHRBlGa/FV8BBsvHtL9CsyaYfKabNFaPzeF97QkR2oC5UzQxqVOp6I11v3yOpL5SIAc9IvCPfSmBQaGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D8h8nAWJ; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uL+Qe7zlWkPFW2SgbZ3d9LPDRsBkkLv0BhiJ3vTkR+RL4Mnup9xGAQtO7/inyLVizHrblrxLTOs/ZkvHUaqBoC/5+U9hMqzFhbP6/XSUTAR6iO4dgN6T8zEWQ0FAp5Urrjc38VoUwrzQpEpinTBJRf6eesjvRQ60kGVJQ/7/LXquG9QvXugQfMQAlMiqvpkJIsjITEt6xzC0B2lttYNw0jGJUe/yon9bvQ4k/hR/7DEWEPcAgZu1Yt6SF7EYyl6v2WN008uWhFjsDTZHy4rFTkPCbDtA0qJkKiYRUj3Ubmul8HUoP81+WPAA7tx2+aPz4iD4FQ4Erq74uwv3nlTPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZigNVyEbOQ0OEmLtrDEOXgLoyHDhxeWzkkmyOwEBSw=;
 b=tKgPulK8L/yVlxf201ye3tGDpSrIpLB81MeB+BCP6wp47uZkj6Q1xLCq3MfVU5/Cqko1E57Wp88QNAJOw+lKeyuH1eebYL75cLi8XP+ryv7BCkt19i8e3o2cMhlrgZME32uRR1QBFoKS/DhTaQkY+p7xECiLCCwXpFxzBcQH6RZft41Frl+h7NA0n2ziI4eBxucaGwOr3fDMXDsnRSeI4dswcbqcRkeJ7hAIcrDKSnPKoHzK7ndCDyyfM8oHX+hFg/hA8264PEYmUoGwsxrUNRlpkP1vF9Ruo4/qtIut/6KOzB7gqzW0jreiHjB/wO/ZSO7wNOleE/6wYvuQ8Lt3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZigNVyEbOQ0OEmLtrDEOXgLoyHDhxeWzkkmyOwEBSw=;
 b=D8h8nAWJXkq7MnaHQ7kJ+iQQW+CR/kds09G6et8P+n5ZpLMMQWwPRGxZjINhI7jyhaV/K8HxMMgOD2+Uv8Ctc2iV1mvm7144SzBiP5Gf0mPVheYGybVSVfTedywBhrW6JTpBBFS4WPLRt49jXwKl9Gy1eMtWcTc4Z7/bX7hQMUKsVldtpH6i3pkWFw97oHI9f0agSVlx2v0xozEcnVjXhpQhJaqqur5F1NTFJktvkZ99K9vbEwfXDaT4xB8p6jS23084vfKs1Q4w42LnPdwXZE1yAA58R95yPkVGq1n+9nibqFtEehnF6Z9SnDAX6N2q5jleBKVslIaL3wQkVAVtFQ==
Received: from BL1P223CA0044.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::17)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 15 Aug
 2025 19:45:58 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::37) by BL1P223CA0044.outlook.office365.com
 (2603:10b6:208:5b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Fri,
 15 Aug 2025 19:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 15 Aug 2025 19:45:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 12:45:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 12:45:36 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 15 Aug 2025 12:45:34 -0700
Date: Fri, 15 Aug 2025 12:45:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"yong.wu@mediatek.com" <yong.wu@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Jaroszynski, Piotr" <pjaroszynski@nvidia.com>,
	"Sethi, Vikram" <vsethi@nvidia.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "etzhao1900@gmail.com" <etzhao1900@gmail.com>
Subject: Re: [PATCH v3 4/5] iommu: Introduce iommu_dev_reset_prepare() and
 iommu_dev_reset_done()
Message-ID: <aJ+OXcxBiLtZxRJF@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <5ba556fc54777853c499186f494f3411d7a4a5a9.1754952762.git.nicolinc@nvidia.com>
 <BN9PR11MB52766E1F39D3C239F046CEA28C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52766E1F39D3C239F046CEA28C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 619c9f34-117f-4fc2-6d4c-08dddc345b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J5LKjZ/wdCX4KVGI6qoXDjf+/Fp92pA/7Qjljreyk8lA9KdYy9s2MgjwOQ+7?=
 =?us-ascii?Q?OS2GPYLu9U/CWWtSz6GiKZegmQM7OGY4Xno8DeKc2ixL0UW2G/rjZ4bPlEq3?=
 =?us-ascii?Q?PLGqw3QMhkjs2Yu9D6VkJxrD9Re8aL2N35jXWXn7XQ++M7lLDRTiyexOxg/A?=
 =?us-ascii?Q?OzdsDS8fpMQpaduj6LhN4jXG1aLAzUeJIVgV5hebK1sFdnkkITrMyWsJ5tHM?=
 =?us-ascii?Q?1dmOgaRJ7p3AXKGfxu9suIubZqihy0cfMSaWxh9uRThAHYgWsalFHsWIlamT?=
 =?us-ascii?Q?aAl+vZMTVKriywEeQ6XMJgnHqIkrXd2ysJCQe4nXuP+DLuqljvxpqvzA6TkX?=
 =?us-ascii?Q?4dCYzZm/Zi0OtkwtxeZdWmwEkf/Fw/1GndjUItJInGos5nsFsChgfWlQNGaR?=
 =?us-ascii?Q?tLj+aVBFNQYoPtqwF7X9AMHv6vaH+XMg8pLIoGFExA6VxIDeJD2Ne5u5jOhp?=
 =?us-ascii?Q?RrXvmCJFfZrBvDWXYR1u4Zb8Ksy2le8BS0vGnHSBdevXlkRkTvVJvms9Mum7?=
 =?us-ascii?Q?dKwUl/Rwgo93VkdqnYtu14TkgwmAFOGvmVTPu6zuFc4DwMrJ10iT+uaNqQuR?=
 =?us-ascii?Q?iP3jgADCkYhNTWrA2PWPOlKEHIclEYL9cJMI64mKcGV0SWZpWXe3V+W/kD8/?=
 =?us-ascii?Q?Metpw4W7HhvveKtLJKD6NKvF8/ixiMhfMjSzxjllvZ/RgcZlQkMlwSp0mOxd?=
 =?us-ascii?Q?D3WZFaW4c19ABF6KpymhlfUZjAMU801x8RHbMsw8txhQUj5ntcijB1bbdGlv?=
 =?us-ascii?Q?VMe9CZKDAArLv7pXPNkunBDa6Qi/NgJaklZcRNB2luxa/wjhkbcAmWuqQkSk?=
 =?us-ascii?Q?KC1tfg4k6KcHNRhlkzsBOKLniPaHp6KbeOgCu8R5RxJRUR8ptFQZgdyVooJS?=
 =?us-ascii?Q?bFhFLLZ4Nc2FeOsMOzzZ0DGcgHGx159fo16NnXf71UWAUAhZX3trMMd//bta?=
 =?us-ascii?Q?RO9equO6xOdYlkfguHgFQvvG9b3HVxE7fOtfruFhcv2dDg9G3wmryBPHRr4Y?=
 =?us-ascii?Q?HWAGNIcieEBm5dHDliDGgkLQ4gofP7X5gifyZNOXXE12w8ujMV8/axT4GXfU?=
 =?us-ascii?Q?+ciVui7C0b4rrJsz2mUD1c5vfrHn9TjqUbw7m7kiWX8QoHQlBk7ug+mCb6p+?=
 =?us-ascii?Q?au+yBNrV+uYf3y5Jb1Lfg6A6eb5dfOjkt4UWZk8ZV5MLlyp1VPBVMXogiYot?=
 =?us-ascii?Q?4FQOSMjxUYv2r8ErML4bttAqcdZgmRPF76h1j4Zz8/ODjlmxP0TM5XA7a6Uc?=
 =?us-ascii?Q?der6VO6mgG5RzaieROwUjqTF6HXV1Vvugfmpk/l0Yxk84+5OeDrYj8ZS72Uq?=
 =?us-ascii?Q?wvHFD28fiSQwTAdZ+7xaWwP1lPmA7HwTCf28tcOvzw6GFE787JadPp4RgXhY?=
 =?us-ascii?Q?+eK0msLjadJRwcxNECdVD3wnaGIm2LV4eAtY+GxVeHd59bYzRm7DiDZZwrt2?=
 =?us-ascii?Q?wnFsvIrKyS7yPk8OJTmDVHAlVX5GkU9d7gBSvyRNdShg5xU+1d6cCcPiNb5P?=
 =?us-ascii?Q?g+8k8lE1MHfGnqQnYCqHinJV8L9Kc8Xno7t/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 19:45:58.1715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 619c9f34-117f-4fc2-6d4c-08dddc345b40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374

On Fri, Aug 15, 2025 at 09:14:28AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, August 12, 2025 6:59 AM
> > 
> [...]
> > However, if there is a domain attachment/replacement happening during an
> > ongoing reset, ATS routines may be re-activated between the two function
> > calls. So, introduce a new pending_reset flag in group_device to defer an
> > attachment during a reset, allowing iommu core to cache target domains in
> > the SW level while bypassing the driver. The iommu_dev_reset_done() will
> > re-attach these soft-attached domains, once the device reset is finished.
> 
> attach could fail e.g. when device and domain are incompatible. This
> deferred attach (until reset done) makes compatibility check impossible in
> the resetting window, given the driver attach_dev callback is not called 
> in the normal attach path.
> 
> Worse..

Ah, that's a good point! I missed that one..

> > +	/* Shift RID domain back to group->domain */
> > +	if (group->domain != group->blocking_domain)
> > +		WARN_ON(__iommu_attach_device(group->domain, dev));
> 
> ..means that an user could trigger WARN_ON() easily if he knows an attach
> would fail.
> 
> IMHO we may just fail attach request in the resetting window then
> WARN_ON above makes sense as it's shifting back to a domain which was 
> originally attached to the resetting device.
>
> Not sure any valid case where one would want to attach/replace domain
> for a resetting device...

It would feel odd to me, if that could happen. So, failing it with
-EBUSY sounds plausible to me.

Thanks!
Nicolin

