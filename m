Return-Path: <linux-pci+bounces-26087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18450A91B1D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 13:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7950D3B291B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 11:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D66623F422;
	Thu, 17 Apr 2025 11:43:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019C23E346;
	Thu, 17 Apr 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890187; cv=none; b=hHLJQHjsZqa15Owngx9Kl9Hn2re8O44nMQNA0A+VaNDs1h5dfgcjZfi9JvTCanx+Lc2iK0MCaXrnbA8eSrRn6PouBN3n+yBmLYRq74k3m0tLTnujn6AdFYdlMAQFrLEcL3bK9IZKVXX5BQE50rdowPBFQL+oo5y/n3epHFoiAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890187; c=relaxed/simple;
	bh=3hqhko1U0mB8lse8v5cIdGEm9RtT3mWOd5RZXTzF76E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7/h8mTcBXoWhHz0hLQNCfveE7CYCckM1kuIJcXo73K+DrKyQwksnIhaQ9RyG4/cMNrugl4VJMpyQRlBLF0hOtCC6N0b+iaGaniPnaP2TAX2oX672Fx+u2jq6cWWQoNrPkktqWxU+lJmhx7vrZc7fhaSLl9fnOdzsv0blaXSZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A152F2C05243;
	Thu, 17 Apr 2025 13:42:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 02911B1FD0; Thu, 17 Apr 2025 13:43:00 +0200 (CEST)
Date: Thu, 17 Apr 2025 13:42:59 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	dingwei@marvell.com, cassel@kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI/ERR: Add support for resetting the slot in a
 platforms specific way
Message-ID: <aADpQ0rbuj571B4R@wunner.de>
References: <20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org>
 <20250404-pcie-reset-slot-v1-2-98952918bf90@linaro.org>
 <Z--cY5Uf6JyTYL9y@wunner.de>
 <3dokyirkf47lqxgx5k2ybij5b5an6qnceifsub3mcmjvzp3kdb@sm7f2jxxepdc>
 <Z__AyQeZmXiNwT7c@wunner.de>
 <rrqn7hlefn7klaczi2jkfta72pwmtentj3zp37yvw3brwpnalk@3eapwfeo5y4d>
 <aABJ_u8-FXeJoPyF@wunner.de>
 <jb4iq364iqwk3swux5cjiczyvdyrkjtqjclefyfjrntepvroyn@7vbvbzu3pd3p>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jb4iq364iqwk3swux5cjiczyvdyrkjtqjclefyfjrntepvroyn@7vbvbzu3pd3p>

On Thu, Apr 17, 2025 at 11:09:21AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Apr 17, 2025 at 02:23:26AM +0200, Lukas Wunner wrote:
> > On Wed, Apr 16, 2025 at 08:34:21PM +0530, Manivannan Sadhasivam wrote:
> > > I don't think it is possible to get rid of the powerpc version. It has
> > > its own pci_dev::sysdata pointing to 'struct pci_controller' pointer
> > > which is internal to powerpc arch code. And the generic code would need
> > > 'struct pci_host_bridge' to access the callback.
> > 
> > Below is my proposal to convert powerpc to the new ->slot_reset() callback.
> > Compile-tested only.
> > 
> > Feel free to include this in your series, alternatively I can submit it
> > to powerpc maintainers once your series has landed.  Thanks!
> 
> Looks good to me, thanks! I think it would be better if it is submitted
> once my series has landed in mainline (just to avoid immutable branch
> hassle between powerpc and PCI trees).

Sure, this can wait until your series has landed.  It would also be
possible to merge through the pci tree if powerpc maintainers ack the
patch.

I've realized that pci_reset_secondary_bus() can be made private as well,
so below is an updated patch.  Just putting this out there FWIW.

-- 8< --

From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] powerpc/powernv/pci: Migrate to pci_host_bridge::reset_slot
 callback

struct pci_host_bridge has just been amended with a ->reset_slot()
callback to allow for a host-bridge-specific bus reset procedure.

PowerNV needs a platform-specific bus reset procedure and has historically
implemented it by overriding pcibios_reset_secondary_bus().

Migrate PowerNV to the new ->reset_slot() callback to avoid having to
maintain two different mechanisms for platform- and host-bridge-specific
bus reset procedures.  Assign the callback as soon as the pci_host_bridge
is allocated through the following call chain:

pcibios_init()
  pcibios_scan_phb()
    pci_create_root_bus()
      pci_register_host_bridge()
        pcibios_root_bridge_prepare()

The powerpc-specific implementation of pcibios_reset_secondary_bus() can
thus be deleted and the remaining default implementation in the PCI core
can be made private.  pci_reset_secondary_bus() can also be made private.
The ->reset_secondary_bus() callback in struct pci_controller_ops becomes
obsolete and can be deleted.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 arch/powerpc/include/asm/pci-bridge.h        |  1 -
 arch/powerpc/kernel/pci-common.c             | 12 ------------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 14 +++++++++-----
 arch/powerpc/platforms/powernv/pci-ioda.c    |  9 +++++++--
 arch/powerpc/platforms/powernv/pci.h         |  3 ++-
 drivers/pci/pci.c                            |  4 ++--
 include/linux/pci.h                          |  2 --
 7 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 2aa3a091ef20..0de09fc90641 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -36,7 +36,6 @@ struct pci_controller_ops {
 					    unsigned long type);
 	void		(*setup_bridge)(struct pci_bus *bus,
 					unsigned long type);
