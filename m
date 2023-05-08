Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0386F9E73
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 05:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjEHD6E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 May 2023 23:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjEHD6D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 May 2023 23:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC22F3A8D
        for <linux-pci@vger.kernel.org>; Sun,  7 May 2023 20:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683518235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i91vpv5xI9eOoiC7RRdi6WyfJZYJucuHqIMPJTLnImA=;
        b=DgcD4U/kffSFos8uzqS2CL8if/uqcgQDth+xpR7MfS1FkX8betTHvdVbdkBEgZ3Np6FzHH
        NRVx9pC+oNT4yJBsJSBgn2lq1aFnco6ODCcKQv4s9FVyPR3+DwIRi843A3yZP9OoprgWeX
        30oDX09VB2TrwEemdpX/SUsjwVbx7G0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-FRenL5YXNge051ZoXgu90A-1; Sun, 07 May 2023 23:57:13 -0400
X-MC-Unique: FRenL5YXNge051ZoXgu90A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ac98a3d564so8565491fa.3
        for <linux-pci@vger.kernel.org>; Sun, 07 May 2023 20:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683518232; x=1686110232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i91vpv5xI9eOoiC7RRdi6WyfJZYJucuHqIMPJTLnImA=;
        b=EQzUufY/x4O3DwC01YBwnNYPdtrm1SsVWql1qiCzh3/iRb3QcvwodvIwHF8VgTA04G
         +zJM6Y4qgG1AsM+FpeGECvRauseKiJ9jj0qF9Ml/tFPQjfo5YvfNztZYa+R9gFgtVdUX
         5BferHxuihNt9l5W37M8jTlTmXuUDSkH3kPXsCo6eNwKidy9M3rlChc7qqOOyLXufciQ
         5cPfPbcwPMshK9GGC2cOwgPLRSU/1jDIEyduIPkZBaV2P76BXkf/0hFAD8Sr/E6b8sV2
         57uG6tTy7tL7P01drZcqSEeH0gvgxYqmqAtfR5m2mmrjdvpyZC6dNCa+zjJ/oerslyJj
         l3fQ==
X-Gm-Message-State: AC+VfDz6EuUW/QAOaS2IVuegEWFp0RYL+59qgCUFzfnn1eIuIOHxIeoD
        DAdIMzUp5PJ53bgiPAnDT7ktrSWcOr0yTVC+7KGCJt57Plq1Yd/DLjzOCR0EIPfaPVi5I1/B9sx
        xrCkfOHXPhhXU1YB2oPL1ZxwGyOjlpfhJBc0/
X-Received: by 2002:a2e:a3d7:0:b0:2a7:6e2e:20e0 with SMTP id w23-20020a2ea3d7000000b002a76e2e20e0mr2358989lje.7.1683518232251;
        Sun, 07 May 2023 20:57:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5u93lIq7NaRxNHzxCXrGIqso8w+PBjqeamQ31AANjgSg0MuDhWLywZFKK4cjWi4nwTnqWmmQ3Hg5Sm1/42Vmg=
X-Received: by 2002:a2e:a3d7:0:b0:2a7:6e2e:20e0 with SMTP id
 w23-20020a2ea3d7000000b002a76e2e20e0mr2358978lje.7.1683518231831; Sun, 07 May
 2023 20:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230427104428.862643-1-mie@igel.co.jp> <20230427104428.862643-2-mie@igel.co.jp>
