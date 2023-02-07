Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B4068D4E8
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 11:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjBGK4Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 05:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGK4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 05:56:15 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6992F10C8
        for <linux-pci@vger.kernel.org>; Tue,  7 Feb 2023 02:56:14 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k4so15821087vsc.4
        for <linux-pci@vger.kernel.org>; Tue, 07 Feb 2023 02:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh6n76XKXwkWQFKv24FSFfZ2Z3Kdasw4AtrqkamX9UM=;
        b=3bRuHxRHNfgNh/U9x9Z0OChjKOxnf23Qq1s4ZVRqD79+wZUL3y8dYHCJeVVYw1Gk3b
         caFgoAj4BGpbB+0rddJneTJyACwZLBM6oQl/WHJeMWQ/6e4Eg9Wgc81z6oRhBaT2LPOk
         TREvubm1ognsVxQVgdkm3yflazGy+YytqGO/PSuPpzgzteTqkd8nDf/Z0jB0pmYTGx0f
         Iv2nysL/rN50+2lL8dMnGzsEmOSkxwVYeiihvE65fw4LTPl3C++Mi/tvdJ5cNL0orluK
         yawkySoBZSGlZgkj5UFYBdkSCKPEAgJHit9yaXBwYo53kzzwmEHg19LBY7Tl9wEFolVa
         GM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eh6n76XKXwkWQFKv24FSFfZ2Z3Kdasw4AtrqkamX9UM=;
        b=N3P+2I+OvPvVD1JZY5OFpvKlJ1Zz2sHuGODxXeKDDNBgetiwvYbwKwehVHkY2LPmey
         LTMqOmBDW8qvVmXfIftzmsPoGwiAm/bSOOWD01LAsRz+5+i5258NlQvtvhjEqPyFSYW4
         /AKyVxi3ktiYNeWbVSNDLkLCeRAX5XhP4cQ4lXdYJkuxcWP6EEU6bxVub4YKHMa2jV9E
         oeFKGq7f0GL6JeawWKS4l6t0oIzeFoKN95jZbAFvrOWRRwjyreOs1lYz8phGezxXiZo0
         /HGeJatpQViDV21XMkcj+XeygFZOVrp7e6Iae8c6UaNTxkIWuTW7sZsZfB+MQ9FUSbXk
         ZyhA==
X-Gm-Message-State: AO0yUKWhFQ1ZWkL8azbg7ehLY1DguiCKyNy6AJ5o22PkaM5uibBe6uq5
        MXZAAbQrhpOaVE/w2nna2vySdVRlXHLiApcOO8Ud3A==
X-Google-Smtp-Source: AK7set/+QocsElN2HAp7zqZEXhXbN49fvEFr+puDDmo2Tj8R93i+EnA3nNuF3VGJjfw7/LYPrLlggfaxFNUmNo4A9B8=
X-Received: by 2002:a67:e10e:0:b0:3d3:d797:33c3 with SMTP id
 d14-20020a67e10e000000b003d3d79733c3mr564644vsl.51.1675767373472; Tue, 07 Feb
 2023 02:56:13 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp> <20230203100418.2981144-5-mie@igel.co.jp>
 <20230203052114-mutt-send-email-mst@kernel.org> <HE1PR0401MB23313FC60955EADE8A00133088D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0401MB23313FC60955EADE8A00133088D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 7 Feb 2023 19:56:02 +0900
Message-ID: <CANXvt5qjgVKccRcsARSkDF+boVkVi7h=AMHC+iWyOfp4dJ-_tQ@mail.gmail.com>
Subject: Re: [EXT] Re: [RFC PATCH 4/4] PCI: endpoint: function: Add EP
 function driver to provide virtio net device
To:     Frank Li <frank.li@nxp.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

