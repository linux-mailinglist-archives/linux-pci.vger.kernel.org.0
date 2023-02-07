Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB51E68D50B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 12:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjBGLFZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 06:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjBGLFW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 06:05:22 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932DF2BF2B
        for <linux-pci@vger.kernel.org>; Tue,  7 Feb 2023 03:05:20 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id bs10so7650306vkb.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Feb 2023 03:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoPHPcTm8H8ze7FW2FRADE/W8w+P/SQ3Sd3300xGuo4=;
        b=0dPAoABezthwk9gv6NoB2KkyYvtpOVASTxfXFscCZF/vXmIhvKj4DrD/GzOAOrARik
         ivToWBkJVLLcSS9KZvgnWlwilnv+D1173Ed+WALVXqS6t6pEjvKFgnloZq1j4ADaXh1Q
         AT+gpssI28cNPKFIjxz4Ak+UlsfBubhD1cAX6ZggZ0sYTFXnj7guo1zmvth6y3mjjL00
         xdUw1z2IX3DT2P7ik5FJ7hnGtFjD30fS0W8aIZrbIn91cSjrC5DtomBwqywVLTUeU+Mf
         AvaVQT908ZvHMnrSsXewNQXjD7SVvAVL870MOHUot35VxWiq6zvzZ+4EYvp05Yx0EEgy
         C0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoPHPcTm8H8ze7FW2FRADE/W8w+P/SQ3Sd3300xGuo4=;
        b=J6VMAbMV7wLo1dowgMb8nRw7rDF4X1J9/OPEW4Q2UhcbODf5esYXiO8J+UeAm3kgpR
         Sw4Tnon8pKC09SCMjj4RlaCPKCCWJZR7lXsI5tr9bqNEPD/ciYKEmASmxuvBeDWEHcDQ
         TekYanZnCkb4cJvpIySGjajfwUlGgO4M1wcf87qprWuu5ZEbMBDZh4k4G/ZV+BMWl+Wx
         XedSUnYa1jDbihPhvn/uul6nENZPirnf69LrTpQFFxTQ8j20G61lViQgdfpDCTTYSbJR
         YavjY/t4WE8oqAhA820X7x9AMxoTN9Mnx4mYyEGn84hDNYY+P8YUAdFp/b7Nkx2//fl3
         QowQ==
X-Gm-Message-State: AO0yUKXUeKZLFrxnN3r6AiJR4nvtDkXymJZ21FIFC/BVoj279/4mNrUI
        sIdTbvVABvzOQxerNFO3/cIenKAYoHP3SUczvTvICA==
X-Google-Smtp-Source: AK7set9nK8EJsglFuTDfip/AK3uw96RbrvDbyGTM4gE2EsRI6AGAzZVwnmVNnIBHUjxBZeYPdJ4Hxa6z7WxUVxSCdz0=
X-Received: by 2002:a1f:9d02:0:b0:3dd:f6a9:4b73 with SMTP id
 g2-20020a1f9d02000000b003ddf6a94b73mr348309vke.12.1675767919671; Tue, 07 Feb
 2023 03:05:19 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp> <20230203100418.2981144-4-mie@igel.co.jp>
 <20230203051844-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230203051844-mutt-send-email-mst@kernel.org>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 7 Feb 2023 20:05:08 +0900
Message-ID: <CANXvt5r10bec+X=j35ertph9i+d08bkxDG7ffwUjc5z_1NgKtw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] PCI: endpoint: Introduce virtio library for EP functions
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Wang <jasowang@redhat.com>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

