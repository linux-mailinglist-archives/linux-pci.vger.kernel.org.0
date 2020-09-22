Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B257A273F10
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 11:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgIVJ7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 05:59:14 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45652 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgIVJ7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 05:59:14 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AA576C03D2;
        Tue, 22 Sep 2020 09:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1600768753; bh=cVMEVxRWNSVrtDCL6M4MXWzU05kV04Tyh8DtD07yNXs=;
        h=From:To:Cc:Subject:Date:From;
        b=lL3+fFzVHizxCkwXcYaI7tYUyYL0ndviJRz3Ihh8KS8pMyMZtQrT9sooCVQgP9TbA
         L7z+rygDRL+bEKp4O0CfbfZz4FPnQeUxswEI0bVKs8HQ16LWX9KR1xh5wtYYDZuiDE
         cM8oa8+JT55EspLhPV6hEwpWscDvrcS8a5BLR+9s7Ciz9SydN74GnzpkzGTkufk90u
         do6eziV0jXdkyT0xFX6nXRfv7erqWG1dflNwC/oDX+2NJ4Ym4IKyehWxMqLnlJ2sX9
         1FxZiGC2n9J7YZ4IOD2Koivir9FCcRqxsrsZQwa5l3ue+8wua8WYu1wHLCsYkS0UC9
         SVduJg5lU3cwA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 51C07A005D;
        Tue, 22 Sep 2020 09:59:12 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] [-next] PCI: DWC: Fix cast truncates bits from constant value
Date:   Tue, 22 Sep 2020 11:59:10 +0200
Message-Id: <7ea7f7d342f97c758949a17b870012f52ce5b3f5.1600767645.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes warning given by executing "make C=2 drivers/pci/"

Sparse output:
CHECK drivers/pci/controller/dwc/pcie-designware.c
 drivers/pci/controller/dwc/pcie-designware.c:432:52: warning:
 cast truncates bits from constant value (ffffffff7fffffff becomes
 7fffffff)

Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 3c3a4d1..e7a41d9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -429,7 +429,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 	}
 
 	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~(u32)PCIE_ATU_ENABLE);
 }
 
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
-- 
2.7.4

