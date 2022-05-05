Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A82E51BB99
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 11:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351957AbiEEJQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351970AbiEEJQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 05:16:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7013C4C787
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 02:12:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x17so6422444lfa.10
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2022 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymMSMm3WL7w52fT9eVEFUT5RZvNqF+HDIyYJzKaCqx0=;
        b=ZQFJYcC6WCt/nMgJnpwIxWL0UTOkaZGnA/HeKmHxNNd/QI9G84mwUkn0o138i/0XyR
         e+zdYYRoWDu6a0rIbA6SAmt4SCmQziJ9Es6szmjdr4QVBDC85BoLxKGp5YUEwjIJc5nW
         lLtqLCJXJecTZ4rLa91360RzE5IHVTUHzNSpJ3DvntvF45vfr1XcAY3iVcQspWwgvD2I
         F01cpfaVl1PYJ1m4VtaMuj/29COwKa7tZqQMlSJ/pJHOFfc7Aa9gwXQXvhNXnydSP3kH
         qOc8aDxPljFkcdUtqQGPgnhNYilzAhViOSgDMg4HlYpaoXh7slrINGqxABKZv7QYdPFy
         zs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymMSMm3WL7w52fT9eVEFUT5RZvNqF+HDIyYJzKaCqx0=;
        b=Nb1APqpIgHlsWsgZh8xfJBvJ1GsCDJyXt9BCz36pXd3esW73+w+RKSjiZX+3BvSJVx
         TVCO3DbcD7S1JkDAQh4lLTuMRxYVTgQ92Dohrx9EAn5oq+MKQMlnS5UGE4BZs2Hx+qEN
         PUuF9niz7uVRCvxlFF9VoO18Hyfd/Tcqtb6vM3x/M4ylHGN5Wf0C0bHVMeZ2606gDZ6x
         hYvLosWpNJ9CDnP4KPj5x1PHXcXGenxqwxKJUkuei95WwoZJcsNK/Z7Fb7X9fE/S1J5m
         R8Z4zPqkMf7mZ73PKrrMdjt2LwZeazW/olwhSwq6eh00HDTwhhzEismLYUv/8EJNda5N
         DuNA==
X-Gm-Message-State: AOAM531VQ3W21V07UazApQ9H2lo5YDmpfM10uqrCgnnMM3x31RmRVkUJ
        S7hKlWdA1Z/w8qugGNuFTIDqsw==
X-Google-Smtp-Source: ABdhPJxlzhrFp7noJQ5Ff8HR+uhjTLm1s1LyZ60YQNHOvl9yzhMqswcOgqJvyhD2F+NwW2kE744yaA==
X-Received: by 2002:a05:6512:ace:b0:473:cca7:a7fa with SMTP id n14-20020a0565120ace00b00473cca7a7famr2742983lfu.410.1651741955628;
        Thu, 05 May 2022 02:12:35 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v26-20020ac2593a000000b0047255d211e8sm133564lfi.279.2022.05.05.02.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 02:12:35 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 5/7] PCI: qcom: Handle MSIs routed to multiple GIC interrupts
Date:   Thu,  5 May 2022 12:12:29 +0300
Message-Id: <20220505091231.1308963-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
References: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
separate GIC interrupt. Thus to receive higher MSI vectors properly,
add separate msi_host_init()/msi_host_deinit() handling additional host
IRQs.

