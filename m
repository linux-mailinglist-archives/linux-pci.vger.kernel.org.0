Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320C3545F05
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347467AbiFJI3h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346690AbiFJI1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:27:47 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EBA465D6;
        Fri, 10 Jun 2022 01:26:02 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id E0A8F16A1;
        Fri, 10 Jun 2022 11:26:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com E0A8F16A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849599;
        bh=pT6mSeQP4L1yqwlcHAGYKXBfkZ9Q5XYcmfpgvP/MfAg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=sRrQcLoEBs4LXUideMmJj6L6WA4t5+txhogZyfUOL2d2deVaW8vvgBBl/IZPntUkf
         QL3S+BY0dl0qBkbOiQOntsNY7poS/Y12ug1MmWj5avribsx0X2OI1fTcFwuLC1E4kf
         aX8hvTtHnKOZkQx7f9hRgu/uW50dWpdRpP4+WwuU=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:25:46 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 14/18] PCI: dwc: Move io_cfg_atu_shared to the Root Port descriptor
Date:   Fri, 10 Jun 2022 11:25:30 +0300
Message-ID: <20220610082535.12802-15-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
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

That flag is set if there is an outbound iATU window used for both PCIe
peripheral config-space accesses and IO ports transfers. Since the flag
semantic is purely Root Port specific, it's unused in neither the DW PCIe
common code nor the DW PCIe Endpoint driver we can freely move it to the
DW PCIe Root Port descriptor. Thus the pcie_port structure will be more
coherent.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v4:
- This is a new patch created on the v4 lap of the series.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f57f456aa543..9da600b841a7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -491,7 +491,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	ret = pci_generic_config_read(bus, devfn, where, size, val);
 
-	if (!ret && pci->io_cfg_atu_shared)
+	if (!ret && pp->cfg0_io_shared)
 		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
 					  pp->io_bus_addr, pp->io_size);
 
@@ -507,7 +507,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	ret = pci_generic_config_write(bus, devfn, where, size, val);
 
-	if (!ret && pci->io_cfg_atu_shared)
+	if (!ret && pp->cfg0_io_shared)
 		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
 					  pp->io_bus_addr, pp->io_size);
 
@@ -626,7 +626,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 							  PCIE_ATU_TYPE_IO, pp->io_base,
 							  pp->io_bus_addr, pp->io_size);
 			else
-				pci->io_cfg_atu_shared = true;
+				pp->cfg0_io_shared = true;
 		}
 
 		if (pci->num_ob_windows <= atu_idx)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 8ba239292634..13bffa3eaed6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -179,6 +179,7 @@ struct dw_pcie_host_ops {
 
 struct pcie_port {
 	bool			has_msi_ctrl:1;
+	bool			cfg0_io_shared:1;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
 	u32			cfg0_size;
@@ -274,7 +275,6 @@ struct dw_pcie {
 	int			link_gen;
 	u8			n_fts[2];
 	bool			iatu_unroll_enabled: 1;
-	bool			io_cfg_atu_shared: 1;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.35.1

