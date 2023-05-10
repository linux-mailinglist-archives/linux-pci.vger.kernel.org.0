Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F446FD417
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 05:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjEJDSB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 23:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjEJDR7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 23:17:59 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A423AB6
        for <linux-pci@vger.kernel.org>; Tue,  9 May 2023 20:17:57 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-434891a48b7so1427885137.0
        for <linux-pci@vger.kernel.org>; Tue, 09 May 2023 20:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1683688677; x=1686280677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPxJiRGkaCrn61lCOnrl7xgEJG8gAowFtHGu2LMXyKg=;
        b=fvSZ7Uu0Yo4716kIlMSj10DQLtSY/mCjwhWjV7STIzlQV6M9etuqQ39oQO6TKm3Fy5
         sPIXbIzLF/0jzyTyl1YbyjeBJ6Gao5M9PL3fP6OtlcibcYz4m7i5JMWMMsdJXYn9YEn5
         HQBQyAH7eWtqDFhz70M1RGTfv9F4zVuoI5FJN3AVmlOoZs/mVhOLGYaOEaEKXA5A5IZM
         lwy1tyow6sUkrQy5J+lJJ2Lh4boU8RA0I8dDwfbZ7yS5PACr/CptSnOv6FewdywsixS3
         Ux8Fo4M1gaZE0xZU2NLXH6KB+opJP9Jf6rW8keUKfjtfj647AqyFNXtMN72RsV8mRZzO
         iFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683688677; x=1686280677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPxJiRGkaCrn61lCOnrl7xgEJG8gAowFtHGu2LMXyKg=;
        b=c9ZoHUcNv2wj9RIPuue9AtPYk2nCguXd3eN051heSLQtAOsyLmZ9M7+EBQJrJ4fbWC
         B6lJ0bt4GX3nD6U+l6UEbsLIT4gJpsCPHqdAt+5Id1iU8YKQURoMPvLDygvQyamkk+3r
         4wYtDjzveATgjMLZEjRq9mxIuitzeNQIggkaeWFWah4Sen6A8/Vfc5CTkPX2bfan8Nmk
         UqIcPSMYgKvy4tUiNhweDfnfliXiz+ptM5RmAx9kmWW9pucaJKu1aQ3F11QUHr5yZcV7
         GgNUJjqiS/EqXntNoddsk7O8bmWRHmVEcIajGNEz3p3qa9r4CNm8vUptKeDUVZOroVCk
         1QJw==
X-Gm-Message-State: AC+VfDxgYl35cLId9s8oIxle/NDbOzU8GSzpHZEBT+fz3NQd1+23VtHz
        4AptgChUAzuAezjS0sXdnsyPvZ4aM+3tfrZ87+3aOw==
X-Google-Smtp-Source: ACHHUZ6xRHYh9tp8qJeVLAvA9SxdlbWiYG1PastkFcumGwMdVr0Z1VGpa6akEoQNEF3m31DxYs8ZL2Z8UjNJ8c5Q7mY=
X-Received: by 2002:a67:ad04:0:b0:42c:37fe:b810 with SMTP id
 t4-20020a67ad04000000b0042c37feb810mr6271392vsl.21.1683688676985; Tue, 09 May
 2023 20:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230427104428.862643-1-mie@igel.co.jp> <20230427104428.862643-4-mie@igel.co.jp>
 <CACGkMEsjH8fA2r=0CacK8WK_sUTAcTK7SQ_VwkJpa1rSgDP0dg@mail.gmail.com>
In-Reply-To: <CACGkMEsjH8fA2r=0CacK8WK_sUTAcTK7SQ_VwkJpa1rSgDP0dg@mail.gmail.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Wed, 10 May 2023 12:17:46 +0900
Message-ID: <CANXvt5r7eha_xnExsdS_4yMW8xTJxVzYhMVrXyQkGQe-_ZURBg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] PCI: endpoint: Add EP function driver to
 provide virtio-console functionality
To:     Jason Wang <jasowang@redhat.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Json,
2023=E5=B9=B45=E6=9C=888=E6=97=A5(=E6=9C=88) 13:03 Jason Wang <jasowang@red=
hat.com>:
>
> On Thu, Apr 27, 2023 at 6:44=E2=80=AFPM Shunsuke Mie <mie@igel.co.jp> wro=
te:
> >
> > Add a new PCIe endpoint function driver that works as a pci virtio-cons=
ole
> > device. The console connect to endpoint side console. It enables to
> > communicate PCIe host and endpoint.
> >
> > Architecture is following:
> >
> >  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90         =E2=94=8C=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90
> >  =E2=94=82virtioe     =E2=94=82         =E2=94=82                      =
=E2=94=82virtio      =E2=94=82
> >  =E2=94=82console drv =E2=94=82         =E2=94=9C=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90      =E2=94=82console drv =
=E2=94=82
> >  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=94=82=
(virtio console=E2=94=82      =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=A4
> >  =E2=94=82 virtio bus =E2=94=82         =E2=94=82 device)       =E2=94=
=82=E2=97=84=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA=E2=94=82 virtio b=
us =E2=94=82
> >  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=94=9C=
---------------=E2=94=A4      =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=A4
> >  =E2=94=82            =E2=94=82         =E2=94=82 pci ep virtio =E2=94=
=82                   =E2=94=82
> >  =E2=94=82  pci bus   =E2=94=82         =E2=94=82  console drv  =E2=94=
=82                   =E2=94=82
> >  =E2=94=82            =E2=94=82  pcie   =E2=94=9C=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4                   =E2=94=
=82
> >  =E2=94=82            =E2=94=82 =E2=97=84=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=96=BA =E2=94=82  pci ep Bus   =E2=94=82                 =
  =E2=94=82
