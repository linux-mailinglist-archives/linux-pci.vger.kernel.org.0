Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF625ADCA7
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 02:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiIFAsN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 20:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIFAsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 20:48:11 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F8D69F7E;
        Mon,  5 Sep 2022 17:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWuRTM4EbiOG/XmCvhbMb+Y2mO96ieQVh07d7qvTD97pL8GEylMOhac5rIXinoMZwmO3wGkRUQ0vm9xDHsyjA8df//3VqsQqUMrEmi+G/fSguLNINJJjUY1xUETTQOkZ5+YZ6da6tU6zbd1djC254KJEV1N2C3O+41whiWPrIdl4jHb5fe5cXr0AqJKwUCXVgqqXtyqojdZqsz/G4H3UFiIwUUH88n2Mmk5WsaBSsSHtHqC5S/dy/Ww9/JAjozVRTxWVKvoZa0BmKJP3Fs0VfMNFEnkNZSdwSaTHz37P6k5DKxUAIELu7NMLRINrasDXznq3xz0XSoDFSLsXC9SKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMpDNlqw5o73e6GlZthus7WEbl56rkoXZgYyj7uksJo=;
 b=CLPTDc0bH1LqKehyqgKRNOgbrLTgsg8dyZBoTYrThk3zd3DACs5r5kp89IB7gzmT9NIFSx60ZoB3fHa884iq+8s3Iz4KdruTjgvhTmsQ5iR7VIGIt8I2kv7fcoHQdULfr8y2ZQk3CGY7e6SgXC9yOjtbpQeQTTKrs7a8cPM0uHfRNKYWsoSlnd5TRH7qKx04g7BaZ1HFwU02bLj1dEDK+FhepyIcKX9z4hPXgPs1qiwIZ3sKaKajlC1nbpsBJxJ3GzyYHaNqVEoQrfxNoYm/vr67tAey6a0qfx8I2H4bZNNK6aMXzrJL7mV9xGjfLyzfH+i3Ods/OCqIPFfJJft2dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMpDNlqw5o73e6GlZthus7WEbl56rkoXZgYyj7uksJo=;
 b=gdDrh8gF9a3ycqNEs8dSYsuouOKtIB7H6mymrZGLUsz23YproDK+BU0ZUeX5sI9v8j4i7uWVGbiRnqppcIjwdXsYmXJnOZQuqwuKX1hIpCr9oN25aXsPOSA45i0NmLynfJn45tEVCKpV+IgKEKTac8LkQq/9ZfiTQkffuYpyVUnGBeWGntupWdW7aIZ4x31aMZ5KMSpcjbxTEiHYWbP3u1ANxYxMmZYclhFeM0YPoadImv6CfypoTcg+SVBPZksg3uzsxqIXAPAJHdy4NXHU1JwI9Vik62urZ5k7TC0XW5iIKsHTHb7UEapWmakeoT+ML1GsdoaV5J3hQx6upLC7ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 00:48:08 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 00:48:08 +0000
Message-ID: <21eda152-c2ec-26bb-92f9-507b5378cd99@nvidia.com>
Date:   Mon, 5 Sep 2022 17:48:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9 5/8] block: set FOLL_PCI_P2PDMA in
 __bio_iov_iter_get_pages()
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
 <20220825152425.6296-6-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220825152425.6296-6-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:a03:80::20) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d3d1e81-8696-4363-2973-08da8fa17766
