Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFE17A46DD
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 12:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjIRKYU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 06:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241124AbjIRKX4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 06:23:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1673ED9
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695032630; x=1726568630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cS4ybwbqfyLBdznvtOWvMo0l9S0n2GVGkyFIttLSb3k=;
  b=hOMqTRUlKCGHYwNkrgg7lVtmECgOEfpcLNj2/qIDnlwxTS0pYT8zyrrv
   UlzMXdsKt8upge70MAvaTlPBTSaMozVaUwCwNj4jqAiBTlI9RhkZRlhfo
   44IPg4H5XG9Ibkc4UhOYROXRYxTnD8o2GsZEqqtQrkglRi4bozpCw62OZ
   cBpOCD+gZRYv0MekzOFFykWu8udcFDLb3VXcXC4fMmG2zyBMCFPkJXED7
   boOvHHt/+xnE2YzF+RZbfmJZ7rQU5B1BOaCHcFuUfxgUgxAilPy4rcmrK
   sJUE+ZFKCfCfs7iLy9abHM9xJRt0Eseqz6D2ACHV67RZW4RYRG5S/hmbX
   w==;
X-CSE-ConnectionGUID: 7Em7OOITQwKiKSoED66vMw==
X-CSE-MsgGUID: hyKhDgBAQaOmVXYMUyCiIw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="5204121"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 03:23:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 18 Sep 2023 03:23:22 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 18 Sep 2023 03:23:20 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-pci@vger.kernel.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1] PCI: dwc: convert SOC_SIFIVE to ARCH_SIFIVE
Date:   Mon, 18 Sep 2023 11:22:47 +0100
Message-ID: <20230918-safeness-cornflake-62278bc3aaaa@wendy>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=cS4ybwbqfyLBdznvtOWvMo0l9S0n2GVGkyFIttLSb3k=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKkcKp9/lFxdLZ5atvB8a3TA5NIfxtveL9Fca2507sX7p2cr uMr5O0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRc6GMDFv/67s+YNVZKK/88bLy0X sh1/7Lnz89y2CitujhpNIFvzwZGVZLBkxMS3JcbLqYvbpQ+pVttk/9/cyiZuX6iLqFO/I9mQE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As part of converting RISC-V SOC_FOO symbols to ARCH_FOO to match the
use of such symbols on other architectures, convert the SiFive PCI
drivers to use the newer symbol.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Krzysztof Wilczyński <kw@linux.com>
CC: Rob Herring <robh@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ab96da43e0c2..58234334bcc2 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -311,7 +311,7 @@ config PCI_EXYNOS
 config PCIE_FU740
 	bool "SiFive FU740 PCIe controller"
 	depends on PCI_MSI
-	depends on SOC_SIFIVE || COMPILE_TEST
+	depends on ARCH_SIFIVE || COMPILE_TEST
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe controller support for the SiFive
-- 
2.40.1

