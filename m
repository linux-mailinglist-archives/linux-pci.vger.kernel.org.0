Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FA0631834
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 02:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiKUBjW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 20:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiKUBjV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 20:39:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241702D744;
        Sun, 20 Nov 2022 17:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668994760; x=1700530760;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ira0VMqCPGyvWtysOgWxerXJj0u8FLzD4AqwNdpMKMs=;
  b=ORnbjD4artsQVuPCSugtXvnU5JSVu/2LMycmV09WkiHvXRSo6kX4iXRr
   UN1u1r1DxH16FvDSb+E+SnZ9lYQL4BfoY4uHW3s3Qx2lwdqym+PbZZgAP
   kgY4Z0exP4mHfD15Onye02VeQNNhZPT3kTB0Pz7CzKY5+IbH20jny2r44
   /g633EBxraOom3m2FOlub0d5gdvFPKCbdSoTsX7G5BzS8tHtsBTcEobT6
   1bkIVt5SinvByfkeiCjhXLdgdfE+Hp8megaWP4lwiAb4R8jaQqI6jYjWd
   NYSbxhXQFlIppLAF4Kl/X9t5AL2Z+bl3tcsnxg1aN8PslirEFhtdiZCw4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="293162044"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="293162044"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 17:39:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="969894743"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="969894743"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2022 17:39:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 17:39:19 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 20 Nov 2022 17:39:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 20 Nov 2022 17:39:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9NZUsujMDHIon8a2YZldjBWK6B4Hk24O13cboQbnChOXkMYJw4QZAFujD92odkgCFtxb4A6oi1WLk7ow2+o9H37s4B043EqrDEw19ZKB+PyRbae0fJ5Cusb5u732fxaIfyG4qtqlrwzYCi6uhDDVVu79jZeqT2ywJL8kdopHrrIXwKIlTsXguGFUxRNjUZnG14H4PXiz+raDA9u+wkanoO61HQYnd2sFVF6wgOD98I7oDP80OkEUbV2cOk/YoWXw48VehQm0w6+z1tjyBwXx9iggSA/0XKl4OGVaXzR+bHCO+D9/d+cAaZ2uqchR1TthRkjzR856V/HRZv/rFjFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EX9n+Tdi2oR/o5YkdJeltLiNihwAbDCG8+Rr4zTyEtc=;
 b=GErXhD5DM1nJfo8wRzsRnglf8BrNZY5ufBz/axyWntFOTm2e4eJkiiAf8S8aqkQ1J9L58mKVvhKn5bPwmHWQDVSDtYUzo68ge5zKAKuhsLCIYre8LqpIdEE0fP8qZIbNrBAezWH3RVcPoBnNaDNZ6JWG0mcWYCEoFEl7ycPdr+8/kxZug28bOGKwLLrbQlChvLQum/6v7+d8BPu73Pj5Y+SqDX6MeTtZStPfcwpRUV2LL/UTEN+QbISiVp/1NH/HwMSPTYybbsYgbEVtebg+HXPl5rsyvaYfTio3jjlsME3TQUTC9p9Y6Cu3Droe6fkN4lBQ/r6EK9nDh1Kt1ZtR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by PH7PR11MB5914.namprd11.prod.outlook.com (2603:10b6:510:138::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 01:39:12 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::7ac:fe96:566:65e]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::7ac:fe96:566:65e%3]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 01:39:11 +0000
