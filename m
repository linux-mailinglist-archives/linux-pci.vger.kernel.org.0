Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C905B5FB9E2
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 19:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJKRri (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 13:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJKRrh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 13:47:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0BD4D25B
        for <linux-pci@vger.kernel.org>; Tue, 11 Oct 2022 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665510452; x=1697046452;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PJZmgiPDJJeaEzB3coFqt0s2hLt2h6metfovLrsJudg=;
  b=J9vMtBsAPAIuKIglDIuLg9tJBGU0Y56TfFdNh8of9OSqAU9DAR5aRuBe
   yQuN4iQeD2a1F0F6dUbWIlAssH6DIBqy8VuFvJ4C7XgEHLmMThg5aN3Xv
   mTeO9gUIJxsw6cLOyv6orktdEvxlZMU85sBwhoKsGQmZaZpBf3VTtosBO
   atHYbPcQqcQHpoB7ggZJ5Adz6v8945sasch+r4WfHYdKzJutacX9rG/ql
   HZs5O0FkUjhI/sHZE+afiqQoBYWlcA2JjQ5vr7gH105ZIcmwCpaVkRM48
   QBqfR1WtT2CHRbFNYThaSbcDjo3MDo68+3hTb3Qf3/HDC5J3FaY1XTR0i
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="368747965"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="368747965"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 10:47:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="659625569"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="659625569"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 11 Oct 2022 10:47:31 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 10:47:31 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 10:47:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 10:47:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 10:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0H5Kgs2mVye9bqb2W38/Lpl/P6CG9oh+NWMAhBMb0ljrvE0EQ/L7YVFG0KTwrsMQN4EuikL2NiAGGEZQNrcRmFKP3BTi1538/mEW83b6z3xTSXDYLSUOd1YUswdDbBhh87QnTe0euBi2mBGYVpNv59+Vhjpe3wuxnFU58OFISaXK91ba1RZrt4d32S9wgKmZoIsqJnG7CS2T2sUMBImrFnunVo3MsIq7MkwfaMJePITTUlNPBnBwDKx9hjy+sufzl0M+NP9yXCLKSzThKU4RZdrlKNkNmvE/EW/2PzZ3bE60Fngmf6wO/aPxfEv88UEGPZnmKFaweachQbnz4N4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaOsRkNYMSVyiOxwBtpJV/vBvaPDNs7Q7Bjyoc03SJs=;
 b=bzTOBDt0dPebrMNCfRrAiTPT5c7avDntqm+axuAiQ5yFOAgBsABUUVWiU4rQsVR7h+B9TGz6kOzHYHmugV9GdaHoOx06yKfvoFgkcLUCkoiAJ3ER7phYKxYTMbCJkdI47UGqseZi6674te3XjJz3xVRr6isrpfSSvKJNVz6jC2puVUpi9B05dE8Zq1t7bUe+GqbvrTP/CsRAZ9VypTzbO/RORWhSn4WZ2EsNVC+182ejw2uqYvYN1p9x92ye3IFIEuzXGL8S94cfzELll8D3KxXZgVpUZap5rdGxPshAYZEmU6hNDKCMwDd69u7g4joyfZ88TNX0Z4rgSChBrVxFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by SJ0PR11MB5134.namprd11.prod.outlook.com (2603:10b6:a03:2de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 17:47:29 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::a3c0:b3ec:db67:58d1]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::a3c0:b3ec:db67:58d1%9]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 17:47:29 +0000
