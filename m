Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D2E51498D
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 14:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359295AbiD2MmA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiD2MmA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 08:42:00 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC8AAFAD0;
        Fri, 29 Apr 2022 05:38:41 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 1so5214610qvs.8;
        Fri, 29 Apr 2022 05:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=201AgYs6wxZXn0CiA5WtaZGJH3IgZsAjitKsl1zeggo=;
        b=bt8ayZxMHw4laYtEaAyGgX7330rJVK1ajlU2d7QFoy4B+KP+smWpbI+Wwy2NmAvgCJ
         7PfJV5I4EOSb0DQk4hXHy6CeFgeD5azjLC7j8waIAkAAG/v7EXQ7fv081l6lydsgyzms
         tRKu1FUzyOnfPfQ3gTTWN4pO1V7Dfla+jZa7B2NPrGiFVjxMTK9qU76IPJK8mJI7QzAg
         RXnsuDeet4J4L3lFY6gbnQWbfvKfl5jRZ+pTK3Y3VWjQeabU4a6xQ0NfnYNMfiMYVxtU
         08h8XTxaiw0Si7GdIGZNvcgGGLn0s6IL8FXwYjYubMwQVpq5Mlp1aCWleRm/gz3AwpTL
         CEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=201AgYs6wxZXn0CiA5WtaZGJH3IgZsAjitKsl1zeggo=;
        b=EgzLPILCgc86f+5X4jylLYYK/SxtSq50oMGna0kpWm5XafgD3perEAoWpopV4s363u
         hGWfCPlHN0j4lpWPina6Bfy6HtiEZIt0PbStmIZnEkv0gllcyyuEhk0EZCEYm4QjMMNQ
         sE2FRAGFhKWoaojCCw3j7uT7y/fetz+RaK0VPD1DWFVUzps+KgPiM4sdoxzaYk5kGcaC
         gfZ9F6xzzyBaopsUW0rgWh9O5BJNuNosihXHOaNkws0QvmUC64WhDJo2HxEMTbmTvDUT
         1KfAQ5zpwD0/uyjpBmBzMlsWXX3L6qTZp8Myb6UWC8mYf7Bnh7sTK5dBFAz5GpI6Cl5I
         rl2g==
X-Gm-Message-State: AOAM532mv7YbuzSiSxl67UHMHa6CTtBMFsHEv8vR/m1swlgdJ/gBYqLD
        JenROCOFqf8LL8oHWNm1XzE=
X-Google-Smtp-Source: ABdhPJyeoCUg6N0c4WPfHjvyCADXc9l4KxtqZKYvz7SV8mcxhCCx3m1zBH5DBIY79I69gcfQpeQ6ww==
X-Received: by 2002:a05:6214:519b:b0:456:48f2:a1b1 with SMTP id kl27-20020a056214519b00b0045648f2a1b1mr12840340qvb.4.1651235920957;
        Fri, 29 Apr 2022 05:38:40 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id v126-20020a37dc84000000b0069f9c375519sm1431644qki.46.2022.04.29.05.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:38:40 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, Marc Zyngier <maz@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: [PATCH v9 2/5] PCI: rockchip-dwc: Reset core at driver probe
Date:   Fri, 29 Apr 2022 08:38:28 -0400
Message-Id: <20220429123832.2376381-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429123832.2376381-1-pgwipeout@gmail.com>
References: <20220429123832.2376381-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe controller is in an unknown state at driver probe. This can
lead to undesireable effects when the driver attempts to configure the
controller.

Prevent issues in the future by resetting the core during probe.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c9b341e55cbb..faedbd6ebc20 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -152,6 +152,11 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
 	if (IS_ERR(rockchip->rst_gpio))
 		return PTR_ERR(rockchip->rst_gpio);
 
+	rockchip->rst = devm_reset_control_array_get_exclusive(&pdev->dev);
+	if (IS_ERR(rockchip->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
+				     "failed to get reset lines\n");
+
 	return 0;
 }
 
@@ -182,18 +187,6 @@ static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
 	phy_power_off(rockchip->phy);
 }
 
-static int rockchip_pcie_reset_control_release(struct rockchip_pcie *rockchip)
-{
-	struct device *dev = rockchip->pci.dev;
-
-	rockchip->rst = devm_reset_control_array_get_exclusive(dev);
-	if (IS_ERR(rockchip->rst))
-		return dev_err_probe(dev, PTR_ERR(rockchip->rst),
-				     "failed to get reset lines\n");
-
-	return reset_control_deassert(rockchip->rst);
-}
-
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = rockchip_pcie_link_up,
 	.start_link = rockchip_pcie_start_link,
@@ -222,6 +215,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = reset_control_assert(rockchip->rst);
+	if (ret)
+		return ret;
+
 	/* DON'T MOVE ME: must be enable before PHY init */
 	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
 	if (IS_ERR(rockchip->vpcie3v3)) {
@@ -241,7 +238,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_regulator;
 
-	ret = rockchip_pcie_reset_control_release(rockchip);
+	ret = reset_control_deassert(rockchip->rst);
 	if (ret)
 		goto deinit_phy;
 
-- 
2.25.1

