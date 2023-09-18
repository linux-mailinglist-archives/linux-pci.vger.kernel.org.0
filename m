Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C227A4B7A
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 17:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjIRPRB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 11:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjIRPRB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 11:17:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F982109
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 08:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=equ5g1ZZmnhT5Z6qEl+Ag3dlEZ6E34mlvCEYF2LYK/7o29LsWpyW1d8LWhQNcSIBk2HWe6e2yRasLJ8mQBGQ6+yyG6Vrf6FnkqfNIDfS6aQFpR8cUlSfu9pX1qfSQ9h5LlOKuj+fyqU7fv1yaHNF6J+Vq6/oFbxY7FG22JEEG6OH0R2bdcM3LFNRGDfBJ2mGI6ySD+87mEoydTJi7ylp6Wio2tH0e6EqL3Jw0K+Q+rjiUhFODF9H7rgAeKnEqCKvhfee2zzA7FWwCfLgewZNOXlgKFVW32MoIoY/KDrVbqRLwpKtJdfsiZgwgdF7kCrWcCQOaUKJ62La1VDenK1Mxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXjV3Ob5xjV69a3IY8eob8Gmvvj9p8v98zUzkr9X/1E=;
 b=jH7Q2Q89ElTd4pfzve9nIUyhsJPKnWhkAdZzn7tm5h9xFeLIJV6H6UZV81+TCjMPj1fgkx+i8HLgPFx9/dV+CSxP45ajV26dd3ytITvzMVOvzm4KtwZiS0yxS9JVrp98EUdX1eJz5o5N3qSV8FKuxEBI5SVEJv987FfXVShzfZHE/7JYkK9XQZsYKeBYTijoTdX6bvXdLnkF+IbHotP2YeKzql1H2c8SeMtWhStKpsN+cXCAlz1qu/BANSfvc8Jl1GpXYs+T+ZAM1B4Ir/uj9P9b5MG1Y4bDCU34Fws0+fsuNIE2bhV8AJoLhZirUjt2vuiF2X9tVYIPowgDejCSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXjV3Ob5xjV69a3IY8eob8Gmvvj9p8v98zUzkr9X/1E=;
 b=Tv6TG3EV0wdaGc3KmJqwkYKPuikouEajUdLlw4Og/FwiOsttPOi+1dKwmxmvuaR+mcX5w5h0q8KNKd9rC4B2jQjUOZoId9PBggwen58l6qzc/oy1WIzoGP69ukJxa+SEw9ft72e3TDrSMD5v7ptZoCbR6HafZsH0OP9ZoddHcGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 14:52:31 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 14:52:30 +0000
