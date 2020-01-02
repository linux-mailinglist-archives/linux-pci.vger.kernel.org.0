Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A099D12E402
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2020 09:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgABIsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jan 2020 03:48:14 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37927 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbgABIsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jan 2020 03:48:14 -0500
Received: by mail-ot1-f66.google.com with SMTP id d7so51705596otf.5;
        Thu, 02 Jan 2020 00:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYK3JQAmW07FRU5GuNZTgBOd+vjFiils6tG0VLmuyGE=;
        b=XvrNbulzxprjJqi8RpScnA140KqOgH0A3KIwDYeZHKhtNqXpKqoIH3DkDmMCVQ4mUL
         UwesBRnFDTc16aXYRWU9fFLStptClVcntJFNz6OyMjwF05UXavP3leAtsROoVh410vm+
         jUwytle5bVp/DrZEhUKPxt7VGX15m/li3nhKMCPQHhUUfTMLo4HrwFfUuHyhLRmPJosc
         ZVN+FIUAGNI58UFohnNWgK+pW61uPy/3SkM8oE8zY+MwPijr+Ibg7angTkInKzlKJqfa
         UB5p84iBYkGvBSTVKgL5bpv2MgeEExqeZUGno4Xaoq9OwJaoN+NtTQiaOofpO6zyJYpl
         4DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYK3JQAmW07FRU5GuNZTgBOd+vjFiils6tG0VLmuyGE=;
        b=ZQJ5XERqKOsE6PBlyf4fn+oUgSy18oD4/lCAZ7FkaLqy/4xf7DqL24c5KGhfLEPeEI
         pYCVqpqndrHqQQ4Aja+Q6Su+voHcPL1Jpp+RJdnqUKGOXv0ECmRojDjWvmU/CdvFD8BS
         jAqi1HuHGJ0aSqIsaNiF9gXJ+PD371Ue6xBmeMCEfKQqbJjeT+U0eM4TNEClUdeUMoh7
         BMb+EWppXnvZU896LYdY6PCegsR/fnlPmM9hRFY5XahtHdRoHWnNLXDbBR8ovsbf+GGM
         y9t74z1csZvLCMOTTVhu0zxptnEw2hLGwdXh4TO47RlgppCEEDNt7bhaIc/vPAJ6Ywnm
         IeNg==
X-Gm-Message-State: APjAAAU2uebq3i4Wcz6805ZKdpsDJJG8ZUJzM9lPpX4r/CfU0UBg1uCs
        NIdb79qFbpEPQbOjsViEc4ToDt9FIWLoMeRZo0k=
X-Google-Smtp-Source: APXvYqxeuKbXHxGtyzku07WE9C0N/ua7Tl5Z8JOlkhllIuUswqzYTzv/m5bf/QtdXNVE3v+FavUIVxFQjdB8xF8hNl8=
X-Received: by 2002:a05:6830:1188:: with SMTP id u8mr91290992otq.274.1577954893533;
 Thu, 02 Jan 2020 00:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191213084748.11210-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <20191219233525.GA9478@bogus>
In-Reply-To: <20191219233525.GA9478@bogus>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 2 Jan 2020 08:47:47 +0000
Message-ID: <CA+V-a8vO_3P3vDFVuKLJAK7v99E7qKVAei0Kmba8tKist7mAaw@mail.gmail.com>
Subject: Re: [v2 4/6] dt-bindings: PCI: rcar: Add bindings for R-Car PCIe
 endpoint controller
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Thank you for the review.

On Thu, Dec 19, 2019 at 11:35 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Dec 13, 2019 at 08:47:46AM +0000, Lad Prabhakar wrote:
> > From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > This patch adds the bindings for the R-Car PCIe endpoint driver.
> >
> > Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../devicetree/bindings/pci/rcar-pci-ep.txt        | 37 ++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
>
> Please make this a DT schema.
>
sure will do.

> >
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> > new file mode 100644
> > index 0000000..7f0a97e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> > @@ -0,0 +1,37 @@
> > +* Renesas R-Car PCIe Endpoint Controller DT description
> > +
> > +Required properties:
> > +         "renesas,pcie-ep-r8a774c0" for the R8A774C0 SoC;
>
> Normal ordering is: renesas,r8a774c0-pcie-ep
>
> > +         "renesas,pcie-ep-rcar-gen3" for a generic R-Car Gen3 or
> > +                                  RZ/G2 compatible device.
> > +
> > +         When compatible with the generic version, nodes must list the
> > +         SoC-specific version corresponding to the platform first
> > +         followed by the generic version.
> > +
> > +- reg: base address and length of the PCIe controller registers.
> > +- outbound-ranges: outbound windows base address and length including the flags.
> > +- resets: Must contain phandles to PCIe-related reset lines exposed by IP block
>
> How many?
>
should be one.

> > +- clocks: from common clock binding: clock specifiers for the PCIe controller
> > +      clock.
> > +- clock-names: from common clock binding: should be "pcie".
> > +
> > +Optional Property:
> > +- max-functions: Maximum number of functions that can be configured (default 1).
> > +
> > +Example:
> > +
> > +SoC-specific DT Entry:
> > +
> > +     pcie_ep: pcie_ep@fe000000 {
>
> pcie-ep@
>
will fix that.

Cheers,
--Prabhakar

> > +             compatible = "renesas,pcie-ep-r8a774c0", "renesas,pcie-rcar-gen2";
> > +             reg = <0 0xfe000000 0 0x80000>;
> > +             outbound-ranges = <0xa 0x0 0xfe100000 0 0x000100000
> > +                                0xa 0x0 0xfe200000 0 0x000200000
> > +                                0x6 0x0 0x30000000 0 0x008000000
> > +                                0x6 0x0 0x38000000 0 0x008000000>;
> > +             clocks = <&cpg CPG_MOD 319>;
> > +             clock-names = "pcie";
> > +             power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
> > +             resets = <&cpg 319>;
> > +     };
> > --
> > 2.7.4
> >
