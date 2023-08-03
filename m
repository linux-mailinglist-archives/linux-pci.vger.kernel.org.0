Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D02E76E712
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 13:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjHCLix (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 07:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjHCLiw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 07:38:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2EA1BF0;
        Thu,  3 Aug 2023 04:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuQB0G1iWjGj8aO8OQYKbqbs0lfiMp0RT3q2rQr1shENW7V1Z/OWjmMdSY09LsHgqfawgjrDCA8sDcQSLcOpZplZL8g2ssaVHz7lKy9M9hQ8oQNxf1HHd4Jtw61GZvMOLLfqwmwrA+uGZsjYn0gyguUJ3D2nxcktk0mXZYNsdEcdYFz306DruMqFtWtEOYKwtyXxr4uXn8kDKAC4Auc0D28K+WaOablPgyyHh4wwYzaZzVIcb9Z9oSCw6BIUEHqPY4LvkkfAKT7d/aoierQWABroJcAf3Tu/MulG5K3WZ408466SvyIWQuSL4b2QeJ9APn8HWPsdKANKVDshRermiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21evKWySk+uoxZbFopg6reFc29iIZUrbM0vzvFefjGA=;
 b=FW63qK0Y8jhQ399wR6cmmwWQ76nhVCmT6yxsRTkPNNF9GbYQH2y+Rs9nmNA2uEQ/K5nwq+nS0W+d4t9m7j2BtYeqcHN0Glck4joSDMp/g7AQDhhzRLwnSnEWAO7EKQIL0wIQtQZvAyQp1dWsaxVqGl5WWje1hFVFkRz8GrDAFUCe11lTu2jHvJdtZsQnycPmxVhkOtHCNm0iv4En9cPytLK5KXCTasnwxypCIGMf/JrLOI9bc/WsoKdEB7W0reikzCXorQrh1fx4NiVpLneO6E7saLpOo5eJZOKsy1vBuOhjaOQwqoU4LOZjgmtAhhlRN91uIJoMlJIa6MXKcQBPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21evKWySk+uoxZbFopg6reFc29iIZUrbM0vzvFefjGA=;
 b=OechxOzLC/IysltJ2Q/DrNF1C+he+eJyTx1v+JbFlJXdIwEF2gQFtSYNao1eTmlz6D/3P2DEr+1n8kJGVSIzGWX4xWBfwuTs+gnLmEQnrZysO2bJRJ0ibYalKeaSjbkE5dBd6eiBMNJQv0dfwiYck4NntzYYq8AlUcn3JVd1BbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 11:38:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 11:38:48 +0000
Message-ID: <06cf76ba-de5f-caaa-d1c4-9d34adf15a52@amd.com>
Date:   Thu, 3 Aug 2023 06:38:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230803050118.GV14638@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0023.prod.exchangelabs.com (2603:10b6:805:b6::36)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: db2b2d33-2241-4375-32ed-08db9416339c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SryOXunReapkjoecQ+dfm8X2OHHrzIauBze02u/5di6nOhbnVNNdPoeMqtXsoH+zb1tOAlS29Fh8PjuKyE71r7uGm6rcgiAKLmXLuGLYUHT5P64nKxL6cmS2yaS8/dGDdAjkeKIURjBnRYwGj/jaZ1R6dNkkig4UTLIJL16yNCZ8LiYg7CqNJQHU0ZRRz41Ry/f2stfzQByFLpxs3kwQ6RUyAS4tQUzDBFJOvA8GmV/BCGA7HqCuAjtGObE6iEwgac9R17znhM/L0LCidGqL1HekVwiugNqPH2g52RkTYXTaMpalM1tZ3KjFNXVWlK9yf4g2GVIFCWsb/vADShLLO9VGXQQxmJD1VIG0mzBh4J9N7ADFNVS3mpdRz0BIUmKONQJHeH+Jh5mVhfbFSGvHYibTZSirJ5l9ptXoabsP1l3JML+QTfWJpCO83hyjkht/XUoTih/MaUuqPoxNp9LUXobgFuiyXfgc3qww9iGK4+p/p+/tMIRNSJdvZeYzWGgleBFqz7h0lH5y9/ncM1B5AKWzNmDHHHuGtrtNuXHOUqlcp8mfXYdbe8eYd15+JEQlXZwIwazcKoXDouoXLqEm7R+QP22B7bJ7VW+TK5bHEgU3TKtGAIVgJW3z49p0na0rRQeiMA114BqhKsY6ZPfkUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(41300700001)(66556008)(316002)(2906002)(4326008)(6916009)(66946007)(66476007)(44832011)(8936002)(8676002)(5660300002)(38100700002)(36756003)(53546011)(186003)(6506007)(86362001)(83380400001)(2616005)(31696002)(6512007)(478600001)(54906003)(6486002)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUduVEhYZ0FRWUhaZUxKeThlNjFyQ2M2MEVHVUQ1cmo0WU5EQ01YejZ3K205?=
 =?utf-8?B?MnhpYXFrVWZmZGZ5U3A0Y1ExUGgvdGd1U09XZE1JRTNiQ0s5Tm5oRzFMUHpk?=
 =?utf-8?B?WmR6aldCSVhpaXdJLy9xNjExOHpXMzRIenBCakVNdjNKcTZ2eVZLMDB5K1FZ?=
 =?utf-8?B?OENrT1pVOUxSaVRmMW1SNjNTTzArRCs5MFlmZzVzUTNiS1Q2dUx2dWU2Zjc2?=
 =?utf-8?B?UUhJWUJMRVhEcVF5ek1EaDhOTUlIbFFMdFRVVlhBdFJJeUxPMlo3aXkzN1Vh?=
 =?utf-8?B?ak9xV1hUdzltRyt6elNDUGZQUCt2dS8xT1VsejZKb3ZuS1JhQW9WNHBLaGhN?=
 =?utf-8?B?RkgwUVJ2VklNRis0K1p3ZG9UYmNMR3BWcWlIT1A5ZjJtK1VBMWJvUUppeEMy?=
 =?utf-8?B?SDlDWmtSL3BKMCt0aWxiT0tKdFVRd2lMQjBmWldwQlNLRUtCRHhzZFBtQUFz?=
 =?utf-8?B?SmgwT01SUUVQRmdmTG55MGlMT0J1cXEvV2RETXJ1SHJLQzJwcG92cWw0NG11?=
 =?utf-8?B?dE5qV1BWRGRKR0oyUFE5dTcxYXRtUnlNN05kY0YyZmhTVTlTOWE1ZTVqbE1Q?=
 =?utf-8?B?WHNGMGNGdVlUU3ZLcXFBWklvbDNBTks0TTE5QndlQWRMZm8yN1N2MGlSdDBJ?=
 =?utf-8?B?VDRPNzRSQ21yMVlzZEhEKzYxd1k5bGNEYlRnYXJBZm1kZGJDblBjdmpZV2xv?=
 =?utf-8?B?b282UVNsaXpwUnc0OVhNRmQweUlxdDgyMzBNd3dZY3FLanZmdXdlcDkxY05B?=
 =?utf-8?B?N0FWUzRFYVJZNktlaVIvdm1maXpDSjk5V1I0b1FCY1F3anJ6TnVHcnhtRzBR?=
 =?utf-8?B?Z01qaVF4YzJmOUczTVNLRjM0czV2YThJS096bG5JanVwbGlmNGJtUmpYK0ZJ?=
 =?utf-8?B?ZnJVODJ2YWQ1ek9jbmVGMUhTS1IxTGVrZzUvU05pOW1MT2pHdkFDREkzTFhu?=
 =?utf-8?B?Rll2VU55cDUwNlVEdlhXck40bGJneVVuM0IrZlVmZGF4ZE1vK283ODBBWjhJ?=
 =?utf-8?B?VG5Jeks3T3BEUmZYb3JraEJ5cmNXNkhaRW1xd3B1TmpUU1dOWnRta0lrVkhr?=
 =?utf-8?B?L1ZQMXRUWGg2OXlwWXlRUU1YRnhPZUlGbXY1bjE0eVJDMUxDMUI4eXYzU3dG?=
 =?utf-8?B?bUhrZjFlMDB5QlIzaW9MaVdBbTRwdmd0T0hEYXlyWUsxYUJFbGhmZTljZHlh?=
 =?utf-8?B?ZlZwSlFqeXNVdFkrcUh1OVpDWEFZYzVkSjhET0c0QjdtL1NUbmE2dVU2Z3pF?=
 =?utf-8?B?VlA5cUlaYlJzYUhZK1lHck9iOEI1azJDcVZBNWh1L0dHcjVydDhiWXM3cHkv?=
 =?utf-8?B?L0piT3VZYnVDU1ZZdFNVNlNDWGJnakt1T085WXFQVmY5VkNGUHV3cEl1YUw1?=
 =?utf-8?B?NWQ2R3F1ZklRZ2JKckkrbmUxQVZraHQ3dDZ6SldtN2dQV3MxdG9xbEFvQXJX?=
 =?utf-8?B?eFk3Nys2QTBONlBSSGlyaDRtS2hMRlZUYXpPVXJFUWxSL2JQT3lLdWNuM2V3?=
 =?utf-8?B?ZjQ4WFVzUnVPSzg3MnNQcWd5REZidWwzUloyRjFrZFRTSEVQbElrd3B3bEdl?=
 =?utf-8?B?NEk3cjY1QVIrYy9jYll6b2dDeU0zcXJad2VRWlhTVXBPZFRURGVNc1VydHlI?=
 =?utf-8?B?ZStTUHhhdllRall5OW9mWkU4Y0l2aEd3RkZzdzI4TkNCbnpraDRvQlVYYm5J?=
 =?utf-8?B?bWNuM0QrcXV6QTZpZ3pobEdYSHl0Rkl1LzFadVhGck1uVHdtbUtOWWczNS84?=
 =?utf-8?B?ZTl3a1QyeW10OFlTWFJESnJvOWQ1MEdYeTNsNmlPdE5PaUpRK0UwcUdrZTVG?=
 =?utf-8?B?N3BHNjZnR1FTd0JQdzZFM0FtWng4VVFUaGNOclMwaFFUZkp5UXozeVI3ejV6?=
 =?utf-8?B?cVRvTzU2elNzcW16MllQQzd4MERYZ3NiaTUrR3JDTDMzRHRDaGpTMzltL2pJ?=
 =?utf-8?B?cVpWa1pjRTFtcy9HdTNyK3dHUUg0Ym1TWE1EV2EyaFpuVFZmb0t4KzFydU1l?=
 =?utf-8?B?Y0ZIRVBHb3EzQVlibUVoVkE5UEliSFlDQkR4bzhnVG5aVlRLdis4SjNCY1JC?=
 =?utf-8?B?c2xMZ3hKUkowUlhJVlAyVkJmN2lWRWdnblFBSU1tTWlNUWJlNDFGaXY3aVlh?=
 =?utf-8?B?NTMwcWZZY0dqZFJyR2ZScW4vdW1oYnNjNURnenRiQTZ0cThLN2ptN0pyOGM5?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2b2d33-2241-4375-32ed-08db9416339c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 11:38:48.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lagae9J9dqMXsSMQ6ASCIl1DrncgRf3DgCL31DQUa+ySXbeSORQU6NplD4MfKUXxvjUthvFkntsaepdk8QUK3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/3/23 00:01, Mika Westerberg wrote:
> Hi,
> 
> On Wed, Aug 02, 2023 at 03:10:13PM -0500, Mario Limonciello wrote:
>> @@ -3036,11 +3044,8 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>   		if (dmi_check_system(bridge_d3_blacklist))
>>   			return false;
>>   
>> -		/*
>> -		 * It should be safe to put PCIe ports from 2015 or newer
>> -		 * to D3.
>> -		 */
>> -		if (dmi_get_bios_year() >= 2015)
>> +		/* the platform indicates in a device constraint that D3 is needed */
>> +		if (platform_constraint_d3(bridge))
> 
> This for sure causes some sort of power regression on the Intel
> platforms made after 2015. Why not check for the constraint and:
> 
Are you sure?  I saw it as an explanation of how Windows could put the 
systems into D3 when there is no other PM related ACPI objects.

> - If present and enabled, use the desired D-state
> - If present and disabled, leave the device in D0
> - If not present use the existing cutoff date
> 
> ?

Thanks! That sounds very reasonable to me.  I'll double check it in my case.
