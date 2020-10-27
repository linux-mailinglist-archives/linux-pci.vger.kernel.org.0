Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8266829BF22
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 18:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1814989AbgJ0RBH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 13:01:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39445 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1814994AbgJ0RBF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 13:01:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id x23so1078176plr.6
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 10:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TNXeOK9vUsEFI4JUtV4egM0DUSZSe3itu2u2LWkjX5w=;
        b=aEMqKfkT0Tl54TdvizwSl1oWEYp2e7iPH1MXyWg+e/USxQFZWVKLmrwvY8KHxKebWp
         2vB7F3XhieXq1nuljcqigZMG6Prc407PDbqs22U/jSHiU+XjxzBUYIOk7qJbPbQZHDXT
         lXdBwjmj0bylYMp9Kst2VJWpbmCa2XfyOWeOHucC6EpGsrLn1TWHPf2gdFZXfu4B+NDf
         L7SiUtqYY6IgS8+9OH8uGxdazQhJfcC0KHN/JBULOqLHzgO0JpRe5PAHdU1HwXsSKeaW
         c2zN2SXO0m4or2QyiYPqnXMZlsTaQBsMB5AJ+3i8IwkWPde/8moIlQ4Jinqfc68Aer/Z
         B07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TNXeOK9vUsEFI4JUtV4egM0DUSZSe3itu2u2LWkjX5w=;
        b=gbtZx1/27HLXE47Z1YtXzXhhVGfUGFpYf7uko5v7LWLPfOGsYuhDE5CgtlJzISo1Tn
         QAvnqmwRZI70A/AxZTVXy8zBAhdmXX9/rVNu978qkZ796efnMiOdXPS7uHu3kfFjKPNn
         ft+6oC8vOugGgm+MHYAyW/von40ClDHdz96uKGoH/qx1/SbavDL4k6t+sZhj2to/tS2o
         SPoO1T4jdiPZJPHXzdp8KI2T6p3NpYO7dGoCO+JLX938KQdRyfiUNgCmagqbjm0UnrB0
         BMEkNH0+lxc3sKAbqFJB5VPx8Zuhwm8yPYs2Wpw2quZS//+uZKXeeiZanNce7ibC0BpU
         xgHw==
X-Gm-Message-State: AOAM5301FwpCXCWBXGowPWrqA+ZfQeYWl+oRt23Lyb/gEM9AJ0iPnn27
        9rOOD5E1G7roD5OuJa4jUASG
X-Google-Smtp-Source: ABdhPJyOZ4ibdCvJDoC0wn94XkueSdlsSLkyR3H7ZyimeJWpRPkOaEZJfvK+VsuCRkMAUz3aomNZ1g==
X-Received: by 2002:a17:90a:3fcd:: with SMTP id u13mr2893644pjm.85.1603818064234;
        Tue, 27 Oct 2020 10:01:04 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id x26sm2845206pfn.178.2020.10.27.10.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:01:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        truong@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 4/5] PCI: qcom: Add SM8250 SoC support
Date:   Tue, 27 Oct 2020 22:30:32 +0530
Message-Id: <20201027170033.8475-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
References: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe IP (rev 1.9.0) on SM8250 SoC is similar to the one used on
SDM845. Hence the support is added reusing the members of ops_2_7_0.
The key difference between ops_2_7_0 and ops_1_9_0 is the config_sid
callback, which will be added in successive commit.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b4761640ffd9..0b180a19b0ea 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1361,6 +1361,16 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 	.post_deinit = qcom_pcie_post_deinit_2_7_0,
 };
 
+/* Qcom IP rev.: 1.9.0 */
+static const struct qcom_pcie_ops ops_1_9_0 = {
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
@@ -1474,6 +1484,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
+	{ .compatible = "qcom,pcie-sm8250", .data = &ops_1_9_0 },
 	{ }
 };
 
-- 
2.17.1

