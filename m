Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE9679862
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 13:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjAXMrm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 07:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjAXMrd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 07:47:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829EC44BF6
        for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2023 04:47:30 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h16so13739907wrz.12
        for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2023 04:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFBkuvtetMyA2vbn4jahCuNYU+8hrzopKaFFwop4SZI=;
        b=jE02fEGjOFvG1AoGZgW0GBwlYGRB9P3np8xGjXm/gJTIMCpJtERwgbalYuN+QkK9Zn
         cBgfQzp+fBETYDEioNPK4aZhrSHPTK/08FD/J1YYqrmCypAmeTRK5gD626MqLXwUm32B
         UhWx37OzmMIa3q/jb3XS99dtn3mSxKfCISvjlr4nd+M/CNX408VQA7kN2Uc9tJfJlwDt
         4E8u4+EX1iIlIF4wxQ52lLtt4TTKYtffvMng4pSCOBzNTzd8aCxpjojRj1pME7WrpP7e
         7qZLSpF1PONiD+GVoJQrqMjvX5JeYcqUkdJCXtk0vGS8YsKeQQgVsirPKHIRegp18RKL
         bYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFBkuvtetMyA2vbn4jahCuNYU+8hrzopKaFFwop4SZI=;
        b=7FMb6CTlzl0Ct/DVTEQ8KeEXx4sCSvPNIMS3ViNUuPtBWeT1LbWjHYmFUy6walFQXF
         qWQ4M126v1Ylxy3s8eOBCeqXXAcwwRLowRoo2nmbrThur6uWfgNZ0Eh6eXV9U91HAKCv
         ZvDkJY761TJCff4obBdgFGXCgbNUHyK2x+Cy84VHcuqdUKty8JoG6Q6Qfy8pfcicUiwu
         1rQtBgMP2YsUsGvrmJH+5neVL/VSM/Qtbcr2crqwAiFBRaXnboxMcu6TJX+mk8RpeCsp
         IOpXlKmk88/rwCl4cKU7Rnge44GqYxDm74IgGIEPZY6XMGGqWZWLjMJs/m+I2BGjumlM
         6kfw==
X-Gm-Message-State: AFqh2krdDmV42+SJzCtxFWz0qgwqCZ20A8Dq6RZn0mMhEe0jfhEQl1ym
        UhA9YiezF0Voy+O/VLNXJ1zD2w==
X-Google-Smtp-Source: AMrXdXvSqHRDI8ajohJ1BTzOoXptM09dl9yqmdyK50yIIzzbBuD8UIpUbmnanwDQNyXB54jPrftPQg==
X-Received: by 2002:a05:6000:1290:b0:2b6:8a41:a949 with SMTP id f16-20020a056000129000b002b68a41a949mr23548147wrx.46.1674564449016;
        Tue, 24 Jan 2023 04:47:29 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d5705000000b002bdbde1d3absm1766840wrv.78.2023.01.24.04.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 04:47:28 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 05/12] phy: qcom-qmp: pcs-pcie: Add v6.20 register offsets
Date:   Tue, 24 Jan 2023 14:47:07 +0200
Message-Id: <20230124124714.3087948-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124124714.3087948-1-abel.vesa@linaro.org>
References: <20230124124714.3087948-1-abel.vesa@linaro.org>
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

The new SM8550 SoC bumps up the HW version of QMP phy to v6.20 for
PCIE g4x2. Add the new PCS PCIE specific offsets in a dedicated
header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

This patchset relies on the following patchset:
https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/

The v4 of this patch is:
https://lore.kernel.org/all/20230119140453.3942340-6-abel.vesa@linaro.org/

Changes since v4:
 * none

Changes since v3:
 * added Dmitry's R-b tag

Changes since v2:
 * none

Changes since v1:
 * split all the offsets into separate patches, like Vinod suggested


 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |  1 +
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h    | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index d4ca38f31e3f..bffb9e138715 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -30,6 +30,7 @@
 #include "phy-qcom-qmp-pcs-pcie-v5.h"
 #include "phy-qcom-qmp-pcs-pcie-v5_20.h"
 #include "phy-qcom-qmp-pcs-pcie-v6.h"
+#include "phy-qcom-qmp-pcs-pcie-v6_20.h"
 #include "phy-qcom-qmp-pcie-qhp.h"
 
 /* QPHY_SW_RESET bit */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
new file mode 100644
index 000000000000..e3eb08776339
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_PCIE_V6_20_H_
+#define QCOM_PHY_QMP_PCS_PCIE_V6_20_H_
+
+/* Only for QMP V6_20 PHY - PCIE have different offsets than V5 */
+#define QPHY_PCIE_V6_20_PCS_POWER_STATE_CONFIG2		0x00c
+#define QPHY_PCIE_V6_20_PCS_TX_RX_CONFIG		0x018
+#define QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_DRIVE	0x01c
+#define QPHY_PCIE_V6_20_PCS_OSC_DTCT_ATCIONS		0x090
+#define QPHY_PCIE_V6_20_PCS_EQ_CONFIG1			0x0a0
+#define QPHY_PCIE_V6_20_PCS_EQ_CONFIG5			0x108
+#define QPHY_PCIE_V6_20_PCS_G4_PRE_GAIN			0x15c
+#define QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG1	0x17c
+#define QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG3	0x184
+#define QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG5	0x18c
+#define QPHY_PCIE_V6_20_PCS_G3_FOM_EQ_CONFIG5		0x1ac
+#define QPHY_PCIE_V6_20_PCS_G4_FOM_EQ_CONFIG5		0x1c0
+
+#endif
-- 
2.34.1

