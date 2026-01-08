Return-Path: <linux-pci+bounces-44248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E12E6D00DFE
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 04:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 277D8304A5BC
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 03:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072022773F9;
	Thu,  8 Jan 2026 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CPpqKLOT"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC42773DA;
	Thu,  8 Jan 2026 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842906; cv=fail; b=BXQGwy0dj73iBPUCA+ELBX0cqIrDi/ff1WnQnNdpyaj4Iaaz+ciMdcGrZQdd0rTyq70IPQ6oHRBFDqBUIs903II2Gv3ROl4YcVi/nPMdmba4wJKpioSyk2RWodZ6HEf2wCXNsUqRyvjI3RVXXnV+3ws0AmivGS6Y8AF2olbhZaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842906; c=relaxed/simple;
	bh=nNoF3OfyQNRIoO6+TAXzyVVlMypSIgMLDPBm+2Ixv9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pHymhK+WGV3ZMXSLpoxVHK9cNjOYIbwIvOFjjyRvgUPSVryxxOFFqc1xF+A03Jn8ouuesW07fHgke12ZR/YpWksFc36N9Jov0XVtVMm760MFyMCKzCgboFRP/Wf60rszlensAjgFJ4EVhkd443ILi3ffvvlTP0z+kflq+N/lJXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CPpqKLOT; arc=fail smtp.client-ip=52.101.48.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjnXqEpPMq8nO7dYpUphGNqCSLfo1yWr6P9XQA17ZCr6du4UhGksDpxrIEA+QXl7woX9e+mz5eDNJoNR8XevUt/xTeQBh3E14g14YzrYXFa1+sYR+RbHWgcCI4N8osaEWbLXNSCrVfHO7YPwUdwQOep5CNoaOmKGHu0mAaOIZNriHzttfcS2RfigRHYWePDaSR7urERD83tsPFzTUwGn2dAesgqIJ9ystz6mrWXgkqRXpjuQ7hSowaIT2LsJ4/oJq4vz5DKSs3CG/4OgeQivX2K4BNCS8xln3D3eKCIxl4DmsPSNeH/+SUVtumW22RNx7HDCqKExA7s22E105zI4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJgRFk5JXETzgqUSc9sNbouDhn/ptvc8KjHSsHpEL+4=;
 b=O2h2ZnHZZK76iELok3M4+ivBSAh9cn3DlRJbc4ezqbb4Mtlm1XbiUX2aLE1poBSgU1wHuiLjQECtZ7xIJQHjsjIbffqtJEgX1xOIdMUG1nsfeByfeuBt+6fqb1PAU5SbPFUaI3787/KxMPWqY9HTelbcUtEnP6tKUafs3o7eGgn4FcwX1j5nbju70x7xKrr+GaVMQKB7IPT+Xcr6tkJJjJaKAVfeEjRYjWIN3FqJIAGSCI+89vCKaU5a/kXducZ82da3rZPlx2fwDDFNKAbXUBVZKd2SlmJ5marAN0LbniqdTKXQiWa7/mTihI2EejLVkCSNA6QPXUwprMP0WHy09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJgRFk5JXETzgqUSc9sNbouDhn/ptvc8KjHSsHpEL+4=;
 b=CPpqKLOTTxJVWtusAPoodVKbVPkoaBEW438CAewnsKnh0ibZS0EDuyMfsG/3ZsP2hEiXlSCbbqqkD8oRwgsOT2x0hBwfWTRO8RiAxGK/dnOCUc7h4jLl1PmGxZUCht9XSxa1NyZlYp+ea6a9LwBW+PnaoElo21oDohRFJCDhBY0Cla4hQluuOaYDIyZ20yasDinrOcsCwMgFx6SIGLDUQqr8CUJfmcVVsvY4xCIanQx3RTkF3o0PF6GROuILKJ2zq8ucyJPjJZ8S1VzywnGUaQDVDywetpA6WrCBdQuWqBKUXq58YBeDZO+GWwq1TNddQUJO2OQACIyS8LuShKmiMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 03:28:22 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9499.001; Thu, 8 Jan 2026
 03:28:22 +0000
