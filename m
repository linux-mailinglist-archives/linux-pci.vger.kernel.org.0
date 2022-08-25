Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC495A0B2A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbiHYISk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 04:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiHYISj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 04:18:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EE5A5703
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 01:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhdVNoGJZacexiDY9XjkGzW4xc7J11xPsihyeHu2Qx9tZos1eKoF+IzDksqUQK1HdPv46WgKXfSONanCzzDu981zkVeoE28gH7wOoCDTrxql9yK+DpPl8CsY+cJVQUcbJ6ILWRml0uOk98hxkQ1BffXBut6Fk8KrZBMfbErFX6T2ZvaN/HDWdWK8BXjzoZh/2sjf2NZnGXWXgdaoeO8CDvDacL7qisNHT2j0AHQZQCZ8d8SnWqv9YE6Nt0zvzelI4C4uuylLw43K5rVBVuPJQRsCcfK9QLtiwbRM9ck7gjfHk7FB3dvZpvLwjgu78XOlkDlErO626NkroEMSloa8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zMLPoQttQm1Dlrk0dZy8S+xKRbct2Pmt2ENECprgfY=;
 b=VQ7ruXjY4DnO6QYJ/HnXwPBfQdZI6C4Ka/AVRq8QMxYvXWea2sq1AWwXVbRb2s6WQVNb1YvnMFQRvA59LQXNB7ck/7QZwEwBJeCN2HONFO+Mg0uaRqWGg2mkJFMFybLbsC97LXOcVxxTqAc+g2jp4q7N4t/ZBXjPwjJqPU2S1bQvVRQUL34BPN5XFANbgovT1kgL1gXjKdaSFrgkxhImyfHT01zUW3Wz4ShuCkIIKNLTZM+xOWBl43aGw567cAf3bOtXtMZvo0PA5PtoKGHu0jxc2venzNpFpwNECa7QNo8n30JVMKkzbtDm62SIO6pR8zenay9/sPZJSyNDLpLtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zMLPoQttQm1Dlrk0dZy8S+xKRbct2Pmt2ENECprgfY=;
 b=DFNjd9wmqpWgMAE8XZEBxmYCxfYPxJMtIJ5UHweAtDSKOZvze7hxtmnLPid8QgwIFUpqpqMm+0z5m/4RV1Sx5NUzpUAAbb2w6iHnWZO7YC9ykkp7wNcZkI/3PQpZkCo5JPpVUp8KAuyTUnWu812zFzU0btVVWNB9MJS7B/va1pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Thu, 25 Aug
 2022 08:18:35 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94%7]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:18:35 +0000
