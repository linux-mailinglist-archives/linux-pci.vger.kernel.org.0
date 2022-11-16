Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD0B62CD00
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbiKPVtm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiKPVtW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:49:22 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3401BB4BF;
        Wed, 16 Nov 2022 13:48:47 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ft34so292518ejc.12;
        Wed, 16 Nov 2022 13:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAzlL7OKuIzPWhKNqIVY4e+Q/KWJKsIpn67snRSlq5k=;
        b=S1L7JT3kfhFzJvexPzawhRGIzZtK8vbX5F/Cl9BdBKHXUzQbK0tzFvPPrSnh+K65/v
         1VurS457YlnJKZPdcawp0ulfCMeBykRH8+NOEcuVJVvHrZNs+91NEfHOWhTI4EoZrphq
         IpXW5pzbI7MRWlTbjhwyfvN+oRsvbB3RvERwu/AviXyuXPnFKAAdPSXkIDPTTjV+9ohM
         F8YDZKHI2OogYYH3ST9gFx3bfaIpigJhRUwJeKFY1ZEYie36DlIykp5p1TcNIGEkfy/E
         n1j7cVuNYir010zsLryvHaM2l4tmhCivBgyUzI/J9OJ+hYvu5T/KLoyDzStIvySIFoj8
         PiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAzlL7OKuIzPWhKNqIVY4e+Q/KWJKsIpn67snRSlq5k=;
        b=PhbHipbZcsmWjyYycTCMD39B/hdKZZnI67rOup689qfHqJK1vZp2vt2vXl/2NU6CXV
         Msjk75W49Yee7oe6TT1c20E5DerfANr4gZQMw/dXj0UPWuMrf6VcfRxSo6JrRtX/zr/Z
         m7FUpfgW0IicS1PxHoQGFK8O3MMw0y2MN5nZk4SqKBhbW7Aw+2L62FHdsU9x9rTf1rZw
         XXCXSJomY5Th4FoOxfWwKMUQCkqBwUqDH5bLqXHXpZC0E69Q1Tnums0iki2f8oEDdB0c
         BNqw03ALaNRTCtmxOI30a89caad4Vt5xAgElT5Samg3e8N4EuGPV1kZhsD3hnc9mBqfp
         U/gA==
X-Gm-Message-State: ANoB5pmqi6jaxoyOUsn95Z5lCNNkj26gWV1TtBH8XMeCJf+5isBpB/zt
        a3U6ag5mZ/fMB5SDjtaHkmkvdf97R1eecw==
X-Google-Smtp-Source: AA0mqf6Pt48yxhIbrJIJfuPFQFyd5qu4eX39eJK6eGgqvgL2UrEIRYsyi5ylweoi/T0VKC9uFSx2IQ==
X-Received: by 2002:a17:906:c1ca:b0:7b2:7b45:2cd2 with SMTP id bw10-20020a170906c1ca00b007b27b452cd2mr6156357ejb.615.1668635325808;
        Wed, 16 Nov 2022 13:48:45 -0800 (PST)
Received: from fedora.. (dh207-99-145.xnet.hr. [88.207.99.145])
        by smtp.googlemail.com with ESMTPSA id b14-20020aa7dc0e000000b00462e1d8e914sm7931341edu.68.2022.11.16.13.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:48:45 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe QMP PHY
Date:   Wed, 16 Nov 2022 22:48:34 +0100
Message-Id: <20221116214841.1116735-2-robimarko@gmail.com>
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

IPQ8074 comes in 2 silicon versions:
* v1 with 2x Gen2 PCIe ports and QMP PHY-s
* v2 with 1x Gen3 and 1x Gen2 PCIe ports and QMP PHY-s

v2 is the final and production version that is actually supported by the
kernel, however it looks like PCIe related nodes were added for the v1 SoC.

Now that we have Gen3 QMP PHY support, we can start fixing the PCIe support
by fixing the Gen3 QMP PHY node first.

Change the compatible to the Gen3 QMP PHY, correct the register space start
and size, add the missing misc PCS register space.

Fixes: 33057e1672fe ("ARM: dts: ipq8074: Add pcie nodes")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 6649a758d8df..9503dfb25d50 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -232,9 +232,9 @@ qusb_phy_0: phy@79000 {
 			status = "disabled";
 		};
 
-		pcie_qmp0: phy@86000 {
-			compatible = "qcom,ipq8074-qmp-pcie-phy";
-			reg = <0x00086000 0x1c4>;
+		pcie_qmp0: phy@84000 {
+			compatible = "qcom,ipq8074-qmp-gen3-pcie-phy";
+			reg = <0x00084000 0x1bc>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -248,10 +248,11 @@ pcie_qmp0: phy@86000 {
 				      "common";
 			status = "disabled";
 
-			pcie_phy0: phy@86200 {
-				reg = <0x86200 0x16c>,
-				      <0x86400 0x200>,
-				      <0x86800 0x4f4>;
+			pcie_phy0: phy@84200 {
+				reg = <0x84200 0x16c>,
+				      <0x84400 0x200>,
+				      <0x84800 0x1f0>,
+				      <0x84c00 0xf4>;
 				#phy-cells = <0>;
 				#clock-cells = <0>;
 				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
-- 
2.38.1

