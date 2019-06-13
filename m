Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F10543D95
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbfFMPm5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:42:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37473 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfFMPm4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 11:42:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so21300822wrr.4;
        Thu, 13 Jun 2019 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FUFVfwBXI3N5Wz0CJsOE4Pfaq0/8R/vg4ijb39bmJA0=;
        b=HBTytAjS2nc0g4t40ucqEhhtshVzSXbrQhrHAoOH6T1IkzmnwTBf5MDyZCpDVUdVee
         rO1Gzu+ymaF0f58jSPguZz1LX3mwTfbeE0dbNzoWqoMeFbU/PJLI5ydEE58CwGwb8kd3
         BeN/vGEnlE3d4mBYbqe/nK0b8nPSP+TJ1AwMjnZHgdzoka8lASRixDpUIy8Cw5ACUgM3
         4VSj3GxCCkOP7SNTY+gY6LkoYFN0JlXAvjfLBxSxsWDmaCj7YsoXYGoKcxuefpcbEX/e
         mrXJAFZzWgbgkFqkCqTkeNU4FU7p5T+cZ8oPh70SDY+cvYP60coo+MZxcjXwX4STN90L
         sMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FUFVfwBXI3N5Wz0CJsOE4Pfaq0/8R/vg4ijb39bmJA0=;
        b=saXjRQ/fv1nzcB9ZY1Aar5A0qKpSvVu6XUUim0L4fq1ub2IcBS+xNo92bTpEkihr39
         vhKwfkl6HGVrZ8DNtul+1zWk3ey4WQ98dpLlXfC4c70gGTzX9xTORasepWhsllgQ4+Dc
         cbSA1mS0/TqSv9OxXa989FW74fp31UAIg5lHK8TvXtNjWA39WJ2CftFiKveTmWWm2A43
         irEIU/yVBK0svHsjY4Oxa+fdGnrtq6NtQZN+Dlxi6EdnDDRiq3opZAY300o5Ta250l0S
         wCSwRRhoU7hYLQGxtaMz/80+8NlmoBqMBli6zMJPw1n7HH+n4JJsBYv8Ilhu3+O+4H/I
         9tTA==
X-Gm-Message-State: APjAAAVMXZ2jaojQVUqT0AzmSDtIhm5YK9y7VutIC6i+H0qSTfa+V3ns
        lsRjBh2A9/NiGMbLkqUCqS4=
X-Google-Smtp-Source: APXvYqzuKixJrz6a310KH1kBwCs8OlhNCKmsO3vfrDSjYkDeL3bOXuio18YBPQL06kbxZ3AIEFX0Jw==
X-Received: by 2002:adf:8044:: with SMTP id 62mr12842408wrk.20.1560440572688;
        Thu, 13 Jun 2019 08:42:52 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id h90sm59310wrh.15.2019.06.13.08.42.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 08:42:52 -0700 (PDT)
Date:   Thu, 13 Jun 2019 17:42:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V4 22/28] PCI: tegra: Access endpoint config only if PCIe
 link is up
Message-ID: <20190613154250.GA32713@ulmo>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-23-mmaddireddy@nvidia.com>
 <20190604131436.GS16519@ulmo>
 <09bcc121-eaca-3866-d0ef-7806503e883f@nvidia.com>
 <ca34eb24-8696-576f-26bc-8d6141f81a41@nvidia.com>
 <20190613143946.GA30445@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20190613143946.GA30445@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 03:39:46PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Jun 10, 2019 at 10:08:16AM +0530, Manikanta Maddireddy wrote:
