Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A03107281
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 13:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfKVMxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 07:53:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24913 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727090AbfKVMxf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 07:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574427212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o8t4lg6G38qB0SQwvVJ9hoeWVdNOZDcB44Ut03IMc4g=;
        b=ERymBvYztMMcrA8CgEoZLR/yY+fzqkZJFqWlAxxmlUWLqYoDReJG92vmS+S0WgarXZ9X/O
        Mx5n4CodEtgsB3AICGMvonjoQZHss5eBEQ8zgw5ic0bQBFv8ZVRJ2NMGM9Q7B4wueBpEr+
        C/ot/QfHdUJmajtp72a+7gx5RkdEVlA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-9w3U9dPrM1m47OkYbHN-Fg-1; Fri, 22 Nov 2019 07:53:29 -0500
Received: by mail-qv1-f71.google.com with SMTP id i11so4625892qvh.3
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 04:53:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9xHNF9/YgjAGk4kIlAAsdUxHxJcJJsv6exr71iNr4V4=;
        b=XimqQG91NMp3VnGnvylGP6dksW3VV3p7C1E3tY4IHR01JFtPR3rEQ2xTie14pq2yGQ
         ZJ2+Tt8SlUBWwBhYKzc7SdzMr6ZaHJlnmGcoQjmcANLQ0QXLPIqdduzoGrqAaZEgraaU
         1WvTn+8vZcuIagmqATBbJewUYPtvXcYqXtjRvC0QBAy3WPJ4+OtaTgdN///YEv+ixDFT
         W0I1II91lxV6lgEvFPk4mmbJCSbZZkfJg0rl9FderW5dO+RpisutP2r2NLdhpuIbI/0t
         qRyr23ompSDFTZ8No8QAoumZdiz8iPyNMVn85cJCMR6xWL1cXWbiX8Hf0IP3RWEUafHR
         nrIA==
X-Gm-Message-State: APjAAAU9/8rXabZV/+fa//nrqBCg76eVZBSZtmQh+0CbI3eEndMUh+A9
        upwuU3YOHx8Sx1HbWdQp092X5fLp2rHBNvWSd5l32eO1mQ21y7rZ2rzRpuIVEcWU8ScmyBS05Pv
        GTJhTlsfYyLtqJFYfBN/T
X-Received: by 2002:a37:f905:: with SMTP id l5mr720002qkj.90.1574427209095;
        Fri, 22 Nov 2019 04:53:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwI8O5AZ60spvd8sFXJP6S0266NtbeUWxXughaKMn9jxZ+nG3v0r7IIJE5S7gM+4nnU3Dugaw==
X-Received: by 2002:a37:f905:: with SMTP id l5mr719954qkj.90.1574427208569;
        Fri, 22 Nov 2019 04:53:28 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id o124sm717630qkf.66.2019.11.22.04.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 04:53:27 -0800 (PST)
Date:   Fri, 22 Nov 2019 07:53:19 -0500
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
Subject: Re: [RFC 13/13] iommu/virtio: Add topology description to
Message-ID: <20191122072753-mutt-send-email-mst@kernel.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
 <20191122105000.800410-14-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20191122105000.800410-14-jean-philippe@linaro.org>
