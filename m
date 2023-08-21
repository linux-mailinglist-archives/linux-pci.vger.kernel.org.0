Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AB3782CE6
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjHUPFk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 11:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjHUPFj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 11:05:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFA2E2
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692630338; x=1724166338;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SHMErgrfqSZZ9DECEQTKYnvlAiD7LDIdLsjBgzLwo9w=;
  b=SMO1VbHI0QOWUWful1WEOAVL9ApahpX7VNNvWrWTvbvtyQ9PtcaS6S5D
   FWkEkAmtNubaZAXYJUV83boPhvk4uFNTVK3gLSblIc6ZTGQuMvncFtMzN
   apWBSjLaftByH9nA4F4KRss8pxb4rQULY9BjoCKsZIJnpC0MsmWben/8X
   3WW6/tKlkfDyzS5TlJtlpZpIdxn7vtxr7gq9c4ibypi42y7JUC9Vzb0XX
   9FntR7OoDMlzo/vTN3TFTM14cXJ48koULCgaWGjVUuXzsE9xdMowXYrDP
   cmkMgPyWzth9zfYAzyCXUQCJGLkl2uCZOZ63VRYFfJA2KMroMTEfqSpGR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376361443"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="376361443"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 08:05:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="712822898"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="712822898"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 21 Aug 2023 08:05:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 08:05:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 08:05:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 08:05:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDZQza/KGxsW675iMkhXATNaKSyNIL44UdaUOPgWeKlWlGANDj6bYt8nIQLBC5gzoFXBLGTtu3gb9PmzsAHPyhPaIMsLFBebQP2JzzsopDMRvhGuel32vkV5MlKbqIujLj+Ro8RrKekp0wf4O1O1hohRuMNUzWP/y1yOV39I+Fz4gi0U/8Pgx1DmL0GwngdBgvtDkI2DEOXe+Rx+nc4aZo2Xn+EzczPehO67IfueIE1WPBLZWrwwASKFqQ/iygFr++3nIcy/djPscjqWly54aJo+/azOhHLtVmuCYm93c54NLE2Wtil492qD4oEFelq4cIyjt22siyGlJXJ8BrPl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2CI26zti5dYbWSv0Qxpcifgd8uRB4jc//8INK/qzF8=;
 b=MhM7oAMEdmF1b03RquOWzVbXaiFrOwiRgJ/seN+UBnUJ4pkCGuo/lmSRQeWFb7Y8hxZZuC4OmDLbciJTzlSiknGNtdezKaIbWbbTSVzQfp9QJjdLSWvLgusOCoUhqn9YM8y7YY7cV0lLERPbG6JiwDajdyMzfHtAJPF1HpKwuKz1aQYnoFtmx7UXC5vvWpXNxEKgwwT759nUV+IKuJmFaLJlQsvQ3E1Ao6Mfpi4ewScp8j3WWZVM1DCDdqbe9qbijlJtRrYkW98N83AP08+ldlFIg5zZIJnT5/LJvXVHZ6qmNsreUvdnSh9Rc8hfI1GMiEf4RZGvr0kTdnbdneeV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 15:05:34 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6678.031; Mon, 21 Aug 2023
 15:05:34 +0000
Message-ID: <61d5bfbf-bb1d-5fc5-1a71-b15495e4c9d9@intel.com>
Date:   Mon, 21 Aug 2023 17:04:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] PCI: Disable ATS for specific Intel IPU E2000 devices
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <sheenamo@google.com>, <justai@google.com>,
        <joel.a.gibson@intel.com>, <emil.s.tantilov@intel.com>,
        <gaurav.s.emmanuel@intel.com>, <mike.conover@intel.com>,
        <shaopeng.he@intel.com>, <anthony.l.nguyen@intel.com>,
        <pavan.kumar.linga@intel.com>
