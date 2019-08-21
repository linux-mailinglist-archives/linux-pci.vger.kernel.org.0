Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C82097D30
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 16:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfHUOh4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 10:37:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:58169 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbfHUOhz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Aug 2019 10:37:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 07:37:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="196007739"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 21 Aug 2019 07:37:52 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 21 Aug 2019 17:37:51 +0300
Date:   Wed, 21 Aug 2019 17:37:51 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add sysfs attribute for disabling PCIe link to
 downstream component
Message-ID: <20190821143751.GW19908@lahna.fi.intel.com>
References: <20190529104942.74991-1-mika.westerberg@linux.intel.com>
 <20190703133953.GK128603@google.com>
 <20190703150341.GW2640@lahna.fi.intel.com>
 <20190801215339.GF151852@google.com>
 <20190806101230.GI2548@lahna.fi.intel.com>
 <20190819235245.GX253360@google.com>
 <20190820095820.GD19908@lahna.fi.intel.com>
 <20190820141717.GA14450@google.com>
 <20190821072833.GM19908@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821072833.GM19908@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 21, 2019 at 10:28:37AM +0300, Mika Westerberg wrote:
> > If we see a type of PCI_EXP_TYPE_ROOT_PORT or
> > PCI_EXP_TYPE_PCIE_BRIDGE, I think we have to assume that's accurate
> > (which we already do today -- for those types, we assume the device
> > has a secondary link).
> > 
> > For a device that claims to be PCI_EXP_TYPE_DOWNSTREAM, if a parent
> > device exists and is a Downstream Port (Root Port, Switch Downstream
> > Port, and I suppose a PCI-to-PCIe bridge (this is basically
> > pcie_downstream_port()), this device must actually be acting as a
> > PCI_EXP_TYPE_UPSTREAM device.
> > 
> > If a device claiming to be PCI_EXP_TYPE_UPSTREAM has a parent that is
> > PCI_EXP_TYPE_UPSTREAM, this device must actually be a
> > PCI_EXP_TYPE_DOWNSTREAM port.
> > 
> > For PCI_EXP_TYPE_DOWNSTREAM and PCI_EXP_TYPE_UPSTREAM devices that
> > don't have parents, we just have to assume they advertise the correct
> > type (as we do today).  There are sparc and virtualization configs
> > like this.
> 
> OK, thanks for the details. I'll try to make patch based on the above.

Something like the below patch? Only compile tested for now but I will
split it into a proper patch series and give it some testing if this is
what you were after.

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 544922f097c0..2fccb5762c76 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -336,15 +336,6 @@ static inline int pcie_cap_version(const struct pci_dev *dev)
 	return pcie_caps_reg(dev) & PCI_EXP_FLAGS_VERS;
 }
 
-static bool pcie_downstream_port(const struct pci_dev *dev)
-{
-	int type = pci_pcie_type(dev);
-
-	return type == PCI_EXP_TYPE_ROOT_PORT ||
-	       type == PCI_EXP_TYPE_DOWNSTREAM ||
-	       type == PCI_EXP_TYPE_PCIE_BRIDGE;
-}
-
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ac50710f1d4..3c0672f1dfe7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3577,7 +3577,7 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 		}
 
 		/* Ensure upstream ports don't block AtomicOps on egress */
-		if (!bridge->has_secondary_link) {
+		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_UPSTREAM) {
 			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
 						   &ctl2);
 			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9a83fcf612ca..ae8d839dca4f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -118,6 +118,15 @@ static inline bool pci_power_manageable(struct pci_dev *pci_dev)
 	return !pci_has_subordinate(pci_dev) || pci_dev->bridge_d3;
 }
 
+static inline bool pcie_downstream_port(const struct pci_dev *dev)
+{
+	int type = pci_pcie_type(dev);
+
+	return type == PCI_EXP_TYPE_ROOT_PORT ||
+	       type == PCI_EXP_TYPE_DOWNSTREAM ||
+	       type == PCI_EXP_TYPE_PCIE_BRIDGE;
+}
+
 int pci_vpd_init(struct pci_dev *dev);
 void pci_vpd_release(struct pci_dev *dev);
 void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 464f8f92653f..db2d40e44c08 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -904,6 +904,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link;
 	int blacklist = !!pcie_aspm_sanity_check(pdev);
+	int type = pci_pcie_type(pdev);
 
 	if (!aspm_support_enabled)
 		return;
@@ -913,15 +914,14 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 
 	/*
 	 * We allocate pcie_link_state for the component on the upstream
-	 * end of a Link, so there's nothing to do unless this device has a
-	 * Link on its secondary side.
+	 * end of a Link, so there's nothing to do unless this device is
+	 * downstream or root port.
 	 */
