Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4798B7DE85D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 23:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjKAWxJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 18:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjKAWxI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 18:53:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F77126;
        Wed,  1 Nov 2023 15:53:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBAFC433C7;
        Wed,  1 Nov 2023 22:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698879181;
        bh=KWFA4MzcMdhYJbaozAjCfZFUA3cJ1Xl92DjhTOQbp2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KXkKwkBDn0dymVcYC8WrV2Y7glzL59nzHFz/XIWUCK6l+hV3ynajqD+snl7Q1W61C
         q9eqorNMx97iI8b+klYYSsaRrPU4ySPj/UtdIs+i4hBLFuADsgUQehCg/WVcuoofg+
         AfwTcvCu8GX5oQ11+I/GXYtRIWravcw77xhIA2Slbu6aONklbJKijiwxb3TZgWnIS+
         pVokuvia+U3kURRTHeyf2WgsJMUVRo4JV+u2ILp+ymQx7umtmyz2r/D5I+TERjgwLw
         tro9wbdtVMemXCoLj3T3NJRuT3kbe5frQthjBURnSvK5HcFAzwy6V31SP4/7yVwis6
         58OSI4B2ugUjQ==
Date:   Wed, 1 Nov 2023 17:52:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Alexander.Deucher@amd.com
Subject: Re: [PATCH 2/2] PCI: Ignore PCIe ports used for tunneling in
 pcie_bandwidth_available()
Message-ID: <20231101225259.GA101390@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031133438.5299-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 31, 2023 at 08:34:38AM -0500, Mario Limonciello wrote:
> The USB4 spec specifies that PCIe ports that are used for tunneling
> PCIe traffic over USB4 fabric will be hardcoded to advertise 2.5GT/s.
> 
> In reality these ports speed is controlled by the fabric implementation.

So I guess you're saying the speed advertised by PCI_EXP_LNKSTA is not
the actual speed?  And we don't have a generic way to find the actual
speed?

> Downstream drivers such as amdgpu which utilize pcie_bandwidth_available()
> to program the device will always find the PCIe ports used for
> tunneling as a limiting factor and may make incorrect decisions.
> 
> To prevent problems in downstream drivers check explicitly for ports
> being used for PCIe tunneling and skip them when looking for bandwidth
> limitations.
> 
> 2 types of devices are detected:
> 1) PCIe root port used for PCIe tunneling
> 2) Intel Thunderbolt 3 bridge
> 
> Downstream drivers could make this change on their own but then they
> wouldn't be able to detect other potential speed bottlenecks.

Is the implication that a tunneling port can *never* be a speed
bottleneck?  That seems to be how this patch would work in practice.

> Link: https://lore.kernel.org/linux-pci/7ad4b2ce-4ee4-429d-b5db-3dfc360f4c3e@amd.com/
> Link: https://www.usb.org/document-library/usb4r-specification-v20
>       USB4 V2 with Errata and ECN through June 2023 - CLEAN p710

I guess this is sec 11.2.1 ("PCIe Physical Layer Logical Sub-block")
on PDF p710 (labeled "666" on the printed page).  How annoying that
the PDF page numbers don't match the printed ones; do the section
numbers at least stay stable in new spec revisions?

> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925

This issue says the external GPU doesn't work at all.  Does this patch
fix that?  This patch looks like it might improve GPU performance, but
wouldn't fix something that didn't work at all.

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 59c01d68c6d5..4a7dc9c2b8f4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6223,6 +6223,40 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
>  }
>  EXPORT_SYMBOL(pcie_set_mps);
>  
> +/**
> + * pcie_is_tunneling_port - Check if a PCI device is used for TBT3/USB4 tunneling
> + * @dev: PCI device to check
> + *
> + * Returns true if the device is used for PCIe tunneling, false otherwise.
> + */
> +static bool
> +pcie_is_tunneling_port(struct pci_dev *pdev)

Use usual function signature styling (all on one line).

> +{
> +	struct device_link *link;
> +	struct pci_dev *supplier;
> +
> +	/* Intel TBT3 bridge */
> +	if (pdev->is_thunderbolt)
> +		return true;
> +
> +	if (!pci_is_pcie(pdev))
> +		return false;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
> +		return false;
> +
> +	/* PCIe root port used for tunneling linked to USB4 router */
> +	list_for_each_entry(link, &pdev->dev.links.suppliers, c_node) {
> +		supplier = to_pci_dev(link->supplier);
> +		if (!supplier)
> +			continue;
> +		if (supplier->class == PCI_CLASS_SERIAL_USB_USB4)
> +			return true;

Since this is in drivers/pci, and this USB4/Thunderbolt routing is not
covered by the PCIe specs, this is basically black magic.  Is there a
reference to the USB4 spec we could include to help make it less
magical?

Lukas' brief intro in
https://lore.kernel.org/all/20230925141930.GA21033@wunner.de/ really
helped me connect a few dots, because things like
Documentation/admin-guide/thunderbolt.rst assume we already know those
details.

> +	}
> +
> +	return false;
> +}
> +
>  /**
>   * pcie_bandwidth_available - determine minimum link settings of a PCIe
>   *			      device and its bandwidth limitation
> @@ -6236,6 +6270,8 @@ EXPORT_SYMBOL(pcie_set_mps);
>   * limiting_dev, speed, and width pointers are supplied) information about
>   * that point.  The bandwidth returned is in Mb/s, i.e., megabits/second of
>   * raw bandwidth.
> + *
> + * This function excludes root ports and bridges used for USB4 and TBT3 tunneling.
>   */
>  u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  			     enum pci_bus_speed *speed,
> @@ -6254,6 +6290,10 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  	bw = 0;
>  
>  	while (dev) {
> +		/* skip root ports and bridges used for tunneling */
> +		if (pcie_is_tunneling_port(dev))
> +			goto skip;
> +
>  		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>  
>  		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
> @@ -6274,6 +6314,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  				*width = next_width;
>  		}
>  
> +skip:
>  		dev = pci_upstream_bridge(dev);
>  	}
>  
> -- 
> 2.34.1
> 
