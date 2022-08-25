Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80DB5A1532
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 17:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiHYPFu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiHYPFt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 11:05:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D1464E6
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 08:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDSGmX721AjNoEtECQZwZN4zG9jiJLjp1Saism16yTE9+8FsdMOsRWzHjXa0StypIKq4B4nTxZfUGV9tGrb/cqLKDUihixPVKrXw/nQw4L1kqJ1gX9oklbtsUhh2Sxw5zC/NBxrhetLGI8l4yZmwXtI8slCfKJPDInnYIyoMD4SPu94rd7GXNnQZGk1yUKwyUSa/1mib4fHFgXgK8NYeFNtGUj96xlE6DxDsgN4RJ0hV82iStY54olykRq7iDNBZOXhCaAL2/VwebqVpsY10KqVhfDVOsQKKOhMVbemGLsuM+L/7ngInJaBD98tQpFxPCvhEet83UDXw76qDYS5L6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PWPbxlWzgMLO51o8m2Cxhp2Db/E3Dfg5SoO/BYHMJA=;
 b=kZ+qnnYK6tejzffLxSkmV9gLbJcMsl5Ruiu75tMkGR6xWv6mxy6j3nwvM/RwrZXBGMKAtzum8owEZLT71d3meVyuJGIWmS6cdTFpyZHdJoq9qPOEdK/t1Au16s8CTgcTNxdlj3OS6koXEIGRBTYoLVxctnklg2zGiaRKqRuQk9YQDLedJtAq2huj/kvjz1mvORyKVIL3j1W8pMDpbWi+Teuy+kSTo13ts3f08DVTwEkW5SL6U7SRC1Us4axr2TMxoidlSTd2vC04OYudwe7NYxFgPDX87TEBBBUea1crn4Dy+FBstwP9/NPvWYQFCibhg+gCqijHm+5ZX36bDi6ONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PWPbxlWzgMLO51o8m2Cxhp2Db/E3Dfg5SoO/BYHMJA=;
 b=wUnNS7xrdQIk0vRvbLYNug0rtLRhDvNdqrHQCK62VkAb30Fx5R9hIRaVvJ3ffO58JZIj38iB3OcjntTXalmBl7V7vhQZ+A4P1Y8nDMK8Pn7J/v3/HnrPj54JBrqohAJBvFoYrc6JUdql547J75QfH/8VXPPJ5SzWYYWHAJ60Sso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 15:05:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 15:05:45 +0000
Message-ID: <e82919d9-c215-bcca-7226-3b008ebfbe18@amd.com>
Date:   Thu, 25 Aug 2022 11:05:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Content-Language: en-US
To:     "Lazar, Lijo" <lijo.lazar@amd.com>,
        Tom Seewald <tseewald@gmail.com>
Cc:     regressions@lists.linux.dev, David Airlie <airlied@linux.ie>,
        linux-pci@vger.kernel.org, Xinhui Pan <Xinhui.Pan@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stefan Roese <sr@denx.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20220819190725.GA2499154@bhelgaas>
 <6aad506b-5324-649e-9700-7ceaaf7ef94b@amd.com>
 <CAARYdbhVwD1m1rAzbR=K60O=_A3wFsb1ya=zRV_bmF8s3Kb02A@mail.gmail.com>
 <30671d88-85a1-0cdf-03db-3a77d6ef96e9@amd.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <30671d88-85a1-0cdf-03db-3a77d6ef96e9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce856ce2-5aca-42dd-d825-08da86ab4961
