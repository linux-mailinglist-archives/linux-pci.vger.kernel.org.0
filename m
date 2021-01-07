Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BEA2ED411
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 17:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbhAGQLn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 11:11:43 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:39281 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbhAGQLn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2021 11:11:43 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210107161039epoutp010c3565de71606c9fab375c066fb3c17f~X-xDNC9ps1022110221epoutp01d
        for <linux-pci@vger.kernel.org>; Thu,  7 Jan 2021 16:10:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210107161039epoutp010c3565de71606c9fab375c066fb3c17f~X-xDNC9ps1022110221epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610035839;
        bh=EPuLISkh8Rcry37eCLEbgtnvmdJrfP667huevNGFuIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQzqXpnUSvvHZZPSqGyyPJtFZ4JBiYhGIikwOuQR+v7NLiBCKFW7Q6LPnb/rF8DGu
         muJtFOYK2ps4r4pIzkpVBIqhpy7gPjCLJhkbRI+Qck/044YR7y63HbIqvVxPZTy1Sx
         75jBgVChTwPQN3n7HIdQ554ghAgex+f0Jg7Oijaw=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210107161038epcas5p393f1d1b703f1b1352efa4296d33d88c8~X-xCjIq1Q0347603476epcas5p3N;
        Thu,  7 Jan 2021 16:10:38 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.AE.15682.E7237FF5; Fri,  8 Jan 2021 01:10:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210107153105epcas5p49ca103794f62faa48c5bedcfc8b4a287~X-OgWkgPs0355003550epcas5p4r;
        Thu,  7 Jan 2021 15:31:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210107153105epsmtrp18012e3229b3d24ce9bd5ea937ecc919c~X-OgVtEi-3139331393epsmtrp1k;
        Thu,  7 Jan 2021 15:31:05 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-87-5ff7327e3e36
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.04.13470.93927FF5; Fri,  8 Jan 2021 00:31:05 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210107153103epsmtip2eee5eeccd2b80e57bcc952584bc1400a~X-OeHYUOu2009920099epsmtip2M;
        Thu,  7 Jan 2021 15:31:03 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com,
        Anvesh Salveru <anvesh.salveru@gmail.com>,
        Shradha Todi <shradha.t@samsung.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v7 4/5] PCI: tegra: Remove platform driver support for
 ZRX-DC compliant PHY
