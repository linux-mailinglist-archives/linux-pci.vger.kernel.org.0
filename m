Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21C3689324
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 10:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBCJJU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 04:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjBCJJT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 04:09:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E8912842;
        Fri,  3 Feb 2023 01:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675415357; x=1706951357;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gUdRiwdOuHrLXfQRchKxC+drlhDcx4ctBZbkouc2J+8=;
  b=BuX0L4eEtmqD36YVB1uKJEzDNC+Yt+xu+eyrL7f4aIEQGX1cz0r6JtRQ
   PgfzcJGjQqKXbWmfRHiGWVf47c17RK1U2pFnahlo2J9hMdeOcAfV1a11K
   bLkqZYdZaPRBrwoViYgPv84nyVhieb2MGuBNiP4n7sG/TBGO+k4C22LHc
   vaAyl0XybGIH6KI1lVHujGGOzAkYVu/STa+1y7xdv8Dr8zPL72Hcu7bbb
   +9ciiTxqDXxSLLMXHftlE+ko0BpU/nU0872JBqou01pf46XEU4ZpQw+Uk
   zyZWL8TbPtliwYdLii84oyQM4xKO3+5m1+K9MsgDa5OdC1vPyXIUa6LIg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="393291110"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="393291110"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 01:09:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="667590111"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="667590111"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 03 Feb 2023 01:09:16 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 01:09:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 01:09:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 01:09:16 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 01:09:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnZ8mzGjloBXmWPul6x6lXayKzSDMrHEoSwOsSGmLIzXMLcrL+TfSRQpEtgvE6cWdmZa4Zkuph9f3I9sZCJDw/yL9ddLLQJjKgJBik06w0KkXMt8XasKzZSOSAhwcCOqgxgXaMRmkIhJHpgBfm2pPISp6kAmjnAsxta2H5t+2Xid/KasZlXNfLOzDl/DiVnqf0l+srkd7BGBRudMi92WdtLgxynMk1P4VK7hZVRcmsVSOThAPcOgAfHeEucuqd3rIbeuICWBco2AeB2LJUVkQ0oRhx9fXQG2R13vruYLErCyZsyAzt5KkQMfpGixWJl8r0JPPiObB8ll7aFC3gDBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyfOUr050rbPiNSZGbRKG+PmZfkpa5xm5/zHrfw4Gag=;
 b=CSdIBDDyu0zpzhXY48vzNP89jb0s28Ljp+TOyNQXMLdnQfUtvUF9bNqCvvcrUhwb5h71ye+BpRXIWLBYbpdd/unm5KKaJ3tTTRXkwB3/1wOxhs2ijtBXIorW+RqOA9BlytfYZnc7M4kk24P8ZbukVvzRiwZ+6VnZjMbR8v64vlV1tNbhXc2WBL+Cfzw6bj9viSjO1HlYxwxTagVyH+WK08CUHU6eVzKKII14/qgh0x8gVnfKspen1yv7+uskPLrzoSLAclXcXE6OOE1k6CgIHb5OtzkepPSfxc3xywNmg1f7jMd2i/oxFxSzE4kqpUOlfs+9ShozHPu3BEsuSfloqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by SA2PR11MB4971.namprd11.prod.outlook.com (2603:10b6:806:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 09:09:14 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee%4]) with mapi id 15.20.6064.024; Fri, 3 Feb 2023
 09:09:14 +0000
Message-ID: <eeabe95c-2a9e-38c2-00ee-cdff1cf9ca9b@intel.com>
Date:   Fri, 3 Feb 2023 17:09:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 06/10] PCI/DOE: Allow mailbox creation without devres
 management
Content-Language: en-US
From:   "Li, Ming" <ming4.li@intel.com>
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
 <d6d3a6c8-7b82-77c2-3407-705916c020b7@intel.com>
