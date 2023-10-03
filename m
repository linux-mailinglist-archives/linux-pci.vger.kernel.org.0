Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF1D7B7122
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 20:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbjJCShp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240806AbjJCShp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 14:37:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB4483;
        Tue,  3 Oct 2023 11:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMvsA2cUSiD1fzwYuCBzGC8g+exv74HaWkAoFe2qJJ06anxOUiuamX/V8h/E9JbznFVFjwkGkHyKn2Nvm4S+agra+xu0ZheEaByQi6rBGZWmUwTqW1kH49kled4ZdAm46+F2wT56yKrc0tn9pM/0sgJw+dAy6rRg0+hAmaWrbPGZ7aVykvqnyqLiX3FoUivpDqD2E6tWsukReIjljPANUcK08BjIWhL/hie2Z43pCj3Loz4sE9WIOzVo95PzTB9HeW+jGXB6SUE1SKhb8iy821cfjjm0eBbywS5fpIXbAypMFY9rw0ibUc5OVA6W+7ysv+P+SAzYNXys3BAdsed4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVytqW67l3oFLBbIQgcw0fUsCaktBDrNrtTc5JYZUMw=;
 b=lMIkPDDBW39leAcZ3OEju3D6o17/ThFhhy/9b0/VSKAwiuspe+t+vT2mobV0FvYFPmkKRAX57466U/WgZoACD/3+76vs4bMANLMflBhIuPikhiTgQoPLMsk8MpDvgoFbDqaAJWtiC9V5oSsWwTrCYxpMtMXN9ZUdm7CowkMtqmTUIwqaVaHXLZjiayHl8H/JAbVFS7PSKIF9/MeCbnbT+//NLK2ndc6VsLaEdaKa1VrokHZ1Z+w7652bIOTtk+BGLi0pkdbO0S5sbI/2xFbMsV/JIlFoe9TbYXp0Fu5w1KvWk0KyMVI1HVMBQea6gdqFmn/pcMEFlwsc75YI+ICr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVytqW67l3oFLBbIQgcw0fUsCaktBDrNrtTc5JYZUMw=;
 b=KRBuijibEgwzqJxe69hHb1dVpZx+VG0g58UCYaK9Bt/7ol1cT2S3RAzzu0w5C6THcc/plTyVlo6a1RGvm88jjrrvHA9V5rlRcAHz393LGjrKtPnaZBJmDYP8wdoj0DbbQOYDBHXQpvZJWporfPPQO+nVTJ55kW97W0Dd2VAAFLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 18:37:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 18:37:36 +0000
