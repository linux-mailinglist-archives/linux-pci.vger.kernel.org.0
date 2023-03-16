Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B574A6BC86B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 09:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjCPIME (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 04:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjCPIL6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 04:11:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB84B420C
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:11:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y19so439485pgk.5
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJaOatHkXHzyvqytIDMSmbgPdFymnikRC3HAjIyBTNw=;
        b=ATeuvXh+ip/RSWbMWqowlZ5kyyQAu8innMQy/r1n5x2ERYCX+e+JWpfIjVhZMLRFNw
         i93YgJsZwEb1zx8CAegPl4rZVDdGueeMUhC0CZ+guq588r0xRysrBWiO3A0AYLtjfg+V
         av1GSsiL6MOaByihTK7SzyNNmVkPZ2dhpLNoAfSrpgiTBCvigEnlOOxxDuZUlk4M1Oaw
         RDXC9uo7T3FNfNY7lId9yIGJTOxUiyC1VsBjRx8d625Gm7vqAF6kH0OuXpWO+fA/MO9q
         3BI+0agsIX3Sv0nYOlmAFtyeZL2kFKDaPnGxyT5uhXLWQhisMMt6eM1SCjf8gMZCtfY5
         LwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJaOatHkXHzyvqytIDMSmbgPdFymnikRC3HAjIyBTNw=;
        b=R2+XhQLrNjqzJBLlWETjFOrl0pjzMip+JhnZ0iksmos/riVjxWFlUJDzrg7Fs2gw/m
         QoLCS62/snavTRyGTnsJgJj1vOybQbk090T/fcSXuFPerrg3pNukwlOcyk5+mCxZHL6B
         fn0o0upiPlb17sXLqDHMnhgGbRscn1XjGnWudg/s0brs7Up/vSpviyS9gbajQZjVk9JH
         64W5pRSBky3E40zftANedDWFdEGOuOqW02PhWTzdZBvRm+UfxpPKmdT2RYDPPs25iikD
         YwidYNC3TY+2bQcCua/RpgFgqRPcmtfDPt1hd8W8CgoQCoQ0g5naZw3BTOrq9Sn8FNYe
         VN8w==
X-Gm-Message-State: AO0yUKXvRtMK4rPe4HXmfTKc2OHK3jeY0zgfi39edN60ejVGD/hMiSPw
        oJ+/M5qjR2J63yIJo8N71KTPBP36ppeSvIxLxw==
X-Google-Smtp-Source: AK7set9zlJH/2rVYbX/560KHzSFYy97KLIJopAHcuOpgp8lWwYB5SxVDlBw/CO4pZ2tOmSF9MesLHw==
X-Received: by 2002:a62:4e14:0:b0:625:cc63:642b with SMTP id c20-20020a624e14000000b00625cc63642bmr2455833pfb.14.1678954309984;
        Thu, 16 Mar 2023 01:11:49 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:11:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 04/19] PCI: qcom: Use bitfield definitions for register fields
Date:   Thu, 16 Mar 2023 13:41:02 +0530
Message-Id: <20230316081117.14288-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To maintain uniformity throughout the driver and also to make the code
easier to read, let's make use of bitfield definitions for register fields.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a33653d576b6..44c31c65695a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -76,24 +76,24 @@
 #define REQ_NOT_ENTR_L1				BIT(5)
 
 /* PARF_PCS_DEEMPH register fields */
-#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		((x) << 16)
-#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	((x) << 8)
-#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	((x) << 0)
+#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		FIELD_PREP(GENMASK(21, 16), x)
+#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	FIELD_PREP(GENMASK(13, 8), x)
+#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	FIELD_PREP(GENMASK(5, 0), x)
 
 /* PARF_PCS_SWING register fields */
-#define PCS_SWING_TX_SWING_FULL(x)		((x) << 8)
-#define PCS_SWING_TX_SWING_LOW(x)		((x) << 0)
+#define PCS_SWING_TX_SWING_FULL(x)		FIELD_PREP(GENMASK(14, 8), x)
+#define PCS_SWING_TX_SWING_LOW(x)		FIELD_PREP(GENMASK(6, 0), x)
 
 /* PARF_PHY_CTRL register fields */
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
-#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
+#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		FIELD_PREP(PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK, x)
 
 /* PARF_PHY_REFCLK register fields */
 #define PHY_REFCLK_SSP_EN			BIT(16)
 #define PHY_REFCLK_USE_PAD			BIT(12)
 
 /* PARF_CONFIG_BITS register fields */
-#define PHY_RX0_EQ(x)				((x) << 24)
+#define PHY_RX0_EQ(x)				FIELD_PREP(GENMASK(26, 24), x)
 
 /* PARF_SLV_ADDR_SPACE_SIZE register value */
 #define SLV_ADDR_SPACE_SZ			0x10000000
-- 
2.25.1

