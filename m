Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F7B389594
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 20:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhESSjw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 14:39:52 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46066 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhESSjv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 14:39:51 -0400
Received: by mail-wr1-f41.google.com with SMTP id h4so15019878wrt.12
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 11:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8t4NT32QukReqRKb3NsCwROkTdHScpGYLxCsr2Y3rQ=;
        b=io4n6Al4m5JKhBVVuZ6kahCJn+5RX+G21HJI28cQfSjpW38tKFQHRmff8rnfiUqAwr
         StezugG4Ijqmnx8gH3/TW/5yqSAGe06uDJO6XuSiDk6EydhDGsreSsNRd+9q+XFklkZx
         V1i2bUoHihBjs/kmde+9H4vK/k+EKF//RLPTCR220nYLG7rIwtbDl5JWJkam1ttcHMoG
         WRi+a+fySMGd4VQ479dy/4jTlFq1yoSd+aovUSRhXOQyJOswIyQHBCSeh2uqlSGEE0ny
         u+CHqqJZexRfLOHoFPffAf6jRMqoipd/9b4qj3reWIT2Z5TFJkNa+YEr0uPfRTFwXLAY
         NxBg==
X-Gm-Message-State: AOAM531uHtmuvCbBBQ0cGzlCS8SgLuzbrXpWUUc1J3tnaS5Ap8TIx2sX
        Bleq7dBqwz0EOg8GM+dr05E=
X-Google-Smtp-Source: ABdhPJwEIt9r+mxQPzuJWnsQwidF6so1M8PzWXWewsx4a1G+n+xzx6I9b4pWr8SEpnQbZHZDgloGoA==
X-Received: by 2002:a5d:63c1:: with SMTP id c1mr310922wrw.71.1621449510610;
        Wed, 19 May 2021 11:38:30 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id q1sm6583457wmq.48.2021.05.19.11.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 11:38:30 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Ray Jui <rjui@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] PCI: iproc: Fix a non-compliant kernel-doc
Date:   Wed, 19 May 2021 18:38:29 +0000
Message-Id: <20210519183829.165982-1-kw@linux.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Correct a non-compliant kernel-doc used to describe struct and enum
types and functions in the pcie-iproc.c and pcie-iproc-msi.c files, and
resolve the following build time warning related to kernel-doc:

  drivers/pci/controller/pcie-iproc.c:92: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.c:139: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.c:153: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.c:441: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.c:623: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.c:901: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

  drivers/pci/controller/pcie-iproc-msi.c:52: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc-msi.c:68: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pcie-iproc-msi.c | 16 ++++++++--------
 drivers/pci/controller/pcie-iproc.c     | 14 ++++++++------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index eede4e8f3f75..65ea83d2abfa 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -49,14 +49,14 @@ enum iproc_msi_reg {
 struct iproc_msi;
 
 /**
- * iProc MSI group
- *
- * One MSI group is allocated per GIC interrupt, serviced by one iProc MSI
- * event queue.
+ * struct iproc_msi_grp - iProc MSI group
  *
  * @msi: pointer to iProc MSI data
  * @gic_irq: GIC interrupt
  * @eq: Event queue number
+ *
+ * One MSI group is allocated per GIC interrupt, serviced by one iProc MSI
+ * event queue.
  */
 struct iproc_msi_grp {
 	struct iproc_msi *msi;
@@ -65,10 +65,7 @@ struct iproc_msi_grp {
 };
 
 /**
- * iProc event queue based MSI
- *
- * Only meant to be used on platforms without MSI support integrated into the
- * GIC.
+ * struct iproc_msi - iProc event queue based MSI
  *
  * @pcie: pointer to iProc PCIe data
  * @reg_offsets: MSI register offsets
@@ -89,6 +86,9 @@ struct iproc_msi_grp {
  * @eq_cpu: pointer to allocated memory region for MSI event queues
  * @eq_dma: DMA address of MSI event queues
  * @msi_addr: MSI address
+ *
+ * Only meant to be used on platforms without MSI support integrated into the
+ * GIC.
  */
 struct iproc_msi {
 	struct iproc_pcie *pcie;
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 02e52f698eeb..8e45288c9abc 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -89,7 +89,8 @@
 #define IPROC_PCIE_REG_INVALID		0xffff
 
 /**
- * iProc PCIe outbound mapping controller specific parameters
+ * struct iproc_pcie_ob_map - iProc PCIe outbound mapping controller specific
+ *			      parameters.
  *
  * @window_sizes: list of supported outbound mapping window sizes in MB
  * @nr_sizes: number of supported outbound mapping window sizes
@@ -136,7 +137,7 @@ static const struct iproc_pcie_ob_map paxb_v2_ob_map[] = {
 };
 
 /**
- * iProc PCIe inbound mapping type
+ * enum iproc_pcie_ib_map_type - iProc PCIe inbound mapping type.
  */
 enum iproc_pcie_ib_map_type {
 	/* for DDR memory */
@@ -150,7 +151,8 @@ enum iproc_pcie_ib_map_type {
 };
 
 /**
- * iProc PCIe inbound mapping controller specific parameters
+ * struct iproc_pcie_ib_map - iProc PCIe inbound mapping controller specific
+ *			      parameters.
  *
  * @type: inbound mapping region type
  * @size_unit: inbound mapping region size unit, could be SZ_1K, SZ_1M, or
@@ -437,7 +439,7 @@ static inline void iproc_pcie_write_reg(struct iproc_pcie *pcie,
 	writel(val, pcie->base + offset);
 }
 
-/**
+/*
  * APB error forwarding can be disabled during access of configuration
  * registers of the endpoint device, to prevent unsupported requests
  * (typically seen during enumeration with multi-function devices) from
@@ -619,7 +621,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-/**
+/*
  * Note access to the configuration registers are protected at the higher layer
  * by 'pci_lock' in drivers/pci/access.c
  */
@@ -897,7 +899,7 @@ static inline int iproc_pcie_ob_write(struct iproc_pcie *pcie, int window_idx,
 	return 0;
 }
 
-/**
+/*
  * Some iProc SoCs require the SW to configure the outbound address mapping
  *
  * Outbound address translation:
-- 
2.31.1

