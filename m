Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DEB54BBD9
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 22:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiFNUfz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 16:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiFNUfy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 16:35:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E731B24942
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 13:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QU8oJENjArpuIEqUF125/gnTIC07tk5MzVxoKlFAxUp9ObxEXPUcqjcTllcWoA60HQMdAE0DUCZQ2c+JKIsX6+dKP8RXsI9GPEvocisNNmB05ixelmPRsrJUquaX28mxYDcoClRBSkdo979c6FsdO9nXqH7k3FIqSFutxSRMGIjUazOc7o0I9tErv+rR7cuSe+qNrke1ofdQg25ZdiMgW06GCl4iPiVKHPbmxyKknSvudbs+J5EV+yzE+jbyn7DBqztwRnwVRxbmBF6hiZ/bFgvm54Uv5GxohT2SGIDIlzs9PDWrJGk+Wom54Vwbk34aSfFg0NCOiFfNnOtUzAC6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7CMVAQc9s+xnEm3vfDjTpEmQPtI12vwtnHaZQA1vI0=;
 b=NlGOe8rHIUbXdDUwWE3azRD7WPwA6Fx05TMOOR3izJelADlaU0hm5j6SCnVfJ7X5L7RVO9P6GuiuuDe1S4oPJYgS4NH5llW7l2LrbJPtZTSK4kuKM+QoCUMqdCxD8gbSYMr26Fl6Buv5MzkAfBP8JJf2fIjGEivfGwp5vfOoDJjq0eOZHpWbaSGiyrQKvfCi9dw1GG6sQ7K18PdXjaPDUoZvDNXWaz65MrDn9e5OFmhMxc0wbLmG3TpNrHxNQSjvI3+K448tNB8VGME7bIUxddIHzmCIJOEbPyavRKgxzVFyygsUXreztQAJ5YzcM9m5UIUT1U2Ech9GHy1OOhqFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7CMVAQc9s+xnEm3vfDjTpEmQPtI12vwtnHaZQA1vI0=;
 b=X//5w7O7XK5o9LEBfkJgTJjGMQkS3M/vuf9FRLtgMqf3ja7GNA7+es4K1gXvZsqbbtlzHOGhf+PtrrtyQwwZTXJ5yM/OT3GMR2NknBY53L8+6TeHUmbLl7hvk2LsKp743Oj2a7FYnDmeo783UyYgGDT5V3lDexmOSiwMTtHdf+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BYAPR12MB3557.namprd12.prod.outlook.com (2603:10b6:a03:ad::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 20:35:50 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 20:35:50 +0000
Message-ID: <0754f511-fba7-7ee4-22ac-8457ba71c889@amd.com>
Date:   Tue, 14 Jun 2022 16:35:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "Kumar1, Rahul" <Rahul.Kumar1@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
References: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
 <20220210062308.GB929@wunner.de>
 <f3645499-f9ce-4625-60c7-a4a75384870f@amd.com>
 <952f49bc-81f9-68d3-89a7-b89ea173f6df@amd.com>
 <830edffd-edb9-e07a-a87d-21a6f52577e3@amd.com>
 <e38acd32-48f0-8872-8637-856ac0033ce2@linux.intel.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <e38acd32-48f0-8872-8637-856ac0033ce2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::20) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ed4998b-1964-4287-4978-08da4e4577df
