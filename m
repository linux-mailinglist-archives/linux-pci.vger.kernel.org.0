Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066586EC9C7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 12:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjDXKHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 06:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjDXKHF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 06:07:05 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF42B3AA4
        for <linux-pci@vger.kernel.org>; Mon, 24 Apr 2023 03:06:59 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-771d9ec5aa5so18156418241.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Apr 2023 03:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1682330819; x=1684922819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPK4RM9urqioHz4+lhToeGtEVxXr+HVXjxPgmNgTnWQ=;
        b=32Bo0IDA7i2BZdFWZcQOzSHuM8nYvcBGXlG21X66mWD+jFR/OcmwdlH2R0kNYyNfJm
         OaN7NNklHhzDrdphrsvWlMFPncM3Cxy4Ws6/EpgoGmqAk3mKdreYkPVWr6Y9taD7XJCX
         asd/jqlbMlB47AXcrpp4/GF771qpyLwagzZ4Ka9S7x++LdBigOVmrQMChgGRAJ3VlfpL
         EDYkNknkRW9blK5nNQnlL5iup12CHq2E9H5WoZM/nD0i5yzn9HE56wHsGZt7ldxHNnGR
         HqbS/uiSbWI57O8VHsYWm2z/o4F0mjJJJR3qtYKznqPVVnOtTrO24T1KS7qMvNAiiSGp
         ZBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682330819; x=1684922819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPK4RM9urqioHz4+lhToeGtEVxXr+HVXjxPgmNgTnWQ=;
        b=UTYevGyl5xlw//H8bXeVcOHmtVCDfVhrFgFpUcXAzz6IIB9R5cusTq9Z3UrrS7ikkd
         +AeP/jpXutPtjrKlFtYguA2by1lgKAK2J0nn0py5uxyerYAip4d/YP+88PJ+DF9I/hSe
         Q1BDoRDKMZWQtGEDykIS+onEVNwE1MBW2GGEE3n2LToPaxC+Ffuh2+y6ozgeqLjSc4Ha
         CBt/UteRFQuBPfim5ZKuv8WwPrm5+gIlIA50goJxkK0sYpmj8u+jd/Mpz7SW8IHW2gPi
         jg1PmhHf/1xtgFi0QvpEZOslKlVF8c0t7e08y3AI79F2vU/AMrJsfoQVcOLs3AFmY8Rs
         4c2w==
X-Gm-Message-State: AAQBX9eepjmuBK9hfCK9Hge56OtxdYF+o+Mzaf/AJB0Nsf1EPdenS/Cy
        vj8rs9RbaRtMoBXsP47URjtO4TS0oSWvnCF9eyrvVQ==
X-Google-Smtp-Source: AKy350Y6gPpvmoJfLHIOQVSAlJOfE/J8xU6C5kormDvHY+8n4TUxk5QTOPcjSO2Ei+NOjPSCE2ZUxE5B8X2ukLsOULc=
X-Received: by 2002:a1f:a6d1:0:b0:446:b903:d76c with SMTP id
 p200-20020a1fa6d1000000b00446b903d76cmr3700562vke.5.1682330818096; Mon, 24
 Apr 2023 03:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230414123903.896914-1-mie@igel.co.jp> <AM6PR04MB483871ADC2BA657BBF3A5A4588999@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <9e9acbf6-3486-56d3-c15a-c3d67557c2a9@igel.co.jp> <AM6PR04MB483893F2A017B54AE29474A9889C9@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <7680d6cd-163d-8648-33da-c3d7d2e2fa3d@igel.co.jp> <AM6PR04MB4838244F1AE7C4CFA50DBCE9889D9@AM6PR04MB4838.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4838244F1AE7C4CFA50DBCE9889D9@AM6PR04MB4838.eurprd04.prod.outlook.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Mon, 24 Apr 2023 19:06:47 +0900
Message-ID: <CANXvt5p87ARDF-bBak9DtyMS-Zv96DE8jtAsKdeHdWJGhNuQpQ@mail.gmail.com>
Subject: Re: [EXT] [RFC PATCH 0/3] Introduce a PCIe endpoint virtio console
To:     Frank Li <frank.li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

