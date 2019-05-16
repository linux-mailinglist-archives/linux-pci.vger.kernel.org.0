Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA91FF1F
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEPFyX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:54:23 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15072 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:54:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfb0a0000>; Wed, 15 May 2019 22:54:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:54:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:54:22 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:21 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:21 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:54:18 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 19/28] PCI: tegra: Change PRSNT_SENSE IRQ log to debug
Date:   Thu, 16 May 2019 11:22:58 +0530
Message-ID: <20190516055307.25737-20-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986058; bh=pEGwObITWv0uVkupSvmM1RZYJLFffjd5Al7GJ/gSh/s=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=N1RwPL97n89CzZHgPelf1U5jFA1syzrGpw3G21558/OooMzCCEUCZ+shMeTag9/as
         faQaJ8BHoWZq3cV+grMWAueqcNc5LAL8Nrum6KixnFAYwrw/yLAOk0uLUqVu61x9rJ
         NPjObLDd5+p/Hre4O2uzXmALw3uHxoZyAxQ7grDWmwx6OhUDBtsDr31mRBnu1qR+I4
         gJqnqM23aggQZ1OIbP16jIAS6yUX/Xle+V2edTPxoCZWXYhe5BvvoJEe0YDrwaLtkM
         XwSBckbASRq9aw1ntQSFnVJNu8Lznk3WGeUAlRHHGqOINZrJMPnLleZ45brTL3+D9I
         R0wNh8fP34G6g==
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
V4: No change

V3: Correct typos in commit log

V2: If-else to switch-case conversion patch is dropped, this patch is
rebased to stay with if-else statements

 drivers/pci/controller/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 0f02f54f8a61..ac57c5badd9b 100644
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

