Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDCD5EBE7D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiI0JYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiI0JYR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:24:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE271176CC
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 02:22:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j16so14813632lfg.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6MXcrTEBzn3PtKMuZkuMSbhXg60T5nB8HdxL6gRaNJQ=;
        b=ghNM3R6nbsJI58kBHKmDE1ecT1LfytZJ6l68ErlWHjMCN8lsh3va7+fki46hLMUhRl
         BVpRQLIU9rrvDSMyTeuB5/vrlJDszWXRli6pimDlF6qCxtMB150NGbYjfSSnklBg1blx
         Evj6qKxfpanUTmFisyJ4RurL16mOCW7SwJan/5JSrxopVLqpAzKdJDrUdLIdDd+g/dJj
         AkUvlwK55xtO8ryMDmtKLzDHx6yf/rKBalkfaxy2zEDbvOZxsJV4v/9rDW5Ts0ykdSe1
         TqFUaFG9TZfVRbclti0d9Cr3NoeW7cQ1D6/Ia/oWNbZ3uUKTYu2xHgnL6y1X564gvlmE
         VLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6MXcrTEBzn3PtKMuZkuMSbhXg60T5nB8HdxL6gRaNJQ=;
        b=HW8VEkCjgl2/bXbiu64MrlVW+OqvQX5viL9CQGBmc23kv/yKbhpfECOTytm9OSAFGM
         hRAaSatIF1nd2xfCRMKkg8SSorlxxTo4lcnKxvxRHckkIZWRXcrRYMFgHzZWDFf2J059
         8hNIWJzFmic14b9agrJzv+bfXzyfxxZTV4RDlrKVl9MpD+1MZSGDwaOTgFHth371651d
         Oy2iT0X3i41jOYTf0+BHZsehfURgO3unNZ8niW9VcPnjv2aZj9wnM4cvfSiNcqh3c/JO
         yYQ+L1fS22HqyubTA3wXgiYuVKpaAS7Sn3AoJItDc5c3u1i2nRggRunScpp7ctrn9hbZ
         O2Xg==
X-Gm-Message-State: ACrzQf19dGZDejs7XffHeLTNdHDIKnYzJ7+aTzhDW/UpwUqW/0d/SnvE
        hVUOTASmWgNq7dpRS/xqz3VKzA==
X-Google-Smtp-Source: AMsMyM52N7sJFQBxxVHOh+MEUqK2aorbxXfmfvY3w+odcRjksF/rgtgwmYbZcyqD6w8BJjM4QTHwMg==
X-Received: by 2002:a05:6512:6c7:b0:49f:5491:3330 with SMTP id u7-20020a05651206c700b0049f54913330mr10613565lff.197.1664270532210;
        Tue, 27 Sep 2022 02:22:12 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r28-20020a2e8e3c000000b0026c15d60ad1sm104584ljk.132.2022.09.27.02.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:22:11 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v6 5/5] PCI: qcom-ep: Setup PHY to work in EP mode
Date:   Tue, 27 Sep 2022 12:22:06 +0300
Message-Id: <20220927092207.161501-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927092207.161501-1-dmitry.baryshkov@linaro.org>
References: <20220927092207.161501-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
used in the EP mode.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index ec99116ad05c..8dcfeed24424 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mfd/syscon.h>
+#include <linux/phy/pcie.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -240,6 +241,10 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	if (ret)
 		goto err_disable_clk;
 
+	ret = phy_set_mode_ext(pcie_ep->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_EP);
+	if (ret)
+		goto err_phy_exit;
+
 	ret = phy_power_on(pcie_ep->phy);
 	if (ret)
 		goto err_phy_exit;
-- 
2.35.1

