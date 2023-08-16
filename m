Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E621D77EBFF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 23:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346566AbjHPVkC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 17:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346575AbjHPVjz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 17:39:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27770DC;
        Wed, 16 Aug 2023 14:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692221994; x=1723757994;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TK4FlIkqGY0vIAZencJhyblftBQTKu6bpTH6VDuIGFo=;
  b=K2IFAXfvwTq3wgheXFgCIgOXIAX4kYPn4umyigFgboHafiMHpRLc5/gA
   sr/EVDplUoEM7eKg1fPIsffhBOPUI2Qx/LjSTI+WbJsuDyaYTAGPZboP4
   I6YZFaMYmvJrUMSfznXnebMVse9m9ybWInFeXR4T8mCPQ2p0wy+Uj4rlP
   xAGufxgRdhCxdEpx7jcTnjlL3kTgQUxByvTmLdUrUhuivOpMoBxbqu78X
   RL9TEawjJfPuuXJaYqXIylS61z/es7Zz+Fx0+yXt5qsanIOQkY9FtBbLB
   BJALQHysYRkJe9vhyQJxm86N1lSSAeVUBqQe1HOf/KuR1TCIoP46DESsK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458999940"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="458999940"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 14:39:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763773381"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="763773381"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2023 14:39:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 14:39:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 14:39:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 14:39:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 14:39:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6kk2kCdZogK2IFHJDiUQOPkzwOdq7Zg8Sy5vbgIsnPqNGOlUlpUiQUhgASeTaQpUWU61/VcnlXo+RjRxI6f8QwmUW1le9UHnNKBU1p4kUIqNyrPcj1OyWngShks7vrOSMBYWgTZaw2tBLeybA4IQLuE1jnW6kzJsr0hL3w+wj2zMpd0LCdUoi53WZn4QSJ+no6UAVwf5dBBAfP7gqP0klkiFLXKx8jrjdW2FRtHGqyor42godbNjgd7M9GN/AdQyAko0K3IX0hagVGey3voML9kangM2J986ddKDqB34l6PWCoKN36/hLeAbTurcDym1Mnk76oCzXtcIhytFLC4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkOw4k+IB2juEsmJT6yRgGWRKcYz2iOvjMhBWWzpVOc=;
 b=PBpcGgbDGpE31MoS4j0kIolYQyy121p4m1jEqZQWFnnWWMckH08ALLji0SDtfk8mNmdItIJplLB7LM8wOGNziVzyBPi4bf5EJ6TT7JX9laPrwpu7JBpOaQM5wIeRFEpSaEcyAEPE8TsNhpn8xf742XNhnv8Do2AtPZ4dyGq1XlDOeUyx/G86UaThqu8eXYylqSV/Tbga8xmjGqFVRL4BiVMB8n1xfFWb0q1HMmaErRXiQDbWszAmnjqs1xmVbNAECnEl0HVg2l7zT9IJM40c2/wyc/6rxnZp+kjOvoeZuzisWTtehZMdI04BEgiwCNyjlkKXysfiABxo+uPjU/D0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 21:39:45 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 21:39:44 +0000
