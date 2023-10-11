Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4257C55CB
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 15:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjJKNqe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 09:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjJKNqd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 09:46:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B114B92;
        Wed, 11 Oct 2023 06:46:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115F4C433C7;
        Wed, 11 Oct 2023 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697031991;
        bh=7TPQv7Nq7BiCQCWrWeJZjtLq0BIDRCBxXyV8qe3CLuU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t2l+ViGLRCilD6w6vcRKjFTOxbUav8k077I/X7wqFKzvPpcA3cvPsgoCWNYZbigIs
         npvwgPSxPyAl2ycCusodrfO0KiiFNRpQiOOqWeEXKkbeoZ9iq0HWJoytI5Xvw1zc8M
         i2r/AewloDrcSGip/DSaC9JV9rzO7fgT4e94PSrLIrqHAdYmeFyXyiUe3xMvINCA9Z
         OIVzVXMWccyxSLHkDcEiuPKaxO6BJ6wEdatNMIKQk+w9QMWFvwywPPP8FXGNYkGgT6
         bZj1Sz46Agf5nKPERldj8Fw30VthHD9Lx+SF8ej3mwZtTblpV8PNq3zcDQdG3i/uBV
         /38MnoKPThPng==
Date:   Wed, 11 Oct 2023 08:46:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [PATCH] PCI: keystone: Don't enable BAR0 if link is not detected
Message-ID: <20231011134629.GA1029324@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011123451.34827-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Siddharth,

On Wed, Oct 11, 2023 at 06:04:51PM +0530, Siddharth Vadapalli wrote:
> Since the function dw_pcie_host_init() ignores the absence of link under
> the assumption that link can come up later, it is possible that the
> pci_host_probe(bridge) function is invoked even when no endpoint device
> is connected. In such a situation, the ks_pcie_v3_65_add_bus() function
> configures BAR0 when the link is not up, resulting in Completion Timeouts
> during the MSI configuration performed later by the PCI Express Port driver
> to setup AER, PME and other services. Thus, leave BAR0 disabled if link is
> not yet detected when the ks_pcie_v3_65_add_bus() function is invoked.

I'm trying to make sense of this.  In this path:

  pci_host_probe
    pci_scan_root_bus_bridge
      pci_register_host_bridge
	bus = pci_alloc_bus(NULL)    # root bus
	bus->ops->add_bus(bus)
	  ks_pcie_v3_65_add_bus

The BAR0 in question must belong to a Root Port.  And it sounds like
the issue must be related to MSI-X, since the original MSI doesn't
involve any BARs.

I don't understand why the Root Port's BAR0 is related to the link
being up.  MSI-X configuration of the Root Port (presumably using
BAR0) shouldn't involve any transactions to devices *below* the Root
Port, and I would expect that BAR to be available (readable and
writable) regardless of whether the link is up.

If we skip the BAR0 configuration because the link is down at the time
of pci_host_probe(), when *do* we do that configuration?  I don't see
another path to ks_pcie_v3_65_add_bus() for the root bus later.

Do you know what exactly causes the Completion Timeout?  Is this a
read to BAR0, or some attempted access to a downstream device, or
something else?

Keystone is the only driver that uses .add_bus() for this, so it seems
a little weird, but maybe this is related to some Keystone-specific
hardware design.

> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on linux-next tagged next-20231011.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 49aea6ce3e87..ac2ad112d616 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -459,7 +459,8 @@ static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
>  
> -	if (!pci_is_root_bus(bus))
> +	/* Don't enable BAR0 if link is not yet up at this point */
> +	if (!pci_is_root_bus(bus) || !dw_pcie_link_up(pci))
>  		return 0;
>  
>  	/* Configure and set up BAR0 */
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
