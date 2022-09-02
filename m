Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445575AB89B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 20:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiIBSyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 14:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiIBSyP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 14:54:15 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBCAE2C47;
        Fri,  2 Sep 2022 11:54:06 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so2027882otq.11;
        Fri, 02 Sep 2022 11:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BMjZ9FHCyvEzC1mkDo5TqP/8GFMILshSdPN6isAXJn4=;
        b=DQg+odSjl6n2/CraWNd4rh+M4JOqxAJ+2YEFxGWNa7USuGqf+m1qgBHxTKmapo9jom
         9vYQuYfFV28pOUX9MCJE3TnpGWVR0l9A3rBBH+KNAodpVYEFeHi87xO4TbtzGx1Nw7M8
         fwEOFix2lOmNGrZeLR6fBKPOy0Aljhlu3gpnTT6ykoVWaZ5kwkIs4ibn5s5mF0sfV/94
         zfTu4I9lxJZbXSrPOTxqGiWryA6VtjjGOS6zNGUS6P8sKlk35pQnXsYk0Tz4Rps8ZwA1
         a9bbRw1sr3MCzLgXHVn4oDeRAMcBIhOOU9Vmc2uGyVU5xj06kH342nnAY6m/s8UguC0a
         1V7Q==
X-Gm-Message-State: ACgBeo25yGQAdV6yhl9cQ5YTWc8IMSbjmGOpr/q60oydtQgM1qeGvQV5
        NE95aUKGa8DgzekfisFjF8Vvng9emQ==
X-Google-Smtp-Source: AA6agR5GZXTt1VbMTOS8gsq8HxO52PoLstkhcM+vKWl8Q0tt/Fu1yUBDcxqacovxOsJha5kAg8gPMQ==
X-Received: by 2002:a05:6830:20ca:b0:636:d7f8:a404 with SMTP id z10-20020a05683020ca00b00636d7f8a404mr14464241otq.373.1662144845118;
        Fri, 02 Sep 2022 11:54:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r23-20020acaa817000000b0034276786a89sm1270672oie.31.2022.09.02.11.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:54:04 -0700 (PDT)
Received: (nullmailer pid 222402 invoked by uid 1000);
        Fri, 02 Sep 2022 18:54:03 -0000
Date:   Fri, 2 Sep 2022 13:54:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        helgaas@kernel.org, clement.leger@bootlin.com, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com
Subject: Re: [PATCH RFC 2/2] pci: create device tree node for selected devices
Message-ID: <20220902185403.GA173255-robh@kernel.org>
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1661809417-11370-3-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661809417-11370-3-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 29, 2022 at 02:43:37PM -0700, Lizhi Hou wrote:
> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> spaces from multiple hardware peripherals to its PCI BAR. Normally,
> the PCI core discovers devices and BARs using the PCI enumeration process.
> And the process does not provide a way to discover the hardware peripherals
> been mapped to PCI BARs.

This sentence doesn't make sense.

> For Alveo PCI card, the card firmware provides a
> flattened device tree to describe the hardware peripherals on its BARs.
> And the Alveo card driver can load this flattened device tree and leverage
> device tree framework to generate platform devices for the hardware
> peripherals eventually.
> 
> Apparently, the device tree framework requires a device tree node for the
> PCI device. Thus, it can generate the device tree nodes for hardware
> peripherals underneath. Because PCI is self discoverable bus, there might
> not be a device tree node created for PCI devices. This patch is to add
> support to generate device tree node for PCI devices. It introduces a
> kernel option. When the option is turned on, the kernel will generate
> device tree nodes for PCI bridges unconditionally. It will also generate
> a device tree node for Xilinx Alveo U50 by using PCI quirks. The generated
> device tree nodes do not have any property. The future patches will add
> necessary properties.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Brian Xu <brian.xu@amd.com>
> ---
>  drivers/pci/Kconfig         |  11 ++++
>  drivers/pci/bus.c           |   2 +
>  drivers/pci/msi/irqdomain.c |   6 +-
>  drivers/pci/of.c            | 106 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci-driver.c    |   3 +-
>  drivers/pci/pci.h           |  16 ++++++
>  drivers/pci/quirks.c        |  11 ++++
>  drivers/pci/remove.c        |   1 +
>  8 files changed, 153 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 55c028af4bd9..9eca5420330b 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -198,6 +198,17 @@ config PCI_HYPERV
>  	  The PCI device frontend driver allows the kernel to import arbitrary
>  	  PCI devices from a PCI backend to support PCI driver domains.
>  
> +config PCI_OF

