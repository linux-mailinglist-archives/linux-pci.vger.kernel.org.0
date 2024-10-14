Return-Path: <linux-pci+bounces-14439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CEB99C608
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 11:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F012867E9
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E2B156C76;
	Mon, 14 Oct 2024 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GEMkntAa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F015B551
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898876; cv=none; b=qXgPoTPy/5DU1NnRib0/FS8smKYhvZC7Mgg9n4LPY5clkYD+YLVezwUrK7Y7/yQtJ57Sc8vtwmemVPb3n8jJ4ndobMO98x8CiSdlllNnerJJZvHE1Wwp2otaOsBL0gnXl8lR1THHiHrkJu+6g2sVTrpStEu6/YvVpPJ3/kWSrpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898876; c=relaxed/simple;
	bh=YPMIeQAh/v08kpudUsrOdOUpkX+1BQLN4/IiGBvKriE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0I/MWdM5f3ciyterGCIDrJrjh2yQ5lupexfx1uH+tzyOp0+qyS2VDRQvRjMiROJnyi7F8J/DJGCK3YYyfaagnYGfa46LvYw39DZriBZ3vtdqNMNO4ni8pArse+SACXOP8M8Xx6/+kIEMkhQX71nwZpg73vhtggRDddcL7ijaiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GEMkntAa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c97cc83832so991641a12.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728898870; x=1729503670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XUAkLdSwdYmx8Cc2y8daB/UXV1FX1NTvIYtW8TlrCfc=;
        b=GEMkntAa4cQIAOuNlcfAiDojMzrsSTkXUopq04wf3mqu1HLyJr8j+QcnkOk+eZhe3P
         LquJ/ZL3gnjlIooX2/iHzjvZBxX8D1+eY8P+V9pimA/J+gtmED8kmhilFcltnWQ7rVsf
         Zl9HiuPoGuSsfVj8po0+tk8ojsa+3HeOx5nL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898870; x=1729503670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUAkLdSwdYmx8Cc2y8daB/UXV1FX1NTvIYtW8TlrCfc=;
        b=UnxZlioHcy1rQJ4OJtYOz2g6D5kLX4r4LfsTsLstirJNjPF9STNdnFszN585/D6BRj
         wmA6GbByoJogfTfh6OTVDvTa9Fy6cL0NTIiz1BI7iDtJeHnXTBJQpnkkUkZ+2u9QK47q
         YOesUvmnfMWtI7I63gpmY2d6/rR8f3EbxJKovD2RBofFtdPHEHkbYnSjOfZaigV5npt4
         9fPQ4YdqGDGTZ9AiNW6w+yS04WCKGgFEPev7YGj13Wv1xpzN3EOFjUdCfYi7CcaHmJoy
         zqh7+YhhTEpEqfpwta+qynHvZnWGr2OuyihhvMfEg95Fl7tbmGiSRGc2feTL3tW19CGs
         mvng==
X-Forwarded-Encrypted: i=1; AJvYcCURd5WHmQ7GSJ8VjRuqDc3LkgUW10SCtqZe9UwuD3chc1U2Wt850lBucgcOgx18wc+QygeiIv3YAHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQQJm/p0+6ADqVQJvCdslINYJOYWTs90L9BKLnR8Cz5wpEd/px
	v8n1JGRDnat2jyHKmWlhAw+TNqAxs7Ou9hVIZq+bxS3m+lIjK8W1xeLOErXkaG0UmoqPn9drEvB
	pjgBXIinvoBSggdZrjTTAUE8/kVRGdrOqlSmI
X-Google-Smtp-Source: AGHT+IEu5pwUur15PF+OE26BqHCkTs9hsSavhwNKjjQpciXksY+HW93nUylYB1uawj958Ew2+ibKgFxxRoivvS+qdTU=
X-Received: by 2002:a17:906:f593:b0:a9a:d52:9e79 with SMTP id
 a640c23a62f3a-a9a0d529f4dmr298956466b.60.1728898870059; Mon, 14 Oct 2024
 02:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1726733624-2142-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <1726733624-2142-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <20240924155755.000069cd@Huawei.com> <CADbZ7FqUxAQFT0u7QQMuSKePRCEG2nWBzv=ECbSDGu+8WX8iAQ@mail.gmail.com>
 <20241004113933.00007ec4@Huawei.com>
In-Reply-To: <20241004113933.00007ec4@Huawei.com>
From: Shivasharan Srikanteshwara <shivasharan.srikanteshwara@broadcom.com>
Date: Mon, 14 Oct 2024 15:10:57 +0530
Message-ID: <CAOHJnDv9XK3Pno4pk9bDA1SApnJ-oYmA83EndttpiFh4=i2mMw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] PCI/portdrv: Enable reporting inter-switch P2P links
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>, linux-pci@vger.kernel.org, 
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org, logang@deltatee.com, 
	linux-kernel@vger.kernel.org, sathya.prakash@broadcom.com, 
	sjeaugey@nvidia.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000008e2fb06246ca396"

--00000000000008e2fb06246ca396
Content-Type: multipart/alternative; boundary="00000000000000d5ab06246ca3fa"

--00000000000000d5ab06246ca3fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 4:09=E2=80=AFPM Jonathan Cameron <Jonathan.Cameron@h=
uawei.com>
wrote:
>
> On Thu, 3 Oct 2024 14:41:07 -0600
> Sumanesh Samanta <sumanesh.samanta@broadcom.com> wrote:
>
> > Hi Jonathan,
> >
> > >> Need more data that 'there is a link' for this.
> > >>I'd like to see some info on bandwidth and latency.
> >
> > As you too noted in your comments, for now, we are only addressing p2p
> > connection between "virtual switches", i.e. switches that look
> > different to the host, but are actually part of the same physical
> > hardware.
> > Given that, I am not sure what we should display for bandwidth and
> > latency. There is no physical link to traverse between the virtual
> > switches, and usually we take that as "infinite" bandwidth and "zero"
> > latency.
>
> For a case where you have no information, not having attributes is
> sensible. If there is information (CXL CDAT provides this for switches
> for instance) then we should have an interface that provides space for
> that information.
>
> > As such, any number here will make little sense until we
> > start supporting p2p connection between physical switches.
>
> As above, it makes sense in a switch as well - if the information
> is available.
>
> > We could,
> > of course, have some encoding for the time being, like have "INF" for
> > bandwidth and 0 for latency, but again, those will not be very useful
> > till the day this scheme is extended to physical switch and we display
> > real values, like bandwidth and latency for a x16 PCIe link. Thoughts?
>
> Hide the sysfs attributes for latency and bandwidth if we simply don't
> know.  Software built on top of this can then assume full bandwidth
> is available or better still run some measurements to establish the
> missing data.
>
> All I really meant by this suggestion is a directory with space for
> other info is probably more extensible than a single file.

