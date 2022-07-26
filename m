Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C8658106C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 11:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiGZJ4w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 05:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiGZJ4v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 05:56:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90BE1A3AA;
        Tue, 26 Jul 2022 02:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65F19B811C9;
        Tue, 26 Jul 2022 09:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BF3C341C0;
        Tue, 26 Jul 2022 09:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658829408;
        bh=Mc8eFBIjYIwEhEUBjx7ssWeK9viPjrwFrzaAxDIwyJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZiD48wEsVG0yTLimL1POFy0Qvdvf92mMEh/WlvjU8/bsR78nlgDFcw46e9V78Qnc
         RI2VKPcCKvTLgopY6WmxwY63oBblN6DrX3AYvXwgXlDPSnPO8P+NN5rUww/7qynnBd
         nDaGBfxo/iVGtYxQOmNJgsZH5OBi03+2lx4nULGtzflmfML1k+bmPg6ob1a2FO6jbC
         p5TF7AHF9Jcm8Oo9SZ/q2BoeXqPdS+iAIsYYHjMhz6csDZSILQMWr/sEQdE3Gt0wxY
         9jCg5zKBDLsLSeUj0HwkhYrLi7Vttb69adaoiqKdsvpYN1RWpfe5w1+oGJ86VoJh49
         s3VYcKytgXFiw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oGHJD-0007iu-2V; Tue, 26 Jul 2022 11:56:59 +0200
Date:   Tue, 26 Jul 2022 11:56:59 +0200
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
Message-ID: <Yt+6azfwd/LuMzoG@hovoldconsulting.com>
References: <YtqllIHY/R/BbR3V@hovoldconsulting.com>
 <20220722143858.GA1818206@bhelgaas>
 <Yt6Z3cBrVy1lVTp1@hovoldconsulting.com>
 <87czdtxnfn.wl-maz@kernel.org>
 <Yt60WNVNEVHgzSuN@hovoldconsulting.com>
 <87zggxaye8.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zggxaye8.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 25, 2022 at 06:35:27PM +0100, Marc Zyngier wrote:
> On Mon, 25 Jul 2022 16:18:48 +0100,
> Johan Hovold <johan@kernel.org> wrote:

> > Since when is unloading modules something that is expected to work
> > perfectly? I keep hearing "well, don't do that then" when someone
> > complains about unloading this module while doing this or that broke
> > something. (And it's only root that can unload modules in the first
> > place.)
> 
> Well, maybe I have higher standards. For the stuff I maintain, I now
> point-blank refuse to support module unloading if this can result in a
> crash. Or worse.

That makes sense for regular interrupt controllers where its hard to
tell that all consumers are gone, but I don't think that should limit
the usefulness of having modular PCI controller drivers where we know
that the consumers are gone after deregistering the bus (i.e. the
consumers are descendants of the controller in the device tree).
 
> > If this was the general understanding, then it seems the only option
> > would be to disable module unloading completely as module remove code
> > almost by definition gets less testing and is subject to bit rot.
> 
> My personal preference would be to prevent module unloading by default
> if the probing has succeeded, and have modules to actually buy into
> unloading. But that ship has sailed a long time ago.

We obviously agree that modular driver are important (e.g. for
multi-platform kernels), but being able to unload a module is also a
useful debugging and development tool. I've fixed several driver bugs in
paths that are rarely tested (or hard to test) by unloading the
pcie-qcom driver.

This old quote from Linus seems to agree with my position on this:

	The proper thing to do (and what we _have_ done) is to say
	"unloading of modules is not supported". It's a debugging
	feature, and you literally shouldn't do it unless you are
	actively developing that module.

	https://lore.kernel.org/all/Pine.LNX.4.58.0401251054340.18932@home.osdl.org/

But of course we should fix any issues we find, such as the missing
unmapping of legacy interrupts pointed out by Pali earlier in this
thread.

> > It's useful for developers, but use it at your own risk.
> > 
> > That said, I agree that if something is next to impossible to get right,
> > as may be the case with interrupt controllers generally, then fine,
> > let's disable module unloading for that class of drivers.
> > 
> > And this would mean disabling driver unbind for the 20+ driver PCI
> > drivers that currently implement it to some degree.
> 
> That would be Bjorn's and Lorenzo's call.

Sure, but I think it would be the wrong decision here. Especially, since
the end result will likely just be that more drivers will become always
compiled-in.

> > Also note that we only appear to have some 60 drivers in the tree that
> > can be built as modules but cannot be unloaded (if my grep patterns
> > were correct).
> 
> I'm not surprised. Preventing module unload requires extra "code", and
> hardly anyone cares.

And it's primarily a debugging feature.

> > > > Turns out the pcie-qcom driver does not support legacy interrupts so
> > > > there's no risk of there being any lingering mappings if I understand
> > > > things correctly.
> > > 
> > > It still does MSIs, thanks to dw_pcie_host_init(). If you can remove
> > > the driver while devices are up and running with MSIs allocated,
> > > things may get ugly if things align the wrong way (if a driver still
> > > has a reference to an irq_desc or irq_data, for example).
> > 
> > That is precisely the way I've been testing it and everything appears
> > to be tore down as it should.
> >
> > And a PCI driver that has been unbound should have released its
> > resources, or that's a driver bug. Right?
> 
> But that's the thing: you can easily remove part of the infrastructure
> without the endpoint driver even noticing. It may not happen in your
> particular case if removing the RC driver will also nuke the endpoints
> in the process, but I can't see this is an absolute guarantee. The
> crash pointed to by an earlier email is symptomatic of it.

But that was arguably due to a driver bug, which we know how to fix. For
MSIs the endpoint driver will free its interrupts and all is good.

The key observation is that the driver model will make sure that any
endpoint drivers have been unbound before the bus is deregistered.

That means there are no longer any consumers of the interrupts, which
can be disposed. For MSI this is handled by pci_free_irq_vectors() when
unbinding the endpoint drivers. For legacy interrupts, which can be
shared, the PCIe RC driver needs to manage this itself after the
consumers are gone.

> > And for the OF INTx case you mentioned earlier, aren't those mapped by
> > PCI core and could in theory be released by core as well?
> 
> Potentially, though I haven't tried to follow the life cycle of those.
> The whole thing is pretty fragile, and this sort of resource is rarely
> expected to be removed...

The OF mapping is typically done by PCI core when binding the endpoint
driver, but as the interrupts can be shared, they cannot be disposed at
unbind.

Instead the host-bridge driver needs to dispose the mappings after
deregistering the bus and before removing the domain, as in Pali's
fixes:

	https://lore.kernel.org/linux-pci/20220709161858.15031-1-pali@kernel.org/

at which point the consumers are gone.

Johan
