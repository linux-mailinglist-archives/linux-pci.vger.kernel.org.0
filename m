Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74B41CA2A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 18:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344657AbhI2Qee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 12:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244930AbhI2Qee (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 12:34:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6772613D0;
        Wed, 29 Sep 2021 16:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632933173;
        bh=Pu4A65olMNr8uqiYaOhp03+vuksr93kEdd96A8SFaRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pdk3OySzKuPz8fIbttjoqJAj0rqGKe6CNPZ7UzWkt3bAoZ+68rcATEDR0fYmuZJ+D
         P7u49ahZAkcmssAVBsS0EXTbdTzP+gKN5vqJqOicK0eQGOWGffBWcNcgOM0FiAnEzi
         yUslt58mrcB43UBHTYBnnL/8Huk+sGHv7EvoYVIa613YkEFWYVyFwjbGiTAUu0NTWX
         r3b1A6+AMpRXaJrwhewp0jXiaxMW+UC6VpKWoq7hWlck4FEJhBnKw0Po33Da2sfbWe
         ztBfDByMyzMx1tuc1TZPKFoO1ZKVyniUrl8vYAEwtL3xzSRzfQZ0til87n4spz1SRN
         Kz1+SD3jfVCng==
Date:   Wed, 29 Sep 2021 11:32:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PCI: rcar: Add missing COMMON_CLK dependency
Message-ID: <20210929163250.GA773921@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929145509.GA20495@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 03:55:09PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Sep 22, 2021 at 01:13:11AM +0200, Marek Vasut wrote:
> > On 9/21/21 6:08 PM, Geert Uytterhoeven wrote:
> > 
> > [...]
> > 
> > > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > > > index 326f7d13024f..ee6f5e525d3a 100644
> > > > --- a/drivers/pci/controller/Kconfig
> > > > +++ b/drivers/pci/controller/Kconfig
> > > > @@ -66,6 +66,7 @@ config PCI_RCAR_GEN2
> > > >   config PCIE_RCAR_HOST
> > > >          bool "Renesas R-Car PCIe host controller"
> > > >          depends on ARCH_RENESAS || COMPILE_TEST
> > > > +       depends on COMMON_CLK
> > > 
> > > This part is OK.
> > 
> > This part is also identical in the patch from Arnd, so you can just pick
> > that one as a fix and be done with it:
> > 
> > [PATCH] PCI: rcar: add COMMON_CLK dependency
> > https://patchwork.kernel.org/project/linux-pci/patch/20210920095730.1216692-1-arnd@kernel.org/
> 
> It is not strictly identical (Arnd's patch only touches the COMPILE_TEST
> option).
> 
> Bjorn, shall we pick Arnd's patch up then ? We should be fixing this in
> one of the upcoming -rcs since we introduced it in the last merge
> window.

IIUC, a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort
hook") appeared in v5.15-rc1 and added a use of __clk_is_enabled(),
which is only available when COMMON_CLK=y.

PCIE_RCAR_HOST depends on ARCH_RENESAS || COMPILE_TEST.  ARCH_RENESAS
is an ARM64 platform, so when COMPILE_TEST is not set, I think we get
COMMON_CLK=y via this:

  config ARM64
    select COMMON_CLK

But when ARCH_RENESAS is not set and COMPILE_TEST=y, there's nothing
that enforces the dependency on COMMON_CLK.  Personally I like the
first hunk of Marek's patch at [1] because the dependency on
COMMON_CLK is explicit:

  config PCIE_RCAR_HOST
    depends on ARCH_RENESAS || COMPILE_TEST
    depends on COMMON_CLK

Whereas Arnd's patch [2] implicitly depends on the fact that the platform
selects COMMON_CLK:

  config PCIE_RCAR_HOST
    depends on ARCH_RENESAS || (COMMON_CLK && COMPILE_TEST)

But either is fine and I agree we should fix it soonish.

Bjorn

[1] https://lore.kernel.org/all/20210907144512.5238-1-marek.vasut@gmail.com/
[2] https://lore.kernel.org/all/20210920095730.1216692-1-arnd@kernel.org/
