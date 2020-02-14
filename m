Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A57D15ECFC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2020 18:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389677AbgBNQG5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Feb 2020 11:06:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40996 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390540AbgBNQG5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2020 11:06:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so11507381wrw.8
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2020 08:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVzPEuR2GzNf0eW4z63MDHB1xQMo/xWUQqLWfLG280k=;
        b=LbVawefNsNK5xsQXVpuxbuZa6Q+Ro2kzDz5awpUdiaWEStonew9PvGMhKaKJ2Ns56E
         GHBltfS0JO1bH3rvxRs0ik9VxMLOWSC9H78CCjyiF+3H4GppER2KXTcfLY/2Ei0nK0zo
         xlgfFHbDonykWeMD0XdrWkGaKQL88ln53/He0ztGVQkCB+2jU0Jt8LDDRPuvXHYN013s
         v7GD03hJziZWYTmgPVJmAVsjQ525ArtHfowBSTDXGS2Uw4nKNmBd6IvlhvbbQn63eKIm
         P4+xILLOxik7iDZ1DeJM71g2yMpvy4fSd+x90a6aHvBA6JatnpRedSF0Y7zyMQ8sOznM
         nDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVzPEuR2GzNf0eW4z63MDHB1xQMo/xWUQqLWfLG280k=;
        b=XL9pctOOS04OEUfEUNaxCfh0+Dz1Z0hhnRRwLqcWpg3zy8NC5k/FL/WxY39Up25ouR
         Rce2Goie3O0ZosPrDxG8tEJS+aQ3E9goCVSzvODGpK0dBgoGXqhwyAFwZVJF0RpIVygA
         3AWclDJ1EAdF7rDwVFQksEJzFvqGMQ2vsu2cSlaI54AMe8jW3gnCXrYKispWrae9xMoG
         L3t3NtsNHxOg6FngATdbMli2xn579DNtJC7ZPx/t06JSjrvRg9ottTEVK9N7iX1vouU3
         P0ULERN5Y1/xT1MW8HPiYo5b1lafF6xV6v536DeqOGskvji+HtJ+qtOsGXNjE/UddwSF
         Rfmg==
X-Gm-Message-State: APjAAAU1TMlTUGqRGI4iCtGL5EFzo7k9ZdHlrLMcDETmw2lHloVQXcbt
        vl1f4xdqj1eul6B9+inaQLtRlQ==
X-Google-Smtp-Source: APXvYqzS8V0tCvCvdw2/7KXFxuSe/ELDiODN+rviauMsHmG64mtrXiNxZ6zFV4elx5ANfP9abZnOaQ==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr5070480wre.58.1581696415173;
        Fri, 14 Feb 2020 08:06:55 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s139sm8133213wme.35.2020.02.14.08.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 08:06:54 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        jacob.jun.pan@intel.com
Subject: [PATCH 2/3] PCI: Add DMA configuration for virtual platforms
Date:   Fri, 14 Feb 2020 17:04:12 +0100
Message-Id: <20200214160413.1475396-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214160413.1475396-1-jean-philippe@linaro.org>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
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

