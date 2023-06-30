Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B9E7442D5
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 21:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjF3Tn3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 15:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjF3TnZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 15:43:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265B2A7
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 12:43:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyimhNt8uf563IfvyGMvIy4CuL5J3nhzTZZxbwb3W67qznCKIuWv5QLOudWu3C9roTVsQNfEJzZXymL85WP4jGvRBd13k3hVNVWaJ9HTjYHEKvwRB2HBk+JTuWE7qMWPWWC6Zisv1p+dAIark6sQ4Mt3fme5OiTVSqZds6jHcxcen199x15LO8aGFFRG7En+xzdTi2EtqK1FBKfAP98BT04j8Zf+6x56TZ9PNw+g33P/Jsd0QRRAlI9teXkDfmgnp6aOsOGciO2JnELK4OLP2mZ4AgalcAazw529tN0f0jnBWWwIrph3zeBuh3hCwgFJS+P7JquQ1ILwRk9DpvfmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVClAj2jj4DPGc9NtEkCH+RpzefFh1tlDZU5tpGlwDQ=;
 b=OCv8kWCijfCnIey8VkmVpsxa3cKEy5ZnHUmliQvS/eWZV9QXr0/VVO3uWjbvBswymnUFFySxasi1IjNjbnfWjGn5MiSME9/pWD+LsxWPsy3GQZzGpQBl00fwlOimhJnfFJq4EhUz9C7tbsRZqfOcuQ4VUmBmK14nCcLkPodc7qgoWXsb/BHbYodWf8YBoZ0dbkMC8ZLiKnhdN+dzDgSPmviQREW3SHdSSxZxIJBis92oSWxqAGEmA619VAu/WrjTQ+A8Dlysz3lFbiGKDxn5WNfY4B7YNIp0ePYEs7znaZASuJBIprJXiMTF+LuKo81/fqxiAajkBZqJmOLGdzYyow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVClAj2jj4DPGc9NtEkCH+RpzefFh1tlDZU5tpGlwDQ=;
 b=usijAhLkYV+H2jKCTY4nmrCWjdsT49ZlFvtkgZsauaoS/WWEr76s9IpLa7TJlPRdmH0bp6nNtqfwlaZbq+FGOuA1D5UzSX3f1qJjfTkO+6sfUBVok1Uj+exYFNe6cPRRcccsf5Q7t0yInfatYfZK79Jp5iqJDJvae2CD/z0+piU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 19:43:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 19:43:21 +0000
