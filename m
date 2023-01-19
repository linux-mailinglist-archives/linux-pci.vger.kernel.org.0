Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D00673B1C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 15:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjASOFY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 09:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjASOFP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 09:05:15 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACCC78551
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:05:11 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3655470wma.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOIoWRNHI+rYZ+DVnhtpkSO69WHP+Q1MqP6xsLa+kYU=;
        b=uOvfLofkcKgWN0xCAwairA4VXU8jV4BD8zP9TCt5B1XRYqGZIps1ij2YXSkPrd+4OX
         VRgWMPQSU6AteqmCLzYAGQCEPuDUNjlkNR9rqcGbBOgQkuD+0rqBdWRTNjIRdY7oywAm
         baPdb4VdzXgNlFRFUfPESE10sCMzQy9JOsYDW1vcc5EViU1c+soXPSRsaEXUUvlOknMg
         FGkDygcMOpp/pqvJRlMvb5gE6rCK0kCKADtOoLi8/Zx/A1AIBiiLTWyRqj2kSih+NFx+
         WPFEvHeu08/C5kRPljj/5Z/5V0qy+PNjQx3vhIEAXxmQLvj4KtOh6pdOnPrX4gZ3Dodj
         1R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOIoWRNHI+rYZ+DVnhtpkSO69WHP+Q1MqP6xsLa+kYU=;
        b=G45/qAfzPN+Hyi+AHVaSyo6E7dM7ThJJinQcN1Us0Z9mkcoe9ATWInrWo6ohBy3QZc
         y/EifRtE+85za+M39wKxH4LZR7IYKJeaX4It/WY08VvpDHSkDokMc+o2jONZQ1Nz3RuV
         kPZo92WnpJ+P+o0sOkX8Wx+A3u8vs23XRR5xy9mh6O1WVQb/CYE16/yRlGICE3nBFiEe
         rlBhRakuPgHRhsQJA0Gj6ZJK3uCoPp3KJYwRT/BYbtKo26/nr24uzeyL6tppHYfFVEQr
         Awu9cOYQ+Ocz+Hzv7FIRX4+xOmD6i8xcynG1ZSHRfeusDSIOH+lcoEGPrZfHAXNFOSWK
         0G3g==
X-Gm-Message-State: AFqh2krNjjgCt4Mq7Dw2jOgVilwYRZSalupYCY+QkNIKjOm1u0TPF78e
        zTdffKMBZWSuc1oJewatpoln9g==
X-Google-Smtp-Source: AMrXdXsnPUMo/sexU8Gq1PheYSHXShwr12MGoc0M684KpqET1x8fqD/uwkmoPv6CbWEzMWF51UIuHA==
X-Received: by 2002:a1c:7415:0:b0:3da:fd07:1e3 with SMTP id p21-20020a1c7415000000b003dafd0701e3mr9995528wmc.22.1674137109797;
        Thu, 19 Jan 2023 06:05:09 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c4f4a00b003d96efd09b7sm5263883wmq.19.2023.01.19.06.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:05:08 -0800 (PST)
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
Subject: [PATCH v4 02/12] phy: qcom-qmp: pcs: Add v6 register offsets
Date:   Thu, 19 Jan 2023 16:04:43 +0200
Message-Id: <20230119140453.3942340-3-abel.vesa@linaro.org>
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
UFS and PCIE g3x2. Add the new PCS offsets in a dedicated header file.

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


 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h | 16 ++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h        |  2 ++
 2 files changed, 18 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
new file mode 100644
index 000000000000..18c4a3abe590
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V6_H_
+#define QCOM_PHY_QMP_PCS_V6_H_
+
+/* Only for QMP V6 PHY - USB/PCIe PCS registers */
+#define QPHY_V6_PCS_REFGEN_REQ_CONFIG1		0xdc
+#define QPHY_V6_PCS_RX_SIGDET_LVL		0x188
+#define QPHY_V6_PCS_RATE_SLEW_CNTRL1		0x198
+#define QPHY_V6_PCS_EQ_CONFIG2			0x1e0
+#define QPHY_V6_PCS_PCS_TX_RX_CONFIG		0x1d0
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index a63a691b8372..80e3b5c860b6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -38,6 +38,8 @@
 
 #include "phy-qcom-qmp-pcs-v5_20.h"
 
+#include "phy-qcom-qmp-pcs-v6.h"
+
 /* Only for QMP V3 & V4 PHY - DP COM registers */
 #define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
 #define QPHY_V3_DP_COM_SW_RESET				0x04
-- 
2.34.1

