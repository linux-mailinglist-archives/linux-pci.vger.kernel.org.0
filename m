Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9EF1437C3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbfFMPBG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:01:06 -0400
Received: from foss.arm.com ([217.140.110.172]:40954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732564AbfFMOjx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 10:39:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D184367;
        Thu, 13 Jun 2019 07:39:52 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 373F13F718;
        Thu, 13 Jun 2019 07:39:51 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:39:46 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V4 22/28] PCI: tegra: Access endpoint config only if PCIe
 link is up
Message-ID: <20190613143946.GA30445@e121166-lin.cambridge.arm.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-23-mmaddireddy@nvidia.com>
 <20190604131436.GS16519@ulmo>
 <09bcc121-eaca-3866-d0ef-7806503e883f@nvidia.com>
 <ca34eb24-8696-576f-26bc-8d6141f81a41@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca34eb24-8696-576f-26bc-8d6141f81a41@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 10, 2019 at 10:08:16AM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 04-Jun-19 7:40 PM, Manikanta Maddireddy wrote:
> >
> > On 04-Jun-19 6:44 PM, Thierry Reding wrote:
> >> On Thu, May 16, 2019 at 11:23:01AM +0530, Manikanta Maddireddy wrote:
> >>> Few endpoints like Wi-Fi supports power on/off and to leverage that
> >>> root port must support hot-plug and hot-unplug. Tegra PCIe doesn't
> >>> support hot-plug and hot-unplug, however it supports endpoint power
> >>> on/off feature as follows,
> >>>  - Power off sequence:
> >>>    - Transition of PCIe link to L2
> >>>    - Power off endpoint
> >>>    - Leave root port in power up state with the link in L2
> >>>  - Power on sequence:
> >>>    - Power on endpoint
> >>>    - Apply hot reset to get PCIe link up
> >>>
> >>> PCIe client driver stops accessing PCIe endpoint config and BAR registers
> >>> after endpoint is powered off. However, software applications like x11
> >>> server or lspci can access endpoint config registers in which case
> >>> host controller raises "response decoding" errors. To avoid this scenario,
> >>> add PCIe link up check in config read and write callback functions before
> >>> accessing endpoint config registers.
> >>>
> >>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >>> ---
> >>> V4: No change
> >>>
> >>> V3: Update the commit log with explanation for the need of this patch
> >>>
> >>> V2: Change tegra_pcie_link_status() to tegra_pcie_link_up()
> >>>
> >>>  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++++++++++++++++++++
> >>>  1 file changed, 38 insertions(+)
> >> This still doesn't look right to me conceptually. If somebody wants to
> >> access the PCI devices after the kernel has powered them off, why can't
> >> we just power the devices back on so that we allow userspace to properly
> >> access the devices?
> > 1. WiFi devices provides power-off feature for power saving in mobiles.
> > When WiFi is turned off we shouldn't power on the HW back without user
> > turning it back on.
> > 2. When ever user process tries to access config space, it'll end up
> > in these functions. We cannot have is_powered_on check in config read/write
> > callbacks.
> > 3. WiFi power on/off is device specific feature, we shouldn't handle it
> > in PCI subsystem or host controller driver.
> >
> >> Or if that's not what we want, shouldn't we add something to the core
> >> PCI infrastructure to let us deal with this? It seems like this is some
> >> general problem that would apply to every PCI device and host bridge
> >> driver. Having each driver implement this logic separately doesn't seem
> >> like a good idea to me.
> >>
> >> Thierry
> > This should be handled by hotplug feature, whenever endpoint is powered-off/
> > removed from the slot, hot unplug event should take care of it. Unfortunately
> > Tegra PCIe doesn't support hotplug feature.
> >
> > Manikanta
> 
> Hi Bjorn,
> 
> I thought about your comment in
> https://patchwork.ozlabs.org/patch/1084204/ again.  What if I add link
> up check in tegra_pcie_isr() and make "response decoding error" as
> debug print? EP Config access will happen when link is down, but
> "Response decoding error" print comes only if debug log is enabled.
> This way we can avoid race issue in config accessors and we get prints
> when debug logs are enabled.

I still do not see what you are actually solving. This patch should
be dropped.

Thanks,
Lorenzo

> Thierry,
> Please share your inputs as well.
> 
> Manikanta
>  
> 
> >>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> >>> index d20c88a79e00..33f4dfab9e35 100644
> >>> --- a/drivers/pci/controller/pci-tegra.c
> >>> +++ b/drivers/pci/controller/pci-tegra.c
> >>> @@ -428,6 +428,14 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
> >>>  	return readl(pcie->pads + offset);
> >>>  }
> >>>  
> >>> +static bool tegra_pcie_link_up(struct tegra_pcie_port *port)
> >>> +{
> >>> +	u32 value;
> >>> +
> >>> +	value = readl(port->base + RP_LINK_CONTROL_STATUS);
> >>> +	return !!(value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE);
> >>> +}
> >>> +
> >>>  /*
> >>>   * The configuration space mapping on Tegra is somewhat similar to the ECAM
> >>>   * defined by PCIe. However it deviates a bit in how the 4 bits for extended
> >>> @@ -493,20 +501,50 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
> >>>  static int tegra_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> >>>  				  int where, int size, u32 *value)
> >>>  {
> >>> +	struct tegra_pcie *pcie = bus->sysdata;
> >>> +	struct pci_dev *bridge;
> >>> +	struct tegra_pcie_port *port;
> >>> +
> >>>  	if (bus->number == 0)
> >>>  		return pci_generic_config_read32(bus, devfn, where, size,
> >>>  						 value);
> >>>  
> >>> +	bridge = pcie_find_root_port(bus->self);
> >>> +
> >>> +	list_for_each_entry(port, &pcie->ports, list)
> >>> +		if (port->index + 1 == PCI_SLOT(bridge->devfn))
> >>> +			break;
> >>> +
> >>> +	/* If there is no link, then there is no device */
> >>> +	if (!tegra_pcie_link_up(port)) {
> >>> +		*value = 0xffffffff;
> >>> +		return PCIBIOS_DEVICE_NOT_FOUND;
> >>> +	}
> >>> +
> >>>  	return pci_generic_config_read(bus, devfn, where, size, value);
> >>>  }
> >>>  
> >>>  static int tegra_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> >>>  				   int where, int size, u32 value)
> >>>  {
> >>> +	struct tegra_pcie *pcie = bus->sysdata;
> >>> +	struct tegra_pcie_port *port;
> >>> +	struct pci_dev *bridge;
> >>> +
> >>>  	if (bus->number == 0)
> >>>  		return pci_generic_config_write32(bus, devfn, where, size,
> >>>  						  value);
> >>>  
> >>> +	bridge = pcie_find_root_port(bus->self);
> >>> +
> >>> +	list_for_each_entry(port, &pcie->ports, list)
> >>> +		if (port->index + 1 == PCI_SLOT(bridge->devfn))
> >>> +			break;
> >>> +
> >>> +	/* If there is no link, then there is no device */
> >>> +	if (!tegra_pcie_link_up(port))
> >>> +		return PCIBIOS_DEVICE_NOT_FOUND;
> >>> +
> >>>  	return pci_generic_config_write(bus, devfn, where, size, value);
> >>>  }
> >>>  
> >>> -- 
> >>> 2.17.1
> >>>
> 
