Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4BA696682
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjBNOVU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjBNOVQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:21:16 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A882A988
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:21:05 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230214141314epoutp01d37a99dc7d2928f8dfbd536eef533b71~Dtlxv75kV1584215842epoutp01W
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:13:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230214141314epoutp01d37a99dc7d2928f8dfbd536eef533b71~Dtlxv75kV1584215842epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383994;
        bh=5mjw8UmLM6PO7LT0mi6iOKsr2OMYxUDN9WnWHYBrfiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujoDBIpTRCM46scdrGbM9rLXqyX2i8LkUlgGfiZ7ikl1Z6lmxTuIg8e0FzWgTRm1C
         Bky8cjhv+dP2MG86HFormZZeKjDN2zSpcmlHjFA/dr+m5effPqg9sjFnEqP7tXRVWq
         JPWHm+nMqmL9F4eHVgfkzVjJZrIVU0ihYcjZ/dYg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230214141313epcas5p4d49d3caeb3609b6921393b3ab02cad3a~DtlxNXCTM2002420024epcas5p4Y;
        Tue, 14 Feb 2023 14:13:13 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PGNTh1QXBz4x9Pq; Tue, 14 Feb
        2023 14:13:12 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.C9.10528.8F69BE36; Tue, 14 Feb 2023 23:13:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230214121503epcas5p291dce2b37ec4cdabcfecbf8fbdfcca51~Dr_mABlK_0033300333epcas5p2q;
        Tue, 14 Feb 2023 12:15:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230214121503epsmtrp2bfc29dd6e661af95921a823f554c978e~Dr_l-CZxx1888418884epsmtrp26;
        Tue, 14 Feb 2023 12:15:03 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-2d-63eb96f8983e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.9E.05839.74B7BE36; Tue, 14 Feb 2023 21:15:03 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121500epsmtip106e59f353fd89b085fd5fb3806a8e2a2~Dr_jSVJzv2481024810epsmtip1a;
        Tue, 14 Feb 2023 12:15:00 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, jingoohan1@gmail.com,
        Sergey.Semin@baikalelectronics.ru, lukas.bulwahn@gmail.com,
        hongxing.zhu@nxp.com, tglx@linutronix.de, m.szyprowski@samsung.com,
        jh80.chung@samsung.co, pankaj.dubey@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 15/16] PCI: samsung: Add structure to hold resource
 operations
Date:   Tue, 14 Feb 2023 17:43:32 +0530
Message-Id: <20230214121333.1837-16-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmpu6Paa+TDXZM5rB4MG8bm8WSpgyL
        +UfOsVrM2jaX0eLj73MsFiu+zGS36HvxkNmioec3q8Wmx9dYLS7vmsNmcXbecTaLGef3MVm0
        /GlhsWg52s5isfbIXXaLRVu/sFv837OD3eLP9A8sFr2Hay02b5rK7CDi8WbTd3aPnbPusnss
        2FTqsWlVJ5vHnWt72DzenTvH7vHkynQmj81L6j02vtvB5LGo4SObR9+WVYwenzfJBfBEZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAL2ppFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOODBz
        KlPBF/GK2yv1GxgvCncxcnJICJhIPHiynrWLkYtDSGA3o8TshQ1MEM4nRom1e18zQjjfGCXu
        zG5khWlZd/80VNVeRolNV3YwQzitTBJv2iaAVbEJaEk0fu0CS4gI3GKSePn5ITuIwyxwilHi
        wIu97CBVwgIBEjP2TWABsVkEVCWen7/LBGLzClhJ7L63jh1in7zE6g0HmEFsTqB4S+smsKkS
        Alc4JO68ugLkcAA5LhLbDytC1AtLvDq+BapXSuLzu71sEHa6xMrNM5gh7ByJb5uXMEHY9hIH
        rsxhARnDLKApsX6XPkRYVmLqqXVgJcwCfBK9v59AlfNK7JgHYytLfPm7hwXClpSYd+wyK8Q1
        HhILtulAAqWXUWL7sWesExjlZiFsWMDIuIpRMrWgODc9tdi0wDAvtRwea8n5uZsYwUlZy3MH
        490HH/QOMTJxMB5ilOBgVhLhFX76IlmINyWxsiq1KD++qDQntfgQoykw+CYyS4km5wPzQl5J
        vKGJpYGJmZmZiaWxmaGSOK+67clkIYH0xJLU7NTUgtQimD4mDk6pBqbFC/exZZ+6/lDwU9wX
        zh2a7vOuH3vRpcvsbHdRQ+Aph94jr9IQx0Pz/aWMOAxZLnm+OPOkeKZKW0n6+c1XZ8s9zSr7
        vtHnf3mK+NSkmXZqK+7cniEak5yQ+uNGQPMsfqXMuVOS3yyoOTmTU/VuxaIZ8wTV2VtUVxcX
        tUiI2vysOrtmzaLCVZfZTlQqbrlpvsI6uVE7bgWvzxsZntv+jyXP6Wa5u7fVHSptMvR6rXix
        6HGZTbaS43muE6s+Bqxy+qRm+obnU1HPyp+9Tcqp70+oagY9TYpZum/GlNWCiRtr3Ofe+xB7
        bMN8rqirJxbVS7y58Nho4mRdLWeuK7cXzuk82MVw8WSk3pX76zeef+OqxFKckWioxVxUnAgA
        YU0rXFMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnK579etkg9XdihYP5m1js1jSlGEx
        /8g5VotZ2+YyWnz8fY7FYsWXmewWfS8eMls09Pxmtdj0+BqrxeVdc9gszs47zmYx4/w+JouW
        Py0sFi1H21ks1h65y26xaOsXdov/e3awW/yZ/oHFovdwrcXmTVOZHUQ83mz6zu6xc9Zddo8F
        m0o9Nq3qZPO4c20Pm8e7c+fYPZ5cmc7ksXlJvcfGdzuYPBY1fGTz6NuyitHj8ya5AJ4oLpuU
        1JzMstQifbsErowDM6cyFXwRr7i9Ur+B8aJwFyMnh4SAicS6+6eZuhi5OIQEdjNKrD99mB0i
        ISnx+eI6JghbWGLlv+fsEEXNTBKvNi1mBEmwCWhJNH7tYgZJiAi8YpI4vGcGmMMscIFR4tbB
        bqAWDg5hAT+JF090QRpYBFQlnp+/CzaVV8BKYve9dVDb5CVWbzjADGJzAsVbWjeB2UIClhKz
        fq1inMDIt4CRYRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnDcaGnuYNy+6oPeIUYm
        DsZDjBIczEoivMJPXyQL8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUI
        JsvEwSnVwMTwwiuVpUZRcf3yZ+JN87NCSkzWzeR7uPjn00/rHrhccdIotllW/1Sx5JvOjLaE
        //n6nsGcD+2vqSl5qgTe3bOx4Xh43a6F8w7VHmrefPSKbEHb6cbJFqbmK9svGn4VTa/2Lj2U
        9kr6uJzk7hUJ09gz6zqanfOrt71n0zH81peQKn2wUYNZRZG7OcBhvvGUzAOv8oPum1d+lMzz
        jpry6I65RZF8391CgfSyKWpnN0eW2MrOduZft3PRvayS1Mk8i3pvvZfZMEv3yvzsgOs/fgpN
        eVp2+lcX4xN2DWGhnx9+frjK8UDolPQaXfunLbOmOP9dcS3TumfOvSt51ZJXMldHZFbc4Yur
        bdCZ4naWXYmlOCPRUIu5qDgRAOawcDAKAwAA
