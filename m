Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7714B3A15
	for <lists+linux-pci@lfdr.de>; Sun, 13 Feb 2022 09:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiBMIVE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Feb 2022 03:21:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiBMIVD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Feb 2022 03:21:03 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F64C5E773
        for <linux-pci@vger.kernel.org>; Sun, 13 Feb 2022 00:20:58 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5BEDA300002A0;
        Sun, 13 Feb 2022 09:20:56 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 496B22E6C05; Sun, 13 Feb 2022 09:20:56 +0100 (CET)
Date:   Sun, 13 Feb 2022 09:20:56 +0100
From:   Lukas Wunner <lukas@wunner.de>
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
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 04/12] PCI: Drop the `is_thunderbolt` attribute from
 PCI core
Message-ID: <20220213082056.GA23572@wunner.de>
References: <20220211193250.1904843-1-mario.limonciello@amd.com>
 <20220211193250.1904843-5-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211193250.1904843-5-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 01:32:42PM -0600, Mario Limonciello wrote:
> The `is_thunderbolt` attribute is currently a dumping ground for a
> variety of things.

It's not as arbitrary as it may seem.  Quite a bit of thought went into
the current design.


> Instead use the driver core removable attribute to indicate the
> detail a device is attached to a thunderbolt or USB4 chain.

You're missing the point that "is_thunderbolt" is set on the *controller*
(i.e. its upstream and downstream ports).

The controller itself is *not* removable if it's the host controller.

However a device can be assumed to be removable if it has an ancestor
which has the "is_thunderbolt" flag set.


>  static void pci_set_removable(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent = pci_upstream_bridge(dev);
> +	u16 vsec;
> +
> +	/* Is the device a Thunderbolt controller? */
> +	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT);

This doesn't make any sense because the host controller is not
removable.


> @@ -1860,7 +1855,6 @@ int pci_setup_device(struct pci_dev *dev)
>  	dev->cfg_size = pci_cfg_space_size(dev);
>  
>  	/* Need to have dev->cfg_size ready */
> -	set_pcie_thunderbolt(dev);
>  
>  	set_pcie_untrusted(dev);

Either drop the blank line or drop the code comment if set_pcie_untrusted()
doesn't need dev->cfg_size.


> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 57553f9b4d1d..04232fbc7d56 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -596,7 +596,7 @@ static int gmux_resume(struct device *dev)
>  
>  static int is_thunderbolt(struct device *dev, void *data)
>  {
> -	return to_pci_dev(dev)->is_thunderbolt;
> +	return pci_is_thunderbolt_attached(to_pci_dev(dev));
>  }

No, the gmux driver changes its behavior if a Thunderbolt host
controller is present.  Not if there's a Thunderbolt-attached
device present.

Thanks,

Lukas
