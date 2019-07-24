Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8D9735EB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfGXRtQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 13:49:16 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9282 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGXRtP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 13:49:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d389a180000>; Wed, 24 Jul 2019 10:49:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 24 Jul 2019 10:49:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 24 Jul 2019 10:49:14 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jul
 2019 17:49:14 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 24 Jul 2019 17:49:14 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d389a150001>; Wed, 24 Jul 2019 10:49:13 -0700
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
Subject: [PATCH V14 06/13] PCI: dwc: Export dw_pcie_wait_for_link() API
Date:   Wed, 24 Jul 2019 23:18:17 +0530
Message-ID: <20190724174824.20933-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724174824.20933-1-vidyas@nvidia.com>
References: <20190724174824.20933-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563990552; bh=NfUmmvFQKxFf8y1EjgtQxF9db7rmfQ/JwQTjX5VuqgA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=C5JVoWmYuh6IlHJWUF3I50V2HHrmhse6/blFJdNvZJK584HblqhxX8MU/Zw9GXL2L
         MslpcjhTWP40EpNvbxO+t2jyIh9gfdAJ6qToi0DCmac9xzhtHtF7SpBatDU9t4I25P
         ZphW5EdIKJxlz7d5QHC8adaHj/Y2XjAGWMbjqy7QDUlBO/mgPo9ZsGjUZ9+mfQINzo
         Mc/2Vk4ZZJ/ZAqmguSPE6vEx3A39SJViZBF46IoOw9r1+ndNvIt4MsfT37mqjkDAkp
         jQYKkV5UpyPb52/OWJgdfH9VXs3T6AUHIA61gm1q0Ur4w5GQCtDZ1T0SQxAOnqfM69
         z5n4lJz90EkoA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export dw_pcie_wait_for_link() API to be able to build drivers using
this API as loadable modules (Ex:- Tegra194 PCIe host controller driver).

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
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

