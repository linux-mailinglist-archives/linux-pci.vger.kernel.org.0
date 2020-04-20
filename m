Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368AD1B01D9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 08:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTGwb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 02:52:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:60172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgDTGwa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 02:52:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 72608AB76;
        Mon, 20 Apr 2020 06:52:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     jingoohan1@gmail.com
Cc:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        amurray@thegoodpenguin.co.uk, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] PCI: dwc: clean up computing of msix_tbl
Date:   Mon, 20 Apr 2020 08:52:27 +0200
Message-Id: <20200420065227.4920-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
correct MSI-X table address") overcomplicated the computation of the
msix_tbl address. Simplify it as it's simply the addr + offset. Provided
addr is (void *) already.

objdump -d shows no difference after this patch.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1cdcbd102ce8..c815d36905b6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -433,7 +433,6 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct pci_epf_msix_tbl *msix_tbl;
 	struct pci_epc *epc = ep->epc;
-	struct pci_epf_bar *epf_bar;
 	u32 reg, msg_data, vec_ctrl;
 	unsigned int aligned_offset;
 	u32 tbl_offset;
@@ -446,10 +445,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
 
-	epf_bar = ep->epf_bar[bir];
-	msix_tbl = epf_bar->addr;
-	msix_tbl = (struct pci_epf_msix_tbl *)((char *)msix_tbl + tbl_offset);
-
+	msix_tbl = ep->epf_bar[bir]->addr + tbl_offset;
 	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
 	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
 	vec_ctrl = msix_tbl[(interrupt_num - 1)].vector_ctrl;
-- 
2.26.1

