Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B124F5756
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 10:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiDFH1V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbiDFHKg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 03:10:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4302210281;
        Tue,  5 Apr 2022 22:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCRNYB0FLzrCU7ee611ffGCPImmZxX+dEDanpU5/TSG6CK+vqW8c+s+ZMCnsXw1qmHFL7YbtLTPTRtrHNxd2LIz2ECAgxiCZajjsKQBk4CUeHEdlqc+30re5Jfr9iim4Dr01QPk4OcusPWy0/vhGiK7TWKJrYFQs6s0CCl8pVUvKL4QP/uKf+R1DNysQdP5TlQ/n5WM73g+B95K1sP/95JpqWPXVNk+lMqNoUQJfekAeY+5/t+YoACDspGCrDixBSV0s0tBzOeZ8I2TeDX5v6HSS/abyMRcDBpMsDqP2wQglQF3RzRKfdRVLGM3SrKJzPprvqZNNBgsx9w0SM84aoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLS/wOD8KyEeamRu/Kn1yTMHshR5q+h2ssStQvbLs6I=;
 b=YAiymT9/EflxcD3fMSg1zrfCyKgRE7lGw9BZV4G3cxxeZ/oEJfpg0wllR76MG+xkNSdmRZA9KNs411wkQnJJQrnS9UWUtUoB3wJDaRF1ZN2hSRRwkZV1oJ3agr1dGu5dQWi6sl8i6SxGe+E/t/ZQ1EW9qg1pAMSSUbEGquc66ZjHV1LHHI6XvwGhG46G795fjiakiUpWRMSxZu3wXtCrxThuJtoYOa4eslaOD8bX7jNSt+EnxqKRsPXSesCrTqSM0cayzn1lVpjgoROc1feyWh7akRWg95+gbWQKQcZ08H0FGxpUnmVrV/49xDsn3fRMvCNxLP28Ez8VLHrosKgj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLS/wOD8KyEeamRu/Kn1yTMHshR5q+h2ssStQvbLs6I=;
 b=mMasqedWmt+hYTyGFfxCob/j2sgDGyJtOYSDs1amltU6SXfRzkjf/tN/mbnvO12aDNNNJJwvHtdgq8r3YPVXiFSwYpz8a7Tjq5nIZ7uZ9UrRP1pgRvBfmQbz61ZXzcU5u84+6tl+WKulKyxeXKco826RCs7XlGuJ/Aptz1mfhgKSvLQEVdDuAi3Z+kHpul29PQScidgBZHl9U7PIxDYAhDP+pIsTgR1n0VQR3XJAYpVr1hKvdZvABDuLMbxOvFu7ic9RaaZLdfFQoFaZMt9Rm5ddP+G5YvuQ7X+KQdL64QWFMI5oroAP7MnHrwwdAh9PBJRc6tJa5d/UVHeO5/PWoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 by MN2PR12MB3277.namprd12.prod.outlook.com (2603:10b6:208:103::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 05:32:57 +0000
Received: from BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::d1ee:362f:4337:d03b]) by BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::d1ee:362f:4337:d03b%7]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 05:32:57 +0000
Message-ID: <67fa293b-7957-df11-dd86-7d8d6d9802df@nvidia.com>
Date:   Wed, 6 Apr 2022 11:02:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] PCI: Fix the ACPI power state during runtime resume
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20220204233219.GA228585@bhelgaas>
 <8f89131c-41a2-02e4-1427-8a5b1704e0ea@nvidia.com>
 <469a9db5-9868-cb17-dd5c-96ef29193fda@nvidia.com>
 <2632919.mvXUDI8C0e@kreacher>
