Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715DD68F65A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 19:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjBHSBK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 13:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjBHSA7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 13:00:59 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2FD530E7
        for <linux-pci@vger.kernel.org>; Wed,  8 Feb 2023 10:00:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id r18so349189wmq.5
        for <linux-pci@vger.kernel.org>; Wed, 08 Feb 2023 10:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cig8x+DASIoHgM0lhJw7c8nOcZnMIzVBIm4rhxwpdQI=;
        b=CFD/xtGvafnWR1KJaRW8segO0sG7bJ5FIA728XF3pLAoWhWoR6LZRuCHW9zCIMzkve
         4Fu4+g/n8aHdItfBkLytj3damxBVW/ydd8KN3ZonBQ8Nl9LZ8mPcFQz+O5ygcPqQv/Ch
         qGl7hSXTKYV8IyKkZHzM1ZOWlpeZlcKGsVzw4jN7w6I8bKZsZIk/TYTMIHtaty0Rprtv
         4HgfvGr4s7NjPQeCmZdGeki3qqaFgPEs2uRTQNfzQ2wBograY43MB8ikihGAiyEpvh6P
         MKFH9/Y/CkXW3Gqy2qhnjJwuHS5A87EV6r5Urb0djsKwPxXxnBY6eIT45QlqD7DNOMqF
         1bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cig8x+DASIoHgM0lhJw7c8nOcZnMIzVBIm4rhxwpdQI=;
        b=FwZpFpLLeuqLgC5VSrkc+V03gHyJoOQ4XcKDZQi45/6IelMFprcOtsS2YOn8DSQilu
         FXOjnBwx5b5ToufK7+uJIRatJcYV5GPtYVrf/SxuZAefV8W6PUsMQpbqc4l8HnQRrndg
         Wi1WxziOFlQcPPi/xx6YwtpSfCFnB/q9HtDrIaf4vX9EoCbG+orUhDDdOREkb6xWjJ6U
         MSE3gKAwlSEaK8jZ5pKawX/vgMN0dv4CWs+2+r6FU8Pnwaycvu4tv9v1l9lvJy1ReQ56
         nd6VG9yqnr7Jhb++/95atRZkoiLefBgcdZ3Od30YqoKGhGYrcoKLUQNNWltx9GXD6LLN
         b5WQ==
X-Gm-Message-State: AO0yUKVB8PhIMLyJqPAaTFQqm/b6pnhF+jHkzQbLH9XUbiF+W9rSFgb5
        NjR3PrR+MCBuJdTXvIegtoaFkg==
X-Google-Smtp-Source: AK7set+uevGCDjXBaJSX7rfNlRHkcHw4RM/U9dJZVW5UCbgj8UF1zockXk7XELN2l+TE9mZ5nN41Kw==
X-Received: by 2002:a05:600c:502b:b0:3db:2e6e:7826 with SMTP id n43-20020a05600c502b00b003db2e6e7826mr9884278wmr.5.1675879255176;
        Wed, 08 Feb 2023 10:00:55 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c169400b003dc54eef495sm2370286wmn.24.2023.02.08.10.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:00:54 -0800 (PST)
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
Subject: [PATCH v9 05/11] phy: qcom-qmp: pcs-pcie: Add v6.20 register offsets
Date:   Wed,  8 Feb 2023 20:00:14 +0200
Message-Id: <20230208180020.2761766-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208180020.2761766-1-abel.vesa@linaro.org>
References: <20230208180020.2761766-1-abel.vesa@linaro.org>
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

The new SM8550 SoC bumps up the HW version of QMP phy to v6.20 for
PCIE g4x2. Add the new PCS PCIE specific offsets in a dedicated
header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

The v8 of this patch is:
https://lore.kernel.org/all/20230206212619.3218741-6-abel.vesa@linaro.org/

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


 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |  1 +
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h    | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 05b59f261999..907f3f236f05 100644
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