Message-ID: <8a07413f-d51d-ba66-708f-f26a39708298@intel.com>
Date:   Wed, 16 Aug 2023 14:39:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v3 1/3] cxl/pci: Fix appropriate checking for _OSC while
 handling CXL RAS registers
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <oohall@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
References: <20230803230129.127590-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230803230129.127590-2-Smita.KoralahalliChannabasappa@amd.com>
 <20230804130929.00007dfb@Huawei.com>
 <5547a005-a492-9996-2d60-6919c3a6cc05@intel.com>
 <674e6ba8-1e91-3e27-357b-c86252a1f71c@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <674e6ba8-1e91-3e27-357b-c86252a1f71c@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::41) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|LV2PR11MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 873bc2e3-8360-4920-7a14-08db9ea14e80
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdyL/XJ0YaJjDu1+HYElbDvAbxiAHKFXhEdx0SpgVsmd1tTYLJ8TKVz+hvb+9StThfjjtO8yHt2VDnmZkljJEBUYIXReYgs4fk+NBCxVsn5Wyj10ypThuX7QuZejVbcJtwVWnLbhAcXBdTG7Q7lEcSFrQnszd2smcS5yBfGkNCOFrqXJ7MWXLJHBFTwXu5wn0PrYMpVIJ4cRzeUFU/F+trINrhCStPL+mQijhr7BDjfxblESriK6t4FMNjBaKbtPPwD5aNAIpBgpQY1rAU2o25XOsg6f2cCIvyzq2WqklS9+UogbftSpB3Z6BDvF/I97+jpU0GhLmA0kvfeiP5qTn+xylA7FXq8DQpqXb8ieeFpsOnA+s9CPd6cRwSooIlwM4w/LZSBfXkRI2t7lysgHA12oGRoEERXE1lgbEwQU6h2mPf5r5ybxN8uVwBmqxj960d4KcVhW0NEtPZ4BhG3LAZv6uGVdHNaNpeeISv0N/XO1g+CJn79+Mq2qJrCsxg6Sc1bnmdKFvxj1aTYuIFupQvMXABTnADRwG4J+RzGomkBIZ7yQ+LdCqpYXRJVHphVt/Pjuc/XCCY/V77HSx7fZMNoU/anvMxTzAgb/JF/+YbdMnuCD+aJTd6qBHxaC61Wie2lTmDI8qrTbYdOtE7Imhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(7416002)(86362001)(478600001)(36756003)(6506007)(6486002)(2616005)(6666004)(6512007)(53546011)(31696002)(26005)(966005)(44832011)(5660300002)(41300700001)(54906003)(316002)(66946007)(66556008)(66476007)(110136005)(31686004)(8676002)(8936002)(4326008)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEhCVVAvM1VaQkpYYkdVc2xJOVA0WlJEMDhaMlN3UlpHNzl5RDRyU1VkQnZQ?=
 =?utf-8?B?VGE5UlhnaXZYMHBtamo3TzN4S1NEdmlpRklMVSttZStjNnlUeGJIVTlqSUJ3?=
 =?utf-8?B?WTJnbEFCUEhYbGlmL005V1o4enYzZUN1N0dMdDhtOXZVZDNSaTluYWZJajJZ?=
 =?utf-8?B?T1NtYi9JQmx1eStGdVJLejF5VVpqYmZwTnk5TkxlYWhkbXJiSzVid0VreVB3?=
 =?utf-8?B?cVFlOWpkK2VTT0Voczc5aG4vck5Nc3hPL1RoOVJWVUZIVWNCcElkMG5Ocmc3?=
 =?utf-8?B?NVFRZ05wd2hkNm5tZmpwb3FlSyt0cnNRK1g1SnJ1UnpGQzJ1UlAxancrbEkw?=
 =?utf-8?B?MkY3MndtQUk0cnpmU1RmQThJVHpwOHNPUytpVDhzeWhDSnpWRCs0UnRiL25o?=
 =?utf-8?B?NG81MmpROTBZSXVweS9sRnhtSmhqU1ZSeFhzclRpMGZwb2U5cDRUaUszZUZS?=
 =?utf-8?B?cGNTc1A1bmdqc0swRURLZStNaTEyL0taeS9rdmFTRnB5RTIvOFJWKy91dzlZ?=
 =?utf-8?B?bzNJZUhIeVY4aGprWmM4aDdsWWVHUFE2R1hPcEI5Z2h0V29lb2d3bXA3QTAz?=
 =?utf-8?B?ZkxMOExLRER3MytRRExzU00rdTVXcjFGRzdqQnBmbnRTdWRBRzRTM215eWpS?=
 =?utf-8?B?c2Q1TmZpaW1zaVBDUENsaVpIZmJxK0dSVlVFZ1JzUHZtSnEreDdFazNQNVI1?=
 =?utf-8?B?djc5T0FVRnk0K2ZRQ3hLOHhMWjFSZmRhdHJPREVsMTNQTDJJSm1sYVZ4QjZH?=
 =?utf-8?B?amJCYkcrS1NwK1Bkd3ppM1EzMmV6YVNzR3JwMUFEdUJUM094V244ZFlkakJi?=
 =?utf-8?B?Z3BnQldyaVgwYStpeGhIampGUzZhb1d6cWwrdHV5U0lFN1NEbTN3TzREVVJH?=
 =?utf-8?B?RXp0ajV6WVVFQWY2NjhUU2djUmt3cHB5NERZS0pQaStqdytnL3JMUDJKY045?=
 =?utf-8?B?U2QwMlplS241czh3bmNtVUFIWFBnVmU4RytlM0VLTVdwM0FoZHE3WGloRXcz?=
 =?utf-8?B?dFUzM3ZxVXo3VjNncmJFeDFLNUxIQXZRN01GWHhJUkp6ZzhBc1pNSDNERmRL?=
 =?utf-8?B?UUM0UUVET1JRNTNXbTIyQVZuWTliM1NmbXdPYWNSd1JhM05LOEt0TzJCUzhy?=
 =?utf-8?B?cWYraTQ1QU04MWpnbnRJU01Udm0yUlR6Zm9qZUZMckV4Q2NpaHVCT01FVkgr?=
 =?utf-8?B?RXpSTnZPclhSMkU2R1ZJalFQbHZ6Ynp3dXFuZWk1U2N0bGVId0VUNVRBTTN0?=
 =?utf-8?B?NmNRSzB5M2dvMFhydWNIWXJjZU43RTVxMzFDT0VzZVg3bmJKT09CSFZPYzRM?=
 =?utf-8?B?ZXlBS1c2eWRTWG1YeHUwdEY5V1IwUTloVXFiRzQ1OStyV1graEtEd25vazVT?=
 =?utf-8?B?Wk1LL1I4MmNqMThnaXZnalQ3QXh4M3dKU3ZOTnFmL01KWmIzSG4xQ2h2dG9p?=
 =?utf-8?B?YzBLSDVVdGlOZ2RaVTJrR0RtMkNaWURJK2dVeWs5L1IzL092WEVJb09tYXF6?=
 =?utf-8?B?WU94enIwVXJRd3JpZXN2bk1DRFphRU5WVldyREdNc2F0VjhrVnByVEJ1SGps?=
 =?utf-8?B?YmxyNUdxSXZmWlQwLytPT1hDUTRqY3hSTVhSTXF6VlYwdkpNeW9zL2lOaEl0?=
 =?utf-8?B?bUljR3d2MUFYcVMvWURhTlBLdDcxQi9oTmhuL1Y3aEQrek14NEE3Z1QyMmJ4?=
 =?utf-8?B?ZVVOQVRNZ0o0djVtNVowN3hOaWVqd05ZYjlxMGRsV3h5Zms2cVJjNThQSGF4?=
 =?utf-8?B?cnUxSVlaeHFET295YTFTak9GQlQ4ZGNQM0NhWDFUQW1hbEprR3NObXMzbkFP?=
 =?utf-8?B?NkN4ZDRsVGFLWDlEQngxTlBjSXFOVkh6TU9XS1RwT2M5VDZXZFBSVms0SFV2?=
 =?utf-8?B?LzRaZm9LVmxjd1pDSFhvOW1ZOXJnRWVzaWFWTE03VjBBZmYycm9XZGJBbW1X?=
 =?utf-8?B?dVJhOVVtVUIxd1FFN1lMVlZ3R2hHUlY5MDZSNXl0SlJ1b25abXkwWUlNVFQ2?=
 =?utf-8?B?ZFNzK3padm9lUmJVZEFYNVBuSGRwVGJ1VUxTeTF2VDZCcUJWcEdmVHo1bGha?=
 =?utf-8?B?QjVPcWRWOVR0dUJPSy9aQ0Z5bm11eS81cGdIcWVKb2hqWTFwUStNcFB3d3Rx?=
 =?utf-8?Q?pVfj+6nvm68MOddQKvuIAfd/o?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 873bc2e3-8360-4920-7a14-08db9ea14e80
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:39:44.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8HMbcjck0pVVHFEvdd+FTEtLI7Hm5wYeXOjPNvyo01+rWZdu2wWEs6bc6JZR/QeSanp7Z8pP+uzxdkdmY0ciw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/16/23 14:33, Smita Koralahalli wrote:
> On 8/16/2023 11:06 AM, Dave Jiang wrote:
>>
>>
>> On 8/4/23 05:09, Jonathan Cameron wrote:
>>> On Thu, 3 Aug 2023 23:01:27 +0000
>>> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
>>>
>>>> According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
>>>> of AER should also own CXL Protocol Error Management as there is no
>>>> explicit control of CXL Protocol error. And the CXL RAS Cap registers
>>>> reported on Protocol errors should check for AER _OSC rather than CXL
>>>> Memory Error Reporting Control _OSC.
>>>>
>>>> The CXL Memory Error Reporting Control _OSC specifically highlights
>>>> handling Memory Error Logging and Signaling Enhancements. These 
>>>> kinds of
>>>> errors are reported through a device's mailbox and can be managed
>>>> independently from CXL Protocol Errors.
>>>>
>>>> This change fixes handling and reporting CXL Protocol Errors and RAS
>>>> registers natively with native AER and FW-First CXL Memory Error 
>>>> Reporting
>>>> Control.
>>>>
>>>> [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
>>>>
>>>> Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
>>>> Signed-off-by: Smita Koralahalli 
>>>> <Smita.KoralahalliChannabasappa@amd.com>
>>>> Reviewed-by: Robert Richter <rrichter@amd.com>
>>>
>>> I'd be tempted to add a comment on why this returns 0 rather than an
>>> error.  I think that makes sense but it isn't immediately obvious from
>>> the local context.
>>>
>>> Otherwise LGTM
>>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> Echo Jonathan's comment.
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Yes, and Dan is probably against returning error code.
> https://lore.kernel.org/all/64d1b3e78629f_5ea6e2944@dwillia2-xfh.jf.intel.com.notmuch/
> 
> But I think returning zero is required as we don't want to interfere 
> with cxl device access when operating in native cxl memory error 
> reporting. Returning error code will basically fail cxl_pci_probe() and 
> thus fail to create a cxl device node.
> 
> I was thinking a single line comment as: "Return zero to not block the 
> communication with the cxl device when in native memory error reporting 
> mode".

Looks reasonable to me. Unless Dan feels it needs to fail the probe.

> 
> Agree? Or anything more that needs to be added?
> 
> Thanks,
> Smita
>>
>>>
>>>
>>>> ---
>>>> v2:
>>>>     Added fixes tag.
>>>>     Included what the patch fixes in commit message.
>>>> v3:
>>>>     Added "Reviewed-by" tag.
>>>> ---
>>>>   drivers/cxl/pci.c | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>>> index 1cb1494c28fe..2323169b6e5f 100644
>>>> --- a/drivers/cxl/pci.c
>>>> +++ b/drivers/cxl/pci.c
>>>> @@ -541,9 +541,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>>>           return 0;
>>>>       }
>>>> -    /* BIOS has CXL error control */
>>>> -    if (!host_bridge->native_cxl_error)
>>>> -        return -ENXIO;
>>>> +    /* BIOS has PCIe AER error control */
>>>> +    if (!host_bridge->native_aer)
>>>> +        return 0;
>>>>       rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>>>>       if (rc)
>>>
> 
