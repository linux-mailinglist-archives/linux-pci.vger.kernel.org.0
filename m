Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010E11F589F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 18:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbgFJQHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 12:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbgFJQHc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 12:07:32 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46052C03E96B;
        Wed, 10 Jun 2020 09:07:31 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x1so3191278ejd.8;
        Wed, 10 Jun 2020 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qi0pxCVqozd5V1/C140EBqHG2/fFl/8biYimGdOF39g=;
        b=OYhJZqxKYA02dv6FrmtRjRZ5PVMcx69+LOjMfMNO6kvnu9s+9LV2VXORjr1baHlNNF
         WNkLegfe8tOXHpSiG7q939NUdgv4jU90JqIaSrBOWHBi9WLqdnYjyW6WtDXqG3Lw8hST
         OYQ+BA2lokhOYpZbKJuqpsdT2poLtJ1BRE4rxM6drdmocKRdTko1UWgWz8qm5oa5ODuO
         uO4apqF34m0z+oQ1sZ99kBFM8Gk67N10vYtXzVGz9z43piSPYDaOXtwj4qQcw0RSISxR
         Q4VxuIAlbAOTgOBwxSDdpAQa/Ikbd9zj1W0KE56TDTR1+oWuHHVKJLbyiqPT4Ceu611D
         +wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qi0pxCVqozd5V1/C140EBqHG2/fFl/8biYimGdOF39g=;
        b=imVSph0AKkNFQzOBdgAhzlkYV0XG7RfYJKksx7LMfnZYBeWz7+xhJnqDzsK4+7AxS5
         OmYPaw0h+vvj9Hql3YjuwhbzstY6PZUnzDK0mZrTHKgPeQy/A4rpGfGBUSo6V2bv0rmD
         kR8h3mSSUD/NobQjdbBfDflxhtAneu6Wd4xmKvM/n/yndc6WW0PmPauV/Yf8RuPLzzyH
         XYIGH0yW2RtayWHXxp5V199P8o9cBa7xbWxqX2/qrc1+AafMd00uGj6qb1yOlFF4lAld
         n+RafhahEK7c1S6dH51wegVon+y1/Eka37+PPu2AOR/k4Iz6eESthxIetEgexS3dO5Zv
         Vmww==
X-Gm-Message-State: AOAM532gb0Xvci9OjXNbrxEXxjlTCQm4cboIeop6+IIc75c3BwkA8B6e
        PcKQiwPM6H2plZA0w/ApRxE=
X-Google-Smtp-Source: ABdhPJweC2I3mf2asfrT9CsXI7pjIQzvJIPWLQbk9FTXXsWsuD9GKAhuuni9YKsES2kuEdxtq6EzZA==
X-Received: by 2002:a17:906:480f:: with SMTP id w15mr4069195ejq.430.1591805249894;
        Wed, 10 Jun 2020 09:07:29 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-35-249-242.retail.telecomitalia.it. [79.35.249.242])
        by smtp.googlemail.com with ESMTPSA id ce25sm56067edb.45.2020.06.10.09.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:07:29 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/12] PCI: qcom: Add ipq8064 rev2 variant
Date:   Wed, 10 Jun 2020 18:06:51 +0200
Message-Id: <20200610160655.27799-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610160655.27799-1-ansuelsmth@gmail.com>
References: <20200610160655.27799-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ipq8064-v2 have tx term offset set to 0. Introduce this variant to permit
different offset based on the revision.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2cd6d1456210..259b627bf890 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -366,7 +366,8 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	val &= ~BIT(0);
 	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
 
-	if (of_device_is_compatible(node, "qcom,pcie-ipq8064")) {
+	if (of_device_is_compatible(node, "qcom,pcie-ipq8064") ||
+	    of_device_is_compatible(node, "qcom,pcie-ipq8064-v2")) {
 		writel(PCS_DEEMPH_TX_DEEMPH_GEN1(24) |
 			       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(24) |
 			       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(34),
@@ -1464,6 +1465,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
+	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ops_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8064", .data = &ops_2_1_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
-- 
2.25.1

