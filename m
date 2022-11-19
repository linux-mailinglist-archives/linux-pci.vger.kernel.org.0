Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D52630ACC
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 03:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiKSCkj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 21:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiKSCkX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 21:40:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B9AD9045;
        Fri, 18 Nov 2022 18:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668824732; x=1700360732;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qJD1ePm5XYia3z6Ye8QQ3LXwGhUeBDxe+z5aOT528vQ=;
  b=Gnauv8rIedALXpjcLbT7M+fLDAIXhrjFzFNEeNvZ4naEWyHwRUCXQUJM
   3jrf37lMIA3GHkh1H02MnSNNFIoFKJ1Ny0AcXkXMyZcT559mlD/exuQS7
   KVs5jjWF6RqRVXM69my3jpFrri4JLlfIAg0Ni68qpnSz9NAT94dY9To80
   YkLJMPsSTf4wXJtFQjCdfTj3xDrkJyd9CoQC4TbBJ2ou7ZqXg2gSAhPHE
   bX0078DJvxZQnTg8DeCQWTfHkZXQECE2Y32iucKRtp+Ur/Ue7cKwzbfDo
   HYAA3mu102Mr5AT4MpUt9y9IPCpg5w2gbAr7Ipeg5n+k6BMC0F6RBXRvf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="340127705"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="340127705"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 18:24:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="765372682"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="765372682"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 18 Nov 2022 18:24:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 18:24:38 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 18:24:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 18:24:37 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 18:24:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ax9VbF/VKQd+NwDxr/ia8yNLaqzYXt2IRHi0LUpWKnA8IRC6p1ewZyg5ARB1rRxlApaHjwh0jgy079skL7RuWEF622poNtdlVAZZ2nTqiguoZsjE3EaKX/ZaUCYMGhBX7+XI5YxOOZW3pef2XjaNls4y7DJwJYE40vT7JD3ZvXPkJLiBiuyqWX3OO6Opt2NfUTGdq6u6CDv8+zoS0gw+uuISG/9oxEfnL5ZKBAmAN86jlxDWyf2w/tztTOQWiIxzbUlXvDfDuL0hqcUqV+hjCRjiX0yi0A40o9yN4PUQlNjr7aAYhimtsZ/duehkT5oljpCNVVOQkJnP3olQs2LsGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlqepiLD/Kv1f6bC2JmaAElp6Lkb2nXFgBFZdOPz4cg=;
 b=UUlfEU/76bb9rlKZE5oE8c8Gadq/BhDiJJbPp7HMrTDJM/jXQZhuH7irb1db/kEziVJdHtuXzrD9lDf79lGMXrAB38YV/Lc8pDn1uoeSs/6tCDd/c/HWsvGgbI7pH3zQQB1ABCW0aFfGVYt715jXz9WEDoSCmgaF7XWW6aDcFuWF/LqL2ljOR4As2gMlIk3Eg2sSIkueoUnoPSbeb86fx8rQmzRigN4d+2lOCop0kGqorzMsV5wQ5O7Pt1bWZt9ORledyxwvzKj9KELwRCd4bqtyDx72QJ83k9azx9+Lacy4qRTyDNx3zKvDr6UbNnwD4i++NaiwqKbnbacjwCPySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by DM4PR11MB7182.namprd11.prod.outlook.com (2603:10b6:8:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 02:24:34 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::7ac:fe96:566:65e]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::7ac:fe96:566:65e%3]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 02:24:34 +0000
