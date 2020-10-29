Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799AA29E68E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 09:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgJ2IjL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 04:39:11 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11553 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgJ2IjH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 04:39:07 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9a50b70000>; Wed, 28 Oct 2020 22:18:47 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 05:19:03 +0000
Received: from vidyas-desktop.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 29 Oct 2020 05:18:59 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 3/4] PCI: tegra: Set DesignWare IP version
Date:   Thu, 29 Oct 2020 10:48:38 +0530
Message-ID: <20201029051839.11245-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029051839.11245-1-vidyas@nvidia.com>
References: <20201029051839.11245-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603948727; bh=RQv9cuiDlLNVXnXwNCGYWdbrEe4rjTqds+uRa1jgKgg=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=O3HQqD1iMaGGMTt3tIm84JhDLm4CCQA3HXwDo2unCR/6Flkri2O49co50Cat0RKr5
         0khhyMy6liHj/4K4HhmkU+Hf271lrCFEoFvxw7k+2eSJr5tcXbKNPLQwH24wJty7ct
         DBNJhZ2gE5OzEx2apAWelnpZxrgf//wsbEBmHhC/mnqGXU0YegtQyA56Tjxv3zuTsq
         ofvs0Zn3B1uovnd/MemYY3tSV3GePcZStVuGjGStHLHUBrvholio7SXt6/qPH+gV+U
         Ifih2/VmhxYoNq1xJQvMCzMaI/Obo8f56KJozYKYXRtcQ4QrMxNL89KoeRdU430X6f
         JPGnsB0UAcpfA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set the DesignWare IP version for Tegra194 to 0x490A. This would be used
by the DesigWare sub-system to do any version specific configuration
(Ex:- TD bit programming for ECRC).

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7a0c64436861..253d91033bc3 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2011,6 +2011,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	pci->ops = &tegra_dw_pcie_ops;
 	pci->n_fts[0] = N_FTS_VAL;
 	pci->n_fts[1] = FTS_VAL;
+	pci->version = 0x490A;
 
 	pp = &pci->pp;
 	pcie->dev = &pdev->dev;
-- 
2.17.1

