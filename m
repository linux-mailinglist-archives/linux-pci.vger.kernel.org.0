Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7899467EC9
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 21:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbhLCUb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 15:31:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41356 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhLCUb6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 15:31:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F1E362CD5;
        Fri,  3 Dec 2021 20:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406A6C53FAD;
        Fri,  3 Dec 2021 20:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638563313;
        bh=d/tTsA6UHiD5aC0USnJZwrx9SEeSI7IC0tDkYQUh6jw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UEbZtu6eJPNBaLtl1F+pFfeoyV/EX8eo+tAAUl7Lnt5mgzw8nPIh2rrquvQkrt16m
         aQwK7orohNYpLHkzvgFSH2yOGfzjnviK0CoERvK3Qu8G3UcbBFJt0YwqFLWG15tFH+
         J5tfvoJ6L3YzqWoeKoIp3vUN6dawZzbG8i0OwBzyTZhwTYf9f8YcVeZtpHt8uWgM+v
         MRcsvAhANVWOtyZHueLT4G1atJnb8e3ytr2kF2uGbBZrPk2QgkokiJfMReQai0IiXl
         auiZMeXNPDh2DWOWF64x+tW8ZxU+uIdaOiv9f/zzik1yedXsg4m/StzTMTke/6iUN8
         U9uxMj1HzynyA==
Date:   Fri, 3 Dec 2021 14:28:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH] PCI: imx: do not remap invalid res
Message-ID: <20211203202831.GA3020182@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2Pfwz5e0Jj6c5npceOwuNTB_dTVuL4NMD2qxr0CGyeGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01, 2021 at 02:06:44PM -0800, Tim Harvey wrote:
> On Mon, Nov 1, 2021 at 11:03 AM Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > On imx6 and perhaps others when pcie probes you get a:
> > imx6q-pcie 33800000.pcie: invalid resource
> >
> > This occurs because the atu is not specified in the DT and as such it
> > should not be remapped.
> >
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index a945f0c0e73d..3254f60d1713 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -671,10 +671,11 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
> >                 if (!pci->atu_base) {
> >                         struct resource *res =
> >                                 platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> > -                       if (res)
> > +                       if (res) {
> >                                 pci->atu_size = resource_size(res);
> > -                       pci->atu_base = devm_ioremap_resource(dev, res);
> > -                       if (IS_ERR(pci->atu_base))
> > +                               pci->atu_base = devm_ioremap_resource(dev, res);
> > +                       }
> > +                       if (!pci->atu_base || IS_ERR(pci->atu_base))
> >                                 pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
> >                 }
> >
> > --
> > 2.17.1
> >
> 
> ping - any feedback on this?

Looks like Lorenzo corrected the subject line for you and applied it:

https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=6e5ebc96ec65
