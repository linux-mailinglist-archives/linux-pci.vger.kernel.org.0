Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED549AE57
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 09:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379418AbiAYIrf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 03:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451850AbiAYIns (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 03:43:48 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A418C06B5AD
        for <linux-pci@vger.kernel.org>; Mon, 24 Jan 2022 23:18:28 -0800 (PST)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4JjdVp54DYz9skl;
        Tue, 25 Jan 2022 08:18:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: [PATCH v4 1/3] PCI/AER: Call pcie_set_ecrc_checking() for each PCIe device
Date:   Tue, 25 Jan 2022 08:18:18 +0100
Message-Id: <20220125071820.2247260-2-sr@denx.de>
In-Reply-To: <20220125071820.2247260-1-sr@denx.de>
References: <20220125071820.2247260-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make sure that pcie_set_ecrc_checking() is called for each PCIe device,
also when it's hot-plugged. This is done by moving
pcie_set_ecrc_checking() to pci_aer_init().

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pali Rohár <pali@kernel.org>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
Cc: Naveen Naidu <naveennaidu479@gmail.com>
---
v4:
- New patch

 drivers/pci/pcie/aer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9fa1f97e5b27..5585fefc4d0e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -387,6 +387,9 @@ void pci_aer_init(struct pci_dev *dev)
 	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
 
 	pci_aer_clear_status(dev);
+
+	/* Enable ECRC checking if enabled and configured */
+	pcie_set_ecrc_checking(dev);
 }
 
 void pci_aer_exit(struct pci_dev *dev)
@@ -1223,9 +1226,6 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
 			pci_disable_pcie_error_reporting(dev);
 	}
 
-	if (enable)
-		pcie_set_ecrc_checking(dev);
-
 	return 0;
 }
 
-- 
2.35.0

