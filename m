Return-Path: <linux-pci+bounces-9934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182B592A4E1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 16:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD3AB20CD2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC751C06;
	Mon,  8 Jul 2024 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L7KDJzOy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B62744C;
	Mon,  8 Jul 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449563; cv=fail; b=Ss1WB0daQFpYZ/fG+Oapfn8ilmRRUhVVwg2dBK1B7yzeTHhQbPhqlS+7IQhO663NqMAyXaRLN34sxOCgHDST9q48lTDkEqeoSriStt/lnXEAmtE06ULd7eGyJs6wweaapPolBjqdo09f1CsvsnX7nnvRS1rdxYT+PcgHg3v/ZkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449563; c=relaxed/simple;
	bh=yn1CB74pCcuSj5r/VhuinitdLp+gkkL8+kaVx1PsaQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B7Q3cXTV+TJNUSg0RRvn28CGr8onh254KNszCa2GgNkN3rZlhs4JCa9lFnMQjIaWL6vcEViqnWGbuCm6IjGA1ynXG3EYthUTcwgsisunlNEUC48SICZDSac0yYVLzpHXy1Wya4gAOAzVu6txsCZxLd2HBn2MUItBxkuk0UScxeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L7KDJzOy; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqwEQe0+qw2RPhQGPnjnZQhiODX/KESAIqwOnIVUuRkD43K4Z9NTFxZcDdnGB3bkX5u6KLDKPO2OdZwcf98X50ev50piTICPLdxn8VhW/qG/AbxouwJAsU81kqh9Z9aRDOBuMpgQkZFQTvwHg9g7sqH9gKE5gQ9uOq9+p9uqb6a3VUqO8AWeQFSD9hZwGtRDkCT4JUnmxbpKva+uHjOY5orWZ+CkNO/lWua+6KYLHamCQXCTGWa1ECTiGQ8mIP/9Q+qgdHR+ng6FDxQE34+YJQ68Emecnlu6yp/LMWWSg6QwuFl+tfXzNN500rw/VhYeGOtmkPIvIW0ZsO1jyt3PVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6+3GFkuUMAVB3rmIGMNGeDxOjg8vfXv4k7kokRhpxg=;
 b=Lq57hLeUtZPbFeWGGpZE8+9noc+bMLso2aI7G1eAdHgBEQ7xt6S2G5exlghiamedySdEhguQNX2rJOyoSKtdI9XH/Qu5YQzjm+bf7iTj1Ei0OByfZ/P7YcdH8CMtIykSIHrYyim0sW1BhjEKpZeBN9/2NcCj6IkD+RQ/WtLK89fZ+3KdvQ2IA4gsVkntJ6wsu9qncfYfakCfl3uBxZefiqfgib7gtQcVgXpW83e139EZPEFov9p7FFSy9wOLn7kPpxie20u9So30JOMvjzeKthWJe72hscF7cp9mXjEg/H5a2PV66Oj3Nk6ylDyRFe8ryauA3eDwkuGpAzgkKbY8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6+3GFkuUMAVB3rmIGMNGeDxOjg8vfXv4k7kokRhpxg=;
 b=L7KDJzOyatbn4QRS86xd7Ks+UHxClg76ZG7ggwCJbXdGrGhjWE1qHN0GD87yW6oCSwy9edIm/nwy9FECItx9fDqBYa1plpB0UHpFvYCpng0ZNyqTYtDq1lmOIeC7W7ZbPUxqhEGwSdeMAUhNQvNwHCnsNeHdoUhoJUhQLf88tnT4W5AsY47y+xSkKnjdthsqhO43gX+2BLKcvQaB+a1g+YV02+RFYY0o7jnfzv+MKLhhs5wHOBNH/78FkYoqbnY7lV9DNnIRZmcmCoyF8wb9heK6m3QRSsVzdFb1+j2TDqS6f9WcpCwoM0A7qAa8dio2HOnBOPmSZQxyQJbCMfdaSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:39:17 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 14:39:17 +0000
