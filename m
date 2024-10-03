Return-Path: <linux-pci+bounces-13787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5641F98F82E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 22:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA93F1F22295
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F12D1ABED6;
	Thu,  3 Oct 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ClXX7AtC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBC9224D1
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727988083; cv=none; b=YX/7TDTmCJwjy6Ob6QtUl3B1uxJ1b6LP8i+NFeYpW+Aa5bvlsz1em5+48Uj+BWuYtAHY0XLC5ZeNT9n8crLzDgUlYFyTaI/v5BLiK465hHVwi63mqxFpgVHZoCII9yJKA8ugNHzqeLm7bFuszDygZnx+wmJ3d9b8CipLrX0wMSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727988083; c=relaxed/simple;
	bh=a3j9NP/L5Mih1HtPqaWIMlDprp2extLLInBXsP2m3v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgSU0bm8xn0Q24/MEZnCREhjOxP4/uaioDjPFQsb4eEQoHATeNFBCmryJpjz52mkkCs92+gMcNMQqQZf0MN58xtxb2B60XAx3VQ1wvmEfRu+mACGx9mFEAIaDlJiqhi7pRAcS50knVNVY9jEQOfaFh8WDqnsJkMVQ7y4O2toNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ClXX7AtC; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-28742d10c76so827983fac.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Oct 2024 13:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727988079; x=1728592879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tkdnk/Up7D86Kg6po5gv4rMU88AOAgpDgUB1hsdkpkY=;
        b=ClXX7AtC6I7D2RZDRGde/niFMBOaRIIUktr7t9GRku40G4s8494nFS1mFEfH5Ca/mo
         L2t54d51pptUbLQclRvNixIKmRc5B20156NLcqZyBi8eCqawapvZ2vXrV6T31xobBrKD
         L4IVhxg7Gdpulyt5rJ94ElDpIITNmDmoosP7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727988079; x=1728592879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tkdnk/Up7D86Kg6po5gv4rMU88AOAgpDgUB1hsdkpkY=;
        b=CPPgi3rqd7TLO5LpwUYW2rdg1NjFH4GUmWKhL1cn90DXXxWIOq9G19J/ofqamL18Z/
         zH7h18brVImrrFoJ4PzEkqbvAtZyngthUxnwXb2ZG4xM/PU3wr3oFq+PM6AnOy5tut8/
         iJvhOiL62VTougb0UbDYc8xcfzgN+mGTlAtK9lCoWm1T9bbvNbKbwdesQGtxXFncacXV
         /Htq/ZiHuXRcftCBSrN8q7/YeNoQYG737WK9/VvaTqPexHb1RUT1ZOvhL3dkUoreMCS7
         2w1If4tmQGcKRi56SoNVtgdl7yN8sjROH1C92vdr5epXk4ZEgaGRwP/TXnxMnfNQHV4z
         b3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUQggRb//FD55TKcgqO5tjfA6m9cfjKN+WehnRNrhn5eD/MmdiO0nBzz53oZ/z2db8BZbnoBOVXrXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqeYsPkjgCi+JXteN5rDfNML5QiQe7S9LyIkdrgP8cd3cqUkv1
	rdBUy3Iu0kKNcG8mhF1dpuJWITeNDgaHsxqOf7OkW5C4qXoraULT+RJ4ynnH5GG+fqlqZCv2Crm
	UxFhGFOxbGt2sno0o04EtV8uYJFYRsMUk9NmgIUgbkOfL08pbY1YwRIm0SVwUjmrKG8lozoEO8p
	16amRnigxFKmEzto20dufsUg==
X-Google-Smtp-Source: AGHT+IGMGwYbS6JUhAPsipEzU73kN5z4XHRJ73u47LDD8PSiea1FqfVZeul1BV0ykpsMooSGHwf1ABoRh9PPFO+RNj0=
X-Received: by 2002:a05:6870:8a20:b0:27b:5a42:1448 with SMTP id
 586e51a60fabf-287c1ebfd65mr783028fac.25.1727988079274; Thu, 03 Oct 2024
 13:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1726733624-2142-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <1726733624-2142-2-git-send-email-shivasharan.srikanteshwara@broadcom.com> <20240924155755.000069cd@Huawei.com>
