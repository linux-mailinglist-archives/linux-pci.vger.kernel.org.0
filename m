Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96CE308BC0
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 18:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhA2Rky (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 12:40:54 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:29470 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232526AbhA2RhC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jan 2021 12:37:02 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10THPxF7018958;
        Fri, 29 Jan 2021 09:34:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=4/NeKmGbJOW/BGD4OhZXARIRhurU50TGKfUfwZUcsP0=;
 b=E+vSMPKpPWCFP/VPCC3GQNt5SD2HEXxsX1Ep9+UdONUcEnKJxgaDqZv0yoZQ82YhRojP
 TOWFy0xAb0Puxaxsn2vMRfA3m4qTRkFmQt+e6Thdv7zZwG/HmFDTp6O89ayrzn3VYnLq
 mPqxTLxwIZ9pmevNQSgJdfubEnXh1kUKC9r4EFLZmHFRWesXhheARS2B4Kt6VVId+lmL
 ksg+SpwRXxIllqEvWWd5fY76dyUJ1+JzDm84zyPSrHwp5TkgNviyud9QFVHfEtCxS0EZ
 6NHKgCNo+HDM/NZXJFG0tp8VezWLDxXgj7H4eXhf7SmhQh9PhuMXsPPWeNZAXlNZ5VxJ Hg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36cdyn9e57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 09:34:49 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 29 Jan
 2021 09:34:48 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 29 Jan
 2021 09:34:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 29 Jan 2021 09:34:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+9fJSftVOjtnFrXAX/gmDGRuE9kF6Wo6HSXSWV5AkRpaYXZYmzI5FdnmFCnjqLvSe1+oYtU/PyQ7EfCJfkvc4l4ku8CDRNcT0ro4JH+ff5HzE7z/gpdp3lSwCHveCRO3Piv4AWVyItJQA7kywqPlyVNuG04D8jYMq2WzCNb3cIvKldjhdeqMSVXLBEmwhwMbRY6FCsCqyKR8wkiMx0SNa/ugQJfO20VZ8JEP7Slz7xyncBtZu1kp7WZyJNF3V7UfBxHqMIFHPYTqxtmtTrqiIA/fcdpcivP5jaDqgrDftWrgnSBVhSovsz4SUDf+vEMSg5KxkqhAi9+bvgQi2XETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/NeKmGbJOW/BGD4OhZXARIRhurU50TGKfUfwZUcsP0=;
 b=Dd7ITRQvvqF8KXdHx/ZHNObz2tWOxaWZJ5be58UjSMci7TZr1eBP/Lukn7Kw4OAUOucn1eG4o14r92hbfCRQ11KenjnanVbbUoAjH9/gtFnEijjTdPd7Zq6XnWW9fMCbrU5bdLV3Ej5jRqvfUwDneV4yYJWJLQR/LiVafqd9G1gcXOZuSBkM2AIz87+sXVYDmShYYjstGhZlxA2N/HQQf35z+ZhAU3C5Kpe2WgTmS1VzrhpwyNlHgfS8pVNJHN7FHFb9/hyTNXDBfr4zxJrKzSbImIaBnERua7Xs7gxXZmhIBh/Qvib1zV115U8RGIKLKnU3bvwZUdmLZTL8jrWYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/NeKmGbJOW/BGD4OhZXARIRhurU50TGKfUfwZUcsP0=;
 b=t4fvg4yAzUJT45hde4qTSqZRvXiOdNmQgclQdzQiEW92g8getR119H4ytX9wTZoIMbuZ/7ZVa3Cg4nNCnpAS+QAO9VLafLA7PIidmluiCQcqs0SpjGQuDmbaQS98c+zuD9paPDsVZHFVp6pWju+LMhBl3yGGWTLzr2qQoKiasAk=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=marvell.com;
Received: from MW2PR18MB2267.namprd18.prod.outlook.com (2603:10b6:907:3::11)
 by MW2PR18MB2218.namprd18.prod.outlook.com (2603:10b6:907:5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 29 Jan
 2021 17:34:46 +0000
Received: from MW2PR18MB2267.namprd18.prod.outlook.com
 ([fe80::24e2:8566:bf62:b363]) by MW2PR18MB2267.namprd18.prod.outlook.com
 ([fe80::24e2:8566:bf62:b363%6]) with mapi id 15.20.3784.015; Fri, 29 Jan 2021
 17:34:45 +0000
Message-ID: <a5132281-53e8-c75e-8085-7a44fa805625@marvell.com>
Date:   Fri, 29 Jan 2021 09:34:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:87.0) Gecko/20100101
 Thunderbird/87.0a1
From:   Alex Belits <abelits@marvell.com>
Subject: Re: [EXT] Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to
 houskeeping CPUs
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <frederic@kernel.org>, <juri.lelli@redhat.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <rostedt@goodmis.org>, <mingo@kernel.org>, <peterz@infradead.org>,
        <davem@davemloft.net>, <akpm@linux-foundation.org>,
        <sfr@canb.auug.org.au>, <stephen@networkplumber.org>,
        <rppt@linux.vnet.ibm.com>, <jinyuqi@huawei.com>,
        <zhangshaokun@hisilicon.com>
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
 <20210127121939.GA54725@fuller.cnet> <87r1m5can2.fsf@nanos.tec.linutronix.de>
 <20210128165903.GB38339@fuller.cnet> <87h7n0de5a.fsf@nanos.tec.linutronix.de>
 <d2a4dc97-a9ed-e0e7-3b9c-c56ae46f6608@redhat.com>
 <20210129142356.GB40876@fuller.cnet>
Content-Language: en-US
In-Reply-To: <20210129142356.GB40876@fuller.cnet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.228.7.197]
X-ClientProxiedBy: SJ0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::15) To MW2PR18MB2267.namprd18.prod.outlook.com
 (2603:10b6:907:3::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.9.3] (173.228.7.197) by SJ0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:a03:2c0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend Transport; Fri, 29 Jan 2021 17:34:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f0feb1e-261a-46b0-4fd9-08d8c47c2b2f
