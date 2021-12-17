Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2388478952
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 11:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhLQK7H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 05:59:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:64771 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235165AbhLQK7H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Dec 2021 05:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639738747; x=1671274747;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MXHO8vgcHyd/TVMIPJYLDz8MYBtMsuRsPOEuSgVRvF0=;
  b=GFl6ZxgJqjNK3OZD5YapEqTe/t81hxHKFHXNlmBpYM2SzgEibTDz25cY
   lPwOxmaxQWM1OzexKrDlNA33FJO5tNrLEeP7kr8wCKGN+V+ynRswcSMpw
   ks/Pi94eCJFzao/x24oYgMVEg+qFLn+V9OmwW8+jcdbkkHvPrWkVLr8c+
   b7TSKAOPv1K5L28NF1XTTizejy0yzZhOqyQ6ZUuL33eBUy2vEWs0aUIdy
   b/x19/5Y+aZPzL7xxeVZzyvcb4m4klac1omkLLJD22A2z0BexpnCbKdOI
   RAXQoc+xBeJCVTRz3KwqmlcflsmGEXy6eJ6hrgGMovV7TRQMbIwszkOzC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="238475526"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="238475526"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 02:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="754528703"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2021 02:59:06 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 02:59:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 17 Dec 2021 02:59:06 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 17 Dec 2021 02:59:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UctsZv5sK46PUUaHZp72pOes/U/92IXYKAHpKpt8QDKtbEQ5BV4X+4970pkvJbg31llpqfflEtH8jvGdYAg4xSuM1d2W54fSQTft+6kL35nhI1LGixMD1Y1cRecDDfLGQxF/FV2XoL5FOkz6ZIte2uJmFiaiTAiiwWg/Nc/XNj2fcONHGCKMTpLj28d2SWM+ni2rvLdU786iycw2Du7TCa29IUe7L/TFV7CGU6IPbNAxd5PLB2Rmy06N6vIHjU57mqoY9sC+bnhGVgeSClZzZle2BUfoyDFsuXf7w2vn+AbCetyCD6lMkqPOp2SMZuTKHeY9iZyNwxAtBmpCyEErfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SeyjTfOmfd1C8JMH/PSbMa/KZRQ8Wqo10wwIEDTuq0=;
 b=L4UJFNeKOAlIG9Kfo98+n0PHwga4/alxqkKRkNcjOPhnVf9B190GphFYqJIRAQHRQdrQZfnl0CxXXP7dXanWCjRTQEe/ce1Jh78WeEnonQB5UnWEiajVMfD6rDw7Dxze2YeTh3RTMR9tp+DYgWsxu1ECNHXgtUNfvMSH3Jl1GOHz66PlJoi8tZK8tv+z2djOJliXgDnuPmM0PGTTzT3Otum8xIe+m145IWlpPUu/KpFUNg8FOklqh0dwuG+YveCgkEmCZSiruw+1QGrngbu+vedT5AU9M1B18wjCUsWecE0NJghtF8p6Y7+EOcIpTDyypF4+4oGrgWBoOI1ELEJkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM8PR11MB5688.namprd11.prod.outlook.com (2603:10b6:8:23::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Fri, 17 Dec 2021 10:59:04 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::54fb:8c9f:670:3658]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::54fb:8c9f:670:3658%4]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 10:59:04 +0000
Message-ID: <44100bee-81a0-079a-7247-5c1580142bac@intel.com>
Date:   Fri, 17 Dec 2021 11:58:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] PCI: Add support for VF Resizable Bar extended cap
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20211215141626.3090807-1-michal.winiarski@intel.com>
 <20211215141626.3090807-2-michal.winiarski@intel.com>
 <7a09b5c5-9c7c-106a-65c6-8c25c4918960@amd.com>