X-MS-TrafficTypeDiagnostic: BYAPR12MB3557:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35576148426C614F2AE4ED63EAAA9@BYAPR12MB3557.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdKyvWKUoW6kIvEqP2amu/WJcfi326ksy+gCtBvGRB3P89+8UE2gEWAoYem2piDyuSS+uQGABhRPJ/NUHUKYPekA9DlmpHcoE6cY0jS22TO0SnygAl0ZQH6OhPzv5L/uf4TtjPeuTTyeSfF0ayzcTX3F4dRI5ZKzVwTPi9jNl7W04dfbR/blqGm2OtKZ6LwyIHAukSXJkty1SSCo6JhVH28iS2di2PEsz84mMsSSUGATK4JwzglBjwEf9JPvvCj3VGEOSJHwq82OkB1L6DZOVlyo5DvCIqwHYATjn3tfQdfozOcpZF+M5PmBd8ibDg+pmd4WBv91zJryYltflMa92CtYiUmZR6nDPt7rLl4fJxAp2U0lL9yiaPfSVYQeYx82EGZSvr3aF4ommDvX1+TQZT0BN2BrqjXumBpOzk/iwMPJAkbynHWi00yE6hd89PMTU99qE6ZI/CcezEPUA9iLJjUHoH8nfXuzxLJvW8N23pfqs/oVzkiuf53x71XuDJ37LkwvkUX6+usJSy+Ls8cgU3FDBqI1DJ9dhpvil9ccUjDQ2ouyc2vsxxeoiwVENro2SSrL4+oB30w7RK3+rZHo/YeErXNJMcMGfPuYjGCx9yklDPWcV3ftWOc4x12zgsaR3U7cXVRBdds52TXi6lDAupdPcW6snyVWJ/9oVGWk1IZuPQkb22ZrPHiVGH1zSki2P/FlwUfSJ+8OWy37axU/SrbCMRSP2w7wZQ7WQWq3c0Mu+1hWEPLc6Bvis8qa/qKAi2uP9fX6UkUUVe8w1gVWbU3OwrWT2KD2HqzInv0fDRMt0qDpv1/HRGlLzB9VqZ2cnSW/Y7kFKpyeATvr+actOqR/eb8MRbXShOoiNUJxLoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(31696002)(53546011)(4326008)(86362001)(6506007)(44832011)(6512007)(8676002)(8936002)(6486002)(2616005)(110136005)(31686004)(966005)(5660300002)(2906002)(66556008)(38100700002)(66946007)(66476007)(45080400002)(83380400001)(316002)(54906003)(186003)(6666004)(508600001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0FQcW1vNGRhNmtRbm5LVWo0R2RlY05YVnBkVjhrY2lyMExMWWVLMnVBT1BQ?=
 =?utf-8?B?SHdFVkVWd3FFZzhtSXgrQnVmb1MvMHZHZ2o4dkxYWEZUandlclBnV2hzVkhs?=
 =?utf-8?B?MWxzWjc1U09QaEVJSlhUd0dPZmxlNUZRd005dVZhYWRMQ1daTU5Ea0ZuT1ZU?=
 =?utf-8?B?V3NITlk0VEc2STkra3V0c0VHdU5sSDhoMzRmbFU1b2FHZTBsRmpzTVo3d0o2?=
 =?utf-8?B?c1o2Uk5lZG4zVzVLUW9UT3BGTEJFNlBVbzNZVUtPNnJncHNBVlFVbTBkVUls?=
 =?utf-8?B?ZC9iZW84MHBsMjZIdXdBQkJ6SytLOUkvNml4R1BkMTF5c1BhcTJaTmxEaERV?=
 =?utf-8?B?MnZ2b2w2Mm0zYmhQVE92OEs1RGYwSTV3emc3eDUwYTRmTkYvSmR4NFQyd1ov?=
 =?utf-8?B?d01RNzVPSFlQcUZBK0xrMVg5ZzhEZ0RVY205ZDFBUjZEOFFiV2RjT09hZHNJ?=
 =?utf-8?B?aVJmTGVMeHYrMjhETGxQcmNGMkFLUVRuU2lmaENwTm1nd0d2dkFia010VFdj?=
 =?utf-8?B?a05KQUV2T3lyUFpYYlFldFh5QXgwM2FLdGhFTmtvVUxkeDE1NVVWN1NaRFQ4?=
 =?utf-8?B?ZVJQVEFSZHFsU3hOd0tScE91Q2JSUzZvTWc0T21VRG8ycFllekZET1lYdmxJ?=
 =?utf-8?B?TDdvK094RzFvRXJUc2FLSjVUWEpUM00ydjZwM2dlOVFYTXlXOHNqUkF5OGJZ?=
 =?utf-8?B?enBqdHU4dDJoajBFdEpZTXVXbTJFK3g4Y0pNMXlVSkFjcTRYMG5LK2UyaUxQ?=
 =?utf-8?B?VStGVW9QMjE1SUxudVpCdy9sTHUwNkRXL0pZQ2FKYUdKbytrUjJxWUtOV25y?=
 =?utf-8?B?dkdVNFl5eUR5Ym9vLzRiL1NLLzRXVUxHZUdOcXdRTGhFZHhsZUtQRVlBeDh2?=
 =?utf-8?B?UHg2eE9DTjg5bmdMTHVEOTJ1emg1NVhvMDhCVXg4YTc5ZTg3Z2V2MW9mOTND?=
 =?utf-8?B?Qy9lSnlKSEQ1d0tXMVJPZXJ6UEZMM2RrZXlldHZYU1Aza20yeDYrbFM1TFJa?=
 =?utf-8?B?VDJrd2VpR1ZHOEhQWm1jYUNCQUdic1pZNUgrRnlxQVRFaWowWVpmdlRxZytG?=
 =?utf-8?B?MmdLd0h1TVYwT0pWdVo0bE9XcXVwb1NYRmlYYkNRTlNoUXhzdUFzcVd1d2ds?=
 =?utf-8?B?N2h1RUhCd1R4MjhZYUIzRDhtZkFiM2dNN0NGUHVuWjdzMmJMQzBwcjRYU0tw?=
 =?utf-8?B?eTVCRmhtZHdBQUdycHJOY1M3TW9ZT0pDcHkvaC9LYnVUL1JmL1RGN0diMjlk?=
 =?utf-8?B?NlhhUEJHYmNoalRORUlDM0pieng0SGNKdGdyOC91K2ZRYkdrZnBMME9jVExF?=
 =?utf-8?B?dGhUY3RHVEU2VnRuMnh6MWJkY2ZjZk82bUlpNVhUUTJzcVJ3VkM1d0M3NWxK?=
 =?utf-8?B?d05oaTBSNmltVlBLS2tIWkl4aDdPSW1BYjNZOWdQU0pTRGp1Q3poNXg5UEl0?=
 =?utf-8?B?NFl2NEJlcFhGSU1HdkZFQVVBYTkvRmVmRExFWkNMZGJXcVllY2tFZlZsa0xl?=
 =?utf-8?B?UWpWcHUzWmh0Vkljd04vdDZLSGZxRlYrQTlEYnl5eWtXQmtmelJjQzVFaFdT?=
 =?utf-8?B?cGR0TkZ5NXdvZit2THhLV2NUUHJUWXY0LzVtYkk0VjBublhKMFZxa2x1a3pL?=
 =?utf-8?B?dUo3NUZWNzU3M3duNGlVRUFJOTVYbUE5ZVdvNzd3NWRoY1llSncxRGc4WU1k?=
 =?utf-8?B?Nis5aFVvOUxnZFFPLzdFc3dUTXFCNjd1YzBybnVRTktZeUpsWnZxSkF5U3RS?=
 =?utf-8?B?S2x2OGRYTjJwWnNqWmNoT0FOVkVPUHZYTkVEakFTVGR1YTBGSk91d0dSSGlj?=
 =?utf-8?B?T3ZPdnlVNW83ajNIRDlzVmp0OGtxcTFzd3BLaDVqVDgwNEdsSys3OTlzb0Zy?=
 =?utf-8?B?VGF5MlByQjd4WFdUbUozRXFrL3NSSmdQZG1takgyUjJ2Vnh3OUlyc1c4RlR2?=
 =?utf-8?B?TUVmMmhOQlNMdmNQa1o1U3g3anhmZWUzSndvS21NV1RFMWpXMm4yRDJjTGtr?=
 =?utf-8?B?YUIrNzhyOWFYa2JpaFpEdTk4TFRiRm44dklOUDlXelRLVFloVjVnNEZCdklW?=
 =?utf-8?B?UWNhMHN1VjFUTXBnNmVyZmo1dUpkTHJVOHFSUWVtMFFjZTN1M1dJSWdDQS8y?=
 =?utf-8?B?djFZeEJKTDBJck5QclorM29UNGxQTjM2WHpEZTVaRmZ2bzVsQU05ZGFuUHRr?=
 =?utf-8?B?S1hWcHJaSXBHY2FhMElWVW5XZlA0MnFkaGltRE9QR29LWFNMRGNWaEZqRmsr?=
 =?utf-8?B?SjY5V3F4c3FVK1hYZjYwM3VveCtwME9YaHVvdERFMzBodUVwUFd1NjhiRzJK?=
 =?utf-8?B?aENxYUFzYWloV043QlFLTWY5Mmw3c0piMVhpb3N1RHJYVE9ZOG1RYjlnZDJp?=
 =?utf-8?Q?nOC2h8LaG0euQdkmW0CupmSa6svb++X6ffzTq5YGe6K+U?=
X-MS-Exchange-AntiSpam-MessageData-1: qWnx+bvz/SuNIw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed4998b-1964-4287-4978-08da4e4577df
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 20:35:49.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcqq0G1/5d74CK4PLKm3CqZnNpTMXX1zKbi5ygaoB0G3bp4keCNZsZIafPh9pKnqVlgMVzB2yQy7Q+xTvujxcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3557
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-06-14 14:22, Sathyanarayanan Kuppuswamy wrote:
> Hi,
> 
> On 6/14/22 11:07 AM, Andrey Grodzovsky wrote:
>> Just a gentle ping, also - I updated the ticket https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215590&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C2bef39c2088748464bf408da4e32caca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637908277297716792%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=wEEU3f5%2BrCSZZEnn0e0FTiWRbILd1ZlyYccg3k2CfQQ%3D&amp;reserved=0
>>
>> with the workaround we did if this could help you to advise us
>> what would be a generic solution for this ?
>>
>> Andrey
> Can you explain your WA? It seems to be unrelated to deadlock issue
> discussed in this thread. Are they related?

So from start - originally we have an extension PCI board which is hot 
plug-able into our system board. On top of this extension board we have
AMD dGPU card. Originally we observed hang on resume from sleep (S3) in
AER enabled system because of race between AER and pciehp on S3 resume 
and so this
was resolved by the patch 
https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/T/

Now after this we are facing a second issue where after resume and after
AER driver recovery completed for pcieport the system won't detect a new
hotplug of the extention board into the system board. Anatoli looked
into it and found the workaround that I attached that made it work by
resetting secondary bus and updating link speed on the upstream bridge
after AER recovery complete (post S3 resume).  But this is just a
workaround and not a generic solution so we would like to get an advise 
for a generic fix for this problem.

To reiterate the full scenario is like this

1) Boot system

