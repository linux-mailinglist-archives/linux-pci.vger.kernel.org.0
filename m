Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEF47754F2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 10:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjHIITV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 04:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjHIITU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 04:19:20 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB40171E
        for <linux-pci@vger.kernel.org>; Wed,  9 Aug 2023 01:19:19 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1bc479cc815so5170565fac.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Aug 2023 01:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691569159; x=1692173959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Okzh3I3dzCaHx/bUTlDK1L8F0UIhPrJOUlojekDh3o=;
        b=w2eFjDPWzAORfg5gZl6b/D1O0q/g5sM0KeZ+LXfzb3SM+XbwJxbmWCbWx3rRzDCu7c
         1JvwydZmEXJtvccfgbMkxkGswri3FZ+fGJX33NDK1Zh9kQNNRv1fQVC/tE685qq2XAQW
         gV2wmTEIDwGATUzoDSViYRrEkmmh9JiaCd0ReuFeiCOxRaf62//2DQ3mrAu4b1sHmRET
         ehY+a0EF3Fo7cIU4XXfORfkvwncFgxW2yUZuHXT+h05cfPbHMSp4yB9Y4y69xtJE/SSr
         RameDHrn1aH7WrVf6pIEoanaKU+oUPdIl6Nj12hW8Y8lujHiO01d5GKMSuHpbBU5MTdy
         BbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691569159; x=1692173959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Okzh3I3dzCaHx/bUTlDK1L8F0UIhPrJOUlojekDh3o=;
        b=UZ1yVF/KLgyZdRzmNeZ/MZmtttXR1MP3GbwhDbMsvd4yYvssK8XxZSYpbv9IBE2aFo
         vo890wgDhj2/LO4epkDr4KTT1Up+8C5n1XTooySp8U2KzgxU5y0cApn1WNy48zVz80QJ
         YWk/N9D39791HLZXQcj1Se9mrv4riHPAHOtcIR3/TPGRjmo4p/S8IqtAKo1PKs+Oyfho
         ohT/KWyT3DDrI4c6Ff9gLMHlJKhHThGGT6Ce5+AV50bMlHsS6vT0fp8YwHU0oxplphBp
         3rCcFuOjpeH7svKM1VLM0UchrmRTdNxkpNquDkSbyt5ZifebeU0g+prmY0Q82sWHXp8u
         /GjQ==
X-Gm-Message-State: AOJu0Yyp/CqFvQVV7Y4n+PH3/TcyZexvjYcECdrYbP4JKH7RedRRF0bc
        J44pGQ/Db9x893ckZy7ZnegG
X-Google-Smtp-Source: AGHT+IF8RxjtXdMtgun8QOPi+B+HN1viKgLXoYS1LWbrh0VyxHAqKv9TBjzGUa1hBSNQ+BNOnmQ3FQ==
X-Received: by 2002:a05:6870:418c:b0:1bf:b863:b64 with SMTP id y12-20020a056870418c00b001bfb8630b64mr1897438oac.19.1691569158866;
        Wed, 09 Aug 2023 01:19:18 -0700 (PDT)
Received: from localhost.localdomain ([117.207.25.122])
        by smtp.gmail.com with ESMTPSA id v13-20020a62a50d000000b00686ee7ba3easm9331881pfm.216.2023.08.09.01.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 01:19:18 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andersson@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops
Date:   Wed,  9 Aug 2023 13:48:40 +0530
Message-Id: <20230809081840.16034-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230809081840.16034-1-manivannan.sadhasivam@linaro.org>
References: <20230809081840.16034-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index cee4e400a695..ef843328a9a0 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -219,6 +219,7 @@ struct qcom_pcie_ops {
 	int (*get_resources)(struct qcom_pcie *pcie);
 	int (*init)(struct qcom_pcie *pcie);
 	int (*post_init)(struct qcom_pcie *pcie);
+	void (*host_post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
@@ -964,6 +965,22 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
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
@@ -1216,9 +1233,19 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
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
@@ -1280,6 +1307,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
 	.post_init = qcom_pcie_post_init_2_7_0,
+	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.config_sid = qcom_pcie_config_sid_1_9_0,
-- 
2.25.1

