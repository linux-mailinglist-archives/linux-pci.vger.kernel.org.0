Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D23F624984
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 19:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiKJScO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 13:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiKJScL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 13:32:11 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907854D5CB
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 10:32:08 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id c25so1909252ljr.8
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 10:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kQxK8NfNtnZoSTX7rrGRiciyplegH3K6ehkOZtQW+E=;
        b=U01PAeiPFS2Y7qDuxW3DbYZwvOQbpCSH81D+jkRN+hP1m8aTXsoFg80zLwh3olKH19
         qVUOzA6MFwPkHBk9Am05Z7hZ7uisPOePQ+XqK1t5HIVOm/6eS3E8GTgt5Lkk3z1WWxOx
         mv5317Ln6OdSRcq4xa2i+RLNT+o9BkBPGNKN9r9PHeSB88Ev4GilLSEj3o/8VJXq+hGc
         iJaq2UZoPFfDq+viKewhOqbECPmn62tdVRZlwPfYLY8laIqnZyOYGMqZqD6XLxWlAf9B
         lPPbW3vPmQkHx8ukyb1Ed9gVoODT+HMX05AgqPs6qGeyxez+LZ2Rx+1JWXcWUDHQK67X
         1HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kQxK8NfNtnZoSTX7rrGRiciyplegH3K6ehkOZtQW+E=;
        b=JKi8hxLJobEZ1oLmGhyIWStBFGO1ZJEm6vcXncLHGV4B7hIMnZcgfwrSFdRa3cmEkk
         KnjnT3+Vpp96kAT6LSNnoeU+GIEVXUYvlVg/TZqSv4SbhgIaAuV21bbzH1O66UOg+d3a
         nUhq1pRFcGuitW7VBa+x8+YXGntwmp08MiYJZvbhPGzKgr/QpE83DJrzsTtjn0naXGI9
         oC6nfAQ5KTIchJ6cv/mwwARzlY02c6P9BK05rd84iK2/bV1nSPPMpR2FznA1Ek47o+IT
         bJFAF5I0GrN3i+Z8Fa5oMTEiRMbeKjWBkfqAjZLQRU7olUFSEqjrE3wH2UdTJ9JImLrO
         +Log==
X-Gm-Message-State: ACrzQf0Y1UXYkNdKeEwAfR13IZEWsgPDrMfKqOETtCubieiXW/K5yHIs
        Smh/YvAhthVXJxWmo8g2jXcNRA==
X-Google-Smtp-Source: AMsMyM5rV/gc33ltXWx966I4qPP19/94ZPZJtbpnZndyWoBe5Acmf9klXeJeH9USXuGsf/v4d90nEQ==
X-Received: by 2002:a2e:9057:0:b0:26f:bda0:cf0d with SMTP id n23-20020a2e9057000000b0026fbda0cf0dmr8727991ljg.227.1668105125517;
        Thu, 10 Nov 2022 10:32:05 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m18-20020a197112000000b004a2550db9ddsm2837087lfc.245.2022.11.10.10.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:32:05 -0800 (PST)
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
Subject: [PATCH v3 8/8] arm64: dts: qcom: sm8350-hdk: enable PCIe devices
Date:   Thu, 10 Nov 2022 21:31:58 +0300
Message-Id: <20221110183158.856242-9-dmitry.baryshkov@linaro.org>
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

Enable PCIe0 and PCIe1 hosts found on SM8350 HDK board.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 0fcf5bd88fc7..d3c851ec3501 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -222,6 +222,26 @@ &mpss {
 	firmware-name = "qcom/sm8350/modem.mbn";
 };
 
+&pcie0 {
+	status = "okay";
+};
+
+&pcie0_phy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l5b_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+&pcie1_phy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l5b_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.35.1

