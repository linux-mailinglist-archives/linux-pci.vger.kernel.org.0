Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D737C5A0ACF
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 09:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbiHYHzJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 03:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbiHYHzF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 03:55:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D79108F
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 00:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWGUalSh90emXzhWzxTYTgI68UOiDBHaXKXuAKDm93VMVYWXoHq/1IINu0EohWwi6hWOzmbGNAz0stZodu6GYR02Bob/HPJxigQWp9HusSo6GxAg3lW5Q1SLFXd7gwIrhGYkb1hckldKQ3EzFSMQUG/xfhbdVOPqVA4TIECSkZNEXxP2TmoiDEruOJ9NSHef980lQ+9B5loapEX66YutbJINrpPhV1NOPvaME6pyeHun5PLAqHdw1lL28Nfef7lmPgMjBzf3fgmNa3LrGAgHL92VMldgaSpQUPgPCCzhqhmfzoCsK1/dabsf7w5xZbXyQINPY0gziKvSO8OOlm1Ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POr9TYr9aBKNN5fPXSg+Bx10J6ds1wLuVfwPBsWwT4g=;
 b=mIjJEyEFV4/hBTFssFIixe70c54+6rMvShpDUS/sSm746qI+5guXchM7hRyP52meay5ihjuyXJtfhN3thbOgDotVrcmTjfr/GlUGJIE4HALuTlQe4k+9u34ZyaH6AR9mV4O4aqNGLhZiyH+SRnZ30+R2ajLgin094KRQqER3cpjP0wAZ/ewZ+ZWfDi2tJsrZ0n0hhs2BdpxEeYOO5sN8IYMKYFka3ncbHkD0hYTAfIwEfmjw/xoYYtLE8fHEDQcpo7uI5EbspUuPSsrzTRZRwaTwo+2NsEF1Fonj0wNO+kn9Vpl1ufMA2TKO7jPJ7/+k98xl+Ks8ShOkFDI7Qdw0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POr9TYr9aBKNN5fPXSg+Bx10J6ds1wLuVfwPBsWwT4g=;
 b=bNXteqlVjqb2006ZmHzrJas4X99MhdhQyz4cDHDzsFXJVbZJgo3hBfwA37zX160fnrnbqM4DkBoZ83A8HK6/j+NWTTnd7EdpD6kIDcTr/v0/BcfhZYbthJhKo1/4jWGDkd+birff2HFxVR5yFs8UD4m+ufjTVfNox8ycz/RETws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 07:54:59 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8%3]) with mapi id 15.20.5566.014; Thu, 25 Aug 2022
 07:54:59 +0000
