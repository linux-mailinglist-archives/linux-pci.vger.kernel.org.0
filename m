Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49DC2F28C3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 09:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfKGIKh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 03:10:37 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46856 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfKGIKh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 03:10:37 -0500
Received: by mail-oi1-f195.google.com with SMTP id n14so1161700oie.13;
        Thu, 07 Nov 2019 00:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Ln1GAykiZS8RusuR4H+KQoetDdyYBnG1RhAd3RuDvU=;
        b=XIQjJ1KkwJwDO2WBDAlhOf60GzfwCkkbNwnxofI1gvr56DlMnJZNb4jHhH9l+siPjy
         7XUMhHNlxMeUd0C8IsfA/1LUeakE2mhibVwGsvSfeeV6D1unTFUY+jfFqzTPIcRQl5X+
         gWKfPOXD3nsSRoQRnk8+d5iIA5qxdNdnYM0aAjr5pCDue/7MNTnR9v4pFaetY9pKAOIL
         RcPun1cI3Qh9hzQ1HJD8sMy57glLs6u3q1iXmG7lA0FwoChXUDNfAOgr2ETpotB//xIX
         UnxYVtmQXIYLoaVGsh7uTHXu6+JIFIEnRncdelUnehHP33ZJr4CmSpidqTtDpVy7SPn3
         mHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Ln1GAykiZS8RusuR4H+KQoetDdyYBnG1RhAd3RuDvU=;
        b=jXkXFJEFNJU9WLirEP/Sn7tJJOv6Ym6nWlh3UeBnYz+C86DGtGD/tU9C9pLIbJVm/t
         cY6A1cv9WUqmSVWYSHSgNT6WGhhjzZXoNB+G9cVhYsa5x9omHRALVeRA3Yhr/el8QLzR
         jXCn52QdIvdJ4y0i/8WQ5TJd4mYRIhTo5eSf86pNAqC7th98jkzn0sX777IhQUkg7IVP
         eKzQ28sTXuAG+YAjEsoozPHjlNE3bH48DE6Y5/w11eM9KWOYYBplVhmUfOyW3w21X5pL
         xdNFP1Xl33HGB8r147wHcntSqb6IEw9CVyA+t5dh3zkugZdla/vHYRQP83gVC5FEl9fh
         7G2w==
X-Gm-Message-State: APjAAAXu1tPNCNl+tKGRcIL8KNNGOANBC/XVvMZgQwqGcY6mVN9CtSJu
        irTMf6I/L0dapihTroB/BkaHlp8qb3MzSp9MAWc=
X-Google-Smtp-Source: APXvYqyCsRHXrlcNyFDdWgqpUGNUi9JY2dnU8nu8fLaBJBr7i8H4CEPtAXOaCsi6gmrcZ/dmVtw/Dn8k5G1I4v7yMqw=
X-Received: by 2002:a05:6808:3cf:: with SMTP id o15mr2227687oie.7.1573114236156;
 Thu, 07 Nov 2019 00:10:36 -0800 (PST)
MIME-Version: 1.0
References: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191106193609.19645-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <OSBPR01MB210380ACAF35B2FE94F1589EB8780@OSBPR01MB2103.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB210380ACAF35B2FE94F1589EB8780@OSBPR01MB2103.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 7 Nov 2019 08:10:09 +0000
Message-ID: <CA+V-a8vJrJ8Rw5OgYZN7o_i1R9ZZUfmuMWnzA0PF+pZus0o1SQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: rcar: Add R-Car PCIe endpoint device tree bindings
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Biju,

Thank you for the review.

On Thu, Nov 7, 2019 at 7:39 AM Biju Das <biju.das@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
> Thanks for the patch
>
> > Subject: [PATCH 3/5] PCI: rcar: Add R-Car PCIe endpoint device tree bindings
> >
> > From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > This patch adds the bindings for the R-Car PCIe endpoint driver.
> >
> > Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../devicetree/bindings/pci/rcar-pci-ep.txt   | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> > b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> > new file mode 100644
> > index 000000000000..b8c8616ca007
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> > @@ -0,0 +1,43 @@
> > +* Renesas R-Car PCIe Endpoint Controller DT description
> > +
> > +Required properties:
> > +         "renesas,pcie-ep-r8a774c0" for the R8A774C0 SoC;
> > +         "renesas,pcie-ep-rcar-gen3" for a generic R-Car Gen3 or
> > +                                  RZ/G2 compatible device.
> > +
> > +         When compatible with the generic version, nodes must list the
> > +         SoC-specific version corresponding to the platform first
> > +         followed by the generic version.
> > +
> > +- reg: Five register ranges as listed in the reg-names property
> > +- reg-names: Must include the following names
> > +     - "apb-base"
> > +     - "memory0"
> > +     - "memory1"
> > +     - "memory2"
> > +     - "memory3"
> > +- resets: Must contain phandles to PCIe-related reset lines exposed by IP
> > block
> > +- clocks: from common clock binding: clock specifiers for the PCIe controller
> > +      clock.
> > +- clock-names: from common clock binding: should be "pcie".
> > +
> > +Optional Property:
> > +- max-functions: Maximum number of functions that can be configured
> > (default 1).
> > +
> > +Example:
> > +
> > +SoC-specific DT Entry:
> > +
> > +     pcie_ep: pcie_ep@fe000000 {
> > +             compatible = "renesas,pcie-r8a7791", "renesas,pcie-rcar-
> > gen2";
>
> I believe it is currently tested on RZ/G2E. so please use the same.
>
Yes you are correct its tested on RZ/G2E board, ill fix it in next iteration.

Cheers,
--Prabhakar