> >=20
> >=20
> > On 04-Jun-19 7:40 PM, Manikanta Maddireddy wrote:
> > >
> > > On 04-Jun-19 6:44 PM, Thierry Reding wrote:
> > >> On Thu, May 16, 2019 at 11:23:01AM +0530, Manikanta Maddireddy wrote:
> > >>> Few endpoints like Wi-Fi supports power on/off and to leverage that
> > >>> root port must support hot-plug and hot-unplug. Tegra PCIe doesn't
> > >>> support hot-plug and hot-unplug, however it supports endpoint power
> > >>> on/off feature as follows,
> > >>>  - Power off sequence:
> > >>>    - Transition of PCIe link to L2
> > >>>    - Power off endpoint
> > >>>    - Leave root port in power up state with the link in L2
> > >>>  - Power on sequence:
> > >>>    - Power on endpoint
> > >>>    - Apply hot reset to get PCIe link up
> > >>>
> > >>> PCIe client driver stops accessing PCIe endpoint config and BAR reg=
isters
> > >>> after endpoint is powered off. However, software applications like =
x11
> > >>> server or lspci can access endpoint config registers in which case
> > >>> host controller raises "response decoding" errors. To avoid this sc=
enario,
> > >>> add PCIe link up check in config read and write callback functions =
before
> > >>> accessing endpoint config registers.
> > >>>
> > >>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > >>> ---
> > >>> V4: No change
> > >>>
> > >>> V3: Update the commit log with explanation for the need of this pat=
ch
> > >>>
> > >>> V2: Change tegra_pcie_link_status() to tegra_pcie_link_up()
> > >>>
> > >>>  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++++++++++++++++=
++++
> > >>>  1 file changed, 38 insertions(+)
> > >> This still doesn't look right to me conceptually. If somebody wants =
to
> > >> access the PCI devices after the kernel has powered them off, why ca=
n't
> > >> we just power the devices back on so that we allow userspace to prop=
erly
> > >> access the devices?
> > > 1. WiFi devices provides power-off feature for power saving in mobile=
s.
> > > When WiFi is turned off we shouldn't power on the HW back without user
> > > turning it back on.
> > > 2. When ever user process tries to access config space, it'll end up
> > > in these functions. We cannot have is_powered_on check in config read=
/write
> > > callbacks.
> > > 3. WiFi power on/off is device specific feature, we shouldn't handle =
it
> > > in PCI subsystem or host controller driver.
> > >
> > >> Or if that's not what we want, shouldn't we add something to the core
> > >> PCI infrastructure to let us deal with this? It seems like this is s=
ome
> > >> general problem that would apply to every PCI device and host bridge
> > >> driver. Having each driver implement this logic separately doesn't s=
eem
> > >> like a good idea to me.
> > >>
> > >> Thierry
> > > This should be handled by hotplug feature, whenever endpoint is power=
ed-off/
> > > removed from the slot, hot unplug event should take care of it. Unfor=
tunately
> > > Tegra PCIe doesn't support hotplug feature.
> > >
> > > Manikanta
> >=20
> > Hi Bjorn,
> >=20
> > I thought about your comment in
> > https://patchwork.ozlabs.org/patch/1084204/ again.  What if I add link
> > up check in tegra_pcie_isr() and make "response decoding error" as
> > debug print? EP Config access will happen when link is down, but
> > "Response decoding error" print comes only if debug log is enabled.
> > This way we can avoid race issue in config accessors and we get prints
> > when debug logs are enabled.
>=20
> I still do not see what you are actually solving. This patch should
> be dropped.

