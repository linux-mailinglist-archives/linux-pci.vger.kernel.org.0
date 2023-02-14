Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B9469663F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjBNOOF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjBNONv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:13:51 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596712A9A4
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:13:12 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230214141207epoutp03ff54a0a97c3b269b271acacb8bc26750~DtkzG3nx42144721447epoutp03U
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:12:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230214141207epoutp03ff54a0a97c3b269b271acacb8bc26750~DtkzG3nx42144721447epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383927;
        bh=kuxFDkZgnx1SPc8bSDimvFlfEON/qYA/DJ+OdV4F/YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDuRAcqb+5hyg832WJoKuUhqt6rKqIWP5KtENOp/+vXJd+K/aQk1gdqYF9KN2NSaB
         EaUFU0RBplmSMrVgzkLLnsdX+S4bNPAh8LXQ1J+Ni09TTzJfo9oUf3AVCwF34ivqnq
         xOLwsjaFUNuf+bkUjfgf205G7y8z8ekKZ/P6SSiA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230214141205epcas5p2d1a6f101ff50ff4839d6e38ac321f605~Dtkx45R8m2451524515epcas5p2p;
        Tue, 14 Feb 2023 14:12:05 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PGNSN4yFnz4x9Pv; Tue, 14 Feb
        2023 14:12:04 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.A8.06765.4B69BE36; Tue, 14 Feb 2023 23:12:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230214121456epcas5p36603c8d717588699d1b5575229d19114~Dr_e7CiW40081100811epcas5p3B;
        Tue, 14 Feb 2023 12:14:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230214121456epsmtrp1fda2db0719d5e8d922c54d556495a537~Dr_e04eqs1788717887epsmtrp1Q;
        Tue, 14 Feb 2023 12:14:56 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-f5-63eb96b4cc3b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.0B.17995.F3B7BE36; Tue, 14 Feb 2023 21:14:55 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121452epsmtip16085c3c7717daffba84e84cb8bf1ee37~Dr_bm37Mg2436024360epsmtip1q;
        Tue, 14 Feb 2023 12:14:52 +0000 (GMT)
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
Subject: [PATCH 13/16] PCI: samsung: Rename common functions to samsung
Date:   Tue, 14 Feb 2023 17:43:30 +0530
Message-Id: <20230214121333.1837-14-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTbUxTVxje6b3tLcyyO8DtQCKD65CAAi2WcjDiZzeuccmaEPcDSdhduaGV
        0ja97YYm22ABmXWgiyIfQlUkU1kEKVA7YICAoCxUExgkBBJRdMUtfJXh5COutGX79zzP+7wf
        5z3nCLHAXkGoUK01sgYto6EE/ritNzoqtuXSn0rx+nwEemKxCVDddyp0pc/BR1W2GoAWVh04
        urlUSaBS5xSG8n9Y5SPrs1E+Gm6rFqAhy4AAVTzq5KHCtUIcFd4vxtHtvkkC1bYuEehNh51A
        a+XzOCrp/Ro1W8uwA8H0X9ZXBP1L1SRBX7WaaGv9GQE9MdohoGcdDoKeHinn0c1139JNs3Ye
        XZu/IKBLW+oB7bKGKbak5+xVsUwWawhntUpdllqbnUIdTcs8nJkoE0tiJckoiQrXMrlsCiX/
        RBH7sVrjPiYV/iWjMbklBcNxVPy+vQadyciGq3ScMYVi9VkavVQfxzG5nEmbHadljXskYnFC
        otv4eY7K9ngA07+m8vInS0A+mN5mBn5CSEphUbMLNwN/YSDZDmCX4zrmJYsAVk61+ogLwLN3
        G8FmSp/tNd8baAPwWv8cz0uKeHB1zCzYcAnIGFjwt9mTHkyO8+CMa4rYIBg5CGC381diwxVE
        psKJ36yeujgZCa8POrENLCL3wMXx0zxvvw/gz3e6PbqfWy8ssnqqQnJECNsb5vlekxy+eDhP
        eHEQfDnQ4sOhcObcaR/OhreaKzAv1sDl5jpfg/2we6TavQOhe7po2NgW75W3wbLBBo8FIwNg
        yeq0zy6Cdssm3g6X1jtwLw6Blv5h3zg0bFwpILxrKQFwYeAecR6EVf3f4ioA9SCE1XO52SyX
        qN+tZb/67+KUulwr8LzmmKN28PTJfFwP4AlBD4BCjAoWBT13KgNFWczJU6xBl2kwaViuByS6
        F/gjFrpVqXN/B60xUyJNFktlMpk0ebdMQr0vikp5qAwksxkjm8OyetawmccT+oXm87qqI3vU
        Ud1Nl+9e4V7eCI0eH8sgB6dvzpzImDsoquq03Hj7C1FZ0Cku4ZuPGsxdQ8sZkYro/sX2f05s
        DwmQHM+SG7Q10Xjq7Kv2x0StZvqPCwGHMna44o+tNRXfSkvfP7lz+P6Wd3b2K6Ic8SsKwLLl
        4u/Ti7caHxz49Hj8EXuq7dkF2UTnGVPBQdGYfu5e2PNjBYnik/67iFHd5UXJ+YiEfbfPPvVz
        7hCR3JAlr9h2eN28rFZePPLZhysSlV2u7nDyqYjhJFKqKql47y2b4nfXwrmEcmahaFfSu/LK
        pbyf7pgyiNaL15L5BW8OPWi1XMJlkS+CSv2SYmbgcs2jACaNwjkVI4nBDBzzL0QRPRZWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnK599etkg2UvzS0ezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLRe/hWovNm6YyO4h4vNn0nd1j56y77B4L
        NpV6bFrVyeZx59oeNo93586xezy5Mp3JY/OSeo+N73YweSxq+Mjm0bdlFaPH501yATxRXDYp
        qTmZZalF+nYJXBnbLhxnLvipVNFwt5exgfGJbBcjJ4eEgInEkW0/WbsYuTiEBHYwSizYv4EN
        IiEp8fniOiYIW1hi5b/n7BBFzUwS5/+fAUuwCWhJNH7tYgZJiAi8YpI4vGcGmMMscIFR4tbB
        bnaQKmEBd4k7pzcxgtgsAqoSi0+9YAaxeQWsJD7daoNaIS+xesMBsDgnULyldROYLSRgKTHr
        1yrGCYx8CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBMeOltYOxj2rPugdYmTi
        YDzEKMHBrCTCK/z0RbIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotg
        skwcnFINTOmxGU7e+vvvh0mZf8jQORV7S2zzqjz9LWq5UyfpcPprbVFcFnGdP+PLLpuadQkh
        LZMCrT+9nH4mc8213Ir7Zd33Zk3a3JO/+/Kd9pmb1vvUyf/gOTmJi6vVkis5VPfYTvufAfMO
        np2ceMyY98Ff2TnfhNla37EdYfi1spupU+VxmUFmfe+21kc35v480pRyaFOb8nI9cd5De4qP
        PnGQ+vJzvsPakLcHlRN1rvxWLcl0Xbfhvn31mosnzVX0T75t2H0rzGe6l4TBrbaQjVqyFdfr
        JsoKllzYErZDp8fyRuYtYYHzTVpKXI01WmG7Xtx7qyN68rGhmPqNCUz7W9nbHtUnaExcpb3q
        7Aqu+SJP05RYijMSDbWYi4oTAcxvLLcMAwAA
