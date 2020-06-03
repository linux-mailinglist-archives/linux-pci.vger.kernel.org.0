Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865371ED56D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 19:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgFCRy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 13:54:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58988 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgFCRy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 13:54:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053HooaU185764;
        Wed, 3 Jun 2020 17:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=qViCArxFb3D3nOjejk6M1IcFSmBXLlIuD6LBS7MWpr8=;
 b=UmBok1CB3c4dz1BVnjBD7al72bsox3FA2FGn4usODEogVG5yX8Vioz7dxFtMfUEx1moY
 cuB8cVqjxCMLrbQpV66hQ8GtPQejWz+0JyJ13ruVG3guWJUN2R6z9ltVD/v3w/LRVM+o
 u15GWVjiSpj4D7IleyrbrCA5inx0HR9wLcwJyST5ar23pw65qg+WG43sSaoDGMoDdcX9
 lqmkgZqWo0gigrMkkw5iSqLGPXYkuWyycUqmzV1dC7cOWUUmv2QenJdSJJo9Vt0W6lls
 8w6CPv7ZMMPqsLRBPpAi5vZcCbm/YT6hzVOZoQxGuBp+w/g4N/RBPKHXKuQgRYVjuTMW yg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31bfemam38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 17:54:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053HnUjL167580;
        Wed, 3 Jun 2020 17:52:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31c12r85ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 17:52:17 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053HqG9f014853;
        Wed, 3 Jun 2020 17:52:16 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 10:52:15 -0700
Date:   Wed, 3 Jun 2020 20:52:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: uniphier: Fix some error handling in
 uniphier_pcie_ep_probe()
Message-ID: <20200603175207.GB18931@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030138
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This code is checking the wrong variable.  It should be checking
"clk_gio" instead of "clk".  The "priv->clk" pointer is NULL at this
point so the condition is false.

Fixes: 006564dee8253 ("PCI: uniphier: Add Socionext UniPhier Pro5 PCIe endpoint controller driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/pci/controller/dwc/pcie-uniphier-ep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 0f36aa33d2e50..1483559600610 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -324,8 +324,8 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->clk_gio = devm_clk_get(dev, "gio");
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
+	if (IS_ERR(priv->clk_gio))
+		return PTR_ERR(priv->clk_gio);
 
 	priv->rst_gio = devm_reset_control_get_shared(dev, "gio");
 	if (IS_ERR(priv->rst_gio))
-- 
2.26.2

