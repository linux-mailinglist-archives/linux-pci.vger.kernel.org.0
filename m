Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C366865B031
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jan 2023 11:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjABK7L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Jan 2023 05:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjABK7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jan 2023 05:59:08 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949A9F27
        for <linux-pci@vger.kernel.org>; Mon,  2 Jan 2023 02:59:07 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q9so1158142pgq.5
        for <linux-pci@vger.kernel.org>; Mon, 02 Jan 2023 02:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKYbhDNGtqupbPRUKCCINaSoc+lb4pCR63iH2vtYHr8=;
        b=Qwt4rqH5AdvU0i3hJHzjsqhvUAZrYDolSqESxZJAMmrw+VIYKJC+RbPA4QQl1QQoT2
         jX5Eg9ekFa2WhQ7JoZ5BadUYSAblL31m5AIqWYV65kuDyMxS6xiasCLgCs0pZ77wH3t/
         BPg4cZTrKllvZ/Yk0k7J+zDcomYD4LdfsJN6og8iuNJ9O4R6L/Gz3gw46YxYVI94T6iA
         NNe1X2eOgBBdUF9Wf9hsey3bkjrV2pRICXhXhUKXjiIAZ7tzKzT7wimTyFk4/y+MZsTu
         AEQBp6EIXB2bt/iAZbYmnEXSBfFbd2QykcIeD+DO9PsN17IjE7XyUYK2ApKxvADUkUpy
         KBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKYbhDNGtqupbPRUKCCINaSoc+lb4pCR63iH2vtYHr8=;
        b=e5mbXdjlYjQNgKPYnADV/t+dRGCNDJCyS9HuoewcyNVaHMY2eKosmrrdYsmJOCBojc
         3GntzR2s8l6EUV2A6IHfJOJ3egTNL5TqNg35J7lY6GVDfuAD1ZnNNVIzp0Xdlo/pQeSa
         oqo+epQwpOt31FUayvMSMkq1iumHJ8K/pkkBHYt0v4+d+QAI8nFsF6Pyr1Twfn7GUQgr
         5Q7sm2RS2xGLg0ZH3s49mLCgOWNo3yQCV9CNBdBD6FLL06Sp18lutYiqn0M7u0Axs+Gx
         XgKEBBgo+cgRvwmL22TAyJVXwF1gbgtNCih+h8+IMDPxc9kLnQxLfmvc8qKwwsUxtxTq
         lFUg==
X-Gm-Message-State: AFqh2krvbvTfDrJn5bw/4JxbDWkX5WvWhZmKCKFZw5LfiHT44K+rFID2
        ShzOnu+sZfOvwt5VDTkFE/xD
X-Google-Smtp-Source: AMrXdXs/oDbtqNDAcqgwBH/WGHqDA/PlPcKdwRPMBMnmmaFF114TWVFgqj31yZ4L/Uhz1o8JopW2Mg==
X-Received: by 2002:aa7:8215:0:b0:580:9151:afe5 with SMTP id k21-20020aa78215000000b005809151afe5mr33795493pfi.22.1672657147061;
        Mon, 02 Jan 2023 02:59:07 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.187])
        by smtp.gmail.com with ESMTPSA id k26-20020aa79d1a000000b0058130f1eca1sm12756773pfp.182.2023.01.02.02.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 02:59:06 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lpieralisi@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/3] arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0 and PCIe1
Date:   Mon,  2 Jan 2023 16:28:21 +0530
Message-Id: <20230102105821.28243-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230102105821.28243-1-manivannan.sadhasivam@linaro.org>
References: <20230102105821.28243-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both PCIe0 and PCIe1 controllers are capable of signalling the MSIs
received from endpoint devices to the CPU using GIC-ITS MSI controller.
Add support for it.

Currently, BDF (0:0.0) and BDF (1:0.0) are enabled and with the
msi-map-mask of 0xff00, all the 32 devices under these two busses can
share the same Device ID.

The GIC-ITS MSI implementation provides an advantage over internal MSI
implementation using Locality-specific Peripheral Interrupts (LPI) that
would allow MSIs to be targeted for each CPU core.

It should be noted that the MSIs for BDF (1:0.0) only works with Device
ID of 0x5980 and 0x5a00. Hence, the IDs are swapped.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 570475040d95..c4dd5838fac6 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1733,9 +1733,13 @@ pcie0: pci@1c00000 {
 			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
 
-			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
-			#interrupt-cells = <1>;
+			/*
+			 * MSIs for BDF (1:0.0) only works with Device ID 0x5980.
+			 * Hence, the IDs are swapped.
+			 */
+			msi-map = <0x0 &gic_its 0x5981 0x1>,
+				  <0x100 &gic_its 0x5980 0x1>;
+			msi-map-mask = <0xff00>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
 					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
@@ -1842,9 +1846,13 @@ pcie1: pci@1c08000 {
 			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
 
-			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
-			#interrupt-cells = <1>;
+			/*
+			 * MSIs for BDF (1:0.0) only works with Device ID 0x5a00.
+			 * Hence, the IDs are swapped.
+			 */
+			msi-map = <0x0 &gic_its 0x5a01 0x1>,
+				  <0x100 &gic_its 0x5a00 0x1>;
+			msi-map-mask = <0xff00>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
 					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-- 
2.25.1