In-Reply-To: <20230427104428.862643-2-mie@igel.co.jp>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 8 May 2023 11:57:00 +0800
Message-ID: <CACGkMEsuyHAg=iq_w=jOyjbx5YK2GDF_=RCX-ncqDvEiVMu+Jg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] PCI: endpoint: introduce a helper to implement
 pci ep virtio function
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 27, 2023 at 6:44=E2=80=AFPM Shunsuke Mie <mie@igel.co.jp> wrote=
:
>
> The Linux PCIe Endpoint framework supports to implement PCIe endpoint
> functions using a PCIe controller operating in endpoint mode.
> It is possble to realize the behavior of PCIe device, such as virtio PCI
> device. This patch introduces a setof helper functions and data structure=
s
> to implement a PCIe endpoint function that behaves as a virtio device.
>
> Those functions enable the implementation PCIe endpoint function that
> comply with the virtio lecacy specification. Because modern virtio
> specifications require devices to implement custom PCIe capabilities, whi=
ch
> are not currently supported by either PCIe controllers/drivers or the PCI=
e
> endpoint framework.
>
> The helper functions work with the new struct epf_virtio, which is
> initialized and finalized using the following functions:
>
> - int epf_virtio_init();
> - void epf_virtio_final()
>
> Once initialized, the PCIe configuration space can be read and written
> using the following functions:
>
> - epf_virtio_cfg_{read,write}#size()
> - epf_virtio_cfg_{set,clear}#size()
> - epf_virtio_cfg_memcpy_toio()
>
> The size is supported 8, 16 and 32bits. The content of configuration spac=
e
> varies depending on the type of virtio device.
>
> After the setup, launch the kernel thread for negotiation with host virti=
o
> drivers and detection virtqueue notifications with the function:
>
> - epf_virtio_launch_bgtask()
>
> Also there are functions to shutdown and reset the kthread.
>
> - epf_virtio_terminate_bgtask()
> - epf_virtio_terminate_reset()
>
> Data transfer function is also provide.
>
> - epf_virtio_memcpy_kiov2kiov()
>
> While this patch provides functions for negotiating with host drivers and
> copying data, each PCIe function driver must impl ement operations that
> depend on each specific device, such as network, block, etc.
>
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>
> Changes from v2:
> - Improve the memcpy function between kiov and kiov on local ram and
> remote ram via pcie bus.
>
>  drivers/pci/endpoint/functions/Kconfig        |   7 +
>  drivers/pci/endpoint/functions/Makefile       |   1 +
>  .../pci/endpoint/functions/pci-epf-virtio.c   | 458 ++++++++++++++++++
>  .../pci/endpoint/functions/pci-epf-virtio.h   | 126 +++++
>  4 files changed, 592 insertions(+)
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-virtio.c
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-virtio.h
>
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoin=
t/functions/Kconfig
> index 9fd560886871..fa1a6a569a8f 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -37,3 +37,10 @@ config PCI_EPF_VNTB
>           between PCI Root Port and PCIe Endpoint.
>
>           If in doubt, say "N" to disable Endpoint NTB driver.
> +
> +config PCI_EPF_VIRTIO
> +       tristate
> +       depends on PCI_ENDPOINT
> +       select VHOST_RING_IOMEM
> +       help
> +         Helpers to implement PCI virtio Endpoint function
> diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoi=
nt/functions/Makefile
> index 5c13001deaba..a96f127ce900 100644
> --- a/drivers/pci/endpoint/functions/Makefile
> +++ b/drivers/pci/endpoint/functions/Makefile
> @@ -6,3 +6,4 @@
>  obj-$(CONFIG_PCI_EPF_TEST)             +=3D pci-epf-test.o
>  obj-$(CONFIG_PCI_EPF_NTB)              +=3D pci-epf-ntb.o
>  obj-$(CONFIG_PCI_EPF_VNTB)             +=3D pci-epf-vntb.o
> +obj-$(CONFIG_PCI_EPF_VIRTIO)           +=3D pci-epf-virtio.o
> diff --git a/drivers/pci/endpoint/functions/pci-epf-virtio.c b/drivers/pc=
i/endpoint/functions/pci-epf-virtio.c
> new file mode 100644
> index 000000000000..f67610dd247d
> --- /dev/null
> +++ b/drivers/pci/endpoint/functions/pci-epf-virtio.c
> @@ -0,0 +1,458 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Helpers to implement PCIe virtio EP function.
> + */
> +#include <linux/virtio_pci.h>
> +#include <linux/virtio_config.h>
> +#include <linux/kthread.h>
> +
> +#include "pci-epf-virtio.h"
> +
> +static void epf_virtio_unmap_vq(struct pci_epf *epf, void __iomem *vq_vi=
rt,
> +                               phys_addr_t vq_phys, unsigned int num)
> +{
> +       size_t vq_size =3D vring_size(num, VIRTIO_PCI_VRING_ALIGN);
> +
> +       pci_epc_unmap_addr(epf->epc, epf->func_no, epf->vfunc_no, vq_phys=
,
> +                          vq_virt, vq_size);
> +       pci_epc_mem_free_addr(epf->epc, vq_phys, vq_virt, vq_size);
> +}
> +
> +static void __iomem *epf_virtio_map_vq(struct pci_epf *epf,
> +                                      phys_addr_t vq_pci_addr,
> +                                      unsigned int num, phys_addr_t *vq_=
phys)
> +{
> +       int err;
> +       size_t vq_size;
> +       void __iomem *vq_virt;
> +
> +       vq_size =3D vring_size(num, VIRTIO_PCI_VRING_ALIGN);
> +
> +       vq_virt =3D pci_epc_map_addr(epf->epc, epf->func_no, epf->vfunc_n=
o,
> +                                  vq_pci_addr, vq_phys, vq_size);
> +       if (IS_ERR(vq_virt)) {
> +               pr_err("Failed to map virtuqueue to local");
> +               goto err_free;
> +       }
> +
> +       return vq_virt;
> +
> +err_free:
> +       pci_epc_mem_free_addr(epf->epc, *vq_phys, vq_virt, vq_size);
> +
> +       return ERR_PTR(err);
> +}
> +
> +static void epf_virtio_free_vringh(struct pci_epf *epf, struct epf_vring=
h *evrh)
> +{
> +       epf_virtio_unmap_vq(epf, evrh->virt, evrh->phys, evrh->num);
> +       kfree(evrh);
> +}
> +
> +static struct epf_vringh *epf_virtio_alloc_vringh(struct pci_epf *epf,
> +                                                 u64 features,
> +                                                 phys_addr_t pci_addr,
> +                                                 unsigned int num)
> +{
> +       int err;
> +       struct vring vring;
> +       struct epf_vringh *evrh;
> +
> +       evrh =3D kmalloc(sizeof(*evrh), GFP_KERNEL);
> +       if (!evrh) {
> +               err =3D -ENOMEM;
> +               goto err_unmap_vq;
> +       }
> +
> +       evrh->num =3D num;
> +
> +       evrh->virt =3D epf_virtio_map_vq(epf, pci_addr, num, &evrh->phys)=
;
> +       if (IS_ERR(evrh->virt))
> +               return evrh->virt;
> +
> +       vring_init(&vring, num, evrh->virt, VIRTIO_PCI_VRING_ALIGN);
> +
> +       err =3D vringh_init_iomem(&evrh->vrh, features, num, false, vring=
.desc,
> +                               vring.avail, vring.used);
> +       if (err)
> +               goto err_free_epf_vq;
> +
> +       return evrh;
> +
> +err_free_epf_vq:
> +       kfree(evrh);
> +
> +err_unmap_vq:
> +       epf_virtio_unmap_vq(epf, evrh->virt, evrh->phys, evrh->num);
> +
> +       return ERR_PTR(err);
> +}
> +
> +#define VIRTIO_PCI_LEGACY_CFG_BAR 0
> +
> +static void __iomem *epf_virtio_alloc_bar(struct pci_epf *epf, size_t si=
ze)
> +{
> +       struct pci_epf_bar *config_bar =3D &epf->bar[VIRTIO_PCI_LEGACY_CF=
G_BAR];
> +       const struct pci_epc_features *features;
> +       void __iomem *bar;
> +       int err;
> +
> +       features =3D pci_epc_get_features(epf->epc, epf->func_no, epf->vf=
unc_no);
> +       if (!features) {
> +               pr_debug("Failed to get PCI EPC features\n");
> +               return ERR_PTR(-EOPNOTSUPP);
> +       }
> +
> +       if (features->reserved_bar & BIT(VIRTIO_PCI_LEGACY_CFG_BAR)) {
> +               pr_debug("Cannot use the PCI BAR for legacy virtio pci\n"=
);
> +               return ERR_PTR(-EOPNOTSUPP);

Since 1.0 has been used for years, I would suggest starting from a
modern device other than a legacy one. Otherwise you may end up with
some hacky stuffs more below.

> +       }
> +
> +       if (features->bar_fixed_size[VIRTIO_PCI_LEGACY_CFG_BAR]) {
> +               if (size >
> +                   features->bar_fixed_size[VIRTIO_PCI_LEGACY_CFG_BAR]) =
{
> +                       pr_debug("PCI BAR size is not enough\n");
> +                       return ERR_PTR(-ENOMEM);
> +               }
> +       }
> +
> +       bar =3D pci_epf_alloc_space(epf, size, VIRTIO_PCI_LEGACY_CFG_BAR,
> +                                 features->align, PRIMARY_INTERFACE);
> +       if (!bar) {
> +               pr_debug("Failed to allocate virtio-net config memory\n")=
;
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       config_bar->flags |=3D PCI_BASE_ADDRESS_MEM_TYPE_64;

This is the tricky part:

1) spec said legacy bar is I/O not memory
2) this code may still work if the host is running with Linux since
the virtio driver work for memory bar
3) but it may not work if the host is not running with Linux

