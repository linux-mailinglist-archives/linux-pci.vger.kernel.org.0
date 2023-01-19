Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B173673B25
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 15:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjASOFm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 09:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjASOFc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 09:05:32 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8727F7ED53
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:05:14 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l8so1615017wms.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyeL13YZKrFZSeb2gDbbHxN4JX31WKlESF/rHFow7sE=;
        b=ZRKip5HVUdnjlhj+OzcBXkF9F4RKUdb08F2ztKFvoylRckf8ggAXeIZ1QKkeFYnDSz
         qMlJ7CHRZuJEzk5VvE9SZpxKz+0lPlrIOd1ZxaXs0EUxE/ma65aPqyWGjvTVvNyPvjCR
         pmVC6zwKLe0/Fdqt3SovGMatgXWBzkCdcB4FHYnCCC7nWkVZGATZSact/cozycSOlBH4
         Xvv2Jdrb8Ja86ZtkOrUzC3+ShwgmF5nQQEgrr4SOwnaUwWgJz3JE4QaQ67KYDMWgxNjN
         nxxrOQbeK/2/Dh5WKh0lqRpCEjjeJD6ktWLtwGvo2/qJnOB7cr1BLXH21we9AyxLBHd+
         cD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyeL13YZKrFZSeb2gDbbHxN4JX31WKlESF/rHFow7sE=;
        b=Xlgz1pAf2LeWuz6vC/zrWJd8XcW7s/nVaoosPVAR7T7xc1ovNB7lBKYNt8r83nS7pg
         NUPE2tXAwestSOgSbY8lNbLiPCZGhKvBVO7GYid4p+900kfM7UVHhV3xW6b5rfQ6ijkb
         wY07/DtQJvm45Wr8W67DbR08AQ04086OHKhAesx+uvho7/WZ0n3C22kP/wOg+7r2unng
         hcdET7+8GoDVAaET7BePPrDtH2F64HxDxAIzM728mQjN9nJ78JwwAipHIi9pgLJE90tS
         YVQIpYx8TejaMOJ3MEQls4IyyLVbUnM5+Q/QMqqaHmKpDx7hdiyYsKABBGKgz7ipa48l
         2qSA==
X-Gm-Message-State: AFqh2krrHZhLWWUg8IW/ja5jD7cRRa9W59Ohe46kztLfFyklNRa2lyNt
        RBxYP2S097IHaKFIc8P8/B/gpg==
X-Google-Smtp-Source: AMrXdXub8fPxVZHqC/c1o/KGHIoo28vr5rZznO/eOHmKkx1NBHFoAto40rKERcZeMapqzaHLWD0RMQ==
X-Received: by 2002:a05:600c:a690:b0:3d5:64bf:ccb8 with SMTP id ip16-20020a05600ca69000b003d564bfccb8mr10321074wmb.12.1674137113049;
        Thu, 19 Jan 2023 06:05:13 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c4f4a00b003d96efd09b7sm5263883wmq.19.2023.01.19.06.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:05:12 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 04/12] phy: qcom-qmp: pcs-pcie: Add v6 register offsets
Date:   Thu, 19 Jan 2023 16:04:45 +0200
Message-Id: <20230119140453.3942340-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119140453.3942340-1-abel.vesa@linaro.org>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
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

The new SM8550 SoC bumps up the HW version of QMP phy to v6 for USB,
UFS and PCIE g3x2. Add the new PCS PCIE specific offsets in a dedicated
header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

This patchset relies on the following patchset:
https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/

The v3 of this patchset is:
https://lore.kernel.org/all/20230118005328.2378792-1-abel.vesa@linaro.org/

Changes since v3:
 * added Dmitry's R-b tag

Changes since v2:
 * none

Changes since v1:
 * split all the offsets into separate patches, like Vinod suggested


 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c        |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 21727e90fad1..d4ca38f31e3f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -29,6 +29,7 @@
 #include "phy-qcom-qmp-pcs-pcie-v4_20.h"
 #include "phy-qcom-qmp-pcs-pcie-v5.h"
 #include "phy-qcom-qmp-pcs-pcie-v5_20.h"
+#include "phy-qcom-qmp-pcs-pcie-v6.h"
 #include "phy-qcom-qmp-pcie-qhp.h"
 
 /* QPHY_SW_RESET bit */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
new file mode 100644
index 000000000000..91e70002eb47
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_PCIE_V6_H_
+#define QCOM_PHY_QMP_PCS_PCIE_V6_H_
+
+/* Only for QMP V6 PHY - PCIE have different offsets than V5 */
+#define QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG2	0x0c
+#define QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG4	0x14
+#define QPHY_PCIE_V6_PCS_PCIE_ENDPOINT_REFCLK_DRIVE	0x20
+#define QPHY_PCIE_V6_PCS_PCIE_OSC_DTCT_ACTIONS		0x94
+
+#endif
-- 
2.34.1

