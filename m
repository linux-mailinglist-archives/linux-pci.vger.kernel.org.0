Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054F2E2342
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 21:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391060AbfJWTWX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 15:22:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36823 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389907AbfJWTWW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Oct 2019 15:22:22 -0400
Received: by mail-ot1-f66.google.com with SMTP id c7so7677243otm.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2019 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=AWSzxloZFjqBSYPavsipaCsXnn7FGNC3x2RIp+ASNJ8=;
        b=y0ZJLr+cgueiZO+fvCl5wIdEf3wPufsEH3or0+C0r5plqTxF1gFC/WLiGlDAkykQhC
         ag8VtmVwHXOSW8923OLMhCe1w9F4ChfzgZeulr2vEzCCTuUyiV5WOFki57obZ/R95fDz
         QYHccMqGnIjqC3R4ZHQR/6bW6rpvDnP5r2I3H+bzcou2XpyFOt/Ml+IMaEEZ8vrk+rNt
         TYeHQZ70HuC30AuFX6ekWQ6nXUcyWoB1TkYV8urrgfx0ouxJzxoUZEU6pMXUYVsfWsIt
         B0VccJ/4phWLs9Ow9ky4hzFnDr3sJaBu4zGPHBZ7grhiUiYILikWh/fbHSyMxj33k/80
         gVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AWSzxloZFjqBSYPavsipaCsXnn7FGNC3x2RIp+ASNJ8=;
        b=Y2erTJ7xYU2YCrOvmQaO8pi2iJSN6udAEp66/DiDhbxL3Jvi/HjAZdCos0wb2qY+0U
         JL7LKGvXLSgzNWIbAA6P15bYIyTLu+7V+1AH5YAaMNZEDGGfKvdP1nXZJTBWJlWYbUnQ
         8lEbih+HCTOV/1pImTjE5vX1cWJE8YoaLpj7KhI+KaiIlQLy0C0C1TXV2xAriw/6zHiT
         wJyS62PuAxLXv4MbzNdwWIfZhOh6U3Pi9x2ei2ebuPUBn98VHMuWX5sE3BanUw0V1kxv
         JTs+bo01NBf00IMZpDijR9OxD7YbwgsLHwRgoiTO4CPvg7uwT1aVLdBNGIEbRO/DHSsW
         U82g==
X-Gm-Message-State: APjAAAWM/+HWBtBYGbBPafGzSsIReunbO9bQxLKNotgq/f5naI5ezh9u
        coX6jTFOvuhD+jqibTIYEsrRGw==
X-Google-Smtp-Source: APXvYqykmlBWzvgJXmGine00U7/POyerlUZvysm+7sDg/xeN7uvm3sWMkXfvTaV+4GZ862hIFPTEow==
X-Received: by 2002:a9d:3476:: with SMTP id v109mr8496480otb.211.1571858541669;
        Wed, 23 Oct 2019 12:22:21 -0700 (PDT)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id d25sm5783461oic.23.2019.10.23.12.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 12:22:20 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH] PCI/DPC: Add pcie_ports=dpc-native parameter to bring back old behavior
Date:   Wed, 23 Oct 2019 12:22:05 -0700
Message-Id: <20191023192205.97024-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In commit eed85ff4c0da7 ("PCI/DPC: Enable DPC only if AER is available"),
the behavior was changed such that native (kernel) handling of DPC
got tied to whether the kernel also handled AER. While this is what
the standard recommends, there are BIOSes out there that lack the DPC
handling since it was never required in the past.

To make DPC still work on said platforms the same way they did before,
add a "pcie_ports=dpc-native" kernel parameter that can be passed in
if needed, while keeping defaults unchanged.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 drivers/pci/pcie/dpc.c                          | 2 +-
 drivers/pci/pcie/portdrv_core.c                 | 7 ++++++-
 drivers/pci/pcie/portdrv_pci.c                  | 8 ++++++++
 include/linux/pci.h                             | 2 ++
 5 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5e27d74e2b74b..e0325421980aa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3548,6 +3548,7 @@
 			even if the platform doesn't give the OS permission to
 			use them.  This may cause conflicts if the platform
 			also tries to use these services.
+		dpc-native	Use native PCIe service for DPC, but none other.
 		compat	Disable native PCIe services (PME, AER, DPC, PCIe
 			hotplug).
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a32ec3487a8d0..e06f42f58d3d4 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -291,7 +291,7 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 ctl, cap;
 
-	if (pcie_aer_get_firmware_first(pdev))
+	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
 		return -ENOTSUPP;
 
 	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 1b330129089fe..c24bf6cac4186 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -250,8 +250,13 @@ static int get_port_device_capability(struct pci_dev *dev)
 		pcie_pme_interrupt_enable(dev, false);
 	}
 
+	/*
+	 * With dpc-native, we set it if AER is available, even if AER is
+	 * handled by firmware.
+	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
+	    pci_aer_available() &&
+	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 0a87091a0800e..b415656519a73 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -29,12 +29,20 @@ bool pcie_ports_disabled;
  */
 bool pcie_ports_native;
 
+/*
+ * If the user specified "pcie_ports=dpc-native", use the PCIe services
+ * for DPC, but cuse platform defaults for the others.
+ */
+bool pcie_ports_dpc_native;
+
 static int __init pcie_port_setup(char *str)
 {
 	if (!strncmp(str, "compat", 6))
 		pcie_ports_disabled = true;
 	else if (!strncmp(str, "native", 6))
 		pcie_ports_native = true;
+	else if (!strncmp(str, "dpc-native", 10))
+		pcie_ports_dpc_native = true;
 
 	return 1;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fc1844061e88f..603d4822757b6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1534,9 +1534,11 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 #ifdef CONFIG_PCIEPORTBUS
 extern bool pcie_ports_disabled;
 extern bool pcie_ports_native;
+extern bool pcie_ports_dpc_native;
 #else
 #define pcie_ports_disabled	true
 #define pcie_ports_native	false
+#define pcie_ports_dpc_native	false
 #endif
 
 #define PCIE_LINK_STATE_L0S		BIT(0)
-- 
2.11.0

