Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCD5FAF8E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 12:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfKMLUs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 06:20:48 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6646 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbfKMLUs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 06:20:48 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcbe6d60000>; Wed, 13 Nov 2019 03:19:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 Nov 2019 03:20:46 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 Nov 2019 03:20:46 -0800
Received: from localhost (10.124.1.5) by HQMAIL107.nvidia.com (172.20.187.13)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov 2019 11:20:45
 +0000
Date:   Wed, 13 Nov 2019 12:20:43 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191113112043.GA329424@ulmo>
References: <5bb62272-6a9f-f4e3-540a-360ff5a8a0f7@nvidia.com>
 <20191112185844.GA191944@google.com>
MIME-Version: 1.0
In-Reply-To: <20191112185844.GA191944@google.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573643991; bh=K4pB/ZH7f4AoezLjo5KiXqXgLXXi2COkHxZeaGMvmUg=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=IazSrojt7+FFR7mA9mtLZB9AAmSDvsi6z6ZfR364B0fh+DVbWF1PSYQcG2cBUYtSs
         25HodzhD61J6uP8nOVJa82YYvOUERv9tWSNaMHEBnlaawgIxCAgQwdCprt8vzl7cs1
         wcEf9+CrxSy9F2cMZ4B3qs3WKt3Sbnv6nnHzfaFOjH3OWSWHov5OovGoGduQPv+8TI
         NU7z8l/8EcsnlJp23KiQECPdnRsP86qmYcQkaoupEDbLsYQPE2DhPGMbk8outtMdVS
         HBJI6hobp3+mipIZPCcrWkHYwbU6vy4p1lcOA+egbZ4zXliYLNj+SM4SqJg/zzDrAQ
         PvLhr+3h46ikg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2019 at 12:58:44PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 12, 2019 at 11:29:55PM +0530, Vidya Sagar wrote:
