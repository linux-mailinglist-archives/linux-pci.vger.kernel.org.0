Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698A63E32D2
	for <lists+linux-pci@lfdr.de>; Sat,  7 Aug 2021 04:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhHGCzu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 22:55:50 -0400
Received: from foss.arm.com ([217.140.110.172]:44300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhHGCzt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 22:55:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A67006D;
        Fri,  6 Aug 2021 19:55:32 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FECD3F40C;
        Fri,  6 Aug 2021 19:55:32 -0700 (PDT)
Subject: Re: [PATCH 2/3] PCI: brcmstb: Add ACPI config space quirk
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210806222151.GA1892781@bjorn-Precision-5520>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <51a11c89-d49b-7367-a75c-13016a2ea5d9@arm.com>
Date:   Fri, 6 Aug 2021 21:55:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210806222151.GA1892781@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/6/21 5:21 PM, Bjorn Helgaas wrote:
> On Thu, Aug 05, 2021 at 04:11:59PM -0500, Jeremy Linton wrote:
>> The PFTF CM4 is an ACPI platform that is following the PCIe SMCCC
>> standard because its PCIe config space isn't ECAM compliant and is
>> split into two parts. One part for the root port registers and a
>> moveable window which points at a given device's 4K config space.
>> Thus it doesn't have a MCFG (and really any MCFG provided would be
>> nonsense anyway). As Linux doesn't support the PCIe SMCCC standard
>> we key off a Linux specific host bridge _DSD to add custom ECAM
>> ops and cfgres. The cfg op selects between those two regions, as
>> well as disallowing problematic accesses, particularly if the link
>> is down because there isn't an attached device.
> 
> I'm not sure SMCCC is *really* relevant here.  If it is, an expansion
> of the acronym and a link to a spec would be helpful.
> 
> But AFAICT the only important thing here is that it doesn't have
> standard ECAM, and we're going to work around that.

I will reword it a bit.

> 
> I don't see anything about _DSD in this series.

That is the "linux,pci-quirk" in the next patch.

> 
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/pci/controller/Makefile            |  1 +
>>   drivers/pci/controller/pcie-brcmstb-acpi.c | 77 ++++++++++++++++++++++
>>   include/linux/pci-ecam.h                   |  1 +
>>   3 files changed, 79 insertions(+)
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
>> index 000000000000..76944876155f
>> --- /dev/null
>> +++ b/drivers/pci/controller/pcie-brcmstb-acpi.c
>> @@ -0,0 +1,77 @@
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
>> +#include <linux/pci-acpi.h>
> 
> Do we use something from pci-acpi.h?

Good catch.

> 
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
>> +	 * and nonstandard registers together rather than mapping them
>> +	 * separately. This code simply honors the quirk provided base+size
>> +	 * instead.
>> +	 */
>> +	iounmap(cfg->win);
>> +	cfg->win = pci_remap_cfgspace(cfg->res.start, resource_size(&cfg->res));
>> +	if (!cfg->win)
>> +		goto err_exit;
>> +
>> +	/* MSI is nonstandard as well */
>> +	pci_no_msi();
>> +
>> +	return 0;
>> +err_exit:
>> +	dev_err(cfg->parent, "PCI: Failed to remap config\n");
>> +	return -ENOMEM;
>> +}
>> +
>> +static void __iomem *brcm_pcie_map_conf2(struct pci_bus *bus, unsigned int devfn,
>> +					int where)
> 
> Rewrap to fit in 80 columns.  81 is just ... weird :)
Sure,
> 
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
>> +	/* Assure link up before sending request */
>> +	up = readl(base + PCIE_MISC_PCIE_STATUS);
>> +	if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK))
>> +		return NULL;
>> +
>> +	if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK))
>> +		return NULL;
> 
> What happens if the link goes down here?  Hopefully that's a
> recoverable error?

This check is intended to verify that something is plugged into the 
first bus/slot before attempting to probe it. If nothing is plugged in 
bad things (TM) happen without this check.

But, you sparked my curiosity. I've had some reasonable luck with error 
recovery with a number of those cheap pcie->pcie switches that passively 
route PCIe over USB3 cables when plugged into this thing. So, I tried 
hotpluging the first one to see what happens.

Game over!  :)

Linux was nice enough to tell me it couldn't change the power state back 
to active, but it looks like the link state actually recovered. OTOH, 
the downstream switch appeared to need reconfiguration even though it 
was on a separate power domain. Given, I booted the machine off a NVMe 
drive plugged into that switch, I got another nice screen full of blk_mq 
errors before it officially passed on.

So, the link appears to recover, but that doesn't appear to be enough to 
make the downstream devices recoverable.

Thanks,


> 
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

