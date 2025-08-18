Return-Path: <linux-pci+bounces-34198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE6AB2AB9D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 16:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619DD567A0D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 14:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138FA22D793;
	Mon, 18 Aug 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GxjOKLG+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7299C35A2BE;
	Mon, 18 Aug 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527997; cv=fail; b=G/ga1gHci/Bj1XGu13NUdW4gOjBbpdSRdTd8LUBXTbleFupqofkekZFbl0iu9CvWpd7bYbRGJSjXgDt2d97i/Ob4rr6fdO2aRzuy+sOMh0yeF4VTqhaaN56YSUVq6c8+tuXNndUmYD4JQlpGj+dpsvmlvz+F95I/qrsLaUEcZsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527997; c=relaxed/simple;
	bh=JgRmyxhEtkLEQ2XWSLhl94nbvmNc/JI43Wl/37L4V5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HB5FvpN+aSjpZwi3kOkFcKTckfIxywaVhZ8wAzlrgy8Fe1oYdkTzERH6proLjiDap9cKIH7ned2/wMoYCmedPjLtn/wI+kDpslPE4bkpiN1JThISzfABFvPhgoZk4+eyqxA+s1XC5BPYsk5fb5uAa612cI0Gjo0VN9Oh+3WpYG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GxjOKLG+; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeAO0yy/P7vyFvPapS62Mdixo0MEuQNIQcJymTBp9XgE3DBmMVm8IHteTHyLLJLogMnZk288gKlzx5q9xky+uxeJXkGkXy8AnWtBRjR4Mt+8LbeSYHEuT1/vHG1qg6WSWNeXm+RInfnZ9Pvy8wP9WOQhlR8R5pskuk7xSfMDroCkR2+ZRurJo/DlUV6LgbzMniBfD1ZGb7x2kEG1zSZrXoCaO5iiR8l8f0uWEkahD4PUDCArh9xo8OmzFLrKRlMYPWw59FAbpe4WIQ3YFZqc+PUQbOJTQ7KcNQA4ozbQY90zQ3g0sOx/n8CJQQFZslitSbZwifN3Jdm3KXJ3LNiHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AweLgKazAhLALAGyH9QZrKcgleQGcoxbR+3GhZmsf6A=;
 b=lZFM8z/x/5KbYx7+F+MdTlKg/tYOQzwhEFLqQy3fnTtz1rdaGCjlzfEIzR7Qx6GBUF6C9L5xG2Ua/xmTJTUwcx+ctDQBHnVf1VOiENOHYSZmO6Ry1Vkwrbc3A+kA3ZdkX0AYh0/4EddmAS6shzsuMwPVPPGNzqRIL0KQRamGKc7A24cWXvE3A4ZKNZPN3SSBRzHAzKSFsX/E8UCdQXR9NN+tujJtdCmVYIvhA05MGjeC9/A2pVu+jRR98G+a5ccpa2HRLUOpVXuDxWn6sMkA+Yjll8JTuySr75K5k81uKPJMU4NqjVNOYSy3+wEWO4UBEnbrkbndlyb/OnOkrM34tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AweLgKazAhLALAGyH9QZrKcgleQGcoxbR+3GhZmsf6A=;
 b=GxjOKLG+0L//xoZLSLbZctUg9nbJIprig4yFF2VZbJHOBuG5wH4GvmrsMOcb6/rHI9eUDBwhkmEad9eIKxcJOnQpbPr26lYqjnnV7RdX/vZLiYiVwi/Pa2Ln89DLGcLhiXz3Z5hEy634FRmS43mssPRCzzONKibFO0PoRbr/IlOu9xaSVehDJCTlHA6IMtCig38Us1FaZIUYfCp20hiLbfh6xVzBGxfqCCNZA9+WsbwfM659JStSIkrxWKt2N2uSoTq8uV7i8m8vZt2kLq241OEp0osHLnGFag742b3IxnEzBJ+pyjVh7/8aF46afghAx20phW4dD2hjm9LUhX07Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 14:39:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 14:39:52 +0000
Date: Mon, 18 Aug 2025 11:39:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	will@kernel.org, robin.clark@oss.qualcomm.com, yong.wu@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	rafael@kernel.org, lenb@kernel.org, kevin.tian@intel.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
	helgaas@kernel.org, etzhao1900@gmail.com
