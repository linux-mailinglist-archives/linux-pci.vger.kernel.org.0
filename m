Return-Path: <linux-pci+bounces-4626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E288C8759DA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 23:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156712816E5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9ED13B78F;
	Thu,  7 Mar 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpJWeQmY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F701EF13;
	Thu,  7 Mar 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848881; cv=none; b=bU9b3uF2IKW6zupMp20Ig9hjn5FVC50y2VB2XN7lDOTXcv4EQvikT49GNRXiu1ienQNgrw1D6gZWa1WOV1rfMR3pHOWL6k6LspqpU1TY2BfXswVuLMbWjEEwvAV7ZR0WhIjTT21Tm+WqCKfd/iGmPhZcG2wULhyOlfYxniFcv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848881; c=relaxed/simple;
	bh=RS6YBoqtMAA1A1ME1P4u1SEKX8uOBDaQxzy6vFo9XpI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lyEsHjj4Nl9iNMm8BZ7GLFm81hQ38FyT7YUmKRkjFb+XTJJx6bTt4sp9yUXIKarVC0Vj4FiW3Bbk97bJtyVdYXrxt76dPlAZ9zeHRmmduSg2D+aWK5xUwi0KUW2lBEMcrGnv2jqE4Fim9qUgPUy/JEK2vil3cyF8mucjvIbMToo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpJWeQmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAABC433C7;
	Thu,  7 Mar 2024 22:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709848881;
	bh=RS6YBoqtMAA1A1ME1P4u1SEKX8uOBDaQxzy6vFo9XpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jpJWeQmYSteKUCLxDPtiZqArYbLfWixXtZGbBYhyXcQoHwV97HKLsZPGfXZb7nFk5
	 mVdubzntJNfQlNv3xdO3JLBaE+GnZDnTca82xUJEQpYTZoBNPKUzEYaY2uSeg3qM/O
	 kh+eDBx6b4yhKlWOjJ5MlwWOCpL9CZDiAWlHKU1lg3jFsDo5+yHCSxA4HVZBFRAMwT
	 MUIPR2OoKSkHA6TtUDDhwe0vklV0a86UiDhx4JYvcOy1hy7Q3iidqgUwf3mys+T1N/
	 OufqGoNM6PnRZOm9lfRGnHeoe6US/ehoaraRshIbGipFrsc4Kf3+wugzNxGHIuu+dS
	 eVZ+EdW0aEE5Q==
Date: Thu, 7 Mar 2024 16:01:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>
Cc: bhelgaas@google.com, macro@orcam.me.uk, ajayagarwal@google.com,
	ilpo.jarvinen@linux.intel.com, hkallweit1@gmail.com,
	johan+linaro@kernel.org, xueshuai@linux.alibaba.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI/ASPM: Update saved buffers with latest ASPM
Message-ID: <20240307220119.GA652393@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305220342.GA552530@bhelgaas>

On Tue, Mar 05, 2024 at 04:03:42PM -0600, Bjorn Helgaas wrote:
> [+to Sathy, David in case you want to update your Reviewed-by]
> 
> On Thu, Feb 22, 2024 at 11:14:36PM +0530, Vidya Sagar wrote:
> > Many PCIe device drivers save the configuration state of their respective
> > devices during probe and restore the same when their 'slot_reset' hook
> > is called through PCIe Error Recovery Handler.
> > 
> > If the system has a change in ASPM policy after the driver's probe is
> > called and before error event occurred, 'slot_reset' hook restores the
> > PCIe configuration state to what it was at the time of probe but not to
> > what it was just before the occurrence of the error event.
> > This effectively leads to a mismatch in the ASPM configuration between
> > the device and its upstream parent device.
> > 
> > Update the saved configuration state of the device with the latest info
> > whenever there is a change w.r.t ASPM policy.
> > 
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> 
> > -void pci_save_aspm_state(struct pci_dev *pdev);
> > +void pci_save_aspm_l1ss_state(struct pci_dev *pdev);
> 
> I rebased this again on top of my pci/aspm updates to remove the need
> for the rename above.
> 
> > +static void pci_save_aspm_state(struct pci_dev *dev)
> > +{
> > +	struct pci_cap_saved_state *save_state;
> > +	u16 *cap;
> > +
> > +	if (!pci_is_pcie(dev))
> > +		return;
> > +
> > +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> > +	if (!save_state)
> > +		return;
> > +
> > +	cap = (u16 *)&save_state->cap.data[0];
> > +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[1]);
> 
> And I changed this part so it only updates the PCI_EXP_LNKCTL_ASPMC
> bits, not the entire LNKCTL.
> 
> Updating the entire saved register probably wouldn't *break* anything,
> but it could randomly hide other LNKCTL changes depending on whether
> or not ASPM configuration was changed in the interim.  For example:
> 
>   - driver .probe() saves LNKCTL
>   - LNKCTL changes some non-ASPMC thing via setpci or other mechanism
>   - save_state updated via pcie_config_aspm_link()
> 
> A restore in .slot_reset() would restore different LNKCTL values for
> the non-ASPMC change depending on whether pcie_config_aspm_link() was
> used.