From:   =?UTF-8?Q?Micha=c5=82_Winiarski?= <michal.winiarski@intel.com>
In-Reply-To: <7a09b5c5-9c7c-106a-65c6-8c25c4918960@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0067.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::12) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 901258db-2d16-4222-fee8-08d9c14c3d9b
X-MS-TrafficTypeDiagnostic: DM8PR11MB5688:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM8PR11MB56882CDD586582FFDC43602098789@DM8PR11MB5688.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9tYbpVyfHFkXUUksZhWQLaODAlRGMfQfqrUdQoGNRCu7ZYc/UbUzpQu/BfoXQcb+Tk9gIcKiZYPrJuYiaN6aX/7ED7fADxbdzDuVfmHPnBNaHGph67vUqggkFlfp5oSr6tiNZ9jH5tYUsjybrI4AxEh1AepwbV1j0GRmi+UvU0uY6Gupo6SqPwejkR8uUlAJzt+QGkHwyqr9ziWlk1DPn7qNrq9JpR+69jgLIVFVmloyGLSWfnzKHR0Opg+NkV6zYg1aaxL5tYN1+3LzUUa+vLRO4Lg6uLeXM+bP20iUI46btpzuSk9QH/L6OWUAl8pdZNwxwlW5KntSLu1uz8TGkeZBKv+UpP47wgdbK4O4ojHunxllPFDSNaDyKVwN/pLHBZkO3Fn2H2lv7wRveecfMsEChxQ/ICMYT+fZ+s9pJG9kMHVsX/04B3xnBQ6jvS++jMTpq1qJKo5JBDY/R4B3AsH7s9nGqGvBbLk85v/jrsKTDPizIfAuPIpZGLpT8QAyOfkmc/aThf9xRmKUdDycdeDyQsh9kNDeHjJHHOviiozOonvpDQzmZoHnkrI74fl5BkybSPXeNzoVWE5NrwEFx7D68raTANGPlksVzz01TXgUhaklb+3eGrK5KEB7KpsCW4lAnhEsAXTSYqKS367WD9eE17TkwOy/7hz2/FJdMgrJJc56+aeLYAMh3ztH64XfQ/PozJpStiSE2xIQUAWH36hvwcgGpNcy8wARvf80fw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(66556008)(31696002)(86362001)(2616005)(6512007)(508600001)(186003)(66574015)(82960400001)(83380400001)(36756003)(31686004)(316002)(66946007)(5660300002)(66476007)(6486002)(2906002)(4326008)(53546011)(8936002)(110136005)(6666004)(38100700002)(107886003)(6506007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3A0K0RYNHZNbUwrVXRiVWVKZjlZUjVxcDk3SHdGaUtOem1rUkF0MTl3QXk5?=
 =?utf-8?B?d0VhOTZNOVJlb1YzR2xFRkxCWG9UL1pyUGVMNklhRGU1RmhrTUhuYW1qRm1s?=
 =?utf-8?B?c2x5anBGVFFKdWYrV09HSkRxcWhRTkNIbmVZN3ZWaFRaTmZBSG9hM2FxQ2oy?=
 =?utf-8?B?aWxsT1pZZ2UwWEZTc25ILytaTnlPRGx3d3p6OStFKzA4ZGt5UnhSSUduNTVp?=
 =?utf-8?B?WDgvZmRKbWxOVDh0NjNJL1hwa0k4TjBsQjZlek1FbGgwdFkvSkRMeG5UV3l4?=
 =?utf-8?B?d2syZVlkZUpDTUNaU0IrN2ZVRis4M3pxVlYwak9ib2RBc3J0VERwNzZJZTVk?=
 =?utf-8?B?VlhMOTl1Y3hQbCtwYW1mUlowWTdKbE51OWdKd0EvWW9NVlZEaktSTmhZd2Fw?=
 =?utf-8?B?ODVVeVVQODRQOHhYT3RaYlh1Q3hZcnM3bEVpZHJJVGlPZHp4SSs1WEtURUhj?=
 =?utf-8?B?eUI3OHJPUk94WEJ3K3pRQVlUNXVjdUpvaWxLZU4rTk1aRjJaMkN5OVRXMXZG?=
 =?utf-8?B?TE5ick1aK3NFK0VIMVFyT2xJT0RoQSt3V1RIWWxBY1c4NzNjaVphc0hhdXJu?=
 =?utf-8?B?TitOY2VtM2N2aUhNMlpoUVlEZk1adUhDV0ZrMjM3WVArbVQ3Z3NsL3RYTlZi?=
 =?utf-8?B?ajdUYUJiWlowdzdZK1dzcFN6Z2JJaEhUc21lVHgvR1NSUllaRW5uRm5Nb3Ry?=
 =?utf-8?B?ZEpZUHEybCtTZ3Y4SFNGVmNraUlLTUN0V2tiTWQ5ME44WjQwRThLdUM5U09j?=
 =?utf-8?B?Y080ZnNPN0tBMmZQV21HeUR4MU9LQlkrZFVmVTBicCtwVGNkWDV4aUtINTJr?=
 =?utf-8?B?dmNyRmh4ckRxR0ZyRDdaVXNnV1RXaU1lTEJLSmxBNm9kLzJNcHQ2cFlWTHJB?=
 =?utf-8?B?SFJpbkdFMjBFSkVWWkpONFhrdDhMa3M4L2taU2dzWUgwOUQrcnkrN3dGd2Zq?=
 =?utf-8?B?eFI5MVFvd1JsWjNnYUFNZXRPWmlsM28zWHdBT21icFFOdnpqbTFIeUtseVlE?=
 =?utf-8?B?N29oQnFFSWpVUk1YczgwbGh3MDNoV0dnL0IvSk8yNmh1WnZBMm43ZU9qSWZ0?=
 =?utf-8?B?Y0VGYUQ5bGVzOEh4Z1pwZklqMk9BTVl5SFh2WkFja0lzSzYwRkp2amhNT3V5?=
 =?utf-8?B?STBibjZkMGpkOXNscTRYdm51SUdXTFM1NG1neHluRllVdm93U2xaL3hXMFFs?=
 =?utf-8?B?eHJvbW9zbzZ0d01udVU3V2lZNnU5VG5pRUlqSXJYUXk2MjBiNnpYSXB5cVF1?=
 =?utf-8?B?bm0wcC9HNGxTcUFUaTFzZ3VkeW9UWUpHbDJ1L1ZrdnJ5T1Nqajh3djZsUC96?=
 =?utf-8?B?cXNuWU1QZFdKWEx6SFovU3RiMkNkeTNyQjBqM1U2dWJBUjF2ZjJEbTJmK2tL?=
 =?utf-8?B?R3hkRHN5L0lvZEVTalM1bHpRbHp5RUp2alpQS1M2YnYvRDdKNkNtY3I0YVh4?=
 =?utf-8?B?U3J6RG9laUhBQ0FVNSt6bERYaE0ySjN1c3UxZXJZVGx1ZFV3OXpVeEZMdXcv?=
 =?utf-8?B?dXc0M0xTM2lralNMK1BGMlZXcGppcDNoRmtIaFcxOWVtRGxGRU92ZG1oMk9R?=
 =?utf-8?B?TGtKTGx6ZUNoSHFJbGVKYThGeThveUs1RmxtaXpXK2tuamlPTDRrNitFd3BI?=
 =?utf-8?B?K0RyVlBOUUZzeFZkeThBakdxVUZlR2hPTEEyVnZSYjcxY3NFK29KR2RWa0VU?=
 =?utf-8?B?RTRQeTlwRlBiV2hXNys3NGkrT1dzTzlvQnlYWG4vRTgybWFsY0duTTZoVS8z?=
 =?utf-8?B?bjQ4ODY3a1U4ZFhiTXh0SCs0b2JpY0c1TnR1b1R5VGpWdVhUU1RaYXFHZDdJ?=
 =?utf-8?B?MzNQMXBmL0hsSTk3VmZ6MXc0SEVsZTBsZzBuQzJjWkNqeVE0M3pNRW43dGxv?=
 =?utf-8?B?Y1YyY0hEcTQrUmdKdHdpVU5ZcHExK3I1M2x5TkJKWFVtUkl6d3pNbXdORWxm?=
 =?utf-8?B?bjJoWVk3djZkNmFwQmREU25GSytoWG03RlZKNW5oY0RQc2w1MEpWbVNMdzdO?=
 =?utf-8?B?S3V4d2w1Vm01QjJ1WUhmTEl3WTBNcy9wMFdDTzhUQUtEWUtmbGVkMnI4VzZQ?=
 =?utf-8?B?Z3pQMzJ4b1cxTElmZ1BnZlJtTUJVcEd0clB4dFZEdE5hSllOejZCeHRnbSt4?=
 =?utf-8?B?ZUxWMGFRVG5lQWZMRldETnFjTHpZdEsrTFJYeEx4M25ZSmV0TWsrQzA5bHlQ?=
 =?utf-8?B?NkJORWV4b2N5Ulkxb0xJOGx6ZGVNa2t1WWwvV0ZGVHVoemV3WTE5QWVKZjBJ?=
 =?utf-8?B?VUJ0aW9TVjRSSXRWeWdDRlFyV0RpOE5waWVZZGcvT0hjMTVpTTY3S055SHhC?=
 =?utf-8?Q?38+Mf1+8EqpfUW9Kpc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 901258db-2d16-4222-fee8-08d9c14c3d9b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 10:59:04.6818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwCdKEebc4zzii1SyTca3wosOMUPwyby7phIViND2jyge1W0HLTR5SeLrfMH7CcjifHLRy3c94oyutBnB/CQsh8g+8hoQ22Qz3a7CF43bB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5688
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16.12.2021 08:50, Christian König wrote:
> 
> 
> Am 15.12.21 um 15:16 schrieb Michał Winiarski:
>> Similar to regular resizable BAR, VF BAR can also be resized.
>> The structures are very similar, which means we can reuse most of the
>> implementation. See PCIe r4.0, sec 9.3.7.4.
>>
>> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
>> ---
>>   drivers/pci/pci.c             | 25 +++++++++++++++--
>>   drivers/pci/setup-res.c       | 53 ++++++++++++++++++++++++++++++++---
>>   include/uapi/linux/pci_regs.h |  1 +
>>   3 files changed, 72 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 3d2fb394986a4..89448c5104e46 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1682,12 +1682,15 @@ static void pci_restore_config_space(struct 
>> pci_dev *pdev)
>>       }
>>   }
>> -static void pci_restore_rebar_state(struct pci_dev *pdev)
>> +static void __pci_restore_rebar_state(struct pci_dev *pdev, int cap)
>>   {
>>       unsigned int pos, nbars, i;
>>       u32 ctrl;
>> -    pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
>> +    if (WARN_ON(cap != PCI_EXT_CAP_ID_REBAR && cap != 
>> PCI_EXT_CAP_ID_VF_REBAR))
>> +        return;
>> +
>> +    pos = pci_find_ext_capability(pdev, cap);
>>       if (!pos)
>>           return;
>> @@ -1709,6 +1712,14 @@ static void pci_restore_rebar_state(struct 
>> pci_dev *pdev)
>>       }
>>   }
>> +static void pci_restore_rebar_state(struct pci_dev *pdev)
>> +{
>> +    __pci_restore_rebar_state(pdev, PCI_EXT_CAP_ID_REBAR);
>> +#ifdef CONFIG_PCI_IOV
>> +    __pci_restore_rebar_state(pdev, PCI_EXT_CAP_ID_VF_REBAR);
>> +#endif
>> +}
>> +
> 
> It's probably cleaner to let the caller specify the capability to 
> restore directly.

