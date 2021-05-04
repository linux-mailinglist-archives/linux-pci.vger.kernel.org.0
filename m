Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F3C372DF6
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 18:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhEDQY2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 12:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231523AbhEDQY1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 May 2021 12:24:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46957611AD;
        Tue,  4 May 2021 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620145412;
        bh=OjTM3wjN3EUalqu7VP3gGcczRSciVlWRIKa7hPRIbmw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WIKvK7ezck0cLI8tML9ClP7dOnYY3ZnzY+99TcsSBkwttohmLHSOaNFDPxgXTtm4l
         MCCyZGfCB1d7PDTDQkNlGwWzvGoBIjS4Z3f9Db7z3BPDACcnQGeZJCYHdAK34Phl08
         Mjq6MzT1qYp/lhNeSSDoI/Z8bkQ2/bLgdhfkzz26WUiDgmrxI26epnFeYXlKJ0FqBN
         AMzj+om8OFAuNGpGPLvueA7ZPG0d/sxoEIDQDa9LPMguAUi1BxVEzIWWBUJQz6RHa2
         wQQsFGF5VzcOo82pFVJ0tEztkbiOLkBz8KDblQnjpCc5UR/axyx09GrkN5Xditg7W5
         rYjg5Ugi4kpng==
Date:   Tue, 4 May 2021 11:23:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Greentime Hu <greentime.hu@sifive.com>, paul.walmsley@sifive.com,
        hes@sifive.com, erik.danie@sifive.com, zong.li@sifive.com,
        bhelgaas@google.com, robh+dt@kernel.org, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 1/6] clk: sifive: Add pcie_aux clock in prci driver
 for PCIe driver
Message-ID: <20210504162331.GA1122904@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJE886bhppqes5LQ@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 04, 2021 at 03:24:19PM +0300, Leon Romanovsky wrote:
> On Tue, May 04, 2021 at 06:59:35PM +0800, Greentime Hu wrote:
> > We add pcie_aux clock in this patch so that pcie driver can use
> > clk_prepare_enable() and clk_disable_unprepare() to enable and disable
> > pcie_aux clock.
> > 
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  drivers/clk/sifive/fu740-prci.c               | 11 +++++
> >  drivers/clk/sifive/fu740-prci.h               |  2 +-
> >  drivers/clk/sifive/sifive-prci.c              | 41 +++++++++++++++++++
> >  drivers/clk/sifive/sifive-prci.h              |  9 ++++
> >  include/dt-bindings/clock/sifive-fu740-prci.h |  1 +
> >  5 files changed, 63 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-prci.c
> > index 764d1097aa51..53f6e00a03b9 100644
> > --- a/drivers/clk/sifive/fu740-prci.c
> > +++ b/drivers/clk/sifive/fu740-prci.c
> > @@ -72,6 +72,12 @@ static const struct clk_ops sifive_fu740_prci_hfpclkplldiv_clk_ops = {
> >  	.recalc_rate = sifive_prci_hfpclkplldiv_recalc_rate,
> 
> <...>
> 
> > +/* PCIE AUX clock APIs for enable, disable. */
> > +int sifive_prci_pcie_aux_clock_is_enabled(struct clk_hw *hw)
> 
> It should be bool

It's used via this function pointer:

  struct clk_ops {
    int             (*is_enabled)(struct clk_hw *hw);

so I think "int" is actually appropriate here.

There are some weird/interesting bool vs int usages nearby, though:

  "bool __is_clk_gate_enabled()" goes to some trouble to convert
  int to bool ("return (reg_val & bit_mask) != 0;"), and then
  kona_peri_clk_is_enabled() converts the bool back to int ("return
  is_clk_gate_enabled(bcm_clk->ccu, gate) ? 1 : 0;").

  "int lpc32xx_clk_gate_is_enabled()" actually returns a bool that is
  implicitly converted to int.

  Many *_is_enabled() functions return !!(...) where !! is an
  int-to-bool conversion that is arguably unnecessary and again
  results in an implicit conversion to int.

I don't see any *problems* with any of these; it just seems like a
little more mental effort to think about all the explicit and implicit
conversions going on.

> > +int sifive_prci_pcie_aux_clock_enable(struct clk_hw *hw)
> > +{
> > +	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
> > +	struct __prci_data *pd = pc->pd;
> > +	u32 r __maybe_unused;
> > +
> > +	if (sifive_prci_pcie_aux_clock_is_enabled(hw))
> > +		return 0;
> 
> You actually call to this new function only once, put your
> __prci_readl() here.

Both sifive_prci_pcie_aux_clock_enable() and
sifive_prci_pcie_aux_clock_is_enabled() are used via the clk_ops
function pointers.

Maybe sifive_prci_pcie_aux_clock_is_enabled() could be replaced by the
__prci_readl() here, but I don't know enough about clk_ops internals
to know.

Bjorn
