Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526EB3BA4C0
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 22:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhGBUm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 16:42:59 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39889 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhGBUm6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 16:42:58 -0400
Received: by mail-lj1-f182.google.com with SMTP id e3so6522127ljo.6
        for <linux-pci@vger.kernel.org>; Fri, 02 Jul 2021 13:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XmZGkFlIjDwabyMzBOy9CvoDQY094ZNfNgHxGJydqU=;
        b=jQq3TspO6gY5XaFMq7XSOAaxtBNaWbO7SA+U+vUP8S6AXdl+YlN79p9Se6eekd9wZz
         2i8ORiQYKn1pE4l2hTIu7cpJYWbAuEAQ4X7MJcMxFzRP8UkojZxOCwCZhz5AsuXbRtnF
         WOnW4ZHvJ9P6MYZAqRVy2I3XIYROtKuSqe0sTrm7spaKvzB/dd9WtJTnn+KEZ+eRSHxb
         n+h/VxLstMWNav4EwUakBzw93/K0oHQVpfq9b7FUmyFUDbmPYxqgI2jetVg2cKm09e2U
         234hHyCnSY3q1UpZFXH9x8IHwrHqwCC1m4w470OFfSDr/lu/EmbH/V43NrbQb8JCsYHs
         NAwQ==
X-Gm-Message-State: AOAM533VaIiZyu1jpGvHCci0d2/EgwFvlY525btZp8taWyHK98QXyziV
        gfPHu/2BwALjyDkpaTjiZlg=
X-Google-Smtp-Source: ABdhPJypg+iexLBW3WPDv001kjr9yidLe0RVPFcjpaX8B5vb4zz6NS5iC3Vq8H8BvBWbKE1Gii99dQ==
X-Received: by 2002:a2e:3e07:: with SMTP id l7mr970502lja.131.1625258424304;
        Fri, 02 Jul 2021 13:40:24 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o142sm364201lfa.299.2021.07.02.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 13:40:23 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Ray Jui <rjui@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] PCI: iproc: Fix a non-compliant kernel-doc
Date:   Fri,  2 Jul 2021 20:40:22 +0000
Message-Id: <20210702204022.1654290-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix a non-compliant kernel-doc used to describe struct and enum types
and functions in the pcie-iproc.c, pcie-iproc-msi.c and pcie-iproc.h
files.