Message-ID: <0444020d-e7e6-2fe9-e94e-413c8d3bab38@amd.com>
Date:   Thu, 25 Aug 2022 10:18:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Content-Language: en-US
To:     "Lazar, Lijo" <lijo.lazar@amd.com>, Stefan Roese <sr@denx.de>,
        Tom Seewald <tseewald@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, regressions@lists.linux.dev,
        David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
        Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20220819190725.GA2499154@bhelgaas>
 <6aad506b-5324-649e-9700-7ceaaf7ef94b@amd.com>
 <CAARYdbhVwD1m1rAzbR=K60O=_A3wFsb1ya=zRV_bmF8s3Kb02A@mail.gmail.com>
 <30671d88-85a1-0cdf-03db-3a77d6ef96e9@amd.com>
 <CAARYdbhdR0v=V82WnQOGBNrcth8z6F_61SxG9OTzgNpgg3xx7A@mail.gmail.com>
 <68f140f8-1877-6077-0992-e435fb9a94e7@denx.de>
 <43df753f-faf7-f6be-4adb-e9c3ef615abc@amd.com>
 <54874254-d21e-207c-9526-8b423bd97507@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <54874254-d21e-207c-9526-8b423bd97507@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9982c1a-c93e-4392-6437-08da86726793
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BR38yE9vauBt7v7l/8Th964jVTczekhmBIA/0HoSE2KSt768mi4TNPRXouttcVkUnMK2Kpt438s3lcV4VpGCNUm/zOs6J1aMzFsoiCuE4jlw8J6kW/shtZ92B895eE712m04aXZg4UBQ+jKvVAQd5alcWsgVcxGlu07rbKag4mM1jHWy9B6vo+Xej6PGlqZ4IsdLoTGl3cT8ArbM4Bx5rF3BrZsN9bpGapWzQiApHD6EKvnyjU9d33lJoEAuU1WynFcDl2E0ut8RC6D/tYxJngFotvq6CPgWKfPqL4L6kRtpBqts9fdUAwzAZWa5HFSgAC27U4ZknnSaU383vhfsZ4xl5xA+vzQNFCnn2QBVreUhtrdT+QjGx5qaIcLUexoitG2EfqcH5Ic8HNi7ykq+ym7548mQme9lhaaTOYN8E4dSLZroLRS9CjVWvypQhbK5VUhN4QrlsVtyToF31jju0nTKFA6QxmzOPV/GvT1IO6f8RkWAg1X9cO05j7bIPiOCsBQDGH/pcdGtVNiljJCWvoCdvvENOhZvw6uB7PHOQUvvACqu6LDj4VOwySgJWE+KzNAXtu8/UI2paZ/XO9p6SX3ZOi43BB6FpI7XJk+yYBy0ban4aANYdVCwaA0myKjIRtZpjAOpLUMm9cYvXzs7vGYRCGpV5CBLLLorqYtIs24MhqoPegaI22qiDW3PGMYojLBmpPRu9feKpJWVThC+V8Xg7kMlJx4tpmpAIGbEq0x1EewquuQdFylZBMS52dHPCWb/cLN+ddfbx3OjOuC2ghVRQCu92jftOuy582upbR2RhdPC3Pi+6gv//rTFBg3aA0D0aDYC2mO19e5OxqrHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(86362001)(38100700002)(966005)(45080400002)(31696002)(6486002)(478600001)(186003)(41300700001)(2616005)(66574015)(6666004)(2906002)(83380400001)(31686004)(5660300002)(26005)(6512007)(53546011)(66946007)(316002)(66476007)(110136005)(54906003)(8676002)(4326008)(36756003)(6506007)(8936002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzQwS2VRdiszdVN4dDVCakN0UVE0K3NQVVNiRmJlbWN6Yk5pMXd6UDBsdHJJ?=
 =?utf-8?B?UnR0ZHdubzRXcERUa28xSzVYYjBMZi84MGdua0xBUGhINDhBVEhHTzZxMWhl?=
 =?utf-8?B?aWVLZXBOdlRFZVdXd3hZaXVTYUhwTWhuNm9pQzMzaVBWRE1pd3IwdFplTlVq?=
 =?utf-8?B?UUVtVDN5QjcvMDVXVDdBa2lDRFY1SXQ3NmxNblhMNGdtMC96TXF5ajBVWUZT?=
 =?utf-8?B?OUhqSmR6a2NiWXgwQ29PbHVFZUxHVy9nRFBRejJzZVZIQnhZY2s1SXROK0hN?=
 =?utf-8?B?WGxGS3grbDV1L2RCLzdFM3pwWklCVGJVQmhwWEREWGhIZFdoYW5XWDg1TGFN?=
 =?utf-8?B?d0loc2h2Rk5BTG52UTM2Zkw0WkNQYW43WTF3MEg5VWphd0laNEt5eDJRbm5B?=
 =?utf-8?B?Rnk5L1NRdE5oZktRRkQ4WmlEN05CS09GYndzeFBPSWwzNWdITHNHNmdjYS9m?=
 =?utf-8?B?ZERFclk0YmZMaWxoeFpsN2RuZGc2d3pXb0JCRVpxWWNJcFZkb1JqY0xaVDFq?=
 =?utf-8?B?OG9XdU5Bb1FORXl5TXNKcC9iTy8wRnBzZ1RTdENQRWs5SEdhZHY2UERIbFdR?=
 =?utf-8?B?L1JlOFJpTjkwZUg5NDV1K3lHMVlIR09ha1d2dllaSW1yemRkc3c1V05lM21W?=
 =?utf-8?B?WUJFSVF4R1RoTGwvSTYwdU9QV1VtQWx3TWxWbU9hQldETEwxK24xQjhRODdE?=
 =?utf-8?B?R3VXRDdTU095dVVXejNZOUdBYkpJb0ZRUlhncEJ6WnhiMys2WVVhMnp1SWow?=
 =?utf-8?B?STRXZ1VVbUdpQi9Dc0doTWNQRkxMSFliV05mY2VOOUxRM1k0bVVHbTU1Qjl2?=
 =?utf-8?B?Qkw3aE9MbmgzSVZvUW4vVDFCc04rajdUN2xWNHpTVGlmWHJHNk9CNjJ3Zmc2?=
 =?utf-8?B?OWxUR2VvR3A3Yjc5SC9GYllVdW1NTUJpMFBzUlc5QkFqTFhLdi9BNEFGVndw?=
 =?utf-8?B?elN0amRDRFh1K2hYTno2WTdPbzRUZWxSaFNDVzVheTExMDF0UjN6WUtMYXda?=
 =?utf-8?B?N1VpT2s1Ujh5Y09tUUFjZTBoYjdWL21zd252bFgyaWMyTzNnaml0aW05Y293?=
 =?utf-8?B?Y1lkZmNOTGZHUWs1WUtKc3hXdEh4UzV5K1pNR1FuUzN6MzZFTkV2Smd6U0kz?=
 =?utf-8?B?Vmx0MG5mQlg1cEdrY2F2OERGVUdIMEJTQ0lDdUZSMlFVcGthUkp1d3dyS01q?=
 =?utf-8?B?Yng4Zys2TE56WVgxS3RXaGQwaUdjUGNxTVdCMXJQTFFxaS9yWEsrZktrR3dp?=
 =?utf-8?B?anBqc1lDWHErcUxBNE95NFJoTFpZNzNFNy9xc0JIYXNMN3BKaXV1YmZjYTNx?=
 =?utf-8?B?cXoxK2lKOWw0L1ZQdzVkRE5IaUtKZm5XVXcxeURIcFlFWThMNkwyWm9ldDN2?=
 =?utf-8?B?dERESEQyaXBtdkFvVnJ1Y2xQYUFEMkg3Tmc3Ym5adnVOOE1JRVJNb0FKNkE5?=
 =?utf-8?B?Q3IxV2NGbVV0WFlVdUxnWURabm1Nd0E1WkZRbUkwUjBiNlFsSkdxTElXaktO?=
 =?utf-8?B?NDg0R0RTZnZFbFJ1bE1pdXVQUDZPS2FyeXd4MTRCNWVNbGlaMFRBWTZ6bzNX?=
 =?utf-8?B?Qlo0WmJueGRKaWdOUjBScFEwR3hnWHlGS01aM0VyclVDdVBuUHlHVlBFWFVD?=
 =?utf-8?B?MEs0SHFRZmNmeWFBQzZ0dmNzSVJPRW5JOWwwa2F0TjRQcUM1V3NhZ091bGIz?=
 =?utf-8?B?N2ZiaDF6a1B1WjcwSk1Sd3JDaEs3dFFPZktIOHdNN3ZzRjNkMzFpL1hBM2M5?=
 =?utf-8?B?VEUyNjBBdTJJcFJhNjVETVBNNlUvTFh2RTA5dENxb0wxRy9QVjZRcTI4U1hz?=
 =?utf-8?B?dFI0WWV5dzFtNXVxdUd2ZmdMRWE5aldmT01FQVhCdGptcmd3djF2Z0tQUWtP?=
 =?utf-8?B?WFNIdno5M2NpMCtBREtPQlRlNWZkdHFlUjIvWkIzVVEwUUZLTFY0dFJKRTJI?=
 =?utf-8?B?Lzh3M3FhcWc0bG9vZlE1TmtSMndjRUZERk5hTy9rU3k4ZmVoMEd2VkVRUUMr?=
 =?utf-8?B?clJZZHo3WnhqVEllTEdwNDZmVzhqY2pKMDlNdEQzYWREVnI4UE5YcDVGUGdn?=
 =?utf-8?B?THBQNHozZGl3d0JLUll2djI4TEVnL3E3RnlxVG5rZy9rYkFSdVFPY1NvZlND?=
 =?utf-8?Q?6XJxr8rTJtWEw7NRl7ofoiQge?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9982c1a-c93e-4392-6437-08da86726793
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:18:35.0640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqAHTLhap0ZydpMx8I4oEwNmFzvDFQXcyR+p44ihqtCSpes0GoaatAGvsnWWBHTG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 25.08.22 um 09:54 schrieb Lazar, Lijo:
>
>
> On 8/25/2022 1:04 PM, Christian König wrote:
>> Am 25.08.22 um 08:40 schrieb Stefan Roese:
>>> On 24.08.22 16:45, Tom Seewald wrote:
>>>> On Wed, Aug 24, 2022 at 12:11 AM Lazar, Lijo <lijo.lazar@amd.com> 
>>>> wrote:
>>>>> Unfortunately, I don't have any NV platforms to test. Attached is an
>>>>> 'untested-patch' based on your trace logs.
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>
>>>> Thank you for the patch. It applied cleanly to v6.0-rc2 and after
>>>> booting that kernel I no longer see any messages about PCI errors. I
>>>> have uploaded a dmesg log to the bug report:
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fattachment.cgi%3Fid%3D301642&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cd55a659245b24864bd2d08da8664ae2d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637970065087671063%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000%7C%7C%7C&amp;sdata=vbhJ9OB0jIYr%2FRkDIbQHhRRqhyklnnHOT9Xi8z17MYY%3D&amp;reserved=0 
>>>>
>>>
>>> I did not follow this thread in depth, but FWICT the bug is solved now
>>> with this patch. So is it correct, that the now fully enabled AER
>>> support in the PCI subsystem in v6.0 helped detecting a bug in the AMD
>>> GPU driver?
>>
>> It looks like it, but I'm not 100% sure about the rational behind it.
>>
>> Lijo can you explain more on this?
>>
>
> From the trace, during gmc hw_init it takes this route -
>
> gart_enable -> amdgpu_gtt_mgr_recover -> amdgpu_gart_invalidate_tlb -> 
> amdgpu_device_flush_hdp -> amdgpu_asic_flush_hdp (non-ring based HDP 
> flush)
>
> HDP flush is done using remapped offset which is MMIO_REG_HOLE_OFFSET 
> (0x80000 - PAGE_SIZE)
>
> WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + 
> KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>
> However, the remapping is not yet done at this point. It's done at a 
> later point during common block initialization. Access to the unmapped 
> offset '(0x80000 - PAGE_SIZE)' seems to come back as unsupported 
> request and reported through AER.

That's interesting behavior. So far AER always indicated some kind of 
transmission error.

When that happens as well on unmapped areas of the MMIO BAR then we need 
to keep that in mind.

Thanks,
Christian.

>
> In the patch, I just moved the remapping before gmc block initialization.
>
> Thanks,
> Lijo
>
>> Thanks,
>> Christian.
>>
>>>
>>> Thanks,
>>> Stefan
>>

