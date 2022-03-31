Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5454A4EE14F
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiCaTGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 15:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbiCaTGh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 15:06:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8E32156EA;
        Thu, 31 Mar 2022 12:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABFA161964;
        Thu, 31 Mar 2022 19:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2BBC340EE;
        Thu, 31 Mar 2022 19:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648753488;
        bh=SYMjoHRnoNXLOWVbsdr5TjvylyumCAsmmcVI2IxtO/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ofYNLiabGA0jGbKAFDd8HrDNEPlSDK5yQaXNNc0yw/L2iI7aIh21OoGttseZ7BfGg
         35njGMgk8RWXqh2ieQU8J2QFFa/Ut+8aM4HCKyfR5pD3NOXL4czO/ORU6MvFAgNrk2
         iQ0Ay+SnDWSdEAe2+HRYuTmVSQ7IWu5RsqXG2ALWa8ftzN5nvT8Hfu1lcfV+i90Skx
         7Fl+YIxnABSnlp9bDhz5r3RenbvKpO22TjUwdmJHodfswx69vupV878IKoJAKhukc6
         YdI9Xao7+2P8mX8g/PEU6tWQQnEBxaCeNfSLGzK+yiGSXEJLnqUs5XpI7KPth3wJVX
         qcZTRd05DRfeQ==
Date:   Thu, 31 Mar 2022 14:04:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org, Sanju.Mehta@amd.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5 1/2] PCI / ACPI: Assume `HotPlugSupportInD3` only if
 device can wake from D3
Message-ID: <20220331190446.GA12929@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328205519.250-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, Mika, linux-pm]

On Mon, Mar 28, 2022 at 03:55:18PM -0500, Mario Limonciello wrote:
> According to the Microsoft spec the _DSD `HotPlugSupportInD3` is
> indicates the ability for a bridge to be able to wakeup from D3:
> 
>   This ACPI object [HotPlugSupportInD3] enables the operating system
>   to identify and power manage PCIe Root Ports that are capable of
>   handling hot plug events while in D3 state.
> 
> This however is static information in the ACPI table at BIOS compilation
> time and on some platforms it's possible to configure the firmware at boot
> up such that _S0W returns "0" indicating the inability to wake up the
> device from D3 as explained in the ACPI specification:
> 
>   7.3.20 _S0W (S0 Device Wake State)
> 
>   This object evaluates to an integer that conveys to OSPM the deepest
>   D-state supported by this device in the S0 system sleeping state
>   where the device can wake itself.
> 
> This mismatch may lead to being unable to enumerate devices behind the
> hotplug bridge when a device is plugged in. To remedy these situations
> that `HotPlugSupportInD3` is specified by _S0W returns 0, explicitly
> check that the ACPI companion has returned _S0W greater than or equal
> to 3 and the device has a GPE allowing the device to generate wakeup
> signals handled by the platform in `acpi_pci_bridge_d3`.

acpi_pci_bridge_d3() currently depends only on HotPlugSupportInD3 for
the Root Port.  This patch adds dependencies on _S0W (if it exists)
and _PRW.  The _PRW connection is indirect; this patch tests
device->wakeup.flags.valid, which is only set in this path:

  acpi_add_single_object
    acpi_bus_get_wakeup_device_flags
      if (!acpi_has_method(device->handle, "_PRW"))
	return;
      acpi_bus_extract_wakeup_device_power_package
	acpi_evaluate_object("_PRW") 
	if (package)
	  wakeup->gpe_device = ...
	  wakeup->gpe_number = ...
      device->wakeup.flags.valid = acpi_wakeup_gpe_init(device);

So IIUC the proposed logic here is:

  - If Root Port has no _PRW, we can't put this device in D3 (this is
    new).

  - If Root Port has _S0W that says wake is not supported in D3hot
    (Linux sets OSC_SB_PR3_SUPPORT), we can't put this device in D3
    (this is also new).

  - If Root Port has HotPlugSupportInD3, we can put this device in D3
    (this is the existing behavior).

