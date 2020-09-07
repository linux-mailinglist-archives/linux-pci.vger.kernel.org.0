Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0523D25FE49
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 18:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgIGQMP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 12:12:15 -0400
Received: from foss.arm.com ([217.140.110.172]:39900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729821AbgIGQMO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 12:12:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 905AC31B;
        Mon,  7 Sep 2020 09:12:13 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 367A53F68F;
        Mon,  7 Sep 2020 09:12:13 -0700 (PDT)
Subject: Re: [PATCH] PCI/ACPI: Suppress missing MCFG message
To:     Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org
Cc:     tn@semihalf.com, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        steven.price@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        sudeep.holla@arm.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200904170829.431900-1-jeremy.linton@arm.com>
 <f0c815a0-91f0-aaa6-0f1c-843400a83fd8@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <9e1cb29d-cd27-9a7b-58f8-79b2b3bff4d0@arm.com>
Date:   Mon, 7 Sep 2020 11:11:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f0c815a0-91f0-aaa6-0f1c-843400a83fd8@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 9/6/20 10:30 PM, Hanjun Guo wrote:
> Hi Jeremy,
> 
> On 2020/9/5 1:08, Jeremy Linton wrote:
>> MCFG is an optional ACPI table. Given there are machines
>> without PCI(e) (or it is hidden) we have been receiving
>> queries/complaints about what this message means given
>> its being presented as an error.
>>
>> Lets only print an error if something is wrong with the
>> the given table/etc. The ACPI table list printed at boot
>> will continue to provide a way to detect when the table
>> is missing.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/pci_mcfg.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index 54b36b7ad47d..0bc8c012f157 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -279,6 +279,6 @@ static __init int pci_mcfg_parse(struct 
>> acpi_table_header *header)
>>   void __init pci_mmcfg_late_init(void)
>>   {
>>       int err = acpi_table_parse(ACPI_SIG_MCFG, pci_mcfg_parse);
> 
> acpi_table_parse() will return errno -ENODEV and -EINVAL, and only
> returns -EINVAL if the table id or the handler is NULL, which is
> impossible here.

Right because it doesn't actually return the handler failures.
  >
>> -    if (err)
>> +    if (err && err != -ENODEV)
> 
> So the error message below will never be printed, I would
> prefer update the pr_err() to pr_dbg() for optional ACPI
> table.

Sure, that is a fine plan too.



> 
>>           pr_err("Failed to parse MCFG (%d)\n", err);
>>   }
> 
> Thanks
> Hanjun
> 

