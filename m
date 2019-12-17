Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFFEB1238E4
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 22:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfLQVyj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 16:54:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfLQVyi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 16:54:38 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C73206B7;
        Tue, 17 Dec 2019 21:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576619678;
        bh=wdyV16wlU9V9Sjvh2PVgfC0/SgWz45D/9pDQ0Y8PBj8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=chZCfW9WwO7YaHDGHv+ZcSQnY6TEQqSOlzLpafVWNKzleI+RBH6wAusrYEtULFjHZ
         JiwosCJMmJ9Xw3M7Yk9AHVqw++52rhOyjb8T01xfC5bJY5fJM5v9gpxu/0R7p2L4R4
         fYg+kSR25TiN+YN6KhvkAAN78YwbTInjUwJ5ilpU=
Date:   Tue, 17 Dec 2019 15:54:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yurii Monakov <monakov.y@gmail.com>
Cc:     linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] PCI: keystone: Fix outbound region mapping
Message-ID: <20191217215436.GA230275@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217193131.2dc1c53c@monakov-y.xu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 17, 2019 at 07:31:31PM +0300, Yurii Monakov wrote:
> On Tue, 17 Dec 2019 08:31:13 -0600, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > [+cc Kishon]
> > 
> > On Fri, Oct 04, 2019 at 06:48:11PM +0300, Yurii Monakov wrote:
> > > PCIe window memory start address should be incremented by OB_WIN_SIZE
> > > megabytes (8 MB) instead of plain OB_WIN_SIZE (8).
> > > 
> > > Signed-off-by: Yurii Monakov <monakov.y@gmail.com>  
> > 
> > I added:
> > 
> >   Fixes: e75043ad9792 ("PCI: keystone: Cleanup outbound window configuration")
> >   Acked-by: Andrew Murray <andrew.murray@arm.com>
> >   Cc: stable@vger.kernel.org      # v4.20+
> > 
> > and cc'd Kishon (author of  e75043ad9792) and put this on my
> > pci/host-keystone branch for v5.6.  Lorenzo may pick this up when he
> > returns.
> > 
> > I'd like the commit message to say what this fixes.  Currently it just
> > restates the code change, which I can see from the diff.
> This was my first patch sent to LKML, I'm sorry for inconvenience.
> Should I take any actions to fix this?

Great, welcome!  No need for you to do anything; just let me know if I
captured this correctly:

commit 93c53da177c9 ("PCI: keystone: Fix outbound region mapping")
Author: Yurii Monakov <monakov.y@gmail.com>
Date:   Fri Oct 4 18:48:11 2019 +0300

    PCI: keystone: Fix outbound region mapping
    
    The Keystone outbound Address Translation Unit (ATU) maps PCI MMIO space in
    8 MB windows.  When programming the ATU windows, we previously incremented
    the starting address by 8, not 8 MB, so all the windows were mapped to the
    first 8 MB.  Therefore, only 8 MB of MMIO space was accessible.
    
    Update the loop so it increments the starting address by 8 MB, not 8, so
    more MMIO space is accessible.
    
    Fixes: e75043ad9792 ("PCI: keystone: Cleanup outbound window configuration")
    Link: https://lore.kernel.org/r/20191004154811.GA31397@monakov-y.office.kontur-niirs.ru
    [bhelgaas: commit log]
    Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Andrew Murray <andrew.murray@arm.com>
    Cc: stable@vger.kernel.org	# v4.20+

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index af677254a072..f19de60ac991 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -422,7 +422,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 				   lower_32_bits(start) | OB_ENABLEN);
 		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
 				   upper_32_bits(start));
-		start += OB_WIN_SIZE;
+		start += OB_WIN_SIZE * SZ_1M;
 	}
 
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
