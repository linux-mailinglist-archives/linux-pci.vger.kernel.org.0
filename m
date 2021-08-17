Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95D83EF180
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 20:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhHQSKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 14:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhHQSKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 14:10:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4DDC061764;
        Tue, 17 Aug 2021 11:10:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oa17so427706pjb.1;
        Tue, 17 Aug 2021 11:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLnQgIMItD6zf5chSN5MtQHXoBE4AHjJqDsuFsI1dtI=;
        b=B9e3g0ga4AXwMeSONGID2GGGXrLDVqXJLfPcg+YgUYVSeKddFHZLSX3qN/ZkphZTLg
         F8+kMP+iibW04ujVQ2TXU38Gr674ZISDfqwM9nImGQQTQJ5nTUdqDGixCWOmW3lb5roE
         pCe/qw4jKjRLokVspuM65fv6StowyepMzTd9wwajYHfHLpj94METMIuZkPUEPBczPoT2
         ANgPRrpNy29mIptUNzFVdhNAk4Oym5nuSayMrBqDxXzca2MEaYuOFmA4rQvKNw1Ckf2m
         nJ7CA9esaKoDksuh/k+KsD+IMSOl2DzmqRKd0WG26H6Osmam/KXHUxlBvsyJ57AE7nbK
         4KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLnQgIMItD6zf5chSN5MtQHXoBE4AHjJqDsuFsI1dtI=;
        b=BBBBeGtvjCdsW8IeRPIMpvp+8KESAM3ZgMBC/UlypkykotSBEQCy3ctKz8hFCmcrJM
         Cf7nuW6SY8wS4f/KFE7CwJJXiIj231hKllhNkzx8Z/woys17PwR9vPYmWgQtzDTCx+KZ
         meZq0BbSI+VWrKLpjt5z+kbkO8USmbwWF7oJjUrGY/8yr01KTaY4QQ+gaIn5w99MJ7xR
         4/ZZZoOixu3Qva3olnRCZpP5nestfYKfGsZkUqcWympvgwFOgyh8x+nup5sR9bohFhXe
         O9grJi+TjDBV49wKrX1aUsz32xTaidw07YG4MrHCT3rBI45K1Zf3KY19nxkzKbfbvwzk
         x5ow==
X-Gm-Message-State: AOAM533DXoPVlhjaVgIFlAF+ObiCf9kCNvVGh4ppgmV87e1c/OId8C9b
        xMCXN8qjvkky22iqW4Wm8zY=
X-Google-Smtp-Source: ABdhPJwyzMM6EmzU8x6fES1IoHe3MFyJx6kltdZoqNsvhhv1EU6deV5behz0NoEfXxTClW12dNKO/w==
X-Received: by 2002:a17:90b:150a:: with SMTP id le10mr4708051pjb.135.1629223811113;
        Tue, 17 Aug 2021 11:10:11 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.158])
        by smtp.googlemail.com with ESMTPSA id d18sm4011306pgk.24.2021.08.17.11.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:10:10 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v16 6/9] PCI: Define a function to set ACPI_COMPANION in pci_dev
Date:   Tue, 17 Aug 2021 23:39:34 +0530
Message-Id: <20210817180937.3123-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817180937.3123-1-ameynarkhede03@gmail.com>
References: <20210817180937.3123-1-ameynarkhede03@gmail.com>
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

