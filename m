Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543735EE0F6
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiI1PzP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiI1PzK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 11:55:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C025075CFE;
        Wed, 28 Sep 2022 08:55:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81166B82118;
        Wed, 28 Sep 2022 15:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AC4C433C1;
        Wed, 28 Sep 2022 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380506;
        bh=19kRek0Nz/9dwB2Md/XXV+wwHSf8yk35FNl7Vooy73E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAFJ9lBYsnTSpIwaiRaxIPRbLW1l2YWc8XmwdFpYAgA3Pm/qSOYKqhsiTGegfSBc4
         nCCXulw0M3rA6zJ2ZpPwXs+rd3AHzdmzHIYn8TpQ9309JgLTsZYTLOesvoynC1rUCt
         MYTb4nmRizlLpF+cizq1c27mC9lXY8qDlS49GTbrk2l7u28yhWqUNXo+lBw4zu4O0y
         M8pua8XkBVPTrUBDuHrh8XYKG13rn7EVlLnBEtVgcZmlIzM62h5yGMdXT7UNoYzxPk
         /rFpKm6ehQf2qWVv0qO1TK6XPcTlsTXR8L+9E6nypMCmQw4yinEDvTYl3gewvUClfv
         XGXdJNRzoJAag==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1odZOy-0005eA-Sw; Wed, 28 Sep 2022 17:55:12 +0200
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
Subject: [PATCH v3 2/2] PCI: qcom: Rename host-init error label
Date:   Wed, 28 Sep 2022 17:54:21 +0200
Message-Id: <20220928155421.21660-3-johan+linaro@kernel.org>
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

Use a more descriptive name for the reset host-init error label for
consistency.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8d6df0db4ebb..f711acacaeaf 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1512,12 +1512,12 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
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
 err_disable_phy:
 	phy_power_off(pcie->phy);
-- 
2.35.1