2023=E5=B9=B42=E6=9C=883=E6=97=A5(=E9=87=91) 19:20 Michael S. Tsirkin <mst@=
redhat.com>:
>
> On Fri, Feb 03, 2023 at 07:04:17PM +0900, Shunsuke Mie wrote:
> > Add a new library to access a virtio ring located on PCIe host memory. =
The
> > library generates struct pci_epf_vringh that is introduced in this patc=
h.
> > The struct has a vringh member, so vringh APIs can be used to access th=
e
> > virtio ring.
> >
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > Signed-off-by: Takanari Hayama <taki@igel.co.jp>
> > ---
> >  drivers/pci/endpoint/Kconfig          |   7 ++
> >  drivers/pci/endpoint/Makefile         |   1 +
> >  drivers/pci/endpoint/pci-epf-virtio.c | 113 ++++++++++++++++++++++++++
> >  include/linux/pci-epf-virtio.h        |  25 ++++++
> >  4 files changed, 146 insertions(+)
> >  create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
> >  create mode 100644 include/linux/pci-epf-virtio.h
> >
> > diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfi=
g
> > index 17bbdc9bbde0..07276dcc43c8 100644
> > --- a/drivers/pci/endpoint/Kconfig
> > +++ b/drivers/pci/endpoint/Kconfig
> > @@ -28,6 +28,13 @@ config PCI_ENDPOINT_CONFIGFS
> >          configure the endpoint function and used to bind the
> >          function with a endpoint controller.
> >
> > +config PCI_ENDPOINT_VIRTIO
> > +     tristate
> > +     depends on PCI_ENDPOINT
> > +     select VHOST_IOMEM
> > +     help
> > +       TODO update this comment
> > +
> >  source "drivers/pci/endpoint/functions/Kconfig"
> >
> >  endmenu
> > diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makef=
ile
> > index 95b2fe47e3b0..95712f0a13d1 100644
> > --- a/drivers/pci/endpoint/Makefile
> > +++ b/drivers/pci/endpoint/Makefile
> > @@ -4,5 +4,6 @@
> >  #
> >
> >  obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)  +=3D pci-ep-cfs.o
> > +obj-$(CONFIG_PCI_ENDPOINT_VIRTIO)    +=3D pci-epf-virtio.o
> >  obj-$(CONFIG_PCI_ENDPOINT)           +=3D pci-epc-core.o pci-epf-core.=
o\
> >                                          pci-epc-mem.o functions/
> > diff --git a/drivers/pci/endpoint/pci-epf-virtio.c b/drivers/pci/endpoi=
nt/pci-epf-virtio.c
> > new file mode 100644
> > index 000000000000..7134ca407a03
> > --- /dev/null
> > +++ b/drivers/pci/endpoint/pci-epf-virtio.c
> > @@ -0,0 +1,113 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Virtio library for PCI Endpoint function
> > + */
> > +#include <linux/kernel.h>
> > +#include <linux/pci-epf-virtio.h>
> > +#include <linux/pci-epc.h>
> > +#include <linux/virtio_pci.h>
> > +
> > +static void __iomem *epf_virtio_map_vq(struct pci_epf *epf, u32 pfn,
> > +                                    size_t size, phys_addr_t *vq_phys)
> > +{
> > +     int err;
> > +     phys_addr_t vq_addr;
> > +     size_t vq_size;
> > +     void __iomem *vq_virt;
> > +
> > +     vq_addr =3D (phys_addr_t)pfn << VIRTIO_PCI_QUEUE_ADDR_SHIFT;
> > +
> > +     vq_size =3D vring_size(size, VIRTIO_PCI_VRING_ALIGN) + 100;
>
> 100?
It is a mistake and will be removed.
> Also ugh, this uses the legacy vring_size.
> Did not look closely but is all this limited to legacy virtio then?
> Pls make sure you code builds with #define VIRTIO_RING_NO_LEGACY.
Thanks for your suggestion, but this device works as a legacy device.
In this case, the NO_LEGACY macro can not applicable I think. Is that right=
?
> > +
> > +     vq_virt =3D pci_epc_mem_alloc_addr(epf->epc, vq_phys, vq_size);
> > +     if (!vq_virt) {
> > +             pr_err("Failed to allocate epc memory\n");
> > +             return ERR_PTR(-ENOMEM);
> > +     }
> > +
> > +     err =3D pci_epc_map_addr(epf->epc, epf->func_no, epf->vfunc_no, *=
vq_phys,
> > +                            vq_addr, vq_size);
> > +     if (err) {
> > +             pr_err("Failed to map virtuqueue to local");
> > +             goto err_free;
> > +     }
> > +
> > +     return vq_virt;
> > +
> > +err_free:
> > +     pci_epc_mem_free_addr(epf->epc, *vq_phys, vq_virt, vq_size);
> > +
> > +     return ERR_PTR(err);
> > +}
> > +
> > +static void epf_virtio_unmap_vq(struct pci_epf *epf, void __iomem *vq_=
virt,
> > +                             phys_addr_t vq_phys, size_t size)
> > +{
> > +     pci_epc_unmap_addr(epf->epc, epf->func_no, epf->vfunc_no, vq_phys=
);
> > +     pci_epc_mem_free_addr(epf->epc, vq_phys, vq_virt,
> > +                           vring_size(size, VIRTIO_PCI_VRING_ALIGN));
> > +}
> > +
> > +/**
> > + * pci_epf_virtio_alloc_vringh() - allocate epf vringh from @pfn
> > + * @epf: the EPF device that communicates to host virtio dirver
> > + * @features: the virtio features of device
> > + * @pfn: page frame number of virtqueue located on host memory. It is
> > + *           passed during virtqueue negotiation.
> > + * @size: a length of virtqueue
> > + */
> > +struct pci_epf_vringh *pci_epf_virtio_alloc_vringh(struct pci_epf *epf=
,
> > +                                                u64 features, u32 pfn,
> > +                                                size_t size)
> > +{
> > +     int err;
> > +     struct vring vring;
> > +     struct pci_epf_vringh *evrh;
> > +
> > +     evrh =3D kmalloc(sizeof(*evrh), GFP_KERNEL);
> > +     if (!evrh) {
> > +             err =3D -ENOMEM;
> > +             goto err_unmap_vq;
> > +     }
> > +
> > +     evrh->size =3D size;
> > +
> > +     evrh->virt =3D epf_virtio_map_vq(epf, pfn, size, &evrh->phys);
> > +     if (IS_ERR(evrh->virt))
> > +             return evrh->virt;
> > +
> > +     vring_init(&vring, size, evrh->virt, VIRTIO_PCI_VRING_ALIGN);
> > +
> > +     err =3D vringh_init_iomem(&evrh->vrh, features, size, false, GFP_=
KERNEL,
> > +                             vring.desc, vring.avail, vring.used);
> > +     if (err)
> > +             goto err_free_epf_vq;
> > +
> > +     return evrh;
> > +
> > +err_free_epf_vq:
> > +     kfree(evrh);
> > +
> > +err_unmap_vq:
> > +     epf_virtio_unmap_vq(epf, evrh->virt, evrh->phys, evrh->size);
> > +
> > +     return ERR_PTR(err);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epf_virtio_alloc_vringh);
> > +
> > +/**
> > + * pci_epf_virtio_free_vringh() - release allocated epf vring
> > + * @epf: the EPF device that communicates to host virtio dirver
> > + * @evrh: epf vringh to free
> > + */
> > +void pci_epf_virtio_free_vringh(struct pci_epf *epf,
> > +                             struct pci_epf_vringh *evrh)
> > +{
> > +     epf_virtio_unmap_vq(epf, evrh->virt, evrh->phys, evrh->size);
> > +     kfree(evrh);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epf_virtio_free_vringh);
> > +
> > +MODULE_DESCRIPTION("PCI EP Virtio Library");
> > +MODULE_AUTHOR("Shunsuke Mie <mie@igel.co.jp>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/pci-epf-virtio.h b/include/linux/pci-epf-vir=
tio.h
> > new file mode 100644
> > index 000000000000..ae09087919a9
> > --- /dev/null
> > +++ b/include/linux/pci-epf-virtio.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * PCI Endpoint Function (EPF) for virtio definitions
> > + */
> > +#ifndef __LINUX_PCI_EPF_VIRTIO_H
> > +#define __LINUX_PCI_EPF_VIRTIO_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/vringh.h>
> > +#include <linux/pci-epf.h>
> > +
> > +struct pci_epf_vringh {
> > +     struct vringh vrh;
> > +     void __iomem *virt;
> > +     phys_addr_t phys;
> > +     size_t size;
> > +};
> > +
> > +struct pci_epf_vringh *pci_epf_virtio_alloc_vringh(struct pci_epf *epf=
,
> > +                                                u64 features, u32 pfn,
> > +                                                size_t size);
> > +void pci_epf_virtio_free_vringh(struct pci_epf *epf,
> > +                             struct pci_epf_vringh *evrh);
> > +
> > +#endif // __LINUX_PCI_EPF_VIRTIO_H
> > --
> > 2.25.1
>
Best,
Shunsuke
