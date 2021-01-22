Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC5030024E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 13:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbhAVKz0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 05:55:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11130 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbhAVKvo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 05:51:44 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DMbcc5sd6z15wZP;
        Fri, 22 Jan 2021 18:49:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Fri, 22 Jan 2021
 18:50:50 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <kishon@ti.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] PCI: endpoint: remove set but not used parameter in pci-epf-ntb.c
Date:   Fri, 22 Jan 2021 18:57:06 +0800
Message-ID: <20210122105706.3206057-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix follow warnings:
drivers/pci/endpoint/functions/pci-epf-ntb.c: In function ‘epf_ntb_peer_spad_bar_set’:
drivers/pci/endpoint/functions/pci-epf-ntb.c:763:18: warning: variable ‘epc’ set but not used [-Wunused-but-set-variable]
  763 |  struct pci_epc *epc;
      |                  ^~~
drivers/pci/endpoint/functions/pci-epf-ntb.c: In function ‘epf_ntb_config_spad_bar_alloc’:
drivers/pci/endpoint/functions/pci-epf-ntb.c:976:18: warning: variable ‘epc’ set but not used [-Wunused-but-set-variable]
  976 |  struct pci_epc *epc;
      |                  ^~~
drivers/pci/endpoint/functions/pci-epf-ntb.c:972:17: warning: variable ‘peer_barno’ set but not used [-Wunused-but-set-variable]
  972 |  enum pci_barno peer_barno, barno;

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index e2dc5cae5c81..0e8249b8aeba 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -760,7 +760,6 @@ epf_ntb_peer_spad_bar_set(struct epf_ntb *ntb, enum pci_epc_interface_type type)
 	struct pci_epf_bar *peer_epf_bar, *epf_bar;
 	enum pci_barno peer_barno, barno;
 	u32 peer_spad_offset;
-	struct pci_epc *epc;
 	struct device *dev;
 	u8 func_no;
 	int ret;
@@ -775,7 +774,6 @@ epf_ntb_peer_spad_bar_set(struct epf_ntb *ntb, enum pci_epc_interface_type type)
 	barno = ntb_epc->epf_ntb_bar[BAR_PEER_SPAD];
 	epf_bar = &ntb_epc->epf_bar[barno];
 	func_no = ntb_epc->func_no;
-	epc = ntb_epc->epc;
 
 	peer_spad_offset = peer_ntb_epc->reg->spad_offset;
 	epf_bar->phys_addr = peer_epf_bar->phys_addr + peer_spad_offset;
@@ -969,11 +967,10 @@ epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
 	const struct pci_epc_features *peer_epc_features, *epc_features;
 	struct epf_ntb_epc *peer_ntb_epc, *ntb_epc;
 	size_t msix_table_size, pba_size, align;
-	enum pci_barno peer_barno, barno;
+	enum pci_barno barno;
 	struct epf_ntb_ctrl *ctrl;
 	u32 spad_size, ctrl_size;
 	u64 size, peer_size;
-	struct pci_epc *epc;
 	struct pci_epf *epf;
 	struct device *dev;
 	bool msix_capable;
@@ -983,7 +980,6 @@ epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
 	epf = ntb->epf;
 	dev = &epf->dev;
 	ntb_epc = ntb->epc[type];
-	epc = ntb_epc->epc;
 
 	epc_features = ntb_epc->epc_features;
 	barno = ntb_epc->epf_ntb_bar[BAR_CONFIG];
@@ -992,7 +988,6 @@ epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
 
 	peer_ntb_epc = ntb->epc[!type];
 	peer_epc_features = peer_ntb_epc->epc_features;
-	peer_barno = ntb_epc->epf_ntb_bar[BAR_PEER_SPAD];
 	peer_size = peer_epc_features->bar_fixed_size[barno];
 
 	/* Check if epc_features is populated incorrectly */
-- 
2.25.4

