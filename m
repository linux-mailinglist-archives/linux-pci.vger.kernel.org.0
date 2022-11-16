Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A850762CCFC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiKPVtk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbiKPVtV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:49:21 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE1B623B3;
        Wed, 16 Nov 2022 13:48:46 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f27so450871eje.1;
        Wed, 16 Nov 2022 13:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IVGXMtPYSMA+UPtByWaNjM4ICyi94eVWXqaBEQoY40=;
        b=QUQHMkopSuXeB2TzlkJM9ohIeMlxgnTox/jLzWwWhgsxVzj4Wz7gXr3r3uqFbj2HwU
         cZLAxzpF4VQK6ABEdtyQGJDsNCmoRTnDFk++cWa7dtprGufW2d27O18CjzQWaryNsFut
         R0xVsc8Q34X29Rv8QEilFa7VBgzWffAsjRpvNCgmYKGvd9FqIrwNe8efHS0aDRgXWaq0
         hq1ISQhVigLh1y3i0C5LIIKtzvwfwoV6khOeHyey/e1phgT57IhhBFN5JLRVIqB7zIzm
         sHHMMq+1ZDY1wIRkXttT3Jm23Ib7ZzcPgQOlJlCxrGLEjOVY0M5SWi2V5IVwYf4n9HcK
         oHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IVGXMtPYSMA+UPtByWaNjM4ICyi94eVWXqaBEQoY40=;
        b=xb1Wtcx4qkB+g+WrSxXIleqgJ+SmK0WMpyYJYw0vAcO5II/YkrZPDxZHX4eGj/Xixe
         cv2BUnYKpZSYWUPRdBeIe2SomlCY+t0P/iZvw9hrJUCKFtz8wkezqtNrrxtXMFfs3nq6
         TMXgHBgeoiR84ATE+oLaPWNw0UkHofFWic6iDA3F2MK54xbps6Ir+0t00E/W1LFfiRmB
         rldlExddD/urHOQ+IXmf97w0ymKfV2lAdut0StuwNNwX2xnuf/BW2rWH4tK0fZDP5Dyk
         06UyZKJtp/BAx18hY1ddBBJ9TBAuIDikirr0F0FX6F6HUrEyPcSgYQ6rhuVKsNPa+/p0
         1wEQ==
X-Gm-Message-State: ANoB5pnRAyZUrld9h0mjiNycy1KdoO7AsMp/LEresfFTCNLnN0T2Y4qD
        wYAK6GQd3J2/gEvQuJdfu5A=
X-Google-Smtp-Source: AA0mqf4gmyDBFFr9+aiyhdhMvqgDms3n+9Y48UvNXNTuI4hNYWAln/gD0HZjt6jh2xsE5DAvH5XgAA==
X-Received: by 2002:a17:906:7f92:b0:78d:4e5b:ffaa with SMTP id f18-20020a1709067f9200b0078d4e5bffaamr18365714ejr.455.1668635324556;
        Wed, 16 Nov 2022 13:48:44 -0800 (PST)
Received: from fedora.. (dh207-99-145.xnet.hr. [88.207.99.145])
        by smtp.googlemail.com with ESMTPSA id b14-20020aa7dc0e000000b00462e1d8e914sm7931341edu.68.2022.11.16.13.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:48:44 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/9] arm64: dts: qcom: ipq8074: fix Gen2 PCIe QMP PHY
Date:   Wed, 16 Nov 2022 22:48:33 +0100
Message-Id: <20221116214841.1116735-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Serdes register space sizes are incorrect, update them to match the
actual sizes from downstream QCA 5.4 kernel.

Fixes: 942bcd33ed45 ("arm64: dts: qcom: Fix IPQ8074 PCIe PHY nodes")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 4b4cd3eaf6c8..6649a758d8df 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -277,9 +277,9 @@ pcie_qmp1: phy@8e000 {
 			status = "disabled";
 
 			pcie_phy1: phy@8e200 {
-				reg = <0x8e200 0x16c>,
+				reg = <0x8e200 0x130>,
 				      <0x8e400 0x200>,
-				      <0x8e800 0x4f4>;
+				      <0x8e800 0x1f8>;
 				#phy-cells = <0>;
 				#clock-cells = <0>;
 				clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
-- 
2.38.1

