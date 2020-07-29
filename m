Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4E42325F0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 22:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgG2UMm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 16:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgG2UMm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 16:12:42 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C1C21883;
        Wed, 29 Jul 2020 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596053561;
        bh=2H2F2qOPJfU1SZxbWzf7bM4+AUNctmYvKQWay3zlHls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1MwIztj0NYN/ZAGQLwcTBtY6f39mlg+nxT7sZ+OrdmfDnfpF5zab/As1nXF4LSL8V
         3FCK4Daess5lNCpDPuKLGI4Zi+VP7AfSxUFEt/1AmY8Xw1GUtshMOmdXJX42ppMxuO
         tu6bjBuWVm7rfEUmaERBZ2OsGj5uYGRQgzjm8JEw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 2/6] PCI: endpoint: Fix kerneldoc
Date:   Wed, 29 Jul 2020 22:12:20 +0200
Message-Id: <20200729201224.26799-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729201224.26799-1-krzk@kernel.org>
References: <20200729201224.26799-1-krzk@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/pci/endpoint/pci-epc-core.c:18: warning: cannot understand function prototype: 'struct class *pci_epc_class; '
    drivers/pci/endpoint/pci-ep-cfs.c:17: warning: Function parameter or member 'functions_idr' not described in 'DEFINE_IDR'
    drivers/pci/endpoint/pci-epf-core.c:18: warning: Function parameter or member 'pci_epf_mutex' not described in 'DEFINE_MUTEX'
    drivers/pci/endpoint/pci-epf-core.c:80: warning: Function parameter or member 'epf' not described in 'pci_epf_free_space'
    drivers/pci/endpoint/pci-epf-core.c:107: warning: Function parameter or member 'epf' not described in 'pci_epf_alloc_space'
    drivers/pci/endpoint/pci-epc-mem.c:16: warning: Incorrect use of kernel-doc format:  * pci_epc_mem_get_order() - determine the allocation order of a memory size
    drivers/pci/endpoint/pci-epc-mem.c:24: warning: Function parameter or member 'mem' not described in 'pci_epc_mem_get_order'
    drivers/pci/endpoint/pci-epc-mem.c:24: warning: Function parameter or member 'size' not described in 'pci_epc_mem_get_order'
    drivers/pci/endpoint/functions/pci-epf-test.c:189: warning: Function parameter or member 'epf_test' not described in 'pci_epf_test_clean_dma_chan'
    drivers/pci/endpoint/functions/pci-epf-test.c:189: warning: Excess function parameter 'epf' description in 'pci_epf_test_clean_dma_chan'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 drivers/pci/endpoint/pci-ep-cfs.c             | 2 +-
 drivers/pci/endpoint/pci-epc-core.c           | 2 +-
 drivers/pci/endpoint/pci-epc-mem.c            | 2 +-
 drivers/pci/endpoint/pci-epf-core.c           | 4 +++-
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index c89a9561439f..e4e51d884553 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -181,7 +181,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 
 /**
  * pci_epf_test_clean_dma_chan() - Function to cleanup EPF test DMA channel
- * @epf: the EPF test device that performs data transfer operation
+ * @epf_test: the EPF test device that performs data transfer operation
  *
  * Helper to cleanup EPF test DMA channel.
  */
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 55edce50be96..3710adf51912 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * configfs to configure the PCI endpoint
  *
  * Copyright (C) 2017 Texas Instruments
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 82ba0dc7f2f5..cadd3db0cbb0 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * PCI Endpoint *Controller* (EPC) library
  *
  * Copyright (C) 2017 Texas Instruments
diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index 80c46f3a4590..a97b56a6d2db 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * PCI Endpoint *Controller* Address Space Management
  *
  * Copyright (C) 2017 Texas Instruments
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 244e00f48c5c..c977cf9dce56 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * PCI Endpoint *Function* (EPF) library
  *
  * Copyright (C) 2017 Texas Instruments
@@ -71,6 +71,7 @@ EXPORT_SYMBOL_GPL(pci_epf_bind);
 
 /**
  * pci_epf_free_space() - free the allocated PCI EPF register space
+ * @epf: the EPF device from whom to free the memory
  * @addr: the virtual address of the PCI EPF register space
  * @bar: the BAR number corresponding to the register space
  *
@@ -96,6 +97,7 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
 
 /**
  * pci_epf_alloc_space() - allocate memory for the PCI EPF register space
+ * @epf: the EPF device to whom allocate the memory
  * @size: the size of the memory that has to be allocated
  * @bar: the BAR number corresponding to the allocated register space
  * @align: alignment size for the allocation region
-- 
2.17.1

