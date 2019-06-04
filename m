Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5A349CB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfFDOKb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 10:10:31 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1228 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFDOKb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 10:10:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf67bc80000>; Tue, 04 Jun 2019 07:10:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 04 Jun 2019 07:10:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 04 Jun 2019 07:10:29 -0700
Received: from [10.24.192.32] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Jun
 2019 14:10:25 +0000
Subject: Re: [PATCH V4 22/28] PCI: tegra: Access endpoint config only if PCIe
 link is up
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-23-mmaddireddy@nvidia.com>
 <20190604131436.GS16519@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <09bcc121-eaca-3866-d0ef-7806503e883f@nvidia.com>
Date:   Tue, 4 Jun 2019 19:40:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604131436.GS16519@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559657416; bh=e8fq9MpMuIFTNejCHaVxMSMSN3rhrW0rCYiIMJL4v58=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=aHG7sdhriXAHkcHW0sAQZ4NsYP8jZKtaPRPo2Fv7SI10LSWMulwb7d4zPJNpUrc1D
         bJGC17YGNK+4UgbdHC3Fziaa1qOY3edBY0l2cbRuOJ+5/Xw9F/CWzHSYPyz1jP78JZ
         LgQ80vvicsYRuMHmsj0mX9oSYdH4rCXnUug9fDMKuhVkmO7uGTa5qmNA5PDzHYqXhF
         PFdMR8R5wE0p5MVRikSZ3BHLc03cYB5/9qrVqvcUwCv2+ECDZH8kYKdeM6/lhlZkXK
         MX7U1+WGMMUTZvNTeiEMPIJUIGavbxQO6rdpdK+pVV2cfndFhZxdqEyIZNo6esenjB
         yqxD9RdG+vu1w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 04-Jun-19 6:44 PM, Thierry Reding wrote:
> On Thu, May 16, 2019 at 11:23:01AM +0530, Manikanta Maddireddy wrote:
>> Few endpoints like Wi-Fi supports power on/off and to leverage that
>> root port must support hot-plug and hot-unplug. Tegra PCIe doesn't
>> support hot-plug and hot-unplug, however it supports endpoint power
>> on/off feature as follows,
>>  - Power off sequence:
>>    - Transition of PCIe link to L2
>>    - Power off endpoint
>>    - Leave root port in power up state with the link in L2
>>  - Power on sequence:
>>    - Power on endpoint
>>    - Apply hot reset to get PCIe link up
>>
>> PCIe client driver stops accessing PCIe endpoint config and BAR registers
>> after endpoint is powered off. However, software applications like x11
>> server or lspci can access endpoint config registers in which case
>> host controller raises "response decoding" errors. To avoid this scenario,
>> add PCIe link up check in config read and write callback functions before
>> accessing endpoint config registers.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> V4: No change
>>
>> V3: Update the commit log with explanation for the need of this patch
>>
>> V2: Change tegra_pcie_link_status() to tegra_pcie_link_up()
>>
>>  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
> This still doesn't look right to me conceptually. If somebody wants to
> access the PCI devices after the kernel has powered them off, why can't
> we just power the devices back on so that we allow userspace to properly
> access the devices?

1. WiFi devices provides power-off feature for power saving in mobiles.
When WiFi is turned off we shouldn't power on the HW back without user
turning it back on.
2. When ever user process tries to access config space, it'll end up
in these functions. We cannot have is_powered_on check in config read/write
callbacks.
3. WiFi power on/off is device specific feature, we shouldn't handle it
in PCI subsystem or host controller driver.

>
> Or if that's not what we want, shouldn't we add something to the core
> PCI infrastructure to let us deal with this? It seems like this is some
> general problem that would apply to every PCI device and host bridge
> driver. Having each driver implement this logic separately doesn't seem
> like a good idea to me.
>
> Thierry

This should be handled by hotplug feature, whenever endpoint is powered-off/
removed from the slot, hot unplug event should take care of it. Unfortunately
Tegra PCIe doesn't support hotplug feature.

Manikanta

>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index d20c88a79e00..33f4dfab9e35 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -428,6 +428,14 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
>>  	return readl(pcie->pads + offset);
>>  }
>>  
>> +static bool tegra_pcie_link_up(struct tegra_pcie_port *port)
>> +{
>> +	u32 value;
>> +
>> +	value = readl(port->base + RP_LINK_CONTROL_STATUS);
>> +	return !!(value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE);
>> +}
>> +
>>  /*
>>   * The configuration space mapping on Tegra is somewhat similar to the ECAM
>>   * defined by PCIe. However it deviates a bit in how the 4 bits for extended
>> @@ -493,20 +501,50 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>>  static int tegra_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
>>  				  int where, int size, u32 *value)
>>  {
>> +	struct tegra_pcie *pcie = bus->sysdata;
>> +	struct pci_dev *bridge;
>> +	struct tegra_pcie_port *port;
>> +
>>  	if (bus->number == 0)
>>  		return pci_generic_config_read32(bus, devfn, where, size,
>>  						 value);
>>  
>> +	bridge = pcie_find_root_port(bus->self);
>> +
>> +	list_for_each_entry(port, &pcie->ports, list)
>> +		if (port->index + 1 == PCI_SLOT(bridge->devfn))
>> +			break;
>> +
>> +	/* If there is no link, then there is no device */
>> +	if (!tegra_pcie_link_up(port)) {
>> +		*value = 0xffffffff;
>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>> +	}
>> +
>>  	return pci_generic_config_read(bus, devfn, where, size, value);
>>  }
>>  
>>  static int tegra_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
>>  				   int where, int size, u32 value)
>>  {
>> +	struct tegra_pcie *pcie = bus->sysdata;
>> +	struct tegra_pcie_port *port;
>> +	struct pci_dev *bridge;
>> +
>>  	if (bus->number == 0)
>>  		return pci_generic_config_write32(bus, devfn, where, size,
>>  						  value);
>>  
>> +	bridge = pcie_find_root_port(bus->self);
>> +
>> +	list_for_each_entry(port, &pcie->ports, list)
>> +		if (port->index + 1 == PCI_SLOT(bridge->devfn))
>> +			break;
>> +
>> +	/* If there is no link, then there is no device */
>> +	if (!tegra_pcie_link_up(port))
>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>> +
>>  	return pci_generic_config_write(bus, devfn, where, size, value);
>>  }
>>  
>> -- 
>> 2.17.1
>>