> > On 11/12/2019 7:51 PM, Bjorn Helgaas wrote:
> > > On Tue, Nov 12, 2019 at 01:59:23PM +0100, Thierry Reding wrote:
> > > > On Mon, Nov 11, 2019 at 04:32:35PM -0600, Bjorn Helgaas wrote:
> > > > > On Mon, Nov 11, 2019 at 11:31:18AM +0530, Vidya Sagar wrote:
> > > > > > On 11/6/2019 10:11 PM, Bjorn Helgaas wrote:
> > > > >=20
> > > > > > > Based on Vidya's backtrace, I think the resume path with prob=
lems
> > > > > > > is this:
> > > > > > >=20
> > > > > > >     pci_pm_resume_noirq
> > > > > > >       pci_pm_default_resume_early
> > > > > > >         pci_power_up
> > > > > > >           if (platform_pci_power_manageable(dev))
> > > > > > >             platform_pci_set_power_state(dev, PCI_D0)  # <-- =
FW delay here?
> > > > > > >           pci_raw_set_power_state
> > > > > > >           pci_update_current_state
> > > > > > >             pci_device_is_present        # <-- config read re=
turns CRS
> > > > > > >=20
> > > > > > > So I think your suggestion is that Vidya's firmware should be
> > > > > > > doing the delay inside platform_pci_set_power_state()?
> > > > > > >=20
> > > > > > > Vidya, you typically work on Tegra, so I assume this is on an
> > > > > > > arm64 system?  Does it have ACPI?  Do you have access to the
> > > > > > > firmware developers to ask about who they expect to do the de=
lays?
> > > > > >=20
> > > > > > Yes. This is on arm64 (Tegra) and we don't have any ACPI or any
> > > > > > other firmware for that matter. PCIe is brought up directly in =
the
> > > > > > kernel.
> > > > >=20
> > > > > I assume that your device is coming out of D3cold because apparen=
tly
> > > > > you're seeing a CRS status from the config read when
> > > > > pci_update_current_state() calls pci_device_is_present().  CRS st=
atus
> > > > > should only happen after reset or power-on from D3cold, and you'r=
e not
> > > > > doing a reset.
> > > > >=20
> > > > > I'm pretty sure platform_pci_power_manageable() returns false on
> > > > > your system (can you confirm that?) because the only scenarios wi=
th
> > > > > platform power management are MID (Intel platform) and ACPI (whic=
h you
> > > > > don't have).
> > > > >=20
> > > > > Maybe you have some other platform-specific mechanism that contro=
ls
> > > > > power to PCI devices, and it's not integrated into the
> > > > > platform_pci_*() framework?
> > > >=20
> > > > My understanding after reading the PCIe specification is that CRS i=
s a
> > > > mechanism that allows an endpoint to signal that it isn't ready yet=
 for
> > > > operation after reset or power-on from D3cold. There's nothing in t=
here
> > > > that's platform specific. This is really only for specific endpoint=
s.
> > > >=20
> > > > I don't see how adding platform specific PM code would help in this
> > > > case. At a platform level we don't know if users are going to plug =
in a
> > > > PCI endpoint that needs a long delay before it's ready after reset =
and/
> > > > or exit from D3cold.
> > >=20
> > > Right, see below.
> > >=20
> > > > I do understand that perhaps pci_device_is_present() is perhaps not=
 the
> > > > best place to do complex CRS handling, but if a mechanism is clearly
> > > > described in the specification, isn't it something that should be d=
ealt
> > > > with in the core? That way we don't have to quirk this for every de=
vice
> > > > and platform.
> > >=20
> > > Definitely; we don't want quirks for endpoints (unless they're
> > > actually broken) or for platforms (unless there's a platform hardware
> > > or firmware defect).
> > >=20
> > > There's no question that we need to delay and handle CRS after
> > > power-on from D3cold.  I'm trying to get at the point that PCI itself
> > > doesn't tell us how to do that power-on.  The mechanisms defined by
> > > PCI rely on config space, which is only accessible in D0-D3hot, not
> > > D3cold.  Power-on from D3cold can only happen via ACPI methods or
> > > other platform-specific mechanisms, and the current design abstracts
> > > those via platform_pci_set_power_state().  This is partly based on
> > > Rafael's response in [1].
> > >=20
> > > > The PCIe specification says that:
> > > >=20
> > > > 	Software that intends to take advantage of this mechanism must
> > > > 	ensure that the first access made to a device following a valid
> > > > 	reset condition is a Configuration Read Request accessing both
> > > > 	bytes of the Vendor ID field in the device's Configuration Space
> > > > 	header.
> > > >=20
> > > > So doesn't that mean that pci_device_is_present() is already much t=
oo
> > > > late because we've potentially made other configuration read reques=
ts in
> > > > the meantime?
> > > >=20
> > > > Wouldn't it make more sense to push the CRS handling up a bit? The
> > > > existing pci_power_up() function seems like it would be a good plac=
e.
> > > > For example, adding code to deal with CRS right after the platform =
PCI
> > > > PM calls but before pci_raw_set_power_state() seems like it would f=
it
> > > > the restrictions given in the above quote from the specification.
> > >=20
> > > Yep, I think that's the right point.  I'm trying to figure out how to
> > > integrate it.  Rafael suggests that delays may be platform-specific
> > > and should be in platform_pci_set_power_state(), but the CRS handling
> > > itself isn't platform-specific and maybe could be higher up.
> > >=20
> > > I'm fishing to see if Tegra has some kind of power control for
> > > endpoints that is not related to the platform_pci_*() framework.  How
> > > did the endpoint get put in D3cold in the first place?  I assume
> > > something in the suspend path did that?  Maybe this happens when we
> > > suspend the Tegra RC itself, e.g., tegra_pcie_pm_suspend()?
> > >=20
> > >    tegra_pcie_pm_suspend
> > >      tegra_pcie_phy_power_off
> > >      tegra_pcie_power_off
> > >=20
> > >    tegra_pcie_pm_resume
> > >      tegra_pcie_power_on
> > >      tegra_pcie_phy_power_on
> > >=20
> > > If a path like tegra_pcie_pm_resume() is causing the D3cold -> D0
> > > transition for the endpoint, I don't think we want to do CRS handling
> > > there because that path shouldn't be touching the endpoint.  But maybe
> > > it should be doing the delays required by PCIe r5.0, sec 6.6.1, before
> > > any config accesses are issued to devices.
> >
> > Here, I'm exercising suspend-to-RAM sequence and the PCIe endpoint of
> > concern is Intel 750 NVMe drive.
> > PCIe host controller driver already has 100ms of delay as per the spec,
>=20
> To make this more concrete, where specifically is this delay?
>=20
> > but this particular device is taking 1023ms to get ready to respond to
> > configuration space requests (till that time, it responds with
> > configuration request retry statuses)
> > I've put a dump_stack () to see the path resume sequence takes and here=
 it is
