Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978C2612577
	for <lists+linux-pci@lfdr.de>; Sat, 29 Oct 2022 23:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJ2VNW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Oct 2022 17:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJ2VNU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2022 17:13:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166443DBC5
        for <linux-pci@vger.kernel.org>; Sat, 29 Oct 2022 14:13:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id k19so12077840lji.2
        for <linux-pci@vger.kernel.org>; Sat, 29 Oct 2022 14:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf0KxYjTQhZ9cbNoU3M+UcqCiaOWtVYPcdD8LAR9jPA=;
        b=cflMC47TZ7X5YbQYCR5l0NBpDM7eAliTgYbr2CYpxlmTJvg8EIRjF4KzeAAoC1lXX1
         Vv4KPPYSHILkMsrQAtXN7iepb4LBKw1B1E7TzPXKX4H1NT5fmAZSp+hpFhGNYcj1X/4L
         +iSGItHnVjiDfDVrkwFO55Uhour404p9NBoA8NKOeYFEq+wO+kxBIBW9qEpOpXEh/gsV
         Rvs9GAJ177EjufZ1zMuMBSOkDEqm1k+7nZ6Ds0MfA4sCEtQkfDRGB7LTF0+6NcF+PFcx
         o5RwebOc1Dh48BP6Lw7+W0ZxG3z0IpKXctSAWB6n8r3AScryGNl8VogOUMXnrt7zpHeB
         +sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf0KxYjTQhZ9cbNoU3M+UcqCiaOWtVYPcdD8LAR9jPA=;
        b=KPxmcYwsZOJCYQiCIaeTaJQt3+8bTkVKHrMZnh56s1ElbfocqdL1nXw4Plu8N7vkE2
         SuFksBsi4qxuVDaJItFR31pgk5KZyBT+X183I9SQESQUQgnkewmM86JNZN7YZWJKcDXr
         K5dgU9XnjLBq4uw8I7I5MfqJi/ul0zrCIEPlsb3YV62fN75q2pUWqRBWDD1NZ3CCrVcp
         dCfAbeye0tW0B4uJUmMcKutcoXxo/Cv0PYzErubqts7j0slXvdcj8Z72X0QZPdCcLnHY
         Z6huQQr2NHLOJ8+d6avXT84EED82NuaB4xZVlqnne2DyYsVoLTLG/vVubzMd3YPL2F08
         /AMg==
X-Gm-Message-State: ACrzQf39RcyeFt5eTS03KAt/Pi/kdOw6A1OCkmxKG+6TIyToiVnv1Yd4
        E5kbhBxhxJlIG+95XGQkfGPM/A==
X-Google-Smtp-Source: AMsMyM7l/N0xvNu9hRGVgz61/lh4twmbURpChBDXiV7OEaARn7oerZ3qWdG/cvas0usOReQZgAMbRA==
X-Received: by 2002:a05:651c:983:b0:26c:1c6b:8473 with SMTP id b3-20020a05651c098300b0026c1c6b8473mr2138417ljq.341.1667077997451;
        Sat, 29 Oct 2022 14:13:17 -0700 (PDT)
Received: from localhost.localdomain ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id j14-20020a05651231ce00b004a480c8f770sm433508lfe.210.2022.10.29.14.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 14:13:17 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 3/7] PCI: qcom: Add support for SM8350
Date:   Sun, 30 Oct 2022 00:13:08 +0300
Message-Id: <20221029211312.929862-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221029211312.929862-1-dmitry.baryshkov@linaro.org>
References: <20221029211312.929862-1-dmitry.baryshkov@linaro.org>
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

Add support for the PCIe host on Qualcomm SM8350 platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7db94a22238d..3404c737afba 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1750,6 +1750,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
 	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sm8350", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
 	{ }
-- 
2.35.1