2023=E5=B9=B44=E6=9C=8819=E6=97=A5(=E6=B0=B4) 1:42 Frank Li <frank.li@nxp.c=
om>:
>
>
>
> > -----Original Message-----
> > From: Shunsuke Mie <mie@igel.co.jp>
> > Sent: Tuesday, April 18, 2023 5:31 AM
> > To: Frank Li <frank.li@nxp.com>; Lorenzo Pieralisi <lpieralisi@kernel.o=
rg>
> > Cc: Krzysztof Wilczy=C5=84ski <kw@linux.com>; Manivannan Sadhasivam
> > <mani@kernel.org>; Kishon Vijay Abraham I <kishon@kernel.org>; Bjorn
> > Helgaas <bhelgaas@google.com>; Michael S. Tsirkin <mst@redhat.com>;
> > Jason Wang <jasowang@redhat.com>; Jon Mason <jdmason@kudzu.us>;
> > Randy Dunlap <rdunlap@infradead.org>; Ren Zhijie
> > <renzhijie2@huawei.com>; linux-kernel@vger.kernel.org; linux-
> > pci@vger.kernel.org; virtualization@lists.linux-foundation.org
> > Subject: Re: [EXT] [RFC PATCH 0/3] Introduce a PCIe endpoint virtio con=
sole
> >
> > Caution: EXT Email
> >
> > On 2023/04/18 0:19, Frank Li wrote:
> > >
> > >> -----Original Message-----
> > >> From: Shunsuke Mie <mie@igel.co.jp>
> > >> Sent: Sunday, April 16, 2023 9:12 PM
> > >> To: Frank Li <frank.li@nxp.com>; Lorenzo Pieralisi <lpieralisi@kerne=
l.org>
> > >> Cc: Krzysztof Wilczy=C5=84ski <kw@linux.com>; Manivannan Sadhasivam
> > >> <mani@kernel.org>; Kishon Vijay Abraham I <kishon@kernel.org>; Bjorn
> > >> Helgaas <bhelgaas@google.com>; Michael S. Tsirkin <mst@redhat.com>;
> > >> Jason Wang <jasowang@redhat.com>; Jon Mason <jdmason@kudzu.us>;
> > >> Randy Dunlap <rdunlap@infradead.org>; Ren Zhijie
> > >> <renzhijie2@huawei.com>; linux-kernel@vger.kernel.org; linux-
> > >> pci@vger.kernel.org; virtualization@lists.linux-foundation.org
> > >> Subject: Re: [EXT] [RFC PATCH 0/3] Introduce a PCIe endpoint virtio
> > console
> > >>
> > >> Caution: EXT Email
> > >>
> > >> On 2023/04/14 23:39, Frank Li wrote:
> > >>>> -----Original Message-----
> > >>>> From: Shunsuke Mie <mie@igel.co.jp>
> > >>>> Sent: Friday, April 14, 2023 7:39 AM
> > >>>> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > >>>> Cc: Krzysztof Wilczy=C5=84ski <kw@linux.com>; Manivannan Sadhasiva=
m
> > >>>> <mani@kernel.org>; Kishon Vijay Abraham I <kishon@kernel.org>;
> > Bjorn
> > >>>> Helgaas <bhelgaas@google.com>; Michael S. Tsirkin
> > <mst@redhat.com>;
> > >>>> Jason Wang <jasowang@redhat.com>; Shunsuke Mie
> > <mie@igel.co.jp>;
> > >>>> Frank Li <frank.li@nxp.com>; Jon Mason <jdmason@kudzu.us>; Randy
> > >>>> Dunlap <rdunlap@infradead.org>; Ren Zhijie
> > <renzhijie2@huawei.com>;
> > >>>> linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org;
> > >>>> virtualization@lists.linux-foundation.org
> > >>>> Subject: [EXT] [RFC PATCH 0/3] Introduce a PCIe endpoint virtio co=
nsole
> > >>>>
> > >>>> Caution: EXT Email
> > >>>>
> > >>>> PCIe endpoint framework provides APIs to implement PCIe endpoint
> > >>>> function.
> > >>>> This framework allows defining various PCIe endpoint function
> > behaviors
> > >> in
> > >>>> software. This patch extend the framework for virtio pci device. T=
he
> > >>>> virtio is defined to communicate guest on virtual machine and host=
 side.
> > >>>> Advantage of the virtio is the efficiency of data transfer and the
> > >> conciseness
> > >>>> of implementation device using software. It also be applied to PCI=
e
> > >>>> endpoint function.
> > >>>>
> > >>>> We designed and implemented a PCIe EP virtio console function driv=
er
> > >> using
> > >>>> the extended PCIe endpoint framework for virtio. It can be
> > communicate
> > >>>> host and endpoint over virtio as console.
> > >>>>
> > >>>> An architecture of the function driver is following:
> > >>>>
> > >>>>    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90         =E2=
=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80
> > =E2=94=80
> > >> =E2=94=80=E2=94=80
> > >>>> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> > >>>>    =E2=94=82virtio      =E2=94=82         =E2=94=82               =
       =E2=94=82virtio      =E2=94=82