Message-ID: <92a12451-0950-48b7-b816-642ad506cd41@amd.com>
Date:   Mon, 18 Sep 2023 09:52:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/sysfs: Protect driver's D3cold preference from user
 space
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org
References: <b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de>
 <20230918130742.GU1599918@black.fi.intel.com>
 <fd432ea4-247a-49ca-88e6-c9f88485eb98@amd.com>
 <20230918132424.GA11357@wunner.de>
 <888824f7-06b5-4df4-ac04-c6cd599ff6f7@amd.com>
 <20230918142637.GA28754@wunner.de>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230918142637.GA28754@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:806:a7::17) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: bf217673-1b0f-442b-a482-08dbb856e23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJY4EYczkA1HvmVEJq9XA7ysDboMkSaF8rVSrD8+3HKfcjdDm1yiW2O5wCZiafaO7J9icQ3hW1VBi5qM2GQF6148P4gW6wWD8pOKG53RVFNCKNlYkNyz5wAWR95LV7DzXILcrisJE9DNc6fSByan0IOH2xi0J1H3PyWHcdnJgw3kjauYoYuy4eNQxAR+o+sVVefruUaLphgQ8+VZjEh/AozWiNEr/Bk9BOxQWClJVBkQtcYLno1BTWR6v29R4wVKZSd/qy/Z0z3W6aqvvLvuvEav8rx+xFB42bQhltLdh4ZKmk/8Jpx1s6tGiOwuJjc2YDXMf4D8VAeCcm6n0bb1eZ27w+A5VKQwfEtJIlKA9A0Ygb6Tt0mrVnM1DsjkQeuQzBx3tF31LdPCbxYjDl7DPPFT8Ef6j7cT+yeWthELE4b/+xU+mErilW7o3PopjGFxzElBXYpgiwxx99lWkQCdHmMoHVSrooZw+gnF9j2yV/bU3KUbh35Dambj1kiE0L6tZk94Yz8pYih+W90F2F6w/UinK3bHgQIZ6D8WthALWVy3Dz7HfDewsjq7YVwSSBNqE5d9aPAz6CT+Fnxgdw68qH0vapWsc5JYGpJLW0mL+tgzESK/T5TcJkKvinsWZxWJgMQPvvIDSG7e3qjTEMBsCttSKnqPaOAntazS71e/xw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(1800799009)(186009)(451199024)(26005)(2616005)(8936002)(8676002)(4326008)(83380400001)(2906002)(36756003)(31696002)(5660300002)(44832011)(86362001)(53546011)(6506007)(6486002)(478600001)(31686004)(6916009)(316002)(54906003)(6512007)(38100700002)(66946007)(66476007)(41300700001)(66556008)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWdYbXFXNHdXemQ5Vk15a3dLN3N4aU0yWGwxc3J4bDdFNGJ0dEJzcjkrNnNx?=
 =?utf-8?B?eDRhSHdkVlZHR1JnRTZyMkdYaGVFS1FvbDdTRkVuRmN4OGxpajZkMjc2L1VU?=
 =?utf-8?B?NlJDM0RWbnluRzg5ektOZ1BFTlB0akRRenQzZjYwUXkyU0dTbnA2WEFPUVpV?=
 =?utf-8?B?akx1TEZyNkdQSFJCVUtLRDc1dXI3Tzl0Y2NraVpjait6Y2dwd2JDdHhuT1Ew?=
 =?utf-8?B?elI0UXc2N2x1akdONkJJTzY0NThVZVZ4TDkwMnBVdkhvUDhOSkNsQWhqN2tq?=
 =?utf-8?B?SExUMU81RUtnaEFyMmsxL1I4NXRJWEwrQTFkd0VDRngwUFlYMHNYM1p1c0ZF?=
 =?utf-8?B?WUI1ZHl5aWx4M0lIb05ueTFzUURHeGwyR2VSQU9QRVBRbjMwc25nbk5ZRGht?=
 =?utf-8?B?T25SY2NlVG1kUVFrbTBFRmhxaDJLaUhuNmZ2REV5MmNaaEZyaTNOckhINUR4?=
 =?utf-8?B?S24rYnlIZzdoY09TR1BqUnpCWkZlam12YzBibzROYUxnQ2VOSEJZek8vekhy?=
 =?utf-8?B?VWpHRkF0TjJMbzRHOHhOa0QxN0EzelhxRE5LMGFUZjlEV3dPTkpLN0t0VWxs?=
 =?utf-8?B?N1NYVzVsZG9vcFdUQy9DL0t1VkE5MU94cFNiSFZNbDg4cTlEQUxnMHFpOEg1?=
 =?utf-8?B?ejBFL2FvL0lYL0NOTjF5NUVIT3hvRmFnam9SRDZkbUQ2QnpsL21ZNFJPc2F0?=
 =?utf-8?B?dnByS05zNk5BaG1yY3RSZTFnS2hJSmhVaUpCQTJMU1pXaDRrZjVnR3loampk?=
 =?utf-8?B?ODZXcEpoa0poUUhRc1picUlpT1RXNDZtUmRSVjZFSkpUcnFsWmI4N1hFTTdp?=
 =?utf-8?B?azdWL2R1dXpYenh0ZzJoSzFBTnozSEhsTnFkQ2k0SVYzYlNVTGxIcTJ2MWlw?=
 =?utf-8?B?U29VVjlvRVVrTEJxYTF4d0F0RmlVVUxHK1BiL2tOcWcyZUh4Nkd1VXYrZ01r?=
 =?utf-8?B?VzlrOXd2bUJzb2xkVUtNWmhiS2lLSDVsQnV1cGdSZE02QWQ5S25ZcS9wY1F1?=
 =?utf-8?B?Ky9uR2pHQzlQQXJFRXVUNnUrRkJlRGZOb3JmSU9ZUVRqdlNxckptbFpheGVl?=
 =?utf-8?B?UjZVUUVNamZqdTBuR29BUGJPMXNHaWV3TkpqdjFjRkMrZlNmRW9MQm5kSmFI?=
 =?utf-8?B?L2VIQ3Q2TWRpTjlncjlFeHV4T2IvM0pKU2VSaVE1L0lPL3M3NnpPNmdpeTJD?=
 =?utf-8?B?bWVSK3J1K0ltQ2FITlpwaVZJbnZKRVlXbVNHVzNkeFp0MUtDdk9GUHk5Nytq?=
 =?utf-8?B?UzhMa3h0alhyYWw2a2RHL2cxMTQ3L0Zha04ycHY5clEyektvNS92Z0Q1Sm9n?=
 =?utf-8?B?ZzB1NVlZRmdhMDB4NVRDdFBQcWtwOWJkMkpyNHVFT0F0RFdPdDhXUWQ5SllD?=
 =?utf-8?B?eU0vS3ZiZ3JtMEZzeEhYWXBWUW9laUcvSWRyYWt5WjZKRWluSzlzM25nN3Jm?=
 =?utf-8?B?djVWek1RRWVGemh3aVI3UGNNNWcrVjI2SVRMcVJjM0kwaXJ6eUNUOGw5ak5U?=
 =?utf-8?B?TUVFRWhTMld2N2hxQkFBVnZhMjhleDQ5ejdoWHRxUkxaWjE4YmtoYUJlSCt6?=
 =?utf-8?B?TWo3RXRHZC92L3NGcUVJT1pFbmRqcjlJZTFlUkxtNVh3K003VkVOMXpzeUlD?=
 =?utf-8?B?ZlA5UTRHaVJvZTlUQWN2djhzTkZydXdGTjhrL2ZKYUpKREViZkxzd0xaZjdD?=
 =?utf-8?B?cnptZGlLV1FGUGdjU2ttNTVVcXZjZFlSazM5L0FFcDZGOHltWkpZMjZnQU1l?=
 =?utf-8?B?eGJieDBvekRWSEJzRWlnakZZV2dkYnNDczJqdjJnSlMreG1kM0hPQlg2OEdq?=
 =?utf-8?B?cGM5WjNMdmtaZkdSSEk5RjIvMkdPdzNmUU1lbk9pM2w5TkFpcXRFeGlOTW1r?=
 =?utf-8?B?YkNERm1JaUM4WVg5WFhvVHEzWHdKQkJybGhPakhTclJnUi9ueFRENDBzT09R?=
 =?utf-8?B?RVYxVVBaUFNLNE9TL0RjYlF0SWdpTm5JN241U1pUMEdtQVBvMHlQdVM0Q0Iz?=
 =?utf-8?B?WjdmR25XY25kSjRtNHVVVzdhTGtHQk1QeUR6a3NJY3dLNVBUK01Hdi8rSG1R?=
 =?utf-8?B?RG1qMGpNTnRuQWFXb3loT2IxbytyeEZmMnRNeXA5ZWJxZzdOZGlhcEk5M25m?=
 =?utf-8?Q?E5i1KOlS4zrRrh0tPv5U17ydT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf217673-1b0f-442b-a482-08dbb856e23c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 14:52:30.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFAvux3+b3eW1lT6DULYrsVE2wiJdcKKtWiq3DQovM6JKz2v4WoJkU8014CW3zVSIH4b1wdgEM9SN3Tt1GVFtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/18/2023 09:26, Lukas Wunner wrote:
