Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5EA34C242
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 05:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhC2DkO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Mar 2021 23:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhC2DkH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Mar 2021 23:40:07 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74107C061762
        for <linux-pci@vger.kernel.org>; Sun, 28 Mar 2021 20:40:07 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q12so5838393qvc.8
        for <linux-pci@vger.kernel.org>; Sun, 28 Mar 2021 20:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t+xrhMH6Gr2A3zI8Lcey2uhccYuzey1LBxw8FGRBr38=;
        b=GlrshGa0JheYxNSV53Bg30loaFV1EoaqTDeQ4sNl5yMfy0XcZRrlxMtdMSPW1A7Yf4
         EbTgvKP2xqK9gpYlJKevK6F099bP6A7MjXe561/2v+ADngUOs3cryvs85OYWgtjJZXfk
         1iQoDgHm2qxjio8Y9Ymp80ANC43PudXOfx/WUcIOvInOgXAy7VcIgWyRsm98QhImbst5
         +/1tM1ELbjLI5lHjScnDyL90S4FRIHjiUbfHkrmzex7q+YurcZfSlSqSK3bSb3xrZVAs
         MnNvbTC7Hmn51U/oVHggPrGZ47AxohQwlQ8dtGXWZ4z6bqbTVeScW2T0abx16japHG9X
         wOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t+xrhMH6Gr2A3zI8Lcey2uhccYuzey1LBxw8FGRBr38=;
        b=VWxaFMhpX8+0m/7fnTwtcE6hYVmSBh24yy79OEkVreVnftR3xHxk29Smrh637nee0P
         9LvWgX3UyrWy49Go8F1X7N0GsO7ClHJe/ndSR+rOc5RK/QiMlCabfY3w6WUD9avA9PvX
         JOHDOlN2K9ccQk5ZIXSm04h5CwZV8v27yfoBxmOVZr8JbAprkZJduBOze2UEdCld5xIq
         V5ksfyY+aX0J4FzGZG8SCGBqMZMIoVhiT+IrtlIx6Z+PwCLbAgt+svT6XElpARW1tmj3
         RO2auJAspNaq9aUIHm04OK9tf4W7SpVFVy5uqun/NCFV2Ubw4EUZvHCpgFWaTLyLG4Gg
         S9ig==
X-Gm-Message-State: AOAM530hJTLH4mGNkjpNUTNKdi0BCAwkK/dtPPpuk6OHVYS0RZJWNU1F
        iVjJESGMjTbj2l0c5kZqzqxC6L1GPa4/Xf356MbDPg==
X-Google-Smtp-Source: ABdhPJwtzOJzKprrFyS651SYxqerVpA4YQVKn1jE961aUbyTUomzkbGS4bOkuGuS6qbJozSOfhU9WUXqdidGPMyRNcE=
X-Received: by 2002:a0c:dd14:: with SMTP id u20mr24167583qvk.13.1616989206452;
 Sun, 28 Mar 2021 20:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615954045.git.greentime.hu@sifive.com> <8008af6d86737b74020d7d8f9c3fbc9b500e9993.1615954046.git.greentime.hu@sifive.com>
 <20210323203508.GA1251968@robh.at.kernel.org>
In-Reply-To: <20210323203508.GA1251968@robh.at.kernel.org>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Mon, 29 Mar 2021 11:39:54 +0800
Message-ID: <CAHCEehKw2Sb6DN-hQCZB8-ARuaOf47mmzS18Fqm1amr4sXVCRg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, hes@sifive.com,
        Erik Danie <erik.danie@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, Philipp Zabel <p.zabel@pengutronix.de>,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2021=E5=B9=B43=E6=9C=8824=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=884:35=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Mar 18, 2021 at 02:08:11PM +0800, Greentime Hu wrote:
> > Add PCIe host controller DT bindings of SiFive FU740.
> >
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  .../bindings/pci/sifive,fu740-pcie.yaml       | 119 ++++++++++++++++++
> >  1 file changed, 119 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-=
pcie.yaml
[...]
> > +examples:
> > +  - |
> > +    pcie@e00000000 {
> > +        #address-cells =3D <3>;
> > +        #interrupt-cells =3D <1>;
> > +        #size-cells =3D <2>;
> > +        compatible =3D "sifive,fu740-pcie";
> > +        reg =3D <0xe 0x00000000 0x1 0x0
>
> Humm, 4GB for DBI space? The DWC controller doesn't have that much
> space, and the kernel will map *all* of that. That's not an
> insignificant amount of memory just for page tables.

Thank you for review and point this out. :)

I check the spec description for DBI in DWC_pcie_ctl_dm_databook.pdf
section 3.15 3.16 and table 3-17.

I think CX_SRIOV_ENABLE and CX_ARI_ENABLE will be set to 0 because
these 2 are endpoint mode features.
Single Root I/O Virtualization (SR-IOV) This section describes the
SR-IOV features implemented in EP mode. The parameter for enabling
SR-IOV is CX_SRIOV_ENABLE
Alternative Routing-ID Interpretation (ARI) ARI allows an endpoint to
support more than eight physical functions (PFs). ARI is enabled by
the CX_ARI_ENABLE parameter.

So based on Table 3-17, we will need to map 2GB(bit30) instead of 4GB(bit31=
).
