Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1F41A18EB
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 01:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgDGXy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Apr 2020 19:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgDGXy1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Apr 2020 19:54:27 -0400
Received: from localhost (mobile-166-175-58-14.mycingular.net [166.175.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94317206A1;
        Tue,  7 Apr 2020 23:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586303666;
        bh=kpQNxYFHn1kgTnrJrEW0/RlgMJw6/06y4MFgCiPqI6c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sLKJRRVIhoM0tz7kK/0Z8oOujY3Z0BscPgHpkNlLSvB50Hum2JtqNS7pxkhuON6nO
         ZuYyJ6ZlipKMsXdnC3hu1prA3CfsoXQ8twDIRWjtR1sW1BnpuKaBJUV5lMHk1fpK7w
         qo5htgzYtJwHvDDAN2Ed4yxTtWfZKgsGZXYcZ+rY=
Date:   Tue, 7 Apr 2020 18:54:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI / ACPI: Whitelist D3 for more PCIe hotplug
 ports
Message-ID: <20200407235423.GA201115@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913143322.77953-11-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 13, 2018 at 05:33:22PM +0300, Mika Westerberg wrote:
> In order to have better power management for Thunderbolt PCIe chains,
> Windows enables power management for native PCIe hotplug ports if there
> is following ACPI _DSD attached to the root port:
> 
>   Name (_DSD, Package () {
>       ToUUID ("6211e2c0-58a3-4af3-90e1-927a4e0c55a4"),
>       Package () {
>           Package () {"HotPlugSupportInD3", 1}
>       }
>   })
> 
> This is also documented in:
> 
>   https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3

This doc basically says that if the platform supplies this _DSD, the
root port is "capable of handling hot plug events while in D3 state".

What does that mean?  That statement is not really actionable.  I
*assume* it's telling us about some specific hardware or firmware
functionality, like maybe we'll get a notification for hotplug events
when the device is in D3?  D3hot?  D3cold?  What is the notification?
Is it immediate or when the device comes back to D0?  How do we
control and field the notification?

> Do the same in Linux by introducing new firmware PM callback (->bridge_d3())
> and then implement it for ACPI based systems so that the above property is
> checked.
> 
> There is one catch, though. The initial pci_dev->bridge_d3 is set before
> the root port has ACPI companion bound (the device is not added to the
> PCI bus either) so we need to look up the ACPI companion manually in
> that case in acpi_pci_bridge_d3().
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/property.c |  3 +++
>  drivers/pci/pci-acpi.c  | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c       |  9 +++++++++
>  drivers/pci/pci.h       |  3 +++
>  4 files changed, 56 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 90ba9371bae6..8c7c4583b52d 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -28,6 +28,9 @@ static const guid_t prp_guids[] = {
>  	/* ACPI _DSD device properties GUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301 */
>  	GUID_INIT(0xdaffd814, 0x6eba, 0x4d8c,
>  		  0x8a, 0x91, 0xbc, 0x9b, 0xbf, 0x4a, 0xa3, 0x01),
> +	/* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
> +	GUID_INIT(0x6211e2c0, 0x58a3, 0x4af3,
> +		  0x90, 0xe1, 0x92, 0x7a, 0x4e, 0x0c, 0x55, 0xa4),
>  };
>  
>  static const guid_t ads_guid =
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index f8436d1c4d45..c8d0549580f4 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -519,6 +519,46 @@ static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>  	return PCI_POWER_ERROR;
>  }
>  
> +static struct acpi_device *acpi_pci_find_companion(struct device *dev);
> +
> +static bool acpi_pci_bridge_d3(struct pci_dev *dev)
> +{
> +	const struct fwnode_handle *fwnode;
> +	struct acpi_device *adev;
> +	struct pci_dev *root;
> +	u8 val;
> +
> +	if (!dev->is_hotplug_bridge)
> +		return false;
> +
> +	/*
> +	 * Look for a special _DSD property for the root port and if it
> +	 * is set we know the hierarchy behind it supports D3 just fine.
> +	 */
> +	root = pci_find_pcie_root_port(dev);
> +	if (!root)
> +		return false;
> +
> +	adev = ACPI_COMPANION(&root->dev);
> +	if (root == dev) {
> +		/*
> +		 * It is possible that the ACPI companion is not yet bound
> +		 * for the root port so look it up manually here.
> +		 */
> +		if (!adev && !pci_dev_is_added(root))
> +			adev = acpi_pci_find_companion(&root->dev);
> +	}
> +
> +	if (!adev)
> +		return false;
> +
> +	fwnode = acpi_fwnode_handle(adev);
> +	if (fwnode_property_read_u8(fwnode, "HotPlugSupportInD3", &val))
> +		return false;
> +
> +	return val == 1;
> +}
> +
>  static bool acpi_pci_power_manageable(struct pci_dev *dev)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> @@ -635,6 +675,7 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
>  }
>  
>  static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
> +	.bridge_d3 = acpi_pci_bridge_d3,
>  	.is_manageable = acpi_pci_power_manageable,
>  	.set_state = acpi_pci_set_power_state,
>  	.get_state = acpi_pci_get_power_state,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1af6f1887986..b1b3052f15dc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -791,6 +791,11 @@ static inline bool platform_pci_need_resume(struct pci_dev *dev)
>  	return pci_platform_pm ? pci_platform_pm->need_resume(dev) : false;
>  }
>  
> +static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> +{
> +	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;

This patch added a .bridge_d3() implementation for ACPI but not for
MID.  What prevents us from calling platform_pci_bridge_d3() on a MID
platform and trying to call through a NULL pointer?

Shouldn't we do something like the patch attached below?

> +}
> +
>  /**
>   * pci_raw_set_power_state - Use PCI PM registers to set the power state of
>   *                           given PCI device
> @@ -2514,6 +2519,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		if (bridge->is_thunderbolt)
>  			return true;
>  
> +		/* Platform might know better if the bridge supports D3 */
> +		if (platform_pci_bridge_d3(bridge))
> +			return true;