Hi Jonathan,
We will make the changes to add a directory for p2p_link related informatio=
n
to be exposed to user. We will only populate the information related to the
inter-switch P2P links. Rest of the attributes can be added for devices tha=
t
report them at a later stage.
Please check if the directory structure makes sense to you:
/sys/devices/.../B:D:F/p2p_link/links -> Reading this file will return the
same
information that is returned currently by the p2p_link file.

>
> Jonathan
>
> >
> > sincerely,
> > Sumanesh
> >
> >
> > On Tue, Sep 24, 2024 at 8:57=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Thu, 19 Sep 2024 01:13:43 -0700
> > > Shivasharan S <shivasharan.srikanteshwara@broadcom.com> wrote:
> > >
> > > > Broadcom PCI switches supports inter-switch P2P links between two
> > > > PCI-to-PCI bridges. This presents an optimal data path for data
> > > > movement. The patch exports a new sysfs entry for PCI devices that
> > > > support the inter switch P2P links and reports the B:D:F informatio=
n
> > > > of the devices that are connected through this inter switch link as
> > > > shown below:
> > > >
> > > >                              Host root bridge
> > > >                 ---------------------------------------
> > > >                 |                                     |
> > > >   NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 ---
NIC2
> > > > (2c:00.0)   (2a:00.0)                             (3d:00.0)
(40:00.0)
> > > >                 |                                     |
> > > >                GPU1                                  GPU2
> > > >             (2d:00.0)                             (3f:00.0)
> > > >                                SERVER 1
> > > >
> > > > $ find /sys/ -name "p2p_link" | xargs grep .
> > > >
/sys/devices/pci0000:29/0000:29:01.0/0000:2a:00.0/p2p_link:0000:3d:00.0
> > > >
/sys/devices/pci0000:3c/0000:3c:01.0/0000:3d:00.0/p2p_link:0000:2a:00.0
> > > >
> > > > Current support is added to report the P2P links available for
> > > > Broadcom switches based on the capability that is reported by the
> > > > upstream bridges through their vendor-specific capability registers=
.
> > > >
> > > > Signed-off-by: Shivasharan S <
shivasharan.srikanteshwara@broadcom.com>
> > > > Signed-off-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> > > > ---
> > > > Changes in v2:
> > > > Integrated the code into PCIe portdrv to create the sysfs entries
during
> > > > probe, as suggested by Mani.
> > >
> > > Hmm. So we are trying to rework portdrv in general to support
extensibility.
> > > I'm a little nervous about taking in vendor specific code in the
meantime
> > > even if it is trivial like this is.  We will be having an extensible
> > > discovery scheme but for now the plan is that will be child device
based
> > > for non PCI standard features.
> > >
> > > It is a fairly small bit of code, so maybe it is fine - I'm not keen
> > > on adding the implementation of the vendor specific parts to the
> > > main driver though. Push that to an optional c file.
> > >
> > > A few general comments inline.
> > >
> > > >
> > > >  Documentation/ABI/testing/sysfs-bus-pci |  14 +++
> > > >  drivers/pci/pcie/portdrv.c              | 131
++++++++++++++++++++++++
> > > >  drivers/pci/pcie/portdrv.h              |  10 ++
> > > >  3 files changed, 155 insertions(+)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci
b/Documentation/ABI/testing/sysfs-bus-pci
> > > > index ecf47559f495..e5d02f20655f 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > > > @@ -572,3 +572,17 @@ Description:
> > > >               enclosure-specific indications "specific0" to
"specific7",
> > > >               hence the corresponding led class devices are
unavailable if
> > > >               the DSM interface is used.
> > > > +
> > > > +What:                /sys/bus/pci/devices/.../p2p_link
> > > > +Date:                September 2024
> > > > +Contact:     Shivasharan S <shivasharan.srikanteshwara@broadcom.co=
m
>
> > > > +Description:
> > > > +             This file appears on PCIe upstream ports which
supports an
> > > > +             internal P2P link.
> > > > +             Reading this attribute will provide the list of other
upstream
> > > > +             ports on the system which have an internal P2P link
available
> > > > +             between the two ports.
> > >
> > > Given this only applies to 'internal' links and not inter switch
physical links
> > > I think you should rename it.  An eventual p2p link between physical
switches
> > > is going to be much more complex as will need routing information.
> > > Let us avoid trampling on that space.
> > >
> > > > +Users:
> > > > +             Userspace applications interested in determining a
optimal P2P
> > > > +             link for data transfers between devices connected to
the PCIe
> > > > +             switches.
> > >
> > > Need more data that 'there is a link' for this.
> > > I'd like to see some info on bandwidth and latency. I've previously
been
> > > in discussions about similar devices that provide a low latency but
low
> > > bandwidth direct path.  That gets more likely if we scale up to
> > > multiple physical switches or the software stack is choosing between
> > > multiple p2p targets (e.g. getting nearest path to a multiheaded NIC)=
.
> > >
> > > Perhaps best bet is to leave space for that by using a directory
> > > here to cover everything about p2p?  Maybe have links under there to
the
> > > other upstream ports? That might be fiddly to manage though.
> > >
> > > > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.=
c
> > > > index 6af5e0425872..c940b4b242fd 100644
> > > > --- a/drivers/pci/pcie/portdrv.c
> > > > +++ b/drivers/pci/pcie/portdrv.c
> > > > @@ -18,6 +18,7 @@
> > > >  #include <linux/string.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/aer.h>
> > > > +#include <linux/bitops.h>
> > > >
> > > >  #include "../pci.h"
> > > >  #include "portdrv.h"
> > > > @@ -37,6 +38,134 @@ struct portdrv_service_data {
> > > >       u32 service;
> > > >  };
> > > >
> > > > +/**
> > > > + * pcie_brcm_is_p2p_supported - Broadcom device specific handler
> > > > + *       to check if the upstream port supports inter switch P2P.
> > > > + *
> > > > + * @dev: PCIe upstream port to check
> > > > + *
> > > > + * This function assumes the PCIe upstream port is a Broadcom
> > > > + * PCIe device.
> > > > + */
> > > > +static bool pcie_brcm_is_p2p_supported(struct pci_dev *dev)
> > >
> > > Put this in a separate c file + use a config option and some
> > > stubs to make it go away if people don't want to support it.
> > > The layering and separation in portdrv is currently messy but
> > > we shouldn't make it worse :(
> > >
Understood. We will move the p2p_link creation code to a separate .c/.h fil=
e
.
> > > > +{
> > > > +     u64 dsn;
> > > > +     u16 vsec;
> > > > +     u32 vsec_data;
> > > > +
> > > > +     dsn =3D pci_get_dsn(dev);
> > > > +     if (!dsn) {
> > > > +             pci_dbg(dev, "DSN capability is not present\n");
> > > > +             return false;
> > > > +     }
> > >
> > > Why get the dsn (which will frequently exist on other devices)
> > > before getting the vsec which won't?  Reorder these first
> > > two checks. For most devices the match on vendor will fail in the
> > > vsec check.
> > >
This will be fixed in the next version of this patch.

> > > > +
> > > > +     vsec =3D pci_find_vsec_capability(dev, PCI_VENDOR_ID_LSI_LOGI=
C,
> > > > +                                     PCIE_BRCM_SW_P2P_VSEC_ID);
> > > > +     if (!vsec) {
> > > > +             pci_dbg(dev, "Failed to get VSEC capability\n");
> > > > +             return false;
> > > > +     }
> > > > +
> > > > +     pci_read_config_dword(dev, vsec +
PCIE_BRCM_SW_P2P_MODE_VSEC_OFFSET,
> > > > +                           &vsec_data);
> > > > +
> > > > +     pci_dbg(dev, "Serial Number: 0x%llx VSEC 0x%x\n",
> > > > +             dsn, vsec_data);
> > > > +
> > > > +     if (!PCIE_BRCM_SW_IS_SECURE_PART(dsn))
> > >
> > > Add a comment on this. Not obvious what this is checking as it's
picking
> > > a single bit out of a serial number...
> > >
Will do.
> > > > +             return false;
> > > > +
> > > > +     if (FIELD_GET(PCIE_BRCM_SW_P2P_MODE_MASK, vsec_data) !=3D
> > > > +             PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK)
> > > > +             return false;
> > > > +
> > > > +     return true;
> > >         return FIELD_GET(PCIE_BRCM_SW_P2P_MODE_MASK, vsec_data) =3D=
=3D
> > >                PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK;
> > > perhaps.
> > >
Will take care of this.
> > > > +}
> > > > +
> > > > +/**
> > > > + * Determine if device supports Inter switch P2P links.
> > > > + *
> > > > + * Return value: true if inter switch P2P is supported, return
false otherwise.
> > > > + */
> > > > +static bool pcie_port_is_p2p_supported(struct pci_dev *dev)
> > > > +{
> > > > +     /* P2P link attribute is supported on upstream ports only */
> > > > +     if (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_UPSTREAM)
> > > > +             return false;
> > > > +
> > > > +     /*
> > > > +      * Currently Broadcom PEX switches are supported.
> > > > +      */
> > > > +     if (dev->vendor =3D=3D PCI_VENDOR_ID_LSI_LOGIC &&
> > > > +         (dev->device =3D=3D PCI_DEVICE_ID_BRCM_PEX_89000_HLC ||
> > > > +          dev->device =3D=3D PCI_DEVICE_ID_BRCM_PEX_89000_LLC))
> > > > +             return pcie_brcm_is_p2p_supported(dev);
> > > > +
> > > > +     return false;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Traverse list of all PCI bridges and find devices that support
Inter switch P2P
> > > > + * and have the same serial number to create report the BDF over
sysfs.
> > > > + */
> > > > +static ssize_t p2p_link_show(struct device *dev, struct
device_attribute *attr,
> > > > +                          char *buf)
> > > > +{
> > > > +     struct pci_dev *pdev =3D to_pci_dev(dev), *pdev_link =3D NULL=
;
> > > > +     size_t len =3D 0;
> > > > +     u64 dsn, dsn_link;
> > > > +
> > > > +     dsn =3D pci_get_dsn(pdev);
> > >
> > > Maybe add a comment that we don't need to repeat checks that were don=
e
> > > to make the attribute visible. Hence dsn will exist and it will be
p2p link capable.
> > >
Will take care of this.

> > > > +
> > > > +     /* Traverse list of PCI bridges to determine any available
P2P links */
> > > > +     while ((pdev_link =3D pci_get_class(PCI_CLASS_BRIDGE_PCI << 8=
,
pdev_link))
> > >
> > > Feels like we should have a for_each_pci_bridge() similar to
for_each_pci_dev()
> > > that does this, but that is already defined to mean something else...
> > >
> > > Bjorn, is this something we should be looking to make more consistent
> > > perhaps with naming to make it clear what is a search of all instance=
s
> > > on any bus and what is a search below a particular bus?
> > >
> > > > +                     !=3D NULL) {
> > > > +             if (pdev_link =3D=3D pdev)
> > > > +                     continue;
> > > > +
> > > > +             if (!pcie_port_is_p2p_supported(pdev_link))
> > > > +                     continue;
> > > > +
> > > > +             dsn_link =3D pci_get_dsn(pdev_link);
> > > > +             if (!dsn_link)
> > > > +                     continue;
> > > > +
> > > > +             if (dsn =3D=3D dsn_link)
> > > > +                     len +=3D sysfs_emit_at(buf, len,
"%04x:%02x:%02x.%d\n",
> > > > +
 pci_domain_nr(pdev_link->bus),
> > > > +                                          pdev_link->bus->number,
PCI_SLOT(pdev_link->devfn),
> > > > +
 PCI_FUNC(pdev_link->devfn));
> > > > +     }
> > > > +
> > > > +     return len;
> > > > +}
> > >
> > >
> > > > diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.=
h
> > > > index 12c89ea0313b..1be06cb45665 100644
> > > > --- a/drivers/pci/pcie/portdrv.h
> > > > +++ b/drivers/pci/pcie/portdrv.h
> > > > @@ -25,6 +25,16 @@
> > > >
> > > >  #define PCIE_PORT_DEVICE_MAXSERVICES   5
> > > >
> > > > +/* P2P Link supported device IDs */
> > > > +#define PCI_DEVICE_ID_BRCM_PEX_89000_HLC     0xC030
> > > > +#define PCI_DEVICE_ID_BRCM_PEX_89000_LLC     0xC034
> > > > +
> > > > +#define PCIE_BRCM_SW_P2P_VSEC_ID             0x1
> > > > +#define PCIE_BRCM_SW_P2P_MODE_VSEC_OFFSET    0xC
> > > > +#define PCIE_BRCM_SW_P2P_MODE_MASK           GENMASK(9, 8)
> > > > +#define PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK  0x2
> > > > +#define PCIE_BRCM_SW_IS_SECURE_PART(dsn)     ((dsn) & 0x8)
> > > Define the mask, and use FIELD_GET() to get that.
Will take care of this.

Best Regards,
Shivasharan

> > > > +
> > > >  extern bool pcie_ports_dpc_native;
> > > >
> > > >  #ifdef CONFIG_PCIEAER
> > >
> >
>

--00000000000000d5ab06246ca3fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Oct 4, 2024 at 4:09=E2=80=AFPM Jonathan Ca=
meron &lt;<a href=3D"mailto:Jonathan.Cameron@huawei.com">Jonathan.Cameron@h=
uawei.com</a>&gt; wrote:<br>&gt;<br>&gt; On Thu, 3 Oct 2024 14:41:07 -0600<=
br>&gt; Sumanesh Samanta &lt;<a href=3D"mailto:sumanesh.samanta@broadcom.co=
m">sumanesh.samanta@broadcom.com</a>&gt; wrote:<br>&gt;<br>&gt; &gt; Hi Jon=
athan,<br>&gt; &gt;<br>&gt; &gt; &gt;&gt; Need more data that &#39;there is=
 a link&#39; for this.<br>&gt; &gt; &gt;&gt;I&#39;d like to see some info o=
n bandwidth and latency. <br>&gt; &gt;<br>&gt; &gt; As you too noted in you=
r comments, for now, we are only addressing p2p<br>&gt; &gt; connection bet=
ween &quot;virtual switches&quot;, i.e. switches that look<br>&gt; &gt; dif=
ferent to the host, but are actually part of the same physical<br>&gt; &gt;=
 hardware.<br>&gt; &gt; Given that, I am not sure what we should display fo=
r bandwidth and<br>&gt; &gt; latency. There is no physical link to traverse=
 between the virtual<br>&gt; &gt; switches, and usually we take that as &qu=
ot;infinite&quot; bandwidth and &quot;zero&quot;<br>&gt; &gt; latency.<br>&=
gt;<br>&gt; For a case where you have no information, not having attributes=
 is<br>&gt; sensible. If there is information (CXL CDAT provides this for s=
witches<br>&gt; for instance) then we should have an interface that provide=
s space for<br>&gt; that information.<br>&gt;<br>&gt; &gt; As such, any num=
ber here will make little sense until we<br>&gt; &gt; start supporting p2p =
connection between physical switches.<br>&gt;<br>&gt; As above, it makes se=
nse in a switch as well - if the information<br>&gt; is available.<br>&gt;<=
br>&gt; &gt; We could,<br>&gt; &gt; of course, have some encoding for the t=
ime being, like have &quot;INF&quot; for<br>&gt; &gt; bandwidth and 0 for l=
atency, but again, those will not be very useful<br>&gt; &gt; till the day =
this scheme is extended to physical switch and we display<br>&gt; &gt; real=
 values, like bandwidth and latency for a x16 PCIe link. Thoughts?<br>&gt;<=
br>&gt; Hide the sysfs attributes for latency and bandwidth if we simply do=
n&#39;t<br>&gt; know.=C2=A0 Software built on top of this can then assume f=
ull bandwidth<br>&gt; is available or better still run some measurements to=
 establish the<br>&gt; missing data.<br>&gt;<br>&gt; All I really meant by =
this suggestion is a directory with space for<br>&gt; other info is probabl=
y more extensible than a single file.<div><br></div><div><div class=3D"gmai=
l_default" style=3D"font-family:arial,helvetica,sans-serif">Hi Jonathan,</d=
iv><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-s=
erif">We will make the changes to add a directory for p2p_link related info=
rmation</div><div class=3D"gmail_default" style=3D"font-family:arial,helvet=
ica,sans-serif">to be exposed to user. We will only populate the informatio=
n related to the</div><div class=3D"gmail_default" style=3D"font-family:ari=
al,helvetica,sans-serif">inter-switch P2P links. Rest of the attributes can=
 be added for devices that</div><div class=3D"gmail_default" style=3D"font-=
family:arial,helvetica,sans-serif">report them at a later stage.</div><div =
class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Pl=
ease check if the directory structure makes sense to you:</div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><span s=
tyle=3D"background-color:transparent;color:rgb(0,0,0);font-family:Arial,san=
s-serif;font-size:11pt">/sys/devices/.../B:D:F/p2p_link/links</span>=C2=A0-=
&gt; Reading this file will return the same</div><div class=3D"gmail_defaul=
t" style=3D"font-family:arial,helvetica,sans-serif">information that is ret=
urned currently by the p2p_link file.=C2=A0</div><div class=3D"gmail_defaul=
t" style=3D"font-family:arial,helvetica,sans-serif"><br></div>&gt;<br>&gt; =
Jonathan<br>&gt;<br>&gt; &gt;<br>&gt; &gt; sincerely,<br>&gt; &gt; Sumanesh=
<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; On Tue, Sep 24, 2024 at 8:57=E2=80=
=AFAM Jonathan Cameron<br>&gt; &gt; &lt;<a href=3D"mailto:Jonathan.Cameron@=
huawei.com">Jonathan.Cameron@huawei.com</a>&gt; wrote:<br>&gt; &gt; &gt;<br=
>&gt; &gt; &gt; On Thu, 19 Sep 2024 01:13:43 -0700<br>&gt; &gt; &gt; Shivas=
haran S &lt;<a href=3D"mailto:shivasharan.srikanteshwara@broadcom.com">shiv=
asharan.srikanteshwara@broadcom.com</a>&gt; wrote:<br>&gt; &gt; &gt; <br>&g=
t; &gt; &gt; &gt; Broadcom PCI switches supports inter-switch P2P links bet=
ween two<br>&gt; &gt; &gt; &gt; PCI-to-PCI bridges. This presents an optima=
l data path for data<br>&gt; &gt; &gt; &gt; movement. The patch exports a n=
ew sysfs entry for PCI devices that<br>&gt; &gt; &gt; &gt; support the inte=
r switch P2P links and reports the B:D:F information<br>&gt; &gt; &gt; &gt;=
 of the devices that are connected through this inter switch link as<br>&gt=
; &gt; &gt; &gt; shown below:<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt;=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Host root bridge<br>&gt; &gt; &gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ----------------------=
-----------------<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |<br>&gt; &gt; &gt; &gt; =C2=A0 NIC1 --- PCI Switch1 --- Inter-switch l=
ink --- PCI Switch2 --- NIC2<br>&gt; &gt; &gt; &gt; (2c:00.0) =C2=A0 (2a:00=
.0) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (3d:00.0) =C2=A0 (40:00.0)<br>&gt; &gt; &gt; &g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPU1 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0GPU2<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (2d:00.0) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (3f:00.0)<br>&gt; &gt; &gt=
; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SERVER 1<br>&gt; &gt; &gt; &gt=
;<br>&gt; &gt; &gt; &gt; $ find /sys/ -name &quot;p2p_link&quot; | xargs gr=
ep .<br>&gt; &gt; &gt; &gt; <span class=3D"gmail_default" style=3D"font-fam=
ily:arial,helvetica,sans-serif"></span>/sys/devices/pci0000:29/0000:29:01.0=
/0000:2a:00.0/p2p_link:0000:3d:00.0<br>&gt; &gt; &gt; &gt; /sys/devices/pci=
0000:3c/0000:3c:01.0/0000:3d:00.0/p2p_link:0000:2a:00.0<br>&gt; &gt; &gt; &=
gt;<br>&gt; &gt; &gt; &gt; Current support is added to report the P2P links=
 available for<br>&gt; &gt; &gt; &gt; Broadcom switches based on the capabi=
lity that is reported by the<br>&gt; &gt; &gt; &gt; upstream bridges throug=
h their vendor-specific capability registers.<br>&gt; &gt; &gt; &gt;<br>&gt=
; &gt; &gt; &gt; Signed-off-by: Shivasharan S &lt;<a href=3D"mailto:shivash=
aran.srikanteshwara@broadcom.com">shivasharan.srikanteshwara@broadcom.com</=
a>&gt;<br>&gt; &gt; &gt; &gt; Signed-off-by: Sumanesh Samanta &lt;<a href=
=3D"mailto:sumanesh.samanta@broadcom.com">sumanesh.samanta@broadcom.com</a>=
&gt;<br>&gt; &gt; &gt; &gt; ---<br>&gt; &gt; &gt; &gt; Changes in v2:<br>&g=
t; &gt; &gt; &gt; Integrated the code into PCIe portdrv to create the sysfs=
 entries during<br>&gt; &gt; &gt; &gt; probe, as suggested by Mani. <br>&gt=
; &gt; &gt;<br>&gt; &gt; &gt; Hmm. So we are trying to rework portdrv in ge=
neral to support extensibility.<br>&gt; &gt; &gt; I&#39;m a little nervous =
about taking in vendor specific code in the meantime<br>&gt; &gt; &gt; even=
 if it is trivial like this is.=C2=A0 We will be having an extensible<br>&g=
t; &gt; &gt; discovery scheme but for now the plan is that will be child de=
vice based<br>&gt; &gt; &gt; for non PCI standard features.<br>&gt; &gt; &g=
t;<br>&gt; &gt; &gt; It is a fairly small bit of code, so maybe it is fine =
- I&#39;m not keen<br>&gt; &gt; &gt; on adding the implementation of the ve=
ndor specific parts to the<br>&gt; &gt; &gt; main driver though. Push that =
to an optional c file.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; A few general co=
mments inline.<br>&gt; &gt; &gt; <br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; =
&gt; =C2=A0Documentation/ABI/testing/sysfs-bus-pci | =C2=A014 +++<br>&gt; &=
gt; &gt; &gt; =C2=A0drivers/pci/pcie/portdrv.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 131 ++++++++++++++++++++++++<br>&gt; &gt; &gt; &gt; =
=C2=A0drivers/pci/pcie/portdrv.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A010 ++<br>&gt; &gt; &gt; &gt; =C2=A03 files changed, 155 inser=
tions(+)<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; diff --git a/Documen=
tation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci<=
br>&gt; &gt; &gt; &gt; index ecf47559f495..e5d02f20655f 100644<br>&gt; &gt;=
 &gt; &gt; --- a/Documentation/ABI/testing/sysfs-bus-pci<br>&gt; &gt; &gt; =
&gt; +++ b/Documentation/ABI/testing/sysfs-bus-pci<br>&gt; &gt; &gt; &gt; @=
@ -572,3 +572,17 @@ Description:<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enclosure-specific indications &quot;specif=
ic0&quot; to &quot;specific7&quot;,<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hence the corresponding led class device=
s are unavailable if<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 the DSM interface is used.<br>&gt; &gt; &gt; &gt; +<br>&g=
t; &gt; &gt; &gt; +What: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/sys/bus/pci/devices/.../p2p_link<br>&gt; &gt; &gt; &gt; +Date: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0September 2024<br>&gt; =
&gt; &gt; &gt; +Contact: =C2=A0 =C2=A0 Shivasharan S &lt;<a href=3D"mailto:=
shivasharan.srikanteshwara@broadcom.com">shivasharan.srikanteshwara@broadco=
m.com</a>&gt;<br>&gt; &gt; &gt; &gt; +Description:<br>&gt; &gt; &gt; &gt; +=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 This file appears on PCIe upstre=
am ports which supports an<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 internal P2P link.<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Reading this attribute will provide the lis=
t of other upstream<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ports on the system which have an internal P2P link available=
<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 between=
 the two ports. <br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Given this only applie=
s to &#39;internal&#39; links and not inter switch physical links<br>&gt; &=
gt; &gt; I think you should rename it.=C2=A0 An eventual p2p link between p=
hysical switches<br>&gt; &gt; &gt; is going to be much more complex as will=
 need routing information.<br>&gt; &gt; &gt; Let us avoid trampling on that=
 space.<br>&gt; &gt; &gt; <br>&gt; &gt; &gt; &gt; +Users:<br>&gt; &gt; &gt;=
 &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Userspace applications in=
terested in determining a optimal P2P<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link for data transfers between devices con=
nected to the PCIe<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 switches. <br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Need more data th=
at &#39;there is a link&#39; for this.<br>&gt; &gt; &gt; I&#39;d like to se=
e some info on bandwidth and latency. I&#39;ve previously been<br>&gt; &gt;=
 &gt; in discussions about similar devices that provide a low latency but l=
ow<br>&gt; &gt; &gt; bandwidth direct path.=C2=A0 That gets more likely if =
we scale up to<br>&gt; &gt; &gt; multiple physical switches or the software=
 stack is choosing between<br>&gt; &gt; &gt; multiple p2p targets (e.g. get=
ting nearest path to a multiheaded NIC).<br>&gt; &gt; &gt;<br>&gt; &gt; &gt=
; Perhaps best bet is to leave space for that by using a directory<br>&gt; =
&gt; &gt; here to cover everything about p2p?=C2=A0 Maybe have links under =
there to the<br>&gt; &gt; &gt; other upstream ports? That might be fiddly t=
o manage though.<br>&gt; &gt; &gt; <br>&gt; &gt; &gt; &gt; diff --git a/dri=
vers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c<br>&gt; &gt; &gt; &gt;=
 index 6af5e0425872..c940b4b242fd 100644<br>&gt; &gt; &gt; &gt; --- a/drive=
rs/pci/pcie/portdrv.c<br>&gt; &gt; &gt; &gt; +++ b/drivers/pci/pcie/portdrv=
.c<br>&gt; &gt; &gt; &gt; @@ -18,6 +18,7 @@<br>&gt; &gt; &gt; &gt; =C2=A0#i=
nclude &lt;linux/string.h&gt;<br>&gt; &gt; &gt; &gt; =C2=A0#include &lt;lin=
ux/slab.h&gt;<br>&gt; &gt; &gt; &gt; =C2=A0#include &lt;linux/aer.h&gt;<br>=
&gt; &gt; &gt; &gt; +#include &lt;linux/bitops.h&gt;<br>&gt; &gt; &gt; &gt;=
<br>&gt; &gt; &gt; &gt; =C2=A0#include &quot;../pci.h&quot;<br>&gt; &gt; &g=
t; &gt; =C2=A0#include &quot;portdrv.h&quot;<br>&gt; &gt; &gt; &gt; @@ -37,=
6 +38,134 @@ struct portdrv_service_data {<br>&gt; &gt; &gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 u32 service;<br>&gt; &gt; &gt; &gt; =C2=A0};<br>&gt; &gt; &gt=
; &gt;<br>&gt; &gt; &gt; &gt; +/**<br>&gt; &gt; &gt; &gt; + * pcie_brcm_is_=
p2p_supported - Broadcom device specific handler<br>&gt; &gt; &gt; &gt; + *=
 =C2=A0 =C2=A0 =C2=A0 to check if the upstream port supports inter switch P=
2P.<br>&gt; &gt; &gt; &gt; + *<br>&gt; &gt; &gt; &gt; + * @dev: PCIe upstre=
am port to check<br>&gt; &gt; &gt; &gt; + *<br>&gt; &gt; &gt; &gt; + * This=
 function assumes the PCIe upstream port is a Broadcom<br>&gt; &gt; &gt; &g=
t; + * PCIe device.<br>&gt; &gt; &gt; &gt; + */<br>&gt; &gt; &gt; &gt; +sta=
tic bool pcie_brcm_is_p2p_supported(struct pci_dev *dev) <br>&gt; &gt; &gt;=
<br>&gt; &gt; &gt; Put this in a separate c file + use a config option and =
some<br>&gt; &gt; &gt; stubs to make it go away if people don&#39;t want to=
 support it.<br>&gt; &gt; &gt; The layering and separation in portdrv is cu=
rrently messy but<br>&gt; &gt; &gt; we shouldn&#39;t make it worse :(<br>&g=
t; &gt; &gt;</div><div><span class=3D"gmail_default" style=3D"font-family:a=
rial,helvetica,sans-serif">Understood. We will move the p2p_link creation c=
ode to a separate .c/.h file</span><span class=3D"gmail_default" style=3D"f=
ont-family:arial,helvetica,sans-serif">.</span></div><div class=3D"gmail_de=
fault" style=3D"font-family:arial,helvetica,sans-serif"></div><div>&gt; &gt=
; &gt; &gt; +{<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 u64 dsn;<br>&gt; &gt;=
 &gt; &gt; + =C2=A0 =C2=A0 u16 vsec;<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0=
 u32 vsec_data;<br>&gt; &gt; &gt; &gt; +<br>&gt; &gt; &gt; &gt; + =C2=A0 =
=C2=A0 dsn =3D pci_get_dsn(dev);<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 if =
(!dsn) {<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 pci_dbg(dev, &quot;DSN capability is not present\n&quot;);<br>&gt; &gt; &g=
t; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>&gt; &=
gt; &gt; &gt; + =C2=A0 =C2=A0 } <br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Why ge=
t the dsn (which will frequently exist on other devices)<br>&gt; &gt; &gt; =
before getting the vsec which won&#39;t?=C2=A0 Reorder these first<br>&gt; =
&gt; &gt; two checks. For most devices the match on vendor will fail in the=
<br>&gt; &gt; &gt; vsec check.<br>&gt; &gt; &gt;</div><div><span class=3D"g=
mail_default" style=3D"font-family:arial,helvetica,sans-serif">This will be=
 fixed in the next version of this patch.</span></div><div>=C2=A0=C2=A0<br>=
&gt; &gt; &gt; &gt; +<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 vsec =3D pci_f=
ind_vsec_capability(dev, PCI_VENDOR_ID_LSI_LOGIC,<br>&gt; &gt; &gt; &gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PCIE_BRCM_SW_P2P_VSEC_=
ID);<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 if (!vsec) {<br>&gt; &gt; &gt; =
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_dbg(dev, &quot;Failed =
to get VSEC capability\n&quot;);<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=
=A0 }<br>&gt; &gt; &gt; &gt; +<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 pci_r=
ead_config_dword(dev, vsec + PCIE_BRCM_SW_P2P_MODE_VSEC_OFFSET,<br>&gt; &gt=
; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;vsec_data);<br>&gt; &gt; &gt; &gt; +<b=
r>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 pci_dbg(dev, &quot;Serial Number: 0x%=
llx VSEC 0x%x\n&quot;,<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 dsn, vsec_data);<br>&gt; &gt; &gt; &gt; +<br>&gt; &gt; &gt; =
&gt; + =C2=A0 =C2=A0 if (!PCIE_BRCM_SW_IS_SECURE_PART(dsn)) <br>&gt; &gt; &=
gt;<br>&gt; &gt; &gt; Add a comment on this. Not obvious what this is check=
ing as it&#39;s picking<br>&gt; &gt; &gt; a single bit out of a serial numb=
er...<br>&gt; &gt; &gt;</div><div><span class=3D"gmail_default" style=3D"fo=
nt-family:arial,helvetica,sans-serif">Will do.</span>=C2=A0 <br>&gt; &gt; &=
gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>&gt; =
&gt; &gt; &gt; +<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 if (FIELD_GET(PCIE_=
BRCM_SW_P2P_MODE_MASK, vsec_data) !=3D<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK)<br>&gt=
; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<=
br>&gt; &gt; &gt; &gt; +<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 return true=
; <br>&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FIELD_GET(PCIE_BRCM=
_SW_P2P_MODE_MASK, vsec_data) =3D=3D<br>&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK;<br>=
&gt; &gt; &gt; perhaps.<br>&gt; &gt; &gt;<span class=3D"gmail_default" styl=
e=3D"font-family:arial,helvetica,sans-serif"></span></div><div><span class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Will ta=
ke care of this.</span><br>&gt; &gt; &gt; &gt; +}<br>&gt; &gt; &gt; &gt; +<=
br>&gt; &gt; &gt; &gt; +/**<br>&gt; &gt; &gt; &gt; + * Determine if device =
supports Inter switch P2P links.<br>&gt; &gt; &gt; &gt; + *<br>&gt; &gt; &g=
t; &gt; + * Return value: true if inter switch P2P is supported, return fal=
se otherwise.<br>&gt; &gt; &gt; &gt; + */<br>&gt; &gt; &gt; &gt; +static bo=
ol pcie_port_is_p2p_supported(struct pci_dev *dev)<br>&gt; &gt; &gt; &gt; +=
{<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 /* P2P link attribute is supported=
 on upstream ports only */<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 if (pci_p=
cie_type(dev) !=3D PCI_EXP_TYPE_UPSTREAM)<br>&gt; &gt; &gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>&gt; &gt; &gt; &gt; +<b=
r>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 /*<br>&gt; &gt; &gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0* Currently Broadcom PEX switches are supported.<br>&gt; &gt; =
&gt; &gt; + =C2=A0 =C2=A0 =C2=A0*/<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 i=
f (dev-&gt;vendor =3D=3D PCI_VENDOR_ID_LSI_LOGIC &amp;&amp;<br>&gt; &gt; &g=
t; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dev-&gt;device =3D=3D PCI_DEVICE_ID_=
BRCM_PEX_89000_HLC ||<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0dev-&gt;device =3D=3D PCI_DEVICE_ID_BRCM_PEX_89000_LLC))<br>&gt; &gt;=
 &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return pcie_brcm_is_=
p2p_supported(dev);<br>&gt; &gt; &gt; &gt; +<br>&gt; &gt; &gt; &gt; + =C2=
=A0 =C2=A0 return false;<br>&gt; &gt; &gt; &gt; +}<br>&gt; &gt; &gt; &gt; +=
<br>&gt; &gt; &gt; &gt; +/*<br>&gt; &gt; &gt; &gt; + * Traverse list of all=
 PCI bridges and find devices that support Inter switch P2P<br>&gt; &gt; &g=
t; &gt; + * and have the same serial number to create report the BDF over s=
ysfs.<br>&gt; &gt; &gt; &gt; + */<br>&gt; &gt; &gt; &gt; +static ssize_t p2=
p_link_show(struct device *dev, struct device_attribute *attr,<br>&gt; &gt;=
 &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf)<br>&gt; &gt; &gt; &gt; +{<br>&gt; &g=
t; &gt; &gt; + =C2=A0 =C2=A0 struct pci_dev *pdev =3D to_pci_dev(dev), *pde=
v_link =3D NULL;<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 size_t len =3D 0;<b=
r>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 u64 dsn, dsn_link;<br>&gt; &gt; &gt; =
&gt; +<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 dsn =3D pci_get_dsn(pdev); <b=
r>&gt; &gt; &gt;<br>&gt; &gt; &gt; Maybe add a comment that we don&#39;t ne=
ed to repeat checks that were done<br>&gt; &gt; &gt; to make the attribute =
visible. Hence dsn will exist and it will be p2p link capable.<br>&gt; &gt;=
 &gt;</div><div><span style=3D"font-family:arial,helvetica,sans-serif">Will=
 take care of this.</span><br></div><div><br></div><div>&gt; &gt; &gt; &gt;=
 +<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 /* Traverse list of PCI bridges t=
o determine any available P2P links */<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=
=A0 while ((pdev_link =3D pci_get_class(PCI_CLASS_BRIDGE_PCI &lt;&lt; 8, pd=
ev_link)) <br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Feels like we should have a =
for_each_pci_bridge() similar to for_each_pci_dev()<br>&gt; &gt; &gt; that =
does this, but that is already defined to mean something else...<br>&gt; &g=
t; &gt;<br>&gt; &gt; &gt; Bjorn, is this something we should be looking to =
make more consistent<br>&gt; &gt; &gt; perhaps with naming to make it clear=
 what is a search of all instances<br>&gt; &gt; &gt; on any bus and what is=
 a search below a particular bus?<br>&gt; &gt; &gt;=C2=A0=C2=A0</div><div>&=
gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 !=3D NULL) {<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (pdev_link =3D=3D pdev)<br>&gt; &gt; &gt; &gt; =
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 con=
tinue;<br>&gt; &gt; &gt; &gt; +<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (!pcie_port_is_p2p_supported(pdev_link))<br>&gt=
; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 continue;<br>&gt; &gt; &gt; &gt; +<br>&gt; &gt; &gt; &gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dsn_link =3D pci_get_dsn(pdev_lin=
k);<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
!dsn_link)<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>&gt; &gt; &gt; &gt; +<br>&gt; =
&gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dsn =3D=3D d=
sn_link)<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D sysfs_emit_at(buf, len, &quot;%04x:%0=
2x:%02x.%d\n&quot;,<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_domain_nr(pdev_link-&gt;bu=
s),<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0pdev_link-&gt;bus-&gt;number, PCI_SLOT(pdev_link=
-&gt;devfn),<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_FUNC(pdev_link-&gt;devfn));<br>&g=
t; &gt; &gt; &gt; + =C2=A0 =C2=A0 }<br>&gt; &gt; &gt; &gt; +<br>&gt; &gt; &=
gt; &gt; + =C2=A0 =C2=A0 return len;<br>&gt; &gt; &gt; &gt; +} <br>&gt; &gt=
; &gt;<br>&gt; &gt; &gt; <br>&gt; &gt; &gt; &gt; diff --git a/drivers/pci/p=
cie/portdrv.h b/drivers/pci/pcie/portdrv.h<br>&gt; &gt; &gt; &gt; index 12c=
89ea0313b..1be06cb45665 100644<br>&gt; &gt; &gt; &gt; --- a/drivers/pci/pci=
e/portdrv.h<br>&gt; &gt; &gt; &gt; +++ b/drivers/pci/pcie/portdrv.h<br>&gt;=
 &gt; &gt; &gt; @@ -25,6 +25,16 @@<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt;=
 &gt; =C2=A0#define PCIE_PORT_DEVICE_MAXSERVICES =C2=A0 5<br>&gt; &gt; &gt;=
 &gt;<br>&gt; &gt; &gt; &gt; +/* P2P Link supported device IDs */<br>&gt; &=
