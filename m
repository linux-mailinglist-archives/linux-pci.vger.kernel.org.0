Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2108735AB1
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjFSPFb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 11:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjFSPFK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 11:05:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D2DE78
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2023 08:04:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-25ee8d84b4fso1503626a91.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2023 08:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687187065; x=1689779065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3Dy+kmf8ZISKkCa0j/2ldqP//6MEtxXXYzBp48Kt14=;
        b=vtWdf8pUd95J6h7vr8vtdO30v//wqJANxXMEAkrewzCtyzASzN6R1KCTHyzYqpE4XQ
         hT2kjH2LwEyWdUVa4l+QKByViVVB3fDKG589hDa2B/GS61bFgtH+ehQeoiGkasGegRpT
         YQx9WvmTyBkaBEXT8Br5Lw/JrB0Ls9D8M5+/Z7CN0NCZmzBFuhT9LpZE4Mfddpg8iiJB
         qYKTrgxOMkA5GiRUJ49ooaOW55zu4RQ+IbRQgq55Naz61UT/c70rzn9DvhG+UMzQVjsF
         jUk0ALOCs2vziKBb4OHIaKfoPmUib0Swi38K7NWzs4xSpQQxbr5Io76IuGCZcrAT2BCt
         ImLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187065; x=1689779065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3Dy+kmf8ZISKkCa0j/2ldqP//6MEtxXXYzBp48Kt14=;
        b=Do5/jOgM8TxVjU4d5YHlbo/ETC45p5NXd4WCo/ZWo0/02mvH8BlZW7L1Lqpny/UauR
         5bn9E1WvecLE8YHTgNR3+zX0SFgNNj6V1piFwdzsh2pkjX/nPofNuFUhD0MmuJpqPYme
         ld18sIHrq3VvFjHy+oZJNK1JHIdvJtllsRJNQJ7+XWUmCNp5Dtbjhc0qM05GUQE6TXUs
         hsTz6EbAUc9ZmjlxhGJE6iqIKjaZAmc8iYcL1NuAKF6nXoSZsmwLdJUZyEY+UIS5vhLt
         3H7pgSnyHHzuwWYZW+HBj96DYld0TMX8LJngMgVuCwKd5nZ0TG129hBSckoauBFuN333
         Kx5w==
X-Gm-Message-State: AC+VfDxVg6+fNSNcm71Pn/LbXSz1cBhwlI0OuSObK4c8n6KVD5hO6Sof
        XmaWrtGiFCx+v5H8sKLZejW5
X-Google-Smtp-Source: ACHHUZ4qUQ3hwY9mNHMbObMwBwLYFeY8h8minGqKyB/SxZiGDuFVPaHBPp6CG8/MfyFm+ePr+YTp5A==
X-Received: by 2002:a17:90a:e516:b0:25e:8f12:a74d with SMTP id t22-20020a17090ae51600b0025e8f12a74dmr9926485pjy.44.1687187065087;
        Mon, 19 Jun 2023 08:04:25 -0700 (PDT)
Received: from localhost.localdomain ([117.217.183.37])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b0025efaf7a0d3sm2765480pjj.14.2023.06.19.08.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:04:24 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 2/9] PCI: qcom: Use DWC helpers for modifying the read-only DBI registers
Date:   Mon, 19 Jun 2023 20:34:01 +0530
Message-Id: <20230619150408.8468-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619150408.8468-1-manivannan.sadhasivam@linaro.org>
References: <20230619150408.8468-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DWC core already exposes dw_pcie_dbi_ro_wr_{en/dis} helper APIs for
enabling and disabling the write access to read only DBI registers. So
let's use them instead of doing it manually.

Also, the existing code doesn't disable the write access when it's done.
This is also fixed now.

Fixes: 5d76117f070d ("PCI: qcom: Add support for IPQ8074 PCIe controller")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ef385d36d653..01795ee7ce45 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -61,7 +61,6 @@
 /* DBI registers */
 #define AXI_MSTR_RESP_COMP_CTRL0		0x818
 #define AXI_MSTR_RESP_COMP_CTRL1		0x81c
-#define MISC_CONTROL_1_REG			0x8bc
 
 /* MHI registers */
 #define PARF_DEBUG_CNT_PM_LINKST_IN_L2		0xc04
@@ -132,9 +131,6 @@
 /* AXI_MSTR_RESP_COMP_CTRL1 register fields */
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
-/* MISC_CONTROL_1_REG register fields */
-#define DBI_RO_WR_EN				1
-
 /* PCI_EXP_SLTCAP register fields */
 #define PCIE_CAP_SLOT_POWER_LIMIT_VAL		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, 250)
 #define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, 1)
@@ -826,7 +822,9 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	writel(0, pcie->parf + PARF_Q2A_FLUSH);
 
 	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
-	writel(DBI_RO_WR_EN, pci->dbi_base + MISC_CONTROL_1_REG);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
 	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
-- 
2.25.1

