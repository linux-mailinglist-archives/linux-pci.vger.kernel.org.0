Return-Path: <linux-pci+bounces-13810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1989901B4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 12:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65841F22B21
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E815855C;
	Fri,  4 Oct 2024 10:57:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3A13B5B7;
	Fri,  4 Oct 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039436; cv=none; b=Ctm5y0/5MMaqEX9IS4KA/mB6ceS+sQP5sDSccRoy1k6cTgRTObuvF8yK0WJaZ5en+SyyoBwHzU1mNKeoQjKJhm2E+XgGFfuA0CPfE7/oESv8T4h7bVaOyAviC7G+uCZrqtHO67VPPaMpqkUNY+elLcDFabky+nn/PvNl4mtSM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039436; c=relaxed/simple;
	bh=FKc6JzBKN+EHsQUfgqwXreoVbgH5cVxUynPbGuvMUjc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jspz6Etl7Ol+tJjKliWjNQzsVz+1S3Bb3esLzVyFZT196wgMEA6U2z45Kq4Rx9RkU5iNTbTQGlIac+isSvSSGLxZ7UGVL9jw8+jgzQV9t8F3Tip8BHaSa6cciY5M2silKLybmaIqqQNsnsCHhqaEX3Zwjitke++uYddzvMQVztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XKlQ21k5vz6J6DP;
	Fri,  4 Oct 2024 18:38:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F9AF1402C6;
	Fri,  4 Oct 2024 18:39:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Oct
 2024 12:39:34 +0200
Date: Fri, 4 Oct 2024 11:39:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
CC: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<manivannan.sadhasivam@linaro.org>, <logang@deltatee.com>,
	<linux-kernel@vger.kernel.org>, <sathya.prakash@broadcom.com>,
	<sjeaugey@nvidia.com>
Subject: Re: [PATCH 1/2 v2] PCI/portdrv: Enable reporting inter-switch P2P
 links
Message-ID: <20241004113933.00007ec4@Huawei.com>
In-Reply-To: <CADbZ7FqUxAQFT0u7QQMuSKePRCEG2nWBzv=ECbSDGu+8WX8iAQ@mail.gmail.com>
References: <1726733624-2142-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
	<1726733624-2142-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>
	<20240924155755.000069cd@Huawei.com>
	<CADbZ7FqUxAQFT0u7QQMuSKePRCEG2nWBzv=ECbSDGu+8WX8iAQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 3 Oct 2024 14:41:07 -0600
Sumanesh Samanta <sumanesh.samanta@broadcom.com> wrote:

> Hi Jonathan,
>=20
> >> Need more data that 'there is a link' for this.
> >>I'd like to see some info on bandwidth and latency. =20
>=20
> As you too noted in your comments, for now, we are only addressing p2p
> connection between "virtual switches", i.e. switches that look
> different to the host, but are actually part of the same physical
> hardware.
> Given that, I am not sure what we should display for bandwidth and
> latency. There is no physical link to traverse between the virtual
> switches, and usually we take that as "infinite" bandwidth and "zero"
> latency.

For a case where you have no information, not having attributes is
sensible. If there is information (CXL CDAT provides this for switches
for instance) then we should have an interface that provides space for
that information.

> As such, any number here will make little sense until we
> start supporting p2p connection between physical switches.

As above, it makes sense in a switch as well - if the information
is available.

> We could,
> of course, have some encoding for the time being, like have "INF" for
> bandwidth and 0 for latency, but again, those will not be very useful
> till the day this scheme is extended to physical switch and we display
> real values, like bandwidth and latency for a x16 PCIe link. Thoughts?

Hide the sysfs attributes for latency and bandwidth if we simply don't
know.  Software built on top of this can then assume full bandwidth
is available or better still run some measurements to establish the
missing data.

All I really meant by this suggestion is a directory with space for
other info is probably more extensible than a single file.

Jonathan

