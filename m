Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF1B1072A3
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 14:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfKVNBC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 08:01:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53116 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727783AbfKVNBB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 08:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574427660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hDtTiFZGGo/1StAmtVfrkUJ+PjYMYzK9DUhNQHwqZlg=;
        b=WveYlPr+r80JpPGtiw8L4LuItcwudw119xJ2EJjC1CEhR9t/t/HxBGvm8rkREtEBlVLKGx
        vYejcyupLkLPdNaA5X7HEyeTkaaBJE2s9uN0/MKZx9oUMYxGc1pFSKY6ceuZwp4AkOPQxz
        D4w09bA6q/IPiZS73XBgK6vVDuBsoe8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-i3lwfrzpPj62EvRTnQzvNA-1; Fri, 22 Nov 2019 08:00:57 -0500
Received: by mail-qt1-f200.google.com with SMTP id i1so4567773qtj.19
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 05:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1fR3x/2WLw68dp/9JUT3DJdPEJVC8+NEY0FO9GcZY1o=;
        b=oGkeoxLhwJnP4YWaNeALgROa9O+sJigWXH74drEPeYf7fZ0pHFbPFIvjfFZBIMj1KD
         pxpd2UA75tmG9cr+ILUlBGUgzmb0kFKLxydiRSE7MvZkAnN78y9vcFgNr3cKWAreJh1z
         NEcBZXAmHKzfNXWNeX4ToMthfepA5kk1Wdqh6fJFz7vRyxwkOatJ6wVovbHqJuHUU8E7
         fkAcX8nmcHGw7kuSDimZZg6ZzQBNF4USgtCcVKOH2o8X+aEVXLDWg2uWWCjhFJ/gKFeu
         50B3rvRcVWt1HISLiIchB6fD57awmkC+QdLQAVzE+m1vJtnMmOMas02RSfUkQVDHoxr9
         1nGA==
X-Gm-Message-State: APjAAAWPqIsyrdlBz/AAYe2TkFsnE+2G4qlLYdp+MuzZqYHj7SeYRT+J
        2nmgg7AHCfIjqlyw6+Ta8PJkvAxPVfUSlGX53V/+uiKeNf+PqhCrblMfy43SStq4ml1/uaFZ+95
        24SD0Y5vPRCUhDPFOcggl
X-Received: by 2002:a05:620a:208f:: with SMTP id e15mr3450529qka.351.1574427656432;
        Fri, 22 Nov 2019 05:00:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwq6MxrIGacf2ffzy2/2UvK2qmsTNmCKrzyfncS0NUTLAuxeKcMdMPDyh/8Vn1ehS0K2ecivQ==
X-Received: by 2002:a05:620a:208f:: with SMTP id e15mr3450483qka.351.1574427656023;
        Fri, 22 Nov 2019 05:00:56 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id r36sm3397016qta.27.2019.11.22.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 05:00:55 -0800 (PST)
Date:   Fri, 22 Nov 2019 08:00:46 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com,
        jasowang@redhat.com, jacob.jun.pan@intel.com,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com
Subject: Re: [RFC 00/13] virtio-iommu on non-devicetree platforms
Message-ID: <20191122075438-mutt-send-email-mst@kernel.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
X-MC-Unique: i3lwfrzpPj62EvRTnQzvNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 11:49:47AM +0100, Jean-Philippe Brucker wrote:
> I'm seeking feedback on multi-platform support for virtio-iommu. At the
> moment only devicetree (DT) is supported and we don't have a pleasant
> solution for other platforms. Once we figure out the topology
> description, x86 support is trivial.
>=20
> Since the IOMMU manages memory accesses from other devices, the guest
> kernel needs to initialize the IOMMU before endpoints start issuing DMA.
> It's a solved problem: firmware or hypervisor describes through DT or
> ACPI tables the device dependencies, and probe of endpoints is deferred
> until the IOMMU is probed. But:
>=20
> (1) ACPI has one table per vendor (DMAR for Intel, IVRS for AMD and IORT
>     for Arm). From my point of view IORT is easier to extend, since we
>     just need to introduce a new node type. There are no dependencies to
>     Arm in the Linux IORT driver, so it works well with CONFIG_X86.
>=20
>     However, there are concerns about other OS vendors feeling obligated
>     to implement this new node, so Arm proposed introducing another ACPI
>     table, that can wrap any of DMAR, IVRS and IORT to extend it with
>     new virtual nodes. A draft of this VIOT table specification is
>     available at http://jpbrucker.net/virtio-iommu/viot/viot-v5.pdf
>=20
>     I'm afraid this could increase fragmentation as guests would need to
>     implement or modify their support for all of DMAR, IVRS and IORT. If
>     we end up doing VIOT, I suggest limiting it to IORT.
>=20
> (2) In addition, there are some concerns about having virtio depend on
>     ACPI or DT. Some hypervisors (Firecracker, QEMU microvm, kvmtool x86
>     [1])

power?

