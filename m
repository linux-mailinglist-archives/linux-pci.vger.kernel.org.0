Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B2B32F0ED
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 18:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhCEROV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 12:14:21 -0500
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:22113
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229829AbhCERNs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Mar 2021 12:13:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKMfD1h9ouvcIOC/jocsoWTsw+cWFvVJMIPFXKtqfq5n1nb/xTpAbNp2sgzPxdPFbI2ty3ziTI17jah5bihzvmwqGE1NyxfJC59dq6dHmUDaipIBqUoQpexd8dQKsx0y8NJKoznU13XVXUJ2agVyoaAGJVWhiE4OaFx89qW7g3OlvCczmOoFPS4ZR/EP5cupEnUr5JZ2ItRFzY9YVYb2O/cfDiSYhH4DqZUCeh4Em+4r5z8RDLPfaXKQ6KUUUYSNbcL2Gj9NGAG4M+WHZMsjqTTvDV9scaNi3hrE6rD97vrPcv1JNWhulLUh3Nnaor0iKl3yg68MWYPjjdcTFKJKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agcGJV8LW/hogfaydV5PtztwZE+h/LkKkIWUbFvQxIA=;
 b=aHHdBcvAx0veZvrWC9GIwr+T5xH27ZfzZwzGmS+2GUy2zbmQa/tmMObU1mxWhQF77Ko50HilGKLRYUCIqISJddFwsUWIiLYTDsdw3/oS7SCkiqb1C2Iqz1vmVClPTSVF+u13pIadvyVxvaHfJOF8pToT40kz62vJguS4yPEldYoIXRRHY0VIo/A7QRuZraRtqx3FzlbpWCXcxxNp8WjsUM7zpMK4XDeLC0729neVorpmxVQ1AUzRMhpcFuCWDrajxmyg3PrA4F33NKaLXi4IzcXVVgroSBTd8QdppMm/QKyk4S73dnIR6G5XYEm+V9GGdNwDtETJNbGt/bYd2fqmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agcGJV8LW/hogfaydV5PtztwZE+h/LkKkIWUbFvQxIA=;
 b=4uUg9Ix1g+cb0Ivsfl6Gf2WCOnEyEfzfROUASMff9/H39V/bg3ZHjb3dWAhgAZWvmKPC17r6h675CR+8gbJx9b71HdeqDiJUZ/kmvso3C1R9sIwtksNQ+YF3AgDIanDj/YyhI3nj54Dp7s36VBA/FL8CC6tgsnt/gDs0qAbpMcw=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 17:13:46 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.024; Fri, 5 Mar 2021
 17:13:46 +0000
Subject: Re: Question about supporting AMD eGPU hot plug case
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
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
 <f5a9bc49-3708-a4af-fff1-6822b49732c0@amd.com>
 <1647946cb73ae390b40a593bb021699308bab33e.camel@yadro.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <3873f1ee-1cec-1740-4238-a154dd670d62@amd.com>
