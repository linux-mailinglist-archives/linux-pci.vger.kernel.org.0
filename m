Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7433708D9B
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 04:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjESCC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 22:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjESCC5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 22:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938B3194
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 19:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684461730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3LxIDwxX5oZ/H5qgJAleyIOOnzzqbniVCDVAXDLMI3E=;
        b=Cv7iYu6SVyp9e5//Tgd4aAWT1hqw+IfHCcSqqw30L1fcaGxRbYxbdPlBV+uaXR28RLVXTT
        CG+a1IE5qIK0javueS90sH0Qk8YEY0GTLkn/nDCLnrQ7QvU6NwIF0KtKKNzPZYqmvskXMr
        9pjT19ftr4Sj4nlmuqcqE+58n/kvI7U=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-j-5fp3jmOjC0D8EJbaOd_Q-1; Thu, 18 May 2023 22:02:09 -0400
X-MC-Unique: j-5fp3jmOjC0D8EJbaOd_Q-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f3a7765189so749140e87.0
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 19:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684461727; x=1687053727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LxIDwxX5oZ/H5qgJAleyIOOnzzqbniVCDVAXDLMI3E=;
        b=PGi9Mj3adagI6FDM3gpGXbym1haKiAta5mcuGeWE1/B8hwHfZ/F4mr4ZPnkj1zrlQB
         OPKzvuyFzBNi8AOelChywgPtWsG5OyaQAXYLZc3VgwGmlNf9Q+twzVeOLca9L0AmOOhh
         tWNH/s9B13pixL1AZjwVtbk4fRgF7ymWksqqWTRn87S0Uh0z13qZ8vLgTGxueOfn6C0H
         It7BDWxuydG9SXu3vc5F2OQUIh+GXxqU9BIkTdoy27kaD3CcPpKNaCgKOfml4fT+g5pL
         qTLihQ+hWTvgn/gGoZc2srxaT4jV1yVm2YU7aGOKaTS1D0lpZnYzxlw8sR9nMUjWuXAS
         Tz5g==
X-Gm-Message-State: AC+VfDxtIDYLKI00nV+oSjFrDpL+zgb3miJYZNOD3Wubz2I9HjvuJBb/
        v58FuC3RlIZ62EkiAx+HcC4rNkJDUK7uURTx32PCNi79GQO41lsStY0vz8J6qWFw5ykGQsxOpXY
        RgxqvIXvAQh3dxs81nnM2xX5PyLcPuugvmzfj
X-Received: by 2002:ac2:5612:0:b0:4ed:c7cc:6f12 with SMTP id v18-20020ac25612000000b004edc7cc6f12mr210044lfd.34.1684461727673;
        Thu, 18 May 2023 19:02:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6whPVX/g3XA9o+83szsoUPp5+C2dXI1+p+PRYV3K9auvebjDWKokwY1L4+4bJUpr/8bEe0yh4W3U++26R9dqQ=
X-Received: by 2002:ac2:5612:0:b0:4ed:c7cc:6f12 with SMTP id
 v18-20020ac25612000000b004edc7cc6f12mr210035lfd.34.1684461727327; Thu, 18 May
 2023 19:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230427104428.862643-1-mie@igel.co.jp> <20230427104428.862643-4-mie@igel.co.jp>
 <CACGkMEsjH8fA2r=0CacK8WK_sUTAcTK7SQ_VwkJpa1rSgDP0dg@mail.gmail.com>
 <CANXvt5r7eha_xnExsdS_4yMW8xTJxVzYhMVrXyQkGQe-_ZURBg@mail.gmail.com> <ad3dd4ef-3489-683c-c9e1-2592621687f7@igel.co.jp>
