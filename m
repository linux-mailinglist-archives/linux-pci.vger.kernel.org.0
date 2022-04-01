Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE694EF79B
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348908AbiDAQLp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352307AbiDAQLF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 12:11:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7AC62CB6;
        Fri,  1 Apr 2022 08:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F422B82532;
        Fri,  1 Apr 2022 15:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC50FC2BBE4;
        Fri,  1 Apr 2022 15:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648827435;
        bh=PuaGpzL8a1jL74ecCHi7gxUKeSuanUqtKSFNaNEO6H0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ViajW4MbGFEUEkcq2mg7+MzfRHJQ+OjjbrNd0mdK2izw1UR/5HYh+0Av0q7zjlC8Q
         nrtqgevQn1nZkWFaV0iEqwx88JXHALAGRWkQxUxyQEffhm/gtP3JWp7ZCnx+DqTNvK
         rrfgqF2kwGZFZLQnnWiNMoa8wen0oWwopnzz/dtPtucJkBR0++k7ErMVSQmFPYEC0q
         p6e5zPayZf4CAeZcOsk3wSfprmzTYGcAD2Ag9LP565VuDxiSpivTzuH+EC3mu53EzD
         IdJFZc9DlSA/ivWVjuuLA1DJFAmdWfE4OYngJPE7Glwq8wXPLloXKLJ8jPwdVZdylq
         K3Mu/S7YDQE7Q==
Date:   Fri, 1 Apr 2022 10:37:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org, Sanju.Mehta@amd.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6] PCI / ACPI: Assume "HotPlugSupportInD3" only if
 device can wake from D3
Message-ID: <20220401153713.GA100914@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401034003.3166-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 31, 2022 at 10:40:03PM -0500, Mario Limonciello wrote:
> acpi_pci_bridge_d3(dev) returns "true" if "dev" is a hotplug bridge
> that can handle hotplug events while in D3.  Previously this meant:
> 
>  1) "dev" has a _PS0 or _PR0 method, or
> 
>  2) The Root Port above "dev" has a _DSD with a "HotPlugSupportInD3"
>     property with value 1.
> 
> This did not consider_S0W, which tells us the deepest D-state from
> which a device can wake itself (ACPI v6.4, sec 7.3.20).
> 
> On some platforms, e.g., AMD Yellow Carp, firmware may supply
> "HotPlugSupportInD3" even though the platform does not supply power
> resources through _PRW and _S0W tells us the device cannot wake from
> D3hot.  With the previous code, these devices could be put in D3hot
> and hotplugged devices would not be recognized without manually
> rescanning.
> 
> If _S0W exists and says the Root Port cannot wake itself from D3hot,
> return "false" to indicate that "dev" cannot handle hotplug events
> while in D3.
> 
>  1) "dev" has a _PS0 or _PR0 method, or
> 
>  2a) The Root Port above "dev" has _PRW and
> 
>  2b) If the Root Port above "dev" has _S0W, it can wake from D3hot or
>      D3cold and
> 
>  2c) The Root Port above "dev" has a _DSD with a
>      "HotPlugSupportInD3" property with value 1.
> 
> Windows 10 and Windows 11 both will prevent the bridge from going in D3
> when the firmware is configured this way and this change aligns the
> handling of the situation to be the same.
> 
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
> Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
> Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied to for-linus with tweaks as below.  It's awfully late (my
fault for not pushing on this earlier) but I hope to squeeze it into
v5.18.

> --
> v5->v6:
>  * Re-order checks to only check for _DSD if necessary as suggested by Bjorn.
>  * Adjust commit message wording
>  * Drop rewording comment patch, just apply it while moving text to avoid
>    ping-ponging the same lines in the commits.
> v4-v5:
>  * Don't fail if _S0W is missing
> ---
>  drivers/pci/pci-acpi.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1f15ab7eabf8..5ab797e2709d 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -976,7 +976,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  {
>  	const union acpi_object *obj;
>  	struct acpi_device *adev;
> +	unsigned long long state;
>  	struct pci_dev *rpdev;
> +	acpi_status status;
>  
>  	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>  		return false;
> @@ -985,12 +987,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  	if (acpi_pci_power_manageable(dev))
>  		return true;
>  
> -	/*
> -	 * The ACPI firmware will provide the device-specific properties through
> -	 * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
> -	 * for the root port and if it is set we know the hierarchy behind it
> -	 * supports D3 just fine.
> -	 */
>  	rpdev = pcie_find_root_port(dev);
>  	if (!rpdev)
>  		return false;
> @@ -999,6 +995,23 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  	if (!adev)
>  		return false;
>  
> +	/*
> +	 * If the bridge can't wake from D3hot, it can't signal hotplug
> +	 * events in D3hot.
> +	 */
> +	if (!adev->wakeup.flags.valid)
> +		return false;
> +
> +	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
> +	if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
> +		return false;
> +
> +	/*
> +	 * The ACPI firmware will provide the device-specific properties through
> +	 * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
> +	 * for the root port and if it is set we make an assumption that the
> +	 * hierarchy behind it supports D3 as well.
> +	 */
>  	if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
>  				   ACPI_TYPE_INTEGER, &obj) < 0)
>  		return false;
> -- 
> 2.34.1
> 


