Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74D687D82
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 13:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjBBMjd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 07:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjBBMjb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 07:39:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521468BDC5
        for <linux-pci@vger.kernel.org>; Thu,  2 Feb 2023 04:39:20 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h12so1559116wrv.10
        for <linux-pci@vger.kernel.org>; Thu, 02 Feb 2023 04:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mGLj5xguoE6RrOwo1RSDNcCNpxgV7w5pav0XGnKq0U=;
        b=ymahsYbxdjN6kVaYC/klylxQGhfpSXPAu/bQHo4p5pgyqoS1i0IUPaxWo/69ehRy7Q
         0qU4NBzCYG48rA9kieVpWewyTpCvfxAYJWDY+KHYMZpWcIzEJA/T4tVxvP85WgIxEzIT
         zpIT4QuWxFs78i7xvO77nfXXVcdwedncGKWtkSz6W8pdFjU4hwRtNBTS4oM5zkGOhPBO
         tlfA9qXIGE9rkCH/9ePnRnIAbXvIyQMllPtzYd5dWdR4h/73I3ppUYddADWua7+vPxxk
         f4n9UDIQaUhu3gQl/HiB4cV7xGE+bmcgeLNvCgQSGogJFsBY3d5GWimPAW19cbZG13Gk
         qO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mGLj5xguoE6RrOwo1RSDNcCNpxgV7w5pav0XGnKq0U=;
        b=ayGAELoF5cbCluegNoDuazeroPbCDrdjksZGZOkbFC8Od0glNT1166ajSSS33IK7OR
         m5m8iy8Vck7qyh36iuDQE0D460k0XT4kX2Ozj3k5aM+hJqWgLkxdOr+NNBciMyjj10E+
         VcIxTCBB/KqwcmgDUcA2LD2PzqCtwixCVFHNxbsX5kiZF7uFdaVtCl1sIUcjFE9wjC+6
         Kl6N6XPngxzJzHiCKFsEvjKCIPDMj0DhYA+iEOvNC73gxAbt1bF5eoxjcZbaZ4KZjc73
         RZGckOIXES3o16nqTrbgZNovVzkoCbKJf0+YotTc6Cn93DFDbwfq8e8FWBIdTXBeMIxl
         9uSg==
X-Gm-Message-State: AO0yUKWWV+Fl/VIJCKeFa/KZD3v0n5+yg0sfRjNvfkn9ySEClgiYvRzG
        34KkDM46jU8kJyS4Wtnze0ZRsw==
X-Google-Smtp-Source: AK7set+zllAgMFi3gHo1Y2Se5M9ntPh7hvp5bsppe+JBBuLo4aPC80LidugD31TqG69Ab+vF17iYvw==
X-Received: by 2002:a5d:624b:0:b0:2bd:e8c2:c9bc with SMTP id m11-20020a5d624b000000b002bde8c2c9bcmr4653251wrv.42.1675341558724;
        Thu, 02 Feb 2023 04:39:18 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j5-20020adff005000000b002bddd75a83fsm19525644wro.8.2023.02.02.04.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 04:39:18 -0800 (PST)
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
Subject: [PATCH v6 05/12] phy: qcom-qmp: pcs-pcie: Add v6.20 register offsets
Date:   Thu,  2 Feb 2023 14:38:55 +0200
Message-Id: <20230202123902.3831491-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202123902.3831491-1-abel.vesa@linaro.org>
References: <20230202123902.3831491-1-abel.vesa@linaro.org>
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

The v5 of this patch is:
https://lore.kernel.org/all/20230124124714.3087948-6-abel.vesa@linaro.org/

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

