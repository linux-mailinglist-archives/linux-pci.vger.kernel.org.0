Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496994CAB5F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 18:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiCBRTK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 12:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiCBRTK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 12:19:10 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBB9C336D;
        Wed,  2 Mar 2022 09:18:26 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id b35so4703643ybi.13;
        Wed, 02 Mar 2022 09:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NjQhnXGUl01guBYrTxuPjgXJg1Gs2FdzDMqjUU8s43E=;
        b=Hz4Uz5MnVltpZ9omd3cE5BiQzH23+H7FVPnT5G9knlq55Dvggq9ACHu728hesD9F8l
         hRr3Es3k1d08BQlIS77ShIwDWcg0kTZ+WX2NqfB5I8yS1pGpntnXAQXwMrauZBgy8Gr3
         njviuiuNZVWwLj3SsJPXwlrF0YxorM9EwAUGT1YTVuDC9qX17n8F6wZ7njsIr/i3Wa4x
         gYr8/oKG1qtUJPLTjhFEtZtPVoicvfZIMs+gkuZZaGExDSEDomGNqqnOUlrhY2SO8PKz
         RaUeTHcsABPnoQ11pjuEn4Htie+a5yN3BeYkiihFVHWEif5ooq3eLz6awA5/+ronPyEf
         6SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NjQhnXGUl01guBYrTxuPjgXJg1Gs2FdzDMqjUU8s43E=;
        b=OwLa8oqI8+Q7let8HEWIPh+yno4Ycy5CQWXgEqG6lyyTDcRufUAkadmwkLhI9kckOy
         UyhaQEMAtGrmhStHT/9k9Vqmhct6IF2BRGvqcs70ur5BSSHXvz2TqyCxEZ/jDkyztuYq
         DXqn7eEjUJ1EhxMduHVUiP6QQsUC2GgcYqGMJ2NW31bfvkXWqGPi3/iPhAwcZsWMINo2
         BQzDQhrQ7vIjzM8Q2xH105ZEtUXQ2pxLxWBcPEwuAQN8kFJA80k9dgjFZYFxUEIKG2QD
         qQ/jWxyQtKFTsZe+b51zTOnIN7Ww6fL4LvTVBytS/65FjsMGR6P6Pj00xkoTx4aO/boA
         UdPA==
X-Gm-Message-State: AOAM533vv3exEMpJvtZe4YzFdVFsxlJdh9KHdE923w7zUW+MTfTHazlJ
        KJUm6XlBcmUPcw/G9lXKXr6EM5A+su1ucjSsPQM=
X-Google-Smtp-Source: ABdhPJxPybjHCI1PYSIgm0yNpjx+F4FczlBBpBgg+8SD3ean5vpRW+tNrTdlzj/LcncBKNOjRge/v1Wvv+6wD/6kq1U=
X-Received: by 2002:a25:6b4c:0:b0:628:757c:a379 with SMTP id
 o12-20020a256b4c000000b00628757ca379mr9835591ybm.645.1646241505503; Wed, 02
 Mar 2022 09:18:25 -0800 (PST)
MIME-Version: 1.0
References: <PAXPR04MB9186D7B361F9FFE56A0AE69C88039@PAXPR04MB9186.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB9186D7B361F9FFE56A0AE69C88039@PAXPR04MB9186.eurprd04.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 2 Mar 2022 17:17:59 +0000
Message-ID: <CA+V-a8t2=MRObzdjHM9OUE8LzQXqoiLo-T+D3i1fLAOaneESpw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] PCIe EPF support for internal DMAC handling and
 driver update for R-Car PCIe EP to support DMAC
To:     Frank Li <frank.li@nxp.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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

Hi Frank,

