Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175ED6E827E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 22:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDSUUr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDSUUq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 16:20:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7413558E;
        Wed, 19 Apr 2023 13:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84B8F639DA;
        Wed, 19 Apr 2023 20:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABFAC433D2;
        Wed, 19 Apr 2023 20:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681935644;
        bh=yXhqdjRuvB4MB1gbj846qH8olAdMjNumzM2kBEOaLXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RlvdEgJc6QTxAZm/m2XbHBQY7a3og4fKONfQIfvUd4Sup2cgK6Y88Ja2vDawDsqUy
         EWIOT2PDx3fdGalr2SUcH52j4cQzKs/ZHP952TIzqZpEf8NJd/aeLAhjF8ysLUjWBB
         oH9Zim3LBiH/3AGrq6s5EKNGSGUVwdgUV0EgCWXOQFFh6nGpmfFEr+DwIuAJkk3FIc
         79I4fqI0FaYUpghRD3AtVZhO5xlndfXN+vAM3xGnj3fx7gdcd1fwAsRM/6k8iVwfkL
         hpx21cH/lh2GVC7VvWrGq6P5SutS2DNnwGroORuuXyxZ/ghBXmWhWitkviOyVQ/RcC
         5gHG98IH3xrMQ==
Date:   Wed, 19 Apr 2023 15:20:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Donald Hunter <donald.hunter@gmail.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH] PCI: Restrict device disabled status check to DT
Message-ID: <20230419202042.GA223738@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419193513.708818-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Vitaly, Jesse, Tony, Andy, regressions, regarding reports of
hang or crash during boot in igb driver, some with AWS Xen]

On Wed, Apr 19, 2023 at 02:35:13PM -0500, Rob Herring wrote:
> Commit 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
> checked the firmware device status for both DT and ACPI devices. That
> caused a regression in some ACPI systems. The exact reason isn't clear.
> It's possibly a firmware bug. For now, at least, refactor the check to
> be for DT based systems only.
> 
> Note that the original implementation leaked a refcount which is now
> correctly handled.
> 
> Fixes: 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
> Link: https://lore.kernel.org/all/m2fs9lgndw.fsf@gmail.com/
> Reported-by: Donald Hunter <donald.hunter@gmail.com>
> Cc: Binbin Zhou <zhoubinbin@loongson.cn>
> Cc: Liu Peibao <liupeibao@loongson.cn>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-linus for (hopefully) v6.3.  I added:

  [bhelgaas: Per ACPI r6.5, sec 6.3.7, for devices on an enumerable
  bus, _STA must return with bit[0] ("device is present") set]

  Link: https://bugzilla.kernel.org/show_bug.cgi?id=217317

It would be really great if anybody who has seen this issue could test
and report whether this patch solves it.

> ---
>  drivers/pci/of.c    | 30 ++++++++++++++++++++++++------
>  drivers/pci/pci.h   |  4 ++--
>  drivers/pci/probe.c |  8 ++++----
>  3 files changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 196834ed44fe..4c2ef2e28fb5 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -16,14 +16,32 @@
>  #include "pci.h"
>  
>  #ifdef CONFIG_PCI
> -void pci_set_of_node(struct pci_dev *dev)
> +/**
> + * pci_set_of_node - Find and set device's DT device_node
> + * @dev: the PCI device structure to fill
> + *
> + * Returns 0 on success with of_node set or when no device is described in the
> + * DT. Returns -ENODEV if the device is present, but disabled in the DT.
> + */
> +int pci_set_of_node(struct pci_dev *dev)
>  {
> +	struct device_node *node;
> +
>  	if (!dev->bus->dev.of_node)
> -		return;
> -	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
> -						    dev->devfn);
> -	if (dev->dev.of_node)
> -		dev->dev.fwnode = &dev->dev.of_node->fwnode;
> +		return 0;
> +
> +	node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
> +	if (!node)
> +		return 0;
> +
> +	if (!of_device_is_available(node)) {
> +		of_node_put(node);
> +		return -ENODEV;
> +	}
> +
> +	dev->dev.of_node = node;
> +	dev->dev.fwnode = &node->fwnode;
> +	return 0;
>  }
>  
>  void pci_release_of_node(struct pci_dev *dev)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index d2c08670a20e..2b48a0aa8008 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -624,7 +624,7 @@ int of_pci_get_max_link_speed(struct device_node *node);
>  u32 of_pci_get_slot_power_limit(struct device_node *node,
>  				u8 *slot_power_limit_value,
>  				u8 *slot_power_limit_scale);
> -void pci_set_of_node(struct pci_dev *dev);
> +int pci_set_of_node(struct pci_dev *dev);
>  void pci_release_of_node(struct pci_dev *dev);
>  void pci_set_bus_of_node(struct pci_bus *bus);
>  void pci_release_bus_of_node(struct pci_bus *bus);
> @@ -662,7 +662,7 @@ of_pci_get_slot_power_limit(struct device_node *node,
>  	return 0;
>  }
>  
> -static inline void pci_set_of_node(struct pci_dev *dev) { }
> +static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
>  static inline void pci_release_of_node(struct pci_dev *dev) { }
>  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
>  static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a3f68b6ba6ac..f96fa83f2627 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1826,7 +1826,7 @@ int pci_setup_device(struct pci_dev *dev)
>  	u32 class;
>  	u16 cmd;
>  	u8 hdr_type;
> -	int pos = 0;
> +	int err, pos = 0;
>  	struct pci_bus_region region;
>  	struct resource *res;
>  
> @@ -1840,10 +1840,10 @@ int pci_setup_device(struct pci_dev *dev)
>  	dev->error_state = pci_channel_io_normal;
>  	set_pcie_port_type(dev);
>  
> -	pci_set_of_node(dev);
> +	err = pci_set_of_node(dev);
> +	if (err)
> +		return err;
>  	pci_set_acpi_fwnode(dev);
> -	if (dev->dev.fwnode && !fwnode_device_is_available(dev->dev.fwnode))
> -		return -ENODEV;
>  
>  	pci_dev_assign_slot(dev);
>  
> -- 
> 2.39.2
> 
