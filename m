Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469A04D68C2
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 19:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350999AbiCKSxx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 13:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350246AbiCKSxw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 13:53:52 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C7C48E7E;
        Fri, 11 Mar 2022 10:52:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muHvN0I2dFsW/qy/1fFz3dzLsvBqyAUW7FprjeqFih0gBO912MQqGs+I9y3JbD5Kk17VQqzXeX4Z+ucbNN3WKEfqO0hvAKrKgHN5109xpbMH88W5nNRX4YhmWhXsRrEcf2dIJYEK1cPaiu8MSJjDTQLS8cDaT+rSMtANFHbqO9ysDO0VWZJcBv8qX76AhCVcWOiiGZLq4NXq4cryFYTpwl6AAVkmSvW4nsGxYWYMKnGdaKxho0h/9P8czhrZZVewlNrH6rIQ2RiitnM1SO37DhDicaTReL8Xuo2y0BSXhC0cjHBDjMdUgRMtr2nYPGO/w0I7YfDPMq128LhP+phWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x59Hcv/8fwUXPprsbiC88KLNo1Y1gdEhqkagFzQto0E=;
 b=MSDgW56JcMOSBKnOuZDpYugl5KTPLesq3aGyxs0Q5bQWaWICLpJoOBMlWHSy0O2ENr2/wGkIYenlqAlQJUos7+0MjpxQzY0tyLVn4ruEHUAqFQozsoQ26ten2MeaEi6y3jmSJcU4FerkMdkurVkcJgidDVuQbl/FLrV8X75bxVm6Tech9+KQcH+qhrCv0CvlpiSxQfs19eAIcFgH1jBukRpmQ/p5nxynCIKZI2vwrJniN+LU4fyCKrFkH52IKjAhjCeEkJelxM9GRSCUOfPCSwt40D95NMLomGjjQle3SJ4rC46ZuIt9puf30Fyt7OGC4LC7V0U2JOpQpZ5fZpXmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x59Hcv/8fwUXPprsbiC88KLNo1Y1gdEhqkagFzQto0E=;
 b=TidJ1VG4dcJ2XjdBE3U4KWY/IvAK51obPBaLAT2Rgkqet00XVXHLPa2yRJrcxiuG4h//HqoKu8bXXFL4/dCuLZQr5PtkTo05RSTb2/APxYXtJJbR7cZnNRXkcqQjYYG3kVtxzmiGKnLE1CYGmPaineH4vM65b/xyEe9EVYFUDUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 11 Mar
 2022 18:52:46 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 18:52:44 +0000
Message-ID: <07e31fd8-ac26-f181-f848-290c130e5313@amd.com>
Date:   Fri, 11 Mar 2022 12:52:37 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20220310175832.1259-1-mario.limonciello@amd.com>
 <CAJZ5v0gjPwEcq2dEE+wRr3D+w7=MTEKJoQ+x9muh_R4W-DawVw@mail.gmail.com>
 <BL1PR12MB5157D9FDDD0FC829CDD8CFB2E20B9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0grj=vE1wGJpMxh-Hy7=ommfFUh5hw++nmQdLVxVtCSWw@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0grj=vE1wGJpMxh-Hy7=ommfFUh5hw++nmQdLVxVtCSWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0025.namprd05.prod.outlook.com
 (2603:10b6:803:40::38) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50cf1fa4-0b73-42e5-91d6-08da03905410
