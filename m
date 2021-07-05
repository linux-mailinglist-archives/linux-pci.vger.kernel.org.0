Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6608E3BBE27
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 16:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhGEOZD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 10:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhGEOZD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 10:25:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CE1C061574;
        Mon,  5 Jul 2021 07:22:26 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 17so16574804pfz.4;
        Mon, 05 Jul 2021 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/PjGID5YE9bZJ8kbC8yKj/6YFVLjY36xUbGOb1a2xcI=;
        b=GoDCjirhWMsN6+Y2JNydQeJbbQtD0Qbn4yh1jJqCmqTp3WXjNN+I4pYMu+Xnh7tByV
         1stFDKLiCLBX/D1Oy10gpP4KspcxhHMn61U7i5q/U1M5fYhEGz2ju4hJo8SOtvCubL4v
         dU9ZzmLwMEGIYZBJYmxcINj/9x+/rHBJjj/cMDIbuvWNIT0QeFPKFGj3GTHke9Y3ggCE
         djUTBOqoaokVF4ldVCHwcXzl56Ge89SizTHEk8WZJ9pmLe8CQho7X8uW3OqTd2l/6hPw
         ANNihTVnCwYgs7dn8lxEA2xUFR2+Z/KClhQgRzHl8BaN9PmD8u3fusJlSQoYX2aUOdIc
         iS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/PjGID5YE9bZJ8kbC8yKj/6YFVLjY36xUbGOb1a2xcI=;
        b=qM/XJ+vny6Mv5bSDLQ4m1tWe+GvQ2Uu1engDuKrtw7BhejFJ7MTjuAmOfKSgAHkXcd
         2uGDKpyix/paZwM5mXdMJJE8tPFjqJQZzD69jIARnZCy+rR1Iw+Yv4NQmUbuukAbNfgi
         j+5socjjNGnJCXJXECPJCQhPjI/r9vof++9nCzygvu0dbCkrMw7Bffq5sMhcuLUou6vA
         HU4roXMdbHL9YCCVvbrlV75riyW5iH8HOVrfAhnmoeViLPlqohX4+rYD2rrn43wrfR8a
         6MArvOozfB35LL6I03NhHRuUmLdnM2yzcGUkwZh00VW1A+Q7/+iOz26JQVr2YMlwiN8Z
         EKQA==
X-Gm-Message-State: AOAM5338eCI6kYLnYB2uRX6DYIgmusDsBbbQa478Qi6I0n3LGRx2MYmy
        Cdbxw7U7zBBWl4HfSZzIyH4=
X-Google-Smtp-Source: ABdhPJwvmf49bAD0+eLDOE6Oj3quiVo7zXB4rdPF7ZB7Vmzknbd/i1+fD41EhaGJxVswlWRYJEpMUg==
X-Received: by 2002:a63:e948:: with SMTP id q8mr16201181pgj.52.1625494946320;
        Mon, 05 Jul 2021 07:22:26 -0700 (PDT)
Received: from localhost.localdomain ([2409:4042:2696:1624:5e13:abf4:6ecf:a1f1])
        by smtp.googlemail.com with ESMTPSA id 92sm22615307pjv.29.2021.07.05.07.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 07:22:26 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v9 5/8] PCI: Define a function to set ACPI_COMPANION in pci_dev
Date:   Mon,  5 Jul 2021 19:51:35 +0530
Message-Id: <20210705142138.2651-6-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705142138.2651-1-ameynarkhede03@gmail.com>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
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

