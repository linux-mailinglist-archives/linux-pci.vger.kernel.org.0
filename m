Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882B03B7624
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbhF2QGH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 12:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhF2QFN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 12:05:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6328C0617AD;
        Tue, 29 Jun 2021 09:02:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o3so6069553plg.4;
        Tue, 29 Jun 2021 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/PjGID5YE9bZJ8kbC8yKj/6YFVLjY36xUbGOb1a2xcI=;
        b=pwKFiVbDeCOoepYA7/QpCPu/2h5RFAdP9wB1S2o5hDLTYkbaxS9xZr+ymoK118FPkr
         4hUyDYZ/n35JCg6wPYZ38xVUAzzeeut45nWCKlnNeNXZ+0dueRBsdcrnevkqjmpNsAPu
         ZkvjLb9ikBtDa8Bzlwpd6KAG3yxGgrRt+CtMf8KKVviDEDTIe4TunecquS9FL9BeGMMQ
         cLMdes2Dub963X1K99g6rajYEpinqVZQVkjGFms3wBJD54iU9Yinh42wEFw6yaOaaXm0
         4DS25bHgGeRlglXtPgpiQDQunnlCJZDNPRguJrBNWspH9q9vrb3W8IC5O3dZOWbSeyN+
         XJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/PjGID5YE9bZJ8kbC8yKj/6YFVLjY36xUbGOb1a2xcI=;
        b=bSRf7RE01Ll3H0/c3qX4qlCYh1zqMF/Tpar1FkOfzbh4Ej1x5vHlO//Hulg8T8RN4C
         LRu2QvHBAMG3XzrL1m2HLfHC8mADlcyfR4b+u+WjUiGwTqQSaTeVR0MKPoNu06bwXjto
         Q+PDWeVaon0NqmVfKJiyKxb0JEHUZt08fN4BCiLV9qzexU5uPka8IVdZ162clgisJF0V
         pArp8v96z8hCllSEVKKQkc8zatTIG5r9/JE9tlRj5ujXAB2BevtYOylOkAHT3hvRjBW0
         MqPEahhpVsDapFfcohF6vEWJy2qE4/uogA/h2kLWkLzW+6LK5kd7s6te2IZqUVL511uj
         qoag==
X-Gm-Message-State: AOAM530X5aKEtd7sE6jFoyhCq1OneVG+VCanU+NOO8wxYgAD8PJALEz1
        yC98NVC5e2lxbRCFBMwcCKg=
X-Google-Smtp-Source: ABdhPJzmd+PlVqB1Z+kvfcyK2J/jbLNDYSj8a4dcnvQSpe2n6qzytLFKC8WHpa2TZ4pzXwT7TyhzBQ==
X-Received: by 2002:a17:90a:c003:: with SMTP id p3mr34307829pjt.14.1624982537591;
        Tue, 29 Jun 2021 09:02:17 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.119])
        by smtp.googlemail.com with ESMTPSA id m14sm19166240pgu.84.2021.06.29.09.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 09:02:17 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v8 5/8] PCI: Define a function to set ACPI_COMPANION in pci_dev
Date:   Tue, 29 Jun 2021 21:31:01 +0530
Message-Id: <20210629160104.2893-6-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629160104.2893-1-ameynarkhede03@gmail.com>
References: <20210629160104.2893-1-ameynarkhede03@gmail.com>
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

