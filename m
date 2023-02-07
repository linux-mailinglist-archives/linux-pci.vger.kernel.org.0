Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC968D429
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 11:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBGK3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 05:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjBGK3i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 05:29:38 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CDF27493
        for <linux-pci@vger.kernel.org>; Tue,  7 Feb 2023 02:29:18 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id g13so1395963uan.7
        for <linux-pci@vger.kernel.org>; Tue, 07 Feb 2023 02:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UommVTJaXxWIOJAZoy5o/EUG5Ks0hfVT9tU2NEiYwdg=;
        b=cRO+42/de4Uh+pv3kGZRiBlNDQQKw1ggRGvdLr4DzdWX8ivcamZ816SOkZdGPE7K+k
         qAa5EsnzSgpxuxOU67xVCuJaKaOPlOF6ugte1Ho2+BEgHMOh+VQ3mdtAtHXWVK5UWVdy
         F0jNhXPJokBM000pywFXhmPQoxWNIloTyvnaVpAQQjkpxYSJCIVs/dE+Qvuq8FwYpqO7
         OByedRC3nPh5LZwhIAWELfTxyPc03qEu1Kd2oBinjuplsn4FtI3Et4kzu64Uqlzam+gK
         SsfiPlsJSLCpO+it5mCwJlh1vzQHzQQmOrz1fyZFrh9H6x/Y26kjZ1BFpNpbVUT/5xJm
         5FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UommVTJaXxWIOJAZoy5o/EUG5Ks0hfVT9tU2NEiYwdg=;
        b=Zv8uXI+XiZQ4ohz4lWboVa1K3rwXJMbxEw293/KTk4tz6AyydCE5sH620Bf3Tq3vOq
         kmpAmhgNeLhTfNKqolt64jWMXcz8uRymeh4crumeAfdDKuL9TGf536ZzncHXwrHebmw8
         qomz51PycckJ/qEnN+tT2b7x3n9Hjit1vEdX5S2q8xKogJI1OqTSj+elNjwJJg0Jru73
         dDBAy9NJ/ninAzFOjTNc9oglxF2qcR69p6ZkIrPFTAWBfrWhsFqgGyzKadv6bbtSbDo+
         QikAMUApJlMzEcIpS4vRcpanbVIYbV3JjOMBAf7GmzfGlUuGf8CEDccokHo4gnVijMxl
         6Gpg==
X-Gm-Message-State: AO0yUKW8uSj867l5bT0z8S35VZ3ku0xeFJ3WiizBQ9Cef7C4FJNUwc+1
        c/TVtdmRt45J6Qi6Oy7VPFYYgay4CEaBooc92HlRPHMyn1t2mywzBCs=
X-Google-Smtp-Source: AK7set+vtrzOIUPt3cNy80cmjiPZQoeNH2N8CM9SSDLoBn+2JNI5eWx2e2HNyMEkuQbDC+qeDS5zvamAOgoG3U7qoDs=
X-Received: by 2002:ab0:3749:0:b0:669:f7f:882f with SMTP id
 i9-20020ab03749000000b006690f7f882fmr446807uat.54.1675765757774; Tue, 07 Feb
 2023 02:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp> <HE1PR0401MB2331EAFF5684D60EC565433688D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0401MB2331EAFF5684D60EC565433688D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 7 Feb 2023 19:29:06 +0900
Message-ID: <CANXvt5qjDDEK0NB=BWh00-HGU-p+sC=8TyP-oPdccnZxKxZt9w@mail.gmail.com>
Subject: Re: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP function
To:     Frank Li <frank.li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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

2023=E5=B9=B42=E6=9C=884=E6=97=A5(=E5=9C=9F) 1:45 Frank Li <frank.li@nxp.co=
m>:
>
>
>
> > -----Original Message-----
> > From: Shunsuke Mie <mie@igel.co.jp>
> > Sent: Friday, February 3, 2023 4:04 AM
> > To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Krzysztof Wilczy=C5=84ski <kw@linux.com>; Manivannan Sadhasivam
> > <mani@kernel.org>; Kishon Vijay Abraham I <kishon@kernel.org>; Bjorn
> > Helgaas <bhelgaas@google.com>; Michael S. Tsirkin <mst@redhat.com>;
> > Jason Wang <jasowang@redhat.com>; Shunsuke Mie <mie@igel.co.jp>;
> > Frank Li <frank.li@nxp.com>; Jon Mason <jdmason@kudzu.us>; Ren Zhijie
> > <renzhijie2@huawei.com>; Takanari Hayama <taki@igel.co.jp>; linux-
> > kernel@vger.kernel.org; linux-pci@vger.kernel.org; virtualization@lists=
.linux-
> > foundation.org
> > Subject: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
> > function
> >
> > Caution: EXT Email
> >
> > This patchset introduce a virtio-net EP device function. It provides a
> > new option to communiate between PCIe host and endpoint over IP.
> > Advantage of this option is that the driver fully uses a PCIe embedded =
DMA.
> > It is used to transport data between virtio ring directly each other. I=
t
> > can be expected to better throughput.
>
> Thanks, basic that's what I want.  I am trying use RDMA.
> But I think virtio-net still be good solution.
We project extending this module to support RDMA. The plan is based on
virtio-rdma[1].
It extends the virtio-net and we are plan to implement the proposed
spec based on this patch.
[1] virtio-rdma
- proposal:
https://lore.kernel.org/all/20220511095900.343-1-xieyongji@bytedance.com/T/
- presentation on kvm forum:
https://youtu.be/Qrhv6hC_YK4

