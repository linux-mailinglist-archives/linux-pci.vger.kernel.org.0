Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6035ADCB5
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 02:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiIFAyb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 20:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIFAyY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 20:54:24 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36044C618;
        Mon,  5 Sep 2022 17:54:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmqpRaWmOOWMl/Hp4c1OytQfmVyqOVPYWvDDd5BBnPHO+NkbJ0sakApAEEnPyExKXXBUvICuhqlJJ0r3E3UIG8fyruL+9m1B+w+jdnIA2C3xfrQZocQHkQ+jfHpyRfO1/Vyqxe9x2l4VP9gn++GnZpIQUeGl/zi87mQ/sC+rEHCT3zioDGEgC+dNOjl4MmT/afJNQ85NPvQo4Q66+gCajiHu1XB45qYeyQM7SMxHUF1TNIWv6CCZJMtLXWxze39N6p1jhsEKSbmr+gp/vCx7GKfD4wXBoh0J9u60QnNk+nxbZVeKQniN2T58un6hQAWkM6ellENJ9D8UFii1aeWXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaAizI2gBE4SGUfqZlyjoPlE77vmB2ErKSz59vy3BOA=;
 b=Blvt+VCTNFGZgdehn4PmUvjqqsaeXEfQNcmy0Lm7pcR7lZKJx3tWbRX7RqH4FjrLkpKaG/2lenPX8fPQfiMujIDjx/2bCY2HGcefhC9dy9lYCb+bpUwzaUZiJ+JMNwZDhUdvkrp66g7YlZwuZh9wSuPBijyAfqvjXq87L/BuQMSyoCXAXzr5yc9A9T4AwoeCyzYS3JVqkdqLAg0jcvScNg1wYCeLH9Gt9CQURaiVs1AOpC49HlDQKZf/vMhYANBFAZUHteRPBS1041sX1SzXK/P/aoFNHP2CeT0Jf564zwH8OaGaxDTgyaejzD2ZjA06dbDOUMl+5AwTbQ6FWq5Wgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaAizI2gBE4SGUfqZlyjoPlE77vmB2ErKSz59vy3BOA=;
 b=rlGAsQK2z6B4zQyCdTTFP3oDEiuKKeymw4RpEfJDtU6U1kUb7vjp6gBz9057XBgjlAgWJ4lGTXyi7J+hIMmpcW7N2B8OyWvqQq1OhhkNJzF4c3LFQKE0EiaFox721+JcrZxobA4RA5KFHGzHM2ymBKxbNw2nC8eX7dNbeGk6lf33/Xxi1wAMBgwPPcEde1XcOpYwJVQnWWOQ4Kuyu/q8KqArf2Ehx1MhkgtDvniuod6NMfOhkPTjKh8k6lD1gqgAzN5GAwCcmbwGcZS8QMjkcfscatdhwCRZrvuZ8dkM8W8xuFj3uyQdcHqKRcHbout7TGfqR9FVsIwYnNBJnqJ3sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 00:54:16 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 00:54:16 +0000
Message-ID: <7b0df76d-a920-90a1-2e1e-044671c386fc@nvidia.com>
Date:   Mon, 5 Sep 2022 17:54:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9 6/8] block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
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
 <20220825152425.6296-7-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220825152425.6296-7-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:a03:114::37) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de65a855-87fc-4b05-6eb6-08da8fa25293
