Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61CC669E8F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjAMQr3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAMQrH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:47:07 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60987BDC5;
        Fri, 13 Jan 2023 08:44:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ss4so46355397ejb.11;
        Fri, 13 Jan 2023 08:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQcb/oB3xwlOm2s48lLOAq9nyVmzgn+8crtA0/+mZ6I=;
        b=EMGWF/60kpr/l/+9wKwakDK9XdOz38PcYFeA7MDzQldjdl4x03vknBOGOPhoFBMI+0
         /HIBACCJ/OuWYQnHFrvKnN758S7TWNsHCC3eI4BWDVGM0zQH9Ct4nYPP/LHeuwbz3okI
         WS2yn5yiskrYPSVKUA7x9zsPskcxd0br5xZWRUcjlRQV/ck2kOsNNfuXj6H15n8WgWsl
         opshIvdMpsqLo9yVKpErnzIk/flj4HA9FP6+8PQN9rmoRcHUzuSZqxi1XxFRa9AxEZXp
         sFV3Aw4lslSF4UuHYd5ruzo4m9aTgmHXq6LWqgZv15rmhtQ0hIFRWJ4mDOdtIkb0tAaC
         GTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQcb/oB3xwlOm2s48lLOAq9nyVmzgn+8crtA0/+mZ6I=;
        b=78cIM6vzJ9zfcqZCQ4X5kAC4Uyt494l6GeCE1IizFs9fteKt62rZAgkPWGgotGufkh
         alVgm7r/tY3uon/OqAd7ViHx8Tc7QtYTFUDNLLz+J5xspfhGTi9DhaMPK0Du1DNQn+v8
         ktXV074ScLNiNHRCUR6NerGsziwtxOsQANmhI/z0qfi1c0H8SPtBQkxg3cQLi9H+oedB
         Cr4d+NbgZmq5Kt75XjD7x1A98WCANhpWcRkBbVzyPecDyyfRqM4YG4Er8Kc9ANoZ5LTL
         nsKh8k3UzmSFYB4qeGJhTMwpZsqRYXY/5nT/YHREIp40DmNfRK4FwUnQjLT+esf+dyn8
         +Pyw==
X-Gm-Message-State: AFqh2kqUJLXepsZLCsA6ptsJHvOJQ7EoesP7pSh6hOGiXezwwna71JrQ
        o6aULrEL27WLErWGaxRjNoo=
X-Google-Smtp-Source: AMrXdXtq9iCGPs4Wpz7bJkFbhICFBu+rxsGSDjAFwBCgsNBgrK6z/7GUEyYpBoNZDufRG1jNqKEtYQ==
X-Received: by 2002:a17:906:6693:b0:7c1:8ba7:3182 with SMTP id z19-20020a170906669300b007c18ba73182mr77501370ejo.69.1673628294893;
        Fri, 13 Jan 2023 08:44:54 -0800 (PST)
Received: from fedora.. (dh207-97-147.xnet.hr. [88.207.97.147])
        by smtp.googlemail.com with ESMTPSA id sb25-20020a1709076d9900b007b2a58e31dasm8777831ejc.145.2023.01.13.08.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:44:54 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 3/9] arm64: dts: qcom: ipq8074: correct Gen2 PCIe ranges
Date:   Fri, 13 Jan 2023 17:44:43 +0100
Message-Id: <20230113164449.906002-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113164449.906002-1-robimarko@gmail.com>
References: <20230113164449.906002-1-robimarko@gmail.com>
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

Current ranges property set in Gen2 PCIe node is incorrect, replace it
with the downstream 5.4 QCA kernel value.

Fixes: 33057e1672fe ("ARM: dts: ipq8074: Add pcie nodes")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index c93e3f39f33d..06e1da176334 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -808,9 +808,9 @@ pcie1: pci@10000000 {
 			phy-names = "pciephy";
 
 			ranges = <0x81000000 0 0x10200000 0x10200000
-				  0 0x100000   /* downstream I/O */
-				  0x82000000 0 0x10300000 0x10300000
-				  0 0xd00000>; /* non-prefetchable memory */
+				  0 0x10000>,   /* downstream I/O */
+				 <0x82000000 0 0x10220000 0x10220000
+				  0 0xfde0000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
-- 
2.39.0