2) Extension board is first time hotplugged and dGPU is added to PCI 
topology

3) System suspend S3

4)  WE have costum BIOS which 'shuts off' the extension board during 
sleep so on resume the system discovers that the extension board (and 
dGPU) are gone and hot removes it from PCI topology. Together with this 
hot remove AER errors are generated and handled.

5)We again try to hot plug though a script we have but the system won't
detect the new hot plug of the extension board.

5*) The given workaround patch fixes issue in bullet 5) and hot plug
is detected and system recognizes the extension board and add it and 
dGPU to PCI topology.

Andrey

> 
>>
>> On 2022-06-10 17:25, Andrey Grodzovsky wrote:
>>>
>>>
>>> On 2022-02-10 09:39, Andrey Grodzovsky wrote:
>>>> Thanks a lot for quick response, we will give this a try.
>>>>
>>>> Andrey
>>>>
>>>> On 2022-02-10 01:23, Lukas Wunner wrote:
>>>>> On Wed, Feb 09, 2022 at 02:54:06PM -0500, Andrey Grodzovsky wrote:
>>>>>> Hi, on kernel based on 5.4.2 we are observing a deadlock between
>>>>>> reset_lock semaphore and device_lock (dev->mutex). The scenario
>>>>>> we do is putting the system to sleep, disconnecting the eGPU
>>>>>> from the PCIe bus (through a special SBIOS setting) or by simply
>>>>>> removing power to external PCIe cage and waking the
>>>>>> system up.
>>>>>>
>>>>>> I attached the log. Please advise if you have any idea how
>>>>>> to work around it ? Since the kernel is old, does anyone
>>>>>> have an idea if this issue is known and already solved in later kernels ?
>>>>>> We cannot try with latest since our kernel is custom for that platform.
>>>>>
>>>>> It is a known issue.  Here's a fix I submitted during the v5.9 cycle:
>>>>>
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas%40wunner.de%2F&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C2bef39c2088748464bf408da4e32caca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637908277297716792%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=0mLcR5MtJ52ZPoGPZ63WqK%2BFPNCQ8tOpizKU%2BUmkuFY%3D&amp;reserved=0
>>>>>
>>>>> The fix hasn't been applied yet.  I think I need to rework the patch,
>>>>> just haven't found the time.
>>>
>>> Hey Lucas - just checking again if you had a chance to push this change
>>> through ? It's essential to us in one of our costumer projects so we
>>> wonder if have any estimate when will it be up-streamed and if we can
>>> help with this. We would also need backporting this back to 5.11 and 5.4
>>> kernels after it's upstreamed.
>>>
>>> Another point I want to mention is that this patch has a negative
>>> side effect on plug back times - it causes a regression point for the delay to light-up display at resume time related to back-ported AER
>>>
>>> Anatoli is working on resolving this and so maybe he can add his
>>> comment here and maybe you can help him with proper resolution for this.
>>>
>>> Andrey
>>>
>>>>>
>>>>> Since the trigger in your case are AER-handled errors during a
>>>>> system sleep transition, you may also want to consider the
>>>>> following 2-patch series by Kai-Heng Feng which is currently
>>>>> under discussion:
>>>>>
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F20220127025418.1989642-1-kai.heng.feng%40canonical.com%2F&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C2bef39c2088748464bf408da4e32caca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637908277297716792%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2F94hA3KKA9VUqisUhSaPCPIbi9IS43%2FOGManjoOh1AQ%3D&amp;reserved=0
>>>>>
>>>>> That series disables AER during a system sleep transition and
>>>>> should thus prevent the flood of AER-handled errors you're seeing.
>>>>> Once AER is disabled, the reset-induced deadlocks should go away as well.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Lukas
> 
