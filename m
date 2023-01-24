Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A6E679858
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 13:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjAXMrd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 07:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjAXMr2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 07:47:28 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4A642BCD
        for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2023 04:47:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r2so13749536wrv.7
        for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2023 04:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXqaaiu8XcOEh/w0m5+ujekCyu2XVsl5TF8KZfGBrR0=;
        b=LYPF1xCatea+0wPnKT60w1baAG84QCdLtvjg9sX+tdToX4hVr+m3XlJqlNYvMdjS1b
         1KAZvzY4E9nTDQpE8OzcLOHKxkUIsoH+lAQnJ0cAPPPti9U2cFCsUJ1LExUcggX+yYKt
         0PhZKWOs81uLsYaRekOLndnsoVfFygdwIkk8otLBoP0kVLX43PB0hBgCfZQM0qOO0J6P
         l8J0rAqcooOYRtKXfZusS4tjmizcUpof+O0vAI1Gq8iVoUS+598WUJE8PHxIy3K0GeTL
         pTcqYqENrkd9C7T01ZlK2mrRRGnev4KJI1xum0kSaaeXtgfZnh0nFTlFOd5Oi3f1I25T
         oz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXqaaiu8XcOEh/w0m5+ujekCyu2XVsl5TF8KZfGBrR0=;
        b=D59xA+08sE8Kc7VIAH3NvtpntQeG5XisBLwh9j2F7RwXBKGyFsfHfO0RlSJurSQzbz
         vsyg2x4JjS9lqnmoRiEwhkRUbpnAScyxAPFhLyVd921XUF3AQMPUjKAJ9C9yk00IDZ7d
         h9SuHwDGZTsLNKY6RMZrkQ5mdIGFfP56xcnX3RdI6F24T70p4HFqkFMYXuEnr+NKwud6
         hu/xbo3M/JvjD58zWII4FEmEp8G98+vdcXLaywzdqEncxTk/D9AQVUHafTHny1Mcwfto
         GtYuxad+cVuImE+Zgs5S1zzdeNwZehcvRMzlzQTpRL5OIncusNlQBhPPIP4zAsp1MMOb
         u7Iw==
X-Gm-Message-State: AFqh2kqumHISiEYND4MJPfNVik8xgsQjy6SI1oN1Q3ndEWBWqTApxK6Z
        dbRSKOrDAwBAO3p0hAOytZi0cA==
X-Google-Smtp-Source: AMrXdXuhx5GwrYDDdFGgX1pXhJBJ9MEQAVy0Yi+kChQnWQd1wGb8EH5AP+N3bmVQdBHyQiES+HIl7w==
X-Received: by 2002:a05:6000:1006:b0:24f:5890:616b with SMTP id a6-20020a056000100600b0024f5890616bmr32418689wrx.56.1674564445728;
        Tue, 24 Jan 2023 04:47:25 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d5705000000b002bdbde1d3absm1766840wrv.78.2023.01.24.04.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 04:47:25 -0800 (PST)
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
Subject: [PATCH v5 03/12] phy: qcom-qmp: pcs: Add v6.20 register offsets
Date:   Tue, 24 Jan 2023 14:47:05 +0200
Message-Id: <20230124124714.3087948-4-abel.vesa@linaro.org>
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
PCIE g4x2. Add the new PCS offsets in a dedicated header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

This patchset relies on the following patchset:
https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/

The v4 of this patch is:
https://lore.kernel.org/all/20230119140453.3942340-4-abel.vesa@linaro.org/

Changes since v4:
 * none

Changes since v3:
 * added Dmitry's R-b tag

Changes since v2:
 * none

Changes since v1:
 * split all the offsets into separate patches, like Vinod suggested


 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h | 18 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  2 ++
 2 files changed, 20 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
new file mode 100644
index 000000000000..9c3f1e4950e6
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V6_20_H_
+#define QCOM_PHY_QMP_PCS_V6_20_H_
+
+/* Only for QMP V6_20 PHY - USB/PCIe PCS registers */
+#define QPHY_V6_20_PCS_G3S2_PRE_GAIN			0x178
+#define QPHY_V6_20_PCS_RX_SIGDET_LVL			0x190
+#define QPHY_V6_20_PCS_COM_ELECIDLE_DLY_SEL		0x1b8
+#define QPHY_V6_20_PCS_TX_RX_CONFIG1			0x1dc
+#define QPHY_V6_20_PCS_TX_RX_CONFIG2			0x1e0
+#define QPHY_V6_20_PCS_EQ_CONFIG4			0x1f8
+#define QPHY_V6_20_PCS_EQ_CONFIG5			0x1fc
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 80e3b5c860b6..760de4c76e5b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -40,6 +40,8 @@
 
 #include "phy-qcom-qmp-pcs-v6.h"
 
+#include "phy-qcom-qmp-pcs-v6_20.h"
+
 /* Only for QMP V3 & V4 PHY - DP COM registers */
 #define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
 #define QPHY_V3_DP_COM_SW_RESET				0x04
-- 
2.34.1

