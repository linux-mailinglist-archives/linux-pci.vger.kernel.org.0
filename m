Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047B0623FDF
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 11:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiKJKdy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 05:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiKJKdx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 05:33:53 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FC12D76D
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 02:33:52 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r12so2395208lfp.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 02:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf0KxYjTQhZ9cbNoU3M+UcqCiaOWtVYPcdD8LAR9jPA=;
        b=lu23DnalQprjxAyWG5D5mwMIRPL8gyolzgf1Cz8Ywhtwb1kCOS3l7G7vjImGhjC4AR
         RsNBCJaRyC0+tyQcWteG+UK5yisKD38kGnFF6ejmPoyPZPmNzyG4remuY5NlU3ELtlDn
         jOXD4jV2/j/4Nc/UcpmsJnrFHWk90OkdUrCyP4mCKRC2OWf0yu51hlSux2fBJgTmcDBJ
         CeusdkY0sahe+VDgdbVt84knnwpSUsTJq4sLNV34RYSrewi8Dnq+4Kv0tC7mTeHHo7od
         nrFZml2PyCGC95QxcXnHsk3pEC3GJ5rEvVSgwgmz/Ei1cIgB575GfaQAj3iBm7EZEsul
         YJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf0KxYjTQhZ9cbNoU3M+UcqCiaOWtVYPcdD8LAR9jPA=;
        b=4m5kbANTboaNyyPLvKCe1VYTWLkeQHAGg9Ab34PNpTUlEkZF2Q5e9hd3OvlyjTWvp6
         6/jK92B6I7DrSsu4n4uFed/KZzVadxKEupdV/wduHp5MXMPnWjFLPwNivfUclFQpdgRX
         5MOvn8a3zI7Eic4hKMY7p2btFCQitdI6/YO4fH+k7WWoVkYBrPwsSv4hs2LYOZkpIO5+
         bJbGtBKA06i9Cnn3Albz31MliRER5MqGkh3OftwjNKkfoV00H+glzMOTQLz9KkG+Vj2e
         pxcvqGpUqwgZyyeS809qIc5/VrSVddlJv0Moz/9LUcqTQRbSNNUJIrYDdQj0Lli7JZqG
         qMSQ==
X-Gm-Message-State: ACrzQf2ufYo92IT9wVukbavG3zdLV+WeYT9YXB0+q3BhhI32MwjRF8bC
        CJDneh9gHEKL+IZqzLBWzxJhyg==
X-Google-Smtp-Source: AMsMyM4Hpxo68V74qfwDOYRU6oHVklleTfTFoyqHjkRmalObtuUCGjJKG2F2AhosxDXwNLTR8STMYw==
X-Received: by 2002:ac2:58e3:0:b0:4b0:fa45:9423 with SMTP id v3-20020ac258e3000000b004b0fa459423mr1375372lfo.154.1668076430517;
        Thu, 10 Nov 2022 02:33:50 -0800 (PST)
Received: from localhost.localdomain ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id p22-20020ac246d6000000b00498f32ae907sm2687837lfo.95.2022.11.10.02.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 02:33:50 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/8] PCI: qcom: Add support for SM8350
Date:   Thu, 10 Nov 2022 13:33:40 +0300
Message-Id: <20221110103345.729018-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221110103345.729018-1-dmitry.baryshkov@linaro.org>
References: <20221110103345.729018-1-dmitry.baryshkov@linaro.org>
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

