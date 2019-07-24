Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA88735E7
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfGXRtJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 13:49:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9269 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGXRtJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 13:49:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d389a110000>; Wed, 24 Jul 2019 10:49:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 24 Jul 2019 10:49:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 24 Jul 2019 10:49:08 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jul
 2019 17:49:07 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 24 Jul 2019 17:49:08 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d389a0e0006>; Wed, 24 Jul 2019 10:49:07 -0700
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
Subject: [PATCH V14 05/13] PCI: dwc: Add ext config space capability search API
Date:   Wed, 24 Jul 2019 23:18:16 +0530
Message-ID: <20190724174824.20933-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724174824.20933-1-vidyas@nvidia.com>
References: <20190724174824.20933-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563990546; bh=zfrhQUkxT9cLXGjzknRdGQ25/ub81Adr4/ls57Yv98U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kOBMwq31puPDbmfLoORsXMbcj76M/2IRejttUsrYIAV1Qx2iNCjefmkxcvzZVa9Qw
         vY6+IhVCTfwYHtwT2wHO4BuwYMvO0MQPoW8/+fKW99ABaUf+NWzIAW2CkNHc+bemvI
         NQedDF4gYIsieC42JyHlrKvXaEE8ha2LLivyhhd/uXIQjBom6cZMqYyW808tA788ou
         IS2QEnvjpMsMAVXd6v8jZRmvNZwDBv7IluUX0nVScROZiRYgv+oTRlqcj+pR2Nlt/V
         RmF36GaVU+lSwikIvTvT9pNVfIlySy02MwBASN43F1r50bns2/RoU1VfXClnFNJjiW
         CQL8d/gJBfNgQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add extended configuration space capability search API using struct dw_pcie *
pointer.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V14:
* Added a full stop(.) at the end of commit message.

V13:
* None

V12:
* None

V11:
* None

V10:
* None

V9:
* Added Acked-by from Thierry

V8:
* Changed data types of return and arguments to be inline with data being returned
  and passed.

V7:
* None

V6:
* None

V5:
* None

V4:
* None

V3:
* None

V2:
* This is a new patch in v2 series

 drivers/pci/controller/dwc/pcie-designware.c | 41 ++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 42 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 7818b4febb08..181449e342f1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -53,6 +53,47 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
 
+static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
+					    u8 cap)
+{
+	u32 header;
+	int ttl;
+	int pos = PCI_CFG_SPACE_SIZE;
+
+	/* minimum 8 bytes per capability */
+	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
+
+	if (start)
+		pos = start;
+
+	header = dw_pcie_readl_dbi(pci, pos);
+	/*
+	 * If we have no capabilities, this is indicated by cap ID,
+	 * cap version and next pointer all being 0.
+	 */
+	if (header == 0)
+		return 0;
+
+	while (ttl-- > 0) {
+		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
+			return pos;
+
+		pos = PCI_EXT_CAP_NEXT(header);
+		if (pos < PCI_CFG_SPACE_SIZE)
+			break;
+
+		header = dw_pcie_readl_dbi(pci, pos);
+	}
+
+	return 0;
+}
+
+u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
+{
+	return dw_pcie_find_next_ext_capability(pci, 0, cap);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index d8c66a6827dc..11c223471416 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -252,6 +252,7 @@ struct dw_pcie {
 		container_of((endpoint), struct dw_pcie, ep)
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
+u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
-- 
2.17.1

