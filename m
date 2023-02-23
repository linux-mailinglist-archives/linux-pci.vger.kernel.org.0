Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634516A0F27
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 19:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBWSGt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 13:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBWSGs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 13:06:48 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216CA4FAA8;
        Thu, 23 Feb 2023 10:06:27 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NDZHNW021322;
        Thu, 23 Feb 2023 10:06:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=eFEEh0aRpDvgiO44uo5IvSyXWxNaM3rF5W7x2i2ESx0=;
 b=ZNAyEj6KcaCQ+e/utM27HzF6JQ3neXtnIeLVlLvm2FDw1pTtFwibd570cWv5g6+Ekpdw
 oPBXkuJ5jkD+zduU9RK6MCpUaOTl0roxSYv4bTvrLgV7zJGJHXHB7uh6vxheCTI9LTRs
 N9x8CYhuaWT347qWrAPqJ9BBnhAAdoIWi86q5KmVdB5oPXjzQ4bzsVmNO0+jNqj7kDtv
 xVAWVI8uidFuOiwN8vlGH8k/HFly0mi19z0I4TJEW12dq0EZZchk0/TxWYb4BJUQnPFI
 taU7VeNhxLkfvAOONAea5/Jc1vh1M/NkJ5OEJW8jo9yuV/T5gG5oyO0lOGmT1SagRBSy sw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3nwy5h2cx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:06:12 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 10:06:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Thu, 23 Feb 2023 10:06:11 -0800
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 72D883F7095;
        Thu, 23 Feb 2023 10:06:08 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v3 7/7] PCI: dwc: Introduce region limit from DT
Date:   Thu, 23 Feb 2023 20:05:31 +0200
Message-ID: <20230223180531.15148-8-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230223180531.15148-1-enachman@marvell.com>
References: <20230223180531.15148-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 5X9yLlYXb-hJcLKDlUZdTsQxUUDn_Bss
X-Proofpoint-ORIG-GUID: 5X9yLlYXb-hJcLKDlUZdTsQxUUDn_Bss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_11,2023-02-23_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Allow dts override of region limit for SOCs with older Synopsis
Designware PCIe IP but with greater than 32-bit address range support,
such as the Armada 7020/7040/8040 family of SOCs by Marvell,
when the DT file places the PCIe window above the 4GB region.
The Synopsis Designware PCIe IP in these SOCs is too old to specify the
highest memory location supported by the PCIe, but practically supports
such locations. Allow these locations to be specified in the DT file.
DT property is called num-regionmask , and can range between 33 and 64.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 53a16b8b6ac2..429594e853ae 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -401,7 +401,6 @@ static void dw_pcie_writel_atu(struct dw_pcie *pci, u32 dir, u32 index,
 	int ret;
 
 	base = dw_pcie_select_atu(pci, dir, index);
-
 	if (pci->ops && pci->ops->write_dbi) {
 		pci->ops->write_dbi(pci, base, reg, 4, val);
 		return;
@@ -735,10 +734,13 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
 {
 	int max_region, ob, ib;
-	u32 val, min, dir;
+	u32 val, min, dir, ret, num_region_maskbits;
 	u64 max;
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
 
 	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
+
 	if (val == 0xFFFFFFFF) {
 		dw_pcie_cap_set(pci, IATU_UNROLL);
 
@@ -781,7 +783,12 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 		dw_pcie_writel_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT, 0xFFFFFFFF);
 		max = dw_pcie_readl_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT);
 	} else {
-		max = 0;
+		/* Allow dts override of region limit for older IP with above 32-bit support: */
+		ret = of_property_read_u32(np, "num-regionmask", &num_region_maskbits);
+		if (!ret && num_region_maskbits > 32)
+			max = GENMASK(num_region_maskbits - 33, 0);
+		else
+			max = 0;
 	}
 
 	pci->num_ob_windows = ob;
-- 
2.17.1

