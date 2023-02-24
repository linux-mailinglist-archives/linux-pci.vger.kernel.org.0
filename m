Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F916A1B07
	for <lists+linux-pci@lfdr.de>; Fri, 24 Feb 2023 12:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjBXLCG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Feb 2023 06:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjBXLAz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2023 06:00:55 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107F966978
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 03:00:17 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso2292835pjb.3
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 03:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDe2OfCLNRaJ6CRURKr3KlmzCsataxU7y19XTJRsk+A=;
        b=fAJqvN5f5O1suKMbMKyZTKUOuQWDy9CpZJalOaBD5HtdbClkBc2Y3mQktVEXsKIkyM
         jqwulwTPo0TCvEOim7vshccXaA0Rf0Y9DXxoEyVsK6j4qZBAOBZHZiAZh0/FPdl8b/6t
         99/G0hP6iYZ4siN6USBnUOzHhXy1eq6v4rBhHz+L1jWHVYaknjNut3fHZGmnF4uuf8bR
         wpflaqZ3v5/cyV78xkdj4tw+GViopd/zJBAxU8ZdPbKO62vSoEb1Mc10BxaZZnmVKbUe
         7pNqc3ZJQdBJVjmXt29Ew9KoAUfYslHbLyuSOn82oi52m3xc0zy0oxh6RKvsx+uXM0Us
         l8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDe2OfCLNRaJ6CRURKr3KlmzCsataxU7y19XTJRsk+A=;
        b=oLihPTGe+bd/dYBA1/EOwlJFR6pgUZXlL8s8h+qfvssuMtVCT0spb4hk6Pz61DUQN5
         goilteFoGw5E9ySR6thvjc7klCGRd45cnh6H1qa5pReF9nEK+C/aqK32fTZ4ShxEdY7f
         RGJRtBxgue5VvWiEgIVRzYrkatwjX1VQTjxQivAHuWBNAc1Biv/NmTskumcAYbn8N0oJ
         Udbk6GsSKQvqPopYv+6g8ErvZV9QPEp9ZnVr/aqN9iJA43d8rwGEQrJ/cGbehTXu4vAu
         wtGI9rlPdvhQlWgO04IPc9xBbBIwL3KkteFTrzPhOGIQFcVQNb2xom35JbvYmeXKUBGo
         TaCw==
X-Gm-Message-State: AO0yUKWTUhwR7M58pFiJQXbBJkBdMeEVgyQ7VVKwt8duqr+O7BwQK/Dx
        lnbNeiREvEw6TS5G2u2oaJa9
X-Google-Smtp-Source: AK7set96B4clo9yI/CAFFJdJQ32pbl2Rs/s9/H+2kiiR3ogiFM6+s9/K/NGi2RuWUQxR38KPnofOuA==
X-Received: by 2002:a17:90b:4a4d:b0:231:284:ea4d with SMTP id lb13-20020a17090b4a4d00b002310284ea4dmr17736121pjb.22.1677236416420;
        Fri, 24 Feb 2023 03:00:16 -0800 (PST)
Received: from localhost.localdomain ([117.217.187.3])
        by smtp.gmail.com with ESMTPSA id gd5-20020a17090b0fc500b00233cde36909sm1263853pjb.21.2023.02.24.03.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 03:00:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 13/13] PCI: qcom: Add support for SDX55 SoC
Date:   Fri, 24 Feb 2023 16:29:06 +0530
Message-Id: <20230224105906.16540-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
References: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
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

Add support for SDX55 SoC reusing the 1.9.0 config. The PCIe controller is
of version 1.10.0 but it is compatible with the 1.9.0 config. This SoC also
requires "sleep" clock which is added as an optional clock in the driver,
since it is not required on other SoCs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 77e5dc7b88ad..659df73114dd 100644
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
+	res->clks[idx++].id = "sleep";
 
 	num_opt_clks = idx - num_clks;
 	res->num_clks = idx;
@@ -1824,6 +1825,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
+	{ .compatible = "qcom,pcie-sdx55", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
-- 
2.25.1

