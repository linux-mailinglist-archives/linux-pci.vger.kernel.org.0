Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1D6D6D6B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 04:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfJOC7j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 22:59:39 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:19600 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfJOC7i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Oct 2019 22:59:38 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191015025934epoutp047d81ce5a7ad2db34c6d47b22b471798a~Nsr4eYKZj2041520415epoutp042
        for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2019 02:59:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191015025934epoutp047d81ce5a7ad2db34c6d47b22b471798a~Nsr4eYKZj2041520415epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571108374;
        bh=RPQoptcAngOhAlQVefa7LM3NKKfYj4RRZaFH1zdTe2M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pM3zMsvV3O77njPhz87UnboTBV3hyaYGHAcsuDHejfuEe3WKEjeWoZkpPTyYoUYSm
         OteJAcuwoK3Hno7ZpMYaMsf07nqeP2LVHyqkZDl/Lmqz1DG5kGIbq1Z+u9n96vhLmN
         JoMGYIMWA7eQc3jY1IAAVsiKsUvAaxb9MllGIoDw=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191015025933epcas5p355fcfbe7ceb88a4387638bd787e6633c~Nsr33bnqe0363703637epcas5p3g;
        Tue, 15 Oct 2019 02:59:33 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.C3.04660.51635AD5; Tue, 15 Oct 2019 11:59:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20191015025933epcas5p1f0891dacc13648559ed8e037e49ee5b1~Nsr3M8bvn2838728387epcas5p1T;
        Tue, 15 Oct 2019 02:59:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191015025933epsmtrp20fd09ea9973168d41c7b407bf6ab5099~Nsr3MMi0P1028310283epsmtrp29;
        Tue, 15 Oct 2019 02:59:33 +0000 (GMT)
X-AuditID: b6c32a4a-60fff70000001234-a5-5da536157502
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.51.03889.51635AD5; Tue, 15 Oct 2019 11:59:33 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191015025931epsmtip1f01ff0445547b0078ab7361d1e5bc2d4~Nsr1xvVAt1755217552epsmtip1u;
        Tue, 15 Oct 2019 02:59:31 +0000 (GMT)
From:   Pankaj Dubey <pankaj.dubey@samsung.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, andrew.murray@arm.com,
        lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, vidyas@nvidia.com,
        Anvesh Salveru <anvesh.s@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v3] PCI: dwc: Add support to add GEN3 related equalization
 quirks
Date:   Tue, 15 Oct 2019 08:29:22 +0530
Message-Id: <1571108362-25962-1-git-send-email-pankaj.dubey@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7bCmpq6o2dJYg193zSya/29ntTi7ayGr
        xZKmDItddzvYLVZ8mclucXnXHDaLs/OOs1m8+f2C3WLR1i/sFte28zpweayZt4bRY+esu+we
        CzaVevQ2v2Pz6NuyitFjy/7PjB6fN8kFsEdx2aSk5mSWpRbp2yVwZXx8vZ+94IRkxcEFi9ka
        GB+LdjFyckgImEh87Wpi7WLk4hAS2M0ocWDFaiYI5xOjxJ/J+9ghnG+MErcvzGOCaZm77R4z
        RGIvo8SsKduhqlqYJN5fe8YKUsUmoCvx5P1cZhBbRMBaouHVKrAlzALPGSWu7r/KCJIQFgiW
        eHq2G6yIRUBV4smbXWDNvAIeEvdmz4VaJydx81wn2DoJgRVsEj8m/2GBSLhITNt5hBXCFpZ4
        dXwLO4QtJfH53V42CDtf4sfiSVDNLYwSk4/PhWqwlzhwZQ7QIA6gkzQl1u/SBwkzC/BJ9P5+
        wgQSlhDglehoE4KoVpP4/vwMM4QtI/GweSnUbR4Su6/OBDtHSCBW4t/S/WwTGGVmIQxdwMi4
        ilEytaA4Nz212LTAKC+1XK84Mbe4NC9dLzk/dxMjOCFoee1gXHbO5xCjAAejEg+vQMuSWCHW
        xLLiytxDjBIczEoivPNBQrwpiZVVqUX58UWlOanFhxilOViUxHknsV6NERJITyxJzU5NLUgt
        gskycXBKNTDmbW3nbxR4uvtG192j6RGLtkqq9GyOqqx+w7Zf7rtYj3zCdSUVsU36U6f8/+c1
        h0vx0q05qU83X2nzmqz7a87kZNknrptXqh3fvWs90wE/nhe515avLVr/c+fjTZncxfuy15o/
        Of3zFNe+HBfWrgle12eVMTM4iz3+ei3WqlnM91LA16cfZz6oVmIpzkg01GIuKk4EAMeYvyUE
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSnK6o2dJYg9/HeSya/29ntTi7ayGr
        xZKmDItddzvYLVZ8mclucXnXHDaLs/OOs1m8+f2C3WLR1i/sFte28zpweayZt4bRY+esu+we
        CzaVevQ2v2Pz6NuyitFjy/7PjB6fN8kFsEdx2aSk5mSWpRbp2yVwZXx8vZ+94IRkxcEFi9ka
        GB+LdjFyckgImEjM3XaPuYuRi0NIYDejxK0zS1ggEjISk1evYIWwhSVW/nvODlHUxCQxbcd+
        dpAEm4CuxJP3c5lBbBEBW4mGvx1gk5gF3jNKzN9whREkISwQKHH56g+wqSwCqhJP3uwCm8or
        4CFxb/ZcJogNchI3z3UyT2DkWcDIsIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzjo
        tLR2MJ44EX+IUYCDUYmHN6NtSawQa2JZcWXuIUYJDmYlEd75LUAh3pTEyqrUovz4otKc1OJD
        jNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjF1yqyrO+62Wad6x+aLPRLe/F5P2LumN
        rDrndmWW8qGfa7ZVxS19IfrXRMvCTtL+a1i3WRv/nQ2H5b/wZJlK3jp73PhTdfG31CM7ptkz
        v7SbcPap7p5lhZ6vpTR/sws9NagPdyq1SQi3Xn14xambCWYnmSbvSJkZs1fxJYd95Kovj3cd
        8RDjz1JiKc5INNRiLipOBAD8dnLQNgIAAA==
