Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA80689317
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 10:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjBCJGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 04:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjBCJGl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 04:06:41 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ACB945F6;
        Fri,  3 Feb 2023 01:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675415200; x=1706951200;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3FRcf7AfP80XcdA7PVlyRBne7hWwSLdVQMxOtz1LJj8=;
  b=kBH1s5hns9xTWcqDKYIMVgNjStsp9ASCMWMfHpAv6WkyxtN3kPRAoGx6
   hw5gcmBCTmBLxNrQZIW2PoiRsjoOgNp+Dn7dx2H+UGocWVCCmWoIiarLA
   L7AR6xGxD6/2oqd44XvdiTRePq4clU/r9jpxYIZvuxrY9n2zfKYD2ZqSE
   OZwVIEQG+0LxwvEJCfda69M0i4jrPkulWb9/jpYA9350IlzKS0Jfu9qfL
   ioeVgx9/Urwj0hSGO3gY0hWlgkVjE9N7RaPLwJy/g2b1CKbw7hK6xjOZ/
   5oYSj+9uDqV70rVo9i7F+I6tQpuZQPlomtRZzahNtkoqIFpQQsJjkUI86
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="393290502"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="393290502"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 01:06:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="667589114"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="667589114"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 03 Feb 2023 01:06:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 01:06:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 01:06:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 01:06:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMPCbwj4J6kjaaue+BSSZVcDuMi28LZHvFArJtuHgc3qRiZLXHybTdLTxHHKF5UBZPit8vRKAmwrJ8vTZxXRTLcbWnEKYbkoTH+wSV3/8/54tc2VWTlaTzyqkN3uElYZNV9Ut+qW+NR0SVx2qebrpkOxbQI9CmW78EcRSDSieCWDNjlGVB+MKG/9WoqjX/6h4s5aOdoI5hPTuBL07V4jDznOeo0YiuxIqmf6x2sNo2C6lwFrBVJM0908QmcVxdv2fObgFNFBrgEGGU4h0BdEeUlfntSIBm+vMzP4jfvosIUvVkVUmCggHBXVZGTXkEp9cQNivsSQIfBIrdoTQBf52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbBMyIp0tOsf+8WAL6e3aRs30YbrZDFOJMrny3W5C1s=;
 b=EVRNKiOSUlhOtt7QblclC16sSZJGAKwA6C0oX3w4QKwe8t5XsMNfA2/akidWRM37Gn+wANI12fnRpOLu0KHF83LzMQNQJWoPEhZkQcKZFOT8wfefQvL66cesIuJScbiZrNGyy8/QptK4nWg3C+GxM+vLnLlJ7l8wlB+CDuHhW4fx3GWUxUX/ZFpcXbQn30WvnJ1rJ5kPVE6rv3pUWfUWVviTIZhEj7r2x068ypaGY7NxAdCdbSA03BUTlWteSy2ONGgnzt71rshQ6gTDmxQan480Wpg3sxfX4WoGP6/yEmCcmL+8cLy+rxRr1EOBl/JJjtfvde2cfrtUShAaSq+jkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by SA2PR11MB4971.namprd11.prod.outlook.com (2603:10b6:806:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 09:06:36 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee%4]) with mapi id 15.20.6064.024; Fri, 3 Feb 2023
 09:06:36 +0000
