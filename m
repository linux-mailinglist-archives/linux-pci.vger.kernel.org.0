Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8675ADC4F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 02:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIFAVM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 20:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIFAVL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 20:21:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF5B6555D;
        Mon,  5 Sep 2022 17:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkLzyEacFKHWM/TtAMxh0BmyxZZagssnmgbdz5+G4YHZB2JKBN/mMGi/whvqEGDDkyv6Vs5CQoSYNOWznbZHdu8Z9MUpP3tD2AnjdK26xPeSSTlXXbVb/AUaV8ZhnnlRUlM6i6Yzqdj4e6w5jASd7RjwhUZjIX/mSstxrYHmy0rNnPi151W4cRWejw0jMVsTREUEKhiCXwHrhg/ib4CGLkpfhF3dyMDOEBVUkXDaO+KiOcMa0QVZkcWpnis3RCzMrjRFEeQ+lv+JuhViDUTsZTpAKIDxOy0UPT61oCPB/rgo7aFM2VZhgjMAtNeQPZ9zVt0vshX4NXO72wLeIQou0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaK+eVi772/5Z3cw3ZCakayuFph3BZGcV8b42jCCEMk=;
 b=icTGZKSfW6mTvNHTp9mh83qDNyWF51E0BxlvVuXnux3cyaXXImu7B4Kdy4NDtGrZauxUJ7idL44d6P7iVnqIqqcuc2paBMULl1QREuLkKfDygVPEjIUoVYHRlGkF6tGbYd+CyCf2PBVX6E3QYP+m1XXVUTnjJMIZIXkYrTMZygA6FRLYm+dk+PUb8kq8q4HTxqfGzpuE4s6STmqoqL6kfeq32huNYZ7M+J3G9iKIxLJYbTbG+VsJHvMJ65swvjCaWJkHYTTVt3cVpZ4VlfXlODtWQR3lGLM3nEqYVjqPCtkGMFr5nU1YF6reks60nMfGQ9BAxXneswdEIgdmRA7BHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaK+eVi772/5Z3cw3ZCakayuFph3BZGcV8b42jCCEMk=;
 b=kWb/sWn8mNplgW5dvESa2XZiCpOmdVnnZhkJXYJXnFx+phqCxtHotpS44jVRoW13N4UzTocSgE03Poqk/LsyAPGqIaBDfDnWHWnvWUX0PyKUVGNVQ9ub0o1BU3iHJAvOHoNJgsZMojUrkJOT+sXvBcfNJyjF0B8M+251hcEiRMHSo6FR+qH1LhpffPpx/thC3n0yl9+A2iVVZsBR3BZtKs06DUAzQlHSSYPK7MXPnaeRsnHNiZettRSkJ1NfWUWmSSKcuw0Cd/gR1l3AcbRrCxRuQkQ09I9ApwYtA6LHM7IGXLhezvXqTvSJEPxHK5JGKaJ7gYAw5u6hX5GKQkAKcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 00:21:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 00:21:06 +0000
