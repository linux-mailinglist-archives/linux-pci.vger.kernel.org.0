Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E962C651294
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 20:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiLSTQD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 14:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiLSTPP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 14:15:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C88311C3E
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 11:14:50 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o12so10072845pjo.4
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 11:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAubOkJvINNojNKQySo7fdvunMLKmBVll3HExCwexwo=;
        b=JuHzAjEtS3z3AoG0EOBAtJfVoGmuEoBwfuq6bv4gk+GZhn3641lIsz8c8HCAhPdSg9
         FvbtOTJr/o5hDTHq05f6k7k1tYRrGOiH5LqagM9BEjUxIMLsIPqrGaudPeXxVSNvU/US
         o0Lu7Cw8x8A95clipBqMSjq+zul51e/SovIxqFgsXYlkyVzvwZOK+RLDFRZ+y5ZHlPOj
         FRmE5NGFNCoXlpeud0gPtFrAk2HU2zXev5LEZ7bSjZB54Gp5/V0qEy7q79flhleD7jc+
         MyIJTSrLO7wvOSMuxeqkJZFutH3kX+th0e8ZtgxdV1K8+Jk45wGeM400D+1zesaoZXiN
         tCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAubOkJvINNojNKQySo7fdvunMLKmBVll3HExCwexwo=;
        b=pSVCN8vvCSjBhxgIzcg3f+UbaX/Azoh260gvlmXtsX7DX6BHuxIJAAwBE7VkzYqcn/
         KQ4+0JsiySvOHD8aNjkCfypa65pDjw+Ss6ysXvWa3NwDkLaha4rW5ma68x5QgSQQcJPq
         NqfmtuZAYWjCKbS+2zclTsFOPMoSg2On67Mjy4YCd8iAKqpP3D4+42Y8aqJMtscQ/Rzk
         AoypY/y4HptUFgM7u/shuSGtRP9VsvmRC/O51N7laxuMoaQtDOqknnY7tMBjOjVPX2Jq
         PqwXQrGAZ8E6WHrznLtCe7wZhK45p2As0hN3LUpmxJ+m6qSvv7+VbzxPb4ACGJl5uou/
         QfPw==
X-Gm-Message-State: ANoB5pnFmIs9YakaX/lY0HEnPmrDi2rTAsa8xtOpdongSlkyLBCmjqVZ
        zEVOSaQRUW13nJGRx/fzs0H+
X-Google-Smtp-Source: AA0mqf7bcFYuSkhSlx4GdCaQjF/wzvulHntCyBcCywh+NNbwUHeolME6QXhdkW/x1vnDIOoLUlThdQ==
X-Received: by 2002:a17:90b:378c:b0:21e:1282:af42 with SMTP id mz12-20020a17090b378c00b0021e1282af42mr41810543pjb.40.1671477289675;
        Mon, 19 Dec 2022 11:14:49 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090a66c400b001f94d25bfabsm9485803pjl.28.2022.12.19.11.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:14:48 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0 and PCIe1
Date:   Tue, 20 Dec 2022 00:44:27 +0530
Message-Id: <20221219191427.480085-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219191427.480085-1-manivannan.sadhasivam@linaro.org>
References: <20221219191427.480085-1-manivannan.sadhasivam@linaro.org>
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

Both PCIe0 and PCIe1 controllers are capable of receiving MSIs from
endpoint devices using GIC-ITS MSI controller. Add support for it.

Currently, BDF (0:0.0) and BDF (1:0.0) are enabled and with the
msi-map-mask of 0xff00, all the 32 devices under these two busses can
share the same Device ID.

The GIC-ITS MSI implementation provides an advantage over internal MSI
implementation using Locality-specific Peripheral Interrupts (LPI) that
would allow MSIs to be targeted for each CPU core.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 570475040d95..276ceba4c247 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1733,9 +1733,9 @@ pcie0: pci@1c00000 {
 			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
 
-			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
-			#interrupt-cells = <1>;
+			msi-map = <0x0 &gic_its 0x5980 0x1>,
+				  <0x100 &gic_its 0x5981 0x1>;
+			msi-map-mask = <0xff00>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
 					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
@@ -1842,9 +1842,9 @@ pcie1: pci@1c08000 {
 			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
 
-			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
-			#interrupt-cells = <1>;
+			msi-map = <0x0 &gic_its 0x5a01 0x1>,
+				  <0x100 &gic_its 0x5a00 0x1>;
+			msi-map-mask = <0xff00>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
 					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-- 
2.25.1

