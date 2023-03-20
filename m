Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4406C21E2
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 20:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjCTTtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 15:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCTTsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 15:48:40 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5449026BA
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 12:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehXHqtACsynLzAmB1Th84tOcLLj7pYAE5V5SKNL2FKv+3QT5Vi4K7KOcTyrbFUmhwt8ADJITMUdgchK0Xhmp25bedJAdkGGHAahu8gwf5zAuFSwNb7xBYC7uC6SANAc6gYq25t2eZr/ONA0y2/m1BgVZVGLQRgyyu/sui7Xsh40f0WOfgyleKY2wNN3VVVVjaMBStD/Y2STHxzYGrtTx3TvwJ7X8P7sZYlOqyEDATk0ezUQ9Jmgal8T1wRS3w4KF+84G+cUV8507+qAgll71q+lSb216VOodph3DwU6+jtUsZKo41cCzDvSKz8INExv6MeF52c2o6SsGMLzVP0IWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dU3NM9BTSrfNYqK9tbrZhPyTaPihmCFhrXbbNc4TijE=;
 b=I8QNxqu4oWE5btZwp/IeR3d/HLNIg1hn7OPaFbhtLdoPcH0EnbeexmjXOptOPWf3KhQlM5QUWKHBOGQUsSeCzZ55d7UWXWlgl1qZ8JDSd4gJm3KNCOLrM06kbI5s3DHjqt1kTnbXIBX/GE8FWJ6/Q1U4Cz8QAv5hoGrxQeztFc8nZCTP3IS/Qxv6f8PRTdM/QbAKWCjGT817S5m4Sx6XhlPCQWQXtMB1cQ7toVT7EcdHw0U6UlJd7D8lGzAxRn8kX8BmCdcFFDBimtwJZoD+P+T9zM66zVS15ENXmTbLC7HZd9aO14UdMY33Hbidl0qZEfVU8KMN303nmud+x4FOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU3NM9BTSrfNYqK9tbrZhPyTaPihmCFhrXbbNc4TijE=;
 b=H/WlQ5HjQV8jqqaTbrRzS75Wr/3trYZCZJ1IO9Apy/jM6ZxN8t2EH6MLCFZYLFbxt/04yTVIoGjwsy6TpnAzQ7jXekoFKACEjAMGVGPuPdZpDfQYqH1zPrHyD4pdd8wEzB70A2xlDIQadH1NVaBrXKM5psR4ZHUHHGutzsJCzP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:47:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 19:47:50 +0000