On Wed, Mar 2, 2022 at 3:42 PM Frank Li <frank.li@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: Thursday, February 10, 2022 3:24 AM
> > To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>; Kishon Vij=
ay
> > Abraham I <kishon@ti.com>; Bjorn Helgaas <bhelgaas@google.com>; Lorenzo
> > Pieralisi <lorenzo.pieralisi@arm.com>; Krzysztof Wilczy=C5=84ski <kw@li=
nux.com>;
> > Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Marek Vasut <marek.vasut+renesas@gmail.co=
m>;
> > Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>; Rob Herring
> > <robh@kernel.org>; linux-pci <linux-pci@vger.kernel.org>; Linux-Renesas
> > <linux-renesas-soc@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org=
>;
> > Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: [EXT] Re: [RFC PATCH 0/5] PCIe EPF support for internal DMAC
> > handling and driver update for R-Car PCIe EP to support DMAC
>
> I use standard DMA engine API to implement Designware PCIE EP embedded DM=
A support.
> Please check https://lore.kernel.org/all/20220302032646.3793-3-Frank.Li@n=
xp.com/T/
>
Thank you for the link. The Designware PCIE EP is implemented as a DMA
engine driver so it's convenient to use the DMA engine API, whereas
the R-Car PCIe-EP is implemented as an actual PCIe EP [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml?h=3Dnext-20220302

Cheers,
Prabhakar


> Best regards
> Frank Li
>
> >
> > Caution: EXT Email
> >
> > Hi,
> >
> > On Thu, Feb 10, 2022 at 8:40 AM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Jan 26, 2022 at 07:50:38PM +0000, Lad Prabhakar wrote:
> > > > Hi All,
> > > >
> > > > The current PCIe EPF framework supports DMA data transfers using
> > external
> > > > DMA only, this patch series aims to add support for platforms
> > supporting
> > > > internal DMAC on PCIe for data transfers.
> > > >
> > > > R-Car PCIe supports internal DMAC to transfer data between Internal=
 Bus
> > to
> > > > PCI Express and vice versa. Last patch fills up the required flags =
and
> > ops
> > > > to support internal DMAC.
> > > >
> > > > Patches 1-3 are for PCIe EPF core to support internal DMAC handling=
,
> > patch
> > > > 4/5 is to fix test cases based on the conversation [1].
> > > >
> > >
> > > This looks similar to the Synopsys eDMA IP [1] that goes with the
> > Synopsys PCIe
> > > endpoint IP. Why can't you represent it as a dmaengine driver and use=
 the
> > > existing DMA support?
> > >
> > Let me have a look. Could you please share a link to the Synopsys PCIe
> > endpoint HW manual (the driver doesn't have a binding doc).
> >
> > Cheers,
> > Prabhakar
> >
> > > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
.kerne
> > l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftree%=
2Fdr
> > ivers%2Fdma%2Fdw-
> > edma&amp;data=3D04%7C01%7Cfrank.li%40nxp.com%7C95a5831aac544de2211508d9=
ec772f
> > 9a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637800819106821404%7CUn=
know
> > n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI
> > 6Mn0%3D%7C3000&amp;sdata=3DyG39L2YBN9blGxTcXyVQwIXol8%2FCo%2FZ3GbGPIlqz=
6Mg%3D
> > &amp;reserved=3D0
> > >
> > > > Patches are based on top of [1] next branch.
> > > >
> > > > [0]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.spini
> > cs.net%2Flists%2Flinux-
> > pci%2Fmsg92385.html&amp;data=3D04%7C01%7Cfrank.li%40nxp.com%7C95a5831aa=
c544de
> > 2211508d9ec772f9a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63780081=
9106
> > 821404%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
TiI6
> > Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DieX2gSSHFDumc1k2iWoOfMyHg236a=
JTE7UZ
> > 5D74D9KM%3D&amp;reserved=3D0
> > > > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
.kerne
> > l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fhelgaas%2Fpci.git&amp;data=
=3D04%7C
> > 01%7Cfrank.li%40nxp.com%7C95a5831aac544de2211508d9ec772f9a%7C686ea1d3bc=
2b4c
> > 6fa92cd99c5c301635%7C0%7C0%7C637800819106821404%7CUnknown%7CTWFpbGZsb3d=
8eyJ
> > WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&=
amp;
> > sdata=3DQc5cW6y5OrxprDjFQ1dNMZ4ZUc656I3FZqClaUMLx%2FM%3D&amp;reserved=
=3D0
> > > >
> > > > Cheers,
> > > > Prabhakar
> > > >
> > > > Lad Prabhakar (5):
> > > >   PCI: endpoint: Add ops and flag to support internal DMAC
> > > >   PCI: endpoint: Add support to data transfer using internal dmac
> > > >   misc: pci_endpoint_test: Add driver data for Renesas RZ/G2{EHMN}
> > > >   misc: pci_endpoint_test: Add support to pass flags for buffer
> > > >     allocation
> > > >   PCI: rcar-ep: Add support for DMAC
> > > >
> > > >  drivers/misc/pci_endpoint_test.c              |  56 ++++-
> > > >  drivers/pci/controller/pcie-rcar-ep.c         | 227 ++++++++++++++=
++++
> > > >  drivers/pci/controller/pcie-rcar.h            |  23 ++
> > > >  drivers/pci/endpoint/functions/pci-epf-test.c | 184 ++++++++++----
> > > >  drivers/pci/endpoint/pci-epf-core.c           |  32 +++
> > > >  include/linux/pci-epc.h                       |   8 +
> > > >  include/linux/pci-epf.h                       |   7 +
> > > >  7 files changed, 483 insertions(+), 54 deletions(-)
> > > >
> > > > --
> > > > 2.25.1
> > > >
