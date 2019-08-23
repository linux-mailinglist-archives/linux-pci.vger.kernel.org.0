Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1004D9B324
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394093AbfHWPQa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 11:16:30 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5376 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394059AbfHWPQa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2019 11:16:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d60034d0000>; Fri, 23 Aug 2019 08:16:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 23 Aug 2019 08:16:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 23 Aug 2019 08:16:29 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Aug
 2019 15:16:28 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 23 Aug 2019 15:16:29 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d60034a0000>; Fri, 23 Aug 2019 08:16:28 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH] PCI: dwc: Use dev_info() instead of dev_err()
Date:   Fri, 23 Aug 2019 20:46:18 +0530
Message-ID: <20190823151618.13904-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566573389; bh=/zU/Y/aUMBa0GvPoI85WCd4RIgUyWHb0mOiMZxkz0RM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=LSaI8EqKJA4p+UFTvI8i7eMbces5+c2QmJwnb1DpvJDdy4Ocv8EX6TC/9ZUZa/Zav
         ZJao7KZWEWjaWYY7fRPum+N9CkN4MyJAr0JOK2yWeW/hfgjzsagfVQdl84aK8gGbDd
         AujdCj9/Kj3VIpibswBHQYHHK+bDlZKeC2CJGoCPG5E5+mJj8fL56vGzOKgNAHQWzG
         y/tHDF0sg5/RZhRSFm+Pi9nMpTEEoaC3hFbcOah96HwgT/DgzNFg5U8/nJbnTLwNLE
         jrmJNEahCVdj7FkMz01F/Dp79XoMaqwAlVItM3ltrzYcnk7IWXyv1Ua7oWMS/dxE+1
         +oRCJuSoJXszQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a platform has an open PCIe slot, not having a device connected to
it doesn't have to result in a dev_err() print saying that the link is
not up but a dev_info() would suffice.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 59eaeeb21dbe..4d6690b6ca36 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -456,7 +456,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
 	}
 
-	dev_err(pci->dev, "Phy link never came up\n");
+	dev_info(pci->dev, "Phy link never came up\n");
 
 	return -ETIMEDOUT;
 }
-- 
2.17.1

