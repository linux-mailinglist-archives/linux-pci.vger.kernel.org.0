Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA713F6B49
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 23:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhHXVkH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 17:40:07 -0400
Received: from foss.arm.com ([217.140.110.172]:41126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234442AbhHXVkH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 17:40:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41BB0D6E;
        Tue, 24 Aug 2021 14:39:22 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A06533F5A1;
        Tue, 24 Aug 2021 14:39:21 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
To:     Florian Fainelli <f.fainelli@gmail.com>, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        sdonthineni@nvidia.com, stefan.wahren@i2se.com,
        bcm-kernel-feedback-list@broadcom.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210819215655.84866-1-jeremy.linton@arm.com>
 <20210819215655.84866-4-jeremy.linton@arm.com>
 <9796674a-5870-135c-2fdc-fb0d5347d7c7@gmail.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <ddffee4b-8136-9ca1-85f7-bfdbac07bfe7@arm.com>
Date:   Tue, 24 Aug 2021 16:39:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9796674a-5870-135c-2fdc-fb0d5347d7c7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/22/21 3:53 AM, Florian Fainelli wrote:
> 
> 
> On 8/19/2021 11:56 PM, Jeremy Linton wrote:
>> Now that there is a bcm2711 quirk, it needs to be enabled when the
>> MCFG is missing. Use an ACPI namespace _DSD property
>> "linux-ecam-quirk-id" as an alternative to the MCFG OEM.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/pci_mcfg.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index 53cab975f612..4b991ee5c66c 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
>>       ALTRA_ECAM_QUIRK(1, 13),
>>       ALTRA_ECAM_QUIRK(1, 14),
>>       ALTRA_ECAM_QUIRK(1, 15),
>> +
>> +    { "bcm2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
>> +      DEFINE_RES_MEM(0xFD500000, 0xA000) },
>>   };
>>   static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
>> @@ -198,8 +201,18 @@ static void pci_mcfg_apply_quirks(struct 
>> acpi_pci_root *root,
>>       u16 segment = root->segment;
>>       struct resource *bus_range = &root->secondary;
>>       struct mcfg_fixup *f;
>> +    const char *soc;
>>       int i;
>> +    /*
>> +     * This may be a machine with a PCI/SMC conduit, which means it 
>> doesn't
>> +     * have an MCFG. Use an ACPI namespace definition instead.
>> +     */
>> +    if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
>> +                     "linux-ecam-quirk-id", &soc)) {
>> +        memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
> 
> Being super paranoid here, can we use one of the "safe" string copy 
> routines here just in case?

Hmm, I went around with this a bit when I first wrote it, because the 
OEM fields in the ACPI tables are fixed len and don't have null 
termination. Maybe the right thing to do here is verify the string size 
is at least as long as the OEM_ID_SIZE and then continue to use the memcpy.

> 
>> +    }
>> +
>>       for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, 
>> f++) {
>>           if (pci_mcfg_quirk_matches(f, segment, bus_range)) {
>>               if (f->cfgres.start)
>>
> 

