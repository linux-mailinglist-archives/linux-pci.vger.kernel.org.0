Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383BB546122
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 11:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348320AbiFJJMS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241710AbiFJJMB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 05:12:01 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AFD6285AB0;
        Fri, 10 Jun 2022 02:09:49 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id C59D716A9;
        Fri, 10 Jun 2022 11:45:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com C59D716A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654850742;
        bh=3JtMHXFj/6uj4gS7w7BSLJF7vKVIvx5510cvK8lkOsA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Ec0fddyaPO5EOEsMebyZ5LtNKE+C8u7d9yS43jSAHhbAHImguSC1iBgyL85mW8dk7
         nAu5zvZNYa/j5StUHX6f3FAtchfsOAXmR7M2Eut3A+nX1NPUC7TqC/vknM0Xm18P94
         QUdfXNlOAkgJWCTNClijilcoHX31oRZyWezQqzZY=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:44:50 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 07/15] PCI: tegra194: Drop manual DW PCIe controller version setup
Date:   Fri, 10 Jun 2022 11:44:35 +0300
Message-ID: <20220610084444.14549-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since the DW PCIe common code now supports the IP-core version
auto-detection there is no point in manually setting the version up for the
controllers newer than v4.70a. Seeing Tegra 194 PCIe Host and EP
controllers are based on the DW PCIe v4.90a IP-core we can freely drop the
dw_pcie.version field initialization.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Folks, I don't have Tegra 194 PCIe hw instance to test it out. Could you
please make sure this patch doesn't brake anything?

Changelog v3:
- This is a new patch create as a result of the discussion:
  https://lore.kernel.org/linux-pci/20220503214638.1895-6-Sergey.Semin@baikalelectronics.ru/
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b7109699c2c9..14e9bd89d07a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1981,7 +1981,6 @@ static int tegra194_pcie_probe(struct platform_device *pdev)
 	pci->ops = &tegra_dw_pcie_ops;
 	pci->n_fts[0] = N_FTS_VAL;
 	pci->n_fts[1] = FTS_VAL;
-	pci->version = DW_PCIE_VER_490A;
 
 	pp = &pci->pp;
 	pp->num_vectors = MAX_MSI_IRQS;
-- 
2.35.1

