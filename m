Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8BA40AB33
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 11:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhINJ4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 05:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhINJ4T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 05:56:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2B9C061574
        for <linux-pci@vger.kernel.org>; Tue, 14 Sep 2021 02:55:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y132so8742302wmc.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Sep 2021 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdKUVRZtJ1TDIZqyXHbN+tA2qUuBC0xRclnrY6chKzg=;
        b=RCYq/kdd2XGXv8uX9tzBoBXj6ve07OPtW4zwQWOsekaJ7cpv/0S4DUEXJt0wteDNzz
         2aS3mspyXU3b90WZmBRcdgyvYYZC1FT7hkRf3GmzTPl3FTQf9Ns2RFLcmJf37zpSUEZF
         uswqGMY6HcXlM0+Op9UVIHCnNcFOZ5gdmX0ldX1/m0akQp7wP0GQppY+mmLhueIBx9iM
         H3w/1HzINrm36bads7EbMjrO5rFc1RDsZgYph+syFbOEeS+GSt7kTK72ZjgGVBldtL8W
         gAv2pqPwQMyCf/08KqnqpG72py9nzqVSW/JRlOh1VbRHOacmcriyd5TzMKKZXr/v5nxN
         A2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdKUVRZtJ1TDIZqyXHbN+tA2qUuBC0xRclnrY6chKzg=;
        b=2lKjkhEL55rVLpMqnx6Hkrc1uQ0iN3QzY6S2tDQvtTJJY91MAw0uIQR3XerrxUVEFG
         uWZgVo+b8TZAJPew7PyAK9Ug9uIKfUvRxQ9VUpA+X5Yg+Y2aYrGHcmFfAYT5c7WbfY5q
         M2z4hPwSCvsjeZqtr9Sjhgj7rJv4uUSwcbsIgy5GB6sEEJVaDTGYRmUVFUHlXy/Yd/GU
         2yr7UCEq9shf7balRSZGI6VwsML9TV2nfs85j1YYumaAFeoqgMSjDg3epZ2KISPl8G3d
         ELm/mkQ4YKfTTDsfjm2+NyDqlQzCumLFOtZBLF0lc5UtnsLTq7AV7NQSBv+O6wnYaYLv
         7jZA==
X-Gm-Message-State: AOAM5337RfMeOlDbyECzQZSaOt/ezYq369crTm4B2HFcIPLbpQs6GUKi
        CxbiVbaLs5AooYrB9sEfGGie4Q==
X-Google-Smtp-Source: ABdhPJxI/cDlAXGQ138HYUrNRJlpQQywhVUAwLpYUug38W2/Rb4S01zxLFrScrzqxXlJdhhheA559Q==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr1167364wmq.21.1631613300706;
        Tue, 14 Sep 2021 02:55:00 -0700 (PDT)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id t23sm10408900wrb.71.2021.09.14.02.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:55:00 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        sdonthineni@nvidia.com, robh@kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2] PCI/ACPI: Don't reset a fwnode set by OF
Date:   Tue, 14 Sep 2021 10:51:21 +0100
Message-Id: <20210914095120.2132059-1-jean-philippe@linaro.org>
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
v2: Use dev_fwnode()
v1: https://lore.kernel.org/linux-pci/20210913172358.1775381-1-jean-philippe@linaro.org/
This fixes boot of virtio-iommu under OF on v5.15-rc1
---
 drivers/pci/pci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a1b1e2a01632..0f40943a9a18 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -937,7 +937,7 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev);
 
 void pci_set_acpi_fwnode(struct pci_dev *dev)
 {
-	if (!ACPI_COMPANION(&dev->dev) && !pci_dev_is_added(dev))
+	if (!dev_fwnode(&dev->dev) && !pci_dev_is_added(dev))
 		ACPI_COMPANION_SET(&dev->dev,
 				   acpi_pci_find_companion(&dev->dev));
 }
-- 
2.33.0

