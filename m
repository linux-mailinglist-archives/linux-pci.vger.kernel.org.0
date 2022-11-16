Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7A962CD14
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiKPVtw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiKPVt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:49:27 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2395E3DA;
        Wed, 16 Nov 2022 13:48:55 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id k2so436933ejr.2;
        Wed, 16 Nov 2022 13:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHuhgPHSj8IDOBxbmjfqfqORtE7/J1Jlb4tgqi6UVDE=;
        b=Sr6BfiXrEdlf7+JlYNVLh2dfmHB/RI6a+Yz2hRXI8rI9bdAhQjfLn4PPpP9TZwdb6/
         lGhEs4XanagWTgXPE+QyXuRvatIMhah6dAMl/UyTWoTERpPhSiiITRLCwtQEc5iYguaY
         6WhH70/9d91wmUgkzJ+jbBCXGRch5o2RGxaOFx9bWPxqAuj/9rg2Yms3/TfTCEYc9SGF
         qk/xDP40z8sajB+ZBPJWOJX/BDlNnA8Cli/sQSyQnJ63yAehR5OzRP3oJND2iGcnxFKa
         tPU6o2E3JiIENGLDoLis2Bk7eU+flaemaFzpiTFjCXgc47UZoQf42+0KW9nQYpGs0Shd
         kcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHuhgPHSj8IDOBxbmjfqfqORtE7/J1Jlb4tgqi6UVDE=;
        b=Yxrq7kOHckRtxKFkc2NgzYsOcLZTWNUlLIOr3VyMH9CSq1a/L0xW27g5//DtHt3Wud
         353Z5ykPBmMHdNILbVMl8eIjWfztJata+7JTLziotnW4//LSzPotv9OEBNnHEVFdqGM/
         MhHO+67Q9ADD9EUgCED1H2QsOnb+YQTaHU4qDwcNTdtu39qImj0OhchDlFGp3keo2WMU
         GQ+6xkJOwe9VvcHAczxM0mTAb0iZJP48/JArsFHHEMnrf+BpuAGyZn3DAbihdq4bMb7/
         N/57x5XVPW1Zm5z8no9IaeVQutf3s2nGlQh7xaapuUs1+ae7xPOpFe71VovUjOOJLbAI
         oSVw==
X-Gm-Message-State: ANoB5pki6RBLeBsR567/puEm1A22RMPQzGg75Z+jzT+H4yBAPETwrATp
        bLxMjzRkTmIrCjXiPX1mYlA57ufPxMm0SA==
X-Google-Smtp-Source: AA0mqf5DeJNpPuMAbvD4YJAjKWmy9T2UQkGZYDB2OKfoDWvaKREc/H7yJj5zFEtSP7tBuB1ez6S6Bw==
X-Received: by 2002:a17:907:2123:b0:7a2:335e:90e2 with SMTP id qo3-20020a170907212300b007a2335e90e2mr18917059ejb.712.1668635335000;
        Wed, 16 Nov 2022 13:48:55 -0800 (PST)
Received: from fedora.. (dh207-99-145.xnet.hr. [88.207.99.145])
        by smtp.googlemail.com with ESMTPSA id b14-20020aa7dc0e000000b00462e1d8e914sm7931341edu.68.2022.11.16.13.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:48:54 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 9/9] arm64: dts: qcom: ipq8074: correct PCIe QMP PHY output clock names
Date:   Wed, 16 Nov 2022 22:48:41 +0100
Message-Id: <20221116214841.1116735-9-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116214841.1116735-1-robimarko@gmail.com>
References: <20221116214841.1116735-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Current PCIe QMP PHY output name were changed in ("arm64: dts: qcom: Fix
IPQ8074 PCIe PHY nodes") however it did not account for the fact that GCC
driver is relying on the old names to match them as they are being used as
the parent for the gcc_pcie0_pipe_clk and gcc_pcie1_pipe_clk.

This broke parenting as GCC could not find the parent clock, so fix it by
changing to the names that driver is expecting.

Fixes: 942bcd33ed45 ("arm64: dts: qcom: Fix IPQ8074 PCIe PHY nodes")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index c76c6ee9acb6..6f5d447c9ee7 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -257,7 +257,7 @@ pcie_phy0: phy@84200 {
 				#clock-cells = <0>;
 				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
 				clock-names = "pipe0";
-				clock-output-names = "pcie_0_pipe_clk";
+				clock-output-names = "pcie20_phy0_pipe_clk";
 			};
 		};
 
@@ -285,7 +285,7 @@ pcie_phy1: phy@8e200 {
 				#clock-cells = <0>;
 				clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
 				clock-names = "pipe0";
-				clock-output-names = "pcie_1_pipe_clk";
+				clock-output-names = "pcie20_phy1_pipe_clk";
 			};
 		};
 
-- 
2.38.1

