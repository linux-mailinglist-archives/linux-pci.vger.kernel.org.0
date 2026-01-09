Return-Path: <linux-pci+bounces-44311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 409E3D06A10
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 01:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA117302DCA5
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 00:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709C5189F43;
	Fri,  9 Jan 2026 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UeV9MgNY"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BAE15A85A;
	Fri,  9 Jan 2026 00:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767919321; cv=fail; b=qTb/qN9LaS8tBw9UxNT5ozCCpvpmZGXeMZznG0HHvVZinlPnnopdRHD7AkRLHk2vAqJw3neLNX+sk+UmhxcBsIpDQIC7o/6nkpqjUWLlnjeJEd4/yRWojCFLR+Xl3Y71NaKt01TrZ+lYDqobTO1ujMwyK6MYM8ZHNRMBvKKea1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767919321; c=relaxed/simple;
	bh=LjdduQkWNeJBiTcBiGUW+Q2sWinTWNjNO5DkJCo/3iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ovz9R9Z76IbLYn8ZLYuMYxVfdBFl3lOZ5GNolFrrx8yI/tASBwoY/wzB/EdPl3jg4tSQ41fb3oHCtIA942l228Dnc2zej8JbWmLaMd6TMQG//1gGEQOcQmpMrlvK7iAkgyZpjGinzQlg9+Cu9bvtTtxr24h8nMapVucVkLhEgPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UeV9MgNY; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyqffiiZB7mW1N9G8eEJk5iR9Jmgn1OlWRgSRlk9C66sGJ7bMTJJimCbdQD/IC5ZSgGwylEeOYvB38u6rNJ0JzyHopFDzuvGpf26G7mdtwpHhfRm7fxZ5nNUwEL2rgk0QiVKxZJkjIhOv5kespIN4+pjxW2j3ovcBlzlBkc0IKEs8AlwBnAFQcN9oZuOO/VHEGJNgZ16883vPDGB9T3YccWuguSdfXwnhxeooo+GeLpdqHGtOMucwMVDzGo5KhwNJySLWttnma+4gmHRRmzuMrjQQyK3bTIquUD2W+o+ISitTYYNuLj5HXwcm172HYXdC4w0H9erawkqxwuDeIEo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1O0815lfh1v5uAg+wzs5kuo/RronHYO9PISvzu1wqU=;
 b=PJvZev6Mg/tBULjEZk4P2QcACLJw1igNAcCq4q5FdqhV7VQ5lYnIgRJm35cFPx19ioGgzNNeMxpjNxP6yN8S4Bb7Yf2I/rp/v5/zwXXH4vTXzI/c3hEYczapn09rrnS1lGNiiNUYqxrVWNESLSmeaeRJRLzDK2Ja6+S0plvalTxErz9B4iZqj63V4HTJvYMJQTf/q2jQuOCFgVTo4DT1AyxgWRVSXd72lknwMr7hMFqcEoDFc6iWnmXyE4JY8Un3DwRjuePoKmwsRdBlWxuV4Mu9icfAbaDHcPgGNOCWMbAfuR+57H7FDm8BW8I6PIuNcVRxfdE+gUObvjADwZZJfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1O0815lfh1v5uAg+wzs5kuo/RronHYO9PISvzu1wqU=;
 b=UeV9MgNY+2e4nI9A1vUdv73U/uZkFuigqFiohtQjmUsDmpfuOx7JPIfEaURUGEKP/ZDoqX6TTxuvsDlsVmz0bUo3YbWZL8VexsxnJGkk5UrfAHwPP6JUnJaQVk87S4Ra3suAlAFYFMPtICR4LblLqHhq2e9FTJRrzG+MYzGrDOnVZvmaRscd3+BIYznPwyCOhuhsXTyYuzaKV4I8F3kZ0odi1VYKB4bX9ROV6VueIvPak20Zq6smiVDvsxZ1uWpzLYpvK07vVNfLfRepZZ/ojqjrH4xB+DUDSpdVh/CeNaYP97nd8JbRs9CUCTRYzLKviLlLcZ6opAPIyFfE5Z0RpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 9 Jan
 2026 00:41:57 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 00:41:57 +0000
Date: Fri, 9 Jan 2026 11:41:51 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, houtao1@huawei.com
Subject: Re: [PATCH 01/13] PCI/P2PDMA: Release the per-cpu ref of pgmap when
 vm_insert_page() fails
