Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA07184D6
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 16:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjEaOZm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 10:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbjEaOY4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 10:24:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268DBC5;
        Wed, 31 May 2023 07:24:48 -0700 (PDT)
Received: from kwepemi500025.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QWWjs5PclzTkwv;
        Wed, 31 May 2023 22:24:33 +0800 (CST)
Received: from vm10-29-85-105.huawei.com (10.29.85.105) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 22:24:43 +0800
From:   Jiantao Zhang <water.zhangjiantao@huawei.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tjoseph@cadence.com>
CC:     <zhangjianrong5@huawei.com>
Subject: [PATCH] PCI: controller: Fix calculation error of msix pending table offset
Date:   Wed, 31 May 2023 22:24:42 +0800
Message-ID: <20230531142442.27576-1-water.zhangjiantao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.85.105]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500025.china.huawei.com (7.221.188.170)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The interrupts already minus 1 in pci_epc_set_msix() according to pcie
specification. So we must add 1 otherwise data corruption will happen.

Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
Signed-off-by: Jianrong Zhang <zhangjianrong5@huawei.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index b8b655d4047e..ff608c46b8ac 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -310,7 +310,7 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 
 	/* Set PBA BAR and offset.  BAR must match MSIX BAR */
 	reg = cap + PCI_MSIX_PBA;
-	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = (offset + ((interrupts + 1) * PCI_MSIX_ENTRY_SIZE)) | bir;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f9182f8d552f..3d078ebe2517 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -417,7 +417,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	dw_pcie_writel_dbi(pci, reg, val);
 
 	reg = ep_func->msix_cap + func_offset + PCI_MSIX_PBA;
-	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = (offset + ((interrupts + 1) * PCI_MSIX_ENTRY_SIZE)) | bir;
 	dw_pcie_writel_dbi(pci, reg, val);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
-- 
2.17.1

