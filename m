Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93CA8A676B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 13:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfICLbF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 07:31:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40188 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICLbE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2019 07:31:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id t9so17802760wmi.5;
        Tue, 03 Sep 2019 04:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Ekc0W7zJk5w+9GqjfFzhlAJ4FiN+oEvkKnq/TUY/UA=;
        b=rxQ0A7gL/rvUTRgFS/x6Jhz66KR/9EtqdUj00Gi6qx2X2kvUeehgUkd8+p67o1zAdh
         jhHPTILE48XYrnwg8UBBO258FnM17/u/jy7Djy7SpVAb0P8pFAoTW1qOfpfAwfNjhJAT
         DgMvezl32n1VEXVXQNQbjeAq4GqCIpmC++6kN/xbkwj+u+PUgbKIgQ1Llm24sLydd5ao
         LKeszXIV4Hr0QQP3BUctE8YxTL4jz9rRJTA4f8AjNqEOacNNW1CVAeZAN2slkCI5Hcqh
         2/OS+iB6IzU6RSZYWkyMRuB5kD1XX6OEaiVdFvsFPUttT5lL/m20kyhe/Hpi4gYMB5ti
         fqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2Ekc0W7zJk5w+9GqjfFzhlAJ4FiN+oEvkKnq/TUY/UA=;
        b=tDxBYroz5O57qM5WaSrjNVg1DVHNtNoxn4coX1hza0V+YMxqRBI+1jUNy1WRa8tAy5
         JJOy1tK3MQ4uisSzvX3K4QBSxMWbTbqsmdRctHGbRCOv53fyMM+1JCqkz+BnrVzGstX3
         WTTul8zMefWMMcYnSUWbvaexcRl+EBzNf5GSK5dOX3pNHG2E2ZkBhbqKXbzpdzDiUGxV
         AVp4E/xKMZM5KNZi9lO/Qb5UOvedjWFAhrqmAXKjvb2RU77aj5R+jPtTsrqW6B8eCSZt
         nqlnIXfhlp/aN+hCuTaXzH8HymZZxV+cARc5DgTDsKIbjgHwbK4w6CJzYnWcMVFOtgnQ
         YmVQ==
X-Gm-Message-State: APjAAAUTkOj5utBNld4ujSBjBsQYT/KRzA/HzPnKzkAGNIRIOfRrR1yn
        0YH17IVIbEvB68Tum4CG6xMtVLV3QZa0iA==
X-Google-Smtp-Source: APXvYqziAyX3arV2k8bnfEcXOZ1Bh4SmqiEN1nono5tsDY7ufXY/SqE/5xUTbeQQ6Nd5YaemyR+OCQ==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr29102252wmd.14.1567510261446;
        Tue, 03 Sep 2019 04:31:01 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id l2sm19455074wme.36.2019.09.03.04.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:31:00 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2] PCI: Remove unused includes and superfluous struct declaration
Date:   Tue,  3 Sep 2019 13:30:59 +0200
Message-Id: <20190903113059.2901-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190901112506.8469-1-kw@linux.com>
References: <20190901112506.8469-1-kw@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove <linux/pci.h> and <linux/msi.h> from being included
directly as part of the include/linux/of_pci.h, and remove
superfluous declaration of struct of_phandle_args.

Move users of include <linux/of_pci.h> to include <linux/pci.h>
and <linux/msi.h> directly rather than rely on both being
included transitively through <linux/of_pci.h>.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/iommu/of_iommu.c                          | 2 ++
 drivers/irqchip/irq-gic-v2m.c                     | 1 +
 drivers/irqchip/irq-gic-v3-its-pci-msi.c          | 1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 drivers/pci/controller/pci-aardvark.c             | 1 +
 drivers/pci/controller/pci-thunder-pem.c          | 1 +
 drivers/pci/pci.c                                 | 1 +
 drivers/pci/probe.c                               | 1 +
 include/linux/of_pci.h                            | 5 ++---
 9 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 614a93aa5305..026ad2b29dcd 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -8,6 +8,8 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include <linux/limits.h>
+#include <linux/pci.h>
+#include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index e88e75c22b6a..fbec07d634ad 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 229d586c3d7a..87711e0f8014 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/acpi_iort.h>
+#include <linux/pci.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d3156446ff27..7a9bef993e57 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -10,6 +10,7 @@
 
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/pci_regs.h>
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index fc0fe4d4de49..3a05f6ca95b0 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -16,6 +16,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 
diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
index f127ce8bd4ef..9491e266b1ea 100644
--- a/drivers/pci/controller/pci-thunder-pem.c
+++ b/drivers/pci/controller/pci-thunder-pem.c
@@ -6,6 +6,7 @@
 #include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/pci.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/pci-acpi.h>
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 484e35349565..571e7e00984b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
+#include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 169943f17a4c..11b11a652d18 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/msi.h>
 #include <linux/of_device.h>
 #include <linux/of_pci.h>
 #include <linux/pci_hotplug.h>
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 21a89c4880fa..29658c0ee71f 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -2,11 +2,10 @@
 #ifndef __OF_PCI_H
 #define __OF_PCI_H
 
-#include <linux/pci.h>
-#include <linux/msi.h>
+#include <linux/types.h>
+#include <linux/errno.h>
 
 struct pci_dev;
-struct of_phandle_args;
 struct device_node;
 
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_PCI)
-- 
2.23.0

