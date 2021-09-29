Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A636441C776
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344737AbhI2O46 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 10:56:58 -0400
Received: from foss.arm.com ([217.140.110.172]:46826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344740AbhI2O46 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 10:56:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B60EE6D;
        Wed, 29 Sep 2021 07:55:16 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F5AD3F793;
        Wed, 29 Sep 2021 07:55:15 -0700 (PDT)
Date:   Wed, 29 Sep 2021 15:55:09 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PCI: rcar: Add missing COMMON_CLK dependency
Message-ID: <20210929145509.GA20495@lpieralisi>
References: <20210907144512.5238-1-marek.vasut@gmail.com>
 <CAMuHMdU+QteYhw6xuhuPrX5DVfmPnBgM8JfQoTk-KOP7+fSCWQ@mail.gmail.com>
 <d720b758-109a-434e-b1a4-f49649dd34e9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d720b758-109a-434e-b1a4-f49649dd34e9@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 22, 2021 at 01:13:11AM +0200, Marek Vasut wrote:
> On 9/21/21 6:08 PM, Geert Uytterhoeven wrote:
> 
> [...]
> 
> > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > > index 326f7d13024f..ee6f5e525d3a 100644
> > > --- a/drivers/pci/controller/Kconfig
> > > +++ b/drivers/pci/controller/Kconfig
> > > @@ -66,6 +66,7 @@ config PCI_RCAR_GEN2
> > >   config PCIE_RCAR_HOST
> > >          bool "Renesas R-Car PCIe host controller"
> > >          depends on ARCH_RENESAS || COMPILE_TEST
> > > +       depends on COMMON_CLK
> > 
> > This part is OK.
> 
> This part is also identical in the patch from Arnd, so you can just pick
> that one as a fix and be done with it:
> 
> [PATCH] PCI: rcar: add COMMON_CLK dependency
> https://patchwork.kernel.org/project/linux-pci/patch/20210920095730.1216692-1-arnd@kernel.org/

It is not strictly identical (Arnd's patch only touches the COMPILE_TEST
option).

Bjorn, shall we pick Arnd's patch up then ? We should be fixing this in
one of the upcoming -rcs since we introduced it in the last merge
window.

Thanks,
Lorenzo
