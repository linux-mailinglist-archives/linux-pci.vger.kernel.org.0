Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2064E79B5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Mar 2022 18:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbiCYRPK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Mar 2022 13:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347560AbiCYRPD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Mar 2022 13:15:03 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E593CFD2;
        Fri, 25 Mar 2022 10:13:28 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d07ae0b1c4so89460957b3.11;
        Fri, 25 Mar 2022 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4p0X/XeCE266vSwVQNBGK11tvaUj7yQyARoxG+v1mAo=;
        b=eXVXBuCHvv4Vq88Lxjrm0KjehjMvkIEGi/FnXBa/K9rJxso24l2l4EcQAYwmOnha2d
         YPSm0QTAVkozSxCsZWSJIypqKkn2IfS1j4h/YSHlVKwj1p1la9DcioQyqVPWK+/Tu3RK
         5s3US5NY8BT6cfZhLSe9manwsCEyrNAZhjKzHJwt+ubHEVbc961N0jVtA9zqIehRDn6r
         fs4Fe97WtUlqrKIw9NQsuB83dzU4AqoQiFuVKtvFJzUpgHwxp4dnjYpD3hGhVi11cCTQ
         z286bOjZwqf0KBtMS2gFU2jmm5dhgARV4U8MY2lkBP6b0Z9VsBFHq3zVafVluH+7gVMx
         trEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4p0X/XeCE266vSwVQNBGK11tvaUj7yQyARoxG+v1mAo=;
        b=zYrX8EY+LF+b655TS8ShzPB7XX6BXpLLaQzSdFOvQL6NxN4pY6CPe2ijkHXmhfafsn
         jdjVNAYsXa93MYQmG6zgbmH5eTAX3BJ1r6+fCnErqRMt/jfGjOoJjy59go+58ygDlWpt
         AwLrgx4LQT8xhMElb1U4ZwR/e8JLFSXg/j0sJzE+cYBGGURomlcdL6bo18uDT0kzmpEE
         xLb5f1VpZS2sgWF9Myh8fQTS5x1Vv5JEE/d+xgsIin/nE18vuKR0dd1/bfzKIEbYHoGm
         /F86/T8Vx7GBZVdSX3pnoQvoYXii7oEz5VDhUS11Ixwo96JPIIxPZ2jbU0CF01pq1bJg
         Gdew==
X-Gm-Message-State: AOAM533LstyYSrVK4Iv/iQISCk3INW9xUTe3kiGjVwH9Gi3y7PcuSCzV
        2Q+duxsVCb8Os95laxiEBLyvJL6mjJYsn2ZH24g=
X-Google-Smtp-Source: ABdhPJzjB7PTxvBD0TAF3d9twe9l0NUAc0TZ7HIZSfe/oYnJRznZKrt2Dj0TtyR66WE033Ds67wGpvl2pPMG8RC++UQ=
X-Received: by 2002:a0d:c0c7:0:b0:2e5:bf19:2698 with SMTP id
 b190-20020a0dc0c7000000b002e5bf192698mr11970702ywd.119.1648228407794; Fri, 25
 Mar 2022 10:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <PAXPR04MB9186D7B361F9FFE56A0AE69C88039@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <CA+V-a8t2=MRObzdjHM9OUE8LzQXqoiLo-T+D3i1fLAOaneESpw@mail.gmail.com> <PAXPR04MB91866AB1474C9F9F2CB15B7A88039@PAXPR04MB9186.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB91866AB1474C9F9F2CB15B7A88039@PAXPR04MB9186.eurprd04.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 25 Mar 2022 17:13:02 +0000
Message-ID: <CA+V-a8u-KQSdTFNDKYJBL=1c2xtDraVAyqeNtTT-eFMWjYBtKQ@mail.gmail.com>
Subject: Re: [EXT] Re: [RFC PATCH 0/5] PCIe EPF support for internal DMAC
 handling and driver update for R-Car PCIe EP to support DMAC
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Frank Li <frank.li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Wed, Mar 2, 2022 at 6:28 PM Frank Li <frank.li@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: Wednesday, March 2, 2022 11:18 AM
> > To: Frank Li <frank.li@nxp.com>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>; Lad Prabh=
akar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>; Kishon Vijay Abraham I
> > <kishon@ti.com>; Bjorn Helgaas <bhelgaas@google.com>; Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>; Krzysztof Wilczy=C5=84ski <kw@linux.com>; =
Arnd
> > Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g>;
> > Marek Vasut <marek.vasut+renesas@gmail.com>; Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com>; Rob Herring <robh@kernel.org>; linu=
x-
> > pci <linux-pci@vger.kernel.org>; Linux-Renesas <linux-renesas-
> > soc@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; Biju Das
> > <biju.das.jz@bp.renesas.com>
> > Subject: [EXT] Re: [RFC PATCH 0/5] PCIe EPF support for internal DMAC
> > handling and driver update for R-Car PCIe EP to support DMAC
> >
> > Caution: EXT Email
> >
> > Hi Frank,
> >
> > On Wed, Mar 2, 2022 at 3:42 PM Frank Li <frank.li@nxp.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > > > Sent: Thursday, February 10, 2022 3:24 AM
> > > > To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>; Kishon
> > Vijay
> > > > Abraham I <kishon@ti.com>; Bjorn Helgaas <bhelgaas@google.com>; Lor=
enzo
> > > > Pieralisi <lorenzo.pieralisi@arm.com>; Krzysztof Wilczy=C5=84ski
> > <kw@linux.com>;
> > > > Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org>; Marek Vasut
> > <marek.vasut+renesas@gmail.com>;
> > > > Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>; Rob Herring
> > > > <robh@kernel.org>; linux-pci <linux-pci@vger.kernel.org>; Linux-Ren=
esas
> > > > <linux-renesas-soc@vger.kernel.org>; LKML <linux-
> > kernel@vger.kernel.org>;
> > > > Biju Das <biju.das.jz@bp.renesas.com>
> > > > Subject: [EXT] Re: [RFC PATCH 0/5] PCIe EPF support for internal DM=
AC
> > > > handling and driver update for R-Car PCIe EP to support DMAC
> > >
> > > I use standard DMA engine API to implement Designware PCIE EP embedde=
d
> > DMA support.
> > > Please check
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.kern
> > el.org%2Fall%2F20220302032646.3793-3-
> > Frank.Li%40nxp.com%2FT%2F&amp;data=3D04%7C01%7Cfrank.li%40nxp.com%7C0e2=
e5fe8f
> > d224076afb208d9fc70aa16%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63=
7818
> > 383096028914%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLC
> > JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DDCDX%2BYEVFsPOE6ZWzwrMx=
k1Fjlk
> > ZA%2FEPGmhQSHuPB2c%3D&amp;reserved=3D0
> > >
> > Thank you for the link. The Designware PCIE EP is implemented as a DMA
> > engine driver so it's convenient to use the DMA engine API, whereas
> > the R-Car PCIe-EP is implemented as an actual PCIe EP [0].
>
> My means, needn't add new interface pci_epf_internal_dmac_xfr at epc/epf.
> Your R-Car PCI-EP DMA part can implement as a dma engine driver like desi=
gnware.
>
> So EP functional driver use the same method to operate DMA regardless
> EP controller type.
>
With this approach all the PCIe controllers supporting internal dmac
will have to be added as a DMA driver.

Could you please provide some feedback on the above?

Sorry this mail is not in chain to my orignal patch series. My orignal
series can be found at [0]

[0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/2022012619=
5043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
