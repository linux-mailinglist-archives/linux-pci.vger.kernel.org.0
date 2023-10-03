Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CA97B7198
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 21:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240912AbjJCTQa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbjJCTQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 15:16:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA29E;
        Tue,  3 Oct 2023 12:16:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AA2C433C8;
        Tue,  3 Oct 2023 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696360584;
        bh=QWfjoEuOcSejyUMP+e0H+hvaaH69zJE/DIQodk4Whhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p0EOTWoUEx+hgx946iv1fPpk6S3ioK1PaS1CG7dcODFiEVixgxHz8ae8PHTgRg2VC
         tNzP5AfjG4OLtcto4K0dYeVvGJVHzsDPFeWR/OPbxKgAB1jr+ghA77q5aQIYb19xiW
         gtYU2fQjPa+w6eDgmPnAvXrCWmu7S8bOsEv2gu5S9fRYbdM4kzVNkztB54GkYJNh78
         WfoxwMpNHDmuzS8XS2lE1hrEPyK8xTDE3X2dgoT4QjeHELRDpmyTl9LG66BY2GUBai
         ufem3TXR4MVcmIxu2xOllnPu+9gR3FwVBAerTWk5oZOyaAlmav0MGvZKg+XtoEH6N+
         CaV4gswmFnHxQ==
Date:   Tue, 3 Oct 2023 14:16:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
Subject: Re: [PATCH v21] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Message-ID: <20231003191622.GA682654@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac574884-7568-46c9-87ba-f1555ffe34fa@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 03, 2023 at 01:37:34PM -0500, Mario Limonciello wrote:
> On 10/3/2023 13:31, Bjorn Helgaas wrote:
> > On Tue, Oct 03, 2023 at 01:06:48PM -0500, Mario Limonciello wrote:
> > > On 10/3/2023 12:24, Bjorn Helgaas wrote:
> > > > On Mon, Oct 02, 2023 at 01:09:06PM -0500, Mario Limonciello wrote:
> > > > > Iain reports that USB devices can't be used to wake a Lenovo Z13 from
> > > > > suspend.  This occurs because on some AMD platforms, even though the Root
> > > > > Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
> > > > > messages and generate wakeup interrupts from those states when amd-pmc has
> > > > > put the platform in a hardware sleep state.
> > > > ...
> > 
> > > > Two questions:
> > > > 
> > > >     - PME also doesn't work in D3hot, right?
> > > 
> > > Right.
> > > 
> > > IMO pci_d3cold_*() is poorly named.
> > > It's going to prevent D3 on the bridge.
> > 
> > I agree, that name is super irritating.  I don't even know how to
> > figure out or verify that pci_d3cold_disable() also disables D3hot.
> > 
> > > >     - Is it OK to use D3hot and D3cold if we don't have a wakeup device
> > > >       below the Root Port?  I assume that scenario is possible?
> > > 
> > > Yes; it's "fine to do that" if there is no wakeup device below the
> > > root port.
> > > 
> > > If a user intentionally turns off power/wakeup for the child devices
> > > (which as said before was USB4 and XHCI PCIe devices) then wakeup
> > > won't be set.
> > > 
> > > So in this case as the quirk is implemented I expect the root port
> > > will be left in D0 even if a user intentionally turns off
> > > power/wakeup for the USB4 and XHCI devices.
> > 
> > Even if users don't intentionally turn off wakeup, there are devices
> > like mass storage and NICs without wake-on-LAN that don't require
> > wakeup.
> > 
> > I assume that if there's no downstream device that needs wakeup, this
> > quirk means we will keep the Root Port in D0 even though we could
> > safely put it in D3hot or D3cold.
> 
> Yes that matches my expectation as well.
> 
> > That's one thing I liked about the v20 iteration -- instead of
> > pci_d3cold_disable(), we changed dev->pme_support, which should mean
> > that we only avoid D3hot/D3cold if we need PMEs while in those states,
> > so I assumed that we *could* use D3 when we don't need the wakeups.
> 
> If you think it's worth spinning again for this optimization I think a
> device_may_wakeup() check on the root port can achieve the same result as
> the v20 PME solution did, but without the walking of a tree in the quirk.

Why would we use device_may_wakeup() here?  That seems like too much
assumption about the suspend path, and we already have the Root Port
pci_dev, so rp->pme_support is available.  What about something like
this:

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..4b601b1c0830 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6188,3 +6188,60 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
+
+#ifdef CONFIG_SUSPEND
+/*
+ * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
+ * if the SoC is put into a hardware sleep state by the amd-pmc driver, the
+ * Root Ports don't generate wakeup interrupts for USB devices.
+ *
+ * When suspending, remove D3hot and D3cold from the PME_Support advertised
+ * by the Root Port so we don't use those states if we're expecting wakeup
+ * interrupts.  Restore the advertised PME_Support when resuming.
+ */
+static void amd_rp_pme_suspend(struct pci_dev *dev)
+{
+	struct pci_dev *rp;
+
+	/*
+	 * PM_SUSPEND_ON means we're doing runtime suspend, which means
+	 * amd-pmc will not be involved so PMEs during D3 work as advertised.
+	 *
+	 * The PMEs *do* work if amd-pmc doesn't put the SoC in the hardware
+	 * sleep state, but we assume amd-pmc is always present.
+	 */
+	if (pm_suspend_target_state == PM_SUSPEND_ON)
+		return;
+
+	rp = pcie_find_root_port(dev);
+	if (!rp->pm_cap)
+		return;
+
+	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
+				    PCI_PM_CAP_PME_SHIFT);
+	dev_info_once(&rp->dev, "quirk: disabling D3cold for suspend\n");
+}
+
+static void amd_rp_pme_resume(struct pci_dev *dev)
+{
+	struct pci_dev *rp;
+	u16 pmc;
+
+	rp = pcie_find_root_port(dev);
+	if (!rp->pm_cap)
+		return;
+
+	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
+	rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
+}
+/* Rembrandt (yellow_carp) */
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162e, amd_rp_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162e, amd_rp_pme_resume);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162f, amd_rp_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162f, amd_rp_pme_resume);
+/* Phoenix (pink_sardine) */
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_resume);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_resume);
+#endif /* CONFIG_SUSPEND */
