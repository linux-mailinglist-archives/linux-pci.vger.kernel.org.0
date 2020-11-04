Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6522A5FF7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 09:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgKDIwq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 03:52:46 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2695 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgKDIwp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 03:52:45 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa26bdf0005>; Wed, 04 Nov 2020 00:52:47 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 08:52:42 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Nov 2020 08:52:37 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3 5/5] PCI: tegra: Check return value of tegra_pcie_init_controller()
Date:   Wed, 4 Nov 2020 14:20:18 +0530
Message-ID: <20201104085018.13021-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104085018.13021-1-vidyas@nvidia.com>
References: <20201104085018.13021-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604479967; bh=n8XdfeCZduO7ogcyhJVAlYbsvTFqkbs1wknNZ3ixbf4=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=pZrMuYJElTBvismIA6kjwVHxaFE7FOuOChV1MmIorPgM+RhqDiJy8iiv9KlR5oVNW
         QylfQbhVrOJU/rAGAJ1+EfK4wzHIz1SnGUDFHuRQOnEd1rgytRVYZv0U5pkTh1fqGO
         YqSCoHqVq6vEGSApK/hxHN434Qb2o0SCkKN/iN8L7/1lU8ThikxdcfB4mV/J8b+cIM
         9pYpoI4Ti1QYh6P3JOfOb1IH75RfqD6Q3CdviNkTzHPrXkimf2zwZpynPowkKl0jaS
         35nqtU/5psp54DQ6LwFO0K/aJSXJg2rylUVTcU0BoRn2Lrb+BbG0di9y1FUBPJhE/t
         pK41dEitL4G3Q==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value of tegra_pcie_init_controller() must be checked before
PCIe link up check and registering debugfs entries subsequently as it
doesn't make sense to do these when the controller initialization itself
has failed.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* New patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9be10c8953df..8c08998b9ce1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1579,7 +1579,11 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		goto fail_pm_get_sync;
 	}
 
-	tegra_pcie_init_controller(pcie);
+	ret = tegra_pcie_init_controller(pcie);
+	if (ret < 0) {
+		dev_err(dev, "Failed to initialize controller: %d\n", ret);
+		goto fail_pm_get_sync;
+	}
 
 	pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
 	if (!pcie->link_state) {
-- 
2.17.1

