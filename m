Return-Path: <linux-pci+bounces-12129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AF495D3C0
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 18:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F8C1C21C89
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FAF18BB93;
	Fri, 23 Aug 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YDx2EycJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580D18CC0A
	for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432001; cv=none; b=V5caSSDpl1aD1YcLaO47xDc42a3CtKacYN0Q6JK/GmpmAahci5EbtT8WloCiCLunF0T/Jt6MmB9uHha53lbPZ+iDJenXiDzwMOcUy3ysBrKThFSVxJt87FVWN8RiF8y1ABq8ZsFkhoEvc6uTA5/R19mCEuZCCbcwwAI5++p039c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432001; c=relaxed/simple;
	bh=bKRa6yRPfDIpbcjiOCb5La0JBN13/7clHUgLehwi//c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ldNADObXPU9IZR/XGApL/65YpBygpboXO0531pfxaZTuWrrADQo0Xx8LPa2Thl7p6o+6lM6+L8NFjpORKGtqgnwxJqQ2FHfYkk5MfDV/vYVlvfKKn5x8B2o1PeL2O2zQ0vNC5xB+FJWG4+xyKwD7LF9t8N5Sb6DCHBVkMqvCl/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YDx2EycJ; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-498d7c77e91so736474137.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724431998; x=1725036798; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1GfA3ULtplaIEuIpPw97nZ2Ifwid/+2uSwId89uCLwQ=;
        b=YDx2EycJMlLOJzqR7sFgfrU9E0y82uPrv2dRThngBgxSzwQXA7Qg4Gw/m1datoIrWb
         e1YQ3XgArHOmE3giSkcP56C6HFUycBKA4Xt/dl5geYdcMLJGu9R7vBAhxGZnNUTi2Fbw
         R/V3zbvb1UmBAIFaIBj9gOW+6dwCot3zyN0+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724431998; x=1725036798;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GfA3ULtplaIEuIpPw97nZ2Ifwid/+2uSwId89uCLwQ=;
        b=clcYMZLn3QFh9SE4XiG2ioAa6+wWCZcwy4Kxi/7Ln2LFEsezTBtMMkcvK+litlvkGe
         RuC1Wq5e6OKyzWJdihcaB1ssbH03yGFZkkDTe+Gz/5AoYZaY0xI4CP4dC+fJ0lB0EzL9
         tsPYu9Mk5Ug3hCENFsa/PDRf1pcKqclMCFWeOLeDBVumpe6vIpYaoRPGhit+AuIcuAl2
         j0KMf41ETpIZ22nkFlYra0zzvyt6SpTRTnPU1COP7gNcX+lBl3Ca11pbadr8t0jEZVWa
         hkiJTL9T8tDGBnIik9VUzJ0FERWV+71aHL/zoODtW9KNVf5koQ2Ic109bm9ntJqI7icB
         fc+g==
X-Forwarded-Encrypted: i=1; AJvYcCUno0DZQBTmXUvYzL6s3lx3MPhE5SipGySYFtXdo+P12dwsT0P0sNE53tlsbR7j8Mgl/tE6arnWHBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCqbPU4Gae9baaxWyF4B15ZnhRmjPf9EX9WvIvOPE0EfkQ+Ef
	iL6Kqn7iQ0EWrtJjWqReUQp78a2s8trnLu7GZOlvzWpSxy84j42wtYa2b0y+4Q==
X-Google-Smtp-Source: AGHT+IGwj0F5JNIey6gEkD1rL+ZBWRqjC5PEbwAOO98iIc7ECYvtqFhOQvyrcd1TnEINv/AUHFC/KQ==
X-Received: by 2002:a05:6102:3907:b0:48f:8ead:7b7 with SMTP id ada2fe7eead31-498f4c1c5dcmr3339281137.21.1724431997751;
        Fri, 23 Aug 2024 09:53:17 -0700 (PDT)
Received: from spinny.c.googlers.com (78.206.23.34.bc.googleusercontent.com. [34.23.206.78])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-498e48c9d58sm609859137.21.2024.08.23.09.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:53:17 -0700 (PDT)
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Fri, 23 Aug 2024 16:53:16 +0000
Subject: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240823-trust-tbt-fix-v4-1-c6f1e3bdd9be@chromium.org>
X-B4-Tracking: v=1; b=H4sIAHu+yGYC/3XMuw6CMACF4Vchna3pneLkexiH0gt0AExbGg3h3
 S1MhOj4n+R8C4g2eBvBrVpAsNlHP40l2KUCuldjZ6E3pQFBhCGJBExhjgmmNkHn35A7SmtnGqu
 lAuXzCrbMu/d4lu59TFP47HzG2/pPyhhiWFNluWNMGK7uug/T4OfhOoUObFgmR0CeAVIAYilTi
 KsGS/EDoAcA8zNACyBahcqXG870CVjX9Qu0HiVhLwEAAA==
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
 drivers/pci/probe.c | 145 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 138 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..816f1f879fa3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1629,25 +1629,152 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
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
+static bool pcie_is_tunneled(struct pci_dev *pdev)
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
+	if (parent->untrusted)
 		dev->untrusted = true;
+
+	if (pcie_is_tunneled(dev)) {
+		pci_dbg(dev, "marking as untrusted\n");
+		dev->untrusted = true;
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
@@ -1657,9 +1784,13 @@ static void pci_set_removable(struct pci_dev *dev)
 	 * accessible to user / may not be removed by end user, and thus not
 	 * exposed as "removable" to userspace.
 	 */
-	if (parent &&
-	    (parent->external_facing || dev_is_removable(&parent->dev)))
+	if (dev_is_removable(&parent->dev))
+		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
+
+	if (pcie_is_tunneled(dev)) {
+		pci_dbg(dev, "marking as removable\n");
 		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
+	}
 }
 
 /**

---
base-commit: 3f386cb8ee9f04ff4be164ca7a1d0ef3f81f7374
change-id: 20240806-trust-tbt-fix-5f337fd9ec8a

Best regards,
-- 
Esther Shimanovich <eshimanovich@chromium.org>


