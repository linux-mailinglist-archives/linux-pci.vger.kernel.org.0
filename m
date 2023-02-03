Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6668920C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 09:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjBCISg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 03:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjBCISW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 03:18:22 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC683E636
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 00:18:20 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso3217681wmq.5
        for <linux-pci@vger.kernel.org>; Fri, 03 Feb 2023 00:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNtzL2PidiHeTO8PSCaciTRS6LMZPNwWvdMtS6uNAYc=;
        b=cS0hH6VYYC3sHt99NaWopWGg8GGD7JG6ovgnCdmem75myJRxLbW70C3SQyJAfJtAss
         MtKb5/zta0HUvNQsAWNF5KmgmKvqQs4EtgscWExDHa/LQN2AKgt2JtTLKYq/CnurdBb+
         7A3conLnnSld2T/RwmJaYhcpnlB2RWBATQM3QexnSVsXgkog6VN1Qp1HV0jgC/jyXSrn
         8I9O48YjsctOrBCiJcHCJXZlLp5E/AlKCRAUapVgcyyBkfzQAEeSeV6+i0pPGljwJMnT
         kh4rpTNo2eGykRswFcXHSo9sQm7AU1wRgi91XcH70yQT4rbUa6AsdJNFX8NDY9Y887Av
         ipyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNtzL2PidiHeTO8PSCaciTRS6LMZPNwWvdMtS6uNAYc=;
        b=Vzfo5bdhZNk5EBPRuVtBA+Vqn88JlqIoCFTSIBsIi8nwhjxDd3jriyrccNdjVQHN/2
         ytRQINFmtma8KyxSuYU5rUFkgPDR6mOO3wJ/k1HNI6pZnXWM5zsNrbrBoKn39tIYjJX4
         UbBGc/q6ZEUKRAox8G861vlbC701pDKTdTHMogD72lK+R1Fr2HFYPtZp7ATLkFNcRyvn
         aIW2j0sHNs23UOaMCwrY77OCyE+4uHVK4b/UViRC0Xn+enuO664cXCfloQZoGtTfyEvK
         GH0lCLbpxbXQ1JSP3bhfQCpp4vtZP+cDcfnuCftXYkO/EvNqUe0GNAnXW6ZevaCwRxsy
         q30w==
X-Gm-Message-State: AO0yUKWLf/30h0Ez/FEudVO9vzL8I0fb2434yvhTdAfG70bxFWCQ1RO1
        V5GCFIhuZwyXT2YJV9n9sxv2GA==
X-Google-Smtp-Source: AK7set+Zd8hJT4TmwMNZpfeHn3P8yzeFI3fjRF3TyurezaG18C6o9a91DPDy4f8j7tXVXSkMmBefbA==
X-Received: by 2002:a05:600c:3d8d:b0:3df:9858:c035 with SMTP id bi13-20020a05600c3d8d00b003df9858c035mr3637545wmb.10.1675412298631;
        Fri, 03 Feb 2023 00:18:18 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id az24-20020a05600c601800b003dc4baaedd3sm7316591wmb.37.2023.02.03.00.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:18:18 -0800 (PST)
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
Subject: [PATCH v7 04/12] phy: qcom-qmp: pcs-pcie: Add v6 register offsets
Date:   Fri,  3 Feb 2023 10:17:59 +0200
Message-Id: <20230203081807.2248625-5-abel.vesa@linaro.org>
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

The new SM8550 SoC bumps up the HW version of QMP phy to v6 for USB,
UFS and PCIE g3x2. Add the new PCS PCIE specific offsets in a dedicated
header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

This patchset relies on the following patchset:
https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/

The v6 of this patch is:
https://lore.kernel.org/all/20230202123902.3831491-5-abel.vesa@linaro.org/

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

