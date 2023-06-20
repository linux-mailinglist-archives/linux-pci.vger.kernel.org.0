Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7800573746D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 20:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjFTShH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 14:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjFTShG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 14:37:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E0E65;
        Tue, 20 Jun 2023 11:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5ntC3od0of/EabYa//I7U4Riioz9GRs//dfGrpYn/Xh8hj/DXl87jrQz0rJreNCZGYR89+ufe3QgDrxTjFQ2n9PVGBCQMqmd9DIBJMTA0zZVO8sMTj7J6+BAH67anrK3UdmxfBwgjcSorthMXvQhKwWopQJsI3PgvfWxA3pmXI0eJ61HGvyAymUmtmoQhfhO+FRXYmmBxKI5wuOzlb9yxDWQoXTcSco88VW38ukGrlfliWMJLdn7LLUBPaBzWSAoDeHeZ0UOBoRBcwvqHesJk9j0Q712jkJOM+Gk1YRLoeqP4UCRCnzyIyIKx52/Wp3wq1g5lNJY+rEbznhzmFDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU6Zrgd4ZWdFWihqfbkQtokydwjAeNyC0LJkF2/mSHE=;
 b=H3ETOx0A62pSEueBCgnZBEwSfx5+UOzTD5hx3BMMWdce+vnZ72GAOr0BzA5FXo2FkRb3AE881nPmfME2xFZXu95mjD0lSQ02gCGkf3iyWHJ3iWvVoKZ4T0i8Fi+etuokPAg+ncqNJSwzSK2/ncq5ZJb5f/rdTszRQe20VDAptndglL4ezeGnIJqXOh1bSc8eJwbjRcYoXq0SNThCyR9EQ82JOptk3F7Rq8RBNcQQiGI1WVSGVj3Le0N4RGAhYFpWMnjVikVT9I8xF6FuOwJq+R3L07HISOJw1ZSYBI+DExhhU8wJywXwvoCdQPmM3HMGQV9SsT6WbSvr7f29UTEJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU6Zrgd4ZWdFWihqfbkQtokydwjAeNyC0LJkF2/mSHE=;
 b=4zY7AwSA7k7sT/kx1mquww0gX5ZDKhyk2sKhZR1P8CWcNWcKB9S9VGCZp07pw60zjBZYlIqWBMZsBVhh1MJGtAkMcnGB+bs0eGgID+/G9q+pc3Z+Nea8JicZB5bh/FAxIMEOiw2g0L7X3vtC7x1K3jgsejUazJhV2O6yZlxXhDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 18:37:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 18:37:02 +0000
