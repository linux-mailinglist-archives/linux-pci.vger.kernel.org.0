Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB9AE11BA8D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 18:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfLKRpR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 12:45:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41033 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbfLKRpR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2019 12:45:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so25025481wrw.8
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2019 09:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CD4p8fYxiMicDD4MIq7mi7uX8xuegn7mjnir6hlrD64=;
        b=swpPbwWuFcZFgvGvdXxrIJCqS0RA1Hgfg2IMSaAWJaJb2codc1799GQJO8o6ScQxCe
         TgyVIr5wuRoVcgVrcFFBo3GKdZ+QbIrnuYf2IiPye66b/xuM3TJB2iobcfQFA6tyOJmd
         2Ollz/UHsd4kUEISvo9w27J7fOuCj/Ag5gmtuIsnPHY/DbvLH4rn839Hgv1jyMhYcnqG
         CXsrtbINV9xtIJF8rL8fBxM3acxOD0QBAgcypP+Ra5D7fgnMcvwtU2HFfR2QxheQ8EOl
         WAcStG8AOt4neGXqwXg6jgYe5WBIOy1rY9OAgqp1pz2pEEDOfIMEIhbjFW8Sa+qNMCjL
         3F4g==
X-Gm-Message-State: APjAAAVHzQ5XxeMi9ALkcpcQAQ4DSbOmf+txC7FHg3WjejidIHPLf26u
        0iezZZP7gWMG1/rQFOXX9zKIuMW6
X-Google-Smtp-Source: APXvYqykpoTeCD/ymvARXcUmyXc+hJXoByaotglh7QqX19MUS/bSRgjRvLQSTr1Qg5uTQrsqCqh/HQ==
X-Received: by 2002:adf:9104:: with SMTP id j4mr1050473wrj.221.1576086314469;
        Wed, 11 Dec 2019 09:45:14 -0800 (PST)
Received: from liuwe-devbox-debian.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.104.231.240])
        by smtp.gmail.com with ESMTPSA id p17sm3060005wrx.20.2019.12.11.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 09:45:13 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     helgaas@kernel.org, rjui@broadcom.com, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH] PCI: iproc: move quirks to driver
Date:   Wed, 11 Dec 2019 17:45:11 +0000
Message-Id: <20191211174511.89713-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The quirks were originally enclosed by ifdef. That made the quirks not
to be applied when respective drivers were compiled as modules.

Move the quirks to driver code to fix the issue.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
Feel free to change the commit message as you see fit.
---
 drivers/pci/controller/pcie-iproc-platform.c | 24 ++++++++++++++++++
 drivers/pci/quirks.c                         | 26 --------------------
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index ff0a81a632a1..4e6f7cdd9a25 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -19,6 +19,30 @@
 #include "../pci.h"
 #include "pcie-iproc.h"
 
+static void quirk_paxc_bridge(struct pci_dev *pdev)
+{
+	/*
+	 * The PCI config space is shared with the PAXC root port and the first
+	 * Ethernet device.  So, we need to workaround this by telling the PCI
+	 * code that the bridge is not an Ethernet device.
+	 */
+	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
+
+	/*
+	 * MPSS is not being set properly (as it is currently 0).  This is
+	 * because that area of the PCI config space is hard coded to zero, and
+	 * is not modifiable by firmware.  Set this to 2 (e.g., 512 byte MPS)
+	 * so that the MPS can be set to the real max value.
+	 */
+	pdev->pcie_mpss = 2;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
+
 static const struct of_device_id iproc_pcie_of_match_table[] = {
 	{
 		.compatible = "brcm,iproc-pcie",
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4937a088d7d8..202837ed68c9 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2381,32 +2381,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
 			 PCI_DEVICE_ID_TIGON3_5719,
 			 quirk_brcm_5719_limit_mrrs);
 
-#ifdef CONFIG_PCIE_IPROC_PLATFORM
-static void quirk_paxc_bridge(struct pci_dev *pdev)
-{
-	/*
-	 * The PCI config space is shared with the PAXC root port and the first
-	 * Ethernet device.  So, we need to workaround this by telling the PCI
-	 * code that the bridge is not an Ethernet device.
-	 */
-	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
-		pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
-
-	/*
-	 * MPSS is not being set properly (as it is currently 0).  This is
-	 * because that area of the PCI config space is hard coded to zero, and
-	 * is not modifiable by firmware.  Set this to 2 (e.g., 512 byte MPS)
-	 * so that the MPS can be set to the real max value.
-	 */
-	pdev->pcie_mpss = 2;
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
-#endif
-
 /*
  * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
  * hide device 6 which configures the overflow device access containing the
-- 
2.20.1

