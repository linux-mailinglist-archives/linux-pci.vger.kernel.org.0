Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB933E098C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 22:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbhHDUnM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 16:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240988AbhHDUnC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 16:43:02 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E88FC0613D5;
        Wed,  4 Aug 2021 13:42:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e21so4393339pla.5;
        Wed, 04 Aug 2021 13:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ANue8vIwbJ1NcyUPoYZMHd4TEP2tXpUAukwZ6Fi+ds=;
        b=eIstHSvjJJotZ4gGvSAXKjHMq7VFyqLLMuctUXr4Ix50JHWn61WzZyCqx+Go5hD7HI
         MibqRUS6aaqrPxS18VGxyzk48ZKTImnP3wa8hZBp5fyg9t6uifKLUayXew64KsNqSpQJ
         4RS4RDzLR4WCvAIIki0Klcmo5DayO8xSWwqGaf8SsjoA/M0M2/8wF+4jZ7NoA+2cX7hu
         AsfTGW+8ydtRmcD4GXC7aa8i+N8U44bvdHQ8gNG30twcecCmjtwJlEkEc5c0OkuGqADs
         dgEvP7fTnDINJHJ3htUHraHzaAVK8KZ4RJoRy9zP4EGd+ziGQdpJeE0rm0P1ot8eSMu4
         LLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ANue8vIwbJ1NcyUPoYZMHd4TEP2tXpUAukwZ6Fi+ds=;
        b=KDG741Ud3Hs2NRiavv8QUePDEm67eiJinj+juL9aZt5gtc252u0ikU3KZItThdAwHY
         s2Vnli3BWfRcUf/JuUAED3KOXVeGXsr/4BnuYmz4zP5awWQmGm2LovpEsZb6bAx+c7xj
         RsRZsBZVdUBS6TmahYm5II520K48fPmtOHqFVC5miKtEz6ndckdLA+UozQlB/rxojkRg
         bWvw4g9wulKS04IyGHcsK86UplEDCFmL8/MaiwrkDy25L20CKXOjarnesNZC8REReYmc
         MdwysNOv92G9Gzldw7CN7iBKR9UWgR0BgEdJojoA8KGRnHQTYhdjJ1YUwhHvlkml3AhP
         l6pQ==
X-Gm-Message-State: AOAM5337GBds0OBkUs52HyF4zhN22QSmsiqvurIKXGORVZeafew5l0DK
        IoOuZkad5tsSLWar91m/OLw=
X-Google-Smtp-Source: ABdhPJwJITN46n56eZC4DYHMJvn3gZHvulFjkX42ki00ASneMYr/kABJ/V0sEfk0GQMciyC5BZH/3Q==
X-Received: by 2002:a17:902:8e88:b029:11e:b703:83f1 with SMTP id bg8-20020a1709028e88b029011eb70383f1mr865957plb.79.1628109768228;
        Wed, 04 Aug 2021 13:42:48 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.161])
        by smtp.googlemail.com with ESMTPSA id w2sm7064922pjt.14.2021.08.04.13.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 13:42:48 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v14 8/9] PCI: Add support for ACPI _RST reset method
Date:   Thu,  5 Aug 2021 02:12:00 +0530
Message-Id: <20210804204201.1282-9-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804204201.1282-1-ameynarkhede03@gmail.com>
References: <20210804204201.1282-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shanker Donthineni <sdonthineni@nvidia.com>

The _RST is a standard method specified in the ACPI specification. It
provides a function level reset when it is described in the acpi_device
context associated with PCI-device. Implement a new reset function
pci_dev_acpi_reset() for probing RST method and execute if it is defined
in the firmware.

The default priority of the ACPI reset is set to below device-specific
and above hardware resets.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci-acpi.c | 23 +++++++++++++++++++++++
 drivers/pci/pci.c      |  1 +
 drivers/pci/pci.h      |  6 ++++++
 include/linux/pci.h    |  2 +-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index dae021322b3f..31f76746741f 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -941,6 +941,29 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
 				   acpi_pci_find_companion(&dev->dev));
 }
 
+/**
+ * pci_dev_acpi_reset - do a function level reset using _RST method
+ * @dev: device to reset
+ * @probe: check if _RST method is included in the acpi_device context.
+ */
+int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+	acpi_handle handle = ACPI_HANDLE(&dev->dev);
+
+	if (!handle || !acpi_has_method(handle, "_RST"))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
+		pci_warn(dev, "ACPI _RST failed\n");
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
 static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	const struct fwnode_handle *fwnode;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 994426b2b502..10d86eee03e6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5126,6 +5126,7 @@ static void pci_dev_restore(struct pci_dev *dev)
 static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ pci_dev_specific_reset, .name = "device_specific" },
+	{ pci_dev_acpi_reset, .name = "acpi" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8ef379b6cfad..b13dae3323da 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -704,7 +704,13 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
 void pci_set_acpi_fwnode(struct pci_dev *dev);
+int pci_dev_acpi_reset(struct pci_dev *dev, int probe);
 #else
+static inline int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+	return -ENOTTY;
+}
+
 static inline void pci_set_acpi_fwnode(struct pci_dev *dev) {}
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 94d74fd594c1..d3b06bfd8b99 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -50,7 +50,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 6
+#define PCI_NUM_RESET_METHODS 7
 
 /*
  * The PCI interface treats multi-function devices as independent
-- 
2.32.0

