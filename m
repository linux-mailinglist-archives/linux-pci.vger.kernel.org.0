Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90037D2C6B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjJWIO6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 04:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjJWIO6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 04:14:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B5893;
        Mon, 23 Oct 2023 01:14:48 -0700 (PDT)
X-UUID: 34fba70e717c11ee8051498923ad61e6-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=d5y/tCPvNK1uJUTea7FJvDbB+ElbLPJbs56hofzIUFY=;
        b=n1CT+gyU0mi6J9vmxfsse9HSb1Mq+G/NrsrKp9qWPJ9UxSQGTOaJ7wtiQ6no5k6VWTO5yh8LmOyrfnqc8eq6Lxaxy+eKy7aEi2o0keV4mKqAqCxXR2GKFfwPifT3b6I3bTSoJZpRx5+aNzSoELIqKID+HJcBG6ali3jDL7WMNuQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:528497e7-09bb-444e-8296-06fc22dd03d9,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5f78ec9,CLOUDID:a9290a7d-ccd9-4df5-91ce-9df5fea3ae01,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 34fba70e717c11ee8051498923ad61e6-20231023
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 49696426; Mon, 23 Oct 2023 16:14:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 16:14:36 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 16:14:35 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Subject: [PATCH v2] PCI: mediatek-gen3: Fix translation window
Date:   Mon, 23 Oct 2023 16:14:23 +0800
Message-ID: <20231023081423.18559-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.560800-8.000000
X-TMASE-MatchedRID: 4VX+Kn75IUwwfXl56Qt5SMq3pARtkOfKhEIiqNvBrmM0QmmUihPzrE/3
        ZkXeY1OApLHkqMumMNpuk1SYLV+ldrHErqwG73Buhaz6sxCNvh+l9VzHf0qr7sA0eOJZYj7t8du
        UDrN9y5kjUroFO9YcXHudmZKCXGD2EW6jmoEfW6YtMfCdg6KRDRI1EOUVOliSCqIJhrrDy29Yua
        /kyrSLK0Ee/bRpAYoLNj1dDRXH7+YJdnwVDCoumF4SsF49N47AlQcr7h+FTcUZcrU7gRwFKeJz0
        /I2b9TR4vM1YF6AJbbCCfuIMF6xLSAHAopEd76vB335zBq65/5xiPh5r+3vc3t3L2Ik52C4DCKf
        OFp8GpOrw9Rb0OqbOA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.560800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: C94052166E159269FC3F488C62B0509821519C485DDD9F9AD115AB88E227A29F2000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The size of translation table should be a power of 2, using fls()
cannot get the proper value when the size is not a power of 2. For
example, fls(0x3e00000) - 1 = 25, hence the PCIe translation window
size will be set to 0x2000000 instead of the expected size 0x3e00000.

Fix translation window by splitting the MMIO space to multiple tables if
its size is not a power of 2.

Fixes: d3bf75b579b9 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192")
Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>

---
Changes in v2:
Only print warning message when reach the maximum translation table
number, the MEM space still works but will be smaller than expected.

Bootup logs on MT8195 Platform:

> Before this patch:
mtk-pcie-gen3 112f0000.pcie: Parsing ranges property...
mtk-pcie-gen3 112f0000.pcie:       IO 0x0020000000..0x00201fffff -> 0x0020000000
mtk-pcie-gen3 112f0000.pcie:      MEM 0x0020200000..0x0023ffffff -> 0x0020200000
mtk-pcie-gen3 112f0000.pcie: set IO trans window[0]: cpu_addr = 0x20000000, pci_addr = 0x20000000, size = 0x200000
mtk-pcie-gen3 112f0000.pcie: set MEM trans window[1]: cpu_addr = 0x20200000, pci_addr = 0x20200000, size = 0x3e00000

> We expect the MEM trans window size to be 0x3e00000, but its actual available size is 0x2000000.

> After applying this patch:
mtk-pcie-gen3 112f0000.pcie: Parsing ranges property...
mtk-pcie-gen3 112f0000.pcie:       IO 0x0020000000..0x00201fffff -> 0x0020000000
mtk-pcie-gen3 112f0000.pcie:      MEM 0x0020200000..0x0023ffffff -> 0x0020200000
mtk-pcie-gen3 112f0000.pcie: set IO trans window[0]: cpu_addr = 0x20000000, pci_addr = 0x20000000, size = 0x200000
mtk-pcie-gen3 112f0000.pcie: set MEM trans window[1]: cpu_addr = 0x20200000, pci_addr = 0x20200000, size = 0x200000
mtk-pcie-gen3 112f0000.pcie: set MEM trans window[2]: cpu_addr = 0x20400000, pci_addr = 0x20400000, size = 0x400000
mtk-pcie-gen3 112f0000.pcie: set MEM trans window[3]: cpu_addr = 0x20800000, pci_addr = 0x20800000, size = 0x800000
mtk-pcie-gen3 112f0000.pcie: set MEM trans window[4]: cpu_addr = 0x21000000, pci_addr = 0x21000000, size = 0x1000000
mtk-pcie-gen3 112f0000.pcie: set MEM trans window[5]: cpu_addr = 0x22000000, pci_addr = 0x22000000, size = 0x2000000

