Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72BA57423D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 01:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbfGXXje (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 19:39:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35831 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388717AbfGXXjd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 19:39:33 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so93359536ioo.2;
        Wed, 24 Jul 2019 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctOGDmMbV31DRZN6bdS13O+qL4D/YscoUsTj6P9f3ms=;
        b=Kyh4eV7lSsnfSvqnjqQGyTdGRXXAmHSHQpGvBW7tZ4hqf+BldRoz7XAOek3DPUjgHf
         ZZcX9kESdXzTgLLtESb3/Pt8uCfvDo9K0oSQBek2g+nTFKTlJSyQMW6mODCaChplNs5+
         TRFgyNebhE4989JJ8ipBoQMddqaeoIPZnB/NugWftJWTL1h3ZSlwn3mtjpoy+4dTHply
         9iP6Ez4Ovd4GpLgNmdqn1YL/SqFZm/j4dkikS/ArrhoiJJ/Skv9k3wzAddnhMsVPoWLZ
         jskMxYitB+tY1vpp8VMUDyp789EKpDv14f+Tpzh654LAmGYFqDDHgNl7JyR6PBr+kMDY
         977A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctOGDmMbV31DRZN6bdS13O+qL4D/YscoUsTj6P9f3ms=;
        b=kM97mX0KYlozPUasXyKaTzUL88Sb1Y1EyjAD8B9+wcszgeS9OUSLs/LxtaC4X7waG7
         Ad6zloKdfw5Euys/HbG+giBXklog8magfUyoXFnV/HjmFU0PHV6c9bMni89iWT3B1sB4
         FwCqAkYRMcNVJJqMP8elc7W2YSdl3PFOWhMpnq58KgIvYbO6WJHQSPCu7WhmudFYWrBg
         omVY7LIzUL4+nDBZRgItno6bVNSlkfxncP4maYxJIZOfswDTvQkC0/pT7zq7uAUmp1Wr
         Koh0ild2vhnGPO4TmMDLjwCfJ7aMFkTH6eiFErGrDX83Ujb60DzqiWS6NfwXB/18x9HX
         qwaw==
X-Gm-Message-State: APjAAAU2j1vevAKyUyxhxdGKkbspug5FfPv1fa9vk8HsXEabFd+/tsyL
        K+tImJbIUmMhaV7kegn2h98=
X-Google-Smtp-Source: APXvYqyrIYj9Of1LxsHeZG3OaAByJIlEvBdFsKiD7Yq6A3aBwkvuztrEQzQSvzzzc3epNAsx5dRrLw==
X-Received: by 2002:a6b:3883:: with SMTP id f125mr6671895ioa.109.1564011573235;
        Wed, 24 Jul 2019 16:39:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b14sm51612959iod.33.2019.07.24.16.39.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:39:32 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 09/11] PCI: Move ECRC declarations to drivers/pci/pci.h
Date:   Wed, 24 Jul 2019 17:38:46 -0600
Message-Id: <20190724233848.73327-10-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724233848.73327-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
 <20190724233848.73327-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_set_ecrc_checking() and pcie_ecrc_get_policy() are only called within
drivers/pci/. Since declarations do not need to be visible to the rest of
the kernel, move to drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 8 ++++++++
 include/linux/pci.h | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7c0488b64faf..5e5ce04bda59 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -541,6 +541,14 @@ static inline void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev) { }
 static inline void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_PCIE_ECRC
+void pcie_set_ecrc_checking(struct pci_dev *dev);
+void pcie_ecrc_get_policy(char *str);
+#else
+static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
+static inline void pcie_ecrc_get_policy(char *str) { }
+#endif
+
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
 #else
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5760e19cb625..5dd4abeef8b0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1559,14 +1559,6 @@ bool pci_aer_available(void);
 static inline bool pci_aer_available(void) { return false; }
 #endif
 
-#ifdef CONFIG_PCIE_ECRC
-void pcie_set_ecrc_checking(struct pci_dev *dev);
-void pcie_ecrc_get_policy(char *str);
-#else
-static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
-static inline void pcie_ecrc_get_policy(char *str) { }
-#endif
-
 bool pci_ats_disabled(void);
 
 #ifdef CONFIG_PCIE_PTM
-- 
2.20.1