Message-ID: <e17390fb-0aee-4111-36fc-61bdf6799180@intel.com>
Date:   Tue, 11 Oct 2022 10:47:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH pciutils v1] pciutils: add new readpci utility
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <mj@ucw.cz>, <linux-pci@vger.kernel.org>
References: <20221011164904.GA2995976@bhelgaas>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20221011164904.GA2995976@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::33) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|SJ0PR11MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: ceef11c2-ad40-459b-b18b-08daabb0aa66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlCF8YmzNrzfusQF99dR1v13Q0dxQ3RSbWkZ26bmRESKBB6AjRphf003OWrDsdAGS1S822vTvCa5KC23oJ0dBg/DVV1xVh33QsoXrS+GwIy2t9HfqWaYDjKxOjkK+EMxe3o+Naa983ULIpyWq9EcuO0ZgdfNoiu8UUr7Bc5/K9+5UyO0Flj60zxLU7epuyUf0lPX0vnEIEcU46casBhj2WzDKur78P2bAjbZeyhI61EU3eCaOWMX73OivtoomXzuF67bTfHwKTWrUllGp/6rsZBkvxNsb5IR9pDrGDg6lm2o9l22K+Ur8IwXw5v680GdyJ1gL+Av/WxwxZtSkDPpzc6nAqhSOFYaPFX3VS/lSREqFG+2qd4O4WNyLiZF30nS5LzTMDF7Z+2GShkexEgx3kNXk431VYULXF1Z65KE3WaudDlJlosS44IInxWByvCYKaB3L388JtW/xzu524o8kV363GhAmSJF29dp8/xlbVlpgEkRqACz+JHYUF/zIAnC5ZfgO3X59jKKYcvO0OYRL1XjAD/CRo55TFyEZE1oB7+oUQVsOUVSr/ur6hu+GEda+7SUJTZ1Kfhx9bNntf8FnuxPIe9pMlfojYm1BzT7zjRmcBp3CC0CMuyM2T7cA6oQRHQ5MKZfd9/SM3GLXf6jpiQV68p8+fyz1LNnaQCBbMdYvlfntPJfY78td6cf4o2f8GP/zvEZl2b9QeVpY2mfHR9wyU3hyR90O3Zb3PtYYqvQzHlu9a/bMWkR+gWAs7a+gFXpSfNMeXJPawRf77tOj9Ib5zY1nwVtDoNbAmvwYxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(82960400001)(38100700002)(31696002)(6486002)(478600001)(86362001)(6916009)(26005)(186003)(316002)(31686004)(41300700001)(83380400001)(53546011)(6506007)(2616005)(6512007)(2906002)(8936002)(44832011)(36756003)(5660300002)(4326008)(66946007)(66556008)(66476007)(8676002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aCt1bmljSk45TVQzTmQ2WXRaMjIyR1Vyd3ExUGIvSytGUFZuWXB3MXUzdzZx?=
 =?utf-8?B?Sk5oSHdhYkl1TExBQVZxQVJ0ejJOdUlyNm1JTksyc3E1OUpMVnhuem1ibzZO?=
 =?utf-8?B?ampteEQyaEdQQ3pBcUU2Um56VVI4dEloVFNmYTluQ2FTcUhHeklHNC92bXZ0?=
 =?utf-8?B?ZUplOHJGSGdlQjJzZVRsd1htazQwMzYweTgvMk5zNmRNdzcyZk1YRkR0dFFD?=
 =?utf-8?B?T0V5SjBxN3REOGplVnRRMVhJWklvL2JNaFRsTlkrak5ZbEdYRCtqZXpTVmZI?=
 =?utf-8?B?WFMzNHNIWG5sc1k2MDVOT1VWQ0xodnFuOUdHUXBnVHY4YUcrT2w2TUtvcmN6?=
 =?utf-8?B?WTJ2OTFvNDhwVDBJQXdObU5BcVJlejJYUFgydjN2d2R2UXRhUk8xeU1OZ3ZC?=
 =?utf-8?B?dURZU3VzRTJIbjlTdXdtQkZlQ0g3YlErSWdiWHBuZi9jOUo4TXNTeWJLVjlv?=
 =?utf-8?B?T3VnbmxvNVluanRVU2Z5Szd2NEZ4TzJHKy9FcHdYR0xoSjY3NHFxalMxQmNl?=
 =?utf-8?B?Z0dmdmlxSjV1Z2dPM0hCNUcvSlE5ZWtjVkxra3F4U1lQYW9vRG5QL0JnOE4x?=
 =?utf-8?B?K3M4L3F6QXlOdXpUZ1R0R096WFNvU0p4dE9id0dYWDl2b0xiSGZEd01xWWFJ?=
 =?utf-8?B?MGtCNW15cW5pdnVOaTZuUktlYmh6WGtsdkhUb0V2OU1oQlNhcFFZeFhyaWU0?=
 =?utf-8?B?Mi9SRG5vc1Q1NEV4Z2t2V3pIemxHSUZ1NU1YYVA5NDNIOEl2SHZuOVhwS1oy?=
 =?utf-8?B?YXZGQWxzZGRCYzJiTXlrdHJrLzB6cytNMGV4dHlrNjlubXJvM1dJMUR0bVd3?=
 =?utf-8?B?VUdZTzdoczREZFhGS1RwKzlEUENWWGMzdG5oVDJzcHQwdHlVOWEzMnFPa3l5?=
 =?utf-8?B?ZG9oK3pXQTZsRy93d2NteGF2bVVpaHJMVU40UWNzc0VCL2tMcDh0ZCtLRXVx?=
 =?utf-8?B?QzVoY2VtQW1BeEVBMzgwdXQ0Y2grOVpFWGc0Tm9UYUVYVkpHKzFDYlVxQndj?=
 =?utf-8?B?end1VTE4akhhUlN2VThJWGgyUnV2NkFFU29qMmRzVldwS21PRWVuSDYrM053?=
 =?utf-8?B?WUszelJHdHl1QjZ6QmhXeXVNSFF6a2tmSnNMOElmZDhsS0l2eExLd1F6clc1?=
 =?utf-8?B?cHBUWmtMbXFQT1Y0d1VjbVhSUkpid0VLNEY1QmV4NzRYU0F3T2dxRUVMMlVS?=
 =?utf-8?B?VGdzUU5ob1pGM0RyK0ZOcGVCSzJLSWJsd08xMmgvWFhKa1VWZ1QveG1QTDdJ?=
 =?utf-8?B?TndzRW1SRHdkM3NZVVorNTBEY09FSVlIc2hNRVlRRWVveHNFcWFpR1pweG96?=
 =?utf-8?B?V0FPS3prT1A5ZlhzM3RZUkpIVjJuSEJZMFRMRWxEaml5MkozOXBEb1VKdWJR?=
 =?utf-8?B?ZEhNS1dRY1lCa3lZREMxbzJPdE44dVlyR0dHRzAyY29BY3Z1eXNSRjNvM0dw?=
 =?utf-8?B?OVlBVUduV1M3aGN0ODlucG5VTHRqMU1xR2g2MFJGR1YwZnBvRUFhMG02R1Yr?=
 =?utf-8?B?L011cTBGZDBpMGJleTdaNkVqV2owTCtWeDZUQzhsYW5vTnllbjJ4dmpoeHpX?=
 =?utf-8?B?ZjEvaEd0anhUb0JkYXN4N0g2bEd3Rmhib01SdXZDR0hMTjRwSEVGcmh6WWw4?=
 =?utf-8?B?dTh0bGFxRW1xRjlpK2pOZjRWOThOTUJQbWRGZnR3SFk1NFhhREdBS3VtdGJo?=
 =?utf-8?B?Y2V1TDdvRkJ3MG5sT2hIVlN1R3pSYXdGRXNacDI0M1dNeFRjUnc4cm1JTkZn?=
 =?utf-8?B?WlV1TU5jdlNTMlBqSjl5Q2NWdm9jaldteW9ZcW1EYXg4V1FHWjhrVnlBRExS?=
 =?utf-8?B?SFdzMzF0VGFhanJBL2lBMFU2NFdRMmhjcHpKK2lkdmlobHNjU2E1U3BFdWN4?=
 =?utf-8?B?WkF2U0J2b1ZYd210R0pVYnM2ZVAwd3B4ZWRNaG5SSHRNQ0pwZ2lzaldzdjh1?=
 =?utf-8?B?TkxJd2V5SFhybTEzSEszMWRGcW04aENZRjB0SFl6eEFOcWJQTTJBcnRjR3dy?=
 =?utf-8?B?T3I4MWRJVk1DYlU0SzBDaHdkRWllY3pia2d1SGw0WWhkTmdXY05NdnlyMHkx?=
 =?utf-8?B?dGt3QlN3OGVPTVRFdTFVUTNIOGVNaUlubE92eWdMOUF3UTlpNDdnekU2WDdY?=
 =?utf-8?B?ZWt0MytRTXdvNXkzbkxvbHpMbUpUcEZ3ajczMnFIU2VEMHpYb2dpazE4STBj?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ceef11c2-ad40-459b-b18b-08daabb0aa66
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 17:47:28.9359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43fbpqPXxQLX39ggez6IumEMbUrd685HlY9Iidde+ttYjWcKKiXZzf+xNufnz/j6ra6V3+HH0a8oWaUroXjNAMshzciVMnmdXKuZff4+b9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5134
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/11/2022 9:49 AM, Bjorn Helgaas wrote:
> I like this idea.  I often use rdwrmem, which is more general-purpose,
> but it's a bit of a hassle that it's not commonly installed like
> pciutils is, and you have to manually come up with the physical
> address of a BAR.

I think that's a lot of the advantage of this tool. And yes, there are a 
lot of other versions of this program around that just read/write 
/dev/mem. Having it come with the pciutils makes the most sense to me, 
which is why I'm here.

> The names:
>    "setpci" -- read and write PCI config space
>    "readpci" -- read and write PCI MMIO BARs
> are slightly confusing since both support reads *and* writes, and
> there's no clear config space vs BAR connection in the names.

Yeah, naming is super hard. I chose the *pci name to just keep it 
consistent with the tools in this package, but if Martin or you has some 
other suggestions, we can rabbit down that hole. I'm not super opposed 
to something like:
"mmio_write_pci"
or even
"mmio_pci"

> Would it make any sense to integrate this into setpci, e.g., by
> adding an address format for BAR MMIO offsets?

I hadn't thought of that, but it's not a horrible idea. My feeling in 
general is that I like to differentiate the tools to having "one job" 
sort of unix/posix style, and since this one reads/writes mmio, offset 
from the BAR, I prefer that setpci keep the job of reading/writing PCI 
registers, and this new thing does mmio.

>> basic usage to read a register:
>>
>> $ sudo ./readpci -s 17:0.0 -a 0xb8000
>> 17:00.0 (8086:1592) - Device 8086:1592
>> 0xb8000 == 0x1
> 
> Possibly annotate with the BAR # and the complete physical address (to
> correlate with lspci or dmesg output, especially when debugging via
> email)?  Maybe also useful with reading MSI-X BAR.  Looks like maybe
> it already does some of this with "v".

