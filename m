Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312585ADB65
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 00:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiIEW1X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 18:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiIEW1W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 18:27:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AA52FFD8;
        Mon,  5 Sep 2022 15:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIuZSN7bignulWmTYqMH/A8nW+rPgwPgSllIjEAhAe2AMij53ob3FxLS6wO04aegn9YklrGFBRCmwEamraQK5+Hx8g1PyeWrZaQFOyqmLDyosOtkkrpronC0uf/P1KaFhGXvvVhZRlDaV4x38yxZnPNATTkic4dbS+F/3k5XCRdSr2xgC24nrLrH4SNd6fgxsR95ecZ2Yy/5hSj9UvP6ZNmV7QiIcyQQVqatuNBzyB2zDlixABVTUDvXDAn+wrUuGw0yMd23GrE3Ap2fbjcs+QLEaBCwciMo9HfIaam2NDgc2QUp1gi+rU2bWhltBfW/donKY9d7OIsODLsZ8eEqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o+ZEsj4u+Mr2O36ppY/6DvuowU/2UX2TvICgOENCZk=;
 b=G/yWmNS4w9y1yixo5PXA0UWS7jShwYCgDa2H92aaQnJX7OjL5AWzIQ1q+bj9NPqaSVbIEBiEY4FOW9XikxnWXzwisTrcFjyrlPfZPQ4AXbNvUrRD2u1LCu7lrgGQtZskMDlAMASUW9FXYbAxBVyec9YLTKsaLqmo+nBU7KzVlXIKhx0TnLB7J45qQ+0dK8z9WPkv1h8ampaldpHXlUfb6GFFT5RN4sdfkW2jQJ1PrrH4iTxYZKyERECWq98YsvXB3D4yhX8Ma4gwlzTTvx10y12zmbowOx1vbthGCZpBX85w/tsaaBSTLQ6IAbThDMIZsY9SJ/OUlB3eK6ob5lcGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o+ZEsj4u+Mr2O36ppY/6DvuowU/2UX2TvICgOENCZk=;
 b=N28YYmEO1j39N0CIvDWW5AVRmfCyzG86ZKHTjSQziHPhryezJYo7Bck6aTLutdSSQAzGq8niYyVdyNr8T2rBxMfM9fadR/iLWnJXV1beYCEbczRdr/SEb6x9tiOJhMWa3tu4uetZcXng/M1pNs5/Qi8yWVqnxPMDH5oCAbvpiGMVvfY8q564dUyymNMQTNoPkp5I2SSoCfJ/GjY5YVCo2Fmo9Hfc4RsIbSVjDtcsXaatwwZO6b0h8zRe2dDTWFip5wgvJwF2h6+WblSX42P9MP/D7VSVpdm841COAxkOwxzIgLF4PCwHIlmpLWfuAjAIXDbuWfWTt3T2+2pMKESHTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Mon, 5 Sep
 2022 22:27:19 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 22:27:19 +0000
Message-ID: <cb59ea58-062d-6a3f-c3f6-69d9cfff1484@nvidia.com>
Date:   Mon, 5 Sep 2022 15:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting PCI
 P2PDMA pages
Content-Language: en-US
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20220825152425.6296-1-logang@deltatee.com>
 <20220825152425.6296-2-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220825152425.6296-2-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:a03:60::40) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c768b4b0-2eb2-4f06-d780-08da8f8dcafc
