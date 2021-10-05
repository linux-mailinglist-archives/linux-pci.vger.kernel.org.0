Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12254233B3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 00:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhJEWqh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 18:46:37 -0400
Received: from foss.arm.com ([217.140.110.172]:36998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhJEWqg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 18:46:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 601336D;
        Tue,  5 Oct 2021 15:44:45 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7633C3F66F;
        Tue,  5 Oct 2021 15:44:44 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        robh@kernel.org, kw@linux.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210826071557.29239-1-jeremy.linton@arm.com>
 <20210826071557.29239-4-jeremy.linton@arm.com>
 <20211005200227.ltl6owwksfn7l4xx@pali>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <8cdc1b1a-7ea0-da3e-e6f1-2ae3f4c057db@arm.com>
Date:   Tue, 5 Oct 2021 17:44:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211005200227.ltl6owwksfn7l4xx@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/5/21 3:02 PM, Pali Rohár wrote:
> On Thursday 26 August 2021 02:15:56 Jeremy Linton wrote:
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
> 
> Hello!
> 
> According to discussion described in email [1], adding a new MCFG quirk
> (like above) into kernel requires adding some errata entry for
> documenting buggy HW.
> 
> But this patch series does not introduce any new errata entry.

Nor did the quirk following that email, which was merged. Presumably 
because I'm not sure anyone can predict the future, and some of the 
points in that posting were made simply to fill gaps in the arguments 
around why the SMC is/was a better plan. The final point about requiring 
a MCFG is also flies in the face of the fact that there is an Arm/Pci 
Standardized way to deal with these problems which is supported by other 
OS's running on these platforms and it requires that MFCG is missing. 
The idea that MCFG will magically appear for only Linux and contain 
relevant info (like the non even power of two cfg region on this SoC) is 
a bit wishful.

I'm certainly in no place to claim future PCIe compliance for Broadcom's 
SoC's, nor its lifecycle. I'm betting few people submitting Linux 
patches are, particularly for mostly community supported projects like 
the RPi4/CM4/ACPI port. I'm more than happy to hack/tweak future 
problems with this code, and possibly even extend it if needed. Thats 
about the extent of what I can do.


Thanks,




> 
> Bjorn, could you look at how to properly document these "hw bugs"?
> I guess there would be lot of more requests for adding MCFG quirks as
> now according to [1], doors are open for them. And it is possible that
> after more years nobody would be able to maintain these quirks if would
> not be properly documented.
> 
> [1] - https://lore.kernel.org/linux-pci/20210325131231.GA18590@e121166-lin.cambridge.arm.com/
> 
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

