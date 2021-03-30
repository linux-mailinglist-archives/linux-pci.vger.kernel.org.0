Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EADF34DE45
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 04:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhC3CXy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 22:23:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14189 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhC3CX0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 22:23:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8Y8C1lbrzmc49;
        Tue, 30 Mar 2021 10:20:43 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.162) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 10:23:16 +0800
Subject: Re: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by
 __packed
To:     David Laight <David.Laight@ACULAB.COM>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
 <1616831193-17920-5-git-send-email-tanxiaofei@huawei.com>
 <6df04be78e544e17b3b57f159312541f@AcuMS.aculab.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <34dd3de8-644d-6e44-965a-0991b7027cae@huawei.com>
Date:   Tue, 30 Mar 2021 10:23:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <6df04be78e544e17b3b57f159312541f@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi David,

On 2021/3/29 18:09, David Laight wrote:
> From: Xiaofei Tan
>> Sent: 27 March 2021 07:46
>>
>> Replace __attribute__((packed)) by __packed following the
>> advice of checkpatch.pl.
>>
>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> ---
>>  drivers/acpi/acpi_fpdt.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
>> index a89a806..690a88a 100644
>> --- a/drivers/acpi/acpi_fpdt.c
>> +++ b/drivers/acpi/acpi_fpdt.c
>> @@ -53,7 +53,7 @@ struct resume_performance_record {
>>  	u32 resume_count;
>>  	u64 resume_prev;
>>  	u64 resume_avg;
>> -} __attribute__((packed));
>> +} __packed;
>>
>>  struct boot_performance_record {
>>  	struct fpdt_record_header header;
>> @@ -63,13 +63,13 @@ struct boot_performance_record {
>>  	u64 bootloader_launch;
>>  	u64 exitbootservice_start;
>>  	u64 exitbootservice_end;
>> -} __attribute__((packed));
>> +} __packed;
>>
>>  struct suspend_performance_record {
>>  	struct fpdt_record_header header;
>>  	u64 suspend_start;
>>  	u64 suspend_end;
>> -} __attribute__((packed));
>> +} __packed;
>
> My standard question about 'packed' is whether it is actually needed.
> It should only be used if the structures might be misaligned in memory.
> If the only problem is that a 64bit item needs to be 32bit aligned
> then a suitable type should be used for those specific fields.
>
> Those all look very dubious - the standard header isn't packed
> so everything must eb assumed to be at least 32bit aligned.
>
> There are also other sub-structures that contain 64bit values.
> These don't contain padding - but that requires 64bit alignement.
>
> The only problematic structure is the last one - which would have
> a 32bit pad after the header.
> Is this even right given than there are explicit alignment pads
> in some of the other structures.
>
> If 64bit alignment isn't guaranteed then a '64bit aligned to 32bit'
> type should be used for the u64 fields.
>

Yes, some of them has been aligned already, then nothing changed when 
add this "packed ". Maybe the purpose of the original author is for 
extension, and can tell others that this struct need be packed.

> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
>
> .
>