X-MS-TrafficTypeDiagnostic: BY5PR12MB5015:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ytIbQ72IjPhe7pWQWKJrjZN7h1I5exTHVXy3jweR2lueLrR9nNtxlr9i6VmZY1VHi1OC0AJQx4V68nqmh1r7j52Qr88nLYsaQt55imuGEUlQP/ofQ+6xBlPYTELVtPMTOuH2KXpL7RGnfkZF2582A/0boy0xo4GlDTZrwA58dYmdoRf3Z4XL9tje1qhZTXDZI53OVP+hVusQmapHGQ25fgEoh93XIbyze1jE/8JpFlKfova4lc83mD0VF56E6icaoGFH2Q18ljnNMAW4AtjTcHDqBTQmQpIbvzVmgg2TsOgXa6HPIKtxUdW60+J9HYnL+HsFZBZQNr57N7VOxDVE34w7rZNCQoOgdmR+FXhqwEm0kBma1BcHnyUdLxTSs2fdclkUw5UL/SSVHBRk92Vj5GYlnBQLYiROs010aSK94ivA4Qj4+BdSelh1OJK8oxb7d97RH9//qQoap8oassT6S2cIvCNIiOVpmunOuPRFDEPLQgVOQAyJg/hJZCcmh8CEAVGN68sqQvyEH1LTiFbnRUpZRC6Fw9hAiugymzf6bPBFJPEp5UM/01wn6FwizfuCdzBcKpSpD7diKBi8p1iuJNZ+63Ks4f9+7A1brPipX0qvGgDyD0O5THabkbuCNBQDJnK2H3H5NnZmDCFf51TLFbyqHMry2gNsq6Mj/CwP6Ix+9ziisbZ00X0pTsxX3p8WZngxMFRN5EbwV0XffHuyOJ47hrHDcTnFRlOQx7SqVVe3jrHfWrqmmUMPDgIlUSatqlXY7ArsdVVQbjb1QYcGGxasAzGVEudQvE3PdZsKjG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(86362001)(5660300002)(2906002)(7416002)(8936002)(38100700002)(53546011)(6486002)(6506007)(478600001)(6666004)(316002)(41300700001)(54906003)(66476007)(8676002)(66946007)(66556008)(4326008)(83380400001)(26005)(6512007)(2616005)(186003)(31696002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TitZOVdrYU12dTJsbGRsUEttV1lDZmloZlQ0cndqWFFwNzhGV1pCSUNFTEpI?=
 =?utf-8?B?Q2IrTkFHUUJJQ2ExeGNqSG9FeHJyRDdyQkdNSmFyWHc3VFNIV1kxajNDTCta?=
 =?utf-8?B?RzNuN0xGZTcxc2pRSWxNMWk3TW45cTNYeXFmU1RnNE93a3dxc1BQRThFMkR0?=
 =?utf-8?B?KzQzbVp5NVBML0xIWi9udDRJRXFHcG5ISisrRDVGU2l0enJZQmNxRzNxMC9u?=
 =?utf-8?B?UkplOWd4K1djaGhZamlSdXU1eVJLL2NQMXVBbjEya241YWZKRExaSDFsd1dr?=
 =?utf-8?B?cDB6VGU0ZXA5RmpZVXBFbGRUbzBIRmZrSTJacnZOU2NIYTJQcER0SnNhYnEv?=
 =?utf-8?B?Tm5TMzI2NS95cjM2bmo2TzV4ZjJCbWNVSUhGVXRYMkowV0U2RTV1cGdOSGtp?=
 =?utf-8?B?eDFiemVRQ2pCTEZQVWN6Z3ZWT08vYjM2dk1wUmNtRTA3eUJHbUYzZlhHN3Vt?=
 =?utf-8?B?Yk03ODFXWjNrZnhZL0dDZXR1MjU1VlVtK2R0b1BxZ2pDQUlkUS9ISy9sOFMy?=
 =?utf-8?B?dWdOb3FyZjdsTGpzWHpKZ09Veng4VGlaY0JEZVVZdjFCQnp5WUlGenNCNzJJ?=
 =?utf-8?B?TGxYaG1rQ0p2b2dMQlV5cHRLd1V6bm91T2xCSWJZckplZS9ZWUdIWUwwVGha?=
 =?utf-8?B?d2tMRHpDMFBtWFV2WHpRdXgyOVNqWXJiUHpIcUg5ZmRpdVFRK1oxVGZVOUky?=
 =?utf-8?B?VXIzQXVEYzVaNFpnYzJVOWk0RW1lWFBTTlZGN0RWUFJaSFl2UWhiZjE0MFBz?=
 =?utf-8?B?UXErOTU5V3Yvc0FlSk1LWENZRkhsUHNabGszUkFRdEVFcHNUTEJscU1CcVA2?=
 =?utf-8?B?Z1JLTms0UUxydHRNSHRIUlIySkZqNnRJUVorWVIrVHBST2NwejVkS3cxU2xK?=
 =?utf-8?B?NzBvc21sUURrZ0RhUGsxTVpHYWtuSE9tSVc3MFhIOG1LNE1pYlYxWTVVQnVz?=
 =?utf-8?B?SGFpZ05RWGhpbmo3Mks0ODlvVkRYa3g5Nk1BcWF3MEFENHJhTFBGZUVXbHFn?=
 =?utf-8?B?QW16VUdWNjhyUkdnT1VPNjVZTlZxNHVNTmY2TlhUL0NwWTlKeG0vOFZ5RE9m?=
 =?utf-8?B?Wk1QTnk0bDBTNVNzbFMzRUxLL1JkaGl4cGJwWlRaNFlUZTBrQlVCSzNDdXBR?=
 =?utf-8?B?Q2lmbG5xckovaitzOHBQNTNUZGdIRlhFaFlvRWY4NEhaWmUweXhJZVRUZ1Fp?=
 =?utf-8?B?NGZ0OXJXMEZQSXhpbE9tUUJjWEVidUJGMHR1cjVNLzFiTEt4WDloMHB3c29x?=
 =?utf-8?B?RFFVd3ZpMHBKbHdOM1doRXl5UGlKNktJeHplanhsRnlzRVBhaDFIQUxZNTEx?=
 =?utf-8?B?bkExS0tVZVlEcm5pSlorc0xWMVNUbW5XMWJMN0ZHaDE4RkVDU29nZW5IdGth?=
 =?utf-8?B?bENWSU43SkVSbmI1RW1SYWJoSnB4UERyczFKa0E3ZEhlcmFLS2M4WXVNdmpy?=
 =?utf-8?B?Y3VLa3drbVpkNnlydE41OFVvcFFxL3BqT2JXckFjWFZZcnBia3YrNnpXbGdu?=
 =?utf-8?B?Z3JpK3paTmMzblpsaWJUQVJVQVpTczd1aWovemU5bGt4dWhoT3ArL1ZEQi8w?=
 =?utf-8?B?K013QWt5ckNVdnhwRks1R0tLM25vYW5BU0VHNTQ0WTFXaURFTHRpazVzNU9N?=
 =?utf-8?B?UjhzaE9FL0t1TFJjREFRZ0lyZjlRZ0J1d0NSVGJsa2toMkdUcXpodXhWUURw?=
 =?utf-8?B?RE4xOWttK05DVmtvMGtSZlNxQ002bnJSbit2ZlJvNGQwQkx5eGdGMUFudTc0?=
 =?utf-8?B?OVdTN1VIK05iZUtIWWR5UHhIN2tuMlNBNEt3R2F4UW9KaTNtTlhFRTU4eE1w?=
 =?utf-8?B?OGM5VVF0dHdFTW5ManpQQkU2UVRRMEJDRkdoSllZUmZoTHVCd1QrLzlhcW1P?=
 =?utf-8?B?bU04MURFRHNYZmh0bUxOMjZZZmg4R29DcDR1N2tEb09PZFMzRlZIbDZlelp4?=
 =?utf-8?B?NjBrSzRqQUdIVHd5S2VRcHB0YVBtRHEyb0J3QngwZ1hyUEFrWVBIMlhXMWtN?=
 =?utf-8?B?MW9HdzYxVlRrbjJVd0ZOMVhhV2Z5NmhibjdQVlVhaFJyNTVvN3NEUzFmN3BR?=
 =?utf-8?B?Nkhzd2hWOFhySkF2OUttSGJBRCtpR3pXYXFPVkFEcEw3RXJ6RUFNWFkraEtE?=
 =?utf-8?Q?NvNWD9MHVI8E0H2D+YCZIp6k4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3d1e81-8696-4363-2973-08da8fa17766
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 00:48:08.3911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeqdGgiUj1tx6mTzBUbr+eBXf7jRRMbCPbbpNQxl/7nR2qIaxAOwvWjID/PrzmX2WpfKOg277wev3vsb1hhqtA==
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
> iov_iter_get_pages_flags(). This allows PCI P2PDMA pages to be passed
> from userspace and enables the O_DIRECT path in iomap based filesystems
> and direct to block devices.

