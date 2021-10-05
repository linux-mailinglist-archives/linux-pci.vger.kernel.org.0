Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4934542347D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 01:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhJEXee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 19:34:34 -0400
Received: from foss.arm.com ([217.140.110.172]:43614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231304AbhJEXed (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 19:34:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35CB3D6E;
        Tue,  5 Oct 2021 16:32:42 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AE013F66F;
        Tue,  5 Oct 2021 16:32:40 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211005223148.GA1125087@bhelgaas>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <bd047c7e-6bfb-320c-db0d-1ddcf98667ae@arm.com>
Date:   Tue, 5 Oct 2021 18:32:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211005223148.GA1125087@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/5/21 5:31 PM, Bjorn Helgaas wrote:
> On Tue, Oct 05, 2021 at 10:43:32AM -0500, Jeremy Linton wrote:
>> On 10/5/21 10:10 AM, Bjorn Helgaas wrote:
>>> On Thu, Aug 26, 2021 at 02:15:56AM -0500, Jeremy Linton wrote:
>>>> Now that there is a bcm2711 quirk, it needs to be enabled when the
>>>> MCFG is missing. Use an ACPI namespace _DSD property
>>>> "linux-ecam-quirk-id" as an alternative to the MCFG OEM.
>>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> ---
>>>>    drivers/acpi/pci_mcfg.c | 17 +++++++++++++++++
>>>>    1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>>>> index 53cab975f612..04c517418365 100644
>>>> --- a/drivers/acpi/pci_mcfg.c
>>>> +++ b/drivers/acpi/pci_mcfg.c
>>>> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
>>>>    	ALTRA_ECAM_QUIRK(1, 13),
>>>>    	ALTRA_ECAM_QUIRK(1, 14),
>>>>    	ALTRA_ECAM_QUIRK(1, 15),
>>>> +
>>>> +	{ "bc2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
>>>> +	  DEFINE_RES_MEM(0xFD500000, 0xA000) },
>>>>    };
>>>>    static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
>>>> @@ -198,8 +201,22 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
>>>>    	u16 segment = root->segment;
>>>>    	struct resource *bus_range = &root->secondary;
>>>>    	struct mcfg_fixup *f;
>>>> +	const char *soc;
>>>>    	int i;
>>>> +	/*
>>>> +	 * This may be a machine with a PCI/SMC conduit, which means it doesn't
>>>> +	 * have an MCFG. Use an ACPI namespace definition instead.
>>>> +	 */
>>>> +	if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
>>>> +					 "linux-ecam-quirk-id", &soc)) {
>>>> +		if (strlen(soc) != ACPI_OEM_ID_SIZE)
>>>
>>>  From a reviewing perspective, it's not obvious why soc must be exactly
>>> ACPI_OEM_ID_SIZE.  Does that imply space-padding in the DT string or
>>> something?
>>
>> This is at the moment an ACPI only DSD, and it must follow the MADT OEM_ID
>> format for now because we are effectively just overriding that field. The
>> rest of the code in this module is just treating it as a fixed 6 bytes.
>>
>>> Is there any documentation for this DT property?
>>
>> Its not a DT property, and its unclear since its linux only if it
>> belongs in previously linked ACPI registry.
> 
> Oh, right, it comes from a _DSD.
> 
>>> Also not obvious why strlen() is safe here.  I mean, I looked a couple
>>> levels deep in fwnode_property_read_string(), but whatever guarantees
>>> null termination is buried pretty deep.
>>
>> I've not tracked down who, if anyone other than the AML compiler is
>> guaranteeing a null. The spec says something to the effect "Most other
>> string, however,  are of variable-length and are automatically null
>> terminated by the compiler". Not sure if that helps any.
> 
> Doesn't help for me.  The PCI core shouldn't go in the weeds no matter
> what junk we might get from an AML compiler.  Maybe
> fwnode_property_read_string() guarantees null termination, but it's
> not documented and not easy to verify.
> 
> I think a strncpy() here might be better.  Not sure it's worthwhile to
> emit a specific error message for the wrong length.

I think we went around about this a bit, but yes strncpy() is exactly 
what we want because the rest of the code assumes 6 non-null terminated 
characters and strncpy won't terminate it if its longer. OTOH, i'm not 
sure we really want shorter strings padded with nulls either.

strncpy() is easy though, so sure. <shrug>


> 
>>> It seems a little weird to use an MCFG quirk mechanism when there's no
>>> MCFG at all on this platform.
>>
>> Well its just a point to hook in a CFG space quirk, and since that
>> is what most of the MCFG quirks are, it seemed reasonable to reuse
>> it rather than recreate it.
> 
> Yeah, it's ugly no matter how we slice it.  The pci_no_msi()
> especially has nothing to do with ECAM at all.  But I don't know how
> to identify this thing for a quirk.  PNP0A08 devices really rely on
> ECAM or a system firmware config accessor.
> 
>>>> +			dev_err(&root->device->dev, "ECAM quirk should be %d characters\n",
>>>> +				ACPI_OEM_ID_SIZE);
>>>> +		else
>>>> +			memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
>>>> +	}
>>>> +
>>>>    	for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
>>>>    		if (pci_mcfg_quirk_matches(f, segment, bus_range)) {
>>>>    			if (f->cfgres.start)
>>>> -- 
>>>> 2.31.1
>>>>
>>

