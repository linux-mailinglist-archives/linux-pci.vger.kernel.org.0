Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC25E4B3028
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 23:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353983AbiBKWKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 17:10:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353972AbiBKWKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 17:10:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9338DCF9;
        Fri, 11 Feb 2022 14:10:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FB42612C3;
        Fri, 11 Feb 2022 22:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C337C340E9;
        Fri, 11 Feb 2022 22:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644617443;
        bh=F4zwECnYSIoYTo6u15HaW+7XtQkIsH4vBQQc4HAroWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uwNq4p9W6mrbvgi+RLhhV7zKAfRJ8EtC+4WUxSuPZMShyV/VJTHn6w++7hiePD12o
         HsWflg4eWX4NGfjWWAuGPKlFafA8Jitk3rf/5iE6vNygI4m0VOF3ijn+yDoD5HK9jf
         4h8HFg1bVqxctiAieWR5VHYSsJ15hD8E3qx0RuGtrFcDBKa+v346FXCE9zmzzCjCPU
         ke196VEecIRc5JmgGNc69Q5ReVSePpF2ByphPelHv6Tz/aHz7nRBQVycdNtvnwoIFJ
         j63KwN7h8LNME9v7/JfGJxWPxOmRTxzzIATtQ4MvtH7ttsOh2Os2+nnaCGvlEyVI8y
         oZK0Tu66HNcNw==
Date:   Fri, 11 Feb 2022 16:10:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com, Lukas Wunner <lukas@wunner.de>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v3 07/12] PCI: Set ports for discrete USB4 controllers
 appropriately
Message-ID: <20220211221041.GA738039@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211193250.1904843-8-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make the subject specific, not just "appropriately."  I think you're
marking something *removable*, so include that.

On Fri, Feb 11, 2022 at 01:32:45PM -0600, Mario Limonciello wrote:
> Discrete USB4 controllers won't have ACPI nodes specifying which
> PCIe or XHCI port they are linked with.
> 
> In order to set the removable attribute appropriately, use the
> USB4 DVSEC extended capabability set on these root ports to determine
> if they are located on a discrete USB4 controller.

s/capabability/capability/

> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Link: https://usb.org/sites/default/files/USB4%20Specification%2020211116.zip
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/probe.c     | 33 +++++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h |  2 ++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 67ca33188cba..1ed3e24db11e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -25,6 +25,8 @@
>  #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
>  #define CARDBUS_RESERVE_BUSNR	3
>  
> +#define PCI_DVSEC_ID_USB4	0x23
> +
>  static struct resource busn_resource = {
>  	.name	= "PCI busn",
>  	.start	= 0,
> @@ -1590,6 +1592,36 @@ static void set_pcie_untrusted(struct pci_dev *dev)
>  		dev->untrusted = true;
>  }
>  
> +static bool pci_is_discrete_usb4(struct pci_dev *dev)
> +{
> +	int dvsec_val = 0, pos;
> +	u32 hdr;
> +
> +	/* USB4 spec says vendors can use either */
> +	pos = pci_find_dvsec_capability(dev,
> +					PCI_VENDOR_ID_INTEL,
> +					PCI_DVSEC_ID_USB4);
> +	if (pos) {
> +		dvsec_val = 0x06;
> +	} else {
> +		pos = pci_find_dvsec_capability(dev,
> +						PCI_VENDOR_ID_USB_IF,
> +						PCI_DVSEC_ID_USB4);
> +		if (pos)
> +			dvsec_val = 0x01;
> +	}
> +	if (!dvsec_val)
> +		return false;
> +
> +	pci_read_config_dword(dev, pos + PCI_DVSEC_HEADER2, &hdr);
> +	if ((hdr & GENMASK(15, 0)) != dvsec_val)
> +		return false;
> +	/* this port is used for either NHI/PCIe tunnel/USB tunnel */

Capitalize comment like others in this file.

Spec reference would be helpful, too.  I don't know how to verify
any of these values.  The Link: above is great, but name, revision,
section number would be even better.

> +	if (hdr & GENMASK(18, 16))
> +		return true;
> +	return false;
> +}
> +
>  static void pci_set_removable(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent = pci_upstream_bridge(dev);
> @@ -1612,6 +1644,7 @@ static void pci_set_removable(struct pci_dev *dev)
>  	if (vsec ||
>  	    dev->class == PCI_CLASS_SERIAL_USB_USB4 ||
>  	    pci_acpi_is_usb4(dev) ||
> +	    pci_is_discrete_usb4(dev) ||
>  	    (parent &&
>  	    (parent->external_facing || dev_is_removable(&parent->dev))))
>  		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 61b161d914f0..271326e058b9 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3097,4 +3097,6 @@
>  
>  #define PCI_VENDOR_ID_NCUBE		0x10ff
>  
> +#define PCI_VENDOR_ID_USB_IF		0x1EC0

This file is supposed to be sorted by Vendor ID.  PCI_VENDOR_ID_XEN,
PCI_VENDOR_ID_OCZ, and PCI_VENDOR_ID_NCUBE screwed up, but you can put
USB_IF in the correct spot.

It's not 100%, but most entries use lower-case hex.