Oops, I blew it here.  I think it's good to limit the LNKCTL changes
we put in save_state, but PCI_EXP_LNKCTL_ASPMC is not enough.  We
should include PCI_EXP_LNKCTL_CLKREQ_EN as well since that may be
updated in many of the same paths that update PCI_EXP_LNKCTL_ASPMC.

I updated it to the patch at the bottom; here's the interdiff first:

-------------------------------------------------------------------------

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 46352132bb14..10160d82c10a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -304,18 +304,25 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
 static void pci_update_aspm_saved_state(struct pci_dev *dev)
 {
 	struct pci_cap_saved_state *save_state;
-	u16 *cap, lnkctl, aspmc;
+	u16 *cap, lnkctl, aspm_ctl;
 
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
 	if (!save_state)
 		return;
 
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
+
+	/*
+	 * Update ASPM and CLKREQ bits of LNKCTL in save_state. We only
+	 * write PCI_EXP_LNKCTL_CCC during enumeration, so it shouldn't
+	 * change after being captured in save_state.
+	 */
+	aspm_ctl = lnkctl & (PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
+	lnkctl &= ~(PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
+
 	/* Depends on pci_save_pcie_state(): cap[1] is LNKCTL */
 	cap = (u16 *)&save_state->cap.data[0];
-	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
-	aspmc = FIELD_GET(PCI_EXP_LNKCTL_ASPMC, lnkctl);
-	cap[1] = (lnkctl & ~PCI_EXP_LNKCTL_ASPMC) |
-		FIELD_PREP(PCI_EXP_LNKCTL_ASPMC, aspmc);
+	cap[1] = lnkctl | aspm_ctl;
 }
 
 static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)

-------------------------------------------------------------------------

And here's the entire patch:

commit ff92b9348534 ("PCI/ASPM: Update save_state when configuration changes")
Author: Vidya Sagar <vidyas@nvidia.com>
Date:   Fri Feb 23 13:36:24 2024 -0600

    PCI/ASPM: Update save_state when configuration changes
    
    Many PCIe device drivers save the configuration state of their device
    during probe and restore it when their .slot_reset() hook is called during
    PCIe error recovery.
    
    If the ASPM configuration is changed after the driver's probe is called and
    before an error event occurs, .slot_reset() restores the ASPM configuration
    to what it was at the time of probe, not to what it was just before the
    occurrence of the error event.  This leads to a mismatch in ASPM
    configuration between the device and its upstream device.
    
    Update the saved configuration of the device when the ASPM configuration
    changes.
    
    Link: https://lore.kernel.org/r/20240222174436.3565146-1-vidyas@nvidia.com
    Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
    [bhelgaas: commit log, rebase to pci/aspm, rename to
    pci_update_aspm_saved_state() since it updates only LNKCTL, update only
    ASPMC and CLKREQ_EN in LNKCTL]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
    Reviewed-by: David E. Box <david.e.box@linux.intel.com>


diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1379b8decdf1..10160d82c10a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -301,16 +301,42 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
 	return 0;
 }
 
+static void pci_update_aspm_saved_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	u16 *cap, lnkctl, aspm_ctl;
+
+	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
+	if (!save_state)
+		return;
+
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
+
+	/*
+	 * Update ASPM and CLKREQ bits of LNKCTL in save_state. We only
+	 * write PCI_EXP_LNKCTL_CCC during enumeration, so it shouldn't
+	 * change after being captured in save_state.
+	 */
+	aspm_ctl = lnkctl & (PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
+	lnkctl &= ~(PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
+
+	/* Depends on pci_save_pcie_state(): cap[1] is LNKCTL */
+	cap = (u16 *)&save_state->cap.data[0];
+	cap[1] = lnkctl | aspm_ctl;
+}
+
 static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 {
 	struct pci_dev *child;
 	struct pci_bus *linkbus = link->pdev->subordinate;
 	u32 val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
 
-	list_for_each_entry(child, &linkbus->devices, bus_list)
+	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
 						   PCI_EXP_LNKCTL_CLKREQ_EN,
 						   val);
+		pci_update_aspm_saved_state(child);
+	}
 	link->clkpm_enabled = !!enable;
 }
 
@@ -929,6 +955,12 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 		pcie_config_aspm_dev(parent, upstream);
 
 	link->aspm_enabled = state;
+
+	/* Update latest ASPM configuration in saved context */
+	pci_save_aspm_l1ss_state(link->downstream);
+	pci_update_aspm_saved_state(link->downstream);
+	pci_save_aspm_l1ss_state(parent);
+	pci_update_aspm_saved_state(parent);
 }
 
 static void pcie_config_aspm_path(struct pcie_link_state *link)

