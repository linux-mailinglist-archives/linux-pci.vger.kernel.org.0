Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE017669E86
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjAMQr1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjAMQrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:47:05 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C790589BC3;
        Fri, 13 Jan 2023 08:44:53 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vm8so53606485ejc.2;
        Fri, 13 Jan 2023 08:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSYE2T82iOkVo5VndGHZGfvNrTv8HNJ4m9Ysiu68KwI=;
        b=Wud4UUW4I0LXXwykMW38HKJzeiS+ewkGf9GCGBhdspHzc/IDzmQhpNmnyBCs6aOYdb
         AOFYSdUSeTUxz+Lk/LMrl0vrloshPMfcXeLAvRWMFsQK4JQfsAOdwLCRljl2pVvlMpCi
         x3CtDMaKPlfQ0T2TZnDo1ymZMQVPoH30CwwGJTIPC68iU7Ab8TqoorI4yO5xAUQYX4qQ
         GQJBjp46izovE6xhsm0Z/KmMHtcDBVazocFosVTkV6i9gmD8IUrRWH65/oWuhmEVbBJy
         CMb5l+YCMMYObueKXEVUksnHUrYQvRnl9FpQG7m38BUjuQktrWnBYFXBgGUDiL6BD+m/
         Hnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSYE2T82iOkVo5VndGHZGfvNrTv8HNJ4m9Ysiu68KwI=;
        b=joRwul10fFjiQFOdFDPiYYbXgEmpArDQoMXzNJxXwyeSUxWMveUuOWIGSIcFgBWWHZ
         8NAFe0M8fNAy3y/j73bdUbdZqHA/BXix1VApN4ZikJdmz199uMgeNedotvVYb8asexve
         d1uff0lwUSrl8LReVlkcK1Ivp+31K3Af8Rnc2xnvNcnexHMCqDfT8aOzJNv0109a0pHf
         rImKjnI+8vfzSkTP1GRe3mCR+XqaZvNOKYGHj2t3mR39u8avqdRBzDPQeccsr6luCsVO
         U+Smjn7lWbjakNuNI8TfvjsIb71F2RhVDdlZB+V9h6/cDmSrw8CpPvgYoqoH+S61zgoK
         3y5w==
X-Gm-Message-State: AFqh2kpK5yqd/u9ZUKr6m4Nt35RqYMXhbdZ9tg5lzHh4ivjODovjDRzR
        HTEFoBQxpayP3f60VoqFgQA=
X-Google-Smtp-Source: AMrXdXvqoIZ2B8o5sGtzPTzKfxJ9Wfp6noZuF5fhPatuU42KuRg2fn6CbwBL6m8d/HLO/R+KZW0EYA==
X-Received: by 2002:a17:906:3095:b0:809:c1f4:ea09 with SMTP id 21-20020a170906309500b00809c1f4ea09mr63716609ejv.69.1673628292202;
        Fri, 13 Jan 2023 08:44:52 -0800 (PST)
Received: from fedora.. (dh207-97-147.xnet.hr. [88.207.97.147])
        by smtp.googlemail.com with ESMTPSA id sb25-20020a1709076d9900b007b2a58e31dasm8777831ejc.145.2023.01.13.08.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:44:51 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 1/9] arm64: dts: qcom: ipq8074: fix Gen2 PCIe QMP PHY
Date:   Fri, 13 Jan 2023 17:44:41 +0100
Message-Id: <20230113164449.906002-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.0
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
index 06e2f0157396..31ec24100213 100644
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
2.39.0

