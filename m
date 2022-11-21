Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0884F631882
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 03:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKUCIO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 21:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKUCIN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 21:08:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC12713F8C;
        Sun, 20 Nov 2022 18:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668996491; x=1700532491;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UgoKAvaVej1lY+F8COOB+/X4vAU5Scyn+S4L8fP+HfE=;
  b=HF37lVyfw4aBtFw9cJW4awFDXYJO5QQCQ67FZbCaYK+6KVHfDbqoxP4w
   aDNxJNJQoqCyVtyRj8PJu23FGvWIfpZaqBLCbIEnkJ0n3NuR1mE7dXlDS
   zblPGIrbQfMEZmyE4egBXH5irVGYJmOc0dC/w/mfZoxK6B7EodSNvYiPJ
   dVaFnQ4UqXuUCw3PCtq+/a0QCN7R0fstkuXfvQxCauQp9j01V6E+6y1h7
   6Ay32N/xyL0rlotnuyhYtcAYubkilqbNo47rLnRG09KYO796/sTZkdS57
   dg2n+lioFFiHU5LWVmrf+X+f2+lmQgmSR2OSpoHFUkoRWEFP+eX/bNh+Z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="399742972"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="399742972"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 18:08:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="969899863"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="969899863"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2022 18:08:11 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 18:08:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 18:08:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 20 Nov 2022 18:08:10 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 20 Nov 2022 18:08:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrzSlbqVIMecHP2S0lJ4HqxidYpcwvLVxxaruSJHZI3aNW34agMxn+x0RYr+zSwcilM6q28K71E5dub5OfFf84Efimv+ReqfX636P8shFppUyKkZPATX96GXQTaGaxHNBHdrvLpBEiNOlyP6xyihbw7lOUP57rtJddcEfYJcRZ8NOD99FE5elNf9Qw/pHhjI/OeHOHA+RYvxTbyxBUHhDvqDXraVfwJTV9xljxIzNvNFAOh99UNYZY80p1jKozK1iCLt2LCMGcPd/2T4fzgSh/cCSf2SHVRMOxYOWrHPZm/aX+uJlqXBs9nPmyZ0qU71OIywqrLphjfoT/2q9bB6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6m65k8QGai2uCZdYmjo2/b55PflWcrdKsOz2sNIRxg=;
 b=K7Rx5CBIW05WxRb8zefQCtfTd/56GdfzMzXBmIk2cCAgWwrGJ3fq6zkozRH9ywaT8Y87p7stKv0+CjhW8u00GPuRCEth5orT1I92C4gUE3uo7Yev51rcc3EJLgmHQSPw6KNR7bncQVMJ9moSbCE1q8otDpNjQdX398efJgb+fa13ZWoPq4kQDyk3LR6aB62vujM0cFj4+TArSI2uCz7vdT36sMZuW7LVyPVIP6360uawVer2NIJ/GFYkj7xEAvXA2D9u6V1cgGIDwVV5gkLRfHpY7dflKuGeCxyio3frsuD2+g+WvdN5pEUCmvc1OdBsufgddmFlpn9sV1xlnFDWTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by MW4PR11MB6888.namprd11.prod.outlook.com (2603:10b6:303:22d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 02:08:08 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::7ac:fe96:566:65e]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::7ac:fe96:566:65e%3]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 02:08:08 +0000
Message-ID: <e7db6aea-4146-33f2-9490-9b5b902e0ec1@intel.com>
Date:   Mon, 21 Nov 2022 10:07:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] PCI/DOE: Remove asynchronous task support
Content-Language: en-US
From:   "Li, Ming" <ming4.li@intel.com>
To:     <ira.weiny@intel.com>
CC:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
 <750c2096-fe2f-0597-a635-78cbe6b0ee0d@intel.com>
