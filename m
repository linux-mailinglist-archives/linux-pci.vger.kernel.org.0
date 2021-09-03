Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404603FF926
	for <lists+linux-pci@lfdr.de>; Fri,  3 Sep 2021 05:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhICDlk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 23:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhICDlj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Sep 2021 23:41:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE43C061575
        for <linux-pci@vger.kernel.org>; Thu,  2 Sep 2021 20:40:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t1so4266264pgv.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Sep 2021 20:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:from:to:cc:subject:content-transfer-encoding
         :mime-version;
        bh=U0NNmang+93xJ9CRYg1HjleQnuQby/iUfCmqiHaIqdU=;
        b=Izl1w15alYScT9KmnBbONV8fQPHmF+slJLCSGeA/43CKxMHKWoGk2FztBYAqHKj6ZN
         mfk8w7G8fZG0PxGLPJp0eXSEU8g/r/7rlgEy4eMkrk+4pQqxprQhmqtmFG2mVBImgVCX
         9Z/Up4+5lYSwRneyI9FIJaz2MH2t9KQohx3HfuDXAVc0rWn60mLKD0eALT0Jf3NDv5WL
         ezmhRA2JI8mB1UDftZhDGFCROZehtCzhv87CekSO4fWbAj0OBHGio59VG2YnXZG+vvCe
         UXg6hpsq+kiILcEUrgNGZYm+sTkVZPq0Uuq3yD4sAuk3IaYFioel4TuwwihRPJpyo6RM
         4RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=U0NNmang+93xJ9CRYg1HjleQnuQby/iUfCmqiHaIqdU=;
        b=MpDGFHDEUY67e8wg73+pgKIQT43wIJUrEHZvzW0X3n9ev/1yrDMrkA1rCi/F3d8mT1
         bR5tTVtQqs2fRY8r+XdFkVjsc0/UiSLC4J6+01FHzEymSo+AdaeThNu7TcpG1gmj5AoS
         VAfM5/UqhVyqO3MSKLKYDmzWqomdqiAmt/yGg38EEKX5xxDO96L0esAxpC9Ourj3usf/
         vIf8bESfjP3/CsR49+O4VWI13f9cCjTUnIdlxJtO0wkHGD0ozxJDsIzBaP3lnzrz5ZFU
         tJ2zWczviBRyLzI1SZKGFnbHpTmpEM4OqlG9zZWo9hg8uazCtgP8mTvKY097o2D6o285
         CRXA==
X-Gm-Message-State: AOAM530ydLmnLnu327cPv9yyUEmJ7QWPppZ8KS5HUEWV4GkCc9+9m2Kl
        xMuv8fZPCIGpKzdrnf0CnvTcZkl5J/ii8fmY
X-Google-Smtp-Source: ABdhPJzNy8cgtG5tUB+Yv0m0rYtBXMykDJcrqvvMe9MlLfbYhWpR5RcVw7s4j6VqAJixneo8Ty0Dew==
X-Received: by 2002:a63:111f:: with SMTP id g31mr1684290pgl.80.1630640439455;
        Thu, 02 Sep 2021 20:40:39 -0700 (PDT)
Received: from [127.0.1.1] (117-20-69-24.751445.bne.nbn.aussiebb.net. [117.20.69.24])
        by smtp.gmail.com with UTF8SMTPSA id x189sm325815pfx.30.2021.09.02.20.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 20:40:39 -0700 (PDT)
Date:   Fri, 03 Sep 2021 03:40:29 +0000
Message-Id: <20210903034029.306816-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-pci@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Add ACS errata for Pericom PI7C9X2G404 switch
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Nathan Rossi <nathan.rossi@digi.com>

The Pericom PI7C9X2G404 PCIe switch has an errata for ACS P2P Request
Redirect behaviour when used in the cut-through forwarding mode. The
recommended work around for this issue is to use the switch in store and
forward mode.

This change adds a fixup specific to this switch that when enabling the
downstream port it checks if it has enabled ACS P2P Request Redirect,
and if so changes the device (via the upstream port) to use the store
and forward operating mode.

Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
---
 drivers/pci/quirks.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ab3de1551b..1ea6661d01 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5704,3 +5704,45 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+/*
+ * Pericom PI7C9X2G404 switch errata E5 - ACS P2P Request Redirect is not
+ * functional
+ *
+ * When ACS P2P Request Redirect is enabled and bandwidth is not balanced
+ * between upstream and downstream ports, packets are queued in an internal
+ * buffer until CPLD packet. The workaround is to use the switch in store and
+ * forward mode.
+ */
+#define PI7C9X2G404_MODE_REG		0x74
+#define PI7C9X2G404_STORE_FORWARD_MODE	BIT(0)
+static void pci_fixup_pericom_acs_store_forward(struct pci_dev *pdev)
+{
+	struct pci_dev *upstream;
+	u16 val;
+
+	/* Downstream ports only */
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
+		return;
+
+	/* Check for ACS P2P Request Redirect use */
+	if (!pdev->acs_cap)
+		return;
+	pci_read_config_word(pdev, pdev->acs_cap + PCI_ACS_CTRL, &val);
+	if (!(val & PCI_ACS_RR))
+		return;
+
+	upstream = pci_upstream_bridge(pdev);
+	if (!upstream)
+		return;
+
+	pci_read_config_word(upstream, PI7C9X2G404_MODE_REG, &val);
+	if (!(val & PI7C9X2G404_STORE_FORWARD_MODE)) {
+		pci_info(upstream, "Setting PI7C9X2G404 store-forward mode\n");
+		/* Enable store-foward mode */
+		pci_write_config_word(upstream, PI7C9X2G404_MODE_REG, val |
+				      PI7C9X2G404_STORE_FORWARD_MODE);
+	}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2404,
+			 pci_fixup_pericom_acs_store_forward);
---
2.33.0
