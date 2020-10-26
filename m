Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D6B298727
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 08:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768795AbgJZGzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 02:55:23 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12606 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768361AbgJZGzX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 02:55:23 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9672e30000>; Sun, 25 Oct 2020 23:55:31 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 06:55:22 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 06:55:19 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH 3/4] PCI: tegra: Set DesignWare IP version
Date:   Mon, 26 Oct 2020 12:24:58 +0530
Message-ID: <20201026065459.28509-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026065459.28509-1-vidyas@nvidia.com>
References: <20201026065459.28509-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603695331; bh=GFmNysVeN0rKBbKQ9g02PVNLmRmdooLteOZK929w+3Y=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=p6A2s80KeReTaNcTk9j45dFxPHi6ELkDsT7irTb3tltzzLmgh7Fab219E836U8QRi
         /ZKsPduBXYPEiDG4n0f2ViXzuGXODz7jceiHsQytoD9+k5EiUxOqa2N+dcbqtTO22Z
         3s32KWbXHkepQxxHDgsqIQuTUUu0edAYMxlvKkAonsY5tAqFejs4FF+0ZOIzOlhU/7
         W7D3leV8eRcsjNGbgl5t56xPA8Ovzxa4aNqBhV5tPoFwfMqXgHnZ1dHbOQ5nd6GTJ7
         eOdbzotpi4SdeG7dgs6/VIoNlBdSSouwOiARNOgLeTnGLKnIbDbXoI74hJ+nz7B75d
         Flktexb8Lrk0A==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set the DesignWare IP version for Tegra194 to 0x490A. This would be used
by the DesigWare sub-system to do any version specific configuration
(Ex:- TD bit programming for ECRC).

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
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