References: <20230816172115.1375716-3-bartosz.pawlowski@intel.com>
 <20230816173906.GA292642@bhelgaas> <ZN3t2eYU09iW/4At@smile.fi.intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZN3t2eYU09iW/4At@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0186.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::15) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BN9PR11MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: 310de84a-62b3-49d7-7932-08dba25811f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/muXjUnt3OospZzK8VxZL4Ejv7SuWp0fqz4KmCcUxGI0I6MQe2XkYeS4sbfYXn7J4Kg6z531x33EB1LA3cxAVkgMiFQRnsbucxybkIenY/xNBRDY1i1KEENNq44lUxdX/aj3ZftaUhekp1gpls8h8RIyCt5+whWO3FKhdlwmLOAVqbrdcY+vc5pUOeTUOtHbLMh7e+3clGduv/4Pgm2pvHLPJhmriJdzLuZVy9fQGHX5ZVhxJ018LlKxgJAtLbty138dqz47qlKvk13LCUMQQSrI2un+zsrL8bk5nSCn9cZRVR1X9GTWCM2+QPj7rkPq7GlPH/+v74DahhbjN5TbBjR1vwjpsHpw4M4m8UZPIPAIPrP69JjYqCow6TU7F2ziRfm82r5svUMyQcpwun8/MtW548nATkC4NBdaTLVf7HymUmLEGbzcz4Js44A2Vn9w1lFS3WpSMUPCJ/8k7vLCLLQLMWqSTSP9xuunMEQxA+iq8AHqXwlJDv5LdKpvCJxVjVw0+Hcv/zvIQJnkFsJYiydKhPKIahBFCZG5R0RpMvh91pqq2lSHMJvcr72/2j4nhvp/F7YO+xlSaSRc4IOFzMXoCPVitHnDZmy3pSJctBn98d+dgIa8HszXO91A6w2Z+XNEOBK7BjvuMkOq7NcMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(66556008)(66476007)(110136005)(82960400001)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFFHZElwOC9HdXFnSGV4bDlQQTM2UFZUa05penUzS3ZLMWJuandEeVRNZkls?=
 =?utf-8?B?dXg0WDRZL0twZVdkVUhUVklBN0ZMZFRKa3hRTDhuWGZtM0hCajNSdjN1WkNV?=
 =?utf-8?B?eVZQc2JGcCtxU1E1bjJSQVpvT3BIVTVRT21ac3ZubXF1YUoxYXN2NjVvRk9v?=
 =?utf-8?B?eE5jTUdVb2IzY0RTVUxHcktKb0k4elZGdFJIY3FnSG5hVVYvM1lremp2aG5o?=
 =?utf-8?B?bVd2dUpBWUdsRjBPOWVVZjhrUm8rZXF4UCtRRHdiK1JYWVRpY3k4V2hwYUth?=
 =?utf-8?B?a3o0T1ZuOEZ6LzNQU0ZGSXU5STRYcnUvYXkvMk9nL2xDdjA1aFpUeDZoRU1G?=
 =?utf-8?B?Nng5NXpyZmNNRHhxNmhlWnpmU081dGlCZzlGNTRtZitsL3d6SzF2RUpCRWtx?=
 =?utf-8?B?b1l1b2ZnbHJ0TUpSRXoyS0ZCQ3BFRitBU29rbVQzd3B4NDI5SHk2eXNLY25y?=
 =?utf-8?B?R0xRVDd3OFNJaXpZMVdoUlNHV0NMSGU0bTB5VlJ6ekZyNk1jQXlNYzM1SGRk?=
 =?utf-8?B?S2xxV1BvdkN2cjk5RXlpcWQ5QkxIcHF6YTJ6TkFOQ3o0YkFUSTIyQXFOK1Q2?=
 =?utf-8?B?RG9JM2hpSVJMSzZYdmdPeEg2WDBreWRyMFFwMjdQNE92QWswNGRURkRUUE9B?=
 =?utf-8?B?aFkvZDFwR3VZZzNoUytlYU16UEQ0L3JMYldHUVg0d2dmVytzS0RIQ0N5TlJF?=
 =?utf-8?B?SDlwZk4zQ0MzWkxqTnVmaDhHZWJUbnhrN1RuMmQzQXBCZ3FVNXduSjhFQjRp?=
 =?utf-8?B?dkFvbGM4YjFEYkVQNnRqUmFzcHFZNldPZDMyd05PRXJ5MUJHOUhMdm5LU3Zn?=
 =?utf-8?B?L09VVkN0Zi9oWGRYRFNRUSt4MFY1TFJGYmcxbm5QNkVIZ3d3VHVRZUlNTC9L?=
 =?utf-8?B?bk1xK216QTdlNFZ5QWVwazZaTkdvUkJhSTlCM0R4NUZQSGlRLytyMEVXSERU?=
 =?utf-8?B?eEFoa28zY0UrWVV0ODJHb0ZBZGJXVjFocFhja3poUkdwL0lVeEdlVjRFVkth?=
 =?utf-8?B?SFJpRGlIMXJoeUJyLys4YmhoMEZqRWhIdSt0cExnKzhYT2hreFdVa2pueUNT?=
 =?utf-8?B?Y1huYTZXdVk1bk5vNHJzd1p4aUIwQk01K0lhZityMkNKUFkrOGQ1d05IYzRj?=
 =?utf-8?B?ZGRUTHEyaklIdkN1d1ZWbjVkWXBRemR5NVpYa0pFTHYyUXJBeVVEeG8vOGVp?=
 =?utf-8?B?dUY5WnJocExkeXh3dUhVajBRL3VuUFV4RXg3ZHpNbEk1NTYwZm9LR1B1NCt0?=
 =?utf-8?B?VmQxdHFYTXp4NWhuSEYySDFYZ3VtK2tjbi91MDZyOVdFT0VBSnRjYko1cXd4?=
 =?utf-8?B?OFNOZWNkMHRjN1J4eGp1Y3FEZ1BveFdXYUQzUmVOMHhoTG5YK25pY2ZYMWMx?=
 =?utf-8?B?WndsV1hOK29ZVXd2SDZ5TWlLS1VDTDR3NDk3Q3BCeTV6VzhGbFFULzVvN2FX?=
 =?utf-8?B?dENKVzRJa2lXeXh5OTdVMnZpRitYbU9Ta01DZHlWbGtsOW1ReVA4RjRsRjNW?=
 =?utf-8?B?NEJwcTlHVFVjNlFWRW51b1l0SXdGaG9QK1ZIRUR5Ulc1MitKdG1rMHh0WHVN?=
 =?utf-8?B?Y0RzWGdXYm83eS80WmVsNHU3ZUFsdXJtOVZ2T3pNNGozdllBUEtHbS96WVky?=
 =?utf-8?B?R2ErR21iNWkxN29WNTA0dFF0bkVVK3lkeXhyQnR5WkYwMFZPODNod1ZQYjlT?=
 =?utf-8?B?NTVyQmowR1M1MWxoMXM1RjlpdEcvelNuVmNlUkJPYllEV3UzUGs3WVNHNHF1?=
 =?utf-8?B?WXZlRXpwQU5lakZJemxkWDBTVnRlWVhFU3pCYVJaVDVmbTZvc3RtNUZFSW1Y?=
 =?utf-8?B?VVZuNGc1U2h2eUk1Nm9CZjUrK2wybnJnY1YyNDZsRVJiTGJlQ1ptZnB3NzhF?=
 =?utf-8?B?NkFwTkVhUGF4U0xJUFpLMWM4UEhZSzlVQTJyemxHWTVScE5ER0I1Wmt5RDV3?=
 =?utf-8?B?TkdHNWdBVnRRVXBOZUh0dmRBZlFlZWNVVW5GcUsrQk00VlNZNVRlTW9oTVdu?=
 =?utf-8?B?NWV4UG05TjdvTmtCT1VjNURHNTBDVE00Z0dEbE56Q3g5Q0Frd29xMkk2M2NX?=
 =?utf-8?B?b2xrQTNGVnhQUTNYcUNmRjhmTG1FM3hCSkxZUE1DWUV6VzdMU1NmVjlwRWhP?=
 =?utf-8?B?UVlJU0M2TTdMMUpBNkcrNkY1WHhRZEhXYnlCajhyY3E1MGNjdlhZMzBPb01x?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 310de84a-62b3-49d7-7932-08dba25811f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:05:34.7620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rL2V6sTvkyA4co9iF77ETN4f9vh6z2VZrh5nSOMeBKOkfUA4issuomo5+u8NdiuHGrDaqcVtxRM+ePO95aML1hEWrH366FTHDkOzof/xAg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 17 Aug 2023 12:52:25 +0300

> On Wed, Aug 16, 2023 at 12:39:06PM -0500, Bjorn Helgaas wrote:
>> On Wed, Aug 16, 2023 at 05:21:15PM +0000, Bartosz Pawlowski wrote:
>>> There is a HW issue in A and B steppings of Intel IPU E2000 that it
>>> expects wrong endianness in ATS invalidation message body. This problem
>>> can lead to outdated translations being returned as valid and finally
>>> cause system instability.
>>>
>>> In order to prevent such issues introduce quirk_intel_e2000_no_ats()
>>> function to disable ATS for vulnerable IPU E2000 devices.
>>>
>>> Signed-off-by: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>
>> Andy, Alexander, would you please reiterate your reviewed-by on the
>> mailing list?  I try to avoid relying on internal reviews collected by
>> the author.  Those are great and I'm glad they happen, but it's good
>> if they also appear as part of the public conversation on the mailing
>> list.
> 
> They are legit for my name, I dunno what exactly you want to hear from me.
> The internal process of review requires these tags by default, it's hard
> to deviate from maintainer to maintainer.

+1 under everything, it works the same way for me.

[...]

Thanks,
Olek
