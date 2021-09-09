Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFF24046C3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 10:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhIIIL2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 04:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhIIIL2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Sep 2021 04:11:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5F0C061575
        for <linux-pci@vger.kernel.org>; Thu,  9 Sep 2021 01:10:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q68so992652pga.9
        for <linux-pci@vger.kernel.org>; Thu, 09 Sep 2021 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:from:to:cc:subject:content-transfer-encoding
         :mime-version;
        bh=yGLo+toND5jU9flZz7HkKuB7cLD/PMYmRpmhqNm6K9E=;
        b=iNulV7Ro0lZFevZmW0jQ2n7Wb/zZkDlQ5qQ9VaF05EFo4lYc/pu568+WbD7yxHb2yD
         fPBvEUjs39jvFkrvkQbtmtpZA1T077l/YoTDLLVwFllwZ5HhSSpHDSJ1Aq5MEQejUj9P
         TvQ7wX/mj809KcAkPiRpRIZ7x/bhk3JFQJQfIsMn2/pf3Ooxd2hsqousvinV/hKXkh4H
         Y71+vcm9kjTwLM4sTOJkEoI/c7qhmh2bDZlJQVuB6Z/zuU/iJMdgoS7KpO1G5SnB4HaL
         GkaokS5WTpwFdfRnybLMQyVO91QsCm94Ayhhuuho/MRNmT1Shhl71rIfB3VHfwlF4Paf
         NEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=yGLo+toND5jU9flZz7HkKuB7cLD/PMYmRpmhqNm6K9E=;
        b=fz74+XkB42ufjOmmNfEn7FpvFbcauIxAiXNzFYypfAqiPgAN8Nj6lA+tZzqzSx0b+U
         i1QBZH6vNhtVqPxBA5zpgEzZcbCMZMiAeN8LVmIoXYECEgJDXXzJkYsfL4glgCaAUZTx
         x7lgS1i3H+QwiHbHta3z2HFp5GnVAUrNCuAPGPvUFLkiC48bDQxxyL0nFOAo5+DgTx6P
         eGwzUKB4UuXryRuRNr+OynLPJtQqNhu8v5J6Lcv4rIaadBCydglrrvbrTyKEgYP4SYMY
         xv1wCcrqcjczv6llHYq9i/XGIg6wKt7MmOFLghlFSyU7JbWLrhr7hOkDkEXa6kMQ9VSp
         +62A==
X-Gm-Message-State: AOAM532o/Kj8QfP31pBUC1WwlkN95U5qnjPUy+LPvYkSKdKD307if+tf
        toQLJnUB+Shs45jQ1dPOkOrkLTfjvfNGAg==
X-Google-Smtp-Source: ABdhPJzx66vz3JJHtHyzXILqzyHFMwpf9nFnbCh+y2RglojqK1FQuIEUO8wrudg+LgJbni2Kx97vzw==
X-Received: by 2002:a63:ce57:: with SMTP id r23mr1540817pgi.271.1631175018735;
        Thu, 09 Sep 2021 01:10:18 -0700 (PDT)
Received: from [127.0.1.1] (117-20-69-24.751445.bne.nbn.aussiebb.net. [117.20.69.24])
        by smtp.gmail.com with UTF8SMTPSA id 141sm1449957pgf.46.2021.09.09.01.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 01:10:18 -0700 (PDT)
Date:   Thu, 09 Sep 2021 08:09:27 +0000
Message-Id: <20210909080927.164709-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-pci@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] PCI: Add ACS errata for Pericom PI7C9X2G404 switch
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
forward mode. The errata results in packets being queued and not being
delivered upstream, this can be observed as very poor downstream device
performance and/or dropped device generated data/interrupts.

This change adds a fixup specific to this switch that when enabling or
resuming the downstream port it checks if it has enabled ACS P2P Request
Redirect, and if so changes the device (via the upstream port) to use
the store and forward operating mode.

Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
---
Changes in v2:
- Added DECLARE_PCI_FIXUP_RESUME to handle applying fixup upon resume as
  switch operation may have been reset or ACS configuration may have
  changed
---
 drivers/pci/quirks.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e5089af8ad..5849b7046b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5790,3 +5790,51 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
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
+/*
+ * Apply fixup on enable and on resume, in order to apply the fix up whenever
+ * ACS configuration changes or switch mode is reset
+ */
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2404,
+			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2404,
+			 pci_fixup_pericom_acs_store_forward);
---
2.33.0
