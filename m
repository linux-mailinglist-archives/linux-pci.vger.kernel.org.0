Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C465B5350
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 06:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiILElq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 00:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiILElp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 00:41:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1660225EA5
        for <linux-pci@vger.kernel.org>; Sun, 11 Sep 2022 21:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIUHqin1MUOlb9PSvEAxHZkmmQsnMVSKJUaRXs4CGNvbKH6RcIZEky2CCkUJoHnu19BND0cH6N0YUJHRZ9WupdtFkpba32HHV4EKhA6tPWA0L91rJw3fzAdJXCV3Gd+AuvgxdUBjkwd3SsgOjhH61lLhMQJ8I0Xw7MbN1N9iJJ5MMFsnlZXKsaYW0a/vNvQrehW6GLNDTUxxSAOVAKlV+Vjt4oVNEl/H1dOOwusc4g5tYJomLXcDQwuFdL8830Is9kSWmGQ1Hr/rd6gPjAyy49IXGrkb3B6GF30YJ4zP3jmpN4+0afLSPfX/hDTG2IWfl2nR5w8ZemMhdYxx12ja/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kTLgpbYazRtz+hKbCO+n+fJKoXwxEyEb8PtkM7EqkE=;
 b=fLCRWrDKjK3LUWMjJxZ1yiO75b0uUaQxAiWfscYOcG6ToI4TPNx1KIIkbN0+/tKAzNM1uR9x2jQZ1OLZLzh4u4XiiDxmoZ2W1ErPhXo3P9jvhzFKiyZXL5LU+UJKbgn3ADIecJTc507DlOXAXH2KSkmq/JmLTABdlSPLsZjt7Rt4yuGIPRzkUlGqmmGXEjKFbOvAmIODOxj0BEQRZ9/60HyW+AZjWiXnN88/m+QBOVPTufESwvH1fpHbjMkkn5egOmtU+4GXBg3iBB+9EFr4KCyFQbkN0f3Wj3N4vC66aSkrS3azROJlTdSrGOHYrKfqJPRlw4YA7BvjaKzJ+rq3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kTLgpbYazRtz+hKbCO+n+fJKoXwxEyEb8PtkM7EqkE=;
 b=xoRIoBxLaGBB5/Jalw+YARlrCEfSwaPZTI9JD7ESFyNcnnChRGyqCVsHSqrhPCPtxptcuq3uJeBJNeFuZbLfiJO11Qw/xmchlpB+LXZy6T8ODvJgj+ttaCF2H9Je+94VsAEqa9pdgy50AVb/i8WixqApwYTL1u5JFgVzu50UG2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ0PR12MB5472.namprd12.prod.outlook.com (2603:10b6:a03:3bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 04:41:35 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 04:41:35 +0000
Message-ID: <e5465d4b-21c7-e450-7eb4-9b92641b5b7b@amd.com>
Date:   Mon, 12 Sep 2022 10:11:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/7] drm/amdgpu: move nbio remap_hdp_registers() to gmc9
 code
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, helgaas@kernel.org,
        regressions@lists.linux.dev, airlied@linux.ie,
        linux-pci@vger.kernel.org, m.seyfarth@gmail.com,
        tseewald@gmail.com, kai.heng.feng@canonical.com, daniel@ffwll.ch,
        sr@denx.de