> don't currently implement those methods.
>=20
>     It was suggested to embed the topology description into the device.
>     It can work, as demonstrated at the end of this RFC, with the
>     following limitations:
>=20
>     - The topology description must be read before any endpoint managed
>       by the IOMMU is probed, and even before the virtio module is
>       loaded. This RFC uses a PCI quirk to manually parse the virtio
>       configuration. It assumes that all endpoints managed by the IOMMU
>       are under this same PCI host.
>=20
>     - I don't have a solution for the virtio-mmio transport at the
>       moment, because I haven't had time to modify a host to test it. I
>       think it could either use a notifier on the platform bus, or
>       better, a new 'iommu' command-line argument to the virtio-mmio
>       driver.

=09A notifier seems easier for users. What are the disadvantages of
=09that?

>=09So the current prototype doesn't work for firecracker and
>       microvm, which rely on virtio-mmio.
>=20
>     - For Arm, if the platform has an ITS, the hypervisor needs IORT or
>       DT to describe it anyway. More generally, not using either ACPI or
>       DT might prevent from supporting other features as well. I suspect
>       the above users will have to implement a standard method sooner or
>       later.
>=20
>     - Even when reusing as much existing code as possible, guest support
>       is still going to be around a few hundred lines since we can't
>       rely on the normal virtio infrastructure to be loaded at that
>       point. As you can see below, the diffstat for the incomplete
>       topology implementation is already bigger than the exhaustive IORT
>       support, even when jumping through the VIOT hoop.
>=20
>     So it's a lightweight solution for very specific use-cases, and we
>     should still support ACPI for the general case. Multi-platform
>     guests such as Linux will then need to support three topology
>     descriptions instead of two.
>=20
> In this RFC I present both solutions, but I'd rather not keep all of it.
> Please see the individual patches for details:
>=20
> (1) Patches 1, 3-10 add support for virtio-iommu to the Linux IORT
>     driver and patches 2, 11 add the VIOT glue.
>=20
> (2) Patch 12 adds the built-in topology description to the virtio-iommu
>     specification. Patch 13 is a partial implementation for the Linux
>     virtio-iommu driver. It only supports PCI, not platform devices.
>=20
> You can find Linux and QEMU code on my virtio-iommu/devel branches at
> http://jpbrucker.net/git/linux and http://jpbrucker.net/git/qemu
>=20
>=20
> I split the diffstat since there are two independent features. The first
> one is for patches 1-11, and the second one for patch 13.
>=20
> Jean-Philippe Brucker (11):
>   ACPI/IORT: Move IORT to the ACPI folder
>   ACPI: Add VIOT definitions
>   ACPI/IORT: Allow registration of external tables
>   ACPI/IORT: Add node categories
>   ACPI/IORT: Support VIOT virtio-mmio node
>   ACPI/IORT: Support VIOT virtio-pci node
>   ACPI/IORT: Defer probe until virtio-iommu-pci has registered a fwnode
>   ACPI/IORT: Add callback to update a device's fwnode
>   iommu/virtio: Create fwnode if necessary
>   iommu/virtio: Update IORT fwnode
>   ACPI: Add VIOT table
>=20
>  MAINTAINERS                     |   9 +
>  drivers/acpi/Kconfig            |   7 +
>  drivers/acpi/Makefile           |   2 +
>  drivers/acpi/arm64/Kconfig      |   3 -
>  drivers/acpi/arm64/Makefile     |   1 -
>  drivers/acpi/bus.c              |   2 +
>  drivers/acpi/{arm64 =3D> }/iort.c | 317 ++++++++++++++++++++++++++------
>  drivers/acpi/tables.c           |   2 +-
>  drivers/acpi/viot.c             |  44 +++++
>  drivers/iommu/Kconfig           |   1 +
>  drivers/iommu/virtio-iommu.c    |  61 +++++-
>  include/acpi/actbl2.h           |  31 ++++
>  include/linux/acpi_iort.h       |  14 ++
>  include/linux/acpi_viot.h       |  20 ++
>  14 files changed, 448 insertions(+), 66 deletions(-)
>  rename drivers/acpi/{arm64 =3D> }/iort.c (86%)
>  create mode 100644 drivers/acpi/viot.c
>  create mode 100644 include/linux/acpi_viot.h
>=20
> Jean-Philippe Brucker (1):
>   iommu/virtio: Add topology description to virtio-iommu config space
>=20
>  drivers/base/platform.c               |   3 +
>  drivers/iommu/Kconfig                 |   9 +
>  drivers/iommu/Makefile                |   1 +
>  drivers/iommu/virtio-iommu-topology.c | 410 ++++++++++++++++++++++++++
>  drivers/iommu/virtio-iommu.c          |   3 +
>  drivers/pci/pci-driver.c              |   3 +
>  include/linux/virtio_iommu.h          |  18 ++
>  include/uapi/linux/virtio_iommu.h     |  26 ++
>  8 files changed, 473 insertions(+)
>  create mode 100644 drivers/iommu/virtio-iommu-topology.c
>  create mode 100644 include/linux/virtio_iommu.h
>=20
>=20
> [1] firecracker: https://github.com/firecracker-microvm/firecracker
>     microvm: https://github.com/qemu/qemu/blob/master/docs/microvm.rst
>     kvmtool: https://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool=
.git/
> --=20
> 2.24.0

