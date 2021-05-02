Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C937370F15
	for <lists+linux-pci@lfdr.de>; Sun,  2 May 2021 22:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhEBUmr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 May 2021 16:42:47 -0400
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:51233
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232338AbhEBUmo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 May 2021 16:42:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JApP3IA2kAm/jAFzkGGuouB+QDp11IYXEJt7UQ5PvYF2cHXEjq+fFa5uUhmeShZ+H1fQaxwL3zN/VRw0LS6UDrcFIK7e6Ha3i+G1wCEJuImirJKpP+YPgQhwmdN2AVJFyttZaHyskhPjvwvz9RKW0gBlWcQxYfkT21AGScXg99fdKbwYprtb/H8jgmAagNQ8ZLF6cs+jclUWNGkCZYOlb1i40bkwgcjH5On2RuL9vLdSyA+f2MGRHl7EOXoPzpZ9/X4K8zrGirA4SdC2pAcDw3/6EgLLg/leQFBh1l9O+ZtGTUSC7wmYTWS79HRw0mPBVyETh2TOk/voRGLzF/bpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKnYFYHCcSERU2my6nv7ZicSOdykUOyRLHxpaJnAmQc=;
 b=WofQuqnfDtLhvbEUP12GIlKKP89n68fvKKazLl3rhhCgxSO3efMqRv649n6+uUCGx3wJ8fv48rny5TL2fypnQiaMCyPQg9B0WXZjRQs81FzkZo2agJsXyOWpB+brEksrp9T6dfqpmLqVctxbYVJK2Yb4rocdYEvFDP6pDECfdmfgyKOQH14q4qefDjvvIEG1KDtrwYqOR0qku7PeIPz63TMotdSBoUg1JZ/10mKcMIEny8dlGsyP+sZ4tfhokt32RXKvpLkj8EEcUu5LAIzTQtxk0jPxIuDj5pjx5aE7DY0zrSWnQwmruNzHrB/Cp3qbkUTi2jbcIrPXbkCakVxLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKnYFYHCcSERU2my6nv7ZicSOdykUOyRLHxpaJnAmQc=;
 b=Mxkq09qCe+c8Ai5jXWtl2ydatwoU6b1w0XCrFODbIugv9no3ANSEQ4BjCRzK4I5S4c6j207sT9elpKHlJPkCAPrxAef2oDQ5BazXc7hiBjWit7YpeeDLc3x/sIwnde0YjGRjIwzwT/YMOOlEurVf1XgCnVZCEW4gGBfOT/2C7/uTiFRYe1jZyqho1wZY+MGQEIt0RrX28t/XaQHL3aElAf8pz5+cTXitcuBshf0Ckh9C/QdoRIDFqX6ErXo7KnkcJdXUXvdhDt9gSSjmhjnRD3NJ7NiDOD2qq08bgNqvHS/Jl2dfxUle1ckIFxI8KkKsFysU9cIhgSzg6XAGyzx5ug==