Organization: Intel
In-Reply-To: <750c2096-fe2f-0597-a635-78cbe6b0ee0d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|MW4PR11MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 5948d5a0-28b7-4c83-7396-08dacb653b56
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUSz0Go5n/K7bCBtlF4Z6NT0eRJapB1ALbOMbopueUX/cbo5d88LJE2c5EIUnJ8NC1P354e7Jt6sm3YU149at5UJcYGKiFFtRqiShA1P1vpcNX3BLgQ+2A8lc1GhSML14BWpkc85ViLmwHAmYlskY6/Gg7K/IzmlhcgLxRwDJSM8axg/HH2d0l3z7Ze/s3N6DoCZd/iYl5XcyQIaa0lC8EwClgDytDwFOp1FVQpatiA9MQdW8XaKgg/pZQdPaqRaYC8+ULe2eay667zWrtKmNVcSbGtvbCi1hdVbQqUzOGnq+JOPlwhtnXyC28+um+SvOtJM4bh4gMkUIsvpPOvsFh+/yNOahpnqpIHTKSGsjYdTc52ORU9U6F9w5UBkFVfq/AD7Mau2NiYLzk7vPzqQz/lK2cqH6ZJx7xEJVcil6KKZHcoannBkQwwkjeXTNuXl5vqoMutAK/IqLxTVw0oZFySbpvrTflDEZk5qhFmM/v3yV5XIc0q4h7B1AycFvY4UBVEPja0OdjgjhMGOwvdV5Ov0j9okPzzZnQERJx1Oq0UkzbTvuwlVNCVZKK7A+14MeMTS+/frntcfndulVfRy82QgedbwGca/dLr/8l5ptMtOb51o6ZnEJzOSM/C/xTNXEdF/YZAU9Y8NFFXxPfMufYMNFy5pWk+FVRrkIXgl+27K+YiWzDfJBU8DjoZIg8TNymDJYsuQPS5k3eOdYzRjCDGKaZhIVI03cFEKic1LZqbDijBEQ38jbmo5OxKvA4tmpfrgssPQcdo6DjDniz96ZYFU8IYCztJ0wIs7dG7/c6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(31686004)(86362001)(31696002)(8936002)(4326008)(2906002)(82960400001)(83380400001)(38100700002)(37006003)(316002)(6636002)(54906003)(186003)(2616005)(66476007)(8676002)(36756003)(6486002)(478600001)(36916002)(966005)(5660300002)(34206002)(66556008)(66946007)(30864003)(41300700001)(6666004)(6506007)(26005)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzFDdVN3RDM4MFdZSzJnejFLOXV4V09mcGJTcGVMbUI4RFo5TUtuUi9GT0l6?=
 =?utf-8?B?TkZYZVp3WXhSd29aVGszUEg5dTJwTExlb0JGUW14b1hNaHJUVGFWQUlxQ3JD?=
 =?utf-8?B?aFVsV2lCYmdqRWx3MWYxRWY0U01WL1hvVWh3TnNWTG5udWl4RmVXUzRGbkZy?=
 =?utf-8?B?azJ3QndvdnM0RGRRdTlMMXhOUlRQdGk2Z2NUckJPVUl0UTh5UGE4VmVDUFcy?=
 =?utf-8?B?RXgwQnlXa3RCNWV4cWhUdjNLWjNUS3RGbFd2NlkyZXJXRlRxRXJoSGd6UG5p?=
 =?utf-8?B?OEJjUXhEZTlzZ213QXBxRGVnM1VpQzFrOEZiU2RUbitnZFlCQy90TkpBMjJE?=
 =?utf-8?B?MUx4eit3R2I3a2FqelVjQk1hZTVGMnNWQzloTGhmejdGSnVlVnI2RVQ0d2ZY?=
 =?utf-8?B?bUtxeEVVMTgzV0dwSzdwZ005T0IxWFJOYjlDZlVLc2xLWm5ySngrT1lrNGd5?=
 =?utf-8?B?ek41N294Y2wvNjRLMnV0TWp2eGVNYjVKV0c5aW4zZDRNandQeVRBTUd6UDVI?=
 =?utf-8?B?dVRrbVRBV2U4R1BrSTI0cEYyeURTUzlHcVJ0S1ZEOG5nY0pId1FndWlPRWJt?=
 =?utf-8?B?WVJYK2xKSHZVSWI0OFE5OVh0bFBuM3E4bDExdmRPZlFEb3NkajVPWDRnNFBr?=
 =?utf-8?B?b1R6SW5YcTIrQVRzc1pJS0dEelBxamVkMkVKZEluYXpIcm5zVkJNNjhYY1hB?=
 =?utf-8?B?bzRVS3ArZmx1RmpmT3pJbUl1aDJhdmpkb1JzOVB3QkYxc1JVcjQ0b2V4K2xY?=
 =?utf-8?B?emRWMWZtMHBLbVhlblp6SFZnRXFBSEZJUHFBUVJwa1liS1FpQ2IrRnlGNWUr?=
 =?utf-8?B?TmRoS2FPVDBzMFFlcDk0Nk9rc2VOZk9HVEgvd0xMWU1Ib2NmeHEvdVhLdG1k?=
 =?utf-8?B?SkJxeUZQMGVvYVowcFl4VWV6WWIyd1dXcXlUdE9ZS0xZU01XRlE0R1BmZVB2?=
 =?utf-8?B?RGNQdi9tNTY4NS82aEkzUUt4ZWorVTBPN21QTFkzQkxTSXpWdktNbTJ6SXFY?=
 =?utf-8?B?NGtSUXJFZmR6MVhwY1I5cTNiZDh1eEtaN1VZTCtFNm5XM1AvYTVXZTdSUE4x?=
 =?utf-8?B?NUZwNG94c0NiM0RMRm5ROWc1MFY0dVI2bUtzUTIzc0VGeFhyYk5NT29BaTc0?=
 =?utf-8?B?bmoycGlxTENWazVHRjNBTG1FUG4wNTNnRlNoZStvSnlSYVMzVEVPQjhBdGV3?=
 =?utf-8?B?emVrU2ZjYUdkMWl4dm9FeFVKOVlhYWNkcHpVWXFEeUZvS3FjUGV6Ync2bDJk?=
 =?utf-8?B?alRqTHNwWlhlMWVtazBjMWZFVjdVWk05ZGpJekk2WUNuT20yb205N2Y1S1Ux?=
 =?utf-8?B?dDk1d1U1eFNqUlFpTEtScFJoRTJFZk5LWVRpak43Sy9BNjYrMWk2QWhyWm1E?=
 =?utf-8?B?alk5TG9sTlFZUU1pdTJQTVJaWUFETmJNZU5KZjF2d3IrWURMK3YreUNVSGhh?=
 =?utf-8?B?Nk4rV3c0YXBWVDZxZEZkS1NzL0F0a3lZbDBLRThBUFJCMHI5S3NvUWdZME9s?=
 =?utf-8?B?clFjUTB5OStWQVFJclY2NjJ2dUJEdjRYWWhMRi8zMjQyeXEzV3NkbzZjNUp4?=
 =?utf-8?B?UjZVcGlsS1d1WUlqWDNLTld3ZEc4WVVFZW1nQ20rNnR4Rzg4eGI5eFh5ZTNx?=
 =?utf-8?B?TGVGTEhNendNVXQ5dEpoNnZLUzkzTVpMSkEzVUk1aHl3WFV2SzI1U0M4WmdS?=
 =?utf-8?B?bmt0VTJTWE1laExOYUhQYXQvYkpRYlRtR01LN1FBcFZmVUNyd2t1UjdtbUVu?=
 =?utf-8?B?b0ZCaFdMVkR0M0czSElBT0FlSTJxZnZ1VzI1UURWVjhnR3ZXNlN5S2RwZ1V0?=
 =?utf-8?B?MDBwb2dId2Y2K3pUOGNneUZLdGp3MXErUzlUeXlpaXp0bXpobTN2SE1USEs2?=
 =?utf-8?B?ZkhYVjYyZTlnd1UzY0xuSDYrSjJkZ2hGd2MrM2FBV09xemF4SE8vZEJKL3VF?=
 =?utf-8?B?R0VwZHY3TVUzTGhwTDRnbG9JSDg1aytHazQ4MDBuaTFSQkJDMEZTckd0NGUx?=
 =?utf-8?B?WS8rblVRV3hWM3dtVXMyZEVFejI0ZlJWWUlTYWFUVGswOGJnNDR0NEU2YzQ5?=
 =?utf-8?B?VXN6VGJHMkNQRDRRMlRlbDlja2tPcVdVQncwcElwb08rMmVQVWJVQ0IyNU1N?=
 =?utf-8?Q?Sw06Vsbmr62WhdFTth45asuB0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5948d5a0-28b7-4c83-7396-08dacb653b56
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 02:08:07.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d99C1pAtnq/ojmXpB89O5ccFpPgiWM8WsxPQ1uMyKoHWVictSCtbMPvxpAkwRpEUypVmwu64A4wFT52RU+lybw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6888
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/21/2022 9:39 AM, Li, Ming wrote:
> On 11/20/2022 6:25 AM, ira.weiny@intel.com wrote:
>> From: Ira Weiny <ira.weiny@intel.com>
>>
>> Gregory Price and Jonathan Cameron reported a bug within
>> pci_doe_submit_task().[1]  The issue was that work item initialization
>> needs to be done with either INIT_WORK_ONSTACK() or INIT_WORK()
>> depending on how the work item is allocated.
>>
>> Initially, it was anticipated that DOE tasks were going to need to be
>> submitted asynchronously and the code was designed thusly.  Many
>> alternatives were discussed to fix the work initialization issue.[2]
>>
>> However, all current users submit tasks synchronously and this has
>> therefore become an unneeded maintenance burden.  Remove the extra
>> maintenance burden by replacing asynchronous task submission with
>> a synchronous wait function.[3]
>>
>> [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
>> [2] https://lore.kernel.org/linux-cxl/Y3kSDQDur+IUDs2O@iweiny-mobl/T/#m0f057773d9c75432fcfcc54a2604483fe82abe92
>> [3] https://lore.kernel.org/linux-cxl/Y3kSDQDur+IUDs2O@iweiny-mobl/T/#m32d3f9b208ef7486bc148d94a326b26b2d3e69ff
>>
>> Reported-by: Gregory Price <gregory.price@memverge.com>
>> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Suggested-by: "Li, Ming" <ming4.li@intel.com>
>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>>
>> ---
>> Thanks to Dan for the bulk of the patch.
>> Thanks to Ming for pointing out the need for a lock to prevent more
>> than 1 task from being processed at a time.
>> ---
>>  drivers/cxl/core/pci.c  | 16 ++------
>>  drivers/pci/doe.c       | 83 ++++++++++++++---------------------------
>>  include/linux/pci-doe.h | 10 +----
>>  3 files changed, 32 insertions(+), 77 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 9240df53ed87..58977e0712b6 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -490,21 +490,14 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
>>  		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
>>  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
>>  
>> -static void cxl_doe_task_complete(struct pci_doe_task *task)
>> -{
>> -	complete(task->private);
>> -}
>> -
>>  struct cdat_doe_task {
>>  	u32 request_pl;
>>  	u32 response_pl[32];
>> -	struct completion c;
>>  	struct pci_doe_task task;
>>  };
>>  
>>  #define DECLARE_CDAT_DOE_TASK(req, cdt)                       \
>>  struct cdat_doe_task cdt = {                                  \
>> -	.c = COMPLETION_INITIALIZER_ONSTACK(cdt.c),           \
>>  	.request_pl = req,				      \
>>  	.task = {                                             \
>>  		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,        \
>> @@ -513,8 +506,6 @@ struct cdat_doe_task cdt = {                                  \
>>  		.request_pl_sz = sizeof(cdt.request_pl),      \
>>  		.response_pl = cdt.response_pl,               \
>>  		.response_pl_sz = sizeof(cdt.response_pl),    \
>> -		.complete = cxl_doe_task_complete,            \
>> -		.private = &cdt.c,                            \
>>  	}                                                     \
>>  }
>>  
>> @@ -525,12 +516,12 @@ static int cxl_cdat_get_length(struct device *dev,
>>  	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
>>  	int rc;
>>  
>> -	rc = pci_doe_submit_task(cdat_doe, &t.task);
>> +	rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
>>  	if (rc < 0) {
>>  		dev_err(dev, "DOE submit failed: %d", rc);
>>  		return rc;
>>  	}
>> -	wait_for_completion(&t.c);
>> +
>>  	if (t.task.rv < sizeof(u32))
>>  		return -EIO;
>>  
>> @@ -554,12 +545,11 @@ static int cxl_cdat_read_table(struct device *dev,
>>  		u32 *entry;
>>  		int rc;
>>  
>> -		rc = pci_doe_submit_task(cdat_doe, &t.task);
>> +		rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
>>  		if (rc < 0) {
>>  			dev_err(dev, "DOE submit failed: %d", rc);
>>  			return rc;
>>  		}
>> -		wait_for_completion(&t.c);
>>  		/* 1 DW header + 1 DW data min */
>>  		if (t.task.rv < (2 * sizeof(u32)))
>>  			return -EIO;
>> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
>> index e402f05068a5..41a75112b39b 100644
>> --- a/drivers/pci/doe.c
>> +++ b/drivers/pci/doe.c
>> @@ -18,7 +18,6 @@
>>  #include <linux/mutex.h>
>>  #include <linux/pci.h>
>>  #include <linux/pci-doe.h>
>> -#include <linux/workqueue.h>
>>  
>>  #define PCI_DOE_PROTOCOL_DISCOVERY 0
>>  
>> @@ -40,7 +39,7 @@
>>   * @cap_offset: Capability offset
>>   * @prots: Array of protocols supported (encoded as long values)
>>   * @wq: Wait queue for work item
>> - * @work_queue: Queue of pci_doe_work items
>> + * @exec_lock: Lock to ensure 1 task is processed at a time
>>   * @flags: Bit array of PCI_DOE_FLAG_* flags
>>   */
>>  struct pci_doe_mb {
>> @@ -49,7 +48,7 @@ struct pci_doe_mb {
>>  	struct xarray prots;
>>  
>>  	wait_queue_head_t wq;
>> -	struct workqueue_struct *work_queue;
>> +	struct mutex exec_lock;
>>  	unsigned long flags;
>>  };
>>  
>> @@ -211,7 +210,6 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>>  static void signal_task_complete(struct pci_doe_task *task, int rv)
>>  {
>>  	task->rv = rv;
>> -	task->complete(task);
>>  }
>>  
>>  static void signal_task_abort(struct pci_doe_task *task, int rv)
>> @@ -231,10 +229,8 @@ static void signal_task_abort(struct pci_doe_task *task, int rv)
>>  	signal_task_complete(task, rv);
>>  }
>>  
>> -static void doe_statemachine_work(struct work_struct *work)
>> +static void exec_task(struct pci_doe_task *task)
>>  {
>> -	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
>> -						 work);
>>  	struct pci_doe_mb *doe_mb = task->doe_mb;
>>  	struct pci_dev *pdev = doe_mb->pdev;
>>  	int offset = doe_mb->cap_offset;
>> @@ -295,18 +291,12 @@ static void doe_statemachine_work(struct work_struct *work)
>>  	signal_task_complete(task, rc);
>>  }
>>  
>> -static void pci_doe_task_complete(struct pci_doe_task *task)
>> -{
>> -	complete(task->private);
>> -}
>> -
>>  static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
>>  			     u8 *protocol)
>>  {
>>  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
>>  				    *index);
>>  	u32 response_pl;
>> -	DECLARE_COMPLETION_ONSTACK(c);
>>  	struct pci_doe_task task = {
>>  		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
>>  		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
>> @@ -314,17 +304,13 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
>>  		.request_pl_sz = sizeof(request_pl),
>>  		.response_pl = &response_pl,
>>  		.response_pl_sz = sizeof(response_pl),
>> -		.complete = pci_doe_task_complete,
>> -		.private = &c,
>>  	};
>>  	int rc;
>>  
>> -	rc = pci_doe_submit_task(doe_mb, &task);
>> +	rc = pci_doe_submit_task_wait(doe_mb, &task);
>>  	if (rc < 0)
>>  		return rc;
>>  
>> -	wait_for_completion(&c);
>> -
>>  	if (task.rv != sizeof(response_pl))
>>  		return -EIO;
>>  
>> @@ -376,13 +362,6 @@ static void pci_doe_xa_destroy(void *mb)
>>  	xa_destroy(&doe_mb->prots);
>>  }
>>  
>> -static void pci_doe_destroy_workqueue(void *mb)
>> -{
>> -	struct pci_doe_mb *doe_mb = mb;
>> -
>> -	destroy_workqueue(doe_mb->work_queue);
>> -}
>> -
>>  static void pci_doe_flush_mb(void *mb)
>>  {
>>  	struct pci_doe_mb *doe_mb = mb;
>> @@ -390,12 +369,9 @@ static void pci_doe_flush_mb(void *mb)
>>  	/* Stop all pending work items from starting */
>>  	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
>>  
>> -	/* Cancel an in progress work item, if necessary */
>> +	/* Cancel the in progress task and waiting tasks, if necessary */
>>  	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
>>  	wake_up(&doe_mb->wq);
> should use wake_up_all() to wake up all waiting tasks here?
> 
>> -
>> -	/* Flush all work items */
>> -	flush_workqueue(doe_mb->work_queue);
>>  }
>>  
>>  /**
>> @@ -423,25 +399,13 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
>>  	doe_mb->pdev = pdev;
>>  	doe_mb->cap_offset = cap_offset;
>>  	init_waitqueue_head(&doe_mb->wq);
>> +	mutex_init(&doe_mb->exec_lock);
>>  
>>  	xa_init(&doe_mb->prots);
>>  	rc = devm_add_action(dev, pci_doe_xa_destroy, doe_mb);
>>  	if (rc)
>>  		return ERR_PTR(rc);
>>  
>> -	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
>> -						dev_driver_string(&pdev->dev),
>> -						pci_name(pdev),
>> -						doe_mb->cap_offset);
>> -	if (!doe_mb->work_queue) {
>> -		pci_err(pdev, "[%x] failed to allocate work queue\n",
>> -			doe_mb->cap_offset);
>> -		return ERR_PTR(-ENOMEM);
>> -	}
>> -	rc = devm_add_action_or_reset(dev, pci_doe_destroy_workqueue, doe_mb);
>> -	if (rc)
>> -		return ERR_PTR(rc);
>> -
>>  	/* Reset the mailbox by issuing an abort */
>>  	rc = pci_doe_abort(doe_mb);
>>  	if (rc) {
>> @@ -496,23 +460,22 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
>>  EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
>>  
>>  /**
>> - * pci_doe_submit_task() - Submit a task to be processed by the state machine
>> + * pci_doe_submit_task_wait() - Submit and execute a task
>>   *
>>   * @doe_mb: DOE mailbox capability to submit to
>> - * @task: task to be queued
>> - *
>> - * Submit a DOE task (request/response) to the DOE mailbox to be processed.
>> - * Returns upon queueing the task object.  If the queue is full this function
>> - * will sleep until there is room in the queue.
>> + * @task: task to be run
>>   *
>> - * task->complete will be called when the state machine is done processing this
>> - * task.
>> + * Submit and run DOE task (request/response) to the DOE mailbox to be
>> + * processed.
>>   *
>>   * Excess data will be discarded.
>>   *
>> - * RETURNS: 0 when task has been successfully queued, -ERRNO on error
>> + * Context: non-interrupt
>> + *
>> + * RETURNS: 0 when task was executed, the @task->rv holds the status
>> + * result of the executed opertion, -ERRNO on failure to submit.
>>   */
>> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>> +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>>  {
>>  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
>>  		return -EINVAL;
>> @@ -529,8 +492,18 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>>  		return -EIO;
>>  
>>  	task->doe_mb = doe_mb;
>> -	INIT_WORK(&task->work, doe_statemachine_work);
>> -	queue_work(doe_mb->work_queue, &task->work);
>> +
>> +again:
>> +	if (!mutex_trylock(&doe_mb->exec_lock)) {
>> +		if (wait_event_timeout(task->doe_mb->wq,
>> +				test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
>> +				PCI_DOE_POLL_INTERVAL))
>> +			return -EIO;
> 
> We already implemented a pci_doe_wait(), I think we can use it to instead of this wait_event_timeout.
> 
> Thanks
> Ming
> 

This wait_event_timeout() only check PCI_DOE_FLAG_CANCEL, that means it only detects the signal which the doe_mb has being destroyed.
If current doe task is done correctly, I think we should wake up next task. Current implementation just waits utill timeout happens and try it again.
Besides, If two threads are waiting a same doe_mb, thread #1 waited firstly, thread #2 waited secondly, there is a chance that thread #2 is processed before thread #1.

Thanks
Ming

>> +		goto again;
>> +	}
>> +	exec_task(task);
>> +	mutex_unlock(&doe_mb->exec_lock);
>> +
>>  	return 0;
>>  }
>> -EXPORT_SYMBOL_GPL(pci_doe_submit_task);
>> +EXPORT_SYMBOL_GPL(pci_doe_submit_task_wait);
>> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
>> index ed9b4df792b8..c94122a66221 100644
>> --- a/include/linux/pci-doe.h
>> +++ b/include/linux/pci-doe.h
>> @@ -30,8 +30,6 @@ struct pci_doe_mb;
>>   * @response_pl_sz: Size of the response payload (bytes)
>>   * @rv: Return value.  Length of received response or error (bytes)
>>   * @complete: Called when task is complete
>> - * @private: Private data for the consumer
>> - * @work: Used internally by the mailbox
>>   * @doe_mb: Used internally by the mailbox
>>   *
>>   * The payload sizes and rv are specified in bytes with the following
>> @@ -50,11 +48,6 @@ struct pci_doe_task {
>>  	u32 *response_pl;
>>  	size_t response_pl_sz;
>>  	int rv;
>> -	void (*complete)(struct pci_doe_task *task);
>> -	void *private;
>> -
>> -	/* No need for the user to initialize these fields */
>> -	struct work_struct work;
>>  	struct pci_doe_mb *doe_mb;
>>  };
>>  
>> @@ -72,6 +65,5 @@ struct pci_doe_task {
>>  
>>  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
>>  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
>> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
>> -
>> +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
>>  #endif
>>
>> base-commit: b6e7fdfd6f6a8bf88fcdb4a45da52c42ba238c25