X-CMS-MailID: 20230214121456epcas5p36603c8d717588699d1b5575229d19114
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121456epcas5p36603c8d717588699d1b5575229d19114
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121456epcas5p36603c8d717588699d1b5575229d19114@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use samsung instead of exynos for all common functions
like probe/remove/suspend/resume.

Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-samsung.c | 42 ++++++++++++------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
index 719d284e1552..dc8ec0b546fd 100644
--- a/drivers/pci/controller/dwc/pci-samsung.c
+++ b/drivers/pci/controller/dwc/pci-samsung.c
@@ -60,7 +60,7 @@ struct samsung_pcie {
 	struct regulator_bulk_data	supplies[2];
 };
 
-static int exynos_pcie_init_clk_resources(struct samsung_pcie *sp)
+static int samsung_pcie_init_clk_resources(struct samsung_pcie *sp)
 {
 	struct device *dev = sp->pci.dev;
 	int ret;
@@ -74,7 +74,7 @@ static int exynos_pcie_init_clk_resources(struct samsung_pcie *sp)
 	return clk_bulk_prepare_enable(sp->clk_cnt, sp->clks);
 }
 
-static void exynos_pcie_deinit_clk_resources(struct samsung_pcie *sp)
+static void samsung_pcie_deinit_clk_resources(struct samsung_pcie *sp)
 {
 	clk_bulk_disable_unprepare(sp->clk_cnt, sp->clks);
 }