Proposed text:

  acpi_pci_bridge_d3(dev) returns "true" if "dev" is a hotplug bridge
  that can handle hotplug events while in D3.  Previously this meant:

    1) "dev" has a _PS0 or _PR0 method, or

    2) The Root Port above "dev" has a _DSD with a
       "HotPlugSupportInD3" property with value 1.

  This did not consider_S0W, which tells us the deepest D-state from
  which a device can wake itself (ACPI v6.4, sec 7.3.20).

  On some platforms, e.g., AMD Yellow Carp, firmware may supply
  "HotPlugSupportInD3" even though _S0W tells us the device cannot
  wake from D3hot.  With the previous code, these devices could be put
  in D3hot and hotplugged devices would not be recognized.

  If _S0W exists and says the Root Port cannot wake itself from D3hot,
  return "false" to indicate that "dev" cannot handle hotplug events
  while in D3.

    1) "dev" has a _PS0 or _PR0 method, or

    2a) The Root Port above "dev" has _PRW and

    2b) If the Root Port above "dev" has _S0W, it can wake from D3hot or
        D3cold and

    2c) The Root Port above "dev" has a _DSD with a
        "HotPlugSupportInD3" property with value 1.

The _S0W part makes sense to me.  The _PRW part hasn't been explained
yet.  We didn't depend on it before, but we think it's safe to depend
on it now?

In the commit log and comments, can we be more explicit about whether
"D3" means "D3hot" or "D3cold"?

> Windows 10 and Windows 11 both will prevent the bridge from going in D3
> when the firmware is configured this way and this changes aligns the
> handling of the situation to be the same.
> 
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
> Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
> Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4-v5:
>  * Don't fail if _S0W is missing
>  drivers/pci/pci-acpi.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1f15ab7eabf8..91c165ea4346 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -977,6 +977,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  	const union acpi_object *obj;
>  	struct acpi_device *adev;
>  	struct pci_dev *rpdev;
> +	unsigned long long ret;
>  
>  	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>  		return false;
> @@ -1003,7 +1004,21 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  				   ACPI_TYPE_INTEGER, &obj) < 0)
>  		return false;
>  
> -	return obj->integer.value == 1;
> +	if (!obj->integer.value)
> +		return false;
> +
> +	/*
> +	 * If 'HotPlugSupportInD3' is set, but wakeup is not actually supported,
> +	 * the former cannot be trusted anyway, so validate it by verifying the
> +	 * latter.
> +	 */
> +	if (!adev->wakeup.flags.valid)
> +		return false;
> +
> +	if (ACPI_SUCCESS(acpi_evaluate_integer(adev->handle, "_S0W", NULL, &ret)))
> +		return ret >= ACPI_STATE_D3_HOT;

I think it would make more sense to move the generic easy tests
earlier, before acpi_dev_get_property(), since there's no need to look
up the property if we might fail later.  E.g., something like the
patch below, so it's:

  if (!adev->wakeup.flags.valid)
    return false;

  status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
  if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
    return false;

  if (!acpi_dev_get_property(adev, "HotPlugSupportInD3",
                             ACPI_TYPE_INTEGER, &obj) &&
      obj->integer.value == 1)
    return true;

  return false;

> +
> +	return true;
>  }

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1f15ab7eabf8..9959bfdc0746 100644
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
@@ -985,25 +987,37 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	if (acpi_pci_power_manageable(dev))
 		return true;
 
+	rpdev = pcie_find_root_port(dev);
+	if (!rpdev)
+		return false;
+
+	adev = ACPI_COMPANION(&rpdev->dev);
+	if (!adev)
+		return false;
+
+	/*
+	 * If the bridge can't wake from D3hot, it can't signal hotplug
+	 * events in D3hot.
+	 */
+	if (!adev->wakeup.flags.valid)
+		return false;
+
+	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
+	if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
+		return false;
+
 	/*
 	 * The ACPI firmware will provide the device-specific properties through
 	 * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
 	 * for the root port and if it is set we know the hierarchy behind it
 	 * supports D3 just fine.
 	 */
-	rpdev = pcie_find_root_port(dev);
-	if (!rpdev)
-		return false;
+	if (!acpi_dev_get_property(adev, "HotPlugSupportInD3",
+				   ACPI_TYPE_INTEGER, &obj) &&
+	    obj->integer.value == 1)
+		return true;
 
-	adev = ACPI_COMPANION(&rpdev->dev);
-	if (!adev)
-		return false;
-
-	if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
-				   ACPI_TYPE_INTEGER, &obj) < 0)
-		return false;
-
-	return obj->integer.value == 1;
+	return false;
 }
 
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
