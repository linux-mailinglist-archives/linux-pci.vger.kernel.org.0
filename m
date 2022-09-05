Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2E55ADBDA
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 01:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiIEXVZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 19:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIEXVW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 19:21:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2663657204;
        Mon,  5 Sep 2022 16:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkZTqo89jlj4I+S2Q/Gcf18UTthx7m6ej26pKtTenYXU2MYzGe4cqUXeGq/eSuiNMQhVVN36qOjpuvH375ZXE1KkYpb46jbua3MpYFaB/NnbHlBIQeGUqu6Fm49l2KAvB4/NeUBHEI5GIb5xcjQDT4F3wNwGONEG5kmJQCzznAw5bnrviLm336GDbUscUvIQBcfMnV8/w+oK4XhTUnkwbHU96oHfVAWKW/7xDFTkUbkUF0QVHs/Aetg2YwHgJLcl+LDzoEYh6EfTielhkXaxVVwt1ALUFwhP26Kmqs+mou+BoUrFQ0BCbb7J1ST5EbPPKVLuHjjqci8gVORmTe2XlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rp1sCglIlz3DixjvBe1ZOYOBuHws+bGLrNhaQWVTRK4=;
 b=kjh5R9FGLYdwSkvDxilfpE3CYEnUUrZYmke5hDel3S3vr01Fkbj+P3mtkUnc9+RJ/ADmq65OoJyDD8a1cyjZTq8ps/+jopQMm8eptimHHH9SAHN7g9PU/wfPazg3NIInHMvfcztgHqGWVTt/pdmPfztg5EDH6XuairsD2S0zZnCdSrULNSlGSNlRNBMe5npn8LWKXWb8lBRPtqe92lxrrEq19ARcjW5M3XboPSUHWgvxNLR8F7IH1BNXynmkYOdAmd5BfkKLUDTREfSCxMmy0USayRmhftliaYp5hOX8VtGFfL2gsEiRwia8gbUBT9TPIHsfhIY82AF/d3UqEytLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp1sCglIlz3DixjvBe1ZOYOBuHws+bGLrNhaQWVTRK4=;
 b=cpDdiSvVPNfEU5It3sEeyJX5W52Kp8wuTQc6TXQeAV59NeebFqaNbWbCIXjlvoxOspijkp/vppBLkni1iaHhP6WZdue+bIGnzhYsstm87l/CW3yq3NcK1IQmzvjYwKQchFBoXItiBAb5cefAmbuW4rDQ17L0x2Ulnjm7apFEtdXbzSS+FPiSOdXw1rOyqEIkGq8fEe6RpC2DwZGXhxsCnTcByDs3sYrL/bO2puwp1s4MvKQ0588p9U67mc9HsTi2XJvUo3G9TEJmN1tVHjXgLdtB8a4TLfFEatMKF+D1+YBq4mxnDB4avGrGuI7BSP0/JHHYxEhR1L4BJWCjH4QMRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 23:21:16 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 23:21:16 +0000
Message-ID: <24ee706f-b70c-28d0-15a7-13d0dc9254bb@nvidia.com>
Date:   Mon, 5 Sep 2022 16:21:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9 2/8] iov_iter: introduce
 iov_iter_get_pages_[alloc_]flags()
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
 <20220825152425.6296-3-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220825152425.6296-3-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd27bcea-7ef4-4508-1031-08da8f9554b9
