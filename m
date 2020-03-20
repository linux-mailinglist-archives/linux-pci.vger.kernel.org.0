Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BADE118D74B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCTSfP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:35:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36074 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbgCTSfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 14:35:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id b18so8337646edu.3;
        Fri, 20 Mar 2020 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTJvUrUZh6Asz0TpkI0T8aoHyYL8TgG05bomTjzSOyM=;
        b=g9rdUihThyk73P8wLgLB9/dtJ7c1YiBnldNvV9so+qC4nsHi9lh0LbppH794U4VT5v
         hTaDpUpZf8eWS1bzyjnhxG4Z8aWizFPUb3xj0BnO84gyg19I+Wu5oh3Ny9as6sNLgUaA
         jGe7oqDk6xFKGtOIjkDYvWI8WCT82VCDW4vF0MnQhZiZV8E2WTKgavcar1DtRMaQT4A9
         Vd/yzR/eXJls2bPqU0kyMYj098DlUf5E1U30qlGAkINvH/L7wj3ygwdpmUlPD8nuLmEU
         ZckL6BCB8dDIjUH7kIX/oqtrn3c8DYx7bWlmG8yHgRHFFICq86/5TY864wIGyd/l/jzV
         74YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QTJvUrUZh6Asz0TpkI0T8aoHyYL8TgG05bomTjzSOyM=;
        b=WUB0A8e/DbtHtVMNtpVCgzaJRrwlLmwQt6ZrjR9k1zuTEJ3hrPYjNrOy+71/vS0kE9
         94mfKSvaxfzLGsRbEqKL7X5Te9JCuPeQ2Q+8U76UR9QDq2Bkon81aT1FUuLuQ+nb2nEL
         8AO4NhNQeCAP3Frkolvp4KxtET0XqZY205sC+PekM0l5nOxSyhJtrbFZS2RCGDPc4vNW
         Ll/9i7ZT5ruby89ozT9cYdHLCt2sU6yEUwJLm2V8ze9eyuVQZGDLNi8xl7oQh7SUxq9i
         nYAX9vqkyolJ6Bhk9NaYsq/OxPHls/HhoQzZmVgf0MR+SQ5b6K/1YN/OjMxftPJ7awS7
         04Bg==
X-Gm-Message-State: ANhLgQ0ghMZBDrwYzl6qaCPbrgiefa1+1Q75OuAoet7/6Iu+rCr6YRgQ
        LQRK1v2vxjbnNGwoKXVsuuM=
X-Google-Smtp-Source: ADFU+vslcEfYS+a701OQE8C0wc0N89UVXf8ty5raYXpe2pQxadJpErSZ7aVEf2b+Kh2eOVhdLyGMMQ==
X-Received: by 2002:a05:6402:369:: with SMTP id s9mr9384490edw.349.1584729313054;
        Fri, 20 Mar 2020 11:35:13 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host203-232-dynamic.53-79-r.retail.telecomitalia.it. [79.53.232.203])
        by smtp.googlemail.com with ESMTPSA id y13sm172916eje.3.2020.03.20.11.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:35:12 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] pcie: qcom: Fixed pcie_phy_clk branch issue
Date:   Fri, 20 Mar 2020 19:34:46 +0100
Message-Id: <20200320183455.21311-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320183455.21311-1-ansuelsmth@gmail.com>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Following backtraces are observed in PCIe deinit operation.

 Hardware name: Qualcomm (Flattened Device Tree)
 (unwind_backtrace) from [] (show_stack+0x10/0x14)
 (show_stack) from [] (dump_stack+0x84/0x98)
 (dump_stack) from [] (warn_slowpath_common+0x9c/0xb8)
 (warn_slowpath_common) from [] (warn_slowpath_fmt+0x30/0x40)
 (warn_slowpath_fmt) from [] (clk_branch_wait+0x114/0x120)
 (clk_branch_wait) from [] (clk_core_disable+0xd0/0x1f4)
 (clk_core_disable) from [] (clk_disable+0x24/0x30)
 (clk_disable) from [] (qcom_pcie_deinit_v0+0x6c/0xb8)
 (qcom_pcie_deinit_v0) from [] (qcom_pcie_host_init+0xe0/0xe8)
 (qcom_pcie_host_init) from [] (dw_pcie_host_init+0x3b0/0x538)
 (dw_pcie_host_init) from [] (qcom_pcie_probe+0x20c/0x2e4)

pcie_phy_clk is generated for PCIe controller itself and the
GCC controls its branch operation. This error is coming since
the assert operations turn off the parent clock before branch
clock. Now this patch moves clk_disable_unprepare before assert
operations.

Similarly, during probe function, the clock branch operation
should be done after dessert operation. Currently, it does not
generate any error since bootloader enables the pcie_phy_clk
but the same error is coming during probe, if bootloader
disables pcie_phy_clk.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 1fcc7fed8443..596731b54728 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -280,6 +280,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 
+	clk_disable_unprepare(res->phy_clk);
 	reset_control_assert(res->pci_reset);
 	reset_control_assert(res->axi_reset);
 	reset_control_assert(res->ahb_reset);
@@ -287,7 +288,6 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 	reset_control_assert(res->phy_reset);
 	clk_disable_unprepare(res->iface_clk);
 	clk_disable_unprepare(res->core_clk);
-	clk_disable_unprepare(res->phy_clk);
 	clk_disable_unprepare(res->aux_clk);
 	clk_disable_unprepare(res->ref_clk);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -325,12 +325,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		goto err_clk_core;
 	}
 
-	ret = clk_prepare_enable(res->phy_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable phy clock\n");
-		goto err_clk_phy;
-	}
-
 	ret = clk_prepare_enable(res->aux_clk);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable aux clock\n");
@@ -383,6 +377,12 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(res->phy_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable phy clock\n");
+		goto err_deassert_ahb;
+	}
+
 	/* wait for clock acquisition */
 	usleep_range(1000, 1500);
 
@@ -400,8 +400,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 err_clk_ref:
 	clk_disable_unprepare(res->aux_clk);
 err_clk_aux:
-	clk_disable_unprepare(res->phy_clk);
-err_clk_phy:
 	clk_disable_unprepare(res->core_clk);
 err_clk_core:
 	clk_disable_unprepare(res->iface_clk);
-- 
2.25.1

