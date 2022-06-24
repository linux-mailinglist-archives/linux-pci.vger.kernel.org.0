Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E9C559BB6
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiFXOfo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 10:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiFXOfL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 10:35:11 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 366B656386;
        Fri, 24 Jun 2022 07:34:52 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id B32C95BC5;
        Fri, 24 Jun 2022 17:36:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com B32C95BC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656081361;
        bh=T5PKuFS290Lr6I4CfiwJ9/b7lkNL1VSsJ+Ea5Jz0Bdk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=lThxbG/tup9VNtbzRaj/hgwyJBKA0iQTJ6qWHcTLf+GndRSMTmTw0N0oFJnct9ECP
         kTHXb48K6UWDZ+QYxh4kXQIcsb5a9whARuErxD5t4DRd8ve4nuvv93q3Lshra+9bKa
         FAFe0tRA2Vdgsq7XBISLuygoi7k996lKlyvdWWGo=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:34:42 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v5 14/18] PCI: dwc: Move io_cfg_atu_shared to the Root Port descriptor
Date:   Fri, 24 Jun 2022 17:34:24 +0300
Message-ID: <20220624143428.8334-15-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

That flag is set if there is an outbound iATU window used for both PCIe
peripheral config-space accesses and IO ports transfers. Since the flag
semantic is purely Root Port specific, it's unused in neither the DW PCIe
common code nor in the DW PCIe Endpoint driver, we can freely move it to
the DW PCIe Root Port descriptor. Thus the pcie_port structure will be
more coherent.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v4:
- This is a new patch created on the v4 lap of the series.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index c49a3bde7a2a..7ff2b7555b91 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -492,7 +492,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	ret = pci_generic_config_read(bus, devfn, where, size, val);
 
-	if (!ret && pci->io_cfg_atu_shared)
+	if (!ret && pp->cfg0_io_shared)
 		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
 					  pp->io_bus_addr, pp->io_size);
 
@@ -508,7 +508,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	ret = pci_generic_config_write(bus, devfn, where, size, val);
 
-	if (!ret && pci->io_cfg_atu_shared)
+	if (!ret && pp->cfg0_io_shared)
 		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
 					  pp->io_bus_addr, pp->io_size);
 
@@ -627,7 +627,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
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

