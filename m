Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433DE5ADC18
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 01:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiIEX6g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 19:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIEX6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 19:58:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E865D0F8;
        Mon,  5 Sep 2022 16:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5aq3VxJudqMnXWUmA5OVlLxry2JY8zUW4U1ogWVdrSV0vuHG9LZUFkzCobtS4DEantK20DOgr82Xsb4AxhRrAY0yEg4MAylrqGjqjGGIvVJTrAs3rleeiJ4aJ37Qnd1tQ7p+W5+EqxoqYW3PnFDbgHV5m66jG0yhhyIf5Y32jRLP4eKzLqMIDSxUlzeU1ChBzap+Ll4rW1nlPuwblU7nNCQvRWsyBNMP929eV93ZXhwUc3iBhrdTp5C+SfknB5kM0FZ3A/gEeFU3CS3BPrU0+a9ogKcWgO4fUBJamQTHuwggVXv4IlZpYVTHZs+Vr+RZT90TsJjmi6gSr3BNO8VgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmeFydYMe4iXiNmN2Q1d4YTnkM3weigNBMz80R9Hz0g=;
 b=GMsNQ6+V/YT+2leV+BuAE8RMUOfH8JnVNnZcn5arqcrASasvKqgYymvcTVSxfb7FkNGpKT0AADP2u0Jip5AsMCHX5Kv9YT7JanK3ofCnSfbVdTs/1Tk7PMCIL1l7YA7wYuZMuXQ6l17IH2vMDZcQtMlQXsU4R7MOlvxXjtfQAO1Wchr41M0o8NV9bWNyhvmI03Du88yvIR8sU0vRFy8z8z8pGhXjFjfWBi/769ONUPPLGRnPP+DYFcujM9pon54zZQEw8RXZj9O3xw24RC1l6NMCYTa4EH1yMuVnsB4JEHJtzLJxQFVOfQIH9Hy/6L3nnrmcYzDBp6AM8V8h4QeerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmeFydYMe4iXiNmN2Q1d4YTnkM3weigNBMz80R9Hz0g=;
 b=pnBUp5NyAIKIEKHPH3/FVkuKeXhUgZs9wg21UaTfBFP9oUiX2uDf1B7HCcHFoXv8EUiRNy8M9euF7oGOLSVs5MWW6NNxvBmCAKY1FRIkcFxqeDNzIhESO0BNUUCIchQMB9hMsC2I2pr2udfsYgnE0VskkWQWASWqkCasb4nKhXmHT9HdqjLz9nf9SGx3kq6XiepMIQJSvGSXbxwhuZCiTvI2+JBD29YdRoqcBr1SYCUWo+yEWGrr+fPqgBo4bM5KXB/8N2LkBh+XnrnXvaP8QhBFpIrlQnpI9p39J3DNPBlmXvrJK4DWsXt7HNll2WQL+IR8afANT82PIyWgsdzbRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 23:58:29 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 23:58:29 +0000
Message-ID: <3d88bbf3-8c55-46fc-731e-bc81e184b8d7@nvidia.com>
Date:   Mon, 5 Sep 2022 16:58:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9 3/8] block: add check when merging zone device pages
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
 <20220825152425.6296-4-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220825152425.6296-4-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0108.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::49) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4db04050-14db-4771-fed1-08da8f9a87ae