In-Reply-To: <20240924155755.000069cd@Huawei.com>
From: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Date: Thu, 3 Oct 2024 14:41:07 -0600
Message-ID: <CADbZ7FqUxAQFT0u7QQMuSKePRCEG2nWBzv=ECbSDGu+8WX8iAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] PCI/portdrv: Enable reporting inter-switch P2P links
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, linux-pci@vger.kernel.org, 
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org, logang@deltatee.com, 
	linux-kernel@vger.kernel.org, sathya.prakash@broadcom.com, 
	sjeaugey@nvidia.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ab6a4506239893fb"

--000000000000ab6a4506239893fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

>> Need more data that 'there is a link' for this.
>>I'd like to see some info on bandwidth and latency.

As you too noted in your comments, for now, we are only addressing p2p
connection between "virtual switches", i.e. switches that look
different to the host, but are actually part of the same physical
hardware.
Given that, I am not sure what we should display for bandwidth and
latency. There is no physical link to traverse between the virtual
switches, and usually we take that as "infinite" bandwidth and "zero"
latency. As such, any number here will make little sense until we
start supporting p2p connection between physical switches. We could,
of course, have some encoding for the time being, like have "INF" for
bandwidth and 0 for latency, but again, those will not be very useful
till the day this scheme is extended to physical switch and we display
real values, like bandwidth and latency for a x16 PCIe link. Thoughts?

sincerely,
Sumanesh


On Tue, Sep 24, 2024 at 8:57=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 19 Sep 2024 01:13:43 -0700
> Shivasharan S <shivasharan.srikanteshwara@broadcom.com> wrote:
>
> > Broadcom PCI switches supports inter-switch P2P links between two
> > PCI-to-PCI bridges. This presents an optimal data path for data
> > movement. The patch exports a new sysfs entry for PCI devices that
> > support the inter switch P2P links and reports the B:D:F information
> > of the devices that are connected through this inter switch link as
> > shown below:
> >
> >                              Host root bridge
> >                 ---------------------------------------
> >                 |                                     |
> >   NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
> > (2c:00.0)   (2a:00.0)                             (3d:00.0)   (40:00.0)
> >                 |                                     |
> >                GPU1                                  GPU2
> >             (2d:00.0)                             (3f:00.0)
> >                                SERVER 1
> >
> > $ find /sys/ -name "p2p_link" | xargs grep .
> > /sys/devices/pci0000:29/0000:29:01.0/0000:2a:00.0/p2p_link:0000:3d:00.0
> > /sys/devices/pci0000:3c/0000:3c:01.0/0000:3d:00.0/p2p_link:0000:2a:00.0
> >
> > Current support is added to report the P2P links available for
> > Broadcom switches based on the capability that is reported by the
> > upstream bridges through their vendor-specific capability registers.
> >
> > Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> > Signed-off-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> > ---
> > Changes in v2:
> > Integrated the code into PCIe portdrv to create the sysfs entries durin=
g
> > probe, as suggested by Mani.
>
> Hmm. So we are trying to rework portdrv in general to support extensibili=
ty.
> I'm a little nervous about taking in vendor specific code in the meantime
> even if it is trivial like this is.  We will be having an extensible
> discovery scheme but for now the plan is that will be child device based
> for non PCI standard features.
>
> It is a fairly small bit of code, so maybe it is fine - I'm not keen
> on adding the implementation of the vendor specific parts to the
> main driver though. Push that to an optional c file.
>
> A few general comments inline.
>
> >
> >  Documentation/ABI/testing/sysfs-bus-pci |  14 +++
> >  drivers/pci/pcie/portdrv.c              | 131 ++++++++++++++++++++++++
> >  drivers/pci/pcie/portdrv.h              |  10 ++
> >  3 files changed, 155 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/AB=
I/testing/sysfs-bus-pci
> > index ecf47559f495..e5d02f20655f 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -572,3 +572,17 @@ Description:
> >               enclosure-specific indications "specific0" to "specific7"=
,
> >               hence the corresponding led class devices are unavailable=
 if
