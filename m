Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C965B56D
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jan 2023 17:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjABQ7t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Jan 2023 11:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjABQ7m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jan 2023 11:59:42 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F257111B;
        Mon,  2 Jan 2023 08:59:40 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 79207faae1a7715a; Mon, 2 Jan 2023 17:59:38 +0100
Received: from kreacher.localnet (unknown [213.134.163.167])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AA44A28C0089;
        Mon,  2 Jan 2023 17:59:37 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power resources support D3
Date:   Mon, 02 Jan 2023 17:59:36 +0100
Message-ID: <1945994.PYKUYFuaPT@kreacher>
In-Reply-To: <8191575.T7Z3S40VBb@kreacher>
References: <20221121221742.GA137841@bhelgaas> <8191575.T7Z3S40VBb@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.167
X-CLIENT-HOSTNAME: 213.134.163.167
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrjedvgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudeifedrudeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrdduieejpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdp
 rhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepufgrnhhjuhdrofgvhhhtrgesrghmugdrtghomhdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtoheprhgrfhgrvghlrdhjrdifhihsohgtkhhisehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, January 2, 2023 5:34:19 PM CET Rafael J. Wysocki wrote:
> On Monday, November 21, 2022 11:17:42 PM CET Bjorn Helgaas wrote:
> > On Mon, Nov 21, 2022 at 03:33:00PM +0100, Rafael J. Wysocki wrote:
> > > On Friday, November 18, 2022 10:13:39 PM CET Rafael J. Wysocki wrote:
> > > > On Fri, Nov 18, 2022 at 9:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > >
> > > > > Hi Rafael,
> > > > >
> > > > > Sorry, I'm still confused (my perpetual state :)).
> > > > 
> > > > No worries, doing my best to address that.
> > > > 
> > > > > On Fri, Nov 18, 2022 at 02:16:17PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Thu, Nov 17, 2022 at 11:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > On Thu, Nov 17, 2022 at 06:01:26PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > On Thu, Nov 17, 2022 at 12:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > On Wed, Nov 16, 2022 at 01:00:36PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > > > On Wed, Nov 16, 2022 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > > > On Mon, Nov 14, 2022 at 04:33:52PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > > > > > On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
> > > > > > > > > > > > > > On 11/11/2022 11:41, Bjorn Helgaas wrote:
> > > > > > > > > > > > > > > On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
> > > > > > > > > > > > > > > > Firmware typically advertises that ACPI devices that represent PCIe
> > > > > > > > > > > > > > > > devices can support D3 by a combination of the value returned by
> > > > > > > > > > > > > > > > _S0W as well as the HotPlugSupportInD3 _DSD [1].
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > `acpi_pci_bridge_d3` looks for this combination but also contains
> > > > > > > > > > > > > > > > an assumption that if an ACPI device contains power resources the PCIe
> > > > > > > > > > > > > > > > device it's associated with can support D3.  This was introduced
> > > > > > > > > > > > > > > > from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> > > > > > > > > > > > > > > > D3 if power managed by ACPI").
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Some firmware configurations for "AMD Pink Sardine" do not support
> > > > > > > > > > > > > > > > wake from D3 in _S0W for the ACPI device representing the PCIe root
> > > > > > > > > > > > > > > > port used for tunneling. The PCIe device will still be opted into
> > > > > > > > > > > > > > > > runtime PM in the kernel [2] because of the logic within
> > > > > > > > > > > > > > > > `acpi_pci_bridge_d3`. This currently happens because the ACPI
> > > > > > > > > > > > > > > > device contains power resources.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Wait.  Is this as simple as just recognizing that:
> > > > > > > > > > > > >
> > > > > > > > > > > > >   _PS0 means the OS has a knob to put the device in D0, but it doesn't
> > > > > > > > > > > > >   mean the device can wake itself from a low-power state.  The OS has
> > > > > > > > > > > > >   to use _S0W to learn the device's ability to wake itself.
> > > > > > > > > > > >
> > > > > > > > > > > > It is.
> > > > > > > > > > >
> > > > > > > > > > > Now I'm confused again about what "HotPlugSupportInD3" means.  The MS
> > > > > > > > > > > web page [1] says it identifies Root Ports capable of handling hot
> > > > > > > > > > > plug events while in D3.  That sounds kind of related to _S0W: If _S0W
> > > > > > > > > > > says "I can wake myself from D3hot and D3cold", how is that different
> > > > > > > > > > > from "I can handle hotplug events in D3"?
> > > > > > > > > >
> > > > > > > > > > For native PME/hot-plug signaling there is no difference.  This is the
> > > > > > > > > > same interrupt by the spec after all IIRC.
> > > > > > > > > >
> > > > > > > > > > For GPE-based signaling, though, there is a difference, because GPEs
> > > > > > > > > > can only be used directly for wake signaling (this is related to
> > > > > > > > > > _PRW).  In particular, the only provision in the ACPI spec for device
> > > > > > > > > > hot-add are the Bus Check and Device Check notification values (0 and
> > > > > > > > > > 1) which require AML to run and evaluate Notify() on specific AML
> > > > > > > > > > objects.
> > > > > > > > > >
> > > > > > > > > > Hence, there is no spec-defined way to tell the OS that "something can
> > > > > > > > > > be hot-added under this device while in D3 and you will get notified
> > > > > > > > > > about that".
> > > > > > > > >
> > > > > > > > > So I guess acpi_pci_bridge_d3() looks for:
> > > > > > > > >
> > > > > > > > >   - "wake signaling while in D3" (_S0W) and
> > > > > > > > >   - "notification of hotplug while in D3" ("HotPlugSupportInD3")
> > > > > > > > >
> > > > > > > > > For Root Ports with both those abilities (or bridges below such Root
> > > > > > > > > Ports), we allow D3, and this patch doesn't change that.
> > > > > > > > >
> > > > > > > > > What this patch *does* change is that all bridges with _PS0 or _PR0
> > > > > > > > > previously could use D3, but now will only be able to use D3 if they
> > > > > > > > > are also (or are below) a Root Port that can signal wakeup
> > > > > > > > > (wakeup.flags.valid) and can wakeup from D3hot or D3cold (_S0W).
> > > > > > > > >
> > > > > > > > > And this fixes the Pink Sardine because it has Root Ports that do
> > > > > > > > > Thunderbolt tunneling, and they have _PS0 or _PR0 but their _S0W says
> > > > > > > > > they cannot wake from D3.  Previously we put those in D3, but they
> > > > > > > > > couldn't wake up.  Now we won't put them in D3.
> > > > > > > > >
> > > > > > > > > I guess there's a possibility that this could break or cause higher
> > > > > > > > > power consumption on systems that were fixed by c6e331312ebf
> > > > > > > > > ("PCI/ACPI: Whitelist hotplug ports for D3 if power managed by ACPI").
> > > > > > > > > I don't know enough about that scenario.  Maybe Lukas will chime in.
> > > > > > > >
> > > > > > > > Well, it is possible that some of these systems will be affected.
> > > > > > > >
> > > > > > > > One of such cases is when the port in question has _S0W which says
> > > > > > > > that wakeup from D3 is not supported.  In that case I think the kernel
> > > > > > > > should honor the _S0W input, because there may be a good reason known
> > > > > > > > to the platform integrator for it.
> > > > > > > >
> > > > > > > > The other case is when wakeup.flags.valid is unset for the port's ACPI
> > > > > > > > companion which means that the port cannot signal wakeup through
> > > > > > > > ACPI-related means at all and this may be problematic, especially in
> > > > > > > > the system-wide suspend case in which the wakeup capability is not too
> > > > > > > > relevant unless there is a system wakeup device under the port.
> > > > > > > >
> > > > > > > > I don't think that the adev->wakeup.flags.valid check has any bearing
> > > > > > > > on the _S0W check - if there is _S0W and it says "no wakeup from D3",
> > > > > > > > it should still be taken into account - so that check can be moved
> > > > > > > > past the _S0W check.
> > > > > > >
> > > > > > > So if _S0W says it can wake from D3, but wakeup.flags is not valid,
> > > > > > > it's still OK to use D3?
> > > > > >
> > > > > > No, it isn't, as per the code today and I don't think that this
> > > > > > particular part should be changed now.
> > > > >
> > > > > But the current upstream code checks acpi_pci_power_manageable(dev)
> > > > > first, so if "dev" has _PR0 or _PS0, we'll use D3 even if _S0W says it
> > > > > can wake from D3 and wakeup.flags is not valid.
> > > > 
> > > > Yes, the current code will return 'true' if _PR0 or _PS0 is present
> > > > for dev regardless of anything else.
> > > > 
> > > > The proposed change is to make that conditional on whether or not _S0W
> > > > for the root port says that wakeup from D3 is supported (or it is not
> > > > present or unusable).
> > > > 
> > > > I see that I've missed one point now which is when the root port
> > > > doesn't have an ACPI companion, in which case we should go straight
> > > > for the "dev is power manageable" check.
> > > 
> > > Moreover, it is possible that the bridge passed to acpi_pci_bridge_d3() has its
> > > own _S0W or a wakeup GPE if it is power-manageable via ACPI.  In those cases
> > > it is not necessary to ask the Root Port's _S0W about wakeup from D3, so overall
> > > I would go for the patch like the below (not really tested).
> > > 
> > > This works in the same way as the current code (unless I have missed anything)
> > > except for the case when the "target" bridge is power-manageable via ACPI, but
> > > it cannot signal wakeup via ACPI and has no _S0W.  In that case it will consult
> > > the upstream Root Port's _S0W to check whether or not wakeup from D3 is
> > > supported.
> > > 
> > > [Note that if dev_has_acpi_pm is 'true', it is kind of pointless to look for the
> > > "HotPlugSupportInD3" property of the Root Port, because the function is going to
> > > return 'true' regardless, but I'm not sure if adding an extra if () for handling
> > > this particular case is worth the hassle.]
> > 
> > I think this has a lot of potential.  I haven't tried it, but I wonder
> > if splitting out the Root Port-specific parts to a separate function
> > would be helpful, if only to make it more obvious that there may be
> > two different devices involved.
> > 
> > If there are two devices ("dev" is a bridge below a Root Port), I
> > guess support in the Root Port is not necessarily required?  E.g.,
> > could "dev" assert a wakeup GPE that's not routed through the Root
> > Port?  If Root Port support *is* required, maybe it would read more
> > clearly to test that first, before looking at the downstream device.
> 
> Sorry for the delay.
> 
> I don't really think that Root Port support is required for a bridge below
> a Root Port if that bridge itself is power-manageable via ACPI.  Moreover,
> I don't think that the _S0W of a Root Port has any bearing on devices below
> it that have their own _S0W.
> 
> So what we really want appears to be to evaluate _S0W for the target bridge,
> regardless of whether or not it is a Root Port, and return 'false' if that
> produces D2 or a shallower power state.  Otherwise, we can do what we've
> done so far.
> 
> The patch below implements, this - please let me know what you think.
> 

