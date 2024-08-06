Return-Path: <linux-pci+bounces-11395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B08949A51
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 23:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2349281B29
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 21:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA2414F9D7;
	Tue,  6 Aug 2024 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PvfEEwFS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B89157487
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2024 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980356; cv=none; b=O9vapssUBFLojrA3JijLiKcWQz3M5y23+k5atIXpki+5gF3bpsvigqi1UdXxByIt83TSkiYdZjLjqBP9xIikLZ7w88kNHZMgXjRfgEhK0hablZ59/BpnimX2H2nc0tPh2172uVSDPjYVOu30kCWGkMAcDEMKL160e5u2EdHzsVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980356; c=relaxed/simple;
	bh=jhPWURczYq1JIjUG6nkqvP4l5fXtaUACxUQiT2UsEwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=omzYKsGQzotDDXQtEYyn7zQKO2T37qKNMaoxQzbJFcVVZu4Z275ubaA4LL3emMTvic7WsY9t+kTSXme9aP8RTiGhH4lyhM4lj1ntq77DKkwV7io0wWszotns276CTepQNXQxcFuqwXSIbPD9I2Un24a3TH72jRCcwU8YI6DWbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PvfEEwFS; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4f6b67d9608so517639e0c.2
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2024 14:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722980353; x=1723585153; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cC2MUEziPyHrxjF/4oyBV4C6u5/4UBlCDA1eit8Ed0A=;
        b=PvfEEwFSLwIpKdsA/PIxLu8c8nvzOMIh4zWrcD3bofdy1OTCVW/jvymZZ2ZO27qtu7
         2p38zL9pwA5y9+wvRf7qDCX5ZmcrnnYGuyAGK8VeyIq7ZyNQ9Mn3Wn+i5EkukGC3i4TR
         g5i5tRXWYakcLUqrf0hqAkrateCsaosEiERBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722980353; x=1723585153;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cC2MUEziPyHrxjF/4oyBV4C6u5/4UBlCDA1eit8Ed0A=;
        b=q1cUXlvxSVwtKAn6Vx+c8brioL4Pe3e50ElFDM7u+uAas+wf7Eu5tYpnas8bbI9poJ
         X/n+v2g7oeYaFBl9BbHYnHuIBqElsuDnUtjZVnDP3uCcQqXzjBZKGWuRqfoygLR6Xv97
         tkT9O0Qmg8McXBCP2/GqHGFbbNmlPOCaPYcBu+21vX8fLH52ztdt2X5dojZXqgVdN5Yw
         QASXLC7wjhwJF11qAnouYIyUxBUyubZKdu/VYqecE5kX0vyG7v6Av/KvFD6qcdusjun4
         vpp3WDyd4C0E1dHsnWNq+7PWeBt0KVCTcqEqFFmF2C3p63QiUlq9iO7d+PoB8+x3G4+U
         /oVg==
X-Forwarded-Encrypted: i=1; AJvYcCUEFlkBeH3gUJg//nRWnmIMEW1ULCSwiEVMO+3ar3eI/jg64OHHMwCzDVq5fe2XwfroDp8yXT0zTbpzszqO3e8U3KQgF0gcahwr
X-Gm-Message-State: AOJu0YzZgicLT9d2wgTV7N21UfH5MtuOZcOYjn9497OflggRkY7SmyZb
	oszDryy7+gjppEPwfDC0NBEOR/aCiL+3cjsSZswgZU0MpX9RuVSarCCieJDEXg==
X-Google-Smtp-Source: AGHT+IEEhx9QaLR2TAlx72AtCrrpoDMq7UEfngeztb3Z0bHaJ0ijrO8QWI/zuVE5VFf4lA8ClFpJew==
X-Received: by 2002:a05:6122:1e13:b0:4f6:ae34:9659 with SMTP id 71dfb90a1353d-4f89ff2fad8mr20195763e0c.5.1722980353078;
        Tue, 06 Aug 2024 14:39:13 -0700 (PDT)
Received: from spinny.c.googlers.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f8a1a7ef02sm1352224e0c.26.2024.08.06.14.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 14:39:12 -0700 (PDT)
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Tue, 06 Aug 2024 21:39:11 +0000
Subject: [PATCH] PCI: Detect and trust built-in TBT chips
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org>
X-B4-Tracking: v=1; b=H4sIAP6XsmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwMz3ZKi0uIS3ZKkEt20zApd0zRjY/O0FMvUZItEJaCegqJUoDDYvOj
 Y2loA9ghqm18AAAA=
To: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
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

Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
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
https://lore.kernel.org/lkml/20240510052616.GC4162345@black.fi.intel.com/#r
I refactored it and am submitting as a new patch.
---
 drivers/pci/probe.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 142 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..30de2f6da164 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1629,16 +1629,147 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
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
+	/*
+	 * If the device has a PCIe type, that means it is part of a PCIe
+	 * switch.
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
+	 * For USB4 the tunneled PCIe root or downstream ports are marked
+	 * with the "usb4-host-interface" property, so we look for that
+	 * first. This should cover the most cases.
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
+	 * before Alder Lake do not have the above device property so we
+	 * use their PCI IDs instead. All these are tunneled. This list
+	 * is not expected to grow.
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
+	 * "ExternalFacingPort". These PCIe devices are used to add Thunderbolt
+	 * capabilities to CPUs that lack integrated Thunderbolt.
+	 * These are not behind a PCIe tunnel.
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
+		dev->untrusted = true;
+
+	if (pcie_is_tunneled(dev))
 		dev->untrusted = true;
 }
 
@@ -1646,8 +1777,10 @@ static void pci_set_removable(struct pci_dev *dev)
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
@@ -1657,8 +1790,10 @@ static void pci_set_removable(struct pci_dev *dev)
 	 * accessible to user / may not be removed by end user, and thus not
 	 * exposed as "removable" to userspace.
 	 */
-	if (parent &&
-	    (parent->external_facing || dev_is_removable(&parent->dev)))
+	if (dev_is_removable(&parent->dev))
+		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
+
+	if (pcie_is_tunneled(dev))
 		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
 }
 

---
base-commit: 3f386cb8ee9f04ff4be164ca7a1d0ef3f81f7374
change-id: 20240806-trust-tbt-fix-5f337fd9ec8a

Best regards,
-- 
Esther Shimanovich <eshimanovich@chromium.org>


