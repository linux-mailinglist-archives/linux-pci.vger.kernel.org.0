Return-Path: <linux-pci+bounces-17684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 138FD9E4248
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EEB168A62
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BD9234966;
	Wed,  4 Dec 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNIjphcw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0E234963;
	Wed,  4 Dec 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332387; cv=none; b=Ny25KvVckOtWUcVYeijEHYo/jSI3XXqETzFcHBI+jndiQg0uNzsb+1aUXSPFu7vVEpDLvVbwyPlwAjC+CVPSIBYI4JsBjoQ7mz9FBcFSugj5y+TTUx500BgqegILmDl6LMIBs8a8guUKRSk2w1NQskHjW9UEQ8lOGtLdFTE1kiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332387; c=relaxed/simple;
	bh=UnnGKOXd0BhwwrAWMPw9umXxrSXIo78IY90fEx33PDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3J3M6eAdBOypKrKAHTMs3mJMAqzdrqCbxA9fUAzWjeCfMVkjIGZu6SMesS+s+OgkTJsO/fZD9BCTk6dMO7CehlNeVfYEg/XDFmLfbUlRKyakOOTZjm1MHkd/rSxbSWzmRFWkMFS9sJo1Ir2F3f9ll9wMdIYrGM4Jpa0lVJMf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNIjphcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070CAC4CED6;
	Wed,  4 Dec 2024 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332387;
	bh=UnnGKOXd0BhwwrAWMPw9umXxrSXIo78IY90fEx33PDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LNIjphcwNglJmpiG5Yz5CsHAvHcJk2y5yUlvW19pahgEG7yEDuIIbanQHtyKMDBnB
	 3a1wUmR4PTeR6frppQDZ0HJLG1F/Ieo0sms4DrdBpkAxhYMWlv4oeXTJqNV5QILyei
	 VO+zylgLLKs8L8iYvcvK2mQu/D9cnmWT6UVsPJkfCh5NiVZQTfuCb5EMoLM/ztJgCr
	 Sq5wo7M9xPqf7yojccbse1eTw6zi6deEwi4VG0DsfGDBJ/uoWjoZCx8UZqFAsbjFzk
	 cIZKSqVlfxi5WtclkVpqRDD69w2y9rHGgvLHDVMtopb89JK6APsh2LyTlAf9BDH9si
	 h2XcP+aT2/P7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 3/6] PCI: Detect and trust built-in Thunderbolt chips
Date: Wed,  4 Dec 2024 11:01:35 -0500
Message-ID: <20241204160142.2217017-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160142.2217017-1-sashal@kernel.org>
References: <20241204160142.2217017-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Esther Shimanovich <eshimanovich@chromium.org>

[ Upstream commit 3b96b895127b7c0aed63d82c974b46340e8466c1 ]

Some computers with CPUs that lack Thunderbolt features use discrete
Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
chips are located within the chassis; between the Root Port labeled
ExternalFacingPort and the USB-C port.

These Thunderbolt PCIe devices should be labeled as fixed and trusted, as
they are built into the computer. Otherwise, security policies that rely on
those flags may have unintended results, such as preventing USB-C ports
from enumerating.

Detect the above scenario through the process of elimination.

  1) Integrated Thunderbolt host controllers already have Thunderbolt
     implemented, so anything outside their external facing Root Port is
     removable and untrusted.

     Detect them using the following properties:

       - Most integrated host controllers have the "usb4-host-interface"
         ACPI property, as described here:

         https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers

       - Integrated Thunderbolt PCIe Root Ports before Alder Lake do not
         have the "usb4-host-interface" ACPI property. Identify those by
         their PCI IDs instead.

  2) If a Root Port does not have integrated Thunderbolt capabilities, but
     has the "ExternalFacingPort" ACPI property, that means the
     manufacturer has opted to use a discrete Thunderbolt host controller
     that is built into the computer.

     This host controller can be identified by virtue of being located
     directly below an external-facing Root Port that lacks integrated
     Thunderbolt. Label it as trusted and fixed.

     Everything downstream from it is untrusted and removable.

The "ExternalFacingPort" ACPI property is described here:
https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports

Link: https://lore.kernel.org/r/20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org
Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/pci/acpi.c | 119 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c |  30 ++++++++---
 include/linux/pci.h |   6 +++
 3 files changed, 148 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 2f82480fd4305..4421560a5e825 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -248,6 +248,125 @@ void __init pci_acpi_crs_quirks(void)
 		printk(KERN_INFO "PCI: Please notify linux-pci@vger.kernel.org so future kernels can this automatically\n");
 }
 
