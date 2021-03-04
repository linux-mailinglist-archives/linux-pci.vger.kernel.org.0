Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DC732DA93
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 20:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhCDTuo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 14:50:44 -0500
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com ([40.107.237.87]:51617
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230452AbhCDTuS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Mar 2021 14:50:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iezKvjIh0u3zFtpCa+FFcqwpAZ5epN4jdjM+s9fXtfiw+5d5QSc9ahajl/9tlROWeVMCZxx/bX6vUfSWeEdQ7nBHgfO/E3CCgLszJS2UoWG1QgYtMydQe+cyI/ZDDQX+XFWCJVOGPFzT+n23aEd2p6XgPW0VFFvqys2Yg9UdM7TuUIC4ym4OTHSfqeylWgzuqDeLUmtwJCHOyeXQYb/57Oq/gKKujwxtx5n9I47cxLDt5Vf3IsqsyYiAz4m+7TtreoH/1gTVt+r4sA/afEYSajnjGgYShrCnYewtqKgvjjGlDccCgMXe/hpy9tSC+GAw/7b5hVqSFvJIuIQillrZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LewkFL32wc3ZbYhfW8CGDrETAPNWyXi6fMzsga3cI6U=;
 b=f2F1lSEjnsnFJC2dVbCdKvfc7GiXXKB7a583TL0hZv+xXULE8w/ptZnEdB7nWKLajqP2tf9DKUCvchXCMu4Q/dcBKxMpMcKDbxsqUb2+kUmHLEeWxZiSL1In2gd7a/OYBnwKyVEoFfW2xrmQnvAZZGmIZUKCI1EN1Fiy+eNlaEkTsargvN13WEGLo0XpgzebXdOx6FafZn40+RlAonj1xDYE5PYjH4ujKcJKSbJCQ41Rm6HaZZAaJ0cpFye0U7llPnAUzpaVkCeT4YzS/ULrKQhw1c3+iqYBTXeWNI4hhGo0B2IYJiVH1rP9YDwXBXV9Phq7s6Cn/iXiyPJV6pCztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LewkFL32wc3ZbYhfW8CGDrETAPNWyXi6fMzsga3cI6U=;
 b=VhO5YJQgMwIB+QaV5++Lp/5Pfr4ffT0ejySgMzjl/DzpQk3DxFBY772e0fdszQsr+96c0JIoa8THVSukMxmJfihG0gUrNkEMrB+mfyWmk3Znu6NSL1KT7pqpz5USTig/rdoEJoAmQqdC/cDNZFP3SE8PNP9uxBB4Uq16Lvg+Lec=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 19:49:26 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 19:49:26 +0000
Subject: Re: Question about supporting AMD eGPU hot plug case
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
References: <ddef2da4-4726-7321-40fe-5f90788cc836@amd.com>
 <MN2PR12MB44880052F5C4ECF3EF22B58EF7B69@MN2PR12MB4488.namprd12.prod.outlook.com>
 <ffb816ae8336ff2373ec5fcf695e698900c3d557.camel@yadro.com>
 <9c41221f-ecfa-5554-f2ea-6f72cfe7dc7e@amd.com>
 <dae8dfd8-3a99-620d-f0aa-ceb39923b807@amd.com>
 <7d9e947648ce47a4ba8d223cdec08197@yadro.com>
 <c82919f3-5296-cd0a-0b8f-c33614ca3ea9@amd.com>
 <340062dba82b813b311b2c78022d2d3d0e6f414d.camel@yadro.com>
 <927d7fbe-756f-a4f1-44cd-c68aecd906d7@amd.com>
 <dc2de228b92c4e27819c7681f650e1e5@yadro.com>
 <a6af29ed-179a-7619-3dde-474542c180f4@amd.com>
 <8f53f1403f0c4121885398487bbfa241@yadro.com>
 <fc2ea091-8470-9501-242d-8d82714adecb@amd.com>
 <50afd1079dbabeba36fd35fdef84e6e15470ef45.camel@yadro.com>
 <c53c23b5-dd37-44f1-dffd-ff9699018a82@amd.com>
 <8d7e2d7b7982d8d78c0ecaa74b9d40ace4db8453.camel@yadro.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <f5a9bc49-3708-a4af-fff1-6822b49732c0@amd.com>
Date:   Thu, 4 Mar 2021 14:49:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <8d7e2d7b7982d8d78c0ecaa74b9d40ace4db8453.camel@yadro.com>
Content-Type: multipart/mixed;
 boundary="------------44363419B6834C045EF9B568"
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:4b8e:83e0:94c2:6848]
X-ClientProxiedBy: YTBPR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::20) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:4b8e:83e0:94c2:6848] (2607:fea8:3edf:49b0:4b8e:83e0:94c2:6848) by YTBPR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23 via Frontend Transport; Thu, 4 Mar 2021 19:49:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d60b191-0ccd-4af7-fa8e-08d8df469df1
X-MS-TrafficTypeDiagnostic: SA0PR12MB4576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45760CA6243A1140E151054CEA979@SA0PR12MB4576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfVWYu5vJrm6eGa6GkCEZ3aXLhisoPV50KT9fMaRMJeiZUPPzgAlJu4F5Z2+hOqGVUZJhFSEgOpcw3JQ03300YpxrNVCSPfPlb95g1aF1q0FQW3BB9FOsgBDUiLMX0yO7SBoWiuWk9yjges6iM/eWjLVEo0w3pAjieL3qp+/XqKVzKiZyR+E9FJ+7WJzmelgt2wpblMF4Xxa9HFRHBG7IRQXDBCG0kds2PJ1X6mpf94NUyCoTk164HN2SHcrnMnRomf0oaP+Z75Nfe6BIOAcJo7ppQUuDsqisphM0pZSyo6rYxFJjg0xKpnMk44Xj1KJaAXhFgCjbyzOENb+FQjWOjiFbAkU5L1llfOItvvXec5c57zrMMGZ+kgEG6mctcL8Tmy7HEn3zUuXFgBbdHUkpo2r5Ey0c9Dymr3XLvPkxugWFOx3Y9/N7PAruMpJg4oFaOXN1JApLSvj+oyLCvdri2hKI0FyV6oPnF1KwCa31rrE1sRlp7jpSXuwqGT0gEhnL+jfxROQhefFRILBaknqepkSlsMbmpvzPhHBZGtml3TP7UZih6j26vjfx+9M8+rutyg4drr6BEaPyhIr/UU46VMkqRfSVf7e7+198VkPKXeC/yqvgmRYUAj+5IHEEzBDu7oHQS8Cmx3Nmcv04Q1ALQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(478600001)(966005)(4326008)(52116002)(31696002)(2906002)(31686004)(316002)(44832011)(66946007)(8936002)(66556008)(16526019)(33964004)(5660300002)(54906003)(66476007)(235185007)(86362001)(2616005)(186003)(6486002)(36756003)(66576008)(53546011)(6916009)(8676002)(21480400003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VCtydDQzdlRtQUVMOTU5azJERXNMb09WUTBsRXFJeVVIY1d4VnljRFJGb2FL?=
 =?utf-8?B?UXJVcmlYb2JIejJNdjg5czczRWhMc0d1Wmh5dzg5amdBQ0RrU3I1NENBdVZi?=
 =?utf-8?B?bVlhVVJKV0VZMytqNXZYNWllVUt2ZXJWTjQ3bzlxM0RoZnR2WG5qN2Y2VjBs?=
 =?utf-8?B?YlY5K2k0T0xnWlJQS2FkcDlLT1RBWGpJV2hiS2QwK3ZRZnphaVdIQ3Z6K3Qr?=
 =?utf-8?B?NVhhM1c3eFVFWmxBbGZMY2tWNTlma0l5eUNuUzlxSkcwczZuSy9MamRzYXhC?=
 =?utf-8?B?aDFOOHlKVlYyMmE1QURJVVpyN2NUOHhsck9taTZtOWkvQUlFOURzL1VhMlcy?=
 =?utf-8?B?ZFM0VGpLd0FrR1l5S2JoaXZwaHdxZ0F6Z1FMcnBBdHkwMnpOeXF5RnZyMFc4?=
 =?utf-8?B?dEp6N2pWUWZ4SWsvamVqWHpqVFZIaUIwek0yMnZkR1BFRFpLWkFWMGxLSGt4?=
 =?utf-8?B?Tm5UeWV2MnRIZk9DK3IzM3JGTTgramRkOUhxUTdoYWZQUFQxaWEyOERsWGor?=
 =?utf-8?B?Tlhzcm9tbGNpWUZua2QwYXRQZ2txV0k5ekJnbEZtTjFUUXpYc1BIK3FydmlB?=
 =?utf-8?B?VnowRDU3SkJXVmZHYW9NMytoY0lqT0dKWDBCRzFJcVFWN0FLbGJQL3dVbytX?=
 =?utf-8?B?NTh0YlA1dDdKaXlBdElOd0pxNlJpblJrV3NNa1NmWmJmQ3djRWF6cTJQY0ht?=
 =?utf-8?B?Rmk0dHQ2ejcrNzJhb01Tdk5qZXVlcklsL2VXalE0VnNHRW1YdHlpUVVhM2N5?=
 =?utf-8?B?ZFloak5lYUtYMDAyZUs1T1lZaGxuL2JlSkVPUnk5SXdiZVFvOTdyQnNXRHNJ?=
 =?utf-8?B?VVMwdkxjUTQ4MXIyUXNZYTBPa3BiQzRjTzk3WlQyZUV4NWZyVE91aEdmajFH?=
 =?utf-8?B?WnduRXl1UDhjc3ZlR3dxSmNlbDlSZUIvaWdKZmJybVk1SGdnZmRqczYyWFR4?=
 =?utf-8?B?eXpOSFhhOE9SK0FONGhlMFdXVWdBZ25IUWJoWVpFQjVyeXM1Vm9NRjFDUDU4?=
 =?utf-8?B?Q1M3ZzBkbXRKaWhTTk1pc2F6TEdVbUtoWDJGd1BLOFdiamVOcDdORjdoN04r?=
 =?utf-8?B?M2k2bTdYc3ZCTXVrbzN3QndnQ0xnSlRKK1pxb3BodEQ0T0xIVnU1dEVwZHUy?=
 =?utf-8?B?dG5mZVBla0ErWHJmbXkvS01Va3IyUERyKytnWmVpVDRjdXFKek5id1VoZzB6?=
 =?utf-8?B?QXBKeG5wVWpQdWo5UURkR0Vhb0JOQUV2YWtHS0p4bXRBaWdIQlBiZ3FFY2FL?=
 =?utf-8?B?RC96UllZQ3pGeG5Jc0pyV1RwN1luNnFQNHVjbm1ic1hBaFpwU09lajFybTJa?=
 =?utf-8?B?ZS9Ed0NCMUVyTys2RW92ZTdVbGhuV2JSVlEycWVvM3BiVEt2R1BQcWk5LzNr?=
 =?utf-8?B?elVDUnluUWdPMXVHQTZCOW8vUFJ0UU9pcmxwRUhXbjJyUmNST1kwVS9aV1R2?=
 =?utf-8?B?ZDZldWVyWmdBb0w2aWNMcDZyRWFXTWRCM05QS29WQmhwU1ZXcXBwZTc1TFh4?=
 =?utf-8?B?L3FWc00zL3ZjWkV0TXAxTGh1bEVzblhLVTFjVlJ6dlhwZGFXa0VJT1dCNDFN?=
 =?utf-8?B?Q3VVZlQ2MHE4d2srSG9VVlpNNVdtaEYyUllEQVNwQk9TMnhEV0NET1J2UWlE?=
 =?utf-8?B?YXM1TmNTaklxWWlVVlVQWTg1VFVQRGhyQUNnZFhXbDRTbHUxcGRBVElDR1pE?=
 =?utf-8?B?N0xpeE9jNW05ZkZuT05WSXp4OW5HRDEwa1UwdGZyUmVLN3F0dnJwVEZUQ3dl?=
 =?utf-8?B?MHh2aGREbVFKdUtnVFdNU3lVd0ZDWUFKTGRzeEdhaTJPaml2WVI5Z3JlRDVM?=
 =?utf-8?B?K3JQbjV2ZWVUNjZBQWhkUER0TEFGbDNzS1MrRDJEZXFTNlpFOXpwYm51MnBu?=
 =?utf-8?Q?lSGrpidHY+2J9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d60b191-0ccd-4af7-fa8e-08d8df469df1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 19:49:26.5869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9VCT/mrRVhP7GO6nfsfmELevm5s2VKVQs2YYx+OFpssqk4og/yi5y3KCwhWA6sSvDWjeegjzmK6E4z5+Qym/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4576
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--------------44363419B6834C045EF9B568
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

+ linux-pci

On 2021-02-26 1:44 a.m., Sergei Miroshnichenko wrote:
> On Thu, 2021-02-25 at 13:28 -0500, Andrey Grodzovsky wrote:
>> On 2021-02-25 2:00 a.m., Sergei Miroshnichenko wrote:
>>> On Wed, 2021-02-24 at 17:51 -0500, Andrey Grodzovsky wrote:
>>>> On 2021-02-24 1:23 p.m., Sergei Miroshnichenko wrote:
>>>>> ...
>>>> Are you saying that even without hot-plugging, while both nvme
>>>> and
>>>> AMD
>>>> card are present
>>>> right from boot, you still get BARs moving and MMIO ranges
>>>> reassigned
>>>> for NVME BARs
>>>> just because amdgpu driver will start resize of AMD card BARs and
>>>> this
>>>> will trigger NVMEs BARs move to
>>>> allow AMD card BARs to cover full range of VIDEO RAM ?
>>> Yes. Unconditionally, because it is unknown beforehand if NVMe's
>>> BAR
>>> movement will help. In this particular case BAR movement is not
>>> needed,
>>> but is done anyway.
>>>
>>> BARs are not moved one by one, but the kernel releases all the
>>> releasable ones, and then recalculates a new BAR layout to fit them
>>> all. Kernel's algorithm is different from BIOS's, so NVME has
>>> appeared
>>> at a new place.
>>>
>>> This is triggered by following:
>>> - at boot, if BIOS had assigned not every BAR;
>>> - during pci_resize_resource();
>>> - during pci_rescan_bus() -- after a pciehp event or a manual via
>>> sysfs.
>>
>> By manual via sysfs you mean something like this - 'echo 1 >
>> /sys/bus/pci/drivers/amdgpu/0000\:0c\:00.0/remove && echo 1 >
>> /sys/bus/pci/rescan ' ? I am looking into how most reliably trigger
>> PCI
>> code to call my callbacks even without having external PCI cage for
>> GPU
>> (will take me some time to get it).
> 
> Yeah, this is our way to go when a device can't be physically removed
> or unpowered remotely. With just a bit shorter path:
> 
>    sudo sh -c 'echo 1 > /sys/bus/pci/devices/0000\:0c\:00.0/remove'
>    sudo sh -c 'echo 1 > /sys/bus/pci/rescan'
> 
> Or, just a second command (rescan) is enough: a BAR movement attempt
> will be triggered even if there were no changes in PCI topology.
> 
> Serge
> 

Hi Segrei

Here is a link to initial implementation on top of your tree 
(movable_bars_v9.1) - 
https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&id=05d6abceed650181bb7fe0a49884a26e378b908e
I am able to pass one re-scan cycle and can use the card afterwards (see 
log1.log).
But, according to your prints only BAR5 which is registers BAR was
updated (amdgpu 0000:0b:00.0: BAR 5 updated: 0xfcc00000 -> 0xfc100000)
while I am interested to test BAR0 (Graphic RAM) move since this is
where most of the complexity is. Is there a way to hack your code to 
force this ?
When testing with 2 graphic cards and triggering rescan, hard hang of
the system happens during rescan_prepare of the second card  when 
stopping the HW (see log2.log) - I don't understand why this would 
happen as each of them passes fine when they are standalone tested and 
there should be no interdependence between them as far as i know.
Do you have any idea ?

Andrey


--------------44363419B6834C045EF9B568
Content-Type: text/x-log; charset=UTF-8;
 name="log2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="log2.log"

Dual Vega + Polaris 11 - hang

[  102.022609 <   12.522871>] amdgpu 0000:0b:00.0: amdgpu: amdgpu_device_rescan_prepare - start 
[  102.301619 <    0.279010>] [drm] psp command (0x2) failed and response status is (0x117)
[  102.301702 <    0.000083>] [drm] free PSP TMR buffer
[  102.334903 <    0.033201>] amdgpu 0000:0b:00.0: BAR 5: releasing [mem 0xfcb00000-0xfcb7ffff]
[  102.334925 <    0.000022>] amdgpu 0000:0b:00.0: BAR 2: releasing [mem 0xf0000000-0xf01fffff 64bit pref]
[  102.334941 <    0.000016>] amdgpu 0000:0b:00.0: BAR 0: releasing [mem 0xe0000000-0xefffffff 64bit pref]
[  102.334955 <    0.000014>] amdgpu 0000:0b:00.0: amdgpu: amdgpu_device_rescan_prepare - end 
[  102.354480 <    0.019525>] amdgpu 0000:0c:00.0: amdgpu: amdgpu_device_rescan_prepare - start 
[  102.355059 <    0.000579>] amdgpu: 
                               last message was failed ret is 65535
[  102.355073 <    0.000014>] amdgpu: 
                               failed to send message 261 ret is 65535 
[  102.355087 <    0.000014>] amdgpu: 
                               last message was failed ret is 65535
[  102.355097 <    0.000010>] amdgpu: 
                               failed to send message 261 ret is 65535 
[  102.355110 <    0.000013>] amdgpu: 

--------------44363419B6834C045EF9B568
Content-Type: text/x-log; charset=UTF-8;
 name="log1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="log1.log"

(reverse-i-search)`cat': ^Ct /sys/kernel/debug/dri/0/amdgpu_gpu_recover 
root@andrey-test:~# echo 1 > /sys/bus/pci/rescan 
[  126.923571 <   16.141524>] amdgpu 0000:0b:00.0: amdgpu: amdgpu_device_rescan_prepare - start 
[  127.210952 <    0.287381>] [drm] psp command (0x2) failed and response status is (0x117)
[  127.211037 <    0.000085>] [drm] free PSP TMR buffer
[  127.244310 <    0.033273>] amdgpu 0000:0b:00.0: BAR 5: releasing [mem 0xfcc00000-0xfcc7ffff]
[  127.244333 <    0.000023>] amdgpu 0000:0b:00.0: BAR 2: releasing [mem 0xf0000000-0xf01fffff 64bit pref]
[  127.244348 <    0.000015>] amdgpu 0000:0b:00.0: BAR 0: releasing [mem 0xe0000000-0xefffffff 64bit pref]
[  127.244363 <    0.000015>] amdgpu 0000:0b:00.0: amdgpu: amdgpu_device_rescan_prepare - end 
[  127.244932 <    0.000569>] pcieport 0000:03:07.0: resource 13 [io  0xe000-0xefff] released
[  127.244949 <    0.000017>] pcieport 0000:02:00.2: resource 13 [io  0xe000-0xefff] released
[  127.244964 <    0.000015>] pcieport 0000:00:01.3: resource 13 [io  0xe000-0xefff] released
[  127.244978 <    0.000014>] pcieport 0000:0a:00.0: resource 13 [io  0xd000-0xdfff] released
[  127.244992 <    0.000014>] pcieport 0000:09:00.0: resource 13 [io  0xd000-0xdfff] released
[  127.245005 <    0.000013>] pcieport 0000:00:03.1: resource 13 [io  0xd000-0xdfff] released
[  127.245019 <    0.000014>] pcieport 0000:00:01.1: resource 14 [mem 0xfcf00000-0xfcffffff] released
[  127.245034 <    0.000015>] pcieport 0000:00:01.3: resource 14 [mem 0xfc900000-0xfcbfffff] released
[  127.245047 <    0.000013>] pcieport 0000:00:03.1: resource 14 [mem 0xfcc00000-0xfcdfffff] released
[  127.245062 <    0.000015>] pcieport 0000:00:07.1: resource 14 [mem 0xfc600000-0xfc8fffff] released
[  127.245076 <    0.000014>] pcieport 0000:00:08.1: resource 14 [mem 0xfce00000-0xfcefffff] released
[  127.245091 <    0.000015>] pcieport 0000:00:03.1: resource 15 [mem 0xe0000000-0xf01fffff 64bit pref] released
[  127.245311 <    0.000220>] pcieport 0000:00:01.3: BAR 13: assigned [io  0xe000-0xefff]
[  127.245335 <    0.000024>] pcieport 0000:00:07.1: BAR 14: assigned [mem 0xfc400000-0xfc6fffff]
[  127.245359 <    0.000024>] pcieport 0000:00:01.3: BAR 14: assigned [mem 0xfc900000-0xfcbfffff]
[  127.245383 <    0.000024>] pcieport 0000:00:08.1: BAR 14: assigned [mem 0xfce00000-0xfcefffff]
[  127.245470 <    0.000087>] pcieport 0000:00:03.1: BAR 15: assigned [mem 0xe0000000-0xf7ffffff 64bit pref]
[  127.245492 <    0.000022>] pcieport 0000:00:01.1: BAR 14: assigned [mem 0xfc000000-0xfc0fffff]
[  127.245512 <    0.000020>] pcieport 0000:00:03.1: BAR 14: assigned [mem 0xfc100000-0xfc2fffff]
[  127.245534 <    0.000022>] pcieport 0000:00:03.1: BAR 13: assigned [io  0x1000-0x1fff]
[  127.245613 <    0.000079>] nvme 0000:01:00.0: BAR 0: assigned [mem 0xfc000000-0xfc003fff 64bit]
[  127.245639 <    0.000026>] nvme 0000:01:00.0: BAR 0 updated: 0xfcf00000 -> 0xfc000000
[  127.245755 <    0.000116>] pcieport 0000:02:00.2: BAR 13: assigned [io  0xe000-0xefff]
[  127.245771 <    0.000016>] pcieport 0000:02:00.2: BAR 14: assigned [mem 0xfc900000-0xfcafffff]
[  127.245785 <    0.000014>] ahci 0000:02:00.1: BAR 6: assigned fixed [mem 0xfcb00000-0xfcb7ffff pref]
[  127.245798 <    0.000013>] ahci 0000:02:00.1: BAR 5: assigned fixed [mem 0xfcb80000-0xfcb9ffff]
[  127.245812 <    0.000014>] xhci_hcd 0000:02:00.0: BAR 0: assigned fixed [mem 0xfcba0000-0xfcba7fff 64bit]
[  127.245939 <    0.000127>] pcieport 0000:03:07.0: BAR 13: assigned [io  0xe000-0xefff]
[  127.245955 <    0.000016>] pcieport 0000:03:07.0: BAR 14: assigned [mem 0xfc900000-0xfc9fffff]
[  127.245971 <    0.000016>] pcieport 0000:03:04.0: BAR 14: assigned [mem 0xfca00000-0xfcafffff]
[  127.246040 <    0.000069>] xhci_hcd 0000:05:00.0: BAR 0: assigned fixed [mem 0xfca00000-0xfca07fff 64bit]
[  127.246126 <    0.000086>] igb 0000:07:00.0: BAR 2: assigned fixed [io  0xe000-0xe01f]
[  127.246138 <    0.000012>] igb 0000:07:00.0: BAR 0: assigned fixed [mem 0xfc900000-0xfc91ffff]
[  127.246151 <    0.000013>] igb 0000:07:00.0: BAR 3: assigned fixed [mem 0xfc920000-0xfc923fff]
[  127.246278 <    0.000127>] pcieport 0000:09:00.0: BAR 15: assigned [mem 0xe0000000-0xf7ffffff 64bit pref]
[  127.246295 <    0.000017>] pcieport 0000:09:00.0: BAR 14: assigned [mem 0xfc100000-0xfc1fffff]
[  127.246311 <    0.000016>] pcieport 0000:09:00.0: BAR 0: assigned [mem 0xfc200000-0xfc203fff]
[  127.246327 <    0.000016>] pcieport 0000:09:00.0: BAR 0 updated: 0xfcd00000 -> 0xfc200000
[  127.246340 <    0.000013>] pcieport 0000:09:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[  127.246583 <    0.000243>] pcieport 0000:0a:00.0: BAR 15: assigned [mem 0xe0000000-0xf7ffffff 64bit pref]
[  127.246619 <    0.000036>] pcieport 0000:0a:00.0: BAR 14: assigned [mem 0xfc100000-0xfc1fffff]
[  127.246648 <    0.000029>] pcieport 0000:0a:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[  127.246951 <    0.000303>] amdgpu 0000:0b:00.0: BAR 0: assigned [mem 0xe0000000-0xefffffff 64bit pref]
[  127.247000 <    0.000049>] amdgpu 0000:0b:00.0: BAR 2: assigned [mem 0xf0000000-0xf01fffff 64bit pref]
[  127.247040 <    0.000040>] amdgpu 0000:0b:00.0: BAR 5: assigned [mem 0xfc100000-0xfc17ffff]
[  127.247066 <    0.000026>] amdgpu 0000:0b:00.0: BAR 5 updated: 0xfcc00000 -> 0xfc100000
[  127.247099 <    0.000033>] pci 0000:0b:00.1: BAR 0: assigned [mem 0xfc180000-0xfc183fff]
[  127.247124 <    0.000025>] pci 0000:0b:00.1: BAR 0 updated: 0xfcca0000 -> 0xfc180000
[  127.247145 <    0.000021>] amdgpu 0000:0b:00.0: BAR 4: assigned [io  0x1000-0x10ff]
[  127.247169 <    0.000024>] amdgpu 0000:0b:00.0: BAR 4 updated: 0xd000 -> 0x1000
[  127.247365 <    0.000196>] xhci_hcd 0000:0c:00.3: BAR 0: assigned fixed [mem 0xfc600000-0xfc6fffff 64bit]
[  127.247410 <    0.000045>] pci 0000:0c:00.2: BAR 2: assigned [mem 0xfc400000-0xfc4fffff]
[  127.247434 <    0.000024>] pci 0000:0c:00.2: BAR 2 updated: 0xfc700000 -> 0xfc400000
[  127.247457 <    0.000023>] pci 0000:0c:00.2: BAR 5: assigned [mem 0xfc500000-0xfc501fff]
[  127.247480 <    0.000023>] pci 0000:0c:00.2: BAR 5 updated: 0xfc800000 -> 0xfc500000
[  127.247590 <    0.000110>] ahci 0000:0d:00.2: BAR 5: assigned fixed [mem 0xfce08000-0xfce08fff]
[  127.247632 <    0.000042>] pci 0000:0d:00.3: BAR 0: assigned [mem 0xfce00000-0xfce07fff]
[  127.247676 <    0.000044>] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[  127.247695 <    0.000019>] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[  127.247714 <    0.000019>] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[  127.247742 <    0.000028>] pci_bus 0000:00: resource 7 [io  0x0d00-0xefff window]
[  127.247759 <    0.000017>] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[  127.247779 <    0.000020>] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[  127.247808 <    0.000029>] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff window]
[  127.247827 <    0.000019>] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff window]
[  127.247848 <    0.000021>] pci_bus 0000:01: resource 1 [mem 0xfc000000-0xfc0fffff]
[  127.247877 <    0.000029>] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[  127.247893 <    0.000016>] pci_bus 0000:02: resource 1 [mem 0xfc900000-0xfcbfffff]
[  127.247913 <    0.000020>] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[  127.247940 <    0.000027>] pci_bus 0000:03: resource 1 [mem 0xfc900000-0xfcafffff]
[  127.247958 <    0.000018>] pci_bus 0000:05: resource 1 [mem 0xfca00000-0xfcafffff]
[  127.247977 <    0.000019>] pci_bus 0000:07: resource 0 [io  0xe000-0xefff]
[  127.247995 <    0.000018>] pci_bus 0000:07: resource 1 [mem 0xfc900000-0xfc9fffff]
[  127.248015 <    0.000020>] pci_bus 0000:09: resource 0 [io  0x1000-0x1fff]
[  127.248031 <    0.000016>] pci_bus 0000:09: resource 1 [mem 0xfc100000-0xfc2fffff]
[  127.248051 <    0.000020>] pci_bus 0000:09: resource 2 [mem 0xe0000000-0xf7ffffff 64bit pref]
[  127.248078 <    0.000027>] pci_bus 0000:0a: resource 0 [io  0x1000-0x1fff]
[  127.248095 <    0.000017>] pci_bus 0000:0a: resource 1 [mem 0xfc100000-0xfc1fffff]
[  127.248114 <    0.000019>] pci_bus 0000:0a: resource 2 [mem 0xe0000000-0xf7ffffff 64bit pref]
[  127.248143 <    0.000029>] pci_bus 0000:0b: resource 0 [io  0x1000-0x1fff]
[  127.248160 <    0.000017>] pci_bus 0000:0b: resource 1 [mem 0xfc100000-0xfc1fffff]
[  127.248179 <    0.000019>] pci_bus 0000:0b: resource 2 [mem 0xe0000000-0xf7ffffff 64bit pref]
[  127.248209 <    0.000030>] pci_bus 0000:0c: resource 1 [mem 0xfc400000-0xfc6fffff]
[  127.248227 <    0.000018>] pci_bus 0000:0d: resource 1 [mem 0xfce00000-0xfcefffff]
[  127.248259 <    0.000032>] pcieport 0000:00:01.1: PCI bridge to [bus 01]
[  127.248282 <    0.000023>] pcieport 0000:00:01.1:   bridge window [mem 0xfc000000-0xfc0fffff]
[  127.248308 <    0.000026>] pcieport 0000:03:00.0: PCI bridge to [bus 04]
[  127.248339 <    0.000031>] pcieport 0000:03:04.0: PCI bridge to [bus 05]
[  127.248360 <    0.000021>] pcieport 0000:03:04.0:   bridge window [mem 0xfca00000-0xfcafffff]
[  127.248388 <    0.000028>] pcieport 0000:03:06.0: PCI bridge to [bus 06]
[  127.248418 <    0.000030>] pcieport 0000:03:07.0: PCI bridge to [bus 07]
[  127.248436 <    0.000018>] pcieport 0000:03:07.0:   bridge window [io  0xe000-0xefff]
[  127.248464 <    0.000028>] pcieport 0000:03:07.0:   bridge window [mem 0xfc900000-0xfc9fffff]
[  127.248492 <    0.000028>] pcieport 0000:03:09.0: PCI bridge to [bus 08]
[  127.248523 <    0.000031>] pcieport 0000:02:00.2: PCI bridge to [bus 03-08]
[  127.248540 <    0.000017>] pcieport 0000:02:00.2:   bridge window [io  0xe000-0xefff]
[  127.248562 <    0.000022>] pcieport 0000:02:00.2:   bridge window [mem 0xfc900000-0xfcafffff]
[  127.248595 <    0.000033>] pcieport 0000:00:01.3: PCI bridge to [bus 02-08]
[  127.248612 <    0.000017>] pcieport 0000:00:01.3:   bridge window [io  0xe000-0xefff]
[  127.248633 <    0.000021>] pcieport 0000:00:01.3:   bridge window [mem 0xfc900000-0xfcbfffff]
[  127.248660 <    0.000027>] pcieport 0000:0a:00.0: PCI bridge to [bus 0b]
[  127.248677 <    0.000017>] pcieport 0000:0a:00.0:   bridge window [io  0x1000-0x1fff]
[  127.248699 <    0.000022>] pcieport 0000:0a:00.0:   bridge window [mem 0xfc100000-0xfc1fffff]
[  127.248720 <    0.000021>] pcieport 0000:0a:00.0:   bridge window [mem 0xe0000000-0xf7ffffff 64bit pref]
[  127.248745 <    0.000025>] pcieport 0000:09:00.0: PCI bridge to [bus 0a-0b]
[  127.248763 <    0.000018>] pcieport 0000:09:00.0:   bridge window [io  0x1000-0x1fff]
[  127.248785 <    0.000022>] pcieport 0000:09:00.0:   bridge window [mem 0xfc100000-0xfc1fffff]
[  127.248806 <    0.000021>] pcieport 0000:09:00.0:   bridge window [mem 0xe0000000-0xf7ffffff 64bit pref]
[  127.248832 <    0.000026>] pcieport 0000:00:03.1: PCI bridge to [bus 09-0b]
[  127.248849 <    0.000017>] pcieport 0000:00:03.1:   bridge window [io  0x1000-0x1fff]
[  127.248869 <    0.000020>] pcieport 0000:00:03.1:   bridge window [mem 0xfc100000-0xfc2fffff]
[  127.248889 <    0.000020>] pcieport 0000:00:03.1:   bridge window [mem 0xe0000000-0xf7ffffff 64bit pref]
[  127.248917 <    0.000028>] pcieport 0000:00:07.1: PCI bridge to [bus 0c]
[  127.248936 <    0.000019>] pcieport 0000:00:07.1:   bridge window [mem 0xfc400000-0xfc6fffff]
[  127.248962 <    0.000026>] pcieport 0000:00:08.1: PCI bridge to [bus 0d]
[  127.248981 <    0.000019>] pcieport 0000:00:08.1:   bridge window [mem 0xfce00000-0xfcefffff]
[  127.249893 <    0.000912>] amdgpu 0000:0b:00.0: amdgpu: amdgpu_device_rescan_done - start 
[  127.250694 <    0.000801>] amdgpu 0000:0b:00.0: amdgpu: GPU reset succeeded, trying to resume
[  127.250916 <    0.000222>] [drm] PCIE GART of 512M enabled (table at 0x000000F400900000).
[  127.251063 <    0.000147>] [drm] VRAM is lost due to GPU reset!
[  127.251478 <    0.000415>] [drm] PSP is resuming...
[  127.311254 <    0.059776>] [drm] reserve 0x400000 from 0xf7fec00000 for PSP TMR
[  127.342993 <    0.031739>] nvme nvme0: Shutdown timeout set to 8 seconds
[  127.380310 <    0.037317>] nvme nvme0: 32/0/0 default/read/poll queues
[  127.762031 <    0.381721>] [drm] kiq ring mec 2 pipe 1 q 0
[  127.844977 <    0.082946>] [drm] UVD and UVD ENC initialized successfully.
[  127.944787 <    0.099810>] [drm] VCE initialized successfully.
[  127.944812 <    0.000025>] amdgpu 0000:0b:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[  127.944826 <    0.000014>] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[  127.944838 <    0.000012>] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[  127.944849 <    0.000011>] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[  127.944860 <    0.000011>] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[  127.944871 <    0.000011>] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[  127.944882 <    0.000011>] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[  127.944893 <    0.000011>] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[  127.944904 <    0.000011>] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[  127.944915 <    0.000011>] amdgpu 0000:0b:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
[  127.944926 <    0.000011>] amdgpu 0000:0b:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
[  127.944937 <    0.000011>] amdgpu 0000:0b:00.0: amdgpu: ring page0 uses VM inv eng 1 on hub 1
[  127.944947 <    0.000010>] amdgpu 0000:0b:00.0: amdgpu: ring sdma1 uses VM inv eng 4 on hub 1
[  127.944958 <    0.000011>] amdgpu 0000:0b:00.0: amdgpu: ring page1 uses VM inv eng 5 on hub 1
[  127.944969 <    0.000011>] amdgpu 0000:0b:00.0: amdgpu: ring uvd_0 uses VM inv eng 6 on hub 1
[  127.944979 <    0.000010>] amdgpu 0000:0b:00.0: amdgpu: ring uvd_enc_0.0 uses VM inv eng 7 on hub 1
[  127.944990 <    0.000011>] amdgpu 0000:0b:00.0: amdgpu: ring uvd_enc_0.1 uses VM inv eng 8 on hub 1
[  127.945000 <    0.000010>] amdgpu 0000:0b:00.0: amdgpu: ring vce0 uses VM inv eng 9 on hub 1
[  127.945011 <    0.000011>] amdgpu 0000:0b:00.0: amdgpu: ring vce1 uses VM inv eng 10 on hub 1
[  127.945021 <    0.000010>] amdgpu 0000:0b:00.0: amdgpu: ring vce2 uses VM inv eng 11 on hub 1
root@andrey-test:~# [  127.951047 <    0.006026>] amdgpu 0000:0b:00.0: amdgpu: recover vram bo from shadow start
[  127.951304 <    0.000257>] amdgpu 0000:0b:00.0: amdgpu: recover vram bo from shadow done
[  127.951403 <    0.000099>] amdgpu 0000:0b:00.0: amdgpu: amdgpu_device_rescan_done - end 
[  127.951801 <    0.000398>] pcieport 0000:00:01.1: Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512
[  127.951824 <    0.000023>] nvme 0000:01:00.0: Max Payload Size set to  256/ 256 (was  256), Max Read Rq  512
[  127.951847 <    0.000023>] pcieport 0000:00:01.3: Max Payload Size set to  512/ 512 (was  512), Max Read Rq  512
[  127.951868 <    0.000021>] xhci_hcd 0000:02:00.0: Max Payload Size set to  512/ 512 (was  512), Max Read Rq  512
[  127.951888 <    0.000020>] ahci 0000:02:00.1: Max Payload Size set to  512/ 512 (was  512), Max Read Rq  512
[  127.951908 <    0.000020>] pcieport 0000:02:00.2: Max Payload Size set to  512/ 512 (was  512), Max Read Rq  512
[  127.951928 <    0.000020>] pcieport 0000:03:00.0: Max Payload Size set to  512/ 512 (was  512), Max Read Rq  512
[  127.951948 <    0.000020>] pcieport 0000:03:04.0: Max Payload Size set to  512/ 512 (was  512), Max Read Rq  512
[  127.951972 <    0.000024>] xhci_hcd 0000:05:00.0: Max Payload Size set to  512/ 512 (was  512), Max Read Rq  512
[  127.951991 <    0.000019>] pcieport 0000:03:06.0: Max Payload Size set to  512/ 512 (was  512), Max Read Rq  512
[  127.952011 <    0.000020>] pcieport 0000:03:07.0: Max Payload Size set to  512/ 512 (was  512), Max Read Rq  512
[  127.952038 <    0.000027>] igb 0000:07:00.0: Max Payload Size set to  512/ 512 (was  512), Max Read Rq  512
[  127.952058 <    0.000020>] pcieport 0000:03:09.0: Max Payload Size set to  512/ 512 (was  512), Max Read Rq  512
[  127.952077 <    0.000019>] pcieport 0000:00:03.1: Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512
[  127.952097 <    0.000020>] pcieport 0000:09:00.0: Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512
[  127.952116 <    0.000019>] pcieport 0000:0a:00.0: Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512
[  127.952135 <    0.000019>] amdgpu 0000:0b:00.0: Max Payload Size set to  256/ 256 (was  256), Max Read Rq  512
[  127.952154 <    0.000019>] pci 0000:0b:00.1: Max Payload Size set to  256/ 256 (was  256), Max Read Rq  512
[  127.952172 <    0.000018>] pcieport 0000:00:07.1: Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512
[  127.952190 <    0.000018>] pci 0000:0c:00.0: Max Payload Size set to  256/ 256 (was  256), Max Read Rq  512
[  127.952208 <    0.000018>] pci 0000:0c:00.2: Max Payload Size set to  256/ 256 (was  256), Max Read Rq  512
[  127.952225 <    0.000017>] xhci_hcd 0000:0c:00.3: Max Payload Size set to  256/ 256 (was  256), Max Read Rq  512
[  127.952244 <    0.000019>] pcieport 0000:00:08.1: Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512
[  127.952262 <    0.000018>] pci 0000:0d:00.0: Max Payload Size set to  256/ 256 (was  256), Max Read Rq  512
[  127.952280 <    0.000018>] ahci 0000:0d:00.2: Max Payload Size set to  256/ 256 (was  256), Max Read Rq  512
[  127.952298 <    0.000018>] pci 0000:0d:00.3: Max Payload Size set to  256/ 256 (was  256), Max Read Rq  512


--------------44363419B6834C045EF9B568--
