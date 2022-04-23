Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244F150CBBA
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 17:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiDWP1I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 11:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbiDWP1G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 11:27:06 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8435DDF;
        Sat, 23 Apr 2022 08:24:09 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id v2so889476qto.6;
        Sat, 23 Apr 2022 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vlE3jklwJQd6ueFtiorc64wDSZ8+k3Jyqs3OwGaYUY=;
        b=UBnggtjfHwcWpvPs+QnS6XEae3Sasnm+H/xeBR9JPKtayJ7uYgzHfKAbKmnXOfFTn2
         PvdCdS64Odc13wkddhNe/6CK3a46xT5ijDkvTYm93iNk6S0EQL0Ckke6ySZFfbFVWq3h
         JB2fRQi0Cp6+d5Dc2jxelEfpT/CB6edvOKmOMS8FravcHZbPanbqRwKUN0AiqOuq14eA
         zV3fClSKFlBMRoDogHA+qWthT4EACXfTqAy2oWcecvDJQxQBluqi6+zlGV36ox6Gk6bG
         SE25zfwhunBWVHoJPWO2olCyF/D9Z6Jt+IuQ4ImwCnau5gdQi5XicLqecSvazd8scrvU
         AaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vlE3jklwJQd6ueFtiorc64wDSZ8+k3Jyqs3OwGaYUY=;
        b=gCOte/PVunxQCJbCot8sW+gpsTNJoJhXWuYhB0bYKERqXVmjT1uFNmCvB617F4SOAD
         d2XnliryPOqUvxARVv1oueoQjkgq351pGESh5iP3h7WGDicj72V5jiYiJwFLDHdRUZtR
         4VuK8E75BQ1KVgI8/Wy0b+FxhdbvpuFjTpPjU9d6kOzNNgrabCEe1gpIfx/iSYTKoP0t
         yqqP6mKK9t6OrayyP3Xp7MBs/2KJe12TC8YcsdWCDJyIvrRU5ebzQFlKOBB7C0IlGyA9
         qCTk66nhPWDzO1Xg52Zj5K2xs7tn2ADMTAi8AmQ+ZNT/xgNj9g8Mc7ibxUngRPUsn4zL
         hQew==
X-Gm-Message-State: AOAM532Y0VJM8bKwQIjPBZyRwBqOctocYeLJurWkRTONXoJXr5zJXihg
        +HztWCfmJUNQOvYX0DQzpMo=
X-Google-Smtp-Source: ABdhPJy33XCCwrH6FQYKtkPcqctQEtJ/D+MhJRTW/U1KLGtthMgsWI0Tpo3VWe07SZePvCe/6l4sZg==
X-Received: by 2002:ac8:598b:0:b0:2f3:371f:7c2 with SMTP id e11-20020ac8598b000000b002f3371f07c2mr6644462qte.485.1650727448784;
        Sat, 23 Apr 2022 08:24:08 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id y6-20020a05622a004600b002f33ba280cbsm3184165qtw.8.2022.04.23.08.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:24:08 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/5] PCI: dwc: rockchip: reset core at driver probe
Date:   Sat, 23 Apr 2022 11:24:00 -0400
Message-Id: <20220423152403.1681222-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423152403.1681222-1-pgwipeout@gmail.com>
References: <20220423152403.1681222-1-pgwipeout@gmail.com>
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
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 22 +++++++------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c9b341e55cbb..d67ed811e752 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -152,7 +152,13 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
 	if (IS_ERR(rockchip->rst_gpio))
 		return PTR_ERR(rockchip->rst_gpio);
 
-	return 0;
+	rockchip->rst = devm_reset_control_array_get_exclusive(&pdev->dev);
+	if (IS_ERR(rockchip->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
+				     "failed to get reset lines\n");
+
+	return reset_control_assert(rockchip->rst);
+
 }
 
 static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
@@ -182,18 +188,6 @@ static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
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
@@ -241,7 +235,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_regulator;
 
-	ret = rockchip_pcie_reset_control_release(rockchip);
+	ret = reset_control_deassert(rockchip->rst);
 	if (ret)
 		goto deinit_phy;
 
-- 
2.25.1

