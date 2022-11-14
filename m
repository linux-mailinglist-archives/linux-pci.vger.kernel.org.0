Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A90E628866
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 19:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKNSfH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 13:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiKNSe7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 13:34:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76FA329
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 10:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668450898; x=1699986898;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Pz54BL3ZHbM8xMM42vqq54PiDLJqwnmNXd9jAx5LNo=;
  b=AVK5VVZ/d0R2eS+NyVpiPmFhuy81Rlb+U3rudXWrpeB4SLeag+NUrg8P
   J2p4oUds7R7Ckj8L3XnPeVvQI9hv+Z+gYiyE3KKuXtWemVFoz2z9DSTVt
   LeM4Tu7SwtQV0Ms9uE+uKx9bdHH6oYjzt3ynxWDVAyMAkMKMalyay1YXZ
   aXluuPDtIUL4Dmbv1WH9FUSIiyxSKgifONhyCZeJaXYKGk5piXYINgpD/
   XAZNjZfnSt2UyWuuy29Jh8AcwavKfzM4P7C6ZkjyVRP0V/jmOF0CM2h+e
   EviPw0SJp82tR2hKaDIG0tw1irCYhoO1fvzv3WCPhKMR6vcPXAzB5DNv6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="398338199"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="398338199"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:34:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="638599766"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="638599766"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 14 Nov 2022 10:34:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 10:34:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 10:34:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 10:34:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 10:34:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBb/XdS2UHjC4BnN26kg6GyKLD98ITqvRt1WoK0bAoWfCCrgSjRCVv6uEXCj2UfxoMwaU3Ouj9aP42VuA1Gjp73FaJ6lNtX/OXGkJG149CuBrXL0mcRLgDQrdVqWSjSNv8n89SqRQiTfrXtLDxtkNVe25nnOvrWo18eG2PD0mI7nI1XAhGSWu1Mmp3IiFjwQ3KurflGr/I0CqHsRnookKmn3C47iWi3BOyVoeHZ0v910CpQ+BDVfg2nEzTi/v7hkgbSwgcXiFKgIZX7NGHGxW3nMimZj5uGYInmuHNthdIcCRWhvqhLeiKHVrIl5h8t1NDyzQ/0czGNyk+SzDTYjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//3O0SiKTuTy9yR1Ykfi85rNl24uggTTaZ81/rqgPCA=;
 b=FWDKZYwe3VVlzBYSYqlMN4d7Mi2E39FkzXiKLBQNKXoPtkCGsyzNCalD6oHzjMwwneHzc0yGZiGdGDllEbs2vhDN5kRkRvQsDR+ojWSRTmYbTjuc8QiWJzcq1THX92E1KCMAbaCzYcYPsjKRGMtX9RccHXwubAtaHcVIQDhj04sbZ8xFuex1N39P0AiSerEJJSeK+nwoLqzbkmhJ29uc3JF6qpA4ec1IqTP6sRkPDjAHtVsCfBWt4752It4E+mIk+QZ+MrZaJrKpIGyEV2sTSG9jExHQ9Qs8svJXAYBpk39gewsmM8Ys5rv4D0biUH/ZoDWLMGBCutiMC5kzCFMU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH7PR11MB6380.namprd11.prod.outlook.com (2603:10b6:510:1f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 18:34:55 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d909:216c:b14e:826a]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d909:216c:b14e:826a%8]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 18:34:55 +0000
