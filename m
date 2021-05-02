Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95F53709C7
	for <lists+linux-pci@lfdr.de>; Sun,  2 May 2021 05:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhEBD7N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 May 2021 23:59:13 -0400
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:58176
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230409AbhEBD7N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 1 May 2021 23:59:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POi/Xecp3KdeLAfyWv7xtOu1MD6gYC6ifdTGACvkxhTwXn5bZIwpb5RIAJDjmCpLR5cpTOi3YN1e8POET+703tl1DG3Y9vWFg1H7HoNaUtNNf85UvRg/eNoSiMStf1CVZgVU7NW2Qr8qq0tLEtVRWqViLyI0zpTIRwsXEatlXzAGuAh7VnpcOCufP2q9E3ieQ1fhDw9MtYsR0BHHMZmSVbOWBvtBtzdb1H7zCgYwsX5oxJR1D9r3v3tTfqzshq6WJz9SN3XC8vFfOvwZoDf5p0mmaGu9HKmDpAbm0o8khTBq9L6KKiEoXrpEG3KfXkcg0nk5zD60M31rd1d/zjTohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2967dfxJFy8E/ntaJND45cJzPttmocbX0JqH10oLB04=;
 b=Ld6ShBo/IOZrvbtdA4BXWjI0wL8X/B6nzUegrzUngRbu4LaHuSciCANH5AAUVr+aeAbn2GaTQfqP25goz0t+NPygaegJbNU11DqNbSAqtEL+4RATrL0x3KEt7IQ1z0PijQCTLbRkqRY/4+5lFDT8mLnydypPKhqLaufh4Q5bNDl8VcKJkivHGc3c+NG/xP853419q01D0I1QjzHt5UL1HyMIECX7I/tVSbgpwHAbiqFvDMIoD9wOKqEm9MWBWNtz+Teyfq/Utr88fapJrhP3c2hBFWl/Zbro73Tv+jj94jgCACruU7JZeYdDDSio15os8BWa2xKpMzoaOsJclwbHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2967dfxJFy8E/ntaJND45cJzPttmocbX0JqH10oLB04=;
 b=dUIIdTezdfX39mwoy/tKklpNsAGv+tjkktZ014z3l4Jb87nq5MzlR/lLcON03+7mLqrp0Smn+41Iju+plAiaklZ5vVCvHJRcHq2wBKCfd1cKs2WQettNAw4WFxub0xrVsVWGlMB6TeuVUcZqgPrw4CuWiyKUwrRjeM1KNdU7UxQtgompr+rPV7UfMWd91jAbNNyQW+CvYE6PCuFU9w/Xhy0PtLKlruK8HxPxUwnb20NP3UYAyivH/CVEvAQt+Au39+oYqpROUktaIS5QuoIP6KyTRReYYTwuyjfTs4FBA0wnGq1g60biH/fx7KJtYUeIGu/tOlNzTpPLyptVHJo83w==
