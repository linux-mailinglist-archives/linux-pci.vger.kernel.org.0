Return-Path: <linux-pci+bounces-40434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EFAC3825C
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 23:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D201A205D0
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 22:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0032EF65F;
	Wed,  5 Nov 2025 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwmyqx6m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B92EE5FE;
	Wed,  5 Nov 2025 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380567; cv=none; b=m5zh77xDG8+VfFciiCZ2JiaIaSO8Z4bOKwq/SO1BuepB/FD0h2CwbpLtCwSMEIpUc2s8a3sBY4jkt8zB0GG6vDCN5z99qMJE7JTgS1GO+yK677UYQq6nGoC86FjEiBjPuNh5YCuS+sYFnplpyUzX2J4Q7IFGVtR1PewT4klJ9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380567; c=relaxed/simple;
	bh=Kdf3RStyU+2pisw35rSsTNL9OxNIVbABNhD8/Es6/rE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d8L/e6Vqk3cNN4JSZgWwVJwcqOx4iYoBlCIQAoWWFliSmP2CgxxmE4SZQoAYO0PO8qt1OErn4XDCff0a0ecuvAJ8Kqdm9yhdT+ICweUIbVbtmcTQumuNCpmQZ39vp1a7Uon1kKmY4c+onE1QQ1pcjKv8JnwR/gomJYl8JvDP6zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hwmyqx6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A001AC4CEF5;
	Wed,  5 Nov 2025 22:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762380566;
	bh=Kdf3RStyU+2pisw35rSsTNL9OxNIVbABNhD8/Es6/rE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Hwmyqx6m2A0p60xFJl3/+xrDi1Fztj/nvdOhoGCSlQ2kNgmuRG+hnotQCZAIt2PHk
	 oJGgfv2Y0IVzB0ZeuKS2s+K64kEEsg+dM4pdkNj3TclQEoqslefWMMTab1jorgQd90
	 ibI//FLxMeWaLwBhadwJxtJNrgoiuPB3ELC9aO+mUDqEtLVWTYRi6W6fGt/bprizFV
	 fFlGALu2rK8QHimGRVcx/J5kR8sTQMg2pnDXAXioHNS03gqzodngmpjvw/ks1Z7m5n
	 xP7h/MjTJYGbgBnOSeK9e6+MdrgYgpILimykfD1zfxXvmqkAOpA2bzGhwa5kkhB54v
	 WYoHWhadu7siQ==
Date: Wed, 5 Nov 2025 16:09:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	mad skateman <madskateman@gmail.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	Christian Zigotzky <info@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>,
	debian-powerpc@lists.debian.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>, regressions@lists.linux.dev,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Roland <rol7and@gmx.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251105220925.GA1926619@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d93eac4d-b382-97dd-d829-98aef6695204@xenosoft.de>

[+cc luigi, Al, Roland; we broke X5000 in v6.18-rc1 by enabling ASPM
too aggressively; Christian's original report is at:
https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de
I grubbed around in lore for other X5000 users who might possibly be
able to help test our attempts to fix it]

On Mon, Nov 03, 2025 at 07:28:19PM +0100, Christian Zigotzky wrote:
> On 11/01/2025 06:06 PM, Manivannan Sadhasivam wrote:
> ...

> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index d97335a40193..74d8596b3f62 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev
> *dev)
> >   * disable both L0s and L1 for now to be safe.
> >   */
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080,
> quirk_disable_aspm_l0s_l1);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, 0x0451,
> quirk_disable_aspm_l0s_l1);
> >
> >  /*
> >   * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain

> I tested your patch with the RC4 of kernel 6.18 today. Unfortunately it
> doesn't solve the boot issue.

Thanks for testing that.  I see now why that approach doesn't work:
quirk_disable_aspm_l0s_l1() calls pci_disable_link_state(), which
updates the permissible ASPM link states, but pci_disable_link_state()
only works for devices at the downstream end of a link.  It doesn't
work at all for Root Ports, which are at the upstream end of a link.

Christian, you originally reported that both X5000 and X1000 were
broken.  I suspect X1000 may have been fixed in v6.18-rc3 by
df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree
platforms"), but I would love to have confirmation of that.

The patches below read the PCIe Link Capabilities that tell us what
ASPM link states the hardware supports, cache it, and use a quirk to
remove the states we think are broken.

Since these are just for testing, I didn't want to start a new thread.
If anybody is able to test this, you should be able to just apply this
whole email as a patch on top of v6.18-rc4.

Would appreciate the complete dmesg log of the boot if possible.  This
patch adds a quirk for the [1957:0451] Root Ports in Christian's
X5000.  If ASPM is still broken for other Root Ports, we will need the
Vendor and Device IDs to add quirks for them.

commit 9d089f88fd66 ("PCI/ASPM: Cache Link Capabilities to enable quirks to override")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Nov 5 12:23:38 2025 -0600

    PCI/ASPM: Cache Link Capabilities to enable quirks to override
    
    Cache the PCIe Link Capabilities register in struct pci_dev so quirks can
    remove features to avoid hardware defects.  The idea is:
    
      - set_pcie_port_type() reads PCIe Link Capabilities and caches it in
        dev->lnkcap
    
      - EARLY or HEADER quirks can update the cached dev->lnkcap to remove
        advertised features that don't work correctly
    
      - pcie_aspm_cap_init() relies on dev->lnkcap and ignores any features not
        advertised there
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 79b965158473..c2ecfa4e92e5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -378,15 +378,13 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	int capable = 1, enabled = 1;
-	u32 reg32;
 	u16 reg16;
 	struct pci_dev *child;
 	struct pci_bus *linkbus = link->pdev->subordinate;
 
 	/* All functions should have the same cap and state, take the worst */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