We already have OF_PCI so this is confusing. Maybe 
'PCI_DYNAMIC_OF_NODES'.


> +	bool "Device tree node for PCI devices"
> +	select OF_DYNAMIC
> +	help
> +	  This option enables support for generating device tree nodes for some
> +	  PCI devices. Thus, the driver of this kind can load and overlay
> +	  flattened device tree for its downstream devices.
> +
> +	  Once this option is selected, the device tree nodes will be generated
> +	  for all PCI/PCIE bridges.
> +
>  choice
>  	prompt "PCI Express hierarchy optimization setting"
>  	default PCIE_BUS_DEFAULT
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 3cef835b375f..f752b804ad1f 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -316,6 +316,8 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	 */
>  	pcibios_bus_add_device(dev);
>  	pci_fixup_device(pci_fixup_final, dev);
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)

Would pci_is_bridge() work here? That would include cardbus, but I think 
that won't matter in practice.

> +		of_pci_make_dev_node(dev);


>  	pci_create_sysfs_dev_files(dev);
>  	pci_proc_attach_device(dev);
>  	pci_bridge_d3_update(dev);
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index e9cf318e6670..eeaf44169bfd 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -230,8 +230,10 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
>  
>  	of_node = irq_domain_get_of_node(domain);
> -	rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
> -			iort_msi_map_id(&pdev->dev, rid);
> +	if (of_node && !of_node_check_flag(of_node, OF_DYNAMIC))
> +		rid = of_msi_map_id(&pdev->dev, of_node, rid);
> +	else
> +		rid = iort_msi_map_id(&pdev->dev, rid);
>  
>  	return rid;
>  }
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 196834ed44fe..19856d42e147 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -469,6 +469,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>  		} else {
>  			/* We found a P2P bridge, check if it has a node */
>  			ppnode = pci_device_to_OF_node(ppdev);
> +			if (of_node_check_flag(ppnode, OF_DYNAMIC))
> +				ppnode = NULL;
>  		}
>  
>  		/*
> @@ -599,6 +601,110 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>  	return pci_parse_request_of_pci_ranges(dev, bridge);
>  }
>  
> +#if IS_ENABLED(CONFIG_PCI_OF)
> +struct of_pci_node {
> +	struct list_head node;
> +	struct device_node *dt_node;
> +	struct of_changeset cset;
> +};
> +
> +static LIST_HEAD(of_pci_node_list);
> +static DEFINE_MUTEX(of_pci_node_lock);

There is a 'data' pointer in device_node which you could use to store 
the changeset. Then you wouldn't need a list. (though 'data' is rarely 
used and I hoped to get rid of it)

> +
> +static void of_pci_free_node(struct of_pci_node *node)
> +{
> +	of_changeset_destroy(&node->cset);
> +	kfree(node->dt_node->full_name);
> +	if (node->dt_node)
> +		of_node_put(node->dt_node);

You free full_name before freeing the node, so you could have a UAF. 
That needs to be taken care of when releasing the node.

> +	kfree(node);
> +}
> +
> +void of_pci_remove_node(struct pci_dev *pdev)
> +{
> +	struct list_head *ele, *next;
> +	struct of_pci_node *node;
> +
> +	mutex_lock(&of_pci_node_lock);
> +
> +	list_for_each_safe(ele, next, &of_pci_node_list) {
> +		node = list_entry(ele, struct of_pci_node, node);
> +		if (node->dt_node == pdev->dev.of_node) {
> +			list_del(&node->node);
> +			mutex_unlock(&of_pci_node_lock);
> +			of_pci_free_node(node);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&of_pci_node_lock);
> +}

The above bits aren't really particular to PCI, so they probably 
belong in the DT core code. Frank will probably have thoughts on what 
this should look like.

> +
> +void of_pci_make_dev_node(struct pci_dev *pdev)
> +{
> +	const char *pci_type = "dev";
> +	struct device_node *parent;
> +	struct of_pci_node *node;
> +	int ret;
> +
> +	/*
> +	 * if there is already a device tree node linked to this device,
> +	 * return immediately.
> +	 */
> +	if (pci_device_to_OF_node(pdev))
> +		return;
> +
> +	/* check if there is device tree node for parent device */
> +	if (!pdev->bus->self)
> +		parent = pdev->bus->dev.of_node;
> +	else
> +		parent = pdev->bus->self->dev.of_node;
> +	if (!parent)
> +		return;
> +
> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return;
> +	of_changeset_init(&node->cset);
> +
> +	node->dt_node = of_node_alloc(NULL);
> +	if (!node->dt_node) {
> +		ret = -ENOMEM;
> +		goto failed;
> +	}
> +	node->dt_node->parent = parent;
> +
> +	if (pci_is_bridge(pdev))
> +		pci_type = "pci";
> +
> +	node->dt_node->full_name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
> +					     PCI_SLOT(pdev->devfn),
> +					     PCI_FUNC(pdev->devfn));
> +	if (!node->dt_node->full_name) {
> +		ret = -ENOMEM;
> +		goto failed;
> +	}