> >=20
> >  Call trace:
> >   dump_backtrace+0x0/0x158
> >   show_stack+0x14/0x20
> >   dump_stack+0xb0/0xf4
> >   pci_bus_generic_read_dev_vendor_id+0x19c/0x1a0
> >   pci_bus_read_dev_vendor_id+0x48/0x70
> >   pci_update_current_state+0x68/0xd8
> >   pci_power_up+0x40/0x50
> >   pci_pm_resume_noirq+0x7c/0x138
> >   dpm_run_callback.isra.16+0x20/0x70
> >   device_resume_noirq+0x120/0x238
> >   async_resume_noirq+0x24/0x58
> >   async_run_entry_fn+0x40/0x148
> >   process_one_work+0x1e8/0x360
> >   worker_thread+0x40/0x488
> >   kthread+0x118/0x120
> >   ret_from_fork+0x10/0x1c
> >  pci 0005:01:00.0: ready after 1023ms
> >=20
> > Spec also mentions the following
> >     Unless Readiness Notifications mechanisms are used (see Section
> >     6.23), the Root Complex and/or system software must allow at
> >     least 1.0 s after a Conventional Reset of a device, before it
> >     may determine that a device which fails to return a Successful
> >     Completion status for a valid Configuration Request is a broken
> >     device. This period is independent of how quickly Link training
> >     completes.
> >=20
> > My understanding is that this 1sec waiting is supposed to be done by
> > the PCIe sub-system and not the host controller driver.
>=20
> That doesn't say we must wait 1s; it only says we can't decide the
> device is broken before 1s.  But regardless, I agree that the CRS
> handling doesn't belong in the driver for either the endpoint or the
> PCIe host controller.
>=20
> My question is whether this wait should be connected somehow with
> platform_pci_set_power_state().  It sounds like the tegra host
> controller driver already does the platform-specific delays, and I'm
> not sure it's reasonable for platform_pci_set_power_state() to do the
> CRS polling.  Maybe something like this?  I'd really like to get
> Rafael's thinking here.
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e7982af9a5d8..052fa316c917 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -964,9 +964,14 @@ void pci_refresh_power_state(struct pci_dev *dev)
>   */
>  void pci_power_up(struct pci_dev *dev)
>  {
> +	pci_power_state_t prev_state =3D dev->current_state;
> +
>  	if (platform_pci_power_manageable(dev))
>  		platform_pci_set_power_state(dev, PCI_D0);
> =20
> +	if (prev_state =3D=3D PCI_D3cold)
> +		pci_dev_wait(dev, "D3cold->D0", PCIE_RESET_READY_POLL_MS);

Is there any reason in particular why you chose to call pci_dev_wait()?
It seems to me like that's a little broader than pci_bus_wait_crs(). The
latter is static in drivers/pci/probe.c so we'd need to change that in
order to use it from drivers/pci/pci.c, but it sounds like the more
explicit thing to do.

Thierry

> +
>  	pci_raw_set_power_state(dev, PCI_D0);
>  	pci_update_current_state(dev, PCI_D0);
>  }
>=20
> > FWIW, this particular device is taking a little more time than 1 sec
> > (i.e. 1023 ms) I'm now wondering why is it that the CRS has a
> > timeout of 60 secs than just 1 sec?
>=20
> pci_bus_wait_crs() does an exponential backoff, i.e., it does reads
> after 0ms, 2ms, 4ms, 8ms, ..., 512ms, 1024ms, so we don't know
> *exactly* when the device became ready.  All we know is that it
> became ready somewhere between 512ms and 1024ms.
>=20
> But 821cdad5c46c ("PCI: Wait up to 60 seconds for device to become
> ready after FLR") does suggest that the Intel 750 NVMe may require
> more than 1s.  I think the 60s timeout is just a convenient large
> number and I'm not sure it's derived from anything in the spec.
>=20
> > > [1] https://lore.kernel.org/r/11429373.7ySiFsEkgL@kreacher
>=20

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3L5wcACgkQ3SOs138+
s6FFrg/+NewY1gsg5uIAw79JiHGJTc/EdQqN8gDwVwlKA6fn39nJ8k1QpFDTrz4Q
cFOGRLAUrg7zbctchToWKsKtJqOXgvxP7FLTfFiJX5iSgSpGYk7wdu8vHgEJklD2
nXkE/gWiLM5TVZnF3+aLP7D1P+IYaku3Wh9wHRJ2xSyhwp0Wi2KOuXsWOLOBnNTG
XsdVliIWpplaIBhk6GwtI7XxgHlhInHnGeJO4pieqhzFUO+wh5ke/yiwOIWJagoH
WBbE5fq4Q5cz/T5biPBtmS38IpVy81IT6oh72f/rjO/jRQFEvdC4jJWW4TKmnuRM
CdDziIR4td2NBDBp++Iqc95xvGd+VrD7y0BvVMezjUMbmkABoRmQaRSyri/7SK9O
ZE9+Bhk6jo+CBdKjor56V0ghBbJ2qvE5abrGtG8eHU1Ma4cdIyAFgCqk3B2X6k38
MwT/Ws6fLhJ6zNzElrEQkG/ouTCTVPeUQM3uGbLtvxGl0MAkepEsAZ48Ws7ESTJh
VjnlBZt+jdq70JbSTGs7DdGvsY5IHdoOAXUMdbyiWif2woX1iK5/aMLRkoRwELgL
ZmVYnj+/nm0edZGqATsNIJkxthRUg3PHjhy5Azp6dyEhRTqHUPsRRGHxO/q5i4Ad
oDG7jZPo7vvH00zhceCKhJeqkXVzBzXMAGHIqwfuqa9zrLlXDDc=
=PwQl
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
