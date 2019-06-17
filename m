Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8F4813A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 13:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfFQLrw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 07:47:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51392 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfFQLrv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 07:47:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so8922411wma.1;
        Mon, 17 Jun 2019 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rhqeQm9cA1btIDjmI6i+j+5Tu5gEZya2YOKXq8mQHFY=;
        b=mXdccFskkingTRqpHj/99SUR64n00M2g2Rk96VILrkHwMrMLD+K2EIeo7v7BMqyri9
         fDgriFOiQRNpchbRYPp9ZLlUGTOc0gIbeTd02KFox7XbLWT9oDrkAkFesvucFxKk7HLQ
         r59/B5eKNjtSmvtSD6wT4AocZDwa1JIYtacByUTx1x4jA0W0KDZVmC7UZpxZn/JZFFC5
         bry06KBwSqb6BpKcYNjhhiQJT07ghx5BihFb0HYbbfWppfmBhTzJN55NhZXx9WQBbYZF
         fwswMDZ7urLcmxXLpkIuj1cnPYHArLvExsLq4tYCLf6prlYSoTS8WmHRF6zh4SvYiICk
         f6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhqeQm9cA1btIDjmI6i+j+5Tu5gEZya2YOKXq8mQHFY=;
        b=Itfq9GnPC9WOs3h/xbjMhV9NjWO1OYIQKi+1mrOu+k65uaC30CxLclLh/L2jaMs7tF
         XZLr6114T/HmhIAemuKXPCAmgwTwLPN434fKvE7T5AtG+0jbZMVv1wf4kXiLe2ZaUANu
         ByPdm6y+uIiB62wiX6NFY+JPDikj4h3MnrhhmpktkmScbP6mwPQ5NiXq9tVkc8rEV2NT
         tmoiEzJpC1UG/CwZYYHBJ6lduxVMev6gm7GVCQtVJ69XzPQgBbCD02kKc/KywFWKaEJY
         bsk5W881bvkeRBAmVOAepUIF586zEFn1yUOKCPxC0x7fRzNy1qo4I+NyvnogRN/mAMEO
         jy2A==
X-Gm-Message-State: APjAAAX2abmHFJL4MAivVkDtAofiNkrKvvDqQUposKcYkH7NtNUWRLme
        4FzOrmfpoWd8EG2MLnxYOSzouqU8
X-Google-Smtp-Source: APXvYqw4s2C1ybksy0bysWnsCwgSFN8G5ohmfLu9RKpQb9BwUPPTRCZj1GcOcy5aOAA6+JxH1BqaPA==
X-Received: by 2002:a7b:c001:: with SMTP id c1mr18771476wmb.49.1560772067264;
        Mon, 17 Jun 2019 04:47:47 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id r12sm16764397wrt.95.2019.06.17.04.47.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 04:47:46 -0700 (PDT)
Date:   Mon, 17 Jun 2019 13:47:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V4 22/28] PCI: tegra: Access endpoint config only if PCIe
 link is up
Message-ID: <20190617114745.GL508@ulmo>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-23-mmaddireddy@nvidia.com>
 <20190604131436.GS16519@ulmo>
 <09bcc121-eaca-3866-d0ef-7806503e883f@nvidia.com>
 <ca34eb24-8696-576f-26bc-8d6141f81a41@nvidia.com>
 <20190613143946.GA30445@e121166-lin.cambridge.arm.com>
 <20190613154250.GA32713@ulmo>
 <a523a19c-fdfa-01f7-6f6d-2ca367a10a50@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kkRamCq5m5VQq0L6"