-	if (!pdev->has_secondary_link)
+	if (type != PCI_EXP_TYPE_ROOT_PORT && type != PCI_EXP_TYPE_DOWNSTREAM)
 		return;
 
 	/* VIA has a strange chipset, root port is under a bridge */
-	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT &&
-	    pdev->bus->self)
+	if (type == PCI_EXP_TYPE_ROOT_PORT && pdev->bus->self)
 		return;
 
 	down_read(&pci_bus_sem);
@@ -1070,7 +1070,8 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	if (!pci_is_pcie(pdev))
 		return 0;
 
-	if (pdev->has_secondary_link)
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)
 		parent = pdev;
 	if (!parent || !parent->link_state)
 		return -EINVAL;
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 773197a12568..b0e6048a9208 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -166,7 +166,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
 	driver = pcie_port_find_service(dev, service);
 	if (driver && driver->reset_link) {
 		status = driver->reset_link(dev);
-	} else if (dev->has_secondary_link) {
+	} else if (pcie_downstream_port(dev)) {
 		status = default_reset_link(dev);
 	} else {
 		pci_printk(KERN_DEBUG, dev, "no link-reset support at upstream device %s\n",
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a3c7338fad86..983a5612c548 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1431,26 +1431,40 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
 	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
 
+	parent = pci_upstream_bridge(pdev);
+	if (!parent)
+		return;
+
 	/*
-	 * A Root Port or a PCI-to-PCIe bridge is always the upstream end
-	 * of a Link.  No PCIe component has two Links.  Two Links are
-	 * connected by a Switch that has a Port on each Link and internal
-	 * logic to connect the two Ports.
+	 * Some systems do not identify their upstream/downstream ports
+	 * correctly so detect impossible configurations here and correct
+	 * the port type accordingly.
 	 */
 	type = pci_pcie_type(pdev);
-	if (type == PCI_EXP_TYPE_ROOT_PORT ||
-	    type == PCI_EXP_TYPE_PCIE_BRIDGE)
-		pdev->has_secondary_link = 1;
-	else if (type == PCI_EXP_TYPE_UPSTREAM ||
-		 type == PCI_EXP_TYPE_DOWNSTREAM) {
-		parent = pci_upstream_bridge(pdev);
-
+	if (type == PCI_EXP_TYPE_DOWNSTREAM) {
 		/*
-		 * Usually there's an upstream device (Root Port or Switch
-		 * Downstream Port), but we can't assume one exists.
+		 * If pdev claims to be downstream port but the parent
+		 * device is also downstream port assume pdev is actually
+		 * upstream port.
 		 */
-		if (parent && !parent->has_secondary_link)
-			pdev->has_secondary_link = 1;
+		if (pcie_downstream_port(parent)) {
+			dev_info(&pdev->dev,
+				"claims to be downstream port but is acting as upstream port, correcting type\n");
+			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
+			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
+		}
+	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
+		/*
+		 * If pdev claims to be upstream port but the parent
+		 * device is also upstream port assume pdev is actually
+		 * downstream port.
+		 */
+		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
+			dev_info(&pdev->dev,
+				"claims to be upstream port but is acting as downstream port, correcting type\n");
+			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
+			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
+		}
 	}
 }
 
@@ -2764,12 +2778,8 @@ static int only_one_child(struct pci_bus *bus)
 	 * A PCIe Downstream Port normally leads to a Link with only Device
 	 * 0 on it (PCIe spec r3.1, sec 7.3.1).  As an optimization, scan
 	 * only for Device 0 in that situation.
-	 *
-	 * Checking has_secondary_link is a hack to identify Downstream
-	 * Ports because sometimes Switches are configured such that the
-	 * PCIe Port Type labels are backwards.
 	 */
-	if (bridge && pci_is_pcie(bridge) && bridge->has_secondary_link)
+	if (bridge && pci_is_pcie(bridge) && pcie_downstream_port(bridge))
 		return 1;
 
 	return 0;
diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index 5acd9c02683a..9ae9fb9339e8 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -13,6 +13,8 @@
 #include <linux/pci_regs.h>
 #include <linux/types.h>
 
+#include "pci.h"
+
 /**
  * pci_vc_save_restore_dwords - Save or restore a series of dwords
  * @dev: device
@@ -105,7 +107,7 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
 	struct pci_dev *link = NULL;
 
 	/* Enable VCs from the downstream device */
-	if (!dev->has_secondary_link)
+	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev))
 		return;
 
 	ctrl_pos = pos + PCI_VC_RES_CTRL + (res * PCI_CAP_VC_PER_VC_SIZEOF);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 82e4cd1b7ac3..2f8990246316 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -418,7 +418,6 @@ struct pci_dev {
 	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
 	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
-	unsigned int	has_secondary_link:1;
 	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
 	unsigned int	is_probed:1;		/* Device probing in progress */
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
