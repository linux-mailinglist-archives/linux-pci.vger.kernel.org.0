Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7CD27EBF3
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbgI3PKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 11:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgI3PKV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 11:10:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A317C061755
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 08:10:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fa1so1118347pjb.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kodhvZn5R6qXH3Miy1fK2LaaLU5UR8lTwi5DfXX0o8k=;
        b=bRfKB1TBQF0Zs5/BjHyctMokrw/LmdzA4zDKY2eRThfhGEIOFUnoiiFbrHe3p7dxXB
         z6OUZqCW5gigN4F5ryLLsaDXQdI6WiYayWDWoMbzB5ArmrUPe5iL1R+6P8WCCSkZUx6d
         dwKcE8IhtB0wWMU5FqPC8TfKlRKahASvr7Q6NV1fowAWEpLUTc8B1NkhR843NeWG8cvw
         PFCJPdDTpGaN9RixOe8u8r8VHYhY7ypb3yZeHgslJxHmDFwNKemVMY65eobxOdfkcmr2
         NeLEoZOQdC960FuH+Zq4FKIe6P/BRTx2tZkNO6jX1RS7oNz7Q2C2D9gc/wvgqbdqWWTI
         EDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kodhvZn5R6qXH3Miy1fK2LaaLU5UR8lTwi5DfXX0o8k=;
        b=clqAGjcOJpwTYYcHqeqOLbh8x4MB8qjouzK0K1PQ3tliNxh7rWVcPu1mE9v4AZa1D5
         zneuP7F9Ltd5HoWi6MrFfISwL2u2FW9p1e8fuZV5jBDY9rBPwT9wbvtHarGCa9w63ZiK
         faTwFIIgYEh4YUyBOPXXWjM8ll/1LmMrceJa/QbpmejIcFNUySQLzbNhjzqf5rNGDwbs
         oKk++5PEQsPwxQ1iTLCChcNwleVivFtL7aTBf/dI9QK1n6Up4bK0mXCmzJmFfi5UfXXB
         WLgvfyI+bZsvqUvmMYVWQksj1tu9fKqf5OFvxj2BzWyucLBGZ536h+6j1VeLB46Z8JIS
         6kag==
X-Gm-Message-State: AOAM530cXWVx9u74ULn/geMGwemq6TVdAl0WZSDSN/fQxeXJ8ZUDcw4m
        rmqCnQFCXdCpf0KhDMUW+qVW
X-Google-Smtp-Source: ABdhPJxbLgZMGikcjUoYhxOgzVrOcMRbmpgZrAAm+5CMam33xdXKdxw41gEnewc0og2pNNUdhj2QUA==
X-Received: by 2002:a17:90b:1297:: with SMTP id fw23mr2394501pjb.184.1601478619773;
        Wed, 30 Sep 2020 08:10:19 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6004:2356:f1f4:5bc8:894a:8c50])
        by smtp.gmail.com with ESMTPSA id o6sm2456444pjp.33.2020.09.30.08.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:10:19 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 4/5] PCI: qcom: Add SM8250 SoC support
Date:   Wed, 30 Sep 2020 20:39:24 +0530
Message-Id: <20200930150925.31921-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930150925.31921-1-manivannan.sadhasivam@linaro.org>
References: <20200930150925.31921-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe IP on SM8250 SoC is similar to the one used on SDM845. Hence
the support is added reusing the members of ops_2_7_0. The key
difference between ops_2_7_0 and ops_sm8250 is the config_sid callback,
which will be added in successive commit.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3aac77a295ba..44db91861b47 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1359,6 +1359,16 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 	.post_deinit = qcom_pcie_post_deinit_2_7_0,
 };
 
+/* Qcom IP rev.: 1.9.0 */
+static const struct qcom_pcie_ops ops_sm8250 = {
+	.get_resources = qcom_pcie_get_resources_2_7_0,
+	.init = qcom_pcie_init_2_7_0,
+	.deinit = qcom_pcie_deinit_2_7_0,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+	.post_init = qcom_pcie_post_init_2_7_0,
+	.post_deinit = qcom_pcie_post_deinit_2_7_0,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 };
@@ -1476,6 +1486,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
+	{ .compatible = "qcom,pcie-sm8250", .data = &ops_sm8250 },
 	{ }
 };
 
-- 
2.17.1

