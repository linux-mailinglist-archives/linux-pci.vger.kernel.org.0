Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8589673B26
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 15:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjASOFn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 09:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjASOFe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 09:05:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0EB7ED40
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:05:16 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso2157737wmn.5
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH8B4LzC0JVjNfzgD2r/OpdoTbOIoKwrO9dmbRIoW1Q=;
        b=ZWmzqLW1pIKGxqARx3qpQEVLq4vT0iNDGJw5sLBQZ2FEa721WV8K/uvQlqorSWew7D
         hQ0+5jrBDqAZ0y08G92GDdv8v9xORMgD2NlTrZWqA7JuZ3+CJSPtz4Jr99zll1GPBz+v
         B+Yo3zWfc7ZIqo51LaTgBQxapz1uyEPvQ+aV6Aa0spphd/z7OaNyG/4IGTSbM9UcISlh
         Pbwo1YJwnas0W4XUGP2i+9q/vns6D5ugs9WXn8D5NNOlkQCTS7vTst+8z/sjphth378W
         LspM5Iasl/HJXny22Pp2bfTXu0WHGlk7ZfMkZ0IX3sqSa/yQM15dyEP3StcnYQFQo77i
         z3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH8B4LzC0JVjNfzgD2r/OpdoTbOIoKwrO9dmbRIoW1Q=;
        b=doP9Mrwhl/kehwMR5lVp+aO5NieIURTskMFiwukwYlgI+6jgxbF49SPnEYlLBAgAox
         UK3Uz5ok0MESMDiB3/NADCBxQDtmo/1d7Af+kYsN/AaJSd+Z+xmRpiw37mKVLIj8Lk+s
         IAE3gTPRDnmo9bsOxpyRCCsvT6N5PtggYmPVe9vihun04mvb+sHOrB0a1up3TV7JqLRd
         5eTY2PlrHJRhjWtW149SniCwVUqLALp49pxVHuOtxf0yvz0gflspwkg/Wgz+JcenenVZ
         fXG1/8LJdKhgEOoheAM5E0JsgkQeB52hEEYuqHYJ9MSzTS9Q40imUjswV1wPlZMY/3Cc
         PogQ==
X-Gm-Message-State: AFqh2krkg71L17fd0PYyro08Ad+UiDCdNKGtyFacQlI5T7mh5l8nVbmg
        N4n2HbH90eTLeh5++uKwD/STWw==
X-Google-Smtp-Source: AMrXdXvWdZpqk57gcr4qmbo+zvhD6zEeilvf1Ms/khdBJrFC/t5cBzL4ZRxYvjOssXeTJ6GHifkg9w==
X-Received: by 2002:a05:600c:11:b0:3db:162f:3551 with SMTP id g17-20020a05600c001100b003db162f3551mr5733880wmc.21.1674137116451;
        Thu, 19 Jan 2023 06:05:16 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c4f4a00b003d96efd09b7sm5263883wmq.19.2023.01.19.06.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:05:15 -0800 (PST)
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
Subject: [PATCH v4 06/12] phy: qcom-qmp: qserdes-txrx: Add v6.20 register offsets
Date:   Thu, 19 Jan 2023 16:04:47 +0200
Message-Id: <20230119140453.3942340-7-abel.vesa@linaro.org>
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

The new SM8550 SoC bumps up the HW version of QMP phy to v6.20 for
PCIE g4x2. Add the new qserdes TX RX PCIE specific offsets in a
dedicated header file.

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

