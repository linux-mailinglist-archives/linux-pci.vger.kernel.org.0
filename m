Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F25677BE90
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 18:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjHNQ7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjHNQ6s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 12:58:48 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D815810D5;
        Mon, 14 Aug 2023 09:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1/IMgxJtuZlDA5mJD7pNjeVabupkp8n0aGwK3EUJyjH0XUxGs+LIhHJnO10pKIrLt7O9KTO/s8tIFH0CIV4x0xOjXl71IfDb1CtEQencWprMPEG37f9TVdvX/eE6UTr8aQlkPhuta10QuGaZPVkwkNoWlVttwNm1pPMKyNX7tZTwteu3CuxlyakGu6c21XqTnxkvxS2/FqpvUKI71MwkEUgls41p/HoDVk7iM1tIb2/Rn1/fQ9w6Q9OSsEfXNh0KdSGVTkYWj5QSJQZWyLup2FX4BqZmZqQHVOSMPg/Oyh2w8MOGwGCSutK7VTKfQcAgJVsKczAgpXjkGCxAvap6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQAEYwXueSCk8U1YSu3ksNwxuQtbVETQHZHi4TnU8MU=;
 b=lJym6ov9SykDpYvcB8cZTfLcyKqKBHzJaUcZpekeu1UUaNfm6dgNJz0TQ1eCqx38aMdtg0Vo5JJYYTNSoUti2mByb5KTxSMKoYA3p871qmoedOHMiQ5pqLwTLrKRy+P0kXmfTFbmnZLsNjBRuq7wquj9b2Kg9WlBru1zvC2/toFNDW0XV6xhGbYdYZrGcZvNYLYItw+Ky9LuSYpo50ZKecilK9alwVEYNRs8cTaBILLfVDK1p0Q4KioRvy+oDCdOfrU8Bj7ZU3RBrtQfZOWcZFaJ/7aLmRndvM9jdtCPtHgfZst/qwnsiz3hoP+icGce6aX0M+kptt2kcm71sE7nhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQAEYwXueSCk8U1YSu3ksNwxuQtbVETQHZHi4TnU8MU=;
 b=CYj7uTUL8jt/2wo/i6lB94kO8R0oU1gONaxq72MQSvJvODRs2bARm48f3sonBa0U2CvmZg5B7wOiNzV7VfyIPf9jApDcEoyGJkKnbzNwLaS8hjAJ0C5Tu43Boa5LVEP2deo1G5X91EvnCzJ5O+9HWvi5Eo1KcofqiE2qsUAfcHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 16:58:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 16:58:43 +0000