Message-ID: <1b4b2c6c-8119-95fd-8958-dbbecc66510c@amd.com>
Date:   Tue, 20 Jun 2023 13:36:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230620182851.GA52252@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230620182851.GA52252@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0110.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b80bb1c-3d5d-4c3d-be01-08db71bd56e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/Jl4/Rp4BRByKliByl4j/GJ7J1ZItLBlglk6JV2mOUSiVH1SycQ/Kvpe6cKzev40dN3YrAnsULQg/BrZaY5tm/xfwjezhkbnG8FzlwO4lJiSnnZ4spyjo9hQyo8dmEa5iVty4NTVBsqOZNGRPXS8LwmhBQykHPTlaSKYzJNWoMwNtz03x3x5XMjhcCftaRCsnjNNZH6jw2pIBQ/dpp52tIFPNWfCfkQ/Csx1PSlMvKJ8FBZHuihsPcK7DG3kS2k4fDyU5mBeuM5lq+WGozz7P9ND0izLpoAJUopGoWX8ddD5zURuG8MArYUaX1vY0qgaDoVTjI+9aBYbmYtwmNP22iufuHcgyuYghfy3yGhEbNyicHEKCYXxVYZ6+vYl0AhW0rFL3djHE8V4KieZI9W6bjSXrhO8bOmctl3rFV5o3Br+qubBGiSQ82gTJ5qXLjqqqWL2XvngLsAq6Bf+hk9t/j2FQt4r9bL40XF459I/hjxSJ7ffT54dBGTCcH31WTul3w3ccu1eflGXJQN8TwjvfCjos+6tR8dn2fyWGFWYfAjyNHVVjns2C+ob82ZRsah2Bn5i+NiZ/6MUQXHEdQbYFs4m1bE+9rUs2HDQVF/m+fejJCPMP09BkYJkSM0D6GXd8Q6ExH2EkKfngqGZHCwtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(5660300002)(478600001)(26005)(6916009)(31686004)(7416002)(66476007)(66946007)(66556008)(316002)(54906003)(41300700001)(4326008)(2906002)(6486002)(6666004)(8936002)(8676002)(186003)(6512007)(6506007)(2616005)(83380400001)(38100700002)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M095VGVxNEJuYkFwWE90QVl1c0V3Wm1JNWZEK2MrdmlDQ1JhTEhwbWY0cDNm?=
 =?utf-8?B?WHhwVTB1SkZzVHpZenpwalFiaUxweURBblQrc1JRSmpMdXRVVEJ5WVN4aFhY?=
 =?utf-8?B?ZkNaaGNaUXJVekRBNTM1TFQ4VjUyaGdRTDJEZWZVZUdJQ2xCcTU3RVBqckxT?=
 =?utf-8?B?TGJUY3diK1ljVHluVmxiTU1JUUtoWDZuR0tZQjJGUE5CWnN0Uy80R3pXWGZt?=
 =?utf-8?B?TXd2SUdJNkJnN1FtcVFVRS9qcWhtbXdRZDhTVmZNdWNFbmZEdHRxTFMrem1u?=
 =?utf-8?B?TUJtN1pDdkVvUmUvekcyREltUUtqaDVBZkIvQXdPK2R3TkxtTWRTUFVrb2JZ?=
 =?utf-8?B?R0hJWkFQWFhscXJQamdGV2dJcWpJMno1dlNQZWlMM2xEbXVHeEZxMXY4TE56?=
 =?utf-8?B?ZXRXR1JpMDNWY3RXQVM5ZVRTa0E3Nzd0bDlSeEdjUnNMQnV4R2k3bGk5b2xo?=
 =?utf-8?B?eksyQnNQQkVES05Na0ZsSHBRVm5Cc1NsdmdjT2IyVHRSdDVwZGRjWlR4QUxF?=
 =?utf-8?B?THM5OWNBekMxVk0zd04rczI0aWg2ODAybG4xV3Bnc1NoMDRoTWE1VE9iRVpt?=
 =?utf-8?B?WitzcW9lVThIS0JzcjlLSDBHRnJQdDJhc3lYWGl2NEtTdXhjWmplbU9pUTAr?=
 =?utf-8?B?RVowNUVuOEFJRzJrMUpzSWdkMmZVcnZYZ0hIaDNjVGFoNGMreGNjYnlsajRv?=
 =?utf-8?B?UG8yMURscDBGV1BWaTRRWFFtUk96T2Y3OGhYT1VIMzN1WnhNVkRvY0k0KzZC?=
 =?utf-8?B?TGxiVjhiUkpKR2R4UTJIWEljQzlSc2E3bmJ5OGxQT0dZWk5HSlMydm5oZUk0?=
 =?utf-8?B?YnhKdnFlcXlHN3lQbXgvVis3elpncVFpMFJZYXg4YnB2T1o3UEkzbUJadUlM?=
 =?utf-8?B?cWhsakQzWmNodDNOSlMyaGwrTXMxNjVQMXNEeUs5dUs0a3oyZG5xeXhBQVJj?=
 =?utf-8?B?RFByem05NDFBSnlhSzFpOU5ObG4zWktuODU3bnpOZ2lzLysyRU8rcmlNYWc2?=
 =?utf-8?B?Nkgyb1VTV2JUN0RVSCtFTTJFdHZrN3RVZjl4Y3l3QzZucDRlWTNPeG5LblIz?=
 =?utf-8?B?eVZGOWZQOUtTU1orWWg1OFBWVEpGQUltOXVlSy82SXFsa2pRcFdBRE5obzE5?=
 =?utf-8?B?M3ZIWVJXNWNHdVlMdHhPMmdwaStUNTNOeitKaDk0dGt1a29oU2lER2tycjBh?=
 =?utf-8?B?Y1FJbTc5ZDJJWEd4SFMyaG52UWx1azF3RWJteGk4TjJZVWNYQTRrNWo2SHJ6?=
 =?utf-8?B?ZVhNaTVzb0ZiaVlLTUFCUHIxMHdhWWMxZlc1VHE0ZWFWV1JOcWpNUEY5VWQ2?=
 =?utf-8?B?anN4YmtkQ3JpN3pBWlp6OUNTdTl5MzJDYnBMaGpRQ2pORFNCYi94U2Erb1A0?=
 =?utf-8?B?V3crbGV6SkJubW43ZUl0dHhxY0NFemMxM3l1V21ZQkJrM0R1RnFyN3ZUVkM3?=
 =?utf-8?B?WVVHYzRMNElsWXdPNk9qMEFGc3F1ekNDRkZhNGJrS1hVcHo4MWRGOVNzS090?=
 =?utf-8?B?Q2lxbFNJOFVWQWgrNDFYejJQVlljUTJ6VEpadzQ2MW04RnlJblh0eVY3SXQ3?=
 =?utf-8?B?Z25vR0pZZEdwNDFFNUtyay9lSzVlR21yNlBhOHp0WEVwYUc5ODIwV3h5VVBF?=
 =?utf-8?B?M0ltamFjc2I1QjIvM0tWRjl3VFFOR2xnS0czeCt2M2F2N05TN1ZGeU9kdGRY?=
 =?utf-8?B?MnkraXBRSlJZWTZGUmZ0NEM5OU9IcUprWHBHTEI5Tm55TzVFVndmaGIyQUtH?=
 =?utf-8?B?RVZuR0gyNkxwYXRwbjdxOGZNTDZPUm1FKzJWb3I4cmduTHpyVUs5SWVZS3Bm?=
 =?utf-8?B?a0RUQmpKaUlaZjhVVjRhWnlyc21vUHNObFRyK0Z5Q3BLOEVxazdrZVIzRXht?=
 =?utf-8?B?dDRyZEt2RkZoT2hWWFM2RW5SS3JIOEtPY1pkUmc3eWhKdXgwNVhPY0RPVDI5?=
 =?utf-8?B?NEg1L3Znb3Y1RU1HR2ozRnpPa3lNdnByOW91ZzdKKzByVUc5YWcwWkZNdUVQ?=
 =?utf-8?B?Tmh3NEZCWFowbzZmQVF2VkszZDdVS2pDa3JleXk1bUNwS0pWeG13YW0yYVow?=
 =?utf-8?B?R3ZuUHMvelNKbDNZaVJ4NnErMHM5QkdoMVJrS1EyNHlrdVRmKzd4a0dSaG1N?=
 =?utf-8?Q?jvGWdl+nixGwKrCWn+OrGN8sd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b80bb1c-3d5d-4c3d-be01-08db71bd56e7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 18:37:02.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNWVE1V8gfT+yq9LB/YoCDnwZ017jzberSzwvvv9Y6VafpU4XuIJyd0O+P3RCM8wKUuqWLXxhWR70fSeQUvBYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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