Note, that if DT doesn't list extra MSI interrupts, the driver will limit
the amount of supported MSI vectors accordingly (to 32).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 137 ++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 375f27ab9403..6cd1c2cc6d9e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -194,6 +194,7 @@ struct qcom_pcie_ops {
 
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
+	unsigned int has_split_msi_irqs:1;
 	unsigned int pipe_clk_need_muxing:1;
 	unsigned int has_tbu_clk:1;
 	unsigned int has_ddrss_sf_tbu_clk:1;
@@ -209,6 +210,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_cfg *cfg;
+	int msi_irqs[MAX_MSI_CTRLS];
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1387,6 +1389,124 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static void qcom_chained_msi_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int irq = irq_desc_get_irq(desc);
+	struct pcie_port *pp;
+	int i, pos;
+	unsigned long val;
+	u32 status, num_ctrls;
+	struct dw_pcie *pci;
+	struct qcom_pcie *pcie;
+
+	chained_irq_enter(chip, desc);
+
+	pp = irq_desc_get_handler_data(desc);
+	pci = to_dw_pcie_from_pp(pp);
+	pcie = to_qcom_pcie(pci);
+
+	/*
+	 * Unlike generic dw_handle_msi_irq(), we can determine which group of
+	 * MSIs triggered the IRQ, so process just that group.
+	 */
+	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+
+	for (i = 0; i < num_ctrls; i++) {
+		if (pcie->msi_irqs[i] == irq)
+			break;
+	}
+
+	if (WARN_ON_ONCE(unlikely(i == num_ctrls)))
+		goto out;
+
+	status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
+				   (i * MSI_REG_CTRL_BLOCK_SIZE));
+	if (!status)
+		goto out;
+
+	val = status;
+	pos = 0;
+	while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
+				    pos)) != MAX_MSI_IRQS_PER_CTRL) {
+		generic_handle_domain_irq(pp->irq_domain,
+					  (i * MAX_MSI_IRQS_PER_CTRL) +
+					  pos);
+		pos++;
+	}
+
+out:
+	chained_irq_exit(chip, desc);
+}
+
+static int qcom_pcie_msi_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	struct platform_device *pdev = to_platform_device(pci->dev);
+	char irq_name[] = "msiXXX";
+	unsigned int ctrl, num_ctrls;
+	int msi_irq, ret;
+
+	pp->msi_irq = -EINVAL;
+
+	/*
+	 * We provide our own implementation of MSI init/deinit, but rely on
+	 * using the rest of DWC MSI functionality.
+	 */
+	pp->has_msi_ctrl = true;
+
+	msi_irq = platform_get_irq_byname_optional(pdev, "msi");
+	if (msi_irq < 0) {
+		msi_irq = platform_get_irq(pdev, 0);
+		if (msi_irq < 0)
+			return msi_irq;
+	}
+
+	pcie->msi_irqs[0] = msi_irq;
+
+	for (num_ctrls = 1; num_ctrls < MAX_MSI_CTRLS; num_ctrls++) {
+		snprintf(irq_name, sizeof(irq_name), "msi%d", num_ctrls + 1);
+		msi_irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (msi_irq == -ENXIO)
+			break;
+
+		pcie->msi_irqs[num_ctrls] = msi_irq;
+	}
+
+	pp->num_vectors = num_ctrls * MAX_MSI_IRQS_PER_CTRL;
+	dev_info(&pdev->dev, "Using %d MSI vectors\n", pp->num_vectors);
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
+		pp->irq_mask[ctrl] = ~0;
+
+	ret = dw_pcie_allocate_msi(pp);
+	if (ret)
+		return ret;
+
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
+		irq_set_chained_handler_and_data(pcie->msi_irqs[ctrl],
+				qcom_chained_msi_isr,
+				pp);
+
+	return 0;
+}
+
+static void qcom_pcie_msi_host_deinit(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	unsigned int ctrl, num_ctrls;
+
+	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
+		irq_set_chained_handler_and_data(pcie->msi_irqs[ctrl],
+				NULL,
+				NULL);
+
+	dw_pcie_free_msi(pp);
+}
+
 static int qcom_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1435,6 +1555,12 @@ static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.host_init = qcom_pcie_host_init,
 };
 
+static const struct dw_pcie_host_ops qcom_pcie_msi_dw_ops = {
+	.host_init = qcom_pcie_host_init,
+	.msi_host_init = qcom_pcie_msi_host_init,
+	.msi_host_deinit = qcom_pcie_msi_host_deinit,
+};
+
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
 static const struct qcom_pcie_ops ops_2_1_0 = {
 	.get_resources = qcom_pcie_get_resources_2_1_0,
@@ -1508,6 +1634,7 @@ static const struct qcom_pcie_cfg ipq8064_cfg = {
 
 static const struct qcom_pcie_cfg msm8996_cfg = {
 	.ops = &ops_2_3_2,
+	.has_split_msi_irqs = true,
 };
 
 static const struct qcom_pcie_cfg ipq8074_cfg = {
@@ -1520,6 +1647,7 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
 
 static const struct qcom_pcie_cfg sdm845_cfg = {
 	.ops = &ops_2_7_0,
+	.has_split_msi_irqs = true,
 	.has_tbu_clk = true,
 };
 
@@ -1532,12 +1660,14 @@ static const struct qcom_pcie_cfg sm8150_cfg = {
 
 static const struct qcom_pcie_cfg sm8250_cfg = {
 	.ops = &ops_1_9_0,
+	.has_split_msi_irqs = true,
 	.has_tbu_clk = true,
 	.has_ddrss_sf_tbu_clk = true,
 };
 
 static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
 	.ops = &ops_1_9_0,
+	.has_split_msi_irqs = true,
 	.has_ddrss_sf_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
 	.has_aggre0_clk = true,
@@ -1546,6 +1676,7 @@ static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
 
 static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
 	.ops = &ops_1_9_0,
+	.has_split_msi_irqs = true,
 	.has_ddrss_sf_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
 	.has_aggre1_clk = true,
@@ -1553,6 +1684,7 @@ static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
 
 static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
+	.has_split_msi_irqs = true,
 	.has_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
 };
@@ -1626,7 +1758,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pm_runtime_put;
 
-	pp->ops = &qcom_pcie_dw_ops;
+	if (pcie->cfg->has_split_msi_irqs)
+		pp->ops = &qcom_pcie_msi_dw_ops;
+	else
+		pp->ops = &qcom_pcie_dw_ops;
 
 	ret = phy_init(pcie->phy);
 	if (ret) {
-- 
2.35.1