Date: Mon, 8 Jul 2024 11:39:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vidya Sagar <vidyas@nvidia.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Cc: corbet@lwn.net, bhelgaas@google.com, galshalom@nvidia.com,
	leonro@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com,
	mmoshrefjava@nvidia.com, shahafs@nvidia.com, vsethi@nvidia.com,
	sdonthineni@nvidia.com, jan@nvidia.com, tdave@nvidia.com,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: Extend ACS configurability
Message-ID: <20240708143915.GF14004@nvidia.com>
References: <20240523063528.199908-1-vidyas@nvidia.com>
 <20240625153150.159310-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625153150.159310-1-vidyas@nvidia.com>
X-ClientProxiedBy: BL0PR0102CA0030.prod.exchangelabs.com
 (2603:10b6:207:18::43) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: d25f8b7e-6af7-49f4-0575-08dc9f5bbeb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?psXaDcIHOVlN4uhV5CaBHIW0aaDB6KPx+zy+j4/zZqsj0bvcytnzu4JhwR0x?=
 =?us-ascii?Q?7Eaqj8QB7GAzPHpssp593+a97YYQIXePknWWAhzVLP3LhsOICrm4cP+OZIal?=
 =?us-ascii?Q?OcWUOr8C8gyHvVwrv9/U/Dh8hU2Y+sLs1q16a1OBv9AKATd+pu8HUQsnBbLe?=
 =?us-ascii?Q?oiNatw9+13099f+opBhkUmF83/i7ZIYIAX9tte2LLrKzWqmUDccu7SvsqgNL?=
 =?us-ascii?Q?R0IR59TH6pvt9DQLNxC7yjaxmU2/3LkM6tNazsmCRuIxzD3Nd+7XTSR+pMXi?=
 =?us-ascii?Q?iexHYM0Uodd38nhaI8JsNPFmn6eEAgrnUw9SB/ZgXngRNMpOtbq3xWqOEt5V?=
 =?us-ascii?Q?D5hXWUMr5CcJY6/2CIllX0D4hSE57QA3VVxKzCx/dPs/KNdvtoLGyvAU4WW8?=
 =?us-ascii?Q?cGs4kWaSlGcYLYazgdumIz7Qk+/GXDuaodQ5Y1iIkOVqixLULGSfg6IJvQpk?=
 =?us-ascii?Q?ErY4v+jvFvcHUDxHFS48yojNajCfK4L3iyHqZSowEI/N92sMf/0br9nk35XL?=
 =?us-ascii?Q?BPx2aNJraBvi0vsXJSjrTZLN+kz/H3Eehf20SgVIGAiJzPqnWjb8jO1Bi7u0?=
 =?us-ascii?Q?FhKZslr8KWOemYT738yPIyQvE3GgAwZthS9Enua/j1jhROX5ct14RCVAxCjl?=
 =?us-ascii?Q?PGsqZFIfpG0I+jh3E6WuACcPdnzt8VMNsUDP/jS4AX/8e/wnxdObS1ufKfG7?=
 =?us-ascii?Q?NLP0viSPC9octFHAl9XJOVu1soc0QbJt+RnnCBIJhkANTC6IDQ+XbkGkfWrh?=
 =?us-ascii?Q?gz01+6eHK9fMHEbmmQBfeDft0gJFZfhuIKUOAPhWnTUWVMEbIqbfqEKao/Uy?=
 =?us-ascii?Q?+3Dl/7c3upY0py1aklm4uWWDuIiKq8gSZ8IcTU7LjIS5ikrowV4V9GTkzof2?=
 =?us-ascii?Q?dqCos3iDFR4vQUtbrS9lLjFEFQ3Wkl4QGgzDQev4ArYIXcy90VbXBXwWg49V?=
 =?us-ascii?Q?/ekcBKIeXCADEgrgSWuhRrs7UXcwkpby7Co1xj+DwqSrfsFux6TaR7Iuhe0t?=
 =?us-ascii?Q?2ebDOCMfJLwDvosjR1XRj90jn93++/HdtLD9K4W1c59JwLx69rWLFM75DQOX?=
 =?us-ascii?Q?cyH7bJXZf0zlFcsbD+kDIZt6/gdNbq+xvC06YRe5jwXDTPqMul86Wh+zYXwo?=
 =?us-ascii?Q?IM2dX7o2aHAwkbi1b0EUlbmL737TVDqZ4LJsT8EaD1HAKkmgaqeXinuksKbg?=
 =?us-ascii?Q?ldjxq7wDgZLi8WN8M0z47qiByxfoa/HpipTKquuSHcyQGvgUAh3VjSvHDF4L?=
 =?us-ascii?Q?N3u2lGaVkjuy0oVCphKDORW1csa6PTSrLI5jH3TSGTFZj34fMu5HTh7ussCS?=
 =?us-ascii?Q?hkmtxq+F8kjXwjnXNzx9OBB3j2a3uW4LkftKzehvhvzAGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hWC1azDVx10MkIcMI3D4Tk9MwKxqkbtmT7NrxWRyY+NGz7dqIrFqzNZihwMm?=
 =?us-ascii?Q?EzRdQDQeviUdvtWcjwWLOuqmgUap5iYpGiJnRI3SVGKA1yJA7U1tyg+38M8M?=
 =?us-ascii?Q?08u3XU1tpa1z6I8KFRXb0epxXrqLNxxtJC8p2JctKbmmrm3sQaW8X1IT1h7A?=
 =?us-ascii?Q?Dep80vUd262Tf7DVMZcD+JLbZitSZjrEf2PXaC5mUGCyt4qyC6xM+2quvqsq?=
 =?us-ascii?Q?IwtB6aysQET6xFWWs7ONdbP8WhGfGiseAjtDM+lKQs4cUwHJ4gbqsfx4Fivn?=
 =?us-ascii?Q?s8qmUuBmF7TWEbZa+QCF+vjnd1SahRz4XTLEvn505zfAB2bnWiIiTjg1coh8?=
 =?us-ascii?Q?NP2PYiYTiT9D7KISSnLSXKrhzZr5lPYGv0ky7lV36kBoC9HVjgVMmZfbTkvH?=
 =?us-ascii?Q?BJSQu9zyOngIOycJsRFYRSbA8t5LxVizDXs+rU31PJyMkkVJG11zKeHiWs2P?=
 =?us-ascii?Q?qFmdCrDZrsWZE/Qb6VeKE+sUZl7OboXvbWuxUPG13zjmO2GHgypMgjXE4ua9?=
 =?us-ascii?Q?+f/Jyd++pNRI7NPbZ75wjoVpMbwaZT0uJGI3R2YdgYCt3slt/kvfWA3OYAgc?=
 =?us-ascii?Q?gAKYGLFGpZpkZqye4Sdup51MkUnXwqHwIYGx4YskYkIAuKSRLDGlaOou7ZIG?=
 =?us-ascii?Q?+AbV6kpz2DlIUxJxyC5YYLaDarmsV7BR4yYTBbvOfGTqI+Xv1uxvm4l8Oddt?=
 =?us-ascii?Q?JEIK0vVA4PTPK8WLxd+nPg8OTWkoViuXQYPbTyS84iI8msPWw4QTRPgTVocs?=
 =?us-ascii?Q?8/GJMy3AGrI3ijc8KdkHd049YEjkdUuBWyt/UD/BHDw854AZykSVyvz1Y2NY?=
 =?us-ascii?Q?3oCZo5ASJF67HFoMcKvnFW+qHk3MhMQI/y3yLUaDXYiceTIbebSbe56aY9i8?=
 =?us-ascii?Q?vB9Eng0YWKlmBNq3zuVCtbqfvYHpPIiFP+k1NTgnjb/CgYsh+FHPg/9HcwHD?=
 =?us-ascii?Q?xHRAXiYpadcBaaY8B3G+eZ5wQFdfbbz6FdBUa+uFd6UAIMTImAnKuMU+mP0x?=
 =?us-ascii?Q?VvMoki5rA5DJXTSqPVFZNv8zlnOSRJtF2W8SzqbQ7oKqQEYqHlmKVVsT7SG5?=
 =?us-ascii?Q?vvsycvQcVjAzrGOmCnt3Ih63SeA5/zOsLz/QWI/H9Hu06XXDztyy7eW2N3QT?=
 =?us-ascii?Q?90nyU0Pz1mLOcw1S/aVr7qKDYdvChOJDtSerO+YPfRiaOEy4O8uReXYKu1ou?=
 =?us-ascii?Q?U0j/pHBCZj94ddixJupVyaEK09xjo5yzy5q1roVcS2iXtYL9MPQOM8XCKSAO?=
 =?us-ascii?Q?e7avKNQmxtqxAdsfSYGQlZHQ/wwWSM3TLg2jGRkRpelaE8w575eYrzzO04tI?=
 =?us-ascii?Q?Wlo6QUdgFJ0vubAmqgpvYP03s3ZDi3lXogEe26UTaHo8CDr16fYe2pGicnob?=
 =?us-ascii?Q?uqWGsH0B5rQ5xTtT9ftebaj7/LzsCqC9buVR2A1NjzHX+pN56m4Jlzbsbfu5?=
 =?us-ascii?Q?usla7EAfaWTF9kJIhAIGfUCua2m0rFsCtm3g0emq3hSEasalj2bCeJ6qEH85?=
 =?us-ascii?Q?HA2EcS+Zvs0sQ42a/FvVi9Cfp2NyHsrhMMQj6BnlSZ6GxhEiW9542POBfGV3?=
 =?us-ascii?Q?Qk9c4fFnT/RJ644FVYeTBKVukNazfk8CzyfFQhNc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25f8b7e-6af7-49f4-0575-08dc9f5bbeb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:39:17.2197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0Nt4FRjh2hQPFD9rNTV92Y+7GPHllIBbBQYb+34xzefjnTA1ndb1H3Yz8G+aohd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916

