Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931703BA92A
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 17:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGCPPt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Jul 2021 11:15:49 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:46047 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhGCPPs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Jul 2021 11:15:48 -0400
Received: by mail-lj1-f178.google.com with SMTP id u20so17760961ljo.12
        for <linux-pci@vger.kernel.org>; Sat, 03 Jul 2021 08:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6lHQTkFszDwppiFYXxWFA+kKr860Oxn5YwDCzS+9heU=;
        b=eProUmst4sg72kHTcsktd6Onl8vkkRQgCsfw+6a44a6wgMMHodikoHmLzsGsvBKDJs
         f/79k8IZ1eaTAoRi1YcoEOaD1Kin4ULidx3bUULxb/5bEC+qjFaO0VPI6gz3pLMSh4Cv
         9U9IiXg5TQ3I+j7omKcA6qEa7QsLVecx1ejfRrijH2XAfaKeuL2HtNauBtieUdDgDPsQ
         24+t83WFLTQJUr9OqDzrUYDr0+htYvbGzgNZhErNzN07zjF9K3ttRWJ2vSDkLPXxbpYC
         UhBFnHjdXZfk0tH3A4N9N/bt98yQ3gTobHit+joYEuztEHEsMBBLa48pTAc1QKc8gZn5
         0GvA==
X-Gm-Message-State: AOAM530pWRlmY/oS3E8CfEyBeeEYLAjUvaVwx5/havuX8iyOPImgZEiT
        oPyE7h7CLHKZyl8pFRZHdEo=
X-Google-Smtp-Source: ABdhPJzHbwkWTp5lomxzPU1dmoE8sF99vTpppKGzpbH6LWc4gwV/maUXyu+gYWgpDjdXXkhJgfKz8g==
X-Received: by 2002:a05:651c:168a:: with SMTP id bd10mr3809573ljb.341.1625325192914;
        Sat, 03 Jul 2021 08:13:12 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p18sm715980ljj.56.2021.07.03.08.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 08:13:12 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Scott Murray <scott@spiteful.org>,
        Tom Joseph <tjoseph@cadence.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 5/5] PCI: endpoint: Fix kernel-doc formatting and add missing documentation
Date:   Sat,  3 Jul 2021 15:13:06 +0000
Message-Id: <20210703151306.1922450-5-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210703151306.1922450-1-kw@linux.com>
References: <20210703151306.1922450-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix a non-compliant kernel-doc at the top of the files
include/linux/pci-ep-cfs.h and include/linux/pci-epc.h.

Also add the following missing documentation:
  - "barno" and "flags" members of the struct pci_epf_bar
  - "msix_interrupts" member of the struct pci_epf
  - "get_features" member of the struct pci_epc_ops
  - "core_init_notifier" member of the struct pci_epc_features

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
 include/linux/pci-ep-cfs.h | 2 +-
 include/linux/pci-epc.h    | 5 ++++-
 include/linux/pci-epf.h    | 5 ++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

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
index b82c9b100e97..48e75d8f0543 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * PCI Endpoint *Controller* (EPC) header file
  *
  * Copyright (C) 2017 Texas Instruments
@@ -58,6 +58,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
  * @map_msi_irq: ops to map physical address to MSI address and return MSI data
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
+ * @get_features: ops to get the features supported by the EPC
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -150,6 +151,8 @@ struct pci_epc {
 /**
  * struct pci_epc_features - features supported by a EPC device per function
  * @linkup_notifier: indicate if the EPC device can notify EPF driver on link up
+ * @core_init_notifier:	indicate cores that can notify about their availability
+ * for initialization
  * @msi_capable: indicate if the endpoint function has MSI capability
  * @msix_capable: indicate if the endpoint function has MSI-X capability
  * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 6833e2160ef1..6d1cc35209b6 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * PCI Endpoint *Function* (EPF) header file
  *
  * Copyright (C) 2017 Texas Instruments
@@ -102,6 +102,8 @@ struct pci_epf_driver {
  * @phys_addr: physical address that should be mapped to the BAR
  * @addr: virtual address corresponding to the @phys_addr
  * @size: the size of the address space present in BAR
+ * @barno: the BAR number
+ * @flags: flags that are set for the BAR
  */
 struct pci_epf_bar {
 	dma_addr_t	phys_addr;
@@ -118,6 +120,7 @@ struct pci_epf_bar {
  * @header: represents standard configuration header
  * @bar: represents the BAR of EPF device
  * @msi_interrupts: number of MSI interrupts required by this function
+ * @msix_interrupts: number of MSI-X interrupts required by this function
  * @func_no: unique function number within this endpoint device
  * @epc: the EPC device to which this EPF device is bound
  * @driver: the EPF driver to which this EPF device is bound
-- 
2.32.0

