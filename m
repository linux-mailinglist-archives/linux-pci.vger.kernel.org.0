Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58973E1979
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 18:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhHEQ37 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 12:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbhHEQ35 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Aug 2021 12:29:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F85C0613D5;
        Thu,  5 Aug 2021 09:29:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so16122971pjb.2;
        Thu, 05 Aug 2021 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3TdIfUE1vHBHBg5ARypMvKXE/Ywe1XabexhsHIfEbiE=;
        b=Vp7c1eXJgZ8MYKyFGMe1RUpN1gtDESYHPKERe1lvxkY1DwkACbaHumJXBaCRfo2Rt7
         iqskmOVmI8wCOvi3hyTTMegTSpy3/foIR0OAd9+S1BfwG7aBYLQdupe/ERBelBeN4e+y
         G3720z5ecNfPGLbHhcADSc+yAzQ8Oa1JM+YVjjx7kLfK+b1mis5vKqlQssiVxn5EIE5U
         ZZni2ojqFJp9A8CTZJTRh7PkaKI7vgtTiniM0/M+BemtgA/7Bx4kRNm1+66bKYmnZuu2
         ZW9bbEPEf8PPIwvCYNvYqDMYdCn10Xz5SU0pq8rIOszKotLKUx3yWlp2Jwf/Izpy3iX2
         Y+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3TdIfUE1vHBHBg5ARypMvKXE/Ywe1XabexhsHIfEbiE=;
        b=DRAQyMk3lgt4lPSiejNCTzQXeWaLfl06KQ7+B3bIU27zT79Q8xG2yOzAfKCHrH4zwt
         uZtehHSJEIXWglF/5CetJyMPxs1pkFP1Swd8E4lJwVwSXUP03u/3UTr9VhAzvkRDJDIi
         UZjmpDUQR7VDobi8YODWiqeIpcWTdW38NgD1UBvi784xl3Y2xht/u0kYwRGc8QwW2zlQ
         mhNehE+CYBpnb60jxSA2IbOoKRwGuu52dcCJLddIh5vOiyhhHA2FFWbUqb3fhZaRfQBv
         5pO/yIY/7t44qTGHwjpiJiJhyNaDKW1Wfyc4KUW4+M12EMNXdndM96EtMewywayCkiCM
         R2lA==
X-Gm-Message-State: AOAM53353EtYOnfE2vWaJ1VEdDFX0TonYAMHdYF0RsXDRpRWoldAoJ6R
        7mNx3bkjg7vvEwNBqqBYCxs=
X-Google-Smtp-Source: ABdhPJwLXEJEkLZvFdMbzzeQ9cQTkItK8H0YFqpK1g5/yeofTNt3WU+mzkaWZa9luab799LLgodYCA==
X-Received: by 2002:a65:6a4c:: with SMTP id o12mr171544pgu.108.1628180981597;
        Thu, 05 Aug 2021 09:29:41 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.161])
        by smtp.googlemail.com with ESMTPSA id nr6sm62551pjb.39.2021.08.05.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 09:29:41 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v15 1/9] PCI: Cache PCIe FLR capability
Date:   Thu,  5 Aug 2021 21:59:09 +0530
Message-Id: <20210805162917.3989-2-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805162917.3989-1-ameynarkhede03@gmail.com>
References: <20210805162917.3989-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new member called devcap in struct pci_dev for caching the device
capabilities to avoid reading PCI_EXP_DEVCAP multiple times.

Refactor pcie_has_flr() to use cached device capabilities.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/pci/pci.c   | 6 ++----
 drivers/pci/probe.c | 5 +++--
 include/linux/pci.h | 1 +
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 452351025a09..1fafd05caa41 100644
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
index 3a62d09b8869..df3f9db6e151 100644
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
index c20211e59a57..697b1f085c7b 100644
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