In-Reply-To: <ad3dd4ef-3489-683c-c9e1-2592621687f7@igel.co.jp>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 19 May 2023 10:01:56 +0800
Message-ID: <CACGkMEvdVHQEcDD74TpeWgmHQ+J9aMpv5ui=iwT8E_SDZoY7EA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] PCI: endpoint: Add EP function driver to
 provide virtio-console functionality
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 18, 2023 at 5:54=E2=80=AFPM Shunsuke Mie <mie@igel.co.jp> wrote=
:
>
> Gentle ping ...
>
>
> Thanks,
>
> Shunsuke.
>
> On 2023/05/10 12:17, Shunsuke Mie wrote:
> > Hi Json,
> > 2023=E5=B9=B45=E6=9C=888=E6=97=A5(=E6=9C=88) 13:03 Jason Wang <jasowang=
@redhat.com>:
> >> On Thu, Apr 27, 2023 at 6:44=E2=80=AFPM Shunsuke Mie <mie@igel.co.jp> =
wrote:
> >>> Add a new PCIe endpoint function driver that works as a pci virtio-co=
nsole
> >>> device. The console connect to endpoint side console. It enables to
> >>> communicate PCIe host and endpoint.
> >>>
> >>> Architecture is following:
> >>>
> >>>   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90         =E2=94=
=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90
> >>>   =E2=94=82virtioe     =E2=94=82         =E2=94=82                   =
   =E2=94=82virtio      =E2=94=82
> >>>   =E2=94=82console drv =E2=94=82         =E2=94=9C=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90      =E2=94=82console d=
rv =E2=94=82
> >>>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=94=
=82(virtio console=E2=94=82      =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=A4
> >>>   =E2=94=82 virtio bus =E2=94=82         =E2=94=82 device)       =E2=
=94=82=E2=97=84=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA=E2=94=82 virti=
o bus =E2=94=82
> >>>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=94=
=9C---------------=E2=94=A4      =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=A4
> >>>   =E2=94=82            =E2=94=82         =E2=94=82 pci ep virtio =E2=
=94=82                   =E2=94=82
> >>>   =E2=94=82  pci bus   =E2=94=82         =E2=94=82  console drv  =E2=
=94=82                   =E2=94=82
> >>>   =E2=94=82            =E2=94=82  pcie   =E2=94=9C=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4                   =E2=
=94=82
> >>>   =E2=94=82            =E2=94=82 =E2=97=84=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=96=BA =E2=94=82  pci ep Bus   =E2=94=82              =
     =E2=94=82
> >>>   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98         =E2=94=
=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98
> >>>     PCIe Root              PCIe Endpoint
> >>>
> >> I think it might only works for peer devices like:
> >>
> >> net, console or vsock.
> > Could you tell me what "peer devices" means?

I meant, for example we know in the case of virtio-net, TX can talk
with RX belonging to another device directly.

But this is not the case for other devices like virito-blk.

> >
> >> So there're many choices here, I'd like to know what's the reason for
> >> you to implement a mediation.
> >>
> >> An alternative is to implement a dedicated net, console and vsock
> >> driver for vringh (CAIF somehow works like this). This would have
> >> better performance.
> > Does it mean that the driver also functions as a network driver directl=
y?

I meant, e.g in the case of networking, you can have a dedicated
driver with two vringh in the endpoint side.

The benefit is the performance, no need for the (datapath) mediation.

But if we don't care about the performance, this proposal seems to be fine.

Thanks

> >>
> >>> This driver has two roles. The first is as a PCIe endpoint virtio con=
sole
> >>> function, which is implemented using the PCIe endpoint framework and =
PCIe
> >>> EP virtio helpers. The second is as a virtual virtio console device
> >>> connected to the virtio bus on PCIe endpoint Linux.
> >>>
> >>> Communication between the two is achieved by copying the virtqueue da=
ta
> >>> between PCIe root and endpoint, respectively.
> >>>
> >>> This is a simple implementation and does not include features of
> >>> virtio-console such as MULTIPORT, EMERG_WRITE, etc. As a result, each
> >>> virtio console driver only displays /dev/hvc0.
> >>>
> >>> As an example of usage, by setting getty to /dev/hvc0, it is possible=
 to
> >>> login to another host.
> >>>
> >>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> >>> ---
> >>> Changes from v2:
> >>> - Change to use copy functions between kiovs of pci-epf-virtio.
> >>>
> >>>   drivers/pci/endpoint/functions/Kconfig        |  12 +
> >>>   drivers/pci/endpoint/functions/Makefile       |   1 +
> >>>   drivers/pci/endpoint/functions/pci-epf-vcon.c | 596 +++++++++++++++=
+++
> >>>   3 files changed, 609 insertions(+)
> >>>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-vcon.c
> >>>
> >>> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/end=
point/functions/Kconfig
> >>> index fa1a6a569a8f..9ce2698b67e1 100644
> >>> --- a/drivers/pci/endpoint/functions/Kconfig
> >>> +++ b/drivers/pci/endpoint/functions/Kconfig
> >>> @@ -44,3 +44,15 @@ config PCI_EPF_VIRTIO
> >>>          select VHOST_RING_IOMEM
> >>>          help
> >>>            Helpers to implement PCI virtio Endpoint function
> >>> +
> >>> +config PCI_EPF_VCON
> >>> +       tristate "PCI Endpoint virito-console driver"
> >>> +       depends on PCI_ENDPOINT
> >>> +       select VHOST_RING
> >>> +       select PCI_EPF_VIRTIO
> >>> +       help
> >>> +         PCIe Endpoint virtio-console function implementatino. This =
module
> >>> +         enables to show the virtio-console as pci device to PCIe ho=
st side, and
> >>> +         another virtual virtio-console device registers to endpoint=
 system.