X-MS-TrafficTypeDiagnostic: CH2PR12MB5564:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5564FB103CB76A9697DEE929E20C9@CH2PR12MB5564.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMPZ4zrbPlQffgGi4kVoIQlYikMsf4RhWy3LZKubP1VXjGaYUwTskxDL6Ew3fY9jglAQ9l1GV5FbTMtW4ACqtOGq2LEHBQPhkEBNxYkshPOQTlifAVEFFxcQHkkDfTd78wF0KYxlSKLbMLMnN0sG7JrHfqeq22YyWasp9qEzntQ8NT13QjiLlE48yyYJd2QHDPF1vMDmwpoq9SGBvxdx4mIozZP+RGiwjKzpJQHJc4gKUr33mMBOXfzSU4/MKLHidPB7zQlGFNSPu7Zq21i9/5/msl2V4UrFXaC/orNS0PBLevzXz0iqCWDKk9Rk7AGKLa0wTlhL3kBF2x+WajcqXX/78pc1StK8WWylg6a8paQSYTEvNnOQERORovlb4N8soWWMtEbYO8yjGYecdLDPPTQEVolBZo5UCnD3vsEB+Q4mRyvZShFUPSONN4FDK+5x/CTX3wzMWnvQZIld7ko5hM+wQ/u86/mZs7uc8FHQxQm8jvYrreZ+61b+GF/Js6ejtM9RqEfmqDZXXziJyYgDYRJlw8Puo81mNXinGszLM4VcQ0ARYUsykdAk6dFhYDfvaEkwW4hJM8lprNv/CNe4qM2/wWcyoh3wOP2qnVIeVZ5wjDoMJTSW6y13rt6/dC56ILGryKPRKd0u+yJosaMigIO5v1G55VWqrwdVwcG1AD7YPFDvP0UIUSRXJsiSXovM7dOG/YSGrvy34mgJo99xfYmzY0LOOODvurZdZ0PeAe1Yba37wE2UV/xBwP+6QA/28F43D/wDXN5PQj8RiXiEWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(6916009)(5660300002)(6512007)(19627235002)(83380400001)(54906003)(6486002)(316002)(66556008)(53546011)(6506007)(4326008)(66476007)(66946007)(8676002)(6666004)(8936002)(508600001)(31696002)(86362001)(38100700002)(36756003)(186003)(2906002)(31686004)(2616005)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlFTQ3dvQ25xNThlNElYZjcvY1BMR1BXOURVZGYxQTJSS20rZmViQ0ZockVh?=
 =?utf-8?B?NHl1YVZrVVp2djAzTkxEU1hXM28xV1JMRFlOcCtrZHdNcmtsUlFhQnhMdFB6?=
 =?utf-8?B?bVVaU1oveVkrWHV2VUUvSEliaVpJNDBoVkx6UzJSN1BydGhoWUNvOWtNQmd5?=
 =?utf-8?B?Y00wSzZUcDRTQWMwV2ViUW40RUtnSlk0a2RLZGpqUUw1cVQ1WFZtKzJiSnk0?=
 =?utf-8?B?WjBrNTV6SXNaMG1WdDlocnV6YkM0cVhyZ0lGTmdqWUl0dzNjald1cmdpSE9R?=
 =?utf-8?B?TmZUNE1rdTVvNCtQSTFSWnJrRi9FdTBlZXRuOFIydkZ3ZEtGWEw4WFFSc2pP?=
 =?utf-8?B?SC9TQWxFZjRvUFRnYjlHM25VM1FHdkpOWUUyRzY5TlhCZmJweld0NmJLNFZQ?=
 =?utf-8?B?Vk53RnZlY2VkOVQyNEtBSVJ5V0VSWHVsZkZPQXJYK2hoTWEwTVhRc0lTUlJY?=
 =?utf-8?B?MUtkYkduZWI1R2Z5cjNhaTRFekp6YTZrUU4vTDdxdTc0REc5OUFhNEx3TGQ2?=
 =?utf-8?B?Zlc1Tk0wYXQ5YXdMS3J5RnZQN2sxd1lXd3pMclBHY0w1M0NvK2pXNlpnMENM?=
 =?utf-8?B?V1JpcVAvQ1N0ZWtIbE0xM0l4d2xOa3YyT2RXd0ZLOWZXRTVIV3NpMWl0d3VE?=
 =?utf-8?B?aGU2a3BDV3BwVUV2K0xnUFRNclM0cTJWWmt5dW1aUkF4TEg2aGo0SlVYQnF2?=
 =?utf-8?B?bFFrVDJIQ21xM0I0enA0aWJrZXBldzJ5WmVIWG9aWmlKalVUR1VMSVBNZ1pT?=
 =?utf-8?B?bDY3NUdXSXpoNTN0Tk1uMFZzYTNBZ0xwazFuR1pPbzBwSTBzUmJxRVVzSlJT?=
 =?utf-8?B?dTNBcTV2V3RtRDA1U1VVamIxTy9haEw1dERFbVVER0tyaXE1RzRUTHkxaW1I?=
 =?utf-8?B?b1BQUWg1ZkNlZFZuUDVYeGZKcGliQnhWd3dRYlZxbzVtZDd3RFFPU2JBSC9z?=
 =?utf-8?B?azNUZEU5K1dDWXZGZlBXRUNwYW02anZuSStjNDkxTkFsSUJraGxxSGRnb2tx?=
 =?utf-8?B?aGlxckhiSHN6SE9RdWg3UVgvL21BVm8yUkdaZnZXQm1TRnBiSmJLVlJXN09E?=
 =?utf-8?B?d2t6QmE4Tk1FakVZNzNyY1JYcW41ZkcxRllPTzA3TzhUWXlwWUxpVUhQRWNi?=
 =?utf-8?B?ZU5IUzFRUDZpOVNOZ3Q1OHdxMjl6c3RhM0ZqQTR3R3JsaFg2R3RLUFFhWlFW?=
 =?utf-8?B?ZkozU0I1NEhmMVNnb0h1a0lqV3B2MFdTVi90RjcwYUtNSjZmNkxVNm9tWmtk?=
 =?utf-8?B?MHFiNUlBdlFOVUlqQUxUaEU2dVZETTdYSGdqdjhWeTRaVUE3RVcxLzZtaFht?=
 =?utf-8?B?VTA3NHcycEFkcTdhV1c4di83M015SGdtNXJLQzFjMFhnZHVnNFNuRnN4Ky9X?=
 =?utf-8?B?WDJ2MVdTT2VBbHhsZDhmNEFvMnExeW1YNnMvTjBOaUh3dkNxenhldUE1Q2xF?=
 =?utf-8?B?bUQ0ZFNjbytDRmZGYWp0VXArZTRibWVSQkwrbzI1WUFzZ04vOTFRNjQwRkRK?=
 =?utf-8?B?Uml3cTBNVmtLYVhtN0xNNWZtelFXSWJ1RGdKU05SL1pwRnk3Y1Fpd3UrMDZB?=
 =?utf-8?B?bjhpWFFoVHFma3lVVTJWN2JDdmRya210dDZTOTJYV3A0ZVU3RDJ0elZ3L1hF?=
 =?utf-8?B?eEZkK2JQYmVYUXZRZGdmWUo0dXJWUFduRUxNd3BJUEkrN1J5eElwaDh5OVp1?=
 =?utf-8?B?V0tMMFM5cElBWTB2aTNoZ2tpR0poMjNvdzRvUU1wMllDOXdqZEsraW54UHk4?=
 =?utf-8?B?Y1Vmbi9uM0gxMXhTTXR5RVdid29USkFrbXQ1MmJoWk16bGRiV2x3Tmt3ZzV4?=
 =?utf-8?B?UXBWa0V4MGh1cmNGWUpzZGpvd1A0TEl4Z1pPM0Y5eUNLRDE4VGs5R1FVMGlj?=
 =?utf-8?B?YU9RQytiUGdWdk5WR3g5bGk5a1hKWmRIa1d5dVh3TWdYTUkvZ0FKUExWMUpZ?=
 =?utf-8?B?Q1ZrVmlMUHBySUhzdnA0S0h2RUZOYm96MzV1NzYycHB6a2p3c3dOcG9FaGJ6?=
 =?utf-8?B?VDY5dkxBUktzNjRaOTBHckRYT2pOMFRVSHBSaHNCN2tpN1E1TnNxaFR0K1Na?=
 =?utf-8?B?UXBBN1pzejZzRWl1RWxDcFU2a2hzUFJOZTdhS1YyTzB0TmlFL3BKMFRRTUw5?=
 =?utf-8?B?S1d3b0hndnV6RW9zTWNSVlVwSzdIWGpEc3BHS0JWRkh2RVBNd3FZTjYvVzNh?=
 =?utf-8?B?Z1IzV0VMOGNteUEzOHgxYTk4YkxneUxzVGhRT3hwZy82c1ltaWxlaTdqdy93?=
 =?utf-8?Q?v37MFtVEdWogBX5KpSg30W+oUgTgdegjNhiz/VWtd8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cf1fa4-0b73-42e5-91d6-08da03905410
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 18:52:44.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lrlwf459qrkZNdFxM1emZgzvs1SdxWJ52zUJIYr+iXgCJnUvNQm10xazuvP+wZPjoSUTGWPgr9YsZ5Wmw6WiPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/11/2022 10:05, Rafael J. Wysocki wrote:
> On Thu, Mar 10, 2022 at 9:13 PM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
>>
>> [Public]
>>
>>>> To fix these situations explicitly check that the ACPI device has a GPE
>>>> allowing the device to generate wakeup signals handled by the platform
>>>> in `acpi_pci_bridge_d3`.
>>>
>>> Which may be orthogonal to the _S0W return value mentioned above.
>>>
>>> Also, I'm not quite sure why acpi_pci_bridge_d3() should require the
>>> root port to have a wake GPE associated with it as an indication that
>>> the hierarchy below it can be put into D3cold.
>>
>> The reason that brought me down the path in this patch was actually
>> acpi_dev_pm_get_state.  _S0W isn't actually evaluated unless
>> adev->wakeup.flags.valid is set.
> 
> That's true, but it is unclear how this is related to whether or not a
> given PCIe port can handle D3cold.  But see below.
> 
>>
>>>
>>>>
>>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>>> index a42dbf448860..9f8f55ed09d9 100644
>>>> --- a/drivers/pci/pci-acpi.c
>>>> +++ b/drivers/pci/pci-acpi.c
>>>> @@ -999,6 +999,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>>>          if (!adev)
>>>>                  return false;
>>>>
>>>> +       if (!adev->wakeup.flags.valid)
>>>> +               return false;
>>>
>>> Minor nit: the two checks above could be combined.
>>
>> OK if we stick to this approach I'll do that.
>>
>>>
>>> Also I would add a comment explaining why exactly wakeup.flags.valid
>>> is checked here, because I can imagine a case in which the wakeup
>>> signaling capability is irrelevant for whether or not the given port
>>> can handle D3cold.
>>
>> Specifically a case that it's a hotplug bridge that has HotPlugSupportInD3
>> though?  In practice I've only seen that in use on USB4 and Thunderbolt
>> bridges "so far".
>>
>> I haven't tried yet but I would think directly evaluating _S0W at this time
>> seems it should also work and would match closer to my original intent
>> of the patch.  Would you prefer that?
> 
> I guess, but I'm not sure, that you are trying to kind of validate
> HotPlugSupportInD3 by checking if the root port in question actually
> can signal wakeup via ACPI and if it cannot, assume that the flag was
> set by mistake and so the bridge should not be assumed to be able to
> handle D3cold.
> 
> That is not unreasonable, but in that case you need to check
> wakeup.flags.valid first and then _S0W too, because it can return 0
> even if the "valid" flag is set.  And explain in a comment why this is
> done.

OK I'll make these changes and check the situation again.

> 
>>>
>>>> +
>>>>          if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
>>>>                                     ACPI_TYPE_INTEGER, &obj) < 0)
>>>>                  return false;
>>>> --

