Return-Path: <linux-pci+bounces-44255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A8BD010B5
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 06:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 314213009F9E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 05:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D24C2D249A;
	Thu,  8 Jan 2026 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hG7mNeNz"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F12D063E;
	Thu,  8 Jan 2026 05:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767849256; cv=fail; b=iObFDyd7I3RgY58Gm21yK/dZYjo0V6Sxz0RIRzYtBhpfwDDcvWllMdYNs90zJaL0iwz3r3qeF1N15aWYi5yYwvTM7T+xtxBkedORYqNGgMspWsJ5J7korBG+r3lV3N8jFQx9lBkchL8vWmBX4ywLGU/4sNmtMG6lPwy7TmJjbyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767849256; c=relaxed/simple;
	bh=DbDgOa6OM0w6xpC8Pa8kErwcFFNouur65LsSr7INeAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PAYbUO8EyjM1dLVAGuxj914R+d5LiOV6g3fQSpeEsD+9C9V214RcGuErPpJOrzMMJQA4DgNUQ9nvhZYPRGD031HWkcEKPkGWPj2nroLKfcREsPDzOk1D+QyzZ+W6QjP+koKlXAoUcWdHS/gtl5TVsqZb3xTPA59Qa10HVuM6SpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hG7mNeNz; arc=fail smtp.client-ip=40.93.196.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYusBwzvpoHLBTWwF/wziP/gUUV81qKQE/dGqdWfGBtpnhmimeqVf7mQAZX2MjSJ+S5WzhtIHGadaeiRvMIX8pSwxgDqQ6V7hoDEnyguQAjU7VKHRMf/7jo49btwAvLwTQL0C6Pm+DiEmT9HLYu+HYpAwo9fbNSLUziAuFtcZOP+1ZI+fXN0iyqMBY+bO15Fx7vNJuSRIHd5CK6MveVpfJhTfm3fdsARSTz7cn+z7+Qh1jB42TxwS0aUwlzmWybHstB8qYPB2ViPDNyLWG7ZTfcOGa0O5TGeXxgs3Mrssw+Ao0RwXaMO3uPE67Cb2VsjC4b+NeZQcH8rRdMjXpAhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSF9vzmnmNwBOYoOQZEJO5/l7w6JZ3zE4YTmjXWjRaY=;
 b=Wri9zsW3OLvXVN7ERoeBHDnMIM7ZNyy22pIW1NEImtQHhwU/dKkHvoaf/e/KMdd0hWVX/uywwsAvidQxHbI2+awUlR9fh9K90quiyldcD8yJzpONu5vul4dEu900YgCR4uaifxgsqqfeMBhY0mG8RNE+Hm8mzjWlNeZQv46kq85fwzebOBNyNXx1Iz9anvDoby4/5HfeqLxXIe/pYIqvhTc8XsLthDc1wkXS1F+hY1cPrvFQEdU0ip6Kc4LEcqjrmxTpl7LGckTzquFT7oj5/qXDco7+pfKRgxyGJ6FiCplxNXVJ9FYphK5S0wKtE5H8HIsV2yx5vMK24CDbsovqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSF9vzmnmNwBOYoOQZEJO5/l7w6JZ3zE4YTmjXWjRaY=;
 b=hG7mNeNzIZ4Ue52PsUemO14ZOGvVLcDJt4kFihmLe9xd2lTPklFnI/rIdxHSuRbDJ9U/zYn7Y0iDHzn/VXacN8m440P1WCRJe2Nn2RvwhGon/xF81ohX4tWVpWOxjDwDFv8qDo1O1SxwnTcFclIE6PUlSZNbOl1s2Tae0B5KE4NxDRwb82VAIcu8PFLO2xbn1tzPY1U+U43fmWw3XTVT88jFWumtnNmlNppf5Xr1vhixpvmmdUGRVqJbuiTmnH3CyFyxfHjuzWXXxSLH0PpqXdTmn5lsuDJ87LJ0ykUryOVt7utGNXaYk8yvObd7gM66X78Hd/WZuTfKLkyCf3BZTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 05:14:12 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9499.001; Thu, 8 Jan 2026
 05:14:12 +0000