Organization: Intel
In-Reply-To: <d6d3a6c8-7b82-77c2-3407-705916c020b7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0094.apcprd03.prod.outlook.com
 (2603:1096:4:7c::22) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|SA2PR11MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a96bbf-52ea-4902-53dd-08db05c651c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppx0Cwot940aNCwCRWfGNUpZ7FEkmWdvCZATfY8HjxsTGWHEGfMG//vHyqlplHdRVfLQS8GVgRUSQ1ggunD0vTalmANfiJ8S9RPQapcAc6P3hg82ludeyzeC9M1IvU3f3EAdvR9/SMN6szBjnSnoXLaAY6f6wPJJLtJKFh1GEUL0/28MyGU9dR7B/Nu+p38GUPB4ujwWPy0kCZhFVlBWj2CZrSDYtiOmDgqIM+s51Fs2oGKrwtkxgYFd+CPGZ6SMUfUz4U5NO4hlz2U7bqhtNb37ltyLTuPeDNdVmXc9VQS9aamyMhJQ3Y7yVBp58w2w4Roo0X0SsKc1OoIOtvGroNbCfM+oLeBfhC7WjLFPSdjEznLzJL29R4EsqTK1QTLUXNmDWeTIPnw2HY69r3mqDuSJg9vIWQ99Jyey6B7a6F91ZCquf3/ASLdGkg3P/24sQFwrMslokpADvZlpmERNoo0JV5Ly3o6paN94IhcZCFBNGO56UOHDUNEqMUkT0ctuyQHl07vr7Yhj5jlbIHjbB3vyBJsOr6uGEPJzMlfgIAjpOGLVnK5ps+jDFGSWhXpD9me/le7AWjlu4PQD+S8XV7m+n9zEsPPu+mRR5miyAqjHGvHG7D5j9u2mX6iwBPgni6W/gLM1t/1MTqiGKktBnj/4NlOKcH2LjB+YG7JrH7LJlatByA6ds9yUk6QVABRBzbPeLFDvGMIiC1rQ6WM7muBWM59Waa4CM3gqdqRK3+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199018)(86362001)(31696002)(82960400001)(36756003)(38100700002)(41300700001)(8936002)(5660300002)(66556008)(66476007)(316002)(110136005)(4326008)(66946007)(54906003)(8676002)(15650500001)(2906002)(83380400001)(2616005)(6486002)(478600001)(36916002)(186003)(6512007)(26005)(6666004)(53546011)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEdaZ1NpMVB1UXRITUZJSWtMMHNHbENFaStsNkxHbklVV2tZbkRaRzFSOHl6?=
 =?utf-8?B?RjVsaTVONkZiTmI0UEVBNHdjVm01amRyUHdDd2t5cFIvYVJCT0JxektxK2Fa?=
 =?utf-8?B?VGxwbGpiYlhjTHBkSDZVQ2lYYWNNbURWajZRTHhENEkrTnBJVVVITEF1Yytj?=
 =?utf-8?B?QktBRjFPKzhGejZmSlpPMndZRjE2T3Vucmd5dWFhRWRLa0c4VjJBOU1jTlhw?=
 =?utf-8?B?SFRQOGtzdzJvOGdQTnFJaFdFVHk1TzV5TDM3aWZBUnBTVXpnT013d09CZCsv?=
 =?utf-8?B?cEsycm9GY1hpcXlSczRyTDNYRlBtbDVQSTdkd1FGQUZldUN4NnBCdUZ4Y0Rt?=
 =?utf-8?B?TURCNzZkUTlUTVJRODgvVnZEVUk3a3dmT0VGMzhUN25ENkdKYmZjcTFSWjV1?=
 =?utf-8?B?VEhrZjk2TFBSeFFNb1RLQWVkWE5MYzV4WkxxMndMRkI5ZWY0dXY3N1dvbW5M?=
 =?utf-8?B?aEpDMHdXQjRjV0h6UGxkWWtCdVFtenNUbllsbHE4Q0RZTE9hVlM4YzJrc21v?=
 =?utf-8?B?UUVpMmlVcjh4NDBFeEVEUEErVmhLNXBBR0tLZ3pTb2lpRlZ6Vi81YWVWR0VW?=
 =?utf-8?B?VXRZWjhWOXJXYWRVWTRoaWtUamJjTE1JbktFbGcxTEtLc3pIYkNzQXpZU0hm?=
 =?utf-8?B?YjZtb3BobzJHMnBTc3pKSmxWeGRXdTA1K1VBNnk4K0VMZ2ZjWDJocEJPRnJy?=
 =?utf-8?B?SnA2YVIvNFo2MUo2QkM0UURCOTRHVndRRjNoMnNqREV6OC90Q09Gd2tqNmFF?=
 =?utf-8?B?RDRYQUVEbU1iS1BSZjVLbFhOdUJGZktKbWMzd2k2dm1uYmVyYUhhRDFIcXVU?=
 =?utf-8?B?OUNtcnV4NVBCTEFDSXRRMzRJdUVuM1lSNUR2TVZXMGxyOXFrckRlbExxME9L?=
 =?utf-8?B?ODk5SE14eFpkckhESWFVM1hjVEpqR3BPS1hKOW5YdkdKRjBvdW9kL3lJemV3?=
 =?utf-8?B?aEEvRFlJaVo5YkZKRUw4ODlYZmFkQksyeStvdERrQzhEVnhjWmUzMnpob1Bi?=
 =?utf-8?B?M2QrcE1uNFpTMHpqV3dZLytqdk8yTzNoSldiNmpiQkQzaEhoTzY5MnZ0MzVC?=
 =?utf-8?B?NUdoc1V5L245SkY4YlhNVXVndVN0MnFxQ3dIbkd1L2V0WEMzTTVTMFlVZHVm?=
 =?utf-8?B?SkN0cHRRek1QOUg1YUU3VVY4Q052QjFMdWZhMUJ6QkR6NGZNMW55SU5uWExV?=
 =?utf-8?B?MGpvWXpINlBpaGhmdWs2NkFtaEgyUjRMVE0vcXRxanMzUis5MURpUWU3dEhF?=
 =?utf-8?B?QVNtOUtGMmsrUSt4Y2RDOENOWnU0cFFwb0FXTUc0aW1YWTFaWWlDeHhtUW4y?=
 =?utf-8?B?MmNhc3FNY2w3a3VtQTduN05OQnRERGNuNXU3SWY3YUZTSzFBSy9ZVmZhclJh?=
 =?utf-8?B?SE1xR2tEajNEemgxTjhSQXZDeWl0L2xSYnRpTXhIMUJ5ckY2aXl3bkRhVVdI?=
 =?utf-8?B?ZjJCUmtUZjRtUzRtY3pNcDNtVWhtbUd0TU15SE9PR2JKSGU5aUJKV29nVHV0?=
 =?utf-8?B?K1dnMXVWaVhxKzkrWTJZb2NtUmpuS3A5ZUVmeVRGMDNCT0FsazViVmtEZ2pW?=
 =?utf-8?B?UEFVYjJ3SWwvSi91SWdKd2lmd2FYVSt6TG83QmVLcm9ycGt3aVNISEwyK2gr?=
 =?utf-8?B?NlRGUnpDWVBnSnJvOVY3T2pkcklDYmZyTXc5Mlp2Y2NOM084OVRoWEpwYW9I?=
 =?utf-8?B?bGhiOU8vTU8rWWxrOHBkRit0YmFEYStvdHQ4U2NwQlMvZlIzWjlZL01FbHlU?=
 =?utf-8?B?dDZYdDZyRldnSmk0NHFFY21XK0k4MDA0NGVPbHRaOHVXKzZJNUs2czNjTkJv?=
 =?utf-8?B?NGhCMi9rTnUwYmZDTnQ0MXFWSGYyUFBHaTdNc0FqeU9INmNqTGR3TEdBYkZs?=
 =?utf-8?B?STVmdmZERUp4THAwS0FpZzUzQlZsVlFOMWR6Mlo3Tld6bTZVNUJjb29IMEZZ?=
 =?utf-8?B?dXpPRTFOWGJnWkVxczY1bmprbldENkV5ZHI2VDhBdkE3cHdNV2dTUC81WkJa?=
 =?utf-8?B?dGFiMUJibG5hd1ZERnpWT2IwWVkrcU9vTXNQN2g5ajFlRnFUS290RDBEamN0?=
 =?utf-8?B?eU5tdTVIbnh5YlhmV0Npb25pb0J1anZlRWJXcDgxNkdhS1FtM1AxWlgwRFhJ?=
 =?utf-8?Q?+gKgVWRRthBl8/5LyCxOzmbVG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a96bbf-52ea-4902-53dd-08db05c651c1
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 09:09:14.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifWQn87U2leMrGObs1nCkyBNQ1btBXTfUbuBqlZNwjeS5CIxIIQlm2Kt2wCzTuZcMH+GenScOZd6OZbf5iGBAQ==
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

