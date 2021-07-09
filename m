Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1A73C238B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 14:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhGIMlo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 08:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhGIMlo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jul 2021 08:41:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF0BC0613DD;
        Fri,  9 Jul 2021 05:39:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso5997064pjp.2;
        Fri, 09 Jul 2021 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/PjGID5YE9bZJ8kbC8yKj/6YFVLjY36xUbGOb1a2xcI=;
        b=PLYf/xF94T6BgFl+9z3wFGC7lzbb/CVS/e6Piecm6kvSjwJ++BFSI7RVXQrphfZscC
         nzyBrBOZTHtF0cuK35WZp+RAsZ/R0/JprWqzpL9K8WoQMJSq4Sj7bSSJuj+lhIgo4ios
         jOR+iLFJ5d4+nPLkSXIPLadezOkKTnTcn1s/T//8GCdn7/9dX6NcpsMWXVlVyWevdVrn
         USy/IXuMPXLkOnsFXPuehdii8s/VdaQY0XBxpmU7Mib/5rVINpASi7bVUzTE65ctyEqJ
         EE5CjwQR5TGXM+AH5JPxyvXyg1X+kEYNPDdMd4qBgA4ZLbFuocbtem3Y0jzefBUfYCgF
         66iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/PjGID5YE9bZJ8kbC8yKj/6YFVLjY36xUbGOb1a2xcI=;
        b=J0U0/k8N5z4Yqt/9boHiHND325cZ3Rnvn+Wbq87eEIUt4aIadfS1SzU5JBiFsWM2xQ
         gAUsbzujPyhuUICIwpPXOuCTQig+AHKNBJaIPiyFPJiRyvqT4M9tv7Ez4phMHjR8ZSXH
         7drLusRKBPnCm6jt0cTdoOyCk3Z4qtqxHNEAHyfliBdetp1lgxNHuZ7XuP8n2kMJ6JgI
         jj7pW1tVtTLawDfIiTge2PpfGkFeFCa71bIMVvoPcYZdW2xSyjDjIH2XeJYtps05B1dn
         TiMFUMrOz8NHWn/Hx8yRCuFYtaRUG/+4zadhfje8PnQc5mf0rj0m3LrQJO6ERPRlHgnr
         dNlA==
X-Gm-Message-State: AOAM533qiMYuklhse3qbutecnCS+3NTsz8VbvCzb6Sm1QC7apurPtmTo
        4Jb1g4aG7nbke36YG0c3al0=
X-Google-Smtp-Source: ABdhPJzqGAlOtv37KhviGFypzPgDavV4q6iuTU0d0foCNQTcOd1TJuMbUphOYipj1ZT6eXjbgulkag==
X-Received: by 2002:a17:90a:1749:: with SMTP id 9mr14429929pjm.97.1625834340707;
        Fri, 09 Jul 2021 05:39:00 -0700 (PDT)
Received: from localhost.localdomain ([152.57.176.46])
        by smtp.googlemail.com with ESMTPSA id j6sm5592402pji.23.2021.07.09.05.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 05:39:00 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v10 5/8] PCI: Define a function to set ACPI_COMPANION in pci_dev
Date:   Fri,  9 Jul 2021 18:08:10 +0530
Message-Id: <20210709123813.8700-6-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709123813.8700-1-ameynarkhede03@gmail.com>
References: <20210709123813.8700-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shanker Donthineni <sdonthineni@nvidia.com>

Move the existing code logic from acpi_pci_bridge_d3() to a separate
function pci_set_acpi_fwnode() to set the ACPI fwnode.

No functional change with this patch.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 drivers/pci/pci-acpi.c | 12 ++++++++----
 drivers/pci/pci.h      |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 36bc23e21..eaddbf701 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -934,6 +934,13 @@ static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 
 static struct acpi_device *acpi_pci_find_companion(struct device *dev);
 
+void pci_set_acpi_fwnode(struct pci_dev *dev)
+{
+	if (!ACPI_COMPANION(&dev->dev) && !pci_dev_is_added(dev))
+		ACPI_COMPANION_SET(&dev->dev,
+				   acpi_pci_find_companion(&dev->dev));
+}
+
 static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	const struct fwnode_handle *fwnode;
@@ -945,11 +952,8 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 		return false;
 
 	/* Assume D3 support if the bridge is power-manageable by ACPI. */
+	pci_set_acpi_fwnode(dev);
 	adev = ACPI_COMPANION(&dev->dev);
-	if (!adev && !pci_dev_is_added(dev)) {
-		adev = acpi_pci_find_companion(&dev->dev);
-		ACPI_COMPANION_SET(&dev->dev, adev);
-	}
 
 	if (adev && acpi_device_power_manageable(adev))
 		return true;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index db1ad94e7..990b73e90 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -704,7 +704,9 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 #ifdef CONFIG_ACPI
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
+void pci_set_acpi_fwnode(struct pci_dev *dev);
 #else
+static inline void pci_set_acpi_fwnode(struct pci_dev *dev) {}
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
 	return -ENODEV;
-- 
2.32.0

