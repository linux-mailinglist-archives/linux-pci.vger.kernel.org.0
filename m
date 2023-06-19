Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3494A735ABE
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjFSPGN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjFSPFX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 11:05:23 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED1A10E6
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2023 08:04:48 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39eab4bbe8aso2185408b6e.1
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2023 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687187088; x=1689779088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkQkFXSrqR5MDMbqBcH7Nxin9P2rGGa9soJkqC/yxfY=;
        b=KL7WH9esTs7EFOrJOLlQDJsDcT/mfXXCsaCZDtwfYT+K05rl4Y0uOKqA/nDRWmM1Ay
         P0taJUuvOsjTeEXMez6C0nO7L1aJAoU0K3Fjc1lJVCl9ASZJCTyRjDx39SMKsSJgVjUI
         +nC498m4/o4uDShwgfyz9btY1mBsJhpn64wArvb82L+zGlP/PL09DQBvIavoKC1TNLcW
         MjtJF09kB4h01Yrj1fX0TNT3dROZOVwuDdNOAdKCMjF44SHOpvkte9RU97YN3M86+26U
         H5k9xq1Fmw/9RrXcAqB2TlMbGi9Ht0McM5hkCefS5MAV4huKmK5Oyu37azQTD3PDoCKG
         AzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187088; x=1689779088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkQkFXSrqR5MDMbqBcH7Nxin9P2rGGa9soJkqC/yxfY=;
        b=PkcaebYeHu4d04pCal8UAC7E5akPHx/lkF0VEZLdHTQssFh9HJWU+N3MFEuBYaOkoI
         C+8mou10evAVlSbA50wC2AuqxPNAqaj8zCVmFut0isUB1GcoEle+zUkuuamPfQWcv0hR
         k10shqOOcBh4jhP18xYqVb1sbVCGVOeKZsxSkpzr5TpBicT9vsM+RuCv/kuQqCgQllQo
         yAFN62d27PnuAqqlVTCgTPqQwInF1A2MgBNCT85YKsMQEBha+V3HOmjRwvbxMOH+1tyY
         rVYMTn6qVd67a9RxZML58PBagCEIXrmj6Eqzx5cHZdOnjmydezxsJ6gGRZWWENlidlo8
         EQRA==
X-Gm-Message-State: AC+VfDwQSfKU5BaBhHilIXftYPyPlWpN4qLrsNts4ZC7dGf9zXszHr1Y
        O3UKFrPj8v4C+IFWvJDMW1cp
X-Google-Smtp-Source: ACHHUZ6jYi9B9kO4LbGSPIQT3nzgy6RoEcq55MHd7+0LtTnVlE8m58y0+GdIRnKABb/+X0ocxXlQNQ==
X-Received: by 2002:a05:6808:301:b0:3a0:35c5:f79d with SMTP id i1-20020a056808030100b003a035c5f79dmr9833oie.36.1687187088151;
        Mon, 19 Jun 2023 08:04:48 -0700 (PDT)
Received: from localhost.localdomain ([117.217.183.37])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b0025efaf7a0d3sm2765480pjj.14.2023.06.19.08.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:04:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 8/9] PCI: qcom: Do not advertise hotplug capability for IP v1.0.0
Date:   Mon, 19 Jun 2023 20:34:07 +0530
Message-Id: <20230619150408.8468-9-manivannan.sadhasivam@linaro.org>
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

SoCs making use of Qcom PCIe controller IP v1.0.0 do not support hotplug
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
index e6db9e551752..612266fb849a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -521,6 +521,8 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
+	qcom_pcie_clear_hpc(pcie->pci);
+
 	return 0;
 }
 
-- 
2.25.1

