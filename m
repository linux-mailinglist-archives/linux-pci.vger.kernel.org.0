Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA46749771
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 10:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGFI0N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFI0L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 04:26:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6500E1988;
        Thu,  6 Jul 2023 01:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5468618CE;
        Thu,  6 Jul 2023 08:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C59C433C7;
        Thu,  6 Jul 2023 08:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688631969;
        bh=ml8tQ1onOzNXv2iiwIvDkE0B5s5SQFD1qfGWL82cBgU=;
        h=From:To:Cc:Subject:Date:From;
        b=UCopQXWtHRHwdjDXbVkffNljxZVp9CfirOKQBVacXTmHHVA14CzaJ4eWLzxIcjHZX
         6i4TJQyvWHMs1DTbTlH6hpcoY07u8gvKlFiKd7nu0HrP1afKXoGlJEmnGJE8/uixUg
         w3XaWkuDW8FZwndNjwZlBZg65KKANr4rxI7qZw/+4eCl7rfcyVjT0GLQxUNs0hZ301
         U9W5ijTwdtVVGpmzte6sClN6VLsrJmOZKX2wQ8u60MJhsJ1B8NHX7POlyIuFmoLbUr
         8p6AuON8escUVdx4Ta2UAIvs52pZBb+QdohtLoYHrNtzx86KiOca8DAyg56Rm2hDPe
         oWCaM6sLwRhEA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qHKJr-0006uz-0T;
        Thu, 06 Jul 2023 10:26:31 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sajid Dalvi <sdalvi@google.com>,
        Ajay Agarwal <ajayagarwal@google.com>
Subject: [PATCH] Revert "PCI: dwc: Wait for link up only if link is started"
Date:   Thu,  6 Jul 2023 10:26:10 +0200
Message-Id: <20230706082610.26584-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit da56a1bfbab55189595e588f1d984bdfb5cf5924.

A recent commit broke controller probe by returning an error in case the
link does not come up during host initialisation.

As explained in commit 886a9c134755 ("PCI: dwc: Move link handling into
common code") and as indicated by the comment "Ignore errors, the link
may come up later" in the code, waiting for link up and ignoring errors
is the intended behaviour:

	 Let's standardize this to succeed as there are usecases where
	 devices (and the link) appear later even without hotplug. For
	 example, a reconfigured FPGA device.

Reverting the offending commit specifically fixes a regression on
Qualcomm platforms like the Lenovo ThinkPad X13s which no longer reach
the interconnect sync state if a slot does not have a device populated
(e.g. an optional modem).

Note that enabling asynchronous probing by default as was done for
Qualcomm platforms by commit c0e1eb441b1d ("PCI: qcom: Enable async
probe by default"), should take care of any related boot time concerns.

Finally, note that the intel-gw driver is the only driver currently not
providing a start_link callback and instead starts the link in its
host_init callback, and which may avoid an additional one-second timeout
during probe by making the link-up wait conditional. If anyone cares,
that can be done in a follow-up patch with a proper motivation.

Fixes: da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")
Reported-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Sajid Dalvi <sdalvi@google.com>
Cc: Ajay Agarwal <ajayagarwal@google.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 13 ++++--------
 drivers/pci/controller/dwc/pcie-designware.c  | 20 +++++++------------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 3 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index cf61733bf78d..9952057c8819 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -485,20 +485,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_remove_edma;
 
-	if (dw_pcie_link_up(pci)) {
-		dw_pcie_print_link_status(pci);
-	} else {
+	if (!dw_pcie_link_up(pci)) {
 		ret = dw_pcie_start_link(pci);
 		if (ret)
 			goto err_remove_edma;
-
-		if (pci->ops && pci->ops->start_link) {
-			ret = dw_pcie_wait_for_link(pci);
-			if (ret)
-				goto err_stop_link;
-		}
 	}
 
+	/* Ignore errors, the link may come up later */
+	dw_pcie_wait_for_link(pci);
+
 	bridge->sysdata = pp;
 
 	ret = pci_host_probe(bridge);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index df092229e97d..8e33e6e59e68 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -644,20 +644,9 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
 }
 
-void dw_pcie_print_link_status(struct dw_pcie *pci)
-{
-	u32 offset, val;
-
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
-
-	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
-		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
-		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
-}
-
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
+	u32 offset, val;
 	int retries;
 
 	/* Check if the link is up or not */
@@ -673,7 +662,12 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		return -ETIMEDOUT;
 	}
 
-	dw_pcie_print_link_status(pci);
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
+
+	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
+		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
+		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 615660640801..79713ce075cc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -429,7 +429,6 @@ void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
-void dw_pcie_print_link_status(struct dw_pcie *pci);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
-- 
2.39.3

