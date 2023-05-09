Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D06FC6A7
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjEIMmE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 08:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjEIMmD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 08:42:03 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76CEAFD;
        Tue,  9 May 2023 05:42:01 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,262,1677510000"; 
   d="scan'208";a="158709368"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 May 2023 21:42:00 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0A78640359CB;
        Tue,  9 May 2023 21:42:00 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v15 02/22] PCI: Add PCI_HEADER_TYPE_MULTI_FUNC
Date:   Tue,  9 May 2023 21:41:36 +0900
Message-Id: <20230509124156.150200-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230509124156.150200-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230509124156.150200-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI_HEADER_TYPE_MULTI_FUNC macro which is "Multi-Function Device"
of Header Type Register.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/probe.c           | 2 +-
 drivers/pci/quirks.c          | 4 ++--
 include/uapi/linux/pci_regs.h | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0b2826c4a832..56f01b48fb81 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1836,7 +1836,7 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->dev.parent = dev->bus->bridge;
 	dev->dev.bus = &pci_bus_type;
 	dev->hdr_type = hdr_type & 0x7f;
-	dev->multifunction = !!(hdr_type & 0x80);
+	dev->multifunction = !!(hdr_type & PCI_HEADER_TYPE_MULTI_FUNC);
 	dev->error_state = pci_channel_io_normal;
 	set_pcie_port_type(dev);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f4e2a88729fd..8ceb970ccf1f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1750,7 +1750,7 @@ static void quirk_jmicron_ata(struct pci_dev *pdev)
 	/* Update pdev accordingly */
 	pci_read_config_byte(pdev, PCI_HEADER_TYPE, &hdr);
 	pdev->hdr_type = hdr & 0x7f;
-	pdev->multifunction = !!(hdr & 0x80);
+	pdev->multifunction = !!(hdr & PCI_HEADER_TYPE_MULTI_FUNC);
 
 	pci_read_config_dword(pdev, PCI_CLASS_REVISION, &class);
 	pdev->class = class >> 8;
@@ -5567,7 +5567,7 @@ static void quirk_nvidia_hda(struct pci_dev *gpu)
 
 	/* The GPU becomes a multi-function device when the HDA is enabled */
 	pci_read_config_byte(gpu, PCI_HEADER_TYPE, &hdr_type);
-	gpu->multifunction = !!(hdr_type & 0x80);
+	gpu->multifunction = !!(hdr_type & PCI_HEADER_TYPE_MULTI_FUNC);
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			       PCI_BASE_CLASS_DISPLAY, 16, quirk_nvidia_hda);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 5d48413ac28f..a302b67d2834 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -80,6 +80,7 @@
 #define  PCI_HEADER_TYPE_NORMAL		0
 #define  PCI_HEADER_TYPE_BRIDGE		1
 #define  PCI_HEADER_TYPE_CARDBUS	2
+#define  PCI_HEADER_TYPE_MULTI_FUNC	0x80
 
 #define PCI_BIST		0x0f	/* 8 bits */
 #define  PCI_BIST_CODE_MASK	0x0f	/* Return result */
-- 
2.25.1