X-CMS-MailID: 20230214121503epcas5p291dce2b37ec4cdabcfecbf8fbdfcca51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121503epcas5p291dce2b37ec4cdabcfecbf8fbdfcca51
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121503epcas5p291dce2b37ec4cdabcfecbf8fbdfcca51@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some resources might differ based on platforms and we
need platform specific functions to initialize or alter
them. For better code reusibility, making a separate
res_ops which will hold all such function pointers or
other resource specific data.

This patch includes adding function pointer for IRQ
initialization which will help to move common operations for
host init into the probe sequence.

Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-samsung.c | 26 ++++++++++++++++--------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
index 47ca2a6a545d..01882f2d06c7 100644
--- a/drivers/pci/controller/dwc/pci-samsung.c
+++ b/drivers/pci/controller/dwc/pci-samsung.c
@@ -55,6 +55,7 @@ struct samsung_pcie_pdata {
 	struct pci_ops				*pci_ops;
 	const struct dw_pcie_ops		*dwc_ops;
 	const struct dw_pcie_host_ops		*host_ops;
+	const struct samsung_res_ops		*res_ops;
 };
 
 /*
@@ -77,6 +78,10 @@ struct samsung_pcie {
 	struct regulator_bulk_data	supplies[2];
 };
 
+struct samsung_res_ops {
+	int (*irq_init)(struct samsung_pcie *sp, struct platform_device *pdev);
+};
+
 static int samsung_pcie_init_clk_resources(struct samsung_pcie *sp)
 {
 	struct device *dev = sp->pci.dev;
@@ -276,7 +281,7 @@ static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
 	.host_init = exynos_pcie_host_init,
 };
 
-static int exynos_add_pcie_port(struct samsung_pcie *sp,
+static int exynos_irq_init(struct samsung_pcie *sp,
 				       struct platform_device *pdev)
 {
 	struct dw_pcie *pci = &sp->pci;
@@ -295,15 +300,8 @@ static int exynos_add_pcie_port(struct samsung_pcie *sp,
 		return ret;
 	}
 
-	pp->ops = &exynos_pcie_host_ops;
 	pp->msi_irq[0] = -ENODEV;
 
-	ret = dw_pcie_host_init(pp);
-	if (ret) {
-		dev_err(dev, "failed to initialize host\n");
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -314,6 +312,10 @@ static const struct dw_pcie_ops exynos_dw_pcie_ops = {
 	.start_link = exynos_pcie_start_link,
 };
 
+static const struct samsung_res_ops exynos_res_ops_data = {
+	.irq_init		= exynos_irq_init,
+};
+
 static int samsung_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -357,7 +359,12 @@ static int samsung_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sp);
 
-	ret = exynos_add_pcie_port(sp, pdev);
+	if (pdata->res_ops->irq_init)
+		pdata->res_ops->irq_init(sp, pdev);
+
+	sp->pci.pp.ops = pdata->host_ops;
+
+	ret = dw_pcie_host_init(&sp->pci.pp);
 	if (ret < 0)
 		goto fail_probe;
 
@@ -428,6 +435,7 @@ static const struct samsung_pcie_pdata exynos_5433_pcie_rc_pdata = {
 	.dwc_ops		= &exynos_dw_pcie_ops,
 	.pci_ops		= &exynos_pci_ops,
 	.host_ops		= &exynos_pcie_host_ops,
+	.res_ops		= &exynos_res_ops_data,
 };
 
 static const struct of_device_id samsung_pcie_of_match[] = {
-- 
2.17.1