-		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
+		if (!(child->lnkcap & PCI_EXP_LNKCAP_CLKPM)) {
 			capable = 0;
 			enabled = 0;
 			break;
@@ -567,7 +565,7 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, encoding, lnkcap_up, lnkcap_dw;
+	u32 latency, encoding;
 	u32 l1_switch_latency = 0, latency_up_l0s;
 	u32 latency_up_l1, latency_dw_l0s, latency_dw_l1;
 	u32 acceptable_l0s, acceptable_l1;
@@ -592,14 +590,10 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		struct pci_dev *dev = pci_function_0(link->pdev->subordinate);
 
 		/* Read direction exit latencies */
-		pcie_capability_read_dword(link->pdev, PCI_EXP_LNKCAP,
-					   &lnkcap_up);
-		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP,
-					   &lnkcap_dw);
-		latency_up_l0s = calc_l0s_latency(lnkcap_up);
-		latency_up_l1 = calc_l1_latency(lnkcap_up);
-		latency_dw_l0s = calc_l0s_latency(lnkcap_dw);
-		latency_dw_l1 = calc_l1_latency(lnkcap_dw);
+		latency_up_l0s = calc_l0s_latency(link->pdev->lnkcap);
+		latency_up_l1 = calc_l1_latency(link->pdev->lnkcap);
+		latency_dw_l0s = calc_l0s_latency(dev->lnkcap);
+		latency_dw_l1 = calc_l1_latency(dev->lnkcap);
 
 		/* Check upstream direction L0s latency */
 		if ((link->aspm_capable & PCIE_LINK_STATE_L0S_UP) &&
@@ -814,7 +808,7 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
-	u32 parent_lnkcap, child_lnkcap;
+	u32 lnkcap;
 	u16 parent_lnkctl, child_lnkctl;
 	struct pci_bus *linkbus = parent->subordinate;
 
@@ -829,9 +823,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * If ASPM not supported, don't mess with the clocks and link,
 	 * bail out now.
 	 */
-	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
-	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
-	if (!(parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPMS))
+	if (!(parent->lnkcap & child->lnkcap & PCI_EXP_LNKCAP_ASPMS))
 		return;
 
 	/* Configure common clock before checking latencies */
@@ -841,10 +833,18 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * Re-read upstream/downstream components' register state after
 	 * clock configuration.  L0s & L1 exit latencies in the otherwise
 	 * read-only Link Capabilities may change depending on common clock
-	 * configuration (PCIe r5.0, sec 7.5.3.6).
+	 * configuration (PCIe r5.0, sec 7.5.3.6).  Update only the exit
+	 * latencies in the cached dev->lnkcap because quirks may have
+	 * removed broken features advertised by the device.
 	 */
-	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
-	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
+	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &lnkcap);
+	parent->lnkcap &= ~(PCI_EXP_LNKCAP_L0SEL | PCI_EXP_LNKCAP_L1EL);
+	parent->lnkcap |= lnkcap & (PCI_EXP_LNKCAP_L0SEL | PCI_EXP_LNKCAP_L1EL);
+
+	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &lnkcap);
+	child->lnkcap &= ~(PCI_EXP_LNKCAP_L0SEL | PCI_EXP_LNKCAP_L1EL);
+	child->lnkcap |= lnkcap & (PCI_EXP_LNKCAP_L0SEL | PCI_EXP_LNKCAP_L1EL);
+
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
 	pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
 
