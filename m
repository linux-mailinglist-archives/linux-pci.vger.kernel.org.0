Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919DF4EEE3A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbiDANgl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 09:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245196AbiDANgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 09:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCB315DA98;
        Fri,  1 Apr 2022 06:34:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 295D561B33;
        Fri,  1 Apr 2022 13:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EA5C340EC;
        Fri,  1 Apr 2022 13:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648820090;
        bh=RVL0O4S/hfFXNZm/0gRGl40ZHTehWVbfCwmjbxXvNVk=;
        h=From:To:Cc:Subject:Date:From;
        b=U8kPmkGzpgKuAjC5et7CoGaXJC738aSBSBpE3g5hOfg9tCqXH9/xKHqBJNVxAIugc
         oLTIibB1ddbaEqHcyBoUURCSyvT6sxaTSNqjcITgWUiQO6J4D3hbAV/I9+bd91fedg
         RL7Hq3blqSLfDJVKTuRWR2qnELw6mRyzK4l8QkW0e4AiQBT6qZAKY9MtGCu2OFHAPq
         Bk71HzM/K3rlelJDFzqen7r72mmxc2GUvG6KAwPltkoQLKUZpNcP63sZ7WLH71IKwp
         R76NKxqqm30rrbWVKH+7iYnwgouuv4bI5tMtPu49eoA7GoH6cwCOiXgiY/eAU2tqxm
         q2Nmhh9TFyEgA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1naHQP-0002dz-Ss; Fri, 01 Apr 2022 15:34:50 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2] PCI: qcom: Fix pipe clock imbalance
Date:   Fri,  1 Apr 2022 15:33:51 +0200
Message-Id: <20220401133351.10113-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit ed8cc3b1fc84 ("PCI: qcom: Add support for SDM845 PCIe
controller") introduced a clock imbalance by enabling the pipe clock
both in init() and in post_init() but only disabling in post_deinit().

Note that the pipe clock was also never disabled in the init() error
paths and that enabling the clock before powering up the PHY looks
questionable.

Fixes: ed8cc3b1fc84 ("PCI: qcom: Add support for SDM845 PCIe controller")
Cc: stable@vger.kernel.org      # 5.6
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Changes in v2
 - Capitalise "Fix" in subject line according to PCI subsystem
   convention


 drivers/pci/controller/dwc/pcie-qcom.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b79d98e5e228..20a0e6533a1c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1238,12 +1238,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		goto err_disable_clocks;
 	}
 
-	ret = clk_prepare_enable(res->pipe_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable pipe clock\n");
-		goto err_disable_clocks;
-	}
-
 	/* Wait for reset to complete, required on SM8450 */
 	usleep_range(1000, 1500);
 
-- 
2.35.1

