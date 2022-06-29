Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AA256037D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiF2Omv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiF2Omt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1945A3A1AD;
        Wed, 29 Jun 2022 07:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACCA261F48;
        Wed, 29 Jun 2022 14:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065E6C341CB;
        Wed, 29 Jun 2022 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656513768;
        bh=e0/+toNpTdyz3yvvEA1CAPOw+ZoKsBqs7s7Gcj0cGps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZbBgy1z7clhDff2k11cQNDfpk9iPtv98d5nlWMmwF5Y0NudSOAcjI5NfzCBqyB8kF
         khIQqQHO8U2GrfYFWni6JWoPisgLSK38IU6llz4pvy3wxYsrc/yHa1otRuJ4QD2CrQ
         ZrfIOnwc2wLq0PXAaoJCNPysPqecn7UET5S/aMAYaqCOo0LbRwTf8vEB3rRS3J5DbI
         Cd+cCbwZAxUWkN9a8wJNNK7KawZP4LkYI8X6VWGys2aOn5dY0EeOB9ZGEwS6Q5Uj3v
         rvOX15WJdZfebuBMHawv6IJ3JW3XJIZfoTUhGf84+0+GwWLGrw83TcaKJfFgrJxOFS
         jjFOvh5g+KBnQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o6Ytz-00058X-QW; Wed, 29 Jun 2022 16:42:47 +0200
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
Subject: [PATCH v2 2/2] PCI: qcom: Rename host-init error label
Date:   Wed, 29 Jun 2022 16:41:24 +0200
Message-Id: <20220629144124.19693-3-johan+linaro@kernel.org>
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

Use a more descriptive name for the reset host-init error label for
consistency.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c5e60f8c565d..7a5d15b2cff8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1345,12 +1345,12 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
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

