Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465798B72B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 13:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfHMLhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 07:37:22 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8817 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbfHMLhW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2019 07:37:22 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d52a0f30003>; Tue, 13 Aug 2019 04:37:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 13 Aug 2019 04:37:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 13 Aug 2019 04:37:21 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 13 Aug
 2019 11:37:21 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 13 Aug
 2019 11:37:21 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 13 Aug 2019 11:37:20 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d52a0eb0004>; Tue, 13 Aug 2019 04:37:20 -0700
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
Subject: [PATCH V16 06/13] PCI: dwc: Export dw_pcie_wait_for_link() API
Date:   Tue, 13 Aug 2019 17:06:20 +0530
Message-ID: <20190813113627.27251-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813113627.27251-1-vidyas@nvidia.com>
References: <20190813113627.27251-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565696244; bh=SRV1RhBsxoJIyxy5LU10VRZa3cAac+SrTlGq66juXkw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Gk5rP5aEtF8LbLcAeOtMiMMGILVElWPcbLvT++ba+04BvWwGJyxnPeyTv+NMvLmyj
         thJekfuugADJmXwmGX9Tvx4Dhy1BXqxfnBYZdLSu0GSthvdbWSdpDLyP1OOJehfGDf
         Hb4zbPKLVuiUS9RXyzEyNrZMMC0s+mEMKWENzdkojORSnAb6JKFL5MI/w9EGdlD+w/
         cIYTAbhy+YwEMzzuJTTySRFkgrfXHML1zkYgKsOYWejwxK//hxysUvl3ZRFoMRQew2
         A6DT8G4GF0MLZotC8NAR974bZzmKjqU1YDlbz3+ulRq3rM0yZKm6VzUBt+QqPeofXi
         Gca33UdkxbMvw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export dw_pcie_wait_for_link() API to be able to build drivers using
this API as loadable modules (Ex:- Tegra194 PCIe host controller driver).

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V16
* None

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

