Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDAD7870DE
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 06:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405433AbfHIEq7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 00:46:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5548 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405430AbfHIEq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 00:46:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4cfac30001>; Thu, 08 Aug 2019 21:46:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 21:46:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 08 Aug 2019 21:46:57 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 04:46:57 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 9 Aug 2019 04:46:57 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4cfabc0000>; Thu, 08 Aug 2019 21:46:57 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V15 06/13] PCI: dwc: Export dw_pcie_wait_for_link() API
Date:   Fri, 9 Aug 2019 10:16:02 +0530
Message-ID: <20190809044609.20401-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190809044609.20401-1-vidyas@nvidia.com>
References: <20190809044609.20401-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565326019; bh=GmfSsfkLiF+SxmedIYBXdPOvVKebhwqSQIYA8CNvP8M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=e+Pmdaov3EEuJnrEUK9Z/gEAl0BKNZH0fxH5QCpwjbtuGNLgqlP3vvEFPgvcpf52x
         mdtbiweKU1YVKPDy38ujn2ejuPQ+88OyhaaRQBhNxPYnp9Z4e35Kh6jMFd3wvYqxfk
         aUs8Qvj3UevY+0CMD8oZ6evU9tNRs9nlFHzUkrLhd0ObHYLlJfBt7km96ncNEcPfBK
         cHXcFqgSwHRcfgsjAHYQBpwSAVPjtQ7HRoDUWW3LpOw4bETPr2z2wPB/3rQXmm/mNT
         m0bb25ZLdigusRktw5UMztmU4LUsyDs3/Th+dux3VlBpeM1fj4QE6AX+HykOiEy5bp
         SDyW3yfShT/vQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export dw_pcie_wait_for_link() API to be able to build drivers using
this API as loadable modules (Ex:- Tegra194 PCIe host controller driver).

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V15:
* None

V14:
* This is a new patch in V14 series.

 drivers/pci/controller/dwc/pcie-designware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 181449e342f1..1d87e823de21 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -460,6 +460,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 
 	return -ETIMEDOUT;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_wait_for_link);
 
 int dw_pcie_link_up(struct dw_pcie *pci)
 {
-- 
2.17.1

