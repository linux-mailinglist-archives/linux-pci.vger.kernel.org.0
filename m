Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8D1C09EC
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 00:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgD3WGn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 18:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgD3WGm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 18:06:42 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B5C035494;
        Thu, 30 Apr 2020 15:06:42 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so5842970edv.8;
        Thu, 30 Apr 2020 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CgTrzh3Tu5k7J4C6anuKQZFd/nJ6FehtS7rnu7w0aik=;
        b=W9lUgU66nDUDMQXEq+6WhaUSOwFR89PMCUiEzi9uQtlmrbT3JUKTTX8N/YvWpmGRZM
         bflOf5xiTdbtWJrHBNFVSeEm+ltIVGx/x7kqByJXaZjP5RSgebWF8zkpfKGiVBBrqo+T
         ulnFiY7CxTNRRJVS1U+SxBPB6cN2KjoeJv4TFmlMl0RcQgP8zt1Mw+q4KYnW8qbjribj
         cebgHLKEyWmZnHu7OovETEUUJJb+W+jfYrjGT4pL1C/FniBrTOWpRtNF9NWvapGi2zVC
         3gRUTaf7+pzMeMkHewo63L90kIIiHdlTHSIb3lrak94otqyrmZYWcNxMj1JToDaELXRv
         HOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CgTrzh3Tu5k7J4C6anuKQZFd/nJ6FehtS7rnu7w0aik=;
        b=i6bZXrlmltDhgXTV5Vy/4J2iIoHJmytlZ14dOSVsgTsX883D/VbJZFkSJT51CcdUZO
         72m7WiZQbKLzCjP6fi+zXSQG/y7h6e3Y8Y5+1zcI1bVY9LUES/IZrZa+3Y2YgN/IGGvX
         JH+oS3q5/0qVsvtXZqkerEefTIRaX0f409OJclmX0+fuJ7QVfpYOEiJg9vOhr9xildMY
         efa+rcg7kdEbdkU4tlA7zOKc2rjH/Z4nLWR3QED9y7CkH2u0PU/2Ow1zBwShKRO+9seG
         EE8KZwghfvCLIZaStCUH+sOw6cFi+ozZevuqX2vHwWQtQIfdla/zJEl2DwX2+UR23Jc1
         +s5w==
X-Gm-Message-State: AGi0PuaJ+/vu2EPYNKIjW652gg63xmA+SuZGyW0UDZ3LCWfwf2ok16u8
        qAwsJ+s2JZ6RK6KCrnGvg2Q=
X-Google-Smtp-Source: APiQypKAWtOnJY37BTq1roF1i90+nc9Z/fJC/RtNKvUzlpXZZWc8QxpkmmWxFQpUlmKLLpjH1nhY7g==
X-Received: by 2002:a05:6402:95e:: with SMTP id h30mr1049680edz.117.1588284400719;
        Thu, 30 Apr 2020 15:06:40 -0700 (PDT)
Received: from Ansuel-XPS.localdomain ([79.37.253.240])
        by smtp.googlemail.com with ESMTPSA id t17sm54185edq.88.2020.04.30.15.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:06:40 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Abhishek Sahu <absahu@codeaurora.org>,
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
Subject: [PATCH v3 03/11] PCI: qcom: change duplicate PCI reset to phy reset
Date:   Fri,  1 May 2020 00:06:10 +0200
Message-Id: <20200430220619.3169-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200430220619.3169-1-ansuelsmth@gmail.com>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Abhishek Sahu <absahu@codeaurora.org>

The deinit issues reset_control_assert for PCI twice and does not contain
phy reset.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2a39dfdccfc8..7a8901efc031 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -280,14 +280,14 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 
+	clk_disable_unprepare(res->phy_clk);
 	reset_control_assert(res->pci_reset);
 	reset_control_assert(res->axi_reset);
 	reset_control_assert(res->ahb_reset);
 	reset_control_assert(res->por_reset);
-	reset_control_assert(res->pci_reset);
+	reset_control_assert(res->phy_reset);
 	clk_disable_unprepare(res->iface_clk);
 	clk_disable_unprepare(res->core_clk);
-	clk_disable_unprepare(res->phy_clk);
 	clk_disable_unprepare(res->aux_clk);
 	clk_disable_unprepare(res->ref_clk);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -325,12 +325,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		goto err_clk_core;
 	}
 
-	ret = clk_prepare_enable(res->phy_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable phy clock\n");
-		goto err_clk_phy;
-	}
-
 	if (res->aux_clk) {
 		ret = clk_prepare_enable(res->aux_clk);
 		if (ret) {
@@ -387,6 +381,12 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(res->phy_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable phy clock\n");
+		goto err_deassert_ahb;
+	}
+
 	/* wait for clock acquisition */
 	usleep_range(1000, 1500);
 
@@ -404,8 +404,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 err_clk_ref:
 	clk_disable_unprepare(res->aux_clk);
 err_clk_aux:
-	clk_disable_unprepare(res->phy_clk);
-err_clk_phy:
 	clk_disable_unprepare(res->core_clk);
 err_clk_core:
 	clk_disable_unprepare(res->iface_clk);
-- 
2.25.1