Message-ID: <750c2096-fe2f-0597-a635-78cbe6b0ee0d@intel.com>
Date:   Mon, 21 Nov 2022 09:39:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] PCI/DOE: Remove asynchronous task support
To:     <ira.weiny@intel.com>
CC:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Lukas Wunner" <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
Content-Language: en-US
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <20221119222527.1799836-1-ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|PH7PR11MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc1852d-cb71-479e-1835-08dacb613065
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzt4al8Xba86Uzzdlj7h2k4gM8M80iNyu19gz0TRT8jKMeoeflXXrZNMO3E6khLYtxy0xTbAMaoNJ8RjdDh7FM290cePmxzYyJP9sLfiNihzOPjs7RVKyulnNpqzxP7KPGdxxJ56NQwFydeRneItjYFT3uE/k75lExDNuMOkSBNONjiuRjEqr1yyRQyUdB47e6Wz+aAt0BibI+INVhLRxy+qHr0P9FBnLiLzmKuAo7q4aDLEGdZBT2g5BvY7we80WWD8Z0O7XFjh5KAmIGK5KFplKKJu3hWEE8neTvOFAxEXGEFwNCsWg6SrkJGDRZqR8EMUdG6J6bR1mSO1hzN9BMNYLFJNGR0i+rs/pNMuP+YOBoYXG69+gM0c/1dRuWNYErkCy2a6P+CIIJMZ+nZXAprGHs10JqdMduPHGncJedypXg2yvDK73kKiNEo1X5sKsZDOwJMRUnXiV78e4hDBaa4UBO3LEzSEuZaPaOcfOFeXph8aAWOMTzskfRajl5lig0oIo7nrX/n0AMUz5Gtru1JWAL+KJ0pjTMNOM5vDpTeXMYjFaBXIe7CvRBxyLxnnGPmzZcidKzkmvnMZriJqRkdAVx09V6maQAFJBJjxiJ1qRoDjYL84nrFPbI0PO26TX4w61OwqCIc8e801DeAqOj3limsQRnCkcZjbpfpQIOb9Qpspaj95Obilb6CnEvkyQMhN/Ytx17btGIcpBonfpxRj1PBdEYtrkT5JliCnSLNrta9AstiRwPhVWTM59PRE7T5alQCeeyrEvxVkI3vuRXEMEqaXGbPZFcYyv60WLGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199015)(41300700001)(8936002)(37006003)(5660300002)(4326008)(316002)(6636002)(54906003)(66556008)(66946007)(66476007)(31686004)(8676002)(34206002)(30864003)(478600001)(36916002)(36756003)(2906002)(2616005)(53546011)(966005)(6512007)(6666004)(6506007)(6486002)(186003)(26005)(38100700002)(83380400001)(82960400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHRhanFEbkJWRndtd21LMkhlTUZUTC9Famw3TGlXeldGMjhIdFBJNGM5Q0ky?=
 =?utf-8?B?dXp3a0p2MlRDcm9lb0NVSWZtM1FZdGF3QnNVZU5XQVVkRVR0ZkxSVUcwNjdX?=
 =?utf-8?B?TVNNdHBCY1lDenlaL05QSU50QndkWDRSWklac0cxYlVRUVlVQ0g1NFRVYVRl?=
 =?utf-8?B?RjdHWktoS1hKSnZDWEZwOHRsNmdCK2xpNFE0TXgvdEpUVE85dzdoR3Fzdm1q?=
 =?utf-8?B?S09yQ3lqQ29WaklsUlphVEh0TExtUEVzRVR3eXViUklabW90TGVDWUhzS0ZC?=
 =?utf-8?B?bmMyZDhLcVpLVjZhTUNYNWllWUI2cWFQOUZEU0p6eEJ0U09hOFZtbzVXL2Vh?=
 =?utf-8?B?WlZoTVM2d0ZTM3FyQ0J0MkwrMmZQRnR5eHdzTGpUajIxdnBrOTVsdG40TGIv?=
 =?utf-8?B?bjh3TFRPZ3FZc29DckExTVBFNFlCVGhOS3BuRFJtanlhTnpidENUMnMxTDJM?=
 =?utf-8?B?U2JSL3JBZ0ZJQ3VHQ3BCVVFyOWFXZTFDUzBZWlIzdXJEOURhQVF4YndsSjJj?=
 =?utf-8?B?ZHY3RS92blRIcnBTSEtBS2JyMFdtK2NkNUxLbGo5U0xadjlTMVlpZ09CN2My?=
 =?utf-8?B?cW5GMytpRHRnWVFabHVZeDhXV0pFNFcxL09TOXQwTGdPdENhTnRBUWlKSGNx?=
 =?utf-8?B?UDRrRk9sVUtZa3dDcnM0bG9ZbDBlWWcxTGFPZGdRcnJkc2I2UjFyeERzWHF2?=
 =?utf-8?B?MVVpYXBoZ2pocGM2MU9EdFh0V0tKUzBDd3V6SW1jOUp0TXYyY3lKS0ZPS09u?=
 =?utf-8?B?WEJwNE10V09mOC9qaElyaGNzakJZWlFmdnRidXdLamxoa0ZSM3E5UVRMeXlE?=
 =?utf-8?B?N2J4R2IzSis1OU5CQVhWYlE4L0NpZjJtclFyT1IzQXN3R2ViczRxN3FuWjJh?=
 =?utf-8?B?d0hXdE1hTm9tMjcxUHFISG1KZkg2ajkzWjBYWlFHY1hHTlorSzZwZjB6RXVz?=
 =?utf-8?B?QWJWVExQNU85alFuajNGMjh1djRZT1U2S1lUeFpRRzVWMlZDdmFtaFFqMXZ6?=
 =?utf-8?B?ZCsvOWFqcGJ3ZmlXckNCMXVCODlpclZRKzgyVmViczJhbUtvcVMrL3U2RTJ0?=
 =?utf-8?B?a0N4SUNFeGN3aysxVnBQcGsydndBbmxvN3dCb21zaUVzWCtFUitVZE5rSVBk?=
 =?utf-8?B?cUVKVWZxaWNuN213MnYzNk5vLzVoY3NlbWV3dlkydXBjMEt4aHVvenhDU0FY?=
 =?utf-8?B?bzdEN3hVN3JRNzJBTk1obEtIRlYxelFHekpGaFN1aE0zbi9xdkdoeFE1OEky?=
 =?utf-8?B?WmIza29EbmtIYjhkRXA0RVFUWm9EM1YwMFNGSGZzMWo2WFArajVlUnFZcUJr?=
 =?utf-8?B?RFVqbFR3aURQd29nWEJVdDBQSllpZk9BRjhqZ2FPRHVtODFMdlZaNjN2Yi83?=
 =?utf-8?B?Z3hscVl6LzRMUHZQUzFQRkRoU2FYUDJacE9nNlkrd0hNWmx0Z09YNW5jdzVw?=
 =?utf-8?B?WXFzc2NscTZicmZ3RiswZmNmQ3lid3h5aVgzVytYekVQYTNrenphWGpOcHE1?=
 =?utf-8?B?TzB6aUtpMll0RWQ1b0k4ME83MlhGNnlWS0xlUkFQVWcrUmZaaWhVZEI4cGZJ?=
 =?utf-8?B?VzkvVUxEOVcyVlJwdDFBWUJCUlQyNVhBSDQzOU1PNlZYM0k1ekNYY2RPbnFO?=
 =?utf-8?B?MDdMRnpoVGtEVDVSV3grcHFrVDlNVWtwTlBzdEJXOWRySmJTNStYZnNSaUtx?=
 =?utf-8?B?ci9wRm5yNFpQR09CTnYrVDVZaE40ZXQ0S1hEUi9LZ09VNjRCVDBEWk4ycld6?=
 =?utf-8?B?TEZhNmJqU29Wa0xZWXBDU1k5eEYvL3JKNk5ZTUt0ZHBxTE51TnQwSHk0SkVG?=
 =?utf-8?B?OHFhdkFselZKT0U5YlpqbGl1ZU1JZVBQUTkzZjFjZUZyaklhQ2Ixb0JjSkJl?=
 =?utf-8?B?VmFZbTQ2Ni9hQkpPOVNTbUpadjRDL3pKMGZuZjg5ZVdPa09ZZlR5V2t0UVY0?=
 =?utf-8?B?eTNJTlJzRE8yYTlMNnRrRmNKSUQ1QlZZRXZOalBVTEpieXJqOWhPdDFTUFZ5?=
 =?utf-8?B?V051eU5PSzlNbHVIYUN1dUR0KzVyalRJK3dOa1RtdXRLMUtrTFFaazhiQWJy?=
 =?utf-8?B?RjFSdnZvdm9zZHBUNGtLekZ4ZWJod0wyMVUrSUVkL2JuYmNlNUgrTkduS3Bw?=
 =?utf-8?Q?NPYlOV6LU2KcJ1St0/OHAHQqw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc1852d-cb71-479e-1835-08dacb613065
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 01:39:11.4450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZJNIwTAJpkABGda8cauKrLKxx7p7eHT0j4BNVd3DTZlI9sqZniQI8VutkvdaHvEqr6KirKrQuzKJMH2nHXqTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5914
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/20/2022 6:25 AM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Gregory Price and Jonathan Cameron reported a bug within
> pci_doe_submit_task().[1]  The issue was that work item initialization
> needs to be done with either INIT_WORK_ONSTACK() or INIT_WORK()
> depending on how the work item is allocated.
> 
> Initially, it was anticipated that DOE tasks were going to need to be
> submitted asynchronously and the code was designed thusly.  Many
> alternatives were discussed to fix the work initialization issue.[2]
> 
> However, all current users submit tasks synchronously and this has
> therefore become an unneeded maintenance burden.  Remove the extra
> maintenance burden by replacing asynchronous task submission with
> a synchronous wait function.[3]
> 
> [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
> [2] https://lore.kernel.org/linux-cxl/Y3kSDQDur+IUDs2O@iweiny-mobl/T/#m0f057773d9c75432fcfcc54a2604483fe82abe92
> [3] https://lore.kernel.org/linux-cxl/Y3kSDQDur+IUDs2O@iweiny-mobl/T/#m32d3f9b208ef7486bc148d94a326b26b2d3e69ff
> 
> Reported-by: Gregory Price <gregory.price@memverge.com>
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: "Li, Ming" <ming4.li@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Thanks to Dan for the bulk of the patch.
> Thanks to Ming for pointing out the need for a lock to prevent more
> than 1 task from being processed at a time.
> ---
>  drivers/cxl/core/pci.c  | 16 ++------
>  drivers/pci/doe.c       | 83 ++++++++++++++---------------------------
>  include/linux/pci-doe.h | 10 +----
>  3 files changed, 32 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9240df53ed87..58977e0712b6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -490,21 +490,14 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
>  		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
>  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
>  
> -static void cxl_doe_task_complete(struct pci_doe_task *task)
> -{
> -	complete(task->private);
> -}
> -
>  struct cdat_doe_task {
>  	u32 request_pl;
>  	u32 response_pl[32];
> -	struct completion c;
>  	struct pci_doe_task task;
>  };
>  
>  #define DECLARE_CDAT_DOE_TASK(req, cdt)                       \
>  struct cdat_doe_task cdt = {                                  \
> -	.c = COMPLETION_INITIALIZER_ONSTACK(cdt.c),           \
>  	.request_pl = req,				      \
>  	.task = {                                             \
>  		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,        \
> @@ -513,8 +506,6 @@ struct cdat_doe_task cdt = {                                  \
>  		.request_pl_sz = sizeof(cdt.request_pl),      \
>  		.response_pl = cdt.response_pl,               \
>  		.response_pl_sz = sizeof(cdt.response_pl),    \
> -		.complete = cxl_doe_task_complete,            \
> -		.private = &cdt.c,                            \
>  	}                                                     \
>  }
>  
> @@ -525,12 +516,12 @@ static int cxl_cdat_get_length(struct device *dev,
>  	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
>  	int rc;
>  
> -	rc = pci_doe_submit_task(cdat_doe, &t.task);
> +	rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
>  	if (rc < 0) {
>  		dev_err(dev, "DOE submit failed: %d", rc);
>  		return rc;
>  	}
> -	wait_for_completion(&t.c);
> +
>  	if (t.task.rv < sizeof(u32))
>  		return -EIO;
>  
> @@ -554,12 +545,11 @@ static int cxl_cdat_read_table(struct device *dev,
>  		u32 *entry;
>  		int rc;
>  
> -		rc = pci_doe_submit_task(cdat_doe, &t.task);
> +		rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
>  		if (rc < 0) {
>  			dev_err(dev, "DOE submit failed: %d", rc);
>  			return rc;
>  		}
> -		wait_for_completion(&t.c);
>  		/* 1 DW header + 1 DW data min */
>  		if (t.task.rv < (2 * sizeof(u32)))
>  			return -EIO;
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index e402f05068a5..41a75112b39b 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -18,7 +18,6 @@
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
> -#include <linux/workqueue.h>
>  
>  #define PCI_DOE_PROTOCOL_DISCOVERY 0
>  
> @@ -40,7 +39,7 @@
>   * @cap_offset: Capability offset
>   * @prots: Array of protocols supported (encoded as long values)
>   * @wq: Wait queue for work item
> - * @work_queue: Queue of pci_doe_work items
> + * @exec_lock: Lock to ensure 1 task is processed at a time
>   * @flags: Bit array of PCI_DOE_FLAG_* flags
>   */
>  struct pci_doe_mb {
> @@ -49,7 +48,7 @@ struct pci_doe_mb {
>  	struct xarray prots;
>  
>  	wait_queue_head_t wq;
> -	struct workqueue_struct *work_queue;
> +	struct mutex exec_lock;
>  	unsigned long flags;
>  };
>  
> @@ -211,7 +210,6 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>  static void signal_task_complete(struct pci_doe_task *task, int rv)
>  {
>  	task->rv = rv;
> -	task->complete(task);
>  }
>  
>  static void signal_task_abort(struct pci_doe_task *task, int rv)
> @@ -231,10 +229,8 @@ static void signal_task_abort(struct pci_doe_task *task, int rv)
>  	signal_task_complete(task, rv);
>  }
>  
> -static void doe_statemachine_work(struct work_struct *work)
> +static void exec_task(struct pci_doe_task *task)
>  {
> -	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> -						 work);
>  	struct pci_doe_mb *doe_mb = task->doe_mb;
>  	struct pci_dev *pdev = doe_mb->pdev;
>  	int offset = doe_mb->cap_offset;
> @@ -295,18 +291,12 @@ static void doe_statemachine_work(struct work_struct *work)
>  	signal_task_complete(task, rc);
>  }
>  
> -static void pci_doe_task_complete(struct pci_doe_task *task)
> -{
> -	complete(task->private);
> -}
> -
>  static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
>  			     u8 *protocol)
>  {
>  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
>  				    *index);
>  	u32 response_pl;
> -	DECLARE_COMPLETION_ONSTACK(c);
>  	struct pci_doe_task task = {
>  		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
>  		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> @@ -314,17 +304,13 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
>  		.request_pl_sz = sizeof(request_pl),
>  		.response_pl = &response_pl,
>  		.response_pl_sz = sizeof(response_pl),
> -		.complete = pci_doe_task_complete,
> -		.private = &c,
>  	};
>  	int rc;
>  
> -	rc = pci_doe_submit_task(doe_mb, &task);
> +	rc = pci_doe_submit_task_wait(doe_mb, &task);
>  	if (rc < 0)
>  		return rc;
>  
> -	wait_for_completion(&c);
> -
>  	if (task.rv != sizeof(response_pl))
>  		return -EIO;
>  
> @@ -376,13 +362,6 @@ static void pci_doe_xa_destroy(void *mb)
>  	xa_destroy(&doe_mb->prots);
>  }
>  
> -static void pci_doe_destroy_workqueue(void *mb)
> -{
> -	struct pci_doe_mb *doe_mb = mb;
> -
> -	destroy_workqueue(doe_mb->work_queue);
> -}
> -
>  static void pci_doe_flush_mb(void *mb)
>  {
>  	struct pci_doe_mb *doe_mb = mb;
> @@ -390,12 +369,9 @@ static void pci_doe_flush_mb(void *mb)
>  	/* Stop all pending work items from starting */
>  	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
>  
> -	/* Cancel an in progress work item, if necessary */
> +	/* Cancel the in progress task and waiting tasks, if necessary */
>  	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
>  	wake_up(&doe_mb->wq);
should use wake_up_all() to wake up all waiting tasks here?

> -
> -	/* Flush all work items */
> -	flush_workqueue(doe_mb->work_queue);
>  }
>  
>  /**
> @@ -423,25 +399,13 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
>  	doe_mb->pdev = pdev;
>  	doe_mb->cap_offset = cap_offset;
>  	init_waitqueue_head(&doe_mb->wq);
> +	mutex_init(&doe_mb->exec_lock);
>  
>  	xa_init(&doe_mb->prots);
>  	rc = devm_add_action(dev, pci_doe_xa_destroy, doe_mb);
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> -	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
> -						dev_driver_string(&pdev->dev),
> -						pci_name(pdev),
> -						doe_mb->cap_offset);
> -	if (!doe_mb->work_queue) {
> -		pci_err(pdev, "[%x] failed to allocate work queue\n",
> -			doe_mb->cap_offset);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -	rc = devm_add_action_or_reset(dev, pci_doe_destroy_workqueue, doe_mb);
> -	if (rc)
> -		return ERR_PTR(rc);
> -
>  	/* Reset the mailbox by issuing an abort */
>  	rc = pci_doe_abort(doe_mb);
>  	if (rc) {
> @@ -496,23 +460,22 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
>  EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
>  
>  /**
> - * pci_doe_submit_task() - Submit a task to be processed by the state machine
> + * pci_doe_submit_task_wait() - Submit and execute a task
>   *
>   * @doe_mb: DOE mailbox capability to submit to
> - * @task: task to be queued
> - *
> - * Submit a DOE task (request/response) to the DOE mailbox to be processed.
> - * Returns upon queueing the task object.  If the queue is full this function
> - * will sleep until there is room in the queue.
> + * @task: task to be run
>   *
> - * task->complete will be called when the state machine is done processing this
> - * task.
> + * Submit and run DOE task (request/response) to the DOE mailbox to be
> + * processed.
>   *
>   * Excess data will be discarded.
>   *
> - * RETURNS: 0 when task has been successfully queued, -ERRNO on error
> + * Context: non-interrupt
> + *
> + * RETURNS: 0 when task was executed, the @task->rv holds the status
> + * result of the executed opertion, -ERRNO on failure to submit.
>   */
> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  {
>  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
>  		return -EINVAL;
> @@ -529,8 +492,18 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  		return -EIO;
>  
>  	task->doe_mb = doe_mb;
> -	INIT_WORK(&task->work, doe_statemachine_work);
> -	queue_work(doe_mb->work_queue, &task->work);
> +
> +again:
> +	if (!mutex_trylock(&doe_mb->exec_lock)) {
> +		if (wait_event_timeout(task->doe_mb->wq,
> +				test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
> +				PCI_DOE_POLL_INTERVAL))
> +			return -EIO;

We already implemented a pci_doe_wait(), I think we can use it to instead of this wait_event_timeout.

Thanks
Ming

> +		goto again;
> +	}
> +	exec_task(task);
> +	mutex_unlock(&doe_mb->exec_lock);
> +
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> +EXPORT_SYMBOL_GPL(pci_doe_submit_task_wait);
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index ed9b4df792b8..c94122a66221 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -30,8 +30,6 @@ struct pci_doe_mb;
>   * @response_pl_sz: Size of the response payload (bytes)
>   * @rv: Return value.  Length of received response or error (bytes)
>   * @complete: Called when task is complete
> - * @private: Private data for the consumer
> - * @work: Used internally by the mailbox
>   * @doe_mb: Used internally by the mailbox
>   *
>   * The payload sizes and rv are specified in bytes with the following
> @@ -50,11 +48,6 @@ struct pci_doe_task {
>  	u32 *response_pl;
>  	size_t response_pl_sz;
>  	int rv;
> -	void (*complete)(struct pci_doe_task *task);
> -	void *private;
> -
> -	/* No need for the user to initialize these fields */
> -	struct work_struct work;
>  	struct pci_doe_mb *doe_mb;
>  };
>  
> @@ -72,6 +65,5 @@ struct pci_doe_task {
>  
>  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
>  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> -
> +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
>  #endif
> 
> base-commit: b6e7fdfd6f6a8bf88fcdb4a45da52c42ba238c25