Message-ID: <vrti6maahtwfrd6xrdmyupunprioodhl7x5alpi2r6kyi4qcyr@ga6a5yrdvmb2>
References: <46lz5szq44vz3chzj6unh2sff4cfnpyvih7zty6fcnitzyrulu@6a2xdopoafxt>
 <20260108155558.GA482755@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108155558.GA482755@bhelgaas>
X-ClientProxiedBy: SY6PR01CA0158.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::6) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: a6671af5-322c-4dfe-7c45-08de4f17e40f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gVa8u2awFgdera1Fcsp7ZCvW17nb7bC6Ikc83+teWNBoUNkQw2epXoYTI8Iz?=
 =?us-ascii?Q?9cznEnBOq9M+oZwpg4DGf/9xkswIUahGSsjTP4jBT8ecF0S7Bv2nhoKSuX19?=
 =?us-ascii?Q?PHfOn6FLTOgKX8sbO8fGTfHblHkEEpuJSpeWoFWfGM5+gQEd2XMGshYp3Bnp?=
 =?us-ascii?Q?xWhU7KImM4nkGT3o1GuvKqP8QmlMpOIPwJE/sIP5qpl2iX/tUGgGtzv46Fpv?=
 =?us-ascii?Q?eKywyO3jKkX2DoqmAm4Rx1IWNFXb8d+RMVINd6RDcQheSYT4aq4XyA0T6D9C?=
 =?us-ascii?Q?tCu+joNX0hVfhlX/RHInn2hJ6KiQyefUf0RcxXir/IfjCTGFgxY1yl3DO+5i?=
 =?us-ascii?Q?Sd7wt9rjZLWW74n9ezvcHoDEOrB1j3Vtkn6KIsL0DlGgXWPsSLBvFWooNHKW?=
 =?us-ascii?Q?v1WJbxOkT1RJdmPRlGlwjfZ5BBf2VXQaPLrqJbhWY/BrxjfDUliaJ7P/fFY9?=
 =?us-ascii?Q?wuTo/jeqh8wT7kif4JJLuF8KL/se5zy5SPIpBCM9rSyHQ+33EYrAQTtH2Pip?=
 =?us-ascii?Q?vhZvBI96111ODyji+mdqdfApNjma7mSwBh2vpeLbJzVk8e5YcI9C+I8U++aV?=
 =?us-ascii?Q?HWPCPmtqIaZ8AYN66zmsJHMjm5W7gRgEhaXOZzPabqzSBaBFz0t71VKJkmSu?=
 =?us-ascii?Q?qsmkJc4luZZfpW6bulp0GrykvducF3nFeKWtqsHyKh8LTf+gEcy1YNaZq+T/?=
 =?us-ascii?Q?Cgc9eyiDZ8629o9jjYCBqmKbGEQtcXkr1x0qpD2MRuoYkhAx0L2T9zgFsKtR?=
 =?us-ascii?Q?W6CngpjSyrmgNLJW188bUGeC22fXHZ+hqZpiZvVCSqeCpA+QlaiihlmA5Cpr?=
 =?us-ascii?Q?bQ16QpCsBIq4hnNEmqhOJAgunXxXktEf8GH+FJeOMGMqCZNEFp827TQrWbvL?=
 =?us-ascii?Q?kSUFTtusiVAXQl6NSzuxD0khF39U6RKQUYzJP+VTQOkgOcm/Ybi4sMpLurUj?=
 =?us-ascii?Q?Hbxeu9vChR+33JMi11eRtKzc7gigsW7VAMpUqg1b8K64qK/9iYQfnhxqo3wv?=
 =?us-ascii?Q?6pbzn3j30HUZj6bF0gF5BcL8u8V3ctsmySmdAKhBkYG3vUnyQYF46IvkAtIt?=
 =?us-ascii?Q?vMzzQnj9dtabIrVZUHSiX/Ujn2jvBfmE3lN/FA8ru/QZ0JG8cGe9hZ8EjJSk?=
 =?us-ascii?Q?RWfBldP1ybakVRJ52wYhlXzOg6tLH9ayxSDCt34PkghIp4aU7QVo1FQvuBR2?=
 =?us-ascii?Q?1qDfK4VrNyk+TPmxy53cn7UPKUlMr4s2wqq+9jypuXAufKMhle7pEb6tCcDc?=
 =?us-ascii?Q?a3+mVa02OpDSf5SCRkanRhVn6vlQyR4Qb7aTYlDbp4STQDPuKnlZD2Piq+HS?=
 =?us-ascii?Q?uNX5/ytZpj6btQKwCEoWI/ylYSs83bjX6JvivbtDsLNbIsRRycuX1QNu55AT?=
 =?us-ascii?Q?Vi78650RvsTgjjII3P49o2L6qOF2hzlerEcFfOrYwLMVJyeM5i4KhjvcARfo?=
 =?us-ascii?Q?484GzlDYAlezcGfg2WUds0JSQwNLJykO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xflRGxhWW8nPsOkj7g8I6LGucEgcOnVSNXJEqcuaGfsXawsAB5M7DzUZoZjC?=
 =?us-ascii?Q?4Kbec/Vfu1pf1gy3rGcSPg1x0X12LZA1dst9DYcx4wrSPPGguYcrWu/9NI2Z?=
 =?us-ascii?Q?z5pjpmRivrOam3fcPwVzbB7NW7kL3C6sTrwNcCjeaF4sTNmeNwURd7ZNHegv?=
 =?us-ascii?Q?CBegeMCLLNF7R0VfuJX61vK5SC7c6iRDCH+y5Ntfw+aoc5MhGdbJe1lXJdel?=
 =?us-ascii?Q?miqWuXE9dhbeCuTFuxSoMAVcUHeIsW/OxVagZZ/7874eQKWW5gcItJvf+t6k?=
 =?us-ascii?Q?np0RANxxR3HrNXwUzSn0c20aPIRKMBuxSQaR8MDCx3v78HYDxbJEGarUEwrw?=
 =?us-ascii?Q?qzIZykf7QrwSsmjumzydL9w332USxi1ohxJqskENCh4iPvpA3EYlSWDTOwhD?=
 =?us-ascii?Q?rrT9SJ8laEG0lGb7J78hXDolGMFrW/Ilxhf6B0XeHwpSIzCgk+biwtO9vMHw?=
 =?us-ascii?Q?lb1S8HW3mkH2PkaY8d43uBQpsGZTJZagbkk7yqbD9RVIRAUoL1MEYdn0TMmD?=
 =?us-ascii?Q?vY9ePcz1dTZWlRZUS5xM0YLlkBcIJ7pdERWXbgRzHq1bSAEOEFQsDw65rL55?=
 =?us-ascii?Q?QCuILtw2GVqtFPtZAcBXZ62K2HDav8o37AXCwA8rzw3kQZQGJWRaQpgjN0+h?=
 =?us-ascii?Q?e8Yi18vLn5o37s6clRU95w5xQZAJa1UK7jjY4qV+C3ko9/FgUtVzP22oIDJU?=
 =?us-ascii?Q?9oWGCog2UqMkX7kaNI0LbqF7aUURCGixMMfpMVOYTF5veOxSmjS3V+HzZqwT?=
 =?us-ascii?Q?LKXIhorqheriYjIhlsrfMzTeqeqpyfy6dqD5Vsm7BZZHQ7vKC8CCZh0nhnrt?=
 =?us-ascii?Q?1g2w0kmjPBqShONKqGjtvpy538vW9E/wqK1gHUhbDHFn0bb7jAK+dPQ66AAH?=
 =?us-ascii?Q?1T9+yXnd/5VNdIpOs2QOZO3CN20m9p0hZYUpGMUGU2Qk48CSvNT11bc9gnyB?=
 =?us-ascii?Q?+vCkPpLelNlGh11+UP17eoHfaplG9rUdhr5io/ZqVIQyZcS8ScoBsiTYrAt9?=
 =?us-ascii?Q?ViyK4KIoYYjDECsa1k7Q6wO1EMCNieSCKswFJSJiwDe/QFuUzb6FYdWQxWPC?=
 =?us-ascii?Q?yjt4hVBjCvmrDHglCFEMOTK9T1tNUaOT6LPPAfCywmqJHgfkDeqBqTEggxIA?=
 =?us-ascii?Q?INDtSry/LD8uMjW5U/Fm4KvqzYVypwpKeEUW+1Yay3ZgxHW+AnEoXgD4MlHj?=
 =?us-ascii?Q?OqIFVkn+nHr802ItDB+EOJ2zWljKJej3aoCZICg1j7Gay4Hwf7DR8wqXjfOt?=
 =?us-ascii?Q?sozbadQTZ/v0gKIYHGvZYjogbD+NIF4VtID85noqX7BLmQqsuYASD0IyomZx?=
 =?us-ascii?Q?xcpzCrRDiK1n8z8Mkbm+U6qcwi7Mq83sDDb2gDb6D7Ky6GaeW6Sp7wGwCVKZ?=
 =?us-ascii?Q?baPpEG6RhlY4pIJkxmb9/hX7aQ3taY5GrtYxo9B86agHn95gkRjdPNTbsu2m?=
 =?us-ascii?Q?E48j+TlEGqFDowz1mtLdGOZ0ITmwrohsNKK3nDENYmwE8D9JZF2eYEhjYn9S?=
 =?us-ascii?Q?CXI0ktcLeR6MkOxk5gjrYRtCwpAfTW1uISz7f6TFK1s8Mm6qM6gZqF7LbJYD?=
 =?us-ascii?Q?fUQOPkikQlDEq0RpiFOqCbolG4DaPHNNv8xtW8CWX/cG0S3OO5Y6/3fpBPkg?=
 =?us-ascii?Q?st0gUTNaWxeEhiMU2/4RgqXPLIXMHJ96gYXLae4kgH1iMuvdGExuMHMq1acq?=
 =?us-ascii?Q?ZXL8iBV00XzsmurunDn9WYaqNxo67AQY9AvWxvjkSHkSlKSMA+ZVytzrI8MR?=
 =?us-ascii?Q?eVxZ0VLLxw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6671af5-322c-4dfe-7c45-08de4f17e40f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 00:41:57.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWEoRvXAeCshrimOk5VKoDPM6IdTFew0W4buiFW4oUJmL59yc3ZJC78OrLB8qb4spi8rptYiJ7a9sOGO4RAWGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087