References: <20220909164758.5632-1-alexander.deucher@amd.com>
 <20220909164758.5632-2-alexander.deucher@amd.com>
 <4f9441e7-6ca3-25a6-6dd3-644b211d3fcc@amd.com>
 <CADnq5_OKQwXDP-730jCXFCe60AbvzLrDvyr=dVr91awEwLNWjw@mail.gmail.com>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_OKQwXDP-730jCXFCe60AbvzLrDvyr=dVr91awEwLNWjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ0PR12MB5472:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b8d5e2-beec-4766-09b1-08da9479123a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mhng4+zc/4aTiwY3V5DKn7VxJaP9dTdnhKDFBMzyPrOWuavMnUtA9YuTXxREVxtVgFNy8LgZjo44vfcpjIdqVDVrxkBKE5ikD7RO5paHNzZOXQWGK7wDTtkt/on6e4S73pC15EqAcprSGybwDpYVHh8yh/MpvK1OTt2fJ+MGdMFM7E0tzUpjjMHtAGPQiKMwks/qZBvBz2CXGNk52cUHcP2qMjV9w4jjUQ+cN8KAb22nE0Z40PweP/lPopXt8hh0SDPdGtIIu+nu4KXKI7jXTwLyQRVK9ATBkFzsznbAQA13zy0lZUcgGdNAvB3yO04RPDQ8ZOoaQwChWwhdNgPFPAfnOCj4zVNfDCql5YEU4P1VsF7L2QvNjebtGm9svt8UBe1hPJLUsgVpT+Y1mWTfoxGx2fMo1sPETJOd41WaDR8e7zsL9wo/L3yql/Yr6Ivr4m+nh7+8+LtLlTBYsgc3Lncuv9UjD+c5SP+V6Xz2yBYYJSScFDgpIDoCIC9EK3Ik407JF5OyoJfjuhOoRRs63YxnqFBdtzCQhCRiP7Yvpz/AkqfEgzlrqjCx+TGuHJIj4jB15by4SZLOdBaB/OlDdlwEsTftTYDpvXx/ormWtIW7ICT8gQFDwM+QgcQxNp4Mh6A/qalOA8/Or/hu21qKfLCYlxQqSt8uNnix5sqsCeP0Id/2i5sI2wblIhmE9uLnpXDZ4XMe8aoekbrrnnlXt9CPOgTKpeI+2lpbhs1f9xqphr3NZVtVLxvb3/Obn0MP9+O7PSrb8Ce2yOO8QUqgVO6mpA8PCg/+x3Iy4bKUCv4x+Yh4+dLpVrh49vGo4rzj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(6666004)(45080400002)(41300700001)(31696002)(966005)(478600001)(86362001)(6486002)(6916009)(316002)(83380400001)(38100700002)(53546011)(6512007)(26005)(6506007)(2616005)(186003)(2906002)(7416002)(5660300002)(66946007)(8676002)(8936002)(66556008)(4326008)(36756003)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWx1SVBYcTlwS0hvSERXOTV1SXhoRXU3SHBDd0FMN1FUcm9hbEJ5SmxyYXpi?=
 =?utf-8?B?djBWQlEvQkNITEJoNStiOFVGZStPMjAwR0gzRXExV2JxR1NIMzFmWEE5TlZU?=
 =?utf-8?B?L1V4RzVlWGh1OXJhamRXWTdlTENsUG1Kbkl5MW9VdDM5cHdwdVJPT1dJZ2Jr?=
 =?utf-8?B?L3RNQU9tam9VYk1pV3pCYlcyUU1wYXc5SlM3c0d2cTNOU3BxNC9NQ0dJY2FY?=
 =?utf-8?B?anlwVFdOWk14ejNkT1VQOXh4bmlwUno0QVowZUNwSUt1ZXpDUm5meURoWDM0?=
 =?utf-8?B?QTg4dlNTS3k0U1QwMXdZQVFrcmdiVmgzVnRkbStobVhEbEh1TFJBT0JZQlJK?=
 =?utf-8?B?R240VFFMN1JlWVc3RzBhVXE3TU02R1RETWZvRGRmS0FQWmZpUHdLTE1wcUhm?=
 =?utf-8?B?b3hIUk9HZUVieWlwNzhJQmJBMHU1Z0ZSSVZGbEdjVHhxZWJUVkRMVWxqVGg5?=
 =?utf-8?B?WW1vVFhnNmdJclVZOS9kb3lvQU9VUUdrSVpQdEp6Skh1ei8ySjJvR2ZnT3Ar?=
 =?utf-8?B?TXVDUEVma0dxdlZOYXcyM0o3RmpudGI1Ujk5QWdXdUFZL3dzdTViZTQ1WlRV?=
 =?utf-8?B?dW5yYzMvMU94c3VjQ3d3RzY1c1BoUFE5bnZmMXpVZC93eHdoYVRPRVRBci8y?=
 =?utf-8?B?Nzhic3FZS0ZSbEg2RHBjc3hqRGdhbkFsWGFOMEJ1ZzBlUGViek1kN3gxVDBh?=
 =?utf-8?B?RjNuMTJQNkJoT2J0Zy9ZdThUZlN0ei9hK1ZZcldrcVdPVlY5ejlCYk9PRjI2?=
 =?utf-8?B?TG5aRmF2di96Nm13T0hKRUNQZEE5aHQrM2xsQ3kxU0xJaGV2azk2dzNQK1ZM?=
 =?utf-8?B?SWNTSDFLUmdWODkyTzMzTUdxMHNqS3pweHU4NTNPWkpqcXBQTGE4VEN1MHF0?=
 =?utf-8?B?MGlIZ0pmaHM0MTBjSEF4M1V5TjJPL0IwT1pnUzE5a0x3QU5oNDRuVlA0UHVN?=
 =?utf-8?B?OUNWMFdWQXV0by90bXMzZGk2Uk5MRFQwU2NOeGQ1dllFMmI0bDNJRTVZYkVQ?=
 =?utf-8?B?ZzMzcGNzNCtnbVh2dHZvUG9MdXR4TDJhUVdGcithUXlrNjkvZk5XVzVLL2NF?=
 =?utf-8?B?RFFMcTJWVHJGVDZwaEpjdGpSQzNwNUZzQ2tFU3Nnb1VxT2d1SWc3NVpFcm92?=
 =?utf-8?B?UlBIcmVOTTNHOThhaTdSWWFWQUlQTUk4SXIyYnArOSsvcDMyV3NEbjk5U1N1?=
 =?utf-8?B?SDRDdUVxZk5uRnV6VmtvK2pJT0xOVFRPbmVoUVQxcGVNRVZ2NVpBUUl4TXpD?=
 =?utf-8?B?bEllU1pUZlVDeHJIeGd4Q0ZPY3FVWmlQejB1cXBYdUp2ZWd6cFg0T0dtbGVM?=
 =?utf-8?B?ajFFaitWMHhaRWxGbVBnRmZLMi9NVzV6T0syTFM0Slc4TXZ5dmVHeUpMcDg0?=
 =?utf-8?B?UTdBcGl0TjIvZmdJU3hTaThFdGJHcFdSZVNZZ0pONm9sMmpBSlZiTjJZaDN6?=
 =?utf-8?B?VFo0N2tvNjRmYXQvekdjWWZKOWRVdnI0YWFHT0RiWTFMMzJ1VlRHQWpuOGJV?=
 =?utf-8?B?OEJQNFNvRjlYenRDQW9na0F2b1Q0bFlwSGtIVlB2YTNGT3FuVUZvZThJY3Ev?=
 =?utf-8?B?bnRtdE4vMFFWbEtIL29BTklycGt1SXYwdGovZ2dQRTE2V0RoNDY1UWZZL3VW?=
 =?utf-8?B?MkUxcGRucjJNVHNJVk14eTgrU0NSbkpTQjZhd1Q0elVyanlxR1ZVM2dZbE5T?=
 =?utf-8?B?bWJTQmJWTldMVW4vYS9YcFZQRnhFRTNVVmlIQ1l0R3g2UlVsdW1oZ1ZxcDZI?=
 =?utf-8?B?ekxPblowaHJVRUkvYVREY0JLbnNoTFEwUEJqOEl0ZXY4NUdqcFRpNmxTV01S?=
 =?utf-8?B?L0VDZm1uRytVVHcyNk9HWDFuTDh5dFF4c1A5MVovRFNGNHZHZEtjZnEvbjJS?=
 =?utf-8?B?R0FRWjRTa0VDaGkwWDM0MTdxWDdJbEgzcU5SUVVSNCs2NlFscGptZlNKRGJN?=
 =?utf-8?B?U3pyd1hPVitybWtRaCttSEdTSWppUnZYcE5ONFYwcWwyVXE3a3FnMW40OEZH?=
 =?utf-8?B?eHJWcU15d2NnZEhYSWxPSWFpZVd1UGZ2RzFXRzhvVjZuUzdNR0lNWmd5a0pO?=
 =?utf-8?B?b3hqQUUvMXBNbjhPVzBHSCtEaXZ6NENzMkl1RTFFeWlvWUpVVVVIbFBpTTVO?=
 =?utf-8?Q?2CocPIZmjM5ApBQ+yLnHfCrJL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b8d5e2-beec-4766-09b1-08da9479123a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 04:41:34.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QANR9ttiFXjjiXBtWTrRwLg/oZ39tZ1z2MhYNGdwq3ss/gdKw5BWw+FXbZFP1e5N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5472
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/9/2022 11:05 PM, Alex Deucher wrote:
> On Fri, Sep 9, 2022 at 1:17 PM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 9/9/2022 10:17 PM, Alex Deucher wrote:
>>> This is where it is used, so move it into gmc init so
>>
>> It's only the *side effect* of GMC IP init process, but that doesn't
>> mean these IPs are interlinked. Any IP init process which requires HDP
>> flush also would need this. It is not a good idea to couple HDP remap
>> with GMC especially when there exists a HDP data path way without
>> setting up GMC (MM INDEX/DATA).
> 
> We have no need for HDP flush at all without vram, and we only have
> access to vram once GMC is initialized so it is sort of a dependency
> in that regard.  We also call a bunch of the HDP callbacks in the GMC
> code and I think those are sort of the boat.  Also, the whole reason
> we are in this situation is because we need to init GMC before all
> other HW because all other hardware has a dependency on being able to
> access GPU memory.
> 