X-MS-TrafficTypeDiagnostic: MW2PR18MB2218:
X-Microsoft-Antispam-PRVS: <MW2PR18MB22189961B70F7436D441337EBCB99@MW2PR18MB2218.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/X2b0QYkQKdB0yHIlUp/yeqdxjpNX6oyIm/lKmdRMzpGT7B64v8fFLmx6sKGB8NC7BguxQdTf0vcghI7fmitbZ2lbf18/MukA2nUvVGF++UrBkhU4GCK80uLJC4VOh1F6QQlF/gH3tJ9r7QxugVs9CdLHaiTcC5VxktWLt97hRaBdDm6jSqzQvFxAM+yQfJlb8W44xAkxnf8fn6vek2qbeieruVVELChQIjaIj4RPGB+Nq2go3OtVObKn3S8OJefk0qy5mXsMCRVFLXUWip/rrDKBWlKhmOHVcN9EMZDrepThSDdVkVJbOkgAXKo2d9eYXU3Im6z6/u7aImwywno51uipMExV9sGj7BMfz2/qcTUQvZrUmXeQG2dlHLkqvBsU1TGBkhpCtGWXIUo25crSfHctw+YvvaH8VGjfJYTgvjNeivRh7HnvXm9V9JNt1Ry2WMFgJmOY36gkVBwBR2bP8WjRPcmocMxT0kkoHG4jdoqA+himupE6XL9EImx/GVnLAoGErbc/kX29x0z1oSExQssmX061n5uu0UhRbcNmfGUzCSKdSXQv7tynPKjQj2YVHUCPlhGE+mPC9Mxauuz/BbbQevijD6BgKyJqUqVkRqG6ymYK3/sLidZYzIamZsoQZyFNTIoaL+dbUX2uE2lGWdrQv5sjGdepHUFpKjbqE2QiYyO5se+vTFfD/bh+P7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR18MB2267.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(7416002)(54906003)(5660300002)(52116002)(2906002)(110136005)(966005)(478600001)(36756003)(6486002)(53546011)(186003)(16526019)(2616005)(956004)(26005)(4326008)(66556008)(8936002)(31686004)(86362001)(66946007)(66476007)(83380400001)(16576012)(31696002)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c2w2a3BJZW1pSy9tWVJZWHk5ZVhsWDl2Q3EyWC83V24rSE9tL0ZiT2RNZmxl?=
 =?utf-8?B?WE82VVdpTlNpVXFUT1kyOVhkb3BjNlhueDJZYXZYV292NEJZVUR4S3J3N0la?=
 =?utf-8?B?V0RYRFkxekZSRThhS1dtNjBKYlFPenorbjlkRkhQRTVKNmoyd3dKblYycndI?=
 =?utf-8?B?eStNem92QWMyd1Y3RzNBZ3NGdlFTVnpod3pFdzU2Sml2UE1RU0dNMVR5YUdI?=
 =?utf-8?B?WXBLbG5tUVhvVGRkZGhOdkpCeFNwd0RnZEl5b3lhYmJ2OVI4dkJoekNhbGlG?=
 =?utf-8?B?UVZtR2EvOVhVQmNJdFMyUTI2L0FyU0hTcXVTa2Q3anF3UDVuQlFLR056SEJy?=
 =?utf-8?B?N1AxT3Ayd1BHVmRYK2hBSG1GTERIRVk0VXpsVHQ3TTJHMVU2RC9MN2hNM3ln?=
 =?utf-8?B?L0EvZDdhNW5oZEg1MWNnc3BBTU01dm9LNk1CSXVGS2Jjay9MdFZXMkVNV1pj?=
 =?utf-8?B?VU5zeWlkYzhXSkplNWRkcFZsbkl6b2JuczhJeGZEMWZXa2xIdFMwQWxhMmk3?=
 =?utf-8?B?WkhmNURxM0tTYVFYdDFmTHEweXUrbjlpcm11aE84UGhIOU4wT0ZSbzhsMEsr?=
 =?utf-8?B?bkYxdWpUcGNjbFYxaDBJYVJZRENwMVhUWDRCaHZ3Y3htL0lpaEJ6VUZVWkVJ?=
 =?utf-8?B?UThzSXBzd3N3RjFOcUVLdGRwTkhPUmZkOHVCS0VNVThRRTlkY1hIVFgvU3lu?=
 =?utf-8?B?dFpJc3orVjZLQjgxR2dLa29PRzVvRnYrSEtxZFdTSUhSSllPYitHakFFajJR?=
 =?utf-8?B?OUxVUWt3blJ5cFUyUUd4SXdDVzl0YW43MDJ5M1JyMzRnQndSMmtxenNnTUlm?=
 =?utf-8?B?ekpqVTl4bk9yZVVFdG1kdkg0dDcwa25tSjhRZjdyOU00blZzQTlvRFNsS2ls?=
 =?utf-8?B?NDFJZDl4NTY1bUk4QkRoK2RpbkJaZ2FWOSs0dHRnNDQxRzhSZjl1QWZMN2RL?=
 =?utf-8?B?N1pwRE1YK1M4ZkR2b1hMTnpqbkJrRHJjMDZQRFBEZGcrRjZQb2xKQ3pSYjVs?=
 =?utf-8?B?Zkl2WVlQVTdqUE9sY20zRU1BQlUzbzRZTG5TbzNZQTF4dHY2eHJIbUVmZ01m?=
 =?utf-8?B?SFdVNmdjOFdmbU95bEsxTm5NVTJVOElXRjVsRTNpaEk2ck9ZNGFERmFlTVZ1?=
 =?utf-8?B?YjVHSGVnUER0MXVwUUlCS2s2T0Uxdnp4UG93bU5QeHg0b1hITzFUVXduVEF4?=
 =?utf-8?B?SkhURjhYc25kQkZHNVpnYlMxTWNYTTQ4MmdtUmNZa1grb0I3eTRwYzgrMzRh?=
 =?utf-8?B?Z2kvcXNCdWdHakwvTGNEVFBXZEdjVjlpTk9QNlhlYTlNRUk3OUVsT1JWcVZD?=
 =?utf-8?B?cVk0SzBPK2JxcitRdzZ1S3dyWUowOWNRcENyQkh4V0hETXNHekZYUDNaL1RV?=
 =?utf-8?B?WTV4QXVnQ2ZIQzhDOHAreHpwaEw4aGxSRm11YUlDaDVsYmFkOUZsMTQ1SUlG?=
 =?utf-8?Q?0NoYDIIe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0feb1e-261a-46b0-4fd9-08d8c47c2b2f