Content-Disposition: inline
In-Reply-To: <a523a19c-fdfa-01f7-6f6d-2ca367a10a50@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--kkRamCq5m5VQq0L6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 03:31:38PM +0530, Manikanta Maddireddy wrote:
>=20
>=20
> On 13-Jun-19 9:12 PM, Thierry Reding wrote:
> > On Thu, Jun 13, 2019 at 03:39:46PM +0100, Lorenzo Pieralisi wrote:
> >> On Mon, Jun 10, 2019 at 10:08:16AM +0530, Manikanta Maddireddy wrote:
> >>>
> >>> On 04-Jun-19 7:40 PM, Manikanta Maddireddy wrote:
> >>>> On 04-Jun-19 6:44 PM, Thierry Reding wrote:
> >>>>> On Thu, May 16, 2019 at 11:23:01AM +0530, Manikanta Maddireddy wrot=
e:
> >>>>>> Few endpoints like Wi-Fi supports power on/off and to leverage that
> >>>>>> root port must support hot-plug and hot-unplug. Tegra PCIe doesn't
> >>>>>> support hot-plug and hot-unplug, however it supports endpoint power
> >>>>>> on/off feature as follows,
> >>>>>>  - Power off sequence:
> >>>>>>    - Transition of PCIe link to L2
> >>>>>>    - Power off endpoint
> >>>>>>    - Leave root port in power up state with the link in L2
> >>>>>>  - Power on sequence:
> >>>>>>    - Power on endpoint
> >>>>>>    - Apply hot reset to get PCIe link up
> >>>>>>
> >>>>>> PCIe client driver stops accessing PCIe endpoint config and BAR re=
gisters
> >>>>>> after endpoint is powered off. However, software applications like=
 x11
> >>>>>> server or lspci can access endpoint config registers in which case
> >>>>>> host controller raises "response decoding" errors. To avoid this s=
cenario,
> >>>>>> add PCIe link up check in config read and write callback functions=
 before
> >>>>>> accessing endpoint config registers.
> >>>>>>
> >>>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >>>>>> ---
> >>>>>> V4: No change
> >>>>>>
> >>>>>> V3: Update the commit log with explanation for the need of this pa=
tch
> >>>>>>
> >>>>>> V2: Change tegra_pcie_link_status() to tegra_pcie_link_up()
> >>>>>>
> >>>>>>  drivers/pci/controller/pci-tegra.c | 38 +++++++++++++++++++++++++=
+++++
> >>>>>>  1 file changed, 38 insertions(+)
> >>>>> This still doesn't look right to me conceptually. If somebody wants=
 to
> >>>>> access the PCI devices after the kernel has powered them off, why c=
an't
> >>>>> we just power the devices back on so that we allow userspace to pro=
perly
> >>>>> access the devices?
> >>>> 1. WiFi devices provides power-off feature for power saving in mobil=
es.
> >>>> When WiFi is turned off we shouldn't power on the HW back without us=
er
> >>>> turning it back on.
> >>>> 2. When ever user process tries to access config space, it'll end up
> >>>> in these functions. We cannot have is_powered_on check in config rea=
d/write
> >>>> callbacks.
> >>>> 3. WiFi power on/off is device specific feature, we shouldn't handle=
 it
