Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7DE310E2D
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 17:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhBEPK5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 10:10:57 -0500
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:36065
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232987AbhBEPIi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 10:08:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL/mEXXUgK3NAEGhqgsVDPDfX2ZUEgJ+IqcOMP51Q5Mr1fCkDfp080zrvC1SeXS5j+g2Cd1fky0o3OBWcPas2ERhPCGL46hOzVHR0X8tBYcIsTr/TazRCuJV7NO6f0NeJTxqwcy2TEIFq4MdFh/EoW5SxK3GGdjPsrpE+52XuwhzLdBvvapvU/ex0yjkNW1t/hHDdkcN0oZ0F65ar5l9p8VCZT+89GtgYV28hlhhSoXcF0Y24dG6aXcifRye8fZQkcLgDW84xkIroQO0reO84MI5to9nazstfYtN5Wyix6FuLf/TcvGy6wefn+IcDfIGevxmLe4a+1DBitUO7E9XeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amVTyjXpbQpS7w8kyPHFuCcNglSLGw1LaIR8cKvzoMs=;
 b=n8OpFIS0Xomlz84zP/YdWFfhx+2vuYzNoWW3thtTQ71C59xW4JT66+P4mBbpdnP1noWUm1NtUQMHCS8tCpcxn+DIHJch5YZ5FUQ90vTDvMFwC59M3GTfiQLFchTRyxB2WOO3eZXVtMoIrhU/16wPFQeCMmPsX8HrcKgxUkAkRVqKupIO0jJIMo3iZR8ZfUVK+CuuRcqNX87sHqQze7HJRBqzWAT5kdsx5oYew7Wv1V7moDLiUaPOWTo/w+vzaQmVYa5wQ1BN9s2NaP8aSgpS+YMXK6fNUnq1wlrY2UtRsiOEndEhAgCs90Dll4jEDNQBcNQ7hSRNlPc7zu6F/uN/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amVTyjXpbQpS7w8kyPHFuCcNglSLGw1LaIR8cKvzoMs=;
 b=vtRGi3Pa6lYtVnUShVs2g46HYMrmxu7ZCChvkGHvUAmVoJMy0LF9OpjB+e0klImHWv4Qr+FniAWyjAKqDGxgDyfsmhuwRD8lrWb4jk7KTx1W+HiTj/1DE0rERYpF0z0XFPmJYFSRyPTGiNSgGfj7tt9DhMmUEegxJ31lJPsexMg=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2350.namprd12.prod.outlook.com (2603:10b6:802:24::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 5 Feb
 2021 16:08:49 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::41b1:11f5:fd1e:fc5f]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::41b1:11f5:fd1e:fc5f%5]) with mapi id 15.20.3825.023; Fri, 5 Feb 2021
 16:08:48 +0000