We do have early VRAM access usecases over HDP to fixed offsets for 
discovery region, 2-stage memory training etc. So far there is no 
requirement for flush, or flush might be happening indirectly because of 
a register access. That doesn't rule out any future requirements for 
explicit HDP flush. Prefer to keep HDP and GMC programming separate.

Thanks,
Lijo

>>
>>   From a generic software perspective, I think programming pre-requisite
>> for HDP flush need to be standalone and the order needs to be guaranteed
>> before any client IPs that make use of it.
> 
> In that case patches 5, 6, 7 could be an alternative.
> 
> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> that it will always be initialized in the right order.
>>> We already do this for other nbio and hdp callbacks so
>>> it's consistent with what we do on other IPs.
>>>
>>> This fixes the Unsupported Request error reported through
>>> AER during driver load. The error happens as a write happens
>>> to the remap offset before real remapping is done.
>>>
>>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216373&amp;data=05%7C01%7Clijo.lazar%40amd.com%7C984f5015c4104040ca1d08da9289c85d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637983417715604666%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=BJL7OWuAlaOzA%2F2G%2BYSzkdtaO3TmYwRK1gAsw26pW1U%3D&amp;reserved=0
>>>
>>> The error was unnoticed before and got visible because of the commit
>>> referenced below. This doesn't fix anything in the commit below, rather
>>> fixes the issue in amdgpu exposed by the commit. The reference is only
>>> to associate this commit with below one so that both go together.
>>>
>>> Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
>>>    drivers/gpu/drm/amd/amdgpu/soc15.c    | 7 -------
>>>    2 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index 4603653916f5..3a4b0a475672 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -1819,6 +1819,13 @@ static int gmc_v9_0_hw_init(void *handle)
>>>        bool value;
>>>        int i, r;
>>>
>>> +     /* remap HDP registers to a hole in mmio space,
>>> +      * for the purpose of expose those registers
>>> +      * to process space
>>> +      */
>>> +     if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
>>> +             adev->nbio.funcs->remap_hdp_registers(adev);
>>> +
>>>        /* The sequence of these two function calls matters.*/
>>>        gmc_v9_0_init_golden_registers(adev);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> index 5188da87428d..39c3c6d65aef 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> @@ -1240,13 +1240,6 @@ static int soc15_common_hw_init(void *handle)
>>>        soc15_program_aspm(adev);
>>>        /* setup nbio registers */
>>>        adev->nbio.funcs->init_registers(adev);
>>> -     /* remap HDP registers to a hole in mmio space,
>>> -      * for the purpose of expose those registers
>>> -      * to process space
>>> -      */
>>> -     if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
>>> -             adev->nbio.funcs->remap_hdp_registers(adev);
>>> -
>>>        /* enable the doorbell aperture */
>>>        soc15_enable_doorbell_aperture(adev, true);
>>>        /* HW doorbell routing policy: doorbell writing not
>>>
