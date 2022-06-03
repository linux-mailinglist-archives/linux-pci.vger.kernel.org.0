Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F108D53C682
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 09:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242589AbiFCHlt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 03:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242591AbiFCHlr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 03:41:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13063703F
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 00:41:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h23so11345354lfe.4
        for <linux-pci@vger.kernel.org>; Fri, 03 Jun 2022 00:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NdSvHfXJPo04rlWXmRuhXyu21lDLotG2rBlKXKJ11GQ=;
        b=qHKt+mfVXAy1a7hsm0eSbpXXjaS+LeiEEFYyAOHt+OQBs1/ud5q5QpRX1Yseu63Tyv
         XogRUCXTgJaEK3+L0geBRWCEX4XMCWAHUxi0xS8u1cvlaEzWde3Bv1DlLl7Qm5Srehy1
         8uVwgDpUNq2BRDGxEUpOmdY/p2nhQ0VVHAkgnX5gj5EVt3WBEkmbwrKXIOmocpt9g1YS
         +m1FZNK8n9dzPJ2KI/NmSM6D+93jXAq1EYjW59B+fPnDJLQm0er2F9JzdCwnzqtQ0rKQ
         ys/GQIniZeDP2SJ+b6bmt0Fnv/fZV2qV3nQkKoBtA93VhstkugiWKpEVSKUQdXnrmPB9
         fvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NdSvHfXJPo04rlWXmRuhXyu21lDLotG2rBlKXKJ11GQ=;
        b=POc0yNfPL1qB33mgf5SEYtm5vVUycq4wHxOq08y2QJ4aNyAjykIKxgLdsqRsfUaqL1
         TpA94bPZIoXYC9U2BIr849kavdyx6pPNt0aI8BvFueLyrGChYKZAml50tJ9QLWYNnaTI
         WL58Z+mZ24VYo2rBrcISvEu/Epu9Lrt2Zgrint8ZTXEVyXM6otyjJmYGr14eHArkJ99I
         eh9853xFbJWvXOXQobLMCEUmZ33dQeQkLTcXI5Rda4B5cm2ja+tKpn/ckjYglEuZXhNg
         EsfObcR+8WLUlpoWcXY68OEhNZnd06g6ra0W/4xWL9/DpM6wfbZPKY7aDLfWmx3A/rq5
         TYYA==
X-Gm-Message-State: AOAM531MACo0UtTMvcacg3WxLW6w183U45BuI8L/rAiccD8MpD6k4Mn+
        zzfeCzyv3p99Z6c7z3A65nSrlEILDcYO8uQR
X-Google-Smtp-Source: ABdhPJyCxA7xPas0bEPrmKPCVWFrT95FSL4yJeYYBneaOV8B5+c1ZAIA/8lKqK+JzI6oND0PqCVBJQ==
X-Received: by 2002:ac2:5f48:0:b0:478:f230:52a5 with SMTP id 8-20020ac25f48000000b00478f23052a5mr5650522lfz.218.1654242104268;
        Fri, 03 Jun 2022 00:41:44 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x6-20020ac24886000000b00477b11144e9sm1450023lfc.66.2022.06.03.00.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 00:41:43 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v13 6/7] arm64: dts: qcom: sm8250: provide additional MSI interrupts
Date:   Fri,  3 Jun 2022 10:41:36 +0300
Message-Id: <20220603074137.1849892-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220603074137.1849892-1-dmitry.baryshkov@linaro.org>
References: <20220603074137.1849892-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On SM8250 each group of MSI interrupts is mapped to the separate host
interrupt. Describe each of interrupts in the device tree for PCIe0
host.

Tested on Qualcomm RB5 platform with first group of MSI interrupts being
used by the PME and attached ath11k WiFi chip using second group of MSI
interrupts.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 410272a1e19b..523a035ffc5f 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1807,8 +1807,16 @@ pcie0: pci@1c00000 {
 			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
 
-			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0", "msi1", "msi2", "msi3",
+					  "msi4", "msi5", "msi6", "msi7";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-- 
2.35.1

