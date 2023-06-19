Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C61735AB0
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjFSPFe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 11:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjFSPFQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 11:05:16 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F67819B0
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2023 08:04:33 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1a9d57f8f9fso3311712fac.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2023 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687187073; x=1689779073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A98UhrwZrGyc1cxKVoW5P/FDL2aF5ZgMxYnhHsr36+Y=;
        b=EbDKlvCL0JefPd3whitlUpQhGUTNoSgjlKumRPfJJUtaRaRyJi+GXgBe31dGYr55C9
         ooZUsmxAmjAppZ5UZ+pVq90G5rEuSmRRGezO0LHbpNsr0QBgX/e2E8trhwuUHjO1yboz
         IRGB2OQ4ucJyQBP+bUdwxIgscucJ1rALjFg6TBzngbUBHOD8yI8VZoJ+URb1UngfQi+R
         1QjQXE4M89eAna+gUWYkhhDfYPqpcFOv2RDAWpYni6BG119UbCn8Ufsg5BjcyLIh/cUq
         niy86RbSU38dkxt+ppkH+YyH6w+dfqv88OPDc1LsJILqrDaL9+6bAAQXbBuxS11oViJJ
         xtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187073; x=1689779073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A98UhrwZrGyc1cxKVoW5P/FDL2aF5ZgMxYnhHsr36+Y=;
        b=h9zaGJjtXbYKuV3Pf/uYaUW92qhZYoD9ZZIeu7psyD6N7H/qUFqkWT3hF1TJ4AvHH8
         PQhgBqHSbYdw4tr3G4tfN6qV9mYx0mxxRh5w2e9+5fKvarv3E5wWUmP8lvegFSn6YsnE
         dkEkbsS0m/c/mfjuoKKFILCfvyRx3FeEFoVKZr70Zc4lUVIE0VrrdzqFmr4blowhA7LW
         i4qtTPCn3wq9rkec79sl8Zzg0YSoUGH8gIEmehADAEm0rV5Gj9EXYo0Pvhx2JG9OrxSe
         bJGxEhMdhHc7ZY1SCaV9/8C211PCN5nqEdhw15TykjL3D17SckjP+wb3v2e+alhzdH2D
         wa8Q==
X-Gm-Message-State: AC+VfDwKq2wMu+ubzxMBHyHEc0FCIMjV9PYCfh/lq7z5WBVh+PDehU2A
        TSRxImS0epKCt5U09JxHcRZ1
X-Google-Smtp-Source: ACHHUZ5SNI/kwXJznqe6EkZb9zy0U9dMvylpUymgT1TDx1gqUr+yiw95cWcUBffVD5qvzPCw77UOnw==
X-Received: by 2002:a05:6871:894:b0:1a2:cfd7:bfdc with SMTP id r20-20020a056871089400b001a2cfd7bfdcmr12096478oaq.6.1687187072875;
        Mon, 19 Jun 2023 08:04:32 -0700 (PDT)
Received: from localhost.localdomain ([117.217.183.37])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b0025efaf7a0d3sm2765480pjj.14.2023.06.19.08.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:04:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 4/9] PCI: qcom: Do not advertise hotplug capability for IPs v2.7.0 and v1.9.0
Date:   Mon, 19 Jun 2023 20:34:03 +0530
Message-Id: <20230619150408.8468-5-manivannan.sadhasivam@linaro.org>
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

SoCs making use of Qcom PCIe controller IPs v2.7.0 and v1.9.0 do not
support hotplug functionality. But the hotplug capability bit is set by
default in the hardware. This causes the kernel PCI core to register
hotplug service for the controller and send hotplug commands to it. But
those commands will timeout generating messages as below during boot and
suspend/resume.

[    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
[    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
[    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
[    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)

This not only spams the console output but also induces a delay of a
couple of seconds. To fix this issue, let's clear the HPC bit in
PCI_EXP_SLTCAP register as a part of the post init sequence to not
advertise the hotplug capability for the controller.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 391a45d1e70a..8f448156eccc 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -270,6 +270,20 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
+static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
+{
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
+	val &= ~PCI_EXP_SLTCAP_HPC;
+	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -966,6 +980,13 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	return ret;
 }
 
+static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
+{
+	qcom_pcie_clear_hpc(pcie->pci);
+
+	return 0;
+}
+
 static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
@@ -1272,6 +1293,7 @@ static const struct qcom_pcie_ops ops_2_3_3 = {
 static const struct qcom_pcie_ops ops_2_7_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
+	.post_init = qcom_pcie_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
@@ -1280,6 +1302,7 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 static const struct qcom_pcie_ops ops_1_9_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
+	.post_init = qcom_pcie_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.config_sid = qcom_pcie_config_sid_1_9_0,
-- 
2.25.1

