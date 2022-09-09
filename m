Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C7E5B3340
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiIIJOv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiIIJOr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 05:14:47 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4172CB49C
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 02:14:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bx38so1062155ljb.10
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PvsPfs87gAZRtOiASIB84lPgqC16e4BE5MitB4Ro4vE=;
        b=qov3whUhdo38OXpooMvsX1Qs5OGgXc9voMg70wTfWwKAeYXuMOzVJP59tls7WUZT4o
         yNSY/b3JCkFuDLjapEA04zIKStUHyTIQXFNjaGPqNKtHHXhy7RdVYK9Z2cAY8kQ8uAWC
         S+Jfq5n+9ITLUFWupmSGndRDue4k7EAxgzaLgkL3G7EzsvrawncdOlACledd5DPz0GR9
         yuyyG57PV/vmJcWrt0xIOGXYLvUoDK+/q0oi9JeqhscmZQykY6wF461SvOGzT6NGrhay
         byEpztXMfnAZXAXa0spWJQXc/Tu5cYU+EoMiv/FkGMciNZabMc5R2OKAk8C0NSAeu1A+
         Buzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PvsPfs87gAZRtOiASIB84lPgqC16e4BE5MitB4Ro4vE=;
        b=A7qNDa1dOuqkuXezYVciosaCZZoXjf086GVjaRLoDGeyN9ejrHLH1twLQJuy2Nbnhf
         gP5o2TM2dwGYfUYHFD7DxFr0P7kuBxqJTWxymqZxQO3fz43fo9WkpZVX5ozPQ5DEIBdi
         dYtI9WnSE4Cl2S+oq3ugWoBbSSO9EKvobC0nqs7+hNvf4ON6bZJ/h/8+UdHZnSS/jkeS
         ZE/5KxjVBrNC6FFgO1Y10HXCQ/9DhP4dLnYGEM/TRXLqmgucIeK1GtXvHPW8MwdiJjn1
         pTDABHu6D5L8xMpbTb1wAX8WcsKTwMKbZE3KwoYNT+FNG6KHk2SHT0oQ4e/5EBu/50Zq
         T5mQ==
X-Gm-Message-State: ACgBeo2dL3aVbgNPXcGz06RBrthkBE+ZeoQV9mE0fAWyCKPaRzLoYzZE
        gWZfCjYBHMRFgikaGB1TbDYZ2A==
X-Google-Smtp-Source: AA6agR75S6PFVot6XvjnyH/8hBrHN0ULhCBT2BAci0nWMcNKGTb/tnio5QwNlbUYevghrsdy1lQOBA==
X-Received: by 2002:a05:651c:1cd:b0:261:bef9:ada8 with SMTP id d13-20020a05651c01cd00b00261bef9ada8mr3560707ljn.387.1662714883259;
        Fri, 09 Sep 2022 02:14:43 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e4c1a000000b0026acbb6ed1asm201615lja.66.2022.09.09.02.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:14:42 -0700 (PDT)
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
Subject: [PATCH v3 8/9] PCI: qcom: Setup PHY to work in RC mode
Date:   Fri,  9 Sep 2022 12:14:32 +0300
Message-Id: <20220909091433.3715981-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
References: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 66886dc6e777..32d58282bed0 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1494,6 +1494,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
+	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_SUBMODE_PCIE_RC);
+	if (ret)
+		goto err_deinit;
+
 	ret = phy_power_on(pcie->phy);
 	if (ret)
 		goto err_deinit;
-- 
2.35.1