> > >>>>    =E2=94=82console drv =E2=94=82         =E2=94=9C=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90      =E2=94=82
> > >> console
> > >>>> drv =E2=94=82
> > >>>>    =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=
=94=82(virtio console=E2=94=82      =E2=94=9C=E2=94=80=E2=94=80
> > =E2=94=80
> > >> =E2=94=80=E2=94=80
> > >>>> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=A4
> > >>>>    =E2=94=82 virtio bus =E2=94=82         =E2=94=82 device)       =
=E2=94=82=E2=97=84=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA=E2=94=82 vi=
rtio bus =E2=94=82
> > >>>>    =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=
=94=9C---------------=E2=94=A4      =E2=94=94=E2=94=80=E2=94=80=E2=94=80
> > =E2=94=80
> > >> =E2=94=80=E2=94=80
> > >>>> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> > >>>>    =E2=94=82            =E2=94=82         =E2=94=82 pci ep virtio =
=E2=94=82                   =E2=94=82
> > >>>>    =E2=94=82  pci bus   =E2=94=82         =E2=94=82  console drv  =
=E2=94=82                   =E2=94=82
> > >>>>    =E2=94=82            =E2=94=82  pcie   =E2=94=9C=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> > =E2=94=82
> > >>>>    =E2=94=82            =E2=94=82 =E2=97=84=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=96=BA =E2=94=82  pci ep Bus   =E2=94=82        =
           =E2=94=82
> > >>>>    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98         =E2=
=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80
> > =E2=94=80
> > >> =E2=94=80=E2=94=80
> > >>>> =E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> > >>>>      PCIe Root              PCIe Endpoint
> > >>>>
> > >>> [Frank Li] Some basic question,
> > >>> I see you call register_virtio_device at epf_vcon_setup_vdev,
> > >>> Why call it as virtio console?  I suppose it should be virtiobus di=
rectly?
> > >> I'm sorry I didn't understand your question. What do you mean the
> > >> virtiobus directly?
> > > I go through your code again.  I think I understand why you need pci-=
epf-
> > vcon.c.
> > > Actually,  my means is like virtio_mmio_probe.
> > >
> > > vm_dev->vdev.id.device =3D readl(vm_dev->base +
> > VIRTIO_MMIO_DEVICE_ID);
> > > vm_dev->vdev.id.vendor =3D readl(vm_dev->base +
> > VIRTIO_MMIO_VENDOR_ID);
> > >
> > > I am not sure that if VIRTIO_MMIO_VENDOR_ID and
> > VIRTIO_MMIO_DEVICE_ID
> > > reuse PCI's vendor ID and Device ID.  If yes, you can directly get su=
ch
> > information
> > > from epf.  If no,  a customer field can been added at epf driver.
> > >
> > > So you needn't write pci-epf-vcon  and pci-epf-vnet .....
> > >
> > > Of cause it will be wonderful if directly use virtio_mmio_probe by dy=
nmatic
> > create platform
> > > Devices.  It may have some difficult because pci memory map requireme=
nt.
> > I think that some fields are shared between the vdev and epf device.
> > However, we need to implement device emulation because each virtio
> > device
> > has its specific set of tasks. For example, the virtio-net device has a
> > control queue, and the driver can request MAC filters, VLANs, and other
> > settings via this queue. These requests have to be processed by the vir=
tio
> > device that we are implementing in pci-epf-vnet.
> >
> > The simplest virtio-console device doesn=E2=80=99t have these tasks, bu=
t the other
> > virtio devices requireprocessing them.
> >
> > That's why the current pci-epf-virtio design requires a specific
> > implementation for each virtio device.
> >
> > Is this what you meant
>
> I see. Thank you for explain.
> Thing may become complex. How to implement composite at EPF driver?
> Such as console + net
I'm not sure your suggestion. Could you tell me the advantages?
> >
> > >
> > >>> Previous you use virtio-net, why change to virtio-console here?  Do=
es it
> > >> matter?
> > >>
> > >> No, it doesn't. Just I'd like to break down the changes into smaller
> > >> steps to make it easier to review and merge the changes.
> > >>
> > >> As a first step, I propose adding a simplest virtio function driver =
with
> > >> the extension defined in pci-epf-virtio.{h,c}.
> > >>
> > >>> All virtio-XXX should work?
> > >> Yes, the extension is designed to use any type of virtio device.
> > >>> You removed EDMA support this version?
> > >> I planed the support will be added with epf virtio-net patches.
> > >>>> Introduced driver is `pci ep virtio console drv` in the figure. It=
 works
> > >>>> as ep function for PCIe root and virtual virtio console device for=
 PCIe
> > >>>> endpoint. Each side of virtio console driver has virtqueue, and
> > >>>> introduced driver transfers data on the virtqueue to each other. A=
 data