> On Mon, Sep 18, 2023 at 08:28:51AM -0500, Mario Limonciello wrote:
>> On 9/18/2023 08:24, Lukas Wunner wrote:
>>> On Mon, Sep 18, 2023 at 08:14:21AM -0500, Mario Limonciello wrote:
>>>> What's the history behind why userspace is allowed to opt a device out of
>>>> D3cold in the first place?
>>>>
>>>> It feels like it should have been a debugging only thing to me.
>>>
>>> That's a fair question.
>>>
>>> Apparently the default for d3cold_allowed was originally "false"
>>> and user space could opt in to D3cold.  Then commit 4f9c1397e2e8
>>> ("PCI/PM: Enable D3/D3cold by default for most devices") changed
>>> the default to "true".  That was 11 years ago.
>>>
>>> I agree that today this should all work automatically and a
>>> user space option to disable D3cold on a per-device basis only
>>> really makes sense as a debugging aid, hence belongs in debugfs.
>>>
>>
>> Thanks.  Then perhaps as part of moving it to debugfs it makes sense to
>> simplify the logic.
> 
> d3cold_allowed is documented in Documentation/ABI/testing/sysfs-bus-pci,
> so it's user space ABI which we're not allowed to break.  We'd have to
> declare it deprecated, emit a warning when it's used and slowly phase
> it out over the years.

What about as part of deprecating it to make it always return -EINVAL no 
matter the input?  The ABI isn't broken, but it allows for the optimization.

> 
> Until then, the $SUBJECT_PATCH probably still makes sense to reinstate
> the behavior we had until 2016...
> 
> Thanks,
> 
> Lukas

