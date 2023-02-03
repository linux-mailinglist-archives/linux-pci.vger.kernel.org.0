Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38856891DD
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 09:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjBCISd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 03:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjBCISU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 03:18:20 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8081F5DC
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 00:18:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k16so3245924wms.2
        for <linux-pci@vger.kernel.org>; Fri, 03 Feb 2023 00:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pySYIDhMctXxHKmkvLwbxw7XeNzgPQ7plnVzA+pnk7w=;
        b=UyeOIY2ulfX4s8MxKA2N1KnZzA57Y6AKcdOJUxLynMHNHSHmxlaAmK4csOpDvE07DQ
         01UetPsoELhfcsr1T1BY+InvcS+xQZ0sm+tAE0CCmm4bvBeSPjP9raZT5/pW+CAaBKvW
         G2O0h2TWPmb1zOYP2Jj105iE2RXEZrWQnw3jRhsUJd1kd7hd8viDvk+3D556Vr6IDKWw
         vHbJ0fkUgwfX8ExF/wHL+1EY5wGVX5sfzpId4IVMPd1ffonJRl/geaN1EVAJCSvoGgdT
         JiX7Q1G9Cz596dXutOgxCih/XcZR6WYUzm8i4T0TeuL88mPkoeZkwBMjurVyYlNH8fqW
         cd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pySYIDhMctXxHKmkvLwbxw7XeNzgPQ7plnVzA+pnk7w=;
        b=WY5lfk67//8Fnni6UnWHfA52+3iuTR38AsCvQnzvfq9z6F/C7QMKHQQHX/BVVQJvOf
         iQx1OQzUsNpx4mjpcY43MXkPLhWhRviCb8lAbqu1Ac+lzuWLcBwQUe4drywL0ZrNjBPC
         sn9+nfv2dfX1JgXN0+VIz4/zF1TMULHy7Rv13MwYX9ri7xkqGRd0847Gp5Ie0+H3BDk+
         SHps3P1afoJ1sgtOxorSIi6vyu7erWYy74E/0qmC5XGJhvrLUxHGVpMZ5jhNqPTYE3GB
         gH5G7YWQAWFHrRsHlUmVLgQngHxVvFinYA27RskZykPxAtv8slG6V/3dJnTtNO42aBlm
         MJFw==
X-Gm-Message-State: AO0yUKXPjSq3qAkKtliIevYJ7kygRtOMxwKP9HsgdhMs+azssNQazGgH
        ODt5aD3ltyqrZFdF4GF20+z4kA==
X-Google-Smtp-Source: AK7set+eiG0o1BLpAcJZIg7O75j9ncTQC52lt542ekk7hxtzm0rNz+S8Fl8uIimhXRTiUX3GL63OEA==
X-Received: by 2002:a05:600c:1d86:b0:3da:1f6a:7b36 with SMTP id p6-20020a05600c1d8600b003da1f6a7b36mr10705197wms.0.1675412297081;
        Fri, 03 Feb 2023 00:18:17 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id az24-20020a05600c601800b003dc4baaedd3sm7316591wmb.37.2023.02.03.00.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:18:16 -0800 (PST)
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
Subject: [PATCH v7 03/12] phy: qcom-qmp: pcs: Add v6.20 register offsets
Date:   Fri,  3 Feb 2023 10:17:58 +0200
Message-Id: <20230203081807.2248625-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203081807.2248625-1-abel.vesa@linaro.org>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
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

The v6 of this patch is:
https://lore.kernel.org/all/20230202123902.3831491-4-abel.vesa@linaro.org/

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