Message-ID: <0a1af321-adf9-afa2-46ca-1b76da576fbd@amd.com>
Date:   Mon, 20 Mar 2023 14:47:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20230320193630.GA2301992@bhelgaas>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230320193630.GA2301992@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:806:22::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8ebced-8b20-492b-a915-08db297bfce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eu7uzcdyewmPkYUGbf79tHWid8+uz23gbMbnaS2Ml2Jf3TodI07qmClqdKxdu6MURC4IAnXw8T1SL+DLlfVCY1joPNk44GKxYlG3Vn6mOHK4IIrH5DIQErKSLQO+mjluzcAFJGqoVPiLe/Cuh0WOZ0gCz2oDhK+KklpcA8DTWUQ07DpgT7jPSXqV8iIQFazJiJNFav11iGpuGhh1U0Hh/HBG3oY/8NU67ov0AQ88Ione1fHmkv0HWtwANbZ8y4FG+Kq3r847gcsD22+5DNN+/9p410vcZ+VDMbYbtBWZ6fLDK8lVp02PhnzyCziOhGJG/lPYIsipTaqNZ2m9EL66ltmRcJtJEq7X4xevN7V2njfxoGhIKXrRuguc9nOsWbbqn9mAVqCxg8pigzEYsgIhbavJQPR/mKlzmakIpyz1h8MrFRhp4m2o2Cg69/YRXoEPO8Hm9hGi0MCd9s9f7fkp/E8sWNrdWyjofG1wK6EHXsF1L65CcfI0AyLqcGyHaddKYtQfbmGVzKIixxOAcdg7JMwdZKcbhNMtJccEsuKo0qdyogRl6O9eQza5aweTWo+zX7cTu8DXV9Pr89auCXIW0abskEbFA5IkEMqonvmSNzFb8vFkcSmTWDaUi8alduzDBG9IEPg1nMvLDvi+fVeIcdhN6G5j+QmPHIvSa/bH4SuMsQcRhInr4EsCCmyeOdCfUHNzT6S1Xkp2iDMQhJokKstRvgDw12+P69hiSmLBL4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199018)(6506007)(186003)(6512007)(53546011)(26005)(31686004)(6486002)(2616005)(83380400001)(316002)(54906003)(478600001)(8676002)(4326008)(6916009)(66556008)(66476007)(66946007)(8936002)(41300700001)(36756003)(5660300002)(2906002)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGZValhvRnJiRmxIVDJUM1hwR0FrRTlIb0MxdFZ1STQ0enYxcWxGbThvemV5?=
 =?utf-8?B?dlNvMXUyZ0daQy8rSEJic3hZRW5zU2w4d3hJTjdnbVVFRnU1Z2pIVTZjSWdy?=
 =?utf-8?B?ZVJTdHZZWnhHbEsxcnZVUzBIa1ZrMXQ4Y1RTV1RDYjV0NTNYeXBFck9QaW53?=
 =?utf-8?B?RXpzb3JSazJycUh2Y0lhYnp4SlRvWTFqYWNPdFM5b2lGSVNaSE85TC9pbmFv?=
 =?utf-8?B?UHNTMFAyTm5mWTdPZ081eDlENlZvRkRtUHVSVkVlNWovcnRsVW9Oc2l0NVZJ?=
 =?utf-8?B?ZEtXbUNkVjVaTUQxR1dobC9VemxFYysxVkV5dlkwTTVFZHdIYzlWT1JOaVoy?=
 =?utf-8?B?NU1jbW1nWEs2UUJCR2NZR3JRNWwzK1J1Qy9tRjhsUHEvdGVKS3BoV1ROV052?=
 =?utf-8?B?R2pXeHVMdWp5YmZuWS80MlBJeVJ1eGg3MWx1Zm1iQVdsakVTY2xiMU5lYWo2?=
 =?utf-8?B?N1FsOGJnSWl2UHFaNlM1SkFTaXRjb3dldU9jU3Y0ay9FeC82OVNTaS9sakJn?=
 =?utf-8?B?c0hMc3BDUzBNSjlOR1FLMHF5WFdMSWNlaUNJMmdnQlJHcWRKLzU3RktvMG9j?=
 =?utf-8?B?Q0RNd21meXNiTGFnSEM4MlpadEkyM0R3QVJWZlNLVUJLRmM3cC9PaDFhdnRj?=
 =?utf-8?B?aE02eGdkdEpTSHA3NHJOSWZ4c2xFQjM1OVBsbDhGUHJsSk5kbmtTNU5wZFpW?=
 =?utf-8?B?UDRzSDVnZy9iM2ozamM5Y0ZXQldiZis5aGVBVWh3NWtFbW5LRFRhdFArUDB4?=
 =?utf-8?B?anNaWWNISHBkQ2JxemF1NTVZV0Y2NHhleWU5aFByZEVzclpwOW16dnlQQXl3?=
 =?utf-8?B?eS8vN1VKeGt5ZW9Qd2thUHdyelVHOW5sbDhzMWNLSmZRa2pmelFwSS81akNi?=
 =?utf-8?B?VlkwUGJkcW41K0thMDJYeVU3bTBCUDRMMEhGNVBRdlJQVEdIaElFRUdyMXU2?=
 =?utf-8?B?QzluWW1SQmtaT0RBcHNNTmVqVnFxRUJOU0FkMklmTlBkMTIxZW9haFNIS2tp?=
 =?utf-8?B?TEY0MEFZWjFJYjBYU1hWUHJpY0xPU0E0R0dMNG92cDJGak5JSGpBYmNHSy9N?=
 =?utf-8?B?ZFJodEtvVi9tU05zeHY2bEJpbGJ6d0FZSjN0NjBULzZXWFNSNng5V1JudExQ?=
 =?utf-8?B?TzAyUVk1azdmRThJU2xiam16Mi9uQ0dTTGl6WEZZRDEvbGV2WUdOOGgvVDNx?=
 =?utf-8?B?U2YzUlJuRW5ld3hzNlFIVGp3VDJIZHA2b2lGK0pvcGVZenlBZStJczhwRDBB?=
 =?utf-8?B?cElPT1dNUFdadVpEdnpMYWtSK3Fta3prd01ZWThRbCtTY1IxQ2YyZXNJNU95?=
 =?utf-8?B?SHBlWEw1NisxT2h5WmZidXlwUUIxaHAxa0lYTWRJM0FsMHRTdEQrYnl0OXgv?=
 =?utf-8?B?U0JnaTM1UHB6QXNjRkcvQlFtNzVteEZmdmRTL0lNMDJ5bGJpUG11K2lvSWt0?=
 =?utf-8?B?NDVFU285WjArSzRTMjBHaGpkenNNT0xycjZvNHdzcmJEREdHdFRwL3hBT1Uy?=
 =?utf-8?B?UHpQUStFSnhiZWRxUSt0aFNacDd0RXlNV3Yza0lTNC9BN0lVVnZnSlcwUE1C?=
 =?utf-8?B?elNrK1luV2dXUkpTczd6cUFCLzRNSGwzUlI3bTlsbEJCMm1PZjFwd3BzalNz?=
 =?utf-8?B?WkdPYnFQZmhFZUZnaVgwZWtYSUVoQnZLTVlWVmpzN3BEVjNESVRWWUtQSWFP?=
 =?utf-8?B?a0h3cmpVMVQ2dW5ScTRKZXI1RG1mZjM4ZGo2MEhtR09JZ0FiSmR3cUJ0bXQ3?=
 =?utf-8?B?SGh4OG9Nb1IxckorRHBIN2QyM0Y1YVMyckVDWkpMcVQvWWhjcklITFdXRUN0?=
 =?utf-8?B?dGR1WkpqVDVpR1lKbTFXMXd4bll2allKWURud1A3bjN1TDk3eHBvdHZIYlpM?=
 =?utf-8?B?VXVoSGM4bEpzOTE2WXdvUGZlMTQ3VzRpTHJYcmJpZ1QyRm5GTUNyallLdk1o?=
 =?utf-8?B?Q1VwcFpWYmk5ZGd6TEwwa3NkSUlGNFBkSVRrZ3ZaRkppZm1VVHFLR3N0NDky?=
 =?utf-8?B?Q1gwamNPQVVWSFF2QXFwR3ZpUUp0Ym5KWUZvR3licXMzZksraEptR05hRFVN?=
 =?utf-8?B?RzdPVCtKeGhocWZISVlsVlpWUFRtTGswWmdtUlFJaE5QWkk2SzltbytZUWJC?=
 =?utf-8?Q?7OgKNFG0S/sjb6SK+ic9DFoJV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8ebced-8b20-492b-a915-08db297bfce9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:47:50.5641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzQw4UisqYvaqrYvRUGTQOdEWmUDQfCSTOfeppWtLq99DNWJ0sCGALUrtTaDHrj18tdREn05L5AQ0VPjLwzutQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Whatever you're using for email adds all these redundant headers to
