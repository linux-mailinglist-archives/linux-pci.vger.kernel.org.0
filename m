Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092C23BA927
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhGCPPp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Jul 2021 11:15:45 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:37464 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhGCPPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Jul 2021 11:15:45 -0400
Received: by mail-lf1-f47.google.com with SMTP id q16so23896871lfr.4
        for <linux-pci@vger.kernel.org>; Sat, 03 Jul 2021 08:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nCceiwSHotY6w4BBLh4dMsz6eJ1AQ5LepYY/lC2O4FM=;
        b=kUsrdVT827aHCtrD3MDvpMHsBxnmZ/wHFz8lEbfsg4HRcCvcioDDiWFS5FCW2cRRoq
         85inlUoxrUuGJs9SHUPz+eE8pi4fgLdj8FR6bHNmA7rEIVb55gtVez/HNlbXbo3G55jb
         L6a9muSpe/BIfmCA0NAy/HwYwyhnOZTXB7Rd9B+fEmj2RFn0mJjCzWzwV8LGvNml/QbB
         7+iOIv2b6rt8vt6swvPbdJ7m1kOjQDtQA8udeSMtQTWsODQIFwoNksOO/vO+mXa8OrTh
         +MFEHHxcsZbKFiWqOV+XrnnXoN7oOOL2Zk6Xv9UW5UrlxmdjgwJs17Co5ciCeTmMzDkV
         nO4A==
X-Gm-Message-State: AOAM530wJeBfn0WPY8JA8IsDsmklP3ZB4PDePMAwUs5ukuBnJ4FLWnj0
        UhN/m2voGI1K0umv0xcFclY=
X-Google-Smtp-Source: ABdhPJzHK9ktHD/bQ+3Iia917/0ikz0iROMcW/8hBE7sgMIo1QGtwIH/XheGnnYhz2cfotc+aHfDQw==
X-Received: by 2002:a05:6512:2251:: with SMTP id i17mr3254363lfu.194.1625325189448;
        Sat, 03 Jul 2021 08:13:09 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p18sm715980ljj.56.2021.07.03.08.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 08:13:08 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Scott Murray <scott@spiteful.org>,
        Tom Joseph <tjoseph@cadence.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/5] PCI: iproc: Fix kernel-doc formatting
Date:   Sat,  3 Jul 2021 15:13:03 +0000
Message-Id: <20210703151306.1922450-2-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210703151306.1922450-1-kw@linux.com>
References: <20210703151306.1922450-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix kernel-doc formatting used to describe structs, enum types
and functions in the pcie-iproc.c, pcie-iproc-msi.c and pcie-iproc.h
files.

Also, add documentation for the "mem" member of the struct iproc_pcie,
and the enum values "IPROC_PCIE_IB_MAP_MEM", "IPROC_PCIE_IB_MAP_IO" and
"IPROC_PCIE_IB_MAP_INVALID" of the enum iproc_pcie_ib_map_type.