The problem that Manikanta is trying to solve here occurs in this
situation (Manikanta, correct me if I've got this wrong): on some
setups, a WiFi module connected over PCI will toggle a power GPIO as
part of runtime suspend. This effectively causes the module to disappear
=66rom the PCI bus (i.e. it can no longer be accessed until the power GPIO
is toggled again).

This is fine from a kernel point of view because the kernel keeps track
of what devices are suspended. However, userspace will occasionally try
to read the configuration space access of all devices, and since it
doesn't have any knowledge about the suspend state of these devices, it
doesn't know which ones to leave alone. I think this happens when the
X.Org server is running.

One thing that Manikanta and I had discussed was that perhaps the device
should be hot-unplugged when it goes into this low-power state. However,
we don't support hotplug on Tegra210 where this is needed, so we'd need
some sort of software-induced hot-unplug. However, this low power state
is entered when the WiFi interface is taken down (i.e. ip link set dev
<interface> down). If we were to remove the PCI device in that case, it
means that the interface goes away completely, which is completely
unexpected from a user's perspective. After all, taking a link down and
up may be something that scripts are doing all the time. They'd fall
over if after taking the interface down, the interface completely
disappears.

It's also not entirely clear to me how we get the device back onto the
bus again after it is in low power. If we hot-unplug the device, then
the driver will be unbound. Presumably the driver is what's controlling
the power GPIO, so there won't be any entity that can be used to bring
the chip back to life. Unless we deal with that power GPIO elsewhere
(rfkill switch perhaps?).

Perhaps one other way to deal with this would be to track the suspend
state of devices and then have the code that implements the PCI access
=66rom userspace refuse accesses to devices that are asleep. I suppose
this is somewhat of an odd use-case because traditionally I guess PCI
devices never power down to a state where their configuration space can
no longer be accessed. At least that's what would explain why this has
never been an issue before. Or perhaps it has?

The last resort would be to just never put the WiFi chip into that low
power mode, though I'm not exactly sure what that means for the power
consumption on the affected systems.

Manikanta, can you fill in some of the blanks above?

Thierry

> > Thierry,
> > Please share your inputs as well.
> >=20
> > Manikanta
> > =C2=A0
> >=20
> > >>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/contr=
oller/pci-tegra.c
> > >>> index d20c88a79e00..33f4dfab9e35 100644
> > >>> --- a/drivers/pci/controller/pci-tegra.c
> > >>> +++ b/drivers/pci/controller/pci-tegra.c
> > >>> @@ -428,6 +428,14 @@ static inline u32 pads_readl(struct tegra_pcie=
 *pcie, unsigned long offset)
> > >>>  	return readl(pcie->pads + offset);
> > >>>  }
> > >>> =20
> > >>> +static bool tegra_pcie_link_up(struct tegra_pcie_port *port)
> > >>> +{
> > >>> +	u32 value;
> > >>> +
> > >>> +	value =3D readl(port->base + RP_LINK_CONTROL_STATUS);
> > >>> +	return !!(value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE);
> > >>> +}
> > >>> +
> > >>>  /*
> > >>>   * The configuration space mapping on Tegra is somewhat similar to=
 the ECAM
> > >>>   * defined by PCIe. However it deviates a bit in how the 4 bits fo=
r extended
> > >>> @@ -493,20 +501,50 @@ static void __iomem *tegra_pcie_map_bus(struc=
t pci_bus *bus,
> > >>>  static int tegra_pcie_config_read(struct pci_bus *bus, unsigned in=
t devfn,
> > >>>  				  int where, int size, u32 *value)
> > >>>  {
> > >>> +	struct tegra_pcie *pcie =3D bus->sysdata;
> > >>> +	struct pci_dev *bridge;
> > >>> +	struct tegra_pcie_port *port;
> > >>> +
> > >>>  	if (bus->number =3D=3D 0)
> > >>>  		return pci_generic_config_read32(bus, devfn, where, size,
> > >>>  						 value);
> > >>> =20
> > >>> +	bridge =3D pcie_find_root_port(bus->self);
> > >>> +
> > >>> +	list_for_each_entry(port, &pcie->ports, list)
> > >>> +		if (port->index + 1 =3D=3D PCI_SLOT(bridge->devfn))
> > >>> +			break;
> > >>> +
> > >>> +	/* If there is no link, then there is no device */
> > >>> +	if (!tegra_pcie_link_up(port)) {
> > >>> +		*value =3D 0xffffffff;
> > >>> +		return PCIBIOS_DEVICE_NOT_FOUND;
> > >>> +	}
> > >>> +
> > >>>  	return pci_generic_config_read(bus, devfn, where, size, value);
> > >>>  }
> > >>> =20
> > >>>  static int tegra_pcie_config_write(struct pci_bus *bus, unsigned i=
nt devfn,
> > >>>  				   int where, int size, u32 value)
> > >>>  {
> > >>> +	struct tegra_pcie *pcie =3D bus->sysdata;
> > >>> +	struct tegra_pcie_port *port;
> > >>> +	struct pci_dev *bridge;
> > >>> +
> > >>>  	if (bus->number =3D=3D 0)
> > >>>  		return pci_generic_config_write32(bus, devfn, where, size,
> > >>>  						  value);
> > >>> =20
> > >>> +	bridge =3D pcie_find_root_port(bus->self);
> > >>> +
> > >>> +	list_for_each_entry(port, &pcie->ports, list)
> > >>> +		if (port->index + 1 =3D=3D PCI_SLOT(bridge->devfn))
> > >>> +			break;
> > >>> +
> > >>> +	/* If there is no link, then there is no device */
> > >>> +	if (!tegra_pcie_link_up(port))
> > >>> +		return PCIBIOS_DEVICE_NOT_FOUND;
> > >>> +
> > >>>  	return pci_generic_config_write(bus, devfn, where, size, value);
> > >>>  }
> > >>> =20
> > >>> --=20
> > >>> 2.17.1
> > >>>
> >=20

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0CbvcACgkQ3SOs138+
s6ExVBAAk+6yFjYB7w0KW66h8QsLTBo1BrdF83BlyPEMbSCnUX7mzuBsAY8eazoy
zE0l3/W6eDqEQmQXZsTTtzdCtASHpXh+5ky0g/gwo0Rjnc6oXpRvMaYcGsAgtU5y
pVVwWWPYtC8AYnptNlq02f2AP9cLNmvf2tl7GIabW2S+0toO+rFmXjG+Hu1RV6kP
1tUtt27CRIZGT4JOjkN9tRMjqo6hQdNcFV2/jBuSf26H0Fmz7NfiPcsv0siXBeuy
4Fze+vltRj3zZMN3UtOH5w8oz8SiHSniImODA+5/YlIQLmT6YkGB6bM24h+EFQ+I
0XUbpqAY4ZAlXrA595mU1Jmz/0iTwoWpPgb8QrEQ8qmT17YwMjLW9yyq0sr+/GtH
hs039AZWEmonizXOu7uVpZxReN9o7qC6wJLOSnchrMm2dGGivY+bwCXy7guGrfSV
aMtmOZz7C3GS8bnQtrlFil+JVvaIm11QSR38IdP2yIb8ph/jev9uG+7XcUIr6kUh
D2IiF93OZC0HdDiAblGZ64XrvKL8g5GHKKjnKZ6wdQUEcc0llqQM/oFviMfMi4P7
EtJ4jmjst7yLb/tw9Cx7l39zI0Ktx5Vm0NbNYrsaTe1swrh5RH/twp7EEvcvzJC0
p71EACgN+cfpJFtF6snoKY2MwVPyyoI64dMMjLSejk64OaaBSkE=
=eUoe
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
