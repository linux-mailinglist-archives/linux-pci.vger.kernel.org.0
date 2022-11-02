Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C38615F0E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 10:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiKBJJg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 05:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiKBJJA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 05:09:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8144827FE8;
        Wed,  2 Nov 2022 02:08:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CC4AB8216C;
        Wed,  2 Nov 2022 09:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2C4C43140;
        Wed,  2 Nov 2022 09:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667380135;
        bh=K0quaz+Wfm7vLUHKdy0xGgalRWdTdZS5W06aFhvSiKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRg6Pw5mWkRR1qbrh14cI4Q1E4F1kwqcD2A8jdseXcDVTOUL7JX69X+kKpEWXA/tF
         dIDwk/SlfzHt1LBYTArtqAQRUFiqy0SBCLA6jVw+1ftDvDzCv5KTp0ATbn6c8x34A5
         khhxI9f7ZGYfsaB9kPWn0w0LT2xNMgtLwiaijVTPhW0VjLaVs7XF9B0cIRRtkzDQeJ
         BwQwUEvJ4TDGDVsAGvvLAh45G9Do0yC9+lftpmsMWGbq3Ge3I22fGRcz0Murv81HPH
         CA1HalWm4/iTmG3HN2QLdjDtNfa4SeVVH0StfAQoN75P9zuDkIWM5HygjAoUeZRCU9
         HP/yTi4L84eqQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oq9jj-0006B7-OF; Wed, 02 Nov 2022 10:08:39 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        stanimir.k.varbanov@gmail.com
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Brian Masney <bmasney@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Subject: [PATCH v3 2/2] PCI: qcom: Add basic interconnect support
Date:   Wed,  2 Nov 2022 10:07:05 +0100
Message-Id: <20221102090705.23634-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221102090705.23634-1-johan+linaro@kernel.org>
References: <20221102090705.23634-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Qualcomm platforms like SC8280XP and SA8540P, interconnect bandwidth
must be requested before enabling interconnect clocks.

Add basic support for managing an optional "pcie-mem" interconnect path
by setting a low constraint before enabling clocks and updating it after
the link is up.

Note that it is not possible for a controller driver to set anything but
a maximum peak bandwidth as expected average bandwidth will vary with
use case and actual use (and power policy?). This very much remains an
unresolved problem with the interconnect framework.

Also note that no constraint is set for the SC8280XP/SA8540P "cpu-pcie"
path for now as it is not clear what an appropriate constraint would be
(and the system does not crash when left unspecified).

Fixes: 70574511f3fc ("PCI: qcom: Add support for SC8280XP")
Reviewed-by: Brian Masney <bmasney@redhat.com>
Acked-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 76 ++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7db94a22238d..91b113d0c02a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -12,6 +12,7 @@
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -224,6 +225,7 @@ struct qcom_pcie {
 	union qcom_pcie_resources res;
 	struct phy *phy;
 	struct gpio_desc *reset;
+	struct icc_path *icc_mem;
 	const struct qcom_pcie_cfg *cfg;
 };
 
@@ -1644,6 +1646,74 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = qcom_pcie_start_link,
 };
 
+static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	int ret;
+
+	pcie->icc_mem = devm_of_icc_get(pci->dev, "pcie-mem");
+	if (IS_ERR(pcie->icc_mem))
+		return PTR_ERR(pcie->icc_mem);
+
+	/*
+	 * Some Qualcomm platforms require interconnect bandwidth constraints
+	 * to be set before enabling interconnect clocks.
+	 *
+	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
+	 * for the pcie-mem path.
+	 */
+	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
+	if (ret) {
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u32 offset, status, bw;
+	int speed, width;
+	int ret;
+
+	if (!pcie->icc_mem)
+		return;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+
+	/* Only update constraints if link is up. */
+	if (!(status & PCI_EXP_LNKSTA_DLLLA))
+		return;
+
+	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
+
+	switch (speed) {
+	case 1:
+		bw = MBps_to_icc(250);
+		break;
+	case 2:
+		bw = MBps_to_icc(500);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		fallthrough;
+	case 3:
+		bw = MBps_to_icc(985);
+		break;
+	}
+
+	ret = icc_set_bw(pcie->icc_mem, 0, width * bw);
+	if (ret) {
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+			ret);
+	}
+}
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1704,6 +1774,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
+	ret = qcom_pcie_icc_init(pcie);
+	if (ret)
+		goto err_pm_runtime_put;
+
 	ret = pcie->cfg->ops->get_resources(pcie);
 	if (ret)
 		goto err_pm_runtime_put;
@@ -1722,6 +1796,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
+	qcom_pcie_icc_update(pcie);
+
 	return 0;
 
 err_phy_exit:
-- 
2.37.3