*All* devices trivially support D3.  Obviously we're trying to learn
something else here.  What is it?

>  		/*
>  		 * Hotplug ports handled natively by the OS were not validated
>  		 * by vendors for runtime D3 at least until 2018 because there
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6e0d1528d471..66fd5c1bf71b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -39,6 +39,8 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  /**
>   * struct pci_platform_pm_ops - Firmware PM callbacks
>   *
> + * @bridge_d3: Does the bridge allow entering into D3
> + *
>   * @is_manageable: returns 'true' if given device is power manageable by the
>   *		   platform firmware
>   *
> @@ -60,6 +62,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>   * these callbacks are mandatory.
>   */
>  struct pci_platform_pm_ops {
> +	bool (*bridge_d3)(struct pci_dev *dev);
>  	bool (*is_manageable)(struct pci_dev *dev);
>  	int (*set_state)(struct pci_dev *dev, pci_power_t state);
>  	pci_power_t (*get_state)(struct pci_dev *dev);
> -- 


diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
index aafd58da3a89..0bacd45b30d6 100644
--- a/drivers/pci/pci-mid.c
+++ b/drivers/pci/pci-mid.c
@@ -16,6 +16,11 @@
 
 #include "pci.h"
 
+static bool mid_pci_bridge_d3(struct pci_dev *dev)
+{
+	return false;
+}
+
 static bool mid_pci_power_manageable(struct pci_dev *dev)
 {
 	return true;
@@ -47,6 +52,7 @@ static bool mid_pci_need_resume(struct pci_dev *dev)
 }
 
 static const struct pci_platform_pm_ops mid_pci_platform_pm = {
+	.bridge_d3	= mid_pci_bridge_d3,
 	.is_manageable	= mid_pci_power_manageable,
 	.set_state	= mid_pci_set_power_state,
 	.get_state	= mid_pci_get_power_state,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 595fcf59843f..fa837e88ea07 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -820,8 +820,9 @@ static const struct pci_platform_pm_ops *pci_platform_pm;
 
 int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
 {
-	if (!ops->is_manageable || !ops->set_state  || !ops->get_state ||
-	    !ops->choose_state  || !ops->set_wakeup || !ops->need_resume)
+	if (!ops->bridge_d3 || !ops->is_manageable || !ops->set_state  ||
+	    !ops->get_state || !ops->choose_state  || !ops->set_wakeup ||
+	    !ops->need_resume)
 		return -EINVAL;
 	pci_platform_pm = ops;
 	return 0;
