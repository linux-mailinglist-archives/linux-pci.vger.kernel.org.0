Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38BA7DEC3B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 14:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfJUMaV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 08:30:21 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:43807 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfJUMaU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 08:30:20 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191021123017epoutp01497b6a11b847f37e5b69c7118e86b89f~PqV5fPNZl1936319363epoutp01q
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2019 12:30:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191021123017epoutp01497b6a11b847f37e5b69c7118e86b89f~PqV5fPNZl1936319363epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571661017;
        bh=3jLWlkXFd0BZCxdLzottm5AeS5d5UR0kiBso1bSqG9c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=S7XABmBLQleTNHN4i2h52aNmpyRP1oEF0OKP7Nv7255zd8xlLqc5ZPYwGCYKrPuN3
         75YB8HAMiwF9fCal0PuvtoYmO8EOI1zPhNJsPLmmcmihAfvf0L9qyH/EGvHH8DuPKV
         47Bu06ppFpUA95mqVpnQ4hAUgUkGzuz1UUrsmhGA=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191021123017epcas5p306454e7f6a731be72a638928f5756b88~PqV43j6j_1391713917epcas5p3q;
        Mon, 21 Oct 2019 12:30:17 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.92.04647.8D4ADAD5; Mon, 21 Oct 2019 21:30:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20191021123016epcas5p3ab7100162a8d6d803b117976240f20b4~PqV4cogS12642826428epcas5p3u;
        Mon, 21 Oct 2019 12:30:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191021123016epsmtrp2db4f52c963e168c98f7a8ee612f987b4~PqV4b0us42932329323epsmtrp2a;
        Mon, 21 Oct 2019 12:30:16 +0000 (GMT)
X-AuditID: b6c32a49-72bff70000001227-ed-5dada4d8de56
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.90.04081.8D4ADAD5; Mon, 21 Oct 2019 21:30:16 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191021123015epsmtip1a6905fab73ec796bf63879049675b1bf~PqV3IeBkO2622226222epsmtip1o;
        Mon, 21 Oct 2019 12:30:15 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andrew.murray@arm.com,
        lorenzo.pieralisi@arm.com, Anvesh Salveru <anvesh.s@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH 2/2] PCI: dwc: Add support to handle ZRX-DC Compliant PHYs
Date:   Mon, 21 Oct 2019 17:59:53 +0530
Message-Id: <1571660993-30329-1-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWy7bCmhu7NJWtjDbbvYrJo/r+d1eLsroWs
        FkuaMix23e1gt1jxZSa7xeVdc9gszs47zmbx5vcLdotFW7+wO3B6rJm3htFj56y77B4LNpV6
        9G1ZxeixZf9nRo/Pm+QC2KK4bFJSczLLUov07RK4Ms6t3Mla8FOgor/hE0sD4xm+LkYODgkB
        E4kVGzO6GLk4hAR2M0q8f7iQFcL5xCjxdNkJJgjnG6NEy9rVrDAd/TeCIeJ7GSVeXznHDuG0
        MEm8/t4MVMTJwSagLfHz6F52EFtEwFqi4dUqsLHMAlcYJZpbFjODTBIW8JI49SUbpIZFQFXi
        1dp3bCA2r4CLxOqLi8HmSAjISdw818kM0ishsIBN4k3rBHaIhIvE+4a9jBC2sMSr41ug4lIS
        n9/tZYOw8yV67y6FitdITLnbAVVvL3HgyhwWkBuYBTQl1u/SBwkzC/BJ9P5+wgTxJK9ER5sQ
        hKkk0TazGqJRQmLx/JvMELaHxJcdnWADhQRiJeb+e8M6gVFmFsLMBYyMqxglUwuKc9NTi00L
        DPNSy/WKE3OLS/PS9ZLzczcxgqNey3MH46xzPocYBTgYlXh4CxatjRViTSwrrsw9xCjBwawk
        wnvHACjEm5JYWZValB9fVJqTWnyIUZqDRUmcdxLr1RghgfTEktTs1NSC1CKYLBMHp1QD494Q
        9Uc2Tae2azKd5DK5MKeRYdqe9VWX9vypqA1+c3frmkfe1y4/uXj3iIbqr3mH3N8uDL2Qx7aN
        6dbynf9eld++IlB3f+m0mNlr+J02fY492MJf2bjh6/Qqu3R99bDYnr9WDOwftlzzmMCQ95sp
        ztismLm/zJ8peXFiT9IdOd/oS3LH7k8/yarEUpyRaKjFXFScCAA+dN9q9gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWy7bCSnO6NJWtjDdb/VLRo/r+d1eLsroWs
        FkuaMix23e1gt1jxZSa7xeVdc9gszs47zmbx5vcLdotFW7+wO3B6rJm3htFj56y77B4LNpV6
        9G1ZxeixZf9nRo/Pm+QC2KK4bFJSczLLUov07RK4Ms6t3Mla8FOgor/hE0sD4xm+LkYODgkB
        E4n+G8FdjJwcQgK7GSVWHucDsSUEJCS+7P3KBmELS6z895y9i5ELqKaJSaKrcwMzSIJNQFvi
        59G97CC2iICtRMPfDmaQImaBW4wSm57MYQZZICzgJXHqSzZIDYuAqsSrte/AhvIKuEisvriY
        FWKBnMTNc53MExh5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA4uLc0djJeX
        xB9iFOBgVOLhdZi+JlaINbGsuDL3EKMEB7OSCO8dg7WxQrwpiZVVqUX58UWlOanFhxilOViU
        xHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTAuF874Ny04ry33S0554Ys3mhlee/yXbtaSYM1K
        iNJlby+baLLs6dH48qDdJw0rudba3/OwCsr6l7LBOTV7gyYPs7ztx0PlnlO/Xbzt6/ekcspL
        Nl5Jnc9XhDa+3jgjyEP1sOfnJyuZZkzffvTXTAf7/ZtDom5MLnCNj09alie9xp+399G3CwuV
        WIozEg21mIuKEwGZJjEPKgIAAA==
X-CMS-MailID: 20191021123016epcas5p3ab7100162a8d6d803b117976240f20b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191021123016epcas5p3ab7100162a8d6d803b117976240f20b4
References: <CGME20191021123016epcas5p3ab7100162a8d6d803b117976240f20b4@epcas5p3.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Many platforms use DesignWare controller but the PHY can be different in
different platforms. If the PHY is compliant is to ZRX-DC specification
it helps in low power consumption during power states.

If current data rate is 8.0 GT/s or higher and PHY is not compliant to
ZRX-DC specification, then after every 100ms link should transition to
recovery state during the low power states.

DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.

Platforms with ZRX-DC compliant PHY can set "snps,phy-zrxdc-compliant"
property in controller DT node to specify this property to the controller.

Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
 drivers/pci/controller/dwc/pcie-designware.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 820488dfeaed..6560d9f765d7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -556,4 +556,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		       PCIE_PL_CHK_REG_CHK_REG_START;
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
+
+	if (of_property_read_bool(np, "snps,phy-zrxdc-compliant")) {
+		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
+		val &= ~PORT_LOGIC_GEN3_ZRXDC_NONCOMPL;
+		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
+	}
+
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5a18e94e52c8..427a55ec43c6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -60,6 +60,9 @@
 #define PCIE_MSI_INTR0_MASK		0x82C
 #define PCIE_MSI_INTR0_STATUS		0x830
 
+#define PCIE_PORT_GEN3_RELATED		0x890
+#define PORT_LOGIC_GEN3_ZRXDC_NONCOMPL		BIT(0)
+
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
-- 
2.17.1