X-MS-TrafficTypeDiagnostic: BY5PR12MB5015:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6e4AQ9Gm2fTCsuYtXCJEaQvYv1j1Gokb39TYyq+SkVwE118j7eNDAIXfplVbYJ921Eiyn3tVm4Kf6sym1lKA6SgyKy77gicYhnfIlhfY5BauIAPxiN+HfFeBPCYlqYpXVZJHFjKCodsHiMlcLoKDvQQXp4D6/DFNPQ+BDymE7N4J02aolWzDslW8nhBmIaLrHf40vItCvLW06WHbGbt0aZMfzwu+Vz+rnKQPtARJW5q/0ok6uMs9PbqycFZH9G8stQrzNxkJzlvQb3tITwe5VdeVuAyYDoS6zja+kVRi4lemUIuulZZBHN4OpIvTXECr3KtD+t+3Ujr5/VrEXhDk2wIeGU5qtifOiRHoZL2PbFQBzM26EFZ1DEeBejK6plvNYW7qjkoYZhBpu1ZgnpaXLnsiwGrcTJQMj/+pQAaioxI9D/IYYtjPAf4Q1xzM9oEnDDHEobd8mMokgSaQRVDazkspSdko3Fw6q6hgN6Gd6Ed5YrVnzY52oELSpgr3SQpxQSeexOGO1m3YLUGf0j4+Qgbyu092+BEskoRjff1hqg3K0VfoJLS8LVhIUzlnMK8omgqImEdpXHghiZIB2TpMGiOL17WVvCgKmVkH3ctNZvcVG5U3NR5qRejaamgEhWaG7ETTnuUcAek+05Y1zV32RuS6q1Up0aaIuLhqpp1MVdlb8qwJGBK7clC7gHDgT3LB21+o3r/nZzQ7pzvMZuD0naiTDoFFkAsfgNx33Md+20NeD0EuySkwIigQtgkp6u5Wut5zcq/5uEmAqe2iWAvwKFz+TCOajxvqJX4SUzfbAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(86362001)(5660300002)(2906002)(7416002)(8936002)(38100700002)(53546011)(6486002)(6506007)(478600001)(6666004)(316002)(41300700001)(54906003)(66476007)(8676002)(66946007)(66556008)(4326008)(83380400001)(26005)(6512007)(2616005)(186003)(31696002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnliZXZJejZTUTVGaWFxWWdnTzhabUtVaE1adDNNVEdINC82M24vYzhsclM3?=
 =?utf-8?B?WGdzVUR1aUlpdG03amNMckVBUlBKTFgyYWEvdkY0cGk5YU93djI4WjJQamQy?=
 =?utf-8?B?cTFLeXZndnZSUDluVnRDQ01BZlVSeU12emMvZFhuNFgwMTFFVEQwdE5XaGYz?=
 =?utf-8?B?UmViOXQvb2dnSzlRWUl6bmJnNGF1UEpVQTZWaUJiUXB6bHFHSnpjRnd5dVRG?=
 =?utf-8?B?d2tUNnhHZDFpTUFmV3R3aUNUSklhVGdqWFhhWHJVenFWMlZYT0tQbmg5bkg2?=
 =?utf-8?B?a2FCVVZrM2prc3J4SUM2b0RYQzVKcjZvVlpFei9Oa29jZTExeTVvTTU1aXdT?=
 =?utf-8?B?ZHo4dElvS3ZSZmV3ZGp1cHduekI3UjloYUFDcE9oazduaWRCVmpvTGIvUkJC?=
 =?utf-8?B?K05zcW5wZ3hHTitWVEFmVHdiOEFtMVJiN1lQcUxxRkgrdVVkN1FvQUVsQi9v?=
 =?utf-8?B?VXI3d0hkUG1VOWhlSkFmR2UrWDFQbFJNdThDWDhwSW9iS2xnaFFFL0tnOU9I?=
 =?utf-8?B?ZkFkcW9BSG5CeWNrR1Z6emFPZGFveFNmcFY3QWNFeFRtdmllbzF0R2d5ekFD?=
 =?utf-8?B?WnYwcFhpRXZTRTJKMzZDYWwzQlVVWGZjNFRwTVhMVkFNMVlQRW9sbUxHdFJq?=
 =?utf-8?B?SUVZaExxVmU2d3dvSTc1WURGcms0S09uNlVBR0llNkI0ZmErT3UxenpNWFRJ?=
 =?utf-8?B?NWg3aHUrZ25JbHBsWTMvcDNod3RMZjFsL3hqK2tZaW9jS2ZUY0hYRHFTV09n?=
 =?utf-8?B?YjhZVGJFTEpNTXFlZGpFekRabUZNQXRyWnI2a3NkTTkzR0N1V2MvSUxPZHNp?=
 =?utf-8?B?M2c5ZFkwSkFnUUhtU1pRbDFRTUFOTllOT1Mzc0FtclFkQ2ZpS3Rnb2UxVHpT?=
 =?utf-8?B?aUlzbHE3Mm02a1k5QzlNSGlGVGxEQklZVTlHVEkwaHU1cnk4WGF4WGF0OGN6?=
 =?utf-8?B?OVJSWXpIUlIyWm5oTHFWemxsRE01UVY2aVE5M0pvUVJ6R2pVT05PUFQwYkhD?=
 =?utf-8?B?Q05XT0tiYjN5UVNIb2laQXhmd2tzeFgvcEVyOWlCVXBJbU5vRjF5MWFsWjc0?=
 =?utf-8?B?azdhQ1ZEQnV1ZFhtdDlVVHl3VzB6QW9salJPRllpK1dhdmdJNGgyLzRjWHhW?=
 =?utf-8?B?cHVEQm1UeEhhRmJCWXNORUpERElvbnpnOEt3Z2tHYUpoZEpzZTIwKzZCVGRN?=
 =?utf-8?B?c0hlRkJabWNSTllYUFlLcXhVTHp0cUN2SFFZdXJYVGJXUHg5clNzSFFWRWF5?=
 =?utf-8?B?YStaQUp3cGlNeUxxSG9sb2ZJSWlzdGhreHh4cWFrRWVQdUdHQUVvcjU2bzVN?=
 =?utf-8?B?KzI0amdxTUphZkZaNFdsL3E0ZHdzYnF5c2RHenZQeFBQM0tBU083QVhLNk9i?=
 =?utf-8?B?aDVQaXhnY0JHWVFUNSt4Z2haUVlHUnYyU3IwMG44ZVZibFNRNUdJcHB4QWNC?=
 =?utf-8?B?L283bXNSbGIzS2ZuUGJVeStUdDBMMVkwS1d2Um9hdVNCejRmQjJqRDlFaVR4?=
 =?utf-8?B?ZDkzNDZqNDE4TlJpL0IzSml1bjdJQzZBSkRIVUYwd0xRUC9NdkJDMHp0cklI?=
 =?utf-8?B?WHUyS1ZFZ2dwTVFkV2pXQUxlcGlCTGJwMno5cTFuNkVpZlk0a2Z4MVgvYWxn?=
 =?utf-8?B?cmNlSnRJT2hiSEx3cnA1clp5SzVBb0haYzZaYTQ3ZkM4QTFKeGFSMFpDQjVh?=
 =?utf-8?B?UjZIR2lSREVZSDRYN09RQVEyYStSUXNtZ3NVOHRqU1FxdDM1WEpYRC9ESjgz?=
 =?utf-8?B?OHFDRmYzejB1VkhtQWRkcTR3L2VJcTE4TGgyOGNibGw0eFJOVGtSdW5uT0FO?=
 =?utf-8?B?YWh4RlJRVWVkKzBmZkRVakIyMXViQ3V3Qjk1aFowNVVrWXNqa2ZZMXhYbzY4?=
 =?utf-8?B?cDhmbkgvRk1BNXRzMHpORVd5QzR0S2F2dERENGMzcUZlbTE0YWhXL29BdDY2?=
 =?utf-8?B?SXNvY1VBWXpzaWZSUHp3SitvQlFydTV0RlZCajk0UzN6Zy9TaFFURzcvTTEx?=
 =?utf-8?B?QzQ0cGl1bnIxMFppRmJMWGk0a09DWmt5WkhkMTR3T1lXUU1nQjF3OVdSQ1BG?=
 =?utf-8?B?VzV2NlViMVFudTMzOTJaeCtKZ25aUXNlZDVpSzk4a3ByVmh3S3JlWDhTaVdi?=
 =?utf-8?B?ZmM2NnhWczFWcDFYZkVCUCtEaUxwdkRtQ2hUVXJRVDJtSzhpZ3hVNVhNL2xB?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de65a855-87fc-4b05-6eb6-08da8fa25293
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 00:54:16.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJB7sBEkS/0j3niTvSPJ35DkiwwfToCBZW1Tc0Lb0M7vmOQ8qWBQoptkW5UMrXRQieRVe3WALrRSxOxWAlDngQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
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
> When a bio's queue supports PCI P2PDMA, set FOLL_PCI_P2PDMA for
> iov_iter_get_pages_flags(). This allows PCI P2PDMA pages to be
> passed from userspace and enables the NVMe passthru requests to
> use P2PDMA pages.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  block/blk-map.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 7196a6b64c80..1378f49ca5ca 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -236,6 +236,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  {
>  	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
>  	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
> +	unsigned int flags = 0;

A small thing, but I'd also like to name that one gup_flags, instead of flags.

>  	struct bio *bio;
>  	int ret;
>  	int j;
> @@ -248,13 +249,17 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  		return -ENOMEM;
>  	bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, req_op(rq));
>  
> +	if (blk_queue_pci_p2pdma(rq->q))
> +		flags |= FOLL_PCI_P2PDMA;
> +
>  	while (iov_iter_count(iter)) {
>  		struct page **pages;
>  		ssize_t bytes;
>  		size_t offs, added = 0;
>  		int npages;
>  
> -		bytes = iov_iter_get_pages_alloc2(iter, &pages, LONG_MAX, &offs);
> +		bytes = iov_iter_get_pages_alloc_flags(iter, &pages, LONG_MAX,
> +						       &offs, flags);
>  		if (unlikely(bytes <= 0)) {
>  			ret = bytes ? bytes : -EFAULT;
>  			goto out_unmap;

Looks good, please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,

-- 
John Hubbard
NVIDIA

