Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCD8372FE7
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 20:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhEDSqw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 14:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhEDSqw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 May 2021 14:46:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56D51613B3;
        Tue,  4 May 2021 18:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620153956;
        bh=UTi8HBhw8z0P0MgM0KDvs/15h0MXq7TPBO59A7fxlWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n7f2f84idRrkFsoYOOczfzqsKAzM0IuEIXH33gGEJKh9Q2sW9nM3Vh7PKW25E/8b6
         Iig+PcBj24Q/qdbsBaZ4zrDSLYfI9xlKdhgV1sJFtgFR6bZQJ2kJGz2XZJ68byHV4K
         Q7eBAav8Mvug5sUswmXMYRB+1ygvttTTGWIp90ouqp0z/jprMnQ98Yzj8WNI9cgCzi
         6TND4FNt/PPyrc/CzdF8Ro9EoS2IyLARceFBW0anZCpPxzp5aBzB0lUosvmD6UXI9E
         aPmPfrhYriRlcA7a3hUsxLRvI/otU9c9b29UPUpBAiv4GIIu2BxmMy+iqJoaqYAvlo
         UTzjCTPCLwfYw==
Date:   Tue, 4 May 2021 13:45:55 -0500
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
Message-ID: <20210504184555.GA1144324@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJGOqaMulHzR9BZq@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 04, 2021 at 09:12:57PM +0300, Leon Romanovsky wrote:
> On Tue, May 04, 2021 at 11:23:31AM -0500, Bjorn Helgaas wrote:

> > There are some weird/interesting bool vs int usages nearby, though:
> > 
> >   "bool __is_clk_gate_enabled()" goes to some trouble to convert
> >   int to bool ("return (reg_val & bit_mask) != 0;"), and then
> >   kona_peri_clk_is_enabled() converts the bool back to int ("return
> >   is_clk_gate_enabled(bcm_clk->ccu, gate) ? 1 : 0;").
> > 
> >   "int lpc32xx_clk_gate_is_enabled()" actually returns a bool that is
> >   implicitly converted to int.
> > 
> >   Many *_is_enabled() functions return !!(...) where !! is an
> >   int-to-bool conversion that is arguably unnecessary and again
> >   results in an implicit conversion to int.
> > 
> > I don't see any *problems* with any of these; it just seems like a
> > little more mental effort to think about all the explicit and implicit
> > conversions going on.
> 
> The code is written once but read many times and I can't agree with
> your that examples given by you are not the *problems*. They clearly
> says "the API is not great and easily can be improved".

I certainly agree that it's easier for readers if the style is
consistent.  I just meant I didn't see anything that's an actual bug.  

Bjorn