Message-ID: <54874254-d21e-207c-9526-8b423bd97507@amd.com>
Date:   Thu, 25 Aug 2022 13:24:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Stefan Roese <sr@denx.de>, Tom Seewald <tseewald@gmail.com>
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
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <43df753f-faf7-f6be-4adb-e9c3ef615abc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::21) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29ea9b30-c449-4cab-5b1e-08da866f1bdd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4374:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKc+tNoTKC599xEADRuAwIw3/zRAt42dTtk1VokRUuMpCcXodQ8bGNXFG0523Ux9rhdMbR0uA2ZcU0u6YsAU390camBGCluHe40gK2isHtQMgKxGaXYQY5WqaySKAR+gDM1a6g4twdBkhJHCE6LCT67+TosFVCYD8Uwrb+PHCUTRYk9KrVBG+Wq2/9XDZMcRAMxvKbdxQi8qP4jINYv2MLl/3GukyiazMKRSlAXVkOSFE+ECjY5WSb8LCMFItQtFj8gc/csztyNrmiBR6BUd8xaN2oCn+9T9Ea6rMzQ8e19HpDDFXMzudPFzVolASTOQwU/rGjbH5xwM1IQChRRve8uDNXDATkt+CepP2HNLgS/HuBxsV8Jc8+Oqu/uc+1AQ9BAC99BiWQm/5DVvRoIPjhngDv3W6MyO/Sos6dKwKQA6lrTIR00JVusWjw9O8cfBhz17yF/gxiaZR1mKsos7aWu4XYbcuGczkAW+DX8CKUxZxbcQkKXGyUy13rW7gGs5T9bt/UKvsUh2+kZgKDJ3BAGdwrlqWGn9komgBRz6EiLfJiGyCtKvmfR/p0TFwSzT0cp7B0ylJF2wpT0AswxHMO852lp+BvebiMPWsm06r8H9eeiUh1mZYFe3Uq/5MmweFEAHOXwkA/AnJSWu/U39EhH6MBS8mHTzOwymt3UelU4RSx6mhRz2g5+Fio0jrnDAEVdnbPhtFVXI+tIPY+Sok/b9fMQ+NMiW6rh+AQaV4PDLZFdNyDqCv5JmHAm0Ia6fxQGERq0KI6yt6sUD445PKga78kJkGr18aWE99o3m02krO0VJXoRTNmxX20S09/NfqraAZDMa09g8Y0oUrbNCkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(110136005)(31696002)(45080400002)(66946007)(66556008)(86362001)(8676002)(4326008)(54906003)(316002)(66476007)(966005)(186003)(26005)(38100700002)(478600001)(2616005)(6486002)(6512007)(6506007)(53546011)(83380400001)(2906002)(41300700001)(66574015)(6666004)(5660300002)(36756003)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUZhdC8ySUs1RTFZV3pvbFBkaHM3NzZmemVhb0lITmhtSU5ieTF4V2hqN0Y2?=
 =?utf-8?B?SkRWRFNrTUp0U1FLby85SG92ejE5R2pMN3hHWkJ0Q0grR3pZdi8wMlc0MStr?=
 =?utf-8?B?emRiL3duRjF4bmJuMVM4V0QvLzh2WS9WYVRnT3JDY3Fwd2I2bjFoNi9wMWZD?=
 =?utf-8?B?S0tCL0RNSlA2Tm1PalBpSVlhb1QzVUVtZ2F5UTcxUFUvbGZscER1TUJ0Kzgx?=
 =?utf-8?B?Wm5ZTmlocmVVY2ZoMDF3ODYvWnB2cTNqZ3J6MWNhNVMvM1E0ZXV5aEZtdHls?=
 =?utf-8?B?WUhyQ0JFbDNwUHJ5TWpDb1Nka3BZc1JTR3pRUmRsakdUZFBmTVBCVDFMTXlk?=
 =?utf-8?B?UzlVSjl4UklhQzVXeTFrV1BvQks1UVNFdjF5OGZsVUYzU21WR2Z2ZVBJYTJM?=
 =?utf-8?B?NTRRWSt1dFFaQzg1S3BFcUZaU1Z2MzM0N2NHMGE3NnVwSkVXWlltczNGelQ0?=
 =?utf-8?B?UGNjMlZmMlptVTFSRmpwb2NDNnRHQ3Nmd1VGRURVY2tNL1lURWpZZ0R3YlRv?=
 =?utf-8?B?RW1WcUJYSVFibENJNUtLZHNuOC9NQTV3aWRiYnZJL3k5RW1HLzZBN3NHaVBX?=
 =?utf-8?B?ZjY0WmNwUkFQSzJ3RzVNNE9hd0lHR2FJaVBrbHBjdmJabVQ4YUlycis1dXgy?=
 =?utf-8?B?RkFmVWpORzR1cUFqVmlHSFh0cUhLNXkxOW90VHVrbEk3N1ptemtMMFA0ZWo4?=
 =?utf-8?B?Qmpac1RTMXlJZ2VIcEtXZnQ5TnVzOUcrcHBaMGZwRFRnVE1ZeERqNjhaa0k4?=
 =?utf-8?B?dHBaR2xmemUwUmc1MUVDaEFqMUYwaGhpSS9WeklYdm4vbjFEeFpRV0oxYlRJ?=
 =?utf-8?B?dWRKVk5ldCtYekxKcmJJelNtVVcxNU1yL2tiNHBQRjR4ajc3Q1BiMnVpYXg4?=
 =?utf-8?B?QVhFdkxaTGRkOEFUNkpHankwN1JPSlF6WldOMU5XTWtwNlc1TFArUDBvMXJX?=
 =?utf-8?B?a2pvbmRKTHhITmU4TEQ2Y204T0ZyVFZ0SXA3SG5NNTZtNUduaHRzOG1JckFP?=
 =?utf-8?B?cVlERExPbjhTNGl1MWlqODRJbkhWbGY1OFl5YS9pTjBZSExKcHo4bUZXeGdo?=
 =?utf-8?B?UlNVeWdoUXRqQXNrR0x0RWJJL25LaTlFS05GTFMyTThGZFcwNFcxVVdUaFRo?=
 =?utf-8?B?T2w4a1lZaDZVcGJkUllNU3lJWjFIWjUreW5kWTBjLzdXKzk5cnRFeFArdnhO?=
 =?utf-8?B?bDhQeEt2aStGSlFLVlltNlIxbnA0YTdBSy9BZGJaS0NaOXg5cG5uUmZPOXpJ?=
 =?utf-8?B?SWJKbTBDQk1uajd5WkhKcnRzRStpNU1ha0htOXloSUVGdWI5QlB5a0VzYTVx?=
 =?utf-8?B?YlplYzRlbFhtekZrMzVIYjdvaWUrZDFaU0JhZExTN3Vpb3llWHAwVlQySzJ5?=
 =?utf-8?B?Y21hMEJwRDJjanBmbVdVWDdTV2RJTEhlcHN4T1JDTGVhb05PRGRnNFUzT1Y5?=
 =?utf-8?B?NEI2MVRUSE1mdUxiZUozRE5YQmN1OFZqMTVLTkk3VHQxcjFRV1BoOGhZTitH?=
 =?utf-8?B?T1YwdElpQkpWbE5QV2J3Y25YazNrTUNka3QzSWNkd2VJaloyQ3lEQW9tMDRI?=
 =?utf-8?B?VVJndC9hU2F5SnVGK09qaHRjVU5aZFhBb3pNMko4NUN1dzNLUmkzODJkR2FR?=
 =?utf-8?B?dTZnUDZ5bmlkS1FNMnBxRm1LN3RlTFl1QzU5bVJ5V1N0TUJLekZYQlFmeFQ4?=
 =?utf-8?B?c0pBcEdaRTBjY3RNSVZKYVU0YTdqa3BYRk5vZGpYR3Bic2IyYWZTaWFzNmZo?=
 =?utf-8?B?aXVxTHJVb1MwcUFTZmhTVEZKb1VFTEJEQ2lqTnNZNjZPUHNLT3UzUmRxWXdE?=
 =?utf-8?B?Wk1Xcllxb0dkbkxzbXBWUzdPV1AzSEUxV1MrV1ZTYjQwVTJTbEFkV05VRk84?=
 =?utf-8?B?a2RSVDhNUEo0MFE4RzIzTzdvNlpvN21Wd090elUwbnp0QUQxZEFGV3pFS0Y1?=
 =?utf-8?B?dDVMMVdSQmxlazJ5UngvbTZJeldtNUdIajBkeDV1WTlOdXpybkZRbkpTVGlq?=
 =?utf-8?B?QkJLMk01NlR4MTc4RURFa2djc1hDbnZpRnNEaUdLbzh5US9RWEhhN0Q5aUN3?=
 =?utf-8?B?QW9HVXBiSTBoY0tnRm91RGJkeExGTTFPNFFUZ3FvREdXR1p4STl1TjROeG5j?=
 =?utf-8?Q?QfIbwtMejrjFrqKrj+XOIXdd7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ea9b30-c449-4cab-5b1e-08da866f1bdd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 07:54:59.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fH/rpfU0FTo/oTDE8yL7OtDOJ4YbnIYvj4M/kdD2MR8HGDsul8pnBHXIQMuFCdxV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/25/2022 1:04 PM, Christian König wrote:
> Am 25.08.22 um 08:40 schrieb Stefan Roese:
>> On 24.08.22 16:45, Tom Seewald wrote:
>>> On Wed, Aug 24, 2022 at 12:11 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>> Unfortunately, I don't have any NV platforms to test. Attached is an
>>>> 'untested-patch' based on your trace logs.
>>>>
>>>> Thanks,
>>>> Lijo
>>>
>>> Thank you for the patch. It applied cleanly to v6.0-rc2 and after
>>> booting that kernel I no longer see any messages about PCI errors. I
>>> have uploaded a dmesg log to the bug report:
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fattachment.cgi%3Fid%3D301642&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cd55a659245b24864bd2d08da8664ae2d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637970065087671063%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000%7C%7C%7C&amp;sdata=vbhJ9OB0jIYr%2FRkDIbQHhRRqhyklnnHOT9Xi8z17MYY%3D&amp;reserved=0 
>>>
>>
>> I did not follow this thread in depth, but FWICT the bug is solved now
>> with this patch. So is it correct, that the now fully enabled AER
>> support in the PCI subsystem in v6.0 helped detecting a bug in the AMD
>> GPU driver?
> 
> It looks like it, but I'm not 100% sure about the rational behind it.
> 
> Lijo can you explain more on this?
> 

 From the trace, during gmc hw_init it takes this route -

gart_enable -> amdgpu_gtt_mgr_recover -> amdgpu_gart_invalidate_tlb -> 
amdgpu_device_flush_hdp -> amdgpu_asic_flush_hdp (non-ring based HDP flush)

HDP flush is done using remapped offset which is MMIO_REG_HOLE_OFFSET 
(0x80000 - PAGE_SIZE)

WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + 
KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);

However, the remapping is not yet done at this point. It's done at a 
later point during common block initialization. Access to the unmapped 
offset '(0x80000 - PAGE_SIZE)' seems to come back as unsupported request 
and reported through AER.

In the patch, I just moved the remapping before gmc block initialization.

Thanks,
Lijo

> Thanks,
> Christian.
> 
>>
>> Thanks,
>> Stefan
> 