Ok - I'll go with:
pci_restore_rebar_state(dev);
pci_restore_vf_rebar_state(dev);

in pci_restore_state() (where pci_restore_vf_rebar_state() will be 
"no-op" if there's no CONFIG_PCI_IOV).

> 
>>   /**
>>    * pci_restore_state - Restore the saved state of a PCI device
>>    * @dev: PCI device that we're dealing with
>> @@ -3639,10 +3650,18 @@ void pci_acs_init(struct pci_dev *dev)
>>    */
>>   static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
>>   {
>> +    int cap = PCI_EXT_CAP_ID_REBAR;
>>       unsigned int pos, nbars, i;
>>       u32 ctrl;
>> -    pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
>> +#ifdef CONFIG_PCI_IOV
>> +    if (bar >= PCI_IOV_RESOURCES) {
>> +        cap = PCI_EXT_CAP_ID_VF_REBAR;
>> +        bar -= PCI_IOV_RESOURCES;
>> +    }
>> +#endif
>> +
>> +    pos = pci_find_ext_capability(pdev, cap);
>>       if (!pos)
>>           return -ENOTSUPP;
>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>> index 7f1acb3918d0c..1946e52e7678a 100644
>> --- a/drivers/pci/setup-res.c
>> +++ b/drivers/pci/setup-res.c
>> @@ -407,13 +407,36 @@ void pci_release_resource(struct pci_dev *dev, 
>> int resno)
>>   }
>>   EXPORT_SYMBOL(pci_release_resource);
>> +static int pci_memory_decoding(struct pci_dev *dev)
>> +{
>> +    u16 cmd;
>> +
>> +    pci_read_config_word(dev, PCI_COMMAND, &cmd);
>> +    if (cmd & PCI_COMMAND_MEMORY)
>> +        return -EBUSY;
>> +
>> +    return 0;
>> +}
>> +
>> +#ifdef CONFIG_PCI_IOV
>> +static int pci_vf_memory_decoding(struct pci_dev *dev)
>> +{
>> +    u16 cmd;
>> +
>> +    pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_CTRL, &cmd);
>> +    if (cmd & PCI_SRIOV_CTRL_MSE)
>> +        return -EBUSY;
>> +
>> +    return 0;
>> +}
>> +#endif
>> +
>>   int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>>   {
>>       struct resource *res = dev->resource + resno;
>>       struct pci_host_bridge *host;
>>       int old, ret;
>>       u32 sizes;
>> -    u16 cmd;
>>       /* Check if we must preserve the firmware's resource assignment */
>>       host = pci_find_host_bridge(dev->bus);
>> @@ -424,9 +447,14 @@ int pci_resize_resource(struct pci_dev *dev, int 
>> resno, int size)
>>       if (!(res->flags & IORESOURCE_UNSET))
>>           return -EBUSY;
>> -    pci_read_config_word(dev, PCI_COMMAND, &cmd);
>> -    if (cmd & PCI_COMMAND_MEMORY)
>> -        return -EBUSY;
>> +#ifdef CONFIG_PCI_IOV
>> +    if (resno >= PCI_IOV_RESOURCES)
>> +        ret = pci_vf_memory_decoding(dev);
>> +    else
>> +#endif
>> +    ret = pci_memory_decoding(dev);
>> +    if (ret)
>> +        return ret;
> 
> Way to many #ifdef spread around inside the code, please restructure that.
> 
> For example concentrating the logic in a single function should help:
> 
> static int pci_check_decoding_disabled(..., inr resno)
> {
> 
> #ifdef CONFIG_PCI_IOV
>      if (resno...
>          return -EBUSY;
>      else
>          return 0;
> #endif
> 
>      if (...)
>          return -EBUSY;
>      return 0;
> 
> }
> 

Ok.

>>       sizes = pci_rebar_get_possible_sizes(dev, resno);
>>       if (!sizes)
>> @@ -445,6 +473,14 @@ int pci_resize_resource(struct pci_dev *dev, int 
>> resno, int size)
>>       res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
>> +#ifdef CONFIG_PCI_IOV
>> +    if (resno >= PCI_IOV_RESOURCES) {
>> +        dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = 
>> pci_rebar_size_to_bytes(size);
>> +        res->end = res->start +
>> +            resource_size(res) * pci_sriov_get_totalvfs(dev) - 1;
>> +    }
>> +#endif
>> +
>>       /* Check if the new config works by trying to assign everything. */
>>       if (dev->bus->self) {
>>           ret = pci_reassign_bridge_resources(dev->bus->self, 
>> res->flags);
>> @@ -456,6 +492,15 @@ int pci_resize_resource(struct pci_dev *dev, int 
>> resno, int size)
>>   error_resize:
>>       pci_rebar_set_size(dev, resno, old);
>>       res->end = res->start + pci_rebar_size_to_bytes(old) - 1;
>> +
>> +#ifdef CONFIG_PCI_IOV
>> +    if (resno >= PCI_IOV_RESOURCES) {
>> +        dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = 
>> pci_rebar_size_to_bytes(old);
>> +        res->end = res->start +
>> +            pci_rebar_size_to_bytes(old) * 
>> pci_sriov_get_totalvfs(dev) - 1;
>> +    }
>> +#endif
>> +
> 
> Looks like this deserves it's own function.

I'll extract the whole "restore after failed resize" to separate 
function (for both native and IOV).

Thanks!
-Michał

> 
> Regards,
> Christian.
> 
>>       return ret;
>>   }
>>   EXPORT_SYMBOL(pci_resize_resource);
>> diff --git a/include/uapi/linux/pci_regs.h 
>> b/include/uapi/linux/pci_regs.h
>> index ff6ccbc6efe96..7f5726d23b038 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -734,6 +734,7 @@
>>   #define PCI_EXT_CAP_ID_L1SS    0x1E    /* L1 PM Substates */
>>   #define PCI_EXT_CAP_ID_PTM    0x1F    /* Precision Time Measurement */
>>   #define PCI_EXT_CAP_ID_DVSEC    0x23    /* Designated 
>> Vendor-Specific */
>> +#define PCI_EXT_CAP_ID_VF_REBAR    0x24    /* VF Resizable BAR */
>>   #define PCI_EXT_CAP_ID_DLF    0x25    /* Data Link Feature */
>>   #define PCI_EXT_CAP_ID_PL_16GT    0x26    /* Physical Layer 16.0 
>> GT/s */
>>   #define PCI_EXT_CAP_ID_MAX    PCI_EXT_CAP_ID_PL_16GT
> 

