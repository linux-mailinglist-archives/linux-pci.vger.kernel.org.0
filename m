Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE75542DDD
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbiFHKa6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 06:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbiFHK36 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 06:29:58 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E183196AA6
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 03:22:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b12so11221893ljq.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Jun 2022 03:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pC4EIqDh/2k4QfHSQk4lkvNH/kEKDI9RyvpXo+8JMnk=;
        b=ZqbsqBttLI2/QAztbM63zCCkXktXV/naNAJlpPVNfKiN5ydI4vsFpGkZgnDheLqYZX
         sofUMm8W8V4kRlMpIUqd4RPKWOV3xV4GYO2KZENq48qb364KK9I8DCGBMUy+Plu1P0Uv
         rFZB3d77i7j0XfPLXIvEZKpXQOVFbE8kmT2Lgz2OL500gYzKrv88+k1RwQaso59laQbF
         u/yzELmjJuNG3dHn7A/M26t0gOTa4GCXESWCAcUSftA1o7JcUUKpjlT5Gnz4F+ge350+
         NiOtEP7jf7T+hTI3b6GtjJFkcvTT0LzMgp1ziffyVGLUhUy06/AsqeX5zLnmLlyPwTyj
         HbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pC4EIqDh/2k4QfHSQk4lkvNH/kEKDI9RyvpXo+8JMnk=;
        b=xcGNJqqxUsffLPK+Te17yYCBYWgIjjdyBbmtZ8tp/5l/QMDuGutEl5JnLSTpUzvvWe
         vidWKG+00CO/rrrdMAG8wU6edxuZBe4A4Ziq+2himhk/qXP/Ye7acQ7zdNIqNgonDPGY
         g9w0PRlxua/Eafnf6+dlVjMfwC5mrYKVCFRMWXkxXTbSLqAGsfSxdaEjVurp2toCH8I9
         c4dCNCTqddC0/yxEKuJcgcYq8MGxaGK7nI8trqanVTHRVA6c82OH1RFfBPwAbio+5MvY
         0N93/k3VaYQ5pHq8EVt6g2q1wvysTR9FOOzpxVwWcJmK1fiSwswk+c3+6420i7Emg5kN
         Yizw==
X-Gm-Message-State: AOAM530Y5Aoa8OhXXjeFDXmgqXolBDgc30vIuTDe0q1YnmJ0RVoaze8A
        dGUhzFGQGp56m4m7D9SvNP2llg==
X-Google-Smtp-Source: ABdhPJzKS7kV9XMeU1sky19hyCpIn5ezzTFhW+OQjIcVPz5LsHtQaqxUGS21lp3yojuJ0ZNfCyYQ1g==
X-Received: by 2002:a2e:914d:0:b0:256:8a93:2ca8 with SMTP id q13-20020a2e914d000000b002568a932ca8mr508421ljg.502.1654683736997;
        Wed, 08 Jun 2022 03:22:16 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v1-20020ac25601000000b00478fe3327aasm3642934lfd.217.2022.06.08.03.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 03:22:16 -0700 (PDT)
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
Subject: [PATCH v14 6/7] arm64: dts: qcom: sm8250: provide additional MSI interrupts
Date:   Wed,  8 Jun 2022 13:22:07 +0300
Message-Id: <20220608102208.2967438-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220608102208.2967438-1-dmitry.baryshkov@linaro.org>
References: <20220608102208.2967438-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
index 0147fa9ee475..0fa17ccfb0ab 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1808,8 +1808,16 @@ pcie0: pci@1c00000 {
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

