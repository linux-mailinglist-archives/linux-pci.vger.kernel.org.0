Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD9E1BCF9
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbfEMSJq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:09:46 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18205 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732361AbfEMSJp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:09:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b2ef0004>; Mon, 13 May 2019 11:09:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:09:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 11:09:44 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:43 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:44 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:09:40 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 29/29] PCI: tegra: Change link retry log level to debug
Date:   Mon, 13 May 2019 23:37:44 +0530
Message-ID: <20190513180744.16493-30-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770991; bh=dfk57XYZNcal8kO/q/km6FS8x4fl4LBYZX0nrUA4sbw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZssemgCp9+L+mh35ktR66F3bBsa3hN9i2rovjVeEGH/PPTHM/z9604Q72v4a89lZQ
         Z5j+eNfHMOhMvOREJdYvFU16tLQ38+lBHblM6xeJbuyFvHqGAfeYcZCxDlk5vv/3LM
         73spqJKV1xkWaMC0vuV7QHd6xXQiSO3Pop9C/2cxgYwN0PS4nNUyGa4Lp3OSkk6Hmv
         NUqKWEszwexlGjr3jV8I7O/O/o10AW5C0wdB1U/2w89x/14K/cIXiEpfv47XZA6tfH
         4ICvrToj744qdk1z8ktWm9fw1IMIvVy2Ly7rRy2nLCTXIwob9Di0ttMsxl2ui1wDVw
         JtRSnNduJeiVQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Driver checks for link up three times before giving up, each retry attempt
is printed as an error. Letting users know that PCIe link is down and in the
process of being brought up again is for debug, not an error condition.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3: Changed dev_err to dev_dbg

V2: Updated commit log

 drivers/pci/controller/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index b021863303f1..1370d0015f50 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2373,7 +2373,7 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
 		} while (--timeout);
 
 		if (!timeout) {
-			dev_err(dev, "link %u down, retrying\n", port->index);
+			dev_dbg(dev, "link %u down, retrying\n", port->index);
 			goto retry;
 		}
 
-- 
2.17.1