> >>>> in PCI subsystem or host controller driver.
> >>>>
> >>>>> Or if that's not what we want, shouldn't we add something to the co=
re
> >>>>> PCI infrastructure to let us deal with this? It seems like this is =
some
> >>>>> general problem that would apply to every PCI device and host bridge
> >>>>> driver. Having each driver implement this logic separately doesn't =
seem
> >>>>> like a good idea to me.
> >>>>>
> >>>>> Thierry
> >>>> This should be handled by hotplug feature, whenever endpoint is powe=
red-off/
> >>>> removed from the slot, hot unplug event should take care of it. Unfo=
rtunately
> >>>> Tegra PCIe doesn't support hotplug feature.
> >>>>
> >>>> Manikanta
> >>> Hi Bjorn,
> >>>
> >>> I thought about your comment in
> >>> https://patchwork.ozlabs.org/patch/1084204/ again.  What if I add link
> >>> up check in tegra_pcie_isr() and make "response decoding error" as
> >>> debug print? EP Config access will happen when link is down, but
> >>> "Response decoding error" print comes only if debug log is enabled.
> >>> This way we can avoid race issue in config accessors and we get prints
> >>> when debug logs are enabled.
> >> I still do not see what you are actually solving. This patch should
> >> be dropped.
> > The problem that Manikanta is trying to solve here occurs in this
> > situation (Manikanta, correct me if I've got this wrong): on some
> > setups, a WiFi module connected over PCI will toggle a power GPIO as
> > part of runtime suspend. This effectively causes the module to disappear
> > from the PCI bus (i.e. it can no longer be accessed until the power GPIO
> > is toggled again).
>=20
> GPIO is toggled as part of WiFi on/off, can be triggered from network man=
ager UI.
>=20
> >
> > This is fine from a kernel point of view because the kernel keeps track
> > of what devices are suspended. However, userspace will occasionally try
> > to read the configuration space access of all devices, and since it
> > doesn't have any knowledge about the suspend state of these devices, it
> > doesn't know which ones to leave alone. I think this happens when the
> > X.Org server is running.
>=20
> This is fine from a kernel point of view because PCI client driver
> doesn't initiate any PCIe transaction until network interface
> is up during WiFi on.
>=20
> >
> > One thing that Manikanta and I had discussed was that perhaps the device
> > should be hot-unplugged when it goes into this low-power state. However,
> > we don't support hotplug on Tegra210 where this is needed, so we'd need
> > some sort of software-induced hot-unplug. However, this low power state
> > is entered when the WiFi interface is taken down (i.e. ip link set dev
> > <interface> down). If we were to remove the PCI device in that case, it
> > means that the interface goes away completely, which is completely
> > unexpected from a user's perspective. After all, taking a link down and
> > up may be something that scripts are doing all the time. They'd fall
> > over if after taking the interface down, the interface completely
> > disappears.
> >
> > It's also not entirely clear to me how we get the device back onto the
> > bus again after it is in low power. If we hot-unplug the device, then
> > the driver will be unbound. Presumably the driver is what's controlling
> > the power GPIO, so there won't be any entity that can be used to bring
> > the chip back to life. Unless we deal with that power GPIO elsewhere
> > (rfkill switch perhaps?).
>=20
> Correct, rfkill switch should handle the GPIO.
> Sequence will be,
>  - WiFi ON
>    - rfkill switch enables the WiFi GPIO
>    - Tegra PCIe receives hot plug event
>    - Tegra PCIe hot plug driver rescans PCI bus and enumerates the device
>    - PCI client driver is probed, which will create network interface
>  - WiFi OFF
>    - rfkill switch disables the WiFi GPIO
>    - Tegra PCIe receives hot unplug event
>    - Tegra PCIe hot plug driver removes PCI devices under the bus
>    - PCI client driver remove is executed, which will remove network inte=
rface
>=20
> We don't need current patch in this case because PCI device is not present
> in the PCI hierarchy, so there cannot be EP config access with link down.
> However Tegra doesn't support hot plug and unplug events. I am not sure
> if we have any software based hot plug event trigger.
>=20
> I will drop current patch and pursue if above sequence can be
> implemented for Tegra.

I just recalled that we have these messages in the kernel log:

	# dmesg | grep tegra-pcie
	[    1.055761] tegra-pcie 1003000.pcie: 4x1, 1x1 configuration
	[    2.745764] tegra-pcie 1003000.pcie: 4x1, 1x1 configuration
	[    2.753073] tegra-pcie 1003000.pcie: probing port 0, using 4 lanes
	[    2.761334] tegra-pcie 1003000.pcie: Slot present pin change, signature=
: 00000008
	[    3.177607] tegra-pcie 1003000.pcie: link 0 down, retrying
	[    3.585605] tegra-pcie 1003000.pcie: link 0 down, retrying
	[    3.993606] tegra-pcie 1003000.pcie: link 0 down, retrying
	[    4.001214] tegra-pcie 1003000.pcie: link 0 down, ignoring
	[    4.006733] tegra-pcie 1003000.pcie: probing port 1, using 1 lanes
	[    4.015042] tegra-pcie 1003000.pcie: Slot present pin change, signature=
: 00000000
	[    4.031177] tegra-pcie 1003000.pcie: PCI host bridge to bus 0000:00

These "slot present pin change" message do look a lot like hotplug
related messages. Could we perhaps use those to our advantage for this
case? Do you see these when you run on the platform where WiFi is
enabled/disabled using rfkill?

Given that rfkill is completely decoupled from PCI, I don't see how we
would trigger any software-based hotplug mechanism. Perhaps one thing
that we could do is the equivalent of this:

	# echo 1 > /sys/bus/pci/rescan

=66rom some script that's perhaps tied to the rfkill somehow. I'm not sure
if that's possible, or generic enough.

Thierry

> > Perhaps one other way to deal with this would be to track the suspend
> > state of devices and then have the code that implements the PCI access
> > from userspace refuse accesses to devices that are asleep. I suppose
> > this is somewhat of an odd use-case because traditionally I guess PCI
> > devices never power down to a state where their configuration space can
> > no longer be accessed. At least that's what would explain why this has
> > never been an issue before. Or perhaps it has?
> >
> > The last resort would be to just never put the WiFi chip into that low
> > power mode, though I'm not exactly sure what that means for the power
> > consumption on the affected systems.
> >
> > Manikanta, can you fill in some of the blanks above?
> >
> > Thierry
> >>> Thierry,
> >>> Please share your inputs as well.
> >>>
> >>> Manikanta
> >>> =C2=A0
> >>>
> >>>>>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/cont=
roller/pci-tegra.c
> >>>>>> index d20c88a79e00..33f4dfab9e35 100644
> >>>>>> --- a/drivers/pci/controller/pci-tegra.c
> >>>>>> +++ b/drivers/pci/controller/pci-tegra.c
> >>>>>> @@ -428,6 +428,14 @@ static inline u32 pads_readl(struct tegra_pci=
e *pcie, unsigned long offset)
> >>>>>>  	return readl(pcie->pads + offset);
> >>>>>>  }
> >>>>>> =20
> >>>>>> +static bool tegra_pcie_link_up(struct tegra_pcie_port *port)
> >>>>>> +{
> >>>>>> +	u32 value;
> >>>>>> +
> >>>>>> +	value =3D readl(port->base + RP_LINK_CONTROL_STATUS);
> >>>>>> +	return !!(value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE);
> >>>>>> +}
> >>>>>> +
> >>>>>>  /*
> >>>>>>   * The configuration space mapping on Tegra is somewhat similar t=
o the ECAM
> >>>>>>   * defined by PCIe. However it deviates a bit in how the 4 bits f=
or extended
> >>>>>> @@ -493,20 +501,50 @@ static void __iomem *tegra_pcie_map_bus(stru=
ct pci_bus *bus,
> >>>>>>  static int tegra_pcie_config_read(struct pci_bus *bus, unsigned i=
nt devfn,
> >>>>>>  				  int where, int size, u32 *value)
> >>>>>>  {
> >>>>>> +	struct tegra_pcie *pcie =3D bus->sysdata;
> >>>>>> +	struct pci_dev *bridge;
> >>>>>> +	struct tegra_pcie_port *port;
> >>>>>> +
> >>>>>>  	if (bus->number =3D=3D 0)
> >>>>>>  		return pci_generic_config_read32(bus, devfn, where, size,
> >>>>>>  						 value);
> >>>>>> =20
> >>>>>> +	bridge =3D pcie_find_root_port(bus->self);
> >>>>>> +
> >>>>>> +	list_for_each_entry(port, &pcie->ports, list)
> >>>>>> +		if (port->index + 1 =3D=3D PCI_SLOT(bridge->devfn))
> >>>>>> +			break;
> >>>>>> +
> >>>>>> +	/* If there is no link, then there is no device */
> >>>>>> +	if (!tegra_pcie_link_up(port)) {
> >>>>>> +		*value =3D 0xffffffff;
> >>>>>> +		return PCIBIOS_DEVICE_NOT_FOUND;
> >>>>>> +	}
> >>>>>> +
> >>>>>>  	return pci_generic_config_read(bus, devfn, where, size, value);
> >>>>>>  }
> >>>>>> =20
> >>>>>>  static int tegra_pcie_config_write(struct pci_bus *bus, unsigned =
int devfn,
> >>>>>>  				   int where, int size, u32 value)
> >>>>>>  {
> >>>>>> +	struct tegra_pcie *pcie =3D bus->sysdata;
> >>>>>> +	struct tegra_pcie_port *port;
> >>>>>> +	struct pci_dev *bridge;
> >>>>>> +
> >>>>>>  	if (bus->number =3D=3D 0)
> >>>>>>  		return pci_generic_config_write32(bus, devfn, where, size,
> >>>>>>  						  value);
> >>>>>> =20
> >>>>>> +	bridge =3D pcie_find_root_port(bus->self);
> >>>>>> +
> >>>>>> +	list_for_each_entry(port, &pcie->ports, list)
> >>>>>> +		if (port->index + 1 =3D=3D PCI_SLOT(bridge->devfn))
> >>>>>> +			break;
> >>>>>> +
> >>>>>> +	/* If there is no link, then there is no device */
> >>>>>> +	if (!tegra_pcie_link_up(port))
> >>>>>> +		return PCIBIOS_DEVICE_NOT_FOUND;
> >>>>>> +
> >>>>>>  	return pci_generic_config_write(bus, devfn, where, size, value);
> >>>>>>  }
> >>>>>> =20
> >>>>>> --=20
> >>>>>> 2.17.1
> >>>>>>
>=20

