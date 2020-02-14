Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 343B215ED10
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2020 18:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgBNRbr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Feb 2020 12:31:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39589 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390207AbgBNQG5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2020 11:06:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so11491202wrt.6
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2020 08:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skMhNoTugJ6zTST/t+E4o/R9M7w7is4uxoA6SOGqsOo=;
        b=fdOPmNYPBxSQT0jzJbJlZa3aOnpBcmQ+NPrr4Xy/noKSZhKiX9i700NF6ESveRM+Lv
         xTlEA1Dwu5xMjQ894g+vUCiUoiXJGH+9uqSEd9o2xzn1WnXBxozF1VYbMXmoEsWOI7Ry
         VttQ14b8IQqqdioUurOE0pSQgDT+LFulxpzhp8JiELjG1etHKs2URbJKkPzfQT0G9AVW
         l+jYo4OTMH9FxAWzZoIlKcG2Fb8KRGv+u1ESgU+kpLZWNwv13bfAppOjhXZ6quP3XM1U
         Pad34GfIYydgU733zs8YsgE+pFsFictetmwnoEgjad+U0KtYYSRY9thw1TtP3FGx8H5B
         IPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skMhNoTugJ6zTST/t+E4o/R9M7w7is4uxoA6SOGqsOo=;
        b=jpjKwKlvkbVYYgnJ2vlQidFmS9qZhwLkRNIJYnqeirvehPWHwzCKpvAtRW3rDQk+vh
         Antch6E/kEdBYJ4ZITka1ZDX1Nz3FF6A6TuL3GX+XnY0+lZRGq7qlC5/EXwXqcB0hEFK
         r2s+xRXzyGotB3mEmw4nivjZpARUZIjvRNzc4O/C6FEqO2KuUNq5GdE+sHzMmoh9YIEk
         uheYDdLwH3oAqsUnMGEExL3+JDl0uaBRg0J1JpIJ5jdpbOBWdTxy8fo3NBhTXhXT/gQt
         l929hnZE95/Zc/fgGPGwCIoes+IPeyEc0q0dDbM7gi29YBZcD/dWuNp35QBoOZXRMEst
         Rb6Q==
X-Gm-Message-State: APjAAAVPBuGkzjHJ8Qz7BrNzVjW5JYj04rY6lo0KgJwb7XKyT1SCVXLH
        VQde1J1ruxPBnPyJOKfiFTfj3Q==
X-Google-Smtp-Source: APXvYqxyqmg7e8LeAx5P9P0xO6XsDZ38hCrdbxzCLwg/PkzE30ga5qHV2iVyIHRd9cU6DZhhE39m0A==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr4652778wrp.167.1581696416079;
        Fri, 14 Feb 2020 08:06:56 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s139sm8133213wme.35.2020.02.14.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 08:06:55 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        jacob.jun.pan@intel.com
Subject: [PATCH 3/3] iommu/virtio: Enable x86 support
Date:   Fri, 14 Feb 2020 17:04:13 +0100
Message-Id: <20200214160413.1475396-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214160413.1475396-1-jean-philippe@linaro.org>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With the built-in topology description in place, x86 platforms can now
use the virtio-iommu.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 068d4e0e3541..adcbda44d473 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -508,8 +508,9 @@ config HYPERV_IOMMU
 config VIRTIO_IOMMU
 	bool "Virtio IOMMU driver"
 	depends on VIRTIO=y
-	depends on ARM64
+	depends on (ARM64 || X86)
 	select IOMMU_API
+	select IOMMU_DMA
 	select INTERVAL_TREE
 	help
 	  Para-virtualised IOMMU driver with virtio.
-- 
2.25.0