Add missing documentation of the "mem" filed of the struct iproc_pcie,
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
 drivers/pci/controller/pcie-iproc-msi.c | 54 +++++++--------
 drivers/pci/controller/pcie-iproc.c     | 49 +++++++-------
 drivers/pci/controller/pcie-iproc.h     | 88 +++++++++++++++----------
 3 files changed, 103 insertions(+), 88 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index eede4e8f3f75..d20e66319774 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -49,14 +49,14 @@ enum iproc_msi_reg {
 struct iproc_msi;
 
 /**
- * iProc MSI group
+ * struct iproc_msi_grp - iProc MSI group.
  *
- * One MSI group is allocated per GIC interrupt, serviced by one iProc MSI
- * event queue.
+ * @msi:	Pointer to iProc MSI data.
+ * @gic_irq:	GIC interrupt.
+ * @eq:		Event queue number.
  *
- * @msi: pointer to iProc MSI data
- * @gic_irq: GIC interrupt
- * @eq: Event queue number
+ * One MSI group is allocated per GIC interrupt, serviced by one iProc MSI event
+ * queue.
  */
 struct iproc_msi_grp {
 	struct iproc_msi *msi;
@@ -65,30 +65,30 @@ struct iproc_msi_grp {
 };
 
 /**
- * iProc event queue based MSI
+ * struct iproc_msi - iProc event queue based MSI.
+ *
+ * @pcie:		Pointer to iProc PCIe data.
+ * @reg_offsets:	MSI register offsets.
+ * @grps:		MSI groups.
+ * @nr_irqs:		Number of total interrupts connected to GIC.
+ * @nr_cpus:		Number of toal CPUs.
+ * @has_inten_reg:	Indicates the MSI interrupt enable register needs to be
+ *			set explicitly (required for some legacy platforms).
+ * @bitmap:		MSI vector bitmap.
+ * @bitmap_lock:	Lock to protect access to the MSI bitmap.
+ * @nr_msi_vecs:	Total number of MSI vectors.
+ * @inner_domain:	Inner IRQ domain.
+ * @msi_domain:		MSI IRQ domain.
+ * @nr_eq_region:	Required number of 4K aligned memory region for MSI
+ *			event queues.
+ * @nr_msi_region:	Required number of 4K aligned address region for MSI
+ *			posted writes.
+ * @eq_cpu:		Pointer to allocated memory region for MSI event queues.
+ * @eq_dma:		DMA address of MSI event queues.
+ * @msi_addr:		MSI address.
  *
  * Only meant to be used on platforms without MSI support integrated into the
  * GIC.
- *
- * @pcie: pointer to iProc PCIe data
- * @reg_offsets: MSI register offsets
- * @grps: MSI groups
- * @nr_irqs: number of total interrupts connected to GIC
- * @nr_cpus: number of toal CPUs
- * @has_inten_reg: indicates the MSI interrupt enable register needs to be
- * set explicitly (required for some legacy platforms)
- * @bitmap: MSI vector bitmap
- * @bitmap_lock: lock to protect access to the MSI bitmap
- * @nr_msi_vecs: total number of MSI vectors
- * @inner_domain: inner IRQ domain
- * @msi_domain: MSI IRQ domain
- * @nr_eq_region: required number of 4K aligned memory region for MSI event
- * queues
- * @nr_msi_region: required number of 4K aligned address region for MSI posted
- * writes
- * @eq_cpu: pointer to allocated memory region for MSI event queues
- * @eq_dma: DMA address of MSI event queues
- * @msi_addr: MSI address
  */
 struct iproc_msi {
 	struct iproc_pcie *pcie;
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 02e52f698eeb..2a400bf81f58 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -89,10 +89,10 @@
 #define IPROC_PCIE_REG_INVALID		0xffff
 
 /**
- * iProc PCIe outbound mapping controller specific parameters
- *
- * @window_sizes: list of supported outbound mapping window sizes in MB
- * @nr_sizes: number of supported outbound mapping window sizes
+ * struct iproc_pcie_ob_map - iProc PCIe outbound mapping controller specific
+ *			      parameters.
+ * @window_sizes:	List of supported outbound mapping window sizes in MB.
+ * @nr_sizes:		Number of supported outbound mapping window sizes.
  */
 struct iproc_pcie_ob_map {
 	resource_size_t window_sizes[MAX_NUM_OB_WINDOW_SIZES];
@@ -136,32 +136,31 @@ static const struct iproc_pcie_ob_map paxb_v2_ob_map[] = {
 };
 
 /**
- * iProc PCIe inbound mapping type
+ * enum iproc_pcie_ib_map_type - iProc PCIe inbound mapping type.
+ * @IPROC_PCIE_IB_MAP_MEM:	DDR memory.
+ * @IPROC_PCIE_IB_MAP_IO:	Device I/O memory.
+ * @IPROC_PCIE_IB_MAP_INVALID:	Invalid or unused.
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
- * @type: inbound mapping region type
- * @size_unit: inbound mapping region size unit, could be SZ_1K, SZ_1M, or
- * SZ_1G
- * @region_sizes: list of supported inbound mapping region sizes in KB, MB, or
- * GB, depending on the size unit
- * @nr_sizes: number of supported inbound mapping region sizes
- * @nr_windows: number of supported inbound mapping windows for the region
- * @imap_addr_offset: register offset between the upper and lower 32-bit
- * IMAP address registers
- * @imap_window_offset: register offset between each IMAP window
+ * struct iproc_pcie_ib_map - iProc PCIe inbound mapping controller specific
+ *			      parameters.
+ * @type:		Inbound mapping region type
+ * @size_unit:		Inbound mapping region size unit, could be SZ_1K, SZ_1M,
+ *			or SZ_1G.
+ * @region_sizes:	List of supported inbound mapping region sizes in KB,
+ *			MB, or GB, depending on the size unit.
+ * @nr_sizes:		Number of supported inbound mapping region sizes.
+ * @nr_windows:		Number of supported inbound mapping windows for the
+ *			region.
+ * @imap_addr_offset:	Register offset between the upper and lower 32-bit IMAP
+ *			address registers.
+ * @imap_window_offset:	Register offset between each IMAP window.
  */
 struct iproc_pcie_ib_map {
 	enum iproc_pcie_ib_map_type type;
@@ -437,7 +436,7 @@ static inline void iproc_pcie_write_reg(struct iproc_pcie *pcie,
 	writel(val, pcie->base + offset);
 }
 
-/**
+/*
  * APB error forwarding can be disabled during access of configuration
  * registers of the endpoint device, to prevent unsupported requests
  * (typically seen during enumeration with multi-function devices) from
@@ -619,7 +618,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-/**
+/*
  * Note access to the configuration registers are protected at the higher layer
  * by 'pci_lock' in drivers/pci/access.c
  */
@@ -897,7 +896,7 @@ static inline int iproc_pcie_ob_write(struct iproc_pcie *pcie, int window_idx,
 	return 0;
 }
 
-/**
+/*
  * Some iProc SoCs require the SW to configure the outbound address mapping
  *
  * Outbound address translation:
diff --git a/drivers/pci/controller/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
index c2676e442f55..432ce216f1fb 100644
--- a/drivers/pci/controller/pcie-iproc.h
+++ b/drivers/pci/controller/pcie-iproc.h
@@ -7,7 +7,16 @@
 #define _PCIE_IPROC_H
 
 /**
- * iProc PCIe interface type
+ * enum iproc_pcie_type - iProc PCIe interface type.
+ * @IPROC_PCIE_PAXB_BCMA:	New generation of iProc BCMA-based host
+ *				controllers.
+ * @IPROC_PCIE_PAXB:		iProc PAXB-based host controllers for SoCs such
+ *				as NS, NSP, Cygnus, NS2 and Pegasus.
+ * @IPROC_PCIE_PAXB_V2:		Next generation of iProc PAXB-based host
+ *				controllers using the Stingray SoCs.
+ * @IPROC_PCIE_PAXC:		iProx PAXC-based host controllers.
+ * @IPROC_PCIE_PAXC_V2:		Second generation of the iProc PAXC-based host
+ *				controllers.
  *
  * PAXB is the wrapper used in root complex that can be connected to an
  * external endpoint device.
@@ -24,10 +33,10 @@ enum iproc_pcie_type {
 };
 
 /**
- * iProc PCIe outbound mapping
- * @axi_offset: offset from the AXI address to the internal address used by
- * the iProc PCIe core
- * @nr_windows: total number of supported outbound mapping windows
+ * struct iproc_pcie_ob - iProc PCIe outbound mapping.
+ * @axi_offset:	Offset from the AXI address to the internal address used by the
+ *		iProc PCIe core.
+ * @nr_windows:	Total number of supported outbound mapping windows.
  */
 struct iproc_pcie_ob {
 	resource_size_t axi_offset;
@@ -35,8 +44,8 @@ struct iproc_pcie_ob {
 };
 
 /**
- * iProc PCIe inbound mapping
- * @nr_regions: total number of supported inbound mapping regions
+ * struct iproc_pcie_ib - iProc PCIe inbound mapping.
+ * @nr_regions:	Total number of supported inbound mapping regions.
  */
 struct iproc_pcie_ib {
 	unsigned int nr_regions;
@@ -47,35 +56,42 @@ struct iproc_pcie_ib_map;
 struct iproc_msi;
 
 /**
- * iProc PCIe device
- *
- * @dev: pointer to device data structure
- * @type: iProc PCIe interface type
- * @reg_offsets: register offsets
- * @base: PCIe host controller I/O register base
- * @base_addr: PCIe host controller register base physical address
- * @phy: optional PHY device that controls the Serdes
- * @map_irq: function callback to map interrupts
- * @ep_is_internal: indicates an internal emulated endpoint device is connected
- * @iproc_cfg_read: indicates the iProc config read function should be used
- * @rej_unconfig_pf: indicates the root complex needs to detect and reject
- * enumeration against unconfigured physical functions emulated in the ASIC
- * @has_apb_err_disable: indicates the controller can be configured to prevent
- * unsupported request from being forwarded as an APB bus error
- * @fix_paxc_cap: indicates the controller has corrupted capability list in its
- * config space registers and requires SW based fixup
- *
- * @need_ob_cfg: indicates SW needs to configure the outbound mapping window
- * @ob: outbound mapping related parameters
- * @ob_map: outbound mapping related parameters specific to the controller
- *
- * @need_ib_cfg: indicates SW needs to configure the inbound mapping window
- * @ib: inbound mapping related parameters
- * @ib_map: outbound mapping region related parameters
- *
- * @need_msi_steer: indicates additional configuration of the iProc PCIe
- * controller is required to steer MSI writes to external interrupt controller
- * @msi: MSI data
+ * struct iproc_pcie - iProc PCIe device.
+ * @dev:			Pointer to device data structure.
+ * @type:			iProc PCIe interface type.
+ * @reg_offsets:		Register offsets.
+ * @base:			PCIe host controller I/O register base.
+ * @base_addr:			PCIe host controller register base physical
+ *				address.
+ * @mem:			Host bridge memory window resource.
+ * @phy:			Optional PHY device that controls the Serdes.
+ * @map_irq:			Function callback to map interrupts.
+ * @ep_is_internal:		Indicates an internal emulated endpoint device
+ *				is connected.
+ * @iproc_cfg_read:		Indicates the iProc config read function should
+ *				be used.
+ * @rej_unconfig_pf:		Indicates the root complex needs to detect and
+ *				reject enumeration against unconfigured physical
+ *				functions emulated in the ASIC.
+ * @has_apb_err_disable:	Indicates the controller can be configured to
+ *				prevent unsupported request from being forwarded
+ *				as an APB bus error.
+ * @fix_paxc_cap:		Indicates the controller has corrupted
+ *				capability list in its config space registers
+ *				and requires SW based fixup.
+ * @need_ob_cfg:		Indicates SW needs to configure the outbound
+ *				mapping window.
+ * @ob:				Outbound mapping related parameters.
+ * @ob_map:			Outbound mapping related parameters specific to
+ *				the controller.
+ * @need_ib_cfg:		indicates SW needs to configure the inbound
+ *				mapping window.
+ * @ib:				Inbound mapping related parameters.
+ * @ib_map:			Outbound mapping region related parameters.
+ * @need_msi_steer:		Indicates additional configuration of the iProc
+ *				PCIe controller is required to steer MSI writes
+ *				to external interrupt controller.
+ * @msi:			MSI data.
  */
 struct iproc_pcie {
 	struct device *dev;
-- 
2.32.0

