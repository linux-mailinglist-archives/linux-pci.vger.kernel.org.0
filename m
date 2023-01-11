Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368BC665927
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 11:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjAKKjC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 05:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjAKKjB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 05:39:01 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D135FAE;
        Wed, 11 Jan 2023 02:38:59 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id d11bdf500a244b40; Wed, 11 Jan 2023 11:38:57 +0100
Received: from kreacher.localnet (unknown [213.134.189.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 94D47262179E;
        Wed, 11 Jan 2023 11:38:56 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v3] PCI / ACPI: PM: Take _S0W of the target bridge into account in acpi_pci_bridge_d3(()
Date:   Wed, 11 Jan 2023 11:38:55 +0100
Message-ID: <5659681.DvuYhMxLoT@kreacher>
In-Reply-To: <8191575.T7Z3S40VBb@kreacher>
References: <20221121221742.GA137841@bhelgaas> <8191575.T7Z3S40VBb@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.189.3
X-CLIENT-HOSTNAME: 213.134.189.3
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrleeggdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddukeelrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekledrfedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepudefpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgt
 phhtthhopehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepufgrnhhjuhdrofgvhhhtrgesrghmugdrtghomhdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtoheprhgrfhgrvghlrdhjrdifhihsohgtkhhisehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=13 Fuz1=13 Fuz2=13
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is generally questionable to allow a PCI bridge to go into D3 if
it has _S0W returning D2 or a shallower power state, so modify
acpi_pci_bridge_d3(() to always take the return value of _S0W for the
target bridge into accout.  That is, make it return 'false' if _S0W
returns D2 or a shallower power state for the target bridge regardless
of its ancestor PCIe Root Port properties.  Of course, this also causes
'false' to be returned if the PCIe Root Port itself is the target and
its _S0W returns D2 or a shallower power state.

However, still allow bridges without _S0W that are power-manageable via
ACPI to enter D3 to retain the current code behavior in that case.

Link: https://lore.kernel.org/linux-pci/20221031223356.32570-1-mario.limonciello@amd.com/
Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Use rpadev for the ACPI companion of the Root Port in acpi_pci_bridge_d3(()
     to avoid confusion.
   * Make the function evaluating _S0W return the value produced by it or "unknown
     state" on errors and let its caller deal with that value.

---
 drivers/acpi/device_pm.c |   19 +++++++++++++++++++
 drivers/pci/pci-acpi.c   |   45 +++++++++++++++++++++++++++++++--------------
 include/acpi/acpi_bus.h  |    1 +
 3 files changed, 51 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -976,24 +976,41 @@ bool acpi_pci_power_manageable(struct pc
 bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	struct pci_dev *rpdev;
-	struct acpi_device *adev;
-	acpi_status status;
-	unsigned long long state;
+	struct acpi_device *adev, *rpadev;
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
+		if (acpi_dev_power_state_for_wake(adev) <= ACPI_STATE_D3_HOT)
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
+	if (rpdev == dev)
+		rpadev = adev;
+	else
+		rpadev = ACPI_COMPANION(&rpdev->dev);
+
+	if (!rpadev)
 		return false;
 
 	/*
@@ -1001,15 +1018,15 @@ bool acpi_pci_bridge_d3(struct pci_dev *
 	 * doesn't supply a wakeup GPE via _PRW, it cannot signal hotplug
 	 * events from low-power states including D3hot and D3cold.
 	 */
-	if (!adev->wakeup.flags.valid)
+	if (!rpadev->wakeup.flags.valid)
 		return false;
 
 	/*
-	 * If the Root Port cannot wake itself from D3hot or D3cold, we
-	 * can't use D3.
+	 * In the bridge-below-a-Root-Port case, evaluate _S0W for the Root Port
+	 * to verify whether or not it can signal wakeup from D3.
 	 */
-	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
-	if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
+	if (rpadev != adev &&
+	    acpi_dev_power_state_for_wake(rpadev) <= ACPI_STATE_D3_HOT)
 		return false;
 
 	/*
@@ -1018,7 +1035,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *
 	 * bridges *below* that Root Port can also signal hotplug events
 	 * while in D3.
 	 */
-	if (!acpi_dev_get_property(adev, "HotPlugSupportInD3",
+	if (!acpi_dev_get_property(rpadev, "HotPlugSupportInD3",
 				   ACPI_TYPE_INTEGER, &obj) &&
 	    obj->integer.value == 1)
 		return true;
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -484,6 +484,25 @@ void acpi_dev_power_up_children_with_adr
 	acpi_dev_for_each_child(adev, acpi_power_up_if_adr_present, NULL);
 }
 
+/**
+ * acpi_dev_power_state_for_wake - Deepest power state for wakeup signaling
+ * @adev: ACPI companion of the target device.
+ *
+ * Evaluate _S0W for @adev and return the value produced by it or return
+ * ACPI_STATE_UNKNOWN on errors (including _S0W not present).
+ */
+u8 acpi_dev_power_state_for_wake(struct acpi_device *adev)
+{
+	unsigned long long state;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
+	if (ACPI_FAILURE(status))
+		return ACPI_STATE_UNKNOWN;
+
+	return state;
+}
+
 #ifdef CONFIG_PM
 static DEFINE_MUTEX(acpi_pm_notifier_lock);
 static DEFINE_MUTEX(acpi_pm_notifier_install_lock);
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -533,6 +533,7 @@ int acpi_bus_update_power(acpi_handle ha
 int acpi_device_update_power(struct acpi_device *device, int *state_p);
 bool acpi_bus_power_manageable(acpi_handle handle);
 void acpi_dev_power_up_children_with_adr(struct acpi_device *adev);
+u8 acpi_dev_power_state_for_wake(struct acpi_device *adev);
 int acpi_device_power_add_dependent(struct acpi_device *adev,
 				    struct device *dev);
 void acpi_device_power_remove_dependent(struct acpi_device *adev,