On 2/3/2023 5:06 PM, Li, Ming wrote:
> On 1/24/2023 8:15 PM, Jonathan Cameron wrote:
>> On Mon, 23 Jan 2023 11:16:00 +0100
>> Lukas Wunner <lukas@wunner.de> wrote:
>>
>>> DOE mailbox creation is currently only possible through a devres-managed
>>> API.  The lifetime of mailboxes thus ends with driver unbinding.
>>>
>>> An upcoming commit will create DOE mailboxes upon device enumeration by
>>> the PCI core.  Their lifetime shall not be limited by a driver.
>>>
>>> Therefore rework pcim_doe_create_mb() into the non-devres-managed
>>> pci_doe_create_mb().  Add pci_doe_destroy_mb() for mailbox destruction
>>> on device removal.
>>>
>>> Provide a devres-managed wrapper under the existing pcim_doe_create_mb()
>>> name.
>>>
>>> Tested-by: Ira Weiny <ira.weiny@intel.com>
>>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>> Hi Lukas,
>>
>> A few comments inline.
>>
>> In particular I'd like to understand why flushing in the tear down
>> can't always be done as that makes the code more complex.
>>
>> Might become clear in later patches though as I've not read ahead yet!
>>
>> Jonathan
>>
>>> ---
>>>  drivers/pci/doe.c | 103 +++++++++++++++++++++++++++++++---------------
>>>  1 file changed, 70 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
>>> index 066400531d09..cc1fdd75ad2a 100644
>>> --- a/drivers/pci/doe.c
>>> +++ b/drivers/pci/doe.c
>>> @@ -37,7 +37,7 @@
>>>   *
>>>   * This state is used to manage a single DOE mailbox capability.  All fields
>>>   * should be considered opaque to the consumers and the structure passed into
>>> - * the helpers below after being created by devm_pci_doe_create()
>>> + * the helpers below after being created by pci_doe_create_mb().
>>>   *
>>>   * @pdev: PCI device this mailbox belongs to
>>>   * @cap_offset: Capability offset
>>> @@ -412,20 +412,6 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
>>>  	return 0;
>>>  }
>>>  
> 
> ......
> 
>>> +/**
>>> + * pci_doe_destroy_mb() - Destroy a DOE mailbox object
>>> + *
>>> + * @ptr: Pointer to DOE mailbox
>>> + *
>>> + * Destroy all internal data structures created for the DOE mailbox.
>>>> + */
>>> +static void pci_doe_destroy_mb(void *ptr)
> 
> Sorry, didn't find the original patch, reply on here.
> I don't get why uses "void *ptr" as the parameter of this function, maybe I miss something. I guess we can use "struct pci_doe_mb *doe_mb" as the parameter.
> 
> Thanks
> Ming
> 

