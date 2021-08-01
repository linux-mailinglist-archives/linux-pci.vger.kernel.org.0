Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC59C3DCC03
	for <lists+linux-pci@lfdr.de>; Sun,  1 Aug 2021 16:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhHAOZk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Aug 2021 10:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhHAOZk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Aug 2021 10:25:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF70C06175F;
        Sun,  1 Aug 2021 07:25:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso21174889pjf.4;
        Sun, 01 Aug 2021 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3TdIfUE1vHBHBg5ARypMvKXE/Ywe1XabexhsHIfEbiE=;
        b=YGKvwTDXSvFuOYqP6PyXviyvPiqYe6FMURYDVDML84me2Y9CHpelrf0j8s+wGNWBib
         gih8gJmgAfwlUKlaO8H6Z70yexA8Xd1oZSrZ6rPHIrwUyLZ0DHGxlC6NtoHykgBD8L6G
         230EfFjtWDn8E2n/NP3TPgQ/fGClZDOcStjYAGEpyjcIlOLcFoozHtTy9hSJOHoovPV1
         1RWjNiKUkcfmkKibH0fSOMIKKMYahd/htXHy0kPsjJudsHXkSe8VN7L7GkCOocsjw1GN
         0skPmGQxVAqAFkF7OUkLsDuzCIQCEUj1EFQn9yLXYbWWuvbWrv+Of5oaE0vByV9gM02x
         M8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3TdIfUE1vHBHBg5ARypMvKXE/Ywe1XabexhsHIfEbiE=;
        b=dKnTKo1oAnNcQoPnirzk3vJtp1JMQYvvwb5RZRvpF7AMpHSPZ4m+ypAEp/Y+ibNmvl
         LbJcfEwlkd7z91ZtWBMmccdBRelz5c2fdOrkAwPnh9txq3dujOeSZ+te+jUCyQP3rddF
         Rludebx7FOAcijDpNdLTQZvBrl5NEshz/uz/UUoMlHBHsqLC3f8zR3YgJIJUKy6ZpeVa
         GvE0294L3SewXSIlZK2GEnGe4880MJgDHCNiPo9gAYasSq80VmAeHuZXOxbXqnKhAkA1
         K+4nNsVaw8XObjAOBirCnBy5fc98TTcQpZVkceWUYwdZhDqfqGvN9OX1tszducPYCwaL
         Xhzw==
X-Gm-Message-State: AOAM5316rKlVqXu0TuOQIFTPQSIsduKXzXQzkrpRRqpkJnZEyOClOkqG
        wrJTSBh2AJYRZJ+Z7KrvL+8=
X-Google-Smtp-Source: ABdhPJwkjYtKASUlE9vLsHisJxhPbTvAakoaVfNEOrwGRjsgo+EZJe1zSpTW58yIs8/TBy2iAylFJA==
X-Received: by 2002:a62:d14b:0:b029:353:f8a7:2a10 with SMTP id t11-20020a62d14b0000b0290353f8a72a10mr12727277pfl.72.1627827932185;
        Sun, 01 Aug 2021 07:25:32 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.186])
        by smtp.googlemail.com with ESMTPSA id g11sm7740897pju.13.2021.08.01.07.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 07:25:31 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v13 1/9] PCI: Cache PCIe FLR capability
Date:   Sun,  1 Aug 2021 19:55:10 +0530
Message-Id: <20210801142518.1224-2-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801142518.1224-1-ameynarkhede03@gmail.com>
References: <20210801142518.1224-1-ameynarkhede03@gmail.com>
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

