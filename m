Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41062CD03
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbiKPVto (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiKPVtW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:49:22 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A83A61BB4;
        Wed, 16 Nov 2022 13:48:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id k2so435890ejr.2;
        Wed, 16 Nov 2022 13:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zruJLlJ8a35SxUsYi/AnlLXhcK2EHytmRl4aws2VY94=;
        b=kyOPa3lUh60eEhkr7o+pUaMMxRLpUAQ66gaxw/uWejMMCBj8tDKY8zuIDzxcgDunA8
         c0UwTpD2B1qVIssHrAzEFQghHwFQk6RS6HJe8Jcc2GUXrAYDSmOBFv7XPF+kvbT1/Hkr
         pXjR28HbBEz2EqrH6hrhEljm+pUYcaMF8Hj/Snks7Ic0R80fs3PFaRBIR7zmvrBkf/0w
         vao5nlgmEUsbzfxGzfNCwuCIpjS3HWRaSrpadF6jqOAFegsmniw875kFDjTbz4XWV7eG
         +QIc32uVacO9U2ggGz1D4i1B5k6b0DOBz/YbftVyNZCVmksdgnkYT+ZqCAcsnXROIGau
         Y9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zruJLlJ8a35SxUsYi/AnlLXhcK2EHytmRl4aws2VY94=;
        b=mgX70CH1fkyANQm+PnSmJq/6cwvowl5FmbVNQqD3R8GVNVWWvMRBs5mdFyZWBCnikE
         zIfYodOiCBSQAqbwVCRBghAt7zxRlgQe10Kg7+ndBu5N2mq7vKaUiIXBaW6vJD8sU+To
         mzeVq/huL40F+Av/aZKo63Inh33v5/+svjjdOu35SU7i34e+9oe0oAk+qLpvG4H+mxG+
         RmhZfTwemJl2KF4rcWTjnxhJRSuFUqkk3x6X0oqza/hY/YOpYxyljygEak83JCr4/7Oc
         jA+JAFBuopGMDIxF6WZqU89yA10wy/1DqQqIekdXKdG+DM+uFrkijNDTLuMod87D4528
         X+aA==
X-Gm-Message-State: ANoB5pn7fr2co46fUJccwH/flshV1U/BG1yc0Ci0d2aveGio643eIbTY
        tkzyHmstUh2DLN0oN2Uu4XM=
X-Google-Smtp-Source: AA0mqf71o5kWi/Zk9aWkbFyHvNX37a6arAehFk3futij85Uf2EAp50i3ceddljJPLJEF38UCRkCpyw==
X-Received: by 2002:a17:906:ccd0:b0:7a3:28c7:5835 with SMTP id ot16-20020a170906ccd000b007a328c75835mr19881415ejb.32.1668635327065;
        Wed, 16 Nov 2022 13:48:47 -0800 (PST)
Received: from fedora.. (dh207-99-145.xnet.hr. [88.207.99.145])
        by smtp.googlemail.com with ESMTPSA id b14-20020aa7dc0e000000b00462e1d8e914sm7931341edu.68.2022.11.16.13.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:48:46 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 3/9] arm64: dts: qcom: ipq8074: correct Gen2 PCIe ranges
Date:   Wed, 16 Nov 2022 22:48:35 +0100
Message-Id: <20221116214841.1116735-3-robimarko@gmail.com>
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

Current ranges property set in Gen2 PCIe node is incorrect, replace it
with the downstream 5.4 QCA kernel value.

Fixes: 33057e1672fe ("ARM: dts: ipq8074: Add pcie nodes")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 9503dfb25d50..b1decedbd080 100644
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
2.38.1

