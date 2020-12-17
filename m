Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C088F2DD5AE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Dec 2020 18:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgLQRH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Dec 2020 12:07:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:53998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgLQRH3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Dec 2020 12:07:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2BBB2ACA5;
        Thu, 17 Dec 2020 17:06:47 +0000 (UTC)
Date:   Thu, 17 Dec 2020 18:06:35 +0100
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: dwc: tegra194: issue with card containing a bridge
Message-ID: <20201217170635.GA52649@suse.de>
References: <20201215102442.GA20517@suse.de>
 <9a8abc90-cf18-b0c8-3bcb-efbe03f0ca4c@nvidia.com>
 <20201215132504.GA20914@suse.de>
 <20201215154147.GA3885265@robh.at.kernel.org>
 <20201215205235.GC20914@suse.de>
 <20201217145857.GA3941403@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201217145857.GA3941403@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 17, 2020 at 08:58:57AM -0600, Rob Herring wrote:
> On Tue, Dec 15, 2020 at 09:52:35PM +0100, Mian Yousaf Kaukab wrote:
> > On Tue, Dec 15, 2020 at 09:41:47AM -0600, Rob Herring wrote:
> > > On Tue, Dec 15, 2020 at 02:25:04PM +0100, Mian Yousaf Kaukab wrote:
> > > > On Tue, Dec 15, 2020 at 05:45:59PM +0530, Vidya Sagar wrote:
> > > > > Thanks Mian for bringing it to our notice.
> > > > > Have you tried removing the dw_pcie_setup_rc(pp); call from pcie-tegra194.c
> > > > > file on top of linux-next? and does that solve the issue?
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > > b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > > index 5597b2a49598..1c9e9c054592 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > > @@ -907,7 +907,7 @@ static void tegra_pcie_prepare_host(struct pcie_port
> > > > > *pp)
> > > > >                 dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF,
> > > > > val);
> > > > >         }
> > > > > 
> > > > > -       dw_pcie_setup_rc(pp);
> > > > > +       //dw_pcie_setup_rc(pp);
> > > > I still see the same issue with this change.
> > > > Reverting b9ac0f9dc8ea works though.
> > > > > 
> > > > >         clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> > > > > 
> > > > > I took a quick look at the dw_pcie_setup_rc() implementation and I'm not
> > > > > sure why calling it second time should create any issue for the enumeration
> > > > > of devices behind a switch. Perhaps I need to spend more time to debug that
> > > > > part.
> > > > > In any case, since dw_pcie_setup_rc() is already part of
> > > > > dw_pcie_host_init(), I think it can be removed from
> > > > > tegra_pcie_prepare_host() implemention.
> > > 
> > > I think the 2nd time is making the link go down is my guess. Tegra was 
> > > odd in that its start/stop link functions don't do link handling, so I 
> > > didn't implement those functions and left the link handling in the Tegra 
> > > driver.
> > > 
> > > Can you try the below patch. It needs some more work as it breaks 
> > > endpoint mode.
> 
> [...]
> 
> > Boot is ok with this patch. Some improvement in lspci as well:
> 
> Some improvement? Meaning not completely working still?
> 
> > # lspci
> > 0001:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad2 (rev a1)
> > 0001:01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9171 (rev 13)
> > 0005:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1)
> > 0005:01:00.0 PCI bridge: PLX Technology, Inc. Device 3380 (rev ab)
> 
> This patch was closer to the original flow, but would not have worked if 
> DLFE disabled mode was needed.
> 
> Please give this patch a try:
Thank you for the patch! Initial results with it looks very promising.
I’ll get back to you tomorrow after running a few more tests.

BR,
Yousaf
