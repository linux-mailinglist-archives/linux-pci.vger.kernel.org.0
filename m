Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 341464A954
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 20:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfFRSDq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 14:03:46 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12588 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbfFRSDq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 14:03:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0927820000>; Tue, 18 Jun 2019 11:03:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 11:03:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Jun 2019 11:03:45 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:03:44 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 18:03:42 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 27/27] PCI: tegra: Change link retry log level to debug
Date:   Tue, 18 Jun 2019 23:32:06 +0530
Message-ID: <20190618180206.4908-28-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618180206.4908-1-mmaddireddy@nvidia.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560881026; bh=0OO5Fska2MnXx55NdYz6po+YW49xjfSnkop5yWchCXY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=NDMxhyT78tRQ/VmrTPaO905eODt8L+rk0IPg006O4psvNzNv7UnSegvwIj4c/XJGi
         apJ3rEmnGU8p81lh6aQJpMsVMVcos35G9JTD0MRVQNxvhBWmJgrRGhBBxsYyH6MFbM
         +nE6BoVIrRxl3TWER3pFVZFtHkAogSCpjRzHxgqysIpwotUXsbIHYUPwMTiDBExqqv
         ui6/2iHya19goWy0T7V1AQWEDllVfn6pUuAYguF5RLgqBuht/9CbkE3MBFfYe4PJnX
         vTrk60jDZbRvcH/LhdJ0KgTrFcYpLRyoAUYMNuuB5vFYpc70ozC8Pt78SW0mLesy2f
         wCn0sdLgiOe6A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Driver checks for link up three times before giving up, each retry attempt
is printed as an error. Letting users know that PCIe link is down and in the
process of being brought up again is for debug, not an error condition.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V6: No change

V5: No change

V4: No change

V3: Changed dev_err to dev_dbg

V2: Updated commit log

 drivers/pci/controller/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index a819bc087a05..e95885a3bd67 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2337,7 +2337,7 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
 		} while (--timeout);
 
 		if (!timeout) {
-			dev_err(dev, "link %u down, retrying\n", port->index);
+			dev_dbg(dev, "link %u down, retrying\n", port->index);
 			goto retry;
 		}
 
-- 
2.17.1

