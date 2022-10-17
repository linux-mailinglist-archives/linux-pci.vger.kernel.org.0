Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5518C600E13
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 13:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJQLsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 07:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJQLsC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 07:48:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF23501BA;
        Mon, 17 Oct 2022 04:48:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F0D5B81620;
        Mon, 17 Oct 2022 11:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8B4C433D7;
        Mon, 17 Oct 2022 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666007279;
        bh=nLvYNjNcsWp65q0okwELSdi4ANG2a+C37u/lQ6/epEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcvK+rmrUYh1V0sc+sYyL6tCuliAdBr6oJiHYPOEgdO+5JXo6UtrbIlj5Pi2r1uDd
         R8+yvvBSTZvEj4xUP0206m+BBwdG7VxbCvDbSQjoo9y16rBLy3YiBvck2c3q5GYXlX
         dPgnGP/8GtfpdOsu5yZlQBqd7TKsj2wJCt++LlXvzx3YrsBAI1dO6gyqGCH2lJfGFl
         Va/FrcKvRv/kO+GzzvSFw4KkIRiPNpgPqaiFL0HEJYbz1lLaaS/W8aIWsKUITz02+D
         26ZPuFeb6sl7tFONXKAdajlG1SfaE4YeUrXfBcTnhiQqzHsm5wTTJWEs9Ypfpnx0pX
         bwUkv77KeLXjg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okOay-0002B1-OG; Mon, 17 Oct 2022 13:47:48 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 1/2] PCI: qcom: Fix host-init error handling
Date:   Mon, 17 Oct 2022 13:47:04 +0200
Message-Id: <20221017114705.8277-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017114705.8277-1-johan+linaro@kernel.org>
References: <20221017114705.8277-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement the new host_deinit() callback so that the PHY is powered off
and regulators and clocks are disabled also on late host-init errors.

Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0c13f976626f..417be4d225ed 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1534,8 +1534,19 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	return ret;
 }
 
+static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	qcom_ep_reset_assert(pcie);
+	phy_power_off(pcie->phy);
+	pcie->cfg->ops->deinit(pcie);
+}
+
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
-	.host_init = qcom_pcie_host_init,
+	.host_init	= qcom_pcie_host_init,
+	.host_deinit	= qcom_pcie_host_deinit,
 };
 
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
-- 
2.37.3