> Total available size for MEM trans window is 0x3e00000.
---
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 85 ++++++++++++---------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index e0e27645fdf4..975b3024fb08 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -245,35 +245,60 @@ static int mtk_pcie_set_trans_table(struct mtk_gen3_pcie *pcie,
 				    resource_size_t cpu_addr,
 				    resource_size_t pci_addr,
 				    resource_size_t size,
-				    unsigned long type, int num)
+				    unsigned long type, int *num)
 {
+	resource_size_t remaining = size;
+	resource_size_t table_size;
+	resource_size_t addr_align;
+	const char *range_type;
 	void __iomem *table;
 	u32 val;
 
-	if (num >= PCIE_MAX_TRANS_TABLES) {
-		dev_err(pcie->dev, "not enough translate table for addr: %#llx, limited to [%d]\n",
-			(unsigned long long)cpu_addr, PCIE_MAX_TRANS_TABLES);
-		return -ENODEV;
-	}
+	while (remaining && (*num < PCIE_MAX_TRANS_TABLES)) {
+		/* Table size needs to be a power of 2 */
+		table_size = BIT(fls(remaining) - 1);
+
+		if (cpu_addr > 0) {
+			addr_align = BIT(ffs(cpu_addr) - 1);
+			table_size = min(table_size, addr_align);
+		}
+
+		/* Minimum size of translate table is 4KiB */
+		if (table_size < 0x1000) {
+			dev_err(pcie->dev, "illegal table size %#llx\n",
+				(unsigned long long)table_size);
+			return -EINVAL;
+		}
 
-	table = pcie->base + PCIE_TRANS_TABLE_BASE_REG +
-		num * PCIE_ATR_TLB_SET_OFFSET;
+		table = pcie->base + PCIE_TRANS_TABLE_BASE_REG + *num * PCIE_ATR_TLB_SET_OFFSET;
+		writel_relaxed(lower_32_bits(cpu_addr) | PCIE_ATR_SIZE(fls(table_size) - 1), table);
+		writel_relaxed(upper_32_bits(cpu_addr), table + PCIE_ATR_SRC_ADDR_MSB_OFFSET);
+		writel_relaxed(lower_32_bits(pci_addr), table + PCIE_ATR_TRSL_ADDR_LSB_OFFSET);
+		writel_relaxed(upper_32_bits(pci_addr), table + PCIE_ATR_TRSL_ADDR_MSB_OFFSET);
 
-	writel_relaxed(lower_32_bits(cpu_addr) | PCIE_ATR_SIZE(fls(size) - 1),
-		       table);
-	writel_relaxed(upper_32_bits(cpu_addr),
-		       table + PCIE_ATR_SRC_ADDR_MSB_OFFSET);
-	writel_relaxed(lower_32_bits(pci_addr),
-		       table + PCIE_ATR_TRSL_ADDR_LSB_OFFSET);
-	writel_relaxed(upper_32_bits(pci_addr),
-		       table + PCIE_ATR_TRSL_ADDR_MSB_OFFSET);
+		if (type == IORESOURCE_IO) {
+			val = PCIE_ATR_TYPE_IO | PCIE_ATR_TLP_TYPE_IO;
+			range_type = "IO";
+		} else {
+			val = PCIE_ATR_TYPE_MEM | PCIE_ATR_TLP_TYPE_MEM;
+			range_type = "MEM";
+		}
 
-	if (type == IORESOURCE_IO)
-		val = PCIE_ATR_TYPE_IO | PCIE_ATR_TLP_TYPE_IO;
-	else
-		val = PCIE_ATR_TYPE_MEM | PCIE_ATR_TLP_TYPE_MEM;
+		writel_relaxed(val, table + PCIE_ATR_TRSL_PARAM_OFFSET);
 
-	writel_relaxed(val, table + PCIE_ATR_TRSL_PARAM_OFFSET);
+		dev_dbg(pcie->dev, "set %s trans window[%d]: cpu_addr = %#llx, pci_addr = %#llx, size = %#llx\n",
+			range_type, *num, (unsigned long long)cpu_addr,
+			(unsigned long long)pci_addr, (unsigned long long)table_size);
+
+		cpu_addr += table_size;
+		pci_addr += table_size;
+		remaining -= table_size;
+		(*num)++;
+	}
+
+	if (remaining)
+		dev_warn(pcie->dev, "not enough translate table for addr: %#llx, limited to [%d]\n",
+			 (unsigned long long)cpu_addr, PCIE_MAX_TRANS_TABLES);
 
 	return 0;
 }
@@ -380,30 +405,20 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		resource_size_t cpu_addr;
 		resource_size_t pci_addr;
 		resource_size_t size;
-		const char *range_type;
 
-		if (type == IORESOURCE_IO) {
+		if (type == IORESOURCE_IO)
 			cpu_addr = pci_pio_to_address(res->start);
-			range_type = "IO";
-		} else if (type == IORESOURCE_MEM) {
+		else if (type == IORESOURCE_MEM)
 			cpu_addr = res->start;
-			range_type = "MEM";
-		} else {
+		else
 			continue;
-		}
 
 		pci_addr = res->start - entry->offset;
 		size = resource_size(res);
 		err = mtk_pcie_set_trans_table(pcie, cpu_addr, pci_addr, size,
-					       type, table_index);
+					       type, &table_index);
 		if (err)
 			return err;
-
-		dev_dbg(pcie->dev, "set %s trans window[%d]: cpu_addr = %#llx, pci_addr = %#llx, size = %#llx\n",
-			range_type, table_index, (unsigned long long)cpu_addr,
-			(unsigned long long)pci_addr, (unsigned long long)size);
-
-		table_index++;
 	}
 
 	return 0;
-- 
2.18.0

