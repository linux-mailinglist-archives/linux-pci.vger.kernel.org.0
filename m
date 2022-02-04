Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF14F4A9B3C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 15:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359416AbiBDOqx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 09:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359418AbiBDOqw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 09:46:52 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9763C061401
        for <linux-pci@vger.kernel.org>; Fri,  4 Feb 2022 06:46:51 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id i34so13174744lfv.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Feb 2022 06:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzC5HpXXFvzcL5JJCV5CdUQEBghebML7Iv4KymTKhB8=;
        b=LlGIDny/EA55TFhTg851oaeX/Cc2rlp5sH8x5ErTrCVjkOoFnHprVQhSskyc0WsbP0
         i3XSy8QyVmur4BxV5zsJUJvPXR/xxVl9dqgDr6wdVDeITooqBQ3qwiElkWdrPCWFwUth
         wxPPzIn7rZbppguWP8kSpVHvqiqI2zaSUM2PZFpmrjaIh1Tq9PzL7wGb5lkbpZgUmL8l
         rKU/fXTZqFRai9xvO1wsyo82Y60s9KFzJDoWvKkk9weK3YybJspeOoygJwTPMrO9fb6o
         /3BgI4swDEP49418dJGWI/MHb357wnFxTshltmkxLW3qXbK1QTBeXYd3/fuxCSDGL9Vg
         1eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzC5HpXXFvzcL5JJCV5CdUQEBghebML7Iv4KymTKhB8=;
        b=Cnp7Lr689oCS5p9Zp/GaupPeoc13iV8QKKYPNsf1lI7Kpoex9PcCaXQPUmmaZlNoQO
         sV0euQBpZqNzmLljUV5k6ZvnBg234gp6Ey1JdjyLQJaq4KM49MJ2HbmQsTdxKWnH3bwh
         2d3r925epgxVyggBEfJrNhQCVU5bewhy2ISq7WcQHkB8BsjEpqfpNp3WP8a8sEpG51ik
         26K5B3TLyer23D9PCOuELlqmIZaRyH2fbmgcyNOM0QfDtk9fY8fAYdHo/aUj+C2aEl9e
         DX5c9FJ3WsQozaA2YhnLqvUUFy5/CbfeL9nrQjswtiqEbA2d57+zBt9aBWCEIFpSFJqY
         VX+A==
X-Gm-Message-State: AOAM530GjffDFyPWC0X+ZLDYHuwCh3SRT+mg9AXBinI5Xjslpp0gyzKr
        NGtQLTKvfla7x9JlrSaF6p0eEsHHPrErsg==
X-Google-Smtp-Source: ABdhPJwH85C7W5XjVCD0eFeRNuAE+QO5chgMKHD7xvdHOMn4osYv7rYh9XU/+jZdVfTNIPjqUskARA==
X-Received: by 2002:a05:6512:308e:: with SMTP id z14mr2464804lfd.104.1643986009835;
        Fri, 04 Feb 2022 06:46:49 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y23sm348222lfb.2.2022.02.04.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:46:49 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 03/11] clk: qcom: gdsc: add support for clocks tied to the GDSC
Date:   Fri,  4 Feb 2022 17:46:37 +0300
Message-Id: <20220204144645.3016603-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
References: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On newer Qualcomm platforms GCC_PCIE_n_PIPE_CLK_SRC should be controlled
together with the PCIE_n_GDSC. The clock should be fed from the TCXO
before switching the GDSC off and can be fed from PCIE_n_PIPE_CLK once
the GDSC is on.

Since commit aa9c0df98c29 ("PCI: qcom: Switch pcie_1_pipe_clk_src after
PHY init in SC7280") PCIe controller driver tries to manage this on it's
own, resulting in the non-optimal code. Furthermore, if the any of the
drivers will have the same requirements, the code would have to be
dupliacted there.

Move handling of such clocks to the GDSC code, providing special GDSC
type.

Cc: Prasad Malisetty <pmaliset@codeaurora.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h | 14 ++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 7e1dd8ccfa38..9913d1b70947 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -45,6 +45,7 @@
 #define TIMEOUT_US		500
 
 #define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
+#define domain_to_pipe_clk_gdsc(domain) container_of(domain, struct pipe_clk_gdsc, base.pd)
 
 enum gdsc_status {
 	GDSC_OFF,
@@ -549,3 +550,43 @@ int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
+
+/*
+ * Special operations for GDSCs with attached pipe clocks.
+ * The clock should be parked to safe source (tcxo) before turning off the GDSC
+ * and can be switched on as soon as the GDSC is on.
+ *
+ * We remove respective clock sources from clocks map and handle them manually.
+ */
+int gdsc_pipe_enable(struct generic_pm_domain *domain)
+{
+	struct pipe_clk_gdsc *sc = domain_to_pipe_clk_gdsc(domain);
+	int i, ret;
+
+	ret = gdsc_enable(domain);
+	if (ret)
+		return ret;
+
+	for (i = 0; i< sc->num_clocks; i++)
+		regmap_update_bits(sc->base.regmap, sc->clocks[i].reg,
+				BIT(sc->clocks[i].shift + sc->clocks[i].width) - BIT(sc->clocks[i].shift),
+				sc->clocks[i].on_value << sc->clocks[i].shift);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gdsc_pipe_enable);
+
+int gdsc_pipe_disable(struct generic_pm_domain *domain)
+{
+	struct pipe_clk_gdsc *sc = domain_to_pipe_clk_gdsc(domain);
+	int i;
+
+	for (i = sc->num_clocks - 1; i >= 0; i--)
+		regmap_update_bits(sc->base.regmap, sc->clocks[i].reg,
+				BIT(sc->clocks[i].shift + sc->clocks[i].width) - BIT(sc->clocks[i].shift),
+				sc->clocks[i].off_value << sc->clocks[i].shift);
+
+	/* In case of an error do not try turning the clocks again. We can not be sure about the GDSC state. */
+	return gdsc_disable(domain);
+}
+EXPORT_SYMBOL_GPL(gdsc_pipe_disable);
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index d7cc4c21a9d4..b1a2f0abe41c 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -68,11 +68,25 @@ struct gdsc_desc {
 	size_t num;
 };
 
+struct pipe_clk_gdsc {
+	struct gdsc base;
+	int num_clocks;
+	struct {
+		u32 reg;
+		u32 shift;
+		u32 width;
+		u32 off_value;
+		u32 on_value;
+	} clocks[];
+};
+
 #ifdef CONFIG_QCOM_GDSC
 int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
 		  struct regmap *);
 void gdsc_unregister(struct gdsc_desc *desc);
 int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain);
+int gdsc_pipe_enable(struct generic_pm_domain *domain);
+int gdsc_pipe_disable(struct generic_pm_domain *domain);
 #else
 static inline int gdsc_register(struct gdsc_desc *desc,
 				struct reset_controller_dev *rcdev,
-- 
2.34.1

