Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B751C5D1C
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 18:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgEEQNb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 12:13:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730190AbgEEQNa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 12:13:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3372DAF7A;
        Tue,  5 May 2020 16:13:31 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 3/4] PCI: brcmstb: Wait for Raspberry Pi's firmware when present
Date:   Tue,  5 May 2020 18:13:16 +0200
Message-Id: <20200505161318.26200-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505161318.26200-1-nsaenzjulienne@suse.de>
References: <20200505161318.26200-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

xHCI's PCI fixup, run at the end of pcie-brcmstb's probe, depends on
RPi4's VideoCore firmware interface to be up and running. It's possible
for both initializations to race, so make sure it's available prior to
starting.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

---

Changes since v6:
- Add more complete comment

 drivers/pci/controller/pcie-brcmstb.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 6d79d14527a6..0b97b94c4a9a 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -28,6 +28,8 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
 #include "../pci.h"
 
 /* BRCM_PCIE_CAP_REGS - Offset for the mandatory capability config regs */
@@ -917,11 +919,26 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node, *msi_np;
 	struct pci_host_bridge *bridge;
+	struct device_node *fw_np;
 	struct brcm_pcie *pcie;
 	struct pci_bus *child;
 	struct resource *res;
 	int ret;
 
+	/*
+	 * We have to wait for Raspberry Pi's firmware interface to be up as a
+	 * PCI fixup, rpi_firmware_init_vl805(), depends on it. This driver's
+	 * probe can race with the firmware interface's (see
+	 * drivers/firmware/raspberrypi.c) and potentially break the PCI fixup.
+	 */
+	fw_np = of_find_compatible_node(NULL, NULL,
+					"raspberrypi,bcm2835-firmware");
+	if (fw_np && !rpi_firmware_get(fw_np)) {
+		of_node_put(fw_np);
+		return -EPROBE_DEFER;
+	}
+	of_node_put(fw_np);
+
 	bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENOMEM;
-- 
2.26.2