gt; &gt; &gt; +#define PCI_DEVICE_ID_BRCM_PEX_89000_HLC =C2=A0 =C2=A0 0xC03=
0<br>&gt; &gt; &gt; &gt; +#define PCI_DEVICE_ID_BRCM_PEX_89000_LLC =C2=A0 =
=C2=A0 0xC034<br>&gt; &gt; &gt; &gt; +<br>&gt; &gt; &gt; &gt; +#define PCIE=
_BRCM_SW_P2P_VSEC_ID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1<br>&gt; =
&gt; &gt; &gt; +#define PCIE_BRCM_SW_P2P_MODE_VSEC_OFFSET =C2=A0 =C2=A00xC<=
br>&gt; &gt; &gt; &gt; +#define PCIE_BRCM_SW_P2P_MODE_MASK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 GENMASK(9, 8)<br>&gt; &gt; &gt; &gt; +#define PCIE_BRC=
M_SW_P2P_MODE_INTER_SW_LINK =C2=A00x2<br>&gt; &gt; &gt; &gt; +#define PCIE_=
BRCM_SW_IS_SECURE_PART(dsn) =C2=A0 =C2=A0 ((dsn) &amp; 0x8) <br>&gt; &gt; &=
gt; Define the mask, and use FIELD_GET() to get that.</div><div><span class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"></span>=
</div><div><span style=3D"font-family:arial,helvetica,sans-serif">Will take=
 care of this.</span></div><div><span style=3D"font-family:arial,helvetica,=