I think your point is reasonable, here is the -v output currently:
$ sudo ./readpci -s 17:0.0 -a 0xb8000 -v
17:00.0 (8086:1592) - Device 8086:1592
BAR0: len 0x02000000
0xb8000 == 0x1

Maybe I should print the BAR0 address as well, basically yielding the 
bits of math that were used to find the final offset and printing that 
too in verbose mode?

Maybe something like (proposal)
$ sudo ./readpci -s 17:0.0 -a 0xb8000 -v
17:00.0 (8086:1592) - Device 8086:1592
BAR0: Memory at 387ffa000000 (64-bit, prefetchable) [size=32M]
Final address:  387ffa0b8000
0xb8000 == 0x00000001

<the BAR0 string is like the one from lspci -vvv>

> 
> Possibly fill out the value to indicate the access width, e.g.,
> 0x00000001 in this case?

yes, good point.

> 
>> Currently the utility only allows reading or writing one 32 bit address at
>> a time. The utility must be run as root.
> 
> Does this mean the *address* is limited to 32 bits, or the access size
> is 32 bits?

Yeah, I should clarify that, it's the size of the target register, not 
the address, however, I don't have any devices with > 4GB of registers 
to try it out on to see if larger addresses will work.

> 
>> +++ b/readpci.man
> 
>> +Access to read and write registers in PCI configuration space is restricted to root,
> 
> IIUC, readpci is for MMIO, not config space.  But I guess readpci
> still needs data from config space to figure out *where* to read?  But
> I assume that would normally come from sysfs, not config space
> directly, so we can account for _TRA offsets.  I assume that info is
> sysfs is also root-only, so it amounts to the same thing.  And
> /dev/mem itself is also root-only.

