Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2507A4A9B2B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 15:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359388AbiBDOpm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 09:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345529AbiBDOpl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 09:45:41 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B96C061714;
        Fri,  4 Feb 2022 06:45:41 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id s13so20184676ejy.3;
        Fri, 04 Feb 2022 06:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VlkCsEokLP3ZMpnoXSjzqIzeww+Gg3E6sh/gyoxrWnE=;
        b=BGtI1FWpwJT5dh7jksID6aVpM7hT067KT1TTlpJV9gJ+pHkK4/Kci2tJB0Coc8voER
         5c/Z/TiPiTII9Vj18nrtPg56eK3QcA7VM+zWU4tPhbZ/Tu6KYGZfuT8N9QHio6Ge/a1x
         /xCAfBhMCBniljdQXhi7LmGDl3UclYtreQhQYgUScZFEQ7vZmSLXv0mdR+GOvgnGgSCi
         ez7OydmHr4WxiQM0U5sCEVurar5U7hYLGs0nhRX22LBLDWcrvTj4REv9I2Ve0WUINLem
         3M0wN30kvOZMlaHoh4/lrZ2JGPa7+ZRW3JOmpV3/IqhZlvu9XoIrCr7IXkFVKNwVb+i4
         Iqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VlkCsEokLP3ZMpnoXSjzqIzeww+Gg3E6sh/gyoxrWnE=;
        b=iVVYfmuUdcqjdKL9bqIk9POYw31g/hYgnqUD4aALscqEZXUmgIBgERjhksPYA07GJ4
         LPq+9E5DjBdBpMUlvwvY+0Yj4lyMIO2FAEasCkLaJJTsL+ui5snJmori+oqSYbG25G1o
         Cquw+8qcFcA5ohLRsUyspGcuVKhAvv4qQwXtmNvBemKKp6NbN5ZHsAvZyUw1agEmXoFg
         IP+90YWui5PgAdDZHjm3wZ0ZvaX0fRQzp0q2TMxIUsYs1eFSZaBTxGrNkGqU3M1O98Le
         OzRGySKy1vyVWKnmaKTJlaxm3mVNvE7TBSQ+xNmNPc0TorlIdPPMvztMdCVOPh3caTAV
         KmHQ==
X-Gm-Message-State: AOAM532qNdqOrbHNNLIy0yaPVa8p2h5R2IEr249TtGkTOtlO/kFtp9At
        A8tmdgJoCIVUUH1AXhZY/xvxUrrAERYBvbRBZ5M=
X-Google-Smtp-Source: ABdhPJxwWTqizYRrSpbkbWHjvmJqz5j5xElENgw2nKw/iO3i5JitvaGqoTOFqeYSPGrs1KLpEzSvFukGMqrU9PKLBDQ=
X-Received: by 2002:a17:907:72c1:: with SMTP id du1mr2752799ejc.561.1643985939768;
 Fri, 04 Feb 2022 06:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20220131120841.118833-1-christian.gmeiner@gmail.com> <20220131220518.GA515079@bhelgaas>
In-Reply-To: <20220131220518.GA515079@bhelgaas>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 4 Feb 2022 15:45:28 +0100
Message-ID: <CAH9NwWduP=frHt6kSXHHbkx6fKivH-R9m6+Z6AXqYXgK0eTJ=A@mail.gmail.com>
Subject: Re: [PATCH] PCI: cadence: respond to received PTM Requests
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        sjakhade@cadence.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

Am Mo., 31. Jan. 2022 um 23:05 Uhr schrieb Bjorn Helgaas <helgaas@kernel.or=
g>:
>
> Update subject line to match previous conventions ("git log --oneline
> drivers/pci/controller/cadence/pcie-cadence-host.c" to see).
>

Sure

> On Mon, Jan 31, 2022 at 01:08:27PM +0100, Christian Gmeiner wrote:
> > This enables the Controller [RP] to automatically respond
> > with Response/ResponseD messages.
>
> Update to imperative mood, e.g., "Enable Controller to ...":
>
>   https://chris.beams.io/posts/git-commit/
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/maintainer-tip.rst?id=3Dv5.16#n134
>

Sure


> > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > ---
> >  drivers/pci/controller/cadence/pcie-cadence-host.c | 10 ++++++++++
> >  drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drive=
rs/pci/controller/cadence/pcie-cadence-host.c
> > index fb96d37a135c..940c7dd701d6 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > @@ -123,6 +123,14 @@ static int cdns_pcie_retrain(struct cdns_pcie *pci=
e)
> >       return ret;
> >  }
> >
> > +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
> > +{
> > +     u32 val;
> > +
> > +     val =3D cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> > +     cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_=
TPM_CTRL_PTMRSEN);
>
> I assume this is some device-specific enable bit that is effectively
> ANDed with PCI_PTM_CTRL_ENABLE in the Precision Time Measurement
> Capability?
>

That is a great question to which I have no answer yet. All I have is
a PCIe based FPGA that wants a working PTM.
My target platform is an TI AM642 and I do not have a full picture of
the pci layering used (cadence, pci-j721e and pci-keystone). All I
have is the AM64x Technical Reference Manual (SPRUIM2C =E2=80=93 SEPTEMBER
2021): https://www.ti.com/lit/pdf/SPRUIM2
There I found this register and the meaning of that bit.

I think it is a good idea to get some people with knowledge on board.
So I will add Kishon Vijay Abraham I and Swapnil Jakhade to CC.

> > +}
> > +
> >  static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
> >  {
> >       struct cdns_pcie *pcie =3D &rc->pcie;
> > @@ -501,6 +509,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> >       if (rc->quirk_detect_quiet_flag)
> >               cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
> >
> > +     cdns_pcie_host_enable_ptm_response(pcie);
> > +
> >       ret =3D cdns_pcie_start_link(pcie);
> >       if (ret) {
> >               dev_err(dev, "Failed to start link\n");
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pc=
i/controller/cadence/pcie-cadence.h
> > index c8a27b6290ce..9510ea513b8a 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence.h
> > +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> > @@ -116,6 +116,10 @@
> >  #define LM_RC_BAR_CFG_APERTURE(bar, aperture)                \
> >                                       (((aperture) - 2) << ((bar) * 8))
> >
> > +/* PTM Control Register */
> > +#define CDNS_PCIE_LM_PTM_CTRL        (CDNS_PCIE_LM_BASE + 0x0DA8)
> > +#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN        BIT(17)
> > +
> >  /*
> >   * Endpoint Function Registers (PCI configuration space for endpoint f=
unctions)
> >   */
> > --
> > 2.34.1
> >



--
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
