Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232A75EBE7B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiI0JYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiI0JYQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:24:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C26DEA5A5
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 02:22:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a2so14764850lfb.6
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+cRD+CYxxlYh0TtwkYsk8VGD+YRN12siaZ7YI1JRdBU=;
        b=C+ikIGiHKrX2JWV6Ywhc5I8pRpcwLG1KuPK9+Gg9V+ciLX0Dip4q7RgKbBUirPd7dJ
         riaaUEyoi5mNaSPNfyMqWeCoue1QdN8UlvotASSsbjwjvrR2wAilVhfWX2z45ZrQJ/4p
         FCAgbaKe1t8q4D/GbnD6BlBEiw5XcDzviIJSeQlZHh/9ijSMUnOg/4RFrO6PZQF72Wxo
         haebmx3l+i+QUzNsm/isbYmaY/wza8HOwVX44vzjCKFSTNM6v7llYwCH92/qVE4Jg6ty
         KOZSkuNx/ULlCESmJ5y/+iWFc1S3NQmvydfH24pdL0Y3P10KW/mp45Di5i7NcKilFSRA
         0ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+cRD+CYxxlYh0TtwkYsk8VGD+YRN12siaZ7YI1JRdBU=;
        b=D5aBKONcXYNmGgGgLd09QFzNvla1FieAFEHCbz82LzVgmGDNh397yt4nnyDoB76Lru
         /wnLm9ZVRLXviDj2onU2vqc339X5HtZ0CMxr9aH0FLNZCz67I3VHJ716mtaeBMLPptkp
         szeCOzUoVspQfSBMbUoKc3031mOoa8QoJrZ+hI2do0lbu3W9yMiPwOaTKT1IUNzNZKAQ
         2WaTx9DmJinqTT7cRS0zoTMWbXomRXSfVU6KASUAEkTRa1ZzBM8aMvs2N1/PrXby6sXe
         efxOh/7VDH6LO0tEv1wD4fIz9jFTY4NtUC2FK0OhF/f4mDpWbfOKglIeg08UJsbeoBNt
         MR4g==
X-Gm-Message-State: ACrzQf1/tYpQjg4/nRcu5v/ZNJT5dcuw+7Xk0n4ONW96XlEcmWb5vWtR
        GFTgPs/dl0xKuDJI4rEBAyRtaQ==
X-Google-Smtp-Source: AMsMyM7dzWp7+3RxnEEZRbvsOsxHgCe3YxG7c2tkgPLG9OrgwrJ7+K09IWXwKsgU/E745SVrDqEhhA==
X-Received: by 2002:a05:6512:3ca2:b0:497:9db7:ec10 with SMTP id h34-20020a0565123ca200b004979db7ec10mr11480446lfv.350.1664270531318;
        Tue, 27 Sep 2022 02:22:11 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r28-20020a2e8e3c000000b0026c15d60ad1sm104584ljk.132.2022.09.27.02.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:22:10 -0700 (PDT)
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
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v6 4/5] PCI: qcom: Setup PHY to work in RC mode
Date:   Tue, 27 Sep 2022 12:22:05 +0300
Message-Id: <20220927092207.161501-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927092207.161501-1-dmitry.baryshkov@linaro.org>
References: <20220927092207.161501-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
used in the RC mode.

Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 66886dc6e777..1027281bd6ff 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
+#include <linux/phy/pcie.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
@@ -1494,6 +1495,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
+	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+	if (ret)
+		goto err_deinit;
+
 	ret = phy_power_on(pcie->phy);
 	if (ret)
 		goto err_deinit;
-- 
2.35.1

