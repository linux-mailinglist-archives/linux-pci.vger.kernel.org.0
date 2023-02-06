Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6628468C89C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 22:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjBFV0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 16:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBFV0b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 16:26:31 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662802BEF3
        for <linux-pci@vger.kernel.org>; Mon,  6 Feb 2023 13:26:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bk16so11726060wrb.11
        for <linux-pci@vger.kernel.org>; Mon, 06 Feb 2023 13:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wBYJk8y3G10NfmYHaWiaQMhFZ0a2TrYc3M+tJ1377o=;
        b=M/xilxfr/dH0sZjIKbl9sxHgvCCZ1ZfgIU79Loif+GoVno+6w4LFFdVT2NwvwyEaPb
         2z+42elssXhPowlr4rC577KZGNF2WAtPuIlVKa0lPQtxYSc96Sxj+8kYU5iuInARx/Ys
         LcjSCdKzdmiaQhsZR8ECWbElA5Pfx7j3nOHOXHYGCox76EfzmyrJ55sDlV9F9Qji5eOH
         ZDGOLejNCwTflg/p8HRlKVQ4U97ASYflAL6MynWhWjYYDSSY1KjcB7UZr5DOL8zrMBtI
         JpjwJnxxr11tTKxWd+2y1FSpBBrja5sQOuZWxZMJYAU/Waby1TgtwcaR4oSJhUI7OpNF
         2ovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wBYJk8y3G10NfmYHaWiaQMhFZ0a2TrYc3M+tJ1377o=;
        b=G239jFJqieWH9TBJQFF9gnFr9KGWOddETkUrppPL7fgK0j/tKHUpqF2Gkcr45rqpO5
         vbV0U5GS3oGoWAELJdQDYkLV3+N3Wt/Wnzt3F+wuGPL+0PBiN5BLeBYXylCd92n6ujav
         +iY1pDyUQZ4oGioG9ugcXe3sWquzllxV+7kxaCAj4LsiJ7KdxNWFKem+WsWQfQmONwN1
         WYyhb+jipQXTt2qneBidedX+mFpOafXh58F2Xkq6JC88qyicpj18c3BusUXuCpz16nub
         bfQhXw1OfEmuRav4ECyvqfR5c9wa656FjjeD0y+K6R2AOTX9OvntdXtIROsd/A1o3HuP
         EuMw==
X-Gm-Message-State: AO0yUKVijGzzlhYobjbiZvF1gIBIURVOf38H2BRmXU0+Me3528cIKsr1
        clwkl8LAGRTvvyeBWPv6V11BfA==
X-Google-Smtp-Source: AK7set8p+g9q3lZJUVwFZLddEQyyg/mRs+0l2EAPKXqeQWLeyxgrOY+OCXVjWxuW7RaEYCHjzGEH8A==
X-Received: by 2002:a05:6000:12cb:b0:2bf:c9e2:770a with SMTP id l11-20020a05600012cb00b002bfc9e2770amr488588wrx.2.1675718787940;
        Mon, 06 Feb 2023 13:26:27 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b002b57bae7174sm9783341wrt.5.2023.02.06.13.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:26:27 -0800 (PST)
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
Subject: [PATCH v8 03/11] phy: qcom-qmp: pcs: Add v6.20 register offsets
Date:   Mon,  6 Feb 2023 23:26:11 +0200
Message-Id: <20230206212619.3218741-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206212619.3218741-1-abel.vesa@linaro.org>
References: <20230206212619.3218741-1-abel.vesa@linaro.org>
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

The v7 of this patch is:
https://lore.kernel.org/all/20230203081807.2248625-4-abel.vesa@linaro.org/

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