And here's a v2 with somewhat less code duplication.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] PCI / ACPI: PM: Take _S0W of the target bridge into account in acpi_pci_bridge_d3(()

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

Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |   16 ++++++++++++++++
 drivers/pci/pci-acpi.c   |   34 ++++++++++++++++++++++++----------
 include/acpi/acpi_bus.h  |    1 +
 3 files changed, 41 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -977,22 +977,37 @@ bool acpi_pci_bridge_d3(struct pci_dev *
 {
 	struct pci_dev *rpdev;
 	struct acpi_device *adev;
-	acpi_status status;
-	unsigned long long state;
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
+		if (acpi_dev_no_wakeup_from_d3(adev))
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
+	if (rpdev != dev)
+		adev = ACPI_COMPANION(&rpdev->dev);
+
 	if (!adev)
 		return false;
 
@@ -1005,11 +1020,10 @@ bool acpi_pci_bridge_d3(struct pci_dev *
 		return false;
 
 	/*
-	 * If the Root Port cannot wake itself from D3hot or D3cold, we
-	 * can't use D3.
+	 * In the bridge-below-a-Root-Port case, evaluate _S0W for the Root Port
+	 * to verify whether or not it can signal wakeup from D3.
 	 */
-	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
-	if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
+	if (rpdev != dev && acpi_dev_no_wakeup_from_d3(adev))
 		return false;
 
 	/*
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -484,6 +484,22 @@ void acpi_dev_power_up_children_with_adr
 	acpi_dev_for_each_child(adev, acpi_power_up_if_adr_present, NULL);
 }
 
+/**
+ * acpi_dev_no_wakeup_from_d3 - Check if wakeup signaling from D3 is supported
+ * @adev: ACPI companion of the target device.
+ *
+ * Evaluate _S0W for @adev and return 'true' if it is successful and the power
+ * state returned by it is D2 or shallower.
+ */
+bool acpi_dev_no_wakeup_from_d3(struct acpi_device *adev)
+{
+	unsigned long long state;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
+	return ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT;
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
+bool acpi_dev_no_wakeup_from_d3(struct acpi_device *adev);
 int acpi_device_power_add_dependent(struct acpi_device *adev,
 				    struct device *dev);
 void acpi_device_power_remove_dependent(struct acpi_device *adev,