Date: Thu, 8 Jan 2026 14:28:18 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-mm@kvack.org, linux-nvme@lists.infradead.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, houtao1@huawei.com
Subject: Re: [PATCH 02/13] PCI/P2PDMA: Fix the warning condition in
 p2pmem_alloc_mmap()
Message-ID: <r227azjk4mhat6pxfqodcbnlstqfjndsmkeebm2e6lz2yjiudo@uuy3ageaiv5s>
References: <20251220040446.274991-1-houtao@huaweicloud.com>
 <20251220040446.274991-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220040446.274991-3-houtao@huaweicloud.com>
X-ClientProxiedBy: SY5P282CA0148.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::20) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: e8947d16-fa0b-48df-c612-08de4e65f9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XaU7tW87UVUzBwrgTjZ3mA8h+5RxC6m/j/H9dir+FDhnl98M52aNI2q0U6Vw?=
 =?us-ascii?Q?IyyEQIabglIn+nrR+8mDxlGEpJ3JPFDMh21Lq3yIs+S9/yObuUvmR3lmJnMq?=
 =?us-ascii?Q?k41X8MmQcUUr7dBh5UmmTFN39b6ByZY/ra63Xiy2RukC1ldA3zOWoFtjpDcV?=
 =?us-ascii?Q?4njOFYgcloOTckMK353tWkfJkCrGWGqPfc+AXAtFmKvvzlqG5AUZutFYgX5l?=
 =?us-ascii?Q?Cof/qntAKFIZIjhUyuD580HLEtzUqCMqqMHfiENaTvSz9+ehx/uj/1EEApAF?=
 =?us-ascii?Q?urYV99hErih3gxcpxP94Hc2neUWyXlY8kar801eJ5BA4ipPqCzzyMLlw9B47?=
 =?us-ascii?Q?nlk38tk9zHvPJrbUXpiV3ZmJkSkhgBowkf0hg6w2xoIhU8dm9R0Y4uz7REC4?=
 =?us-ascii?Q?Ppt9CQi6umg8U8m+IdzalNbJkTcT/BAb/MNBkBZ5pgExMcB1TqI2+n0OKjLS?=
 =?us-ascii?Q?FZuejWSOOjq9cW/KKNxu0BK/RBlgmmb1FSTaQekjcs7+Pm1mWb+NQ5CLaGK/?=
 =?us-ascii?Q?6xLNTgB8hN1X9oQHevhiUlHAy8m0G0o1UWi0Hda0WRV+NGA34Z4i8+eFt0yT?=
 =?us-ascii?Q?xRO6x/dNbya9fbbvnliEHODi5PKPkmLmfyg/4TM56I7NOSFxrIcdFdYHG9nC?=
 =?us-ascii?Q?6HBYa7UK1F/GtPOsBRX+YAaq4NTZt3FGOeXdzE0/1J2mDR/GNvVA07Ih7wX2?=
 =?us-ascii?Q?aLyZII5A3MsVNUQXYvixkyvd+cbIbEY65YY4o9C9z5ZIDgtxS38OmzBBlZL9?=
 =?us-ascii?Q?XpqB0nA2aEQhxjlCrZzdcFuN3CrzcmyAngi8tOsd6Cqy6uFyom8W2gz19Gul?=
 =?us-ascii?Q?VRKv0PAsFNJUJl7GuH5nRF6veonnyHxnIs31ywX1MMRQsw/MVm3zN1ECPc+1?=
 =?us-ascii?Q?/GovYFgnAlqlBa61v0bzojptL0/XP7otrxmaUK+FIJH6i73TQJXPtwPDDCAf?=
 =?us-ascii?Q?K7uwg0GCU2TwQ55F2iEdccUZFa9NMc86Apj69pPl7xktaMhTtQ5qWsHAqRiq?=
 =?us-ascii?Q?IN3uXowLVlxAVSC/leeRt/oxVNfh0pumnddsbvsa80XmpMgUgjUMUQ0bq08Q?=
 =?us-ascii?Q?rxYIMgiZ0NdauePIquDfFMjFBvwU14hkHS9igHxCVWSEFGA9YMn2KwEnXERp?=
 =?us-ascii?Q?xBAivMkJHxCMUlLZe3qdPTIKGU4T6jHyN71XSX0yVvkQ+w34OuSPJz8/PUm5?=
 =?us-ascii?Q?B3FZw0R7jD6AKxNzj83JeYOrI7ytxHjUlROObZYb3cPA9W/dArvk1pdFQQO2?=
 =?us-ascii?Q?d2u7i7XNH4+01H9pT1XoOt4ZmtPgLC6Y2+btOt2vaLF57ZAU1GZIxTUPOCs1?=
 =?us-ascii?Q?QrpAtMQ3bJfQpm7bsDowXcJvSAScUaQLPIw3DXqYXF5Xalg2ZnEV9zWMRXS4?=
 =?us-ascii?Q?hOBdtpcFYNBmTUy35lXH/WEZu9uZC2Gm4TH5f6vVM1NO5O/jYfk3xvC1UV/F?=
 =?us-ascii?Q?ALbkdARtdZZWQDhNNdMfJmki2r3kBpb3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4w7iXTxlku8FWkqfnG0kOoHhrPULu1oQs71bhTiOatCmtBHCvLeVumc4ruXr?=
 =?us-ascii?Q?sATF8j9E7e5PB++P/xPzyWW9tSO33immThQVQ9WeeHAzMRv1dVf/kDw620wM?=
 =?us-ascii?Q?XH3f/PIBU6KoBu+Jn3NYEnxXqfxX5pNNl3EiOUtwwc1PEKckf6Cw7UitTa8j?=
 =?us-ascii?Q?HDAWS1Spwpq2uKahkE4NlY81KjgT9MmyycMT7gSY8FIzNSY733JkXdUvIBk5?=
 =?us-ascii?Q?7rOkLeo2wYJzTf2Krkv9nP3e3JWlyZkyFK8DjpWl9mVebj7Nj+iw7QHrMAax?=
 =?us-ascii?Q?SXUt6k3h0Tj6KmWEwYd4f4OZJ03vfDgioPGHVTmNOjRu2bdGMf+pL3KkuSDE?=
 =?us-ascii?Q?x3jxU+zSdOvnDdhloGU7pPeWrRb7ASx106bdDZdaARaNhcgkavSrQIYHoPPL?=
 =?us-ascii?Q?sW9zb0dA6m/wpt4rRlg8MJujXHyL+lq067G/1BKKWp5++06WC2XVR/eEZvti?=
 =?us-ascii?Q?4Msbaj2ejSlyDT3gvM41XGMeAhPJbdd1zS0YOmms3nJ66ic4gtmOnj72xVLo?=
 =?us-ascii?Q?lQLQfg9NXXSeI1Gsyu0+OMyxNhef24UZ7rsBe3UsGh6bVzFY0+qsSHEdxq/5?=
 =?us-ascii?Q?Cv/jw6Z/jw14F880U3wODUyttfvRmxeV4Q30Rtk6QROpx/wJZN5qsKJl7afy?=
 =?us-ascii?Q?k3QoF3nCDHto3CDTjQwWmJNzgEFAHrJBTJEj1lvaPx5Qla67hD1LzK7gM5Nz?=
 =?us-ascii?Q?yyj9VVrzOervvDUMZ0YpWXutmb4tCCRExt1nJM3yWKvFUJqwQwgViFzw+t35?=
 =?us-ascii?Q?065vMX8I4ZNmVWzJ0zIMOB7T1B1mQU7t5dXj6qzmdBVQODupyEtbC22a3J0J?=
 =?us-ascii?Q?4OvMwNHoP2Y8Iebt/L3A8UpFqwj/KyLRRzDqqsfd4s4JacRRPBr/4DihoFMg?=
 =?us-ascii?Q?a8TvNVQbjihywldaAa2qi7GlgNKSi/1Wc8izFgoykNfevzvdTSmpBvxPDzi0?=
 =?us-ascii?Q?MnN6r6vnH7F1KgNfjieZl+SfsL/rKI5gPdLZbeEKU2UdMkX2HJr40N4hKr/m?=
 =?us-ascii?Q?iUNzBUcV13B1ggEkRj8gMmc0ZAey+z8mkC9tLaZJIz4Popg2DzWaFT15ExFD?=
 =?us-ascii?Q?futQvneo3oPIO7uJazvETifF7hqrzbaHGKZx7POqduwetMFd0bM4W5KEqHEc?=
 =?us-ascii?Q?1onY+3j4xTHvdBytwr/+sk7A52O6Y7TwEhpGYptLwbmNypW9+NDBOFLw/Cg0?=
 =?us-ascii?Q?9dVYRVRD3jMw65KbtPNhBLryaVk/Q2nrGj4jaIjeJTSWUA+v40XvjLH+ml/q?=
 =?us-ascii?Q?3LfhrVJ81pjPUT5jOsTixmXw7IT4u7RJJbQBRbZAesANg/oPQBz0WKQch0N9?=
 =?us-ascii?Q?0YJy01ERSAzJOOlo5wnaDa8e9YU6cyj7KtAJEGSS87sx70YVQQQToM1LgLr2?=
 =?us-ascii?Q?JDV7F8nQE555PhKXBy9aKpbZORSBKPt+nUHPyalLnZ9+pQlWl/MX3owftP7z?=
 =?us-ascii?Q?vzIBX8SWp/pKSQQIDj8/lD36Lu8uJSb2r7RATAdPdC20d6/FgVCiNiciSO8a?=
 =?us-ascii?Q?s5j2Hx0VHaJgbAoOaFogRXXtCHMnYi1UC4DorQhb7+/cAPDew54/77ej2YTD?=
 =?us-ascii?Q?Ug+h5P65k9ubMkCZy95AoTjNF98voeYNdJZKiAWFO4iuILdt67G3H0gEzgMu?=
 =?us-ascii?Q?zxAp4qpDlYBmnKwvClWuxDUP6G0eUg6aDAFBhu34zekrWkRUiTz2T+c8z28b?=
 =?us-ascii?Q?eFiy+8I9vF1KBjizWFXUDVGoftaMNox9PrK2GWRQpdxs3egO1yfQGOl8B3Eq?=
 =?us-ascii?Q?tEwpKv3h9g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8947d16-fa0b-48df-c612-08de4e65f9ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 03:28:22.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gbI1vGzn0qgcfqaStO55D/F80dUWZJk1HtxPEHNdnAEn2YOy596J2D54dSGYCPnI7L5fTvDqOY+IU5KYEKWPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076

