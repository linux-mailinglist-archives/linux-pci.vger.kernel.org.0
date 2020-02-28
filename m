Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEA5173E81
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 18:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgB1R3H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 12:29:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41777 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgB1R3H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 12:29:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id v4so3841808wrs.8
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2020 09:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVzPEuR2GzNf0eW4z63MDHB1xQMo/xWUQqLWfLG280k=;
        b=CbMmHBQFWNap3SvvT/pd4tFwlHy/0p/eszdAWT3G2kZuQjh8VT6iBemJ8mEEVvM8DG
         gYzsRDXklS9k3ia0O6auURvqastCyNghO4JhFNgAdpHO53/OjuMAloQqaLoz7KFR/E30
         uDgJYmBBMcMtAEG0IUmBMCkpWifeWcPr3hms0C4RZNN3dchhhB1QDC6I2qyQzjctPZsF
         uxasWOOfceSTO4CZaeNc3l7d5TUOmQ7EmNh6owaXwKVSkJITT19Ny9z5pDLa3fH6FJWE
         OrlY2pz7c1kUntJZ0voKPpcEyk9b6tzY+C4ZLrdSX1aO7Z4vbO9TotUhVgu95nrySL/F
         xT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVzPEuR2GzNf0eW4z63MDHB1xQMo/xWUQqLWfLG280k=;
        b=aoClqkF25LByNkViAtppAIgNff9UnjqrRfLcQrBJW+l7e3D8bUhFWvMVIBADUSfAxs
         oQKS6xT1N7QN3kOtDfXxrh8jXpao5sT1d839bkUf+YjeqJ0587rg4Zv6bjuVCoVoz5yO
         LJx9w8L+V4UatQhQfRk64DZbLccMO409//nLUfs55pbYkmlv8JGp321mOv55CnJXPPDH
         Pw3LuLpRdjDV80DchCaLMydYdIqXsiSd7DQ5LuHuWyiJlcIBZUqilyfXbv0uOE2V0isP
         Sxm5GwURh8hlLtnjJ6DUOMqrrJIEx2B0Qoosu26Ib/nK1UAolL9ySO4nJCEbXdxfWBqX
         Or/A==
X-Gm-Message-State: APjAAAVM60ceaC4qmn5312/vQutnOLG60kTVl86E+KniqghJYHEd3mSr
        fck4jBChoj1hMfkpDCRpbB90lQ==
X-Google-Smtp-Source: APXvYqwoODJ182W+tU34PDRQU6ZjdWMfRs889Si422AXkoD4YBlI28yghK+V6XaUBNiOO+Pcm+sNDw==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr5505559wrp.378.1582910945709;
        Fri, 28 Feb 2020 09:29:05 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m125sm3004795wmf.8.2020.02.28.09.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 09:29:05 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        jacob.jun.pan@intel.com, robin.murphy@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 2/3] PCI: Add DMA configuration for virtual platforms
Date:   Fri, 28 Feb 2020 18:25:37 +0100
Message-Id: <20200228172537.377327-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200228172537.377327-1-jean-philippe@linaro.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hardware platforms usually describe the IOMMU topology using either
device-tree pointers or vendor-specific ACPI tables.  For virtual
platforms that don't provide a device-tree, the virtio-iommu device
contains a description of the endpoints it manages.  That information
allows us to probe endpoints after the IOMMU is probed (possibly as late
as userspace modprobe), provided it is discovered early enough.

Add a hook to pci_dma_configure(), which returns -EPROBE_DEFER if the
endpoint is managed by a vIOMMU that will be loaded later, or 0 in any
other case to avoid disturbing the normal DMA configuration methods.
When CONFIG_VIRTIO_IOMMU_TOPOLOGY isn't selected, the call to
virt_dma_configure() is compiled out.

As long as the information is consistent, platforms can provide both a
device-tree and a built-in topology, and the IOMMU infrastructure is
able to deal with multiple DMA configuration methods.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/pci-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0454ca0e4e3f..69303a814f21 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -18,6 +18,7 @@
 #include <linux/kexec.h>
 #include <linux/of_device.h>
 #include <linux/acpi.h>
+#include <linux/virt_iommu.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -1602,6 +1603,10 @@ static int pci_dma_configure(struct device *dev)
 	struct device *bridge;
 	int ret = 0;
 
+	ret = virt_dma_configure(dev);
+	if (ret)
+		return ret;
+
 	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
-- 
2.25.0

