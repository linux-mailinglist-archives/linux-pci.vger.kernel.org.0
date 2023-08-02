Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B18276C36B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 05:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjHBDRV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 23:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjHBDRT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 23:17:19 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D683EFB;
        Tue,  1 Aug 2023 20:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiuAQNrXSoGzqjHXiYWfkzaSioqeLyJoM7stXeXf2Niw7iVVRy/RLk2AFBo7MGg/MCe7UKiiLKd2b4izlPQWTIrr1aVKFJ+MIjRbqX/QJOT/caW8d3Qj49X2kHat8+T4kSCrfT5Ms0jbGSJGk/OFi5ImthzGUu8cvm6xiNNzX+3KKDaRq4EWfoixD+a2UV0JARPwMM0aQ6If2tyMlyTMmIkq5WGsmgvXdDgO7aWo11XUWfkltnxtxG/iof0vjpfeyipZd64sQolLwwuDIZuHXYjMOGrBMzwQfN7s3HYuhppxTnIkyNW4ZsFDF+2qM6EmFsytYhWozcatjeqpsUx0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duzsVjeQO+39vn69ReK95ABtk7tdepps2LZAFIp2e6k=;
 b=P21e13OiSlZtGzbEEzTmx20awNQKDdD3AvC/xPsdRpDBmqvpXtQYWnqekc+U4EtgbKfpt7PKEwuKn6pSSGWDY0pNHIG8BCB3TX/+EtVwY7RWBjVQulaB9tdPgZbzby0U4tgIz3RtLM/wVCACeX46OPuzj02of5GoFUzizyUTVZAFCONBqwvf4CR/EWEl45/5utEJpZYZI26amRBhabW+iEzGAIB7BzXpiCFIzamju3/6pIJB4l1oo7xW4CbWeJZ1+/2JYlHkMcE8jWhWM/BY14R1WpcR6g4k4dg6dh8+uzPjyZuBip60bOap/fX/XK7DQtdo/vrwnt1CBoc4bKbtOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duzsVjeQO+39vn69ReK95ABtk7tdepps2LZAFIp2e6k=;
 b=XiruNOyReQfcSvJ8wvwIqXuK0oTxE3mzn8lSyY3nsyMlbeF3OGnZjW2Ny0KEJLeBGs+NXY2IJtbfPsgF7JRyJGEBeihuydkz1bkfcMwosmbCSnCxJMR64UR6isJuhZSaR1I78+rWBsdcK1Zl/PkHVRXn/kU56We0Q3R+UU2UEJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Wed, 2 Aug
 2023 03:17:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 03:17:14 +0000
