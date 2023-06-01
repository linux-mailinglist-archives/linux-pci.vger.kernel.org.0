Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4678971EF50
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 18:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjFAQkP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 12:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjFAQkI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 12:40:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00A9E76
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 09:39:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-65292f79456so107431b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2023 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685637587; x=1688229587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAHgbKUGLDFGyzp+XWYZ2sseIunYBsYQIO/Xldf05CU=;
        b=ryx0q2tgrm1ZKWtwvRMJ9C4j+popyHn3lXSPJE9WeKkQ8kOC7HrJjfKFRmCDgLK4jz
         G+xHfxxcaoeujui+lcZ6sPSDA/hrnRZY37AoAlRfbMdJ0mKBg9o1d/Ht6SWrWKvI+/Ob
         3AqIkXmgLW7Ow0C11PK9HJ73XCF3XNb3nZKClbX6cAkDj7N8NY4UfuQ1+r1widBM4GBD
         nlCUvtrR1tVC/L+3NG4elw/3ZxlvASHGYNmD9LVnt2zDOWfuvYnoinrYnEBboea7Stsb
         AmdQgtgKGiCeC/Ov1oHeEioCI7ba3+dxWO6sZhmjzpca5UywJn/3+LNXabcEui4aSGPM
         tpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637587; x=1688229587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAHgbKUGLDFGyzp+XWYZ2sseIunYBsYQIO/Xldf05CU=;
        b=lvzR/NZFE0ag+/JNG9LgS9IExTDaDyGtWK21gRhgLk33aTAzsoP3v7+7VAUB6GsTuj
         /iiJwQ/A6y5etT9W2Sm3Q3KMTjjRbPYJiCyejFQs3dwo1h5ivsoVn8o3Q0kfavd26hCm
         UUPfwAOTjnll63vwa41Q3qTvsq8Coa6t8BvgsfPM+PVPDBEyoigvePEWpL2Zo2SMjXk8
         +wD7sGv2TZBrs8ejIUyKifWXwu8kbu9XDHQTCcF7wi3GE6wWNU18XugS4oVeDlxppsYH
         wwzGkRA7J6qceAt9jB917v8M2UN9KbIUV9LU8mEQA2Nn5LdLOC51YiQv91Ef3l3h3Hjn
         lgwA==
X-Gm-Message-State: AC+VfDwLPwYxlzw5bBnRZL8zHVuSwaQBzS1zylo5mpKuxy2Qb7Ih9Apd
        yf2cB5fZTrkOn0MPCapsdRP5
X-Google-Smtp-Source: ACHHUZ77Hvcyy/LhNWPZBGSZ2qUN6+7BPRkk03iorDwp2wOt2Mtg1w9NrwyWpOHSK+Sam8bl4ZhCTw==
X-Received: by 2002:a05:6a00:2184:b0:64a:2dd6:4f18 with SMTP id h4-20020a056a00218400b0064a2dd64f18mr7536124pfi.13.1685637586895;
        Thu, 01 Jun 2023 09:39:46 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b0064f83595bbcsm5273630pfo.58.2023.06.01.09.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:39:46 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 8/8] PCI: qcom: Do not advertise hotplug capability for IP v2.1.0
Date:   Thu,  1 Jun 2023 22:09:00 +0530
Message-Id: <20230601163900.15500-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601163900.15500-1-manivannan.sadhasivam@linaro.org>
References: <20230601163900.15500-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SoCs making use of Qcom PCIe controller IP v2.1.0 do not support hotplug
functionality. But the hotplug capability bit is set by default in the
hardware. This causes the kernel PCI core to register hotplug service for
the controller and send hotplug commands to it. But those commands will
timeout generating messages as below during boot and suspend/resume.

[    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
[    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
[    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
[    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)

This not only spams the console output but also induces a delay of a
couple of seconds. To fix this issue, let's clear the HPC bit in
PCI_EXP_SLTCAP register as a part of the post init sequence to not
advertise the hotplug capability for the controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 612266fb849a..7a87a47eb7ed 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -438,6 +438,8 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	writel(CFG_BRIDGE_SB_INIT,
 	       pci->dbi_base + AXI_MSTR_RESP_COMP_CTRL1);
 
+	qcom_pcie_clear_hpc(pcie->pci);
+
 	return 0;
 }
 
-- 
2.25.1

