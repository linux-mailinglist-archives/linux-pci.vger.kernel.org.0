Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED6F509D95
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388337AbiDUK03 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 06:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388294AbiDUK0Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 06:26:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB5E2229E;
        Thu, 21 Apr 2022 03:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F45C61A36;
        Thu, 21 Apr 2022 10:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DFFC385A5;
        Thu, 21 Apr 2022 10:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650536613;
        bh=PLPfqK1kInufZpDRYtLVy/FfrLJYvtPIqiJbh2gX40Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cK/Kn2tbYHBJjKGmUXRXQ0n+/8esHVntKqfRjQvZosnuimAODJGbxWx+9mk+PqizZ
         g+Q8rDS4/HhLvEFXdE3nz+6Y5boAO9yklqyF/nxFgbc+bqSmj03sQRBjmO9E8Ylu3U
         Q/XQOk1lS0EM1vfWJitapsbpVxwQMuhKsM3Ou7E9/dkbCdq+75bCzNWArF70dDOueA
         EtWtfK2N2oJyz59TQq9d0PcKYalcvDdZJ03N0z0D3IJSCgld1ATZEjCIBFhx2NYhQ4
         LdOm6aWbnFV2JZbci07iFNb9dhD5NBou8meYWCO8kPryCV6wzXN1Z9K1grwVUixkUB
         7h6P50urBG0vg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nhTyB-0004Xm-M3; Thu, 21 Apr 2022 12:23:27 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Stephen Boyd" <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH RFC 5/5] PCI: qcom: Drop unused post-init callbacks
Date:   Thu, 21 Apr 2022 12:20:41 +0200
Message-Id: <20220421102041.17345-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421102041.17345-1-johan+linaro@kernel.org>
References: <20220421102041.17345-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Drop the unused post_init and post_deinit callbacks that were added for
the now removed pipe clock handling.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d6e33ac9a01a..7606a9f6eb21 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -180,9 +180,7 @@ struct qcom_pcie;
 struct qcom_pcie_ops {
 	int (*get_resources)(struct qcom_pcie *pcie);
 	int (*init)(struct qcom_pcie *pcie);
-	int (*post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
-	void (*post_deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
 };
@@ -1331,27 +1329,18 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		goto err_deinit;
 
-	if (pcie->cfg->ops->post_init) {
-		ret = pcie->cfg->ops->post_init(pcie);
-		if (ret)
-			goto err_disable_phy;
-	}
-
 	qcom_ep_reset_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {
 		ret = pcie->cfg->ops->config_sid(pcie);
 		if (ret)
-			goto err;
+			goto err_assert_reset;
 	}
 
 	return 0;
 
-err:
+err_assert_reset:
 	qcom_ep_reset_assert(pcie);
-	if (pcie->cfg->ops->post_deinit)
-		pcie->cfg->ops->post_deinit(pcie);
-err_disable_phy:
 	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->cfg->ops->deinit(pcie);
-- 
2.35.1

