Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17B76F7E2
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 04:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjHDCcp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 22:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjHDCco (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 22:32:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F64119;
        Thu,  3 Aug 2023 19:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6/uRuL099iUc50GlTbxq1hHjZtWo51vabVoAnkdeYRkSGUGI4lFk+CJH/ouz8IFU69zQcjOXo3KoAKj0o4WeeZwgMvwwLfoHctx/UhoTdnVDe+JsKtC4J5la31l3OMgWs/013sjVOQVE30HoFRoa/MYYDcpaUyPXLLYSGnb+3b6zOk6iLQ0w4C0Z8fMRtym2YFlM8jkP+agJTwFLoP5A7Rjr1K8uZ086GKkUGFW0JewvNQjyao3T0z/j8SNFL8eeiwmvkXkGM4BlJY8JXj8dxfdjzzMfr84BWNlSo+mVKHMgDUQuoI6LRpR6rCS019X8LgRnh5i8Xc7+QsDunYW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAIawoKWeYc5Bs9Moet/aYsbA3W41wYv8mJ7OxxKScs=;
 b=kA3kfV7pfSYpUNo5wWSWQyYZyJFm7lBLSQPvayu8FUcdTnErXm+MOlDhzROh8H8A8TNHbveYKavvRuuNbGoVKDb66REfc9GZEZ/Q6Nod1yXu6ACJZlqoJWfLPjvfDbv1OC7lCNrMd3X+SyS51lhIKeZ/RH1iZ5I4/7a1xAbf4KwdLZf47QdMEQWD1XZi7lo6WYbQTBdyf79zHijEBTtH+0lw9o0z7sjvm7Ki9GoOjNJS8xsAJgv+/OIfUhsKi/2H/12XPxEouGqjmi5WWMHnupUZCXFOVjh8EyDFVKRNve+J9AXKPMqSD0I05H68YaLvjeRUkUSCOQ8/dOHV7R4k9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAIawoKWeYc5Bs9Moet/aYsbA3W41wYv8mJ7OxxKScs=;
 b=Da08GBwcfhFRvWfQO0aBzS1WZWVloG3dDzlbb5lah3/A+EogsfzCZGrwOXHpRvg76Jql/2ZHf7hHGEwOlzSCRbUBaVMDfqPKlqHy6VbhNImdgeawnrKDx4pi7a30flTjjV8NP88E8sksdjZyqEI+hwov85Yj3I3d6oQ/ldSWD2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 02:32:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 02:32:38 +0000
Message-ID: <846c0e8f-d7b4-bfe5-8b2b-cf72fe7afeb9@amd.com>
Date:   Thu, 3 Aug 2023 21:32:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 2/2] PCI/ACPI: Use device constraints instead of dates
 to opt devices into D3
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20230802201013.910-1-mario.limonciello@amd.com>
 <20230802201013.910-3-mario.limonciello@amd.com>
 <20230803050118.GV14638@black.fi.intel.com>
 <06cf76ba-de5f-caaa-d1c4-9d34adf15a52@amd.com>