On 2025-12-20 at 15:04 +1100, Hou Tao <houtao@huaweicloud.com> wrote...
> From: Hou Tao <houtao1@huawei.com>
> 
> Commit b7e282378773 has already changed the initial page refcount of
> p2pdma page from one to zero, however, in p2pmem_alloc_mmap() it uses
> "VM_WARN_ON_ONCE_PAGE(!page_ref_count(page))" to assert the initial page
> refcount should not be zero and the following will be reported when
> CONFIG_DEBUG_VM is enabled:
> 
>  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x380400000
>  flags: 0x20000000002000(reserved|node=0|zone=4)
>  raw: 0020000000002000 ff1100015e3ab440 0000000000000000 0000000000000000
>  raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>  page dumped because: VM_WARN_ON_ONCE_PAGE(!page_ref_count(page))
>  ------------[ cut here ]------------
>  WARNING: CPU: 5 PID: 449 at drivers/pci/p2pdma.c:240 p2pmem_alloc_mmap+0x83a/0xa60
> 
> Fix by using "page_ref_count(page)" as the assertion condition.
> 
> Fixes: b7e282378773 ("mm/mm_init: move p2pdma page refcount initialisation to p2pdma")

Argh, thanks for fixing that.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  drivers/pci/p2pdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 218c1f5252b6..dd64ec830fdd 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -147,7 +147,7 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>  		 * we have just allocated the page no one else should be
>  		 * using it.
>  		 */
> -		VM_WARN_ON_ONCE_PAGE(!page_ref_count(page), page);
> +		VM_WARN_ON_ONCE_PAGE(page_ref_count(page), page);
>  		set_page_count(page, 1);
>  		ret = vm_insert_page(vma, vaddr, page);
>  		if (ret) {
> -- 
> 2.29.2
> 

