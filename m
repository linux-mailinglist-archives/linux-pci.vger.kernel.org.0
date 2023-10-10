Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9317C00EF
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 17:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjJJP7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 11:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjJJP7k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 11:59:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C3DCF
        for <linux-pci@vger.kernel.org>; Tue, 10 Oct 2023 08:59:38 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-694f3444f94so4788638b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Oct 2023 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696953578; x=1697558378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mr4EIMH8RidVLiQCjZesTsiyIho+EqgKqP+n2ghexZ0=;
        b=V/tno/VmWysmqS8GOvQPddbaRMCx+TH7RqH5h3STf1QZxqf7isva4RjLNMYD2J07yI
         sLGXZQ7KpjRPEfVhTyV2uYeQs2H1l5Gv25OJG1LedvHNasURibT+DuICyaCBqDrBQ2B9
         XXngnFQL76rNf7VBqF3BFm50V+ZkDN85yrvbkeJxJcWFPrjo2cK7EeDy6IcTl3Up+8EQ
         bUpDYxEXZhrqpv7SX7fCKQ7CZihQrFN0D491wHwK1fwGSy0GHICrQe85jbfSq2tpDgr1
         HpCPODOQypOKnnj2g9/ltLiToBqLCDjPCn1oSRtA5aU0T1b4YtPMlziGqJ6JZ4jmICY6
         tq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696953578; x=1697558378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mr4EIMH8RidVLiQCjZesTsiyIho+EqgKqP+n2ghexZ0=;
        b=huM0zxp8ILTQIY3VSeTJ21XU99+mKa05AmWCOnQWmaTetocT5T3wB/9ztfwZTBrQvD
         PfoCfhk/c5UmDEsh6YxA1SSa0uZvje2jjkkZ888Aaz5RzbTV6wIDWZvWWF4Vuacpa5HQ
         Io7paUcqM6V1idGnF3iCh8hCVBzmk439sH8/6+WYqxVhbO5OSkTLSBjPvbj28G6rarrT
         w/xBD8IJHG0heFTMdOw5Dh4g0y/oTN/PX5LTFokv4i4YTeM2f/HTObOp1Xv2vaQYXOHa
         i88o+ierAUOGDQvR/qQtCtvCNVrQOqTdDuvJ2cktTmTTxxvOx/T5ZlJ1KG/op/3zZWWp
         PP+w==
X-Gm-Message-State: AOJu0Yzg2mL9dCBsBG9dtnNF44rp5k89kK52pG5QVk+Lfbw3o6r/+t43
        R+QuF4EhYBHiHg7LP4vOjjbk
X-Google-Smtp-Source: AGHT+IGZsh/8Q0P3Q/53kwfHSFlOV+p4RTFFqq7TsSk24jv7/qLF1y3Fthhkiyz3Aep4/SuzlKbqbQ==
X-Received: by 2002:a05:6a20:258f:b0:14d:d9f8:83f8 with SMTP id k15-20020a056a20258f00b0014dd9f883f8mr22767237pzd.1.1696953577720;
        Tue, 10 Oct 2023 08:59:37 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id c24-20020a637258000000b0055c178a8df1sm6537023pgn.94.2023.10.10.08.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 08:59:37 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/2] PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops
Date:   Tue, 10 Oct 2023 21:29:14 +0530
Message-Id: <20231010155914.9516-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231010155914.9516-1-manivannan.sadhasivam@linaro.org>
References: <20231010155914.9516-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ASPM is supported by Qcom host controllers/bridges on most of the recent
platforms and so the devices tested so far. But for enabling ASPM by
default (without Kconfig/cmdline/sysfs), BIOS has to enable ASPM on both
host bridge and downstream devices during boot. Unfortunately, none of the
BIOS available on Qcom platforms enables ASPM. Due to this, the platforms
making use of Qcom SoCs draw high power during runtime.

To fix this power issue, users/distros have to enable ASPM using configs
such as (Kconfig/cmdline/sysfs) or the BIOS has to start enabling ASPM.
The latter may happen in the future, but that won't address the issue on
current platforms. Also, asking users/distros to enable a feature to get
the power management right would provide an unpleasant out-of-the-box
experience.

So the apt solution is to enable ASPM in the controller driver itself. And
this is being accomplished by calling pci_enable_link_state() in the newly
introduced host_post_init() callback for all the devices connected to the
bus. This function enables all supported link low power states for both
host bridge and the downstream devices.

Due to limited testing, ASPM is only enabled for platforms making use of
ops_1_9_0 callbacks.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 367acb419a2b..c324c3daaa5a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -222,6 +222,7 @@ struct qcom_pcie_ops {
 	int (*get_resources)(struct qcom_pcie *pcie);
 	int (*init)(struct qcom_pcie *pcie);
 	int (*post_init)(struct qcom_pcie *pcie);
+	void (*host_post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
@@ -967,6 +968,22 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
+{
+	/* Downstream devices need to be in D0 state before enabling PCI PM substates */
+	pci_set_power_state(pdev, PCI_D0);
+	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
+
+	return 0;
+}
+
+static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
+{
+	struct dw_pcie_rp *pp = &pcie->pci->pp;
+
+	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_aspm, NULL);
+}
+
 static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
@@ -1219,9 +1236,19 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	pcie->cfg->ops->deinit(pcie);
 }
 
+static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	if (pcie->cfg->ops->host_post_init)
+		pcie->cfg->ops->host_post_init(pcie);
+}
+
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.host_init	= qcom_pcie_host_init,
 	.host_deinit	= qcom_pcie_host_deinit,
+	.host_post_init	= qcom_pcie_host_post_init,
 };
 
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
@@ -1283,6 +1310,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
 	.post_init = qcom_pcie_post_init_2_7_0,
+	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.config_sid = qcom_pcie_config_sid_1_9_0,
-- 
2.25.1