> +       err =3D pci_epc_set_bar(epf->epc, epf->func_no, epf->vfunc_no,
> +                             config_bar);
> +       if (err) {
> +               pr_debug("Failed to set PCI BAR");
> +               goto err_free_space;
> +       }
> +
> +       return bar;
> +
> +err_free_space:
> +
> +       pci_epf_free_space(epf, bar, VIRTIO_PCI_LEGACY_CFG_BAR,
> +                          PRIMARY_INTERFACE);
> +
> +       return ERR_PTR(err);
> +}
> +
> +static void epf_virtio_free_bar(struct pci_epf *epf, void __iomem *bar)
> +{
> +       struct pci_epf_bar *config_bar =3D &epf->bar[VIRTIO_PCI_LEGACY_CF=
G_BAR];
> +
> +       pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no, config_b=
ar);
> +       pci_epf_free_space(epf, bar, VIRTIO_PCI_LEGACY_CFG_BAR,
> +                          PRIMARY_INTERFACE);
> +}
> +
> +static void epf_virtio_init_bar(struct epf_virtio *evio, void __iomem *b=
ar)
> +{
> +       evio->bar =3D bar;
> +
> +       epf_virtio_cfg_write32(evio, VIRTIO_PCI_HOST_FEATURES, evio->feat=
ures);
> +       epf_virtio_cfg_write16(evio, VIRTIO_PCI_ISR, VIRTIO_PCI_ISR_QUEUE=
);
> +       epf_virtio_cfg_write16(evio, VIRTIO_PCI_QUEUE_NUM, evio->vqlen);
> +       epf_virtio_cfg_write16(evio, VIRTIO_PCI_QUEUE_NOTIFY, evio->nvq);
> +       epf_virtio_cfg_write8(evio, VIRTIO_PCI_STATUS, 0);
> +}
> +
> +/**
> + * epf_virtio_init - initialize struct epf_virtio and setup BAR for virt=
io
> + * @evio: struct epf_virtio to initialize.
> + * @hdr: pci configuration space to show remote host.
> + * @bar_size: pci BAR size it depends on the virtio device type.
> + *
> + * Returns zero or a negative error.
> + */
> +int epf_virtio_init(struct epf_virtio *evio, struct pci_epf_header *hdr,
> +                   size_t bar_size)
> +{
> +       struct pci_epf *epf =3D evio->epf;
> +       void __iomem *bar;
> +       int err;
> +
> +       err =3D pci_epc_write_header(epf->epc, epf->func_no, epf->vfunc_n=
o, hdr);
> +       if (err)
> +               return err;
> +
> +       bar =3D epf_virtio_alloc_bar(epf, bar_size);
> +       if (IS_ERR(bar))
> +               return PTR_ERR(bar);
> +
> +       epf_virtio_init_bar(evio, bar);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(epf_virtio_init);
> +
> +/**
> + * epf_virtio_final - finalize struct epf_virtio. it frees bar and memor=
ies
> + * @evio: struct epf_virtio to finalize.
> + */
> +void epf_virtio_final(struct epf_virtio *evio)
> +{
> +       epf_virtio_free_bar(evio->epf, evio->bar);
> +
> +       for (int i =3D 0; i < evio->nvq; i++)
> +               epf_virtio_free_vringh(evio->epf, evio->vrhs[i]);
> +
> +       kfree(evio->vrhs);
> +}
> +EXPORT_SYMBOL_GPL(epf_virtio_final);
> +
> +static int epf_virtio_negotiate_vq(struct epf_virtio *evio)
> +{
> +       u32 pfn;
> +       u16 sel;
> +       int i =3D 0;
> +       struct _pair {
> +               u32 pfn;
> +               u16 sel;
> +       } *tmp;
> +       int err =3D 0;
> +       size_t nvq =3D evio->nvq;
> +
> +       tmp =3D kmalloc_array(nvq, sizeof(tmp[0]), GFP_KERNEL);
> +       if (!tmp)
> +               return -ENOMEM;
> +
> +       /*
> +        * PCIe EP framework has no capability to hook access PCI BAR spa=
ce from
> +        * remote host driver, so poll the specific register, queue pfn t=
o detect
> +        * the writing from the driver.

There were discussions in the past which tried to have a new transport
that works for the endpoint instead of doing tricks like this. Have
you ever considered this?

> +        *
> +        * This implementation assumes that the address of each virtqueue=
 is
> +        * written only once.
> +        */
> +       for (i =3D 0; i < nvq; i++) {
> +               while (!(pfn =3D epf_virtio_cfg_read32(evio,
> +                                                    VIRTIO_PCI_QUEUE_PFN=
)) &&
> +                      evio->running)
> +                       ;

Should we do cond_resched() here?

> +
> +               sel =3D epf_virtio_cfg_read16(evio, VIRTIO_PCI_QUEUE_SEL)=
;
> +
> +               epf_virtio_cfg_write32(evio, VIRTIO_PCI_QUEUE_PFN, 0);
> +
> +               tmp[i].pfn =3D pfn;
> +               tmp[i].sel =3D sel;
> +       }
> +
> +       if (!evio->running)
> +               goto err_out;
> +
> +       evio->vrhs =3D kmalloc_array(nvq, sizeof(evio->vrhs[0]), GFP_KERN=
EL);
> +       if (!evio->vrhs) {
> +               err =3D -ENOMEM;
> +               goto err_out;
> +       }
> +
> +       for (i =3D 0; i < nvq; i++) {
> +               phys_addr_t pci =3D tmp[i].pfn << VIRTIO_PCI_QUEUE_ADDR_S=
HIFT;
> +
> +               evio->vrhs[i] =3D epf_virtio_alloc_vringh(
> +                       evio->epf, evio->features, pci, evio->vqlen);
> +               if (IS_ERR(evio->vrhs[i])) {
> +                       err =3D PTR_ERR(evio->vrhs[i]);
> +                       goto err_free_evrhs;
> +               }
> +       }
> +
> +       kfree(tmp);
> +
> +       return 0;
> +
> +err_free_evrhs:
> +       for (i -=3D 1; i > 0; i--)
> +               epf_virtio_free_vringh(evio->epf, evio->vrhs[i]);
> +
> +       kfree(evio->vrhs);
> +
> +err_out:
> +       kfree(tmp);
> +
> +       return err;
> +}
> +
> +static void epf_virtio_monitor_qnotify(struct epf_virtio *evio)
> +{
> +       const u16 qn_default =3D evio->nvq;
> +       u16 tmp;
> +
> +       /* Since there is no way to synchronize between the host and EP f=
unctions,
> +        * it is possible to miss multiple notifications.
> +        */
> +       while (evio->running) {
> +               tmp =3D epf_virtio_cfg_read16(evio, VIRTIO_PCI_QUEUE_NOTI=
FY);
> +               if (tmp =3D=3D qn_default)
> +                       continue;

cond_resched()?

> +
> +               epf_virtio_cfg_write16(evio, VIRTIO_PCI_QUEUE_NOTIFY,
> +                                      qn_default);
> +
> +               evio->qn_callback(evio->qn_param);
> +       }
> +}
> +
> +static int epf_virtio_bgtask(void *param)
> +{
> +       struct epf_virtio *evio =3D param;
> +       int err;
> +
> +       err =3D epf_virtio_negotiate_vq(evio);
> +       if (err < 0) {
> +               pr_err("failed to negoticate configs with driver\n");
> +               return err;
> +       }
> +
> +       while (!(epf_virtio_cfg_read8(evio, VIRTIO_PCI_STATUS) &
> +                VIRTIO_CONFIG_S_DRIVER_OK) &&
> +              evio->running)
> +               ;
> +
> +       if (evio->ic_callback && evio->running)
> +               evio->ic_callback(evio->ic_param);
> +
> +       epf_virtio_monitor_qnotify(evio);
> +
> +       return 0;
> +}
> +
> +/**
> + * epf_virtio_launch_bgtask - spawn a kthread that emulates virtio devic=
e
> + * operations.
> + * @evio: It should be initialized prior with epf_virtio_init().
> + *
> + * Returns zero or a negative error.
> + */
> +int epf_virtio_launch_bgtask(struct epf_virtio *evio)
> +{
> +       evio->bgtask =3D kthread_create(epf_virtio_bgtask, evio,
> +                                     "pci-epf-virtio/bgtask");
> +       if (IS_ERR(evio->bgtask))
> +               return PTR_ERR(evio->bgtask);
> +
> +       evio->running =3D true;
> +
> +       sched_set_fifo(evio->bgtask);
> +       wake_up_process(evio->bgtask);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(epf_virtio_launch_bgtask);
> +
> +/**
> + * epf_virtio_terminate_bgtask - shutdown a device emulation kthread.
> + * @evio: struct epf_virtio it already launched bgtask.
> + */
> +void epf_virtio_terminate_bgtask(struct epf_virtio *evio)
> +{
> +       evio->running =3D false;
> +
> +       kthread_stop(evio->bgtask);
> +}
> +EXPORT_SYMBOL_GPL(epf_virtio_terminate_bgtask);
> +
> +/**
> + * epf_virtio_reset - reset virtio status
> + * @evio: struct epf_virtio to reset
> + *
> + * Returns zero or a negative error.
> + */
> +int epf_virtio_reset(struct epf_virtio *evio)
> +{
> +       epf_virtio_terminate_bgtask(evio);
> +       epf_virtio_init_bar(evio, evio->bar);
> +
> +       return epf_virtio_launch_bgtask(evio);
> +}
> +EXPORT_SYMBOL_GPL(epf_virtio_reset);
> +
> +int epf_virtio_getdesc(struct epf_virtio *evio, int index,
> +                      struct vringh_kiov *riov, struct vringh_kiov *wiov=
,
> +                      u16 *head)
> +{
> +       struct vringh *vrh =3D &evio->vrhs[index]->vrh;
> +
> +       return vringh_getdesc_iomem(vrh, riov, wiov, head, GFP_KERNEL);
> +}
> +
> +void epf_virtio_abandon(struct epf_virtio *evio, int index, int num)
> +{
> +       struct vringh *vrh =3D &evio->vrhs[index]->vrh;
> +
> +       vringh_abandon_iomem(vrh, num);
> +}
> +
> +void epf_virtio_iov_complete(struct epf_virtio *evio, int index, u16 hea=
d,
> +                            size_t total_len)
> +{
> +       struct vringh *vrh =3D &evio->vrhs[index]->vrh;
> +
> +       vringh_complete_iomem(vrh, head, total_len);
> +}
> +
> +int epf_virtio_memcpy_kiov2kiov(struct epf_virtio *evio,
> +                               struct vringh_kiov *siov,
> +                               struct vringh_kiov *diov,
> +                               enum dma_transfer_direction dir)
> +{
> +       struct pci_epf *epf =3D evio->epf;
> +       size_t slen, dlen;
> +       u64 sbase, dbase;
> +       phys_addr_t phys;
> +       void *dst, *src;
> +
> +       for (; siov->i < siov->used; siov->i++, diov->i++) {
> +               slen =3D siov->iov[siov->i].iov_len;
> +               sbase =3D (u64)siov->iov[siov->i].iov_base;
> +               dlen =3D diov->iov[diov->i].iov_len;
> +               dbase =3D (u64)diov->iov[diov->i].iov_base;
> +
> +               if (dlen < slen) {
> +                       pr_info("not enough buffer\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (dir =3D=3D DMA_MEM_TO_DEV) {
> +                       src =3D phys_to_virt(sbase);
> +
> +                       dst =3D pci_epc_map_addr(epf->epc, epf->func_no,
> +                                              epf->vfunc_no, dbase, &phy=
s,
> +                                              slen);
> +                       if (IS_ERR(dst)) {
> +                               pr_err("failed to map pci mmoery spact to=
 local\n");

Typos.

> +                               return PTR_ERR(dst);
> +                       }
> +               } else {
> +                       src =3D pci_epc_map_addr(epf->epc, epf->func_no,
> +                                              epf->vfunc_no, sbase, &phy=
s,
> +                                              slen);
> +                       if (IS_ERR(src)) {
> +                               pr_err("failed to map pci mmoery spact to=
 local\n");

Typos.

Thanks