X-MS-TrafficTypeDiagnostic: BY5PR12MB4242:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rQKCDrf8b1Kzd3o9TDxhAM1Snrp+q6ThbgkeZ09ZCRa2bE6IwdQGFCwJ9rcHvjKC+xXoNS3vc91dCwmfV/bCNCgbEPo5Kf96dbLAr2hNkOSR5I0SAsEB0f04tEfySuzYFGKYaVQ/I2TH3EhYKqXP3yUEU9E/8jMg5RaAJq/J3FTU7Mv3jEUAWUyZYG8g/VjxrW4mh8Jzj6MzXteZazUOF/uYCrUFpfdzv+FMvLgN5C4POL9npr9/M6AOvtf3vXpi7bSaErmM7zU2lBUDNynvavhq1jNggMohXF7K5ywugQAk/s/bsBgX4bYfwFf2STxT1Xz943inQoCCa1FcCCLuY9nKt4IAMrsxcEeHqQvfGi0gFM+0VK2+edX7NgQYxB920GOka29KoIPBEPz0eg0MaeSLqlqM/9fSH/KzH4M7Ttlz0Wnf//4y8MakRmoCF8B/5QtvOjU6JWf4uPZ09HVXYz30yyyGZ8NFbZUeJcxs/o5nv5lcegyVZQFM1SLuicFPVK02UHBR2+ol746gV108y87YECXpZBZmTG+pTk6E5n53ZaNnLBq07+l9Z+KLUWorZO+cXG66BnWz2Fg99EieW6AYzULHbj2CU0vW8b7d/U36hNLT64bPS08CmTQ8jmDEfQnU1ecdOqnCAWncPq4DvjYlRR13xAZ3KKsYCVXjf/aBE6DbPWtD5nx/Qu6DCQP3aXt+0RHb5S0sQhs6s/8GfDoMCZCwBJk3UNoJBivZ9npQDVlr0E7fjnT4gKHu/MId0abLvfUZoGhnCrB4xe8Qmi1DcEWwrrphF0OrBidf5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(36756003)(6512007)(41300700001)(8936002)(26005)(2906002)(6486002)(478600001)(6666004)(38100700002)(7416002)(66556008)(66946007)(66476007)(86362001)(6506007)(8676002)(4326008)(53546011)(5660300002)(31696002)(54906003)(186003)(31686004)(316002)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmNwdEhobEpXVmNHODVVRUpCVU1xbzRPWlhCZy9tbjA1UUg2b1hsS25jTHRG?=
 =?utf-8?B?Q0FlMGFHc3pTeFpBL1BybVlaK1NSNFEwNmRzL05xNzhXaG1kaHRJZkhmMkxm?=
 =?utf-8?B?N1N6alc5bHdubTZkaU9qMXVLWVZEaDhCYlZJUkFDL2xReDFLL1pnemtUeXVT?=
 =?utf-8?B?MGlxV3NON3Uwb0gydGVGZXdsZDJ0cHAyTStOUmhMTDgxdlFvalR1cVlTbURG?=
 =?utf-8?B?VFh3aFFISDFwK0VoWlBRYVltTndjUEZWTURjY3VtbnhmN2cyRGluR1RnMWVX?=
 =?utf-8?B?cmJ3eFZrVmh2eHhWU29ydkNNYUJXWDBraUJTZnNQUzBYbFM0MURCajg2T21L?=
 =?utf-8?B?VlRXVEtRcVBvQ0MwQUsycU02M0xsU1VMR09oUEN6YWtibjhkakl3Vy95cmpF?=
 =?utf-8?B?Y0NxRGl0NzVKWXNJaGlkeG9uVXNvWXlrZC9oRDd2VHFjdUlmdC8vZHF4cTlN?=
 =?utf-8?B?OURMOTBhcDh0VzE0dkc2YVZZaEZMZXRWbk1Hb1hUaStFVFUwVGM5czV6Q3cw?=
 =?utf-8?B?WkJSMjVYQk5aNUQ4TDFzSGt2NWJIMFVURVRmV24wV0ZvbUdlcFpRYVkycXkr?=
 =?utf-8?B?NlpubXB5RzE1MUpsQkxDSnVTYktvZVNHK3RhcjRSUGY2RkdrQXozd3pzd3ZN?=
 =?utf-8?B?NTFRTXNLKzE3SXFsbnJQWmVtUDJUd09EYkx3SGZzakxxYVo1Mm51NHpZc3hV?=
 =?utf-8?B?NDhuYWNva29HR0hzV1NSU1V0bWd5dDJxUllIL2xnY3ZyU0U0WDE0U2swclRo?=
 =?utf-8?B?dlY4SGsrRU50QmZXZy9VWThZRHhLclNrRXZiSEd3ODNHbkQ4bVQvaG1ZRDVm?=
 =?utf-8?B?aWpjZFJqOVJvakxEdFpUNjNaUEFhSmJuMjB6TnZVYmlwd0EzNTlqdGRnem9P?=
 =?utf-8?B?TnZsWlVOb0VBVVNLMHQ3c1FxSlpoNTh3NHFEa0JaMTlnQllHd1RlSFEyc25m?=
 =?utf-8?B?N3QwdEdxTTBKTjFSYkJTL29JLzZBTmY0eUdqZk5PZmoyY2lBZDN5VmdTUytU?=
 =?utf-8?B?OXhNeTRIcnBpcDFrZHNYOC9DMVJzNUludlkzOW1BWmMyYnFBVmgrT3J1Ynd2?=
 =?utf-8?B?V0dVeEJyZmJ5dmYzRWpjSHVpRmxxZVE3RkJKVytBam1tUFN2SEp1cUk1aDBM?=
 =?utf-8?B?VEhwYm5rQSs2N1QxcnRNSGIzcGNOZTJDaXJoOVdLOFZCd2V3bnpmbG95TE1I?=
 =?utf-8?B?QW5OT3A4RkFYaGZGeFNuZ24wZHhVcGRMeVJDT2c2aWttWGowZWMvdDZLTVNY?=
 =?utf-8?B?cS9qbmZRVGNpalVPLzBJY3p2ckhYM08veUpIT1BCUUpSc3Z4SlJ2MkRsbHFz?=
 =?utf-8?B?Q0doSGl4MVlSZGVDS0hQWlN3NWJEdnA3Z1RTNG5PL1B4aXF6OU1aMVR3TElh?=
 =?utf-8?B?MEQ3dVdJcUtiWWc1QjV6cVdiVk5XbGlNaDJhZStUeU1CNDZKUnM2azNadmJ0?=
 =?utf-8?B?SEN6anIyQnArTk0wWEQyUjljVnhFekduVXdFUFFYYmtndTRNbjVZMXAwVXRO?=
 =?utf-8?B?b1pPREg5ZGFaWWlJRmpzSXp4UjFveFR4dGV0RnNFWkMyMFl2MU93MU9OZlpq?=
 =?utf-8?B?SHE5alJGRmhrc2FIZ0hGaGtNNXdrTklsNklMTFBnOFQ4azhIZXJYTmxzWlAx?=
 =?utf-8?B?anpVZllCMS8rZFl0V2pBUGdkTEowZUxkK1dRbC9XcUFmQjhESGRQQkxGNzlI?=
 =?utf-8?B?UHgwZCtWUWx2V1RQSmptTlBheFAzckxSZTd1RFNlcE5YTmpheHBIMy9DRk1G?=
 =?utf-8?B?K3BiMnVqamYxY2twT3p0MUNuSUJ3dG9kUDlLeU1md09YT0pmV1BOL0RRR0hH?=
 =?utf-8?B?aUpjUEhmMnppWGwxeEMwVWFNMGpWd0tPNk9yVVhUM1R4V2x4SXZ3WEgyYnRt?=
 =?utf-8?B?RWJuaCtKd3VJQUkwZjltaTBoRDk4b05mRzYrNUs1M1Q1NFRrdG1WK29TeCt6?=
 =?utf-8?B?ampGWTUxcjlNdTVWM3E1a0N5KzE2N3pWa2NiRFl2cEJUWEVGR1YwREEwTmU2?=
 =?utf-8?B?Z0x5cWRPbTlJRTR3QmIwU09QeDNpNVhleGp3ZWpML3dGdnZ5MkM2dUtkOVBF?=
 =?utf-8?B?QmRwZTVydFZlWE5OL0M0R0VFVi91VkdmSlZ2QzMwbzBCQ3lsb1ZhWmhhWGRn?=
 =?utf-8?B?R2oxY3Z0bkxvWUlPRnBxUXFQK29zZEk3REZlNFozQmZwRlJRWHhBbzE5aUJn?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db04050-14db-4771-fed1-08da8f9a87ae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 23:58:29.3132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4XGaPkWYDysU7o7Camec6CdIi/irl+Vm3VdKnpAC44exqtPx2ke9t/io4yXb2enajnUElXEejhkN85WRThkqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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
