Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0854968F65F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 19:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjBHSBN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 13:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjBHSBA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 13:01:00 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7DF521CE
        for <linux-pci@vger.kernel.org>; Wed,  8 Feb 2023 10:00:57 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg26so13933853wmb.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Feb 2023 10:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb47t2l6ksd+bCu6DOmZphj7wo/mr6EIlF/5BcCuaE4=;
        b=AZ99FsUvQ0+Pb9OlXvWZr/Nan0omCCHOaI/tIER8CEH79h29VMVKCqmwGrYpEHXh6n
         /iCAMCzWN/iNQGtcr+gEY12mqT0f6tU5k30k29xSyhWDyjpo57wkVUEGZRRqqyBdbW5z
         vLXKdezNh8RsbUVZETb2yq3YVHzPb/CPMmmN/PKAhEV/Hezxagn/hcm/7n6uklJtnxja
         ZIjlXzYY2xCh2PfVlnsLZKwaxZVhAS2i+Q+vOVVBhKA3Ossrj9RQFtKC7wg6XavLMKFx
         sPdVBOT01NPOjRxarfcS4jQkMwObqKStuhTuGYqQFHMlrHqBzKoCYlDUgcfOWQAKXM5w
         3jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb47t2l6ksd+bCu6DOmZphj7wo/mr6EIlF/5BcCuaE4=;
        b=1JCD2LxzJVjw1SNKmonzl9AvYV1H8Rq5crY+WeTFYl7ECcoOmql6zmunlYh8v56xnv
         43lsFZRIqfeQ1tuoR+V3Kx9amMdNJh0J76yf3e23nCtE9iVOVhpdwgh+RnOupgpJ8Bcz
         wtPGf1eBqDGsM0GC8DNwdjumA8ad5k7wZsL6Dl9i5A6ojpv9SIzt+d2g19tGYGP7odxw
         3+CIiHsiMgRmwCvdYGFCxVFUDL0EzbzGfml9HCa/zusmqzUUxMa19DkdtpB68/pokuQW
         tCV+QEg89vFs2QRKwP0L6uoF8uqubNLPdPoSCFt5QM43h8mXi3DiQNkX7FPr7uKhBnHK
         s43A==
X-Gm-Message-State: AO0yUKXmR8KMB+jXkI+2ac5mtGAt2gJlgExDP/x3gXji4sdpRuNPz071
        LDhSxGIPDEHTZjaU0azzrIjNA3o68msm3S/4
X-Google-Smtp-Source: AK7set/yTlx2HJiDa0+9pbzNMpDY827dwcNmDwOw93SrLk+ubba+YP7GKpkXg90XEkBf5nUOkbiJCg==
X-Received: by 2002:a05:600c:3423:b0:3dd:b0b3:811b with SMTP id y35-20020a05600c342300b003ddb0b3811bmr7384281wmp.31.1675879256874;
        Wed, 08 Feb 2023 10:00:56 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c169400b003dc54eef495sm2370286wmn.24.2023.02.08.10.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:00:56 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v9 06/11] phy: qcom-qmp: qserdes-txrx: Add v6.20 register offsets
Date:   Wed,  8 Feb 2023 20:00:15 +0200
Message-Id: <20230208180020.2761766-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208180020.2761766-1-abel.vesa@linaro.org>
References: <20230208180020.2761766-1-abel.vesa@linaro.org>
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
PCIE g4x2. Add the new qserdes TX RX PCIE specific offsets in a
dedicated header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

The v8 of this patch is:
https://lore.kernel.org/all/20230206212619.3218741-7-abel.vesa@linaro.org/

Changes since v8:
 * none

Changes since v7:
 * none

Changes since v6:
 * none

Changes since v5:
 * none

Changes since v4:
 * none

Changes since v3:
 * added Dmitry's R-b tag

Changes since v2:
 * none

Changes since v1:
 * split all the offsets into separate patches, like Vinod suggested

 .../phy-qcom-qmp-qserdes-txrx-v6_20.h         | 45 +++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  1 +
 2 files changed, 46 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
new file mode 100644
index 000000000000..5385a8b60970
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_PCIE_V6_20_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_PCIE_V6_20_H_
+
+#define QSERDES_V6_20_TX_RES_CODE_LANE_OFFSET_TX		0x30
+#define QSERDES_V6_20_TX_RES_CODE_LANE_OFFSET_RX		0x34
+#define QSERDES_V6_20_TX_TRAN_DRVR_EMP_EN			0xac
+#define QSERDES_V6_20_TX_LANE_MODE_1				0x78
+#define QSERDES_V6_20_TX_LANE_MODE_2				0x7c
+#define QSERDES_V6_20_TX_LANE_MODE_3				0x80
+
+#define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_2			0x08
+#define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_3			0x0c
+#define QSERDES_V6_20_RX_UCDR_PI_CONTROLS			0x20
+#define QSERDES_V6_20_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3		0x34
+#define QSERDES_V6_20_RX_IVCM_CAL_CTRL2				0x9c
+#define QSERDES_V6_20_RX_IVCM_POSTCAL_OFFSET			0xa0
+#define QSERDES_V6_20_RX_DFE_3					0xb4
+#define QSERDES_V6_20_RX_VGA_CAL_MAN_VAL			0xe8
+#define QSERDES_V6_20_RX_GM_CAL					0x10c
+#define QSERDES_V6_20_RX_EQU_ADAPTOR_CNTRL4			0x120
+#define QSERDES_V6_20_RX_SIGDET_ENABLES				0x148
+#define QSERDES_V6_20_RX_PHPRE_CTRL				0x188
+#define QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET		0x194
+#define QSERDES_V6_20_RX_Q_PI_INTRINSIC_BIAS_RATE32		0x1dc
+#define QSERDES_V6_20_RX_MODE_RATE2_B0				0x1f4
+#define QSERDES_V6_20_RX_MODE_RATE2_B1				0x1f8
+#define QSERDES_V6_20_RX_MODE_RATE2_B2				0x1fc
+#define QSERDES_V6_20_RX_MODE_RATE2_B3				0x200
+#define QSERDES_V6_20_RX_MODE_RATE2_B4				0x204
+#define QSERDES_V6_20_RX_MODE_RATE2_B5				0x208
+#define QSERDES_V6_20_RX_MODE_RATE2_B6				0x20c
+#define QSERDES_V6_20_RX_MODE_RATE3_B0				0x210
+#define QSERDES_V6_20_RX_MODE_RATE3_B1				0x214
+#define QSERDES_V6_20_RX_MODE_RATE3_B2				0x218
+#define QSERDES_V6_20_RX_MODE_RATE3_B3				0x21c
+#define QSERDES_V6_20_RX_MODE_RATE3_B4				0x220
+#define QSERDES_V6_20_RX_MODE_RATE3_B5				0x224
+#define QSERDES_V6_20_RX_MODE_RATE3_B6				0x228
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 760de4c76e5b..e5974e6caf51 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -23,6 +23,7 @@
 
 #include "phy-qcom-qmp-qserdes-com-v6.h"
 #include "phy-qcom-qmp-qserdes-txrx-v6.h"
+#include "phy-qcom-qmp-qserdes-txrx-v6_20.h"
 
 #include "phy-qcom-qmp-qserdes-pll.h"
 
-- 
2.34.1

