Return-Path: <linux-pci+bounces-11714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C83953A95
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 21:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336C51C227DF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 19:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DBC7BAEC;
	Thu, 15 Aug 2024 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AYwGJjmR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7937BAF4
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748874; cv=none; b=LePV43YgZ7CQoWaHAtFK/xsic4iTtUk1jPTuMkONV+Iw66Qb+Md0VEcXP3hbGWy2EQIdeJCdAV4/iGWRvSVMGp0ZIQ8DNxkHnIr7y7zDup4CuRMbHjWgaen9G9cw5OQ3bBLUKya4ZnLPMzu8lUDPn72+WkVqatuF5tz8kbYeNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748874; c=relaxed/simple;
	bh=6/w6gGbAnR6cOCpsYWd654PRsspfks/WIgQdHQ80Rc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kfb1wQfh6BWrX6ar+Q6muM8M1br+SztSem32EyPlaoHT1qVjIMr2WePktXT2meYL1Tx4zsIZcZUm5mV8HnSBiWUWUUJL6kA0tpPzqx+y+GeFUkqEvHmbFvdqwL0C2r+YmrNn7pVWy/Pb0bmlLqLAws8urmSTvJ1DAysNegM9VyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AYwGJjmR; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4f887be28e7so427129e0c.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723748871; x=1724353671; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A9CmQGD3BALHaAD+1mPdEDG0RqgpbFh+fv7YL+Tejgk=;
        b=AYwGJjmROgelxFoL9VJW+buv1ScMtFHYOVTcMA3ba0FBxQpYkzL+CzNn7gCHUAO356
         9L3KPWLtEXMY8R7Jp/uv8pyyeQGAbFGtaTj72ECudhkqu7Ep+jo/LXqPynQgah0haKoU
         7hatsv4quZz+zRH5SZuoHnAF+txBki+a9MgiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723748871; x=1724353671;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9CmQGD3BALHaAD+1mPdEDG0RqgpbFh+fv7YL+Tejgk=;
        b=Ff/ZzWNfqFiLT/Sjs3N3fI6lgbIcpFCRMihd/Fq1ed5Qi72EOOM75gbpQgA/j5cAyo
         sVcQgv2ElysE8z7V+lTfIvSHxMKvv6KGidPNqBtvRvGQihVQVtQUKjLc5e+av1xdSDNR
         cgdQ+W2r0cYCM5uTONLqeKBciL94zxEpftC+iA2g4CAeuXKsuWxHbRczOFzV4aK9uXq/
         5UrHNRosFdpJUv7yv4KCqi7tHGEw7k7XeF4MUK2IKnjDCuGFfcQV6aoMGL80zLfjCBg5
         3+DbDwRAlf3VktpVmc6tUB1FwaeksyHPjaCWLohXdHk0obFIBqedhOHvR/6nhy8aQ3Ng
         MQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsMXFTA5fAqhEABvFQNOGtuElb9GlcvvBw3yyJ4bFnOtdxi+F91ZAAy/ndfnGVaA5P1W2uL36o4rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOe3bRf3KCl0rM76Phsm6fZv0lF2Sm52mrGfAg+MJjG3CuS2cO
	KBMI+fGN9dxfjLYeqcwxLMzZViM6nsBAzloV87FQLh3jvz/3fgpOg0MzHhPJP1J2fiWfCQl/Rr4
	=
X-Google-Smtp-Source: AGHT+IGQgGndnTs8qkFnTaVVGn5spCUwZS/Vqhk77yEeXzXZDhb4B1MBePCQ99KeZNa7ugGuaQxiRg==
X-Received: by 2002:a05:6122:2a0e:b0:4f5:199b:2a61 with SMTP id 71dfb90a1353d-4fc6c9b0fb5mr943347e0c.9.1723748871186;
        Thu, 15 Aug 2024 12:07:51 -0700 (PDT)
Received: from spinny.c.googlers.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b8c649bsm207423e0c.1.2024.08.15.12.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 12:07:50 -0700 (PDT)
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Thu, 15 Aug 2024 19:07:44 +0000
Subject: [PATCH v3] PCI: Detect and trust built-in Thunderbolt chips
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-trust-tbt-fix-v3-1-6ba01865d54c@chromium.org>
X-B4-Tracking: v=1; b=H4sIAP9RvmYC/3XMSw6CMBSF4a2QO7amT6iO3IdxUOEWOoCatjQaw
 t4tjAyJw/8k51sgYnAY4VotEDC76PxUQpwqaAcz9UhcVxo45ZJqWpMU5phIeiZi3ZsoK0Rjuwu
 22kD5vAKWeffuj9KDi8mHz85ntq3/pMwII40wqKyUdafMrR2CH908nn3oYcMy/wX0EeAF4Ciko
 cpcmK4PwLquX5E+1f/uAAAA
To: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, iommu@lists.linux.dev, 
 Lukas Wunner <lukas@wunner.de>, 
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
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
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
 drivers/pci/probe.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 146 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..308d5a0e5c51 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1629,25 +1629,160 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
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
+	/* If the device doesn't have a parent, it's not under anything.*/
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
+		if (parent == bridge)
+			return true;
+		break;
+
+	case PCI_EXP_TYPE_DOWNSTREAM:
+		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
+			parent = pci_upstream_bridge(parent);
+			if (parent == bridge)
+				return true;
+		}
+		break;
+
+	case PCI_EXP_TYPE_ENDPOINT:
+		if (pci_pcie_type(parent) == PCI_EXP_TYPE_DOWNSTREAM) {
+			parent = pci_upstream_bridge(parent);
+			if (parent && pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
+				parent = pci_upstream_bridge(parent);
+				if (parent == bridge)
+					return true;
+			}
+		}
+		break;
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
+	parent = pci_upstream_bridge(pdev);
+	/* If pdev doesn't have a parent, then there's no way it is tunneled.*/
+	if (!parent)
+		return false;
+
+	root = pcie_find_root_port(pdev);
+	/* If pdev doesn't have a root, then there's no way it is tunneled.*/
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
@@ -1657,9 +1792,13 @@ static void pci_set_removable(struct pci_dev *dev)
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