2023=E5=B9=B42=E6=9C=884=E6=97=A5(=E5=9C=9F) 7:15 Frank Li <frank.li@nxp.co=
m>:
>
> >
> > Caution: EXT Email
> >
> > On Fri, Feb 03, 2023 at 07:04:18PM +0900, Shunsuke Mie wrote:
> > > Add a new endpoint(EP) function driver to provide virtio-net device. =
This
> > > function not only shows virtio-net device for PCIe host system, but a=
lso
> > > provides virtio-net device to EP side(local) system. Virtualy those n=
etwork
> > > devices are connected, so we can use to communicate over IP like a si=
mple
> > > NIC.
> > >
> > > Architecture overview is following:
> > >
> > > to Host       |                       to Endpoint
> > > network stack |                 network stack
> > >       |       |                       |
> > > +-----------+ |       +-----------+   +-----------+
> > > |virtio-net | |       |virtio-net |   |virtio-net |
> > > |driver     | |       |EP function|---|driver     |
> > > +-----------+ |       +-----------+   +-----------+
> > >       |       |             |
> > > +-----------+ | +-----------+
> > > |PCIeC      | | |PCIeC      |
> > > |Rootcomplex|-|-|Endpoint   |
> > > +-----------+ | +-----------+
> > >   Host side   |          Endpoint side
> > >
> > > This driver uses PCIe EP framework to show virtio-net (pci) device Ho=
st
> > > side, and generate virtual virtio-net device and register to EP side.
> > > A communication date
> >
> > data?
> >
> > > is diractly
> >
> > directly?
> >
> > > transported between virtqueue level
> > > with each other using PCIe embedded DMA controller.
> > >
> > > by a limitation of the hardware and Linux EP framework, this function
> > > follows a virtio legacy specification.
> >
> > what exactly is the limitation and why does it force legacy?
> >
> > > This function driver has beed tested on S4 Rcar (r8a779fa-spider) boa=
rd but
> > > just use the PCIe EP framework and depends on the PCIe EDMA.
> > >
> > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > > Signed-off-by: Takanari Hayama <taki@igel.co.jp>
> > > ---
> > >  drivers/pci/endpoint/functions/Kconfig        |  12 +
> > >  drivers/pci/endpoint/functions/Makefile       |   1 +
> > >  .../pci/endpoint/functions/pci-epf-vnet-ep.c  | 343 ++++++++++
>
> It is actually that not related vnet. Just virtio.
> I think pci-epf-virtio.c is better.
Yes, it have to be.
> > >  .../pci/endpoint/functions/pci-epf-vnet-rc.c  | 635 ++++++++++++++++=
++
>
> It is epf driver. rc is quite confused.
> Maybe you can combine pci-epf-vnet-ep.c and pci-epf-vnet-rc.c to one file=
.
I agree. Try to combine them
> > >  drivers/pci/endpoint/functions/pci-epf-vnet.c | 387 +++++++++++
>
> This file setup dma transfer according virtio-ring.
> How about pci-epf-virtio-dma.c ?
I attempt to rearrange the location of code and filenames.
> > > +
> > > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_ISR,
> > VIRTIO_PCI_ISR_QUEUE);
> > > +     /*
> > > +      * Initialize the queue notify and selector to outside of the a=
ppropriate
> > > +      * virtqueue index. It is used to detect change with polling. T=
here is no
> > > +      * other ways to detect host side driver updateing those values
> > > +      */
>
> I am try to use gic-its or other msi controller as doorbell.
> https://lore.kernel.org/imx/20221125192729.1722913-1-Frank.Li@nxp.com/T/#=
u
>
> but it may need update host side pci virtio driver.
Thanks, is it possible to use  MSI-X as well? The virtio spec
indicates to use legacy irq or
MSI-X only.
> > > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_QUEUE_NOTIFY,
> > default_qindex);
> > > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_QUEUE_SEL,
> > default_qindex);
> > > +     /* This pfn is also set to 0 for the polling as well */
> > > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_QUEUE_PFN, 0);
> > > +
> > --
> > > 2.25.1
>
Best,
Shunsuke.
