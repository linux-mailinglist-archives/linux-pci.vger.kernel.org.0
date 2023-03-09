Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441246B1EAD
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 09:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCIIvi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 03:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjCIIvg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 03:51:36 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AC8D8874
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 00:51:28 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id i5so1280182pla.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 00:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tT4IStfyTS7c0lPgVozml2BSLbP+qQslzAxoVdPoGM=;
        b=iU7903JlmzBlp2BmGN+3jhJz3BVNyLMQJj5lIlGMAhFdARhYDAbCdtpAQvPSfzeIvo
         miTfd19DZ5Bcz7dOBZKDAWmDerNTeX/rKzU3XIusqxEUkWQmZQZeM8XlyQYmhemI2NTI
         oqa7Etm0N+KO3p9xbksrHHo8N93BwM4Qx3rLURuHMFwWUgRYznHLWyvrgKXBzWmHyRl0
         EgbPcz0SBK/E5a5Hcfmd5a0CI+Z5NgX2bmJ41A/hE1Xzu/TNcPSHBWP8+GFyw1OHeJj7
         MXSp6njLPwFYfZDp1h0XJ73uhR8iwFqQxAbr9aE5zBo8sRYfAeOr5jCRaB5Ajl9ROQFw
         ekpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tT4IStfyTS7c0lPgVozml2BSLbP+qQslzAxoVdPoGM=;
        b=QTMIldNY+Zf1jL33rIra2z9ogBLNosxAakh1jqSbnW4XWMosIoUTZM9EQ8nvuVKrjF
         oUQS9NqspXxSUmM1Fll/93z4rVh36V+0z1lEP6WnP0iroiqBJdE88fJ800RhJmz6U12f
         M8xFsShH3FapNrExPoN9E4eFTwYlcPfvsOHYwgoXB3dYt9+JBronhvxE5rPjrSz09dkX
         +9FBYDDl7JcQei2FGg/SkA7NM69KMh/1W3zJHgdMpnPPDaMBPYATS1nQHZc2e8MOk28V
         I8qrMQZfzvIZyRwUk04w/1+Y6OSw33SrdyB+chXRIDTcHAuEYdM5Dq7cGfmdrEkyEdnD
         gGGA==
X-Gm-Message-State: AO0yUKUWNrgRxE2B7RL9/baVYuGgUd6q8Ei8Yj3ZvG7sE4Z0QOs2oALg
        aHx82F8UQTs4Zm7NXtLj+Bju
X-Google-Smtp-Source: AK7set8mKlsyGlNy/0MkozUoptgR8oHYv6pYvoU1vXyZYVhpHo57kiSPNpYjNjORKjQeKOPGPgcwyg==
X-Received: by 2002:a05:6a20:9150:b0:be:d389:7abf with SMTP id x16-20020a056a20915000b000bed3897abfmr23782750pzc.3.1678351887847;
        Thu, 09 Mar 2023 00:51:27 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:51:27 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 03/17] PCI: qcom: Use bitfield definitions for register fields
Date:   Thu,  9 Mar 2023 14:20:48 +0530
Message-Id: <20230309085102.120977-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
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

To maintain uniformity throughout the driver and also to make the code
easier to read, let's make use of bitfield definitions for register fields.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 9223ca76640d..e9f4c70b719a 100644
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