Message-ID: <f25d6ce8-b2aa-42ce-00b3-28818cd50f34@nvidia.com>
Date:   Mon, 5 Sep 2022 17:21:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9 4/8] lib/scatterlist: add check when merging zone
 device pages
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
 <20220825152425.6296-5-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220825152425.6296-5-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:332::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e63416c-44b1-488e-fb6d-08da8f9db0dc
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Etsv2v94uyDYfrm0Ik/X159klUr+WptW0gWAUdjmA+QwH9UBims2LXrKDRm6SPtDPD24G4TXRQqMo62ocgrg4QVsJW5gTYzfcZWSUDOPLZNORuKGTeX/7YQWszO3C8ax1ROa3dzIhKvtopBXXBuWlqAvFVn10au9g1PDRwSc0FhfbnQTv9dVIcX8AZ6Uqdd2EGUFy/KzNkYIQiuMVz0Ke2wKzTK4qaODTlAQtud/ol3t3kGcRzfIAb3biTxaLbhHkXCiRbc0/xAHnaAbMbMciwRz3ECIY/mPemwGJWBDv/GBkuj4bYpKrZdFp3ZKHl6vLYDJb1tu3igL2t4dCfYFTUM/CUYa3Jm/LYD+NZU9nlVkzp3sqV74iuOTdq3f2sQTm5SiUVijKAra/Z33OiVLm6JK/YOceokDOzBNuVa3Cg8HPbUXiI5IJOKrD5ZFgTWQXo6QRuSWdtvHEzca5oo3cdYuGhZka/z7WBF3RDD+YqciDOMytn+Fv2QoJQF9CX3LMSWFS3Unta/axuGoiN0Xb1WPnuJu9U5zx/efr/LfHqLFeenkFtwlEvtkWUsaTeub/92j8M0BH4GW17PaspquORYLjMvxl7AM87UEFeXeq/MkG0FYxM4H0Vfd8shtCr/wbTJObZUa1zv3GzME8JN+vZ9OZgwb9TRW8Rs7bNUsGQCzIf8+vTTowdMqrDSFoQorkJqgE2LsIk4CVIM6QSw83TcwjZdjjcQQP1F9owucrTytXCMYzFAr0bQbmoBd8OWAr84bygSnTojImILbZBqpv0KXyMLWjrF3AndykYd0A9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(38100700002)(31686004)(7416002)(8936002)(5660300002)(2906002)(86362001)(66946007)(54906003)(8676002)(4326008)(66556008)(316002)(31696002)(66476007)(6666004)(478600001)(6486002)(36756003)(41300700001)(2616005)(6506007)(26005)(53546011)(6512007)(83380400001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnRDeXNtdE10a2NYZ1Y0eS9mbnI0dGx0bUsxY09xM1ZUaHRudmxxSkdIV0to?=
 =?utf-8?B?S3p0SDk1L2NtQ01CNFVCRUNuR3pFckRzaU5NUkltMEFqRitReWZFY1QyVCsr?=
 =?utf-8?B?NStBVnpQb0pCbEdDZzBYVE9BbHNCWDJ6SGF5VVZqSzdUMk9ZYklsc0NNQml6?=
 =?utf-8?B?NEtXSHhXUjkzUEd4N0h2M0tUZ0QvdlV0OXd4UkJLejk5dHhWT1RzcTlzSzUx?=
 =?utf-8?B?REM5NzJPaURUZG4zditxc0tSeHZ4QkxRelpxa0hKRW5UMURXa1I0c2NsYThK?=
 =?utf-8?B?UWZ2OUlIdjdZZndTWnpWSjBqY0twbXNLTWNHeDFKQldUdzBQSmIvUGxheTJw?=
 =?utf-8?B?V2xCMjFadHpieVp5eXVCTXB2S3lkTVFJRFNsVUNMU0Z4eFJmWUxBRVJ1QWxi?=
 =?utf-8?B?NnFmZ1puUnUyQ2FTUUU2N2ZFeHZCeVM3VkZmOWRqNnFLWHkveW1saStrYXho?=
 =?utf-8?B?S2M3MmlkdE1hUHhpa0pmdmxzeGdzelE3ZjlBdHcrd3ZNcDA5bHl6NzBQUlcr?=
 =?utf-8?B?c0t2VUU1QWFLdXA0Nk9KNU5MK3VURENVT2tNVTNXdEdicXB2czlwS2ZRMEV3?=
 =?utf-8?B?NVdkVTZNUm9HVEJ0S3o5WTF6NVUwQTRFbk9WTTFnTnNEZnNpb09EMTh1TzZv?=
 =?utf-8?B?c2pnaURjZUxUSnpwZm16UTl0dVRHeUcwWHVkVUpmM29HS3hTUkMvOEd2cVV5?=
 =?utf-8?B?VjY3aWJWODQ0aWk3S1AzL2lKNENjZG41Q05kdXNTSXpiOENKUlVCbGNXZEIx?=
 =?utf-8?B?NW1uQmNSRkFsblFBdThORzRKcUM0a0VDR25QamlnQkxNdVUrRk9kTDI3c1du?=
 =?utf-8?B?M05tTmhyMHZjMFFFNEZjUGljU094ckhhem1rZDc5U2s0TjFGSkNwS2VJbzcr?=
 =?utf-8?B?cXhCcm4xRGwrc2cwTG5OZXJhSFF6YmpoZ2hCRmxxeE1JQkhwYzUwZXk2SmxC?=
 =?utf-8?B?Q3d2UWlFakJMUGhvdVJ6SGsyUWY1U2dJOWNzRnRoWUplOFpSdUxqSnJWT2Fn?=
 =?utf-8?B?ZHpVaHFDc3RBMm0zZFU2MzNqR1JjWGQzQkVYYTQveHhkQW4zTUhNTUtLN1Bt?=
 =?utf-8?B?UjZ1Ry9iTWZhYXNhZWx0ZlliTnFQMXFXQTBRblBPKytMUFB5ZXNWUDZoMElH?=
 =?utf-8?B?V2VtaUFDa1huZXhCd0swMU9Dd01pdndYWE54TXIxRGJhOFVRSTZHbjkwbXZy?=
 =?utf-8?B?bWR5dGdGNFN5Vmptc1J3blBaY1hqWFBBWmh2RXU1dTNOUklmeTFORUJkd1Rz?=
 =?utf-8?B?YmVBclUrekNGR2pEb3VINzAvQ2lKS2loWmFUYlRtZHhsRjZTMGFhN2NkcnIv?=
 =?utf-8?B?Y0lYOW5ObGFjYXQrdmRQQUdSd0VLVmNINStpQXJFcGJXejVaOEVaeEN2bHVY?=
 =?utf-8?B?dUZoYkdkZVordUlmR2RoTjlXZ1ExYzdxS2w3RTVRaElYR0pSQVNwV01ydG4r?=
 =?utf-8?B?RFlHRHlWWDBsdEI4d0VDUjlRNDZGZ0ZTSVc2a2I0K3d3Ull6OUFCZU1UMmdn?=
 =?utf-8?B?SU1GSU12VGc4cDFRZGM2SFdWeVhHM2NxRWU2dy9scHFEY0Y0VnAzcnhBWUZo?=
 =?utf-8?B?bGo4ZVFNZXlXL3ZLb2x2TmlvWGdnemxYWjg1MXRnSW5Uc2MwODFCZURiU3Ev?=
 =?utf-8?B?Sk5LWEVPY1UzOUl5UFJTb0tDWHRqcVNBSFV2RzU5VmltNHpFZ3ExMThJdGg4?=
 =?utf-8?B?SFBoL09mWmFnaVBxQnNsclQ0OTlicTc3bFEvVVNqWUVqK3UrUklqUHhGTkFW?=
 =?utf-8?B?Wit0TDRmTVhVZjdkbkVzcCtiRXdaREFtMTRUd0kyL2JYS3gxOHlHWVlBMyt3?=
 =?utf-8?B?dkZLS1lPS2p5Mno2YnlzeU9pMGxGcXJZNUpObmh2ZzJnMTdrWkZqUllVVFNn?=
 =?utf-8?B?enozVFp0TVc4WXlrQnp3RVovNUFVdHhaMEp4Q0x5WkVtTkxueitmTnZYaGlo?=
 =?utf-8?B?M3BMdTNCcWp2V0RjYkpoZW9RU0tLTEo5ZVJGWEJPSm5VZ2hHRWdUVk0vS2RN?=
 =?utf-8?B?MitJVTdBUjFUNFNyR3lsaDVuWXB4eEZmZE5XSk1MbkpWaEZUUGJLa3laelg1?=
 =?utf-8?B?ZUFLR3lQWUR5MFc5OTV5RzFJdHhXL3lrT1FIdlZkZFA3S3R6eHlpSVpUc2lM?=
 =?utf-8?Q?m80mnatiXvmN9JjOd+5jKl2hH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e63416c-44b1-488e-fb6d-08da8f9db0dc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 00:21:06.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doWU0Jte/LCEKTSeW7BHWrJJqC9AqGLTyKtiNvFeV8ouJWI0zkbMLZkefcs3m2UeRoA6GF8gHTtGdDWf3zJaUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
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
> Consecutive zone device pages should not be merged into the same sgl
> or bvec segment with other types of pages or if they belong to different
> pgmaps. Otherwise getting the pgmap of a given segment is not possible
> without scanning the entire segment. This helper returns true either if
> both pages are not zone device pages or both pages are zone device
> pages with the same pgmap.
> 
> Factor out the check for page mergability into a pages_are_mergable()
> helper and add a check with zone_device_pages_are_mergeable().
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  lib/scatterlist.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index c8c3d675845c..a0ad2a7959b5 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -410,6 +410,15 @@ static struct scatterlist *get_next_sg(struct sg_append_table *table,
>  	return new_sg;
>  }
>  
> +static bool pages_are_mergeable(struct page *a, struct page *b)
> +{
> +	if (page_to_pfn(a) != page_to_pfn(b) + 1)

Instead of "a" and "b", how about naming these args something like
"page" and "prev_page", in order to avoid giving the impression that
comparing a and b is the same as comparing b and a?

In other words, previously, as an unrolled function, the code made
sense:

    page_to_pfn(pages[j]) != page_to_pfn(pages[j - 1]) + 1)

But now, the understanding that this *must* be called with a page and
its previous page has gotten lost during refactoring, and we are left
with a check that is, on its own, not understandable.

Otherwise, the diffs look good. With some sort of naming change to
the args there, please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,

-- 
John Hubbard
NVIDIA

> +		return false;
> +	if (!zone_device_pages_have_same_pgmap(a, b))
> +		return false;
> +	return true;
> +}
> +
>  /**
>   * sg_alloc_append_table_from_pages - Allocate and initialize an append sg
>   *                                    table from an array of pages
> @@ -447,6 +456,7 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
>  	unsigned int chunks, cur_page, seg_len, i, prv_len = 0;
>  	unsigned int added_nents = 0;
>  	struct scatterlist *s = sgt_append->prv;
> +	struct page *last_pg;
>  
>  	/*
>  	 * The algorithm below requires max_segment to be aligned to PAGE_SIZE
> @@ -460,21 +470,17 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
>  		return -EOPNOTSUPP;
>  
>  	if (sgt_append->prv) {
> -		unsigned long paddr =
> -			(page_to_pfn(sg_page(sgt_append->prv)) * PAGE_SIZE +
> -			 sgt_append->prv->offset + sgt_append->prv->length) /
> -			PAGE_SIZE;
> -
>  		if (WARN_ON(offset))
>  			return -EINVAL;
>  
>  		/* Merge contiguous pages into the last SG */
>  		prv_len = sgt_append->prv->length;
> -		while (n_pages && page_to_pfn(pages[0]) == paddr) {
> +		last_pg = sg_page(sgt_append->prv);
> +		while (n_pages && pages_are_mergeable(last_pg, pages[0])) {
>  			if (sgt_append->prv->length + PAGE_SIZE > max_segment)
>  				break;
>  			sgt_append->prv->length += PAGE_SIZE;
> -			paddr++;
> +			last_pg = pages[0];
>  			pages++;
>  			n_pages--;
>  		}
> @@ -488,7 +494,7 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
>  	for (i = 1; i < n_pages; i++) {
>  		seg_len += PAGE_SIZE;
>  		if (seg_len >= max_segment ||
> -		    page_to_pfn(pages[i]) != page_to_pfn(pages[i - 1]) + 1) {
> +		    !pages_are_mergeable(pages[i], pages[i - 1])) {
>  			chunks++;
>  			seg_len = 0;
>  		}
> @@ -504,8 +510,7 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
>  		for (j = cur_page + 1; j < n_pages; j++) {
>  			seg_len += PAGE_SIZE;
>  			if (seg_len >= max_segment ||
> -			    page_to_pfn(pages[j]) !=
> -			    page_to_pfn(pages[j - 1]) + 1)
> +			    !pages_are_mergeable(pages[j], pages[j - 1]))
>  				break;
>  		}
>  



