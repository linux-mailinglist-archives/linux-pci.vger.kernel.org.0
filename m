Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B94455205C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 17:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbiFTPTj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 11:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243911AbiFTPSF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 11:18:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077021C104;
        Mon, 20 Jun 2022 08:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF052B811D3;
        Mon, 20 Jun 2022 15:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5EAC3411B;
        Mon, 20 Jun 2022 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655737772;
        bh=nvUKsIOSB2sKsfhVbzK6dt7B6Lv7rlPXdDOGznoItlY=;
        h=From:To:Cc:Subject:Date:From;
        b=FKVE6PdMFMl4zITgmVhBTj42NCZqaX9hDjUK7e6/sbm4gq3/EFqAW2I8vbdyt7c9y
         EplvFbxsRjr6vene6rqWhrZE6Y3KTTLSiX/8FCy2wW/qSGPnpKUWUwY50LFsE1Z7fx
         rIOt3pnmF3fWJDN39JTzSHJhW+jXkSjRB2bWfcePpANbFl5Rg8DRIZm664pvJlbkDQ
         vy+guQDS+ken8AHZbiTSP5ovdeUU8hKRZKH4V0wkBkEVTPZ3ZEZ84ONsVzMuBnn8d5
         cB/e4cJfIcFgAMWXCtOyNfWM2QRPxEQWFJYoSyqMDNNAFl2KrWxGeOnGIbnYvNY14c
         GDvcHeJyqzH6A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o3J1s-00030a-Pp; Mon, 20 Jun 2022 17:09:28 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] PCI: qcom: Drop unused post-init callbacks
Date:   Mon, 20 Jun 2022 17:07:59 +0200
Message-Id: <20220620150759.11507-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Drop the unused post_init and post_deinit callbacks that were added for
the now removed pipe clock handling.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Now that Bjorn has merged the pipe clock series:

	https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/ctrl/qcom

the post_init and post_deinit callbacks can also be removed.

Note that this one depends on the patch adding support for modular
builds:

	https://lore.kernel.org/all/20220519094646.23009-1-johan+linaro@kernel.org/

which has been reviewed by Rob and should be ready to be picked up.

Johan


 drivers/pci/controller/dwc/pcie-qcom.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ff1b40f213c1..fe701da32119 100644
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
@@ -1362,8 +1351,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
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