X-MS-TrafficTypeDiagnostic: SN1PR12MB2349:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1LsLNNm1tFaTP8g0eWVUr6U/jgA+GVTOde6+mdaDoCLbOmeGl1IZwOl8HbJ8iU9Ka0jVCIP86TCX0JfUr5uXdsjA1onBui4yoHZzs9L+srqkwEmBi8T+Jq9gDodV6ldypGvK/IkY7GoIHezqDNsDz/vbIO1LowyfcYQCKPiNo+yAhJR1QRYSZPS/TnJEYPmykU8BQm26fGZKaQoewc7w+E+Vb3feATWSmFH2bFkNLuNAvHFxMN6OsD5Ozk47ej6e4XUKAjqTsY1weweWo5LF5xvskwyeuwj3v4PEMhBLkYEFJMQ3K+Zz8kz5H7XATwxaJYEvSFSItiz9l0OMXbNqVxEo0o0xN/ocpRXxOmKBpYfwd1LI+GhqBcQ4LYh52uB4+IypV7rfI1MglymhpWtdc3tGBMPsujYcQiUXeHJpGKuuD50Op8fhFDsJV89mj0niLQ9fkXstX8pNYyXFOWGP4yFH9nJDx20cBY8Sd1gD3mHHrIwfJe1fp4jUZg2YSRsQaH2Dkq+qhQDUvwGZl/9AACB0dDp8YHwLRZX0pMNU17CyVcK5AB0jlau3LxUay/nPYMy+CA+PXOozd1jEFNh1rydAOvhE4qgZz1OsMIbUQYo/UBLi+3RMFM4UU4qz/XVVsdjNm+mpTxTrdQ16XbzPxlO5GPd/9wSUk90+ywLSSu5qGtv9yxIIc4Yz/p8wWLa5VDlLyL0wqm/UKNBLzzBfTHeAtX5hBqN6W8zLM72K4oEZ6Gx0KCfRq5g/rcXrsiXi2okBIs23MN5KaFZb/m021w8wOjMjMWISkNNjVi9cx9xM2cig+lMJEWIsBdwTncDI+H1gWENr/2XPlxOgcERQ9MVh7mteDkGkz0wfpPh029QVGnBPSfLbQ0UFnQxyTBk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(6506007)(53546011)(2616005)(41300700001)(6512007)(86362001)(26005)(36756003)(31696002)(6486002)(31686004)(186003)(966005)(478600001)(66946007)(8676002)(4326008)(66476007)(110136005)(66556008)(316002)(54906003)(38100700002)(8936002)(44832011)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVNrdXA4a24wbDNKSTEyWlhEY3NxTEFPQUJYUmw0SGRHSlQ1Ujg1eFlseXBJ?=
 =?utf-8?B?NmUyNXo0b2c5TFhUZStNQ29UUHVESlZQY1VJelBFVUwzQVVDdWk4eThDSit5?=
 =?utf-8?B?Wlo3TmV5SjU5U0x6d0U1MnpBTXdiS0Y2Tm9GdDdENXhUV3Q5MEM1d1VRK1Fs?=
 =?utf-8?B?bDl1UEVYYnFOM0ZEYTk0eEtWUklDdnNPeVU1ZllqSVg3QnVlczMzdVFhcmh5?=
 =?utf-8?B?MUx3UmR5RGNHTG9jeFhxZ01YZGNiMkxhUjdQNHJobHZsUXNHUFp3cVdYQ29J?=
 =?utf-8?B?MXN1S1lXOThzSWZseG0wQTFuVTE1cWNIK0xtdWhFZERFTjFxajdSc0JqS20z?=
 =?utf-8?B?b01WcmhldnByR0FVSjE3eW9hbUd0enF2d1M1NktmNnRqaDdRN05YNEszU0t2?=
 =?utf-8?B?QWtLM3hnc2MyanI4eGFKT0JCWGVsU3FlbitaVTVNbUNpeWJlMTZUdVJUU1NY?=
 =?utf-8?B?Z1NzSlQxQVFnTm5MR29uMnU1aXRsaW5pdDFtcmMydjlDeldyekZTZGNZMnhx?=
 =?utf-8?B?MzhqVEIyRXhwQTgyNWhMTXVZRlJkUk9mUENtYjFRMGh0UjkwaEJOeEVPclJI?=
 =?utf-8?B?U3ArbzhqRVlaWCtETlBEU1ZJQTlxdWdaeTBmRlNWTUFzbkxLK1o4eXBMZmhS?=
 =?utf-8?B?Y29iSTRaeFQrV0VNSThxUDMvOE9TdEtDdzRqK3d4QzRoZW1leGRNNTZwb2Fr?=
 =?utf-8?B?MW1iVC9JRzB2VnlBZVh2QmFHU25kVmNjWHpYV1lDUE5GNGxRd20wL0pBcjFp?=
 =?utf-8?B?S25LaUkvbWNXVklaZXBhcHdsQ3pBVHZ2bjk5UHQzOG5TdVhoVXJSTjhjcmND?=
 =?utf-8?B?a3YvUUs0RGhXMkd5Y3NrT2pDYWw2b011dkZLTTErc2xBM0NmV0dHOGJjTVA0?=
 =?utf-8?B?S2ZpWlphOXIwZlZQUmF3ZTF6eVNmUk5oN1VFMEF3N3hZdXZNakpYeUxScU94?=
 =?utf-8?B?TkQ2SnY2V1lva3ErSU5jTEs3R1lMZFJXOS9Udjh2OExGU1VCYnNwbUxMbFpV?=
 =?utf-8?B?N3htQkJjeUIxa3h6UzhwT0g4VlpWQ3FnaFdNbzlVd2g4NHk2TzlPRDNwUTdn?=
 =?utf-8?B?VzRzeEZtSFdkek5LeENtemhyZmVqYU9qelNLRVF2NE1WYUk5WkFJLzlTU21v?=
 =?utf-8?B?dnVnR1NEZnZQN2NhbjdoSHI2N2d4MXhmOG51Z3VOZ0svTnFaV2NEWWxseFA1?=
 =?utf-8?B?S2FZQTBoUytUYmtKYWxmbU5kSHEwblkzU3F1VS9ST1hGVTR2bDlWOHZkWXVC?=
 =?utf-8?B?OVkrYk1IamF6V29zbGtCOS93c1FwUWkrWmdPd1RvUzRmL1V3KzJRT28xYzhR?=
 =?utf-8?B?QWJWY0ZWN01MV3ZKYkYyRWowZXFVRlUrQjRreVhEZUFvY2UzRGt1S3BiWTRa?=
 =?utf-8?B?ZS94N3ZyOWdUNzFVaWZlUnI5V1RrM1MyM292a1dXdVZqQVRTTVdEK3ZQeElK?=
 =?utf-8?B?V2ljN1Fvc2pNeXJiYVc2bFBKODNiRnRBZ0VFZ0RjR0hHQTRYNEhkNmJNajh2?=
 =?utf-8?B?NUJaeFhBcm93TWRTUkdTQVY3Yk4vZ2tyNVRxZ0ZEelpYcnVQRjJzeGV6WVdT?=
 =?utf-8?B?TUMxTGgzTzhzQWNuNlZPMGlnOFBpcG5NYnhEcGFNYXBWRUhsV1hXbHVBM3N1?=
 =?utf-8?B?L0xxMmlDRkVyWG1LOGdXN3FiU0tyQnhzMGlld243dXUyNTFzVEJ2OUUycXJS?=
 =?utf-8?B?bEVwd041anI3NExoT0dCMzhnTTc3SVpCS3FuVUlkRnRjTHpaKzhoT1JRbFJx?=
 =?utf-8?B?eG04cjh5ZjJTdEIyenc4SU53Z1RmWXpIZkgxeEVmSko5akx3VnpBOVR5Qm9Z?=
 =?utf-8?B?ZDMwVFhTZExyZE1TUE9GYUxBQjVHZWR1K21QVVNGYlhMUkppV1BPWDYzZDQ1?=
 =?utf-8?B?RzY3KzI0L0VUVFNaVDVZekJuOXlhMWRlekdSZjBLQ2lKWkRhenJzdWtVcnNh?=
 =?utf-8?B?ZXArVFFaMHphRGgvTFc4Mjh0UXBNNjBITnRLNFJGODdCeHlnS3pxTzYrdVRB?=
 =?utf-8?B?M2wvb00xczlFNnJGbU16dUU3NFlrYzQzUnFvdjYwb2ljMGxidUlvWnhpc3F4?=
 =?utf-8?B?QjA5NUtQUXVvcW8rVW1GaklNdDl3WmE1T0xEYXliaGpwNjQycmtaZ0ZtSmdF?=
 =?utf-8?Q?Ts8fCkwdQ99T9ixNZfeEpM+ut?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce856ce2-5aca-42dd-d825-08da86ab4961
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 15:05:45.6587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKGCc0DB/x7aLvbIV5BiWk/lI2Rjbzg6kBeG2hWvWJ+5viuy9Idpy+0A8FDCFsc++sX6fM31gV2Gl9uUhjpRQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Am 2022-08-24 um 01:10 schrieb Lazar, Lijo:
>
>
> On 8/23/2022 10:34 PM, Tom Seewald wrote:
>> On Sat, Aug 20, 2022 at 2:53 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>
>>> Missed the remap part, the offset is here -
>>>
>>> https://elixir.bootlin.com/linux/v6.0-rc1/source/drivers/gpu/drm/amd/amdgpu/nv.c#L680 
>>>
>>>
>>>
>>> The trace is coming from *_flush_hdp.
>>>
>>> You may also check if *_remap_hdp_registers() is getting called. It is
>>> done in nbio_vx_y files, most likely this one for your device -
>>> https://elixir.bootlin.com/linux/v6.0-rc1/source/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c#L68 
>>>
>>>
>>> Thanks,
>>> Lijo
>>
>> Hi Lijo,
>>
>> I would be happy to test any patches that you think would shed some
>> light on this.
>>
> Unfortunately, I don't have any NV platforms to test. Attached is an 
> 'untested-patch' based on your trace logs.
Hi Lijo,

I like that the patch also removes some code duplication. Can you check 
that this doesn't break GFXv8 GPUs? You may need to add a NULL-check for 
adev->nbio.funcs to the if-condition.

Regards,
   Felix


>
> Thanks,
> Lijo
