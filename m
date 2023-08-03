Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B404D76EDE0
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 17:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbjHCPST (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 11:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjHCPSR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 11:18:17 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDC030E5;
        Thu,  3 Aug 2023 08:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfVfA707bmUSwoTvRAW5HBoy3v6BdksRQ293peN3vGLVhhUjzoDPajEQAMQeWntjmHv5s1JS15tSasvhs/16iC4bSlHx0+FNwPqJB8LXRoRqejqbjLRJvalsIMBJ4zsapqx1I4ORL+UPX5K6JUf/pq40xgLO3w6HxLE01ZgI8nYm2L8s7x08ZdgI70tfJUeiwzzHdVtoOyDauKTZ4YtopWcP6TIwmYLqJOsKbOxMp/5p4wdLBLXeLa+V3rw6vuna0CVfdOcKkvx7M5aGa9kMy2ONh7z0hnNWVD/dmKHQnt/6gk+JTmiWmTMpxe7Ip4gvosSrS3k50B08rWA7PbwBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aka6tMo5FTfZXHoQ2AaKF+tzFw9xGERjijNG6c9oQeQ=;
 b=NRzzpwvFuYY7aJc745RrV+s5HwDz2Bxcroh7D9yrfSkp/jt4ai/XsthFm9tHgwvEFTys+UefioM4wXMfj2gGkTFEJmG7sR+Jx6Kna4ZCvEEv9/IwH7hwVO3/CbWQvERLS4YL63p1YDZaYQPfq0QwgOZp8ckSyUKvYhbaO1uvimFAPp/7yS+nuFq+aTstrVuTZ/ME6Tv5yAx0NRDOEf5qRYqfJvN2/wv8uh5RpSQWG+SHEaNZX4S77oSnz2pMQrgnCPB80mzjYVmSm1mEmR27RdtCEPZX/RxcEUyQBkAmghgCTKSXSzxRbdk1OdH6foZlBu8o/v1BB9OoBANZMi8I+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aka6tMo5FTfZXHoQ2AaKF+tzFw9xGERjijNG6c9oQeQ=;
 b=lnTBUwDOaSRrUVfYm6lZ7G7eT44BZ/8p51JEHK76P9eSXfJZeHv4lWda1ZOhexvrTQRHH9pzwx7J/ZFViu8XdA/WzpNQkIXGxY/uJjDyqOdfyX/5TWkmKBJ6nMNLH5eO/A/EU/PHP1dEKJLgF1Q005TjQf1W1zOXSH93JhlHxVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 15:18:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:18:10 +0000
Message-ID: <208afe43-2539-156b-971f-89233598b687@amd.com>
Date:   Thu, 3 Aug 2023 10:18:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v8 2/2] PCI/ACPI: Use device constraints instead of dates
 to opt devices into D3