X-MC-Unique: 9w3U9dPrM1m47OkYbHN-Fg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 11:50:00AM +0100, Jean-Philippe Brucker wrote:
> Some hypervisors don't implement either device-tree or ACPI, but still
> need a method to describe the IOMMU topology. Read the virtio-iommu
> config early and parse the topology description. Hook into the
> dma_setup() callbacks to initialize the IOMMU before probing endpoints.
>=20
> If the virtio-iommu uses the virtio-pci transport, this will only work
> if the PCI root complex is the first device probed. We don't currently
> support virtio-mmio.
>=20
> Initially I tried to generate a fake IORT table and feed it to the IORT
> driver, in order to avoid rewriting the whole DMA code, but it wouldn't
> work with platform endpoints, which are references to items in the ACPI
> table on IORT.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Overall this looks good to me. The only point is that
I think the way the interface is designed makes writing
the driver a bit too difficult. Idea: if instead we just
have a length field and then an array of records
(preferably unions so we don't need to work hard),
we can shadow that into memory, then iterate over
the unions.

Maybe add a uniform record length + number of records field.
Then just skip types you do not know how to handle.
This will also help make sure it's within bounds.

What do you think?


You will need to do something to address the TODO I think.

> ---
> Note that we only call virt_dma_configure() if the host didn't provide
> either DT or ACPI method. If you want to test this with QEMU, you'll
> need to manually disable the acpi_dma_configure() part in pci-driver.c
> ---
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
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index b230beb6ccb4..70b12c8ef2fb 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -27,6 +27,7 @@
>  #include <linux/limits.h>
>  #include <linux/property.h>
>  #include <linux/kmemleak.h>
> +#include <linux/virtio_iommu.h>
> =20
>  #include "base.h"
>  #include "power/power.h"
> @@ -1257,6 +1258,8 @@ int platform_dma_configure(struct device *dev)
>  =09} else if (has_acpi_companion(dev)) {
>  =09=09attr =3D acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
>  =09=09ret =3D acpi_dma_configure(dev, attr);
> +=09} else if (IS_ENABLED(CONFIG_VIRTIO_IOMMU_TOPOLOGY)) {
> +=09=09ret =3D virt_dma_configure(dev);
>  =09}
> =20
>  =09return ret;
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index e6eb4f238d1a..d02c0d36019d 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -486,4 +486,13 @@ config VIRTIO_IOMMU
> =20
>  =09  Say Y here if you intend to run this kernel as a guest.
> =20
> +config VIRTIO_IOMMU_TOPOLOGY
> +=09bool "Topology properties for the virtio-iommu"
> +=09depends on VIRTIO_IOMMU
> +=09help
> +=09  Enable early probing of the virtio-iommu device, to detect the
> +=09  topology description.
> +
> +=09  Say Y here if you intend to run this kernel as a guest.
> +
>  endif # IOMMU_SUPPORT
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 4f405f926e73..6b51c4186ebc 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -35,3 +35,4 @@ obj-$(CONFIG_S390_IOMMU) +=3D s390-iommu.o
>  obj-$(CONFIG_QCOM_IOMMU) +=3D qcom_iommu.o
>  obj-$(CONFIG_HYPERV_IOMMU) +=3D hyperv-iommu.o
>  obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu.o
> +obj-$(CONFIG_VIRTIO_IOMMU_TOPOLOGY) +=3D virtio-iommu-topology.o
> diff --git a/drivers/iommu/virtio-iommu-topology.c b/drivers/iommu/virtio=
-iommu-topology.c
> new file mode 100644
> index 000000000000..ec22510ace3d
> --- /dev/null
> +++ b/drivers/iommu/virtio-iommu-topology.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/iommu.h>
> +#include <linux/list.h>
> +#include <linux/pci.h>
> +#include <linux/printk.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_iommu.h>
> +#include <linux/virtio_pci.h>
> +#include <uapi/linux/virtio_iommu.h>
> +
> +struct viommu_cap_config {
> +=09u8 pos; /* PCI capability position */
> +=09u8 bar;
> +=09u32 length; /* structure size */
> +=09u32 offset; /* structure offset within the bar */
> +};
> +
> +struct viommu_spec {
> +=09struct device=09=09*dev; /* transport device */
> +=09struct fwnode_handle=09*fwnode;
> +=09struct iommu_ops=09*ops;
> +=09struct list_head=09topology;
> +=09struct list_head=09list;
> +};
> +
> +struct viommu_topology {
> +=09union {
> +=09=09struct virtio_iommu_topo_head head;
> +=09=09struct virtio_iommu_topo_pci_range pci;
> +=09=09struct virtio_iommu_topo_endpoint ep;
> +=09};
> +=09/* Index into viommu_spec->topology */
> +=09struct list_head list;
> +};
> +
> +static LIST_HEAD(viommus);
> +static DEFINE_MUTEX(viommus_lock);
> +
> +#define VPCI_FIELD(field) offsetof(struct virtio_pci_cap, field)
> +
> +static inline int viommu_find_capability(struct pci_dev *dev, u8 cfg_typ=
e,
> +=09=09=09=09=09 struct viommu_cap_config *cap)
> +{
> +=09int pos;
> +=09u8 bar;
> +
> +=09for (pos =3D pci_find_capability(dev, PCI_CAP_ID_VNDR);
> +=09     pos > 0;
> +=09     pos =3D pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> +=09=09u8 type;
> +
> +=09=09pci_read_config_byte(dev, pos + VPCI_FIELD(cfg_type), &type);
> +=09=09if (type !=3D cfg_type)
> +=09=09=09continue;
> +
> +=09=09pci_read_config_byte(dev, pos + VPCI_FIELD(bar), &bar);
> +
> +=09=09/* Ignore structures with reserved BAR values */
> +=09=09if (type !=3D VIRTIO_PCI_CAP_PCI_CFG && bar > 0x5)
> +=09=09=09continue;
> +
> +=09=09cap->bar =3D bar;
> +=09=09cap->pos =3D pos;
> +=09=09pci_read_config_dword(dev, pos + VPCI_FIELD(length),
> +=09=09=09=09      &cap->length);
> +=09=09pci_read_config_dword(dev, pos + VPCI_FIELD(offset),
> +=09=09=09=09      &cap->offset);
> +
> +=09=09return pos;
> +=09}
> +=09return 0;
> +}
> +
> +/*
> + * Setup the special virtio PCI capability to read one of the config reg=
isters
> + */
> +static int viommu_switch_pci_cfg(struct pci_dev *dev, int cfg,
> +=09=09=09=09 struct viommu_cap_config *cap, u32 length,
> +=09=09=09=09 u32 offset)
> +{
> +=09offset +=3D cap->offset;
> +
> +=09if (offset + length > cap->offset + cap->length) {
> +=09=09dev_warn(&dev->dev,
> +=09=09=09 "read of %d bytes at offset 0x%x overflows cap of size %d\n",
> +=09=09=09 length, offset, cap->length);
> +=09=09return -EOVERFLOW;
> +=09}
> +
> +=09pci_write_config_byte(dev, cfg + VPCI_FIELD(bar), cap->bar);
> +=09pci_write_config_dword(dev, cfg + VPCI_FIELD(length), length);
> +=09pci_write_config_dword(dev, cfg + VPCI_FIELD(offset), offset);
> +=09return 0;
> +}
> +
> +static u32 viommu_cread(struct pci_dev *dev, int cfg,
> +=09=09=09struct viommu_cap_config *cap, u32 length, u32 offset)
> +{
> +=09u8 val8;
> +=09u16 val16;
> +=09u32 val32;
> +=09int out =3D cfg + sizeof(struct virtio_pci_cap);
> +
> +=09if (viommu_switch_pci_cfg(dev, cfg, cap, length, offset))
> +=09=09return 0;
> +
> +=09switch (length) {
> +=09case 1:
> +=09=09pci_read_config_byte(dev, out, &val8);
> +=09=09return val8;
> +=09case 2:
> +=09=09pci_read_config_word(dev, out, &val16);
> +=09=09return val16;
> +=09case 4:
> +=09=09pci_read_config_dword(dev, out, &val32);
> +=09=09return val32;
> +=09default:
> +=09=09WARN_ON(1);
> +=09=09return 0;
> +=09}
> +}
> +
> +static void viommu_cwrite(struct pci_dev *dev, int cfg,
> +=09=09=09  struct viommu_cap_config *cap, u32 length, u32 offset,
> +=09=09=09  u32 val)

