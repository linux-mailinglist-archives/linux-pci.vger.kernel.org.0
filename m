Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D5068C8A4
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 22:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjBFV0o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 16:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjBFV0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 16:26:33 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F712ED4D
        for <linux-pci@vger.kernel.org>; Mon,  6 Feb 2023 13:26:31 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a2so11471244wrd.6
        for <linux-pci@vger.kernel.org>; Mon, 06 Feb 2023 13:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUq/Mgp1nazpI35D4KET133wslbHGuvnLSSg4b0SKK4=;
        b=gAWZ/IMKMdFEyF5JQTlly91fv3p4xkOVyD4o3+UNciqY2AZS/gdDNz+LL0u+iGhAwH
         FwIzGb5oRxzAIUGsHQBztLnzrsq86Zd1AOf3lJ82e5OxDK9pyh+5Gl4Mv5s3xukZT2gZ
         bXEK7Y7weN0dngk5+dHZYCf/qDFCKPAfKaHAlYg7jq3fUcyn7ugrHEagJYA0nP7mzkY0
         GB2JQl3/znuOJ/tUrCZA26kG+7PQuqC04/jRKbhV4UNUKDl396VeNGwQtfjIq4A5R3lX
         N34OmvDJ2bddh6BPYerk30UbDmJ5L8ypBAYseJHexWM9xoUyqSu5NmZvrMg3nMbHvVmh
         SxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUq/Mgp1nazpI35D4KET133wslbHGuvnLSSg4b0SKK4=;
        b=qmrNNjLAUayZWT53HIi+qfQi4I1ZRHo9qQ1l/Xxuqp4kKW0/qBufuhBrtDTa1qnR7q
         NI9yFCdzJPNgjzg3FIe0Z8RKrAdUcNBml1rIwGY6K51vFpUoqbndO58OpHe4JIhTe4bi
         8ifxSSw/r7T5OSDFojNcw4MQZCCDr8k641yN9LRdDiRnTmqVytacWSUBGbKPQiM0csvc
         u3Wl9b7zt8z/1HLogzZ7Z6zvyW78mSUeayIKfDq79+TmBHk6XIJq6bEm7VXh9yx2pCT+
         AoDyyX5SgxM8TGM9PgAG+P9ODMDDjGMrFbrZg0FSrcw2P17ySQNF1q7HXlgw/xPK5Zr4
         tDUQ==
X-Gm-Message-State: AO0yUKUkLeNU06ai6VVyzRuJv4aI9XpbvOj+rgZ7EQJ9EK/CmH4Y7cgb
        Et2lI7mYRsQxM+huOQTgEKdVDw==
X-Google-Smtp-Source: AK7set+xsS0QFCyQplZ6ZvXIodCRuCLQYATyLZ+sjAQoifNre2Sr4/DQFfgYgdrSNOnTY61pXo7Vww==
X-Received: by 2002:a5d:6a08:0:b0:2bf:95cc:744c with SMTP id m8-20020a5d6a08000000b002bf95cc744cmr409055wru.0.1675718789374;
        Mon, 06 Feb 2023 13:26:29 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b002b57bae7174sm9783341wrt.5.2023.02.06.13.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:26:28 -0800 (PST)
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
Subject: [PATCH v8 04/11] phy: qcom-qmp: pcs-pcie: Add v6 register offsets
Date:   Mon,  6 Feb 2023 23:26:12 +0200
Message-Id: <20230206212619.3218741-5-abel.vesa@linaro.org>
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

The new SM8550 SoC bumps up the HW version of QMP phy to v6 for USB,
UFS and PCIE g3x2. Add the new PCS PCIE specific offsets in a dedicated
header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

The v7 of this patch is:
https://lore.kernel.org/all/20230203081807.2248625-5-abel.vesa@linaro.org/

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

 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c        |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 0e7aaff2ecfd..05b59f261999 100644
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

