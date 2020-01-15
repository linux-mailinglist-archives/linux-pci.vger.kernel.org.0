Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A97513C1CC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 13:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAOMxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 07:53:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53532 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgAOMxd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 07:53:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so17735857wmc.3
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2020 04:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SVox6K0aClSgQAj4ZePzlVYlKOAA5RM1JxWE0eeJ+CM=;
        b=d82j4vm1o3BcAiDmH8LgzA/3vpHR0J1gWTn3QQfboZjYwEHmLjWkVdv0rRYfw8tFQD
         ZuKg7Rqy6hIQuC+dEDXPSLfFBVh4xfBVaqbdgIL1DjHmr5YQ0g8aBzYy3Kb+GHOJFU4L
         g6e/Md8hX8aJLbt7iWz2wb0JfPk+FA+VwfPFj8ARFZ/hHFjSIIJjUKBrW0X8Uw65/GFN
         pCj8ovv/3UsaefxbgelPQ8wVEKeHfYhcTtN2E+f84GERI489oXoalINk//Ix2yee5SSF
         +wfxiIYEG3WEI0GqJI+KNZVEJCgdOf8YjqzueruUlJfwuRyTHAExiMrKEJFJQ/Z+jnHY
         DS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SVox6K0aClSgQAj4ZePzlVYlKOAA5RM1JxWE0eeJ+CM=;
        b=MBfUsRZ5bnVNjyFaTuf36wcvzWAFgk723awNtDJ3jiMgQxIYWv0ygOqgMXCDcJ9EzS
         xSKlIn39771py5Q2T637yHWyH3HdCQRFlxJ+9RtOU5qVR6bwXbySUT+LtF6OtcDFPAIX
         g+tfKMWNgMpgYYqVtJRykUJfmQGB0gkBEFF3qQjOww8ZlwLoutembJ+x6ilklFFZFK98
         25o5VVU5ODe5fBEW5uaCLgqDDhBl5l51AJ6+DF9fosG4/Jluw7LwHam6UhpY9iACAxoU
         x51TU1XeCkMUeV2+mMQhRim8FvzxXfpFx14VLhoBGNkzwmTFhb3JY/JDJ1QFkKyEQhiQ
         lB5g==
X-Gm-Message-State: APjAAAWJiOdrC5ZDiBYGCCkQ7RONQFP8Tf+kJPuPPJzx1hPdrBeNscRt
        rAVgrBrKTztN6qPEx7RjjEClwoke81k=
X-Google-Smtp-Source: APXvYqzv6wpZNhXp0mYEPij61j3ANQSOgHf/a/RB8gE84eHpEFNB/mfELJUcr+OpmYAPFC/lrGboWA==
X-Received: by 2002:a1c:3187:: with SMTP id x129mr33613992wmx.91.1579092812076;
        Wed, 15 Jan 2020 04:53:32 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:31 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 04/13] ACPI/IORT: Parse SSID property of named component node
Date:   Wed, 15 Jan 2020 13:52:30 +0100
Message-Id: <20200115125239.136759-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
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