On Tue, Jun 25, 2024 at 09:01:50PM +0530, Vidya Sagar wrote:
> PCIe ACS settings control the level of isolation and the possible P2P
> paths between devices. With greater isolation the kernel will create
> smaller iommu_groups and with less isolation there is more HW that
> can achieve P2P transfers. From a virtualization perspective all
> devices in the same iommu_group must be assigned to the same VM as
> they lack security isolation.
> 
> There is no way for the kernel to automatically know the correct
> ACS settings for any given system and workload. Existing command line
> options (ex:- disable_acs_redir) allow only for large scale change,
> disabling all isolation, but this is not sufficient for more complex cases.
> 
> Add a kernel command-line option 'config_acs' to directly control all the
> ACS bits for specific devices, which allows the operator to setup the
> right level of isolation to achieve the desired P2P configuration.
> The definition is future proof, when new ACS bits are added to the spec
> the open syntax can be extended.
> 
> ACS needs to be setup early in the kernel boot as the ACS settings
> effect how iommu_groups are formed. iommu_group formation is a one
> time event during initial device discovery, changing ACS bits after
> kernel boot can result in an inaccurate view of the iommu_groups
> compared to the current isolation configuration.
> 
> ACS applies to PCIe Downstream Ports and multi-function devices.
> The default ACS settings are strict and deny any direct traffic
> between two functions. This results in the smallest iommu_group the
> HW can support. Frequently these values result in slow or
> non-working P2PDMA.
> 
> ACS offers a range of security choices controlling how traffic is
> allowed to go directly between two devices. Some popular choices:
>   - Full prevention
>   - Translated requests can be direct, with various options
>   - Asymmetric direct traffic, A can reach B but not the reverse
>   - All traffic can be direct
> Along with some other less common ones for special topologies.
> 
> The intention is that this option would be used with expert knowledge
> of the HW capability and workload to achieve the desired
> configuration.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> v4:
> * Changed commit message (Courtesy: Jason) to provide more details
> 
> v3:
> * Fixed a documentation issue reported by kernel test bot
> 
> v2:
> * Refactored the code as per Jason's suggestion
> 
>  .../admin-guide/kernel-parameters.txt         |  22 +++
>  drivers/pci/pci.c                             | 148 +++++++++++-------
>  2 files changed, 112 insertions(+), 58 deletions(-)

Bjorn?

Jason

