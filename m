Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 349221266F2
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 17:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLSQb1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 11:31:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41534 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfLSQb0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 11:31:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so6611608wrw.8
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2019 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SVox6K0aClSgQAj4ZePzlVYlKOAA5RM1JxWE0eeJ+CM=;
        b=KsJmWTGBulFgtHxInjLbvLy9PpRX0GteBfzNXmUrDZJrH+ZYaBQIa1dHh47VnHT3Us
         G2OJX3xgvKyS2XK3zuqcw1ZOXlKDVBJQRRMVF0nOr9xyj+lDw01Q6Jd6vR/rkeYccEHt
         yJOWYb/rjfBgXbMc7wgknxeamdVg+ZZN29ommW/LnpTHOjUz0VpuiDmfABbg1QOhKWEP
         BK79LYU2nE8gQz8QcvCdTDHowZsM7F9ia5UVAVVs4wcvu3pPH0s1tj25cZ4VQrLWBmC5
         SAfWsR+i6gOKs+s2DrspT9Ahp+NfOeXnTsawx79CvIM08A0Wu8V+jAyezZPtTeJVSYeM
         zLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SVox6K0aClSgQAj4ZePzlVYlKOAA5RM1JxWE0eeJ+CM=;
        b=b47Gl4Rq+LwA4BUOaQN+DQNrUf6EUq+GF6OENA9FI+YSthxBBIC+kckNvOruW1lrf0
         smPTMUKWhzRtSgzRjMZOKaJHQiZnCRKylGmCu9+gdayCHTRCXadB2c8f9VNJbByi7Yqx
         QepIWdfxqcFoK4saC065vuSiauuXquqxVM0f8A5z2dhJaTKtMzSYqcyJWZ/e+L9Xbgpt
         pUirANu7SPkGSxRhURFvRC9YoXCVAMJsZi51fncUamn+iV/e7f8fZo31NiinmGRDzcRu
         7bXYdOf9Rc/Oz6RLI7mWCmgv8SzY91C8BRbMFwj3YL1kyC8qSLt6eeJ7elj/OIvlIw3g
         wx+Q==
X-Gm-Message-State: APjAAAX2dtCkdyGCMeydqyNcJRxnvSVm4YpPI3eJ7K3DS+ISd4MnpbTN
        dScRKU/j3GF+iFdnRdAG3PA+jq6E3RU=
X-Google-Smtp-Source: APXvYqzR3BRml1Osw8Pe6sNrf17z34IMgIAsII/16lKoUagOiEfpACFYNxRXRQ+jtWBFUTIlzmF8Sw==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr9977279wrn.283.1576773084271;
        Thu, 19 Dec 2019 08:31:24 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 08:31:23 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        eric.auger@redhat.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH v4 04/13] ACPI/IORT: Parse SSID property of named component node
Date:   Thu, 19 Dec 2019 17:30:24 +0100
Message-Id: <20191219163033.2608177-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Named component nodes in the IORT tables describe the number of
Substream ID bits (aka. PASID) supported by the device. Propagate this
value to the fwspec structure in order to enable PASID for platform
devices.

Acked-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 33f71983e001..39f389214ecf 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt)	"ACPI: IORT: " fmt
 
 #include <linux/acpi_iort.h>
+#include <linux/bitfield.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -924,6 +925,20 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return iort_iommu_xlate(info->dev, parent, streamid);
 }
 
+static void iort_named_component_init(struct device *dev,
+				      struct acpi_iort_node *node)
+{
+	struct acpi_iort_named_component *nc;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (!fwspec)
+		return;
+
+	nc = (struct acpi_iort_named_component *)node->node_data;
+	fwspec->num_pasid_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
+					   nc->node_flags);
+}
+
 /**
  * iort_iommu_configure - Set-up IOMMU configuration for a device.
  *
@@ -978,6 +993,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 			if (parent)
 				err = iort_iommu_xlate(dev, parent, streamid);
 		} while (parent && !err);
+
+		if (!err)
+			iort_named_component_init(dev, node);
 	}
 
 	/*
-- 
2.24.1

