Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12053FCAA2
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 17:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhHaPTC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 11:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232559AbhHaPTC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Aug 2021 11:19:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBCB46103A;
        Tue, 31 Aug 2021 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630423087;
        bh=RJTxHIyrBUknplHV6hGq8g2EyXUUbu+8+pAvfCZtkMk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G0yMMTqHzwe0qELu/DoAveRwHUB13dr3KPJRkqxmmeotdjBerRgfbWfJzvi9M4w7j
         R3d+skaMiYzBdMNJOfXm9IWujZ7afBwVsnt3mzrac3T8HNMuZFQm6btu2kyq11MD9l
         NU0wxpysBolR1UlYFWOd3DdrfplB3FDtilgRYq9UbC1JXckD5jD+uXirhjfZ876WcO
         cqkLBhbYdUEdxIO0Y3pu3KB4qCvNUYdQDdwG5VOgIGLiZCWlloej9IUto9KfnXma+I
         CftbNTGohba7GqvjL/2RLJlsW3BEuUXuEVwcoNO1UjdzSkJ21YGcAF73la1USBO6cM
         6J9E/lUdaDRTA==
Received: by mail-ej1-f52.google.com with SMTP id e21so39507055ejz.12;
        Tue, 31 Aug 2021 08:18:06 -0700 (PDT)
X-Gm-Message-State: AOAM533EBAIN1HUAZg0/mQATQ8qqgXXGodmv2IfUN97ibNJZ9hbfx17i
        HWNAvjWe1xztl4hw9M8chUknL8zsQLruroCGlQ==
X-Google-Smtp-Source: ABdhPJy8LprSPFGyN9DqZEs0SFSzAWJ2ZV2nFyBr73KsmWA8/W5JGC4e+TWoma70T7sy/5hnC40loUZrlfZ4loNuCl4=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr32127271eje.341.1630423085544;
 Tue, 31 Aug 2021 08:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210830214317.GA27606@bjorn-Precision-5520> <ccf767340afe13a6d273ad8fbc29c6bc966d6314.camel@mediatek.com>
In-Reply-To: <ccf767340afe13a6d273ad8fbc29c6bc966d6314.camel@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 31 Aug 2021 10:17:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+dBi-XUDJD_STP=jWw+RLkRpX1U9XsRMhqK4U1H=0FHw@mail.gmail.com>
Message-ID: <CAL_Jsq+dBi-XUDJD_STP=jWw+RLkRpX1U9XsRMhqK4U1H=0FHw@mail.gmail.com>
Subject: Re: [PATCH v12 2/6] PCI: mediatek: Add new method to get shared
 pcie-cfg base address
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        PCI <linux-pci@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 30, 2021 at 10:31 PM Chuanjia Liu <chuanjia.liu@mediatek.com> wrote:
>
> On Mon, 2021-08-30 at 16:43 -0500, Bjorn Helgaas wrote:
> > On Mon, Aug 30, 2021 at 03:09:44PM +0800, Chuanjia Liu wrote:
> > > On Fri, 2021-08-27 at 11:46 -0500, Bjorn Helgaas wrote:
> > > > On Mon, Aug 23, 2021 at 11:27:56AM +0800, Chuanjia Liu wrote:
> > > > > @@ -995,6 +1004,14 @@ static int mtk_pcie_subsys_powerup(struct
> > > > > mtk_pcie *pcie)
> > > > >                         return PTR_ERR(pcie->base);
> > > > >         }
> > > > >
> > > > > +       cfg_node = of_find_compatible_node(NULL, NULL,
> > > > > +                                          "mediatek,generic-
> > > > > pciecfg");
> > > > > +       if (cfg_node) {
> > > > > +               pcie->cfg = syscon_node_to_regmap(cfg_node);
> > > >
> > > > Other drivers in drivers/pci/controller/ use
> > > > syscon_regmap_lookup_by_phandle() (j721e, dra7xx, keystone,
> > > > layerscape, artpec6) or syscon_regmap_lookup_by_compatible()
> > > > (imx6,
> > > > kirin, v3-semi).
> > > >
> > > > You should do it the same way unless there's a need to be
> > > > different.
> > >
> > > I have used phandle, but Rob suggested to search for the node by
> > > compatible.
> > > The reason why syscon_regmap_lookup_by_compatible() is not
> > > used here is that the pciecfg node is optional, and there is no
> > > need to
> > > return error when the node is not searched.
> >
> > How about this?
> >
> >   regmap = syscon_regmap_lookup_by_compatible("mediatek,generic-
> > pciecfg");
> >   if (!IS_ERR(regmap))
> >     pcie->cfg = regmap;

+1

>
> Hi Bjorn,
>
> We need to deal with three situations
> 1) No error
> 2) The error of the node not found, don't do anything
> 3) Other errors, return errors
>
> I guess you mean
>
> regmap = syscon_regmap_lookup_by_compatible("mediatek,generic-
> pciecfg");
>   if (!IS_ERR(regmap))
>       pcie->cfg = regmap;
>   else if (IS_ERR(regmap) && PTR_ERR(regmap) != -ENODEV)

You already know  IS_ERR is true here.

>       return PTR_ERR(regmap);

syscon_regmap_lookup_by_compatible_optional is the function you are
looking for. The _optional flavor doesn't exist, so create it. There
is one for the phandle lookup.

>
> I'm not sure if we need this, it seems a little weird and there are
> many drivers in other subsystems that use syscon_node_to_regmap().

You are implementing the exact same sequence that
syscon_regmap_lookup_by_compatible() does, so clearly you should be
using it. The one difference is you forgot the of_node_put().

Rob