Message-ID: <d6d3a6c8-7b82-77c2-3407-705916c020b7@intel.com>
Date:   Fri, 3 Feb 2023 17:06:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 06/10] PCI/DOE: Allow mailbox creation without devres
 management
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        "Gregory Price" <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
References: <cover.1674468099.git.lukas@wunner.de>
 <291131574c9e625195e9c34591abf5fa75cd1279.1674468099.git.lukas@wunner.de>
 <20230124121543.00002600@Huawei.com>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <20230124121543.00002600@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|SA2PR11MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 4001b9f4-9240-40ea-2673-08db05c5f310
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VRPcS+5y8JYs9PDF9Ms18SOAKZnLAGivTOq3vjRj8XrH+reonn1bTmGtVUGfX98039+p7gU5co3wATSQ3qwZ8GlfqV0JnBP9mUyjGlroLeF1glGtHuT2It1pbpkfmQVKHW5VuXTNaAfaOuda04gxc9tPBL8nZ56m0mmkD29eVb3appaRZwu/OYi46SxqiM1ntawoXl29NGAdM/0VqOxW8TJGxxa+CVk+vYWqN9hDQ0I56L/VQ9kvP2C1ErlprJFssNm1TAW9AVF/UIzt4eOKDShsH+ruARnALltrnb4Oltr+oPPx1OP8PMZ1HzYe1Y/zBn4OlBGfKudHq+Zx5b4SgqsWOQTUbiEmqOShq34zySmC5axNq6ojtdkR7icgkI9Gp9DwJ7IX2EpN8gVkSZYVoX+4LMQDVt2N4d4RHMOg5OSQbxzSJec4bX9uwzz6LUuqK6KpEoWPZoqD0rAEykqhnKeuNNWHk9sBVzyvBfeSju6FcKlHLTaxOX4HcPxUiG1ent6q7o59VMYKBw8ARWcnfMEJqSOSL6k/5zgiSUUXOExnH7b0mBf5t8xkZlRPcSSM9FJmv4hNi1it/JLzBD4Uh7c1D0YI6941HGO/3XyHQ2xArvjq1LkC0t3Ca7d1/qMRtpFiCuhWQyF7jr8SmIL5XFWxLYb+Nnc7l8E2ErOCSW+KVrboSH0v/2AhNChvROQQkqH3e6n250QZCO4bFX3B0UB0lTgAiglEoPRDK5oc/qQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199018)(86362001)(31696002)(82960400001)(36756003)(38100700002)(41300700001)(8936002)(5660300002)(66556008)(66476007)(316002)(110136005)(4326008)(66946007)(54906003)(8676002)(15650500001)(2906002)(83380400001)(2616005)(6486002)(478600001)(36916002)(186003)(6512007)(26005)(6666004)(53546011)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N01HWlBZRmZVenNmTS93Zk1YZG43WGtqeGYrNExSQmEwRVI4OWhOYzRBbXc0?=
 =?utf-8?B?RGJHRkhkR1YyZkIxZnVaMXdVbXlwc1pld1J0cGEyR2c0Vlg3SE5DMm9ZeUNU?=
 =?utf-8?B?T3VqbDN4cGtJKzhsTCtqamc5bC91eFNGSDJVOURYcEJPbmRGeWVhczNieTVB?=
 =?utf-8?B?ZHJVRWphT211VU5FKzVxcktOaFpaSnhzVnBjY1RCRVN5ZEpSWlRXUFI0TXFH?=
 =?utf-8?B?U1JaL1d2N3Niazc3a1kzUWY3c3cxUUh5YkRkcjNqTzFIL3Q4eUxPTCtXQ3ps?=
 =?utf-8?B?ajdIUjhXMzNIZzBsWTR1QTNXNTBHZjlIWVpGZjJZUEM0VEQ4OGk5MklYT3hF?=
 =?utf-8?B?TlkxVERLTEYvT1NhK1dpQTdFcENuQlYzRVEySVoyR1NlN3ZxR2dlcnhwZU5Y?=
 =?utf-8?B?RU5SRVo0WklldThCQmVoRlI2WkJHbG5Nd0RHZy80dExFTk1YTUF3V0xGL24r?=
 =?utf-8?B?RFJGRE5zSjh5Rjl2MmV5NFhyNmdvRWtFb0xyeC9QSlNrYnNSaUp0TW90cWpv?=
 =?utf-8?B?dFhYSDI0YnJBSmJEZ1BySERJVDh1NnAwODdNMWk3SlRZSjR5amNnd1VBQ0F3?=
 =?utf-8?B?NXdVNDZPTU11UlZMRFY2SXFPWFpwRkJKc1FrMWNZK2NKMjR4eExqNk5VUDNQ?=
 =?utf-8?B?QTBNb3BqTlNJQXJvK0dhZWs3RFFBUzdlOE5Ud0g0aWg0WmhmNncxb1RkeU1v?=
 =?utf-8?B?cXFXa3hES0ppSzV4aGdPZEh3dFRYK05wWXpmMlFIWktTSlF4SkhPUld1SFhE?=
 =?utf-8?B?c0NuT2pJQXN5ZENuSzE5MjAreHZpV1J6THdhMmtYV3pLbzgyM2FhTWlZaDdp?=
 =?utf-8?B?UWRVK1A1RTd6U01yeEp3NjVtUWUwaTRiOWF5YjJMaGlMdTh4U0RJanNpWWlq?=
 =?utf-8?B?M0xBdEMzZjFmY0Q2MW5wN0hBYUVSZUhXZmpGeDZZcVZkV0NnRG54K1NMQmVr?=
 =?utf-8?B?OVhydnpQRUhXS2wvN0ptNWMrcVJ6VGY3U3k5MHJGNHFxdEJlU2NaZTRmbkt0?=
 =?utf-8?B?MlJLakVSMFF4WFNtclFsYnZ2U3hvcEl6VHRreklUbVUrN2hDaG5pNVFjbkRp?=
 =?utf-8?B?MUZLNU5kaTFTaWhEcW51bGdldUsrUXNmRkM0Rkd0ejluRTVJNTk2RzhFam15?=
 =?utf-8?B?cVpyWWJhMm5ML2plTVNLSUkyOExmemkzZUI2bnNZcHBkN1g1Q1RzcUhHeUww?=
 =?utf-8?B?dzBmWWl2NjJmd09SZVd1elVMK2NXSnBXOVVtNnNhTi9XSmQ4RWpEMWxqRDYx?=
 =?utf-8?B?YklQYVJ6dWUyQVU0NUo5dUlzMVJCTTFYa1JCRUZGQjNTQko5d1cyVCtFYklk?=
 =?utf-8?B?RzNYYnBPenJiTHZ6aGoyVXZCMnlLYjlBYkhITFovTGZ1cWZPTjZhYzU5UllX?=
 =?utf-8?B?M1BvUUl6aWh2OEJObUo0SDhTZW01b1JUZU9tZEpVODRadVl4cmVONGJyRXdP?=
 =?utf-8?B?WUsvaFgrRTJyKzhsbzlnTS9mbWk3T1RGZG53K3BtZnFOaEVtMy9wYnZuVi80?=
 =?utf-8?B?a3pFemNnNk9XNkk4MTFQVXhCYWozU2p4QTBwRHJhYkhTM1h3YmNqbTVoUzhi?=
 =?utf-8?B?blRyQlJFQXB0cWdYai9CTUNpZWZMY255NFpHRXlFL1NiVTBwVWpTUWxNWi8r?=
 =?utf-8?B?TG80QmdZYU9QVzhFOTJGNHNTMHRpbkVwVFZkVUlsc3dHMDBWWmp0NlFMU1Zm?=
 =?utf-8?B?aHIxZlBzdVlNZGlPaFJXbzJLdkw2Nm1jZmduNzBCNjg0QUx3K0Z6L0NmK052?=
 =?utf-8?B?ckhYQjlTYzFrRVQ4c1BCYTdwc01aWEcwN3d3UGthNkk2bUhBdWFkSlFBdzBk?=
 =?utf-8?B?S1pndFQvbGtRL2kxcTNKc1NqbytRYUVQV3BiTGtCREtkdnIwTGdvcjl2OG5v?=
 =?utf-8?B?ZWxGZ1M2OE9aNU03VTkzWGFiSXY0ZjdIU3RJYTBjSmoycFlXMXdBZnZPS1ky?=
 =?utf-8?B?SXVBVFFHb04xUjV1a0J4dDR5UC84MlNuSi9QaHhac1Z6K2V1amFCT01zbVVJ?=
 =?utf-8?B?QlJQKzEvVWMvRnN1eXJRRFN0dmNsdG1nYmJsRHFGUUFGMndURmVscUo3RHMr?=
 =?utf-8?B?VGpQL2E2YnBRd28yUW1ZZTViVzczQzZOVnVlblI1MGVwVkNkbkNmY3VFek9h?=
 =?utf-8?Q?PlaDyyHTI4sviEhI0KHRpsVqc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4001b9f4-9240-40ea-2673-08db05c5f310
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 09:06:35.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1AnQ447J5b32yv8qkN5WzUS0LhmHw14wQHLC6hCFKsJRJ9jUjET195t3VwiPW68LaEx2P9OcgKLX8tRR8Q1Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/24/2023 8:15 PM, Jonathan Cameron wrote:
> On Mon, 23 Jan 2023 11:16:00 +0100
> Lukas Wunner <lukas@wunner.de> wrote:
> 
>> DOE mailbox creation is currently only possible through a devres-managed
>> API.  The lifetime of mailboxes thus ends with driver unbinding.
>>
>> An upcoming commit will create DOE mailboxes upon device enumeration by
>> the PCI core.  Their lifetime shall not be limited by a driver.
>>
>> Therefore rework pcim_doe_create_mb() into the non-devres-managed
>> pci_doe_create_mb().  Add pci_doe_destroy_mb() for mailbox destruction
>> on device removal.
>>
>> Provide a devres-managed wrapper under the existing pcim_doe_create_mb()
>> name.
>>
>> Tested-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Hi Lukas,
> 
> A few comments inline.
> 
> In particular I'd like to understand why flushing in the tear down
> can't always be done as that makes the code more complex.
> 
> Might become clear in later patches though as I've not read ahead yet!
> 
> Jonathan
> 
>> ---
>>  drivers/pci/doe.c | 103 +++++++++++++++++++++++++++++++---------------
>>  1 file changed, 70 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
>> index 066400531d09..cc1fdd75ad2a 100644
>> --- a/drivers/pci/doe.c
>> +++ b/drivers/pci/doe.c
>> @@ -37,7 +37,7 @@
>>   *
>>   * This state is used to manage a single DOE mailbox capability.  All fields
>>   * should be considered opaque to the consumers and the structure passed into
>> - * the helpers below after being created by devm_pci_doe_create()
>> + * the helpers below after being created by pci_doe_create_mb().
>>   *
>>   * @pdev: PCI device this mailbox belongs to
>>   * @cap_offset: Capability offset
>> @@ -412,20 +412,6 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
>>  	return 0;
>>  }
>>  

