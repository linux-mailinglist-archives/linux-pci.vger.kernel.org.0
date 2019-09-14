Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB22CB2D24
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2019 23:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfINVai (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Sep 2019 17:30:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50444 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfINVai (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Sep 2019 17:30:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id 5so266018wmg.0;
        Sat, 14 Sep 2019 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JczHJPwUxUzfOEXYUhaXp6IF33XabnHLSQIw2Wsc7cs=;
        b=rBHFcDUVTF6LyVbsOVorK0zcjJtIn3M8QWjapCf7afTdmcA/UVamzLy8YUxJ/M6djK
         z4jMHb06Jsq4mhHqMNZygdi7GYudRtABrXCcBudAiUzcyVKGcFJUmvL7cnswZVB9pv9G
         cMdj769mPjA1kpaL6BoIyCmSCtZ0pD7mYms68IWw/xm2UgmTZUTGo3n/udnA+kcRRYW+
         LvgTVdumRbcJT58FyPuBybyypznDxm8mfUvV6927HQrT+mcwScSwCcJoMpDyGMFCQPjs
         xHNtSBlI0AiBFHX+EVbuBXDtGFCe+TP/lubL7QAXCLz48fASvwII8+8XESxr7l8VfQm5
         MYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JczHJPwUxUzfOEXYUhaXp6IF33XabnHLSQIw2Wsc7cs=;
        b=Ty+daNWtCayOGAE3s5BL2JECY9AccilQiBIxwinuk66pa4WbeTCJ/XcqgRILxnrOuB
         iZ18oCvnawhj5Ihc7+VhBG+Ls9IbJLIZUAoCJdz0XnJEGFRBnpuLo1WymDPDRBGUAg/O
         oyJpglisVL1fz7pN86oUkLwjx0Md22ibpIMSGk3vWQj3N5rb3ba6MuR/xjvuw4LzaZ+4
         M2tgkjlzxNzBHqiJmP+FyHNXQBYKSi3YZopgUkGOwN7+nGYIIkthbM8kPpM/lZoh+vFo
         MAcI6mmSFYAiIwvmqfKYar4uN4j7zNCXcJPLsCGYr7DwkGh6ez5F9kkJxjkHB4T6sccR
         p6aw==
X-Gm-Message-State: APjAAAUBgv4SdkHaevjFyDw21bmRZvMoqrI/Q0rFKFHg3PBSkDdBoFRE
        +XWiNvy7Fz6tvy3eNlbN5Rc=
X-Google-Smtp-Source: APXvYqyoI9Bd7zagG6mqoF/9LiGGwkJQTi/MZwR+3veRaOYS7SFkGAa6sdRzwsnDPSV8HNp/DlKglg==
X-Received: by 2002:a1c:1b14:: with SMTP id b20mr7780590wmb.122.1568496635033;
        Sat, 14 Sep 2019 14:30:35 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id s10sm14403728wmf.48.2019.09.14.14.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 14:30:34 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Move ATS declarations to linux/pci-ats.h
Date:   Sat, 14 Sep 2019 23:30:32 +0200
Message-Id: <20190914213032.22314-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move ATS function prototypes from include/linux/pci.h
to include/linux/pci-ats.h as the ATS, PRI, and PASID
interfaces are related, and are used only by the IOMMU
drivers.  This effecively reverts the change done in
commit ff9bee895c4d ("PCI: Move ATS declarations to
linux/pci.h so they're all together").

Also, remove surplus forward declaration of struct pci_ats
from include/linux/pci.h, as it is no longer needed, since
the struct pci_ats has been embedded directly into struct
pci_dev in the commit d544d75ac96a ("PCI: Embed ATS info
directly into struct pci_dev").

No functional changes intended.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Related:
  https://lore.kernel.org/r/20190902211100.GH7013@google.com
  https://lore.kernel.org/r/20190724233848.73327-9-skunberg.kelsey@gmail.com

 include/linux/pci-ats.h | 76 +++++++++++++++--------------------------
 include/linux/pci.h     | 14 --------
 2 files changed, 28 insertions(+), 62 deletions(-)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 1ebb88e7c184..a2001673d445 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -4,74 +4,54 @@
 
 #include <linux/pci.h>
 
-#ifdef CONFIG_PCI_PRI
+#ifdef CONFIG_PCI_ATS
+/* Address Translation Service */
+int pci_enable_ats(struct pci_dev *dev, int ps);
+void pci_disable_ats(struct pci_dev *dev);
+int pci_ats_queue_depth(struct pci_dev *dev);
+int pci_ats_page_aligned(struct pci_dev *dev);
+#else /* CONFIG_PCI_ATS */
+static inline int pci_enable_ats(struct pci_dev *d, int ps)
+{ return -ENODEV; }
+static inline void pci_disable_ats(struct pci_dev *d) { }
+static inline int pci_ats_queue_depth(struct pci_dev *d)
+{ return -ENODEV; }
+static inline int pci_ats_page_aligned(struct pci_dev *dev)
+{ return 0; }
+#endif /* CONFIG_PCI_ATS */
 
+#ifdef CONFIG_PCI_PRI
 int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
 void pci_disable_pri(struct pci_dev *pdev);
 void pci_restore_pri_state(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
-
 #else /* CONFIG_PCI_PRI */
-
 static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
-{
-	return -ENODEV;
-}
-
-static inline void pci_disable_pri(struct pci_dev *pdev)
-{
-}
-
-static inline void pci_restore_pri_state(struct pci_dev *pdev)
-{
-}
-
+{ return -ENODEV; }
+static inline void pci_disable_pri(struct pci_dev *pdev) { }
+static inline void pci_restore_pri_state(struct pci_dev *pdev) { }
 static inline int pci_reset_pri(struct pci_dev *pdev)
-{
-	return -ENODEV;
-}
-
+{ return -ENODEV; }
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-
 int pci_enable_pasid(struct pci_dev *pdev, int features);
 void pci_disable_pasid(struct pci_dev *pdev);
 void pci_restore_pasid_state(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
-
-#else  /* CONFIG_PCI_PASID */
-
+#else /* CONFIG_PCI_PASID */
 static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
-{
-	return -EINVAL;
-}
-
-static inline void pci_disable_pasid(struct pci_dev *pdev)
-{
-}
-
-static inline void pci_restore_pasid_state(struct pci_dev *pdev)
-{
-}
-
+{ return -EINVAL; }
+static inline void pci_disable_pasid(struct pci_dev *pdev) { }
+static inline void pci_restore_pasid_state(struct pci_dev *pdev) { }
 static inline int pci_pasid_features(struct pci_dev *pdev)
-{
-	return -EINVAL;
-}
-
+{ return -EINVAL; }
 static inline int pci_max_pasids(struct pci_dev *pdev)
-{
-	return -EINVAL;
-}
-
+{ return -EINVAL; }
 static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
-{
-	return 0;
-}
+{ return 0; }
 #endif /* CONFIG_PCI_PASID */
 
-
-#endif /* LINUX_PCI_ATS_H*/
+#endif /* LINUX_PCI_ATS_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 56767f50ad96..5f2ae580bd19 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -284,7 +284,6 @@ struct irq_affinity;
 struct pcie_link_state;
 struct pci_vpd;
 struct pci_sriov;
-struct pci_ats;
 struct pci_p2pdma;
 
 /* The pci_dev structure describes PCI devices */
@@ -1764,19 +1763,6 @@ static inline const struct pci_device_id *pci_match_id(const struct pci_device_i
 static inline bool pci_ats_disabled(void) { return true; }
 #endif /* CONFIG_PCI */
 
-#ifdef CONFIG_PCI_ATS
-/* Address Translation Service */
-int pci_enable_ats(struct pci_dev *dev, int ps);
-void pci_disable_ats(struct pci_dev *dev);
-int pci_ats_queue_depth(struct pci_dev *dev);
-int pci_ats_page_aligned(struct pci_dev *dev);
-#else
-static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
-static inline void pci_disable_ats(struct pci_dev *d) { }
-static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
-static inline int pci_ats_page_aligned(struct pci_dev *dev) { return 0; }
-#endif
-
 /* Include architecture-dependent settings and functions */
 
 #include <asm/pci.h>
-- 
2.23.0