Content-Language: en-US
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
 <20230803151454.GZ14638@black.fi.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230803151454.GZ14638@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:806:6e::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: aa205a95-5cf3-4336-5229-08db9434d8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pg7JIYRrDm4ZFnxz6YOgzNoWId7hQIApRlN+MQadqsfIpOVmWHQzqkpndo2DQxd9L8dhRNpd61z6K2JoFoMW4by7evKeqMsA1JvrKINycMoj1KJwD3PwhPx8C8yHv9MHLgWDPD6lviFP00GEpm9lY1/47aHUUjwB9tcIeLizjKrPlVFrimDSt/TqkULig2MPQOZkJVyrRk0QzUiuBpEd+n7tEZiDz01FboTM2p944decVzVDotUg8RkBHgtZ+YY/vnQKgpodYbQrPYs/ayVtfmEG8UP2SfGYNGYMJSiMCWpbCvNvG4xcHN7CvlpjMfrwSm9m4XASSl8hBREoSxcGc0J4Vf6ZzfkyB/9dxD3GcTZ0VPsYry3g3jQed11NAbmv/PBPkaIKsGaa5tX1RR0x4zEc1E5Z9sVok+CvSyvlZ4/THJyD9uF0v1Bv8fuWZ3ginbrP+yuCFH+FeiDZikAhUJm+lIQsAC0mLE31VggFdeNh6TktLOqys46wS2KOZbf+IRMsUPxP7WTTzV0lRlJXhS/TeMVak/LZuMw987p26yZzThmOa1YQOK7M9TUbL4fCTkBPgZ9ZdFGPQlFEYNhf2lQfpDLaCPzIM1yjWFqUM9VmiQ7zwuzkGay4+d1w8Fd58hMuaZG/gToSiFal4ludHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2616005)(53546011)(6506007)(83380400001)(186003)(26005)(8676002)(316002)(66556008)(2906002)(4326008)(66946007)(5660300002)(6916009)(66476007)(41300700001)(44832011)(8936002)(6486002)(6666004)(6512007)(54906003)(478600001)(38100700002)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDlXTi96ZmF4SGRwT2h1QUpOYUhvUFhHM1NocUxOQlFDQWRtdkhPcUhvYUpr?=
 =?utf-8?B?aFQwSGt6ZTB2aGkzZlViSmlIVitsZjlCQjJjeUVtSGhBZHdEZEdsUWlacm1R?=
 =?utf-8?B?WElCTTFWZzlIMWxqYjhqamt6a2svb2NUMjhJRTZPV1M3aE9ENEpZYVV3LzJo?=
 =?utf-8?B?bGZsbi81K005U0dJTHVINHVTTGl2M00rNmoyU3ZVYkJ5ZXdvMjkxbHl6NE5Y?=
 =?utf-8?B?RlZ2eFNpZ0V3Y09kMmJqRVNpRlI3aHpYRmcySVFtMk1rUHBBNTU4bnJsTGt4?=
 =?utf-8?B?ZWVHVHFsdkxubEhYQjNYNlNNUjBudmREUmFjSnoyVmJ6aUNFcVFnSTMzYmRp?=
 =?utf-8?B?QitUL0tOZnNodElrMjVDdFFZMUdkWkNmOWhtd2d1OHJPMG5YRy9IYnN4WXUw?=
 =?utf-8?B?QWZObGZ4T0c4Qm52d0tpRVJOOTAzTjYwc1RKRUZLeFFBT1NPYkZMdGVkNlJp?=
 =?utf-8?B?TlNFYWM0YmxQRXJwZVY5OXlabXplRWlUcVRCeXFrL1psbTl1bm5uOHdiNGdq?=
 =?utf-8?B?MFFPNEFBMTI3ZXozdEErenBJQWVRTUFHQkZNNGFVNzRNMEtLYklEZElaUkNV?=
 =?utf-8?B?ZkQvOGhidFZZY0c1OGJTR2hQT0ErcjhIalVaT2oyL2w0SVpicmdIWkZCN0tI?=
 =?utf-8?B?NlpNL1lTR0ZLWWxhbjhYQkl4Ri8vL1J4ZHdzOCttM2R6Ti9kVzZ0WUZtcGlK?=
 =?utf-8?B?OHFucGJIQmdFVXlXTm5MMXFNREx5YkxLTENSRlpKbEFrVUhYaGNyL1NwQTZa?=
 =?utf-8?B?Yzcva21qUmlPRWppanhFVUE4Y2x2bGJ6OHVnT1o5TXJKb3hTZ0F6RmNoQ3hC?=
 =?utf-8?B?SkRkd3U5U3FHb2xWbDdZZVlFekJGRmhnTytNdnl0QkNIT2xUWnRzbnI5LzRH?=
 =?utf-8?B?T3E0K0luay9oRzdycEF2L1pNdnZmcitnQTlwdk1sQjhrejBEWGZPcUVCQlJM?=
 =?utf-8?B?K3NYUy9UZ21YN2FBajFpOFhCUTEvbG9WaVl5STdReWJzN1dVLytFOE9PTS9n?=
 =?utf-8?B?TmMzZitVNkI2c05CYkdDWWlJWEpmTVM4M252dlE5T29JMjY2Uk04eUtEamZW?=
 =?utf-8?B?UElHNnR5N3RuOE1CMkZ4QUc2NiszZzVVQWZQQU51UXlLcHQzdTg0Y0c5dlhR?=
 =?utf-8?B?T0VHOG9sbm96bFpCNkZSRnBnQjVOU2hrWndoN2hSekJBY2VQRFNRQjVuUmlz?=
 =?utf-8?B?ci9ROEFFUUtjRXZhcnlxQ2duWHROY0FsT0RBWnRKaS9lWUZxV3k1bklvUUl3?=
 =?utf-8?B?ckxQa3pLTVZVUC9ranhpVlVCSTVmUWxZODZ3R3BMQUNkbWNESWhGenN0SzdY?=
 =?utf-8?B?M0g4WmdhbUZ6a2RaR1NMaGs2MW5wOVVIdy9mN09nekxXTFdSOHJxRnBnbmRk?=
 =?utf-8?B?b1hsdUVER1JiWjFkNnFDbEJFYTltYTN2ZzgyRGtwdnRRMmRKQ0pzY3lUSkFE?=
 =?utf-8?B?MWJmM3R0LzFEU244ZVQ2R3NsUU9KdDJoNjhyYWpHRG1TSy9tTXUzOFQrbkwr?=
 =?utf-8?B?YktDbnF1WTU5SVNUaC9KdWpFcWNEY2MvWE5MOXlFbHJtdWJEMm0vYUsvbm5F?=
 =?utf-8?B?dnV6aDIwY0J3SXBZYnRpSDhpeDFMTGd6NDNpNG51K1ZFNThSd1VFcmh4cW41?=
 =?utf-8?B?bUtvam9xT1V4MGxjUVU0U1NvSkZPcWpDdVNxSllPY3ZSc1drSkZwSmQ3eFQr?=
 =?utf-8?B?STkyT1NsVVk3cUVOQzdnVmFIQW9jUnc5NmhVWGNYSUs4RHVrOGlvcmFKcE5r?=
 =?utf-8?B?bVNBMHpqZ0wzWnUrQVcycGEzZmM4S1JZNGd5WWdENlIrZmNJNW1iRnBRK1BZ?=
 =?utf-8?B?aXlKdks4dmw4NjVIQnNPeE9PdVB0dUdUeFBVMVF5U3d1MlRLZUx4c3RHcTky?=
 =?utf-8?B?aHZ2ejltTTEwZytLekVTc0Ivd1dpTnFoZDlRb1dDWUtUd2QweVp0YWdXZjlX?=
 =?utf-8?B?UDZHZzZPS0NOb3Yxa3JMb1JxR3pMcTQ5WUdQSHg3RWljVGs1SnBJbk5KUjBo?=
 =?utf-8?B?UUZSU2trZnFYb3J2NEcxUXpVZlo1RDJ3MlVPZG8yVWd3Uy92RGhaZ0RhRmhN?=
 =?utf-8?B?UXYvMWl4d1phTUhwZmhZMHFSY2JsMng4aDJ5aFBTdUFsK0JNeVRrRzFrL3pN?=
 =?utf-8?Q?EfEZN2TdQMrutoGK2mqXeIubQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa205a95-5cf3-4336-5229-08db9434d8e4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:18:10.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8myp642DLQL57vzJmlWwCmM5p41vF8jNerqi0nNUouqyOmhjE5PClNk/ncKG2n/soOjHdX5VzsSH79rpPR0jeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/3/2023 10:14, Mika Westerberg wrote:
> On Thu, Aug 03, 2023 at 06:38:45AM -0500, Mario Limonciello wrote:
>> On 8/3/23 00:01, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Wed, Aug 02, 2023 at 03:10:13PM -0500, Mario Limonciello wrote:
>>>> @@ -3036,11 +3044,8 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>>>    		if (dmi_check_system(bridge_d3_blacklist))
>>>>    			return false;
>>>> -		/*
>>>> -		 * It should be safe to put PCIe ports from 2015 or newer
>>>> -		 * to D3.
>>>> -		 */
>>>> -		if (dmi_get_bios_year() >= 2015)
>>>> +		/* the platform indicates in a device constraint that D3 is needed */
>>>> +		if (platform_constraint_d3(bridge))
>>>
>>> This for sure causes some sort of power regression on the Intel
>>> platforms made after 2015. Why not check for the constraint and:
>>>
>> Are you sure?  I saw it as an explanation of how Windows could put the
>> systems into D3 when there is no other PM related ACPI objects.
> 
> I'm concerned if there are no PEP constraints on some of the affected
> systems this now leaves root ports into D0 then, no?

Do you have any idea if any of the affected systems were something that 
didn't ship with Windows?  Like an Apple system or a Chromebook?

If so; I'd think it's better to treat those as "quirks" rather than make 
a blanket policy from the timing.
