Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1107C20D7B9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jun 2020 22:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbgF2TcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 15:32:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:36740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730958AbgF2Tb1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 15:31:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0060BAE7F;
        Mon, 29 Jun 2020 16:19:01 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, robh@kernel.org,
        wahrenst@gmx.net, p.zabel@pengutronix.de, andy.shevchenko@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mathias.nyman@linux.intel.com, lorenzo.pieralisi@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v5 9/9] Revert "PCI: brcmstb: Wait for Raspberry Pi's firmware when present"
Date:   Mon, 29 Jun 2020 18:18:45 +0200
Message-Id: <20200629161845.6021-10-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629161845.6021-1-nsaenzjulienne@suse.de>
References: <20200629161845.6021-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 44331189f9082c7e659697bbac1747db3def73e7.

Now that the VL805 init routine is run through a reset controller driver
the device dependencies are being taken care of by the device core. No
need to do it manually here.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7730ea845ff2..752f5b331579 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -28,8 +28,6 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
-#include <soc/bcm2835/raspberrypi-firmware.h>
-
 #include "../pci.h"
 
 /* BRCM_PCIE_CAP_REGS - Offset for the mandatory capability config regs */
@@ -931,26 +929,11 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node, *msi_np;
 	struct pci_host_bridge *bridge;
-	struct device_node *fw_np;
 	struct brcm_pcie *pcie;
 	struct pci_bus *child;
 	struct resource *res;
 	int ret;
 
-	/*
-	 * We have to wait for Raspberry Pi's firmware interface to be up as a
-	 * PCI fixup, rpi_firmware_init_vl805(), depends on it. This driver's
-	 * probe can race with the firmware interface's (see
-	 * drivers/firmware/raspberrypi.c) and potentially break the PCI fixup.
-	 */
-	fw_np = of_find_compatible_node(NULL, NULL,
-					"raspberrypi,bcm2835-firmware");
-	if (fw_np && !rpi_firmware_get(fw_np)) {
-		of_node_put(fw_np);
-		return -EPROBE_DEFER;
-	}
-	of_node_put(fw_np);
-
 	bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENOMEM;
-- 
2.27.0