Oh great, more O_DIRECT code paths. :)

> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  block/bio.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 969607bc1f4d..ca09d79a0683 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1200,6 +1200,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
>  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>  	struct page **pages = (struct page **)bv;
> +	unsigned int flags = 0;

It would be nice to name this gup_flags, instead.

>  	ssize_t size, left;
>  	unsigned len, i = 0;
>  	size_t offset, trim;
> @@ -1213,6 +1214,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
>  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>  
> +	if (bio->bi_bdev && bio->bi_bdev->bd_disk &&
> +	    blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
> +		flags |= FOLL_PCI_P2PDMA;
> +
>  	/*
>  	 * Each segment in the iov is required to be a block size multiple.
>  	 * However, we may not be able to get the entire segment if it spans
> @@ -1220,8 +1225,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	 * result to ensure the bio's total size is correct. The remainder of
>  	 * the iov data will be picked up in the next bio iteration.
>  	 */
> -	size = iov_iter_get_pages2(iter, pages, UINT_MAX - bio->bi_iter.bi_size,
> -				  nr_pages, &offset);
> +	size = iov_iter_get_pages_flags(iter, pages,
> +					UINT_MAX - bio->bi_iter.bi_size,
> +					nr_pages, &offset, flags);
>  	if (unlikely(size <= 0))
>  		return size ? size : -EFAULT;
>  

Looks good. After applying Christoph's tweak, and optionally the gup_flags
rename as well, please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,

-- 
John Hubbard
NVIDIA

