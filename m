Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D841EBB06
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 13:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgFBLyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 07:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgFBLyt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 07:54:49 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEC3C061A0E;
        Tue,  2 Jun 2020 04:54:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f5so2816902wmh.2;
        Tue, 02 Jun 2020 04:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qi0pxCVqozd5V1/C140EBqHG2/fFl/8biYimGdOF39g=;
        b=Ea6DeRGE2KT1Qqmq3jiwAFlEKfxaL6cvAKSsaHQe0qJQJKriCeT6ufldt/bZNNjQfJ
         yQ/nFOzxOSkLPtd7MeLQbasnO/Ck/x3m0jqSQPJgn5EHOOh0qKKPtbC3utC5WizyuhT7
         80TdFRe//3FOefXmdyUuSNvzt+Hm1sOd4bwyWNJ70Pm/qRLu9qiiJvGgiJUapWS5K4NU
         tawisumfIJXZVQHThtq/lsh1u/Ws/Hgj9dapHg7keed/rX80KuhSl9X29JTO7Lo1hbVA
         X8pH6Oh2uajXysk7IF6raUA7/HmmPBKC8Invr9dvqy4Ii2cbxs6kRLVHs7CfxYqmJZF+
         BDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qi0pxCVqozd5V1/C140EBqHG2/fFl/8biYimGdOF39g=;
        b=L2P1lyKZysXUFrtYDi+l6apNVJe/BRjCJXHgBOMuAazokwQqx81Pq5xe7R/SIKqZF2
         u8DYgod2f+a1HKy6PtHdiVMZfRtd4N1uODEO/Sfszo0atUPe/iDw4upYqMC6uHYnSSR7
         Ect8CGxq5uPoW7ppNzmd2TXaGg+BgxZUtr0rdnqGxIZ/rNv4nVGswWfmM+Ylt9bimwTl
         ZNAWCiXrnGxkLvcpuFNDO05mgq5trAgQlduMgzEufvBrR3QDdfIes8eslE3dMHGy7Uat
         0VcK4oWepwCGC7lIQsEfGE1mFdD+Qv0Ur0KVtoOotE915Jpc9N7sYRO2c5+CFCQZefl8
         Jkhg==
X-Gm-Message-State: AOAM533a6jbmYkEPsXu34/U7Ggst6T6P/UKu8CmM8AhgsZNlDKlSBOBc
        FMiKEF5r2GsSfMFSDzt5n+g=
X-Google-Smtp-Source: ABdhPJyTwZiSryX5MIZpidIgIJi9LcUpN/z/chFF+oGj5J6XeYxB7Tv7kw9xlUyI/1o1pG1R/x/zJQ==
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr2871659wmk.91.1591098887652;
        Tue, 02 Jun 2020 04:54:47 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host9-254-dynamic.3-87-r.retail.telecomitalia.it. [87.3.254.9])
        by smtp.googlemail.com with ESMTPSA id b18sm3273777wrn.88.2020.06.02.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 04:54:46 -0700 (PDT)
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
Subject: [PATCH v5 09/11] PCI: qcom: Add ipq8064 rev2 variant
Date:   Tue,  2 Jun 2020 13:53:50 +0200
Message-Id: <20200602115353.20143-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602115353.20143-1-ansuelsmth@gmail.com>
References: <20200602115353.20143-1-ansuelsmth@gmail.com>
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

