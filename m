Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A679E3BC47D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 03:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhGFBJD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 21:09:03 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:41788 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFBJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 21:09:03 -0400
Received: by mail-wr1-f54.google.com with SMTP id u8so23956518wrq.8
        for <linux-pci@vger.kernel.org>; Mon, 05 Jul 2021 18:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAt2/9fsX8msYKcUtaCFzrmkaM3hAZjJLNAanXNK3v4=;
        b=EF/JzakONreT6F/dLDtZ3HebP/QNk2f/eRSnJNMitA2O+O65Q9Pkyc7jKjQbBuCylh
         yn/m29WhooKPITyrQtXBucjiJaG67RcrNsjFrq6jejwFKsWC0gi9UXqSf4vH35OHaYnO
         24xzrlN7eMw9OeDn18FKQPH3vH8JvzXLvXsyqOvoYg3k3EKUThBqG+rMEFK51Pr+iMXC
         1ic8t5rKzmTHwh14a6bExS2hiTRavVgvXkpxHOg9lib7+uawn9AJd/olOmdViZxkUTl/
         9/QJzV5csKjdUSD7y5XH+FOajDK239UOV42B0z+lv5myzFKLVmDSFWEU46aEEEH/wmLc
         X7OA==
X-Gm-Message-State: AOAM532MmGl44H9ZPmtnTVyWjt3DtptOppAuH9zhBV5B56K74SFJc6zR
        xuA4zJOPlbjQY8o8ZNfiysQ=
X-Google-Smtp-Source: ABdhPJyB5uRbyrgCQ8HHumPxTdwQWDi30dLZloF8VoL7Hk1WgvKffYPggolbnLfCigN9HsE0raocqw==
X-Received: by 2002:a5d:508b:: with SMTP id a11mr18100207wrt.280.1625533584782;
        Mon, 05 Jul 2021 18:06:24 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id m12sm13379418wms.24.2021.07.05.18.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 18:06:24 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 2/4] PCI/sysfs: Check CAP_SYS_ADMIN before parsing user input
Date:   Tue,  6 Jul 2021 01:06:20 +0000
Message-Id: <20210706010622.3058968-2-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706010622.3058968-1-kw@linux.com>
References: <20210706010622.3058968-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Check if the "CAP_SYS_ADMIN" capability flag is set before parsing user
input as it makes more sense to first check whether the current user
actually has the right permissions before accepting any input from such
user.

This will also make order in which enable_store() and msi_bus_store()
perform the "CAP_SYS_ADMIN" capability check consistent with other
PCI-related sysfs objects that first verify whether user has this
capability set.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 0f98c4843764..bc4c141e4c1c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -275,13 +275,13 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	ssize_t result = 0;
 
-	if (kstrtobool(buf, &enable) < 0)
-		return -EINVAL;
-
 	/* this can crash the machine when done on the "wrong" device */
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
 	device_lock(dev);
 	if (dev->driver)
 		result = -EBUSY;
@@ -377,12 +377,12 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_bus *subordinate = pdev->subordinate;
 
-	if (kstrtobool(buf, &enable) < 0)
-		return -EINVAL;
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
 	/*
 	 * "no_msi" and "bus_flags" only affect what happens when a driver
 	 * requests MSI or MSI-X.  They don't affect any drivers that have
-- 
2.32.0

