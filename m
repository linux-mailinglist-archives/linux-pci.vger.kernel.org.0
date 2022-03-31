Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C97C4ED155
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 03:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351946AbiCaBdd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 21:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiCaBdd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 21:33:33 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D5148396
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 18:31:46 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t21so19030017oie.11
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 18:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DaR3MwFp8bDqlwUMKw41JbUHj/I2OKstsngLkvC3fEU=;
        b=nR6ntNCh4/YAwUbhK2XuUXTQBF8F95GEVdVCBAlu5e1/zu2pXuFPiAqknf9j2X+mEC
         bciAcM17DbdUEAaR7zc27qebz+a2Z+EqjWa3xdxOmC9FV6cT+kZdibU0Cb57JJnIU3nA
         VTyTMjKlyMao2lNKvTAOCui00LY5xZir/rtz+ys1eu9u1rlWbjjo/Dlc1Cn3YTcQbnOX
         Pw64KTGFflLTOr/K+l091WVuxEhmvUw/JvX/0JRkcOur/nrPUZQ4nuNCfxR17oefO9QF
         8QJHV7ZkyvcSOH6EzB5303y85qkSb0h4RFW20PbIZoiqt4y/YFIpEjNnexkpomXhu5F5
         PiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DaR3MwFp8bDqlwUMKw41JbUHj/I2OKstsngLkvC3fEU=;
        b=4knri0e9lolcpJFE6c0zZcvPCMHmRO3XqFOp9v20/v33Y/Kpe2ATRFjiSzjXAYfY+8
         TD8MC/EtpXKNbYSU9vl0LhrM9lRYcs4iSIP+QLjIffIEwNQzeH+8Qjn7ObI9Lej+h/9m
         Ed9CjYQRUJX4VwRMO9Q8G43zpRqI9lRXuxEBuhGyJ8mJkIzryCypfo5CULn94h19jO9k
         bcsuJgETpYhtdW0qQgjW9Qg1fgYudLb5A3icUhqikpmoE/Y5oG4U3wPMOLocsyDbwavg
         reIUb/IJ2hARJI1K3c4uMNmuCPq4uEEsxEwwZ8K6o7+yPbQyfY/g/arDFP5zozJmPt5F
         m56A==
X-Gm-Message-State: AOAM531/tHuDTuae9dwwva6Ge0qslNXx09rTn0npQhtxM8gVd3/oYZWw
        Uhf1qQeKP99lLVHKVlJ1ecmsFNmTaXwUbg==
X-Google-Smtp-Source: ABdhPJwVKqtA54H4KDUa2wyQrVcmg6t+fr5bx1rXVdpddFUtYpR1NCwlFGbWwE7ZhZum3rbVXvEEOg==
X-Received: by 2002:aca:30c7:0:b0:2ef:8a54:c3c5 with SMTP id w190-20020aca30c7000000b002ef8a54c3c5mr1706517oiw.56.1648690305328;
        Wed, 30 Mar 2022 18:31:45 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id b188-20020aca34c5000000b002da579c994dsm11213153oia.31.2022.03.30.18.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:31:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: qcom: Remove ddrss_sf_tbu clock from sc8180x
Date:   Wed, 30 Mar 2022 18:34:15 -0700
Message-Id: <20220331013415.592748-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Qualcomm SC8180X platform was piggy backing on the SM8250
qcom_pcie_cfg, but the platform doesn't have the ddrss_sf_tbu clock, so
it now fails to probe due to the missing clock.

Give SC8180X its own qcom_pcie_cfg, without the ddrss_sf_tbu flag set.

Fixes: 0614f98bbb9f ("PCI: qcom: Add ddrss_sf_tbu flag")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6ab90891801d..816028c0f6ed 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1550,6 +1550,11 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
 	.pipe_clk_need_muxing = true,
 };
 
+static const struct qcom_pcie_cfg sc8180x_cfg = {
+	.ops = &ops_1_9_0,
+	.has_tbu_clk = true,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1656,7 +1661,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
 	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
 	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
-	{ .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
+	{ .compatible = "qcom,pcie-sc8180x", .data = &sc8180x_cfg },
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &sm8450_pcie0_cfg },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &sm8450_pcie1_cfg },
 	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
-- 
2.35.1