X-CMS-MailID: 20191015025933epcas5p1f0891dacc13648559ed8e037e49ee5b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191015025933epcas5p1f0891dacc13648559ed8e037e49ee5b1
References: <CGME20191015025933epcas5p1f0891dacc13648559ed8e037e49ee5b1@epcas5p1.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Anvesh Salveru <anvesh.s@samsung.com>

In some platforms, PCIe PHY may have issues which will prevent linkup
to happen in GEN3 or higher speed. In case equalization fails, link will
fallback to GEN1.

DesignWare controller gives flexibility to disable GEN3 equalization
completely or only phase 2 and 3 of equalization.

This patch enables the DesignWare driver to disable the PCIe GEN3
equalization by enabling one of the following quirks:
 - DWC_EQUALIZATION_DISABLE: To disable GEN3 equalization all phases
 - DWC_EQ_PHASE_2_3_DISABLE: To disable GEN3 equalization phase 2 & 3

Platform drivers can set these quirks via "quirk" variable of "dw_pcie"
struct.

Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes w.r.t v2:
 - Rebased on latest linus/master
 - Added Reviewed-by and Acked-by

 drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 820488d..e247d6d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -556,4 +556,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		       PCIE_PL_CHK_REG_CHK_REG_START;
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
+
+	if (pci->quirk & DWC_EQUALIZATION_DISABLE) {
+		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
+		val |= PORT_LOGIC_GEN3_EQ_DISABLE;
+		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
+	}
+
+	if (pci->quirk & DWC_EQ_PHASE_2_3_DISABLE) {
+		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
+		val |= PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE;
+		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
+	}
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5a18e94..7d3fe6f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -29,6 +29,10 @@
 #define LINK_WAIT_MAX_IATU_RETRIES	5
 #define LINK_WAIT_IATU			9
 
+/* Parameters for GEN3 related quirks */
+#define DWC_EQUALIZATION_DISABLE	BIT(1)
+#define DWC_EQ_PHASE_2_3_DISABLE	BIT(2)
+
 /* Synopsys-specific PCIe configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
@@ -60,6 +64,10 @@
 #define PCIE_MSI_INTR0_MASK		0x82C
 #define PCIE_MSI_INTR0_STATUS		0x830
 
+#define PCIE_PORT_GEN3_RELATED		0x890
+#define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE	BIT(9)
+#define PORT_LOGIC_GEN3_EQ_DISABLE		BIT(16)
+
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
@@ -253,6 +261,7 @@ struct dw_pcie {
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
 	unsigned int		version;
+	unsigned int		quirk;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.7.4

