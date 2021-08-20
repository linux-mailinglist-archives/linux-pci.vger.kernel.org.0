Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622F63F3549
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 22:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbhHTUcZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 16:32:25 -0400
Received: from foss.arm.com ([217.140.110.172]:36516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239000AbhHTUcZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 16:32:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D42D6101E;
        Fri, 20 Aug 2021 13:31:46 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C68033F66F;
        Fri, 20 Aug 2021 13:31:45 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] PCI: brcmstb: Add ACPI config space quirk
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, sdonthineni@nvidia.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210820190604.GA3340361@bjorn-Precision-5520>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <0f9443fc-51c8-105d-51ac-32725af4e710@arm.com>
Date:   Fri, 20 Aug 2021 15:31:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210820190604.GA3340361@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thanks for looking at this.

On 8/20/21 2:06 PM, Bjorn Helgaas wrote:
> On Thu, Aug 19, 2021 at 04:56:53PM -0500, Jeremy Linton wrote:
>> The PFTF CM4 is an ACPI platform that isn't ECAM compliant. Its config
>> space is in two parts. One part is for the root port registers and a
>> second moveable window pointing at a device's 4K config space. Thus it
>> doesn't have an MCFG, and any MCFG provided would be nonsense
>> anyway. Instead, a Linux specific host bridge _DSD selects a custom
>> ECAM ops and cfgres. The cfg op picks between those two regions while
>> disallowing problematic accesses.
> 
> This doesn't actually say what this patch *does*.

Ok.

> 
> Can you expand "PFTF CM4" somehow?  Google (and the comment below, I
> guess) suggests it's something to do with Raspberry Pi 4, but it would
> be nice if the commit log made sense without Googling or reading the
> patch.

Yes, sure, as you deduced PFTF is a community project which aims to 
create a systemready UEFI/ACPI platform out of rpi4/rpi400/cm4 systems. 
Its actually fairly far along in that goal, and is capable of booting a 
wide range of arm64 based OS's & Hypervisors. Its acting like a proof of 
concept that putting effort into some basic platform abstractions 
reduces the effort to boot off the shelf OSs. It does this by moving 
much of the platform specific code into firmware.



> 
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/pci/controller/Makefile            |  1 +
>>   drivers/pci/controller/pcie-brcmstb-acpi.c | 74 ++++++++++++++++++++++
>>   include/linux/pci-ecam.h                   |  1 +
>>   3 files changed, 76 insertions(+)
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
>> index 000000000000..71f6def3074c
>> --- /dev/null
>> +++ b/drivers/pci/controller/pcie-brcmstb-acpi.c
>> @@ -0,0 +1,74 @@
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
>> +	/* Assure link up before sending request */
> 
> Obviously this is horribly racy, since the link may go down after you
> check but before you send the request.  Maybe the hardware leaves you
> no choice.  I'd feel a little better about it if the comment
> acknowledged that (if it's so) and outlined the consequence of losing
> the race (panic, recoverable error, etc).

Sure, that gets at what appears to be the fundamental problem with this 
bridge, mainly that the HW doesn't appear to be able to handle missing 
config TLP completions in a way that can be recovered.

So, if one loses the race here (and the window is much larger in the DT 
config accessor) the machine takes what is basically an unrecoverable 
exception. I will update the comment to that effect.


> 
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

