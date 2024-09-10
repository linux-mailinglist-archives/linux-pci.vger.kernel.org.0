Return-Path: <linux-pci+bounces-13010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D66974167
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 19:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221641C25943
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AFF1A38F4;
	Tue, 10 Sep 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LlRV4REP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39F1A3BAF
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991073; cv=none; b=bJIoKQAq0Pt7sPbWdesCNR00FmieCvG7zfmC90UaR0EnOkCduIjlFoW9V5ajMdPK6bCw7nMx4P+Y1oppcihye8bABzMDyR3Q7jiaWc7M7MERsCsRhQPINzKCFdBm31xzb8AHDuS0DW5cnojFGmDWmMKAWIP/Fl5tVeQ4+Fu8oMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991073; c=relaxed/simple;
	bh=JJZZB/X30QZDdKidFd5uFcb4V3/vG1UgCQ1the0PQ60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R3u6pJ84da3rLu69x/smjRQk2IzmsCU6xE8kDQy1OnDw07uXXw1VlNNRlD884GJ9Tm9U6VrhnmSUd+VClx2081bBdPLMCtz6IpYUpmR2vPMmNYYUCU5diDXzojbdQAadgEFLY0+yrtMC4VIuGqOxwVyIUTkHhpQF8uSY3RDnWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LlRV4REP; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-49bc672bb46so1849462137.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725991070; x=1726595870; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=STGVj6vl6LpAjZBaoJO/AHJ0YBKmV2BfQaPxcPnlFp4=;
        b=LlRV4REPaT2SuSTFRcBWiZ2EUJRNBjSVFF/qc2b0WMhDaC/qtfA+mKedFuB++5wjbt
         gkyRX/SF8daXWKSW66HCojnqieT7gtr2uITMdT5+rD6eQXYuexAHEEKAjhklnsY8GeQx
         EzSor/bbza5cSWeZBRPd7DnC7w7zvGHIaSnG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725991070; x=1726595870;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STGVj6vl6LpAjZBaoJO/AHJ0YBKmV2BfQaPxcPnlFp4=;
        b=ekP9zQvS7JyLNCR42jxl9KhMRNuNIQQmFeKORv2R/Z7n7ezouwekBKH8kHFIEF+UBU
         JKy+EVRPzf8TG/YItGapiDouL1z381E/8HQ1YhoEaEoV0EZwBFqveIyw9WCQo0iRixeN
         5UZQJRlaO10oepdfV6iFiKmsd72vqD5yzY4rIqzWdeXpMUCJq+8CbSYKIZ1ZVzFf7YbZ
         K0pnlg4AF0m5zQ9wfXraikJB4OCDS0L4KW6aeimsVGTB7FyX9BwECQyn1u9Ccuet7MJq
         j0jFxQFn/xJYWPhllG/L38P0AD6G3i9tNdx21JCK/q7TfPxQ9kN/tU9sUnnm/hH6cszN
         PRHA==
X-Forwarded-Encrypted: i=1; AJvYcCVr1S1V+O28C/G80Cu4W3qXxo3WXLSb5sTixoXGG6qee+lyWHJyEWU7OPov+7DaeZOuDgzsMIZVRWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9rsMo2o618smAbsgcG5zswf2O4YM9Hb5Ro8kUvIjHtqr9zhq
	o8eUa0ZqfL97OuY4aqCvptz8eIUd2r0o7bBxm7nNaRyUXFWnKNDqfM3DpIBxdw==
X-Google-Smtp-Source: AGHT+IGne/IKFNr9YFpyRr2ls9xEmzWsfOMV71gkVSWIpAyGIP2uO/EP6hAwPlHys0aPcgD5J5pTpg==
X-Received: by 2002:a05:6102:510b:b0:492:abbe:8923 with SMTP id ada2fe7eead31-49bde14671dmr15106234137.6.1725991070196;
        Tue, 10 Sep 2024 10:57:50 -0700 (PDT)
Received: from spinny.c.googlers.com (78.206.23.34.bc.googleusercontent.com. [34.23.206.78])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8489ac10b36sm746045241.8.2024.09.10.10.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 10:57:49 -0700 (PDT)
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Tue, 10 Sep 2024 17:57:45 +0000
Subject: [PATCH v5] PCI: Detect and trust built-in Thunderbolt chips
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org>
X-B4-Tracking: v=1; b=H4sIAJiI4GYC/3XMSw6CMBSF4a2Qjq3pG3DkPoyD0t5CB4hpC9EY9
 u7VESE6/E9yvhfJkCJkcqpeJMESc5xuGPpQETfYWw80emwimFCsYYaWNOdCS1doiA+qg5R18C2
 4xhL83BPg/PUuV+wh5jKl55df+Gf9Jy2cclpLCzooZby2ZzekaYzzeJxSTz7YIrZAswcEAgKks
 kzbljfmByA3ANd7QCJgOsvwq71W7gegNoCQe0Ah4EzgIDvv2w52wLqubxcwYuVwAQAA
To: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Esther Shimanovich <eshimanovich@chromium.org>
X-Mailer: b4 0.13.0

Some computers with CPUs that lack Thunderbolt features use discrete
Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
chips are located within the chassis; between the root port labeled
ExternalFacingPort and the USB-C port.