Date: Thu, 8 Jan 2026 16:14:07 +1100
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
Subject: Re: [PATCH 07/13] PCI/P2PDMA: create compound page for aligned
 p2pdma memory
Message-ID: <krs6qfjs2rle2ufoqdk65slnjkq55nbn23reptoij3je4gnb4d@pcbiqtz35hbh>
References: <20251220040446.274991-1-houtao@huaweicloud.com>
 <20251220040446.274991-8-houtao@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220040446.274991-8-houtao@huaweicloud.com>
X-ClientProxiedBy: SY5P282CA0132.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1950aa-7d90-47e2-5ea9-08de4e74c250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/0AmEL7XX2IIXD5+x4nBm8tn/M+W4FZ8be4zWbLSUrsNeJ0GyyeqtklL9H9r?=
 =?us-ascii?Q?cTOcOhsthN2ZuNAnJ7p/GTSa/z74zgTu5PGKkOAm9dCDLH4mxOSq6lYV8FTm?=
 =?us-ascii?Q?uj9Ps2SHHsfN34icGR70NACenBSxZcnSMwFcY446Er7w58HQuNUEpZMwosdp?=
 =?us-ascii?Q?L3tyY65n9mWfyapPbdu3YnjdgOkUPGJDe1CiIOniSaYlM9DivhBYg6glCGqj?=
 =?us-ascii?Q?MF3onwwjZfavEmvNu7I3IEZBG4n8xV1WkRI0X7zk6yK9hV0Hwys1h5B6v0Fe?=
 =?us-ascii?Q?pbkcCMfgxadSJAovmfvhnxUqhx4gl6CU7GkQZs5PqOv7+buyKLJlycgSVD2D?=
 =?us-ascii?Q?X+RywJh1ztlxIZnUgm++5cCK2wJ/Lbk5ZUSvxAQkgq13JAi0r72juEmhfl0W?=
 =?us-ascii?Q?j4gBlndCKqh3Nd8qUAyDVIjXe7Rn4/hOYTyvkY4OWDx3+jzDpBjgcZMKzEyw?=
 =?us-ascii?Q?QdNGyXiJ11hdqlnHvZf2o2zc88rR112qqJYdS7PiVeBabe7mOZSt/YdHelzS?=
 =?us-ascii?Q?j25vQRZe24vzqebctso5HOiEJZ+t4wmMxn1aFmHgV/f0j3s33tdMC/GUCDaz?=
 =?us-ascii?Q?7xWqdDHTXpcoFoKEDEP2E0CqLbhJsbdHM7J1yI8/9wDiMuHfy4cf8uO0Y4cY?=
 =?us-ascii?Q?92qDVn2tIfok342M+RU8rF4RY1N20oUR+E25KUDgMswMKAS2ldUNzs5FE6Bt?=
 =?us-ascii?Q?ZqJrRd+m3edb1d9hrDB1V7B7GLllhGTw3EVgkysIx06EuK9fZkHmGZzuFc7c?=
 =?us-ascii?Q?X37WdqopHPMHjIZMZVlieY7EF70QN7Q/Dfu5Bdjkx8A1lH9vRLGk0ZIsQjv7?=
 =?us-ascii?Q?5PAvbXJuwKcqxiEOPngniMxTfim6pSgzw+szfN7h1wS9bcnjgF4kBTS5uY5l?=
 =?us-ascii?Q?nBivMbpTQfINvOduKvUKucbXAr8NnnQzvWPKW82dti6erCXrCfMb30Fz7571?=
 =?us-ascii?Q?WaDIdK65MGN0qNyK0lfUFL59ZrPzrSoOExt3zfIGfjisXAMhRyFo4W5KRx5r?=
 =?us-ascii?Q?SBeYRdL/vwkK9w/hhmeTNcO+vXVZShasY8ZKHRxCyyd1xCzIJeghFVchfCgH?=
 =?us-ascii?Q?TwBC8wBne2lapg+/orqEP7YgfBletHNrpUJQ0ugMm0XCNNBiwGXdtDQ5ulAw?=
 =?us-ascii?Q?luK7hTzVQ1fqOwvXDduZRALsPKlzCuzBGQa+I6zVSpzOXmgbSdtvr+gRBX5n?=
 =?us-ascii?Q?A+LMBEQa5Nd0IJqxiJOo7187twBqPzpBn4BAtNh/6p0c4FenTAVpA3o+vvMj?=
 =?us-ascii?Q?j/Td3gzv0xL9q44A4C/c1BRqTM3xKh7zQHH62rT3R7bfXkKDFOkfbXa0Q6oD?=
 =?us-ascii?Q?ZQLW0ty+b+Md/LrRmkfKK5Y8KW2/veOfY4Y3MeZX6SLabgEpxfuwlj2nN4mS?=
 =?us-ascii?Q?+08JTrRVq9N/Jmje+jKdoSikR9vu0s5SnbY36tgNVLvNcZ122fjl2ilhnSaM?=
 =?us-ascii?Q?qa67Gwf7hPmbLX8JVtOcA/iAqcXYLPUW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K2zULAYxpaLOfts9s4+dR6pH++eR4Sy1LOFW4t3tvmcKKHtjzukqZwaRy9no?=
 =?us-ascii?Q?u/gulSoGe4917selRic6cdNEoFEu8qRwb0Szd3hU0r2LFOPKyZpuYCiYeCcu?=
 =?us-ascii?Q?rP7OGkMLzQHErvw53QObt8kvBh7VMm+LGwOrVd6RbB16IGhI7VYlUbov54dV?=
 =?us-ascii?Q?0uOf51Bs6iOSlyYyJA54ZySTp4dI6wkgOqXr+UJuP6i3qS0wRLFdjsDIBQcz?=
 =?us-ascii?Q?fuvqnDngInsc1fX9Eb2EiDvVvTEYUk3CdxdYOGaNZGJVQbzYrZHpARGBeYAz?=
 =?us-ascii?Q?rRhidPHbqp1FwahpqYDh3Chkqj2h2ngjuViz6NN3RXaKXqApIZhD7cJpQSLN?=
 =?us-ascii?Q?H3nRTAAwKijqpIQcy7Z5/a6Vku+9UlRSnh46clChhIE4oUJs3EYJJAAreoVF?=
 =?us-ascii?Q?z+Qe09nviBo3uMnJ4/OLdQeqxfWc9r3xcz0hhYDV+gUbbMCjoxTDu6BlbeYE?=
 =?us-ascii?Q?Pw6pOFXb4yCmsFQZLzqOxojcRgAJfX/pxzMvzdFNCB+4pwWrUm/GTPfz4qFr?=
 =?us-ascii?Q?8lqMXlkHv0MQl6K/KuOLyTwAW9VEQ3x6/dVpItibW+lT057fd2XiuYFPBEDT?=
 =?us-ascii?Q?kHep9C8uVDCG7jhaUwuO2/E2rwP/Mb5tql2uCepzw+s2+rsxKFBoJEFwoTWk?=
 =?us-ascii?Q?DIlUbsmvLThnVE4AY/651sbBgNW6devWEoHp1+cRcfkyKCPAMjJ9QYIaDcGc?=
 =?us-ascii?Q?rq1dfArrLqplFrsOEuq31LHy7Q7rB9dzhE3bH38ospITxlEXqTQ2iA30Biwd?=
 =?us-ascii?Q?DZO4nxL9tRYO1r/2uqsCQ04X8ntBPR2NltJjdIxI+Maf+6lbzP5Kt18FAIMC?=
 =?us-ascii?Q?YPpXulgVvqUOzEb3bdtzfjY9FIdut3Ma2sRovII5Aq7jl+St9m+lL53QG5th?=
 =?us-ascii?Q?j3ExeCmrElg5uRhms6sJDgRmato32FDHSECdPphNE1W6aRiv1pWS4CX3eHx6?=
 =?us-ascii?Q?PHwyL2abysySfL/BFWt0ccR5EhtU2V24Hc/4JRxTUv20CPuHa0cEEZiSN4+v?=
 =?us-ascii?Q?R8PH1yKaGSDyfedTNHlyOaUQvHxyPbR2l94Uw1KxdoQQuCSyoh2tvFS2+IUy?=
 =?us-ascii?Q?l5FlheTFPnrEvno7VR3NaZSFioUar87j5e1q0xxSNu60/A6XLtFNVeETwzb8?=
 =?us-ascii?Q?kcbAFC4g5H/xQWlLGjGsXfiMbQZiDC0hcXJjumS+QhLZLIABwUlkfCaByZhF?=
 =?us-ascii?Q?sZQDd8XJEgIRiJlLT1dgHu0NkDRC/UqdmN3X7BBA4gx1gsmUqHiOdw/cfWaw?=
 =?us-ascii?Q?CmEmXHW36xRDpJgh1fM0AFOcSaqde/y5MgV4X22Exbl+rT5qgcHq9YkTk/h+?=
 =?us-ascii?Q?zQaDfs1n+1ZYMeDB19FBZPZSrooeVMB/zWEgRzAB9ewJV0MuPIOESH+GRC6L?=
 =?us-ascii?Q?F4ByXYVPPPLfKqe25NRhBnFnAfOPw6pQ3OC5GRhS4bOmkPf182PaerYYLqpd?=
 =?us-ascii?Q?7gSnHM0Hw2n0w8lZrKzcDCKM87Lw2uqnTTZmPV0u74ecj1sig6xOB6x0evAt?=
 =?us-ascii?Q?ySrTwEHjze5U8ZMzzhsBHMTXn6k1HVQ+/B/QhkexGWtqemjNM9fW/54mfYGw?=
 =?us-ascii?Q?JocnBGSutPag/+1sRcYtYpZdabCxzoL0CPDYMNNMUlVhV8SrJrsHb3iWpeL4?=
 =?us-ascii?Q?4igwV6kqY8h8i9Alpwqt3ZVGopfQy42K1XoXJAIfhOhcvfCNK4UV8JQdhyrF?=
 =?us-ascii?Q?KpINtv/nuj4OdnhzM59KWD3/9p5ANGWE1p5ajknSA5kTQT1rojgZWS3CFefF?=
 =?us-ascii?Q?kHo7k2ShXQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1950aa-7d90-47e2-5ea9-08de4e74c250
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 05:14:11.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQZw/d+sW/6+dbRZ+HpNWsSN8byAZudw+MP6PXfVY1smH6qqZkw17y/0vn/TueYMwWUlVBrmhDnS2Z3jR6RrEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992

