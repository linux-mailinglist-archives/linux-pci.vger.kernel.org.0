Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4260541CC64
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344217AbhI2TN0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 15:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346510AbhI2TNQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 15:13:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EB86610E6;
        Wed, 29 Sep 2021 19:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632942695;
        bh=UjF4jv2Ru1MqOiXSdyZgXMrL/3XRvFwF9fRUynp1WR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n8uPiJrGgzqzYAaxHjX6S+9fK9arrf3/q66chYjHHmVgnNOSdzMsYUO/lsUKyPazq
         6puYQKA+z0E7Lm5JAQiolXPqg6PACv3ciHHlRqllG9thD/uV6qMhe9MScYsQ+3PKN4
         OuMPdaEK8AaX5+7cj2XVuLKHjMNFdTl+nFEKQ1Zm8eJTreEFQxAwZfRDZNpg+EPAOm
         /r1AV9EVMQnC6fH4UHWxzu3mshPCC/e6lc+0ZlfuuxJgT1LoP+BNcYp9SmQmDvMvsJ
         JiCeFG4YJh/Ut2BuXs9ePL86ob7+16mdP7bA2dWn+pzOcSYl1wJYbVLWXrhAAAENEQ
         g8TS8+APczopQ==
Date:   Wed, 29 Sep 2021 14:11:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] PCI: rcar: Add missing COMMON_CLK dependency
Message-ID: <20210929191133.GA794252@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVNRdD8nD7w6+UsySC+8J_r5TeH1NVwgiKqKaOLBEfhcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 09:08:42PM +0200, Geert Uytterhoeven wrote:
> On Wed, Sep 29, 2021 at 8:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Sep 29, 2021 at 6:32 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Sep 29, 2021 at 03:55:09PM +0100, Lorenzo Pieralisi wrote:
> > > > On Wed, Sep 22, 2021 at 01:13:11AM +0200, Marek Vasut wrote:
> > > > > On 9/21/21 6:08 PM, Geert Uytterhoeven wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > > > > > > index 326f7d13024f..ee6f5e525d3a 100644
> > > > > > > --- a/drivers/pci/controller/Kconfig
> > > > > > > +++ b/drivers/pci/controller/Kconfig
> > > > > > > @@ -66,6 +66,7 @@ config PCI_RCAR_GEN2
> > > > > > >   config PCIE_RCAR_HOST
> > > > > > >          bool "Renesas R-Car PCIe host controller"
> > > > > > >          depends on ARCH_RENESAS || COMPILE_TEST
> > > > > > > +       depends on COMMON_CLK
> > > > > >
> > > >
> > > > Bjorn, shall we pick Arnd's patch up then ? We should be fixing this in
> > > > one of the upcoming -rcs since we introduced it in the last merge
> > > > window.
> > >
> > > IIUC, a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort
> > > hook") appeared in v5.15-rc1 and added a use of __clk_is_enabled(),
> > > which is only available when COMMON_CLK=y.
> > >
> > > PCIE_RCAR_HOST depends on ARCH_RENESAS || COMPILE_TEST.  ARCH_RENESAS
> > > is an ARM64 platform, so when COMPILE_TEST is not set, I think we get
> > > COMMON_CLK=y via this:
> > >
> > >   config ARM64
> > >     select COMMON_CLK
> > >
> > > But when ARCH_RENESAS is not set and COMPILE_TEST=y, there's nothing
> > > that enforces the dependency on COMMON_CLK.  Personally I like the
> > > first hunk of Marek's patch at [1] because the dependency on
> > > COMMON_CLK is explicit:
> > >
> > >   config PCIE_RCAR_HOST
> > >     depends on ARCH_RENESAS || COMPILE_TEST
> > >     depends on COMMON_CLK
> >
> > Agreed, Marek's version is clearer than mine, please use that.
> 
> But PCIE_RCAR_EP does not need the dependency.

Right, that's why I said the *first* hunk of Marek's patch.  I would
apply that and skip the second one.
