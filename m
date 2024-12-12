Return-Path: <linux-pci+bounces-18348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FBF9EFFC2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 00:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A4E168325
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 23:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389381AF0B4;
	Thu, 12 Dec 2024 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf9HzgX5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1361E493;
	Thu, 12 Dec 2024 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044622; cv=none; b=gi7aOzXIPHhWRhSVzujN6s9T/4JPCTDPKvQcpskYaRKOiiobhe6lwrmuGUYrpFMSkJW5wIPXkE1hSzTjwIVpHhRNEsGNTYtom9NapfrjNe838WdxbXlCHkkCzPEuPLXcM8muhoC7s6ZLG5yTqAfM0UdGJ6SrJBJsN3duYkqrUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044622; c=relaxed/simple;
	bh=yPk8uKKugJ6GC7AonBJQuaUBvHzwAG0kW4HbwfcGikg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KraLqchxHJuobnP8IK0hRhmk9orVnq8KX3JPfLsC2czsDa+6nzI21Sl4P/1Edubg+uxnu0RiBtgJ7DvBFaMrfa68bAHKl/zjZuYpjRNWZsrkzKggwD4lshJv5akbslahrtTQtF7mcdYveb4G23nM7guvVNzXNGpp9OAW8nWDfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf9HzgX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE91C4CECE;
	Thu, 12 Dec 2024 23:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734044621;
	bh=yPk8uKKugJ6GC7AonBJQuaUBvHzwAG0kW4HbwfcGikg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gf9HzgX5iwVnNYglbpy3jVk6r87o9MwxIHogGk4Q7hMMZ6vTNXwBvZzWyGavkRDoz
	 ZHHqkCsPNB6Kwrd2t/gX9Kc+F00lsm2LZ4yTOsx1JMZIY7SmpapDZOn3e4ioLz9LnM
	 +Vce/gSoCuUYq+RUPKdjd5wIDViOLFUN3Bn2TOq+vwfJN77b9ESZt9JP6nM5t3c8rC
	 16xpbDSmt5OrLlo3fGccGGZ20uTGbqUWLpp2gIs5h6rDfv2+IQdZXRR8Uy1deEILp9
	 zH240cEJGhGFfVAfo90DwCFNRu82tJBfCMpx9hsAVgHFkp1bqjAIuXYBLIZwYFByQK
	 ZltPHIUXsvgYg==
Date: Thu, 12 Dec 2024 17:03:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH v13] PCI/ASPM: Make pci_save_aspm_l1ss_state save both
 child and parent's L1SS configuration
Message-ID: <20241212230340.GA3267194@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115072200.37509-3-jhp@endlessos.org>

On Fri, Nov 15, 2024 at 03:22:02PM +0800, Jian-Hong Pan wrote:
> PCI devices' parameters on the VMD bus have been programmed properly
> originally. But, cleared after pci_reset_bus() and have not been restored
> correctly. This leads the link's L1.2 between PCIe Root Port and child
> device gets wrong configs.
> 
> Here is a failed example on ASUS B1400CEAE with enabled VMD. Both PCIe
> bridge and NVMe device should have the same LTR1.2_Threshold value.
> However, they are configured as different values in this case:
> 
> 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
>   ...
>   Capabilities: [200 v1] L1 PM Substates
>     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>       PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
>     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>       T_CommonMode=0us LTR1.2_Threshold=0ns
>     L1SubCtl2: T_PwrOn=0us
> 
> 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
>   ...
>   Capabilities: [900 v1] L1 PM Substates
>     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
>       PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>       T_CommonMode=0us LTR1.2_Threshold=101376ns
>     L1SubCtl2: T_PwrOn=50us
> 
>
> Here is VMD mapped PCI device tree:
> 
> -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
>  | ...
>  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
>               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
> 
> When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
> restores NVMe's state before and after reset. Then, when it restores the
> NVMe's state, ASPM code restores L1SS for both the parent bridge and the
> NVMe in pci_restore_aspm_l1ss_state(). The NVMe's L1SS is restored
> correctly. But, the parent bridge's L1SS is restored with a wrong value 0x0
> because the parent bridge's L1SS wasn't saved by pci_save_aspm_l1ss_state()
> before reset.

I think the important thing here is that currently
pci_save_aspm_l1ss_state() saves only the child L1SS state, but
pci_restore_aspm_l1ss_state() restores both parent and child, and the
parent state is garbage.

Obviously nothing specific to VMD or NVMe or SATA.

> To avoid pci_restore_aspm_l1ss_state() restore wrong value to the parent's
> L1SS config like this example, make pci_save_aspm_l1ss_state() save the
> parent's L1SS config, if the PCI device has a parent.

I tried to simplify the commit log and the patch so it's a little more
parallel with pci_restore_aspm_l1ss_state().  Please comment and test.

Bjorn

commit c93935e3ac92 ("PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()")
Author: Jian-Hong Pan <jhp@endlessos.org>
Date:   Fri Nov 15 15:22:02 2024 +0800

    PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()
    
    After 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
    suspend/resume"), pci_save_aspm_l1ss_state(dev) saves the L1SS state for
    "dev", and pci_restore_aspm_l1ss_state(dev) restores the state for both
    "dev" and its parent.
    
    The problem is that unless pci_save_state() has been used in some other
    path and has already saved the parent L1SS state, we will restore junk to
    the parent, which means the L1 Substates likely won't work correctly.
    
    Save the L1SS config for both the device and its parent in
    pci_save_aspm_l1ss_state().  When restoring, we need both because L1SS must
    be enabled at the parent (the Downstream Port) before being enabled at the
    child (the Upstream Port).
    
    Link: https://lore.kernel.org/r/20241115072200.37509-3-jhp@endlessos.org
    Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
    Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218394
    Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
    [bhelgaas: parallel save/restore structure, simplify commit log]


diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 28567d457613..e0bc90597dca 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -81,24 +81,47 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
 
 void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 {
+	struct pci_dev *parent = pdev->bus->self;
 	struct pci_cap_saved_state *save_state;
-	u16 l1ss = pdev->l1ss;
 	u32 *cap;
 
+	/*
+	 * If this is a Downstream Port, we never restore the L1SS state
+	 * directly; we only restore it when we restore the state of the
+	 * Upstream Port below it.
+	 */
+	if (pcie_downstream_port(pdev) || !parent)
+		return;
+
+	if (!pdev->l1ss || !parent->l1ss)
+		return;
+
 	/*
 	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
 	 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
 	 */
-	if (!l1ss)
-		return;
-
 	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
 	if (!save_state)
 		return;
 
 	cap = &save_state->cap.data[0];
-	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
-	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
+	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
+	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
+
+	if (parent->state_saved)
+		return;
+
+	/*
+	 * Save parent's L1 substate configuration so we have it for
+	 * pci_restore_aspm_l1ss_state(pdev) to restore.
+	 */
+	save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state)
+		return;
+
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, cap++);
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, cap++);
 }
 
 void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)

