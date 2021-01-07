Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FCA2ED407
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 17:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbhAGQLP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 11:11:15 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:49411 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbhAGQLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2021 11:11:13 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210107161030epoutp046bb1f449f1df0b8609a3c18c27ececac~X-w6xZPua2349823498epoutp04a
        for <linux-pci@vger.kernel.org>; Thu,  7 Jan 2021 16:10:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210107161030epoutp046bb1f449f1df0b8609a3c18c27ececac~X-w6xZPua2349823498epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610035830;
        bh=g439C459CH1OddhMJ45SN6Ai5VaoDSSAZ947c4RRj8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvyS0EL9LB/pOwEf1gHTz8X8qurCaknteDdSGYlJoGcq3WV2DnK83mJtU0HQJZcY6
         VA4TB6EeiRalq3HqCx9ERyyj3jc5ot2YQ7TMYTJUVyGMau2sFYfYBsOHqwL3UM6d5F
         QPx6jqyNOlOiJUHkcJGHs4AFYFufaMREWG2eKj/Y=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210107161028epcas5p332ce3b0c4627572c2c5efdf49b9d15f3~X-w5bYnus2636626366epcas5p3H;
        Thu,  7 Jan 2021 16:10:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.BB.33964.47237FF5; Fri,  8 Jan 2021 01:10:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210107153030epcas5p14b0967c4d8d9804a2d084981af445c58~X-OAJV35C2091320913epcas5p1-;
        Thu,  7 Jan 2021 15:30:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210107153030epsmtrp2519ac2f4d5611a8110fca846b86b99f3~X-OAIZSlw0417604176epsmtrp2P;
        Thu,  7 Jan 2021 15:30:30 +0000 (GMT)
X-AuditID: b6c32a4b-eb7ff700000184ac-ed-5ff73274ddb0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.2A.08745.61927FF5; Fri,  8 Jan 2021 00:30:30 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210107153028epsmtip2971fe2872a2a5a799371e17e823cbcd0~X-N98qClA1958119581epsmtip2b;
        Thu,  7 Jan 2021 15:30:28 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com,
        Anvesh Salveru <anvesh.salveru@gmail.com>,
        Shradha Todi <shradha.t@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v7 2/5] PCI: dwc: add support to handle ZRX-DC Compliant
 PHYs
