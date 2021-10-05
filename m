Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8644422D20
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 17:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhJEP7V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 11:59:21 -0400
Received: from foss.arm.com ([217.140.110.172]:36724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233705AbhJEP7T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 11:59:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC36E6D;
        Tue,  5 Oct 2021 08:57:28 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 849D03F766;
        Tue,  5 Oct 2021 08:57:27 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] PCI: brcmstb: Add ACPI config space quirk
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211005153209.GA1083986@bhelgaas>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <d4b34193-31e5-2f95-6365-b58239c0dabb@arm.com>
Date:   Tue, 5 Oct 2021 10:57:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211005153209.GA1083986@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/5/21 10:32 AM, Bjorn Helgaas wrote:
> On Thu, Aug 26, 2021 at 02:15:55AM -0500, Jeremy Linton wrote:
>> The Pi Firmware Task Force (PFTF: https://github.com/pftf) Compute
>> Module 4 (CM4: an embedded form factor RPi4) is an ACPI platform that
>> isn't ECAM compliant. Its config space is in two parts. One part is for
>> the root port registers and a second moveable window pointing at a
>> device's 4K config space. Thus it doesn't have an MCFG, and any MCFG
>> provided would be nonsense anyway.
>>
>> Instead, a custom pci_ecam_ops quirk is created. The custom ops override
>> the .init and .map_bus functions. The former to assure that cfg->win
>> points at a single mapping that contains the root port registers and the
>> device config window, as well as disabling MSIs due to lack of a
>> GICv2M. map_bus() then provides the address of either the standard
>> portion of the root port registers or to the device config window after
>> it has been moved.
>>
>> Additionally, some basic bus/device filtering exist to avoid sending
>> config transactions to invalid devices on the RP's primary or
>> secondary bus. A basic link check is also made to assure that
>> something is operational on the secondary side before probing the
>> remainder of the config space. If either of these constraints are
>> violated and a config operation is lost in the ether because an EP
>> doesn't respond an unrecoverable SERROR is raised.
> 
> It's not "lost"; I assume the root port raises an error because it
> can't send a transaction over a link that is down.

The problem is AFAIK because the root port doesn't do that.

> 
> Is "SERROR" an ARM64 thing?  My guess is the root port would raise an
> Unsupported Request error or similar, and the root complex turns that
> into a system-specific SERROR?

AFAIK, what is happening here the CPU core has an outstanding R/W 
request for which it never receives a response from the root port. So 
basically its an interconnect protocol violation that the CPU is 
complaining about rather than something PCIe specific.


> 
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>   drivers/pci/controller/Makefile            |  1 +
>>   drivers/pci/controller/pcie-brcmstb-acpi.c | 79 ++++++++++++++++++++++
>>   include/linux/pci-ecam.h                   |  1 +
>>   3 files changed, 81 insertions(+)
>>   create mode 100644 drivers/pci/controller/pcie-brcmstb-acpi.c
>>
>> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
>> index aaf30b3dcc14..65aa6fd3ed89 100644
>> --- a/drivers/pci/controller/Makefile
>> +++ b/drivers/pci/controller/Makefile
>> @@ -57,5 +57,6 @@ ifdef CONFIG_PCI_QUIRKS
>>   obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
>>   obj-$(CONFIG_ARM64) += pci-thunder-pem.o
>>   obj-$(CONFIG_ARM64) += pci-xgene.o
>> +obj-$(CONFIG_ARM64) += pcie-brcmstb-acpi.o
>>   endif
>>   endif
>> diff --git a/drivers/pci/controller/pcie-brcmstb-acpi.c b/drivers/pci/controller/pcie-brcmstb-acpi.c
>> new file mode 100644
>> index 000000000000..528b2b3ffbd2
>> --- /dev/null
>> +++ b/drivers/pci/controller/pcie-brcmstb-acpi.c
>> @@ -0,0 +1,79 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * ACPI quirks for Brcm2711 PCIe host controller
>> + * As used on the Raspberry Pi Compute Module 4
>> + *
>> + * Copyright (C) 2021 Arm Ltd.
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/pci.h>
>> +#include <linux/pci-ecam.h>
>> +#include "../pci.h"
>> +#include "pcie-brcmstb.h"
>> +
>> +static int brcm_acpi_init(struct pci_config_window *cfg)
>> +{
>> +	/*
>> +	 * This platform doesn't technically have anything that could be called
>> +	 * ECAM. Its config region has root port specific registers between
>> +	 * standard PCIe defined config registers. Thus the region setup by the
>> +	 * generic ECAM code needs to be adjusted. The HW can access bus 0-ff
>> +	 * but the footprint isn't a nice power of 2 (40k). For purposes of
>> +	 * mapping the config region we are just going to squash the standard
>> +	 * and nonstandard registers together rather than mapping them separately.
> 
> Wrap this and comment below to fit in 80 columns.  Nothing magic about
> 80 columns except for the fact that all the other code in drivers/pci
> fits in that width and consistency is helpful.

Hmm, I thought I had wrapped these, but probably at 78, guess I will 
rebase/repost.

> 
>> +	 */
>> +	iounmap(cfg->win);
>> +	cfg->win = pci_remap_cfgspace(cfg->res.start, resource_size(&cfg->res));
>> +	if (!cfg->win)
>> +		goto err_exit;
>> +
>> +	/* MSI is nonstandard as well */
>> +	pci_no_msi();
> 
> This doesn't seem to fit in an MCFG quirk.

"pcie quirk"

> 
>> +	return 0;
>> +err_exit:
>> +	dev_err(cfg->parent, "PCI: Failed to remap config\n");
>> +	return -ENOMEM;
>> +}
>> +
>> +static void __iomem *brcm_pcie_map_conf2(struct pci_bus *bus,
>> +					unsigned int devfn, int where)
>> +{
>> +	struct pci_config_window *cfg = bus->sysdata;
>> +	void __iomem *base = cfg->win;
>> +	int idx;
>> +	u32 up;
>> +
>> +	/* Accesses to the RC go right to the RC registers if slot==0 */
>> +	if (pci_is_root_bus(bus))
>> +		return PCI_SLOT(devfn) ? NULL : base + where;
>> +
>> +	/*
>> +	 * Assure the link is up before sending requests downstream. This is done
>> +	 * to avoid sending transactions to EPs that don't exist. Link flap
>> +	 * conditions/etc make this race more probable. The resulting unrecoverable
>> +	 * SERRORs will result in the machine crashing.
> 
> Is the crash because SERROR is fundamentally unrecoverable?  Is there
> any control over what kind of system-specific error the PCIe errors
> are mapped to?

Yes, that is basically where we are because the reason for the exception 
can't really be pinned down. There are some thoughts about ways to work 
around the problem, but they aren't pretty and probably need to be done 
at an exception level higher than what the kernel is operating at. Hence 
the SMC.

> 
> I know there are other systems where PCIe errors always cause a system
> crash, but most platforms seem to be moving toward at least the
> theoretical ability to recover from I/O errors.

Yes, that would be part of SBSA, which of course this platform isn't.


> 
>> +	 */
>> +	up = readl(base + PCIE_MISC_PCIE_STATUS);
>> +	if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK))
>> +		return NULL;
>> +
>> +	if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK))
>> +		return NULL;
>> +
>> +	/* For devices, write to the config space index register */
>> +	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
>> +	writel(idx, base + PCIE_EXT_CFG_INDEX);
>> +	return base + PCIE_EXT_CFG_DATA + where;
>> +}
>> +
>> +const struct pci_ecam_ops bcm2711_pcie_ops = {
>> +	.init		= brcm_acpi_init,
>> +	.bus_shift	= 1,
>> +	.pci_ops	= {
>> +		.map_bus	= brcm_pcie_map_conf2,
>> +		.read		= pci_generic_config_read,
>> +		.write		= pci_generic_config_write,
>> +	}
>> +};
>> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
>> index adea5a4771cf..a5de0285bb7f 100644
>> --- a/include/linux/pci-ecam.h
>> +++ b/include/linux/pci-ecam.h
>> @@ -87,6 +87,7 @@ extern const struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 *
>>   extern const struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
>>   extern const struct pci_ecam_ops al_pcie_ops;	/* Amazon Annapurna Labs PCIe */
>>   extern const struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
>> +extern const struct pci_ecam_ops bcm2711_pcie_ops; /* Bcm2711 PCIe */
>>   #endif
>>   
>>   #if IS_ENABLED(CONFIG_PCI_HOST_COMMON)
>> -- 
>> 2.31.1
>>

