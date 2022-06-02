Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C653BC67
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 18:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiFBQX3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 12:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbiFBQX3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 12:23:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C776715A3D
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 09:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62F5461590
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 16:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC6AC385A5;
        Thu,  2 Jun 2022 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654187006;
        bh=GEzEbsjaZRmvrXF9Ds6TvkRVO/ISEYsq5UHZcU4vjeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YaCSajEkOL3ZCKv01P14/ukIL/L1XRrm5D2nk0BRgRkVJ/VuvSH5BsH7TTC1g8OJB
         bnDcTSVgZUkTlZRTKU0Y8VU4VI2UQ/5evC+vsUyzeCTsjyKB90ygAnyWJ6PLD95/2L
         a+X4Dj3URMcptYbo+2E0q9H+xRxT+vd+iR38WZuBczs5uweAHWWrBnG9R84JuOVr/g
         RwdovuOcYtRpxaCLkIpKBVYaF44tkzHFZapwf3jlBDR6cwZXkUPfUt3bn+oMFrXC5/
         ubORbVoYxCheWJlBFoyBSjEQXkFBiT+1Y98QZEC0cbYumW5UwWEK9laLDAYJhkd0YK
         NS3IXeWefn7dg==
Date:   Thu, 2 Jun 2022 11:23:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V13 3/6] PCI: loongson: Don't access unexisting devices
Message-ID: <20220602162324.GA21622@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5c5ytuaG5dk+bXwRKiM1Mxfut_2uaZfFK1JUiO2VkqZA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 12:28:40PM +0800, Huacai Chen wrote:
> Hi, Bjorn,
> 
> On Wed, Jun 1, 2022 at 7:14 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sat, Apr 30, 2022 at 04:48:43PM +0800, Huacai Chen wrote:
> > > On LS2K/LS7A, some unexisting devices don't return 0xffffffff when
> > > scanning. This is a hardware flaw but we can only avoid it by software
> > > now.
> >
> > What happens in other situations that normally cause Unsupported
> > Request or similar errors?  For example, memory reads/writes to a
> > device in D3hot should cause an Unsupported Request error.  I'm
> > wondering whether other error handling assumptions might be broken
> > on LS2K/LS7A.
>
> Hardware engineers told me that the problem is due to pin
> multiplexing, under some configurations, a PCI device is unusable but
> the read request doesn't return 0xffffffff.

What happens if a driver does a mem read to a device that's in D3hot?

> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  drivers/pci/controller/pci-loongson.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> > > index adbfa4a2330f..48316daa1f23 100644
> > > --- a/drivers/pci/controller/pci-loongson.c
> > > +++ b/drivers/pci/controller/pci-loongson.c
> > > @@ -138,6 +138,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
> > >                              int where)
> > >  {
> > >       unsigned char busnum = bus->number;
> > > +     unsigned int device = PCI_SLOT(devfn);
> > > +     unsigned int function = PCI_FUNC(devfn);
> > >       struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
> > >
> > >       if (pci_is_root_bus(bus))
> > > @@ -147,8 +149,13 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
> > >        * Do not read more than one device on the bus other than
> > >        * the host bus. For our hardware the root bus is always bus 0.
> > >        */
> > > -     if (priv->data->flags & FLAG_DEV_FIX &&
> > > -                     !pci_is_root_bus(bus) && PCI_SLOT(devfn) > 0)
> > > +     if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
> > > +             if (!pci_is_root_bus(bus) && (device > 0))
> > > +                     return NULL;
> > > +     }
> > > +
> > > +     /* Don't access unexisting devices */
> > > +     if (pci_is_root_bus(bus) && (device >= 9 && device <= 20 && function > 0))
> >
> > Yuck.  This is pretty nasty magic.  If this is something that might be
> > fixed in future versions of the hardware, maybe you should factor this
> > out into a function pointer in loongson_pci_data or something.
> OK, seems providing a pdev_is_existant() is better.
> 
> Huacai
> >
> > >               return NULL;
> > >
> > >       /* CFG0 can only access standard space */
> > > --
> > > 2.27.0
> > >
