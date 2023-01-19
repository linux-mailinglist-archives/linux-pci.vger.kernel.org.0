Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BDB673B39
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 15:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjASOG3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 09:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjASOF4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 09:05:56 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F077F990
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:05:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l8so1615627wms.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnjm/PMfCWBhtrU2iGU0gG9+KDqoUzC+C9XvnUy9xOc=;
        b=M0O7PQaCGbV0hMlBcsh03sRfPVTNskwhjem187W4uuej4J5RtyB+jYc8c2OnJJfFmC
         oZe/BTbbPyI2bYXggtFLLdK3G4NQw5KrE9rLIC07z4v/Tn5Ke1HTn1rk+aZtGG9MdHar
         SfVnXT6hXblTh9g5OhkWdQ/tVIbMGaHSnO7iLt4pnMVcEm/X8SuXJZO6Yrr5k+ocFmaw
         nXKB4Iw89bYgdOXW/idAPWdqGyXDtHSkWo3ME6qzizd9Hs8UqAUlATNrJaaTyvLkxHTY
         wBK7s6Dbtx4HjyzfBMu8SVesBOdIsPWd8nl445KGqlaflELTVG4Lw/4ZUc3UTI4SPYGq
         slEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnjm/PMfCWBhtrU2iGU0gG9+KDqoUzC+C9XvnUy9xOc=;
        b=K8q7XcdMtbWKKpQ3YQ96gwhA9Fi2P6XCb6OfMWioA/JXuFZKXYZjvivDX8p//DP0VR
         dOR3vsX+YO78ebL2HudbSYHP8lcD7m0JbLGI1u1HC6ZZ4FJOCAsOf5FD2baxiAk2Jyrc
         Q6N3CbXy5Xx6QkkwAWDn6VLUw+7dmf7BP7c4o+gTSFdtPOrYPDcF7/Bk18M2L3v/uR21
         qWAWtlUEG4GvC8tNwtZwyFBHF4r65RN+/6QRt/6vjcSOS2G8LyAnNLabmtDKD5ZJ5t/5
         +ez+UyKiXF9lWPbBfVm/SfSneZNJ6jPifYVoTkPVh0Vc2oONjs3LVWlkH6mmugDDvTuL
         UvwQ==
X-Gm-Message-State: AFqh2krp1YmaF2rribSYw9o69C29EIWtCPZbv+kOjIGckIZoAatNjWT9
        vxfiEp03y9icAyOj/8ALbd3r9A==
X-Google-Smtp-Source: AMrXdXtphli43eFWHG1PjJ2mKVvRbspfaY8ujSfwWfzIsqOG/XGx12InmUGDoNDQm10pyYnxc0FWpQ==
X-Received: by 2002:a05:600c:4e05:b0:3d3:5a4a:9103 with SMTP id b5-20020a05600c4e0500b003d35a4a9103mr10304805wmq.31.1674137123398;
        Thu, 19 Jan 2023 06:05:23 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c4f4a00b003d96efd09b7sm5263883wmq.19.2023.01.19.06.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:05:22 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 10/12] PCI: qcom: Add SM8550 PCIe support
Date:   Thu, 19 Jan 2023 16:04:51 +0200
Message-Id: <20230119140453.3942340-11-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119140453.3942340-1-abel.vesa@linaro.org>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add compatible for both PCIe found on SM8550.
Also add the cnoc_pcie_sf_axi clock needed by the SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---

The v3 of this patchset is:
https://lore.kernel.org/all/20230119112453.3393911-1-abel.vesa@linaro.org/

Changes since v3:
 * renamed cnoc_pcie_sf_axi to cnoc_sf_axi

Changes since v2:
 * none
 
Changes since v1:
 * changed the subject line prefix for the patch to match the history,
   like Bjorn Helgaas suggested.
 * added Konrad's R-b tag


 drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 77e5dc7b88ad..30f74bc51dbf 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -182,7 +182,7 @@ struct qcom_pcie_resources_2_3_3 {
 
 /* 6 clocks typically, 7 for sm8250 */
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[12];
+	struct clk_bulk_data clks[13];
 	int num_clks;
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
@@ -1208,6 +1208,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	res->clks[idx++].id = "noc_aggr_4";
 	res->clks[idx++].id = "noc_aggr_south_sf";
 	res->clks[idx++].id = "cnoc_qx";
+	res->clks[idx++].id = "cnoc_sf_axi";
 
 	num_opt_clks = idx - num_clks;
 	res->num_clks = idx;
@@ -1828,6 +1829,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
 	{ }
 };
 
-- 
2.34.1