sans-serif"><br></span></div><div>B<span class=3D"gmail_default" style=3D"f=
ont-family:arial,helvetica,sans-serif">est Regards,</span></div><div><span =
class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Sh=
ivasharan</span></div><div><span class=3D"gmail_default" style=3D"font-fami=
ly:arial,helvetica,sans-serif"><br></span></div><div>&gt; &gt; &gt; &gt; +<=
br>&gt; &gt; &gt; &gt; =C2=A0extern bool pcie_ports_dpc_native;<br>&gt; &gt=
; &gt; &gt;<br>&gt; &gt; &gt; &gt; =C2=A0#ifdef CONFIG_PCIEAER <br>&gt; &gt=
; &gt; <br>&gt; &gt;<br>&gt;<br></div></div>

--00000000000000d5ab06246ca3fa--

--00000000000008e2fb06246ca396
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
XzCCBXYwggReoAMCAQICDFr9U6igf1QRzoaH1TANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTMyNDhaFw0yNTA5MTAwOTMyNDhaMIGq
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xIzAhBgNVBAMTGlNoaXZhc2hhcmFuIFNyaWthbnRlc2h3YXJh
MTYwNAYJKoZIhvcNAQkBFidzaGl2YXNoYXJhbi5zcmlrYW50ZXNod2FyYUBicm9hZGNvbS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDulAFNbtc+tsB1JubfhUwbq5745iWy0PqA
tUlf8OsSpnKZPtpZ/P9TJL8MrXyDJN5GdKeVAvh1YAvXb2S0i90gW5qWZtFQ4MRMQwXKHvwdVCTj
NBVuju4wvuIk8TWSSWryDIa/KUmQEFgRethHXcwAGKVM2LV19E+RJxjbqcqBXqT20XVYJ+86q3gC
pKeDdMqs49aS4NkFAulUXfKMvwayi1/al6l6H6NjkYI9V+VAhd2Pw5dVGT1UGNnGenU1ASxrICxB
p1may//a5w+WwgjNTKaKkyc6n0c4ds/TIbS/qi/G87n1VXSpcJHiebcJy8WZCbvo6g9j0Ipsx9mZ
ZyjVAgMBAAGjggHoMIIB5DAOBgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsG
AQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29t
L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRME
AjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3Bl
cnNvbmFsc2lnbjJjYTIwMjAuY3JsMDIGA1UdEQQrMCmBJ3NoaXZhc2hhcmFuLnNyaWthbnRlc2h3
YXJhQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdb
NHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUOXk95+zAtIGGWGU9q37iyIJKcYMwDQYJKoZIhvcNAQEL
BQADggEBABd5fRmxw/2mYuimst/fZaHYCHDoiYauRKIOm2YcV+s/4xhvXJx0fFit4LzpW8EgTXQv
GQCCaJeSArd/ad3NUOhuQtVB5xOO5cHcCYpdb9gvRPzSZss4mN5OrQsOD6iH0lyg9zIQfhReghMc
Y0C0m8ndFGSil396kqXLgxfPWJ8LChptV9z3iLmGoxJa/gqhi4xu+Ql3ZcQqcP6YItbGOmGjXF/p
uwxVuxQ2ZLaLPPZF5H6t1UPCJRYZXbcjPQHXqFTijI0/1PIUtJy3gUmAsxZe+1n/rCqqCHE4rM+q
Xm1kxB5u/2AMUovVed0IK1+1PFQLP47vY8PfDbSkU4UXH0YxggJtMIICaQIBATBrMFsxCzAJBgNV
BAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdD
QyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxa/VOooH9UEc6Gh9UwDQYJYIZIAWUDBAIBBQCg
gdQwLwYJKoZIhvcNAQkEMSIEIP4Weusp9nY7UITg6XzophVtqwfi7/DWxMbZnOhgHT7XMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAxNDA5NDExMFowaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAmBo1K4Q7OHLWFN7GgFLdq9U/IbNNy1hE7gZI4wkq6gwk5PO143hQz0Ts1hf1ykMViOiNf
Lpur46clUmf+jgEmFbWlJsSDey2YP1ZtRteC2JMOQYRhlAKfdjTZD4kTI/TbxtZ2srIbsINbKDP3
pvCCesLN7R/if3oE9yGV9QObn+RI3haIedSqjrlj6pdnjzd49ygLCfMESnzhYDFFA7vYERJhrFuL
Kny4x3pdI5QI36yYeQosw9oVsYqtfLzeZVuerkmtQ5+iXjZWCUvM+CasNIqO8bsS4N03ukkpD2oH
LqZtojhzLlVxzvOqb/YpECE/LwYJnJDRUTrulPSbtWdQ
--00000000000008e2fb06246ca396--

