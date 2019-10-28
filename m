Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65019E7202
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 13:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389233AbfJ1Mm6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 08:42:58 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:25223 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389163AbfJ1Mm5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 08:42:57 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191028124255epoutp02fe64f0185f6b820400fea921d45583d2~R0B6rHU_W1285612856epoutp02f
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 12:42:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191028124255epoutp02fe64f0185f6b820400fea921d45583d2~R0B6rHU_W1285612856epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572266575;
        bh=T5dy0LMdMnOMairr/D+gfFi983RUv2eT1Chz5wu0IN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IwNJ/hn2iY7ajlaK2raZMh+4/dmCDUFX7/UlFUcTbq7vVsAgXjXDI/HTl1Jtsq0B3
         SdOFT0cmHA6dbZkF6h6u2naEwJ/0LKNF/nhS3apcLIW0uqTTaomkt5lUehU/drNcd5
         nHb72K5yRHYvt2aLDm2M8n66gS3sF1ALE4gN+1Vg=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20191028124254epcas5p1317837693f904049b413d736deee5d89~R0B6Q3PtO3227132271epcas5p1L;
        Mon, 28 Oct 2019 12:42:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.F1.48302.E42E6BD5; Mon, 28 Oct 2019 21:42:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20191028124253epcas5p3fd6b58e5ecd45bfd9c51dfdbd1a4ae40~R0B5ZfMyg1784817848epcas5p3q;
        Mon, 28 Oct 2019 12:42:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191028124253epsmtrp1c21784a4638b87bf7ebf356942f20a71~R0B5Ys5YV1231112311epsmtrp14;
        Mon, 28 Oct 2019 12:42:53 +0000 (GMT)
X-AuditID: b6c32a4a-327ff7000001bcae-51-5db6e24ebffd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.0A.24756.D42E6BD5; Mon, 28 Oct 2019 21:42:53 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191028124251epsmtip2d93a03035818de7b01b40fc46e6a7453~R0B3s1JF_0999809998epsmtip2o;
        Mon, 28 Oct 2019 12:42:51 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     pankaj.dubey@samsung.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Anvesh Salveru <anvesh.s@samsung.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH 1/2] PCI: tegra: Remove support for ZRX-DC compliant PHY
 from platform driver
Date:   Mon, 28 Oct 2019 18:12:19 +0530
Message-Id: <1572266540-17626-2-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572266540-17626-1-git-send-email-anvesh.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7bCmpq7fo22xBvtuq1g0/9/OanF210JW
        iyVNGRbzj5xjtWiZtYjF4vKuOWwWZ+cdZ7Po/DKLzeLN7xfsFou2fmG3+LlrHovFte28Djwe
        a+atYfTYOesuu8eCTaUevc3v2Dz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoErY+7TFsaCddwV
        9z5uZGpg/MzZxcjJISFgInGoaw1jFyMXh5DAbkaJpy8vM0M4nxgltl9cwAbhfGOU6Ow8wwbT
        0vP8DFTLXkaJZyfPsEM4LUwSrw6dA6tiE9CW+Hl0LzuILSJQJjGr6QpYB7PAdCaJM5M3AhVx
        cAgLxEt0HpQEqWERUJVoWv4drJdXwEXi3VKQepBtchI3z3Uyg9icAq4S3VsfsYDMkRA4wiax
        vG8yM0SRi8Snj0uhbGGJV8e3sEPYUhIv+9ug7HyJ3rtLoewaiSl3O6AW2EscuDKHBeQeZgFN
        ifW79EHCzAJ8Er2/nzCBhCUEeCU62oQgTCWJtpnVEI0SEovn32SGCHtIXP+pDwmFGYwS7ZMO
        s01glJ2FMHMBI+MqRsnUguLc9NRi0wKjvNRyveLE3OLSvHS95PzcTYzgZKHltYNx2TmfQ4wC
        HIxKPLwTLm+LFWJNLCuuzD3EKMHBrCTCe/EMUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjvJNar
        MUIC6YklqdmpqQWpRTBZJg5OqQbGkNrnjU3Hnr60euX3sY1bfu4UL0UhhU9pj85yFWzddKhK
        vCl6s8QVzliGvOA1u/4xip6OEGJcxX1yYUdKydaS+1ffz9ZYsjxwXv+DpccXKa/Wrvq8jr25
        ZcflhV6CWyZ4u/Q79Cnu0fQJu6gbWvZc8RTnP1VGgz+f7pvn71O4o/i39KjAF8UtSizFGYmG
        WsxFxYkAcURQzBIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSvK7vo22xBmtPqlo0/9/OanF210JW
        iyVNGRbzj5xjtWiZtYjF4vKuOWwWZ+cdZ7Po/DKLzeLN7xfsFou2fmG3+LlrHovFte28Djwe
        a+atYfTYOesuu8eCTaUevc3v2Dz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoErY+7TFsaCddwV
        9z5uZGpg/MzZxcjJISFgItHz/AxjFyMXh5DAbkaJi9c+sUEkJCS+7P0KZQtLrPz3nB2iqIlJ
        YlHDd1aQBJuAtsTPo3vZQWwRgSqJAx19LCA2s8BcJonna1NAbGGBWIlDHXOZQWwWAVWJpuXf
        wYbyCrhIvFt6hRFigZzEzXOdYDWcAq4S3Vsfgc0RAqpp+vuKeQIj3wJGhlWMkqkFxbnpucWG
        BYZ5qeV6xYm5xaV56XrJ+bmbGMHBqqW5g/HykvhDjAIcjEo8vC+ubosVYk0sK67MPcQowcGs
        JMJ78QxQiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBsbp
        lzYmP+l3cGO4f6clLXNKLMveY5wbGSV8bpq3K8zNyJ33JmZ3xtx9y07vP2frVXj533nlI09X
        8Uz5+S9Pb8a5x09cqgV8Y8Q0pl7vqH3881Zv4/Hdn9+rVqauW2n1iW/OzL2/DC5ECF7yV3q3
        8x3nlC27z28rMnkxa//6nTvzuU9FnX/45sLBs0osxRmJhlrMRcWJAF8447dSAgAA
X-CMS-MailID: 20191028124253epcas5p3fd6b58e5ecd45bfd9c51dfdbd1a4ae40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191028124253epcas5p3fd6b58e5ecd45bfd9c51dfdbd1a4ae40
References: <1572266540-17626-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191028124253epcas5p3fd6b58e5ecd45bfd9c51dfdbd1a4ae40@epcas5p3.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As part of dw_pcie_setup(), PHYs which are compliant to ZRX-DC
specification are already handled based on "snps,phy-zrxdc-compliant"
property in controller DT node. So, instead of handling ZRX-DC
compliant settings in each platform driver, remove this driver
specific code.

CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Andrew Murray <andrew.murray@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
Depends on the following patch:
https://patchwork.kernel.org/patch/11215241/
https://patchwork.kernel.org/patch/11215239/

 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f89f5acee72d..f3a6ea89b8a8 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -782,10 +782,6 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 
 	init_host_aspm(pcie);
 
-	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
-
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
 		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
-- 
2.17.1

