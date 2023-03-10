Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F91E6B3534
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 05:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCJEJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 23:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCJEIt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 23:08:49 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E6CD13DD
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 20:08:45 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 16so2335728pge.11
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 20:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678421325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tT4IStfyTS7c0lPgVozml2BSLbP+qQslzAxoVdPoGM=;
        b=mS8ca4KUr2oW5X7maBG1wnkmGrlRXMieICGs7WL15nmhwKqZnxDPkGMkDesTYkNAuR
         NdNUdiAPN7atsb9WUfUd8sg4EeATQ2uYIj75TFUAqruU+ZP5xXsxa1tl8JilZtM3Rpo5
         Eyc9kTf0n8rbfpbq/VsYLpfIFxYB7VvJkCGVIi0KOOJ600ccqhQ6uZ946z6JEVF8kUHl
         GOBN4m2okj0pU8tdCt3sYUdh46x8Z7DTvdXS5yYgPnDfKhKBDGFQAhTOugNeZJRBu+7W
         9iRstoNFMVeq4zx4VNZcecRu4rVMC5CNkqt8zTXBwsxLgxS8WD6asbBUlVi1Dmq6a4jh
         GT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678421325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tT4IStfyTS7c0lPgVozml2BSLbP+qQslzAxoVdPoGM=;
        b=GMw0t7uMXRpM5/NKdbfv1rqxJ9AQ5IKdqNr6CLbSU5NTD7Sm/lIdnzHJhK4Lg2JqIZ
         vSprJOIs8h/77m32SXg8iZMhbAOk01O6KZnryJrIwt+R8b0bu0BmGn4abDzMOLPLCZO1
         2aCxwTS7q78VJ/IMMIGo4inhKUBeSpl8YGNLB4oFu4rw9WUSE3gYQCD+JrrVakgT0DT5
         64eNTjeXrqmBO40G3fgrnxsWXWjf4287VoCPwJ6URfK30SlK3sysQikBKwsjqDZYqO83
         uOs8Rh4TPFqv4ezFMTVoM2HcZtY9pdDFN/abJOOxqd9QKSoaRxZuKZ1rlKCAGnZ1ye5f
         rm0w==
X-Gm-Message-State: AO0yUKX8a2CLIG9AIITBjohl8zsFbP6UY9UwP3KiNdxWeGuad2sbPIOz
        P8OIunvjlOhewArD2nO9W38/
X-Google-Smtp-Source: AK7set9nu0ilYfYPSNadD6JoU+N0HTVUl3h8rH+EtUOG1w270054r2Z4TCO6j/V71BnDSMyuGVvMZw==
X-Received: by 2002:aa7:941d:0:b0:5f1:f57a:b0c3 with SMTP id x29-20020aa7941d000000b005f1f57ab0c3mr21881195pfo.5.1678421324837;
        Thu, 09 Mar 2023 20:08:44 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.67])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b0058d92d6e4ddsm361846pfn.5.2023.03.09.20.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:08:43 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 03/19] PCI: qcom: Use bitfield definitions for register fields
Date:   Fri, 10 Mar 2023 09:38:00 +0530
Message-Id: <20230310040816.22094-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
References: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

