Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706DB4B2FAF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 22:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbiBKVpv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 16:45:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiBKVpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 16:45:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A31C65;
        Fri, 11 Feb 2022 13:45:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE33560B84;
        Fri, 11 Feb 2022 21:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD758C340E9;
        Fri, 11 Feb 2022 21:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644615948;
        bh=2KgOn/RZzkXwEjZXA2P3mRTuQv6sRwGGGOoktFxh1d4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kPdw7gJdeNgRqZ0bF0QfcOqrx72tFbaJ7hD6DvQ1Rb0gU0TCdCB/BPQS/brppXP+l
         FToWaDqfReFE8zu4Il9ynRR+Gwhd0s03bclaI0GgUOfSqtoBWU2aaOEp9q1X/aeVlh
         T8vp3E6RfwW9HsLAxJKQXYSBZaS2qa6AkMAEXCOZ72wOgShaOqGCjIBbr+MDQNzd/1
         IMhMnhWEBINIulUeLcXAwUNc/vGTno3Nidyjuialc6CrHAsC9mYm2BqIoFeeX1y5hP
         bk4le6RS1casf3+ljFu7eM9r9Bfu2irb4h38bqiKUMqzYuGzr8IXH7TQsysYbgj0DJ
         LsPYmzVolLiwQ==
Date:   Fri, 11 Feb 2022 15:45:46 -0600
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
Subject: Re: [PATCH v3 05/12] PCI: Detect root port of internal USB4 devices
 by `usb4-host-interface`
Message-ID: <20220211214546.GA737137@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211193250.1904843-6-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 01:32:43PM -0600, Mario Limonciello wrote:
> The root port used for PCIe tunneling should be marked as removable to
> ensure that the entire chain is marked removable.
> 
> This can be done by looking for the device property specified in
> the ACPI tables `usb4-host-interface`.
> 
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci-acpi.c | 10 ++++++++++
>  drivers/pci/pci.h      |  5 +++++
>  drivers/pci/probe.c    |  1 +
>  3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a42dbf448860..6368e5633b1b 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1391,6 +1391,16 @@ void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev)
>  	}
>  }
>  
> +bool pci_acpi_is_usb4(struct pci_dev *dev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> +
> +	if (!adev)
> +		return false;
> +	return fwnode_property_present(acpi_fwnode_handle(adev),
> +				       "usb4-host-interface");

Maybe it's obvious to everybody but me that "USB4" means this device
is removable.  The Microsoft reference above doesn't say anything
about removability.

My expectation is that "USB" (like "PCI" and "PCIe") tells me
something about how a device is electrically connected and how
software can operate it.  It doesn't really tell me anything about
whether those electrical connections are permanent, made through an
internal slot, or made through an external connector and cable.

> +}
> +
>  static struct fwnode_handle *(*pci_msi_get_fwnode_cb)(struct device *dev);
>  
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3d60cabde1a1..359607c0542d 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -695,6 +695,7 @@ void acpi_pci_refresh_power_state(struct pci_dev *dev);
>  int acpi_pci_wakeup(struct pci_dev *dev, bool enable);
>  bool acpi_pci_need_resume(struct pci_dev *dev);
>  pci_power_t acpi_pci_choose_state(struct pci_dev *pdev);
> +bool pci_acpi_is_usb4(struct pci_dev *dev);
>  #else
>  static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
>  {
> @@ -734,6 +735,10 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>  {
>  	return PCI_POWER_ERROR;
>  }
> +static inline bool pci_acpi_is_usb4(struct pci_dev *dev)
> +{
> +	return false;
> +}
>  #endif
>  
>  #ifdef CONFIG_PCIEASPM
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e41656cdd8f0..2693211d31cf 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1610,6 +1610,7 @@ static void pci_set_removable(struct pci_dev *dev)
>  	 * exposed as "removable" to userspace.
>  	 */
>  	if (vsec ||
> +	    pci_acpi_is_usb4(dev) ||
>  	    (parent &&
>  	    (parent->external_facing || dev_is_removable(&parent->dev))))
>  		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> -- 
> 2.34.1
> 
