Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FE25A0E70
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbiHYKux (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 06:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbiHYKuw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 06:50:52 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B839AB065
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 03:50:50 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x24so954060lji.9
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 03:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ODOakmbW0+n2i2GvoUEmLl+J2Ch890Gy790ZhnYDLTw=;
        b=qztsMtgT1wzs9IBxp8KllDV6N6DQ9s1Dh4UVbMo+CqncvN3C+/bpnYuiqze9HegQbf
         Ebq8mTYuXJeREzMF3QwsR6cMCwNssnbCflaR8xF5G4iLcfT5egUA3Shy06XKZX4pRoOk
         iOyGZT/ZboLmKYNB+Lw5PAchh7/sixD3a/AjZj1SVJvbKplAipOGb0iZSbYNjXDcUBL4
         zYySLLXJWiGDlFlg0KKdvn+QJL86zwhair3aVvbLfEfJ7M2nQK/ydiCgxpdFszPBPKXo
         RfYACLYmWnxXfHhr7kmqnHbnuVQgd5GOyohwfjyN/PEPaum/VaVEV4QIT9XUVnRdqnL/
         zHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ODOakmbW0+n2i2GvoUEmLl+J2Ch890Gy790ZhnYDLTw=;
        b=PRIQwPwebBPkyN6s9a0vkurCp/EzWfUHFlnHkAZfDpG2H8QP3Y7N1tjMvOw5WX6uC0
         PHk6OVZCdbRafYUYoMOn4csjI5h0WtozodMTDnOjMgO8C7NTUNGbyTFh9ZSR/50MAsg/
         AI/EJCl8BDvNx6gM2dFlCwFJvmUVVIRfmDmJ9YU5VzYzSqbkPDvrlcBKx/znE20HwKnW
         6xf41Yg8RUoYz8WOWUjY9U1og2RiW4OSsb9UyF8aW+rl4KfHuOD70Ij2gcA0GKsr3hwe
         a5At9xS6pzGTwjqsaOeRikv44u3eq7WKZmJP97ZrL78Th+s+cCZXwQ9i3qbDYfa76xic
         y6Ug==
X-Gm-Message-State: ACgBeo1WzvAg19E2P4ml+WsCZDa81qbnahJqaItAZSw96+wcpNjsO2Wp
        lWa7dtYzgzYqykYeX0owFh7uGQ==
X-Google-Smtp-Source: AA6agR4J4vK0+tsAWO8vmP25IubvCpc025cbMjdERrbKm4KnEOwHYvG4qdmVusGqtz3gfFXX2vmtJw==
X-Received: by 2002:a05:651c:905:b0:25e:67a8:4dd0 with SMTP id e5-20020a05651c090500b0025e67a84dd0mr1028364ljq.232.1661424649936;
        Thu, 25 Aug 2022 03:50:49 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u14-20020ac258ce000000b00492f49037dfsm429609lfo.152.2022.08.25.03.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:50:49 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn@kryo.se>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v2 4/6] PCI: qcom: Setup PHY to work in RC mode
Date:   Thu, 25 Aug 2022 13:50:42 +0300
Message-Id: <20220825105044.636209-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825105044.636209-1-dmitry.baryshkov@linaro.org>
References: <20220825105044.636209-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
used in the RC mode.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 66886dc6e777..79dcb1a22f53 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1494,6 +1494,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
+	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, 0);
+	if (ret)
+		goto err_deinit;
+
 	ret = phy_power_on(pcie->phy);
 	if (ret)
 		goto err_deinit;
-- 
2.35.1