X-MS-Exchange-CrossTenant-AuthSource: MW2PR18MB2267.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 17:34:45.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLbCZr68SrI/lYWEZTM0KrwjsJJvD8C5xwuP6u7i/RtXynD7OEcuWkgFswzlDUI0hVE687kylu0IldRg+ArSBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR18MB2218
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-29_06:2021-01-29,2021-01-29 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/29/21 06:23, Marcelo Tosatti wrote:
> External Email
> 
> ----------------------------------------------------------------------
> On Fri, Jan 29, 2021 at 08:55:20AM -0500, Nitesh Narayan Lal wrote:
>>
>> On 1/28/21 3:01 PM, Thomas Gleixner wrote:
>>> On Thu, Jan 28 2021 at 13:59, Marcelo Tosatti wrote:
>>>>> The whole pile wants to be reverted. It's simply broken in several ways.
>>>> I was asking for your comments on interaction with CPU hotplug :-)
>>> Which I answered in an seperate mail :)
>>>
>>>> So housekeeping_cpumask has multiple meanings. In this case:
>>> ...
>>>
>>>> So as long as the meaning of the flags are respected, seems
>>>> alright.
>>> Yes. Stuff like the managed interrupts preference for housekeeping CPUs
>>> when a affinity mask spawns housekeeping and isolated is perfectly
>>> fine. It's well thought out and has no limitations.
>>>
>>>> Nitesh, is there anything preventing this from being fixed
>>>> in userspace ? (as Thomas suggested previously).
>>> Everything with is not managed can be steered by user space.
>>>
>>> Thanks,
>>>
>>>          tglx
>>>
>>
>> So, I think the conclusion here would be to revert the change made in
>> cpumask_local_spread via the patch:
>>   - lib: Restrict cpumask_local_spread to housekeeping CPUs
>>
>> Also, a similar case can be made for the rps patch that went in with
>> this:
>>  - net: Restrict receive packets queuing to housekeeping CPUs
> 
> Yes, this is the userspace solution:
> 
> https://lkml.org/lkml/2021/1/22/815
> 
> Should have a kernel document with this info and examples
> (the network queue configuration as well). Will
> send something.
> 
>>  + net: accept an empty mask in /sys/class/net/*/queues/rx-*/rps_cpus
>>
>> I am not sure about the PCI patch as I don't think we can control that from
>> the userspace or maybe I am wrong?
> 
> You mean "lib: Restrict cpumask_local_spread to housekeeping CPUs" ?
> 

If we want to do it from userspace, we should have something that 
triggers it in userspace. Should we use udev for this purpose?

-- 
Alex
