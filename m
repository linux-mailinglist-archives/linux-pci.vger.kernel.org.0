Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C363B5801A1
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 17:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiGYPVZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 11:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiGYPVM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 11:21:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC976167;
        Mon, 25 Jul 2022 08:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A8661284;
        Mon, 25 Jul 2022 15:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3B7C341C8;
        Mon, 25 Jul 2022 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658762319;
        bh=9nUkscWr6F41nc6e9ioJgyDs4jP8GMh1w//u9IckWOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=togkg6dzHsqFJNhh2OMC+RUpofF2Ut8DKGR/s7JbC1NxYk+eaySs9IUspg6SkixDC
         +P3g/3CjBISitRaQ6IokxpMUcRBdu4KtFH9i5OcU9HhqN3zOrkeVyLbOqHJlJUkAvF
         mSVqApIroZEc77KjLvHCcpJlI+/hoUulDkxsarq/qhvbXrYk6XxXCFr7U/xblMxcV0
         uP7jQ4mdHKp+niT3l0qwKf1nSnWQFwiAVdHEuaNbPDcTPJRyqkusS1Z+NTt2khGTyb
         T2LiVKORgQsaGXc7lhQYhzCbKwWk8FbewyWFIbVA6ema+ZmAbBWn2TA6LVuFJTrhFm
         RnlTiw7Q+M2mg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFzr6-0001RI-6H; Mon, 25 Jul 2022 17:18:48 +0200
Date:   Mon, 25 Jul 2022 17:18:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Message-ID: <Yt60WNVNEVHgzSuN@hovoldconsulting.com>
References: <YtqllIHY/R/BbR3V@hovoldconsulting.com>
 <20220722143858.GA1818206@bhelgaas>
 <Yt6Z3cBrVy1lVTp1@hovoldconsulting.com>
 <87czdtxnfn.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czdtxnfn.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 25, 2022 at 03:43:40PM +0100, Marc Zyngier wrote:
> On Mon, 25 Jul 2022 14:25:49 +0100,
> Johan Hovold <johan@kernel.org> wrote:
> > 
> > [ +CC: maz ]
> > 
> > On Fri, Jul 22, 2022 at 09:38:58AM -0500, Bjorn Helgaas wrote:
> > > On Fri, Jul 22, 2022 at 03:26:44PM +0200, Johan Hovold wrote:
> > > > On Thu, Jul 21, 2022 at 05:21:22PM -0500, Bjorn Helgaas wrote:
> > > 
> > > > > qcom is a DWC driver, so all the IRQ stuff happens in
> > > > > dw_pcie_host_init().  qcom_pcie_remove() does call
> > > > > dw_pcie_host_deinit(), which calls irq_domain_remove(), but nobody
> > > > > calls irq_dispose_mapping().
> > > > > 
> > > > > I'm thoroughly confused by all this.  But I suspect that maybe I
> > > > > should drop the "make qcom modular" patch because it seems susceptible
> > > > > to this problem:
> > > > > 
> > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ctrl/qcom&id=41b68c2d097e
> > > > 
> > > > That should not be necessary.
> > > > 
> > > > As you note above, interrupt handling is implemented in dwc core so if
> > > > there are any issue here at all, which I doubt, then all of the dwc
> > > > drivers that currently can be built as modules would all be broken and
> > > > this would need to be fixed in core.
> > > 
> > > I don't know yet whether there's an issue.  We need a clear argument
> > > for why there is or is not.  The fact that others might be broken is
> > > not an argument for breaking another one ;)
> > 
> > It's not breaking anything that is currently working, and if there's
> > some corner case during module unload, that's not the end of the world
> > either.
> 
> It may not be the end of the world for you, but you have absolutely no
> idea of what dangling pointers to kernel memory will do on a user
> machine, nor how this can be further exploited. Unloading a module
> should never result in an unsafe kernel.

Since when is unloading modules something that is expected to work
perfectly? I keep hearing "well, don't do that then" when someone
complains about unloading this module while doing this or that broke
something. (And it's only root that can unload modules in the first
place.)

If this was the general understanding, then it seems the only option
would be to disable module unloading completely as module remove code
almost by definition gets less testing and is subject to bit rot.

It's useful for developers, but use it at your own risk.

That said, I agree that if something is next to impossible to get right,
as may be the case with interrupt controllers generally, then fine,
let's disable module unloading for that class of drivers.

And this would mean disabling driver unbind for the 20+ driver PCI
drivers that currently implement it to some degree.

Also note that we only appear to have some 60 drivers in the tree that
can be built as modules but cannot be unloaded (if my grep patterns
were correct).

> > > > I've been using the modular pcie-qcom patch for months now, unloading
> > > > and reloading the driver repeatedly to test power sequencing, without
> > > > noticing any problems whatsoever.
> > > 
> > > Pali's commit log suggests that unloading the module is not, by
> > > itself, enough to trigger the problem:
> > > 
> > >   https://lore.kernel.org/linux-pci/20220709161858.15031-1-pali@kernel.org/
> > > 
> > > Can you test the scenario he mentions?
> > 
> > Turns out the pcie-qcom driver does not support legacy interrupts so
> > there's no risk of there being any lingering mappings if I understand
> > things correctly.
> 
> It still does MSIs, thanks to dw_pcie_host_init(). If you can remove
> the driver while devices are up and running with MSIs allocated,
> things may get ugly if things align the wrong way (if a driver still
> has a reference to an irq_desc or irq_data, for example).

That is precisely the way I've been testing it and everything appears
to be tore down as it should.

And a PCI driver that has been unbound should have released its
resources, or that's a driver bug. Right?

And for the OF INTx case you mentioned earlier, aren't those mapped by
PCI core and could in theory be released by core as well?

Johan