Thus, resolve the following build time warning related to kernel-doc:

  drivers/pci/controller/pcie-iproc.c:92: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.c:139: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.c:153: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.c:441: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.c:623: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.c:901: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.c:151: warning: Enum value 'IPROC_PCIE_IB_MAP_MEM' not described in enum 'iproc_pcie_ib_map_type'
  drivers/pci/controller/pcie-iproc.c:151: warning: Enum value 'IPROC_PCIE_IB_MAP_IO' not described in enum 'iproc_pcie_ib_map_type'
  drivers/pci/controller/pcie-iproc.c:151: warning: Enum value 'IPROC_PCIE_IB_MAP_INVALID' not described in enum 'iproc_pcie_ib_map_type'

  drivers/pci/controller/pcie-iproc-msi.c:52: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc-msi.c:68: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

  drivers/pci/controller/pcie-iproc.h:11: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.h:28: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.h:39: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.h:51: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc.h:112: warning: Function parameter or member 'mem' not described in 'iproc_pcie'

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pcie-iproc-msi.c |  4 ++--
 drivers/pci/controller/pcie-iproc.c     | 24 +++++++++++-------------
 drivers/pci/controller/pcie-iproc.h     | 18 +++++++++++++-----
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index eede4e8f3f75..21d28dc0b901 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -49,7 +49,7 @@ enum iproc_msi_reg {
 struct iproc_msi;
 
 /**
- * iProc MSI group
+ * struct iproc_msi_grp - iProc MSI group
  *
  * One MSI group is allocated per GIC interrupt, serviced by one iProc MSI
  * event queue.
@@ -65,7 +65,7 @@ struct iproc_msi_grp {
 };
 
 /**
- * iProc event queue based MSI
+ * struct iproc_msi - iProc event queue based MSI
  *
  * Only meant to be used on platforms without MSI support integrated into the
  * GIC.
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 02e52f698eeb..5b2a02a309cf 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -89,8 +89,8 @@
 #define IPROC_PCIE_REG_INVALID		0xffff
 
 /**
- * iProc PCIe outbound mapping controller specific parameters
- *
+ * struct iproc_pcie_ob_map - iProc PCIe outbound mapping controller specific
+ * parameters
  * @window_sizes: list of supported outbound mapping window sizes in MB
  * @nr_sizes: number of supported outbound mapping window sizes
  */
@@ -136,22 +136,20 @@ static const struct iproc_pcie_ob_map paxb_v2_ob_map[] = {
 };
 
 /**
- * iProc PCIe inbound mapping type
+ * enum iproc_pcie_ib_map_type - iProc PCIe inbound mapping type
+ * @IPROC_PCIE_IB_MAP_MEM: DDR memory
+ * @IPROC_PCIE_IB_MAP_IO: device I/O memory
+ * @IPROC_PCIE_IB_MAP_INVALID: invalid or unused
  */
 enum iproc_pcie_ib_map_type {
-	/* for DDR memory */
 	IPROC_PCIE_IB_MAP_MEM = 0,
-
-	/* for device I/O memory */
 	IPROC_PCIE_IB_MAP_IO,
-
-	/* invalid or unused */
 	IPROC_PCIE_IB_MAP_INVALID
 };
 
 /**
- * iProc PCIe inbound mapping controller specific parameters
- *
+ * struct iproc_pcie_ib_map - iProc PCIe inbound mapping controller specific
+ * parameters
  * @type: inbound mapping region type
  * @size_unit: inbound mapping region size unit, could be SZ_1K, SZ_1M, or
  * SZ_1G
@@ -437,7 +435,7 @@ static inline void iproc_pcie_write_reg(struct iproc_pcie *pcie,
 	writel(val, pcie->base + offset);
 }
 
-/**
+/*
  * APB error forwarding can be disabled during access of configuration
  * registers of the endpoint device, to prevent unsupported requests
  * (typically seen during enumeration with multi-function devices) from
@@ -619,7 +617,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-/**
+/*
  * Note access to the configuration registers are protected at the higher layer
  * by 'pci_lock' in drivers/pci/access.c
  */
@@ -897,7 +895,7 @@ static inline int iproc_pcie_ob_write(struct iproc_pcie *pcie, int window_idx,
 	return 0;
 }
 
-/**
+/*
  * Some iProc SoCs require the SW to configure the outbound address mapping
  *
  * Outbound address translation:
diff --git a/drivers/pci/controller/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
index c2676e442f55..170247f7e49e 100644
--- a/drivers/pci/controller/pcie-iproc.h
+++ b/drivers/pci/controller/pcie-iproc.h
@@ -7,7 +7,15 @@
 #define _PCIE_IPROC_H
 
 /**
- * iProc PCIe interface type
+ * enum iproc_pcie_type - iProc PCIe interface type
+ * @IPROC_PCIE_PAXB_BCMA: new generation of iProc BCMA-based host controllers
+ * @IPROC_PCIE_PAXB: iProc PAXB-based host controllers for SoCs such as NS, NSP,
+ * Cygnus, NS2 and Pegasus
+ * @IPROC_PCIE_PAXB_V2: next generation of iProc PAXB-based host controllers
+ * using the Stingray SoCs
+ * @IPROC_PCIE_PAXC: iProx PAXC-based host controllers
+ * @IPROC_PCIE_PAXC_V2: Second generation of the iProc PAXC-based host
+ * controllers
  *
  * PAXB is the wrapper used in root complex that can be connected to an
  * external endpoint device.
@@ -24,7 +32,7 @@ enum iproc_pcie_type {
 };
 
 /**
- * iProc PCIe outbound mapping
+ * struct iproc_pcie_ob - iProc PCIe outbound mapping
  * @axi_offset: offset from the AXI address to the internal address used by
  * the iProc PCIe core
  * @nr_windows: total number of supported outbound mapping windows
@@ -35,7 +43,7 @@ struct iproc_pcie_ob {
 };
 
 /**
- * iProc PCIe inbound mapping
+ * struct iproc_pcie_ib - iProc PCIe inbound mapping
  * @nr_regions: total number of supported inbound mapping regions
  */
 struct iproc_pcie_ib {
@@ -47,13 +55,13 @@ struct iproc_pcie_ib_map;
 struct iproc_msi;
 
 /**
- * iProc PCIe device
- *
+ * struct iproc_pcie - iProc PCIe device
  * @dev: pointer to device data structure
  * @type: iProc PCIe interface type
  * @reg_offsets: register offsets
  * @base: PCIe host controller I/O register base
  * @base_addr: PCIe host controller register base physical address
+ * @mem: host bridge memory window resource
  * @phy: optional PHY device that controls the Serdes
  * @map_irq: function callback to map interrupts
  * @ep_is_internal: indicates an internal emulated endpoint device is connected
-- 
2.32.0