> Add a helper to determine if zone device pages are mergeable and use
> this helper in page_is_mergeable().
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  block/bio.c            |  2 ++
>  include/linux/mmzone.h | 24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 3d3a2678fea2..969607bc1f4d 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -865,6 +865,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
>  		return false;
>  	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
>  		return false;
> +	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
> +		return false;
>  
>  	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
>  	if (*same_page)
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index e24b40c52468..2c31915b057e 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -794,6 +794,25 @@ static inline bool is_zone_device_page(const struct page *page)
>  {
>  	return page_zonenum(page) == ZONE_DEVICE;
>  }
> +
> +/*
> + * Consecutive zone device pages should not be merged into the same sgl
> + * or bvec segment with other types of pages or if they belong to different
> + * pgmaps. Otherwise getting the pgmap of a given segment is not possible
> + * without scanning the entire segment. This helper returns true either if
> + * both pages are not zone device pages or both pages are zone device pages
> + * with the same pgmap.
> + */

Nice work on the documentation here. Approach looks correct.


Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,

-- 
John Hubbard
NVIDIA

> +static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
> +						     const struct page *b)
> +{
> +	if (is_zone_device_page(a) != is_zone_device_page(b))
> +		return false;
> +	if (!is_zone_device_page(a))
> +		return true;
> +	return a->pgmap == b->pgmap;
> +}
> +
>  extern void memmap_init_zone_device(struct zone *, unsigned long,
>  				    unsigned long, struct dev_pagemap *);
>  #else
> @@ -801,6 +820,11 @@ static inline bool is_zone_device_page(const struct page *page)
>  {
>  	return false;
>  }
> +static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
> +						     const struct page *b)
> +{
> +	return true;
> +}
>  #endif
>  
>  static inline bool folio_is_zone_device(const struct folio *folio)