These Thunderbolt PCIe devices should be labeled as fixed and trusted,
as they are built into the computer. Otherwise, security policies that
rely on those flags may have unintended results, such as preventing
USB-C ports from enumerating.

Detect the above scenario through the process of elimination.

1) Integrated Thunderbolt host controllers already have Thunderbolt
   implemented, so anything outside their external facing root port is
   removable and untrusted.

   Detect them using the following properties:

     - Most integrated host controllers have the usb4-host-interface
       ACPI property, as described here:
Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers

     - Integrated Thunderbolt PCIe root ports before Alder Lake do not
       have the usb4-host-interface ACPI property. Identify those with
       their PCI IDs instead.

2) If a root port does not have integrated Thunderbolt capabilities, but
   has the ExternalFacingPort ACPI property, that means the manufacturer
   has opted to use a discrete Thunderbolt host controller that is
   built into the computer.

   This host controller can be identified by virtue of being located
   directly below an external-facing root port that lacks integrated
   Thunderbolt. Label it as trusted and fixed.

   Everything downstream from it is untrusted and removable.

The ExternalFacingPort ACPI property is described here:
Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports

Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
While working with devices that have discrete Thunderbolt chips, I
noticed that their internal TBT chips are inaccurately labeled as
untrusted and removable.

I've observed that this issue impacts all computers with internal,
discrete Intel JHL Thunderbolt chips, such as JHL6240, JHL6340, JHL6540,
and JHL7540, across multiple device manufacturers such as Lenovo, Dell,
and HP.

This affects the execution of any downstream security policy that
relies on the "untrusted" or "removable" flags.

I initially submitted a quirk to resolve this, which was too small in
scope, and after some discussion, Mika proposed a more thorough fix:
https://lore.kernel.org/lkml/20240510052616.GC4162345@black.fi.intel.com
I refactored it and am submitting as a new patch.
---
Changes in v5:
- Applied the following edits suggested by Lukas Wunner:
  - Applied ifdefs edits to ensure code is only compiled on x86 systems
  with ACPI
  - Added returns to avoid unecessary checks
  - Renamed pcie_is_tunneled to arch_pci_dev_is_removable
- Link to v4: https://lore.kernel.org/r/20240823-trust-tbt-fix-v4-1-c6f1e3bdd9be@chromium.org

Changes in v4:
- Applied edits on logic-flow clarity and formatting suggested by Ilpo
  Järvinen
- Mario Limonciello tested patch and confirmed works as intended.
- Link to v3: https://lore.kernel.org/r/20240815-trust-tbt-fix-v3-1-6ba01865d54c@chromium.org

Changes in v3:
- Incorporated minor edits suggested by Mika Westerberg.
- Mika Westerberg tested patch (more details in v2 link)
- Added "reviewed-by" and "tested-by" lines
- Link to v2: https://lore.kernel.org/r/20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org

Changes in v2:
- I clarified some comments, and made minor fixins
- I also added a more detailed description of implementation into the
  commit message
- Added Cc recipients Mike recommended
- Link to v1: https://lore.kernel.org/r/20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org
---
 arch/x86/pci/acpi.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c |  30 +++++++++----
 include/linux/pci.h |   6 +++
 3 files changed, 148 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 55c4b07ec1f6..62271668c3b1 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -250,6 +250,125 @@ void __init pci_acpi_crs_quirks(void)
 		pr_info("Please notify linux-pci@vger.kernel.org so future kernels can do this automatically\n");
 }
 
+/*
+ * Checks if pdev is part of a PCIe switch that is directly below the
+ * specified bridge.
+ */
+static bool pcie_switch_directly_under(struct pci_dev *bridge,
+				       struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(pdev);
+
+	/* If the device doesn't have a parent, it's not under anything. */
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
+	 * For USB4, the tunneled PCIe root or downstream ports are marked
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
+	 * Any integrated Thunderbolt 3/4 PCIe root ports from Intel
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
+	/* pdev without a parent or Root Port is never tunneled. */
+	parent = pci_upstream_bridge(pdev);
+	if (!parent)
+		return false;
+	root = pcie_find_root_port(pdev);
+	if (!root)
+		return false;
+
+	/* Internal PCIe devices are not tunneled. */
+	if (!root->external_facing)
+		return false;
+
+	/* Anything directly behind a "usb4-host-interface" is tunneled. */
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
+	/* PCIe devices after the discrete chip are tunneled. */
+	return true;
+}
+
 #ifdef	CONFIG_PCI_MMCONFIG
 static int check_segment(u16 seg, struct device *dev, char *estr)
 {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..7e0d6a1e151b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1631,23 +1631,33 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 
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
@@ -1657,9 +1667,15 @@ static void pci_set_removable(struct pci_dev *dev)
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
index 9e36b6c1810e..dca19203bc7c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2604,6 +2604,12 @@ pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
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

---
base-commit: 3f386cb8ee9f04ff4be164ca7a1d0ef3f81f7374
change-id: 20240806-trust-tbt-fix-5f337fd9ec8a

Best regards,
-- 
Esther Shimanovich <eshimanovich@chromium.org>


