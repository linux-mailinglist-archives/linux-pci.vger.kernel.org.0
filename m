Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69AD3BA684
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 02:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhGCAtV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 20:49:21 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:42632 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhGCAtT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 20:49:19 -0400
Received: by mail-lj1-f178.google.com with SMTP id r16so15678420ljk.9
        for <linux-pci@vger.kernel.org>; Fri, 02 Jul 2021 17:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLTgyVVagJJzlRjsGc+Cb+zutjhyCkOaKQW2VFhgoWI=;
        b=rz+heMqb8Zux8THbeEQe7XaWEFKdym5OHgraYAdHOALfrHueGdSCmRViiLivWlmwQm
         s60PALkt+QrfZ/bjzuc3exTkxKDlTY4ik0zP1XF956sXRund9gtTMcDIWGVhrtXt5+AQ
         n0S/MxWb1zSv3If5Ppjale1m1PM6F2BJy7VSgCeA7laT6yO6o7MfEX5IzBGd+CsaZcqu
         L1Ot6m47NAagb9L6JeA1njHvZWNi5873rL+mJM8sxTQCDWzI+RgAtvDJqAXe56Ui7iPa
         3dNwJuN6Gc4mWWcR70rCXDm02uCO1OpDDAYGp4eQtMgq9unIslyxoJJETNQ0sDjy2np8
         sc3g==
X-Gm-Message-State: AOAM532rCfSdaUb3CMISZQ8wmadb72qIAA+sWsEeaIVgn/vpHgWF4ikA
        NveU+3tXpcmLLIblKnFsrjc=
X-Google-Smtp-Source: ABdhPJwUeTUbbLYAnXCXqagwSqW5h9iQ6+7KyuO59kf5rgZ+nYCY/f9f8cAhws7v+eVmaeYYJlLY+w==
X-Received: by 2002:a2e:9d1a:: with SMTP id t26mr1633137lji.10.1625273203959;
        Fri, 02 Jul 2021 17:46:43 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b7sm409304lfe.151.2021.07.02.17.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 17:46:43 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Fix kernel-doc formatting and add missing documentation
Date:   Sat,  3 Jul 2021 00:46:42 +0000
Message-Id: <20210703004642.1680585-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix kernel-doc formatting and add missing documentation for the members
"barno" and "flags" of the struct pci_epf_bar, "msix_interrupts" of the
struct pci_epf, "get_features" of the struct pci_epc_ops and
"core_init_notifier" of the struct pci_epc_features.

Thus, resolve build time warnings related to kernel-doc:

  include/linux/pci-epf.h:4: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  include/linux/pci-epf.h:113: warning: Function parameter or member 'barno' not described in 'pci_epf_bar'
  include/linux/pci-epf.h:113: warning: Function parameter or member 'flags' not described in 'pci_epf_bar'
  include/linux/pci-epf.h:157: warning: Function parameter or member 'msix_interrupts' not described in 'pci_epf'

  include/linux/pci-ep-cfs.h:4: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

  include/linux/pci-epc.h:4: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  include/linux/pci-epc.h:91: warning: Function parameter or member 'get_features' not described in 'pci_epc_ops'
  include/linux/pci-epc.h:170: warning: Function parameter or member 'core_init_notifier' not described in 'pci_epc_features'

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 include/linux/pci-ep-cfs.h |  2 +-
 include/linux/pci-epc.h    | 62 +++++++++++++++++++++-----------------
 include/linux/pci-epf.h    | 56 ++++++++++++++++++++--------------
 3 files changed, 68 insertions(+), 52 deletions(-)

