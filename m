Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44710780D63
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 16:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377597AbjHROEk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 10:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377629AbjHROEj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 10:04:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1BF2102;
        Fri, 18 Aug 2023 07:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hz9Ml6oyiFzEW8Z+4nALAOtpuHn6Nmmqs8rAnsaTZoeJ4ThoMCjX678h7o41cOQNBMji8TjAyVQEjk9aDRJqLbzRh177dM/2EbpSdY+7WVm0SX3C+BPjMh39XciF4umy1jKEEydXCnHQxOUde96R9zdrcvlXnf6GSIUxls48BezWnXD0DFvsmi3NcAEjigYfUHHuJJgXitebzQBjX6wFKfyA4z9F+dldNKUXTzWJPwgtYgz5Qv6xaxhN6KA3KgT6t0r4trqbgTRYXFJuAkZdo1qlSj6dqrFBnSrabNUSgT0zJu42FE14lZMB5gwRk7xw+Iq+sQfc4Z31gdIUkBm0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5eEYtNEvrRa41YMUH+foX+EU7URILSYFnFrzjKLFu4=;
 b=Zu+EnEf9zpMzxohHIrepynvPdrqEAXqRsNsrVWjNiGJHb8HdYRFvW7tsbHYBGHifcyxcJ2Dk6d+v3NbX0lNoPD13LE9Uo7N6P3hWoHgtm7yvezhAav4IbkQLITCjA5w555FN/wYs2pdp41cqdYdOtcJ0oP9kQvMLJH3Bp4MmzvT70IzahOPaK6ON/tnxnwWrBrK7iWZh7c9WlurKrFuwptx6IQpl0r9eQkRZJPJa61123KqqHpfKZmN754p4au6ZqWhZF9cdE5LV+VR+32bjyNprfZlsZjJliU4eSMswF58Kt3WdOdYUpBUEvhAVsVkq4mMhETLnp9PZDLrqlSkMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5eEYtNEvrRa41YMUH+foX+EU7URILSYFnFrzjKLFu4=;
 b=EQG4dfMgI9wOBimzKxH5K851Ls7/nfdXVpo074VrBVTGykO4LXw6K+M9xpEFnLfTYoRPts5rQtqmqivUDFVFPUAlv2vv8W7mVxsXLWLkSAlzOgjmyXnnjvgVzqBeTo7+JEmIRE8hTrW4olh4IoPOBWfn2cdosCx5jTTDhgI3K6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Fri, 18 Aug 2023 14:04:34 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 14:04:34 +0000