> >>> +         Those devices are connected virtually and can communicate e=
ach other.
> >>> +
> >>> diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/en=
dpoint/functions/Makefile
> >>> index a96f127ce900..b4056689ce33 100644
> >>> --- a/drivers/pci/endpoint/functions/Makefile
> >>> +++ b/drivers/pci/endpoint/functions/Makefile
> >>> @@ -7,3 +7,4 @@ obj-$(CONFIG_PCI_EPF_TEST)              +=3D pci-epf-=
test.o
> >>>   obj-$(CONFIG_PCI_EPF_NTB)              +=3D pci-epf-ntb.o
> >>>   obj-$(CONFIG_PCI_EPF_VNTB)             +=3D pci-epf-vntb.o
> >>>   obj-$(CONFIG_PCI_EPF_VIRTIO)           +=3D pci-epf-virtio.o
> >>> +obj-$(CONFIG_PCI_EPF_VCON)             +=3D pci-epf-vcon.o
> >>> diff --git a/drivers/pci/endpoint/functions/pci-epf-vcon.c b/drivers/=
pci/endpoint/functions/pci-epf-vcon.c
> >>> new file mode 100644
> >>> index 000000000000..31f4247cd10f
> >>> --- /dev/null
> >>> +++ b/drivers/pci/endpoint/functions/pci-epf-vcon.c
> >>> @@ -0,0 +1,596 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * PCI Endpoint function driver to impliment virtio-console device
> >>> + * functionality.
> >>> + */
> >>> +#include <linux/pci-epf.h>
> >>> +#include <linux/virtio_ids.h>
> >>> +#include <linux/virtio_pci.h>
> >>> +#include <linux/virtio_console.h>
> >>> +#include <linux/virtio_ring.h>
> >>> +
> >>> +#include "pci-epf-virtio.h"
> >>> +
> >>> +static int virtio_queue_size =3D 0x100;
> >>> +module_param(virtio_queue_size, int, 0444);
> >>> +MODULE_PARM_DESC(virtio_queue_size, "A length of virtqueue");
> >>> +
> >>> +struct epf_vcon {
> >>> +       /* To access virtqueues on remote host */
> >>> +       struct epf_virtio evio;
> >>> +       struct vringh_kiov *rdev_iovs;
> >>> +
> >>> +       /* To register a local virtio bus */
> >>> +       struct virtio_device vdev;
> >>> +
> >>> +       /* To access virtqueus of local host driver */
> >>> +       struct vringh *vdev_vrhs;
> >>> +       struct vringh_kiov *vdev_iovs;
> >>> +       struct virtqueue **vdev_vqs;
> >>> +
> >>> +       /* For transportation and notification */
> >>> +       struct workqueue_struct *task_wq;
> >>> +       struct work_struct raise_irq_work, rx_work, tx_work;
> >>> +
> >>> +       /* To retain virtio features. It is commonly used local and r=
emote. */
> >>> +       u64 features;
> >>> +
> >>> +       /* To show a status whether this driver is ready and the remo=
te is connected */
> >>> +       bool connected;
> >>> +};
> >>> +
> >>> +enum {
> >>> +       VCON_VIRTQUEUE_RX,
> >>> +       VCON_VIRTQUEUE_TX,
> >>> +       // Should be end of enum
> >>> +       VCON_VIRTQUEUE_NUM
> >>> +};
> >> It would be better if we can split the console specific thing out,
> >> then it allows us to do ethernet and vsock in the future.
> > I'm planning to implement each virtio device in a separate file.
> > https://lwn.net/Articles/922124/
> >
> >
> >
> >> Thanks
> >>
> > Best regards,
> > Shunsuke
>