>=20
> sincerely,
> Sumanesh
>=20
>=20
> On Tue, Sep 24, 2024 at 8:57=E2=80=AFAM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 19 Sep 2024 01:13:43 -0700
> > Shivasharan S <shivasharan.srikanteshwara@broadcom.com> wrote:
> > =20
> > > Broadcom PCI switches supports inter-switch P2P links between two
> > > PCI-to-PCI bridges. This presents an optimal data path for data
> > > movement. The patch exports a new sysfs entry for PCI devices that
> > > support the inter switch P2P links and reports the B:D:F information
> > > of the devices that are connected through this inter switch link as
> > > shown below:
> > >
> > >                              Host root bridge
> > >                 ---------------------------------------
> > >                 |                                     |
> > >   NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
> > > (2c:00.0)   (2a:00.0)                             (3d:00.0)   (40:00.=
0)
> > >                 |                                     |
> > >                GPU1                                  GPU2
> > >             (2d:00.0)                             (3f:00.0)
> > >                                SERVER 1
> > >
> > > $ find /sys/ -name "p2p_link" | xargs grep .
> > > /sys/devices/pci0000:29/0000:29:01.0/0000:2a:00.0/p2p_link:0000:3d:00=
.0
> > > /sys/devices/pci0000:3c/0000:3c:01.0/0000:3d:00.0/p2p_link:0000:2a:00=
.0
> > >
> > > Current support is added to report the P2P links available for
> > > Broadcom switches based on the capability that is reported by the
> > > upstream bridges through their vendor-specific capability registers.
> > >
> > > Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> > > Signed-off-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> > > ---
> > > Changes in v2:
> > > Integrated the code into PCIe portdrv to create the sysfs entries dur=
ing
> > > probe, as suggested by Mani. =20
> >
> > Hmm. So we are trying to rework portdrv in general to support extensibi=
lity.
> > I'm a little nervous about taking in vendor specific code in the meanti=
me
> > even if it is trivial like this is.  We will be having an extensible
> > discovery scheme but for now the plan is that will be child device based
> > for non PCI standard features.
> >
> > It is a fairly small bit of code, so maybe it is fine - I'm not keen
> > on adding the implementation of the vendor specific parts to the
> > main driver though. Push that to an optional c file.
> >
> > A few general comments inline.
> > =20
> > >
> > >  Documentation/ABI/testing/sysfs-bus-pci |  14 +++
> > >  drivers/pci/pcie/portdrv.c              | 131 ++++++++++++++++++++++=
++
> > >  drivers/pci/pcie/portdrv.h              |  10 ++
> > >  3 files changed, 155 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/=
ABI/testing/sysfs-bus-pci
> > > index ecf47559f495..e5d02f20655f 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > > @@ -572,3 +572,17 @@ Description:
> > >               enclosure-specific indications "specific0" to "specific=
7",
> > >               hence the corresponding led class devices are unavailab=
le if
> > >               the DSM interface is used.
> > > +
> > > +What:                /sys/bus/pci/devices/.../p2p_link
> > > +Date:                September 2024
> > > +Contact:     Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> > > +Description:
> > > +             This file appears on PCIe upstream ports which supports=
 an
