Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51573749490
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 06:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjGFEIL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 00:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjGFEID (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 00:08:03 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CF01BF9;
        Wed,  5 Jul 2023 21:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGHrWvq8aPGRUzcJFnSXC+G7iNpAYW8lBTrMzTDt/m72arz7U4XkjvHNCp2kGRCxSIFdfBo8kgmA8RF1OsXGuTR9B+WZOYIbAvl/Xy1uZ4Pff2LbaFebQbJfF4z03Xi4ASnBFwG438sq4Jy+aHrWs8Z/jEHgKYd7qlk1rYqTAEmjzGAGaydaP/9cP/JCeY8zbL4jasg2zWThZVES48QgCStF2L7EQud2vv3+GdiB6PkBRrntEzzIrnp9W/ThCLr/wP9gmuTlmeBq8pnXUc74OlwF81N/GuSBa2tVJEnXILWIaGHZHyGzj0HrfntyAejs73aKjcWuRgtxebwDgB9Mtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0R2E490+xKStoDJwSlE3D4mz3glKGtLmX86yAt7dDI=;
 b=nEuA0m5cAz7ddkL3CG3/7NwrSKJh6HLutQuXb7S7pvp0lohurqInDPh/eHPxhN7uwQoeC3bb1M2mmGLAnv9q5olkxucarEQyerOinRL4fKytsZt8TTTphkqb+XQ86gS6LKzhrB+PkheXzGNe1Te+ENtvCkg/6KNJhSGkb7liwkf+FKugRhUfl4UHi8/m9eZ3aWn71mlQkvhFT/VqMeF2YHrG/UoaFm/KAd7sKSX46k+WCG4XkAdQTqo99usW9QZMjuEsWYUCk5NmgYIpMQ7KAt8VeH17GYzLmgOytdBNYajmRuDTevc72fUHll+NXwhB3vM5WiCJodoDHWI6lvLLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0R2E490+xKStoDJwSlE3D4mz3glKGtLmX86yAt7dDI=;
 b=b0krs4+iIKWh5W/ybFONOUH60HdUVkENi4qZ7WTZZtaRatUIAQnS23HvBKYzOt5fcT4z+iotgxIS2DMnxAHw8IYB1i+lRhvYTRoUmgUmCiRWu8ZsxJpMTA2VsENxFS0zO9Nq0Vh0WgvxQmeckQvEg1b9CIWqTPHF8IdOT4/fA70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:07:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:07:36 +0000
Message-ID: <9d1095ab-23e5-3df3-58d6-b2974f87ee72@amd.com>
Date:   Wed, 5 Jul 2023 23:07:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH] PCI/ASPM: Enable ASPM on external PCIe
 devices
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        intel-wired-lan@osuosl.org, bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20230705200617.GA72825@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230705200617.GA72825@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0098.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d3ec36-339e-4267-accc-08db7dd6883d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rutKKdcTxq8eCw9ek2ZochNSjsuVbFUCJrJAmAT+2vmxnSRbHqY0K76xkUQqfCrBO19ZDPxzncwT3VkX0cXdyIz26YdMTLdRxbzeGpT3qro8JivO2groa7qUzgGd9ZjiJS7Z06vM4J3Fl2nNndhkUJCx8+PtL5GFXy4ht/VPl/k6nKpGzNnfzCQJ2XPbmTpCfU6JpfLe5AStpc73qMtdQXhBDSEHZd4lMSca0ipHZaPkEVD2BHD/+udbB/PxitU7uGiRWh5NSuXVUK7LaDdV9Q+71iWjK74uKn6iQgHSFbY83sPAA+vqnttaFqF2gQq5LQfb7Y0JtaDHFbT5O8PwgRug5qxG4UuLJd8oMCWSoysUKunfC10czrXaaEg7z6crz0f1sHVg9VNoC0f5WwUJucomHLZgh+FYkboUfd8HrIMJDfrDIXmCyqtYrMRzUFFb25jKH19KCNRcmRkaxH8PdXiz+/Dd2RaGoKWCEv+k2JK9MvHRhXocDlz9FzeMKmeeWZiC8TELkvhDTAswZTzBNU/x/dE7rkDDcXxjbCOWB/j5t9b1uTodHvFWTOeJ43V6o14bxQ2/6lIF9tAPXOpiL7l/8ic0LUfYzN24FEaA6bQsYoOAQITzfue9nTZi3CD5MZwtOcfvt+V/IUdrex4MJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(41300700001)(2906002)(7416002)(5660300002)(44832011)(8676002)(8936002)(36756003)(31696002)(86362001)(45080400002)(31686004)(2616005)(478600001)(186003)(6506007)(53546011)(6512007)(966005)(6486002)(66476007)(4326008)(66946007)(66556008)(110136005)(316002)(54906003)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm4xUnVhcExkN0xGZkl0ZTQzSCtzSDR5b1R4dFQ0S1JWZEJlRUtIVzMzeDYw?=
 =?utf-8?B?ZnVUZXU3d2FXMENNRWFIWnlmalJyTm1kdUlaNStGNU9iMnBsZWRZQnVveHJL?=
 =?utf-8?B?L1IyakI3UFJ6UHhEU0sxdUpFK3EwSDk3ZUVlZFpYc1UzTFo4L2t4b2p5VjB1?=
 =?utf-8?B?WEpIMWdia3RZSmlpcDlPVWZ0WXVnZ1RvTlAxYzdSOFBWb0J3M0pyREFDUXA1?=
 =?utf-8?B?WEwxMGJHTDBDcC90bk1YZTRkQlpua0I4dHM3dkZmWGZneDIrZms1T1FWVDk2?=
 =?utf-8?B?Qk5veU1iczhtTCtRRHY2NndaU3dvVXNnWlA0WTRBTFNSb0FDNy8zV3d0aitE?=
 =?utf-8?B?WkZjeUNtK2hTTlJ1SjErai81Q1JQaGJRQ2tLYnZZSDYwN29lZGJnZWhIQURw?=
 =?utf-8?B?UU0xcGE5dDk1WGJqM1NSdmU1WGNLa1Rlemk2bGExeWpJTm8zVTJTbkFRVEZi?=
 =?utf-8?B?dzRmMWdSYkE0a2kxYmNwaENBb2p0eUF3dURybzdyTm1PTjloZEVlK01nRnZp?=
 =?utf-8?B?ZDRIYzRkOHcvYTk1dThGSWZiRGJTaXE4MTcySGdXNE9pMnV6OVphVy9kZHhM?=
 =?utf-8?B?WFVqTWpUbGpDTWV6T0xrWXEza0ZUUWxCNCtvZldsbTFWcitKZ2ZwV1BUVkM1?=
 =?utf-8?B?WjFvTmNwWUUrUjFmbG9sT21VbkluaEVMWDEzTDVUNUNIQjdtcUJkY1YxZy8z?=
 =?utf-8?B?VDd3N0lpVGRza2VxZE1zakZITi9ZRzBleUhiOGpyZjR0M1ZkVzlCOXpsb1RP?=
 =?utf-8?B?czVzYTdFM2R3d09YbW4xcTlOVjAremJNWVYzZTNMcW1jM2RvL25kQkg3SnZw?=
 =?utf-8?B?SnlPRjB1V29mK3N1Rnkwb3MxNmZFSmc4QXBubEkxVGRwY0h2WGM5OU1uNC9n?=
 =?utf-8?B?TnkyQ1lpR0pPR2FtNjhUdTZUaDNDTFlDM3ZVOWtCY01ycjRmb0ZVUUNINExp?=
 =?utf-8?B?ODAxZFhtNjVvZlQzdjNEUXBaaGVYclpqOVhvVlJoVWgvVkEremNld2U5elZK?=
 =?utf-8?B?bEpHV25pbkx1NTF4UDJJcVdYNW4xcTBHZTdkeUY2cnRTemhUamU4cy94dU9k?=
 =?utf-8?B?TnNBdDltYXd2cTB3clE1dHVNbHlZbWhIdXc2Y2hNb0NFaW11L0JyK3BlMGFG?=
 =?utf-8?B?L0h2NlZjaklYV2QrUUNWVW9HV01BbXc0KzloUWZFbzh1a2VNNHdjSS8zWVRy?=
 =?utf-8?B?ZVFyYWNJNVBLTU51QTloN09Oa2d3VWkxcjJ4TGRtNHMvRnJ3OVJ6V0RwdnpO?=
 =?utf-8?B?cHRpUllkcGFZZDVNWFZkaWpuUEZJK2FubVh2MzRmYWxlUUlqQnFEQ1p2blpj?=
 =?utf-8?B?K3R1bHEwWHduakR2ZFI3NUQ5VmtSZFV0NWlDa2RWK0VkRTczUk1kY1RQREpt?=
 =?utf-8?B?VWhzVHo0MDdTVVh2Z3lsSG9CWE5sSk5FMFFadDBKblZYQTFYaWNiT1lKK2hu?=
 =?utf-8?B?UCtwb2NpcHdqdnR4WjIxS3ZmREZPbS9wRTF2c0t0dkFwQmlMTk9SZzlocEww?=
 =?utf-8?B?TXdMUFVTTlFRanFzZEs0RjNhT0IwOEZFQm1WZC8xMHNDT3ZqVUJ1Mnlnb3dh?=
 =?utf-8?B?QThTR1VQang0NWlBODc3QXltS0FDMFhjUkFHZG1zcDhKZjJTUGd0VnIvVFVN?=
 =?utf-8?B?Vy9kdE92ZENuN1Y5cGx3OFAxSGNWbURIMm1xNVhQelZKZVNNdEkvc21zQnZw?=
 =?utf-8?B?TklGRmVOelRTSEZNRTgzbmowTmtmam5yUncrdHFMT0FJVWVjWmZLTThIOXVq?=
 =?utf-8?B?ajRuNzMzQTloMUhqQ1VCUnQwYVZaR2NHbUJTeC96cDlMK1M5SXJjQ1lVekhx?=
 =?utf-8?B?b293Z2VyVjRmWnA4eENva09TUmwxY0VoWGFnZzBtYUVVRk5rdTc0NUUxK21x?=
 =?utf-8?B?L0w5Ym1wY28yQlptMFVaUER6cXUwL2F6TzlGTU5zZnUvR25NYWE2VzdyZjJU?=
 =?utf-8?B?ZVVyd3pjNERvNDg4eVpoZkxZUWxBVnI4WHFSS1A5d2g5S2Z4aWJLbXlZVDdr?=
 =?utf-8?B?NXo0RERVcWpLelJRMDdBVFZpd3JwZmxhZnl3T3RITS9GbXFleVBkWmh0ekFO?=
 =?utf-8?B?enRKMWJXeVJIMkIrWWpuellxMXFjMFhSMy9wNVRHR25XcUlnbVlHcWkvWWNu?=
 =?utf-8?B?YWUzdW9nU2s2ZlhGclRja2NEU3o5UktSTWRrdmZ3QjBhdVlPeUpNS0dQWGZL?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d3ec36-339e-4267-accc-08db7dd6883d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:07:36.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWXceW1yqZs3t43jzJtUG6uA0LuCS+zztMP+q6Ex97oALaERmC8mz2w21N2G1Jss4PIf95bYK8qKNzwKpbicbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/5/23 15:06, Bjorn Helgaas wrote:
> On Wed, Jun 28, 2023 at 01:09:49PM +0800, Kai-Heng Feng wrote:
>> On Wed, Jun 28, 2023 at 4:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Tue, Jun 27, 2023 at 04:35:25PM +0800, Kai-Heng Feng wrote:
>>>> On Fri, Jun 23, 2023 at 7:06 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>> On Tue, Jun 20, 2023 at 01:36:59PM -0500, Limonciello, Mario wrote:
> 
>>> It's perfectly fine for the IP to support PCI features that are not
>>> and can not be enabled in a system design.  But I expect that
>>> strapping or firmware would disable those features so they are not
>>> advertised in config space.
>>>
>>> If BIOS leaves features disabled because they cannot work, but at the
>>> same time leaves them advertised in config space, I'd say that's a
>>> BIOS defect.  In that case, we should have a DMI quirk or something to
>>> work around the defect.
>>
>> That means most if not all BIOS are defected.
>> BIOS vendors and ODM never bothered (and probably will not) to change
>> the capabilities advertised by config space because "it already works
>> under Windows".
> 
> This is what seems strange to me.  Are you saying that Windows never
> enables these power-saving features?  Or that Windows includes quirks
> for all these broken BIOSes?  Neither idea seems very convincing.
> 

I see your point.  I was looking through Microsoft documentation for 
hints and came across this:

https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/pci-express-settings-link-state-power-management

They have a policy knob to globally set L0 or L1 for PCIe links.

They don't explicitly say it, but surely it's based on what the devices 
advertise in the capabilities registers.

>>>> So the logic is to ignore the capability and trust the default set
>>>> by BIOS.
>>>
>>> I think limiting ASPM support to whatever BIOS configured at boot-time
>>> is problematic.  I don't think we can assume that all platforms have
>>> firmware that configures ASPM as aggressively as possible, and
>>> obviously firmware won't configure hot-added devices at all (in
>>> general; I know ACPI _HPX can do some of that).
>>
>> Totally agree. I was not suggesting to limiting the setting at all.
>> A boot-time parameter to flip ASPM setting is very useful. If none has
>> been set, default to BIOS setting.
> 
> A boot-time parameter for debugging and workarounds is fine.  IMO,
> needing a boot-time parameter in the course of normal operation is
> not OK.
> 
> Bjorn