Received: from DM5PR20CA0004.namprd20.prod.outlook.com (2603:10b6:3:93::14) by
 MWHPR1201MB0224.namprd12.prod.outlook.com (2603:10b6:301:55::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Sun, 2 May
 2021 03:58:19 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::24) by DM5PR20CA0004.outlook.office365.com
 (2603:10b6:3:93::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Sun, 2 May 2021 03:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.32 via Frontend Transport; Sun, 2 May 2021 03:58:18 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 03:58:18 +0000
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
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
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-2-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
Date:   Sat, 1 May 2021 20:58:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-2-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea3d5f4f-029a-497c-1ef1-08d90d1e855f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0224:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02248C35BA0DFA6B73458DFBA85C9@MWHPR1201MB0224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3gl9tz3AekPp69OLif8bbLHq69PtghIy29Y3Z9TfzJCgwzvHLJmc8Qald1boG5bTMcgdVLtPFFHE+Jw9DWKD+ejfij6TN+7ivqscApbLN7lK/2RPhsVxAcbl58xC7nITjLLySGUxsaPS8vygwmA+L2pgdWsbGsqv7ix+/0RputJ+dlhwyUCK6yENi7fCiZ6XQ+3OqHZrdEi3eLv9E1hjfgYzsTvuQ9pfDoykMHMIBGghryr07zEpyqTIpnLNmT3W6fzgxM29NHT5hSncbah0GVtpK+Br42ktHtahVdWgKVrDWFLQ179Xtu0NOYglBCFwYvOwY/E8tZIv0QruEobXFdp7uh/hQEGYgcewBNx1yGVdU9gf/nHNW8f7WPbNMXliPZ9yyG6nZqd8FudXnFtZSNbBSxF1nki1iI8nn1HrnfwF02sNvwAhSqvPHjH6otpMM0As3xzhsZQsGFcfntVTEn1MzrLSeVC5krlywgT4qcOx8NF6KUieUfMYyiAHONFwZkKoAloIzHGTm2aJhxCO4Q4bp/au4j8X9YQdgmr90cws5DiuqsD6rbawCk8ICtTdnc6dDr2YPl1pOWuhrFB+jFKGbV1zIDIF0q5qJe5Z7adm9pxjmQOYPIFvWkhjj3AAm9tSFIHSni1196rUTqqELHKEWha3qc8QzMjrP6k8uyVZspFIGidS2IKf/oX4Tus42cWeXShesxf7cVr7V9vZQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(46966006)(7416002)(5660300002)(4326008)(2616005)(8676002)(8936002)(316002)(83380400001)(36906005)(336012)(478600001)(110136005)(36860700001)(426003)(356005)(86362001)(186003)(36756003)(26005)(16576012)(16526019)(70206006)(2906002)(53546011)(31696002)(7636003)(82310400003)(70586007)(31686004)(82740400003)(47076005)(54906003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 03:58:18.6320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3d5f4f-029a-497c-1ef1-08d90d1e855f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0224
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
> In order to call upstream_bridge_distance_warn() from a dma_map function,
> it must not sleep. The only reason it does sleep is to allocate the seqbuf
> to print which devices are within the ACS path.
> 
> Switch the kmalloc call to use a passed in gfp_mask and don't print that
> message if the buffer fails to be allocated.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/p2pdma.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 196382630363..bd89437faf06 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -267,7 +267,7 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
>   
>   static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>   {
> -	if (!buf)
> +	if (!buf || !buf->buffer)

This is not great, sort of from an overall design point of view, even though
it makes the rest of the patch work. See below for other ideas, that will
avoid the need for this sort of odd point fix.

>   		return;
>   
>   	seq_buf_printf(buf, "%s;", pci_name(pdev));
> @@ -495,25 +495,26 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
>   
>   static enum pci_p2pdma_map_type
>   upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
> -			      int *dist)
> +			      int *dist, gfp_t gfp_mask)
>   {
>   	struct seq_buf acs_list;
>   	bool acs_redirects;
>   	int ret;
>   
> -	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> -	if (!acs_list.buffer)
> -		return -ENOMEM;

Another odd thing: this used to check for memory failure and just give
up, and now it doesn't. Yes, I realize that it all still works at the
moment, but this is quirky and we shouldn't stop here.

Instead, a cleaner approach would be to push the memory allocation
slightly higher up the call stack, out to the
pci_p2pdma_distance_many(). So pci_p2pdma_distance_many() should make
the kmalloc() call, and fail out if it can't get a page for the seq_buf
buffer. Then you don't have to do all this odd stuff.

Furthermore, the call sites can then decide for themselves which GFP
flags, GFP_ATOMIC or GFP_KERNEL or whatever they want for kmalloc().

A related thing: this whole exercise would go better if there were a
preparatory patch or two that changed the return codes in this file to
something less crazy. There are too many functions that can fail, but
are treated as if they sort-of-mostly-would-never-fail, in the hopes of
using the return value directly for counting and such. This is badly
mistaken, and it leads developers to try to avoid returning -ENOMEM
(which is what we need here).

Really, these functions should all be doing "0 for success, -ERRNO for
failure, and pass other values, including results, in the arg list".


> +	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, gfp_mask), PAGE_SIZE);
>   
>   	ret = upstream_bridge_distance(provider, client, dist, &acs_redirects,
>   				       &acs_list);
>   	if (acs_redirects) {
>   		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
>   			 pci_name(provider));
> -		/* Drop final semicolon */
> -		acs_list.buffer[acs_list.len-1] = 0;
> -		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
> -			 acs_list.buffer);
> +
> +		if (acs_list.buffer) {
> +			/* Drop final semicolon */
> +			acs_list.buffer[acs_list.len - 1] = 0;
> +			pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
> +				 acs_list.buffer);
> +		}
>   	}
>   
>   	if (ret == PCI_P2PDMA_MAP_NOT_SUPPORTED) {
> @@ -566,7 +567,7 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>   
>   		if (verbose)
>   			ret = upstream_bridge_distance_warn(provider,
> -					pci_client, &distance);
> +					pci_client, &distance, GFP_KERNEL);
>   		else
>   			ret = upstream_bridge_distance(provider, pci_client,
>   						       &distance, NULL, NULL);
> 

thanks,
-- 
John Hubbard
NVIDIA
