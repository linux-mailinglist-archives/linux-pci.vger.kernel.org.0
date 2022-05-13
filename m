Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A633526080
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 13:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379682AbiEMLBG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 07:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379678AbiEMLBF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 07:01:05 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A3329C91
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 04:01:02 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g184so7193612pgc.1
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsD7LJRkuECyYX1jGlfTiXHU1Ijh0jPTLQ2k9fUhrL4=;
        b=QiA79YYEX5J9Cz/ubTy3uRnX00TKZfSieKIylSPlqoMh6cybvG0v6NWiRbpuIbSfd4
         Sg6gFMhz4XRhjovPrMvP4JHa9cpy1RtHVD3W8ZH5nonlK8GBPfG8TZM1Oigbjd8ktjPu
         I5ajvo1NSSx0d6NQj58DvBg+rOuoKgiDFSFGVMJLmenRCGPLdU/EjXWFZJlTcNUvWUK/
         4nvf5UFYfVAZPPDC1sApcVOtsIfEl16Wn32QPMG9AxzU3sBwVPoi6wTjYWscLKHSqWCF
         GJjkosFZBfUJYOhl5VXrovgcrSniLe7jdBcmGv4ChD7xvrbSJSnxKcsgLoV67XeoRTD/
         4gTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsD7LJRkuECyYX1jGlfTiXHU1Ijh0jPTLQ2k9fUhrL4=;
        b=SrbjBstUuH/R8HyrNUf8xuZBoX7vBifw08/ZxkK030E8UuFOQUo/yNvl5+XJx72Huz
         YcDmnmT9PgHJS5pAAeX0UgzDTWaXSDLnRs32z/7GeWNRV7ct5j6cSX/FLNGMQHQQ+okF
         kB4c4lOShJGJlAM9dh9lSI03oRila49XJgJW7Jt4gt8UxpLdeuysJB+JeWeTUue6vWiK
         IPmm5HG+QQE2E04SU/G5OmsO1p6x+wQLSpOAoNUeul0Eg2DfLKg4B7D92uMjO0wuhKd+
         Jeo6CwKhq8NRWhZfxbI02op+3v5S8hrt17u0zYilyg/uZ+Taos9aFGIBCY2YV7c62wZ3
         e+fA==
X-Gm-Message-State: AOAM530rCXRM9xNE0GyTvgr9owx60N2GKzqmN8r6hOZIGxcrFe35SG8T
        fw/frqDdUG93hgIH5vNYsDyPe1z/6JNK
X-Google-Smtp-Source: ABdhPJy6supPwd4jHaESPrjZJsyad5J2wl3TDO2EQ8PzZO62JGRs3jBDxNtnqMckk0JHMD7+cNctsA==
X-Received: by 2002:a63:8143:0:b0:3da:eb5e:2833 with SMTP id t64-20020a638143000000b003daeb5e2833mr3514458pgd.426.1652439661640;
        Fri, 13 May 2022 04:01:01 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id u36-20020a631424000000b003db0f2d135esm1322120pgl.49.2022.05.13.04.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 04:01:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] PCI: dwc: qcom: Set suspend_poweroff flag for SC7280
Date:   Fri, 13 May 2022 16:30:26 +0530
Message-Id: <20220513110027.31015-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
References: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For aggressive power saving on SC7280 SoCs, the power for the PCI devices
will be taken off during system suspend. Hence, notify the same to the
PCI device drivers using "suspend_poweroff" flag so that the drivers can
prepare the PCI devices to handle the poweroff and recover them during
resume.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6ab90891801d..4b0ad2827f8f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -199,6 +199,7 @@ struct qcom_pcie_cfg {
 	unsigned int has_ddrss_sf_tbu_clk:1;
 	unsigned int has_aggre0_clk:1;
 	unsigned int has_aggre1_clk:1;
+	unsigned int suspend_poweroff:1;
 };
 
 struct qcom_pcie {
@@ -1220,6 +1221,10 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	if (pcie->cfg->pipe_clk_need_muxing)
 		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
 
+	/* Indicate PCI device drivers that the power will be taken off during system suspend */
+	if (pcie->cfg->suspend_poweroff)
+		pci->pp.bridge->suspend_poweroff = true;
+
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret < 0)
 		goto err_disable_regulators;
@@ -1548,6 +1553,7 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
 	.has_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
+	.suspend_poweroff = true,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-- 
2.25.1