diff --git a/include/linux/pci-ep-cfs.h b/include/linux/pci-ep-cfs.h
index 662881335c7e..3e2140d7e31d 100644
--- a/include/linux/pci-ep-cfs.h
+++ b/include/linux/pci-ep-cfs.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/**
+/*
  * PCI Endpoint ConfigFS header file
  *
  * Copyright (C) 2017 Texas Instruments
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index b82c9b100e97..912f8f542f3e 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * PCI Endpoint *Controller* (EPC) header file
  *
  * Copyright (C) 2017 Texas Instruments
@@ -40,25 +40,27 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
 }
 
 /**
- * struct pci_epc_ops - set of function pointers for performing EPC operations
- * @write_header: ops to populate configuration space header
- * @set_bar: ops to configure the BAR
- * @clear_bar: ops to reset the BAR
- * @map_addr: ops to map CPU address to PCI address
- * @unmap_addr: ops to unmap CPU address and PCI address
- * @set_msi: ops to set the requested number of MSI interrupts in the MSI
- *	     capability register
- * @get_msi: ops to get the number of MSI interrupts allocated by the RC from
- *	     the MSI capability register
- * @set_msix: ops to set the requested number of MSI-X interrupts in the
- *	     MSI-X capability register
- * @get_msix: ops to get the number of MSI-X interrupts allocated by the RC
- *	     from the MSI-X capability register
- * @raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
- * @map_msi_irq: ops to map physical address to MSI address and return MSI data
- * @start: ops to start the PCI link
- * @stop: ops to stop the PCI link
- * @owner: the module owner containing the ops
+ * struct pci_epc_ops - Set of function pointers for performing EPC operations.
+ * @write_header:	Ops to populate configuration space header.
+ * @set_bar:		Ops to configure the BAR.
+ * @clear_bar:		Ops to reset the BAR.
+ * @map_addr:		Ops to map CPU address to PCI address.
+ * @unmap_addr:		Ops to unmap CPU address and PCI address.
+ * @set_msi:		Ops to set the requested number of MSI interrupts in the
+ *			MSI capability register.
+ * @get_msi:		Ops to get the number of MSI interrupts allocated by the
+ *			RC from the MSI capability register.
+ * @set_msix:		Ops to set the requested number of MSI-X interrupts in
+ *			the MSI-X capability register.
+ * @get_msix:		Ops to get the number of MSI-X interrupts allocated by.
+ *			the RC from the MSI-X capability register.
+ * @raise_irq:		Ops to raise a legacy, MSI or MSI-X interrupt.
+ * @map_msi_irq:	Ops to map physical address to MSI address and return
+ *			MSI data.
+ * @start:		Ops to start the PCI link.
+ * @stop:		Ops to stop the PCI link.
+ * @get_features:	Ops to get the features supported by the EPC.
+ * @owner:		The module owner containing the ops.
  */
 struct pci_epc_ops {
 	int	(*write_header)(struct pci_epc *epc, u8 func_no,
@@ -148,14 +150,18 @@ struct pci_epc {
 };
 
 /**
- * struct pci_epc_features - features supported by a EPC device per function
- * @linkup_notifier: indicate if the EPC device can notify EPF driver on link up
- * @msi_capable: indicate if the endpoint function has MSI capability
- * @msix_capable: indicate if the endpoint function has MSI-X capability
- * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
- * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
- * @bar_fixed_size: Array specifying the size supported by each BAR
- * @align: alignment size required for BAR buffer allocation
+ * struct pci_epc_features - Features supported by a EPC device per function.
+ * @linkup_notifier:	Indicate if the EPC device can notify EPF driver on link
+ *			up.
+ * @core_init_notifier:	Indicate cores that can notify about their availability
+ *			for initialization.
+ * @msi_capable:	Indicate if the endpoint function has MSI capability.
+ * @msix_capable:	Indicate if the endpoint function has MSI-X capability.
+ * @reserved_bar:	Bitmap to indicate reserved BAR unavailable to function
+ *			driver.
+ * @bar_fixed_64bit:	Bitmap to indicate fixed 64bit BARs.
+ * @bar_fixed_size:	Array specifying the size supported by each BAR.
+ * @align:		Alignment size required for BAR buffer allocation.
  */
 struct pci_epc_features {
 	unsigned int	linkup_notifier : 1;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 6833e2160ef1..91d8b800e6dc 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * PCI Endpoint *Function* (EPF) header file
  *
  * Copyright (C) 2017 Texas Instruments
@@ -98,10 +98,13 @@ struct pci_epf_driver {
 				driver))
 
 /**
- * struct pci_epf_bar - represents the BAR of EPF device
- * @phys_addr: physical address that should be mapped to the BAR
- * @addr: virtual address corresponding to the @phys_addr
- * @size: the size of the address space present in BAR
+ * struct pci_epf_bar - Represents the BAR of EPF device.
+ * @phys_addr:	Physical address that should be mapped to the BAR.
+ * @addr:	Virtual address corresponding to the @phys_addr.
+ * @size:	The size of the address space present in BAR.
+ * @barno:	The BAR number.
+ * @flags:	Flags that are set for the BAR. This is need so that specific
+ *		epc->ops->set_bar() implementations can modify BAR flags.
  */
 struct pci_epf_bar {
 	dma_addr_t	phys_addr;
@@ -112,24 +115,31 @@ struct pci_epf_bar {
 };
 
 /**
- * struct pci_epf - represents the PCI EPF device
- * @dev: the PCI EPF device
- * @name: the name of the PCI EPF device
- * @header: represents standard configuration header
- * @bar: represents the BAR of EPF device
- * @msi_interrupts: number of MSI interrupts required by this function
- * @func_no: unique function number within this endpoint device
- * @epc: the EPC device to which this EPF device is bound
- * @driver: the EPF driver to which this EPF device is bound
- * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
- * @nb: notifier block to notify EPF of any EPC events (like linkup)
- * @lock: mutex to protect pci_epf_ops
- * @sec_epc: the secondary EPC device to which this EPF device is bound
- * @sec_epc_list: to add pci_epf as list of PCI endpoint functions to secondary
- *   EPC device
- * @sec_epc_bar: represents the BAR of EPF device associated with secondary EPC
- * @sec_epc_func_no: unique (physical) function number within the secondary EPC
- * @group: configfs group associated with the EPF device
+ * struct pci_epf - Represents the PCI EPF device.
+ * @dev:		The PCI EPF device.
+ * @name:		The name of the PCI EPF device.
+ * @header:		Represents standard configuration header.
+ * @bar:		Represents the BAR of EPF device.
+ * @msi_interrupts:	Number of MSI interrupts required by this function.
+ * @msix_interrupts:	Maximum number of MSI-X interrupts required by this
+ *			function.
+ * @func_no:		Unique function number within this endpoint device.
+ * @epc:		The EPC device to which this EPF device is bound.
+ * @driver:		The EPF driver to which this EPF device is bound.
+ * @list:		To add pci_epf as a list of PCI endpoint functions to
+ *			pci_epc.
+ * @nb:			Notifier block to notify EPF of any EPC events (like
+ *			linkup).
+ * @lock:		Mutex to protect pci_epf_ops.
+ * @sec_epc:		The secondary EPC device to which this EPF device is
+ *			bound.
+ * @sec_epc_list:	To add pci_epf as list of PCI endpoint functions to
+ *			secondary EPC device.
+ * @sec_epc_bar:	Represents the BAR of EPF device associated with
+ *			secondary EPC.
+ * @sec_epc_func_no:	Unique (physical) function number within the secondary
+ *			EPC.
+ * @group:		Configfs group associated with the EPF device.
  */
 struct pci_epf {
 	struct device		dev;
-- 
2.32.0

