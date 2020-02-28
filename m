Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A165173E84
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 18:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgB1R3L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 12:29:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37336 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgB1R3L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 12:29:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so3880540wrx.4
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2020 09:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jos+UmzK8Hc9Z4PLlKLT5wM1USAOZpd5S+CdEr/za4M=;
        b=yZGrvgqQ3a9ydAmqTudY9IPdx/DjncbPCa+rQvZU9WCCULTVwu2UGa5TOBot6AcdAG
         Kea81JX8LljjFV+j8BdSJpCyXxETCHdToyup/qvOs2Kn/fZyBQP4EcHVQVMY//0PDYs8
         SwcXTnK7YZ6v3S+y6nKkPQibqpCdCoHJqW4g0nJu/BIO9DBIa3lGcvtNA2prifHT/Oxw
         mIbbtRN7Vlm0MUeryNgWY+DQRCOUVg7Y7AL5rM3IrhRJM50B+aLgnA02feYoB5UL1UQX
         OV1jj+4Aepoo957kJ/DUrhNRR3P3hpqS7hEv+rVY3PJ+0f87zExAbBJD5I+PfPnq0iQz
         2xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jos+UmzK8Hc9Z4PLlKLT5wM1USAOZpd5S+CdEr/za4M=;
        b=KO5yobaDUczQT9jS+hL+9cN5ENPxdgTNPfQ1p4TfZ3dmEAJVRcZ6DZ+jGlqntYsEhe
         erIGx1PHTKl0NJyIsdNhoWTzt367WWtf3nwScUb+5rbe0jJytDJmaRsoUcHzJLwEUzib
         hqrg6BolclH/1eOU2J1hk3oi3DjN2Ebjn6UvAUCCekQNYM7+dgLa8QVSrNg9l/Yzh9Sx
         Xi8jPhfV0Wk77q6SCt6N8yXsx/wetp5E/Hc0YRSdOPitnIyltmY7WC1Lu67LcigDAiKm
         Lb1e9U5L5wMY42UmDc+a1oLACqeBcnduBuDu8C3V8y0Dv4yNlVDII0pf0CLDsyv9y364
         8vcA==
X-Gm-Message-State: APjAAAU0FrzqVPmeDYk+5aAru0MFkOZPnap2delbchGz1Df0gRaw1z7n
        wuLSkXj4cLbvm5tr3NiQyRLXUA==
X-Google-Smtp-Source: APXvYqzT3P7sA/CZ/b1UMh6+05HJ/72/05Zr7K58Lo6dOwmy5w3WAhfYStmzvZK+P8kUpQEHVNKUng==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr5683415wrj.196.1582910948537;
        Fri, 28 Feb 2020 09:29:08 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m125sm3004795wmf.8.2020.02.28.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 09:29:08 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        jacob.jun.pan@intel.com, robin.murphy@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 3/3] iommu/virtio: Enable x86 support
Date:   Fri, 28 Feb 2020 18:25:38 +0100
Message-Id: <20200228172537.377327-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200228172537.377327-1-jean-philippe@linaro.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With the built-in topology description in place, x86 platforms can now
use the virtio-iommu.

Architectures that use the generic iommu_dma_ops should normally select
CONFIG_IOMMU_DMA themselves (from arch/*/Kconfig). Since not all x86
drivers have been converted yet, it's currently up to the IOMMU Kconfig
to select it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f8cb45d84bb0..87efc48c244e 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -508,8 +508,9 @@ config HYPERV_IOMMU
 config VIRTIO_IOMMU
 	tristate "Virtio IOMMU driver"
 	depends on VIRTIO
-	depends on ARM64
+	depends on (ARM64 || X86)
 	select IOMMU_API
+	select IOMMU_DMA if X86
 	select INTERVAL_TREE
 	help
 	  Para-virtualised IOMMU driver with virtio.
-- 
2.25.0

