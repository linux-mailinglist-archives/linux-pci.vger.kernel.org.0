Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBB96C24F3
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 23:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCTWxa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 18:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCTWx3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 18:53:29 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E0D3A8B
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 15:53:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCgrgLqawEWOvW2qEyvwwN1h0xJn59fm+iPeldF55GoZFVEakksati5sM25trOaA7lYK+0n7Iu/MbYFhYlUr5Q+DKLpF80iDoWLooLbsG1Nd84JmI2cxcmJCQiAw/DG7TMxNbOGAAz6T9ShKPPi5VyJW22DRbDrowDoP+bMv8BkOts7gGsaSOHLVcfytXPvmvngHJsQpTjwkYt5u5ui4KZrdnM+yfcU0PKUt+OiP1a/nqTFaI3kboTJbvvq8fgPJuGNy31MnEef7SPkRumkuFARqfgMJnQOo7Dq2V0a6MfT+DWukZAjL6IBLdxEDiSTSoWBUTA8VEhF3fds62uctMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZQ/G9QGFNSIcUW2HsyeN2+FhEjEfEjaHr/cwcI1BSg=;
 b=gts78we5d8dqIQWFQ7X6smeJ8AEdyO7tgDhBByvdSNs3l6AZQy0SmzOAYv1qQwix6JcjDHgbVsnD8iosUo+mOwWxZzolaRIs9Ixx/CfSPi/yOfJLTksOCAZ8a/vbbFICrsXEYufZUPcOh7rMEsiptAidqqVrCW62C9rleDGImfsbWRAOtUBVnp3y2S8hjJ8AH1l3j7IRvTcouTc0hi8oE4HX/7qrSUQqkpWl6jYBKOrryhWlMyrp430g1Koz5KqdJusCgMrA+2gNeI/eYKpjE1/VFA5ONDHlDsT2KPdekkq+unFqm7dsnO2Q0GB6gOVg90ewuEltCKvP9B9XYqbGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZQ/G9QGFNSIcUW2HsyeN2+FhEjEfEjaHr/cwcI1BSg=;
 b=4EimqfFsb5k+OlEO+I6lO+c6Idxy0GyFxxV7M2/f/GhzlkvOKVB15c1WFHvufmDLeY8AsLvF+HEbAv08B9QT30QDKwzH4vpsTgP5Qq8CLvamfnMfpXWXn2VizhNz3mT1tq21b7Uabhk5CpHJQ5SLEnx43PVQ6LCi/vNiVMAqIlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8264.namprd12.prod.outlook.com (2603:10b6:208:3f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 22:53:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 22:53:24 +0000
Message-ID: <7bb0b977-be26-bf28-7bf1-b4e1b83f33c7@amd.com>
Date:   Mon, 20 Mar 2023 17:52:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20230320220802.GA2326747@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230320220802.GA2326747@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:806:6f::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: 4878aef0-3db5-4ca9-95a8-08db2995e938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpfNSD1Cb5o1LWh4vXIAsf3V0fiT4hi1T0yADZEza0UaPeGFYDU9TVOLxQJdRNX5DqM1HzUWNwBaBMEAvNQ7P837VUdpG0/6/U6jrr8P+6J0F3ptipl9Vb7r2WVIQHU0UfAHTNRPt8IKpHxLhw+ohKZSEFojVSaASeBEMn72LmsMzOyj0jCed6Bk0qQhPrlLiV6XSaEjUVr/cwX0afbObd7YG1mzgCuQdaz6yOKxt+lS6q9+BALYDe0BJQr35FKor7QwtWtl+g/KWzAz8r8ZqEXQOm7D1PQ7V1u5ebNMe76WqWRRPI3gAjdwdR4hPncjRSJb16moOR32drSV9+ezoo4b1Oko8uNqsbbyMwyJAsCSN/YkclslDU+WAtd/GxBNDJTXT8Hlq4ieyLUB8Ue9Vwy7yfhc0KOeKkb9ycGEM13NAmxIiltof8f4ohkdPytsc6NF0YPVQjzaEUxLQaMDwUvdYuxPmc00FN25En9dSmKa/nRtf0yb8cSCxyiAsd15NOMeZkNy8JNMm4BxXuJbMvqVDqARiIvXzLd3d+drU3e5V+tvSqXeu+yujwbA4h74b70pDlA46bxYJCnVQFMjdy6I/tR88IAf86jX19RJrSQdo3Z4SK/6EXl6Yr9DRO4aO0/xs87YDSwuarb5sO1yGVOXmtEV7TtKpgn20Zmu0lZM2aaRUcEmgvf3IFAUqFAwvJuccaJ9njWUkHbmefPHi/8gzhyL4puVbSXL4K/xX4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199018)(31686004)(2616005)(478600001)(83380400001)(316002)(6486002)(6512007)(54906003)(186003)(6666004)(6506007)(38100700002)(86362001)(44832011)(2906002)(66946007)(5660300002)(6916009)(66556008)(8936002)(66476007)(4326008)(36756003)(31696002)(8676002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDAyc2YwQUxZM08xelRxdWRZWmFMYW4zS3pJcmNzQmt6cGdFTGtzaTF5VEVj?=
 =?utf-8?B?bWpnZUZPWHBseE9UeEt2YThDUGRGMmhXci9neGFqSmFaMTNNb2VGY2tVMWN6?=
 =?utf-8?B?cml5RE9Ccit3STBLT1BkcG5vT2tKMU82d0FId2NpQ2dKWCtiYW9jcDNuQ01T?=
 =?utf-8?B?Nk9ZL2d5TlR6bEVDaFkyUUp5eURjZ3lIcktodndjNHdIaHhucDBHemZnK2J3?=
 =?utf-8?B?S0lwN0JIU0hoOWdocG9wOGhCMk50M3hsalJtSml2M2VOOTBNVDVCYWVtb3Vh?=
 =?utf-8?B?M09nNkM5bC9IRFZuazFXSjg3ZXJHZVRJa1NGNFpzM2JVRzUvaVlHUDdnSVdG?=
 =?utf-8?B?eG5IbHB1TTF5dHBsRTh3cGF0Qkcva3FUbGJjV3I4VWdiS01FbHBtMDVIYlJm?=
 =?utf-8?B?VW9NYWliczZiRSt6RzFOdkw1cURkbDNaS1FXUlVSYmhGbGdrcm41Sm1WZmx5?=
 =?utf-8?B?YUZwQURBZUxQL0VlOTgyVWcvNlRvZFZ3ZlRxUWN4VEFLaUg4aFhBMnVBUGNN?=
 =?utf-8?B?R2IvRDB5eGc3cGd1OTcyNXBveURBM1JKWFlsUDFIbklrK1JpUC9BK1NtSWsx?=
 =?utf-8?B?Y2Z0ZU5Nb0grYkEzNTcyQjVSVWxUN0kxTXM0TkxwUXlWK05MZnZ6bEdMRXJX?=
 =?utf-8?B?SEdySFVjcit3dVpHM3A2Q3JRem1rMzRBUlM0N3NmUVdGUnlIbFE5RGUyaEky?=
 =?utf-8?B?cGY5VERSWmN4SEV5L2dGdEp5U2JScWJHVFdaRzNLczQvZGFlTUlZb0RoNWli?=
 =?utf-8?B?eUVQMU9mTk9OVHRFamNFZzI0S1J6U21ONDArZU4yejJvZG1YdXpqTU9sblBF?=
 =?utf-8?B?cnE2UGtOV0ZDWHhOZmFJV01ZR01menZNYWFXbnQyalYwTGFCeWR6Q3ZZOVBT?=
 =?utf-8?B?MlBIUGlISEp3ZUNqNmQ0TlUrYUxOcDNFQ3ZTZ3Fwa01rUW91V2t2Y0hkMjhE?=
 =?utf-8?B?MC9vTzZvVDlUS0kzaXdIL0FWVjFjZDlIN1ovMkZLS2JHM0pHZXFLdzV3ejNn?=
 =?utf-8?B?bXA4Zk8rWVhJRjlXUHpjNGFpWDlMaUVTYTRZUEwrOURDdUxodUhHMDlHaWFO?=
 =?utf-8?B?K0tJbmFsaWQ4MWd6cmsxRUJQTGNINVdzRFl3bFhrMTVYcFB6dDFIMXpaZ2pa?=
 =?utf-8?B?UVQyZ3l1US9KcEpQTWplYXVIQzE1dkp5ejFMa3V0dG9LMTZJZXU4d1dmU1B5?=
 =?utf-8?B?R0hzUERRUEkwempKUURmQ0RNaVRCcjVKOFlZdkYzVUE5QzZQK3J5QzRwa1Bl?=
 =?utf-8?B?cDJ1TnBTMU9KWWd3SGsrYVhQZWxlSTB4T2JuU0V2MDFsVlEvc1RCQUpiV01J?=
 =?utf-8?B?UHVEdVNXNlU2cHA2SkFmeWg2b2ZlZUlCdWMvTkFuYWlFeDlQQ3U5R2t1Wmpn?=
 =?utf-8?B?eS9WYngwdCtXd0xGd2daV0xJYmZUaE5tUFpKUG5PcjdUaHVZUFFVeU1wQVNP?=
 =?utf-8?B?b3NJVU9UVnR1YjYzQnU2MkszcVB5aHhOUVFqUzdIa1FsRldlVkNFUU5lVldp?=
 =?utf-8?B?dnJVZzRqV0lFUm5oT3I1b2prNGlQZ1dsT2RtWXRlWHM4SkNmZWtLVSthSnRi?=
 =?utf-8?B?dGZrMFczYlpOUE1PU0JiNGFnU0ljc2l0cEpnSFl1OGhUZllPaVBwTjhZRUcw?=
 =?utf-8?B?RkxKZ3lCSUp1NUZ3cVVCSnZHbTFvRkppQjBHYlE2VkUyMC9jNCtqRDJSOWVE?=
 =?utf-8?B?ZUIrNm13dEp1dkF5ZENCMi8rVTByK0V1TE1kWDhGdFpTanhJdE9CbWtiWVd1?=
 =?utf-8?B?NXFoS2xGMjgzYjVqL2ErY2hFUlZBVDNKRFlIbWhUSzlaaWpUQ0pRNFVvZmpw?=
 =?utf-8?B?WmVYWGFFQVBRc2dhKzh0amlGY0oxMnhicWo3UXVjM2NXTEJLN1ZOWTdpdjlS?=
 =?utf-8?B?N2YyUVhyUlY1Kzd6VFpISVJPcDJ3eE1Pc3IwQ3BMK1J5dXhHZFR2bzNNeXVP?=
 =?utf-8?B?b3VtZHJhcjVyaExOZmcrTEVhZ3AyMTBzM1hiNkM1VEtSTUkxYW1wcVY2ZGdP?=
 =?utf-8?B?SzJIZFR5ZjdSZzVla2VPcy82UU5HLzh4K3VWSlpmK1F5aGcvVjYyM2xrRjM5?=
 =?utf-8?B?RWU3M3dxbTlQWGY3QzdQU2ZxaFhPL21LSzZia0NWVy9EWm9CUDNibmxBS1FJ?=
 =?utf-8?B?Q25SNjJoOEhkcCtlcm0yNUdtRGxFam9lRlRSTlNYazdwbERQVlBLNGx1T2Nt?=
 =?utf-8?Q?qszROVxM3J6469cOtM9BBhQ2u3PsXVUo6/pEiinDxojE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4878aef0-3db5-4ca9-95a8-08db2995e938
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 22:53:24.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQlBNKVigfjN3urte9hasDG6oyuSfOx1wnSrqi7m8LyULUkLeC2AvTaCZXW8/t8bV+TkiMb+rzA7qobdOQ5EqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


>> My point is that's only needed if the hardware wasn't initialized correctly.
>> If it's initialized properly then it behaves like you expect.
> So is this something that BIOS must initialize, and then it's locked
> so that by the time Linux shows up, this one-time initialization can
> no longer be done?
>
> If Linux *could* do this one-time initialization, and subsequent
> D0/D3hot transitions worked per spec, that would be awesome because we
> wouldn't have to worry about making sure we run the quirk at every
> possible transition.

It can be changed again at runtime.

That's exactly what we did in amdgpu for the case that the user didn't 
disable integrated GPU.

We did the init for the IP block during amdgpu's HW init phase.

I see 3 ways to address this:

1) As submitted or similar (on every D state transition work around the 
issue).
2) Mimic the Windows behavior in Linux by disabling MSI-X during D3 
entry and re-enabling on D0.
3) Look for a way to get to and program that register outside of amdgpu.

There are merits to all those approaches, what do you think?
>>> Let's say somebody runs coreboot on this platform.  Does coreboot need
>>> this device-specific knowledge?
>> Yes; the exact same bug will happen with a coreboot implementation that had
>> the initialization done improperly.
> My claim is that this means the device doesn't conform to the spec.
> If we add a conforming PCI device that neither the OS nor the firmware
> has ever seen before, standard generic functionality like power
> management should just work.
>
> Bjorn

Yeah as it's configured here I agree with you.

