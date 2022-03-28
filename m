Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BC74E8C2E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 04:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiC1Cb7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Mar 2022 22:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiC1Cb6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2022 22:31:58 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD52E3EBB3
        for <linux-pci@vger.kernel.org>; Sun, 27 Mar 2022 19:30:18 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220328023016epoutp03888087f2b123e37fda766ddd982c3749~gaozUU8AF1897418974epoutp03s
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 02:30:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220328023016epoutp03888087f2b123e37fda766ddd982c3749~gaozUU8AF1897418974epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648434616;
        bh=xOhRaFRi5l7VsV6rahq9Sgi2dv+5soRTfRVDiUQcO3Q=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=TZUi2gyhw1KbBgRUsGXFYIGhzZHNd+vishzAF5LyDHcYepqfX+dwB5A6S+pboBvI4
         sTofg8lkNpadb++uSeQEAgPED7RjAW5ygk51R2QAu9Lme531CGtgSQve2f0LHdi5wz
         Z52DFbO9tnLpHJVnlLr7qARakaLRx1szB4TZPWBI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220328023016epcas2p1090b05a430045d9c4ca2a152837cf9c6~gaoytgKoI0224602246epcas2p1p;
        Mon, 28 Mar 2022 02:30:16 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KRc9Z45rHz4x9Q5; Mon, 28 Mar
        2022 02:30:10 +0000 (GMT)
X-AuditID: b6c32a48-4fbff7000000810c-89-62411db1ce16
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.CC.33036.1BD11426; Mon, 28 Mar 2022 11:30:09 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Reply-To: wangseok.lee@samsung.com
Sender: =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
From:   =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
To:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
Date:   Mon, 28 Mar 2022 11:30:09 +0900
X-CMS-MailID: 20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmme5GWcckg0XnFSyWNGVYvDykabHr
        bge7xfNDs5gtVnyZyW7xqUXVoqHnN6vF2XnH2Sze/H7BbnFucabF/z072C123jnB7MDjsWbe
        GkaP6+sCPHbOusvusWBTqcemVZ1sHk+uTGfy6NuyitFjy/7PjB6fN8kFcEZl22SkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAXaukUJaYUwoUCkgsLlbS
        t7Mpyi8tSVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5onB1X8IWv4tJC
        kQbGeTxdjJwcEgImEufn/2TtYuTiEBLYwSjR/GgDcxcjBwevgKDE3x3CIDXCAq4ST5vOsILY
        QgJKEjvWzGOGiFtLfJpymQXEZhOwlLjY+pARxBYRKJFomH6bEWQms8BSZokJvf+YIZbxSsxo
        f8oCYUtLbF++lRHC1pD4sawXqkZU4ubqt+ww9vtj86FqRCRa752FqhGUePBzN1RcSmLBk0Os
        EHa1xP6/v5kg7AZGif77qSC/SAjoS+y4bgwS5hXwldi5dhMbiM0ioCqxpf8C1CoXicY5T8Ba
        mQXkJba/nQMOBmYBTYn1u/QhpihLHLnFAvNIw8bf7OhsZgE+iY7Df+HiO+Y9gTpGTWLeyp3M
        EGNkJLa+9J/AqDQLEcyzkKydhbB2ASPzKkax1ILi3PTUYqMCE3i8JufnbmIEp1ktjx2Ms99+
        0DvEyMTBeIhRgoNZSYRX9qx9khBvSmJlVWpRfnxRaU5q8SFGU6CHJzJLiSbnAxN9Xkm8oYml
        gYmZmaG5kamBuZI4r1fKhkQhgfTEktTs1NSC1CKYPiYOTqkGJpu/e43W3m/ctchxubrjrnt5
        dp8UvBOm8H9feEREWkJ5qUSB31+3BYE9049Jny+snFTB9T7VhWlrzxSmr/NvndjKpsO4r03m
        8kZOnV2r/WZriQv92fa7fTebtNoFM9nsfxt3bgsPuH/0pfjqKxvm1t69u33u6brjP0L21e8U
        VFmowbiEZcaUwgurtrGnT0uakC9a4aEjn6SbplWQfG7n72tLtsiYHBfgfMRcNnHH3MbOOzeW
        Hll8e0u05qr9ii+u60lE565Mky9YpLmg0jx5ZrKJyhdntoUn5Jw8lkfc1H1iLpJ4zkL0pmbO
        r1b9qWEqcYcfh+1zOGvvEbBO/8t0mzt1fDmlRf/naB/nEFWa26PEUpyRaKjFXFScCADyZcFY
        PAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c
References: <CGME20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If dma_mask is more than 32 bits this will trigger an error occurs when
dma_map_single_attrs() is performed.

dma_map_single_attrs() -> dma_map_page_attrs()->
error return in dma_direct_map_page().

On ARTPEC-8, this fails with:
artpec8-pcie 17200000.pcie: DMA addr 0x0000000106b052c8+2 overflow
(mask ffffffff, bus limit 27fffffff)

There is no sequence that re-sets dev->dma_mask to more than 32 bits
before call dma_map_single_attrs().
The dev->dma_mask is first set just prior to the dw_pcie_host_init() call.
Therefore, the check logic was modified to be performed only when
the dev-dma_mask is not set larger than 32 bits.

Always setting dma_mask to 32 bits is not always correct,
for example the ARTPEC-8 is an arm64 platform, and can access
more than 32 bits

Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 2fa86f3..7e25958 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -388,9 +388,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 							    dw_chained_msi_isr,
 							    pp);
 
-			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
-			if (ret)
-				dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+			if (!(*dev->dma_mask &  ~(GENMASK(31, 0)))) {
+				ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
+					if (ret)
+						dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+			}
 
 			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
 						      sizeof(pp->msi_msg),
-- 
2.9.5