Date:   Fri, 5 Mar 2021 12:13:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1647946cb73ae390b40a593bb021699308bab33e.camel@yadro.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2607:fea8:3edf:49b0:3012:19ff:c30b:a786]
X-ClientProxiedBy: YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::29) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:3012:19ff:c30b:a786] (2607:fea8:3edf:49b0:3012:19ff:c30b:a786) by YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.24 via Frontend Transport; Fri, 5 Mar 2021 17:13:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7483b65-3dcb-4ee4-838a-08d8dffa0962
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2814F81030B374AFA591E72EEA969@SN6PR12MB2814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3gmkdt+dEInuIUhetj+t71BEVfdmaiVIi24NvvdI9iNopv+uAZ7ef8xFyPn516QkUjyvkOFBrLl8ChLxQbQIM1R8zLGME6/KuGM5AEM2OwKk0tb/YlUYMT2SPgWalrNuJbh2x0wu1ir9vnBnnePIvnI9IHK5Bc5+RFEAiwGAi1fdUFYYc/NajiLtA4taveIhk86hTQZsMYlEvvsryy+H+k5+ucyIfdNMVi7fI4EgwT4cIZ1r2oNjpho/hrqtKm3tWaHF/i7bDK3svkUEDAaTN/59pIMxtQVMxeDGEgI5PlzlyLTEh48UUR4zgZgie5cpYZtVqDoCW2sW5zRrT2/hYPx64uVcjL/jhMYPjp8K0/EhFRQo+hGDDIxrDA7zh9wJ4ofvGsZMoT4OwxaYn0oq0aW0FnmWfXWWcEtt1VFiiaMs5a2ZgujT71jMC2eD44NuOhbmKhcA6d4WjCl8+x5STN3cmCxr1rWNCWVpddtZQXjDzH9FH+9Lx0qc6Fat6NVdE+9kd5jJ0EjA/qX7cR4zNg1F/3fT2cvjPwmbHggtuyOTdjVZnGC9z9TMYzlgIJ4E7tILT60Kak5olNEFZUrmbXug3VWWbxYGV/zMmAG+0XoLrxZu7pIm50Xomog7i04G/27afEyVCPcDpmMvkU/xiknHVna873aSnr6tBFOLfk+o2b1vCwvAxTbEQKZjXiX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(83380400001)(478600001)(45080400002)(6916009)(31686004)(316002)(86362001)(966005)(4326008)(6486002)(36756003)(8936002)(8676002)(31696002)(16526019)(66476007)(66556008)(186003)(53546011)(66946007)(2616005)(2906002)(44832011)(54906003)(5660300002)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y1RIOWFuVStZcGpNQUh1YU5Ld2F4cXRoN2Y2cG9VenQwTVRPNHEzTzJ1djY2?=
 =?utf-8?B?aXlkMHdIbEswVHpqd0I5c0VNOGl2d3RmSXpNUENMMk5KdVJNZGFFK1JQdG9y?=
 =?utf-8?B?VnZkWjJGQVVBcmRIcllaMG0waHBSV2pRQU56WXJEN3ZIcHBkNzlnMG9xTncy?=
 =?utf-8?B?MTFHbUhGc21hMklaWmZUVFdZSVNWaUpFMXdObWlodUZrTkViOVBTZ2twMjlC?=
 =?utf-8?B?SlBqdkR0eEUraXlEVXJ0NUdIZk51YUhINkpDYlpNR1htUTFFRktlS2NXcVNB?=
 =?utf-8?B?NDJvN3k0VVRTRmtlTVJSbnZqbncvdUc3Y0tWVFhTQTJsNmpYOHMzTm5OSUFr?=
 =?utf-8?B?M2NKLyt5TDFjR09YZTNDbEdDN0EyZHh1ZHVEQUNSeTRqenNSbnpwdjNtaGg1?=
 =?utf-8?B?UzdmcWVRMG9sTE1IeGtwcHZ6d2ZxNW0xdGMvV3ZlK3FsSFB1ZEo5WE5zM3dY?=
 =?utf-8?B?VHc5bzQ0TkNwYTVESFI2TWtBRXBXa1FEV05kd2VwNlVsUEliQ2l2eXFFYWVQ?=
 =?utf-8?B?am5xZ1VaaXVuelpSNThJK2dxK0hYSEkxQlFxcmUxQXl2SkRHQ2k2dFFrZnpF?=
 =?utf-8?B?cysvcU9OYWZ2ZUtJMTFpdElSajhxR1MyZzAxUWJoaFMvTXlVK0FDclVBNjI0?=
 =?utf-8?B?cy9FQm15Y3R1L1lCdDlhdlV1bk8vSWpNWFJZZlBrS0tmSEJ0UkdyWnRsaEhV?=
 =?utf-8?B?VjgzNlZpNXFHZ2F4ZjAwbVV6dGI2OXZ2L1k2YU9EWWhVZmlFeUc0Z0F1eElR?=
 =?utf-8?B?UG9HU1NkL0hFRGtFQWlPMzluTHphY3Rra3JDZS9ZMnlTYU1BMXNQV0oyeTBD?=
 =?utf-8?B?N2dMbTI4YWtoaXFkcjFHVkN0MVZCN3huY1NaMDhDUDVRRjJWamlZalFYREE3?=
 =?utf-8?B?QXdBVmVhZ1BEcjI1dS8xeEpWdVVRa3JSZDFpY0p3WVFKaEVKZFZIRGprc3Jp?=
 =?utf-8?B?akRFUWJwb1hDdmdqbW5lL09XeGVhK0xiNGhJaDg0dnE1QVZySVg2UjMwZUs5?=
 =?utf-8?B?ZzBVeW1rQlg0WEtZeURsSWV2R0VvSnZWVXVIN0NaODBydm5INnBHRFBwNVcw?=
 =?utf-8?B?b2VpcmlmanBNMEZpMzZETWtLZDJCMmJqeEY3a3Izam1vZDREYUtxNnNBTnQz?=
 =?utf-8?B?VmtWa29MUDVxVFhVZUJ3dlJLOXNSWU5URnkyaWl2QktIbFR3YnVzVDRHUmwx?=
 =?utf-8?B?djlXaFpKTGN5Z0ZPa0RPUUtTa1EyYWo0R3Fxd1crc1cyd2RMc1dscCtTQjNw?=
 =?utf-8?B?bEJ3ditnUmxqSTRtemp3TU53RmhGTlQzek5icC9iTkYvOFM4dm8yc0k3WExs?=
 =?utf-8?B?Z2lzSEtMM2xLRFhqVkgycFJsMGVpbVZLZDluSVlnN3lIQndWTzQ3TWlBMFV1?=
 =?utf-8?B?MnhlLzQ3MmtEaWZkM2JZaWRub3NCWjE5cGVpb2hRZDJvY0Q3aXZ0SEo4V3V2?=
 =?utf-8?B?dXNXUlZQaGRLZW94S2Q1a2dPbzFYOHdwajliTDN0VEFkMFBuUENlZVhqL3Nm?=
 =?utf-8?B?cXhScnpqTEk4eWRkTmVvT3FHVEM5SFRIZkZWMnZkTUR2RVRSZ0k4TDRpUjVG?=
 =?utf-8?B?eE0wNFFnYk0yS3RUWUNkb3VGWDFjSjdFYlo2cTh1cFdGaXpTS1BjR0pheXpV?=
 =?utf-8?B?ZEhwMEkxQW1BN1VjTUlyc1BzbjBTSmVCWFRTVThWZHpWb1I3YVRtNjVDejlk?=
 =?utf-8?B?UDdYSWFRYnV4Z2tOZm91Z2xySjVlVlpYVk1sR1BBckNEaSt2VS9IZS9wbms3?=
 =?utf-8?B?OVFVamFpTVNMTWJsSVpLcjJUWENIWFlYS2hQMjZxb2x2cmw3WHN1TVhnSHl0?=
 =?utf-8?B?RE1mWTRmY1VKNEIxMWtxK2hVc3owMnIvNzVnVFdKWkRkOHcrK3RQa1ZVaGk5?=
 =?utf-8?Q?8ydC0haDQa83O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7483b65-3dcb-4ee4-838a-08d8dffa0962
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 17:13:46.7063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Yi+Qe6Qt3aR0AiwNP1ajHF+BtiVY2dHS27OvSE1Bu3z7/s66TPI58pV/U29+MDefDwqtJxQwAW0DC76JirEPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-05 11:08 a.m., Sergei Miroshnichenko wrote:
> On Thu, 2021-03-04 at 14:49 -0500, Andrey Grodzovsky wrote:
>> + linux-pci
>>
>> On 2021-02-26 1:44 a.m., Sergei Miroshnichenko wrote:
>>> On Thu, 2021-02-25 at 13:28 -0500, Andrey Grodzovsky wrote:
>>>> On 2021-02-25 2:00 a.m., Sergei Miroshnichenko wrote:
>>>>> On Wed, 2021-02-24 at 17:51 -0500, Andrey Grodzovsky wrote:
>>>>>> On 2021-02-24 1:23 p.m., Sergei Miroshnichenko wrote:
>>>>>>> ...
>>>>>> Are you saying that even without hot-plugging, while both
>>>>>> nvme
>>>>>> and
>>>>>> AMD
>>>>>> card are present
>>>>>> right from boot, you still get BARs moving and MMIO ranges
>>>>>> reassigned
>>>>>> for NVME BARs
>>>>>> just because amdgpu driver will start resize of AMD card BARs
>>>>>> and
>>>>>> this
>>>>>> will trigger NVMEs BARs move to
>>>>>> allow AMD card BARs to cover full range of VIDEO RAM ?
>>>>> Yes. Unconditionally, because it is unknown beforehand if
>>>>> NVMe's
>>>>> BAR
>>>>> movement will help. In this particular case BAR movement is not
>>>>> needed,
>>>>> but is done anyway.
>>>>>
>>>>> BARs are not moved one by one, but the kernel releases all the
>>>>> releasable ones, and then recalculates a new BAR layout to fit
>>>>> them
>>>>> all. Kernel's algorithm is different from BIOS's, so NVME has
>>>>> appeared
>>>>> at a new place.
>>>>>
>>>>> This is triggered by following:
>>>>> - at boot, if BIOS had assigned not every BAR;
>>>>> - during pci_resize_resource();
>>>>> - during pci_rescan_bus() -- after a pciehp event or a manual
>>>>> via
>>>>> sysfs.
>>>>
>>>> By manual via sysfs you mean something like this - 'echo 1 >
>>>> /sys/bus/pci/drivers/amdgpu/0000\:0c\:00.0/remove && echo 1 >
>>>> /sys/bus/pci/rescan ' ? I am looking into how most reliably
>>>> trigger
>>>> PCI
>>>> code to call my callbacks even without having external PCI cage
>>>> for
>>>> GPU
>>>> (will take me some time to get it).
>>>
>>> Yeah, this is our way to go when a device can't be physically
>>> removed
>>> or unpowered remotely. With just a bit shorter path:
>>>
>>>     sudo sh -c 'echo 1 > /sys/bus/pci/devices/0000\:0c\:00.0/remove'
>>>     sudo sh -c 'echo 1 > /sys/bus/pci/rescan'
>>>
>>> Or, just a second command (rescan) is enough: a BAR movement
>>> attempt
>>> will be triggered even if there were no changes in PCI topology.
>>>
>>> Serge
>>>
>>
>> Hi Segrei
>>
>> Here is a link to initial implementation on top of your tree
>> (movable_bars_v9.1) -
>> https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Dyadro%2Fpcie_hotplug%2Fmovable_bars_v9.1%26id%3D05d6abceed650181bb7fe0a49884a26e378b908e&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C637bf3aab3634ab69dc608d8dff0e0b1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637505572958565332%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2F2urbXqCLMzZBKe0lTyAfhgqDqDxiOZN04R9LTVxvI0%3D&amp;reserved=0
>> I am able to pass one re-scan cycle and can use the card afterwards
>> (see
>> log1.log).
>> But, according to your prints only BAR5 which is registers BAR was
>> updated (amdgpu 0000:0b:00.0: BAR 5 updated: 0xfcc00000 ->
>> 0xfc100000)
>> while I am interested to test BAR0 (Graphic RAM) move since this is
>> where most of the complexity is. Is there a way to hack your code to
>> force this ?
> 
> Hi Andrey,
> 
> Regarding the amdgpu's BAR0 remaining on its place: it seems this is
> because of fixed BARs starting from fc600000. The kernel tends to group
> the BARs close to each other, making a bridge window as compact as
> possible. So the BAR0 had occupied the closest "comfortable" slots
> 0xe0000000-0xefffffff, with the resulting bridge window of bus 00
> covering all the BARs:
> 
>      pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff window]
> 
> I'll let you know if I get an idea how to rearrange that manually.
> 
> Two GPUs can actually swap their places.

