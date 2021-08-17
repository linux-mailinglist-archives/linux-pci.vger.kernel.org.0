Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B933EF153
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 20:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhHQSGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 14:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbhHQSGF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 14:06:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A211C061764;
        Tue, 17 Aug 2021 11:05:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nt11so397008pjb.2;
        Tue, 17 Aug 2021 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLnQgIMItD6zf5chSN5MtQHXoBE4AHjJqDsuFsI1dtI=;
        b=gVl1CMvTLidKWG0EvVQTg8pGcfZBTKASJ2bYJqdqv9akrwO3nQEtgRvqrYhHoHCj1r
         ZTiC+XKE+Z5sn9wckS4NmpdXhaSjN1/GOooaMUtlEJikYJtxs5ypkFKRsN98eB8F98DA
         ExoTYn3Q9jW5o1nNQXVGLWwTWVeOH8857CjnOdnMs8WBel2UXNGN1YmfumBqmNaUSraL
         yZFbehai8+iSGS5LzVyfnYSwOmf0VGq1O7TdJe5Sf6Xdq7tJZyiQ0x8PQ9D33ALmbIfV
         zoX9VNdAzCf3XRi84uLO34tD8Z7EGKTW6l1/HhOotkBLjHWEGga85jiqxb/JbUii01Qt
         sDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLnQgIMItD6zf5chSN5MtQHXoBE4AHjJqDsuFsI1dtI=;
        b=Q6E2HrOoPBmOQtPXGs05Qrk0pWwfusJQncoatCN4LkIAnYjCvxxKJ1+rA+7zHJB0m7
         CM8AGav77d7O/3OjbBlNimNzKYMKhMMcZvQm1BWQLlKvhVMYREgTaSlg50z6Nb0OOqXr
         zvdHd+wA/Eg/4myXs2albquv2mTFQSpHiZajsWs4qtKJCuIz8oFIstoVd7zQNTVd9dTN
         J+RMLdE5+y+Rw+8ElXhC0F3wIXkxAo4oAOMYaKrNqwuWql4VOaE8KUrbuSKreLy39Hml
         aleJRhoZsxItetQMRN+7imje7QzDNYNb8hQ2GRT6n3J7I2nrvfIqAauJ3EZxM4NxeNZE
         i2gw==
X-Gm-Message-State: AOAM532drbFfjwqQ09VgSmizmfsZqN6xn/NrSCfsfGz79yeCFQc6Iy4H
        cuzVDudpfg6HAVcsP9vHyVc=
X-Google-Smtp-Source: ABdhPJyOSAjlNijZRpL4CdMhOhZBS2lFCk1X1c5kF0bx71AcBZpDEtL8O/mMt7eFSePRKybdKJnItg==
X-Received: by 2002:a17:902:6ac8:b029:12d:632:ffcf with SMTP id i8-20020a1709026ac8b029012d0632ffcfmr3884236plt.28.1629223531158;
        Tue, 17 Aug 2021 11:05:31 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.158])
        by smtp.googlemail.com with ESMTPSA id 65sm4065632pgi.12.2021.08.17.11.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:05:30 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v16 6/9] PCI: Define a function to set ACPI_COMPANION in pci_dev
Date:   Tue, 17 Aug 2021 23:34:57 +0530
Message-Id: <20210817180500.1253-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817180500.1253-1-ameynarkhede03@gmail.com>
References: <20210817180500.1253-1-ameynarkhede03@gmail.com>
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
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
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
index 31458d48e..8ef379b6c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -703,7 +703,9 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
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

