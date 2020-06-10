Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF271F58A2
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbgFJQHr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 12:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbgFJQHj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 12:07:39 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C89C03E96F;
        Wed, 10 Jun 2020 09:07:38 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id o26so1800436edq.0;
        Wed, 10 Jun 2020 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dd+Z0yjxtztXOTLMBUJZUOa3hEnZCJ80Y/mxXHp3PO8=;
        b=FEePfPFgVZZCcpcfMbca3kv5qq8lzcNem0TgiIVvPpHFnrRotBAN9YB5aQmHNhWhKQ
         aLiTvuCsFYiGd9JQQ9svqpqieWGj3TSHdWevq2KLr3Rr55eiyL/KHbDEUurSZFeObQ62
         cGbttj7Yr+7cZYP/G4BEtTokTTNmiKA3cG3yE0sV0Y6UpkohjfW28kTFhfGMnhsn38/z
         HAIjsgcHlej5FedyfeIojDGj7G3ltRT6chJ5urtbVzVAZsSO2xbdeI5CC5yORrOYLh3C
         lomqJr0d4/ObImbSj2hjtmPlPkzzODpO7QlGH65ZHXND2ugo+ED/8m/XVMDYshbP/9+f
         TkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dd+Z0yjxtztXOTLMBUJZUOa3hEnZCJ80Y/mxXHp3PO8=;
        b=uGqyTlnme+mZZ29VW53rtyXmQkQxsKKQ0sTxp2ZNPfkrGcV8TBt7uZVA2g+QRB3q8a
         YNQozaXIHO62QL1yKjeJ8iWndyRz8PK3FlDsg7o1Myv+Tmc3c8tkF65aC7HYVYmWvDwy
         Lp+sIXvJ/y6aMJSaQcz8FdD52ObicsDroRDqoEciBZSps30/4zWygQ2Tz7Co5whmufxC
         vFR6KQ1cRWnCsYijuf8qrS2t5iibORLbXJ1ZTMzuFAZogsi+0VU2SN3DGYHT2gzzTXoU
         mO3tq0zyJtvD4hno8FnNk8mO6obrrphVtSUu9OjAn8A6rQ89WPYDLse4hznxWcREufhw
         tMmQ==
X-Gm-Message-State: AOAM533wb/AYM1ZFt3m8x04KcwqsklbryYB+qBRc/b5K3gSwQsqa70TV
        HL+MhvRn/x83YJgLlfoR5y0=
X-Google-Smtp-Source: ABdhPJy2QXHTerysK0MjqZYcEjsPjCtx7EmQmhU2ZSQ6TRAOctZNgcI5WHuK8Ee76OAhZaUlgdyklA==
X-Received: by 2002:aa7:c752:: with SMTP id c18mr3034215eds.55.1591805257335;
        Wed, 10 Jun 2020 09:07:37 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-35-249-242.retail.telecomitalia.it. [79.35.249.242])
        by smtp.googlemail.com with ESMTPSA id ce25sm56067edb.45.2020.06.10.09.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:07:36 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/12] PCI: qcom: Replace define with standard value
Date:   Wed, 10 Jun 2020 18:06:54 +0200
Message-Id: <20200610160655.27799-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610160655.27799-1-ansuelsmth@gmail.com>
References: <20200610160655.27799-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lots of define are actually already defined in pci_regs.h, directly use
the standard defines.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c40921589122..a23d3d886479 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -40,11 +40,6 @@
 #define L23_CLK_RMV_DIS				BIT(2)
 #define L1_CLK_RMV_DIS				BIT(1)
 
-#define PCIE20_COMMAND_STATUS			0x04
-#define CMD_BME_VAL				0x4
-#define PCIE20_DEVICE_CONTROL2_STATUS2		0x98
-#define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
-
 #define PCIE20_PARF_PHY_CTRL			0x40
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
@@ -73,8 +68,8 @@
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
 #define PCIE20_CAP				0x70
-#define PCIE20_CAP_LINK_CAPABILITIES		(PCIE20_CAP + 0xC)
-#define PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT	(BIT(10) | BIT(11))
+#define PCIE20_DEVICE_CONTROL2_STATUS2		(PCIE20_CAP + PCI_EXP_DEVCTL2)
+#define PCIE20_CAP_LINK_CAPABILITIES		(PCIE20_CAP + PCI_EXP_LNKCAP)
 #define PCIE20_CAP_LINK_1			(PCIE20_CAP + 0x14)
 #define PCIE_CAP_LINK1_VAL			0x2FD7F
 
@@ -1095,15 +1090,15 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 		pcie->parf + PCIE20_PARF_SYS_CTRL);
 	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
 
-	writel(CMD_BME_VAL, pci->dbi_base + PCIE20_COMMAND_STATUS);
+	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
 	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
 	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + PCIE20_CAP_LINK_1);
 
 	val = readl(pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
-	val &= ~PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT;
+	val &= ~PCI_EXP_LNKCAP_ASPMS;
 	writel(val, pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
 
-	writel(PCIE_CAP_CPL_TIMEOUT_DISABLE, pci->dbi_base +
+	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base +
 		PCIE20_DEVICE_CONTROL2_STATUS2);
 
 	return 0;
-- 
2.25.1

