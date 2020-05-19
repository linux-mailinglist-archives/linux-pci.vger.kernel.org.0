Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6341D9AD5
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 17:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgESPLo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 11:11:44 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:14524 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728773AbgESPLo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 11:11:44 -0400
X-IronPort-AV: E=Sophos;i="5.73,410,1583161200"; 
   d="scan'208";a="47275375"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 May 2020 00:11:43 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 98954400516E;
        Wed, 20 May 2020 00:11:41 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] PCI: endpoint: Fix epc windows allocation in pci_epc_multi_mem_init()
Date:   Tue, 19 May 2020 16:11:20 +0100
Message-Id: <1589901081-29948-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix allocation of epc windows with the correct size, this also fix smatch
warning:

drivers/pci/endpoint/pci-epc-mem.c:65 pci_epc_multi_mem_init()
warn: double check that we're allocating correct size: 4 vs 112

Fixes: ecbae87 ("PCI: endpoint: Add support to handle multiple base for mapping outbound memory")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/pci/endpoint/pci-epc-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index 2325f74..80c46f3 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -62,7 +62,7 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
 	if (!windows || !num_windows)
 		return -EINVAL;
 
-	epc->windows = kcalloc(num_windows, sizeof(*mem), GFP_KERNEL);
+	epc->windows = kcalloc(num_windows, sizeof(*epc->windows), GFP_KERNEL);
 	if (!epc->windows)
 		return -ENOMEM;
 
-- 
2.7.4

