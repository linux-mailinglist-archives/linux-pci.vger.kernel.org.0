Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE57440CFC8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 01:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhIOXCx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Sep 2021 19:02:53 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:35425 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhIOXCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Sep 2021 19:02:52 -0400
Received: by mail-lf1-f52.google.com with SMTP id m3so8870412lfu.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Sep 2021 16:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26ouncjbdif/NlFpToD8aoYp3QL4ipoKM+I1PaYnEss=;
        b=WtP9bVNmV/tRZXm/mEBJv71JzCCyZsvZq+T4vhzBZ8kcRJQhJlcsJlOz3c2x3A7BFr
         4iflNNT8H+P/ODUGMshmSULojQPSJDvet5dcy0u2bj+PpdoQxrla5Kzn+sOgfqFGcKjA
         Wd64jh4KMspilYYqoXc2lxihQbqISV3Ylw4qQOTvnnfpvekLF0OorRfqwWDgoafEMzCv
         qVaxTjGNXUqxOaPOLtmeKt5eWzl9GD/qLS4DlVx7vcL23HkbPHo4ehCSt/xVvmykx7fO
         rSd8twCj5wKijneJO9geRSaNOIoknqN19T8KkgMsYoQVn7N6SuLK+TxSPWwLML6O9Typ
         vOlA==
X-Gm-Message-State: AOAM532h9V/M4SIlNjlHzepZJz/S2QcbnQx1wKsxr5GgbO95WO7CBPsu
        vZwDbpAM6gzGF/1yEeaxfAg=
X-Google-Smtp-Source: ABdhPJwD2a49I/M0+MHGoSSxmz/EYyLS66FMKWZNMYEG9A1uuBJDucRNcJf4SKqdZbFTSTAcHqClYA==
X-Received: by 2002:a05:6512:a82:: with SMTP id m2mr1845599lfu.66.1631746892193;
        Wed, 15 Sep 2021 16:01:32 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d15sm107386lfn.220.2021.09.15.16.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 16:01:31 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 3/3] PCI: Don't use the strtobool() wrapper for kstrtobool()
Date:   Wed, 15 Sep 2021 23:01:27 +0000
Message-Id: <20210915230127.2495723-3-kw@linux.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915230127.2495723-1-kw@linux.com>
References: <20210915230127.2495723-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The strtobool() function is a wrapper over the kstrtobool() function
that has been added for backward compatibility.

There is no reason to use the old API, thus rather than using the
wrapper use the kstrtobool() directly.

Related:
  commit ef951599074b ("lib: move strtobool() to kstrtobool()")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/p2pdma.c    | 6 +++---
 drivers/pci/pcie/aspm.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 50cdde3e9a8b..4fccdcf9186f 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -943,7 +943,7 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
  *
  * Parses an attribute value to decide whether to enable p2pdma.
  * The value can select a PCI device (using its full BDF device
- * name) or a boolean (in any format strtobool() accepts). A false
+ * name) or a boolean (in any format kstrtobool() accepts). A false
  * value disables p2pdma, a true value expects the caller
  * to automatically find a compatible device and specifying a PCI device
  * expects the caller to use the specific provider.
@@ -975,11 +975,11 @@ int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 	} else if ((page[0] == '0' || page[0] == '1') && !iscntrl(page[1])) {
 		/*
 		 * If the user enters a PCI device that  doesn't exist
-		 * like "0000:01:00.1", we don't want strtobool to think
+		 * like "0000:01:00.1", we don't want kstrtobool to think
 		 * it's a '0' when it's clearly not what the user wanted.
 		 * So we require 0's and 1's to be exactly one character.
 		 */
-	} else if (!strtobool(page, use_p2pdma)) {
+	} else if (!kstrtobool(page, use_p2pdma)) {
 		return 0;
 	}
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 013a47f587ce..52c74682601a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1219,7 +1219,7 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 	bool state_enable;
 
-	if (strtobool(buf, &state_enable) < 0)
+	if (kstrtobool(buf, &state_enable) < 0)
 		return -EINVAL;
 
 	down_read(&pci_bus_sem);
@@ -1276,7 +1276,7 @@ static ssize_t clkpm_store(struct device *dev,
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 	bool state_enable;
 
-	if (strtobool(buf, &state_enable) < 0)
+	if (kstrtobool(buf, &state_enable) < 0)
 		return -EINVAL;
 
 	down_read(&pci_bus_sem);
-- 
2.33.0

