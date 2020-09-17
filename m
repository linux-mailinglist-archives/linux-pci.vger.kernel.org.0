Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A32526E779
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 23:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgIQVhS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 17:37:18 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59362 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgIQVhR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2020 17:37:17 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C60D5C041D;
        Thu, 17 Sep 2020 21:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1600378089; bh=YiOMEnwFAXpSI4nF+diAbzj8ipMfBsm9nW3oHU0KW9w=;
        h=From:To:Cc:Subject:Date:From;
        b=g+4K4oUW05HpTLm1Yq1/7lL3Ad/HpyEd+cRasAKEFF1HoU5npe75hFSgm9ndVROrK
         BVd4yKOJW5OZTgiWcVIFCpI15KoRNuty0voaXdXxFOvcCSjvWFnZtD1kBZ4rvH1ySn
         5pnHW2KEeJSJ8BWR77BNmZ0EyJsiTx6U0xTVr7p3SvnBzjnD9cotNgc3vzFeQEYJET
         2tdfFU04v9ztuHRc55bkJaDzEIkC0qT6glPi3LXW0kf3oIGzn/EEp4WvZjxw/CD5Ky
         Nsp1+8x3ZZwTlP3JY/Tvoe0fPJCZY/0T5pZ27P74YY+Bj3kTg9kcUhRD27iYywNVgc
         LXBD4ZEn11F7A==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 45F7AA005A;
        Thu, 17 Sep 2020 21:28:06 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] [-next] PCI: DWC: Fix cast truncates bits from constant value
Date:   Thu, 17 Sep 2020 23:28:03 +0200
Message-Id: <7743c426ae2c34573d59636d4d6cefaccdb00990.1600378070.git.gustavo.pimentel@synopsys.com>
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
index 3c3a4d1..dcb7108 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -429,7 +429,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 	}
 
 	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~0 & ~PCIE_ATU_ENABLE);
 }
 
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
-- 
2.7.4

