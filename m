Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1A3792E0D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 20:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbjIES71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 14:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjIES71 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 14:59:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11246E9;
        Tue,  5 Sep 2023 11:59:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30914B81109;
        Tue,  5 Sep 2023 16:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A1BC433C8;
        Tue,  5 Sep 2023 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693931835;
        bh=w+oEgQVQbOnu49ifCvEgRbOLpeyCI0kFGG7aALURPuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SZiKoDobJ73xtwVhTW8bCkYjbuMn9ns3UIbfSBhdrJqwrdxa51jFyXM0GxrDFaLiN
         EfeDZrPGNkI8R2Nur6TKMtjCEftwLRB52jqbd/QaqyXgbdn737rQTKH4WoR32O7Yzv
         xAV9RlpI4O9PUDK9mXC2DHekQQmUVgwbp9ED/RqlKr/kqrj93fwuLhDmVoCnncpX5O
         rYL9ZElWgKxwTlORHQX3m6FPd4JqOWtnhNQVwVkxwm3weGED6PbbIILADm1OJgYYpr
         2sBtUblLNWbYdn0Tkkn7L4W34dIZkzx2PkYNvZBtz5iOyvUAK6X/gP7aEVd1cC7DYe
         tFmtkddPtPu0Q==
Date:   Tue, 5 Sep 2023 11:37:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Verma, Achal" <a-verma1@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [EXTERNAL] Re: [RFC PATCH 2/2] PCI: j721e: Add support to build
 pci-j721e as a kernel module
Message-ID: <20230905163713.GA175472@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9164d7-e2a2-1a63-3574-a305d8f8d3fc@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 05, 2023 at 04:09:34PM +0530, Verma, Achal wrote:
> On 8/17/2023 10:34 PM, Bjorn Helgaas wrote:
> > On Thu, Aug 17, 2023 at 05:38:23PM +0530, Achal Verma wrote:
> > > pci-j721e driver can be build as a in-built kernel driver only, which is
> > > not required as it is not used during boot time in most cases.
> > > This change add support to build pci-j721e as a kernel loadable module.
> > > 
> > > J721e PCIe controller can work in both host mode and end-point mode.
> > > In order to enable host mode driver and endpoint driver to be built
> > > independently either as built-in or kernel module, the pcie-j721e.c driver
> > > is refactored into following components:
> > > 
> > > 1) pci-j721e-host.c: Driver used when PCIe controller has to be
> > > initialized in host mode.
> > > 
> > > 2) pci-j721e-ep.c: Driver used when PCIe controller has to be
> > > initialized in endpoint mode.
> > > 
> > > 3) pci-j721e.c: contains common code required in both modes.
> > 
> > Sounds like at least two commits (I'm not sure what the best order
> > would be):
> > 
> >    1) Split into separate host mode and endpoint mode drivers
> > 
> >    2) Make both drivers tristate
> 
> So one patch for .c files and Makefile and other one for Kconfig.

Well, not exactly.  I think there are some .c file changes related to
making the drivers tristate, e.g., adding .remove(), etc.  Those
specific changes and the Kconfig change from bool to tristate should
be in the same patch.

The split into two drivers should be basically a code rearrangement
that doesn't add any new functionality.  That should be in a separate
patch by itself.

> > It looks like you implement both module loading and removal.  Do we
> > now think removal of these modules is safe?  IIRC there used to be a
> > question related to irq_desc lifetimes, e.g., there's some discussion
> > here: https://lore.kernel.org/linux-pci/87k085xekg.wl-maz@kernel.org/
> > 
> > The ability to *load* drivers as modules is definitely useful.  The
> > ability to *remove* them is useful for developers but not really
> > useful for users.
> > 
> > But I guess j721e_pcie_remove() already exists, so maybe you're not
> > changing anything as far as irq_desc lifetimes
>
> I went through the email-thread you have shared.
> It looks like its related to the issue when pcie bridge driver also working
> as a interrupt domain/controller for EP.
> In case of legacy interrupt support, its required that pcie host driver free
> interrupt mapping before freeing the interrupt domain.
> 
> Note that current upstream implementation of pci-j721e doesn't support
> interrupt domain, so issue doesn't applies here but its there in TI kernel
> and I believe we are handling this in proper way by freeing the mappings
> before.
> 
> Also pci-j721e remove() was lacking some important clean-up functions
> including pci_remove_root_bus() without which remove wasn't possible, so
> added required calls and checked the correct sequence of calls.

These changes should be separate from the patch that splits into
host/endpoint drivers.

> I have tested load/un-load multiple times on J784S4 EVM PCIe1 instance, it
> worked fine but reload after load->un-load in case of j721e fails leading to
> kernel hung, I suspect this as something to do with improper (sequence)
> handling of refclk for endpoint (shutting down and then powering up) as the
> only difference between these is that for J784S4 both host controller and EP
> side use shared ref-clk generated by pcie phy while in j721e case host
> controller use pcie-phy clock while EP side uses board generated ref-clock,
> so something to do with power and clock off/on sequence.

We should not make module unload possible until reload is reliable.
But in the meantime, we can certainly make it possible to build the
drivers as modules and load them at runtime.

Bjorn
