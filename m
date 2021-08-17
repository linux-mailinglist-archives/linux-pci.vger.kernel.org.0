Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A2E3EF148
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 20:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhHQSFr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 14:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhHQSFq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 14:05:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD13C061764;
        Tue, 17 Aug 2021 11:05:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e15so25714713plh.8;
        Tue, 17 Aug 2021 11:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64aDvN9oKekcubnbTh6hlBJyjfJ9jTD8l/UAKBhqJ40=;
        b=SeTrUriXHM4d+Vksu1xKcmwzC3t1Q6DWcjvPQM2j/919V+OGAhPi/D/cS3wZTt4oZv
         HK4VwileVCgHaSLaQ/iVwHyDspTFWdlzTzTP507oPko1nahHujIEq8d572r0btLNMA0z
         Sd2765GGzmWs5v1cx7+P4djf639sQS1ufoSeavaEr6OjnQKdS7PC2cx5YKvvAFiALeBN
         H8qM4VabJwICiDZIp7kDw2ydGxMJSxTpApd/0QTaFrfWvjL8ByAjS9KHFIR73n8uv/1n
         5QJkkcpq2dOKV77fREvn2lBWh2wIFAaUBU/zTjk+RiuiYQ1tJilaqpaRK4C66XBffQk1
         Hw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64aDvN9oKekcubnbTh6hlBJyjfJ9jTD8l/UAKBhqJ40=;
        b=A5GhczzgVxYX7wsAzfyQubYHQTqVLYoSuMX3MMlZNnb+8Z4Tk+3J0+AAdUOFp9kKkR
         nGZxdZUgfhY2HNiqCeweOaRiTwJa0vErTMXDPiW/5/Clj+9ZFDRZhEO5k0sRKTWVaJjO
         AFoOEUdIcAku5M6g6pYQkGuaoSmcmS0e4rJcjxVxXOR8dl4LzmPVkDN9Pptk9tDh99Nx
         muL5VeixudHe/mj7vxsmmI4W0j97OvdQUXw41evIA9rREMPKwsl7NSiEVxWdSqQ0SNwv
         kpEnpo7u+PY8Hd6ee4j9RKDHOWq3fqsS0UCmJV00V2DY2wrihUliOAtgcKcipgjHm4sL
         FHBg==
X-Gm-Message-State: AOAM532TYDj9TgT8afGgd6jeOeQ9373fvi7835zOO0eI4iArlnbA496P
        aH9+P9JXYKqQ1b/pIpd3cHg=
X-Google-Smtp-Source: ABdhPJy0N4ASmJ27LXenrrtRUjqvTnRNIN/lSd8Brtlc/l2l+7XCYo3vNnpuI3FuoQG28I3dGtNq9A==
X-Received: by 2002:aa7:8b07:0:b029:3c7:c29f:9822 with SMTP id f7-20020aa78b070000b02903c7c29f9822mr4732765pfd.33.1629223513211;
        Tue, 17 Aug 2021 11:05:13 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.158])
        by smtp.googlemail.com with ESMTPSA id 65sm4065632pgi.12.2021.08.17.11.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:05:12 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v16 1/9] PCI: Cache PCIe FLR capability
Date:   Tue, 17 Aug 2021 23:34:52 +0530
Message-Id: <20210817180500.1253-2-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817180500.1253-1-ameynarkhede03@gmail.com>
References: <20210817180500.1253-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new member called devcap in struct pci_dev for caching the device
capabilities to avoid reading PCI_EXP_DEVCAP multiple times.

Refactor pcie_has_flr() to use cached device capabilities.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 drivers/pci/pci.c   | 6 ++----
 drivers/pci/probe.c | 5 +++--
 include/linux/pci.h | 1 +
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 452351025..1fafd05ca 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -31,6 +31,7 @@
 #include <linux/vmalloc.h>
 #include <asm/dma.h>
 #include <linux/aer.h>
+#include <linux/bitfield.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -4620,13 +4621,10 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
  */
 bool pcie_has_flr(struct pci_dev *dev)
 {
-	u32 cap;
-
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return false;
 
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
-	return cap & PCI_EXP_DEVCAP_FLR;
+	return FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap) == 1;
 }
 EXPORT_SYMBOL_GPL(pcie_has_flr);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3a62d09b8..df3f9db6e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -19,6 +19,7 @@
 #include <linux/hypervisor.h>
 #include <linux/irqdomain.h>
 #include <linux/pm_runtime.h>
+#include <linux/bitfield.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -1497,8 +1498,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_cap = pos;
 	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
 	pdev->pcie_flags_reg = reg16;
-	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
-	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
+	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
+	pdev->pcie_mpss = FIELD_GET(PCI_EXP_DEVCAP_PAYLOAD, pdev->devcap);
 
 	parent = pci_upstream_bridge(pdev);
 	if (!parent)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c20211e59..697b1f085 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -333,6 +333,7 @@ struct pci_dev {
 	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
 	struct pci_dev  *rcec;          /* Associated RCEC device */
 #endif
+	u32		devcap;		/* PCIe device capabilities */
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
 	u8		msix_cap;	/* MSI-X capability offset */
-- 
2.32.0