From:   Abhishek Sahu <abhsahu@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <2632919.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::33) To BL1PR12MB5304.namprd12.prod.outlook.com
 (2603:10b6:208:314::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25c170a3-5fa1-4390-e13a-08da178ee814
X-MS-TrafficTypeDiagnostic: MN2PR12MB3277:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3277BBB24FE7925F301D909ACCE79@MN2PR12MB3277.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TG5oUJ020Zstpcn5YHLDJQqjvCihpZs+mnevQqoFuEBP0qM3OhKuNIfWyGGVOFIo/WFPv1OCwkimZDNDG7826JYjIGkseJhlMec37B7b+1llFTHkTQIFb9A8Rv3AjIQhGF1MZ3M4pm//aeff0TcRrzYTiGKUAGBr8/Vfotor0YibyrDpeXQgjAd+UHtRdkZl7dj/9wPFCgpWbaLhkQt395JZmMwHQCBSqoafAYt7s/E1wByNMeb/juxfdhoYUV7gqpCIQtyUppNA7yrw4jUNmrcbH4Q7z+0fBRQniBw6kAZvoefxFkj61UmxrUp8HlDh0wfYMlbLUfTUP0wrITZRUy9itbSDvpxbz7/6BbyvkEhN+dPABqoaAlUgz9OfU1ogrmIksF6F9WHVnwsrDmWOusccG1U1G+s6RaXO24dkXyNVv/qA47/5K+WzoyTZGITY/15PNut2gDwd2W0jpzwmcixvQSALrLpCwkFT50rYktzJfu3nARTx06pWItvD88bLaWVBTsIr8EiXBfDkOZViUOfVBlXUSBLPC+kj1z0fEp6NBWGhpe7R1psQ2LiYS7uEC4CX3RvDD4OCcUXyQoDQkDDTL6Pbi3IBvuNubu4k5rdHfD5UgGWrySZyOzSjIBkoA3Pip+bHqYiGZ5RaKGn6PsQQhdvxt5VG0TdGXZVcj1q08Tg0QGjWb7s71MG5BmeS6xRG/PQ4v4cOoih3JGJ4We6mwzbm9UhLyJ9sdv26yYXt/Y1LhIFaRFBGuv1BXsoLOFJSlgncpmDY7IYBQHFnzUrByvSFp66pE4JIrC1UJ5uHZpZCIlw6tNwmhTzMEcJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5304.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(5660300002)(4326008)(66556008)(66476007)(316002)(8676002)(66946007)(31686004)(36756003)(8936002)(31696002)(186003)(966005)(6486002)(86362001)(54906003)(2616005)(6916009)(83380400001)(6512007)(26005)(6666004)(55236004)(53546011)(6506007)(45080400002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmZnZzhEdWxCRVQ0WXZxUjlhWDllcUdYa01zeDRkNHo2a3JwTWd6Q2NWNnFZ?=
 =?utf-8?B?MjU4Q29GMmkxeWc4a2VPSGJkRXNqY0oxVmYxM0lKNlhZWHNwR0NGamJPTUlt?=
 =?utf-8?B?bnMzcWRidmRQWXZlM1FiYnAvbmRXSWxTTGU3aGY0RHJldXByU3lYUUg0VHFS?=
 =?utf-8?B?aFhjUkRMcVQ1OERwU0p4SGE2R2kvSlcrNGhjb2tVSlRLK0hNNFhQa1ovdXN6?=
 =?utf-8?B?WjFnMG03MVJzRy95VlF6WmpWc2ZNZ2taOHVNUk1OQUNDN01ydVRSbFpYVFRX?=
 =?utf-8?B?RWVSSVFxQVhRTW9OWGNPeUYxSjIzTWxEZGIxY01vajA5T3lOb3NjaDloOE41?=
 =?utf-8?B?SDRVSVMrMkE3YTNwUUNEWTI5RVkxRXJuL1YyQW9SY2pnZThSbXB2Z1p5VlZu?=
 =?utf-8?B?eXJzc2F1YjE4a2hwY0F0anNnTVVTemNsRkE4MmtUcld4RUR6cXEzbzVpdmRC?=
 =?utf-8?B?c2JVYjhaS2w4NnBhcm1EUDBzcW1MTi9HZS9wQ0Q4Qk8wQXY0Q3VTR2QxM2x1?=
 =?utf-8?B?bTNvVnRlVEthc1NhQTJFL1NTTm1sSDFpaXpoYVZBMmxpUXlGeitaN29RYTFj?=
 =?utf-8?B?NEowUUxybkF0UWYzZ0tRTHZySlFVdDlsUmdYSmlTWDAyb0RzMTVrc3B1RTdH?=
 =?utf-8?B?Z05TVGl4cThVbGRSRkhXNmNXR0FSWlNGTXRxL0hvdFFGSlVQTkdnYTF5cTJi?=
 =?utf-8?B?VE84cDFxbjB6VE1OS1hCMGtiRS9vR3hNMFRheCtyL2hsOG9qMU9mL09LcU5U?=
 =?utf-8?B?QkovY1IvZjk5UDA3OEQ4QjRYMjF0YjhnY05nNzlTZUdsQ1RaTU5tSkJyL04w?=
 =?utf-8?B?eUpWK2x0WThEQTl0aExYNkJkUVk0TDBhVVdnYVVoNnZ1ZjV0LzZLcUtQL2ZU?=
 =?utf-8?B?SGFiZi9leTRKMjl5OENBdDFBUTBEWW43R2FLdWVkdVQvaFNmNzU2ZS9yT0NG?=
 =?utf-8?B?SENtREE0T2ZLVFd1bzNaQ0NWSUdFd2ZWTWxEeU8zMGFwOGdXK0drN1Rnbkgw?=
 =?utf-8?B?ZVJuZnRFSnMzUTRSclU4RFVxd2dHNVBOWmdsSTY5bWFSTWUxaVVvU1hvUmJw?=
 =?utf-8?B?b25hMjQ5NnduYXRXUzh3V1BGS3NKYzNhYmVXSFJCUFJGemE2YzM4OFhzM1Ru?=
 =?utf-8?B?NDR3aEVnMllrREpxNWVkQmZMY1J0QjRLd1l0b0FFS1VnM1hqamZlRHJocldz?=
 =?utf-8?B?TUI3VnE5djMwSVZLKzhJZGFrWjR3M1VkeFlDaHhnUy83Z1dxbUFsbFBCMkxm?=
 =?utf-8?B?YWVab21Jc2hKR3RrWlJvTXV6TEx6UENDMlhsRUxEZ2xjczBpUXRmSUNjYzBF?=
 =?utf-8?B?aTdEOVpJbTd5bkRGSzdwOWRJczgyNFF2VWJoaXFTd2t0VzEvMytlL1FZQlUr?=
 =?utf-8?B?YWp5YWpLYm5KS2lhR3k5anBZMGJlSC9MeGYreDRIZktQZ21nNk9mZGNSRDNN?=
 =?utf-8?B?cHdOVTZVTi91MkRuaktKdVc1T1hCbEVIL0RNanZKMzcyQndvWVdxemxveVI5?=
 =?utf-8?B?Rk51RjlWcHplMWl4ZWJWVHBhMGkzQ3dJd0NhS0J3MkY2T053R3ppMWJYZUFm?=
 =?utf-8?B?QjVUWlRnQ1JCS29CVVUwekttTWU5U0l3Y05WVmllYnNPZEw0eVFOV1IrUWww?=
 =?utf-8?B?cUE5WXF3SVd2dmFxeVpaZGZTN2xhK1NuTHhjSTBSaGt0VG14Y08yeEJkN2pp?=
 =?utf-8?B?RC9sL2tOWEZzNWRuUkgyaWVNVStlS3JKYkJsOWpscUZhUTVwTCtDaUFxL1dn?=
 =?utf-8?B?U0s5NGZ2b2h4Tk5qNHBRY3FkUkVhVE1SbnM3MTBVYTRmYkhlQkk3WEh2L1d0?=
 =?utf-8?B?UEVQWFlHb1AvNS81V3FtL1RWN1VqdnhOc3ltMExqd2tETExLSG9xbjZuOStW?=
 =?utf-8?B?eGcxQm11UTlWZFBxcHNyK0JhSzQ5YjJnb1NNbFdROFZUVnZuMzVOWFNiMzUz?=
 =?utf-8?B?dkUxUElHeWt3cHJQU2ZQMHJ4UVRWS2o1aDFjQkRjeTk5WFp2Tjltd0pjVUcr?=
 =?utf-8?B?dnNLYzI1eHZRSFhXekFzNk94d2tGL1dwcHROVXBKUFlaMGRPdFJwbmZWT3k2?=
 =?utf-8?B?VzB4SzNwL2RPYTBjV2NyT0hqd0RhQlMvVUxTaGtyTHJ6YTg1U3BCUFdveEp0?=
 =?utf-8?B?S1cvUnNBaVBKclVOZytER2VkNmdUUThGMm1VQk9MNDRJOVMwdzhTOExpZUdF?=
 =?utf-8?B?S0VZVDk4NldVZUUyTlhHeldGQVp0cHh0L2ZzMHkrQk15SVQwclJNMkE5aUsy?=
 =?utf-8?B?UHc2K2JsU0ROSTEwWC9tTkFFenFTVjBvaW8vcWFRWWpMZ3U1Z0xJRkh3alNT?=
 =?utf-8?B?WFBRWW1YcytZd0szUUxWT0pxcC8xb05tVFZVUDBVYUIzVlJPUVdUZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c170a3-5fa1-4390-e13a-08da178ee814
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5304.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 05:32:57.6260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 972fnoOiOjSstwmH/JvORTsJ48uAqYa7LN9Jre61Qc70Z8Mzyd/8b/Hi+SzUTeqtsGLOidYJPGbTG1B9mAl/DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3277
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/5/2022 10:20 PM, Rafael J. Wysocki wrote:
> On Tuesday, April 5, 2022 6:36:34 PM CEST Abhishek Sahu wrote:
>> On 2/8/2022 4:00 PM, Abhishek Sahu wrote:
>>> On 2/8/2022 12:28 AM, Rafael J. Wysocki wrote:
>>>> On Saturday, February 5, 2022 12:32:19 AM CET Bjorn Helgaas wrote:
>>>>> [+cc Rafael, hoping for your review :)
>>>>
>>>> +Mika
>>>>
>>>>> Wonder if we should add something like this to MAINTAINERS so you get
>>>>> cc'd on power-related things:
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index ea3e6c914384..3d9a211cad5d 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -15422,6 +15422,7 @@ F:    include/linux/pm.h
>>>>>  F:   include/linux/pm_*
>>>>>  F:   include/linux/powercap.h
>>>>>  F:   kernel/configs/nopm.config
>>>>> +K:   pci_[a-z_]*power[a-z_]*\(
>>>>
>>>> It seems so, but generally PM patches should be CCed to linux-pm anyway.
>>>>
>>>>>
>>>>>  DYNAMIC THERMAL POWER MANAGEMENT (DTPM)
>>>>>  M:   Daniel Lezcano <daniel.lezcano@kernel.org>
>>>>> ]
>>>>>
>>>>> On Mon, Jan 24, 2022 at 05:51:07PM +0530, Abhishek Sahu wrote:
>>>>>> Consider the following sequence during PCI device runtime
>>>>>> suspend/resume:
>>>>>>
>>>>>> 1. PCI device goes into runtime suspended state. The PCI state
>>>>>>    will be changed to PCI_D0 and then pci_platform_power_transition()
>>>>>>    will be called which changes the ACPI state to ACPI_STATE_D3_HOT.
>>>>
>>>> You mean PCI_D3hot I suppose?
>>>>
>>>
>>>  Yes. It should be PCI_D3hot here.
>>>
>>>>>> 2. Parent bridge goes into runtime suspended state. If parent
>>>>>>    bridge supports D3cold, then it will change the power state of all its
>>>>>>    children to D3cold state and the power will be removed.
>>>>>>
>>>>>> 3. During wake-up time, the bridge will be runtime resumed first
>>>>>>    and pci_power_up() will be called for the bridge. Now, the power
>>>>>>    supply will be resumed.
>>>>>>
>>>>>> 4. pci_resume_bus() will be called which will internally invoke
>>>>>>    pci_restore_standard_config(). pci_update_current_state()
>>>>>>    will read PCI_PM_CTRL register and the current_state will be
>>>>>>    updated to D0.
>>>>>>
>>>>>> In the above process, at step 4, the ACPI device state will still be
>>>>>> ACPI_STATE_D3_HOT since pci_platform_power_transition() is not being
>>>>>> invoked.
>>>>
>>>> I'm not quite following.
>>>>
>>>> I'm assuming that this description applies to the endpoint device that was
>>>> previously put into D3_hot.
>>>>
>>>
>>>  Yes. This is applicable for endpoint devices which was previously put
>>>  into D3hot.
>>>
>>>> Since its current state is D3_hot, it is not D0 (in particular) and the
>>>> pci_set_power_state() in pci_restore_standard_config() should put int into
>>>> D0 proper, including the platform firmware part.
>>>>
>>>
>>>  The pci_restore_standard_config() for endpoint devices are being called
>>>  internally during wake-up of upstream bridge.
>>>
>>>  pci_power_up(struct pci_dev *dev)
>>>  {
>>>       ...
>>>       if (dev->runtime_d3cold) {
>>>         /*
>>>          * When powering on a bridge from D3cold, the whole hierarchy
>>>          * may be powered on into D0uninitialized state, resume them to
>>>          * give them a chance to suspend again
>>>          */
>>>         pci_resume_bus(dev->subordinate);
>>>     }
>>>     ...
>>>  }
>>>
>>>  For the upstream bridge, the above code will trigger the wake-up of
>>>  endpoint devices and then following code will be executed for the
>>>  endpoint devices:
>>>
>>>  pci_update_current_state(struct pci_dev *dev, pci_power_t state)
>>>  {
>>>     if (platform_pci_get_power_state(dev) == PCI_D3cold ||
>>>         !pci_device_is_present(dev)) {
>>>         dev->current_state = PCI_D3cold;
>>>     } else if (dev->pm_cap) {
>>>         u16 pmcsr;
>>>
>>>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>>         dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
>>>     } else {
>>>         dev->current_state = state;
>>>     }
>>>  }
>>>
>>>  In the above code, the current_state will be set to D0 for the
>>>  endpoint devices since it will go into second block where
>>>  it will read the PM_CTRL register.
>>>
>>>>>> We need call the pci_platform_power_transition() with state
>>>>>> D0 to change the ACPI state to ACPI_STATE_D0.
>>>>>>
>>>>>> This patch calls pci_power_up() if current power state is D0 inside
>>>>>> pci_restore_standard_config(). This pci_power_up() will change the
>>>>>> ACPI state to ACPI_STATE_D0.
>>>>>>
>>>>>> Following are the steps to confirm:
>>>>>>
>>>>>> Enable the debug prints in acpi_pci_set_power_state()
>>>>>>
>>>>>> 0000:01:00.0 is PCI device and 0000:00:01.0 is parent bridge device
>>>>>>
>>>>>> Before:
>>>>>>
>>>>>> 0000:01:00.0: power state changed by ACPI to D3hot
>>>>>> 0000:00:01.0: power state changed by ACPI to D3cold
>>>>>> 0000:00:01.0: power state changed by ACPI to D0
>>>>>>
>>>>>> After:
>>>>>>
>>>>>> 0000:01:00.0: power state changed by ACPI to D3hot
>>>>>> 0000:00:01.0: power state changed by ACPI to D3cold
>>>>>> 0000:00:01.0: power state changed by ACPI to D0
>>>>>> 0000:01:00.0: power state changed by ACPI to D0
>>>>>>
>>>>>> So with this patch, the PCI device ACPI state is also being
>>>>>> changed to D0.
>>>>>>
>>>>>> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
>>>>>> ---
>>>>>>  drivers/pci/pci-driver.c | 14 +++++++++++---
>>>>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>>>> index 588588cfda48..64e0cca12f16 100644
>>>>>> --- a/drivers/pci/pci-driver.c
>>>>>> +++ b/drivers/pci/pci-driver.c
>>>>>> @@ -521,14 +521,22 @@ static void pci_device_shutdown(struct device *dev)
>>>>>>   */
>>>>>>  static int pci_restore_standard_config(struct pci_dev *pci_dev)
>>>>>>  {
>>>>>> +   int error = 0;
>>>>>>     pci_update_current_state(pci_dev, PCI_UNKNOWN);
>>>>>>
>>>>>>     if (pci_dev->current_state != PCI_D0) {
>>>>>> -           int error = pci_set_power_state(pci_dev, PCI_D0);
>>>>>> -           if (error)
>>>>>> -                   return error;
>>>>>> +           error = pci_set_power_state(pci_dev, PCI_D0);
>>>>>> +   } else {
>>>>>> +           /*
>>>>>> +            * The platform power state can still be non-D0, so this is
>>>>>> +            * required to change the platform power state to D0.
>>>>>> +            */
>>>>
>>>> This really isn't expected to happen.
>>>>
>>>> If the device's power state has been changed to D3hot by ACPI, it is not in D0.
>>>>
>>>> It looks like the state tracking is not working here.
>>>>
>>>
>>>  The state setting to D0 is happening due to the current logic present in
>>>  pci_update_current_state(). If we can fix the logic in
>>>  pci_update_current_state() to detect this condition and return state D3hot,
>>>  then it should also fix the issue.
>>>
>>>  Thanks,
>>>  Abhishek
>>>
>>
>>  Hi Rafael/Mika,
>>
>>  Could you please help regarding the correct way to fix this issue.
>>  I can update the patch accordingly.
> 
> I think you can try one of the patches posted recently:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-pm%2Fpatch%2F3623886.MHq7AAxBmi%40kreacher%2F&amp;data=04%7C01%7Cabhsahu%40nvidia.com%7Cae4c8574f5a44973514a08da172471d6%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637847743178405297%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=aasJ79EICVnlJQ4EbXA2AtZFW0qnRsMkHEZRI8mnDI8%3D&amp;reserved=0
> 
> Thanks!
> 
> 
> 

 Thanks Rafael.
 I have applied both the changes and still the issue which I mentioned is happening.

 Following are the prints:

 0000:01:00.0: power state changed by ACPI to D3hot
 0000:00:01.0: power state changed by ACPI to D3cold
 0000:00:01.0: power state changed by ACPI to D0

 So ACPI state change is still not happening for PCI endpoint devices.

 Also, the I checked the code and the pci_power_up() will not be called
 for endpoint devices. For endpoints, pci_restore_standard_config() will
 be called first where the current state will come as D0.

 Thanks,
 Abhishek