On 2026-01-09 at 02:55 +1100, Bjorn Helgaas <helgaas@kernel.org> wrote...
> On Thu, Jan 08, 2026 at 02:23:16PM +1100, Alistair Popple wrote:
> > On 2025-12-20 at 15:04 +1100, Hou Tao <houtao@huaweicloud.com> wrote...
> > > From: Hou Tao <houtao1@huawei.com>
> > > 
> > > When vm_insert_page() fails in p2pmem_alloc_mmap(), p2pmem_alloc_mmap()
> > > doesn't invoke percpu_ref_put() to free the per-cpu ref of pgmap
> > > acquired after gen_pool_alloc_owner(), and memunmap_pages() will hang
> > > forever when trying to remove the PCIe device.
> > > 
> > > Fix it by adding the missed percpu_ref_put().
> > 
> > This pairs with the percpu_ref_tryget_live_rcu() above right? Might
> > be worth mentioning that as a comment, but overall looks good to me
> > so feel free to add:
> > 
> > Reviewed-by: Alistair Popple <apopple@nvidia.com>
> 
> Added your Reviewed-by, thanks!
> 
> Would the following commit log address your suggestion?
> 
>   When the vm_insert_page() in p2pmem_alloc_mmap() failed, we did not
>   invoke percpu_ref_put() to free the per-CPU pgmap ref acquired by
>   percpu_ref_tryget_live_rcu(), which meant that PCI device removal would
>   hang forever in memunmap_pages().
> 
>   Fix it by adding the missed percpu_ref_put().