Message-ID: <0ed1f73e-3931-4e22-ac7a-22ce57094d67@amd.com>
Date:   Fri, 18 Aug 2023 09:04:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/12] ACPI: x86: s2idle: Add a function to get
 constraints for a device
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230818051319.551-1-mario.limonciello@amd.com>
 <20230818051319.551-10-mario.limonciello@amd.com>
 <CAJZ5v0heB1yGcEzJCA88tyEhFi_LDWcHAF6xsrEFgH4j-DmT7Q@mail.gmail.com>
 <ZN9MQMjcNZK+Ul9z@smile.fi.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZN9MQMjcNZK+Ul9z@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:5:333::16) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a120d7-5367-4c9e-ad4d-08db9ff40c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+R9LLte1iqUxTlG17McXQRhTuJKQ1fykHR918Y/F5PDAgahBOuEa9t7z7v5owJifefMRrKl3CDeKLfMyZCAPBZMv7+AKwt8R0lgrnYfZmMoRIK8WZJBMGDdrNmQhHC/0zBXrZ8izdi+v+ZjdqZ6oioIMw7FC4Y8SyyqrChtqRcix1rNNUY4bykqvRg+kyDMmXFMiVL9H6bwS0ArSmNI4CmXBEvSi/Rp2asgX/Mg/udHOdDxsK+x0BlGSJoP2xLFhGfhbs4jTqNmjFTtDaOSTPWl3yLXzkxsdOz8qH6WS0oa5ZnHBFm+GqbiYVdMSi2RDeMyexkzXs7jW7Nwh38H2PO65N0yMZn7HfCkyuW9KNOZc0tMJhudCpGOGR4gvEKNmpQ3pJMNFwpd/61su+IXeV9e5gDsHIkiRtV1Gw0NtRDTAtEeOhgLyLXCknHjg+f7SRTWsFanQQuqm5/k6tgsAhLkUjZTANZI8qT39pRhBsvHGa4Le4Xu/kJxj+bYwKR7nOXAu6zYFHLNdiCggmQjQbrZ9h8Nnr1zfZn5VNpZF1mfQd5SCfHkx0M9Qqz/3LD1eKzxQmAd0khhO7vjL1oyQ7zlmeWB5D3zIT78NCG8BUpA3vh3JM8eThD/so178nkfO34LgKOQYv36RCvIZYCSxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(186009)(1800799009)(451199024)(2906002)(478600001)(66556008)(66476007)(66946007)(6506007)(54906003)(6666004)(316002)(53546011)(6486002)(5660300002)(110136005)(44832011)(2616005)(26005)(6512007)(8676002)(4326008)(8936002)(41300700001)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhKa2tlOWtKZkZCWXlRUVNoSXlYSTE4S00wZkkrYVNvM2YrN3YvNmNCWUlq?=
 =?utf-8?B?OUVJSDZNVU5PRlo1eXhYbFVXQThGTHNRQnU5R0NYaGFDVHBza3FvVmpKejlt?=
 =?utf-8?B?VVFsTGt3Z0pOczQrT3J5SU4vVE9xU3pjR1BxVGIwRXRoc3hhNk9vckNTNVhw?=
 =?utf-8?B?dFJjR0Q1dUJRbFlvZTY2TU90ZVJPYXM1NnZrWElYKy9YbFpiQzJWV2NEUTZx?=
 =?utf-8?B?Z2tCclVOTGRnUlNZcDdmekplOGplY0piSWZDWGhjSnFWSUZncVFIYS9HN1dF?=
 =?utf-8?B?YllrbUoxNWR3elJBNEdkbzlwYUs3b2pOLzU5cmZyL21jb1dnT0NDMUlRTjlh?=
 =?utf-8?B?bEFFYjNaQkV6N002WDYvU1o5YjNJcVVKTWhlZWZBOUYyNDFSd2hiYXIwTXE0?=
 =?utf-8?B?QVVQNWlhOERjUHFNaHJCbXNnd2xiMWlTMG5paktuWTFMUldhRUVPd0lEcmlW?=
 =?utf-8?B?MXlISjd4OHozcmtBK3IxWGVabnZKQ0ZkTGJoNEM5UzVCYXJ2RWZXWU45NGhG?=
 =?utf-8?B?NkRQZ0NQRUFBd3BVaVdCTnJ3NHlraDZyd0pxQUg1SzA5U2R5cHZrcjhXaVhz?=
 =?utf-8?B?a0lYYWRONzQ0dCtiYnpKVzlBWE0zSXcyRUVKV1Y4YktKWm1EenRkUGxZMTc4?=
 =?utf-8?B?d3YzNVNoSUMySnJWRERwaWdKNDl2MExjZmh1Y0M2UHpDT25wRERQdnhOK1Vx?=
 =?utf-8?B?ZmJwWnZXczd5L3BaYTAwTDdaZmVYeFNNU2lneHJOTTNnUTVQS0xFSTlYZUxo?=
 =?utf-8?B?SVp3QkFtOWFXVVdmcThuZmM4VHRJVWlRdnpGZmxuaTBjYzBsOXg1MWFvRW40?=
 =?utf-8?B?V0VPTDZUTjBzM2V6RWVuUkFpUVU1NnU3YWFFemw0TnBldGZYd0Y2SXhBbjJM?=
 =?utf-8?B?VVVaZmpyd0tLdE9XaTd1dVpUcHI0YU5vWTU2cWEwcWVKYzZKdFZwcjJiQy9u?=
 =?utf-8?B?UXhnMkFrZGhiVm96Q3FheUhKbEU3TTJtb29XN3M3cE9zVDB2SVc1RGtpVWNa?=
 =?utf-8?B?SW5LNHoxVlFFWUFFQ0VDZW9QbnUyMXh2TGJ6M1FaRGZ5U2c5YWVWVGJsRjJX?=
 =?utf-8?B?MUswU0JkNTFYRVJQN1E2c2gvNUkzQW14OGdRYzZmb2Vvd2F4Y0Rybit0NVN5?=
 =?utf-8?B?QjBtbWw3cmtvWUF1MDV2YTE4Q1JvVXE3emdKbUM4VUNyTUlYb1Rnd2Y4emJh?=
 =?utf-8?B?ZGIwUWtKeUxsaC9NdXdxV3JkcFZ2U0JDQVI0QmlOZWxacEo1UFpSWUhKcWxP?=
 =?utf-8?B?OUtiRG03S2tlT2pQRGZDL1d4YURCdEkwdC91M1VRL2kzekZ1WmpDVFk0UTIy?=
 =?utf-8?B?TGkwWFpPYVRuSGlTUHYxSGRDWG9xU0hpYnJadCs1VzlsYThsMXd5YlBlV1Vv?=
 =?utf-8?B?cEtoWEYwalk0T1dSTUFERlBibGxqeUxJYmxMakJhZ1FGb0pSZHpHZVZtTEhu?=
 =?utf-8?B?bk91YkJsVXlNdmkyMVVXaXdXQ3BKNDNVNjF5TEpjeEhiUmxnb1ROTFVFeFpn?=
 =?utf-8?B?bzFqYSs4NFRVTzZFdG91a3I4OGJVbitEamkwNldUdU9nUy9PYWtra01rVnBG?=
 =?utf-8?B?b2l4ZVVMdXJxd0ZtMDdCYmdGUUs4c1ZUck40SXBHeUlJOGg2ek0wWlpKVFFx?=
 =?utf-8?B?d1k2TUxBazZhYTNUZVBLUHFNU3h2Z25FZ1ExWEtiQUtuSXcvUWN2dWFiSWk0?=
 =?utf-8?B?Q0UzQ0F0Qlpkd3BGSzV6N25LdThZbldpUlRJQSsvN2pBMGZNMDM3QVBZZ1Zt?=
 =?utf-8?B?T2t1ZVRCL3hPd2p5U3NtK293RWpsaC8vYndhMDdvV0MwK29DcGozdVBqQkw1?=
 =?utf-8?B?dm9JUXlkQ3hvT0k1aGlLRGJ3MXFpUmpOMHBrNE5ZL1VtN1hKZ2ozNnFuSGNB?=
 =?utf-8?B?VGNnaWJBNTBHNk5RNmY0RlBDWjR4WE5pVkRYeGVpaHh0dWdzOElOV2NscWVr?=
 =?utf-8?B?WXEyc1JJbUJvOThUYVhOd3p6Ymp2eFBnakhsZ1ZuYjFMcU8zQk1YQWdjWVFu?=
 =?utf-8?B?ay9tcUxPSUhYREhKZVIwT1JlbndOMDNhNkd6WGI3Y3cveFM3VWhjR2x0OW1Z?=
 =?utf-8?B?Vk5NTlhpS1lDeDEwQ3dLT3NZKyt1dVRUZ0wrZ0RrMW9uK3ZjNEpzR1pkWW1o?=
 =?utf-8?Q?ZZgua5pIf6Cwylt66CVHvLGIe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a120d7-5367-4c9e-ad4d-08db9ff40c37
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 14:04:34.1400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AipsMSrbmtrdsTBZ9LXfRcNVQuhIVdSOvxh/K9ROYebHWIbguAtyUNtv7sZwZUuA+TeCVU3XKHitqHv3TPX1Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/18/2023 05:47, Andy Shevchenko wrote:
> On Fri, Aug 18, 2023 at 10:31:03AM +0200, Rafael J. Wysocki wrote:
>> On Fri, Aug 18, 2023 at 7:15 AM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
> 
> ...
> 
>>> +int acpi_get_lps0_constraint(struct device *dev)
>>
>> I think that some overhead would be reduced below if this were taking
>> a struct acpi_device pointer as the argument.
> 
> Hmm... Either you need a pointer to handle, which involves pointer arithmetics
> or something else. I would believe if you tell that ACPI handle should be passed,
> but current suggestion is not obvious to me how it may help.

To Rafael's point about overhead there are potentially "less" calls into 
acpi_get_lps0_constraint if it's a 'struct acpi_device' pointer because 
it won't be called by caller for any devices that don't have an ACPI 
companion.

> 
>>> +{
>>> +       struct lpi_constraints *entry;
>>> +
>>> +       for_each_lpi_constraint(entry) {
>>> +               if (!device_match_acpi_handle(dev, entry->handle))
> 
> Here we retrieve handle...
> 
>>> +                       continue;
>>> +               acpi_handle_debug(entry->handle,
>>> +                                 "ACPI device constraint: %d\n", entry->min_dstate);
>>> +               return entry->min_dstate;
>>> +       }
> 
>>> +       dev_dbg(dev, "No ACPI device constraint specified\n");
> 
> ...and here we are using dev directly (otherwise acpi_handle_dbg() should be used).

I'll just move the debugging statements into the caller of 
acpi_get_lps0_constraint().

> 
>>> +       return -ENODEV;
>>
>> ACPI_STATE_UNKNOWN?

Much better, thanks.

>>
>>> +}
> 

