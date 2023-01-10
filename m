Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C716664DBB
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 21:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjAJUzT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 15:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjAJUzT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 15:55:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1D4244;
        Tue, 10 Jan 2023 12:55:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 900BEB819AB;
        Tue, 10 Jan 2023 20:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECA4C433D2;
        Tue, 10 Jan 2023 20:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673384115;
        bh=QD1jTOHKqiQ+2IgPZL7y9a5rws2XG+ZSMfZp4kVs1sU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IsLP/arLn9vDHcQOfi/AkSeBjMhEvNYDqLAd0BDcUgiLmReE7qkeA7MloGVk0pFT+
         JMEVRSC3LjIJhFRBFvZDyEuIGMrBxyWr7oo9g9YWAobVIAOLH/rUq9JKfrzk3rWJ9b
         TI/Gcr96zmQuw0RV3KrBh5kURwmloV+7AOKtb3OQTr1uPFH64W591yxJfpV0s3YrZD
         t5onOQuUQBHE0GFMVZHVFfYo5gzv+9abGNfP+N+1xLdY5W6KMnr/MVKeW1j9kKgTBl
         yRAx/+QvjVrsl5b6cJwxPbqDJmO5XUVXkWbBxeGH46bUFm+SyX3EYwTAIR7F66c6Zl
         cXApDQxVSZZcA==
Date:   Tue, 10 Jan 2023 14:55:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
Message-ID: <20230110205513.GA1608269@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1945994.PYKUYFuaPT@kreacher>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 02, 2023 at 05:59:36PM +0100, Rafael J. Wysocki wrote:
> On Monday, January 2, 2023 5:34:19 PM CET Rafael J. Wysocki wrote:
> ...

> > I don't really think that Root Port support is required for a bridge below
> > a Root Port if that bridge itself is power-manageable via ACPI.  Moreover,
> > I don't think that the _S0W of a Root Port has any bearing on devices below
> > it that have their own _S0W.
> > 
> > So what we really want appears to be to evaluate _S0W for the target bridge,
> > regardless of whether or not it is a Root Port, and return 'false' if that
> > produces D2 or a shallower power state.  Otherwise, we can do what we've
> > done so far.

> +bool acpi_dev_no_wakeup_from_d3(struct acpi_device *adev)
> +{
> +	unsigned long long state;
> +	acpi_status status;
> +
> +	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
> +	return ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT;

This returns "false" (i.e., "yes, device can signal wakeup from D3")
if _S0W doesn't exist.  Is that right?

I think this might be less confusing as:

  bool acpi_dev_can_wake_from_d3(struct acpi_device *adev)
  {
    status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
    return ACPI_SUCCESS(status) && state >= ACPI_STATE_D3_HOT;
  }

That would look like this (including minor change to add "rp_adev" to
make it more obviously that it's different from "adev"):


diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 97450f4003cc..789a717d4819 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -484,6 +484,22 @@ void acpi_dev_power_up_children_with_adr(struct acpi_device *adev)
 	acpi_dev_for_each_child(adev, acpi_power_up_if_adr_present, NULL);
 }
 
+/**
+ * acpi_dev_can_wake_from_d3 - Check if wakeup signaling from D3 is supported
+ * @adev: ACPI companion of the target device.
+ *
+ * Evaluate _S0W for @adev and return 'true' if it is successful and the power
+ * state returned by it is D3hot or deeper.
+ */
+bool acpi_dev_can_wake_from_d3(struct acpi_device *adev)
+{
+	unsigned long long state;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
+	return ACPI_SUCCESS(status) && state >= ACPI_STATE_D3_HOT;
+}
+
 #ifdef CONFIG_PM
 static DEFINE_MUTEX(acpi_pm_notifier_lock);
 static DEFINE_MUTEX(acpi_pm_notifier_install_lock);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 068d6745bf98..03dbb57047be 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -976,24 +976,37 @@ bool acpi_pci_power_manageable(struct pci_dev *dev)
 bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	struct pci_dev *rpdev;
-	struct acpi_device *adev;
-	acpi_status status;
-	unsigned long long state;
+	struct acpi_device *adev, *rp_adev;
 	const union acpi_object *obj;
 
 	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
 		return false;
 
-	/* Assume D3 support if the bridge is power-manageable by ACPI. */
-	if (acpi_pci_power_manageable(dev))
-		return true;
+	adev = ACPI_COMPANION(&dev->dev);
+	if (adev) {
+		/*
+		 * If the bridge has _S0W, whether or not it can go into D3
+		 * depends on what is returned by that object.  In particular,
+		 * if the power state returned by _S0W is D2 or shallower,
+		 * entering D3 should not be allowed.
+		 */
+		if (!acpi_dev_can_wake_from_d3(adev))
+			return false;
+
+		/*
+		 * Otherwise, assume that the bridge can enter D3 so long as it
+		 * is power-manageable via ACPI.
+		 */
+		if (acpi_device_power_manageable(adev))
+			return true;
+	}
 
 	rpdev = pcie_find_root_port(dev);
 	if (!rpdev)
 		return false;
 
-	adev = ACPI_COMPANION(&rpdev->dev);
-	if (!adev)
+	rp_adev = (rpdev == dev) ? adev : ACPI_COMPANION(&rpdev->dev);
+	if (!rp_adev)
 		return false;
 
 	/*
@@ -1001,15 +1014,14 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	 * doesn't supply a wakeup GPE via _PRW, it cannot signal hotplug
 	 * events from low-power states including D3hot and D3cold.
 	 */
-	if (!adev->wakeup.flags.valid)
+	if (!rp_adev->wakeup.flags.valid)
 		return false;
 
 	/*
-	 * If the Root Port cannot wake itself from D3hot or D3cold, we
-	 * can't use D3.
+	 * In the bridge-below-a-Root-Port case, evaluate _S0W for the Root Port
+	 * to verify whether or not it can signal wakeup from D3.
 	 */
-	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
-	if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
+	if (rp_adev != adev && !acpi_dev_can_wake_from_d3(rp_adev))
 		return false;
 
 	/*
@@ -1018,7 +1030,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	 * bridges *below* that Root Port can also signal hotplug events
 	 * while in D3.
 	 */
-	if (!acpi_dev_get_property(adev, "HotPlugSupportInD3",
+	if (!acpi_dev_get_property(rp_adev, "HotPlugSupportInD3",
 				   ACPI_TYPE_INTEGER, &obj) &&
 	    obj->integer.value == 1)
 		return true;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index cd3b75e08ec3..0d0c6aa367e0 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -533,6 +533,7 @@ int acpi_bus_update_power(acpi_handle handle, int *state_p);
 int acpi_device_update_power(struct acpi_device *device, int *state_p);
 bool acpi_bus_power_manageable(acpi_handle handle);
 void acpi_dev_power_up_children_with_adr(struct acpi_device *adev);
+bool acpi_dev_can_wake_from_d3(struct acpi_device *adev);
 int acpi_device_power_add_dependent(struct acpi_device *adev,
 				    struct device *dev);
 void acpi_device_power_remove_dependent(struct acpi_device *adev,