> >  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98         =E2=94=94=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98
> >    PCIe Root              PCIe Endpoint
> >
>
> I think it might only works for peer devices like:
>
> net, console or vsock.
Could you tell me what "peer devices" means?

> So there're many choices here, I'd like to know what's the reason for
> you to implement a mediation.
>
> An alternative is to implement a dedicated net, console and vsock
> driver for vringh (CAIF somehow works like this). This would have
> better performance.
Does it mean that the driver also functions as a network driver directly?
>
>
> > This driver has two roles. The first is as a PCIe endpoint virtio conso=
le
> > function, which is implemented using the PCIe endpoint framework and PC=
Ie
> > EP virtio helpers. The second is as a virtual virtio console device
> > connected to the virtio bus on PCIe endpoint Linux.
> >
> > Communication between the two is achieved by copying the virtqueue data
> > between PCIe root and endpoint, respectively.
> >
> > This is a simple implementation and does not include features of
> > virtio-console such as MULTIPORT, EMERG_WRITE, etc. As a result, each
> > virtio console driver only displays /dev/hvc0.
> >
> > As an example of usage, by setting getty to /dev/hvc0, it is possible t=
o
> > login to another host.
> >
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > ---
> > Changes from v2:
> > - Change to use copy functions between kiovs of pci-epf-virtio.
> >
> >  drivers/pci/endpoint/functions/Kconfig        |  12 +
> >  drivers/pci/endpoint/functions/Makefile       |   1 +
> >  drivers/pci/endpoint/functions/pci-epf-vcon.c | 596 ++++++++++++++++++
> >  3 files changed, 609 insertions(+)
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vcon.c
> >
> > diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpo=
int/functions/Kconfig
> > index fa1a6a569a8f..9ce2698b67e1 100644
> > --- a/drivers/pci/endpoint/functions/Kconfig
> > +++ b/drivers/pci/endpoint/functions/Kconfig
> > @@ -44,3 +44,15 @@ config PCI_EPF_VIRTIO
> >         select VHOST_RING_IOMEM
> >         help
> >           Helpers to implement PCI virtio Endpoint function
> > +
> > +config PCI_EPF_VCON
> > +       tristate "PCI Endpoint virito-console driver"
> > +       depends on PCI_ENDPOINT
> > +       select VHOST_RING
> > +       select PCI_EPF_VIRTIO
> > +       help
> > +         PCIe Endpoint virtio-console function implementatino. This mo=
dule
> > +         enables to show the virtio-console as pci device to PCIe host=
 side, and
> > +         another virtual virtio-console device registers to endpoint s=
ystem.
> > +         Those devices are connected virtually and can communicate eac=
h other.
> > +
> > diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endp=
oint/functions/Makefile
> > index a96f127ce900..b4056689ce33 100644
> > --- a/drivers/pci/endpoint/functions/Makefile
> > +++ b/drivers/pci/endpoint/functions/Makefile
> > @@ -7,3 +7,4 @@ obj-$(CONFIG_PCI_EPF_TEST)              +=3D pci-epf-te=
st.o
> >  obj-$(CONFIG_PCI_EPF_NTB)              +=3D pci-epf-ntb.o
> >  obj-$(CONFIG_PCI_EPF_VNTB)             +=3D pci-epf-vntb.o
> >  obj-$(CONFIG_PCI_EPF_VIRTIO)           +=3D pci-epf-virtio.o
> > +obj-$(CONFIG_PCI_EPF_VCON)             +=3D pci-epf-vcon.o
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vcon.c b/drivers/pc=
i/endpoint/functions/pci-epf-vcon.c
> > new file mode 100644
> > index 000000000000..31f4247cd10f
> > --- /dev/null
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vcon.c
> > @@ -0,0 +1,596 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCI Endpoint function driver to impliment virtio-console device
> > + * functionality.
> > + */
> > +#include <linux/pci-epf.h>
> > +#include <linux/virtio_ids.h>
> > +#include <linux/virtio_pci.h>
> > +#include <linux/virtio_console.h>
> > +#include <linux/virtio_ring.h>
> > +
> > +#include "pci-epf-virtio.h"
> > +
> > +static int virtio_queue_size =3D 0x100;
> > +module_param(virtio_queue_size, int, 0444);
> > +MODULE_PARM_DESC(virtio_queue_size, "A length of virtqueue");
> > +
> > +struct epf_vcon {
> > +       /* To access virtqueues on remote host */
> > +       struct epf_virtio evio;
> > +       struct vringh_kiov *rdev_iovs;
> > +
> > +       /* To register a local virtio bus */
> > +       struct virtio_device vdev;
> > +
> > +       /* To access virtqueus of local host driver */
> > +       struct vringh *vdev_vrhs;
> > +       struct vringh_kiov *vdev_iovs;
> > +       struct virtqueue **vdev_vqs;
> > +
> > +       /* For transportation and notification */
> > +       struct workqueue_struct *task_wq;
> > +       struct work_struct raise_irq_work, rx_work, tx_work;
> > +
> > +       /* To retain virtio features. It is commonly used local and rem=
ote. */
> > +       u64 features;
> > +
> > +       /* To show a status whether this driver is ready and the remote=
 is connected */
> > +       bool connected;
> > +};
> > +
> > +enum {
> > +       VCON_VIRTQUEUE_RX,
> > +       VCON_VIRTQUEUE_TX,
> > +       // Should be end of enum
> > +       VCON_VIRTQUEUE_NUM
> > +};
>
> It would be better if we can split the console specific thing out,
> then it allows us to do ethernet and vsock in the future.
I'm planning to implement each virtio device in a separate file.
https://lwn.net/Articles/922124/



> Thanks
>
Best regards,
Shunsuke