@@ -864,7 +864,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * given link unless components on both sides of the link each
 	 * support L0s.
 	 */
-	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
+	if (parent->lnkcap & child->lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
 		link->aspm_support |= PCIE_LINK_STATE_L0S;
 
 	if (child_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
@@ -873,7 +873,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		link->aspm_enabled |= PCIE_LINK_STATE_L0S_DW;
 
 	/* Setup L1 state */
-	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
+	if (parent->lnkcap & child->lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
 		link->aspm_support |= PCIE_LINK_STATE_L1;
 
 	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0ce98e18b5a8..7dab61347244 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1633,7 +1633,6 @@ void set_pcie_port_type(struct pci_dev *pdev)
 {
 	int pos;
 	u16 reg16;
-	u32 reg32;
 	int type;
 	struct pci_dev *parent;
 
@@ -1652,8 +1651,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
 	pdev->pcie_mpss = FIELD_GET(PCI_EXP_DEVCAP_PAYLOAD, pdev->devcap);
 
-	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &reg32);
-	if (reg32 & PCI_EXP_LNKCAP_DLLLARC)
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &pdev->lnkcap);
+	if (pdev->lnkcap & PCI_EXP_LNKCAP_DLLLARC)
 		pdev->link_active_reporting = 1;
 
 	parent = pci_upstream_bridge(pdev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..ec4133ae9cae 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -361,6 +361,7 @@ struct pci_dev {
 	struct pci_dev  *rcec;          /* Associated RCEC device */
 #endif
 	u32		devcap;		/* PCIe Device Capabilities */
+	u32		lnkcap;		/* PCIe Link Capabilities */
 	u16		rebar_cap;	/* Resizable BAR capability offset */
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
commit ad3106e7d1bf ("PCI/ASPM: Add pcie_aspm_disable_cap() to remove advertised features")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Nov 5 09:11:21 2025 -0600

    PCI/ASPM: Add pcie_aspm_disable_cap() to remove advertised features
    
    Add pcie_aspm_disable_cap(), which can be used by quirks to remove
    advertised features that don't work correctly.
    
    Removing advertised features prevents aspm.c from enabling them, even if
    users try to enable them via sysfs or by building the kernel with
    CONFIG_PCIEASPM_POWERSAVE or CONFIG_PCIEASPM_POWER_SUPERSAVE.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4492b809094b..858d2d6c9304 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -958,6 +958,7 @@ void pci_save_aspm_l1ss_state(struct pci_dev *dev);
 void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
 
 #ifdef CONFIG_PCIEASPM
+void pcie_aspm_disable_cap(struct pci_dev *pdev, int state);
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked);
@@ -965,6 +966,7 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 void pci_configure_ltr(struct pci_dev *pdev);
 void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
 #else
+static inline void pcie_aspm_disable_cap(struct pci_dev *pdev, int state) { }
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked) { }
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index c2ecfa4e92e5..4e9e3503c569 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1530,6 +1530,18 @@ int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
 }
 EXPORT_SYMBOL(pci_enable_link_state_locked);
 
+void pcie_aspm_disable_cap(struct pci_dev *pdev, int state)
+{
+	if (state & PCIE_LINK_STATE_L0S)
+		pdev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L0S;
+	if (state & PCIE_LINK_STATE_L1)
+		pdev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L1;
+	if (state & (PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1))
+		pci_info(pdev, "ASPM:%s%s removed from Link Capabilities to work around device defect\n",
+			 state & PCIE_LINK_STATE_L0S ? " L0s" : "",
+			 state & PCIE_LINK_STATE_L1 ? " L1" : "");
+}
+
 static int pcie_aspm_set_policy(const char *val,
 				const struct kernel_param *kp)
 {
commit 69184484d69e ("PCI/ASPM: Prevent use of ASPM on Freescale Root Ports")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Nov 5 12:18:07 2025 -0600

    PCI/ASPM: Prevent use of ASPM on Freescale Root Ports
    
    Christian reported that f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and
    ASPM states for devicetree platforms") broke booting on the A-EON X5000 and
    AmigaOne X1000.
    
    Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
    Fixes: df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms"
    )
    Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
    Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..8cf182c28d2b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2525,6 +2525,16 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
 
+/*
+ * Remove ASPM L0s and L1 support from cached copy of Link Capabilities so
+ * aspm.c won't try to enable them.
+ */
+static void quirk_disable_aspm_l0s_l1_cap(struct pci_dev *dev)
+{
+	pcie_aspm_disable_cap(dev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1_cap);
+
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
  * Link bit cleared after starting the link retrain process to allow this

