Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B761A735AAE
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 17:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjFSPFa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 11:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjFSPFL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 11:05:11 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE1719AB
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2023 08:04:29 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-39eab4bcee8so2116559b6e.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2023 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687187069; x=1689779069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnYTPbLQMWkMCSqucReygW86UFXzEWRo6n6RYpHSl6Q=;
        b=yWd0G0ny+PmbdNeLBRGorz5mIOaQFrNwDntf5+renDW0fy412pD6JDBOdc+4S/CceP
         kgVH8/2BcsQ8og92IG+bF11zWQSMcmkiWcwY9TDDT6VtzQ/tVwq2o01g/xJzkd0tyTLj
         PEz+1SUZ1H39Pta0aAOe96LpDclPfkJM2qZM+DFUua25auQVZkvnW7ZirZ9KZKTxwG7R
         +0t6SYE0udQkuIfMiCQglLqqgrjobH76m7GmBeXSN6jyOjmE27uBV1gQlc8Y8YY8ak4L
         7sWx9wuUjS0HkLELy60r0spaD+h0mlyJ3pGbS3R062GkeSwQUeiFfmXI9XpuJXjjkx+U
         zKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187069; x=1689779069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnYTPbLQMWkMCSqucReygW86UFXzEWRo6n6RYpHSl6Q=;
        b=NW88jCi53ZQydNlRRLTMyRYPOzQbNl4FFR4UgPIYOS4YoPZY0psFYlcYAy+FMpiffX
         fwISpi1S6UA3sS0YhI58Vd7P0S40/Zwv7TTuyvIQFF93kVrn+yGGqSoHq6CjH8ca52or
         jiCrzzw7Z3qIX7LwNDtUkPqH76Dh8ep6n9dcAh0P7reEegBp3tN2ynnZqsUC3GXVgTqt
         +dRgI/uOKgw8FS09GAR/Wlrt1Th1fLLm28BLLy+ueFsrWFXY7Oj3X3obwCZTbnVYZAYf
         nV4a2b9GQFSNOkv+m88TyAQJXXejrbMzXQVlrqWf9CP3LcwxTrWadHfkzQ0IiBDVwB69
         C0nA==
X-Gm-Message-State: AC+VfDyMDjOOv6JWcSxHkZThv2ddWQ0X48xmd+59g58yW9FJXKmrsQDq
        WZEY1Ev+t/UKWxDPmr0N7sWs
X-Google-Smtp-Source: ACHHUZ7wBeSAiIUYQJsKlfpNCJ9nrtg1ZRSoqtpfVEl/vL4msN1p3aq/MZxsBXrCKD3ygAu0a7+x1w==
X-Received: by 2002:a05:6808:1455:b0:39a:a880:50dc with SMTP id x21-20020a056808145500b0039aa88050dcmr14860675oiv.52.1687187069106;
        Mon, 19 Jun 2023 08:04:29 -0700 (PDT)
Received: from localhost.localdomain ([117.217.183.37])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b0025efaf7a0d3sm2765480pjj.14.2023.06.19.08.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:04:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 3/9] PCI: qcom: Disable write access to read only registers for IP v2.9.0
Date:   Mon, 19 Jun 2023 20:34:02 +0530
Message-Id: <20230619150408.8468-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619150408.8468-1-manivannan.sadhasivam@linaro.org>
References: <20230619150408.8468-1-manivannan.sadhasivam@linaro.org>
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

In the post init sequence of v2.9.0, write access to read only registers
are not disabled after updating the registers. Fix it by disabling the
access after register update.

While at it, let's also add a newline after existing dw_pcie_dbi_ro_wr_en()
guard function to align with rest of the driver.

Fixes: 0cf7c2efe8ac ("PCI: qcom: Add IPQ60xx support")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 01795ee7ce45..391a45d1e70a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1136,6 +1136,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	writel(0, pcie->parf + PARF_Q2A_FLUSH);
 
 	dw_pcie_dbi_ro_wr_en(pci);
+
 	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
@@ -1145,6 +1146,8 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
 			PCI_EXP_DEVCTL2);
 
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	for (i = 0; i < 256; i++)
 		writel(0, pcie->parf + PARF_BDF_TO_SID_TABLE_N + (4 * i));
 
-- 
2.25.1

