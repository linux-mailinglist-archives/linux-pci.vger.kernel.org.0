Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 332F4A48DD
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2019 13:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfIALZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Sep 2019 07:25:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37216 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfIALZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Sep 2019 07:25:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id d16so11795085wme.2;
        Sun, 01 Sep 2019 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=01HPTey408UCBL639ZxLYtnZytu5ResDsXDWNRYopFs=;
        b=uNkmgSDRj0aCeJn8wLr/V5uo7ANHZI0Ir4fFw+tfD1CApEj8Mh/wK0Ze7wqdsdBTwD
         wKWWEheNTcNp0sLjO2N31rD5C/mAyePd5I7tPCw+uazWklSplQpGR8VILBdNyVTG1EKy
         x38I63zw9kYwo6PFRwKZyMWg6l3Z74zmSEaE4RXuSFukNISKQDboWeB8EAD5yrS+hfRN
         dBNbudRWyt/FYS5Ire4D12/nCZX29mdcqnjnQpH42mVJ2xlBHRdGvB2PLhH/6QTKYCNe
         DnUIsqnWL3uxsBg0t21xLKaRb609UUIlp8hgs52Bo9OTq4DscFhMg6CpMHf6BBQujP37
         U7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=01HPTey408UCBL639ZxLYtnZytu5ResDsXDWNRYopFs=;
        b=sOguh9vnIqWTuurRgsk9KYNhHvjNWrVdD95hx1Lwv3x4QlbnYik/a8GUV2EP2ROIB4
         5v2hEsvNwPNmFr96a2y+6tZZivu/gXMI0VnsZnMCKz/jnu1UdUfzL3Pg/r75ZvB90v4I
         wViMxXHDov9jpBiPZfEL/FqE48dA7LDgj7eWlUd3C/wWQXL+cy45GwZt2bDeeRVJv/IQ
         Lh+MmIb0i4UxNNFp1kOcJM44T/PQH1CnioB7PMq8gzQTwfTzEEDLsSeTNzgLtisyD9oe
         6OGkqH1mP7z8ONX8OkjNvVUJ89IcFJrXTcLJxsX8hJgkzo+qP5Z09nf9CgUh5QUn+pM5
         92RQ==
X-Gm-Message-State: APjAAAW1uAb0y5/yZtFT4lg7QyONRDhsvp4c7e5WKfdXJGQ+dX/Jm541
        0ORbobWVmVbZaaXuYkg793Bv4sf9q3r54A==
X-Google-Smtp-Source: APXvYqy1j+qHgGkl142BUZQL/cgCiSDmmOxkvewbJoqW69rnrk6CVgyUWdrQETI/0pc6am1fndsuUg==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr28564345wmk.33.1567337109185;
        Sun, 01 Sep 2019 04:25:09 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id x5sm747241wrg.69.2019.09.01.04.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 04:25:08 -0700 (PDT)
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
Subject: [PATCH] PCI: Remove unused includes and superfluous struct declaration
Date:   Sun,  1 Sep 2019 13:25:06 +0200
Message-Id: <20190901112506.8469-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
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
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 drivers/pci/controller/pci-aardvark.c             | 1 +
 drivers/pci/pci.c                                 | 1 +
 drivers/pci/probe.c                               | 1 +
 include/linux/of_pci.h                            | 4 +---
 6 files changed, 7 insertions(+), 3 deletions(-)

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
index 21a89c4880fa..7929b4c0e886 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -2,11 +2,9 @@
 #ifndef __OF_PCI_H
 #define __OF_PCI_H
 
-#include <linux/pci.h>
-#include <linux/msi.h>
+#include <linux/types.h>
 
 struct pci_dev;
-struct of_phandle_args;
 struct device_node;
 
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_PCI)
-- 
2.23.0