--kkRamCq5m5VQq0L6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0Hfd4ACgkQ3SOs138+
s6GGmBAAp44F/d6EEI8ITnr2/VuBHl158WCsmku4me5F/r5NbdGmy1+bvh1BgUVB
fQrFwRaGH0lXrj3zKwqfsHIz1HElpfx80R6UTmUlHZ5Z75ySjVuRldMEuNoHJZH8
8tI0EkSutEVB6TMblOOD0mzNsX6tADq60fUPBI/CkX19Y1rl1GDA1zHWiz1PXIie
4PeqweugJsHkXSV0VGODagVvIGDrZcYJrJVgtBwzPWeMVIFnAXhpti2bdaXx4tyy
E2GLd+WiJYf0ui4/lx6qapbWEUvjwskCUobyqxsobHFIirxb6Z0iJiMqHE8A1m6W
kpl47/oLkfDeakDZd8odvqjTl29n0txqyeRWYh7X7ZRPQMEwxAH4ygc9KectlEv2
5r0NB8BZzPQrjIBYMEglpA126Ny6s19DyJmuSqVLtq3bd+KDHxZOoF7bsxUP44G3
9Eq72Z8hqu9PTKEDr1BNwOjNckaTwpUGoZdwUMTcYkXgIrtW5E3z3ximdiE4l2/7
gaZ2zSjJ/Q+be0xpnbecp01x6hji7Kb8SlBMVMeKcDtTZcCSonXMfY2SPusUy9JR
JAMjuV1Ke3KEzcnOnuUBn5zCt9JsS1SLzXHUH48kSsHJSJpaLKlPiN8w0UoT2RQt
8vqtDbn7K1oFuojrS7+UAzXMaFJcGSQQZHrZIxaSmlFFGnaCqso=
=TZD1
-----END PGP SIGNATURE-----

--kkRamCq5m5VQq0L6--