Message-ID: <7bb72f37-9da0-2406-cbc4-d9b0f879320a@intel.com>
Date:   Sat, 19 Nov 2022 10:24:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Laight <David.Laight@aculab.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20221118000524.1477383-1-ira.weiny@intel.com>
 <e59f83f3ca4149d098efe43b48fecd1b@AcuMS.aculab.com>
 <Y3fSRbpjeC1CTPA1@iweiny-desk3>
 <6377e0fa50f1d_12cdff29425@dwillia2-xfh.jf.intel.com.notmuch>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <6377e0fa50f1d_12cdff29425@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|DM4PR11MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6ce280-50c2-4998-38dc-08dac9d5329f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LHAAXXbJ2Q/XkodULox6rGIPyqiY9zfRLvVpbw2NBD4d963eSSkde4IBg/ldO88NprRzLfvdZk1TDWS2BdxcBlHNtcioqT8K+OvvzAJfmht11hjrRx0E6+qOPlIjPsRtAdy9RrYQJ20AtEiAwbuD6L4cw+9I3HaEvRWzTg9nOPiELf4eWFj7yW5+C0OC4gzMCNeouWULM5EzisKiJ9v7F10VCNJqia6Nq3qbrf+VeOfvG6xv/GJ9Li93QJmw0cGJYCZLHI3J9XL0AjbkIz6T3a0eNAbpHtUbekUQqLjDuoYyJXFDPb5GS5MrgtlcOhaEIAzt2z9MFRHBSELckZLuSoshNbGKy6XDED87A8bPH8cgb+LQ2Pw0jsfXoaXP0DSOTKdCpaeTGoxnUx2RnnD1eO3WOxLz3Mh8UjtddcSi6LKrqvCc0BM9+GMZHBpzOf3VDq7XxY7VDWmue68Q+o++IkmsgZIDJlb2GcX0elN6l8qP5eInEo5fJCHPZT4hx/xoZTCDfubZOPIBNS1OTslVvb+lczG7zCPJMB/JS4/tOvU2cjzaneOewOuawJJPJSSZAI15VQj+a4POo87klnMehXeoII8hxp9gDLwLFI698ewZnI0ZYQfV9LJBYy0jYrp27im8/3TvwXijq5TVk0b+2f/C1JU2dOYC0Ev7OnYKTsP4m/x8UyplZ9iKZivCrWWGiOQtKrCC56VnbtjMDUtMLh+fSKhNoaiEcuZg8wqRBk1rGeC8iIqmzkS5Dgcn3Du00duF1e32ykvyrpP/fD8JVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199015)(6506007)(478600001)(2906002)(316002)(6512007)(36916002)(186003)(54906003)(53546011)(26005)(31686004)(110136005)(66556008)(4326008)(2616005)(8676002)(6486002)(66946007)(66476007)(30864003)(966005)(41300700001)(5660300002)(8936002)(83380400001)(36756003)(31696002)(86362001)(6666004)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1BHTGUvOW93WU8zQ0dacHZxbllYcEk2RmxHUlRPYzBVQVZmMjk4UFVKV1Rt?=
 =?utf-8?B?eGVtVXFtdWVkUmVySUhGTlBRWXdSSXMrc2xoQjBZcTAvaEFuWWwwSE41cDcz?=
 =?utf-8?B?U1NyMGtmRmZoNjNLOEtkWTNMOVNBM0FiOUxLWW1zbzZMTVNLYUFtdTdBcXB3?=
 =?utf-8?B?b1YxRjlXbUcveU94TUNUOEt6T29PL2laRTY1MjI4UFgzM05od2RXdnpBZkZt?=
 =?utf-8?B?cWRIV1l0RXlxODlXOG9iTlZIaFVud1pSWGkvMzhIZkd1MVZGQXlPN1FSMWx1?=
 =?utf-8?B?S0RLOURGa0pGUHJNVmMxakVQM21BS3NDQU0rdWJvOEtMOFlvK0RLQWFrRlVE?=
 =?utf-8?B?blhyM08wYWdualdMeDBBS3daOEpuYXhJM2VRaXNMa2dGVTVVNDRJaDlmbXJS?=
 =?utf-8?B?NE0rTE5DcGE4dnRYSEdsYkxtTXFUaUNyQjZRNFJFdnJ3OXBlRCtNNzRJYlEy?=
 =?utf-8?B?Q3J0cmhZcWxHUkhvdFJkMVpWdXM3MldIdGluWWVqaHpCSXpieHRrS3cyN1FO?=
 =?utf-8?B?bzY1dTRrbmpVOWxJdklrRE9jZktSdmk3bzRPaFM3cm5teUdpTDU4TTBVeTZY?=
 =?utf-8?B?VDZxWkJ0MERQUmNpU2k5OStpQlM0OTdnK3BrOEUxVkx6MWZuUWtTQVNGUldD?=
 =?utf-8?B?RkwwWHhvRGNEeEVURVEyWkw3bis5endlOTlOUzFMUGE4VHNpdGdMa2huTEx3?=
 =?utf-8?B?dGc2a1E4U1VuR2s1NzFheWJrS0RIV0h1eVM5cVlhbzhSTGJoMSt5UFFpTDRJ?=
 =?utf-8?B?bE5jZnBERTdzVFFXT2tFeEF3dkYvVk1VUW56K24rYlpmcW5vTFRNeGM5dEVQ?=
 =?utf-8?B?ekI2NGRSRW13ZW1BV2p6aGtqUTVoTGZSNUsxV0RvY2VYNExneUZZdVRGUERj?=
 =?utf-8?B?YU1nTEpqbGRCemFpb0Y5YkNXVnhuckhHaWIvc1BVbnVmR2xidmw4ZGViKzhz?=
 =?utf-8?B?eWxFRVdWQnpSZWN3TGUxN3BoUUk0SzZFczZRVU1YRUlVSGpQQk5DRXFORW9P?=
 =?utf-8?B?N1ptSCs1WG5CaUdLS2RLUjZBT1FkOHBFdnZ2NmFYVmVjNnRkbmVkbXk5YXJl?=
 =?utf-8?B?THBhY0lHRzBjcWVJOXdmTzRYWFF4N3pyaGdzTDNHSmZTeEU2bmNpdnBOSHlN?=
 =?utf-8?B?OUNwUUZpaXhQWlptS0xyQTNreG9acGJXMUxnNCtFSmxhUDNvQVpuN0hyWDBT?=
 =?utf-8?B?ZVJJN0E0eEp6N0ZaaFBkNWZ5aXVnbjZGYTVuVy9FUnFvY1V5OU1GTEV4ckw4?=
 =?utf-8?B?aDRyb0F3STI2RkRNcFNPczA4QVpBN0l6cDV1b0c0NFBzNXZiczNFM3lsNmJo?=
 =?utf-8?B?YlhQdFhGWVRMd0Vpcjd3Tk5CWjB2WEYzbmJrTG5tRU1oNzI3YXlYUDFsK3ZI?=
 =?utf-8?B?UHdMM3Fza0VJa2VGRkgyWXQ5NDFJN3BrblNwZWZlakgrb21ka2phMG42anNv?=
 =?utf-8?B?YjBNK1BLUUlIVnp4Y28wRTZYUmgwd3VaeHFTUk9tdmxvelA3bDBmU3dTM2Yz?=
 =?utf-8?B?UjQwRGEvVVBlNXJpYWVodFFyMlhlcDRydGNRY2VoMDl0VEZIZmMxUWdNV1BB?=
 =?utf-8?B?cVBVMHpERktBREI2YnBFK3dUQXZLbmkyaTR0S0FIcUJSM2pHVmg2blVTczVI?=
 =?utf-8?B?MVEvcEFUODk2cm9sVlRvZHdDdjdzZkxYSFNiRTRlVldKdWkwRm02dUpxaW13?=
 =?utf-8?B?YVpDVjNPZzQ4OEFPYWZCdFhkT1JrTFBQUU5WOGVsNU5PYkwwMzdiMlJGMFVK?=
 =?utf-8?B?SGlRQUYrWDRNRzhLdWh3SmVLdkp0alkvVUVPYXQ3cUVhczNubXpwZzQyZjJN?=
 =?utf-8?B?bkdCakJWZU1QSDU3SjNRZmZnRnJZVzhnVWZhZGRzUjVoWEIvbHFSRHVyc0tO?=
 =?utf-8?B?a2FtSGRWMFhVanF5aHNhSWxHM1RCMTFvMkt1TnJSQTNOVzJvdzdIZXE3VTcr?=
 =?utf-8?B?VElDM2lxNTUzOTV1U09BM2FuSk9aUWR3Z0tkZkNnZDBBdkMvN2c2NVd5YXZH?=
 =?utf-8?B?SHJIUWNoanZrSTdNTHpTWWJiYklZTDJIa01aZ1FUajlYUTdhRlhTenhOak0y?=
 =?utf-8?B?VDlFbGJZd1UwNlozUnVpRWZxSnhlc09NV3VJczBPdmt4U2FxTVJtcDBobWpE?=
 =?utf-8?Q?hIwpdXfg+YYV/5y4QuJuJmo46?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6ce280-50c2-4998-38dc-08dac9d5329f
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 02:24:34.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtUPYBrWO+7tSb8QMq5+5OFggyBc+hdnYNfX1Kxj5aake8Zd/7HVrhZzvl18IG5q+LT+amIaAiXGsqxFAiP8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7182
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/19/2022 3:46 AM, Dan Williams wrote:
> Ira Weiny wrote:
>> On Fri, Nov 18, 2022 at 09:20:38AM +0000, David Laight wrote:
>>> From: ira.weiny@intel.com
>>>> Sent: 18 November 2022 00:05
>>>>
>>>> Work item initialization needs to be done with either
>>>> INIT_WORK_ONSTACK() or INIT_WORK() depending on how the work item is
>>>> allocated.
>>>>
>>>> The callers of pci_doe_submit_task() allocate struct pci_doe_task on the
>>>> stack and pci_doe_submit_task() incorrectly used INIT_WORK().
>>>>
>>>> Jonathan suggested creating doe task allocation macros such as
>>>> DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
>>>> function is not known to the callers and must be initialized correctly.
>>>>
>>>> A follow up suggestion was to have an internal 'pci_doe_work' item
>>>> allocated by pci_doe_submit_task().[2]  This requires an allocation which
>>>> could restrict the context where tasks are used.
>>>>
>>>> Another idea was to have an intermediate step to initialize the task
>>>> struct with a new call.[3]  This added a lot of complexity.
>>>>
>>>> Lukas pointed out that object_is_on_stack() is available to detect this
>>>> automatically.
>>>>
>>>> Use object_is_on_stack() to determine the correct init work function to
>>>> call.
>>>
>>> This is all a bit strange.
>>> The 'onstack' flag is needed for the diagnostic check:
>>> 	is_on_stack = object_is_on_stack(addr);
>>> 	if (is_on_stack == onstack)
>>> 		return;
>>> 	pr_warn(...);
>>> 	WARN_ON(1);
>>>
>>
>> :-(
>>
>>> So setting the flag to the location of the buffer just subverts the check.
>>> It that is sane there ought to be a proper way to do it.
>>
>> Ok this brings me back to my previous point and suggested patch.[*]  The
>> fundamental bug is that the work item is allocated in different code from
>> the code which uses it.  Separating the work item from the task.
>>
>> [*] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667
>>
>> Bjorn would this solution be acceptable and just use GFP_KERNEL and mark the
>> required context for pci_doe_submit_task()?
> 
> It is a waste to have an allocation when one is not needed. The value of
> having INIT_WORK_ONSTACK and DECLARE_COMPLETION_ONSTACK is to be clear
> at the call site that an async context cares about this stack frame not
> going out of scope.
> 
> However, coming full circle, we have zero async users today, and having
> the completion and work struct in the task are causing a maintenance
> burden. So let's just rip it out for now with something like the
> following and circle back to add async support later when it becomes
> necessary: (only compile tested)
> 
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0dbbe8d39b07..69873cdcc911 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -488,21 +488,14 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
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
> @@ -511,8 +504,6 @@ struct cdat_doe_task cdt = {                                  \
>  		.request_pl_sz = sizeof(cdt.request_pl),      \
>  		.response_pl = cdt.response_pl,               \
>  		.response_pl_sz = sizeof(cdt.response_pl),    \
> -		.complete = cxl_doe_task_complete,            \
> -		.private = &cdt.c,                            \
>  	}                                                     \
>  }
>  
> @@ -523,12 +514,12 @@ static int cxl_cdat_get_length(struct device *dev,
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
> @@ -552,12 +543,11 @@ static int cxl_cdat_read_table(struct device *dev,
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
> index e402f05068a5..115a8ff14afc 100644
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
> @@ -40,7 +39,6 @@
>   * @cap_offset: Capability offset
>   * @prots: Array of protocols supported (encoded as long values)
>   * @wq: Wait queue for work item
> - * @work_queue: Queue of pci_doe_work items
>   * @flags: Bit array of PCI_DOE_FLAG_* flags
>   */
>  struct pci_doe_mb {
> @@ -49,7 +47,6 @@ struct pci_doe_mb {
>  	struct xarray prots;
>  
>  	wait_queue_head_t wq;
> -	struct workqueue_struct *work_queue;
>  	unsigned long flags;
>  };
>  
> @@ -211,7 +208,6 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>  static void signal_task_complete(struct pci_doe_task *task, int rv)
>  {
>  	task->rv = rv;
> -	task->complete(task);
>  }
>  
>  static void signal_task_abort(struct pci_doe_task *task, int rv)
> @@ -231,10 +227,9 @@ static void signal_task_abort(struct pci_doe_task *task, int rv)
>  	signal_task_complete(task, rv);
>  }
>  
> -static void doe_statemachine_work(struct work_struct *work)
> +
> +static void exec_task(struct pci_doe_task *task)
>  {
> -	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> -						 work);
>  	struct pci_doe_mb *doe_mb = task->doe_mb;
>  	struct pci_dev *pdev = doe_mb->pdev;
>  	int offset = doe_mb->cap_offset;
> @@ -295,18 +290,12 @@ static void doe_statemachine_work(struct work_struct *work)
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
> @@ -314,17 +303,13 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
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
> @@ -376,13 +361,6 @@ static void pci_doe_xa_destroy(void *mb)
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
> @@ -393,9 +371,6 @@ static void pci_doe_flush_mb(void *mb)
>  	/* Cancel an in progress work item, if necessary */
>  	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
>  	wake_up(&doe_mb->wq);
> -
> -	/* Flush all work items */
> -	flush_workqueue(doe_mb->work_queue);
>  }
>  
>  /**
> @@ -429,19 +404,6 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
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
> @@ -496,23 +458,20 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
>  EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
>  
>  /**
> - * pci_doe_submit_task() - Submit a task to be processed by the state machine
> + * pci_doe_submit_task_wait() - Submit and execute a task
>   *
>   * @doe_mb: DOE mailbox capability to submit to
> - * @task: task to be queued
> + * @task: task to be run
>   *
> - * Submit a DOE task (request/response) to the DOE mailbox to be processed.
> - * Returns upon queueing the task object.  If the queue is full this function
> - * will sleep until there is room in the queue.
> - *
> - * task->complete will be called when the state machine is done processing this
> - * task.
> + * Submit and run DOE task (request/response) to the DOE mailbox to be
> + * processed.
>   *
>   * Excess data will be discarded.
>   *
> - * RETURNS: 0 when task has been successfully queued, -ERRNO on error
> + * RETURNS: 0 when task was executed, the @task->rv holds the status
> + * result of the executed opertion, -ERRNO on failure to submit.
>   */
> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  {
>  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
>  		return -EINVAL;
> @@ -529,8 +488,8 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  		return -EIO;
>  
>  	task->doe_mb = doe_mb;
> -	INIT_WORK(&task->work, doe_statemachine_work);
> -	queue_work(doe_mb->work_queue, &task->work);
> +	exec_task(task);
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
> 

good to see that we can have a sync interface.
I think that we still need some methods to garantee doe_task can be handled one by one in doe_mb?
When more than one kernel thread are going to transfer data over a same doe_mb, only one kernel thread can use it and others will failed in exec_task().

Thanks
Ming

>>> OTOH using an on-stack structure for INIT_WORK seems rather strange.
>>> Since the kernel thread must sleep waiting for the 'work' to complete
>>> why not just perform the required code there.
>>
>> It is not strange if some task submitters want to wait while others do not.  It
>> was suggested that all submit task operations be async and the callers who
>> wanted to be synchronous would wait like this.
>>
>> As Dan said there is a difference between submit_bio() and submit_bio_wait().
>>
>> We have simply left the wait part up to the users who all wait right now.
> 
> Yeah, my bad for jumping ahead to worry about async when it is not yet
> needed.