@@ -297,7 +297,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = exynos_pcie_start_link,
 };
 
-static int exynos_pcie_probe(struct platform_device *pdev)
+static int samsung_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct samsung_pcie *sp;
@@ -319,7 +319,7 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(sp->appl_base))
 		return PTR_ERR(sp->appl_base);
 
-	ret = exynos_pcie_init_clk_resources(sp);
+	ret = samsung_pcie_init_clk_resources(sp);
 	if (ret < 0)
 		return ret;
 
@@ -345,12 +345,12 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 fail_probe:
 	phy_exit(sp->phy);
 	regulator_bulk_disable(ARRAY_SIZE(sp->supplies), sp->supplies);
-	exynos_pcie_deinit_clk_resources(sp);
+	samsung_pcie_deinit_clk_resources(sp);
 
 	return ret;
 }
 
-static int __exit exynos_pcie_remove(struct platform_device *pdev)
+static int __exit samsung_pcie_remove(struct platform_device *pdev)
 {
 	struct samsung_pcie *sp = platform_get_drvdata(pdev);
 
@@ -358,13 +358,13 @@ static int __exit exynos_pcie_remove(struct platform_device *pdev)
 	exynos_pcie_assert_core_reset(sp);
 	phy_power_off(sp->phy);
 	phy_exit(sp->phy);
-	exynos_pcie_deinit_clk_resources(sp);
+	samsung_pcie_deinit_clk_resources(sp);
 	regulator_bulk_disable(ARRAY_SIZE(sp->supplies), sp->supplies);
 
 	return 0;
 }
 
-static int exynos_pcie_suspend_noirq(struct device *dev)
+static int samsung_pcie_suspend_noirq(struct device *dev)
 {
 	struct samsung_pcie *sp = dev_get_drvdata(dev);
 
@@ -376,7 +376,7 @@ static int exynos_pcie_suspend_noirq(struct device *dev)
 	return 0;
 }
 
-static int exynos_pcie_resume_noirq(struct device *dev)
+static int samsung_pcie_resume_noirq(struct device *dev)
 {
 	struct samsung_pcie *sp = dev_get_drvdata(dev);
 	struct dw_pcie *pci = &sp->pci;
@@ -394,25 +394,25 @@ static int exynos_pcie_resume_noirq(struct device *dev)
 	return dw_pcie_wait_for_link(pci);
 }
 
-static const struct dev_pm_ops exynos_pcie_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(exynos_pcie_suspend_noirq,
-				  exynos_pcie_resume_noirq)
+static const struct dev_pm_ops samsung_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(samsung_pcie_suspend_noirq,
+				  samsung_pcie_resume_noirq)
 };
 
-static const struct of_device_id exynos_pcie_of_match[] = {
+static const struct of_device_id samsung_pcie_of_match[] = {
 	{ .compatible = "samsung,exynos5433-pcie", },
 	{ },
 };
 
-static struct platform_driver exynos_pcie_driver = {
-	.probe		= exynos_pcie_probe,
-	.remove		= __exit_p(exynos_pcie_remove),
+static struct platform_driver samsung_pcie_driver = {
+	.probe		= samsung_pcie_probe,
+	.remove		= __exit_p(samsung_pcie_remove),
 	.driver = {
-		.name	= "exynos-pcie",
-		.of_match_table = exynos_pcie_of_match,
-		.pm		= &exynos_pcie_pm_ops,
+		.name	= "samsung-pcie",
+		.of_match_table = samsung_pcie_of_match,
+		.pm		= &samsung_pcie_pm_ops,
 	},
 };
-module_platform_driver(exynos_pcie_driver);
+module_platform_driver(samsung_pcie_driver);
 MODULE_LICENSE("GPL v2");
-MODULE_DEVICE_TABLE(of, exynos_pcie_of_match);
+MODULE_DEVICE_TABLE(of, samsung_pcie_of_match);
-- 
2.17.1