Message-ID: <ac574884-7568-46c9-87ba-f1555ffe34fa@amd.com>
Date:   Tue, 3 Oct 2023 13:37:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
References: <20231003183123.GA680474@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231003183123.GA680474@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0050.namprd12.prod.outlook.com
 (2603:10b6:802:20::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c7f64a-bc0e-4a61-7d8c-08dbc43fd09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKq2J/ZYXcy/0B6s0iv6aW+2r1Q0BN4uUaG9K6urJePxKBOZZn1UBiLDDjvUy0KdWQUN6DtHu44+nRXjFA6dcC/ICTytATa1tt9gqhXcvG0XpFIn599BrdBP+8pGPvIMF2eXSBCSDAGozOG2hOkZH7V9e0oZ+bTWzutAaIm3AiLMNLlZNvzkqZK1iL1iUlWsDy0cI1GFZJY8YaGiku50SdftFLgymNJ4VKYXhqiBET14vyLIn3BXStEKSz5lmDjvwGmBAjrM2/8YZj+BF9DGgj0nOhhnuNcyde/wEl1jrUgynMj7fMgIXYEkm4bfzC7zgRd1AVde+TSREivrezot1fHQhqSyRLNE26xokghXE8L+95ljXURcrcqO7inV1P65cfhGfzDehyNeE3uFTAOsJs8YAPyDdzqLz44i9/kC4QgBRLr6xNU8QJWNbTZA+3Cn+mDlrnRexmUbCvqCd+Rs6GT/vBE+8FFBoFEe18x6m1CuJ7rjL0FW229PgcK0K79DyCiF5FQV01cuw9W/Kio37wA8S26X0YENq2QbRihFv1i4Lv7HuwGdebTrOQhd48uBk12xx7rU9fXeKEl1x1hMpoF82Uc+JnmJVH00/bFKrWbcJCJnnsc72s8DJOEqq4eOVy7lDSI0nmvKxvok4y8lGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(6486002)(36756003)(2616005)(26005)(83380400001)(6512007)(38100700002)(31696002)(86362001)(53546011)(66476007)(6506007)(15650500001)(8676002)(66556008)(8936002)(41300700001)(4326008)(44832011)(66946007)(7416002)(54906003)(31686004)(2906002)(6916009)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NERVa1RZRnM1RGtKd3lxQnBmaVBiOEFwWXp0R1NpTXlkM2pRMUtTSUY0V3J2?=
 =?utf-8?B?WWYvWXBMTU5Xd0ErZUo5ZVBjNjFZM0RwK3JHcEQ4OS94dVJmVG9tcVZMc1dL?=
 =?utf-8?B?cW9DakNKM0NBZ011Q1lmNEVkemJJWDZMUlNGRkovd3FTZ2JxWmNqaHZGeU5P?=
 =?utf-8?B?V0dwUS9ObHJ6M010b0JQcWRRU3IxdHZrOEgyemlzUUk0VFdFd2pvREZXNjRU?=
 =?utf-8?B?TTdEeHlacDlzNlV4dHlZZnMyY2NxOXJCSmVvUVIrcFN1UmthYUFML1dibTVl?=
 =?utf-8?B?eEhyMU1nTk1tV2lwTWlETmVITVo2TkJONWhOelo3SFR2WGR1WjUraUZHYmNj?=
 =?utf-8?B?SmRVWGttT1ZNd2RkQ1JxWnlYN0xDd1pmWW8wa3RzNjYwY0ZpVDdMcHlPK2tX?=
 =?utf-8?B?Y0RYajFURk40dmR6YmNPMGJobFR6eWpuS245RTBlcHM5Tjl0MnRVOERFaVpL?=
 =?utf-8?B?V2JMWlNrUm55Rk5BblNiQ0tOSVEvUEVacVVGMG9EbXp1KzJzTDFpU1NmQm9j?=
 =?utf-8?B?ejJIaW9wOWpWU2Nyb0Fzd2Vyb0UzU2FXRGxJc01vNVJ4aE92NVo2UlBmYlJr?=
 =?utf-8?B?Sms1dWJVbTl6amdrSmhLR09mVURWWjZSSHBJZERDVUlzMUxSdVIrazNrbVZ4?=
 =?utf-8?B?cXptUUcvUE00VEtMZHhXdi9ld295c1hBTk5WQVYrR01Yd1lSM1Vwa0IvSzlv?=
 =?utf-8?B?ZlpVU2pMcWdTK3pXdG1OU0JHSk0vUXg3YUlmSmVpWVo2VUlqcHgvNGJJZThv?=
 =?utf-8?B?MkJFMVUxdTFDR0ZFQmNkaTVqVUZrRkZVM0czZzFDbm4ybVdkMkVHbUo1NGpi?=
 =?utf-8?B?WjVhdXRWbGRIU0swSm9URkRUMnNoSnpZS3ZBc3E0aUttTWZBZ1dzVjQ2emVi?=
 =?utf-8?B?L3hTNXB2YmdZR1JuL0MyRFRLVGFQaEhSWTkzNXpPMm5URWdnclZXYmczdkdL?=
 =?utf-8?B?QTEvVTV5STQ2a2xueEpLY3E2alNlTVJKNi84UTZQU1laaThxa3RvL3ZmbEhL?=
 =?utf-8?B?L0thdGp4aG1yQmw0TytheWpYa3NGd1FvRk1EY1gxWm0zc0ovejE3N0ZNUlpV?=
 =?utf-8?B?TmFBU1BiNnVHbUpxTkt6OHNQYjkyUTdCeHZsVVZwalUrdTdSZWUyMFlab1Vv?=
 =?utf-8?B?THM2MW5GMWZudTFXb3V2Vkl6aE5zaU13MTFrak50SXA4dURXaTc5TE4yQ0Ey?=
 =?utf-8?B?VHVFNlZ0NXFNNm5RWDZOaGc4Y0pSdzlGV2FCVUNpYlNRbmFTZERKd0E0aGlS?=
 =?utf-8?B?YzhiRms3NWVMMmhZTzFTSlUranFqV3ZSRE9uTHA5ZHNLNE40VFB6eHB1TWFR?=
 =?utf-8?B?R3dKM2JWSkh6QXNWNkQ2ZW5qOGF1UGUrak0yUCsyN0g1T05VS3VTbnZnVHZp?=
 =?utf-8?B?YjV6b29pR2QrUEVBRlByZzA4dmRmYlVBOWs5Z1o1VTRhSzRqUEJHUjY2NGVi?=
 =?utf-8?B?L2tkclc0QzVOZlo2Z1p3TGVXVEc0bGFSSEd0YnptRjFTVHBCV0dKcmJYR3Ur?=
 =?utf-8?B?UTI5WnM3eUs1RjVPRmZBWVNMRXhMZFZSWXRsUzNUTVVvKzExMFhaVkxVcURQ?=
 =?utf-8?B?anRMYktHRys3U0U1SjdsVVhFalQ3RnVsN280TjJVY2JIcXNIV0drN253ekth?=
 =?utf-8?B?MVZSZFl1SVpOTDhyRzVvZFRjMTVNQjFYT0UvZWUwNjA4cEtZQnM0enFzU290?=
 =?utf-8?B?NExUTVU3R3dQVkhvLzR1S3ZoVWZoelVGT1hPbkRFd3I3M1BxZDM4M0tLZHFB?=
 =?utf-8?B?Tk41dVdpREY4M2JkZFBLQkpSUy82bG9mSDBjVVcxSGZvWEdxZ0V2VHpub2pO?=
 =?utf-8?B?U2M5VGhhb1NiaWduclJaOGJXQUhwQWxsb0p6YUlTYkk5VkJZZktUOUZFZGp5?=
 =?utf-8?B?TWtEN0poak82eFExWlZCQ1NWOTF6T2p5Vno1S1F1SCtLNlp6bTJPM0hveWNt?=
 =?utf-8?B?d3VaQUhpTjVQU3RTbEM1VzJDVHc3dkZNdS9LNUtYcFd1YXo0OEdjZlFOWnI3?=
 =?utf-8?B?WlU1eXh2WlliK3FITmx1OUtuMjhNSTduSndndEF5SXlWWC9YTmhwWWxQcFlV?=
 =?utf-8?B?anR3d3ZWaGZuNmNEM1F3RzBjemRxYlVWYVZKZm8yWGhmekpUWkw5YmNvM1pq?=
 =?utf-8?Q?THerUOMJTbAHwdxSwPAu4z8/a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c7f64a-bc0e-4a61-7d8c-08dbc43fd09d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 18:37:36.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92cuk94AV86dIcOOf7+LbYfrMudCRoX4SGT2gaN2yOyT1ILByyDrNKf7HDOBirQJVsgDpAvSLacNo0wdfahETg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/3/2023 13:31, Bjorn Helgaas wrote:
> On Tue, Oct 03, 2023 at 01:06:48PM -0500, Mario Limonciello wrote:
>> On 10/3/2023 12:24, Bjorn Helgaas wrote:
>>> On Mon, Oct 02, 2023 at 01:09:06PM -0500, Mario Limonciello wrote:
>>>> Iain reports that USB devices can't be used to wake a Lenovo Z13 from
>>>> suspend.  This occurs because on some AMD platforms, even though the Root
>>>> Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
>>>> messages and generate wakeup interrupts from those states when amd-pmc has
>>>> put the platform in a hardware sleep state.
>>> ...
> 
>>> Two questions:
>>>
>>>     - PME also doesn't work in D3hot, right?
>>
>> Right.
>>
>> IMO pci_d3cold_*() is poorly named.
>> It's going to prevent D3 on the bridge.
> 
> I agree, that name is super irritating.  I don't even know how to
> figure out or verify that pci_d3cold_disable() also disables D3hot.
> 
>>>     - Is it OK to use D3hot and D3cold if we don't have a wakeup device
>>>       below the Root Port?  I assume that scenario is possible?
>>
>> Yes; it's "fine to do that" if there is no wakeup device below the
>> root port.
>>
>> If a user intentionally turns off power/wakeup for the child devices
>> (which as said before was USB4 and XHCI PCIe devices) then wakeup
>> won't be set.
>>
>> So in this case as the quirk is implemented I expect the root port
>> will be left in D0 even if a user intentionally turns off
>> power/wakeup for the USB4 and XHCI devices.
> 
> Even if users don't intentionally turn off wakeup, there are devices
> like mass storage and NICs without wake-on-LAN that don't require
> wakeup.
> 
> I assume that if there's no downstream device that needs wakeup, this
> quirk means we will keep the Root Port in D0 even though we could
> safely put it in D3hot or D3cold.

Yes that matches my expectation as well.

> 
> That's one thing I liked about the v20 iteration -- instead of
> pci_d3cold_disable(), we changed dev->pme_support, which should mean
> that we only avoid D3hot/D3cold if we need PMEs while in those states,
> so I assumed that we *could* use D3 when we don't need the wakeups.
> 
> Bjorn

If you think it's worth spinning again for this optimization I think a 
device_may_wakeup() check on the root port can achieve the same result 
as the v20 PME solution did, but without the walking of a tree in the quirk.