In-Reply-To: <06cf76ba-de5f-caaa-d1c4-9d34adf15a52@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:806:a7::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: a5304d46-c5fe-4d6a-14b3-08db949311e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiNi7T4g30b/fjFDl5IhmecL3T0zk65cUC2tPdIvmggxBimXIg4yq2r1IadoPngTACcL4CkRrkr39rTwYRi2ROPHQXjNI7ZqlyJjA7uDMseLG2jVI3KfsdpwFp7NNjQ8FZ2A+1aRpAvAU9tBVptsrhXJ7a0joOOfta0r89a71INW2BllVzbZBHUR3QqFLoOM1O10ZyNHui1b/CivO4b6riXEYY8FWRM5DwWM8irQrpZbk0hBwx/EqrpqSMcLzeW4lQJnm6KVV31rFZ3s2pp7UKiGroaCxIA3ma+QhucjQb8qsS6EOHDeCPNAlQAceMOurgP21ZSrC7g2JP4ld7XgiR3YaWQgzYVtPQDyOFh4jx/UPRKjCqQP2FoGg4rj4IYl8vilVwlRWoBVkH15JRje45pS2snuGfw5jQ4/KID+jpLa1AXRYecY0bwdqpZIWxh+8sLsKGV7Cbf97M+snVRlgvTd08M4+LSlX8Haoy7vo5WSw040QLnvyDkyUgQQNI9slsyHTiOEFgn92zR9udebQ7dhfGlT7zmi21zX7d5UbMhbzEGiH3B/co5YwmoKACSwnt4NrVq6rEOGxGLYRjc6YHl2cz7QxWkBviPHhPR0Se+Y4tWcXWzlIbrp3wIUutaafmoeFRK2fD7Ce6NF9Og/sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(1800799003)(186006)(451199021)(36756003)(6506007)(53546011)(478600001)(6512007)(6486002)(6666004)(54906003)(2906002)(66556008)(4326008)(41300700001)(316002)(6916009)(5660300002)(66476007)(66946007)(44832011)(8676002)(8936002)(38100700002)(86362001)(31696002)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aytsRnU0MlhGWE0vMHJ5RFRKaEM4aEtnOWUxREoxQ05lU0psZnExQTNwNTNa?=
 =?utf-8?B?SlpBbk90MHd1NW9QZkFDdUV3M2FSK1cxWlNWd3lHNmVPTDJlakliZEh1OFIr?=
 =?utf-8?B?TU9yU1RiZGIyT0c1QkwxYTByc2xYWUVjN3dlbDY4QkUyNmJPb25BS29XMDRu?=
 =?utf-8?B?MThRWkE5WERlMlF3MUQxdTRwdjZ2RFluOHFuRERNZXhnMTlRR3U3cmVqNmMx?=
 =?utf-8?B?azRLZmRjN0JPRE1tb09PWEJUc1BNTkl2Ui9sWXQvU25OTDhxS241cWQxaUxq?=
 =?utf-8?B?U0NoWitoMHVNQmZ0a1YxSWx4bUpXRGFZc05nU0wwZGljbzkzdEhZWmRnUlFE?=
 =?utf-8?B?VmJzYVZSM09JdU1ValZjcXduYkduRlI1ZVBEcEw1cWJndFhJWmpUeHcwait2?=
 =?utf-8?B?V2tDYjZwTDhmRzkxREV1bG1nVVdoRU96eHd1aFZqVm9qamlCUlVyMUtTNnpV?=
 =?utf-8?B?Q29kNEw0ZCtMUEppQkZiU0NJTnBaQlR2RHV6bG5WV2p1UkxOSzZrV3NwRGU2?=
 =?utf-8?B?MXZHSGt5bWViVEtnTS9mQkVLWVpSYkl6bTZ3K1RjcGxITlcxQ0dIS0xtM3E5?=
 =?utf-8?B?U2VzQlZrcnJOekpQU2NGaVdYQmVIbDdLSTVjcGJyT2dHU1R2b3MrQkg1NUcw?=
 =?utf-8?B?L3hBcTBqaEQxWEt6ckxjTWd5QVBOQzJXbmpNbjNwQVQzK0JGRnFzaXlCOWNE?=
 =?utf-8?B?MUJ4S2NZTVg2MkVnRlBka09TTStiSU9DaG16WHNzSEtYdGdIamEzZDNJb2Ro?=
 =?utf-8?B?bEVvZUM5anUzNGtjZVVXQ0xCMDFzN2tmVG9XaVNmTTNXcDh2b2N2RnFRNU9R?=
 =?utf-8?B?amdFcTQ3TWkxTzluR3YzZ0FwUjFDcnptOTZJVkQzdWJ0ZXhmT2x1Q0pNci9S?=
 =?utf-8?B?L0hSWGRibnlnL1h2TWM0dDZKMEpzUW1sSFBVbzcrSFhKWVpiMWZBTUpBeTJG?=
 =?utf-8?B?Nkd3c1ZYVmFaNGp4blJvWUJWRFBwSmlDOHBDRjdyRlJLL09qSFdrNXQxLzJC?=
 =?utf-8?B?cE1KRVRERVhmT3B0YkhRRU56VGRqNkw2alFYTzZyeFF6cGR3ejZabW0yeks5?=
 =?utf-8?B?cjQrMW54cysxeEVKbXIvRTVZZjhqZ0ZNRis0ZFQ4SG9EZjZhUkZqUUlBb0lq?=
 =?utf-8?B?a3ZxUGxDWC90NjBBMXhMY1Z6ZmNVUlVnMU1KMGh5ZzhvUzhWSDkvbitsNk1Q?=
 =?utf-8?B?TGVIM2NaWDZUc1F0OHlIWDBaUkUzMFhOb1R0cHVOWG8xTVNiekFNZkVEZXZZ?=
 =?utf-8?B?V3JhUG5CRW5HZ29yNGlTN2JwbTBnQk1seEUvbDlSdnZqczJsRlJRMURIQ1dy?=
 =?utf-8?B?S3lBb3E0bE1tZjJnSkEzRHlQQnhnN2dGQ3pyUXA2T2llS092OWNXU1I1Y2RW?=
 =?utf-8?B?bUdLMVd5Zkg2eFNwY2ZqYWlnMTgxZ0FlYlpOOG9oeWc1VXg2b3FXaGFqejZ2?=
 =?utf-8?B?d0NhSXV6UmhNTll1UU04eHNWY0RrVVRxTzRmdGdLRmh5NFMxbUtBM0tROGRI?=
 =?utf-8?B?eHNEdVRJQ0h1NXNPNHdJZ2ZUOXBaLzFaK1F0WkhHRllmbUVORnRUeDVKaWhh?=
 =?utf-8?B?Y2tPZ080aHc2QWN3YzRuRlJ3d2RZRTNsNTVNM1hCR3dCSTVFUE5pWWlyaHQ1?=
 =?utf-8?B?cjBwS3JDaXF1TXVhMXA3K1BPWDRkbjFjdDBmTmNsWmg5K2pxd1ozVC9HdXlJ?=
 =?utf-8?B?NUhMYlM2R3hyelByQ2Q2QWx5dk84Y2NuMG9FN1ZDUmRKYTVVQTI2U04ydUxJ?=
 =?utf-8?B?SUVaRmpHSWVmbm1DVjZueHFIaElocDlZaUVqQ2FQSFlxUnhqYkJnMURDWFpp?=
 =?utf-8?B?L1lUOWEwaktBSGl0UkFDam0yT2x4WTQyVjNYa1RDM3pMRUNLdWpkQTVBS2RG?=
 =?utf-8?B?TUx0ZnI0VDErOGJ4UTRZajZObUNtclFFMFk2VGRUY2UyMXM2ZnFmTisyNmdV?=
 =?utf-8?B?WVFUQjgwV3IwNGVqZDl2OHVUa3kySVVlTHV5b2pYZ0swbWdwRzYwdk5VN0JC?=
 =?utf-8?B?YkdhVGRrRW51Uzk3WHptZXN2THVNb21VVzNsakNsTWJoakVlamd6UVBKR1JR?=
 =?utf-8?B?TW5UV0l4bjdWSUxjcWR1aXM5aU5pdXVsQnFnOEhqeXdVZWhZb0Qzc0Zzc0Zw?=
 =?utf-8?B?M3o3NDR5Tkhtc3BYTkZSWWszZkFlaXFGcnFvSmxRZ3JzUS9pOWlialNDZHNX?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5304d46-c5fe-4d6a-14b3-08db949311e7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 02:32:38.6680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjLeMRxhAzJ7xlJ0I/WhfPB6pv6qvXoqLCPaxWMtbhNK2KxEaMG7RFbThqrv4c0hgt4ZNXr3oZaGiwudlBinMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/3/23 06:38, Mario Limonciello wrote:
> On 8/3/23 00:01, Mika Westerberg wrote:
>> Hi,
>>
>> On Wed, Aug 02, 2023 at 03:10:13PM -0500, Mario Limonciello wrote:
>>> @@ -3036,11 +3044,8 @@ bool pci_bridge_d3_possible(struct pci_dev 
>>> *bridge)
>>>           if (dmi_check_system(bridge_d3_blacklist))
>>>               return false;
>>> -        /*
>>> -         * It should be safe to put PCIe ports from 2015 or newer
>>> -         * to D3.
>>> -         */
>>> -        if (dmi_get_bios_year() >= 2015)
>>> +        /* the platform indicates in a device constraint that D3 is 
>>> needed */
>>> +        if (platform_constraint_d3(bridge))
>>
>> This for sure causes some sort of power regression on the Intel
>> platforms made after 2015. Why not check for the constraint and:
>>
> Are you sure?  I saw it as an explanation of how Windows could put the 
> systems into D3 when there is no other PM related ACPI objects.
> 
>> - If present and enabled, use the desired D-state
>> - If present and disabled, leave the device in D0
>> - If not present use the existing cutoff date
>>
>> ?
> 
> Thanks! That sounds very reasonable to me.  I'll double check it in my 
> case.

I've played with this a bit, and I found that I can make it work by 
moving the constraints check into pci_target_state() in the non-ACPI 
power manageable case.

To me this works pretty well to reflect spec policy ambiguity but should 
avoid regressions dropping the 2015 check.  I'll send out a v9 with this 
approach.
