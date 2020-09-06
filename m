Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F1425F04D
	for <lists+linux-pci@lfdr.de>; Sun,  6 Sep 2020 21:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgIFTvu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Sep 2020 15:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgIFTvj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Sep 2020 15:51:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2135C061757;
        Sun,  6 Sep 2020 12:51:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so13105030wrm.2;
        Sun, 06 Sep 2020 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/S5Im9/ROfqvfa1Sle39Oh3fNtnOr9/GsxUV+XEYiDw=;
        b=hJUJQyDBSxhKiCexl2PgZJhKdzT1VEGaaTOtZpUHYMSjpePpKg3Ub8mYNYHHZuW6m1
         wRWfcRi8mvws/10gVmCI/hyZRHdBL0E1NfIz34/SIVnBfA1XvCNMuTHc8h8Skht+q8+/
         KC8KdC8tXzVu1uU/K2ISF+bYH8OmdKNd73tKnJ6attwIhoTHjLGS193b8VgXN0iC0kQi
         oSlfq2VRguvdtrDgSoSxFhLq3h7jhcZfHC501BSjM8rCUjOOsD6YyV2Wly9iL6nHug7T
         za95kOVxzlNPNFR/VJxCbhRh6Wgo8uuARFI2Hlg/SomTZaSkSz9Kw+9CAuytCHRXHE5k
         oG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/S5Im9/ROfqvfa1Sle39Oh3fNtnOr9/GsxUV+XEYiDw=;
        b=qHeJNAPqZvKWJ5XIB1l1k8m3359DbZrz6WzbjChu4hy/cgc/6/XAAvmLliAQ+jdSs4
         bQn/qLsFteyrtGuk4dvs5eGuBeY2KD8q4tBtt69tPioP/l2JXAo9x2A22sn2BbT/gMXE
         di8zcfkOEbQQ4FA4kCBDQUPLm/+6p9Fv8kfzhj0+kUdje4whi021DvSVzvdQgPkXuAmZ
         e2bWArKBrbE07IkDHvMZwH2DcqZRkcJLMZMq4jGa508ibkJ4nKGDbHbZfPqA/Jm/4WaA
         mCSD/8UR/W46QXp0Ebj9QsHUZrbPEB3EX4ko0MkUPIwPeYcYvsJN7c6l9WqgQOpMB2Kw
         xyyQ==
X-Gm-Message-State: AOAM5325tPdoc7z+uwGOMSRw3FE9UiBNOF1WWJViyV6Iz4nagntr/ljX
        HbF8niEna+v5pnQz6mLs3DU=
X-Google-Smtp-Source: ABdhPJyfbXY479yfemJKmQe+tgYWfEuqdjjGMulgXwrkYJMCIY8BbPfaKy3e2vUEOCZ7t9lim3Q18g==
X-Received: by 2002:a5d:4d8a:: with SMTP id b10mr12495522wru.82.1599421893393;
        Sun, 06 Sep 2020 12:51:33 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id q6sm22817479wmq.19.2020.09.06.12.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 12:51:32 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2] PCI: keystone: Enable compile-testing on !ARM
Date:   Sun,  6 Sep 2020 20:51:27 +0100
Message-Id: <20200906195128.279342-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906194850.63glbnehjcuw356k@lenovo-laptop>
References: <20200906194850.63glbnehjcuw356k@lenovo-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the Keystone driver can only be compile-tested on ARM, but
this restriction seems unnecessary. Get rid of it to increase test
coverage.

Build-tested with allyesconfig on x86, ppc, mips and riscv.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/pci/controller/dwc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 044a3761c44f..ca36691314ed 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -107,7 +107,7 @@ config PCI_KEYSTONE
 
 config PCI_KEYSTONE_HOST
 	bool "PCI Keystone Host Mode"
-	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
+	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select PCI_KEYSTONE
@@ -119,7 +119,7 @@ config PCI_KEYSTONE_HOST
 
 config PCI_KEYSTONE_EP
 	bool "PCI Keystone Endpoint Mode"
-	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
+	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PCI_KEYSTONE
-- 
2.28.0

