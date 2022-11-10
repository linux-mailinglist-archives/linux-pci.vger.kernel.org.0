Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92745624978
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 19:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiKJScJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 13:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiKJScH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 13:32:07 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B013E4AF3C
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 10:32:03 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id r12so4876583lfp.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 10:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf0KxYjTQhZ9cbNoU3M+UcqCiaOWtVYPcdD8LAR9jPA=;
        b=sAkgH9hOWR7bkWqoMlGZohtO9vMpWf9Rj/ZlOnYqGNaMAGtS9gxv1S0iXVc8PMeIOj
         jOkDTF1oNtcpEIo602oakDzojagaEvM4wYEKZJ073aiLb1qU8BiA87Kf2lGmg8dKQtgm
         UlQvEdP+ijvNITu8gwuWkjhH8yhiNhPA1zj46VB3dSexyopijVuYyfzIbIuImNM7dTHO
         VTj1Dc7ExWEjb6zccCa2YNwdo3KAuCLUII9NLxtaVthY0a11ixTA1xK2HcAA6zVzMahm
         QamrFKX64ddQItlmlKMCp5Rgv7acKbKoWBwuPA6N5N1YmbnS8AFXoiEzg3/evcQokmDr
         c+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf0KxYjTQhZ9cbNoU3M+UcqCiaOWtVYPcdD8LAR9jPA=;
        b=T4gOR7boafHgosU4XRD0oANBqo+hApdjDjtoZkUiLpOaths65tD40SaWHFuz3Evqv2
         kV0hM/XoNX5rp8zjmNCb2lbwxzeUlCGy6AGvlWi6PEz5ihzGeGKeEJVACxZFRCBsaTOt
         O24crFXLVOOrRpTdbjeC4gMqNL7TVtrHpETn7RBcKwNWsDd4UNJZyd7wtIn4jMWH6kAl
         pKXI2nuXT6+88tyxVLTiaJGlzX8DBV1WWxjlD0ddCa2ofgg3qfBC+PZ6fIGwMeBRklI1
         64F45kuLttDYXeTHi9xgTaykZ0wGQpJCniQ7UAI+BpzhLWo6f2LQ6kmcrd6VPZREs5se
         zRkQ==
X-Gm-Message-State: ACrzQf2QH28C1hzVNY+FCThKUS7Y5Qxzwo789Gxo5QdhikDUaIRSdRgx
        t/xZ3lEre7PPVhUDHYiV+/UbSg==
X-Google-Smtp-Source: AMsMyM47k3FEnQ6+Oc/h62lDnIktWn1L+T0YDe5nlGuUyncZZBlaXIvY5+S8cQ2zJvIE9oW8wIOeZQ==
X-Received: by 2002:a05:6512:ac4:b0:4af:b4ac:c2d6 with SMTP id n4-20020a0565120ac400b004afb4acc2d6mr1842004lfu.219.1668105122084;
        Thu, 10 Nov 2022 10:32:02 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m18-20020a197112000000b004a2550db9ddsm2837087lfc.245.2022.11.10.10.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:32:01 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 3/8] PCI: qcom: Add support for SM8350
Date:   Thu, 10 Nov 2022 21:31:53 +0300
Message-Id: <20221110183158.856242-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221110183158.856242-1-dmitry.baryshkov@linaro.org>
References: <20221110183158.856242-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for the PCIe host on Qualcomm SM8350 platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7db94a22238d..3404c737afba 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1750,6 +1750,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
 	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sm8350", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
 	{ }
-- 
2.35.1