> > >>>> on root tx queue is transfered to endpoint rx queue and vice versa=
.
> > >>>>
> > >>>> This patchset is depend follwing patches which are under discussio=
n.
> > >>>>
> > >>>> - [RFC PATCH 0/3] Deal with alignment restriction on EP side
> > >>>> link:
> > >>>>
> > >>
> > https://lore.k/
> > %2F&data=3D05%7C01%7Cfrank.li%40nxp.com%7C80a237184ff4420a96de08db
> > 3ff80d78%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63817410683
> > 2489955%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DLSP
> > LeFzTYpUVTZpymoM00Es9kOpxlN90%2BDM6ceDJMFE%3D&reserved=3D0
> > >> %2F&data=3D05%7C01%7Cfrank.li%40nxp.com%7Cff59a16f88c643913e3908
> > db3
> > >>
> > ee91ca8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63817294315
> > >>
> > 3821831%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > >>
> > 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DhTB
> > >> 5UDaJoJfta9ohMG%2BrxCVJY34ANn10iSLP9iCHX3M%3D&reserved=3D0
> > >>>> ernel.org%2Flinux-pci%2F20230113090350.1103494-1-
> > >>>>
> > >>
> > mie%40igel.co.jp%2F&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cea6513dbf
> > >>
> > 4084b80ced208db3ce54133%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> > >>
> > C0%7C638170727558800720%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> > >>
> > LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > >>>> %7C%7C&sdata=3DjYgy%2Bxk84ZXZRVfqm0GCXoRnCTLMrX4zTfV%2Bs5
> > Mm
> > >> svo
> > >>>> %3D&reserved=3D0
> > >>>> - [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
> > >>>> link:
> > >>>>
> > >>
> > https://lore.k/
> > %2F&data=3D05%7C01%7Cfrank.li%40nxp.com%7C80a237184ff4420a96de08db
> > 3ff80d78%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63817410683
> > 2489955%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DLSP
> > LeFzTYpUVTZpymoM00Es9kOpxlN90%2BDM6ceDJMFE%3D&reserved=3D0
> > >> %2F&data=3D05%7C01%7Cfrank.li%40nxp.com%7Cff59a16f88c643913e3908
> > db3
> > >>
> > ee91ca8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63817294315
> > >>
> > 3821831%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > >>
> > 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DhTB
> > >> 5UDaJoJfta9ohMG%2BrxCVJY34ANn10iSLP9iCHX3M%3D&reserved=3D0
> > >>>> ernel.org%2Fvirtualization%2F20230202090934.549556-1-
> > >>>>
> > >>
> > mie%40igel.co.jp%2F&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cea6513dbf
> > >>
> > 4084b80ced208db3ce54133%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> > >>
> > C0%7C638170727558800720%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> > >>
> > LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > >>>> %7C%7C&sdata=3DK4El76GSAGtsWkNBXJK5%2Fn7flCN20eEMZpZYTX2WI
> > Z0
> > >> %3
> > >>>> D&reserved=3D0
> > >>>>
> > >>>> First of this patchset is introduce a helper function to realize p=
ci
> > >>>> virtio function using PCIe endpoint framework. The second one is
> > adding
> > >>>> a missing definition for virtio pci header. The last one is for PC=
Ie
> > >>>> endpoint virtio console driver.
> > >>>>
> > >>>> This is tested on linux-20230406 and RCar S4 board as PCIe endpoin=
t.
> > >>>>
> > >>>> Shunsuke Mie (3):
> > >>>>     PCI: endpoint: introduce a helper to implement pci ep virtio f=
unction
> > >>>>     virtio_pci: add a definition of queue flag in ISR
> > >>>>     PCI: endpoint: Add EP function driver to provide virtio-consol=
e
> > >>>>       functionality
> > >>>>
> > >>>>    drivers/pci/endpoint/functions/Kconfig        |  19 +
> > >>>>    drivers/pci/endpoint/functions/Makefile       |   2 +
> > >>>>    drivers/pci/endpoint/functions/pci-epf-vcon.c | 554
> > >> ++++++++++++++++++
> > >>>>    .../pci/endpoint/functions/pci-epf-virtio.c   | 469 +++++++++++=
++++
> > >>>>    .../pci/endpoint/functions/pci-epf-virtio.h   | 123 ++++
> > >>>>    include/uapi/linux/virtio_pci.h               |   3 +
> > >>>>    6 files changed, 1170 insertions(+)
> > >>>>    create mode 100644 drivers/pci/endpoint/functions/pci-epf-vcon.=
c
> > >>>>    create mode 100644 drivers/pci/endpoint/functions/pci-epf-virti=
o.c
> > >>>>    create mode 100644 drivers/pci/endpoint/functions/pci-epf-virti=
o.h
> > >>>>
> > >>>> --
> > >>>> 2.25.1
Best regards,
Shunsuike
