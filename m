Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF0836B991
	for <lists+linux-pci@lfdr.de>; Mon, 26 Apr 2021 21:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbhDZTDH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Apr 2021 15:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239038AbhDZTDF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Apr 2021 15:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619463743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lUOmIfVKVmn7W2gLrr33NGKDnELSORbbbUBZA/ks9GQ=;
        b=BsjplinQ5x5cNKmJV1yDE6fZtLlXwWSkaU+YNOSVpQs9RCcb7iveiNkzTBJ/DO4HUBAB29
        OvrYGBIMiPNKMJk6oPlXnE+UDssvOhsT6QAiD37/k4jZdxU6BL/okH8MjQERVwjCl2PCvx
        KCvGslf/ZUZ913ME2B1ni2SskwP/Y1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-5MeCUxOGM2-6fMla4thlMg-1; Mon, 26 Apr 2021 15:02:18 -0400
X-MC-Unique: 5MeCUxOGM2-6fMla4thlMg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5D22107ACE8;
        Mon, 26 Apr 2021 19:02:13 +0000 (UTC)
Received: from redhat.com (ovpn-113-225.phx2.redhat.com [10.3.113.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EBA4610A8;
        Mon, 26 Apr 2021 19:02:13 +0000 (UTC)
Date:   Mon, 26 Apr 2021 13:02:12 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Shanker R Donthineni <sdonthineni@nvidia.com>
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH 1/1] PCI: Add pci reset quirk for Nvidia GPUs
Message-ID: <20210426130212.4c2e78f2@redhat.com>
In-Reply-To: <c758d8a8-4f8b-c505-118e-b364e93ae539@nvidia.com>
References: <20210423145402.14559-1-sdonthineni@nvidia.com>
        <ff4812ba-ec1d-9462-0cbd-029635af3267@kernel.org>
        <20210423093701.594efd86@redhat.com>
        <c758d8a8-4f8b-c505-118e-b364e93ae539@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 23 Apr 2021 16:45:15 -0500
Shanker R Donthineni <sdonthineni@nvidia.com> wrote:

> On 4/23/21 10:37 AM, Alex Williamson wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Fri, 23 Apr 2021 11:12:05 -0400
> > Sinan Kaya <okaya@kernel.org> wrote:
> > =20
> >> +Alex,
> >>
> >> On 4/23/2021 10:54 AM, Shanker Donthineni wrote: =20
> >>> +static int reset_nvidia_gpu_quirk(struct pci_dev *dev, int probe)
> >>> +{
> >>> +#ifdef CONFIG_ACPI
> >>> +   acpi_handle handle =3D ACPI_HANDLE(&dev->dev);
> >>> +
> >>> +   /*
> >>> +    * Check for the affected devices' ID range. If device is not in
> >>> +    * the affected range, return -ENOTTY indicating no device
> >>> +    * specific reset method is available.
> >>> +    */
> >>> +   if ((dev->device & 0xffc0) !=3D 0x2340)
> >>> +           return -ENOTTY;
> >>> +
> >>> +   /*
> >>> +    * Return -ENOTTY indicating no device-specific reset method if _=
RST
> >>> +    * method is not defined
> >>> +    */
> >>> +   if (!handle || !acpi_has_method(handle, "_RST"))
> >>> +           return -ENOTTY;
> >>> +
> >>> +   /* Return 0 for probe phase indicating that we can reset this dev=
ice */
> >>> +   if (probe)
> >>> +           return 0;
> >>> +
> >>> +   /* Invoke _RST() method to perform the device-specific reset */
> >>> +   if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL)=
)) {
> >>> +           pci_warn(dev, "Failed to reset the device\n");
> >>> +           return -EINVAL;
> >>> +   }
> >>> +   return 0;
> >>> +#else
> >>> +   return -ENOTTY;
> >>> +#endif
> >>> +} =20
> >> Interesting, some pieces of this function (especially the ACPI _RST)
> >> could be generalized. =20
> > Agreed, we should add a new function level reset method for this rather
> > than a device specific reset.  At that point the extent of the device
> > specific quirk could be to restrict SBR. =20
> Thanks Sinan/Alex, Agree ACPI _RST is a generic method applicable
> to all PCI-ACPI-DEVICE objects. I'll define a new helper function
> pci_dev_acpi_reset() and move common code to it. I've one question
> before posting a v2 patch, should I call pci_dev_acpi_reset() from
> the reset_nvidia_gpu_quirk() or always apply _RST method if exists?
>=20
> Option-1:
> static int reset_nvidia_gpu_quirk(struct pci_dev *dev, int probe)
> {
>  =C2=A0=C2=A0=C2=A0 /* Check for the affected devices' ID range */
>  =C2=A0=C2=A0=C2=A0 if ((dev->device & 0xffc0) !=3D 0x2340)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOTTY;
>  =C2=A0=C2=A0=C2=A0 return pci_dev_acpi_reset(dev, probe);
> }
>=20
> OR
>=20
> Option-2
> int pci_dev_specific_reset(struct pci_dev *dev, int probe)
> {
>  =C2=A0=C2=A0 const struct pci_dev_reset_methods *i;
>=20
>  =C2=A0=C2=A0 if (!pci_dev_acpi_reset(dev, probe))
>  =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>  =C2=A0=C2=A0 ...
> }

Not quite either actually.  I think this is a standard mechanism for
firmware to provide a reset method for a device, so it should be called
as a first-class mechanism from __pci_reset_function_locked() and
pci_probe_reset_function() rather than from within the device specific
callout.  pci_dev_specific_reset() should only handle our own software
defined reset quirks for devices.  It seems like we should be able to
safely probe any device for an ACPI device handle with _RST method
support.

I'd likely set the default priority of a a new acpi reset mechanism
below our own software defined resets, but above hardware resets.  We
should only need the PCI header fixup quirk for this device to set the
NO_BUS_RESET flag, which would prevent userspace from re-prioritizing
SBR reset when we consider proposals like the one from Amey to allow
userspace policy management of reset mechanisms[1].

> >    It'd be useful to know what
> > these devices are (not in pciids yet), why we expect to only see them in
> > specific platforms (embedded device?), and the failure mode of the SBR.=
 =20
> These are not plug-in PCIe GPU cards, will exist on upcoming
> server baseboards. Triggering SBR without firmware notification
> would leave the device inoperable for the current system boot.
> It requires a system hard-reboot to get the GPU device back to
> normal operating condition post-SBR.

Any such descriptions you can include in the quirk to disable SBR for
this device, especially if you can share public code names, seems like
it would only help people associate this support to the hardware that
requires it.  Thanks,

Alex

[1]https://lore.kernel.org/linux-pci/20210409192324.30080-1-ameynarkhede03@=
gmail.com/

