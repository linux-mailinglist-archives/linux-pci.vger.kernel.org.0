Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8D9583E73
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 14:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbiG1MQv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 08:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbiG1MQu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 08:16:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6214752DFB;
        Thu, 28 Jul 2022 05:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0201761C3C;
        Thu, 28 Jul 2022 12:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FEEC433C1;
        Thu, 28 Jul 2022 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659010608;
        bh=LFZJFSQspiVXFSZZuiOSuX8EkyVURrciQuZijn6iuYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYRAjGPcx4Pk+v7gA5d4Y6TZiNhDSm7UAjnIIjANFVLL8CYcpVXuUoogC7+zNaKPJ
         kWW7IV/58w9goM69D3Tkl45VhrvTInyyVh1QwLsYCpxV9cMJf4UCLOUY0Ztqolg/iq
         YMMMTRLyixkiRn3X3BWEDTxsGRIsCGhvs8TpVU7kAYWK569AZgOBT5zAAs5xPT/Ps8
         InUShCMMs2GtlAmYmb4tb6Zhj3NC0NFTGEP9h5V8QJ2D/GcafM7BbjUApVTZNZ11yo
         6w6yFxQ1A7z981s9Or8o+q1DZ0mDboZSxX/1Vf7iTvLbs6m1vYfhEmZL6wY2PFbQt6
         FDG7BBdnD4FFg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oH2Rp-0008HG-QL; Thu, 28 Jul 2022 14:17:01 +0200
Date:   Thu, 28 Jul 2022 14:17:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
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
Message-ID: <YuJ+PZIhg8mDrdlX@hovoldconsulting.com>
References: <Yt+6azfwd/LuMzoG@hovoldconsulting.com>
 <20220727195716.GA220011@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727195716.GA220011@bhelgaas>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 27, 2022 at 02:57:16PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 26, 2022 at 11:56:59AM +0200, Johan Hovold wrote:
> > On Mon, Jul 25, 2022 at 06:35:27PM +0100, Marc Zyngier wrote:
> > > On Mon, 25 Jul 2022 16:18:48 +0100,
> > > Johan Hovold <johan@kernel.org> wrote:
> > 
> > > > Since when is unloading modules something that is expected to
> > > > work perfectly? I keep hearing "well, don't do that then" when
> > > > someone complains about unloading this module while doing this
> > > > or that broke something. (And it's only root that can unload
> > > > modules in the first place.)
> > > 
> > > Well, maybe I have higher standards. For the stuff I maintain, I
> > > now point-blank refuse to support module unloading if this can
> > > result in a crash. Or worse.
> > 
> > That makes sense for regular interrupt controllers where its hard to
> > tell that all consumers are gone, but I don't think that should
> > limit the usefulness of having modular PCI controller drivers where
> > we know that the consumers are gone after deregistering the bus
> > (i.e. the consumers are descendants of the controller in the device
> > tree).
> 
> Those consumers are endpoint drivers, so I think this depends on those
> drivers correctly unmapping the interrupts they use, right?

Right. For MSI this means that pci_alloc_irq_vectors() in probe should
be matched by pci_free_irq_vectors() on remove.

For legacy interrupts, which can be shared, the mapping is created by
PCI core when binding to the first device and can only be disposed by
the host-bridge driver once all descendants have been removed.

The endpoint drivers still need to disable their interrupts of course.

Buggy endpoint-driver remove implementations can lead to all sorts of
crashes (e.g. after failing to deregister a class device), and if that's
a worry then don't unload modules (and possibly disable it completely
using CONFIG_MODULE_UNLOAD).

> > > > It's useful for developers, but use it at your own risk.
> > > > 
> > > > That said, I agree that if something is next to impossible to
> > > > get right, as may be the case with interrupt controllers
> > > > generally, then fine, let's disable module unloading for that
> > > > class of drivers.
> > > > 
> > > > And this would mean disabling driver unbind for the 20+ driver
> > > > PCI drivers that currently implement it to some degree.
> > > 
> > > That would be Bjorn's and Lorenzo's call.
> > 
> > Sure, but I think it would be the wrong decision here. Especially,
> > since the end result will likely just be that more drivers will
> > become always compiled-in.
> 
> Can you elaborate on this?  I think Marc is suggesting that these PCI
> controller drivers be modular but not removable.  Why would that cause
> more of them to be compiled-in?

As mentioned earlier in this thread, we only appear to have some 60
drivers in the entire tree that bother to try to implement that. I fear
that blocking the use of modules (including being able to unload them)
will just make people submit drivers that can only be built in.

Not everyone cares about Android's GKI, but being able to unload a
module during development is very useful (and keeping that out-of-tree
prevents sharing the implementation and make it susceptible to even
further bit rot).

So continuing to supporting modules properly is a win for everyone (e.g.
GKI and developers).
 
> > > > > > Turns out the pcie-qcom driver does not support legacy
> > > > > > interrupts so there's no risk of there being any lingering
> > > > > > mappings if I understand things correctly.
> > > > > 
> > > > > It still does MSIs, thanks to dw_pcie_host_init(). If you can
> > > > > remove the driver while devices are up and running with MSIs
> > > > > allocated, things may get ugly if things align the wrong way
> > > > > (if a driver still has a reference to an irq_desc or irq_data,
> > > > > for example).
> > > > 
> > > > That is precisely the way I've been testing it and everything
> > > > appears to be tore down as it should.
> > > >
> > > > And a PCI driver that has been unbound should have released its
> > > > resources, or that's a driver bug. Right?
> > > 
> > > But that's the thing: you can easily remove part of the
> > > infrastructure without the endpoint driver even noticing. It may
> > > not happen in your particular case if removing the RC driver will
> > > also nuke the endpoints in the process, but I can't see this is an
> > > absolute guarantee. The crash pointed to by an earlier email is
> > > symptomatic of it.
> > 
> > But that was arguably due to a driver bug, which we know how to fix.
> > For MSIs the endpoint driver will free its interrupts and all is
> > good.
> > 
> > The key observation is that the driver model will make sure that any
> > endpoint drivers have been unbound before the bus is deregistered.
> > 
> > That means there are no longer any consumers of the interrupts,
> > which can be disposed. For MSI this is handled by
> > pci_free_irq_vectors() when unbinding the endpoint drivers. For
> > legacy interrupts, which can be shared, the PCIe RC driver needs to
> > manage this itself after the consumers are gone.
> 
> The driver model ensures that endpoint drivers have been unbound. But
> doesn't the interrupt disposal depend on the correct functioning of
> those endpoint drivers?  So if a buggy endpoint driver failed to
> dispose of them, we're still vulnerable?

Just as you are if an endpoint-driver fails to clean up after itself in
some other way (e.g. leaves the interrupt enabled).

Johan