Wait, aren't you missing adding properties? You need 'reg', 
'compatbile', and 'device_type = "pci"' for bridges.

> +
> +	ret = of_changeset_attach_node(&node->cset, node->dt_node);
> +	if (ret)
> +		goto failed;
> +
> +	ret = of_changeset_apply(&node->cset);
> +	if (ret)
> +		goto failed;
> +
> +	pdev->dev.of_node = node->dt_node;
> +
> +	mutex_lock(&of_pci_node_lock);
> +	list_add(&node->node, &of_pci_node_list);
> +	mutex_unlock(&of_pci_node_lock);
> +
> +	return;
> +
> +failed:
> +	of_pci_free_node(node);
> +}

Pass in the parent node and node name, and this function is not PCI 
specific either.

> +#endif
> +
>  #endif /* CONFIG_PCI */
>  
>  /**
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 49238ddd39ee..1540c4c9a770 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1628,7 +1628,8 @@ static int pci_dma_configure(struct device *dev)
>  	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
>  
>  	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
> -	    bridge->parent->of_node) {
> +	    bridge->parent->of_node &&
> +	    !of_node_check_flag(bridge->parent->of_node, OF_DYNAMIC)) {
>  		ret = of_dma_configure(dev, bridge->parent->of_node, true);
>  	} else if (has_acpi_companion(bridge)) {
>  		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 785f31086313..319b79920d40 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -678,6 +678,22 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
>  
>  #endif /* CONFIG_OF */
>  
> +#ifdef CONFIG_PCI_OF
> +void of_pci_make_dev_node(struct pci_dev *pdev);
> +void of_pci_remove_node(struct pci_dev *pdev);
> +
> +#else
> +static inline void
> +of_pci_make_dev_node(struct pci_dev *pdev)
> +{
> +}
> +
> +static inline void
> +of_pci_remove_node(struct pci_dev *pdev);
> +{
> +}
> +#endif /* CONFIG_OF_DYNAMIC */
> +
>  #ifdef CONFIG_PCIEAER
>  void pci_no_aer(void);
>  void pci_aer_init(struct pci_dev *dev);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4944798e75b5..58a81e9ff0ed 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5956,3 +5956,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
>  #endif
> +
> +/*
> + * For PCIe device which have multiple downstream devices, its driver may use
> + * a flattened device tree to describe the downstream devices.
> + * To overlay the flattened device tree, the PCI device and all its ancestor
> + * devices need to have device tree nodes on system base device tree. Thus,
> + * before driver probing, it might need to add a device tree node as the final
> + * fixup.
> + */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 4c54c75050dc..0eaa9d9a3609 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -23,6 +23,7 @@ static void pci_stop_dev(struct pci_dev *dev)
>  		device_release_driver(&dev->dev);
>  		pci_proc_detach_device(dev);
>  		pci_remove_sysfs_dev_files(dev);
> +		of_pci_remove_node(dev);
>  
>  		pci_dev_assign_added(dev, false);
>  	}
> -- 
> 2.27.0
> 
> 
