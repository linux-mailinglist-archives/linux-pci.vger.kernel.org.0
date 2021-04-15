Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED99036044D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 10:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhDOId3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 04:33:29 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52049 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbhDOId3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Apr 2021 04:33:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVdfYiB_1618475578;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVdfYiB_1618475578)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Apr 2021 16:33:04 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lorenzo.pieralisi@arm.com
Cc:     robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] PCI: dwc: remove unused function
Date:   Thu, 15 Apr 2021 16:32:57 +0800
Message-Id: <1618475577-99198-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the following clang warning:

drivers/pci/controller/dwc/pcie-intel-gw.c:84:19: warning: unused
function 'pcie_app_rd' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 0cedd1f..f89a7d2 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -81,11 +81,6 @@ static void pcie_update_bits(void __iomem *base, u32 ofs, u32 mask, u32 val)
 		writel(val, base + ofs);
 }
 
-static inline u32 pcie_app_rd(struct intel_pcie_port *lpp, u32 ofs)
-{
-	return readl(lpp->app_base + ofs);
-}
-
 static inline void pcie_app_wr(struct intel_pcie_port *lpp, u32 ofs, u32 val)
 {
 	writel(val, lpp->app_base + ofs);
-- 
1.8.3.1

