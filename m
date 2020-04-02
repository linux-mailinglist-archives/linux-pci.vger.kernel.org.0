Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF7519C0D9
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 14:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388283AbgDBMMI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 08:12:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41582 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388270AbgDBMMH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 08:12:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id v1so3778621edq.8;
        Thu, 02 Apr 2020 05:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTJvUrUZh6Asz0TpkI0T8aoHyYL8TgG05bomTjzSOyM=;
        b=RgRQbPEzT5t5qyUie+NZNDm7W//5r0zMUaVjO0vTHJXLn1Jq+AFFTQ8NF6cuRQg3+r
         jw/UZ0DJckiTbrsc2w+LRw9hB6+7eL355HC2PuA/h9kNI0v/BB7GMtLZFI2h2ggYUkzO
         2kWywja4BJWC6XJrGLixUBQ3ljfSuaSCOndwZ2/U0e7YWUQaq8COd31WDAGmAdJ/94yh
         yPe70XqwKy2yEEQjQyKtkqApsUALuBjY6nHOPvhtvtaWRIVWjeRoSSxZQDNQ7g4CPmMb
         xx/RPHnWVJ8675BRNXgFsSccucnSRJBTzypSeCXH6FRq5vzNuJuKye5C6I5dMdtdtYeK
         3k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QTJvUrUZh6Asz0TpkI0T8aoHyYL8TgG05bomTjzSOyM=;
        b=uc3AlM4XzV/n30xVL7NjtLsyGSQTIW8McC753TdFZ6U4S0f/SaygdwI0d0ab6EVwyl
         hWrhJGD+r4ExHc+xUlSeojeIRPXvylx0HG/5id9KqDJ21q69/e5L67x/WJr4OTsQl+Tg
         iCh+MZG5rmSbMXg5ysq+i032jtXRwohGQ1lZTHgEXj4uq+LFonAcuULep4xO6jOXDirw
         /76HgHgSE9POuKB4fmmYBUOAMfdTepUHt/QS8uVhvEOwBbskQBbQ26UZ7EEHcPjLh38Q
         GanjOsLeBALiV9a29U7CX+bSMskg/zZHc2Zrr6TB7XqooPv6HfkON5PlCuzjYKI+kXlV
         tUYQ==
X-Gm-Message-State: AGi0PuZXCAisRoNnXecsqQjTsM2A1hE9t8YuKoPL+2CC0gAW/Vejt4Ok
        shWmWKwm3RC+xrx7pEU95Uo=
X-Google-Smtp-Source: APiQypIapMX5g/RNGOzYfHeGKlNQ8T/bL6HvSioskJYSxgPjXIMKz7gAV5jsSa4/pYer1Ua7q64ybQ==
X-Received: by 2002:a05:6402:705:: with SMTP id w5mr2585708edx.288.1585829524941;
        Thu, 02 Apr 2020 05:12:04 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host250-251-dynamic.250-95-r.retail.telecomitalia.it. [95.250.251.250])
        by smtp.googlemail.com with ESMTPSA id w20sm1083611ejv.40.2020.04.02.05.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:12:04 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] PCIe: qcom: Fixed pcie_phy_clk branch issue
Date:   Thu,  2 Apr 2020 14:11:41 +0200
Message-Id: <20200402121148.1767-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402121148.1767-1-ansuelsmth@gmail.com>
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
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