X-MS-TrafficTypeDiagnostic: BL3PR12MB6593:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAELAUxuryGXQjoaSianMSPdatGUd0hzN63XeQfLvJb6yQs00lHvqUYP/eFvMHOo2yl6bgbJLTUfmraxWXHFeywOJDY4dOedik+iQ2QaQZ2yNCmgKVNBo85j44eTd2A2bX9Vz1NAzoTFUzVSlZr9kybGUmgvQegyhrnMaLOGv6BGAStHkSDU6qk/R1ZhirjQdSr3JFy5To7zjl8aBtHwDyM5LIizFNkD1FeDqiSmUGeZgLze0bgl7tHBXEIFHypQbnr3vae+hviTzHmSQcLmqKOsQabWgbm7UFLro/w/EQkmxIJjL6501AaSB3ych2lMVyQeedDYEsYL6mnSdct+2/ozrUkd/83L+epsnn1VMPibVnhu119cFCcjd5OYvaI1o1Uif7jKi6mr0X+QVoPfMon7ujxgmqc3irZwvRPQKkmHZMhfAZ/4t3sWnr2jdDPActJj9kQOmoSlWzQSvaGP9B69ke7yYwvlEkXqm6B5dnln6BYhRZ2SIJiDQJAL2TdRYo66n2kAOeVyjgjzS/MvdTpJEf0Sru+ITfGwpPM855vouWcFMXNdALm09eUUrQpZLVjv0G8PC5cocjZWTQS19vM0H9C++ARU/Tq5vXRxdZ3DeobUHM1c6M3dvWRzBHshOprMVll74N3JnYX8ZmxPGakJVbbUR9usxtxkLTEKOO7+3i9GN9geF3TMLZIRFUJWf1/CqWIV+B1VesuYkdGUf9hAsOZ+jydPqphYsobq1rkRbSsTMyCRHM/KkCcjYGD75+RzpvZ0Yedj1/yB6oWPohLYrIn6iGxlPAhnnDivTMzBMV94dCib3V+gbtC1wUKgOmDuyo8tq3NuagFylXQ5EralJl8uivmmVCi21+Ss5oA8L2vD7OL2SCuO+o8UHqYr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(66476007)(66556008)(4326008)(66946007)(8676002)(38100700002)(6486002)(186003)(966005)(2616005)(41300700001)(6512007)(478600001)(6666004)(26005)(6506007)(54906003)(53546011)(31686004)(83380400001)(8936002)(5660300002)(2906002)(86362001)(31696002)(7416002)(316002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGpKVklRY21oOExvSTJNNkphSVFmSTdnUHR3NEEvL3RIbThXRkN3Mk1Ja3Nn?=
 =?utf-8?B?bUxZSFN0NkhQUHUvamxubWg3NWhseEZsTnl6NWo5b3pQRW41OHYvNVZRUGxV?=
 =?utf-8?B?dko3cHUzZEpDbUI0STJMYXhENHd4d0NzZTczZVBHbHNCczFzRXdGY0R5bTRG?=
 =?utf-8?B?bXl4WEpHWWdpOXgyZDFqMHpsalZESkZOS042cGFXRzZHTzd5eERMOTNhM0Ex?=
 =?utf-8?B?N1VYaWtCSGxjQmxqQkNTR3dwK2ExZFNadkh6L1FJQlNKTEs2eWoxV0dUQW9S?=
 =?utf-8?B?YldNUGcybWtjaW91WDNqam1yR1hNZTFhMXBlLzNOeXYrTXg3Tm1MYUkxNUoy?=
 =?utf-8?B?bFVhTHZCYjFLZG1TblNIZC9sb1owRlFiditVb1BKSkxEK1M5K2w3RG54cVdV?=
 =?utf-8?B?c3MxUVY5ZFpCSTgxcVNJcFFNVktuL1JBZEtVeWQzWDhlRElNdStlMjhYVjhP?=
 =?utf-8?B?UTBTdi9HUXVCQlJ4S2VLUGFFR3BDZ3k3d01MRDQ4dlp0L285ZWx2WEszKzEv?=
 =?utf-8?B?NXhHL21sRGZuclAvT056L1RadmF4Q3lIa1VJU2JDU2xHQU5sdnJESjFoUk1I?=
 =?utf-8?B?UDhWdTVpNFU4RFpKdDFMR21NT1FjN1NnZWxyMmVzOEZVRHhORTFrQkxvOXl0?=
 =?utf-8?B?QnIxRVRoSmFRSXluK01ZNlNLMWtCa01aQithOGFQakc4d2R3bHRwRGNhMFFB?=
 =?utf-8?B?dThnZXZnODV3ai9ydjE4Sm0yUGhsdWhkOW5pYmJjbUxMQmJRS3JKN1BubDBW?=
 =?utf-8?B?YWYreVc2MlNNNXMwOGN5V1RxR1UvUEZ1ODkrb1pvaDJPS0J6SlBjZDRiUVpv?=
 =?utf-8?B?dCt0eEw5d3Q0U3h5YjNOZWIrTi80SUVMcm1kS2ZKVFlWYkg4WDVGaWxSRVI0?=
 =?utf-8?B?ZDR1YXpQTUR3bW5zVlo5TzA2MEw5YnVsWVBRSG9adE5ubVNDRFVsQnV4ajJG?=
 =?utf-8?B?VUJOQkJLS3FwbEVTTTF6U1FxR2tmK3JDdGpBQTdrWFhGcjVKdE5tcVFuc2tR?=
 =?utf-8?B?RUt0RGM4YzRiWnQrcVpCRHZ1dWxaVUhDSjBSZ1lFaVl3ZnQrbmF5WHZTY01W?=
 =?utf-8?B?NWU5ZmgwV3FGV05tQWh0Z3dsRVc3ZVk3ZVZQZWc1cnlKei84ZUFnMlA4bnJo?=
 =?utf-8?B?SHBnM3c1UkFMcVVTNm0zWFVycHZ6RjJCaWEyVFBtVEs0OC9SK2V5VWNxcXVy?=
 =?utf-8?B?WDRocUVOcTJvNU1GdUpaTUF4alR2T3hWMllpeFg2WXRVejVUNEcwUjFhNW9n?=
 =?utf-8?B?NFE2MGtTT0lvbkV5VkNXejY4SVYwNEU0TUFUb25UeDJTbXJGMlc2SEU0U3Vr?=
 =?utf-8?B?VjFtZzlBMitGL3NNak00SDZKSHpmR2pzTUx4b09BeXhTeUI4d3F2THVwV09v?=
 =?utf-8?B?L01PcWFWM2N6dHhXVUlVSDB5WWlxR0cxZStITUZKcThtajl2cEZEelFZWk0z?=
 =?utf-8?B?N3NIV2pYV0UyQVVVVUF4eThTZzlkZSszQ1FYd0x6dVQwL3l3aWZpanladkNh?=
 =?utf-8?B?Y3RKcFdFMm9lVGdyTmptZmlHdmE2T2Z4cVZuVjU5ZTNCZm1hL2RSTi92QkJG?=
 =?utf-8?B?OVErU1gyVlJlK3A0bU9xQmdwZW1xbVZ5YVNQSjVheHY2VS9KaFBTcGlyc0cx?=
 =?utf-8?B?YzU5ODY5ZlAyMEkxUVNBRmF5VmRibUNDMWJUa284MWdzbXJTQ1BUT2UyWitZ?=
 =?utf-8?B?RFZBUWdBeW5VQ1NORHA4UElRSjdzUGlFbGhFcGgxTnlPMHhtTUZQTDY0R29M?=
 =?utf-8?B?REp4UUhtbXdYbG9KV1E0UkY2SDdVN0ZETStSNmZhdFZMUWpWUjB5Q2VmUGdr?=
 =?utf-8?B?enFOOWlGb21LK1BJNk1vVnFxRmR6YkZ1dHd6QXdobWUyckU1aUJadk9Ld3ZO?=
 =?utf-8?B?bjE1Z1VlckJndnBqQ0UzekxFTk83YjV2QUhqbHlqQmtadktycGxIR2ZYRStZ?=
 =?utf-8?B?THV1R2pEVVg3a3o3VkVLQ2dBRW9KRjh4bGdPTWVmM0N3dDd1UnkyT2dOR2pk?=
 =?utf-8?B?WGpPVFJ3eDFtdnhsTTFYYnRXN3BIVDR6aXBtODFueVoxWkRsak1iUTZDRTZL?=
 =?utf-8?B?NnI2U2FrMmU3R25YUkZ6UElDV0YvSTdiaXlINDB6Y2dSS2JHRnlobi9QZ3hj?=
 =?utf-8?Q?Bi5uooB/RJ79tj+Ahhm1Wnge9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd27bcea-7ef4-4508-1031-08da8f9554b9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 23:21:16.2858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fhD4VLpcu82W6IS4mzYpks8irebVShtX6lHd/IWJL0dEWpxJVLCwpyfp5kfGeVJNtPAYygrsfPCmvgnGynFkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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
> Add iov_iter_get_pages_flags() and iov_iter_get_pages_alloc_flags()
> which take a flags argument that is passed to get_user_pages_fast().
> 
> This is so that FOLL_PCI_P2PDMA can be passed when appropriate.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  include/linux/uio.h |  6 ++++++
>  lib/iov_iter.c      | 40 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 42 insertions(+), 4 deletions(-)
> 

Yes.

I also don't object to Christoph's additional request to refactor and
rename around iov_iter_get_pages2() and such, but this version here is
perfectly good, so please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Looking ahead, interestingly enough, it turns out that this approach to
the wrappers is really pretty close to what I posted in patch 4/7 of my
"convert most filesystems to pin_user_pages_fast()" series [1]. Instead
of passing gup_flags through, I tried to avoid that (because FOLL_PIN
is, as a mild design preference, supposed to remain internal to gup.c),
but given that you need to do it, I think I can just build on top of
your approach, and pass in FOLL_PIN via your new gup_flags arg.

Along those lines, I've copied you in on "New topic branch for block + 
gup work?", let's see what happens over there.

[1] https://lore.kernel.org/r/20220831041843.973026-1-jhubbard@nvidia.com


thanks,

-- 
John Hubbard
NVIDIA
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 5896af36199c..76ba69edb8c5 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -247,8 +247,14 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode
>  void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
>  void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
>  		     loff_t start, size_t count);
> +ssize_t iov_iter_get_pages_flags(struct iov_iter *i, struct page **pages,
> +		size_t maxsize, unsigned maxpages, size_t *start,
> +		unsigned int gup_flags);
>  ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
>  			size_t maxsize, unsigned maxpages, size_t *start);
> +ssize_t iov_iter_get_pages_alloc_flags(struct iov_iter *i,
> +		struct page ***pages, size_t maxsize, size_t *start,
> +		unsigned int gup_flags);
>  ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
>  			size_t maxsize, size_t *start);
>  int iov_iter_npages(const struct iov_iter *i, int maxpages);
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 4b7fce72e3e5..dedb78f3c655 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1427,7 +1427,8 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
>  
>  static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>  		   struct page ***pages, size_t maxsize,
> -		   unsigned int maxpages, size_t *start)
> +		   unsigned int maxpages, size_t *start,
> +		   unsigned int gup_flags)
>  {
>  	unsigned int n;
>  
> @@ -1439,7 +1440,6 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>  		maxsize = MAX_RW_COUNT;
>  
>  	if (likely(user_backed_iter(i))) {
> -		unsigned int gup_flags = 0;
>  		unsigned long addr;
>  		int res;
>  
> @@ -1497,10 +1497,24 @@ ssize_t iov_iter_get_pages2(struct iov_iter *i,
>  		return 0;
>  	BUG_ON(!pages);
>  
> -	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
> +	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages,
> +					  start, 0);
>  }
>  EXPORT_SYMBOL(iov_iter_get_pages2);
>  
> +ssize_t iov_iter_get_pages_flags(struct iov_iter *i, struct page **pages,
> +		size_t maxsize, unsigned maxpages, size_t *start,
> +		unsigned int gup_flags)
> +{
> +	if (!maxpages)
> +		return 0;
> +	BUG_ON(!pages);
> +
> +	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages,
> +					  start, gup_flags);
> +}
> +EXPORT_SYMBOL_GPL(iov_iter_get_pages_flags);
> +
>  ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
>  		   struct page ***pages, size_t maxsize,
>  		   size_t *start)
> @@ -1509,7 +1523,7 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
>  
>  	*pages = NULL;
>  
> -	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start);
> +	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start, 0);
>  	if (len <= 0) {
>  		kvfree(*pages);
>  		*pages = NULL;
> @@ -1518,6 +1532,24 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
>  }
>  EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
>  
> +ssize_t iov_iter_get_pages_alloc_flags(struct iov_iter *i,
> +		struct page ***pages, size_t maxsize,
> +		size_t *start, unsigned int gup_flags)
> +{
> +	ssize_t len;
> +
> +	*pages = NULL;
> +
> +	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start,
> +					 gup_flags);
> +	if (len <= 0) {
> +		kvfree(*pages);
> +		*pages = NULL;
> +	}
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(iov_iter_get_pages_alloc_flags);
> +
>  size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
>  			       struct iov_iter *i)
>  {


