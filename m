Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0656A409AAA
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 19:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbhIMR3W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 13:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242395AbhIMR3O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 13:29:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79738C061760
        for <linux-pci@vger.kernel.org>; Mon, 13 Sep 2021 10:27:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u16so15889944wrn.5
        for <linux-pci@vger.kernel.org>; Mon, 13 Sep 2021 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYkKjupU60hjMoVoiKRZMcxcNQZn+uo4Fm5/nL836Ps=;
        b=v0dJK0mx5IKoUqec9tlPaB87hp2PgiZTKU2qd+dihbVLNs3hzol0pLJ7WlmQ6nwf3l
         Cw3xr0gvIwV7AJjVeO4XAO2yDCZAL4p7jAsmcJz0OyerpVEBILEVlwbflvIAQHL89ZX6
         dHmPlyXKRt4uTh7Y/3hhKbME9K1DY3nxtSso3BI5o0Lmx9ZgF0pg+n0YcCkEtF9E6NWo
         eAboQnljnOIz5qNrCcZKnyGyIuWlaGJ5lBfRe70aXqEfwurAM4giPGIpePd1NU25XWGy
         cUn/einI0MDJAbV5oAEiKHygrWzYX4Kd6bJr03rqyaoBrXKwc7luaiLxacUv8geympzR
         pUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYkKjupU60hjMoVoiKRZMcxcNQZn+uo4Fm5/nL836Ps=;
        b=RbNcMJfSfvI161Ccn7G5MqzbLrh/J5+tVadHH4OIWjsq03S3+LR1UBighjp8H2grnl
         udXzoQ3MUSiHjrj5oOtKfUCe4hLLsLNvD86+TMPZvfP421M/Drv9DUkcAU1siIou9uau
         NVhNe6vquToT9/9jexvRjfczEM4wFXELFVsy1ut3o/m8AKJpreqhgvfQ1wXo+T3B9KsK
         AI5XYXo2YRnMbWfRBoHaLaR8qbrWyYnGdgdDgo9ErDU3TKJyD7ww0FFkWQcyNeJRf/Me
         YzCL+mgbjReA6VcugIPnrtBItJmfveBFKtLNv193vdE9HcsfonQVyaYyro//wE/aCiPi
         OOhg==
X-Gm-Message-State: AOAM5336lsejZyhzzTxE2RgbladZU/gKOLZcxuCiOhrocW8nSlbK7BTc
        MLa2LGRCp8jGKp4P60QGE63s7g==
X-Google-Smtp-Source: ABdhPJwxZJQJzjpfe5jpcmkXHTZBSTu2SPPIYovnW7+MrxzERRRyLT4xT9F3xM5uSquHbMmi5YaOPg==
X-Received: by 2002:adf:db4a:: with SMTP id f10mr4772713wrj.91.1631554077026;
        Mon, 13 Sep 2021 10:27:57 -0700 (PDT)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id x13sm7933228wrg.62.2021.09.13.10.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 10:27:56 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        sdonthineni@nvidia.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] PCI/ACPI: Don't reset a fwnode set by OF
Date:   Mon, 13 Sep 2021 18:23:59 +0100
Message-Id: <20210913172358.1775381-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 375553a93201 ("PCI: Setup ACPI fwnode early and at the same time
with OF") added a call to pci_set_acpi_fwnode() in pci_setup_device(),
which unconditionally clears any fwnode previously set by
pci_set_of_node().

pci_set_acpi_fwnode() looks for ACPI_COMPANION(), which only returns the
existing fwnode if it was set by ACPI_COMPANION_SET(). If it was set by
OF instead, ACPI_COMPANION() returns NULL and pci_set_acpi_fwnode()
accidentally clears the fwnode. To fix this, look for any fwnode instead
of just ACPI companions.

Fixes: 375553a93201 ("PCI: Setup ACPI fwnode early and at the same time with OF")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
This fixes boot of virtio-iommu under OF on v5.15-rc1
---
 drivers/pci/pci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a1b1e2a01632..483a9e50f6ca 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -937,7 +937,7 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev);
 
 void pci_set_acpi_fwnode(struct pci_dev *dev)
 {
-	if (!ACPI_COMPANION(&dev->dev) && !pci_dev_is_added(dev))
+	if (!dev->dev.fwnode && !pci_dev_is_added(dev))
 		ACPI_COMPANION_SET(&dev->dev,
 				   acpi_pci_find_companion(&dev->dev));
 }
-- 
2.33.0