Message-ID: <c9954583-1a01-15ee-1155-a2cb18ed3e6c@intel.com>
Date:   Mon, 14 Nov 2022 19:34:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v2 1/2] PCI: Take multifunction devices into account when
 distributing resources
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        <linux-pci@vger.kernel.org>
References: <20221114115953.40236-1-mika.westerberg@linux.intel.com>
Content-Language: en-US
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20221114115953.40236-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::28)
 To MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|PH7PR11MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf0a33b-106d-48db-b12a-08dac66eece9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZ1bT7LwacEeRBQiO3Qih1whMr/sTFvUhNoNHUn2Tq9tOqNz7eARWAvH4DAWTC1+/YPK2isSctfSMT6udwPRhrDMUQ1/TyK5p+gY55v2x0x+H9nMEKltg0x2iPBsz6Rl19637JivmUyesMqTX6oTt6d4Y9OlXaA7+M/36kq/47dHnFdhnTFqnbzwev+iK3dufgdcEsFZNptdmYqkDjz0t/mGyb9xn1/EM7/6XCXfupzgbFwCh3fkaNXu4Shhm8sI0Xkd/+LKg8sDcuAtbanMlDChJ6m9W67M24uEI93Kde9xTS0E+lNn2RGeI9wpxJ1oPN3XWo4WgRuAQU2KZlUJ9tHkuOpB1eEBbPmL9zCRwpfASf2zoqDwxwdOmCeuoS82XC7TR0Wbn6MVt4CzzGyR14rrGGAsSgh9B4TtMRnqfqlK+aQlDKyHTlwJZhs6gIqqu9EcUI8HVF4ZBmVPvhP7YiV/AKL0wgXUCeJHSjqeihzIrhoFSOyEvu5wBBloieEladrh4aI+YvpVMwOCf2YyU+3ie2vywn/flq2NsKhThhuGvK2Dr237QBqA0zhWMou+nNHHpEtwKOk0XLnw00Qe8vcrVT+PbKYPu6iOJCRn1lKPQ3vlmZlid/6DLaNrIkI64W0jFoclwvzw03w2yE9TCond8mmkmja42kg9RolXoVAm0atTSfWesRH/yd+KSrnUb/iRM6BlDv3Za/0VqoWQSk+vzBl274fSeNIM2MptburDsx9ap+f3zqvaiYmWzeb9ZdnC4MFGhaQiNDzl+tXyrO7Yx6npEMxwJJjTsud2M4IC2wJp+v/VR+WzqjBEo87ptmQL+47WY4jq9Eu9uBelh568OUwlHxhnvxyq5UsvAwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(54906003)(316002)(31686004)(36756003)(36916002)(966005)(26005)(53546011)(6666004)(2906002)(31696002)(86362001)(6512007)(6506007)(15650500001)(110136005)(66476007)(8676002)(186003)(66556008)(82960400001)(83380400001)(8936002)(66946007)(2616005)(6486002)(41300700001)(5660300002)(478600001)(4326008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEZZUmVTUFNub3MwVWZDeGdNWjJmQVdqTUxFdENMUkI3OElTV2dKN1FhbThv?=
 =?utf-8?B?MWdwVjVTcVhrQWFrb1hVTEJIY25VbHowMS81Tnk0UXA2a1huKzdvRzZKNDNY?=
 =?utf-8?B?YnpBTlIyY09venpRRFQrVHk2SVZObFhBeG8ycGZYMHR3U0hhRzU0T2xSODlI?=
 =?utf-8?B?aXIyY0pVUTQ2dnRiSzBsYXJ0bjQrS2Z5RlJQemt0TEIwYnYydDdLOExZNjRT?=
 =?utf-8?B?QnIxRU9oUWdOVkZrQVZUMnBsVGdnQUo4Q2N3VmxkRTJwQThKSmVwVkhKSFZF?=
 =?utf-8?B?Y0F0L2lQbmFLdXZ2QVNodWhLM3J3K2pYNFIwV21ucWZzV3N1Z011amJMUnk2?=
 =?utf-8?B?VW9HNnR1bU5tamVHTXVoSVYzVUhDM1dFTU5XdWVnSzhmTXVRTWt5NEN2eENs?=
 =?utf-8?B?QVhucmhsS25iMG5qT0Fidkt1SHN4UktFSjhEcVRTWkJYV29wWmIvY2htTlJ4?=
 =?utf-8?B?cktMbVdRellacHhxQTN4WGhLU0FyeDk5UjAxdk5IclRKWUVJa2hJaHlITTJI?=
 =?utf-8?B?OGVDclJxUXljMEZzZUt4TFFSQUYxRTB3ZnRKa2lJMXBnK2I2QitLcjExbkFN?=
 =?utf-8?B?OHVpWFhLbDFaM0t4VUk3Sm9zRThoM25DNUZkVU9aZGZ1TTNXYkFuMkVKT3dE?=
 =?utf-8?B?MmFjZnVFczUxUzBkVGEwRnlCV3FnakJjOXRQeVRQQjA1QVRnM0RmMGNtaTh2?=
 =?utf-8?B?SStCQzdYUE92MjlHcnNCWldic1lYMjNjay9iUVp3Tmd0aEFEL0RFek5kY21p?=
 =?utf-8?B?UGdLUml4YlEyYUJNMyt0cVJGTHg1N0hJWUxScE43VGZKUkZDbDNpbllkSzAw?=
 =?utf-8?B?WVRLenlQOXl1RjhjQnNSd3NlU0RIV2lqbUNNbkRmem1MV1ZPLzVjNE5ncXhr?=
 =?utf-8?B?c1RJMUhhaVd5WTVodTR4MVVxcUJaZGRQS0JKVjBrQUdIR3JjMFppY3lpQ0JQ?=
 =?utf-8?B?cnRQSHJFam9PbDY2K3doWjRlZjVvUUp3VnVoUVU5RTFiTStkNjdSMy9lb0Z4?=
 =?utf-8?B?dXdiZzFrTEFvTmQxNWdyUUlERWg4TFBUNVJEck9ISWxLTDRibitzN3d0THZ1?=
 =?utf-8?B?NTJIaGtXTytEamdOVEFXbGRwZFRWY2FZQzM5QlQ0Umx5aHQ2dmI2RytxQmN0?=
 =?utf-8?B?djJ2NUJWNkVSbTZnbGZneU1TSjhON2w0MDBaK2JZZFNsRjFuQmx4NHZVR1h0?=
 =?utf-8?B?bVFMNDZlay8vTnF4QUM2YWNlbTlaeG5LYlNKN0sveUVaWXA1NkRReGY5cTJH?=
 =?utf-8?B?Y1hZRkU3eGR3eFppdXEyck5YS0pIOVF0dG9tY2pSMEhtSUlwN0NSWFRwaGdT?=
 =?utf-8?B?VFMxWDFQT2pMT3M4MjNNT0h5Zys4TkVnSko3TFNWZFVmWXdiQllpL2hMb1pl?=
 =?utf-8?B?UldvNHF3N29weXFSNTBRUkkwby80cDZsWGc4aGgzVmE4anlsRzhMczhJdWNC?=
 =?utf-8?B?NElWdXJkUjZnbk00SEJnbWZWL2RkVit3SnRlR29vYkZKODlhWE0zeUtqLzBn?=
 =?utf-8?B?QnBBNGZBNytGaEhpZE1TUlFmb2hsYWF4MmJEMEhYYncyU284aCtFRU9QNGZB?=
 =?utf-8?B?ZVFGV1MrdUZvRnE4bG9lUTkrcDROTmVqK0RpdVVuaXBBWko1WHNISHpZblF0?=
 =?utf-8?B?TkNjS1ZHM3ptR1laVEIrdndhRUhlc3FObkRKc2hGSXBXTk05U29OOHBydC9u?=
 =?utf-8?B?KzdtOEFFVWdNOGJIRCtLWld1ZUs4a09VMG4wVVk5L05qMnUyeEtmY0wxekhD?=
 =?utf-8?B?S1U4U255ODRGWGhzSEtMbW03RGhYREdQc24yUXUzS28xV09ETldZaFlQWFUr?=
 =?utf-8?B?UzUrcFBJcTFwZ0RSUDhOTW1KZ3NlYWVYY3h4a1VuZ2toNHFSTGUxQnlOL0pR?=
 =?utf-8?B?RHZOaHp5VkhDb1BLbkI5QWNobDJNVG0zV25QMjJTTkk4VnhOTFNkcDBzYnEx?=
 =?utf-8?B?ay9wd2ZlV0crTWVtR1gwaUFYR21ybkU4M3NIZFgyTURTTGVQOUZ3VEx5THI1?=
 =?utf-8?B?TGhvaWRKdUFWMzNTdEhhZXdsM3BJWE45NWY0cWViWSsxSm12NXQrN0g3V3BB?=
 =?utf-8?B?SEppa2sydDkyNXNjSFV6c1J6L1dpZ0pJU0xMamYxajF0eG1Lck1QZG1uMU1i?=
 =?utf-8?B?L0ZuWmhrbnpjRjBEYktqeVZZcDZqODRwYlByTFBsNW8zVHdaWWdrU25TbnlO?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf0a33b-106d-48db-b12a-08dac66eece9
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 18:34:55.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pl02lr1MAiN0aumq8q1llQ5e2kiJey0GMen2UXZ54FgOhssc6dUWjWHjaaaBzof65e8yxKStaoCimeyOnySNNs+7wLIyPMR1ASeHNFjCT1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6380
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

On 11/14/2022 12:59 PM, Mika Westerberg wrote:
> PCIe switch upstream port may be one of the functions of a multifunction
> device. The resource distribution code does not take this into account
> properly and therefore it expands the upstream port resource windows too
> much, not leaving space for the other functions (in the multifunction
> device) and this leads to an issue that Jonathan reported. He runs QEMU
> with the following topoology (QEMU parameters):
>
>   -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2	\
>   -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on	\
>   -device e1000,bus=root_port13,addr=0.1 			\
>   -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3	\
>   -device e1000,bus=fun1
>
> The first e1000 NIC here is another function in the switch upstream
> port. This leads to following errors:
>
>    pci 0000:00:04.0: bridge window [mem 0x10200000-0x103fffff] to [bus 02-04]
>    pci 0000:02:00.0: bridge window [mem 0x10200000-0x103fffff] to [bus 03-04]
>    pci 0000:02:00.1: BAR 0: failed to assign [mem size 0x00020000]
>    e1000 0000:02:00.1: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
>
> Fix this by taking into account the possible multifunction devices when
> uptream port resources are distributed.
>
> Link: https://lore.kernel.org/linux-pci/20221014124553.0000696f@huawei.com/
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@itel.com>

for both patches in this series.


> ---
> The previous version of the series can be found here:
>
>    https://lore.kernel.org/linux-pci/20221103103254.30497-1-mika.westerberg@linux.intel.com/
>
> Changes from v1:
>    * Re-worded the commit message to hopefully explain the problem
>      better
>    * Added Link: to the bug report
>    * Update the comment according to Bjorn's suggestion
>    * Dropped the ->multifunction check
>    * Use %#llx in log format.
>
>   drivers/pci/setup-bus.c | 56 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 52 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b4096598dbcb..f3f39aa82dda 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1830,10 +1830,58 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>   	 * bridges below.
>   	 */
>   	if (hotplug_bridges + normal_bridges == 1) {
> -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> -		if (dev->subordinate)
> -			pci_bus_distribute_available_resources(dev->subordinate,
> -				add_list, io, mmio, mmio_pref);
> +		/* Upstream port must be the first */
> +		bridge = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> +		if (!bridge->subordinate)
> +			return;
> +
> +		/*
> +		 * It is possible to have switch upstream port as a part of a
> +		 * multifunction device. For this reason reduce the space
> +		 * available for distribution by the amount required by the
> +		 * peers of the upstream port.
> +		 */
> +		list_for_each_entry(dev, &bus->devices, bus_list) {
> +			int i;
> +
> +			if (dev == bridge)
> +				continue;
> +
> +			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +				const struct resource *dev_res = &dev->resource[i];
> +				resource_size_t dev_sz;
> +				struct resource *b_res;
> +
> +				if (dev_res->flags & IORESOURCE_IO) {
> +					b_res = &io;
> +				} else if (dev_res->flags & IORESOURCE_MEM) {
> +					if (dev_res->flags & IORESOURCE_PREFETCH)
> +						b_res = &mmio_pref;
> +					else
> +						b_res = &mmio;
> +				} else {
> +					continue;
> +				}
> +
> +				/* Size aligned to bridge window */
> +				align = pci_resource_alignment(bridge, b_res);
> +				dev_sz = ALIGN(resource_size(dev_res), align);
> +
> +				pci_dbg(dev, "%pR aligned to %#llx\n", dev_res,
> +					(unsigned long long)dev_sz);
> +
> +				if (dev_sz >= resource_size(b_res))
> +					memset(b_res, 0, sizeof(*b_res));
> +				else
> +					b_res->end -= dev_sz;
> +
> +				pci_dbg(bridge, "updated available to %pR\n", b_res);
> +			}
> +		}
> +
> +		pci_bus_distribute_available_resources(bridge->subordinate,
> +						       add_list, io, mmio,
> +						       mmio_pref);
>   		return;
>   	}
>   


