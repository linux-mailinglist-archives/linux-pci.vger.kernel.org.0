Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B6C6736B6
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjASLZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 06:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjASLZM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 06:25:12 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B3171F0E
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 03:25:06 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b7so1538160wrt.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 03:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jjumn+I+wkHZk5NVVYexup8sGnkZ4VyPciwtVSYN3y8=;
        b=IhWrXLqtYqFTRUG0/z62w2T8MBWpTFNipnLhMR3XSGokgY5LWm+zCPvIqgcL8TBcum
         9RJSAoS/ZyYyCjOIxDuoGmYWV1TXamIMZ3LkVvbazMZENQ+KFF2lJAyazU60T9jEDaW3
         yZWvEXiINvKtfv9DuI6+5TpHSbnTJ7EUmtigC/wdKeJTnp/7pt+VGTPjC1r9H0RfMStO
         Nb47ANOONNt3/SCJhyhPwWzZ126MB/89DJxndPWGJAcPh30t7FJWqsNl83CuBZCA07Pa
         3I2Gs4UV8QSr7sBTkf+QKitlKpDx+ILC51YXIOWhp+xxh5IFcJxTdGcDS0QaucSr89of
         9LdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jjumn+I+wkHZk5NVVYexup8sGnkZ4VyPciwtVSYN3y8=;
        b=6VWWGB0tosXw6/JDkNwEoxiGWRxKBxpRLxD70NfjLyl0pMk+FHXRZY+/xxh0+K23Tx
         M7gpLelYE+yTwiUNW3L5UjPflsAmsfGCy6QlprarA8Ed4i53Fxe0RKiQYLJH8WBXjMQs
         aQZ8E5S1C5bGvBF7jUufb3NwjhZPDQs9mPJsK4wXXDYXJrLCQ5a0F92lWJdqSK9F9BoO
         +xkcBtJYWBN1gOGBsoZixLcUoJEgnbpw9YxQQV6Lkfgs4OOc51I5IkRGzNO6X0m90RkF
         nNKogbAClaCKrLRO08EeT20PVwjibM/A/NNA6OQQh4PS/2w5kaPXfog85eTcIVy9oHeN
         FaNg==
X-Gm-Message-State: AFqh2kp+h7d66zeDY/Mlap865tok1B+6GP3+LJN2YhYFEmTzSpKMEGnS
        BvuJBVRoJ8sjvMi0kUVHpKs4ZCwktZ6Ej5Mp
X-Google-Smtp-Source: AMrXdXvPbSq3xK4D65Edtw3e5PzfKKeFt2TmJ1e+1mU6FlJ7V9ToKuqrWDNM9rZCGzZV+8Bh5Vkceg==
X-Received: by 2002:a5d:548d:0:b0:2aa:438a:2165 with SMTP id h13-20020a5d548d000000b002aa438a2165mr8615483wrv.24.1674127505074;
        Thu, 19 Jan 2023 03:25:05 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d404a000000b00275970a85f4sm33436999wrp.74.2023.01.19.03.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 03:25:04 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] PCI: qcom: Add SM8550 PCIe support
Date:   Thu, 19 Jan 2023 13:24:53 +0200
Message-Id: <20230119112453.3393911-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119112453.3393911-1-abel.vesa@linaro.org>
References: <20230119112453.3393911-1-abel.vesa@linaro.org>
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

The v2 was here:
https://lore.kernel.org/all/20230118111704.3553542-2-abel.vesa@linaro.org/

Changes since v2:
 * none

Changes since v1:
 * changed the subject line prefix for the patch to match the history,
   like Bjorn Helgaas suggested.
 * added Konrad's R-b tag


 drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 77e5dc7b88ad..85988b3fd4f6 100644
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
+	res->clks[idx++].id = "cnoc_pcie_sf_axi";
 
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