Message-ID: <f3b45ec5-3157-f39f-1133-284e4c6fe9ab@amd.com>
Date:   Fri, 30 Jun 2023 14:43:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: When it rains it pours
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
References: <20230630193929.GA493696@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230630193929.GA493696@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:806:28::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 080abc56-37b7-4061-88b5-08db79a24297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijB7ga9h5+HwZJZI1AEQQGnx79KOHJRR4BRjhuCQpN7u/6viV0El37eWgsU4HISvW5azjiFDtmXE93Hm24r8z5Y6QPXOFfmeBW/jZ/cKaOw2QoSCr/ans9OPuoXxPaFm7VK4hZusWRAiBnglqht5shjar4TnieDeD0hXHXPE145JljVNMAWzQa4qk1GiicEK/sE+vh75mIfs2s+gGpNJGCBv3/dPBHouSQe3SVGOhHpetAc40v09lgk6DKkv3/+sjWDYyipvrHXN2YWI3JrEmJf2d/Ji6F4mnSrbK0kbjqBT3Uhcl9wxyMq+GdGW+WQIbhAfTM/bE6hW1SUy+Pd49qur9BRgf+gJPO8tj3Er6xxqegL1WFHeb9GuKzTDTTBmE76Vs/CoKf1FryXdvC1e5kmhi/0aDnxnNCxPyOK38UqJC7z6FPXMjLRVtfSBAhciUuAQZs1rgiTCu28ut6lfgNPkrAX3NQhylYUfBe0OWvh0NLgQoLnJ6PndESacQch9vYh1ROLjkAxmGs+E6Fr2vIEAdHwIK6SooInbhadZun+m73hLpTHUUqcHmUI05/2DjV7ey4Pqq5YIGg0YqGWEnKJnSUMykSBv3zVgYOilAY2CBr1af+hAwbFg10ERqBOs95UfgT1fJqE8vDcWFVAcDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(966005)(6666004)(6486002)(83380400001)(186003)(26005)(2616005)(53546011)(6506007)(6512007)(31696002)(5660300002)(86362001)(8676002)(36756003)(2906002)(54906003)(66946007)(66556008)(66476007)(38100700002)(8936002)(316002)(6916009)(4326008)(41300700001)(478600001)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2s0T2o1YTVraHUxVmNERXNSbDQ1ZXphZDRhRmlMR25kaXRLcmdCNnA3Zmxu?=
 =?utf-8?B?a0UrRFFnRWlwM0RSOFU5RGdhZXc1YndmTHRPWHdBSlB2aEwvK0pNL2Z4Uy9K?=
 =?utf-8?B?WWRaM3FHNzNrUUtDczhYdXJBSWJmSEh1WTFJbldFVndiTGlzQnE1TUpEQVA1?=
 =?utf-8?B?NlhVbk5NM0pQUmgrVG9YZ3BlblJFUmZuSmhjQW9xSmdkR3dsdXh3Y2M2UDZ3?=
 =?utf-8?B?MWU5K3JZNDltcmNicjJnUWI4UzhkRjRZMm5YSjA4T25BSXNXNW1uZTVoRlBm?=
 =?utf-8?B?N1hPbm55QVF3aDZjMlUwNjRvU0VyQVd5SXhqdi9EUEZLMzAwNWYwVVB5bXlH?=
 =?utf-8?B?QkdqNjBWdU5mUmZGVllPUTNTcnJ3dlRFOGJBREovNmh0c0UrSkFBQjNJZFBk?=
 =?utf-8?B?VThTdlM0SjB5L2c3RkxRMzgwL0FETHdOTjh3MWp2aTRFTXRMNkZJUnZRZE9E?=
 =?utf-8?B?OWlsekFVd0p5UCswOU0wVEdoZUFCRy8zeWRKQnNHaGVyaHBwL3RYSGVkYWpS?=
 =?utf-8?B?WWZSYjNPYm82VFB5b2xtQXhTWGdwcVBTa2RGVjZjaVhFUHAwZDduRUxpRVdQ?=
 =?utf-8?B?R1RmeEpNa0tWc0FUdlp5YnFUMXpiaG5NV1AzRzcyU014Mmtpdzl1b0N5a21J?=
 =?utf-8?B?MWY4N3k5Y3RyUk1yU1Voc1lmakJETGNJMW1UTDEybGw2VVIycUdVMkNoaVlk?=
 =?utf-8?B?TEpiNUhsd0VCa05neWxGeUxyODhzblFadktjU3k2UGloVko3ZDdLV2lKWFNo?=
 =?utf-8?B?cGxlQSt6VlI3UUlPeEhsNDgvbXFsWFpnVWVhKzNQOCt3ZVJJa3BQL3FNaStO?=
 =?utf-8?B?bUwxMlJWVVVoWG56TVl3V3FEL3l1cll1T2ZMWHFLTit5TUVtZW9GaVZTdm4v?=
 =?utf-8?B?MzlZVERDTTNsUnB5bkV1dFRESWI0d2pZeVVEQzQ1VFNOZ1dlZkN1YXVLbXBR?=
 =?utf-8?B?SWFweWllMW5QNW50d0VSMmFwMjgzNCtFaG5IanRtVENuZHdlN2E2TDBrUkEx?=
 =?utf-8?B?bFdVVXkvaTErMTBzbGNET1BNMDd6T0N2ZTlOamh1ak96TG9kcWRub2U2WWkw?=
 =?utf-8?B?ZSttMVdoZTJHdE5MQno3Yzc1RjRsQjg4d0lkRjdlWHlibE1JRzRLbFBVZ1A4?=
 =?utf-8?B?dWRIZkFWT0U0R1Jqck9JN2RsWEc0YWFneVRrVkxuUEZuOEdiTnhiUStoaU1M?=
 =?utf-8?B?RjZBQTZQdDZrU05YY2VFSm1lVjhPRm84N2NOTkcvZExhczI4eG5Od0Z1R0Ey?=
 =?utf-8?B?MVdoaVM0MG5VRHJncWlGL216ejlKa0srZHMrbXJlWFRkWHFxOUVHWjBEd3da?=
 =?utf-8?B?MTJiY0c2MVQrYW0zMjFlR1BrQk4yNzNLenZEOXdsNm5IU3g2TGxwOTRIN0NQ?=
 =?utf-8?B?R2V2OVN6QnZkTnp0cGlnRkh6MGs1UGdXZktFcUY0Z3FZUUpNUUVQY3FWZmVK?=
 =?utf-8?B?c3VTWEtIQm1pcGNZZUNtWmppMTEyU1oybC8yTnIvZFlJdGhpRWtFZ2ZaSzEv?=
 =?utf-8?B?ckk0N1pqYXpoNWw0bWxoOVQwU2Vsa1lsNlJJQVVMb1Q0RVRCd3B5NnlsUDRO?=
 =?utf-8?B?YnZ6R1VKcEV1aXRvTVZaaktrREV2Nko0eEtZdmREVW9nK0J5bUxRQUFWU3Vk?=
 =?utf-8?B?RzdoU1QwM0dSME4yclM4SmEvK3dXQkVTSkZQeTJWZlE3Nkl4dzg1Vy84SFVt?=
 =?utf-8?B?QWljaVRVWkVQT0J3REk4OERPNzl5ZGVBZ25FbjhWQ1ZoLytPK2tBOHR4UlR6?=
 =?utf-8?B?bm5oa2xPbGU0OWRqOFBjMzRsTUZ3NTNleVpHbGRrK1RiYlkyUHA4c3AxeXJZ?=
 =?utf-8?B?YzhPZmwzZFVVOEk1aXA4NWFFK3h0MklMWWlONjdFSVlFdHJId1dlOFlCV0tt?=
 =?utf-8?B?cDZSWDRuMXNQZElhTHlIY21IL2xxRkE5L0U3YUg1aWhkM0c5NDRvVUc2ZzY4?=
 =?utf-8?B?MUtibzM1a0p5NjExNlY2SEZDY2Z1bGZYNy90bzNOV1lad3ZpaUVRdTBIcFZ4?=
 =?utf-8?B?RnFSN0w5ZGg4eUFkc0J3MEpqVmFRWGU2Y3ZoQit3cGNuNnRGWDZjaU5oOXQv?=
 =?utf-8?B?WjhlTGxvZkRtOG5YMWoxaUo3eVR5ZzIrSzg2My82SjFNRnZ2R3ZkbC9hMGtS?=
 =?utf-8?Q?L9XK08EgSmtpwao5WTkKjRSIx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080abc56-37b7-4061-88b5-08db79a24297
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 19:43:21.3560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8v4bEyWsJLadDY1ZDTyJqHZuZA9M4gMec0jaSUjyH1feF74DhR91YuTI4cPaEgXfdm1m6wmaqUGYml2gsHMdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
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

