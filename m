Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23405422CD4
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 17:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhJEPpx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 11:45:53 -0400
Received: from foss.arm.com ([217.140.110.172]:34602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhJEPpw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 11:45:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F27E21FB;
        Tue,  5 Oct 2021 08:44:01 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B48B3F70D;
        Tue,  5 Oct 2021 08:44:01 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211005151042.GA1083482@bhelgaas>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <2bcc69b5-6659-0ec4-cd33-a9b8e61d1afe@arm.com>
Date:   Tue, 5 Oct 2021 10:43:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211005151042.GA1083482@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thanks for looking at this again.


On 10/5/21 10:10 AM, Bjorn Helgaas wrote:
> On Thu, Aug 26, 2021 at 02:15:56AM -0500, Jeremy Linton wrote:
>> Now that there is a bcm2711 quirk, it needs to be enabled when the
>> MCFG is missing. Use an ACPI namespace _DSD property
>> "linux-ecam-quirk-id" as an alternative to the MCFG OEM.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>   drivers/acpi/pci_mcfg.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index 53cab975f612..04c517418365 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
>>   	ALTRA_ECAM_QUIRK(1, 13),
>>   	ALTRA_ECAM_QUIRK(1, 14),
>>   	ALTRA_ECAM_QUIRK(1, 15),
>> +
>> +	{ "bc2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
>> +	  DEFINE_RES_MEM(0xFD500000, 0xA000) },
>>   };
>>   
>>   static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
>> @@ -198,8 +201,22 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
>>   	u16 segment = root->segment;
>>   	struct resource *bus_range = &root->secondary;
>>   	struct mcfg_fixup *f;
>> +	const char *soc;
>>   	int i;
>>   
>> +	/*
>> +	 * This may be a machine with a PCI/SMC conduit, which means it doesn't
>> +	 * have an MCFG. Use an ACPI namespace definition instead.
>> +	 */
>> +	if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
>> +					 "linux-ecam-quirk-id", &soc)) {
>> +		if (strlen(soc) != ACPI_OEM_ID_SIZE)
> 
>  From a reviewing perspective, it's not obvious why soc must be exactly
> ACPI_OEM_ID_SIZE.  Does that imply space-padding in the DT string or
> something?

This is at the moment an ACPI only DSD, and it must follow the MADT 
OEM_ID format for now because we are effectively just overriding that 
field. The rest of the code in this module is just treating it as a 
fixed 6 bytes.


> 
> Is there any documentation for this DT property?

Its not a DT property, and its unclear since its linux only if it 
belongs in previously linked ACPI registry.

> 
> Also not obvious why strlen() is safe here.  I mean, I looked a couple
> levels deep in fwnode_property_read_string(), but whatever guarantees
> null termination is buried pretty deep.

I've not tracked down who, if anyone other than the AML compiler is 
guaranteeing a null. The spec says something to the effect "Most other 
string, however,  are of variable-length and are automatically null 
terminated by the compiler". Not sure if that helps any.

> 
> It seems a little weird to use an MCFG quirk mechanism when there's no
> MCFG at all on this platform.

Well its just a point to hook in a CFG space quirk, and since that is 
what most of the MCFG quirks are, it seemed reasonable to reuse it 
rather than recreate it.



PS, had some offline convo about reposing with a simple rebase and the 
ACK's applied, will do that if it helps any, but when I checked a couple 
weeks back this applied to 5.15 automatically.



> 
>> +			dev_err(&root->device->dev, "ECAM quirk should be %d characters\n",
>> +				ACPI_OEM_ID_SIZE);
>> +		else
>> +			memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
>> +	}
>> +
>>   	for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
>>   		if (pci_mcfg_quirk_matches(f, segment, bus_range)) {
>>   			if (f->cfgres.start)
>> -- 
>> 2.31.1
>>

