Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FE4560383
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiF2Omx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiF2Omv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:42:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED5E39148;
        Wed, 29 Jun 2022 07:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 629C1B821D1;
        Wed, 29 Jun 2022 14:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB3CC385A5;
        Wed, 29 Jun 2022 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656513768;
        bh=n9ZmQ6x2qPrMGIXbPtlayfptIXt0o9THHH95LquL13c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYETopM8meokBgTHEA5w58kW3E/y0/CbROzg1i+aXHVIqtEHLFy1wIwtWwJWgFgZK
         NuQgS0WTMN8d8eeB3mi4rbaz7w4KhnpfmDFa7L0KggyNCmFpgru2W7bvbiZwT2aYQ9
         RYRkHZjUhWmqmlCIrrWEqnQfsByvIYvQ0+h2/a489qLpRGUhWCf7394lPlV8cbAdRI
         /jBsp45m3/C4a0eYEbQAqC116oIVFAsvquVn+URlsO9oHRG+Vlo1heWMISO8UjFUMF
         O1HPZxVM+TgDxamwtsbt3arGEvIIjgWRkkax8KwPX1/z97r0/jpZEu2JmNfBz5bMf5
         bocv/0uaoKB9w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o6Ytz-00058V-Nk; Wed, 29 Jun 2022 16:42:47 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 1/2] PCI: qcom: Drop unused post_deinit callback
Date:   Wed, 29 Jun 2022 16:41:23 +0200
Message-Id: <20220629144124.19693-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629144124.19693-1-johan+linaro@kernel.org>
References: <20220629144124.19693-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Drop the unused and confusingly named post_deinit callback that was
added for the now removed pipe clock handling.

If ever needed we can add back a callback named pre_deinit (or perhaps
rather pre_phy_power_off) instead.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 093f4d4bc15d..c5e60f8c565d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -182,7 +182,6 @@ struct qcom_pcie_ops {
 	int (*init)(struct qcom_pcie *pcie);
 	int (*post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
-	void (*post_deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
 };
@@ -1353,8 +1352,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
 err:
 	qcom_ep_reset_assert(pcie);
-	if (pcie->cfg->ops->post_deinit)
-		pcie->cfg->ops->post_deinit(pcie);
 err_disable_phy:
 	phy_power_off(pcie->phy);
 err_deinit:
@@ -1366,8 +1363,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 static void qcom_pcie_host_deinit(struct qcom_pcie *pcie)
 {
 	qcom_ep_reset_assert(pcie);
-	if (pcie->cfg->ops->post_deinit)
-		pcie->cfg->ops->post_deinit(pcie);
 	phy_power_off(pcie->phy);
 	pcie->cfg->ops->deinit(pcie);
 }
-- 
2.35.1