Subject: Re: Avoid MMIO write access after hot unplug [WAS - Re: Question
 about supporting AMD eGPU hot plug case]
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "s.miroshnichenko@yadro.com" <s.miroshnichenko@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20210205153809.GA179207@bjorn-Precision-5520>
From:   Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <423067e5-9d65-5f0f-bedc-9c5939a63be7@amd.com>
Date:   Fri, 5 Feb 2021 11:08:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210205153809.GA179207@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:5454:6ba:dbb:af87]
X-ClientProxiedBy: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:5454:6ba:dbb:af87] (2607:fea8:3edf:49b0:5454:6ba:dbb:af87) by YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Fri, 5 Feb 2021 16:08:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bdc6c8d-74fe-4049-0790-08d8c9f0527a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23508D9016C31A3DC94CA6B4EAB29@SN1PR12MB2350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECFQOfsQJvyYVr/Rfj7M2S3vM+qHhlMKWmxWN+ijaCZXl8sNzHvIG57D1SwpegoWkjUC5S9zQor+sA9SPQrbqsRHiISFSBQGn3N0N47p5k0CuWG9HJ3LNtZbifYtkxAUQBRDmFaoj1754QTpPTUXb+vHaL/I3tXSy1V7WKkG5gm3GmBKOhfIhii1km9C+hpAg5OmboDUtwIB1Q6s5vK/YGuI0nJUBgL8NwInz9p1COumuwMKUMbe0rfDEqw+k4yH6dOQlBg0umjYaQF8ioZve3gxDX+ZzG8CZeI/OniINbUMVjCtbi9OF6vAQIVdM8UA0CI1jK3QcgcgyudC3ttvoNCXzi/tn0eP4Jb6CAKC1czswunbkzdFd1NNHkwDIXNGTKUf7TKy0JUnLxZy/R2NfKdR/1wgKvZ5u/yGZPRYKwXweAJVWMLXoWtI0nsIHgUG7HtsJ2F92enmCZH729lOglOPsxlYnFqgspq49rMBC96iRuYLbcxfuF6K2Ptq51glp0I4UUihH3p9tz6KU5fbUjBTh1t8WRa4uWaMk8Ec8kArYkBTFPY9zORgPX3W1sZye3YwXSmn56oAp69XO93gneFhQ78kTFKNBI2ghTnMNkQhG+slWE0tb+PGpVpWQj0V1Ol6WJ38jT1/R1YsYR2JgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(66946007)(4326008)(54906003)(66556008)(66476007)(31696002)(966005)(31686004)(8936002)(16526019)(6916009)(5660300002)(86362001)(2906002)(45080400002)(83380400001)(36756003)(6486002)(8676002)(478600001)(2616005)(316002)(52116002)(186003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UkFuSWtLY2RFeVZZM1BCM0RoVkl3L3RzeU1xTEFBM0tMQWR6QnQzWUNCU045?=
 =?utf-8?B?d1RXUkZpaHhHb3NVWnQzNEh0QkYyWGVadmdZckg5cFJMckFnbEhFa0xvekx0?=
 =?utf-8?B?SFNPQmdHdWJITDNqcmFIQnFsc1Q1MVlmcVdPTDVzOTN0TWZ5a0g5SWQwb0o3?=
 =?utf-8?B?eGZqaFNpaGxZczJtOEs2ditjd1BlRGt2Yk4yZ1krcklkd3dJS1pjeDNGa1Ry?=
 =?utf-8?B?RDY0bzlDb3VldkVTajVCRlVlR0xZQzNQWE9xcTNXT0FIMk5HSmFvNmpyUE93?=
 =?utf-8?B?bmJPcTNjbjJqM3hhc1NVQU1JMG9TL2NpMGRDcnFJWnpHaDIwK29pV0JGalZt?=
 =?utf-8?B?OEpSbjJYSnRsVHk5UWEzZ1l6REJ3WVJxanpHY3BvZFd4VXJyUW9hL1N0aGY3?=
 =?utf-8?B?YVJDOFhETmNMV1QvVzgwcC84ZlhEZ3g2Q3lWQno0WndZQ3c5cW0yd2UxemNz?=
 =?utf-8?B?TEUvR29TNWM4WVFPUDBSWVF4aHUwNlErTFU5dWVCVGZweDZKZk1QdDhzdjBG?=
 =?utf-8?B?RWkrcVdCTUd1bEdlTllBdXhKSnVhK0NnTTNxODNvQVpxdk05SzVCbGhkSDdl?=
 =?utf-8?B?bzR3RUpVU214MmxIU0pwRnpydGZ1Mi9jMjBRZHYweFBIS0h4enFvOHdBZnVs?=
 =?utf-8?B?TFordzRaaE9DWFlVTCtqVllMR0ZmSW9yd3NCMStCU0M2S2ROclBtb0VYenpt?=
 =?utf-8?B?cm1veVk2bW5pSmJTNEg4cTNIRzh3bGcrbURESVJ2ZTdIcUc1TWcvTnZwNGhC?=
 =?utf-8?B?MXRUeWhuOFcrWitZT1g0Rk5tcm5MYVJidTdzWG9UdWlLakpQZjk1OWNpc0dS?=
 =?utf-8?B?NnRpeWQ0M2phNCtnblZCcVlSNTJlaHpCVC9EL2RGWGxRNDNmazZDbVVzSGQy?=
 =?utf-8?B?MU5TSVFFSGlDdnM0SlYvdDZKNG1aT3VKTVE1bnprVXRVU042dkt5M2YyQ05y?=
 =?utf-8?B?WHJxdFRGUGIzdlVUY0dUdktGc2MwZTdwdVN2dDVnaUErQ3Znc09XYkFQVUFS?=
 =?utf-8?B?cWZURmtsU2xyaUVNS3hBalFOMzJRRFgxQUFCRU5OOEdTTmljcEZZeWF2OFNt?=
 =?utf-8?B?MkVIRUxEUXFsQ0xZaDNSdHNNaEh4RWRKd0NUWUZDSk5FWWFhY0NGR1lqWUl5?=
 =?utf-8?B?aVk5Y3ZCZ1pjL21UdWVlaitQZVUxNm5NbFRqZUZhelV2ZTJoYm4yVnR4akZ4?=
 =?utf-8?B?SytDRHUzamNQWFBReXMyRXNnNVhOYjJTOTd0SkFiWVdIVVpSMC9ocklIS3Y5?=
 =?utf-8?B?Mm1JVWp2cWxVZUNvcGJxalV6M1ZycDJBa3pqTWI5RURiMU1RYlp1VUxDSXZq?=
 =?utf-8?B?VnlJOVhwTVBqY3d0d1F3TUgvVmdyeHRtdkxzT2ZZR3JCdkM1dGJudXBkUlg2?=
 =?utf-8?B?U3kyU0RlS3A5dmNWUTZSWWlqRWwwWXYrUDlJZ2hhSFlPVG1IYmVCVVAzb1Js?=
 =?utf-8?B?RHZGUG9kVUkxaWZlMk51RFJKck56QmswbCtJRk9pSmhRM1o4MlBYa2c5RGxp?=
 =?utf-8?B?R3hBVWU0cFFaV2J3NGtXMTB5clVKQjcvSGhtT0FBTHF2L3pCNThmZjFNREgy?=
 =?utf-8?B?Uk4zNkhvSjBNNXNiRU4wRkxnNUVKWmJBbW9KMW1MQkxlL2Y4VWUzMytCZStC?=
 =?utf-8?B?WEtESGk5SW9kcTd3dERGYkExbUdSSHRpWWNWZldjNXlid1Yyb1pDbnZpNGFY?=
 =?utf-8?B?YWx3ZG1BbWszTVdvQXB6SmwzM1RwdVd3UzUzU29iUGFoa0RxMXJqblA3NHR5?=
 =?utf-8?B?cG1zeEFTS3ZYd2ExZHVJdVhrVkt2cjUzQ1dweUxkNjUvNGY1ZDRKbmtGcjBQ?=
 =?utf-8?B?Q2FDamZEcjJzUjc0dlg0YjZYYm9ncmtKeko1YXBXdVd5N25tOHN3d3RnTXVZ?=
 =?utf-8?Q?HJnMmUsrdeVZV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdc6c8d-74fe-4049-0790-08d8c9f0527a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 16:08:48.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqIow7E6z7e13YgGJ4nPSfAKjC4TAD1RMBg4FiKbzAUk3aHOOBKXRTasM6pMevyRqarY6S1eS5IKuRPmmPNn7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2350
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Daniel


On 2/5/21 10:38 AM, Bjorn Helgaas wrote:
> On Thu, Feb 04, 2021 at 11:03:10AM -0500, Andrey Grodzovsky wrote:
>> + linux-pci mailing list and a bit of extra details bellow.
>>
>> On 2/2/21 12:51 PM, Andrey Grodzovsky wrote:
>>> Bjorn, Sergey I would also like to use this opportunity to ask you a
>>> question on a related topic - Hot unplug.
>>> I've been working for a while on this (see latest patchset set here
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058595.html&amp;data=04%7C01%7CAndrey.Grodzovsky%40amd.com%7Ccb508648cdca4144b0af08d8c9ec0c9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481362958887459%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=IZgVF3%2Bq0vGwXBJo5gh8%2BaYEgYnXWqIhnfI3swFDCXU%3D&amp;reserved=0).
>>> My question is specifically regarding this patch
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058606.html&amp;data=04%7C01%7CAndrey.Grodzovsky%40amd.com%7Ccb508648cdca4144b0af08d8c9ec0c9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481362958887459%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ARrUqyg%2F3NoCOs0l6hgaR3Fktqt2nz6Ab0FP9zSVx04%3D&amp;reserved=0
>>> - the idea here is to
>>> prevent any accesses to MMIO address ranges still mapped in kernel page
> 
> I think you're talking about a PCI BAR that is mapped into a user
> process.

