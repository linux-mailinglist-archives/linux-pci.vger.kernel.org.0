Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911A823ADDC
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 22:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgHCUAv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 16:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbgHCUAu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Aug 2020 16:00:50 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9A0222CAF;
        Mon,  3 Aug 2020 20:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596484850;
        bh=WW/ReI2Lpo+10NCbAObpKYY3zIWS1mXg+dJ8PJcCqI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JUcqzFd4A6yl5wjgxnvJtEqMsDIiLvFPojugVgGJCT+6YI378h8bswSw/TMYJNDO/
         vcNeg5RjtuSF7vaCWxj8I20jj1akQOQCP42jHQmzp1H1dl8HtbMQH+N85y8yfIa56S
         /kxD3Z/HLIAr98KvZAeuRajVevjOpt3MqUm+lVFY=
Received: by mail-oi1-f175.google.com with SMTP id l204so5573235oib.3;
        Mon, 03 Aug 2020 13:00:49 -0700 (PDT)
X-Gm-Message-State: AOAM5307lHMBZ7srFqBes80CwlqEoR2bs0u+LTWrCRsGBaVBrYciRyES
        bs/kL8o4Lpg3t82IyUlZKEs7NBaCCPK19m1Twg==
X-Google-Smtp-Source: ABdhPJyWYwSBeWPX0Ikotw5BNtaMvn06MWvQpkwp8XBO1ywypqx8qlrtD9/CrTrHCN1+zeAP+fEy8K2k1MNq4ZAB5f4=
X-Received: by 2002:aca:190c:: with SMTP id l12mr807066oii.147.1596484849037;
 Mon, 03 Aug 2020 13:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200715142557.17115-1-marek.behun@nic.cz> <20200715142557.17115-5-marek.behun@nic.cz>
 <20200729184809.GA569408@bogus> <20200803144634.nr5cjddyvdnv3lxo@pali>
In-Reply-To: <20200803144634.nr5cjddyvdnv3lxo@pali>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 3 Aug 2020 14:00:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLvqt9VneSm3Up9ib0AH7jWytA9fss_QMfJwd8xrVEp4A@mail.gmail.com>
Message-ID: <CAL_JsqLvqt9VneSm3Up9ib0AH7jWytA9fss_QMfJwd8xrVEp4A@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: aardvark: Implement driver 'remove' function and
 allow to build it as module
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        PCI <linux-pci@vger.kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Xogium <contact@xogium.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 3, 2020 at 8:46 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Wednesday 29 July 2020 12:48:09 Rob Herring wrote:
> > On Wed, Jul 15, 2020 at 04:25:56PM +0200, Marek Beh=C3=BAn wrote:
> > > From: Pali Roh=C3=A1r <pali@kernel.org>
> > >
> > > Providing driver's 'remove' function allows kernel to bind and unbind=
 devices
> > > from aardvark driver. It also allows to build aardvark driver as a mo=
dule.
> > >
> > > Compiling aardvark as a module simplifies development and debugging o=
f
> > > this driver as it can be reloaded at runtime without the need to rebo=
ot
> > > to new kernel.
> > >
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> > > ---
> > >  drivers/pci/controller/Kconfig        |  2 +-
> > >  drivers/pci/controller/pci-aardvark.c | 25 ++++++++++++++++++++++---
> > >  2 files changed, 23 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/=
Kconfig
> > > index adddf21fa381..f9da5ff2c517 100644
> > > --- a/drivers/pci/controller/Kconfig
> > > +++ b/drivers/pci/controller/Kconfig
> > > @@ -12,7 +12,7 @@ config PCI_MVEBU
> > >     select PCI_BRIDGE_EMUL
> > >
> > >  config PCI_AARDVARK
> > > -   bool "Aardvark PCIe controller"
> > > +   tristate "Aardvark PCIe controller"
> > >     depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
> > >     depends on OF
> > >     depends on PCI_MSI_IRQ_DOMAIN
> > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/cont=
roller/pci-aardvark.c
> > > index d5f58684d962..0a5aa6d77f5d 100644
> > > --- a/drivers/pci/controller/pci-aardvark.c
> > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/irq.h>
> > >  #include <linux/irqdomain.h>
> > >  #include <linux/kernel.h>
> > > +#include <linux/module.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/init.h>
> > >  #include <linux/phy/phy.h>
> > > @@ -1114,6 +1115,7 @@ static int advk_pcie_probe(struct platform_devi=
ce *pdev)
> > >
> > >     pcie =3D pci_host_bridge_priv(bridge);
> > >     pcie->pdev =3D pdev;
> > > +   platform_set_drvdata(pdev, pcie);
> > >
> > >     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >     pcie->base =3D devm_ioremap_resource(dev, res);
> > > @@ -1204,18 +1206,35 @@ static int advk_pcie_probe(struct platform_de=
vice *pdev)
> > >     return 0;
> > >  }
> > >
> > > +static int advk_pcie_remove(struct platform_device *pdev)
> > > +{
> > > +   struct advk_pcie *pcie =3D platform_get_drvdata(pdev);
> > > +   struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(pcie=
);
> > > +
> > > +   pci_stop_root_bus(bridge->bus);
> > > +   pci_remove_root_bus(bridge->bus);
> >
> > Based on pci_host_common_remove() implementation, doesn't this need a
> > lock around it (pci_lock_rescan_remove)?
>
> Well, I'm not sure. I looked into other pci drivers and none of
> following drivers pci-tegra.c, pcie-altera.c, pcie-brcmstb.c,
> pcie-iproc.c, pcie-mediatek.c, pcie-rockchip-host.c calls
> pci_lock_rescan_remove() and pci_unlock_rescan_remove().

The mutex protects the bus->devices list, so yes I believe it is needed.

Rob
