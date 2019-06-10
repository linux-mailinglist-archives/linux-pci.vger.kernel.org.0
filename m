Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7BF3AE3C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2019 06:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfFJEit (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 00:38:49 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13745 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfFJEis (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jun 2019 00:38:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfdded60000>; Sun, 09 Jun 2019 21:38:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 09 Jun 2019 21:38:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 09 Jun 2019 21:38:46 -0700
Received: from [10.24.192.30] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Jun
 2019 04:38:43 +0000
Subject: Re: [PATCH V4 22/28] PCI: tegra: Access endpoint config only if PCIe
 link is up
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>, <bhelgaas@google.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-23-mmaddireddy@nvidia.com>
 <20190604131436.GS16519@ulmo>
 <09bcc121-eaca-3866-d0ef-7806503e883f@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <ca34eb24-8696-576f-26bc-8d6141f81a41@nvidia.com>
Date:   Mon, 10 Jun 2019 10:08:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <09bcc121-eaca-3866-d0ef-7806503e883f@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560141526; bh=4ak0b1zw2t9GAGhq6XjTYGiH4zepUYojd2UbEKqwzTI=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=W3cXUG2e3BWUb4qQFR5H8Vq4J5glOILCoEHC89sleJvFetWF0v+rFEaH353hoIVEh
         OVe9pqqAsfovvFPhPs6QLTFCCdzU6S36zHvWITbn8eplTCdK4gjJCFAmHXxnenKJqP
         EKXBnbIlyTdpXlnC6IE7ottocbynWwsIn92lqFKdRVkHpNiNJhMs131XlQDnipCUWP
         ze7Oude7VLKrXKmqFkGHvaDBde0JgrhXrEI8Bk7DaCeggFOtqtFbvLfPaVfS07fUdN
         9iL8u2XkgZ831L4StQ43gCRn+rAqJzkIavInVY2N4cVNxBebI+1UN1TsDxjB39mWC6
         6nwXQBg1oZKXQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 04-Jun-19 7:40 PM, Manikanta Maddireddy wrote:
>
> On 04-Jun-19 6:44 PM, Thierry Reding wrote:
>> On Thu, May 16, 2019 at 11:23:01AM +0530, Manikanta Maddireddy wrote:
>>> Few endpoints like Wi-Fi supports power on/off and to leverage that
>>> root port must support hot-plug and hot-unplug. Tegra PCIe doesn't
>>> support hot-plug and hot-unplug, however it supports endpoint power
>>> on/off feature as follows,
>>>  - Power off sequence:
>>>    - Transition of PCIe link to L2
>>>    - Power off endpoint
>>>    - Leave root port in power up state with the link in L2
>>>  - Power on sequence:
>>>    - Power on endpoint
>>>    - Apply hot reset to get PCIe link up
>>>
>>> PCIe client driver stops accessing PCIe endpoint config and BAR registe=
rs
>>> after endpoint is powered off. However, software applications like x11
>>> server or lspci can access endpoint config registers in which case
>>> host controller raises "response decoding" errors. To avoid this scenar=
io,
>>> add PCIe link up check in config read and write callback functions befo=
re
>>> accessing endpoint config registers.
>>>
>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>> ---
>>> V4: No change
>>>
>>> V3: Update the commit log with explanation for the need of this patch
>>>
>>> V2: Change tegra_pcie_link_status() to tegra_pcie_link_up()
>>>
>>>  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++++++++++++++++++++
>>>  1 file changed, 38 insertions(+)
>> This still doesn't look right to me conceptually. If somebody wants to
>> access the PCI devices after the kernel has powered them off, why can't
>> we just power the devices back on so that we allow userspace to properly
>> access the devices?
> 1. WiFi devices provides power-off feature for power saving in mobiles.
> When WiFi is turned off we shouldn't power on the HW back without user
> turning it back on.
> 2. When ever user process tries to access config space, it'll end up
> in these functions. We cannot have is_powered_on check in config read/wri=
te
> callbacks.
> 3. WiFi power on/off is device specific feature, we shouldn't handle it
> in PCI subsystem or host controller driver.
>
>> Or if that's not what we want, shouldn't we add something to the core
>> PCI infrastructure to let us deal with this? It seems like this is some
>> general problem that would apply to every PCI device and host bridge
>> driver. Having each driver implement this logic separately doesn't seem
>> like a good idea to me.
>>
>> Thierry
> This should be handled by hotplug feature, whenever endpoint is powered-o=
ff/
> removed from the slot, hot unplug event should take care of it. Unfortuna=
tely
> Tegra PCIe doesn't support hotplug feature.
>
> Manikanta

Hi Bjorn,

I thought about your comment in https://patchwork.ozlabs.org/patch/1084204/=
 again.
What if I add link up check in tegra_pcie_isr() and make "response decoding=
 error"
as debug print? EP Config access will happen when link is down, but "Respon=
se
decoding error" print comes only if debug log is enabled. This way we can a=
void
race issue in config accessors and we get prints when debug logs are enable=
d.

Thierry,
Please share your inputs as well.

Manikanta
=A0

>>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controlle=
r/pci-tegra.c
>>> index d20c88a79e00..33f4dfab9e35 100644
>>> --- a/drivers/pci/controller/pci-tegra.c
>>> +++ b/drivers/pci/controller/pci-tegra.c
>>> @@ -428,6 +428,14 @@ static inline u32 pads_readl(struct tegra_pcie *pc=
ie, unsigned long offset)
>>>  	return readl(pcie->pads + offset);
>>>  }
>>> =20
>>> +static bool tegra_pcie_link_up(struct tegra_pcie_port *port)
>>> +{
>>> +	u32 value;
>>> +
>>> +	value =3D readl(port->base + RP_LINK_CONTROL_STATUS);
>>> +	return !!(value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE);
>>> +}
>>> +
>>>  /*
>>>   * The configuration space mapping on Tegra is somewhat similar to the=
 ECAM
>>>   * defined by PCIe. However it deviates a bit in how the 4 bits for ex=
tended
>>> @@ -493,20 +501,50 @@ static void __iomem *tegra_pcie_map_bus(struct pc=
i_bus *bus,
>>>  static int tegra_pcie_config_read(struct pci_bus *bus, unsigned int de=
vfn,
>>>  				  int where, int size, u32 *value)
>>>  {
>>> +	struct tegra_pcie *pcie =3D bus->sysdata;
>>> +	struct pci_dev *bridge;
>>> +	struct tegra_pcie_port *port;
>>> +
>>>  	if (bus->number =3D=3D 0)
>>>  		return pci_generic_config_read32(bus, devfn, where, size,
>>>  						 value);
>>> =20
>>> +	bridge =3D pcie_find_root_port(bus->self);
>>> +
>>> +	list_for_each_entry(port, &pcie->ports, list)
>>> +		if (port->index + 1 =3D=3D PCI_SLOT(bridge->devfn))
>>> +			break;
>>> +
>>> +	/* If there is no link, then there is no device */
>>> +	if (!tegra_pcie_link_up(port)) {
>>> +		*value =3D 0xffffffff;
>>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>>> +	}
>>> +
>>>  	return pci_generic_config_read(bus, devfn, where, size, value);
>>>  }
>>> =20
>>>  static int tegra_pcie_config_write(struct pci_bus *bus, unsigned int d=
evfn,
>>>  				   int where, int size, u32 value)
>>>  {
>>> +	struct tegra_pcie *pcie =3D bus->sysdata;
>>> +	struct tegra_pcie_port *port;
>>> +	struct pci_dev *bridge;
>>> +
>>>  	if (bus->number =3D=3D 0)
>>>  		return pci_generic_config_write32(bus, devfn, where, size,
>>>  						  value);
>>> =20
>>> +	bridge =3D pcie_find_root_port(bus->self);
>>> +
>>> +	list_for_each_entry(port, &pcie->ports, list)
>>> +		if (port->index + 1 =3D=3D PCI_SLOT(bridge->devfn))
>>> +			break;
>>> +
>>> +	/* If there is no link, then there is no device */
>>> +	if (!tegra_pcie_link_up(port))
>>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>>> +
>>>  	return pci_generic_config_write(bus, devfn, where, size, value);
>>>  }
>>> =20
>>> --=20
>>> 2.17.1
>>>

