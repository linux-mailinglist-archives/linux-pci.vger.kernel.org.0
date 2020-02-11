Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2957615866A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 01:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBKAIT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 19:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbgBKAIS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Feb 2020 19:08:18 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6FA220715;
        Tue, 11 Feb 2020 00:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581379698;
        bh=+3hiyGuKOYyaqXG4pIEL/1L3LLikzfXOz15j+Jhb6pM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ULwi5x7ggKtgzEzf7EHCkIEFJUx5je94d+AcEN7bFUkBdWJHASfoZODfJ8zuYDdw5
         psQNybyCNK+qFSp5SBPofHsotsJXkWqCCgEWz+gmLpGvv7RrCbmJoTOJS/QfsQfALF
         PAYTaaJIYdLeHEAffeYz+JvlLb+z09dTLHD9zM9g=
Date:   Mon, 10 Feb 2020 18:08:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH v4 0/3] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Message-ID: <20200211000816.GA89075@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025190047.38130-1-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Libor (thanks for the ping!)]

On Fri, Oct 25, 2019 at 03:00:44PM -0400, Stuart Hayes wrote:
> In older PCIe specs, PDS (presence detect) would come up when the
> "in-band" presence detect pin connected, and would be up before DLLLA
> (link active).
> 
> In PCIe 4.0 (as an ECN) and in PCIe 5.0, there is a new bit to show if
> in-band presence detection can be disabled for the slot, and another bit
> that disables it--and a recommendation that it should be disabled if it
> can be. In addition, certain OEMs disable in-band presence detection
> without implementing these bits.
> 
> This means it is possible to get a "card present" interrupt after the
> link is up and the driver is loaded.  This causes an erroneous removal
> of the device driver, followed by an immediate re-probing.
> 
> This patch set defines these new bits, uses them to disable in-band
> presence detection if it can be, waits for PDS to go up if in-band
> presence detection is disabled, and adds a DMI table that will let us
> know if we should assume in-band presence is disabled on a system.
> 
> The first two patches in this set come from a patch set that was
> submitted but not accepted many months ago by Alexandru Gagniuc [1].
> The first is unmodified, the second has the commit message and timeout 
> modified.
> 
> [1] https://patchwork.kernel.org/cover/10909167/
>     [v3,0/4] PCI: pciehp: Do not turn off slot if presence comes up after link
> 
> v2:
> - modify loop in pcie_wait_for_presence to do..while
> 
> v3:
> - remove unused variable declaration
> - modify text of warning message
> 
> v4:
> - remove "!!" boolean conversion in an "if" condition for readability
> - add explanation comment in dmi table
> 
> Alexandru Gagniuc (2):
>   PCI: pciehp: Add support for disabling in-band presence
>   PCI: pciehp: Wait for PDS if in-band presence is disabled
> 
> Stuart Hayes (1):
>   PCI: pciehp: Add dmi table for in-band presence disabled
> 
>  drivers/pci/hotplug/pciehp.h     |  1 +
>  drivers/pci/hotplug/pciehp_hpc.c | 50 +++++++++++++++++++++++++++++++-
>  include/uapi/linux/pci_regs.h    |  2 ++
>  3 files changed, 52 insertions(+), 1 deletion(-)

I added the spec reference to the 1/3 commit log, tried to make the
tweaks Lukas suggested (interdiff below), used ctrl_info() instead of
pci_info() (I would actually like to change the whole driver to use
pci_info(), but better to be consistent for now), and applied to
pci/hotplug for v5.7.

Somebody should also update lspci to:

  - Do something with DevCap AttnBtn, AttnInd, PwrInd to indicate that
    they were only defined for PCIe r1.0 and have been explicitly
    undefined since then.  If there's a way to identify those 1.0
    devices and only decode those fields for 1.0, that would be nice.

  - Add SltCap2 and SltCtrl2 decoding.

Speak up if you plan to do this so we don't duplicate effort.

Bjorn

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index ae0108b92084..469873b44a8e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -284,7 +284,7 @@ static void pcie_wait_for_presence(struct pci_dev *pdev)
 		timeout -= 10;
 	} while (timeout > 0);
 
-	pci_info(pdev, "Timeout waiting for Presence Detect state to be set\n");
+	ctrl_info(ctrl, "Timeout waiting for Presence Detect\n");
 }
 
 int pciehp_check_link_status(struct controller *ctrl)
@@ -921,6 +921,16 @@ struct controller *pcie_init(struct pcie_device *dev)
 	ctrl->state = list_empty(&subordinate->devices) ? OFF_STATE : ON_STATE;
 	up_read(&pci_bus_sem);
 
+	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP2, &slot_cap2);
+	if (slot_cap2 & PCI_EXP_SLTCAP2_IBPD) {
+		pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_IBPD_DISABLE,
+				      PCI_EXP_SLTCTL_IBPD_DISABLE);
+		ctrl->inband_presence_disabled = 1;
+	}
+
+	if (dmi_first_match(inband_presence_disabled_dmi_table))
+		ctrl->inband_presence_disabled = 1;
+
 	/* Check if Data Link Layer Link Active Reporting is implemented */
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
 
@@ -930,7 +940,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_CC |
 		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
 
-	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c%s\n",
+	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c IbPresDis%c LLActRep%c%s\n",
 		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
 		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
@@ -941,19 +951,10 @@ struct controller *pcie_init(struct pcie_device *dev)
 		FLAG(slot_cap, PCI_EXP_SLTCAP_HPS),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_EIP),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_NCCS),
+		ctrl->inband_presence_disabled,
 		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
 		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
 
-	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP2, &slot_cap2);
-	if (slot_cap2 & PCI_EXP_SLTCAP2_IBPD) {
-		pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_IBPD_DISABLE,
-				      PCI_EXP_SLTCTL_IBPD_DISABLE);
-		ctrl->inband_presence_disabled = 1;
-	}
-
-	if (dmi_first_match(inband_presence_disabled_dmi_table))
-		ctrl->inband_presence_disabled = 1;
-
 	/*
 	 * If empty slot's power status is on, turn power off.  The IRQ isn't
 	 * requested yet, so avoid triggering a notification with this command.
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index b464d2f76513..f9701410d3b5 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -681,7 +681,7 @@
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
-#define  PCI_EXP_SLTCAP2_IBPD	0x0001	/* In-band PD Disable Supported */
+#define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */
 #define PCI_EXP_SLTCTL2		56	/* Slot Control 2 */
 #define PCI_EXP_SLTSTA2		58	/* Slot Status 2 */
 
