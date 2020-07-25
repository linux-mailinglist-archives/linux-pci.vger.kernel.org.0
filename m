Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4FA22D652
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jul 2020 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGYJKS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Jul 2020 05:10:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726583AbgGYJKS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 25 Jul 2020 05:10:18 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 63500437AB6D9D7E53AA;
        Sat, 25 Jul 2020 17:09:58 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 17:09:52 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Tom Joseph <tjoseph@cadence.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Douglas <adouglas@cadence.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH -next] PCI: cadence: Fix unused-but-set-variable warning
Date:   Sat, 25 Jul 2020 17:19:45 +0800
Message-ID: <20200725091945.75176-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gcc report warning as followings:

drivers/pci/controller/cadence/pcie-cadence-ep.c:390:33: warning:
 variable 'vec_ctrl' set but not used [-Wunused-but-set-variable]
  390 |  u32 tbl_offset, msg_data, reg, vec_ctrl;
      |                                 ^~~~~~~~

This variable is not used so this commit removing it.

Fixes: dae15ff2c7a9 ("PCI: cadence: Add MSI-X support to Endpoint driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 87c76341eab4..ec1306da301f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -387,7 +387,7 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn,
 				      u16 interrupt_num)
 {
 	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
-	u32 tbl_offset, msg_data, reg, vec_ctrl;
+	u32 tbl_offset, msg_data, reg;
 	struct cdns_pcie *pcie = &ep->pcie;
 	struct pci_epf_msix_tbl *msix_tbl;
 	struct cdns_pcie_epf *epf;
@@ -410,7 +410,6 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn,
 	msix_tbl = epf->epf_bar[bir]->addr + tbl_offset;
 	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
 	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
-	vec_ctrl = msix_tbl[(interrupt_num - 1)].vector_ctrl;
 
 	/* Set the outbound region if needed. */
 	if (ep->irq_pci_addr != (msg_addr & ~pci_addr_mask) ||

