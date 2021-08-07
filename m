Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584E63E3260
	for <lists+linux-pci@lfdr.de>; Sat,  7 Aug 2021 02:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhHGAfT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 20:35:19 -0400
Received: from foss.arm.com ([217.140.110.172]:42446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhHGAfT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 20:35:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 870E731B;
        Fri,  6 Aug 2021 17:35:02 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A37FA3F66F;
        Fri,  6 Aug 2021 17:35:01 -0700 (PDT)
Subject: Re: [PATCH 3/3] PCI/ACPI: Add new quirk detection, enable bcm2711
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210806221256.GA1891371@bjorn-Precision-5520>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <5f4f484b-9eef-2722-405d-a7ff6259aa0f@arm.com>
Date:   Fri, 6 Aug 2021 19:34:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210806221256.GA1891371@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thanks for looking at this.

On 8/6/21 5:12 PM, Bjorn Helgaas wrote:
> In subject, this or similar would match history:
> 
>    PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
> 
> On Thu, Aug 05, 2021 at 04:12:00PM -0500, Jeremy Linton wrote:
>> Now that we have a bcm2711 quirk, we need to be able to
>> detect it when the MCFG is missing. Use a namespace
>> property as an alternative to the MCFG OEM.
> 
> Rewrap to use ~75 columns.
> 
> Mention the DT namespace property here.
> 
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/pci_mcfg.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index 53cab975f612..7d77fc72c2a4 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
>>   	ALTRA_ECAM_QUIRK(1, 13),
>>   	ALTRA_ECAM_QUIRK(1, 14),
>>   	ALTRA_ECAM_QUIRK(1, 15),
>> +
>> +	{ "bcm2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
>> +	  DEFINE_RES_MEM(0xFD500000, 0xA000) },
>>   };
>>   
>>   static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
>> @@ -198,8 +201,19 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
>>   	u16 segment = root->segment;
>>   	struct resource *bus_range = &root->secondary;
>>   	struct mcfg_fixup *f;
>> +	const char *soc;
>>   	int i;
>>   
>> +	/*
>> +	 * This could be a machine with a PCI/SMC conduit,
>> +	 * which means it doens't have MCFG. Get the machineid from
>> +	 * the namespace definition instead.
> 
> s/SMC/SMCCC/ ?  Cover letter uses SMCCC (not sure it's relevant anyway)
> s/doens't/doesn't/
> 
> Rewrap comment to use ~80 columns.
> 
> Seems pretty reasonable that a platform without standard ECAM might
> not have MCFG, since MCFG basically implies ECAM.


Sure, on all the above comments.

> 
> Is "linux,pcie-quirk" the right property to look for?  It doesn't
> sound very generic, and it doesn't sound like anything related to
> ECAM.  Is it new?  I don't see it in the tree yet.  Should it be in
> Documentation/devicetree/bindings/pci/pci.txt so we don't get a
> different property name for every new platform?

Yes, I made it up. Someone else commented about the "linux," partially 
because it should be "linux-" to conform with 
https://github.com/UEFI/DSD-Guide. But also in the same context of it 
being linux specific.  I think that guide is where it should end up, 
rather than the devicetree bindings.

I guess we can request addition to the uefi- but that seems like a 
mistake this is really (hopefully?) a Linux specific properly as other 
OS's will simply use the SMC. I think we could request another prefix if 
we come up with a good one and think it belongs in that guide.




> 
>> +	 */
>> +	if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
>> +					 "linux,pcie-quirk", &soc)) {
>> +		memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
>> +	}
>> +
>>   	for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
>>   		if (pci_mcfg_quirk_matches(f, segment, bus_range)) {
>>   			if (f->cfgres.start)
>> -- 
>> 2.31.1
>>

