Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA75C4635C4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbhK3Nul (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhK3Nuk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:50:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418FEC061574;
        Tue, 30 Nov 2021 05:47:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12904B819AC;
        Tue, 30 Nov 2021 13:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B12C53FCD;
        Tue, 30 Nov 2021 13:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638280038;
        bh=bJQ0rPNyHmQj5pgvCHo7GRmvI6o8RT3OGU1tv1q6bko=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AO7BmZZRy1HxLAbs2HO/RFNsgNLorMTfB4aP/GhcdC4xZ31CFgYb/6Ag51IdOwsrC
         98qz+SYTcF0sDOSOjEuswX+iWThb0Q4L/q72ER4h/P2Jamh4YfBXwg8LuJk+dfLxWq
         qCj0+z71L6bWvQbk4j/XIejw3nMvOeiTCdeE7x/QsZnRrqXtq2UwPIA4TkPFxjvxq6
         3SiQbTm2qz5eFCnV7t74V4D249bNXX28JMlraE4ltAetfDbI+6vtbx4+h88A0/DdR+
         6lrQoxIgUfZ+wDN9bzPZefK4nk7PXUHBawRSev4QcCSRN9ITxx25bB24wDBBGh0zL0
         0gDrVjxIG6aZA==
Received: by mail-ed1-f52.google.com with SMTP id l25so86760576eda.11;
        Tue, 30 Nov 2021 05:47:18 -0800 (PST)
X-Gm-Message-State: AOAM531XPHUy9ytkSsEphoIVoTU/O31iIYyjLF38WolsxdU6QwCZVXcP
        aeimf7RQNL5trfM3h3+H/gjROivFsGKc6ZOzNw==
X-Google-Smtp-Source: ABdhPJxg05ApXgN6+7/B6ztitZWjTKrMZV85iNjN6Yfp+XEpFRc9ZZeFWe7fAGUuX9C6qp/x/5QqLeBzKiK7WH8BuHE=
X-Received: by 2002:aa7:cc82:: with SMTP id p2mr81704238edt.201.1638280037036;
 Tue, 30 Nov 2021 05:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20211120001621.21246-1-leoyang.li@nxp.com> <20211120001621.21246-5-leoyang.li@nxp.com>
 <YaWGKaBvTpx1pA/x@robh.at.kernel.org> <AS8PR04MB89467DDB9BC3217431716D358F679@AS8PR04MB8946.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB89467DDB9BC3217431716D358F679@AS8PR04MB8946.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 30 Nov 2021 07:47:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKdekKnG4CR3aGuOmLCxU9WzOaqLyPwBgUeE5D2WURFnQ@mail.gmail.com>
Message-ID: <CAL_JsqKdekKnG4CR3aGuOmLCxU9WzOaqLyPwBgUeE5D2WURFnQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: pci: layerscape-pci: define aer/pme interrupts
To:     Leo Li <leoyang.li@nxp.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 9:35 PM Leo Li <leoyang.li@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Monday, November 29, 2021 8:02 PM
> > To: Leo Li <leoyang.li@nxp.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Z.Q. Hou
> > <zhiqiang.hou@nxp.com>
> > Subject: Re: [PATCH 4/4] dt-bindings: pci: layerscape-pci: define aer/pme
> > interrupts
> >
> > On Fri, Nov 19, 2021 at 06:16:21PM -0600, Li Yang wrote:
> > > Some platforms using this controller have separated interrupt lines
> > > for aer or pme events instead of having a single interrupt line for
> > > miscellaneous events.  Define interrupts in the binding for these
> > > interrupt lines.
> > >
> > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > > ---
> > >  .../devicetree/bindings/pci/layerscape-pci.txt     | 14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > index 8fd6039a826b..bcf11bfc4bab 100644
> > > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > @@ -31,8 +31,13 @@ Required properties:
> > >  - reg: base addresses and lengths of the PCIe controller register blocks.
> > >  - interrupts: A list of interrupt outputs of the controller. Must contain an
> > >    entry for each entry in the interrupt-names property.
> > > -- interrupt-names: Must include the following entries:
> > > -  "intr": The interrupt that is asserted for controller interrupts
> > > +- interrupt-names: It could include the following entries:
> > > +  "aer": For interrupt line reporting aer events when non MSI/MSI-X/INTx
> > mode
> > > +           is used
> > > +  "pme": For interrupt line reporting pme events when non MSI/MSI-
> > X/INTx mode
> > > +           is used
> > > +  "intr": For interrupt line reporting miscellaneous controller
> > > +events
> > > +  ......
> > >  - fsl,pcie-scfg: Must include two entries.
> > >    The first entry must be a link to the SCFG device node
> > >    The second entry is the physical PCIe controller index starting from '0'.
> > > @@ -52,8 +57,9 @@ Example:
> > >             reg = <0x00 0x03400000 0x0 0x00010000   /* controller
> > registers */
> > >                    0x40 0x00000000 0x0 0x00002000>; /* configuration space
> > */
> > >             reg-names = "regs", "config";
> > > -           interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /*
> > controller interrupt */
> > > -           interrupt-names = "intr";
> > > +           interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>, /* aer
> > interrupt */
> > > +                   <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* pme
> > interrupt */
> > > +           interrupt-names = "aer", "pme";
> >
> > This isn't a compatible change. The h/w suddenly has no 'intr'
> > interrupt?
>
> The original 'intr' was just a place holder for a HW interrupt signal without a clear definition of events associated.  Some later SoC has more interrupt signals to associate with more specific events.

'Later SoC' means new compatible, but you're not changing the
compatible. If it was just wrong for all SoCs, then state that in the
commit message. Please define all the interrupts on all SoCs, so it is
not changing again.

> If needed, we can keep the "intr" interrupt-name there just for backward compatibility although it was never used in Linux.

What about other OSs?

Rob
