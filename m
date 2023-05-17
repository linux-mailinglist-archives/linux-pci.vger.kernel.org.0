Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87DD706836
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 14:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjEQMd0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 08:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjEQMdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 08:33:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362E32101;
        Wed, 17 May 2023 05:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKMbQssgBeS+ePhxDQe57cLJg0o2ct7CtgmGhjPDIB4b0+O7oTnpLrtCnv2zqwzHz31Uy74F3vXmhdW2CSHaRTkhTW1wPyS/EWeHT6VOrsOdsk8FsSKRrbmsQhdLW673ftwVvwBTutvTROheqHW7oTlWZK/prupBxFnWhbQ8vpKILZZK+Js96EY8cRE41r64tOwxeYbZ4v9FzGNXimR0S4nuJMMWrsc8hU/BupkHaldPG/25oFIkhtyYAjt6U0ypaINIgALkvLVQ5pE0dGp5VmTStkvR8qgyluTm+lDesotlDz2FxN6nFa/jaTbfCNMeVJlzoJvBbpsoiIlzWpEtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcn257jqt50UQnfinT3HB0mItESfQuYPNInIDt1bKLo=;
 b=iN7+Xnm8mLksQ0SJYUxvZyoXsx2uafJ2KuQS1SK9yie9Kk/kMiHXzCtXkI+C7EbJa4YhJxxJXjSJaPSP/jEetf0TWAHGtJmAJ+Gx4Q+w7Ka6ZzEZCnfuyfFOY2Rc661VuqW9m9zaiS45ZxidJmZpRvXDgJQ1SnS1Quv74YCtE0LeurdDs/VvA3wyuKT02OplrmhKvFGlJaLyOt/oqlbztAHTos5uwg+X+K1phmLK1jPtJPH+/oHBAfeubzAW6hlk7BIR0Nf672Wz4PUcsHuEjS/vGxKkNaklGj7hYS2mIJqX6+Oo2Gm29rq1E8M82WfUgoOrZ1lg7b04AeOv4O/sQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcn257jqt50UQnfinT3HB0mItESfQuYPNInIDt1bKLo=;
 b=M6n4fPrfbrKoWh6MHjk25iHujJoZZjlx9i4mzcDvLP6Yuv63um2RKvqutr90SBbEbNvlZlsQS6d5Cxw5KAUacegMEZ7Ca7eu/gh7Ca73YQ4G5W4tF2T66/rtLkwnOQ8Sww1o+X/ciem1nYk9wvTOVofdzPj9nVVWMs5B5/WWdvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB5170.namprd12.prod.outlook.com (2603:10b6:610:b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 12:33:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 12:33:19 +0000
Message-ID: <8e7e23dc-f01b-6f78-f383-7706795e386e@amd.com>
Date:   Wed, 17 May 2023 07:33:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] PCI: Only put >= 2015 root ports into D3 on Intel
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Limonciello, Mario" <mlimonci@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Iain Lane <iain@orangesquash.org.uk>
References: <20230515231515.1440-1-mario.limonciello@amd.com>
 <20230516055918.GS66750@black.fi.intel.com>
 <f0417d28-0c1a-f46e-9cbd-f20f2ac1e9f9@amd.com>
 <20230517071527.GU66750@black.fi.intel.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230517071527.GU66750@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0113.namprd11.prod.outlook.com
 (2603:10b6:806:d1::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b17f05-2d81-4f47-9b6e-08db56d2e51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lcbJ3sIPlIVC4DZgQm7rnarlARWebl8a5pMGafA0qy3NrtxvwCyToGAC+ISVdN4XKT4JBNqjc85UFW2yEXxkfzA+FG2dpVrNJC9xDLGBFE7syO7v6Wvu8iGR7hAOOCXMT+g5EMtsx52V0JlgPbeW4EVut3auoFQKL/iywFUVtfvr9BbNWiOfeHO3y97tlfMtP7Wmep9K4J5vagsJPYSqOaBngX7G6CoCMREqx+rdhKLvJsXWy5JwuWjUvTC1Pqsyxj6qQlf2Dk2jRREGwo54J5K5Oi/QISNqyA0rRPlyqqcVTF/wqEdcXJ8agu9ITkOiZBqjsrPMHexuGjDH4InuH2Tj/O3F/GN7w7ccOab0j08j3L5BlfsFgIvTSjUQUZ+j0lSw4YzAlqXk7HmD3it5acCOHICPtf7M5fhdSAX5ky4bn18n1LXCgMKXqi+2OgHFONYR/hgnEY5XGZxQwRnggEUD0KjeVWFaxKH33T8A9vzCInOg8XUqh5WtMrNooYyRhr9KWw99VN9YNFVrqfmr3sjNgvC7A4dcDZF2jU6+J+rCj+MFW5vHOdMF1TWOauY9wW4sJffN74HsUrSi0eSPLGlt6OcDu/O5HL4u1mNqaXOxVPd/fACyb0+widn3biYqy9JwY64kgOUEjVpNH0ecIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(5660300002)(41300700001)(2906002)(36756003)(83380400001)(2616005)(86362001)(31696002)(38100700002)(26005)(186003)(6512007)(6506007)(8676002)(8936002)(66556008)(66476007)(31686004)(66946007)(478600001)(6486002)(54906003)(316002)(6636002)(4326008)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnJiVHgxYnd6RXpDWHdtK3UxZDhpTkVsd1dLOGdxcDVZMnRJNkYyZVpzczI0?=
 =?utf-8?B?RkhYaEJSQW1pWUVHTkh1RER0TjZobnBNb0poL0xBQms0R2wzT3VTS2JLWk91?=
 =?utf-8?B?UGJkM3RURjhFU3NXUE9MRWhwQlJCYms3MXF5cmczV05VMXBNOFdzZWFvTlh5?=
 =?utf-8?B?VnBid011VUZ5ZWFVMjM0ZmRCbTJNSDBpUGt6amt1U2NIeHRJUUZsNkVzSzZw?=
 =?utf-8?B?RVh2Y25OK0FvZmlQektzZGh3MU1SQ3VZem00V0JsbWZzMWxuektyRGEwdVNi?=
 =?utf-8?B?TmFPbW1KcE5BTHJzeVM0SzBndEwxYTFqZkJMdVAvVDZQeU4ydVRWdk1Fb2h4?=
 =?utf-8?B?LzdvWVJaRXRwd0F6anE3N3crWWdFV2ptMiswQkVWR1RXekhVY3laQThSOEkz?=
 =?utf-8?B?eE5UWnBLUmszSW1JelV3a3hwbExVTDJOZGlhMHVCWjFOaDU0enpYVHJoMXBt?=
 =?utf-8?B?cVZhbW4rblo1OFpuR24zMjU3eHhnckVCQjBuYTBwRjhZNFdSNWVPZTRUdm5U?=
 =?utf-8?B?bHFuamxOVXExLzd2RHE5ZVNpbmZpdUdRRFRvQXZBRkx6RVZEOU81OE1CK3hD?=
 =?utf-8?B?YndzalBwN1lqQjd2QUU5NCtNanVicmZXSW9pbDJZcXJNK0Jid3hGdVRzazNk?=
 =?utf-8?B?c1l4ZjhoM2sxcEM0Y1lhaU5tYXloWGlwanVFaXhGRy9wYnc3RlJyRFFacDlX?=
 =?utf-8?B?OFNCbVNYMS9hZzQxWGJvUE5Xa1V0U1NFOUhLMTU3VkFzNUl5NzRPSzhPTEgv?=
 =?utf-8?B?dXJEaitRNkg4TzRPVkVVTC9hUU9YM0V5d1IvZVZTZno0NzNLZzNLdXNSUFJ1?=
 =?utf-8?B?cWhqaXBLMSswaUlGQld2aU1Cb2x4Z212dnljakpTM3ZKVXNlc1Y2MWUxZkJP?=
 =?utf-8?B?akxlL1dud2lNT1VuUExoUFBpSlRQY3kvMlllR1lTYlU3TVpkNjdBeHBJdEE0?=
 =?utf-8?B?QXI4S2VDVExPMWpZK3BXOElEelBqZGVEZHlLeWhLd0xhWjl4QkZRMmI2Y2Z4?=
 =?utf-8?B?S2thT21lbkpMdHJVaS82TzdSN2lvcldBYysveGN0VjE1OUtieVEvOGkvWnR1?=
 =?utf-8?B?Y1A5REFnckIxRm5UODRacGZyOWtDaEFidmlqRVZUSWl3aEpNZm50V3krN3ZG?=
 =?utf-8?B?STd6eUllVk1iTjYyaWljUjlMRG1Jb2picXYwa0hmTmRCSUl2UHE3NHRrQ2Vh?=
 =?utf-8?B?WkxVa29qTitQYlJBNEtKRWJLTHRYTy9SUXR6TVlCWTcxa3RDcGwydC9XVWps?=
 =?utf-8?B?YnJPVzEyUFU4d3hkNi9Ya2x2NmZZWTgwSlh1TnJVSjJZUGJuVHpSbTdHZUNj?=
 =?utf-8?B?Q2JQamcxQ0ptNGY2RVFxWGx1OFFwN1g3T2FRdFJnc2UydXd3SVRFckxPMjJK?=
 =?utf-8?B?d2p4M2k2WE1qUk01Qys1VkIvaEgyTGNiSkVxOUFyZThmNVgxWXh4RVpCM0ho?=
 =?utf-8?B?czRrWEV1V0hlV0tVT2NmK2F6VWtMZVhPYi95K2NLN0Y1eTJXdllHcHIzaXl5?=
 =?utf-8?B?TlJ2eTBLc2NaWkVwMkNlSDFyZHBxclhCd0pvTmVLODZ1SC9IVTZyQURkeVNs?=
 =?utf-8?B?a2dqWG4vRVUyalNleFpXREJmRUlkOHhCQm1oQjIra0dEOE9aZmt1N3p3RTZI?=
 =?utf-8?B?UEhuWHVocEx3SkROMUU3enBGWTZMZkU4dVBROCsyeStIc1Q1eVN4c0VlWjZL?=
 =?utf-8?B?NWRyNHZ6aE9KaVYrU1YvSi9nMGZsT2ptbTY5OG1Ubnpob0NtZ3g1SFVLY0l5?=
 =?utf-8?B?NGcvcmxlUVM1Vit0aVBhYVFhenM1bkdoa3pvcFdRbWVUNFVMMVJML21EK2Nh?=
 =?utf-8?B?c1V0RUNRRmtlaTBEcVFpQzM3RWNQQ1M3UUYwMkFoWGp5UU12N2hQV1JvcGVw?=
 =?utf-8?B?Vkx5Nm9ZQTkxaVMxWmYzc2JzdVVrd2dYKzRlclJvTFA3cFlZWnVsT2NrQnBv?=
 =?utf-8?B?WE4zV1hWSUJqZ3dUdTE1QnhmalgvL01PbW5SOTJLbkJzdzNNVWE5bTNWakh5?=
 =?utf-8?B?Qzc0V2p1bkdtL2tETlNKdmZ5RzgyblFtbVBQdEkydHgvWm4zc3Y4N1ZPUmta?=
 =?utf-8?B?RjNHODFBNmladUhTL2tSbXJ6Z21yajBKbFRmbFZSMkgvT0Y3RnNaVEFYdGFt?=
 =?utf-8?Q?yZSmczX6hTS5egQYUPUuPanLv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b17f05-2d81-4f47-9b6e-08db56d2e51c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 12:33:19.1614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4Ps8hsvDJ/hvQF0s7n+8b3QhDtVSGVHQ2uFBPPuenqrUmo42G5CHYqKyKGbUNJZp0EEbQe0t9kjpOxfgei6sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5170
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


>> AFAICT the actual issue is entirely a wakeup platform firmware sequencing
>> issue
>> while in a hardware sleep state and not PMEs.
>>
>> It's only exposed by putting the root ports into D3 over s2idle.
> But there are two ways to enter s2idle (well or the S0ix whatever is the
> AMD term for that). Either through system sleep or simply waiting that
> all the needed devices runtime suspend. There should be no difference
> from device perspective AFAICT.
On AMD all devices in runtime suspend and SoC entering system
suspend aren't the same state.
>> As an experiment on an unpatched kernel if I avoid letting amd-pmc bind then
>> the
>> hardware will never enter a hardware sleep state over Linux s2idle and this
>> issue
>> doesn't occur.
>>
>> That shows that PMEs *do* work from D3cold.
>>
>> With all of this I have to wonder if the Windows behavior of what to do with
>> the root
>> ports is tied to the uPEP requirements specified in the firmware.
>>
>> Linux doesn't do any enforcement or adjustments from what uPEP indicates.
>>
>> The uPEP constraints for the root port in question in an affected AMD system
>> has:
>>
>>                      Package (0x04)
>>                      {
>>                          Zero,
>>                          "\\_SB.PCI0.GP19",
>>                          Zero,
>>                          Zero
>>                      },
>>
>> AMD's parsing is through 'lpi_device_get_constraints_amd' so that structure
>> shows
>> as not enabled and doesn't specify any D-state requirements.
> AFAIK this object does not exist in ChromeOS so Linux cannot use it
> there.
OK that means that if we came up with a solution that utilized
uPEP that it would have to remain optional.
>
>> What do they specify for Intel on a matching root port?
> I think the corresponding entry in ADL-P system for TBT PCIe root port 0
> looks like this:
>
> 	Package (0x03)
> 	{
> 	    "\\_SB.PC00.TRP0",
> 	    Zero,
> 	    Package (0x02)
> 	    {
> 		Zero,
> 		Package (0x02)
> 		{
> 		    0xFF,
> 		    0x03
> 		}
> 	    }
> 	},
>
> I'm not entirely sure what does it tell? ;-)

It's parsed using `lpi_device_get_constraints`.

So should I follow it right this means for ACPI device
\\_SB.PC00.TRP0 the constraint is disabled.

It's described as
Version 0, UID 0xFF has a minimum D-state of 3.

That means my idea to try to only change D-states at
suspend for enabled constraints won't help.


