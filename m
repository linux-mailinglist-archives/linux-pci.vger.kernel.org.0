Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3CE62E809
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 23:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiKQWRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 17:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbiKQWQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 17:16:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795927EBD6;
        Thu, 17 Nov 2022 14:16:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EEBBB821FA;
        Thu, 17 Nov 2022 22:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E69C433D7;
        Thu, 17 Nov 2022 22:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668723382;
        bh=sN7qOkymNn0SZ2E2s98QfM9f6lUJW4h/cq5V8IR6dy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VPKyJUC+xVE/V96N1fhM2Ml3GkVCJKRHUv6UAYkaQfPpQIArpplyTV5Rrr6OcWDq1
         qTcFJIgBQKHpwwTWZuN10jfvdPH1J+iE+MKBkxD35O0js5pIWGM+Ce9hMHJmok1WIA
         /7T84ojb3lkB4m1q7rM3qwlgWznyZMkq11k+OyZFTmqnqYZO6ENH3q4fDnhZO64a7k
         pUwSI6NvHZhrh8eM1LXTjWfzRaFucc9hfHO83P4JZwpLFFgK8I3nX5CfpdRsvYSATI
         lWCORbmKfUO8rzS9Obj5LgAMAMazsjcSKdptsKHnRN0KIJDDZ5ugGlbxwW3ZxAPwiJ
         RXKKtBmsYiuKg==
Date:   Thu, 17 Nov 2022 16:16:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
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
Message-ID: <20221117221621.GA1208852@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gX_ZEM60_4V-vn+uP+QqPEewwkpk8-PpnY28bUHgdFPw@mail.gmail.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_TRY_3LD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 17, 2022 at 06:01:26PM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 17, 2022 at 12:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Nov 16, 2022 at 01:00:36PM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Nov 16, 2022 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Mon, Nov 14, 2022 at 04:33:52PM +0100, Rafael J. Wysocki wrote:
> > > > > On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
> > > > > > > On 11/11/2022 11:41, Bjorn Helgaas wrote:
> > > > > > > > On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
> > > > > > > > > Firmware typically advertises that ACPI devices that represent PCIe
> > > > > > > > > devices can support D3 by a combination of the value returned by
> > > > > > > > > _S0W as well as the HotPlugSupportInD3 _DSD [1].
> > > > > > > > >
> > > > > > > > > `acpi_pci_bridge_d3` looks for this combination but also contains
> > > > > > > > > an assumption that if an ACPI device contains power resources the PCIe
> > > > > > > > > device it's associated with can support D3.  This was introduced
> > > > > > > > > from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> > > > > > > > > D3 if power managed by ACPI").
> > > > > > > > >
> > > > > > > > > Some firmware configurations for "AMD Pink Sardine" do not support
> > > > > > > > > wake from D3 in _S0W for the ACPI device representing the PCIe root
> > > > > > > > > port used for tunneling. The PCIe device will still be opted into
> > > > > > > > > runtime PM in the kernel [2] because of the logic within
> > > > > > > > > `acpi_pci_bridge_d3`. This currently happens because the ACPI
> > > > > > > > > device contains power resources.
> > > > > >
> > > > > > Wait.  Is this as simple as just recognizing that:
> > > > > >
> > > > > >   _PS0 means the OS has a knob to put the device in D0, but it doesn't
> > > > > >   mean the device can wake itself from a low-power state.  The OS has
> > > > > >   to use _S0W to learn the device's ability to wake itself.
> > > > >
> > > > > It is.
> > > >
> > > > Now I'm confused again about what "HotPlugSupportInD3" means.  The MS
> > > > web page [1] says it identifies Root Ports capable of handling hot
> > > > plug events while in D3.  That sounds kind of related to _S0W: If _S0W
> > > > says "I can wake myself from D3hot and D3cold", how is that different
> > > > from "I can handle hotplug events in D3"?
> > >
> > > For native PME/hot-plug signaling there is no difference.  This is the
> > > same interrupt by the spec after all IIRC.
> > >
> > > For GPE-based signaling, though, there is a difference, because GPEs
> > > can only be used directly for wake signaling (this is related to
> > > _PRW).  In particular, the only provision in the ACPI spec for device
> > > hot-add are the Bus Check and Device Check notification values (0 and
> > > 1) which require AML to run and evaluate Notify() on specific AML
> > > objects.
> > >
> > > Hence, there is no spec-defined way to tell the OS that "something can
> > > be hot-added under this device while in D3 and you will get notified
> > > about that".
> >
> > So I guess acpi_pci_bridge_d3() looks for:
> >
> >   - "wake signaling while in D3" (_S0W) and
> >   - "notification of hotplug while in D3" ("HotPlugSupportInD3")
> >
> > For Root Ports with both those abilities (or bridges below such Root
> > Ports), we allow D3, and this patch doesn't change that.
> >
> > What this patch *does* change is that all bridges with _PS0 or _PR0
> > previously could use D3, but now will only be able to use D3 if they
> > are also (or are below) a Root Port that can signal wakeup
> > (wakeup.flags.valid) and can wakeup from D3hot or D3cold (_S0W).
> >
> > And this fixes the Pink Sardine because it has Root Ports that do
> > Thunderbolt tunneling, and they have _PS0 or _PR0 but their _S0W says
> > they cannot wake from D3.  Previously we put those in D3, but they
> > couldn't wake up.  Now we won't put them in D3.
> >
> > I guess there's a possibility that this could break or cause higher
> > power consumption on systems that were fixed by c6e331312ebf
> > ("PCI/ACPI: Whitelist hotplug ports for D3 if power managed by ACPI").
> > I don't know enough about that scenario.  Maybe Lukas will chime in.
> 
> Well, it is possible that some of these systems will be affected.
> 
> One of such cases is when the port in question has _S0W which says
> that wakeup from D3 is not supported.  In that case I think the kernel
> should honor the _S0W input, because there may be a good reason known
> to the platform integrator for it.
> 
> The other case is when wakeup.flags.valid is unset for the port's ACPI
> companion which means that the port cannot signal wakeup through
> ACPI-related means at all and this may be problematic, especially in
> the system-wide suspend case in which the wakeup capability is not too
> relevant unless there is a system wakeup device under the port.
> 
> I don't think that the adev->wakeup.flags.valid check has any bearing
> on the _S0W check - if there is _S0W and it says "no wakeup from D3",
> it should still be taken into account - so that check can be moved
> past the _S0W check.

