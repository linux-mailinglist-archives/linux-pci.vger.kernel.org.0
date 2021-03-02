Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5816432B274
	for <lists+linux-pci@lfdr.de>; Wed,  3 Mar 2021 04:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242988AbhCCB6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Mar 2021 20:58:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1574551AbhCBUAN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Mar 2021 15:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614715123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TH/kVYUdvKj/aImEpFveijQAwn4b77rjoVCorE44qS8=;
        b=hToiE/UwhOh9fRCC4KfZKgW/9bQ8e1ZV3yA0ZPiCRg8tC0YoKVW79LyOLue9geO4eFDoHy
        9MBVq5FWIkwvoO2TPHqBkYx4mKO/sO9VViLzD89dOK6aTHcJNQX7be95e8OB5RROC+eB9u
        6dcqBgKwy5O3Jf69iuw5dviHVdsQicA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-I2eNvxwCPqGyrPIX8ok5BQ-1; Tue, 02 Mar 2021 14:58:32 -0500
X-MC-Unique: I2eNvxwCPqGyrPIX8ok5BQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23AFC1005501;
        Tue,  2 Mar 2021 19:58:31 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com [10.3.112.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5542119712;
        Tue,  2 Mar 2021 19:58:30 +0000 (UTC)
Date:   Tue, 2 Mar 2021 12:58:29 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede02@gmail.com>
Subject: Re: RFC: sysfs node for Secondary PCI bus reset (PCIe Hot Reset)
Message-ID: <20210302125829.216784cd@omen.home.shazbot.org>
In-Reply-To: <20210301202817.GA201451@bjorn-Precision-5520>
References: <20210301171221.3d42a55i7h5ubqsb@pali>
        <20210301202817.GA201451@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 1 Mar 2021 14:28:17 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex, reset expert]
>=20
> On Mon, Mar 01, 2021 at 06:12:21PM +0100, Pali Roh=C3=A1r wrote:
> > Hello!
> >=20
> > PCIe card can be reset via in-band Hot Reset signal which can be
> > triggered by PCIe bridge via Secondary Bus Reset bit in PCI config
> > space.
> >=20
> > Kernel already exports sysfs node "reset" for triggering Functional
> > Reset of particular function of PCI device. But in some cases Functional
> > Reset is not enough and Hot Reset is required.
> >=20
> > Following RFC patch exports sysfs node "reset_bus" for PCI bridges which
> > triggers Secondary Bus Reset and therefore for PCIe bridges it resets
> > connected PCIe card.
> >=20
> > What do you think about it?
> >=20
> > Currently there is userspace script which can trigger PCIe Hot Reset by
> > modifying PCI config space from userspace:
> >=20
> > https://alexforencich.com/wiki/en/pcie/hot-reset-linux
> >=20
> > But because kernel already provides way how to trigger Functional Reset
> > it could provide also way how to trigger PCIe Hot Reset.

What that script does and what this does, or what the existing reset
attribute does, are very different.  The script finds the upstream
bridge for a given device, removes the device (ignoring that more than
one device might be affected by the bus reset), uses setpci to trigger
a secondary bus reset, then rescans devices.  The below only triggers
the secondary bus reset, neither saving and restoring affected device
state like the existing function level reset attribute, nor removing
and rescanning as the script does.  It simply leaves an entire
hierarchy of PCI devices entirely un-programmed yet still has struct
pci_devs attached to them for untold future misery.

In fact, for the case of a single device affected by the bus reset, as
intended by the script, the existing reset attribute will already do
that if the device supports no other reset mechanism.  There's actually
a running LFX mentorship project that aims to allow the user to control
the type of reset performed by the existing reset attribute such that a
user could force the bus reset behavior over other reset methods.

There might be some justification for an attribute that actually
implements the referenced script correctly, perhaps in kernel we could
avoid races with bus rescans, but simply triggering an SBR to quietly
de-program all downstream devices with no state restore or device
rescan is not it.  Any affected device would be unusable.  Was this
tested?  Thanks,

Alex

> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 50fcb62d59b5..f5e11c589498 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1321,6 +1321,30 @@ static ssize_t reset_store(struct device *dev, s=
truct device_attribute *attr,
> > =20
> >  static DEVICE_ATTR(reset, 0200, NULL, reset_store);
> > =20
> > +static ssize_t reset_bus_store(struct device *dev, struct device_attri=
bute *attr,
> > +			       const char *buf, size_t count)
> > +{
> > +	struct pci_dev *pdev =3D to_pci_dev(dev);
> > +	unsigned long val;
> > +	ssize_t result =3D kstrtoul(buf, 0, &val);
> > +
> > +	if (result < 0)
> > +		return result;
> > +
> > +	if (val !=3D 1)
> > +		return -EINVAL;
> > +
> > +	pm_runtime_get_sync(dev);
> > +	result =3D pci_bridge_secondary_bus_reset(pdev);
> > +	pm_runtime_put(dev);
> > +	if (result < 0)
> > +		return result;
> > +
> > +	return count;
> > +}
> > +
> > +static DEVICE_ATTR(reset_bus, 0200, NULL, reset_bus_store);
> > +
> >  static int pci_create_capabilities_sysfs(struct pci_dev *dev)
> >  {
> >  	int retval;
> > @@ -1332,8 +1356,15 @@ static int pci_create_capabilities_sysfs(struct =
pci_dev *dev)
> >  		if (retval)
> >  			goto error;
> >  	}
> > +	if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> > +		retval =3D device_create_file(&dev->dev, &dev_attr_reset_bus);
> > +		if (retval)
> > +			goto error_reset_bus;
> > +	}
> >  	return 0;
> > =20
> > +error_reset_bus:
> > +	device_remove_file(&dev->dev, &dev_attr_reset);
> >  error:
> >  	pcie_vpd_remove_sysfs_dev_files(dev);
> >  	return retval;
> > @@ -1414,6 +1445,8 @@ static void pci_remove_capabilities_sysfs(struct =
pci_dev *dev)
> >  		device_remove_file(&dev->dev, &dev_attr_reset);
> >  		dev->reset_fn =3D 0;
> >  	}
> > +	if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE)
> > +		device_remove_file(&dev->dev, &dev_attr_reset_bus);
> >  }
> > =20
> >  /** =20
>=20