commit c1d27b79a94f ("PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3")
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:   Thu Mar 31 22:40:03 2022 -0500

    PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3
    
    acpi_pci_bridge_d3(dev) returns "true" if "dev" is a hotplug bridge that
    can handle hotplug events while in D3.  Previously this meant either:
    
      - "dev" has a _PS0 or _PR0 method (acpi_pci_power_manageable()), or
    
      - The Root Port above "dev" has a _DSD with a "HotPlugSupportInD3"
        property with value 1.
    
    This did not consider _PRW, which tells us about wakeup GPEs (ACPI v6.4,
    sec 7.3.13).  Without a wakeup GPE, from an ACPI perspective the Root Port
    has no way of generating wakeup signals, so hotplug events will be lost if
    we use D3.
    
    Similarly, it did not consider _S0W, which tells us the deepest D-state
    from which a device can wake itself (sec 7.3.20).  If _S0W tells us the
    device cannot wake from D3, hotplug events will again be lost if we use D3.
    
    Some platforms, e.g., AMD Yellow Carp, supply "HotPlugSupportInD3" without
    _PRW or with an _S0W that says the Root Port cannot wake from D3.  On those
    platforms, we previously put bridges in D3hot, hotplug events were lost,
    and hotplugged devices would not be recognized without manually rescanning.
    
    Allow bridges to be put in D3 only if the Root Port can generate wakeup
    GPEs (wakeup.flags.valid), it can wake from D3 (_S0W), AND it has the
    "HotPlugSupportInD3" property.
    
    Neither Windows 10 nor Windows 11 puts the bridge in D3 when the firmware
    is configured this way, and this change aligns the handling of the
    situation to be the same.
    
    [bhelgaas: commit log, tidy "HotPlugSupportInD3" check and comment]
    Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
    Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
    Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
    Link: https://lore.kernel.org/r/20220401034003.3166-1-mario.limonciello@amd.com
    Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1f15ab7eabf8..3ae435beaf0a 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -974,9 +974,11 @@ bool acpi_pci_power_manageable(struct pci_dev *dev)
 
 bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
-	const union acpi_object *obj;
-	struct acpi_device *adev;
 	struct pci_dev *rpdev;
+	struct acpi_device *adev;
+	acpi_status status;
+	unsigned long long state;
+	const union acpi_object *obj;
 
 	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
 		return false;
@@ -985,12 +987,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	if (acpi_pci_power_manageable(dev))
 		return true;
 
-	/*
-	 * The ACPI firmware will provide the device-specific properties through
-	 * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
-	 * for the root port and if it is set we know the hierarchy behind it
-	 * supports D3 just fine.
-	 */
 	rpdev = pcie_find_root_port(dev);
 	if (!rpdev)
 		return false;
@@ -999,11 +995,34 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	if (!adev)
 		return false;
 
-	if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
-				   ACPI_TYPE_INTEGER, &obj) < 0)
+	/*
+	 * If the Root Port cannot signal wakeup signals at all, i.e., it
+	 * doesn't supply a wakeup GPE via _PRW, it cannot signal hotplug
+	 * events from low-power states including D3hot and D3cold.
+	 */
+	if (!adev->wakeup.flags.valid)
 		return false;
 
-	return obj->integer.value == 1;
+	/*
+	 * If the Root Port cannot wake itself from D3hot or D3cold, we
+	 * can't use D3.
+	 */
+	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
+	if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
+		return false;
+
+	/*
+	 * The "HotPlugSupportInD3" property in a Root Port _DSD indicates
+	 * the Port can signal hotplug events while in D3.  We assume any
+	 * bridges *below* that Root Port can also signal hotplug events
+	 * while in D3.
+	 */
+	if (!acpi_dev_get_property(adev, "HotPlugSupportInD3",
+				   ACPI_TYPE_INTEGER, &obj) &&
+	    obj->integer.value == 1)
+		return true;
+
+	return false;
 }
 
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