+/*
+ * Check if pdev is part of a PCIe switch that is directly below the
+ * specified bridge.
+ */
+static bool pcie_switch_directly_under(struct pci_dev *bridge,
+				       struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(pdev);
+
+	/* If the device doesn't have a parent, it's not under anything */
+	if (!parent)
+		return false;
+
+	/*
+	 * If the device has a PCIe type, check if it is below the
+	 * corresponding PCIe switch components (if applicable). Then check
+	 * if its upstream port is directly beneath the specified bridge.
+	 */
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_UPSTREAM:
+		return parent == bridge;
+
+	case PCI_EXP_TYPE_DOWNSTREAM:
+		if (pci_pcie_type(parent) != PCI_EXP_TYPE_UPSTREAM)
+			return false;
+		parent = pci_upstream_bridge(parent);
+		return parent == bridge;
+
+	case PCI_EXP_TYPE_ENDPOINT:
+		if (pci_pcie_type(parent) != PCI_EXP_TYPE_DOWNSTREAM)
+			return false;
+		parent = pci_upstream_bridge(parent);
+		if (!parent || pci_pcie_type(parent) != PCI_EXP_TYPE_UPSTREAM)
+			return false;
+		parent = pci_upstream_bridge(parent);
+		return parent == bridge;
+	}
+
+	return false;
+}
+
+static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
+{
+	struct fwnode_handle *fwnode;
+
+	/*
+	 * For USB4, the tunneled PCIe Root or Downstream Ports are marked
+	 * with the "usb4-host-interface" ACPI property, so we look for
+	 * that first. This should cover most cases.
+	 */
+	fwnode = fwnode_find_reference(dev_fwnode(&pdev->dev),
+				       "usb4-host-interface", 0);
+	if (!IS_ERR(fwnode)) {
+		fwnode_handle_put(fwnode);
+		return true;
+	}
+
+	/*
+	 * Any integrated Thunderbolt 3/4 PCIe Root Ports from Intel
+	 * before Alder Lake do not have the "usb4-host-interface"
+	 * property so we use their PCI IDs instead. All these are
+	 * tunneled. This list is not expected to grow.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
+		switch (pdev->device) {
+		/* Ice Lake Thunderbolt 3 PCIe Root Ports */
+		case 0x8a1d:
+		case 0x8a1f:
+		case 0x8a21:
+		case 0x8a23:
+		/* Tiger Lake-LP Thunderbolt 4 PCIe Root Ports */
+		case 0x9a23:
+		case 0x9a25:
+		case 0x9a27:
+		case 0x9a29:
+		/* Tiger Lake-H Thunderbolt 4 PCIe Root Ports */
+		case 0x9a2b:
+		case 0x9a2d:
+		case 0x9a2f:
+		case 0x9a31:
+			return true;
+		}
+	}
+
+	return false;
+}
+
+bool arch_pci_dev_is_removable(struct pci_dev *pdev)
+{
+	struct pci_dev *parent, *root;
+
+	/* pdev without a parent or Root Port is never tunneled */
+	parent = pci_upstream_bridge(pdev);
+	if (!parent)
+		return false;
+	root = pcie_find_root_port(pdev);
+	if (!root)
+		return false;
+
+	/* Internal PCIe devices are not tunneled */
+	if (!root->external_facing)
+		return false;
+
+	/* Anything directly behind a "usb4-host-interface" is tunneled */
+	if (pcie_has_usb4_host_interface(parent))
+		return true;
+
+	/*
+	 * Check if this is a discrete Thunderbolt/USB4 controller that is
+	 * directly behind the non-USB4 PCIe Root Port marked as
+	 * "ExternalFacingPort". Those are not behind a PCIe tunnel.
+	 */
+	if (pcie_switch_directly_under(root, pdev))
+		return false;
+
+	/* PCIe devices after the discrete chip are tunneled */
+	return true;
+}
+
 #ifdef	CONFIG_PCI_MMCONFIG
 static int check_segment(u16 seg, struct device *dev, char *estr)
 {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e19b79821dd6d..5c1ab9ee65eb3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1593,23 +1593,33 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 
 static void set_pcie_untrusted(struct pci_dev *dev)
 {
-	struct pci_dev *parent;
+	struct pci_dev *parent = pci_upstream_bridge(dev);
 
+	if (!parent)
+		return;
 	/*
-	 * If the upstream bridge is untrusted we treat this device
+	 * If the upstream bridge is untrusted we treat this device as
 	 * untrusted as well.
 	 */
-	parent = pci_upstream_bridge(dev);
-	if (parent && (parent->untrusted || parent->external_facing))
+	if (parent->untrusted) {
+		dev->untrusted = true;
+		return;
+	}
+
+	if (arch_pci_dev_is_removable(dev)) {
+		pci_dbg(dev, "marking as untrusted\n");
 		dev->untrusted = true;
+	}
 }
 
 static void pci_set_removable(struct pci_dev *dev)
 {
 	struct pci_dev *parent = pci_upstream_bridge(dev);
 
+	if (!parent)
+		return;
 	/*
-	 * We (only) consider everything downstream from an external_facing
+	 * We (only) consider everything tunneled below an external_facing
 	 * device to be removable by the user. We're mainly concerned with
 	 * consumer platforms with user accessible thunderbolt ports that are
 	 * vulnerable to DMA attacks, and we expect those ports to be marked by
@@ -1619,9 +1629,15 @@ static void pci_set_removable(struct pci_dev *dev)
 	 * accessible to user / may not be removed by end user, and thus not
 	 * exposed as "removable" to userspace.
 	 */
-	if (parent &&
-	    (parent->external_facing || dev_is_removable(&parent->dev)))
+	if (dev_is_removable(&parent->dev)) {
+		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
+		return;
+	}
+
+	if (arch_pci_dev_is_removable(dev)) {
+		pci_dbg(dev, "marking as removable\n");
 		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
+	}
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index df73fb26b8250..9e58e5400d783 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2471,6 +2471,12 @@ pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
 static inline bool pci_pr3_present(struct pci_dev *pdev) { return false; }
 #endif
 
+#if defined(CONFIG_X86) && defined(CONFIG_ACPI)
+bool arch_pci_dev_is_removable(struct pci_dev *pdev);
+#else
+static inline bool arch_pci_dev_is_removable(struct pci_dev *pdev) { return false; }
+#endif
+
 #ifdef CONFIG_EEH
 static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
 {
-- 
2.43.0


