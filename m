Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74201BCD9
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbfEMSJM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:09:12 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18134 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732296AbfEMSJL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:09:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b2cd0001>; Mon, 13 May 2019 11:09:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:09:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 11:09:10 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:09 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:09:06 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 19/29] PCI: tegra: Change PRSNT_SENSE IRQ log to debug
Date:   Mon, 13 May 2019 23:37:34 +0530
Message-ID: <20190513180744.16493-20-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770957; bh=8eGDwe4dssMYppDaemK5PbOgjUhqX1PSQUK7pKozYcU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=mBJurBb55cREq6E6/lLDpu2QJdjxcOWgDmzejg4QHVUozFGw0+yCAZWQhWT+IU17J
         oUlZwlR24r6M8/UMeqPvVM/LOAG6a79K/aExypnuwtDJGscr9A2RrUGlED326AroGw
         28xajq8nwtzSJP5jOjItBzBVPYtyqMPOaUeGjaP/4TNJZDYnlu/YF8SsLkAN7yNhUB
         QsYrH0KC7gkvOzOGQ6P+9hDqB5VLGIpkh9Pur/7jPV57dAim7M1yPVwU3geeIacVBh
         g77VBlROBMsOfZXuQ2BD2WRusoGrAaqSvFdZATaQzoMhG9lw49Dco+tc1IFMllbLxh
         sRK/D86FSCSMw==
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

