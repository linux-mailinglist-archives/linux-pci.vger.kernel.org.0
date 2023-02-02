Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6A9687D7B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 13:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjBBMjV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 07:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjBBMjT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 07:39:19 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE84D84B62
        for <linux-pci@vger.kernel.org>; Thu,  2 Feb 2023 04:39:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bk16so1554613wrb.11
        for <linux-pci@vger.kernel.org>; Thu, 02 Feb 2023 04:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evUJ0BtoNRLcEsnJaspA/+zDJwRp6qkKXdDbMhL86e8=;
        b=wlxcgVWXHVHFw9GecNk4NSKCVYJD5dqGFF+5Ve3xgjIjyKLoC8F29rrBkJafs1kPyc
         kCy6RTxldArmPEhYyh5LUcEC8ZGpErmE2M02N4YKTheDLaZpR9px0/gyAakfHt8WAgAZ
         rALfSg5GH5uG8nXc1rreWTX6uPpIYxwJn3evkvh3sXsu9HKZzzztRgBfSmhMFBpZ4ocE
         xI0HmrKd4rlhwmGTsfwWQhlgPtRkQT2R68lMYBo+wpMYjZRPIFLcWaXjD1Fe9hi7DwkA
         stw6jmE1CvsSw0FgOQhxoC2ob9lrwzWR7iUcU9QPsXLJPsEP1RIdXXw+4NQYxqn1LBwE
         XKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evUJ0BtoNRLcEsnJaspA/+zDJwRp6qkKXdDbMhL86e8=;
        b=zrHM2DoTwG0sgL+zEDa+Db1hJEeNc1DvI/8F7wBOQtb3HczAuAp+vH6hXRcE0IGMei
         4eELked1ZmNz/vsIVpMxZJ0mVrEdYSIK2Hp3wcrwgE2XBFwS/jFAqYmJdC/QArO7ptzd
         BtGw71mBcDLri4CfilYy4pEKYOJcy1/Y2UlShnXFfjo5fc+w+BwouJTssmSbLjpAXMMM
         61Wix5SR0W+tyxstPxUfnedluQXDrw46pGG4ysYmMNaQ3wDg/oluchchHcOXOSDM8a/L
         YWYw6uA4Gq/Vs1J3y7Pmnz8bQdq0o+xAFetUbWgniaAyUPoEp4fmH1Gm8HJyyJ6lUEuv
         Edzw==
X-Gm-Message-State: AO0yUKWM2eGoFN+8p/yM6nbAKbDVoLHZru9yN6sLzPB2d4mPOeW9scY7
        RB0jmtKjsdhoIZhzkdXA7f+5Mg==
X-Google-Smtp-Source: AK7set85GUUjRUYmEqmwQnKBLNmpTMfWaYic9nHqjxfxe5BH59qaaDiBCiprZrA5NB9nxaBw3GLiHg==
X-Received: by 2002:a05:6000:613:b0:2bf:c319:d1d8 with SMTP id bn19-20020a056000061300b002bfc319d1d8mr6094995wrb.42.1675341557292;
        Thu, 02 Feb 2023 04:39:17 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j5-20020adff005000000b002bddd75a83fsm19525644wro.8.2023.02.02.04.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 04:39:16 -0800 (PST)
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
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v6 04/12] phy: qcom-qmp: pcs-pcie: Add v6 register offsets
Date:   Thu,  2 Feb 2023 14:38:54 +0200
Message-Id: <20230202123902.3831491-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202123902.3831491-1-abel.vesa@linaro.org>
References: <20230202123902.3831491-1-abel.vesa@linaro.org>
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

The new SM8550 SoC bumps up the HW version of QMP phy to v6 for USB,
UFS and PCIE g3x2. Add the new PCS PCIE specific offsets in a dedicated
header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

This patchset relies on the following patchset:
https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/

The v5 of this patch is:
https://lore.kernel.org/all/20230124124714.3087948-5-abel.vesa@linaro.org/

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