Message-ID: <d1b2cf1b-de5f-6c2e-c8dc-fdf60cd0882d@amd.com>
Date:   Tue, 1 Aug 2023 22:17:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230711221427.GA250962@bhelgaas>
 <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
 <CAJZ5v0i6PviqW7u3i8hmvSCvR_VHqP-mWRy3Da8Ev_1vi9qBQA@mail.gmail.com>
 <a309e3fe-b1f9-e269-cb97-8af87c8d483b@amd.com>
 <CAJZ5v0jvxrDMR6YHFpYZ4yYpp82-3TtrH==SMRFtUMJsv7=i=g@mail.gmail.com>
 <37b005d5-68fb-f8dd-67e2-c953d677fca2@amd.com>
 <8298c01c-abec-914b-0542-459f38c635fe@amd.com>
 <CAJZ5v0i3g0JujMwikB8niRZ93hXJZqWtjrCjbaDmkMLUbMmwMA@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0i3g0JujMwikB8niRZ93hXJZqWtjrCjbaDmkMLUbMmwMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:806:a7::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e43aa53-01b0-4e3c-2e9a-08db9306f7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1VzDVMNykSPnou8JGblArlqFkx8YwUG7hq+1gzkNWQzuae61hQ150osI46qkyHMWXVZ7i1AzQKN0X96KLduV71oour6DZwz20x8aIjQVKzuzq++pMRuO4dBc/0ZgSUrWyOBAwQmPGevjhreTw/FEKYN8V6axPv4ZGqAhH20Zis6n5qT359DOFmBRCiGAI3eMM7fJfYYsE8tu8RKRikB1mYeTqo7XFRvu/Noz6rGMnjKjSrEZPzw9uz3X4BGyh+aMwXWDOrOrJEHDFGgpiJd5LPG98XIXW5k5dx9vJeSDL3Ub2ukhuW4sjSDdhm6m1bx53RYbcuiw4qTpaCi/rZuUD6qynpqvrnm1M3F0xXTpcOrL8vaMpE/bp6v3mRnxzf7hJstSyJgUP82cH+cro+uBkrwoQqLxPt0scY3kMxp7/0Wiq+grt8pM3niUyi0hIZvFiWBh4Ej2lPX+vUeIOZcJcJEzMqSJOrov68Tvl2Wuwoo+pBC300AnH4rLGxxhKazojyZXZsEMXFnTOItMDzksetAF5neHSPJF4U+B0X6hXMARqMUv6+RVB8GVkgPzVUomMnlj8wSdTc/qdkMSw8VL8inGmWRJJQsq7n2NOi2eIzqDIdWbuTACLPIIJKmr+OpXrwjsfJnzqbFSVcJQAcFCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(7416002)(38100700002)(6506007)(5660300002)(19627235002)(4326008)(53546011)(110136005)(66476007)(66946007)(66556008)(54906003)(6512007)(478600001)(2906002)(2616005)(8936002)(8676002)(6486002)(41300700001)(36756003)(31686004)(31696002)(186003)(316002)(86362001)(6666004)(44832011)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXN6NWFTSXNiUm8rdVZUL1ZqT0EvZ0E4VjVrZnFGTHc5WndaOFhscFRYOGR4?=
 =?utf-8?B?QnpaS1M3YndVWmhadXNpdmNUaTVtV0xhMlBIbjF0TlhBS01icVI2MEVQOGZS?=
 =?utf-8?B?RmlneG44U3liaFJ2RVk0Y1VHN0NBU21pWlFTRXRPdjExdDF2YUxiSk8vUWM4?=
 =?utf-8?B?eGRTRFZ4WkZ6Nmp3QVdYRGJSbUZyVzVMcUQ2ZWYwaG5ZR1RVNExzVENOZW5M?=
 =?utf-8?B?a3dLTkFYc0hTR0wrZTlZU1VjaUt3Uld2a09WNWFUM1cxamhtRXJLNE43MUJW?=
 =?utf-8?B?T2ptSVE3TVdnYWo3TkVranhoVllQTHpEb1pRTktBS21FVDBWeHlGOGhWSnEr?=
 =?utf-8?B?bGRIVzJOOC9hdERHWE9obFVBRi9ZVjR4YUJON3hGK2FXdGdDeGdiZlp0aitw?=
 =?utf-8?B?bUdXcFNMZ2JWdUgzRG54RE4rVjRPOE1rVHQ5SWtsa3o1OU1QcnpSSElvajNP?=
 =?utf-8?B?YlNMTmtSN1JFYjZET2l4aHRMUTVPeGMyc0RpeGE5clh3V2t2NVl0YXdKaWFs?=
 =?utf-8?B?R2RnbkUwaEtNcTVLS08zRXBsOE1FanhlbktuaC9GNUFHLzFpUzBIOVIrYUxW?=
 =?utf-8?B?L2JSam56ZWNBN0EyWGVBTUJLMG5iY1ZyRElrRUFFV2VkRmR4VDJ5Rno4MVhU?=
 =?utf-8?B?T2p2UnJDZGpCYlQ4cnZ4MzBiK1VGTHNualNscGNKQ01OY2ZnZVliVkxtR0xz?=
 =?utf-8?B?NlBTYzFVS29PeXlyTHlTK2RPa3UwRWI0TzZXR1hUL2FXYnFaSnJDLyswY3Jz?=
 =?utf-8?B?ZTQ5YnpzUkFDQVdDZWVzVDJ2RnhKcFhjSE8wTVRHM0FpSTJKSkh1dE9MUzgz?=
 =?utf-8?B?NXlUTTJtSXNqRitJYllhYWdHV0FjQVpXdTdYLzFkSk9neGFUUklTTnhURndL?=
 =?utf-8?B?Rk9KUzkwSkh5cFV2YTdiVXYvK3JVU2sycTA2SEs5Qk1hV0NNMkF3elo4aVc0?=
 =?utf-8?B?NkJBNTJCNWhGN1c2RGo4N21WeTJhblFzenVYTnFzM2o0eEwvV0MrNnR1S01F?=
 =?utf-8?B?Sk02b2tFTTZtZ1QyN2V1bkRYMnpCbXQ1cHNUWGgzMDlkVjNLTUhnK0VWNlZY?=
 =?utf-8?B?OUtndlFCZjNJVXRCSlF4bVR0WGRxTlJVaGo1aWFlZTNETytobnpxWTVXQ3U4?=
 =?utf-8?B?dlByY2hZTS9pMHpDZkc0NkhQRUIxVCtKS1E0Z3RySGErVVN6bk9tL0FMeklX?=
 =?utf-8?B?WFplR3REZThYY1JxOFUvQ1R4Ri9qMXVUdjluM3NGMzZHcmFCeE0vV3YvNm05?=
 =?utf-8?B?QThCbkUwa0tGa2FZc0MwSXFPdmk0OVVmSE9KaEZIbVNTQmQrOHZ4SHpaWWVW?=
 =?utf-8?B?NW5WUjFBK3hzQ2FOWTl1S3h4a1Q0RHY1N0VpdVpCdTlmUHVkcDE3aHEvcXl6?=
 =?utf-8?B?SnIxSTBENWNQNHZabDBYYk54eldPcFZFWnBoT2t4a2xHbWdRYXNkNVhjaytp?=
 =?utf-8?B?S3JNRVpBbUo3RHRtaUE2Vy93MUFzN3VrRG9oNU5jWS9nZkR2U2d4bXk1N2Rq?=
 =?utf-8?B?d2JnRzBRVEI4eVRQS3VRTi8rUitzMDUxVGlvYU9jVlNZejBWZFp5UnhyV3V3?=
 =?utf-8?B?L09Sd1dtMnlJM3I1YXpoeHQ4K2ZMUUlaMmdKenFES0xIeDM1Wmd2NVo1aDJu?=
 =?utf-8?B?TmdQazhQczc2R0MwQi9SYUxvY2c5OXhOcE92VlBHcFh4SDgzaHRXSmV1TnNS?=
 =?utf-8?B?Z1pmaHdjaDZ6STdDT2F6elk4U3ZqL3ROWE9mWS8zV0hHNUh0SEhkbjBDSzdD?=
 =?utf-8?B?WHpOT05hVmhDaE4rOGJyMll5NVoxWXR5cFVXdnkyLzcrMlo4NE1xVTA2UkY2?=
 =?utf-8?B?dmlJWXJKSE95YmF2ajF0bkQzR3FBbjB2VXRub3dEc04wVzhSZkN3ZEZkQ1Ji?=
 =?utf-8?B?UWtIQkk3NXM0dUVncDN6dWFvZjdWaUw5UUhwWXU1WEhoS2VqdVJZcGJQakZF?=
 =?utf-8?B?UmdvbzNHZmVGOVFKTDJRSmlDTGJQd0RVWkl3NHc3aEtob0tmNldZaG5ZeThx?=
 =?utf-8?B?Y0VoY2ZESG14QXFZMmd3elQvZzFYZURyblpzZXYvTlJyQ2MwZFRpTUhraXYr?=
 =?utf-8?B?NGtkRWk4eHBmN0ZFNUd0dGJlWHlEZkxWYjBXOGo1WXRVaDd3bDVlM2s1KzFP?=
 =?utf-8?B?dEpKSklENzFVNzhYc1cvWXJCR0pBNlFXUzg3c3NNQ3cyMzNYc0NnOWtodkEy?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e43aa53-01b0-4e3c-2e9a-08db9306f7be
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 03:17:13.9962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYHspxv75602fRChkja993A/rAfN3gYY1vfbgd0cmrUE6tvPw0hJ8+5+BIj8Ax+TUZmYJ70lCh449rXhesTUIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/1/23 05:15, Rafael J. Wysocki wrote:
> On Tue, Aug 1, 2023 at 5:25 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 7/14/23 19:46, Limonciello, Mario wrote:
>>>
>>> On 7/14/2023 2:17 PM, Rafael J. Wysocki wrote:
>>>>>> Generally speaking, pci_bridge_d3_possible() is there to prevent
>>>>>> bridges (and PCIe ports in particular) from being put into D3hot/cold
>>>>>> if there are reasons to believe that it may not work.
>>>>>> acpi_pci_bridge_d3() is part of that.
>>>>>>
>>>>>> Even if it returns 'true', the _SxD/_SxW check should still be applied
>>>>>> via pci_target_state() to determine whether or not the firmware allows
>>>>>> this particular bridge to go into D3hot/cold.  So arguably, the _SxW
>>>>>> check in acpi_pci_bridge_d3() should not be necessary and if it makes
>>>>>> any functional difference, there is a bug somewhere else.
>>>>> But only if it was power manageable would the _SxD/_SxW check be
>>>>> applied.  This issue is around the branch of pci_target_state() where
>>>>> it's not power manageable and so it uses PME or it falls back to D3hot.
>>>> Well, this looks like a spec interpretation difference.
>>>>
>>>> We thought that _SxD/_SxW would only be relevant for devices with ACPI
>>>> PM support, but the firmware people seem to think that those objects
>>>> are also relevant for PCI devices that don't have ACPI PM support
>>>> (because those devices are still power-manageable via PMCSR).  If
>>>> Windows agrees with that viewpoint, we'll need to adjust, but not
>>>> through adding _SxW checks in random places.
>>> I think that depends upon how you want to handle the lack of _S0W.
>>>
>>> On these problematic devices there is no _S0W under the PCIe
>>> root port.  As I said; Windows puts them into D0 in this case though.
>>>
>>> So acpi_dev_power_state_for_wake should return ACPI_STATE_UNKNOWN.
>>>
>>> Can you suggest where you think adding a acpi_dev_power_state_for_wake()
>>> does make sense?
>>>
>>> Two areas that I think would work would be in: pci_pm_suspend_noirq()
>>> (to avoid calling pci_prepare_to_sleep)
>>>
>>> or
>>>
>>> directly in pci_prepare_to_sleep() to check that value in lieu of
>>> pci_target_state().
>>>
>>
>> Rafael,
>>
>> Did you have any more thoughts on this?
> 
> Reportedly, if there are no ACPI power management objects associated
> with a Root Port, Windows will always leave it in D0.
> 
> In that case, acpi_pci_bridge_d3() will return false unless the
> HotPlugSupportInD3 property is present AFAICS, so the ACPI code will
> not allow the port to be put into D3hot.
> 
> Consequently, platform_pci_bridge_d3() will return false and the only
> thing that may allow the port to go into D0 is the dmi_get_bios_year()
> check at the end of pci_bridge_d3_possible().
> 
> However, that was added, because there are Intel platforms on which
> Root Ports need to be programmed into D3hot on suspend (which allows
> the whole platform to reduce power significantly) and there are no
> ACPI device power management objects associated with them (Mika should
> know the gory details related to this).  It looks like under Windows
> the additional power reduction would not be possible on those systems,
> but that would be a problem, wouldn't it?
> 

I've been thinking on this today, and I at least have a hypothesis about 
this behavior.  Perhaps Windows is actually utilizing enabled PEP 
constraints to enforce what state device should be put into over Modern 
Standby cycles in the absence of ACPI objects.

In the case of one of my problematic system the PEP constraints for the 
root port are:

Package (0x04)
{
	0x00,
	"\\_SB.PCI0.GP17",
	0x00,
	0x00
},

That first 0x00 means the constraint isn't actually enabled for the root 
port.

Mika,

Could you get an acpidump from one of these problematic Intel systems so 
we can check the PEP constraints to see if this theory works? Or maybe 
you have some other ideas why this is different?

> So it looks like there are some systems on which programming Root
> Ports into D3hot is needed to achieve additional power reduction of
> the platform and there are systems on which programming Root Ports
> into D3hot breaks things and there are no ACPI power management
> objects associated with these Root Ports in both cases.
> 
> The only way to make progress that I can think about right now is to
> limit the dmi_get_bios_year() check at the end of
> pci_bridge_d3_possible() to Intel platforms.

Yeah if we can't come up with a method that works for both this might be 
the only real option.