-	void		(*reset_secondary_bus)(struct pci_dev *pdev);
 
 #ifdef CONFIG_PCI_MSI
 	int		(*setup_msi_irqs)(struct pci_dev *pdev,
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index eac84d687b53..dad15fbec4e0 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -233,18 +233,6 @@ void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
 		hose->controller_ops.setup_bridge(bus, type);
 }
 
-void pcibios_reset_secondary_bus(struct pci_dev *dev)
-{
-	struct pci_controller *phb = pci_bus_to_host(dev->bus);
-
-	if (phb->controller_ops.reset_secondary_bus) {
-		phb->controller_ops.reset_secondary_bus(dev);
-		return;
-	}
-
-	pci_reset_secondary_bus(dev);
-}
-
 resource_size_t pcibios_default_alignment(void)
 {
 	if (ppc_md.pcibios_default_alignment)
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index db3370d1673c..9ea2fa892efc 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -890,18 +890,22 @@ static int pnv_eeh_bridge_reset(struct pci_dev *pdev, int option)
 	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
 }
 
-void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
+int pnv_pci_reset_secondary_bus(struct pci_host_bridge *host,
+				struct pci_dev *dev)
 {
 	struct pci_controller *hose;
+	int rc_hot, rc_dea;
 
 	if (pci_is_root_bus(dev->bus)) {
 		hose = pci_bus_to_host(dev->bus);
-		pnv_eeh_root_reset(hose, EEH_RESET_HOT);
-		pnv_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
+		rc_hot = pnv_eeh_root_reset(hose, EEH_RESET_HOT);
+		rc_dea = pnv_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
 	} else {
-		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
-		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
+		rc_hot = pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
+		rc_dea = pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
 	}
+
+	return rc_hot ? : rc_dea;
 }
 
 static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, const char *type,
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ae4b549b5ca0..e1b75a4bc681 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2145,6 +2145,12 @@ static void pnv_pci_ioda_fixup(void)
 #endif
 }
 
+static int pnv_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->reset_slot = pnv_pci_reset_secondary_bus;
+	return 0;
+}
+
 /*
  * Returns the alignment for I/O or memory windows for P2P
  * bridges. That actually depends on how PEs are segmented.
@@ -2504,7 +2510,6 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 	.release_device		= pnv_pci_release_device,
 	.window_alignment	= pnv_pci_window_alignment,
 	.setup_bridge		= pnv_pci_fixup_bridge_resources,
-	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
 	.shutdown		= pnv_pci_ioda_shutdown,
 #ifdef CONFIG_IOMMU_API
 	.device_group		= pnv_pci_device_group,
@@ -2515,7 +2520,6 @@ static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {
 	.enable_device_hook	= pnv_ocapi_enable_device_hook,
 	.release_device		= pnv_pci_release_device,
 	.window_alignment	= pnv_pci_window_alignment,
-	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
 	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
@@ -2724,6 +2728,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	}
 
 	ppc_md.pcibios_default_alignment = pnv_pci_default_alignment;
+	ppc_md.pcibios_root_bridge_prepare = pnv_pci_root_bridge_prepare;
 
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 42075501663b..44e8969c7729 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -275,7 +275,8 @@ extern struct iommu_table *pnv_pci_table_alloc(int nid);
 
 extern void pnv_pci_init_ioda2_phb(struct device_node *np);
 extern void pnv_pci_init_npu2_opencapi_phb(struct device_node *np);
-extern void pnv_pci_reset_secondary_bus(struct pci_dev *dev);
+extern int pnv_pci_reset_secondary_bus(struct pci_host_bridge *host,
+				       struct pci_dev *dev);
 extern int pnv_eeh_phb_reset(struct pci_controller *hose, int option);
 
 extern struct pnv_ioda_pe *pnv_pci_bdfn_to_pe(struct pnv_phb *phb, u16 bdfn);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13709bb898a9..28cdcd698914 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4962,7 +4962,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 			    PCIE_RESET_READY_POLL_MS - delay);
 }
 
-void pci_reset_secondary_bus(struct pci_dev *dev)
+static void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
 
@@ -4980,7 +4980,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
 }
 
-void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
+static void pcibios_reset_secondary_bus(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	int ret;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 76e977af2d52..829d7cbbf258 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1397,8 +1397,6 @@ int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
 int pci_reset_bus(struct pci_dev *dev);
-void pci_reset_secondary_bus(struct pci_dev *dev);
-void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 void pci_release_resource(struct pci_dev *dev, int resno);
-- 
2.43.0


