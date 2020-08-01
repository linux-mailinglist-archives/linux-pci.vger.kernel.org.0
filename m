Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A274823510A
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHAHrD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Aug 2020 03:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgHAHrC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2020 03:47:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46000C06174A
        for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2020 00:47:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y206so5288051pfb.10
        for <linux-pci@vger.kernel.org>; Sat, 01 Aug 2020 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ElOKRaHrVWvgkFFIM5c3QvDp6dYwcrCLkC2nurrivNw=;
        b=UzoLoNI+gIetJHPf7c9ExSZXw4/gRcmAo86wCrJt7uTCzdmmMHJGVlV/O2I4ev3iIU
         JmFsAOVMIki1izym7xmTyJ87EphjpXKq6fwQklcb9e/0zvK7kToQBZNt3Jx/TbW72e3a
         vgikOHn/DLvLCJxftYxlf475Ap1MCP2T2OJg2YyZSYRuvLOEUYBlALyrVlE9WC3b43Bq
         NGRuybExA2TZhXEOMiahnw094jOgH4FwKI45/I3v6cR55SaUXQ7JbM/yZUxOIA+6sirq
         kfUI97ErUlDp47VoD+BWv0A/xr5MWu6AaRdsqevuqgQFPPNjnh3iQbhOnS8kVL/K54+3
         TB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=ElOKRaHrVWvgkFFIM5c3QvDp6dYwcrCLkC2nurrivNw=;
        b=N2nRJqE7R43q93eqzhcfxgTFBAjYWHW0boHkOQF+79S7QnyGvPZKuM5UG+DtESZ/2D
         ACzyLGyHWF3DQPYMWlwa9F4ZWve4PFBirRRpn+R3I+9DShYsd2QHq9B5XtpPFqXt5soJ
         GxtDRg6PwlysENKUx60DWoqvKsqcDvA97O7EZaRG/CFxMPi3yWZfrxb1Xsni4CywpaX0
         Q1oCOu5Lx3g/ws05CoqFg5Z/VrOEI4WdSRWWOzz0J7fhm/G7b6FBZr9Qd2r8QK0mxXO4
         5mdf/I5UxbRps3qFKwrltP9uqUXUTxrgJBk8R+RA4Njqjk3+EbV8xSHmtObNQ1JrflQw
         oTHA==
X-Gm-Message-State: AOAM530/bv/4RfcKzuuBfKty5CWnhCHQm/oi4VX3YCxyDp7VHJaWkhh7
        xZ8y3qZC/YRB3oNGEclre4U=
X-Google-Smtp-Source: ABdhPJzZkRwx5Nj1dPGLFee4aXzTrhERSrRWa/xf12jaUVgG3kEpT17JMghNCPTzMATyJgETFBiazQ==
X-Received: by 2002:a63:3c41:: with SMTP id i1mr7173723pgn.349.1596268021498;
        Sat, 01 Aug 2020 00:47:01 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com. [34.92.144.28])
        by smtp.gmail.com with ESMTPSA id y10sm12528365pfp.130.2020.08.01.00.46.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Aug 2020 00:47:01 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH RFC] PCI/portdrv: Don't disable pci device during shutdown
Date:   Sat,  1 Aug 2020 15:49:40 +0800
Message-Id: <1596268180-9114-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use separate remove()/shutdown() callback, and don't disable pci device
during shutdown. This can avoid some poweroff/reboot failures.

The poweroff/reboot failures can easily reproduce on Loongson platforms.
I think this is not a Loongson-specific problem, instead, is a problem
related to some specific PCI hosts. On some x86 platforms, radeon/amdgpu
devices can cause the same problem, and commit faefba95c9e8ca3a523831c2e
("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.

Radeon driver is more difficult than amdgpu due to its confusing symbol
names, and I have maintained an out-of-tree patch for a long time [1].
Recently, we found more and more devices can cause the same problem, and
it is very difficult to modify all problematic drivers as radeon/amdgpu
does. So, I think modify the PCIe port driver is a simple and effective
way.

[1] https://github.com/chenhuacai/linux/commit/6612f9c1fc290d42a14618ce9a7d03014d8ebb1a

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 drivers/pci/pcie/portdrv.h      |  2 +-
 drivers/pci/pcie/portdrv_core.c |  6 ++++--
 drivers/pci/pcie/portdrv_pci.c  | 15 +++++++++++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index af7cf23..22ba7b9 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -123,7 +123,7 @@ int pcie_port_device_resume(struct device *dev);
 int pcie_port_device_runtime_suspend(struct device *dev);
 int pcie_port_device_runtime_resume(struct device *dev);
 #endif
-void pcie_port_device_remove(struct pci_dev *dev);
+void pcie_port_device_remove(struct pci_dev *dev, bool disable);
 int __must_check pcie_port_bus_register(void);
 void pcie_port_bus_unregister(void);
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522..aa165be 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -487,11 +487,13 @@ EXPORT_SYMBOL_GPL(pcie_port_find_device);
  * Remove PCI Express port service devices associated with given port and
  * disable MSI-X or MSI for the port.
  */
-void pcie_port_device_remove(struct pci_dev *dev)
+void pcie_port_device_remove(struct pci_dev *dev, bool disable)
 {
 	device_for_each_child(&dev->dev, NULL, remove_iter);
 	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
+
+	if (disable)
+		pci_disable_device(dev);
 }
 
 /**
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 3acf151..fcd3d2e 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -142,7 +142,18 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 		pm_runtime_dont_use_autosuspend(&dev->dev);
 	}
 
-	pcie_port_device_remove(dev);
+	pcie_port_device_remove(dev, true);
+}
+
+static void pcie_portdrv_shutdown(struct pci_dev *dev)
+{
+	if (pci_bridge_d3_possible(dev)) {
+		pm_runtime_forbid(&dev->dev);
+		pm_runtime_get_noresume(&dev->dev);
+		pm_runtime_dont_use_autosuspend(&dev->dev);
+	}
+
+	pcie_port_device_remove(dev, false);
 }
 
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
@@ -211,7 +222,7 @@ static struct pci_driver pcie_portdriver = {
 
 	.probe		= pcie_portdrv_probe,
 	.remove		= pcie_portdrv_remove,
-	.shutdown	= pcie_portdrv_remove,
+	.shutdown	= pcie_portdrv_shutdown,
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
-- 
2.7.0

