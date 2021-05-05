Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CBA3734B1
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 07:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhEEFXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 01:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231388AbhEEFXe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 01:23:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4FF361176;
        Wed,  5 May 2021 05:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620192158;
        bh=bPIeKfd6KZ78X0NtafKS2Ld5eWyAQr/hRA5Y7nqkX5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbsqixYgEOIdUWAQfZlPPm6FdNMeb4RmS/3GvhlnqyWw8jqKWmtDhsvXvb9Ag50zs
         /epJxLlp0YDsliOWhR8/23gNTnrg5B4WP7sHGtEYrtVSC1OnzMzePLB2/KehTQ+vVP
         euEoqHuiKHUD/U3GHMd0ubofFswfPNPnw+07Ur0MD/WaUF4hVihK3RMBzHC5f0a3+b
         c3uHJZUt9wPB4R8n6wq/gWQlMPn5dhx76Mjk4nrEj5FnXw55PHDFDnnYEhdTs2t0Ma
         mIbJvz5snMxmRP9gtHZMlswTmPt56wqx6FGqhpj3nMastgGtRnffjv/Teq6xOAWOHF
         ML20afPCMUxmA==
Date:   Wed, 5 May 2021 08:22:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <YJIrmjsYLWhIuevI@unreal>
References: <YJGOqaMulHzR9BZq@unreal>
 <20210504184555.GA1144324@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504184555.GA1144324@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 04, 2021 at 01:45:55PM -0500, Bjorn Helgaas wrote:
> On Tue, May 04, 2021 at 09:12:57PM +0300, Leon Romanovsky wrote:
> > On Tue, May 04, 2021 at 11:23:31AM -0500, Bjorn Helgaas wrote:
> 
> > > There are some weird/interesting bool vs int usages nearby, though:
> > > 
> > >   "bool __is_clk_gate_enabled()" goes to some trouble to convert
> > >   int to bool ("return (reg_val & bit_mask) != 0;"), and then
> > >   kona_peri_clk_is_enabled() converts the bool back to int ("return
> > >   is_clk_gate_enabled(bcm_clk->ccu, gate) ? 1 : 0;").
> > > 
> > >   "int lpc32xx_clk_gate_is_enabled()" actually returns a bool that is
> > >   implicitly converted to int.
> > > 
> > >   Many *_is_enabled() functions return !!(...) where !! is an
> > >   int-to-bool conversion that is arguably unnecessary and again
> > >   results in an implicit conversion to int.
> > > 
> > > I don't see any *problems* with any of these; it just seems like a
> > > little more mental effort to think about all the explicit and implicit
> > > conversions going on.
> > 
> > The code is written once but read many times and I can't agree with
> > your that examples given by you are not the *problems*. They clearly
> > says "the API is not great and easily can be improved".
> 
> I certainly agree that it's easier for readers if the style is
> consistent.  I just meant I didn't see anything that's an actual bug.  

No one said that it is a bug. My comment is better seen as s suggestion
to the maintainers on how other subsystems keep their code base clean
and up-to date.

Once "the problem" is spotted, the submitter is asked to fix it globally
including fixing other drivers if needed, before "new feature" can be merged.

Of course, there are exceptions from this rule, but they are rare and
usually given to the people who has proven record.

Thanks

> 
> Bjorn