Message-ID: <912c659b-420e-4c2d-96f1-0ed6de5d4b4c@amd.com>
Date:   Mon, 14 Aug 2023 11:58:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: firmware-iwlwifi: Wireless AC 7265 lacks D3cold support
Content-Language: en-US
To:     Juno Computers USA <usa@junocomputers.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <4f218a49-e4dc-4a6f-8f80-338ed4dae207@amd.com>
 <C9EAD2BA-5148-4793-8427-D23F1EF2C084@getmailspring.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <C9EAD2BA-5148-4793-8427-D23F1EF2C084@getmailspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:806:27::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f891ee-9c46-4be1-ebfc-08db9ce7b794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1ZvMIy0xx9ABgRR8vt66P5Ym2RgeJaCAwjdJCyPUSDgHK7FrVRXYt4Aafdqg2czcPzx/MzY1MQ0cUiEB5TadfVGLHc4q2jtYrxYbaX5VIIaxz5oCDwdB7dBS6ePn7JdzVd/UumiMAXbqxaK2u2qOqdFbGO9cebebLwV8Al9cZmvXEWMFD+M7h2p8wthk64ZVcgL1ly3CnvDGgG5c8p8z9Ps+vYbQWr/fMXIR4AISJOZIdcd5Nvz66DwkfWBeyPGidWnXsut+ncPDkJ8j7tY20JRmEWZNuVCAjG4XfC37xtdhKKL8mMRwup6XOzl0qyQ8aQysm6KYdGzOK4dYIm+PKJPVZEECEF04xmaCG3F53l56UIZ6V3hheSXMgZNb/XQ/3U5WSphcx7w2phiOWHty/1jyRX00cy6mEp1Eg7ub68f9ii3SwB1FFn2KYka+2cMtiu2Cfv88fyz/cWuwNr2Xe3RAjr9yzajbwZZ7ngQWVP92qNtKhMR32Cjz6FKpRLZSC5TNs/yaqeP8Z32Ba7cOiV8GHgtIpjftukSC6EGrgXKDdne0fWoxlNjda2Hrq8LQOy9eEi45ua+GMtiXmVeTDH4UqBFuCQBtqmxq9N0ce4zNReNI9XBJVrYyMFQ7UOB3I8u/NcIjsu3gc0zDlKvVAbO9CvQjTom9aWfN4RtdMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(366004)(39860400002)(376002)(186006)(1800799006)(451199021)(66899021)(966005)(478600001)(8936002)(8676002)(4326008)(316002)(66556008)(6916009)(66946007)(41300700001)(66476007)(54906003)(38100700002)(83380400001)(53546011)(6486002)(6506007)(26005)(2616005)(6512007)(86362001)(31696002)(2906002)(5660300002)(40140700001)(36756003)(31686004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmdxRG1Ma3c4RFEwTllIN3o3RU40ZHFrU1hrejlhVmxGWkhSWis2MUZSZFZG?=
 =?utf-8?B?RHlyVHNJdGsvcDEyYkp6YmZXRU1BdVUxVkhIcXdqUm5YbmhzSmx0M3ZteTR4?=
 =?utf-8?B?SXRjMHhiOGtCdnhERWFsOEhNQ1ZOVWhBZmpqQnRMMlNXSGdPTjVrT09ZV0lG?=
 =?utf-8?B?UUVaQm91ZFJuaFF3dVE5UGxnS1VlNWpFOE9NZjRQcTcrYUFQczB3NWhJd3Mv?=
 =?utf-8?B?SDR5V2tmcVBMd1FjUzhuQ3VrRWx3M3VsRktxdmQxeXVHODl2TEhPR2JjMXJy?=
 =?utf-8?B?TG1WWE9acFN2NmtUWS80dTBQYzVva0ZVL3VTV3kvalN5aVJxRE5GZ3dsK2VV?=
 =?utf-8?B?a2EyTnl4d21POFhobS9lYkNrbldhdk9CdjIwd1E1d3loUTBqWm45TTU1Nmly?=
 =?utf-8?B?cUpCN3RkeFd6blpQRDdTL2JjT2JlQXJ1OFROd2RxNjBzVUUyMk5EZW1iVUUw?=
 =?utf-8?B?TGN5S2tmekQ5cmlZR0dUSldadngrZStycExvczlEN1ZQNWdaRDl2N01rZ2Q3?=
 =?utf-8?B?aFBHV0FCTmxGV1liMS9XTFRVblgzNWludE9tdG9OWTZ5Ujd6bWFnd1lqbzha?=
 =?utf-8?B?TDJ0MGU1c3dnVEN5VC9qLzFyTzFEdmtNVU8vdFQwVFhRQ3VwZWZrMVZQRVgx?=
 =?utf-8?B?bzczZUVqUDdIY3BEMVJJYzZrdVRyRTNEQ3NKN1F4Z0wzaVJJWk9GZ0szOE5t?=
 =?utf-8?B?QlhFMDVMSU44OU5zUDNjMUx5d2pOc0YrV0sza1orV1MwMlVCZlBwZ1JqZWkz?=
 =?utf-8?B?aGpFNkRKTm1oM0pOY2ZwdFBDYkhzM2FsU2JUOG5hdHI4UzNUY2Yva2g4RENN?=
 =?utf-8?B?eUQvVDNidjRMK1laZ0pSOXJLUkgvUnNDVmZPUDR4N2RjRkIrUHFaWUdVdkE2?=
 =?utf-8?B?VU1Md2tRdkkwdzd4NXUrYnJSS3FMRFE0d3B0TlNFeWw4cWxOeEtLOXBJbUp6?=
 =?utf-8?B?YVZEUmRYQkQ5RTNKTmhEZE5qRUVOak9IZXRRNTJaZ1pQUkpxOVBsQStZUTEx?=
 =?utf-8?B?YTczVGRGbkt6MU5CNUtjUUxYM1BjSFhCSDVBM2Fvb3BSa0dDZUhpanBPYzhP?=
 =?utf-8?B?MHJud1p4YTRxZ3B0ZUt6dnE4Yi9NZmxuQnkyLzQ4MnFndkhUUzFOcW92Nnpy?=
 =?utf-8?B?cGpveXdtNHNBdjF6elVUSW9NcjArMzB3b3J5NUFWdkZ2ZU02cDhPb2s4MkNC?=
 =?utf-8?B?WCt3dlBYdWxxYzBFRHdETWNIVDlxMFdxR0RYN2FoZEpXTGwwcVhMNUhGS29t?=
 =?utf-8?B?QzR6dFdNSVEwWUUzNHFoUjFEMWxqQ1FFaUVIUVZWVW5LWXJydFFCY0FvR1hr?=
 =?utf-8?B?Z00vTDNiYzhmY0pjakZNcUNVTW5vQUpYZDNIL1gwbERJa3ZuRzBBdUp5ZWV4?=
 =?utf-8?B?cjBlN3FPcGY5QVo5QlpDVjNFY0E1cXJCSW4vUFRDQk1LS0JwZDBYVWRNWXp0?=
 =?utf-8?B?U1NrcTNvRVNGQ1EzZXVDZHZlVVVzc2kvVWxCTXZQbDdBT1JiaEYzaTNQNUdj?=
 =?utf-8?B?SERnYVVxYTI3c3Q3R0dCNG1pNUI2a0ljNVYvcFpMam5IWElOTXZBeTdhRitw?=
 =?utf-8?B?S2VNRnJEMzFpeGRidFhCekVHaWFLWGlXZEt5anNIUi9DNFFFS0xYdVV2TUh3?=
 =?utf-8?B?MktUVG1Qbk9uNU96UnByeXQrbklFeW9iMHU4bkUvMC9Ua1RQTWVhYW42Mlh1?=
 =?utf-8?B?M2pDZnpTSUlvWmNrakhpbHl2RmdzaW41bHliV1g4OVMzM1BSL0htV0YvZFVu?=
 =?utf-8?B?VEhRdjE5cUN4Zlo2dHBER1M0STRIWlBRWkFqaHduQjkyOVlYOU0xM09nSStC?=
 =?utf-8?B?ZmJYMi9zTEZOSTArQ0pXL0RybUhON1ZpSTVEWjFWM0FtcFdnSnU2L1V5K2d0?=
 =?utf-8?B?TStENUhsaGc0c1lrYjJ0TmNyY2xLakUvbHpVaDFXRnF3enJ1cEp4U3YzNWln?=
 =?utf-8?B?SlBKOTEwNUprSDUxczlzTmg3eHlEU1c2Z2E5OTg4d29zSHRWa0NJMW4vd1JC?=
 =?utf-8?B?Rm4ydytyNEM1ZEZxVEs4UW9JN01zdFRtVHdoWERBZWY4RW80ZDBjeHFoYjJZ?=
 =?utf-8?B?YjZBTnN2RXB6VkE0TFo5d0ovUXBnRWdjaXpjMUdJbGVnQ01yZWlROTRaN0NZ?=
 =?utf-8?Q?7/5bxl43p7cFd+Oa1cKGQwRig?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f891ee-9c46-4be1-ebfc-08db9ce7b794
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 16:58:43.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyBIP5zs2o8Sw8oD8LjeoNxfdhiUsK+P7G2njVohnAo1y8dLqkd0fKw7xEfyjI9PrpCriTfAX1OvL6uLDeRoIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/14/2023 11:56 AM, Juno Computers USA wrote:
> Hi,
> 
> I can provide some logs. Should I do it with pcie_port_pm=off or without?
> 

You could do it with both, just make it clear when you add the 
attachment description to the kernel bugzilla which logs are which.

Also; if you try my patch series please make sure you test without that 
parameter and indicate which logs contain it.

> On Aug 14 2023, at 12:41 pm, Limonciello, Mario 
> <mario.limonciello@amd.com> wrote:
> 
> 
> 
>     On 8/14/2023 11:35 AM, Bjorn Helgaas wrote:
>      > [+cc Mario, linux-pm]
>      >
>      > On Sun, Aug 13, 2023 at 03:33:21PM +0000, Greenman, Gregory wrote:
>      >> On Fri, 2023-08-11 at 15:34 -0400, Juno Computers USA wrote:
>      >>> Any updates on this?
>      >
>      > D3cold support has been a problem area, and there are some changes in
>      > progress [1] that could be related.
> 
>     Yeah; no harm in at least trying this series. I'd love another data
>     point with it.
> 
>      >
>      > Could you possibly collect the complete dmesg logs (with a recent
>      > upstream kernel, e.g., v6.4, if possible)? And the output of
>      > "sudo lspci -vv"? And the contents of /sys/firmware/acpi/tables/?
>      > You can attach them to the Debian bug report if that's convenient for
>      > you.
>      >
> 
>     Yes this could be related but it will come down to
>     1) Whether the root ports are considered power manageable.
>     2) The system uses S0ix or not.
> 
>     whether the series could help as it stands today.
> 
>     Please CC me into any kernel bugzilla that you open against a mainline
>     or stable kernel and can capture the lspci output, the dmesg and
>     acpidump and I'll look at it.
> 
>      > Bjorn
>      >
>      > [1]
>     https://lore.kernel.org/r/20230809185453.40916-1-mario.limonciello@amd.com
> 
>     BTW - Bjorn, can I have comments on the last patch in this series? I
>     have fixes ready locally for everything in the earlier patches that Andy
>     gave feedback but I was hoping for some feedback on the very last patch
>     before I sent out a v12.
> 
>     Thanks!
> 
>      >
>      >>> On Aug 3 2023, at 8:01 am, Juno Computers USA
>     <usa@junocomputers.com> wrote:
>      >>>> Dear Maintainer,
>      >>>>
>      >>>> If D3Cold is enabled from BIOS the tablet boots without Wifi.
>      >>>> The only two ways to enable wifi support is either by disabling
>      >>>> D3Cold from BIOS (not ideal) or adding pcie_port_pm=off to grub
>      >>>>
>      >>>> [   12.681303] iwlwifi 0000:01:00.0: Detected Intel(R) Dual
>     Band Wireless AC 7265, REV=0x210
>      >>>>
>      >>>> This is needed for our new Juno Tab 2
>      >>>>
>      >>>> https://junocomputers.com/us/product/juno-tab-2/
>      >>>>
>      >>>> I also filed this under Debian bug-tracker.
>      >>>>
>      >>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1036633
>      >>>> Thanks,
>      >>>>
>      >>>> Giovanni Caligaris
>      >>>> Juno Computers USA
>      >>>> P: (215) 509-5472
>      >>>> W: https://junocomputers.com/us
>      >>
>      >> This device is very old and actually already EOL, so I'll not be
>      >> able to get any support for this internally. D3 works fine with this
>      >> NIC on standard, off the shelf laptops, so I'd guess that the probem
>      >> could be rooted in the tablets' PCIe hardware or maybe the BIOS
>      >> itself.
> 
