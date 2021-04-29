Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E9336F0F4
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 22:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbhD2UT1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 16:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236920AbhD2UT1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 16:19:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CFF7613AD;
        Thu, 29 Apr 2021 20:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619727520;
        bh=1Jlm5w7yjpdS8rVcgR+Mk9yJz6ypGJk1aLizdWq4K2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GNbr4NFJuOUv+LYf9LMx/Mk1LwzNEHsPUWRp29Dq5Dd6bhqwpbPSv8bcP25EpoHeS
         MMQUmhPG3jXYKv5ZjhkRJ1YJ6ycfb5jXC4l2MP72Ab0EIWPz5VkimopL71N1AIzrwB
         hHM6xUxWP2AzF15+WIjyd+tSUiz0DQ2Jb5Xg6xt5/mujADem+SBp4xCh7wXuJD1Esy
         8rgFIFykULOx7BJMILv6Jip++oHklf0s6g++SvOeOML+mocGTexPxrAb5faCinFkQD
         AJT2TORlqim5ZCeNTmGFVNC4BeII/1nZ8W7qKgPffRkwMMuZUce9pLg9u60DGzRET3
         0+xTG6z+KzqhQ==
Date:   Thu, 29 Apr 2021 15:18:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Greentime Hu <greentime.hu@sifive.com>, paul.walmsley@sifive.com,
        hes@sifive.com, erik.danie@sifive.com, zong.li@sifive.com,
        bhelgaas@google.com, robh+dt@kernel.org, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 5/6] PCI: fu740: Add SiFive FU740 PCIe host controller
 driver
Message-ID: <20210429201838.GA576947@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429164010.GA31397@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 29, 2021 at 05:40:11PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Apr 29, 2021 at 10:15:22AM -0500, Bjorn Helgaas wrote:
> > On Thu, Apr 29, 2021 at 03:59:54PM +0100, Lorenzo Pieralisi wrote:
> > > On Wed, Apr 28, 2021 at 02:47:13PM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Apr 06, 2021 at 05:26:33PM +0800, Greentime Hu wrote:
> > > > > From: Paul Walmsley <paul.walmsley@sifive.com>
> > > > > 
> > > > > Add driver for the SiFive FU740 PCIe host controller.
> > > > > This controller is based on the DesignWare PCIe core.
> > > > > 
> > > > > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > > > > Co-developed-by: Henry Styles <hes@sifive.com>
> > > > > Signed-off-by: Henry Styles <hes@sifive.com>
> > > > > Co-developed-by: Erik Danie <erik.danie@sifive.com>
> > > > > Signed-off-by: Erik Danie <erik.danie@sifive.com>
> > > > > Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
> > > > > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > > > 
> > > > Tripped over these errors while build testing with the .config below.
> > > 
> > > Sorry about that - the kbot did not managed to test it. Is it a
> > > randconfig ? I think we should ask the kbuild bot guys to add it,
> > > I think it can be done on a per-repo basis.
> > 
> > I don't know enough about the bot.  The lkp@intel.com reports I get
> > include allyesconfig for x86_64; not sure why that wouldn't catch
> > this.
> > > Waiting for a fix asap - I can move/rebase some commits if the fix
> > > takes time.
> > 
> > If it's feasible you could just move the FU740 stuff to a different
> > branch so we can be sure to include the other dwc stuff.  Same for
> > brcmstb.
> > 
> > Oh, and Colin just posted a NULL pointer check that could be squashed
> > into the new mediatek-gen3 driver.
> 
> All done. Updated pci/dwc, pci/brcmstb and pci/mediatek, parked the
> changes requiring a fix-up in separate branches, will push them out
> when fixed.

Thanks, I updated my "next" branch with these.

Bjorn
