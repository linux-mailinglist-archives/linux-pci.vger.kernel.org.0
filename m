Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A835F671B5D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 13:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjARMAd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 07:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjARMAB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 07:00:01 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729F7EE57
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 03:17:14 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso1224564wmb.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 03:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax0S1Mi21dQMczSaAgM0TaYM+PtE4awHpXsqNp1yeTs=;
        b=LVO8wtaTw/mwetQHWmbQRBGMm1Qwm1fXYLm1TMwUAF0rVno1eQ4vfawC8DHGgibq85
         Ca9IuilPgvfjwM7dPmJKpoLHPQ5t8tg1ITDXefjjYttak0nnHOVJG9bYNKic3uQ/NqaX
         rDj+UszO828Jvel8gZgKI2WU6kFW4aO3jcrlqQZC0VJXOQdRtpyGRr1ztBSyh8PQHE4C
         uTZftHL8faguXRqYtbMlMPdK4SIATcGt15ZsYErjJVPQpbyUtj9a72xHhQlotxaWS11n
         axniRJOKC1NJ3AElrqOKee4fpzy3vHCHRAb8wjQ09Q8ad1kg6+n9VfI0yXFnhEulGcNc
         bb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ax0S1Mi21dQMczSaAgM0TaYM+PtE4awHpXsqNp1yeTs=;
        b=T/BqJoyWyRmE0MYymabgBUthRRvUs9+zp3DMFrPTN8E8dJ9GSJtpgHYNqhhDbetqM5
         lHLFYW1ccpjWGIPkKiJO0mIijIDFbrZ5dnSIBYrh/i0nZ32vYrlZHtR5PIlYAVRoevCw
         phapFpVOPEAjUM0ZiP4zjlNHK5w66aVGcdieNYVNYGjfXbgZuc1quf1LAoJ+7AA4Mo0s
         dSh62XiPPJKiBhPYj0eUmI4N0QDBv0/eQnax1HMpLLpjK7omq7Ixw5h2Ql/k90Bz2FTM
         P6Nnt6ALLzChtVNKqeTh8xvWLMJtKS9Krx3MxlvnKMA7Y/q2grtwOYvN6KfSm/kjO3T8
         mD4Q==
X-Gm-Message-State: AFqh2kp+k52mNtKQw77ZdaSLQX4KfwNJ/XZg2jnhNfxWY0sfYwrlbZoD
        2In52s/wMNZrrm4jpMjyOetiRD11cPC5hbQj
X-Google-Smtp-Source: AMrXdXu/jsgeI9CfpoJSfBwQlQSHFQhbqZk8oQ0dhQ1qE3VJqvmj418GDaH2fhc0Fdp0lB7bGnPoRg==
X-Received: by 2002:a05:600c:3c8a:b0:3da:2a78:d7a4 with SMTP id bg10-20020a05600c3c8a00b003da2a78d7a4mr6183108wmb.21.1674040633455;
        Wed, 18 Jan 2023 03:17:13 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q10-20020a1cf30a000000b003d1e3b1624dsm1670998wmq.2.2023.01.18.03.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 03:17:12 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] PCI: qcom: Add SM8550 PCIe support
Date:   Wed, 18 Jan 2023 13:17:04 +0200
Message-Id: <20230118111704.3553542-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118111704.3553542-1-abel.vesa@linaro.org>
References: <20230118111704.3553542-1-abel.vesa@linaro.org>
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

Add compatible for both PCIe found on SM8550.
Also add the cnoc_pcie_sf_axi clock needed by the SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---

The v1 was here:
https://lore.kernel.org/all/20221116123505.2760397-2-abel.vesa@linaro.org/

Changes since v1:
 * changed the subject line prefix for the patch to match the history,
   like Bjorn Helgaas suggested.
 * added Konrad's R-b tag

 drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 77e5dc7b88ad..85988b3fd4f6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -182,7 +182,7 @@ struct qcom_pcie_resources_2_3_3 {
 
 /* 6 clocks typically, 7 for sm8250 */
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[12];
+	struct clk_bulk_data clks[13];
 	int num_clks;
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
@@ -1208,6 +1208,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	res->clks[idx++].id = "noc_aggr_4";
 	res->clks[idx++].id = "noc_aggr_south_sf";
 	res->clks[idx++].id = "cnoc_qx";
+	res->clks[idx++].id = "cnoc_pcie_sf_axi";
 
 	num_opt_clks = idx - num_clks;
 	res->num_clks = idx;
@@ -1828,6 +1829,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
 	{ }
 };
 
-- 
2.34.1

