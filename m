Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 074BA1374DD
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 18:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgAJRdq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 12:33:46 -0500
Received: from foss.arm.com ([217.140.110.172]:49134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgAJRdp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jan 2020 12:33:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3808130E;
        Fri, 10 Jan 2020 09:33:45 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E8A93F6C4;
        Fri, 10 Jan 2020 09:33:44 -0800 (PST)
Date:   Fri, 10 Jan 2020 17:33:42 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yurii Monakov <monakov.y@gmail.com>, linux-pci@vger.kernel.org,
        m-karicheri2@ti.com, Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] PCI: keystone: Fix outbound region mapping
Message-ID: <20200110173342.GC885@e121166-lin.cambridge.arm.com>
References: <20191217193131.2dc1c53c@monakov-y.xu>
 <20191217215436.GA230275@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217215436.GA230275@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 17, 2019 at 03:54:36PM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 17, 2019 at 07:31:31PM +0300, Yurii Monakov wrote:
> > On Tue, 17 Dec 2019 08:31:13 -0600, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > > [+cc Kishon]
> > > 
> > > On Fri, Oct 04, 2019 at 06:48:11PM +0300, Yurii Monakov wrote:
> > > > PCIe window memory start address should be incremented by OB_WIN_SIZE
> > > > megabytes (8 MB) instead of plain OB_WIN_SIZE (8).
> > > > 
> > > > Signed-off-by: Yurii Monakov <monakov.y@gmail.com>  
> > > 
> > > I added:
> > > 
> > >   Fixes: e75043ad9792 ("PCI: keystone: Cleanup outbound window configuration")
> > >   Acked-by: Andrew Murray <andrew.murray@arm.com>
> > >   Cc: stable@vger.kernel.org      # v4.20+
> > > 
> > > and cc'd Kishon (author of  e75043ad9792) and put this on my
> > > pci/host-keystone branch for v5.6.  Lorenzo may pick this up when he
> > > returns.
> > > 
> > > I'd like the commit message to say what this fixes.  Currently it just
> > > restates the code change, which I can see from the diff.
> > This was my first patch sent to LKML, I'm sorry for inconvenience.
> > Should I take any actions to fix this?
> 
> Great, welcome!  No need for you to do anything; just let me know if I
> captured this correctly:

Bjorn, I took your refactored patch below from -next and left your
SOB in place because technically you changed the patch.

Merged in my pci/keystone branch.

Thanks,
Lorenzo

> commit 93c53da177c9 ("PCI: keystone: Fix outbound region mapping")
> Author: Yurii Monakov <monakov.y@gmail.com>
> Date:   Fri Oct 4 18:48:11 2019 +0300
> 
>     PCI: keystone: Fix outbound region mapping
>     
>     The Keystone outbound Address Translation Unit (ATU) maps PCI MMIO space in
>     8 MB windows.  When programming the ATU windows, we previously incremented
>     the starting address by 8, not 8 MB, so all the windows were mapped to the
>     first 8 MB.  Therefore, only 8 MB of MMIO space was accessible.
>     
>     Update the loop so it increments the starting address by 8 MB, not 8, so
>     more MMIO space is accessible.
>     
>     Fixes: e75043ad9792 ("PCI: keystone: Cleanup outbound window configuration")
>     Link: https://lore.kernel.org/r/20191004154811.GA31397@monakov-y.office.kontur-niirs.ru
>     [bhelgaas: commit log]
>     Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Andrew Murray <andrew.murray@arm.com>
>     Cc: stable@vger.kernel.org	# v4.20+
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index af677254a072..f19de60ac991 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -422,7 +422,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  				   lower_32_bits(start) | OB_ENABLEN);
>  		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
>  				   upper_32_bits(start));
> -		start += OB_WIN_SIZE;
> +		start += OB_WIN_SIZE * SZ_1M;
>  	}
>  
>  	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