On 2025-12-20 at 15:04 +1100, Hou Tao <houtao@huaweicloud.com> wrote...
> From: Hou Tao <houtao1@huawei.com>
> 
> Commit c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for compound
> pages") has already supported compound page for ZONE_DEVICE memory. It
> not only decreases the memory overhead of ZONE_DEVICE memory through
> the deduplication of vmemmap pages

Is this true? I wouldn't expect supporting P2PDMA compound pages would change
the vmemmap overhead - I think we'd still need a struct page in the vmemmap
for each 4K of memory unless you were going to prevent anything smaller than a
PMD/PUD sized BAR region from getting mapped.

> , it also optimize the performance of
> get_user_pages when the memory is used for IO.
> 
> As for now, the alignment of p2p dma memory is already known, setting
> vmemmap_shift accordingly to create compound page for p2pdma memory.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  drivers/pci/p2pdma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 70482e240304..7180dea4855c 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -447,6 +447,8 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  	pgmap->nr_range = 1;
>  	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
>  	pgmap->ops = &p2pdma_pgmap_ops;
> +	if (align > PAGE_SIZE)
> +		pgmap->vmemmap_shift = ilog2(align) - PAGE_SHIFT;
>  	p2p_pgmap->mem = mem;
>  
>  	addr = devm_memremap_pages(&pdev->dev, pgmap);
> -- 
> 2.29.2
> 