> >               the DSM interface is used.
> > +
> > +What:                /sys/bus/pci/devices/.../p2p_link
> > +Date:                September 2024
> > +Contact:     Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> > +Description:
> > +             This file appears on PCIe upstream ports which supports a=
n
> > +             internal P2P link.
> > +             Reading this attribute will provide the list of other ups=
tream
> > +             ports on the system which have an internal P2P link avail=
able
> > +             between the two ports.
>
> Given this only applies to 'internal' links and not inter switch physical=
 links
> I think you should rename it.  An eventual p2p link between physical swit=
ches
> is going to be much more complex as will need routing information.
> Let us avoid trampling on that space.
>
> > +Users:
> > +             Userspace applications interested in determining a optima=
l P2P
> > +             link for data transfers between devices connected to the =
PCIe
> > +             switches.
>
> Need more data that 'there is a link' for this.
> I'd like to see some info on bandwidth and latency. I've previously been
> in discussions about similar devices that provide a low latency but low
> bandwidth direct path.  That gets more likely if we scale up to
> multiple physical switches or the software stack is choosing between
> multiple p2p targets (e.g. getting nearest path to a multiheaded NIC).
>
> Perhaps best bet is to leave space for that by using a directory
> here to cover everything about p2p?  Maybe have links under there to the
> other upstream ports? That might be fiddly to manage though.
>
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index 6af5e0425872..c940b4b242fd 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/string.h>
> >  #include <linux/slab.h>
> >  #include <linux/aer.h>
> > +#include <linux/bitops.h>
> >
> >  #include "../pci.h"
> >  #include "portdrv.h"
> > @@ -37,6 +38,134 @@ struct portdrv_service_data {
> >       u32 service;
> >  };
> >
> > +/**
> > + * pcie_brcm_is_p2p_supported - Broadcom device specific handler
> > + *       to check if the upstream port supports inter switch P2P.
> > + *
> > + * @dev: PCIe upstream port to check
> > + *
> > + * This function assumes the PCIe upstream port is a Broadcom
> > + * PCIe device.
> > + */
> > +static bool pcie_brcm_is_p2p_supported(struct pci_dev *dev)
>
> Put this in a separate c file + use a config option and some
> stubs to make it go away if people don't want to support it.
> The layering and separation in portdrv is currently messy but
> we shouldn't make it worse :(
>
> > +{
> > +     u64 dsn;
> > +     u16 vsec;
> > +     u32 vsec_data;
> > +
> > +     dsn =3D pci_get_dsn(dev);
> > +     if (!dsn) {
> > +             pci_dbg(dev, "DSN capability is not present\n");
> > +             return false;
> > +     }
>
> Why get the dsn (which will frequently exist on other devices)
> before getting the vsec which won't?  Reorder these first
> two checks. For most devices the match on vendor will fail in the
> vsec check.
>
> > +
> > +     vsec =3D pci_find_vsec_capability(dev, PCI_VENDOR_ID_LSI_LOGIC,
> > +                                     PCIE_BRCM_SW_P2P_VSEC_ID);
> > +     if (!vsec) {
> > +             pci_dbg(dev, "Failed to get VSEC capability\n");
> > +             return false;
> > +     }
> > +
> > +     pci_read_config_dword(dev, vsec + PCIE_BRCM_SW_P2P_MODE_VSEC_OFFS=
ET,
> > +                           &vsec_data);
> > +
> > +     pci_dbg(dev, "Serial Number: 0x%llx VSEC 0x%x\n",
> > +             dsn, vsec_data);
> > +
> > +     if (!PCIE_BRCM_SW_IS_SECURE_PART(dsn))
>
> Add a comment on this. Not obvious what this is checking as it's picking
> a single bit out of a serial number...
>
> > +             return false;
> > +
> > +     if (FIELD_GET(PCIE_BRCM_SW_P2P_MODE_MASK, vsec_data) !=3D
> > +             PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK)
> > +             return false;
> > +
> > +     return true;
>         return FIELD_GET(PCIE_BRCM_SW_P2P_MODE_MASK, vsec_data) =3D=3D
>                PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK;
> perhaps.
>
> > +}
> > +
> > +/**
> > + * Determine if device supports Inter switch P2P links.
> > + *
> > + * Return value: true if inter switch P2P is supported, return false o=
therwise.
> > + */
> > +static bool pcie_port_is_p2p_supported(struct pci_dev *dev)
> > +{
> > +     /* P2P link attribute is supported on upstream ports only */
> > +     if (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_UPSTREAM)
> > +             return false;
> > +
> > +     /*
> > +      * Currently Broadcom PEX switches are supported.
> > +      */
> > +     if (dev->vendor =3D=3D PCI_VENDOR_ID_LSI_LOGIC &&
> > +         (dev->device =3D=3D PCI_DEVICE_ID_BRCM_PEX_89000_HLC ||
> > +          dev->device =3D=3D PCI_DEVICE_ID_BRCM_PEX_89000_LLC))
> > +             return pcie_brcm_is_p2p_supported(dev);
> > +
> > +     return false;
> > +}
> > +
> > +/*
> > + * Traverse list of all PCI bridges and find devices that support Inte=
r switch P2P
> > + * and have the same serial number to create report the BDF over sysfs=
.
> > + */
> > +static ssize_t p2p_link_show(struct device *dev, struct device_attribu=
te *attr,
> > +                          char *buf)
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(dev), *pdev_link =3D NULL;
> > +     size_t len =3D 0;
> > +     u64 dsn, dsn_link;
> > +
> > +     dsn =3D pci_get_dsn(pdev);
>
> Maybe add a comment that we don't need to repeat checks that were done
> to make the attribute visible. Hence dsn will exist and it will be p2p li=
nk capable.
>
> > +
> > +     /* Traverse list of PCI bridges to determine any available P2P li=
nks */
> > +     while ((pdev_link =3D pci_get_class(PCI_CLASS_BRIDGE_PCI << 8, pd=
ev_link))
>
> Feels like we should have a for_each_pci_bridge() similar to for_each_pci=
_dev()
> that does this, but that is already defined to mean something else...
>
> Bjorn, is this something we should be looking to make more consistent
> perhaps with naming to make it clear what is a search of all instances
> on any bus and what is a search below a particular bus?
>
> > +                     !=3D NULL) {
> > +             if (pdev_link =3D=3D pdev)
> > +                     continue;
> > +
> > +             if (!pcie_port_is_p2p_supported(pdev_link))
> > +                     continue;
> > +
> > +             dsn_link =3D pci_get_dsn(pdev_link);
> > +             if (!dsn_link)
> > +                     continue;
> > +
> > +             if (dsn =3D=3D dsn_link)
> > +                     len +=3D sysfs_emit_at(buf, len, "%04x:%02x:%02x.=
%d\n",
> > +                                          pci_domain_nr(pdev_link->bus=
),
> > +                                          pdev_link->bus->number, PCI_=
SLOT(pdev_link->devfn),
> > +                                          PCI_FUNC(pdev_link->devfn));
> > +     }
> > +
> > +     return len;
> > +}
>
>
> > diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> > index 12c89ea0313b..1be06cb45665 100644
> > --- a/drivers/pci/pcie/portdrv.h
> > +++ b/drivers/pci/pcie/portdrv.h
> > @@ -25,6 +25,16 @@
> >
> >  #define PCIE_PORT_DEVICE_MAXSERVICES   5
> >
> > +/* P2P Link supported device IDs */
> > +#define PCI_DEVICE_ID_BRCM_PEX_89000_HLC     0xC030
> > +#define PCI_DEVICE_ID_BRCM_PEX_89000_LLC     0xC034
> > +
> > +#define PCIE_BRCM_SW_P2P_VSEC_ID             0x1
> > +#define PCIE_BRCM_SW_P2P_MODE_VSEC_OFFSET    0xC
> > +#define PCIE_BRCM_SW_P2P_MODE_MASK           GENMASK(9, 8)
> > +#define PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK  0x2
> > +#define PCIE_BRCM_SW_IS_SECURE_PART(dsn)     ((dsn) & 0x8)
> Define the mask, and use FIELD_GET() to get that.
> > +
> >  extern bool pcie_ports_dpc_native;
> >
> >  #ifdef CONFIG_PCIEAER
>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--000000000000ab6a4506239893fb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDG3N/v/7cXC4xYP/YDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTIzMzdaFw0yNTA5MTAwOTIzMzdaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEFN1bWFuZXNoIFNhbWFudGExLDAqBgkqhkiG
9w0BCQEWHXN1bWFuZXNoLnNhbWFudGFAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAsuiZfUgi9027cN+iQrYjDHStIlbjoJWWNwczYntRKg33D9vp+AVA1FV9sHTq
vC+5D42TNZY/dJZv0cwb4JWxZa0ZG3BJzvkpsRJNUreSojb5yuBrY6Tr8Hav57NDLZAnynhV3xZ6
iX6Wa0JFKZIept2rdGV201AJmgVaDZsRFPIpfHeRsUuTufDWr5A/2hVVTvQt7hQmgXyyQzcii9I3
zekCl3pjcoOObDAkznDD9vlyLLvDDWikUDmc6Q82vNt89t6IYnDV8PrsTGMlK2Js/LyhYHN3d/sQ
dBHV3iBHyeN6pUKZ0sDzQMKjzE2S0IRRX6Mwh+DYAUDm66pjXc8FOQIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1zdW1hbmVzaC5zYW1hbnRhQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU6TFlZ1Wo
0dmsZDo+/EXAseKlvxUwDQYJKoZIhvcNAQELBQADggEBACxY1CWol9aZ4MJi8uYcPC6El2gUSbiO
NySelOnmiuTKCJRj0e5NJqm6X7p7kN/JEqPy03YjEMTvqYCGcc0ExTQf3RPYeZzaQSrFr3oc9k8N
EGmluzckC+UTGlwVoo38RG+V/ixlatLYgSLqvrKV1h/wX79onLyMMlGR1yZUburAx5qpK6eE/EHW
o6GtvueloW9jET+RFa16TbcDTDio24qwqHELYzgk/PngQbUU82erdcVP80Rr7rWwC5XtbAB6cbjb
mca5iAjoc2SCWnNGFtyOQ5hUC10AMZrPOP4hPodpkP+FJR35N4NiEg6amrNvmPIEadV2JkyE0qVa
fniK4LcxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxt
zf7/+3FwuMWD/2AwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILt8luWNaQBsWJaH
9Qsk71PH6zM8iroSIQrd+7fbFWakMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MTAwMzIwNDExOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBWsagFte1J8z2ClVljCSEMf/32qAeCkPbq
m7w+sXohkRpOJ85MKtfvEe0BrccfpYdErFkBGmXnw+NL22NmdYEP6sjObU5OvyEwjxU7/QAM9m1y
I0W0vda9pUg7/ZKnG7oh3I4vWS7MW1qsNJplfuOMl07FRopI4LxrtDeNc5JdViZNTZGE/I4e0ClT
HP0WHrgF+lMXC3PTRbYlgGwpfmCr9VgVpore26iBluxgT7VBzlt2saObP+wnV4ukq58NrdhNfTrc
24Ii82oTNMz4ZEvXZOId//unshkpx3Ftttt5ihfx41dyQ2np7KOl211Bx+XOKLhIOeLkC9wpWr36
KsrV
--000000000000ab6a4506239893fb--