For user mappings, including MMIO mappings, we have a reliable approach where
we invalidate device address space mappings for all user on first sign of device 
disconnect
and then on all subsequent page faults from the users accessing those ranges we 
insert dummy zero page
into their respective page tables. It's actually the kernel driver, where no 
page faulting can be used
such as for user space, I have issues on how to protect from keep accessing 
those ranges which already are released
by PCI subsystem and hence can be allocated to another hot plugging device.

> 
> It is impossible to reliably *prevent* MMIO accesses to a BAR on a
> PCI device that has been unplugged.  There is always a window where
> the CPU issues a load/store and the device is unplugged before the
> load/store completes.
> 
> If a PCIe device is unplugged, an MMIO read to that BAR will complete
> on PCIe with an uncorrectable fatal error.  When that happens there is
> no valid data from the PCIe device, so the PCIe host bridge typically
> fabricates ~0 data so the CPU load instruction can complete.
> 
> If you want to reliably recover from unplugs like this, I think you
> have to check for that ~0 data at the important points, i.e., where
> you make decisions based on the data.  Of course, ~0 may be valid data
> in some cases.  You have to use your knowledge of the device
> programming model to determine whether ~0 is possible, and if it is,
> check in some other way, like another MMIO read, to tell whether the
> read succeeded and returned ~0, or failed because of PCIe error and
> returned ~0.

