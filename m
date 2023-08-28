Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D8D78B9FD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 23:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjH1VLe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 17:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjH1VL1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 17:11:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81B6C3;
        Mon, 28 Aug 2023 14:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53F06631D9;
        Mon, 28 Aug 2023 21:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACDFC433C7;
        Mon, 28 Aug 2023 21:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693257083;
        bh=CuIPNQ07mUdRKNEEdCDCs1DaOYgbGMZeHU/QMDCau2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SNbYvyr/S6MofsbcLWGC/v8Q/z6fsngz+tQFU6IQ4pDrWQTsO3aJasZ5yND6SX0/P
         upbhNWzYyc00nO6x7oWjOcINTy9R4eZCpgbz4FHdizLdHvzYZiPWnyELPbicb4ymZY
         2YGkfPfn9VQr0V+hCKcCktaQiI5MSAocDZVbDEMG19hk3bmCeFUzXzEFxTpNCiDPEF
         sXXQms3QoUSvWqJd11MTNu6IFGPBe1tm2dQIfTjr3CQmwbrFIWRUWLTiAdIPDoZA6n
         6N6QzWzZdMP/rdhTHgn1eTxRzOQxu5iy1uA6pIvGSDQuKnUyLg4cKDznAQYEvmMdwk
         gCS4z/cVezlUQ==
Date:   Mon, 28 Aug 2023 16:11:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: Re: [PATCH v6 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Message-ID: <20230828211121.GA745436@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB7201459AEFB6DFF600E753928BE0A@SN7PR12MB7201.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 28, 2023 at 12:01:52PM +0000, Havalige, Thippeswamy wrote:
> > > On Fri, Aug 18, 2023 at 03:05:07PM +0530, Thippeswamy Havalige wrote:
> > > > ...

> > > > +static bool xilinx_pl_dma_pcie_valid_device(struct pci_bus *bus,
> > > > +					    unsigned int devfn)
> > > > +{
> > > > +	struct pl_dma_pcie *port = bus->sysdata;
> > > > +
> > > > +	/* Check if link is up when trying to access downstream ports */
> > > > +	if (!pci_is_root_bus(bus)) {
> > > > +		/*
> > > > +		 * Checking whether link is up here is a last line of defence,
> > > > +		 * if the link goes down after we check for link-up, we have a
> > > > +		 * problem: if a PIO request is initiated while link-down, the
> > > > +		 * whole controller hangs, and even after link comes up again,
> > > > +		 * previous PIO requests won't work, and a reset of the whole
> > > > +		 * PCIe controller is needed. Henceforth we need link-up
> > > check
> > > > +		 * here to avoid sending PIO request when link is down. This
> > > > +		 * check is racy by definition and does not make controller
> > > hang
> > > > +		 * if the link goes down after this check is performed.
> > >
> > > This comment doesn't make sense to me.  "If PIO request initiated
> > > while link- down, controller hangs ... This check is racy and does not
> > > make controller hang if link goes down."  Which is it?
> - Here checking link up treats device as invalid.
> 
> Please find comment that I ll update in next patch and 
> Please letme know if any changes are needed.
> 
>   /*
>                  * Checking whether the link is up. Here is the last line of
>                  * defence. If the link goes down after we check for link-up,
>                  * we have a problem. If a PIO request is initiated while link
>                  * is down, the whole controller hangs. Even after link comes up
>                  * again, previous PIO requests won't work, and a reset of the
>                  * whole PCIe controller is needed. Henceforth we need link-up
>                  * check here to treat device as invalid and avoid sending PIO
>                  * request when link is down and this check is inherently racy
>                  * by definition.
> */
> > >
> > > My *guess* is that this check narrows the window but doesn't close it,
> > > so if
> > > xilinx_pl_dma_pcie_link_up() finds the link up, but the link goes down
> > > before
> > > pci_generic_config_read() initiates the PIO request, the controller
> > > hangs, and a reset is required.

Sorry, I dragged this out by not giving you a more useful suggestion
to begin with.  Since advk_pcie_valid_device() has the same issue,
copying its comment was a great place to start.

But I think advk_pcie_valid_device(), altera_pcie_valid_device(),
nwl_pcie_valid_device(), xilinx_pcie_valid_device(), and now
xilinx_pl_dma_pcie_valid_device() all have the same race, but none of
them really address it in the comment.

I'm looking for explicit acknowledgement that we can't reliably
prevent this unrecoverable error, e.g., something like this:

  Sending a PIO request to a downstream device when the link is down
  causes an unrecoverable error, and a reset of the entire PCIe
  controller will be needed.  We can reduce the likelihood of that
  unrecoverable error by checking whether the link is up, but can't
  completely prevent it because the link may go down between the
  link-up check and the PIO request.

Bjorn