Date:   Thu,  7 Jan 2021 20:58:40 +0530
Message-Id: <1610033323-10560-3-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610033323-10560-1-git-send-email-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7bCmhm6J0fd4gz2HTSx+rJ7AbLGkKcNi
        190OdouP01YyWaz4MpPd4s7zG4wWl3fNYbM4O+84m0Xnl1lsFm9+v2C3eDLlEavF0Y3BFou2
        fmG3+L9nB7tF7+Faixvr2R0EPNbMW8PosXPWXXaPBZtKPTat6mTz6NuyitFjy/7PjB6fN8kF
        sEdx2aSk5mSWpRbp2yVwZSw9285SsFek4sme20wNjIcFuxg5OSQETCSWzFnE2MXIxSEksJtR
        Yu73pVDOJ0aJxi9fmSCcz4wSZ/5+Z4RpubvpDjNEYhdQ4tEvVginhUlixaJrTCBVbAJaEo1f
        u5hBbBGBKImZ21vBipgFtjFLTNs+lRUkISzgL7Hl7zUWEJtFQFXiVetLMJtXwFXi1d0b7BDr
        5CRunusEG8Qp4Cbxbdo6sEESAlM5JBbvPgJ1k4vEm19/mSFsYYlXx7dANUtJfH63lw3CzpeY
        euEp0AIOILtCYnlPHUTYXuLAlTlgYWYBTYn1u/QhwrISU0+tA/uFWYBPovf3EyaIOK/Ejnkw
        trLEl797WCBsSYl5xy6zQtgeEp0/Z0KDbiajxL+miywTGOVmIaxYwMi4ilEytaA4Nz212LTA
        OC+1XK84Mbe4NC9dLzk/dxMjOPFoee9gfPTgg94hRiYOxkOMEhzMSiK8Fse+xAvxpiRWVqUW
        5ccXleakFh9ilOZgURLn3WHwIF5IID2xJDU7NbUgtQgmy8TBKdXA9OxrR7nNi9+LeZuei2w4
        /vqgytm/bCkOWU7KXtfXTnpfGR38zmR1d2030/o675m7y/bteZJwZkbyxk7vYyWXKytd3kvb
        1JzbHpZ8fW/FjrIvM5z4rL/9/JG72mV2XWBv8XzJJXWuS3n17W6cOdf317Hoo7SC6FGef0e2
        MH0XaTFXebz8lZnF/Rlnw/M2ZpcdueBf/pZz9sJZX7fPZl/6TseJ+dS+bIe5xnMsP79tan2l
        uiw+t3ND+9qm5GoTQ/1Tuu3TmcvCZkxbwqLuLOXTwFV4rjr3Cff/nFUqDgsfM8XKzzA7c2D+
        t3mHi6+/vq5326fuq0bzvK6ze33iP+xxS31wyvGl+B+N2NiMxRFtlUosxRmJhlrMRcWJANbm
        fRWrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSvK6Y5vd4g5YpxhY/Vk9gtljSlGGx
        624Hu8XHaSuZLFZ8mclucef5DUaLy7vmsFmcnXeczaLzyyw2ize/X7BbPJnyiNXi6MZgi0Vb
        v7Bb/N+zg92i93CtxY317A4CHmvmrWH02DnrLrvHgk2lHptWdbJ59G1ZxeixZf9nRo/Pm+QC
        2KO4bFJSczLLUov07RK4MpaebWcp2CtS8WTPbaYGxsOCXYycHBICJhJ3N91h7mLk4hAS2MEo
        cWhmLztEQlLi88V1TBC2sMTKf8/ZIYqamCS2/2phA0mwCWhJNH7tYgaxRQRiJNb/u8kKUsQs
        cIhZ4vatKWBFwgK+En8nfGUEsVkEVCVetb5kAbF5BVwlXt29AbVNTuLmuU6wQZwCbhLfpq0D
        GsQBtM1V4uGnkAmMfAsYGVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSHtpbWDsY9
        qz7oHWJk4mA8xCjBwawkwmtx7Eu8EG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tS
        s1NTC1KLYLJMHJxSDUy+Z9fJMrttTqmf3bzGM/SjY0pd9ZrrHstW2znGMPUcSZQOcNqhoHb3
        +zTN5RWBTX5+9UbTerVPXL22/OvLHwtFZp1L3/J3v57z9z1nz6m0z2A2ixTSsnOb0rPbQfrf
        qsKf23bnVZtfeP0reDqL0V22QrWc3S1pzVu690/fLbBo0bnazMmeK63UCz7p2PHKRB8oeuT/
        S5WdebFBGcfBk5/WnErbybJ1m8Ka8soEj66j81V/Pdo7be8S1/SHDOFSO7+ta7hRyFpxssW1
        SCv94JYVn3hsXqTHPT3+Xc7w+X+Hwx71Ex0ys6V23H/Zv754R1Jl5IkbTfJ3w/oyLJdYtkv0
        1Qkoi/237s/eZSPq4q/EUpyRaKjFXFScCAB1M7GW3AIAAA==
X-CMS-MailID: 20210107153030epcas5p14b0967c4d8d9804a2d084981af445c58
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210107153030epcas5p14b0967c4d8d9804a2d084981af445c58
References: <1610033323-10560-1-git-send-email-shradha.t@samsung.com>
        <CGME20210107153030epcas5p14b0967c4d8d9804a2d084981af445c58@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

Many platforms use DesignWare controller but the PHY can be different in
different platforms. If the PHY is compliant is to ZRX-DC specification it
helps in low power consumption during power states.

If current data rate is 8.0 GT/s or higher and PHY is not compliant to
ZRX-DC specification, then after every 100ms link should transition to
recovery state during the low power states.

DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.

Platforms with ZRX-DC compliant PHY can set phy_zrxdc_compliant variable to
specify this property to the controller.

Signed-off-by: Anvesh Salveru <anvesh.salveru@gmail.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 6 ++++++
 drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 645fa18..74590c7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -722,4 +722,10 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		       PCIE_PL_CHK_REG_CHK_REG_START;
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
+
+	if (pci->phy_zrxdc_compliant) {
+		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
+		val &= ~PORT_LOGIC_GEN3_ZRXDC_NONCOMPL;
+		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
+	}
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0207840..8b905a2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -74,6 +74,9 @@
 #define PCIE_MSI_INTR0_MASK		0x82C
 #define PCIE_MSI_INTR0_STATUS		0x830
 
+#define PCIE_PORT_GEN3_RELATED		0x890
+#define PORT_LOGIC_GEN3_ZRXDC_NONCOMPL	BIT(0)
+
 #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
 #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
 
@@ -273,6 +276,7 @@ struct dw_pcie {
 	u8			n_fts[2];
 	bool			iatu_unroll_enabled: 1;
 	bool			io_cfg_atu_shared: 1;
+	bool			phy_zrxdc_compliant;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.7.4