So if _S0W says it can wake from D3, but wakeup.flags is not valid,
it's still OK to use D3?  I guess in this case we assume wakeup would
be via native PME/hotplug signaling?

> Now, for compatibility with systems where ports have neither _S0W nor
> the HotPlugSupportInD3 property, the acpi_pci_power_manageable()
> return value should determine the outcome regardless of the
> adev->wakeup.flags.valid value, so the latter should only determine
> whether or not the HotPlugSupportInD3 property will be inspected
> (which may cause true to be returned before the "power manageable"
> check).
> 
> IOW, something like this (after checking _S0W):
> 
> if (adev->wakeup.flags.valid &&
>     !acpi_dev_get_property(adev, "HotPlugSupportInD3",
> ACPI_TYPE_INTEGER, &obj) &&
>     obj->integer.value == 1)
>         return true;
> 
> return acpi_pci_power_manageable(dev);
> 
> Where the if () condition basically means that wakeup signaling is
> supported (and there is no indication that it cannot be done from D3
> as per the previous _S0W check) and hotplug signaling from D3 is
> supported.
> 
> > > > This patch says that if dev's Root Port has "HotPlugSupportInD3", we
> > > > don't need _PS0 or _PR0 for dev.  I guess that must be true, because
> > > > previously the fact that we checked for "HotPlugSupportInD3" meant the
> > > > device did NOT have _PS0 or _PR0.
> > > >
> > > > [1] https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3

I think you're suggesting the patch below, which will make
acpi_pci_bridge_d3(dev) return "true" if:

  - Root Port can wake from D3hot or D3cold, has "HotPlugSupportInD3",
    and has wakeup.flags.valid, OR

  - Root Port can wake from D3hot or D3cold, and "dev" has _PR0 or
    _PS0

Previously, all bridges with _PR0 or _PS0 could use D3; now we also
require that the Root Port's _S0W says it can wake from at least
D3hot.

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a46fec776ad7..66c9ae1dc5da 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -984,10 +984,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
 		return false;
 
-	/* Assume D3 support if the bridge is power-manageable by ACPI. */
-	if (acpi_pci_power_manageable(dev))
-		return true;
-
 	rpdev = pcie_find_root_port(dev);
 	if (!rpdev)
 		return false;
@@ -996,14 +992,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	if (!adev)
 		return false;
 
-	/*
-	 * If the Root Port cannot signal wakeup signals at all, i.e., it
-	 * doesn't supply a wakeup GPE via _PRW, it cannot signal hotplug
-	 * events from low-power states including D3hot and D3cold.
-	 */
-	if (!adev->wakeup.flags.valid)
-		return false;
-
 	/*
 	 * If the Root Port cannot wake itself from D3hot or D3cold, we
 	 * can't use D3.
@@ -1014,16 +1002,21 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 
 	/*
 	 * The "HotPlugSupportInD3" property in a Root Port _DSD indicates
-	 * the Port can signal hotplug events while in D3.  We assume any
-	 * bridges *below* that Root Port can also signal hotplug events
-	 * while in D3.
+	 * the Port can signal hotplug events while in D3.  This differs
+	 * from _S0W because _S0W may rely on GPEs, which can only be used
+	 * directly for wake signaling, not hotplug events.
+	 *
+	 * We assume any bridges *below* that Root Port can also signal
+	 * hotplug events while in D3.
 	 */
-	if (!acpi_dev_get_property(adev, "HotPlugSupportInD3",
+	if (adev->wakeup.flags.valid &&
+	    !acpi_dev_get_property(adev, "HotPlugSupportInD3",
 				   ACPI_TYPE_INTEGER, &obj) &&
 	    obj->integer.value == 1)
 		return true;
 
-	return false;
+	/* Assume D3 support if the bridge is power-manageable by ACPI. */
+	return acpi_pci_power_manageable(dev);
 }
 
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
