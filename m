Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4EC3E1983
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhHEQbK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 12:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhHEQaO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Aug 2021 12:30:14 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCBDC06179A;
        Thu,  5 Aug 2021 09:29:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j1so10144117pjv.3;
        Thu, 05 Aug 2021 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdmxS97wTwZYrZefvhIzjx0kSlZLxSWqP1+jzXnYcUw=;
        b=AH61w1zThHfVGVSNGfFP4TqcnoxjzIoUNha+LlsotBEh/qKrNFHxNu9gH6/a++x3N0
         KYYByi15r/HZ7+1KBL5MHEWSzzcgxllUZOvYlp43QMTn8pNna+3VEVsO9qS7/1C9rS/p
         C4DcahwrvPK0Oclh9MTRbsAliTsr5wOlyjKyAuDjWnrrmHKO1NNsi9luPI7d2sUHeBrS
         92GB+JKMnuQWFuUPMtuM6mbB03mKO9MSwIs0X4FBGaR46m8Ymw4GAzHwNAn+GXjhbJze
         kD4SHZB8fB+OTW8rUR1Xu26uYvsytJTjL/0eURJKp0svf6JXXKNI3n8ISr9i4mDOhISE
         pYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdmxS97wTwZYrZefvhIzjx0kSlZLxSWqP1+jzXnYcUw=;
        b=kmlYP0dZOIUDjZXVA5cvxLcvJjE3O3OGz8MGgWfbd7fm6pX55l/WuJhwe2b0yIOTF/
         vOkVOZ+mzzSylK+DkRasuuUlfRv3BSaham6zgEYycbijjo5ErZAhynJZU6yu4fTMjFkd
         y/8/rGsTZwe6E/s4Ty5shX4BXi2FHsTh4r4LdLszUjCOd1hpksenrLIjs6LsgiamWuT1
         gfl+ZwbZ615pEsux9beVx4cv5fWB91RMz4dUJetgvLKTQgWz8C9RGmms+5JJRF/kWXSP
         XZ1UGlDiCegAM8+YJNTL1JyPlME5sj+iv9lP1z2bl/P6JjL+RMyTrq7FcOi4VaOk1g40
         orfQ==
X-Gm-Message-State: AOAM532LDClAAkSq2zMXTav3VBWVtQC4dUJhLyCw7EANoV0o4S03RmNV
        WTi1qBOXcIwXme86uJJSzEI=
X-Google-Smtp-Source: ABdhPJwTI/HPGYjSd8MEasKJbD3xkZSxogpfjyeBu4quQ7LWqdha0F6KSrPQY9uaJglWYk6EI7i1Ow==
X-Received: by 2002:a17:90a:5889:: with SMTP id j9mr15920482pji.117.1628180999132;
        Thu, 05 Aug 2021 09:29:59 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.161])
        by smtp.googlemail.com with ESMTPSA id nr6sm62551pjb.39.2021.08.05.09.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 09:29:58 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v15 6/9] PCI: Define a function to set ACPI_COMPANION in pci_dev
Date:   Thu,  5 Aug 2021 21:59:14 +0530
Message-Id: <20210805162917.3989-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805162917.3989-1-ameynarkhede03@gmail.com>
References: <20210805162917.3989-1-ameynarkhede03@gmail.com>
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
index 36bc23e21759..eaddbf701759 100644
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
index 31458d48eda7..8ef379b6cfad 100644
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

