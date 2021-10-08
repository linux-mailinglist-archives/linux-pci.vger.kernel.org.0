Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA4426C59
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 16:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhJHOHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 10:07:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63372 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhJHOHj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Oct 2021 10:07:39 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 21634131c65fd7fb; Fri, 8 Oct 2021 16:05:42 +0200
Received: from kreacher.localnet (unknown [213.134.175.153])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C102966A805;
        Fri,  8 Oct 2021 16:05:41 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     mario.limonciello@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: [PATCH] PCI: Put power resources not tied to a physical node in D3cold
Date:   Fri, 08 Oct 2021 16:05:40 +0200
Message-ID: <2211361.ElGaqSPkdT@kreacher>
In-Reply-To: <20211007205126.11769-1-mario.limonciello@amd.com>
References: <20211007205126.11769-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.153
X-CLIENT-HOSTNAME: 213.134.175.153
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddttddgieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeetgefgleetgeduheeugeeikeevudelueelvdeufeejfeffgeefjedugfetfeehhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddujeehrdduheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrudehfedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepvghrihhkrdhkrghn
 vggurgesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhgvlhesrggtphhitggrrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday, October 7, 2021 10:51:26 PM CEST Mario Limonciello wrote:
> I found a case that a system that two physical SATA controllers share
> the same ACPI Power Resource.  When a drive is connected to one of
> the controllers then it will bind with PCI devices with the ahci driver
> and form a relationship with the firmware node and physical node.  During
> s2idle I see that the constraints are met for this device as it is
> transitioned into the appropriate state. However the second ACPI node
> doesn't have any relationship with a physical node and stays in "D0":
> 
> ```
> ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
> ACPI: PM: Power resource [P0SA] still in use
> acpi device:2a: Power state changed to D3cold
> ```
> 
> Due to the refcounting used on the shared power resource putting the
> device with a physical node into D3 doesn't result in the _OFF method
> being called.
> 
> To help with this type of problem, make a new helper function that can
> be used to check all the children of an ACPI device and put any firmware
> nodes that don't have physical devices into D3cold to allow shared
> resources to transition. Call this helper function after PCI devices have
> been scanned and ACPI companions have had a chance to associate.
> 
> After making this change, here is what the flow looks like:
> ```
> <snip:bootup>
> ACPI: \_SB_.PCI0.GP18.SAT1: ACPI: PM: Power state change: D0 -> D3cold
> ACPI: PM: Power resource [P0SA] still in use
> acpi device:2c: Power state changed to D3cold
> <snip:suspend>
> ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
> ACPI: PM: Power resource [P0SA] turned off
> acpi device:2a: Power state changed to D3cold
> ```
> 
> Link: https://lore.kernel.org/linux-acpi/0571292a-286b-18f2-70ad-12b125a61469@amd.com/T/#m042055c5ca1e49c2829655511f04b0311c142559
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214091
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/device_pm.c | 34 ++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c      |  5 +++++
>  include/acpi/acpi_bus.h  |  1 +
>  3 files changed, 40 insertions(+)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 0028b6b51c87..0fb0bbeeae9e 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -149,6 +149,40 @@ static int acpi_dev_pm_explicit_set(struct acpi_device *adev, int state)
>  	return 0;
>  }
>  
> +/**
> + * acpi_device_turn_off_absent_children - Turn off power resources for
> + *					  children not physically present.
> + * @parent: ACPI bridge device
> + */
> +int acpi_device_turn_off_absent_children(struct acpi_device *parent)
> +{
> +	struct acpi_device *adev;
> +	int ret = 0;
> +
> +	if (!parent)
> +		return -EINVAL;
> +
> +	list_for_each_entry(adev, &parent->children, node) {

It is better to use device_for_each_child() for this, walking the children list
without locking is questionable.

> +		int state;
> +
> +		if (!adev->flags.power_manageable ||

This need not be checked, acpi_device_set_power() checks it.

> +		    !adev->power.flags.power_resources)

And I'm not sure about this too.  Even if there are no power resources, it
would be still prudent to release PM resources referred to by unused device
objects by calling _PS3 on them.

> +			continue;
> +		if (acpi_get_first_physical_node(adev))
> +			continue;

In addition to this, I would check if the device object has _ADR, because
there are legitimate cases when device objects with a _HID have no physical
nodes.

> +		ret = acpi_device_get_power(adev, &state);
> +		if (ret)
> +			return ret;
> +		if (state == ACPI_STATE_D3_COLD)
> +			continue;

The above is not necessary.

> +		ret = acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> +		if (ret)
> +			return ret;
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(acpi_device_turn_off_absent_children);

And I would put this function into glue.c.

> +
>  /**
>   * acpi_device_set_power - Set power state of an ACPI device.
>   * @device: Device to set the power state of.
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 79177ac37880..1a45182394d1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2939,6 +2939,11 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  		}
>  	}
>  
> +	/* check for and turn off dangling power resources */
> +	for_each_pci_bridge(dev, bus) {
> +		acpi_device_turn_off_absent_children(ACPI_COMPANION(&dev->dev));

IMO it would be better to call this from inside of the ACPI subsystem and
after scanning the entire bus.

> +	}
> +
>  	/*
>  	 * We've scanned the bus and so we know all about what's on
>  	 * the other side of any bridges that may be on this bus plus
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 13d93371790e..0eba08b60e13 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -510,6 +510,7 @@ int acpi_bus_get_status(struct acpi_device *device);
>  
>  int acpi_bus_set_power(acpi_handle handle, int state);
>  const char *acpi_power_state_string(int state);
> +int acpi_device_turn_off_absent_children(struct acpi_device *parent);
>  int acpi_device_set_power(struct acpi_device *device, int state);
>  int acpi_bus_init_power(struct acpi_device *device);
>  int acpi_device_fix_up_power(struct acpi_device *device);
> 

Overall, something like the appended patch might work.

Note that on my test-bed machine it makes no difference, though.

---
 drivers/acpi/glue.c     |   28 ++++++++++++++++++++++++++++
 drivers/acpi/internal.h |    2 ++
 drivers/acpi/pci_root.c |    1 +
 3 files changed, 31 insertions(+)

Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -350,3 +350,31 @@ void acpi_device_notify_remove(struct de
 
 	acpi_unbind_one(dev);
 }
+
+static int acpi_dev_turn_off_if_unused(struct device *dev, void *not_used)
+{
+	struct acpi_device *adev = to_acpi_device(dev);
+
+	acpi_dev_turn_off_unused_descendants(adev);
+
+	if (adev->pnp.type.bus_address && !acpi_get_first_physical_node(adev))
+		acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
+
+	return 0;
+}
+
+/**
+ * acpi_dev_turn_off_unused_descendants - Put unused descendants into D3cold.
+ * @adev: ACPI device object at the top of a branch of device hierarchy.
+ *
+ * Walk the branch of the hierarchy of ACPI device objects starting at @adev
+ * and put all of the objects in it that have _ADR and have no corresponding
+ * physical nodes into D3cold.
+ *
+ * This allows power resources that are only referred to by unused ACPI device
+ * objects to be turned off.
+ */
+void acpi_dev_turn_off_unused_descendants(struct acpi_device *adev)
+{
+	device_for_each_child(&adev->dev, NULL, acpi_dev_turn_off_if_unused);
+}
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -88,6 +88,8 @@ bool acpi_scan_is_offline(struct acpi_de
 acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
 void acpi_scan_table_notify(void);
 
+void acpi_dev_turn_off_unused_descendants(struct acpi_device *adev);
+
 /* --------------------------------------------------------------------------
                      Device Node Initialization / Removal
    -------------------------------------------------------------------------- */
Index: linux-pm/drivers/acpi/pci_root.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_root.c
+++ linux-pm/drivers/acpi/pci_root.c
@@ -630,6 +630,7 @@ static int acpi_pci_root_add(struct acpi
 
 	pci_lock_rescan_remove();
 	pci_bus_add_devices(root->bus);
+	acpi_dev_turn_off_unused_descendants(root->device);
 	pci_unlock_rescan_remove();
 	return 1;
 



