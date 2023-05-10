Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF0C6FD382
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 03:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjEJBZg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 21:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjEJBZc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 21:25:32 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B4D2D7E
        for <linux-pci@vger.kernel.org>; Tue,  9 May 2023 18:25:31 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-44ff2f8ec9dso4104575e0c.1
        for <linux-pci@vger.kernel.org>; Tue, 09 May 2023 18:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1683681930; x=1686273930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0ARqn6lUh+8+K75vz/NE3HQE8qKTumvzAuTMNY1vXo=;
        b=UOdGmj2HqWuDuWFZ07gN0GFZa4HwwCBPfIzGLenp/qvEd2r4ggMpmDoVZGnYRbxtah
         oBol6sEQL7XFtEAb62UbScv8R1N0hlTEN9NatwWc8T31ewa08EjnUSH9OzLTwX+1CBZo
         tW8jB2RIy6BaXZtewZNP03ZbyL64/M8me5itTDUoR2G1NnGMpL888cHz5mLmLLPYhvHN
         Uj+syFwvxBIBqxz9DREUdHu5jVZueMCTgb1BrC3SKQmjVe7mXS5BWet+RiiI9EDtNW6j
         7n6UkZ76ztdDpLtJJnhn/uD7CqBD/u8TNujykPOTUkAwdWYbPkim9KOKWyZLvPjBH5HU
         2l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683681930; x=1686273930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0ARqn6lUh+8+K75vz/NE3HQE8qKTumvzAuTMNY1vXo=;
        b=lm9Y2WZjm7psFUr8ZdSEaP8C/8mfMv3Pi+37D0izoYFdmgnwv069ONJMnH7Ytwwjo7
         Kfz6q8sVsSX9SYiVHUGrb0SFoAsYcuPnfUvddCV2QrQkqX5MWQzVq8v0uI785PBH+sjr
         3vu11qqzXZQYyuPDWevjH2xCVPCk9HdM30SVrR16JCj10CUfrUOW/7zZkD79zzjtH4eo
         s9wfVjmWAbHlSJD/OOr5VzOdpejPCRUYs+9z+UiQ2J1aHTvFk1kxilhh8YPEK4auogV2
         v87g1Ilf/yKkxeyeK1mKLD013v2PMj99/0WeVdzLYT5AYaCmaUP1bkenatOqFulswWpq
         YNCA==
X-Gm-Message-State: AC+VfDzfx0YkElVRur9e5S96xGD58XOHJ9au4h9uKCXMxSllEf66RdNR
        VfmeQAbGlmkuJsMw+0wPl+b1xZs5KwX9pgjcYBsvUw==
X-Google-Smtp-Source: ACHHUZ7Bi0L6Y5RYYpzfwbgMQqZU/tca8oH+br74IUhODrNZZunpV78eUf1PcSHKT6yiWgGGNBSQ7pQhnQ9IefTgUFw=
X-Received: by 2002:a1f:c112:0:b0:43f:ea80:e8af with SMTP id
 r18-20020a1fc112000000b0043fea80e8afmr5234632vkf.4.1683681929848; Tue, 09 May
 2023 18:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230427104428.862643-4-mie@igel.co.jp> <20230427180906.GA261441@bhelgaas>
In-Reply-To: <20230427180906.GA261441@bhelgaas>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Wed, 10 May 2023 10:25:19 +0900
Message-ID: <CANXvt5pNH-y-p8Sy3E8o_KNHDjeMb6USZivJVtDmn1rfRqp3wA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] PCI: endpoint: Add EP function driver to
 provide virtio-console functionality
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
Thanks for the many comments. I will fix the mannerisms and typos as noted.

