Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DECCC4A93B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 20:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfFRSDT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 14:03:19 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8379 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbfFRSDT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 14:03:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0927660000>; Tue, 18 Jun 2019 11:03:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 11:03:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Jun 2019 11:03:18 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:03:18 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 18:03:15 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 19/27] PCI: tegra: Change PRSNT_SENSE IRQ log to debug
Date:   Tue, 18 Jun 2019 23:31:58 +0530
Message-ID: <20190618180206.4908-20-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618180206.4908-1-mmaddireddy@nvidia.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560880998; bh=UTaTMadg122LUR2ZZc+S0234k4Wo4BpqrvrvhVSQ4PI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=qswuMBq15fpbJWHzUYb7VpHViRWFIpK7oq5RA/BYyrLvUtTQjyaUEjjTrNzE76yy6
         QciKwZ3PS0iLVwMACQF8hxvxJXzuGFXxRh1AKh9eiA3kxt4rC6mxjOK/nt9OKE8TBt
         /+xXekPK8npX1Z04C80Dw22QULzSbKEo2WUEAIm5qagykxp/6QMH61rUZanf/rI2tt
         +N4AqkODARucZffewzB/b4lumfn6g46XeLGDK09KGc2KA+QlyaKLufz6oThO1LLEGn
         8tqK12d3022z47ESkvUIlVJ4W8mMzun5E+Dzi8amp2KJm9lzCBgesVrM4Jaxu8oTun
         Ab7osmKtBCGqw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PRSNT_MAP bit field is programmed to update the slot present status.
PRSNT_SENSE IRQ is triggered when this bit field is programmed, which is
not an error. Add a new if condition to trap PRSNT_SENSE code and print it
with debug log level.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V6: No change

V5: No change

V4: No change

V3: Correct typos in commit log

V2: If-else to switch-case conversion patch is dropped, this patch is
rebased to stay with if-else statements

 drivers/pci/controller/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index a746d963ca36..73d5a8841405 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -864,7 +864,7 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 	 * do not pollute kernel log with master abort reports since they
 	 * happen a lot during enumeration
 	 */
-	if (code == AFI_INTR_MASTER_ABORT)
+	if (code == AFI_INTR_MASTER_ABORT || code == AFI_INTR_PE_PRSNT_SENSE)
 		dev_dbg(dev, "%s, signature: %08x\n", err_msg[code], signature);
 	else
 		dev_err(dev, "%s, signature: %08x\n", err_msg[code], signature);
-- 
2.17.1