Date:   Thu,  7 Jan 2021 20:58:42 +0530
Message-Id: <1610033323-10560-5-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610033323-10560-1-git-send-email-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7bCmlm6d0fd4g2tf1S2a/29ntfixegKz
        xZKmDIuP01YyWbTMWsRicef5DUaLy7vmsFmcnXeczaLzyyw2ize/X7BbPJnyiNXi6MZgi0Vb
        v7Bb9B6utbixnt3i2nZeBwGPNfPWMHrsnHWX3WPBplKP3uZ3bB59W1YxenzeJBfAFsVlk5Ka
        k1mWWqRvl8CVcW7dUsaCl+IVHVd2sTcwrhTpYuTkkBAwkVi0+jFTFyMXh5DAbkaJD21rWSCc
        T4wSv29/YQSpEhL4xiix+Gk1TMelR0vYIYr2Mkrs3n+IEcJpYZLon3eICaSKTUBLovFrFzOI
        LSIQJTFzeysrSBGzwAZmif8LvrGDJIQFYiVeHjoGVsQioCrx+udSsDivgKtE57k7zBDr5CRu
        nusEszkF3CS+TVsHNkhCoJdD4tOnnSwQRS4SPRe7oRqEJV4d38IOYUtJvOxvg7LzJaZeeApU
        zwFkV0gs76mDCNtLHLgyByzMLKApsX6XPkRYVmLqqXVgvzAL8En0/n7CBBHnldgxD8ZWlvjy
        dw/UBZIS845dZoWwPSQ2nLzFCgmUmYwSz64vYJnAKDcLYcUCRsZVjJKpBcW56anFpgWGeanl
        esWJucWleel6yfm5mxjBqUbLcwfj3Qcf9A4xMnEwHmKU4GBWEuG1OPYlXog3JbGyKrUoP76o
        NCe1+BCjNAeLkjjvDoMH8UIC6YklqdmpqQWpRTBZJg5OqQampSmrdrw9mSC2MPjbopsRWg5u
        f9hOVzbd/eX6xlj+fdlEue3eK/ON/jZtPCFou+5QS13D5jeTM550Pt/B9CCQU/brhUU8Jxb3
        T79Rs+FF5R6rE2fmaF/QWfd0gruiyWb7Ky/mfW7IOq6/bOpRm75PUZeXBszILjv2UvbnkrW3
        1j18JPCt8B9PtYDV9pgnif0R1Rc3H+U2KH/10kLFwGT+dJHTZ/tfF7YrqeQ8WCBqfsfj1UTO
        5TXSKf4N93xDft21aujtummyVD7yZE8W58V4Ts1Jxc93Rx2KuK+0pcfmtL4P1zvR0hdbd3Ev
        eebz+03ejIVC+Rmn+96lpehfrzXbHPcrcCUv08fcqX+mHIkreafEUpyRaKjFXFScCABxU65U
        pAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSvK6l5vd4gwMXJSya/29ntfixegKz
        xZKmDIuP01YyWbTMWsRicef5DUaLy7vmsFmcnXeczaLzyyw2ize/X7BbPJnyiNXi6MZgi0Vb
        v7Bb9B6utbixnt3i2nZeBwGPNfPWMHrsnHWX3WPBplKP3uZ3bB59W1YxenzeJBfAFsVlk5Ka
        k1mWWqRvl8CVcW7dUsaCl+IVHVd2sTcwrhTpYuTkkBAwkbj0aAl7FyMXh5DAbkaJNR8/M0Ek
        JCU+X1wHZQtLrPz3nB3EFhJoYpKY8sABxGYT0JJo/NrFDGKLCMRIrP93kxVkELPAPmaJqZNX
        MIIkhAWiJebcWwJWxCKgKvH651KwQbwCrhKd5+4wQyyQk7h5rhPM5hRwk/g2bR3QIA6gZa4S
        Dz+FTGDkW8DIsIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIziYtTR3MG5f9UHvECMT
        B+MhRgkOZiURXotjX+KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoE
        k2Xi4JRqYCq0vRG1eeeBM6fWp0lm6/l3XSoKzHhql5r75Ei32cnZDFGNRua3v07R8Lw2Y13v
        st/SdpvK6v5d5F0ivIO764pvwkVT2Ul8/u9tRbdJP3e5LaS5vuPOAam4t4rMya8eVzLOzpBY
        xj/7WF5Kce4np0mvTU896Xw1YcnLim2sdnO8dtlpilx0jwp6K/vyUPaVk1cfOnTsCvdjE0lb
        2/n6Sf/cnhc93fnnlkWuvylxJVhGQoaV98/3Dc7fefefv2fXuWPX60vbAqZZCz9Sfnpuc4dV
        mK4+14LGf4Z7ApfeOpP/5QzLeg4NrvBQH++TpixzJTY2tZUdqxFQU7VW2HM49H+VxUHrwGKb
        3LuSJ59c+KrEUpyRaKjFXFScCAB0HqZM1QIAAA==
X-CMS-MailID: 20210107153105epcas5p49ca103794f62faa48c5bedcfc8b4a287
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210107153105epcas5p49ca103794f62faa48c5bedcfc8b4a287
References: <1610033323-10560-1-git-send-email-shradha.t@samsung.com>
        <CGME20210107153105epcas5p49ca103794f62faa48c5bedcfc8b4a287@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

As part of dw_pcie_setup(), PHYs which are compliant to ZRX-DC
specification are already handled based on "phy-zrxdc-compliant" property
in PCIe PHY DT node. So, instead of handling ZRX-DC compliant settings in
each platform driver, remove this driver specific code.

Signed-off-by: Anvesh Salveru <anvesh.salveru@gmail.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 6fa216e..50e85e5 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -194,7 +194,6 @@
 #define GEN3_EQ_CONTROL_OFF_FB_MODE_MASK	GENMASK(3, 0)
 
 #define GEN3_RELATED_OFF			0x890
-#define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
 #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
@@ -899,10 +898,6 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 		disable_aspm_l12(pcie);
 	}
 
-	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
-
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
 		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
@@ -1752,10 +1747,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		disable_aspm_l12(pcie);
 	}
 
-	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
-
 	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 						      PCI_CAP_ID_EXP);
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
@@ -1958,6 +1949,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 {
 	const struct tegra_pcie_dw_of_data *data;
 	struct device *dev = &pdev->dev;
+	unsigned int phy_zrxdc_count;
 	struct resource *atu_dma_res;
 	struct tegra_pcie_dw *pcie;
 	struct pcie_port *pp;
@@ -2066,8 +2058,15 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 				dev_err(dev, "Failed to get PHY: %d\n", ret);
 			return ret;
 		}
+		if (phy_property_present(phys[i], "phy-zrxdc-compliant"))
+			phy_zrxdc_count++;
 	}
 
+	if ((pcie->phy_count) && (pcie->phy_count == phy_zrxdc_count))
+		pci->phy_zrxdc_compliant = true;
+	else
+		pci->phy_zrxdc_compliant = false;
+
 	pcie->phys = phys;
 
 	atu_dma_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-- 
2.7.4