A single user with 4 byte parameter. Just open-code?

> +{
> +=09int out =3D cfg + sizeof(struct virtio_pci_cap);
> +
> +=09if (viommu_switch_pci_cfg(dev, cfg, cap, length, offset))
> +=09=09return;
> +
> +=09switch (length) {
> +=09case 1:
> +=09=09pci_write_config_byte(dev, out, (u8)val);
> +=09=09break;
> +=09case 2:
> +=09=09pci_write_config_word(dev, out, (u16)val);
> +=09=09break;
> +=09case 4:
> +=09=09pci_write_config_dword(dev, out, val);
> +=09=09break;
> +=09default:
> +=09=09WARN_ON(1);
> +=09}
> +}
> +
> +static int viommu_add_topology(struct viommu_spec *viommu_spec,
> +=09=09=09       struct viommu_topology *cap)
> +{
> +=09struct viommu_topology *new =3D kmemdup(cap, sizeof(*cap), GFP_KERNEL=
);
> +
> +=09if (!new)
> +=09=09return -ENOMEM;
> +
> +=09mutex_lock(&viommus_lock);
> +=09list_add(&new->list, &viommu_spec->topology);
> +=09mutex_unlock(&viommus_lock);
> +=09return 0;
> +}
> +
> +static int viommu_parse_topology(struct pci_dev *dev, int pci_cfg,
> +=09=09=09=09 struct viommu_cap_config *dev_cfg)
> +{
> +=09u32 offset;
> +=09struct viommu_topology cap;
> +=09struct viommu_spec *viommu_spec;
> +=09int iter =3D 0; /* Protects against config loop */
> +
> +=09offset =3D viommu_cread(dev, pci_cfg, dev_cfg, 2,
> +=09=09=09      offsetof(struct virtio_iommu_config,
> +=09=09=09=09       topo_offset));
> +=09if (!offset)
> +=09=09return 0;
> +
> +=09viommu_spec =3D kzalloc(sizeof(*viommu_spec), GFP_KERNEL);
> +=09if (!viommu_spec)
> +=09=09return -ENOMEM;
> +
> +=09INIT_LIST_HEAD(&viommu_spec->topology);
> +=09viommu_spec->dev =3D &dev->dev;
> +
> +=09while (offset >=3D sizeof(struct virtio_iommu_config) && ++iter < 0x1=
0000) {
> +=09=09memset(&cap, 0, sizeof(cap));
> +
> +=09=09cap.head.type =3D viommu_cread(dev, pci_cfg, dev_cfg, 2, offset);
> +=09=09cap.head.next =3D viommu_cread(dev, pci_cfg, dev_cfg, 2, offset + =
2);

All of this doesn't seem to be endian-clean. Try running sparse I think
it will complain.

> +
> +=09=09switch (cap.head.type) {
> +=09=09case VIRTIO_IOMMU_TOPO_PCI_RANGE:
> +=09=09=09cap.pci.endpoint_start =3D viommu_cread(dev, pci_cfg,
> +=09=09=09=09=09=09=09      dev_cfg, 2, offset
> +=09=09=09=09=09=09=09      + 4);
> +=09=09=09cap.pci.hierarchy =3D viommu_cread(dev, pci_cfg, dev_cfg,
> +=09=09=09=09=09=09=09 2, offset + 8);
> +=09=09=09cap.pci.requester_start =3D viommu_cread(dev, pci_cfg,
> +=09=09=09=09=09=09=09       dev_cfg, 2,
> +=09=09=09=09=09=09=09       offset + 10);
> +=09=09=09cap.pci.requester_end =3D viommu_cread(dev, pci_cfg,
> +=09=09=09=09=09=09=09     dev_cfg, 2, offset +
> +=09=09=09=09=09=09=09     12);
> +=09=09=09dev_info(&dev->dev,
> +=09=09=09=09 "topology: adding PCI range 0x%x [0x%x:0x%x] -> 0x%x\n",
> +=09=09=09=09 cap.pci.hierarchy, cap.pci.requester_start,
> +=09=09=09=09 cap.pci.requester_end, cap.pci.endpoint_start);
> +=09=09=09if (viommu_add_topology(viommu_spec, &cap))
> +=09=09=09=09return -ENOMEM;
> +=09=09=09break;
> +=09=09case VIRTIO_IOMMU_TOPO_ENDPOINT:
> +=09=09=09cap.ep.endpoint =3D viommu_cread(dev, pci_cfg, dev_cfg, 2,
> +=09=09=09=09=09=09       offset + 4);
> +=09=09=09cap.ep.address =3D viommu_cread(dev, pci_cfg, dev_cfg, 2,
> +=09=09=09=09=09=09      offset + 8);
> +=09=09=09dev_info(&dev->dev,
> +=09=09=09=09 "topology: adding endpoint 0x%llx -> 0x%x\n",
> +=09=09=09=09 cap.ep.address, cap.ep.endpoint);
> +=09=09=09if (viommu_add_topology(viommu_spec, &cap))
> +=09=09=09=09return -ENOMEM;
> +=09=09=09break;
> +=09=09default:
> +=09=09=09dev_warn(&dev->dev, "Unknown topo structure 0x%x\n",
> +=09=09=09=09 cap.head.type);
> +=09=09=09break;
> +=09=09}
> +
> +=09=09offset =3D cap.head.next;
> +=09}
> +
> +=09/* TODO: handle device removal */
> +=09mutex_lock(&viommus_lock);
> +=09list_add(&viommu_spec->list, &viommus);
> +=09mutex_unlock(&viommus_lock);
> +
> +=09return 0;
> +}
> +
> +static void viommu_pci_parse_topology(struct pci_dev *dev)
> +{
> +=09int pos;
> +=09u32 features;
> +=09struct viommu_cap_config common =3D {0};
> +=09struct viommu_cap_config pci_cfg =3D {0};
> +=09struct viommu_cap_config dev_cfg =3D {0};
> +
> +=09pos =3D viommu_find_capability(dev, VIRTIO_PCI_CAP_COMMON_CFG, &commo=
n);
> +=09if (!pos) {
> +=09=09dev_warn(&dev->dev, "common capability not found\n");
> +=09=09return;
> +=09}
> +=09pos =3D viommu_find_capability(dev, VIRTIO_PCI_CAP_DEVICE_CFG, &dev_c=
fg);
> +=09if (!pos) {
> +=09=09dev_warn(&dev->dev, "device config capability not found\n");
> +=09=09return;
> +=09}
> +=09pos =3D viommu_find_capability(dev, VIRTIO_PCI_CAP_PCI_CFG, &pci_cfg)=
;
> +=09if (!pos) {
> +=09=09dev_warn(&dev->dev, "PCI config capability not found\n");
> +=09=09return;
> +=09}
> +
> +=09/* Find out if the device supports topology description */
> +=09viommu_cwrite(dev, pos, &common, 4,
> +=09=09      offsetof(struct virtio_pci_common_cfg,
> +=09=09=09       device_feature_select),
> +=09=09      0);
> +=09features =3D viommu_cread(dev, pos, &common, 4,
> +=09=09=09=09offsetof(struct virtio_pci_common_cfg,
> +=09=09=09=09=09 device_feature));
> +=09if (!(features & VIRTIO_IOMMU_F_TOPOLOGY)) {
> +=09=09dev_dbg(&dev->dev, "device doesn't have topology description");
> +=09=09return;
> +=09}
> +
> +=09viommu_parse_topology(dev, pos, &dev_cfg);
> +}
> +
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1014,
> +=09=09=09viommu_pci_parse_topology);
> +
> +static const struct iommu_ops *virt_iommu_setup(struct device *dev)
> +{
> +=09struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> +=09const struct iommu_ops *viommu_ops =3D NULL;
> +=09struct fwnode_handle *viommu_fwnode;
> +=09struct viommu_spec *viommu_spec;
> +=09struct viommu_topology *topo;
> +=09struct pci_dev *pdev =3D NULL;
> +=09struct device *viommu_dev;
> +=09bool found =3D false;
> +=09u16 devid;
> +=09u32 eid;
> +=09int ret;
> +
> +=09/* Already translated? */
> +=09if (fwspec && fwspec->ops)
> +=09=09return fwspec->ops;
> +
> +=09if (dev_is_pci(dev)) {
> +=09=09pdev =3D to_pci_dev(dev);
> +=09=09devid =3D pci_dev_id(pdev);
> +=09} else {
> +=09=09/* TODO: Do something with devres */
> +=09=09return NULL;
> +=09}
> +
> +=09mutex_lock(&viommus_lock);
> +=09list_for_each_entry(viommu_spec, &viommus, list) {
> +=09=09list_for_each_entry(topo, &viommu_spec->topology, list) {
> +=09=09=09if (pdev &&
> +=09=09=09    topo->head.type =3D=3D VIRTIO_IOMMU_TOPO_PCI_RANGE &&
> +=09=09=09    pci_domain_nr(pdev->bus) =3D=3D topo->pci.hierarchy &&
> +=09=09=09    devid >=3D topo->pci.requester_start &&
> +=09=09=09    devid <=3D topo->pci.requester_end) {
> +=09=09=09=09found =3D true;
> +=09=09=09=09eid =3D devid - topo->pci.requester_start +
> +=09=09=09=09=09topo->pci.endpoint_start;
> +=09=09=09=09break;
> +=09=09=09} else if (!pdev) {
> +=09=09=09=09/* TODO: compare address with devres */
> +=09=09=09}
> +=09=09}
> +=09=09if (found) {
> +=09=09=09viommu_ops =3D viommu_spec->ops;
> +=09=09=09viommu_fwnode =3D viommu_spec->fwnode;
> +=09=09=09viommu_dev =3D viommu_spec->dev;
> +=09=09=09break;
> +=09=09}
> +=09}
> +=09mutex_unlock(&viommus_lock);
> +=09if (!found)
> +=09=09return NULL;
> +
> +=09/* We're not translating ourselves, that would be silly. */
> +=09if (viommu_dev =3D=3D dev)
> +=09=09return NULL;
> +
> +=09if (!viommu_ops)
> +=09=09return ERR_PTR(-EPROBE_DEFER);
> +
> +=09ret =3D iommu_fwspec_init(dev, viommu_fwnode, viommu_ops);
> +=09if (ret)
> +=09=09return ERR_PTR(ret);
> +
> +=09iommu_fwspec_add_ids(dev, &eid, 1);
> +
> +=09return viommu_ops;
> +}
> +
> +/**
> + * virt_dma_configure - Configure DMA of virtualized devices
> + * @dev: the endpoint
> + *
> + * An alternative to the ACPI and DT methods to setup DMA and the IOMMU =
ops of a
> + * virtual device.
> + *
> + * Return: -EPROBE_DEFER if the IOMMU hasn't been loaded yet, 0 otherwis=
e
> + */
> +int virt_dma_configure(struct device *dev)
> +{
> +=09const struct iommu_ops *iommu_ops;
> +
> +=09/* TODO: do we need to mess about with the dma_mask as well? */
> +=09WARN_ON(!dev->dma_mask);
> +
> +=09iommu_ops =3D virt_iommu_setup(dev);
> +=09if (IS_ERR(iommu_ops)) {
> +=09=09if (PTR_ERR(iommu_ops) =3D=3D -EPROBE_DEFER)
> +=09=09=09return -EPROBE_DEFER;
> +=09=09iommu_ops =3D NULL;
> +=09}
> +
> +=09/*
> +=09 * If we have reason to believe the IOMMU driver missed the initial
> +=09 * add_device callback for dev, replay it to get things in order.
> +=09 */
> +=09if (iommu_ops && dev->bus && !device_iommu_mapped(dev))
> +=09=09iommu_probe_device(dev);
> +
> +#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> +=09/* Assume coherent, as well as full 64-bit addresses. */
> +=09arch_setup_dma_ops(dev, 0, ~0UL, iommu_ops, true);
> +#else
> +=09if (iommu_ops)
> +=09=09iommu_setup_dma_ops(dev, 0, ~0UL);
> +#endif
> +=09return 0;
> +}
> +
> +/**
> + * virt_set_iommu_ops - Set the IOMMU ops of a virtual IOMMU device
> + *
> + * Setup the iommu_ops associated to a viommu_spec, once the driver is l=
oaded
> + * and the device probed.
> + */
> +void virt_set_iommu_ops(struct device *dev, struct iommu_ops *ops)
> +{
> +=09struct viommu_spec *viommu_spec;
> +
> +=09mutex_lock(&viommus_lock);
> +=09list_for_each_entry(viommu_spec, &viommus, list) {
> +=09=09if (viommu_spec->dev =3D=3D dev) {
> +=09=09=09viommu_spec->ops =3D ops;
> +=09=09=09viommu_spec->fwnode =3D ops ? dev->fwnode : NULL;
> +=09=09=09break;
> +=09=09}
> +=09}
> +=09mutex_unlock(&viommus_lock);
> +}
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 9847552faecc..f68ee9615b38 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -22,6 +22,7 @@
>  #include <linux/virtio.h>
>  #include <linux/virtio_config.h>
>  #include <linux/virtio_ids.h>
> +#include <linux/virtio_iommu.h>
>  #include <linux/wait.h>
> =20
>  #include <uapi/linux/virtio_iommu.h>
> @@ -1134,6 +1135,7 @@ static int viommu_probe(struct virtio_device *vdev)
>  =09if (ret)
>  =09=09goto err_sysfs_remove;
> =20
> +=09virt_set_iommu_ops(dev->parent, &viommu_ops);
>  =09iommu_device_set_ops(&viommu->iommu, &viommu_ops);
>  =09iommu_device_register(&viommu->iommu);
> =20
> @@ -1182,6 +1184,7 @@ static void viommu_remove(struct virtio_device *vde=
v)
>  =09struct viommu_dev *viommu =3D vdev->priv;
> =20
>  =09iommu_device_unregister(&viommu->iommu);
> +=09virt_set_iommu_ops(vdev->dev.parent, NULL);
>  =09viommu_clear_fwnode(viommu);
>  =09iommu_device_sysfs_remove(&viommu->iommu);
> =20
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index a8124e47bf6e..d9b5e902ad18 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -17,6 +17,7 @@
>  #include <linux/suspend.h>
>  #include <linux/kexec.h>
>  #include <linux/of_device.h>
> +#include <linux/virtio_iommu.h>
>  #include <linux/acpi.h>
>  #include "pci.h"
>  #include "pcie/portdrv.h"
> @@ -1633,6 +1634,8 @@ static int pci_dma_configure(struct device *dev)
>  =09=09struct acpi_device *adev =3D to_acpi_device_node(bridge->fwnode);
> =20
>  =09=09ret =3D acpi_dma_configure(dev, acpi_get_dma_attr(adev));
> +=09} else if (IS_ENABLED(CONFIG_VIRTIO_IOMMU_TOPOLOGY)) {
> +=09=09ret =3D virt_dma_configure(dev);
>  =09}
> =20
>  =09pci_put_host_bridge_device(bridge);
> diff --git a/include/linux/virtio_iommu.h b/include/linux/virtio_iommu.h
> new file mode 100644
> index 000000000000..b700256f1063
> --- /dev/null
> +++ b/include/linux/virtio_iommu.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef VIRTIO_IOMMU_H_
> +#define VIRTIO_IOMMU_H_
> +
> +#if IS_ENABLED(CONFIG_VIRTIO_IOMMU_TOPOLOGY)
> +int virt_dma_configure(struct device *dev);
> +void virt_set_iommu_ops(struct device *dev, struct iommu_ops *ops);
> +#else /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY */
> +static inline int virt_dma_configure(struct device *dev)
> +{
> +=09return -ENODEV;
> +}
> +
> +static inline void virt_set_iommu_ops(struct device *dev, struct iommu_o=
ps *ops)
> +{ }
> +#endif /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY */
> +
> +#endif /* VIRTIO_IOMMU_H_ */
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virti=
o_iommu.h
> index 237e36a280cb..d3b7cd2a076f 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -16,6 +16,7 @@
>  #define VIRTIO_IOMMU_F_BYPASS=09=09=093
>  #define VIRTIO_IOMMU_F_PROBE=09=09=094
>  #define VIRTIO_IOMMU_F_MMIO=09=09=095
> +#define VIRTIO_IOMMU_F_TOPOLOGY=09=09=096
> =20
>  struct virtio_iommu_range_64 {
>  =09__le64=09=09=09=09=09start;
> @@ -36,6 +37,31 @@ struct virtio_iommu_config {
>  =09struct virtio_iommu_range_32=09=09domain_range;
>  =09/* Probe buffer size */
>  =09__le32=09=09=09=09=09probe_size;
> +=09/* Offset to the beginning of the topology table */
> +=09__le16=09=09=09=09=09topo_offset;

why do we need an offset?

> +};
> +
> +struct virtio_iommu_topo_head {
> +=09__le16=09=09=09=09=09type;
> +=09__le16=09=09=09=09=09next;
> +};

So this linked list makes things harder than necessary imho.
It will be easier to just have a counter with # of records.
Then make all records the same size.
Then just read each record out into a buffer, and
handle it there.

> +
> +#define VIRTIO_IOMMU_TOPO_PCI_RANGE=09=090x0
> +#define VIRTIO_IOMMU_TOPO_ENDPOINT=09=090x1
> +
> +struct virtio_iommu_topo_pci_range {
> +=09struct virtio_iommu_topo_head=09=09head;
> +=09__le32=09=09=09=09=09endpoint_start;
> +=09__le16=09=09=09=09=09hierarchy;
> +=09__le16=09=09=09=09=09requester_start;
> +=09__le16=09=09=09=09=09requester_end;
> +=09__le16=09=09=09=09=09reserved;
> +};
> +
> +struct virtio_iommu_topo_endpoint {
> +=09struct virtio_iommu_topo_head=09=09head;
> +=09__le32=09=09=09=09=09endpoint;
> +=09__le64=09=09=09=09=09address;
>  };
> =20
>  /* Request types */
> --=20
> 2.24.0

