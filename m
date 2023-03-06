Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE29F6AC529
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCFPds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCFPd1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:33:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0D21BFD
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:32:53 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso13540910pjb.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tT4IStfyTS7c0lPgVozml2BSLbP+qQslzAxoVdPoGM=;
        b=qzFYJbB7hAFe7l46nHpK+q27pyKOro8dHeXLkSvKdgHRTDwrDJvyUujUSPZYQ9E0R3
         KYRq24VUy+YZsbMCTHh5ZSYTwSlJ3owoPJWfAk+9h9ntwKEOY3MTr4wyMvraBRjfEa2C
         qYJCImXGHxsET7RQLe6K/OcDYFMh+qMcuOJBWyvMx20JN+PVgtRWqAIYXlCDwO/IYbZU
         8P+k6hbuGqcI8nqTQVtl9VCb3YjDrl/slsZYXfLYkWsiPzC5HLQzf11f20Y4li9/jmQE
         RKkJM9s74mWLsvwp5yHrISGrnl97nHwk5Rag4jxMSmDoH8WQf50i87CnLCQTzSVpi1Hu
         pJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tT4IStfyTS7c0lPgVozml2BSLbP+qQslzAxoVdPoGM=;
        b=UKYqT8YaDf/+GNpxVxnzNIraOx3I4+oMaSlV2Mq2shCZ5cUaqQ4gfYF4wL0BFul2J2
         Us3DuI01FBABnNEQg7kSsYhoy+p867czy252bqifojHhYNGgvbo+79lveDebhOeDcskh
         /uxkLmuGq8vKuby46ULRfvrfbb+u8m55trRvt7Wi5OZ9P6f3ovE6Uyg9RaV/52axbj/V
         LXdr/eKmPxDWPhbV4hoWoBfs5I3G52OrDPx8BYsRGwBrNyYfqu8nG3ADMKUpSIDhSshL
         odXjZaFSsYXPR4Uo1uSwTdWzYZOZ+sCdUeYu7ZljcEyBY0bDnNeet/pQg2MH6oiYhPQy
         gjZg==
X-Gm-Message-State: AO0yUKXNH6jm0nYqnONM16uMa52AY1cRJ+K9MH22wvMk9baMF7x6W0hd
        7b1aueXpcRg97ldoin5zlSRv
X-Google-Smtp-Source: AK7set+rfW5mUC6Jzv3XUSjoc31D9wyI3xcLM7qOSrxPZKjhLzoB90Ibrt4vWYqfAsj2sIV+sIHrmw==
X-Received: by 2002:a17:902:e844:b0:19c:ef4d:ea35 with SMTP id t4-20020a170902e84400b0019cef4dea35mr13099075plg.21.1678116771509;
        Mon, 06 Mar 2023 07:32:51 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:32:51 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 03/19] PCI: qcom: Use bitfield definitions for register fields
Date:   Mon,  6 Mar 2023 21:02:06 +0530
Message-Id: <20230306153222.157667-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
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

