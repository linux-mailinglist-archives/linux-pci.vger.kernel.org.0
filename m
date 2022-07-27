Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5FE5833DA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 21:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiG0T5Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 15:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiG0T5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 15:57:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5252158B47;
        Wed, 27 Jul 2022 12:57:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E82F2B82279;
        Wed, 27 Jul 2022 19:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58074C433D6;
        Wed, 27 Jul 2022 19:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658951838;
        bh=7QZYmwrZG8Sh+D/oho3aNQtPpOKtF7UQO1cgldixeeM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ttzeWYdIb1nRjk/211e/C9p3EW2o66CuWJWHiSEXQN2nuTmFo91k/lUqNaY2YeMKj
         5smWl38FbyzKv+eaoBDXl0azZ3lMoznTCdeCNFaJL6hvi/k82aZ34qb2gt4SVsGbmO
         6kDjiD/pcBQ5KrChlE+0oRrlXL0fdcFkMJ09eP5+f4eXBxWOLHaYCyKs3gl9jsg28k
         aAiGAyG7Ffaft6uPWbE33lxGpj3seSIZCdXSlSVhHfO5xLUuuUv/fzGrcBz1u+w7m9
         K1IQwBpuJo9LEXr9GRivOYTxSJdtM2UlUoLuI4Wds2phLrvHUaz2coHyisCQ5FbFoA
         jCFtHB13pyb9Q==
Date:   Wed, 27 Jul 2022 14:57:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
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
Message-ID: <20220727195716.GA220011@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt+6azfwd/LuMzoG@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 26, 2022 at 11:56:59AM +0200, Johan Hovold wrote:
> On Mon, Jul 25, 2022 at 06:35:27PM +0100, Marc Zyngier wrote:
> > On Mon, 25 Jul 2022 16:18:48 +0100,
> > Johan Hovold <johan@kernel.org> wrote:
> 
> > > Since when is unloading modules something that is expected to
> > > work perfectly? I keep hearing "well, don't do that then" when
> > > someone complains about unloading this module while doing this
> > > or that broke something. (And it's only root that can unload
> > > modules in the first place.)
> > 
> > Well, maybe I have higher standards. For the stuff I maintain, I
> > now point-blank refuse to support module unloading if this can
> > result in a crash. Or worse.
> 
> That makes sense for regular interrupt controllers where its hard to
> tell that all consumers are gone, but I don't think that should
> limit the usefulness of having modular PCI controller drivers where
> we know that the consumers are gone after deregistering the bus
> (i.e. the consumers are descendants of the controller in the device
> tree).

Those consumers are endpoint drivers, so I think this depends on those
drivers correctly unmapping the interrupts they use, right?

> > > It's useful for developers, but use it at your own risk.
> > > 
> > > That said, I agree that if something is next to impossible to
> > > get right, as may be the case with interrupt controllers
> > > generally, then fine, let's disable module unloading for that
> > > class of drivers.
> > > 
> > > And this would mean disabling driver unbind for the 20+ driver
> > > PCI drivers that currently implement it to some degree.
> > 
> > That would be Bjorn's and Lorenzo's call.
> 
> Sure, but I think it would be the wrong decision here. Especially,
> since the end result will likely just be that more drivers will
> become always compiled-in.

Can you elaborate on this?  I think Marc is suggesting that these PCI
controller drivers be modular but not removable.  Why would that cause
more of them to be compiled-in?

> > > > > Turns out the pcie-qcom driver does not support legacy
> > > > > interrupts so there's no risk of there being any lingering
> > > > > mappings if I understand things correctly.
> > > > 
> > > > It still does MSIs, thanks to dw_pcie_host_init(). If you can
> > > > remove the driver while devices are up and running with MSIs
> > > > allocated, things may get ugly if things align the wrong way
> > > > (if a driver still has a reference to an irq_desc or irq_data,
> > > > for example).
> > > 
> > > That is precisely the way I've been testing it and everything
> > > appears to be tore down as it should.
> > >
> > > And a PCI driver that has been unbound should have released its
> > > resources, or that's a driver bug. Right?
> > 
> > But that's the thing: you can easily remove part of the
> > infrastructure without the endpoint driver even noticing. It may
> > not happen in your particular case if removing the RC driver will
> > also nuke the endpoints in the process, but I can't see this is an
> > absolute guarantee. The crash pointed to by an earlier email is
> > symptomatic of it.
> 
> But that was arguably due to a driver bug, which we know how to fix.
> For MSIs the endpoint driver will free its interrupts and all is
> good.
> 
> The key observation is that the driver model will make sure that any
> endpoint drivers have been unbound before the bus is deregistered.
> 
> That means there are no longer any consumers of the interrupts,
> which can be disposed. For MSI this is handled by
> pci_free_irq_vectors() when unbinding the endpoint drivers. For
> legacy interrupts, which can be shared, the PCIe RC driver needs to
> manage this itself after the consumers are gone.

The driver model ensures that endpoint drivers have been unbound. But
doesn't the interrupt disposal depend on the correct functioning of
those endpoint drivers?  So if a buggy endpoint driver failed to
dispose of them, we're still vulnerable?

Bjorn