Please ignore my comment, I saw it has been changed by PATCH #9

Thanks
Ming

> 
>>> +{
>>> +	struct pci_doe_mb *doe_mb = ptr;
>>> +
>>> +	xa_destroy(&doe_mb->prots); 
>>> +	destroy_workqueue(doe_mb->work_queue);
>>> +	kfree(doe_mb);
>>> +}
>>> +
>>> +/**
>>> + * pcim_doe_create_mb() - Create a DOE mailbox object
>>> + *
>>> + * @pdev: PCI device to create the DOE mailbox for
>>> + * @cap_offset: Offset of the DOE mailbox
>>> + *
>>> + * Create a single mailbox object to manage the mailbox protocol at the
>>> + * cap_offset specified.  The mailbox will automatically be destroyed on
>>> + * driver unbinding from @pdev.
>>> + *
>>> + * RETURNS: created mailbox object on success
>>> + *	    ERR_PTR(-errno) on failure
>>> + */
>>> +struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
>>> +{
>>> +	struct pci_doe_mb *doe_mb;
>>> +	int rc;
>>> +
>>> +	doe_mb = pci_doe_create_mb(pdev, cap_offset);
>>> +	if (IS_ERR(doe_mb))
>>> +		return doe_mb;
>>> +
>>> +	rc = devm_add_action(&pdev->dev, pci_doe_destroy_mb, doe_mb);
>>> +	if (rc) {
>>> +		pci_doe_flush_mb(doe_mb);
>>> +		pci_doe_destroy_mb(doe_mb);
>>>  		return ERR_PTR(rc);
>>>  	}
>>>  
>>> +	rc = devm_add_action_or_reset(&pdev->dev, pci_doe_flush_mb, doe_mb);
>>> +	if (rc)
>>> +		return ERR_PTR(rc);
>>> +
>>>  	return doe_mb;
>>>  }
>>>  EXPORT_SYMBOL_GPL(pcim_doe_create_mb);
>>
> 