Yes, that looks perfect. Thanks.

> Looking at this again, I'm confused about why in the normal, non-error
> case, we do the percpu_ref_tryget_live_rcu(ref), followed by another
> percpu_ref_get(ref) for each page, followed by just a single
> percpu_ref_put() at the exit.
> 
> So we do ref_get() "1 + number of pages" times but we only do a single
> ref_put().  Is there a loop of ref_put() for each page elsewhere?

Right, the per-page ref_put() happens when the page is freed (ie. the struct
page refcount drops to zero) - in this case free_zone_device_folio() will call
p2pdma_folio_free() which has the corresponding percpu_ref_put().

It would be nice to harmonize the pgmap refcounting across all ZONE_DEVICE
users. For example for MEMORY_DEVICE_PRIVATE/COHERENT pages drop the reference
in the generic free_zone_device_folio() rather than in the specific free
callback. Although the whole thing is actually a bit redundant now and I have
debated removing it entirely - it really just serves as an optimised way to do
a sanity check that no pages are in use when memunmap_pages() is called. The
alternative would be just to check the refcount of every page.

> > > Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through sysfs")
> > > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > > ---
> > >  drivers/pci/p2pdma.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > > index 4a2fc7ab42c3..218c1f5252b6 100644
> > > --- a/drivers/pci/p2pdma.c
> > > +++ b/drivers/pci/p2pdma.c
> > > @@ -152,6 +152,7 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
> > >  		ret = vm_insert_page(vma, vaddr, page);
> > >  		if (ret) {
> > >  			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
> > > +			percpu_ref_put(ref);
> > >  			return ret;
> > >  		}
> > >  		percpu_ref_get(ref);
> > > -- 
> > > 2.29.2
> > > 
> 