2023=E5=B9=B44=E6=9C=8828=E6=97=A5(=E9=87=91) 3:09 Bjorn Helgaas <helgaas@k=
ernel.org>:
>
> Random typos and trivial things.  No need to repost until somebody
> does a more substantive review.
>
> On Thu, Apr 27, 2023 at 07:44:28PM +0900, Shunsuke Mie wrote:
> > Add a new PCIe endpoint function driver that works as a pci virtio-cons=
ole
> > device. The console connect to endpoint side console. It enables to
> > communicate PCIe host and endpoint.
>
> s/pci/PCI/
>
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
>
> s/virtioe/virtio/
> s/pci/PCI/
> s/pcie/PCIe/
> s/ep/EP/
>
> > +config PCI_EPF_VCON
> > +     tristate "PCI Endpoint virito-console driver"
>
> s/virito/virtio/
>
> > +     depends on PCI_ENDPOINT
> > +     select VHOST_RING
> > +     select PCI_EPF_VIRTIO
> > +     help
> > +       PCIe Endpoint virtio-console function implementatino. This modu=
le
> > +       enables to show the virtio-console as pci device to PCIe host s=
ide, and
> > +       another virtual virtio-console device registers to endpoint sys=
tem.
> > +       Those devices are connected virtually and can communicate each =
other.
>
> s/implementatino/implementation/
> s/pci/PCI/
> s/can communicate/can communicate with/
>
> > + * PCI Endpoint function driver to impliment virtio-console device
> > + * functionality.
>
> s/impliment/implement/
>
> > +static int virtio_queue_size =3D 0x100;
> > +module_param(virtio_queue_size, int, 0444);
> > +MODULE_PARM_DESC(virtio_queue_size, "A length of virtqueue");
>
> When and why would users need this parameter?  Where is it documented?
>
> > +     /* To access virtqueus of local host driver */
>
> s/virtqueus/virtqueues/
>
> > +     /* To show a status whether this driver is ready and the remote i=
s connected */
>
> Make this fit in 80 columns.
>
> > +     /* This is a minimum implementation. Doesn't support any features=
 of
> > +      * virtio console. It means driver and device use just 2 virtuque=
 for tx
> > +      * and rx.
> > +      */
>
> Use common multi-line comment style:
>
>   /*
>    * This is ...
>    */
I'll follow the style.
> s/virtuque/virtqueues/
>
> > +static void epf_vcon_raise_irq_handler(struct work_struct *work)
> > +{
> > +     struct epf_vcon *vcon =3D
> > +             container_of(work, struct epf_vcon, raise_irq_work);
>
> Rewrap.
>
> > +static int epf_vcon_setup_common(struct epf_vcon *vcon)
> > +{
> > +     vcon->features =3D 0;
> > +     vcon->connected =3D false;
> > +
> > +     vcon->task_wq =3D
> > +             alloc_workqueue("pci-epf-vcon/task-wq",
>
> Looks like this would fit on the previous line?
>
> > +                             WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND,=
 0);
>
> > +static void epf_vcon_initialize_complete(void *param)
> > +{
> > +     struct epf_vcon *vcon =3D param;
> > +
> > +     pr_debug("Remote host has connected\n");
>
> Is there any device info you could include here, e.g., with dev_dbg()?
> It's nice if users have a little context.
I see. I'll use it.
> > +static int epf_vcon_setup_ep_func(struct epf_vcon *vcon, struct pci_ep=
f *epf)
> > +{
> > +     int err;
> > +     struct epf_virtio *evio =3D &vcon->evio;
> > +     unsigned int nvq =3D epf_vcon_get_nvq(vcon);
> > +
> > +     vcon->rdev_iovs =3D
> > +             kmalloc_array(nvq, sizeof(vcon->rdev_iovs[0]), GFP_KERNEL=
);
>
> Move the function name and as many parameters as fit in 80 columns to
> the previous line to match prevailing style.
I've just applied clang-format... Ok, I'll fix it manually.
> > +     /* There is no config for virtio console because this console dev=
ice
> > +      * doesn't any support features
> > +      */
>
> Multi-line comment style.
>
> s/doesn't any support/doesn't support any/?  Is that what you mean?
>
> > +     /* Do nothing because this console device doesn't any support fea=
tures */
>
> Same.
>
> > +static void epf_vcon_vdev_set_status(struct virtio_device *vdev, u8 st=
atus)
> > +{
> > +     if (status & VIRTIO_CONFIG_S_FAILED)
> > +             pr_debug("driver failed to setup this device\n");
>
> dev_dbg() if possible.
>
> > +             err =3D vringh_init_kern(&vcon->vdev_vrhs[i], vcon->featu=
res,
> > +                                    virtio_queue_size, false, vring->d=
esc,
> > +                                    vring->avail, vring->used);
> > +             if (err) {
> > +                     pr_err("failed to init vringh for vring %d\n", i)=
;
>
> dev_err() if possible.
>
> > +static int epf_vcon_setup_vdev(struct epf_vcon *vcon, struct device *p=
arent)
> > +{
> > +     int err;
> > +     struct virtio_device *vdev =3D &vcon->vdev;
> > +     const unsigned int nvq =3D epf_vcon_get_nvq(vcon);
> > +
> > +     vcon->vdev_vrhs =3D
> > +             kmalloc_array(nvq, sizeof(vcon->vdev_vrhs[0]), GFP_KERNEL=
);
>
> Rewrap.
>
> > +     vcon->vdev_iovs =3D
> > +             kmalloc_array(nvq, sizeof(vcon->vdev_iovs[0]), GFP_KERNEL=
);
>
> Rewrap.
>
> > +     vcon->vdev_vqs =3D
> > +             kmalloc_array(nvq, sizeof(vcon->vdev_vrhs[0]), GFP_KERNEL=
);
>
> Rewrap.
>
> > +static void epf_vcon_cleanup_vdev(struct epf_vcon *vcon)
> > +{
> > +     unregister_virtio_device(&vcon->vdev);
> > +     /* Cleanup struct virtio_device that has kobject, otherwise error=
 occures when
> > +      * reregister the virtio device.
> > +      */
>
> Multi-line style and rewrap to fit in 80 columns.
>
> > +static int __init epf_vcon_init(void)
> > +{
> > +     int err;
> > +
> > +     err =3D pci_epf_register_driver(&epf_vcon_drv);
> > +     if (err)
> > +             pr_err("Failed to register PCI EP virtio-console function=
\n");
>
> dev_err() if possible (doesn't look like it *is* possible).
>
> Looks like this registers a *driver*, so maybe change the message from
> "function" to "driver"?
It should be "driver".
https://docs.kernel.org/PCI/endpoint/pci-endpoint.html#epc-apis-for-the-pci=
-endpoint-function-driver
> Bjorn

Best regards,
Shunsuke