<snip>
>> A variety of Intel chipsets don't support lane width switching
>> or speed switching.  When ASPM has been enabled on a dGPU,
>> these features are utilized and breakage ensues.
> Maybe this helps explain all the completely unmaintainable ASPM
> garbage in amdgpu and radeon.
>
> If these devices are broken, we need quirks for them.

The problem is which device do you consider "broken"?
The dGPU that uses these features when the platform advertises ASPM
or the chipset which doesn't support the features that the device
uses when ASPM is active?

With this problem I'm talking about the dGPU works fine on hosts
that support these features.

KH has a lot more experience with ASPM issues and hopefully has some
other examples to share.

> We can't avoid
> ASPM in general just because random devices break.

I'm not advocating to avoid it in general, I'm saying we shouldn't
be turning it on across the board for all devices if the platform had
it off initially via a kernel command line option or Kconfig.

>> There are various methods to try to mitigate the impact both in
>> firmware and driver code.
>>
>>> This feels like a real problem to me.  There are existing mechanisms
>>> (ACPI_FADT_NO_ASPM and _OSC PCIe cap ownership) the platform can use
>>> to prevent the OS from using ASPM.
>>>
>>> If vendors assume that *in addition*, the OS will pay attention to
>>> whatever ASPM configuration BIOS did, that's a major disconnect.  We
>>> don't do anything like that for other PCI features, and I'm not aware
>>> of any restriction like that being documented.
>> With both of those policies in place, how did we get into
>> the situation of having configuration options and knobs?
> The kernel parameters and config options been there pretty much from
> the beginning.  We didn't have the per-device sysfs knobs until very
> recently.
Ah, I see.
>
>>>> I think the pragmatic way to approach it is to (essentially) apply
>>>> the policy as BIOS defaults and allow overrides from that.
>>> Do you mean that when enumerating a device (at boot-time or hot-add
>>> time), we would read the current ASPM config but not change it?  And
>>> users could use the sysfs knobs to enable/disable ASPM as desired?
>> Yes.
> Hot-added devices power up with ASPM disabled.  This policy would mean
> the user has to explicitly enable it, which doesn't seem practical to
> me.
Could we maybe have the hot added devices follow the policy of
the bridge they're connected to by default?
>
>>> That wouldn't solve the problem Kai-Heng is trying to solve.
>> Alone it wouldn't; but if you treated the i225 PCIe device
>> connected to the system as a "quirk" to apply ASPM policy
>> from the parent device to this child device it could.
> I want quirks for BROKEN devices.  Quirks for working hardware is a
> maintenance nightmare.
>
> Bjorn
If you follow my idea of hot added devices the policy follows
the parent would it work for the i225 PCIe device case?
