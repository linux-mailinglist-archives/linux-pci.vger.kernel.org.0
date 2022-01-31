Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4D74A469A
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 13:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348389AbiAaMIz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 07:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351380AbiAaMIz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 07:08:55 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90E6C061714;
        Mon, 31 Jan 2022 04:08:54 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j2so26154220edj.8;
        Mon, 31 Jan 2022 04:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TvB/L+qgB/BhC4HvCjJPFFAzV5TyQ93kn0tMstVAmJQ=;
        b=VwsBbQ45g/pUtJRiPkmGzxG5OSP5GN+tsFTi4a5YNsaPeTgMiIePfq7/ZIVUGPPE5R
         2DxyDpUJQprDVf63ECXz/nutFX7nNSdi1A+zTo0A9E1znFnUQMmSLpZQItMYwv/KUsbY
         RbaHnsGAxcXWYNkDy//DS3OHJwxlFySIrUyV4owrnKblqxbQTh9JC9N8FH0lvA2zEjDG
         zSj3JagWm2gEVkHcGJMFc22AkNXcMQZsDlAeyiNLyNmSeYQSwr2Lca8MRuoeUQIBfA42
         +QsB0/N8EoNlY/81lBB2R5itYgRJCRI6hAjiw2HODcbmgx4h/dSWHgxjS6P2EOBIEsjI
         8oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TvB/L+qgB/BhC4HvCjJPFFAzV5TyQ93kn0tMstVAmJQ=;
        b=cMxEoo/+5T1qqFTShCOqsdbT75+uz8Qz85rPkvdOLfHtV9SNkk4VBe/rdI1HvQCsKn
         8Jip2KhkODtyJ7OKTmUY95neoozoL8o2GiwBzeaTJae/vuwVA/8kBOUtYY4wnHu6JysK
         8VDSdia53XM8yaribjNV/BxkyjBtLifIfM5EImiA9zIRE1BhYK4S9Aips21dFWwE/UA6
         wfJzvkKknvIGzz3gVpJ+RsliKktav7lF9GBBJZyZVSLOxMnesRrn0Ks5wKbT+ZGn7CPS
         aDigize0h9ULlUyUqb/sjOIEpzpe5/jsfn2+MqYEcmJQxtSvmNwda3dEwDvCn8GBNLQI
         pW+w==
X-Gm-Message-State: AOAM5315k67GyLptIQ4ddGRivrjzMR4xX9WDVgQ7O6nON+nJmiI7ztEj
        SwzDOD7ssBmZ4GA3tNc26YkrkNEoKh6QmQ==
X-Google-Smtp-Source: ABdhPJzEP40J2JXVpgaxe9rVh7Cse9HqtcmIvV4DKsJg9fevNePmM4dFZdEZYEM36CglMbo5SINBhA==
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr20298146edd.65.1643630933175;
        Mon, 31 Jan 2022 04:08:53 -0800 (PST)
Received: from localhost.localdomain.info (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id j2sm13380735ejc.223.2022.01.31.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 04:08:52 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: cadence: respond to received PTM Requests
Date:   Mon, 31 Jan 2022 13:08:27 +0100
Message-Id: <20220131120841.118833-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This enables the Controller [RP] to automatically respond
with Response/ResponseD messages.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 10 ++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index fb96d37a135c..940c7dd701d6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -123,6 +123,14 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
 	return ret;
 }
 
+static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
+{
+	u32 val;
+
+	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
+	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
+}
+
 static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -501,6 +509,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	if (rc->quirk_detect_quiet_flag)
 		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
 
+	cdns_pcie_host_enable_ptm_response(pcie);
+
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to start link\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index c8a27b6290ce..9510ea513b8a 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -116,6 +116,10 @@
 #define LM_RC_BAR_CFG_APERTURE(bar, aperture)		\
 					(((aperture) - 2) << ((bar) * 8))
 
+/* PTM Control Register */
+#define CDNS_PCIE_LM_PTM_CTRL 	(CDNS_PCIE_LM_BASE + 0x0DA8)
+#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN 	BIT(17)
+
 /*
  * Endpoint Function Registers (PCI configuration space for endpoint functions)
  */
-- 
2.34.1

