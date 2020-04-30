Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E5E1C0A07
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 00:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgD3WHB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 18:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgD3WG7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 18:06:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59429C035494;
        Thu, 30 Apr 2020 15:06:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s3so6017667eji.6;
        Thu, 30 Apr 2020 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5qwOdOjBM0kR3h5Ux00+NLqsBpbJPVpfGyfoBvZ0KU=;
        b=c5CYdiZZeep2K6qtPUqzur442gkAeLpmaznc9LJNKtnDY06F+DPUTIgjpf+0VNDeEc
         WV41w4nGCCBTsAnaRozUjiWqtmYyufG1BADcu/c/Yoe3+5/2U44N87u+FghlfBGkkHML
         a2qc51oGITjmf5QQMmqZRip+7UdC5YyQhe2LxbBLesBgTLu73zkmd9sa2QHxriHG8+FP
         n54Cy99LdxFGl35iKumefOEkTEkIqK0AAiZ/Th664L7KXr7pcTYHVfjuZqye9s80VCnf
         TivfTQTuisO3pn4ncaCOJJRHM0pprwhqKohaCrE8fBqQWsFDQ7aajqDHyKSOttcKd2Dn
         Tvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5qwOdOjBM0kR3h5Ux00+NLqsBpbJPVpfGyfoBvZ0KU=;
        b=adpUytGkKUTV9V9xd46liMfPEQDMmPB5am+hoE22IvNOVxUNs5ZyShsQhCQUFzRxZ2
         hgFuwhnb1Qfs1FuaZJBhVBA8m9tS3Wj6/GNPbYbZTEsMqeMHT0Ps744pEn3Ty3YaExuv
         LYrRExvNFeDf6LKYw0zOI9n7EVb1JxeBsgiMxjjztCCcqi7AgxwOV/XC7DuByoDhgTqQ
         u7mVW6sxuN1JFRWbhLtvdGYM/mToYHXeKmEPN9DzxFRELBTdzV8jlk9b96g8KoN5wvYR
         8aRQPkLhBqVmTFvoXTgB8XPmeq2UtQGF6g5ehzLwP8JlGmCCwRiPcG2OdZ4jPZlToxAi
         0dAA==
X-Gm-Message-State: AGi0PuaOQWG9k7MqjUQzO5yAbmj+L3wR0HHtDbglMFpth5JFZaaH3A1p
        hLxL94zMT/Qcn/X0HthvMzA=
X-Google-Smtp-Source: APiQypLsfhnbzhYBF4ojiBpUSjb/Wnjy30KMuPcOEgMymuyUa0nQMhfoim7Tbvd/6YROw9VY3sQqMA==
X-Received: by 2002:a17:906:1199:: with SMTP id n25mr623646eja.30.1588284418018;
        Thu, 30 Apr 2020 15:06:58 -0700 (PDT)
Received: from Ansuel-XPS.localdomain ([79.37.253.240])
        by smtp.googlemail.com with ESMTPSA id t17sm54185edq.88.2020.04.30.15.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:06:57 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sham Muthayyan <smuthayy@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/11] PCI: qcom: add ipq8064 rev2 variant and set tx term offset
Date:   Fri,  1 May 2020 00:06:16 +0200
Message-Id: <20200430220619.3169-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200430220619.3169-1-ansuelsmth@gmail.com>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sham Muthayyan <smuthayy@codeaurora.org>

Add tx term offset support to pcie qcom driver need in some revision of
the ipq806x SoC.
Ipq8064 have tx term offset set to 7.
Ipq8064-v2 revision and ipq8065 have the tx term offset set to 0.

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index da8058fd1925..372d2c8508b5 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -45,6 +45,9 @@
 #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
 
 #define PCIE20_PARF_PHY_CTRL			0x40
+#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(12, 16)
+#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
+
 #define PCIE20_PARF_PHY_REFCLK			0x4C
 #define PHY_REFCLK_SSP_EN			BIT(16)
 #define PHY_REFCLK_USE_PAD			BIT(12)
@@ -118,6 +121,7 @@ struct qcom_pcie_resources_2_1_0 {
 	u32 tx_swing_full;
 	u32 tx_swing_low;
 	u32 rx0_eq;
+	u8 phy_tx0_term_offset;
 };
 
 struct qcom_pcie_resources_1_0_0 {
@@ -318,6 +322,11 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->ext_reset))
 		return PTR_ERR(res->ext_reset);
 
+	if (of_device_is_compatible(dev->of_node, "qcom,pcie-ipq8064"))
+		res->phy_tx0_term_offset = 7;
+	else
+		res->phy_tx0_term_offset = 0;
+
 	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
 	return PTR_ERR_OR_ZERO(res->phy_reset);
 }
@@ -402,6 +411,11 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	/* enable PCIe clocks and resets */
 	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
 
+	/* set TX termination offset */
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL,
+			PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK,
+			PHY_CTRL_PHY_TX0_TERM_OFFSET(res->phy_tx0_term_offset));
+
 	writel(PCS_DEEMPH_TX_DEEMPH_GEN1(res->tx_deemph_gen1) |
 	       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(res->tx_deemph_gen2_3p5db) |
 	       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(res->tx_deemph_gen2_6db),
@@ -1485,6 +1499,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
+	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ops_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8064", .data = &ops_2_1_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
-- 
2.25.1

