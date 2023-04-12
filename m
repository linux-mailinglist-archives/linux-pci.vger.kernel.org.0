Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0856DFAC2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 18:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjDLQDC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjDLQC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 12:02:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFFC6EBA;
        Wed, 12 Apr 2023 09:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78436636A7;
        Wed, 12 Apr 2023 16:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46B0C433EF;
        Wed, 12 Apr 2023 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681315374;
        bh=7bafig4Gjr1M4Mmce2Kn1RXfVldb+pDVH9bGirK31r0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ti1om2CyCAsGI37IcrPsSns/MS8hFtpaqrApyQUe3iwut1p58dnAPboxOf5fPh4YN
         M2Ud3Ah4xyLEnaB1B9364/5vhsggedosXfT0EsWTaBMzVszfY2t9Wry/S2PXIvTxlH
         uhJklkXY4aEj7Dh11PPATKxySKkfv15q3nr13OnR5Yf6zyfC3A7arRpD9xz6gSns0r
         ApREjKKS+tRWDXtHI9YdVgNeW1UytA2oI5o16VhUtl3mBeozIc36sMPU9YxjgAStqR
         zCt+qlnO9ZxGovsXUc90oaAFXylzQFCEsGB5JHRyORIXJL4RwrltEdc+DlZEMv9ke7
         KFTN4eSKlPkaw==
Date:   Wed, 12 Apr 2023 11:02:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] PCI: of: Propagate firmware node
Message-ID: <20230412160253.GA41376@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412131520.52840-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 04:15:20PM +0300, Andy Shevchenko wrote:
> Propagate firmware node by using a specific API call, i.e. device_set_node().

Can you add a line or two about *why* we should do this, e.g., is this
headed toward some goal?  Is it a simplification that's 100%
equivalent (doesn't seem so, see below)?

Seems like there's an underlying long-term effort to unify things from
OF and ACPI, which seems like a good thing, but at the moment it's a
little confusing to follow.  For instance pci_set_of_node() seems like
it ought to be sort of analogous to pci_set_acpi_fwnode(), but they
look nothing alike.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/of.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 196834ed44fe..4bba00dfbfc5 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -18,19 +18,18 @@
>  #ifdef CONFIG_PCI
>  void pci_set_of_node(struct pci_dev *dev)
>  {
> +	struct device_node *node;
> +
>  	if (!dev->bus->dev.of_node)
>  		return;
> -	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
> -						    dev->devfn);
> -	if (dev->dev.of_node)
> -		dev->dev.fwnode = &dev->dev.of_node->fwnode;
> +	node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
> +	device_set_node(&dev->dev, of_fwnode_handle(node));

This doesn't seem 100% equivalent.  If of_pci_find_child_device()
returns NULL, the previous code doesn't set dev->dev.fwnode, but the
new code does.

>  }
>  
>  void pci_release_of_node(struct pci_dev *dev)
>  {
>  	of_node_put(dev->dev.of_node);
> -	dev->dev.of_node = NULL;
> -	dev->dev.fwnode = NULL;
> +	device_set_node(&dev->dev, NULL);
>  }
>  
>  void pci_set_bus_of_node(struct pci_bus *bus)
> @@ -45,17 +44,13 @@ void pci_set_bus_of_node(struct pci_bus *bus)
>  			bus->self->external_facing = true;
>  	}
>  
> -	bus->dev.of_node = node;
> -
> -	if (bus->dev.of_node)
> -		bus->dev.fwnode = &bus->dev.of_node->fwnode;
> +	device_set_node(&bus->dev, of_fwnode_handle(node));
>  }
>  
>  void pci_release_bus_of_node(struct pci_bus *bus)
>  {
>  	of_node_put(bus->dev.of_node);
> -	bus->dev.of_node = NULL;
> -	bus->dev.fwnode = NULL;
> +	device_set_node(&bus->dev, NULL);
>  }
>  
>  struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
> -- 
> 2.40.0.1.gaa8946217a0b
> 