On 6/30/2023 14:39, Bjorn Helgaas wrote:
> On Fri, Jun 30, 2023 at 02:30:56PM -0500, Limonciello, Mario wrote:
>> Hi Bjorn,
>>
>> For the _REG change that went into Linus' tree I was recently made aware of
>> another system that it helps.
>>
>> This system was appearing to hang during bootup which evaluating the USB4
>> _OSC.
>> This hang happened on both the 6.1 LTS kernel and 6.4 final kernel.
>>
>> In looking at the BIOS debug log shared by the reporter I noticed that
>> the kernel isn't hung it's just that the BIOS was waiting to be given the
>> ability to access the config space.
>>
>> Backporting just that _REG patch onto 6.1 LTS kernel fixes the issue.
>>
>> I'm encouraging the BIOS team to try to come up with a cleaner failure path
>> for the lack of _REG being called.  However there is always the possibility
>> they can't or choose not to and people try to boot older kernels and fail.
>>
>> Given how severe this boot issue is compared to the original suspend issue
>> that prompted the patch I wanted to gauge how you feel about the risk of
>> taking this change back to stable.
> 
> I think we can do that.  But the patch is already in the pull request
> for v6.5, so we'll have to wait until Linus pulls it and then ask the
> stable folks to pick it up.  I don't think it should be a big deal; we
> just need a mainline SHA1 for it.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?id=v6.4#n64

OK thanks, I saw your PR was sent out but I didn't realize it wasn't 
picked yet.

I'll keep an eye out for when the SHA1 is in Linus' tree and I'll 
request it for stable when it is.