> every response...

Sorry about that, let me use a real email client this time.

> 
>>> On Mon, Mar 20, 2023 at 01:32:16AM +0000, Limonciello, Mario wrote:
>>>>> -----Original Message-----
>>>>> From: Bjorn Helgaas <helgaas@kernel.org>
>>>>> Sent: Friday, March 10, 2023 16:14
>>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>>>>> Cc: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Natikar, Basavaraj
>>>>> <Basavaraj.Natikar@amd.com>; bhelgaas@google.com; linux-
>>>>> pci@vger.kernel.org; thomas@glanzmann.de
>>>>> Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
>>>>>
>>>>> On Thu, Mar 09, 2023 at 06:57:38PM -0600, Mario Limonciello wrote:
>>>>>> On 3/9/23 16:30, Bjorn Helgaas wrote:
>>>>>>> On Thu, Mar 09, 2023 at 12:32:41PM -0600, Limonciello, Mario wrote:
>>>>>>>> On 3/9/2023 12:25, Bjorn Helgaas wrote:
>>>>>>>> ...
> 
>>> it's important that the commit log is accurate and makes sense even to
>>> people who don't know the internals of the device.
>>>
>>> It *sounds* like what's happening is:
>>>
>>>    - OS writes PMCSR to put device in D3hot
>>>    - BIOS traps D0->D3hot transition via something like SMI and
>>>      captures MSI-X state
>>>    - Device enters D3hot
>>>    - Device internal MSI-X state is lost
>>>    - BIOS traps D3hot->D0 transition via SMI
>>>    - Device enters D0
>>>    - BIOS restores MSI-X state
>>>    - OS resumes use of device
>>>
>>> If that's what's happening, the fact that the device loses the
>>> internal state in D3hot sounds like a *hardware* defect -- if you put
>>> the device in a system without a BIOS, the D0->D3hot->D0 transitions
>>> would not work as required by the PCIe spec.
>>
>> Actually it's a controller integrated into the APU.
>>
>> So any system you put this APU into has a BIOS.  Because it's a socketed
>> APU people can very easily move it from one motherboard to another and one
>> vendor may have the BIOS properly configuring but another might not.
>>
>>> We can call the fact that BIOS lacks the MSI-X save/restore a BIOS
>>> defect, but the only reason BIOS would *need* that save/restore is
>>> because of the underlying *hardware* defect.
>>>
>>> If that's the case, I would expect a commit log something like this:
>>>
>>>    The AMD [1022:15b8] USB controller loses some internal functional
>>>    MSI-X context when transitioning from D0 to D3hot.  BIOS normally
>>>    traps D0->D3hot and D3hot->D0 transitions so it can save and restore
>>>    that internal context, but some firmware in the field lacks this
>>>    workaround.
>>
>> I wouldn't call it a workaround.  The hardware is doing exactly as it's
>> intended for how the firmware programmed.
> 
> The whole point of the PCI spec is to build devices where standard
> features like power management can be operated without device-specific
> knowledge.  

Right.  I "think" the confusion here might stem from the term "BIOS".

The initialization of the hardware happens from a series of 
microcontrollers in the APU before X86 cores are released from reset. 
By the time UEFI runs all of this should have already happened.

When I say "BIOS" I mean collectively "all" of this firmware.

> If we need device-specific code in BIOS or Linux, I'd say
> that's a workaround.

Something I'd like to point out in case it wasn't apparent is Windows 
doesn't actually hit this problem.  It doesn't matter if the correct 
hardware initialization code is included in "BIOS" or not.

So I wonder maybe we should be looking at this another way?

> 
> Does this device set No_Soft_Reset?  If it does, when it receives a
> config write to PMCSR that puts it in D3hot, followed by a config
> write that puts it back in D0, it's supposed to return to D0 with no
> additional software intervention required.  I think that also means no
> BIOS intervention is required.
> 
> If it does not set No_Soft_Reset, pci_pm_reset() assumes that a
> D0->D3hot->D0 transition resets the device.  We save and restore the
> MSI-X Capability in that case, but we do NOT run the
> DECLARE_PCI_FIXUP_RESUME_EARLY quirks.  I think that means MSI-X would
> not work after a PM reset of this device.
> 
> Bjorn

