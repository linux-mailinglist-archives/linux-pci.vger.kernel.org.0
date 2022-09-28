Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A3E5EE0F9
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiI1PzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 11:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiI1PzO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 11:55:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6958768C;
        Wed, 28 Sep 2022 08:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ABD52CE1EE1;
        Wed, 28 Sep 2022 15:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1E5C433D7;
        Wed, 28 Sep 2022 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380506;
        bh=snbCPFGK77lLhaoBKaG+W4txsXWhqgoJg/DwQu1/7Wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8gBCOaI21XKWOE/s/fW03R9iL7ZdL05MNVEePYa0Bu9sb9edsJyjOsG+WD3Q8oAH
         mk7LycDvNYKwN2ezN4MygIzEOhcmdD01tmdawLuQS+Z7c9cNY0rzXomGLCMuyHDwj0
         yZIzc8qMP/ukh/Bqd5oKx1oSawGLeWnfsaCIRAmDl6CH/e9kh1Dhtqj6zKnivZKtuU
         lUeyHL3kbgLY0IHT2XrkhTibqho+K9WFL41SvthXCSRfLeqTK9PuDzes4e/cXXOzup
         WCuOCZmot2KMFROEp2H/mUK06Wwa4WHrZwy9qB1TvDe1/v9VXX5onvtRv7aHt+4qTK
         CFCQe5hJugzGg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1odZOy-0005e8-Q2; Wed, 28 Sep 2022 17:55:12 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 1/2] PCI: qcom: Drop unused post_deinit callback
Date:   Wed, 28 Sep 2022 17:54:20 +0200
Message-Id: <20220928155421.21660-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220928155421.21660-1-johan+linaro@kernel.org>
References: <20220928155421.21660-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pci/controller/dwc/pcie-qcom.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 39ca06ffe614..8d6df0db4ebb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -208,7 +208,6 @@ struct qcom_pcie_ops {
 	int (*init)(struct qcom_pcie *pcie);
 	int (*post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
-	void (*post_deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
 };
@@ -1520,8 +1519,6 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 
 err:
 	qcom_ep_reset_assert(pcie);
-	if (pcie->cfg->ops->post_deinit)
-		pcie->cfg->ops->post_deinit(pcie);
 err_disable_phy:
 	phy_power_off(pcie->phy);
 err_deinit:
-- 
2.35.1