Please feel free to comment and suggest.
> Frank Li
>
> >
> > To realize the function, this patchset has few changes and introduces a
> > new APIs to PCI EP framework related to virtio. Furthermore, it device
> > depends on the some patchtes that is discussing. Those depended patchse=
t
> > are following:
> > - [PATCH 1/2] dmaengine: dw-edma: Fix to change for continuous transfer
> > link:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.k
> > ernel.org%2Fdmaengine%2F20221223022608.550697-1-
> > mie%40igel.co.jp%2F&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
> > 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> > 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> > wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> > C%7C%7C&sdata=3DtIn0MHzEvrdxaC4KKTvTRvYXBzQ6MyrFa2GXpa3ePv0%3D&
> > reserved=3D0
> > - [RFC PATCH 0/3] Deal with alignment restriction on EP side
> > link:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.k
> > ernel.org%2Flinux-pci%2F20230113090350.1103494-1-
> > mie%40igel.co.jp%2F&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
> > 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> > 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> > wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> > C%7C%7C&sdata=3DRLpnDiLwfqQd5QMXdiQyPVCkfOj8q2AyVeZOwWHvlsM%3
> > D&reserved=3D0
> > - [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
> > link:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.k
> > ernel.org%2Fvirtualization%2F20230202090934.549556-1-
> > mie%40igel.co.jp%2F&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
> > 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> > 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> > wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> > C%7C%7C&sdata=3D6jgY76BMSbvamb%2Fl3Urjt4Gcizeqon%2BZE5nPssc2kDA%
> > 3D&reserved=3D0
> >
> > About this patchset has 4 patches. The first of two patch is little cha=
nges
> > to virtio. The third patch add APIs to easily access virtio data struct=
ure
> > on PCIe Host side memory. The last one introduce a virtio-net EP device
> > function. Details are in commit respectively.
> >
> > Currently those network devices are testd using ping only. I'll add a
> > result of performance evaluation using iperf and etc to the future vers=
ion
> > of this patchset.
> >
> > Shunsuke Mie (4):
> >   virtio_pci: add a definition of queue flag in ISR
> >   virtio_ring: remove const from vring getter
> >   PCI: endpoint: Introduce virtio library for EP functions
> >   PCI: endpoint: function: Add EP function driver to provide virtio net
> >     device
> >
> >  drivers/pci/endpoint/Kconfig                  |   7 +
> >  drivers/pci/endpoint/Makefile                 |   1 +
> >  drivers/pci/endpoint/functions/Kconfig        |  12 +
> >  drivers/pci/endpoint/functions/Makefile       |   1 +
> >  .../pci/endpoint/functions/pci-epf-vnet-ep.c  | 343 ++++++++++
> >  .../pci/endpoint/functions/pci-epf-vnet-rc.c  | 635 ++++++++++++++++++
> >  drivers/pci/endpoint/functions/pci-epf-vnet.c | 387 +++++++++++
> >  drivers/pci/endpoint/functions/pci-epf-vnet.h |  62 ++
> >  drivers/pci/endpoint/pci-epf-virtio.c         | 113 ++++
> >  drivers/virtio/virtio_ring.c                  |   2 +-
> >  include/linux/pci-epf-virtio.h                |  25 +
> >  include/linux/virtio.h                        |   2 +-
> >  include/uapi/linux/virtio_pci.h               |   2 +
> >  13 files changed, 1590 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-ep.c
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-rc.c
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.c
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.h
> >  create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
> >  create mode 100644 include/linux/pci-epf-virtio.h
> >
> > --
> > 2.25.1
>
Best,
Shunsuke
