Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A655B1FA283
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 23:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgFOVHC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 17:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbgFOVGi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 17:06:38 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A813FC061A0E;
        Mon, 15 Jun 2020 14:06:36 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e12so12578360eds.2;
        Mon, 15 Jun 2020 14:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CF5K9ujAQuucHml86IAG1dkKBBk45BbB1oezTy06myY=;
        b=qcDOZ3hgr1ADhgAZm2QtCmAX4qKpx6GAkHuhohZHSLphx2nrfVaQQgths0J4JahMr8
         cC/03iW0ZUh4S7M7etRijN8maAclSzhRXRfPHhTIu5wZB3Hw0zEC2oWS39CJIq6h2PM+
         takVWPXZAMfTojJgngfKSZVtS2B+H0Cot7w3eiQDb+Dvqfk0fHijdWs9p+2KpqbzJdM4
         Otv5fyNmiSZBO3alybYR2OjeeUu2SENeqOcPs06cbU/QPzCQ2LPdRdFoiNH6iquTdYeN
         EHWhxSGP9Z7yDQYsfYMgNLTTfkYah9c7QZAWHCfFULRh5FESkXFZB80yy2obOqRaYSdG
         ljLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CF5K9ujAQuucHml86IAG1dkKBBk45BbB1oezTy06myY=;
        b=pTM0WJ7b+aihBvX+D7UrJtiuugooX3RpMFi49mzBTf02xcbBzGP/GJxludgUtoYVNr
         OvaOlgWXP/A4NDemwMnDjr7fZrmdVlwQNuw5QWg4X1CPImgjDcbsDKP5H8MiN5lPtqnL
         y9dx/Kexy3iZiDSAusXTFAPE5+VdQJ4J2o+yolgcn8mTztEjVEzYozzXkF2ev/QdlMCk
         cJ52L0AEkWqfIehKowmT6jUHxAtXCxmgfpD6QQTjhjg6m7QIHqrEuY7URbWrwnG7rkW6
         8hC4x9f+V7tOe4flzmqu/FHhMLvya7Io5u/ea7Gzi2QLuI9sRP0cwMUfjz1DsWQiRCSV
         OZEA==
X-Gm-Message-State: AOAM533qRrVd5nqNHBhuACrlUXcmYLtfXGT3TDi3D3Yu4212Yz890dxu
        eUYfELnX1H7yj0Idk2SFLbo=
X-Google-Smtp-Source: ABdhPJwxom631KPO65yeC0E53jnW34L2PrhaWBP5j08rh3VRYuvgUuKzW3MonC3t1bKFQHLZCenhGQ==
X-Received: by 2002:a50:cd56:: with SMTP id d22mr24844238edj.374.1592255195340;
        Mon, 15 Jun 2020 14:06:35 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-95-238-254-39.retail.telecomitalia.it. [95.238.254.39])
        by smtp.googlemail.com with ESMTPSA id d5sm9662226ejr.78.2020.06.15.14.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:06:34 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Ansuel Smith <ansuelsmth@gmail.com>,
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
Subject: [PATCH v7 09/12] PCI: qcom: Add ipq8064 rev2 variant
Date:   Mon, 15 Jun 2020 23:06:05 +0200
Message-Id: <20200615210608.21469-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200615210608.21469-1-ansuelsmth@gmail.com>
References: <20200615210608.21469-1-ansuelsmth@gmail.com>
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
2.27.0.rc0