> > > +             internal P2P link.
> > > +             Reading this attribute will provide the list of other u=
pstream
> > > +             ports on the system which have an internal P2P link ava=
ilable
> > > +             between the two ports. =20
> >
> > Given this only applies to 'internal' links and not inter switch physic=
al links
> > I think you should rename it.  An eventual p2p link between physical sw=
itches
> > is going to be much more complex as will need routing information.
> > Let us avoid trampling on that space.
> > =20
> > > +Users:
> > > +             Userspace applications interested in determining a opti=
mal P2P
> > > +             link for data transfers between devices connected to th=
e PCIe
> > > +             switches. =20
> >
> > Need more data that 'there is a link' for this.
> > I'd like to see some info on bandwidth and latency. I've previously been
> > in discussions about similar devices that provide a low latency but low
> > bandwidth direct path.  That gets more likely if we scale up to
> > multiple physical switches or the software stack is choosing between
> > multiple p2p targets (e.g. getting nearest path to a multiheaded NIC).
> >
> > Perhaps best bet is to leave space for that by using a directory
> > here to cover everything about p2p?  Maybe have links under there to the
> > other upstream ports? That might be fiddly to manage though.
> > =20
> > > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > > index 6af5e0425872..c940b4b242fd 100644
> > > --- a/drivers/pci/pcie/portdrv.c
> > > +++ b/drivers/pci/pcie/portdrv.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/string.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/aer.h>
> > > +#include <linux/bitops.h>
> > >
> > >  #include "../pci.h"
> > >  #include "portdrv.h"
> > > @@ -37,6 +38,134 @@ struct portdrv_service_data {
> > >       u32 service;
> > >  };
> > >
> > > +/**
> > > + * pcie_brcm_is_p2p_supported - Broadcom device specific handler
> > > + *       to check if the upstream port supports inter switch P2P.
> > > + *
> > > + * @dev: PCIe upstream port to check
> > > + *
> > > + * This function assumes the PCIe upstream port is a Broadcom
> > > + * PCIe device.
> > > + */
> > > +static bool pcie_brcm_is_p2p_supported(struct pci_dev *dev) =20
> >
> > Put this in a separate c file + use a config option and some
> > stubs to make it go away if people don't want to support it.
> > The layering and separation in portdrv is currently messy but
> > we shouldn't make it worse :(
> > =20
> > > +{
> > > +     u64 dsn;
> > > +     u16 vsec;
> > > +     u32 vsec_data;
> > > +
> > > +     dsn =3D pci_get_dsn(dev);
> > > +     if (!dsn) {
> > > +             pci_dbg(dev, "DSN capability is not present\n");
> > > +             return false;
> > > +     } =20
> >
> > Why get the dsn (which will frequently exist on other devices)
> > before getting the vsec which won't?  Reorder these first
> > two checks. For most devices the match on vendor will fail in the
> > vsec check.
> > =20
> > > +
> > > +     vsec =3D pci_find_vsec_capability(dev, PCI_VENDOR_ID_LSI_LOGIC,
> > > +                                     PCIE_BRCM_SW_P2P_VSEC_ID);
> > > +     if (!vsec) {
> > > +             pci_dbg(dev, "Failed to get VSEC capability\n");
> > > +             return false;
> > > +     }
> > > +
> > > +     pci_read_config_dword(dev, vsec + PCIE_BRCM_SW_P2P_MODE_VSEC_OF=
FSET,
> > > +                           &vsec_data);
> > > +
> > > +     pci_dbg(dev, "Serial Number: 0x%llx VSEC 0x%x\n",
> > > +             dsn, vsec_data);
> > > +
> > > +     if (!PCIE_BRCM_SW_IS_SECURE_PART(dsn)) =20
> >
> > Add a comment on this. Not obvious what this is checking as it's picking
> > a single bit out of a serial number...
> > =20
> > > +             return false;
> > > +
> > > +     if (FIELD_GET(PCIE_BRCM_SW_P2P_MODE_MASK, vsec_data) !=3D
> > > +             PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK)
> > > +             return false;
> > > +
> > > +     return true; =20
> >         return FIELD_GET(PCIE_BRCM_SW_P2P_MODE_MASK, vsec_data) =3D=3D
> >                PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK;
> > perhaps.
> > =20
> > > +}
> > > +
> > > +/**
> > > + * Determine if device supports Inter switch P2P links.
> > > + *
> > > + * Return value: true if inter switch P2P is supported, return false=
 otherwise.
> > > + */
> > > +static bool pcie_port_is_p2p_supported(struct pci_dev *dev)
> > > +{
> > > +     /* P2P link attribute is supported on upstream ports only */
> > > +     if (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_UPSTREAM)
> > > +             return false;
> > > +
> > > +     /*
> > > +      * Currently Broadcom PEX switches are supported.
> > > +      */
> > > +     if (dev->vendor =3D=3D PCI_VENDOR_ID_LSI_LOGIC &&
> > > +         (dev->device =3D=3D PCI_DEVICE_ID_BRCM_PEX_89000_HLC ||
> > > +          dev->device =3D=3D PCI_DEVICE_ID_BRCM_PEX_89000_LLC))
> > > +             return pcie_brcm_is_p2p_supported(dev);
> > > +
> > > +     return false;
> > > +}
> > > +
> > > +/*
> > > + * Traverse list of all PCI bridges and find devices that support In=
ter switch P2P
> > > + * and have the same serial number to create report the BDF over sys=
fs.
> > > + */
> > > +static ssize_t p2p_link_show(struct device *dev, struct device_attri=
bute *attr,
> > > +                          char *buf)
> > > +{
> > > +     struct pci_dev *pdev =3D to_pci_dev(dev), *pdev_link =3D NULL;
> > > +     size_t len =3D 0;
> > > +     u64 dsn, dsn_link;
> > > +
> > > +     dsn =3D pci_get_dsn(pdev); =20
> >
> > Maybe add a comment that we don't need to repeat checks that were done
> > to make the attribute visible. Hence dsn will exist and it will be p2p =
link capable.
> > =20
> > > +
> > > +     /* Traverse list of PCI bridges to determine any available P2P =
links */
> > > +     while ((pdev_link =3D pci_get_class(PCI_CLASS_BRIDGE_PCI << 8, =
pdev_link)) =20
> >
> > Feels like we should have a for_each_pci_bridge() similar to for_each_p=
ci_dev()
> > that does this, but that is already defined to mean something else...
> >
> > Bjorn, is this something we should be looking to make more consistent
> > perhaps with naming to make it clear what is a search of all instances
> > on any bus and what is a search below a particular bus?
> > =20
> > > +                     !=3D NULL) {
> > > +             if (pdev_link =3D=3D pdev)
> > > +                     continue;
> > > +
> > > +             if (!pcie_port_is_p2p_supported(pdev_link))
> > > +                     continue;
> > > +
> > > +             dsn_link =3D pci_get_dsn(pdev_link);
> > > +             if (!dsn_link)
> > > +                     continue;
> > > +
> > > +             if (dsn =3D=3D dsn_link)
> > > +                     len +=3D sysfs_emit_at(buf, len, "%04x:%02x:%02=
x.%d\n",
> > > +                                          pci_domain_nr(pdev_link->b=
us),
> > > +                                          pdev_link->bus->number, PC=
I_SLOT(pdev_link->devfn),
> > > +                                          PCI_FUNC(pdev_link->devfn)=
);
> > > +     }
> > > +
> > > +     return len;
> > > +} =20
> >
> > =20
> > > diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> > > index 12c89ea0313b..1be06cb45665 100644
> > > --- a/drivers/pci/pcie/portdrv.h
> > > +++ b/drivers/pci/pcie/portdrv.h
> > > @@ -25,6 +25,16 @@
> > >
> > >  #define PCIE_PORT_DEVICE_MAXSERVICES   5
> > >
> > > +/* P2P Link supported device IDs */
> > > +#define PCI_DEVICE_ID_BRCM_PEX_89000_HLC     0xC030
> > > +#define PCI_DEVICE_ID_BRCM_PEX_89000_LLC     0xC034
> > > +
> > > +#define PCIE_BRCM_SW_P2P_VSEC_ID             0x1
> > > +#define PCIE_BRCM_SW_P2P_MODE_VSEC_OFFSET    0xC
> > > +#define PCIE_BRCM_SW_P2P_MODE_MASK           GENMASK(9, 8)
> > > +#define PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK  0x2
> > > +#define PCIE_BRCM_SW_IS_SECURE_PART(dsn)     ((dsn) & 0x8) =20
> > Define the mask, and use FIELD_GET() to get that. =20
> > > +
> > >  extern bool pcie_ports_dpc_native;
> > >
> > >  #ifdef CONFIG_PCIEAER =20
> > =20
>=20


