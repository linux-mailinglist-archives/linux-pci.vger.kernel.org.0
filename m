Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE5E6EE770
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 20:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjDYSPV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 14:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjDYSPU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 14:15:20 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D17316F37
        for <linux-pci@vger.kernel.org>; Tue, 25 Apr 2023 11:15:14 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b99dae893c0so2773891276.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Apr 2023 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682446513; x=1685038513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9AxBpSZhvTcSfimABy9+1chMCP4MkWnZQm2EpRgkoI=;
        b=wdK9Uu8DdzUoq0xP0PExEZWSiILIsch6ZxIszR4Cemcce6+0cIUMSPd1tfUhisuTk0
         8DveGGIxaP01WTv6ok97sqaif9WAiZTUNDDPQ2KIE2hqjo07hy4cYd0pfnMGRYRndFkV
         gw5ahNsb7bIS52YRfOSUotfPFdCDh7dTy3n/S9DI8128hgPE/YY3D48tvFM9v0xraSX/
         J0AnMGixHRHEc5nnQcL5Rofw5PRudPYzVI5kqGTI/JtpKovziH/pVU+3d59n+Hv75npE
         ynXXBT1JmVOihLihCe98ZN32CzrjwD2eA+Y68/dvfZpji/uHoBaJpg127tiS1Ws0QQOd
         +DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682446513; x=1685038513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9AxBpSZhvTcSfimABy9+1chMCP4MkWnZQm2EpRgkoI=;
        b=jbnZszHdyPMNfBpUUaBRRXKTdaGbdpJaUhLQBC1DXLULi9zbpvRWUbwvKjzW5bPUP9
         IBtqIYIZYacUFSTshRbonVGin14SMQLJ5pjrCfBmgMVaO1mRreXMJD3q81NInSCfvWcT
         EyEAFPvxEB4Jphapwlx9Sl2gOcf5wWed1QrEg4nB80cUu1nhAEtJ1mW1zffkt5qB10fF
         zxq9Y9jNB/UvAi1TzdVgoLTc2QmEERj/uxtjNPJ4K8pMYiR53x1esGjySJCVmAm5pa55
         iU4vtzXORGxWoSRQ9Vu/ilV2EulxaYVdjZTE26WnxcTbdqgjcV9AnH87H7414lOuKaDk
         4CrA==
X-Gm-Message-State: AAQBX9di+HajHsg89LaFalrN7S+c/lFPjoQuqM13NU5UBy+VTZGfTNvo
        EmazhMPuGhuMYiJyqb2sde4FKq1xD6hPWW5Auuwf4JKPZg5s6yYtQpdS7SqYVmAQe9Qal3iKDDz
        u8haXq/Lxg3RPo+9JBYRj1j30dQc=
X-Google-Smtp-Source: AKy350ZflPgIJCugWeaCs0Yx8kdvPSau8XXZhOzJibXk5dSZlFEutbHvECIBbtYun02VomcnVmm8zzrd05/iM0u8dXk=
X-Received: by 2002:a25:fa02:0:b0:b8f:4c4c:ffd8 with SMTP id
 b2-20020a25fa02000000b00b8f4c4cffd8mr12782968ybe.24.1682446513075; Tue, 25
 Apr 2023 11:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230412093425.3659088-1-ajayagarwal@google.com> <ZEBBCg3DEhytqnMb@google.com>
In-Reply-To: <ZEBBCg3DEhytqnMb@google.com>
From:   Ajay Agarwal <ajayagarwal@google.com>
Date:   Tue, 25 Apr 2023 23:44:59 +0530
Message-ID: <CAHMEbQ_8KNWwWxaY-7JxEu=wQ58WXQQ5XBaHOxFUE7NRKSNiUA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: dwc: Wait for link up only if link is started
To:     William McVicker <willmcvicker@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sajid Dalvi <sdalvi@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ccpol: medium
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for the review and testing the patch William!

Hi Lorenzo
Can you please include this patch in the next release if it looks good?

On Thu, Apr 20, 2023 at 12:59=E2=80=AFAM William McVicker
<willmcvicker@google.com> wrote:
>
> On 04/12/2023, Ajay Agarwal wrote:
> > In dw_pcie_host_init() regardless of whether the link has been
> > started or not, the code waits for the link to come up. Even in
> > cases where start_link() is not defined the code ends up spinning
> > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > gets called during probe, this one second loop for each pcie
> > interface instance ends up extending the boot time.
> >
> > Wait for the link up in only if the start_link() is defined.
> >
> > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> > Changelog since v3:
> > - Run dw_pcie_start_link() only if link is not already up
> >
> > Changelog since v2:
> > - Wait for the link up if start_link() is really defined.
> > - Print the link status if the link is up on init.
> >
> >  .../pci/controller/dwc/pcie-designware-host.c | 13 ++++++++----
> >  drivers/pci/controller/dwc/pcie-designware.c  | 20 ++++++++++++-------
> >  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> >  3 files changed, 23 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driver=
s/pci/controller/dwc/pcie-designware-host.c
> > index 9952057c8819..cf61733bf78d 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -485,14 +485,19 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >       if (ret)
> >               goto err_remove_edma;
> >
> > -     if (!dw_pcie_link_up(pci)) {
> > +     if (dw_pcie_link_up(pci)) {
> > +             dw_pcie_print_link_status(pci);
> > +     } else {
> >               ret =3D dw_pcie_start_link(pci);
> >               if (ret)
> >                       goto err_remove_edma;
> > -     }
> >
> > -     /* Ignore errors, the link may come up later */
> > -     dw_pcie_wait_for_link(pci);
> > +             if (pci->ops && pci->ops->start_link) {
> > +                     ret =3D dw_pcie_wait_for_link(pci);
> > +                     if (ret)
> > +                             goto err_stop_link;
> > +             }
> > +     }
> >
> >       bridge->sysdata =3D pp;
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index 53a16b8b6ac2..03748a8dffd3 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -644,9 +644,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 =
dir, int index)
> >       dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
> >  }
> >
> > -int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > +void dw_pcie_print_link_status(struct dw_pcie *pci)
> >  {
> >       u32 offset, val;
> > +
> > +     offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +     val =3D dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > +
> > +     dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > +              FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > +              FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > +}
> > +
> > +int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > +{
> >       int retries;
> >
> >       /* Check if the link is up or not */
> > @@ -662,12 +673,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >               return -ETIMEDOUT;
> >       }
> >
> > -     offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > -     val =3D dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > -
> > -     dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > -              FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > -              FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > +     dw_pcie_print_link_status(pci);
> >
> >       return 0;
> >  }
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 79713ce075cc..615660640801 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -429,6 +429,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
> >  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> >  int dw_pcie_edma_detect(struct dw_pcie *pci);
> >  void dw_pcie_edma_remove(struct dw_pcie *pci);
> > +void dw_pcie_print_link_status(struct dw_pcie *pci);
> >
> >  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u3=
2 val)
> >  {
> > --
> > 2.40.0.577.gac1e443424-goog
> >
>
> Thanks for sending this patch Ajay! I tested this on my Pixel 6 with 6.3-=
rc1.
> I verified the PCIe RC probes without the 1s delay in dw_pcie_wait_for_li=
nk().
> Feel free to include
>
> Tested-by: Will McVicker <willmcvicker@google.com>