Looks like there is a high performance price to pay for this approach if we 
protect at every possible junction (e.g. register read/write accessors ), I 
tested this by doing 1M read/writes while using drm_dev_enter/drm_dev_exit which 
is DRM's RCU based guard against device unplug and even then we hit performance 
penalty of 40%. I assume that with actual MMIO read (e.g. pci_device_is_present) 
  will cause a much larger performance
penalty.

Andrey

> 
>>> table by the driver AFTER the device is gone physically and from the
>>> PCI  subsystem, post pci_driver.remove
>>> call back execution. This happens because struct device (and struct
>>> drm_device representing the graphic card) are still present because some
>>> user clients which  are not aware
>>> of hot removal still hold device file open and hence prevents device
>>> refcount to drop to 0. The solution in this patch is brute force where
>>> we try and find any place we access MMIO
>>> mapped to kernel address space and guard against the write access with a
>>> 'device-unplug' flag. This solution is obliviously racy because a device
>>> can be unplugged right after checking the falg.
>>> I had an idea to instead not release but to keep those ranges reserved
>>> even after pci_driver.remove, until DRM device is destroyed when it's
>>> refcount drops to 0 and by this to prevent new devices plugged in
>>> and allocated some of the same MMIO address  range to get accidental
>>> writes into their registers.
>>> But, on dri-devel I was advised that this will upset the PCI subsystem
>>> and so best to be avoided but I still would like another opinion from
>>> PCI experts on whether this approach is indeed not possible ?
>>>
>>> Andrey