What do you mean ?

> 
> What also can make a BAR movable -- is rmmod'ing its driver. It could
> be some hack from within a tmux, like:
> 
>    rmmod igb; \
>    rmmod xhci_hcd; \
>    rmmod ahci; \
>    echo 1 > /sys/bus/pci/rescan; \
>    modprobe igb; \
>    modprobe xhci_hcd; \
>    modprobe ahci

But should I also rmmod amdgpu ? Or modprobing back the other drivers 
should cause (hopefully) BAR0 move in AMD graphic card ?

> 
> I think pci_release_resource() should not be in
> amdgpu_device_unmap_mmio() -- the patched kernel will do that itself
> for BARs the amdgpu_device_bar_fixed() returns false. Even more -- the
> kernel will ensure that all BARs which were working before, are
> reassigned properly, so it needs them to be assigned before the
> procedure.
> The same for pci_assign_unassigned_bus_resources() in
> amdgpu_device_remap_mmio(): this callback is invoked from
> pci_rescan_bus() after pci_assign_unassigned_root_bus_resources().

This seems to me in contrast to your documentation (see 
https://github.com/YADRO-KNS/linux/commit/5bc12ba7c74f1c19c11db29b4807bd32acfac2c2 
step 1) although step 2 seems also to contradict step 1 with regard to 
BARs release - so now I am a bit confused. Also looking at 
nvme_dev_unmap - it calls pci_release_mem_regions. Symmetrical 
acquisition happens in nvme_dev_unmap.

Andrey

> 
>> When testing with 2 graphic cards and triggering rescan, hard hang of
>> the system happens during rescan_prepare of the second card  when
>> stopping the HW (see log2.log) - I don't understand why this would
>> happen as each of them passes fine when they are standalone tested
>> and
>> there should be no interdependence between them as far as i know.
>> Do you have any idea ?
> 
> What happens with two GPUs is unclear for me as well, nothing looks
> suspicious.
> 
> Serge
> 
