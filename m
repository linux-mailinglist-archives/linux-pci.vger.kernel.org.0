Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC165E8E4A
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiIXQDO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 12:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiIXQDL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 12:03:11 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D733399D9
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:10 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c7so3091987ljm.12
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3e3cQ74Y/JA5vVePYbQS/YusMBYX3fuhrdntX7uBS3U=;
        b=KUvqDjmY6EuOVysiL1IAoJUyVxCGESqo2ysnLe7B2bagzto7dyFl72pP0ZiwwfZBkg
         qOTfaDBx65yV6LoTMlxegEUgK0O56I0ustInI0N6XtpfxjX7R7ogNyzsIuWOob0S6tsu
         elnFplzczGm9bzjvr0p2m5kMPrk6ti+if/OtNJsH0ikF8ynAU4jGWZWhl3z+dySKLTwX
         1PbjTcUy0Qnk/TtA9Wq031WMk78tFLHt95leoMpf7cr84+/8kPE253CNMD4fUfaLE6wa
         0PjQR5Ge0sTcvr1mUMrk9DiI8olFIrVokzLb8gX9LVoaBEM2+Husnkc/ned05NFE6vf6
         a/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3e3cQ74Y/JA5vVePYbQS/YusMBYX3fuhrdntX7uBS3U=;
        b=aimh6T/CwSBjUaRfQu4PAsOnzpYWFGRzXflP+TXSKOQuhYn59TGxk91kdoTImsFgCA
         +Dphs7dEsBSGYskdqtYMJlJRK7XVkbGGbiYI+bLPrlHczS5w+7dTjaw0y0D6fU/0eM7n
         JceWRHYirELiTAsvgDGQuEPfd5EN2u9WDMnLhTcIvJdB1HmZlqr52UAQahje+L40v5Wa
         jy9/pRyakFUZsX48jdSQ9Mb5y4kJwl74hXEn1LwU9baOA7W+QwXSeNR2QJ0X98nSu4Vz
         LaRxwUH59vEF7JbI8lRV7esuWIt3MMbPUSkMMh7UUtN8yYTUCK1CdDZQGn2WbxrHaUOw
         syPw==
X-Gm-Message-State: ACrzQf1COYJ/E8k9mGBoBFPywu8gkPz73NT1qGzwUJXFgSkzx7lAeaTZ
        h+oSoHnuqOs6RZB6wz4QdHKgow==
X-Google-Smtp-Source: AMsMyM5XQors/dq+7LJVGbMfHKBDMa+6z5wIeH38QsMBoDVJGocnChEF/rch6EwppsF29MaDYb65OQ==
X-Received: by 2002:a05:651c:2103:b0:25d:6478:2a57 with SMTP id a3-20020a05651c210300b0025d64782a57mr4779718ljq.496.1664035388407;
        Sat, 24 Sep 2022 09:03:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([95.161.222.31])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b00499f9ba6af0sm1928015lfq.207.2022.09.24.09.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:03:08 -0700 (PDT)
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
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v4 5/6] PCI: qcom: Setup PHY to work in RC mode
Date:   Sat, 24 Sep 2022 19:03:01 +0300
Message-Id: <20220924160302.285875-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
References: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
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