X-MS-TrafficTypeDiagnostic: PH8PR12MB6938:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pH/sOfCyCo7TS8tjhKGrfCuMPQAqHbdPFihOzpq90ZjRkSi7R0UAj1jPHEG9d/Q1d9Sy9HLx763RVKQ3CpYDbJhCqCBk0ZbDfJJDVLJtCJwSMNd+LSmNofP6+Xhz4SYzcAu4cmfKpISWxgNu2XNe6WqBE74SjbrabXvJqNYOqeQKdmdVAMOW6ntYceb6wvP4TzTH4OnJoE4/NqBuWJPKJrY50zB/Czh45lc01bsvKDxKV9kVENNubPNUOPlHf5Etnw/ikQhF7uslNbN37IcxsnXoGFo1miPekTvfbftg9GOTyRZvyLlPcbWZMdh9iViqO5Omp4WnhkAHV8hXoENWrLCwixH5gnwz1CekOR569jgXdT97rtIvNuMhSIYBnfpj76NKxUkFMHnfWquBbji/X3OhsGsO3X1D57/8INBXuIwIqLn1zDVlgK0OMemT9w8haEKzZMKUWtm6esDYcS7OTZqp+msF9iqDLAXYaiAITKGmlZoe3ax+UKggxqp8Qd/2qJI50piBMzaegPSbE33GArSglLqXjrDJrlvK0MiFvP1ZX/xLok6dZgRK4TzkttIA9B1bURrx4z82EDgbTp2QiXgb1wfzj79BJVPcvjQqMXTzrDtjPbSCJqUTogoasIHZe7NCFl0APjZPQfnTgv8iGaH9K/n2sJI02eLrgRHtD3HrKS2hLow6aiH3vH0w/9fH3HR10ph0j5kHXRhgDpF6tFK2CKJ2mGrvemKOmjsK4RBRGRpwt2FGo5ZIyCQVE/VMVPbj6NNGVAQJiX4dFFBujZhv+MqH72SAM1mr9UYI6mY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(8676002)(66946007)(54906003)(66556008)(7416002)(66476007)(8936002)(36756003)(31686004)(5660300002)(4326008)(6486002)(2906002)(316002)(478600001)(83380400001)(41300700001)(6506007)(26005)(6512007)(86362001)(6666004)(2616005)(53546011)(31696002)(186003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHpHTnZRQ1ljNEhFeGZ5YVRaT3lkeXFmZVcyQnp4ZlA4RzdBbzYyMUx3bU4y?=
 =?utf-8?B?bHlsUUgxN2gvRHlnTFkxSGJmOXpvSStWVndFVHY2ZnNXMW1UeGwwYzVwNHVj?=
 =?utf-8?B?ZGlrNXMxd0JHQUF1YUEzR1pEakg4V3Bwamt3TVVZUk04WTVPUysvZnhLbkVO?=
 =?utf-8?B?bXN4cEI1WEl2R2xQNlZ3NVNGUkpjbERKb3JGTFdXNDdhVUlSczZiS3hTWkg1?=
 =?utf-8?B?MW9uR3l5b3Bya0JrMGZHcFhqaEt0dnhTMW9XYzJjVmxIblA2WTJMZDNYMmJL?=
 =?utf-8?B?elVzNGhFRlNIUTA4SEd6ZmNSK0tzVjlnWFFSWGV5bE1qUzQ5Nlc0bWpRVk8v?=
 =?utf-8?B?VjlMMGthTUh4TDBhakZYbU93aXIyUVlGSkdVY0UxaVBqL3RnV0JLTHpTU2pC?=
 =?utf-8?B?V01YQ0lodlpmTHF2NlBQNmgybUR2bGpQQTF4MXJWbWVwbGQ2M0s1MkwwQ1Vp?=
 =?utf-8?B?L3ExMi9WWDlndlduWWtDeUZxUEsycDJtN0lQMTV4YUlWbVEvTWVRWWcwbFR1?=
 =?utf-8?B?SXVMZFEvTzdYalBiQjZZU0VkcWRwWTI0ay93TUp2V1dHNFJBanZ0ZnZZckZi?=
 =?utf-8?B?RXV4cGROMHpGejdFdFVKS0ljdTBWYlpXc3poYjBESU5xYzhQSVFoazlSa2l2?=
 =?utf-8?B?aVkvanBWbWlJakJYdWZUY3p5eVlrYVM2YnRmTTFoSmFQMGM5ZjBSSnNYc1Ni?=
 =?utf-8?B?RHpzMHRzTGx5aFNaM1NPYUgyTjc3QmJlbkN6ak9PWVh1Q3lVRWtTRG00dDVX?=
 =?utf-8?B?VENvNUF2UWovYUNmYWx4Zk5aSW1GK0VtYkhxMzAyTHB5enJ1WEhjZURtSW9K?=
 =?utf-8?B?aVhQNk9scHRoMUgrRVp2eVp5TGtoakk1TVdlNmYrUWtUVGN3TnNNdUYvZE5k?=
 =?utf-8?B?TDF0TVBOejFNOEEvd0NUUDh4SzI3UXI1bkZ6ZnRrR0JvcmFJUXNGcktXdEhQ?=
 =?utf-8?B?SEZPdGFiSDNncERtK3pNMGFXbWhvWHl0ZTRZSHIzdEw0K1VoVUc4cU40eFo0?=
 =?utf-8?B?bjRtOGd2blMvVVRla3ZOMks1Q2NhWnA5UDFEcjFCak1UQmhJQlAxUXdGdzY0?=
 =?utf-8?B?MDhValFNNXBCWDlUVEd6a0RRRitGQzJESDhVY09aTVU3d0w5RHJVRUZlenlx?=
 =?utf-8?B?WCtQTEFkUHphSkpVMDVNazlRdzkyTzlhYzRGb3ZUSjFmaDhJYWhnSWtFUk9h?=
 =?utf-8?B?eHFHdEJkOHpqZEN5ejQ3K3RmYjZ5d1hZS1B6TlpCMUorbjJOT3hjbENtQ3Vp?=
 =?utf-8?B?QkRBeDZyS2VTdE03MFg0T2YvcWwrRmpmaFlKUVBCa2tyTUFmeVBhZU5BNGVs?=
 =?utf-8?B?NHlDc0JtR2lMY0V0aFp3UGVNVnhHOTNnVzJOdm5Gd3JqZWhMeCtvVzg2SVk0?=
 =?utf-8?B?emcvKzArTW1VcktvVkNacGN0SjVTQWwwYU1FbG9vRmxNWm9ybXk1NHd4MmdG?=
 =?utf-8?B?UFpIMHFYcHJBM0crUGc1aXVJbHNEeWQ4SUlCQURpQnozQjVORUJvMEM2Rnlj?=
 =?utf-8?B?QzgyUHVPY0xUOUNac1FORVBFczdlTkhGTDQ0L3B6azVqRmZuT01VUWVMdEI3?=
 =?utf-8?B?cnBjbUc2NmJmQzl2Yi9hOGQyT0MvSWdzS0pHWHBBVGVJZEVpUGFsUEpsa0FN?=
 =?utf-8?B?VUN1UzZDc1FwRmtXaUZPU2hXMk0wVGpUaFdQUzRxSEhtK0VFQWc5L215bThJ?=
 =?utf-8?B?MU50T01JZWhXOWZSbDFHTkxWVk1uOUd2U2pIUHI1bDFYS3RXa3NxWndoYXBD?=
 =?utf-8?B?UkRPa1QrSmtTRUpkblF1Ynl1Y05qcGg1NFpIcTNRZGQvL0U5djN5cHVKTGFM?=
 =?utf-8?B?ZDNPOXRQclg1aEpDTkJmVDVRMHhucUxrY0tScS92V0pGVjJmbjdDZW1hWXhP?=
 =?utf-8?B?WHRVSUtabVB0ZjByUVkrSVQ5ZWNLMFpOdlZXM1BOZnZxQ0Y5VjFjL2VvV3pP?=
 =?utf-8?B?Q2tEOWRlbUt2QmZoMjYzcmxCUVdsNGpTY3RtQXlucFg0Zkc2L3JXZktKMXRT?=
 =?utf-8?B?MmZSa1RlVWcvTllyTlFZc3F5WlYyN0FXd3g4RGpSUTBNK3FKTEJZalF0Z0ZO?=
 =?utf-8?B?dFR3VDBQODNWUDhtYzVyN1dpY28wQ2VjT1FBL2xFZG9RYzB5LzlrbUszRHVp?=
 =?utf-8?Q?9L9HOAhRiyvzkcxox35G1ch8W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c768b4b0-2eb2-4f06-d780-08da8f8dcafc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 22:27:18.7106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXuFLw46o6h3Q2RJySBheOQfyH62aM44OOcLIK0SUMrZXe4rrimH5khc5SPk7mfDD499rELSnT5TTSrYNNUkYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/25/22 08:24, Logan Gunthorpe wrote:
> GUP Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
> allow obtaining P2PDMA pages. If GUP is called without the flag and a
> P2PDMA page is found, it will return an error.
> 
> FOLL_PCI_P2PDMA cannot be set if FOLL_LONGTERM is set.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/mm.h |  1 +
>  mm/gup.c           | 22 +++++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 

Looks good. And I see that Dan Williams' upcoming "Fix the DAX-gup
mistake" series will remove the need for most (all?) of the
undo_dev_pagemap() calls that you have to make here, so the end result
will be even simpler.


Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,

-- 
John Hubbard
NVIDIA

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3bedc449c14d..37a3e91e6e77 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2891,6 +2891,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>  #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
>  #define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
>  #define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
> +#define FOLL_PCI_P2PDMA	0x100000 /* allow returning PCI P2PDMA pages */
>  
>  /*
>   * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
> diff --git a/mm/gup.c b/mm/gup.c
> index 732825157430..79aea452619e 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -566,6 +566,12 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  		goto out;
>  	}
>  
> +	if (unlikely(!(flags & FOLL_PCI_P2PDMA) &&
> +		     is_pci_p2pdma_page(page))) {
> +		page = ERR_PTR(-EREMOTEIO);
> +		goto out;
> +	}
> +
>  	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
>  		       !PageAnonExclusive(page), page);
>  
> @@ -1015,6 +1021,9 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>  	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
>  		return -EOPNOTSUPP;
>  
> +	if ((gup_flags & FOLL_LONGTERM) && (gup_flags & FOLL_PCI_P2PDMA))
> +		return -EOPNOTSUPP;
> +
>  	if (vma_is_secretmem(vma))
>  		return -EFAULT;
>  
> @@ -2359,6 +2368,10 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>  		page = pte_page(pte);
>  
> +		if (unlikely(!(flags & FOLL_PCI_P2PDMA) &&
> +			     is_pci_p2pdma_page(page)))
> +			goto pte_unmap;
> +
>  		folio = try_grab_folio(page, 1, flags);
>  		if (!folio)
>  			goto pte_unmap;
> @@ -2438,6 +2451,12 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  			undo_dev_pagemap(nr, nr_start, flags, pages);
>  			break;
>  		}
> +
> +		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
> +			undo_dev_pagemap(nr, nr_start, flags, pages);
> +			break;
> +		}
> +
>  		SetPageReferenced(page);
>  		pages[*nr] = page;
>  		if (unlikely(!try_grab_page(page, flags))) {
> @@ -2926,7 +2945,8 @@ static int internal_get_user_pages_fast(unsigned long start,
>  
>  	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
>  				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
> -				       FOLL_FAST_ONLY | FOLL_NOFAULT)))
> +				       FOLL_FAST_ONLY | FOLL_NOFAULT |
> +				       FOLL_PCI_P2PDMA)))
>  		return -EINVAL;
>  
>  	if (gup_flags & FOLL_PIN)


