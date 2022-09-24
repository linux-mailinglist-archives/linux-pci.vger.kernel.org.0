Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238475E8E50
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 18:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiIXQDP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 12:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiIXQDL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 12:03:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4CF399C8
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a8so4597323lff.13
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qNP6ThRLpHNI/EUjMpjjuQG55s6ZxCbGqJcYBGEJHG4=;
        b=HPew258xyvOOq0agsLcQvgFBuWGMmeXE1O/TQ2jVEgrVXvDPFCvijlXIGC9FeyJ3nn
         D9cRmNI1agSsPKPLL2d8ZYtQX8EXNGJi0fgg9vR9ZtJxNbU+JF4dfhOifgQ/k/cbH4tR
         xcrUK4x7plppO5XSYmW52xXSplayrWLoITtaCX7tpsuU31XuTgNSTvczG4897jXCAriQ
         RsBo9VEO4MMYgZ/pt4GXNyHuw8RYBNkOk6Nm/wDjLSb/diFcvz7mDtvAdRRi4ctgVNCR
         iFI/4X3gbEx6DbjwoMV+217tIa/c8d1RIi42XK9aRRz372sPhybuWVg3d7YWw/nmhr48
         CiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qNP6ThRLpHNI/EUjMpjjuQG55s6ZxCbGqJcYBGEJHG4=;
        b=ULUVM0hv3arsAOtCbHzB/omLBmvaci+LxnyJXS7f/wR5ZogZVWV+RHn/yQZbgEGZUd
         TaOllX8aL2s/p0yHdYkecr9q3X0Gnm0qHZ2F6h9DL6NDbgJk7HfGI3BqI1cs/JqWOLyG
         CqgUFwDNkO/PhHw8Z0cuRc9896cztyWFcZpsDFHEmsP7sbOheO5eWvGn7VLKhmCBcDt7
         w5a+nmfIaL1/KINS/ac+L35kjFLeysFOrRw+KT3IIFTDB2SUIqQh07QjGEFrGlAwcpTN
         /hMVoIT3ZJ6yBgf8FNzcJS8XY95l4ugZfJirhfOw1422dyAe8OP6HDObTjCT7TIsSJ/5
         g45Q==
X-Gm-Message-State: ACrzQf0lUGEZC4ty5Yv/Hku3Hhh/1QDpqpzg4TbKxy607WsN5XKzM+fs
        9ThQRG80BC1AN5JbEp30Orl7Cw==
X-Google-Smtp-Source: AMsMyM6etBjajLFZyOO5iUfHHXRd4Vm+/Y/spSTurjv1mn1NTAAxvJjmipI2eHTqA/yeakFinoOhnw==
X-Received: by 2002:a05:6512:252b:b0:4a0:5642:dbc5 with SMTP id be43-20020a056512252b00b004a05642dbc5mr3293999lfb.436.1664035389284;
        Sat, 24 Sep 2022 09:03:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([95.161.222.31])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b00499f9ba6af0sm1928015lfq.207.2022.09.24.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:03:08 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 6/6] PCI: qcom-ep: Setup PHY to work in EP mode
Date:   Sat, 24 Sep 2022 19:03:02 +0300
Message-Id: <20220924160302.285875-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
References: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
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

Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
used in the EP mode.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index ec99116ad05c..8dcfeed24424 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mfd/syscon.h>
+#include <linux/phy/pcie.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -240,6 +241,10 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	if (ret)
 		goto err_disable_clk;
 
+	ret = phy_set_mode_ext(pcie_ep->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_EP);
+	if (ret)
+		goto err_phy_exit;
+
 	ret = phy_power_on(pcie_ep->phy);
 	if (ret)
 		goto err_phy_exit;
-- 
2.35.1