I think this is a copy/paste error, so will fix. It was meant to be 
saying Access to read and write registers via /dev/mem is restricted to 
root.

> I guess I would say either just "readpci can only be used by root" or
> list the items actually required (sysfs config info and /dev/mem) in
> case access to them requires different CAP_SYS_* things.

In this case the app actually checks it's being run by UID 0, since 
we'll get all sorts of chained failures if you run it as a regular user. 
But simplifying the text as you suggested is best.

> 
>> +So,
>> +.I readpci
>> +isn't available to normal users.
> 
>> +.B -b [<value>]
>> +Optional parameter, defaults to 0 if not specified. BAR number to access if
>> +other than BAR0.
> 
> Maybe move the main point ("BAR number") first, mention the "optional"
> part later?

OK, will fix

>> +on any bus, "0.3" selects third function of device 0 on all buses and ".4" shows only
>> +the fourth function of each device.
> 
> Isn't "0.3" the *fourth* function?  0.0, 0.1, 0.2, 0.3?  Maybe reword
> to avoid the question of whether we start with "zeroth" or "first",
> e.g., "0.3 selects function 3 of device 0 on all buses"?

Good point, will fix.

> 
>> +There might be some, but none known at this time. If you find one please
>> +let the list know.
> 
> Does this man page say what "the list" refers to?

I'll expand it!
Thanks for the review!