......

>> +/**
>> + * pci_doe_destroy_mb() - Destroy a DOE mailbox object
>> + *
>> + * @ptr: Pointer to DOE mailbox
>> + *
>> + * Destroy all internal data structures created for the DOE mailbox.
> >> + */
>> +static void pci_doe_destroy_mb(void *ptr)

Sorry, didn't find the original patch, reply on here.
I don't get why uses "void *ptr" as the parameter of this function, maybe I miss something. I guess we can use "struct pci_doe_mb *doe_mb" as the parameter.

Thanks
Ming


>> +{
>> +	struct pci_doe_mb *doe_mb = ptr;
>> +
>> +	xa_destroy(&doe_mb->prots); 
>> +	destroy_workqueue(doe_mb->work_queue);
>> +	kfree(doe_mb);
>> +}
>> +
>> +/**
>> + * pcim_doe_create_mb() - Create a DOE mailbox object
>> + *
>> + * @pdev: PCI device to create the DOE mailbox for
>> + * @cap_offset: Offset of the DOE mailbox
>> + *
>> + * Create a single mailbox object to manage the mailbox protocol at the
>> + * cap_offset specified.  The mailbox will automatically be destroyed on
>> + * driver unbinding from @pdev.
>> + *
>> + * RETURNS: created mailbox object on success
>> + *	    ERR_PTR(-errno) on failure
>> + */
>> +struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
>> +{
>> +	struct pci_doe_mb *doe_mb;
>> +	int rc;
>> +
>> +	doe_mb = pci_doe_create_mb(pdev, cap_offset);
>> +	if (IS_ERR(doe_mb))
>> +		return doe_mb;
>> +
>> +	rc = devm_add_action(&pdev->dev, pci_doe_destroy_mb, doe_mb);
>> +	if (rc) {
>> +		pci_doe_flush_mb(doe_mb);
>> +		pci_doe_destroy_mb(doe_mb);
>>  		return ERR_PTR(rc);
>>  	}
>>  
>> +	rc = devm_add_action_or_reset(&pdev->dev, pci_doe_flush_mb, doe_mb);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>>  	return doe_mb;
>>  }
>>  EXPORT_SYMBOL_GPL(pcim_doe_create_mb);
> 