Received: from CO2PR04CA0118.namprd04.prod.outlook.com (2603:10b6:104:7::20)
 by DM6PR12MB3500.namprd12.prod.outlook.com (2603:10b6:5:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Sun, 2 May
 2021 20:41:50 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::34) by CO2PR04CA0118.outlook.office365.com
 (2603:10b6:104:7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Sun, 2 May 2021 20:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sun, 2 May 2021 20:41:49 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 20:41:46 +0000
Subject: Re: [PATCH 04/16] PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take
 pagmap and device
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mm@kvack.org>, <iommu@lists.linux-foundation.org>
CC:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-5-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <ce04d398-e4a1-b3aa-2a4e-b1b868470144@nvidia.com>
Date:   Sun, 2 May 2021 13:41:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-5-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2583174-43b5-4931-abba-08d90daab5f1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3500:
X-Microsoft-Antispam-PRVS: <DM6PR12MB350042EA82BC6ACF1DD725D0A85C9@DM6PR12MB3500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ckiJSm6M2bGvz/Eair+ojrLGv1wpm1yLGW7r/Sj6BU2Vwz/ryGwJ1/pgZEwI5JDleKxdROdDHb7y7cvljFOo4M787Hr1KTbLU+7SVveAsNcadRaaJph+zpbJjXY5qdjjBiKz/c/xC0h15Bx4F5wtJ0m01+1l8tx242KVnvR5AUuy88y+TonsRMUUH/DnWsfqfL7B14OzwtkCwYO/TF0V/h9ZrxaA0WNCOL6zz+piFig9ZZn/LyGMtVUkKWDLLOuR/5baJJ2RoyTBPel2tUxRZaywwylSqBTOGX45zk2SNSNobI0jIi1+4xDwOaVFJwYbYgZD1BGm9ppPlrz7gpm4hladtVhB7GcrLgYV0hFpvuPalhB59UVW7/Lkvtbqo81u9NPBZ71MshGxqh6xrQhFmE21yNHLXQIEujY/3UdqmfrT3y+WULahQGglMnUbC5OzjDr239Br8q6Mznkz4HyMn1XxeD80/q5XYdhnfE12kYJ3uXdizYRT1l2lI6A4CMkKc+1hO4rJ+Am/8cxQ9Z9m4Mcf/M8lSd4XoCBKqqlN7hp74+T3H83FA221VBzwX24F0z4XHILtH6TNUQCnZaNV+isTzjf7o5u8ks7wQ8GM9nWzavT/6ZvQzYMd3LPCX9TTzKN5uoAXpNicJv97x0bb6gubw/sJofydm7GHS6qsrBtyA1OANm6xjqDTfiYMBIKi7nuKBzt5cFqSpPtTSu7iA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(110136005)(82310400003)(7416002)(53546011)(16526019)(4326008)(47076005)(31686004)(8936002)(356005)(5660300002)(31696002)(336012)(186003)(8676002)(70206006)(316002)(82740400003)(7636003)(26005)(426003)(478600001)(70586007)(16576012)(36756003)(36906005)(2906002)(86362001)(2616005)(36860700001)(54906003)(83380400001)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 20:41:49.6522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2583174-43b5-4931-abba-08d90daab5f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3500
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
> All callers of pci_p2pdma_map_type() have a struct dev_pgmap and a
> struct device (of the client doing the DMA transfer). Thus move the
> conversion to struct pci_devs for the provider and client into this
> function.

Actually, this is the wrong direction to go! All of these pre-existing
pci_*() functions have a small problem already: they are dealing with
struct device, instead of struct pci_dev. And so refactoring should be
pushing the conversion to pci_dev *up* the calling stack, not lower as
the patch here proposes.

Also, there is no improvement in clarity by passing in (pgmap, dev)
instead of the previous (provider, client). Now you have to do more type
checking in the leaf function, which is another indication of a problem.

Let's go that direction, please? Just convert to pci_dev much higher in
the calling stack, and you'll find that everything fits together better.
And it's OK to pass in extra params if that turns out to be necessary,
after all.

thanks,
-- 
John Hubbard
NVIDIA

> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/pci/p2pdma.c | 29 +++++++++++------------------
>   1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 2574a062a255..bcb1a6d6119d 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -822,14 +822,21 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>   }
>   EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>   
> -static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct pci_dev *provider,
> -						    struct pci_dev *client)
> +static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> +						    struct device *dev)
>   {
> +	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
>   	enum pci_p2pdma_map_type ret;
> +	struct pci_dev *client;
>   
>   	if (!provider->p2pdma)
>   		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
>   
> +	if (!dev_is_pci(dev))
> +		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> +
> +	client = to_pci_dev(dev);
> +
>   	ret = xa_to_value(xa_load(&provider->p2pdma->map_types,
>   				  map_types_idx(client)));
>   	if (ret != PCI_P2PDMA_MAP_UNKNOWN)
> @@ -871,14 +878,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   {
>   	struct pci_p2pdma_pagemap *p2p_pgmap =
>   		to_p2p_pgmap(sg_page(sg)->pgmap);
> -	struct pci_dev *client;
> -
> -	if (WARN_ON_ONCE(!dev_is_pci(dev)))
> -		return 0;
>   
> -	client = to_pci_dev(dev);
> -
> -	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
> +	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev)) {
>   	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>   		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>   	case PCI_P2PDMA_MAP_BUS_ADDR:
> @@ -901,17 +902,9 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
>   void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   		int nents, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	struct pci_p2pdma_pagemap *p2p_pgmap =
> -		to_p2p_pgmap(sg_page(sg)->pgmap);
>   	enum pci_p2pdma_map_type map_type;
> -	struct pci_dev *client;
> -
> -	if (WARN_ON_ONCE(!dev_is_pci(dev)))
> -		return;
> -
> -	client = to_pci_dev(dev);
>   
> -	map_type = pci_p2pdma_map_type(p2p_pgmap->provider, client);
> +	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev);
>   
>   	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
>   		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
> 