Subject: Re: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <20250818143949.GO802098@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BYAPR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::40) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9c7a53-20a3-4ecf-c8f2-08ddde651775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iWr+V0pK4Aqfa4wy7yyxnNk1teYaLXGtP1/PuNJbrWIlldI0mWzRNYqzRixK?=
 =?us-ascii?Q?PpKGXBPklwDXTak+UDTRBuKxPl6YSyMzA1rc8+fGTdTptWNdMfTSea4NDdgs?=
 =?us-ascii?Q?gmdWDluDHHmLqaAxaTZPlUG2JeHpJHm/fF9G0Ypp8pSUvadBpJtWiwRxTe7I?=
 =?us-ascii?Q?L26AIY7KLCnatiaJkFWrF3w+eoO2vmNaRKqOjP69wt/BVRIHM3klkwUz2Dr4?=
 =?us-ascii?Q?odn4hBeCvMK62xYPOjEdjMIdBl2JM7uceNN9PMbS4NHEfI60Cfv7AE4pX3Bk?=
 =?us-ascii?Q?6uCQMBUKmhAwslxsSQ6QkYDoB2tmK5Bw4T8kvcMvW0WoGEYrEiiUWDRQZf2f?=
 =?us-ascii?Q?+z+Ynulai8/wriq6zz5Bs0Ok/HfbB8T/4iSNSz8JcG2aNIR60cKcRs6GovqD?=
 =?us-ascii?Q?EF9v/TnDGu2ay1nFNM8qEPplyIEdughex23S9lYp/ArlqzGIODlgoPW5MRJA?=
 =?us-ascii?Q?eCQmho8HtiUGfW1R7Xwq2RRlyfoek1anxlaHrg2y63ZQebizCVyeugw/2iKq?=
 =?us-ascii?Q?AGiBAunjB+6Kbr6Ik9rnIrIYMgCXrkx11tVU5vIz8Pkqna9jju2+0h01jQcg?=
 =?us-ascii?Q?8Hvd5H5Z4gs7qJXXRNEhVGUaC10ZnArH8b/iu7sL5fdUobaW5eEwuh/8IHTQ?=
 =?us-ascii?Q?L96SAr9XfXKQTsH4YifR7Cimw5Kqna73DxWzb68F4Ndgj7EctvueE2CB/jQ0?=
 =?us-ascii?Q?SEmEBEd9uUI+lP/uLKJXTOYE+dSbwbCzh2+YDh3EAbQtyW4IuRe7STpXfiA7?=
 =?us-ascii?Q?3cmSMmW1eIimU/eBHYZCYmn8AnaupsT/h2sEecUInsF9xARtN6U6rTK9rcBR?=
 =?us-ascii?Q?23pyH8hghtk1eEojopV9DXmOFtwU2tlJOYfsoalHtqcw5W0H6B5g4ay8QQ6p?=
 =?us-ascii?Q?knfYCARfMb3dNows/DydkAKGVu738kW32QeG69n6zTbnklb+s0wDCe3LjgqJ?=
 =?us-ascii?Q?EkED2lG1Yu1qth0VRR33blQ27qQcnBbq4PWIhdCgLI+omSPP3QIdBuJN08zJ?=
 =?us-ascii?Q?H8UTLeQNK66ssXLMSTFEWnddww5tVF76YhlOOqsueWhCUYbtjuPji9gVN20t?=
 =?us-ascii?Q?CBmCOQsMLKtrDfKnW41FJo8B8NmW6cHZS0qOtuizL6jWUBsdtY0iAdPkWftU?=
 =?us-ascii?Q?8jp3CJZv5twcj3sUP6swwbX4bq2bNWO6vueWZLLXVKTV/hgG+/+eQP1h56Kq?=
 =?us-ascii?Q?Z0jjlkrm6HehQlU08ibGMJx1aII+pk8w16tkiruTYQzntKMkya18qXGUey00?=
 =?us-ascii?Q?KoH3Xp6BAZda72lgTe/PXOHT60GJktQmAxO1pg3atJdO6lfVZwn8qcfV63Kv?=
 =?us-ascii?Q?mwBwfYTEhpH62FvUNm24gnZh1tEeq7+J4VuM5NEQeNBWOu3a+EFfpOU5sDgF?=
 =?us-ascii?Q?AHVYdcYvRpp2PhmJNsNO0R7eBMTBvbDeS7yOCafJSJ0P8h895g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CD+evpHNlP42f6qShI+djiPoRvRnRMRlNN0Sj6ewq8zB/p6qeh9pRKlLHya+?=
 =?us-ascii?Q?rlcPHm3aS/3AniR2eSCoFh2uR5XFJ3XZuDTx43TGHsiUy7qIhwQqjQTCHcdz?=
 =?us-ascii?Q?cHbvlXjjj2pXwJEfvJTLhyOzg/rEfGuqJbD+TIZfkoAR+sw0iatEWXWnHvy1?=
 =?us-ascii?Q?vbYAdMkUAyXH3heqBEWR//pAOtBGqg6qb0FFRujqvpEsE5oOSYGo0UsDlZPK?=
 =?us-ascii?Q?V+6mcAPsdZrnipbXA/ZyrforrK3l2Vp3dxBlRqMBPrdFt+Kdi6ybvnyXtFJJ?=
 =?us-ascii?Q?+a6UgV9TPV8C79org5FY2W9D4qAyo02PEy4JHVunY8xgoG+JhQN92zTc+G6f?=
 =?us-ascii?Q?YopOTZbDrvGYjKfxVKlSI2Drru3Tt24oVxwuCYQecqmwio7f+4yvpICMkcaC?=
 =?us-ascii?Q?2+s9xbKL7eSkhG9HeSKcrL9VFLnl3coxW4ic92GpYCYtUYCSqKjgI4HYtf4R?=
 =?us-ascii?Q?yqcZmhkH9nu4wdqFxjQA07QquEgbxtPRddYip4s3C7i1kIboJagUfD9rf0Ei?=
 =?us-ascii?Q?kw4/SbUbLFuehtBu19QbV8fGm53w+LEeVx9s6XxYwJmfBvnfclY7oHz6Dryw?=
 =?us-ascii?Q?GI6bd9lG9GyxuOtjKoHSdog0HrifxZe4PErr0HvV17pNFNTNNNFYImvo7iOy?=
 =?us-ascii?Q?AlX4/zSJkUZlXPkp645t77SAWeIpHkuzKoVU/y1uuk3VuCjMpYu75hH5wWV4?=
 =?us-ascii?Q?Gn8wH0ulpiYd9bLeHt88Q82VexV7rmEk5iZ+pqLQyZzTPbYa4pmKrjx9B9da?=
 =?us-ascii?Q?oVULW/L1xP61pg7qV/qvK9UqV1rq5BM2GCTrx51OmjoeK/LR2CysfKf5xFTy?=
 =?us-ascii?Q?f60ApcS0z6r2qaAyIFjZa4r1T+nvZU3VP5g9u8KW/C1BQErMPOwFqOQDKxUC?=
 =?us-ascii?Q?W+4DuQT7Bme7puoC9yu+EO/qdLq3fOiwe+HhQPk0IOYnSMHCUSTXhlsV7g3w?=
 =?us-ascii?Q?lnyGVFAhVlOKtIjnXD7Ioufu+7Ypp/JovCsaiNx5CJIgX3JJXHsTY6MlsBFf?=
 =?us-ascii?Q?QvLnkJyTbIBUjXb6g484aTYdL7qxTtpcbu5KstihVV7K2Pk55XUePmZQgxkw?=
 =?us-ascii?Q?DDt+BgqIjSMYuOm73k9pH/xITMcrocv0NxOsWXk+DY1J3gKdwsNj7z9x536K?=
 =?us-ascii?Q?qjW9JMFB14IGzRvmdeNXkRuPPKUc5+hYwYXz1ZctnwBjUndGPvtSOWY1yhkg?=
 =?us-ascii?Q?XVnxggSWl4iLiNVvVmJe3wqo2SAZeR5Xih8u5l+eyKNa86Em2C8S5FV6c67N?=
 =?us-ascii?Q?Vf4nU9piN0veKWoSiErRN/ZZo3BO80ulNcIpdDgckPg7z89ljfDz+Q0aNIWu?=
 =?us-ascii?Q?YYB25tkZyaBvPoXYPxxOqMAHvBcZNSdZ1xBj1uqC3DBCYf/lmW7cz+SYRYv5?=
 =?us-ascii?Q?HiIdx8y5FLc/sDDt37uQ4i3397h/34EHmyB2RnYQYfh7X1pI8DimBDY5z3wN?=
 =?us-ascii?Q?y3XO+bU1PIMKPWww6ECfFCTj4Hh7mMvwBBwxwu5SaSj8xSlSplhQwqaxk9nz?=
 =?us-ascii?Q?R/mopgdkRNEmydZKaLPYqZ2p4mt2tvnc9l21dj9+DIolq3EIP458njMh0fyr?=
 =?us-ascii?Q?pJquWh4nn+CsUyeyj6qc9ne2xg40z8qvNtRRaa/c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9c7a53-20a3-4ecf-c8f2-08ddde651775
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:39:52.5706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljPGnCGyIA/hgLUj9EVSgCmg8EqeEnRh/b+y/OHem4th+CBx6BPbWZ5NuSbzp/sq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160

On Mon, Aug 11, 2025 at 03:59:10PM -0700, Nicolin Chen wrote:

> Introduce a new iommu_get_domain_for_dev_locked() helper to be used by
> those drivers in a context that is already under the protection of the
> group->mutex, e.g. those attach_dev callback functions. And roll out the
> new helper to all the existing IOMMU drivers.

I still don't much care for this, I think it would be better to
approach this problem by passing the old domain to the driver callback:

> @@ -390,7 +390,7 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
>  static int qcom_iommu_identity_attach(struct iommu_domain *identity_domain,
>  				      struct device *dev)
>  {
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct iommu_domain *domain = iommu_get_domain_for_dev_locked(dev);

Because this is a very common pattern in drivers.

Once that is done we can see what calls to iommu_get_domain_for_dev()
are even left, arguably we should be trying to eliminate this badly
locked thing...

Jason

