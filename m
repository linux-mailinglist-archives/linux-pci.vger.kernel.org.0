Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD5217B2F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 00:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgGGWqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 18:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729314AbgGGWqJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2020 18:46:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B924DC08C5E1
        for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2020 15:46:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p22so49075310ybg.21
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2020 15:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IEfZLZ78xcvl63YOGXYJYdTw/XucW2SRwmLFdcRTwIE=;
        b=eBoPjreRWiU8NjeW0Fu/7efs7C8GadIPXxLb/b4W5z53Uu77vk+4febcwq1JkQeMf2
         4H/ljOzw8mCmTooOmnt6GTFSbciL3mt1aeUEH4vXypwvYUAt/br50PHlR9O93yw1uz50
         P5Z3GylpA0obhYQ4nFfgyViY67nhALdrKqOadGfpMwgmh/wg4DJQWkH6oiXAXR1+hk66
         JVswL/NopEugGFHnkAXeD9cuoksXiQqw5s9qdAYbVgxJsaBCyu15+e//XDy+MSlpV3XL
         7yAgS1UvTX8hmQd3/1kGtTB7NBQRMFzrH8jTJjOSbDe2ogGDcE4PST808XY3R4jmRHol
         VzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IEfZLZ78xcvl63YOGXYJYdTw/XucW2SRwmLFdcRTwIE=;
        b=DE44QUUN9s+lE/ZCE+gCS60eDbpDlp3X+rywDBRaUd1TEx0vTIRel5HyQP0G1ZIPBZ
         e9YDjKqMYc9J9R72WgNTG6VSelBk3AdggttsmQJKLpD46tYaa2xmvnWRcI89Qil3dcHz
         Sy9/veEMDZ86MJqwziDXu2Spu4k7D4QQHkEZyuSrq0wKZmB9xc69lvGA9jOZmW3D02ig
         44sgGcdjU+fSeWlCJzBNqtm+55FT3sPtm8Kx/RqiUd9Q3Uw7x70VRSmrRqTJe71BClO6
         Ym2ltA/fPh1NCr98wrI5fXdayhg55bRtXv2b/bhVZ0fzvgHXQQn7kgQUmt7YJGDhasuO
         772Q==
X-Gm-Message-State: AOAM531bytmqyYTlbejJOOw6ctfxp4eaoeRDXgwYK3KXrb3p7+H3irUV
        jUxVkdtjSeliIcJ/uN/q+G7Ex5kooqqZ
X-Google-Smtp-Source: ABdhPJz62vzOsYrjFc5Vg2wRsVItzBkR3EFMlTaNhnQrwZLPYqgptPIriecmFQNCxJnn+co+nTLjrfOxXlzl
X-Received: by 2002:a25:7755:: with SMTP id s82mr34709305ybc.275.1594161967387;
 Tue, 07 Jul 2020 15:46:07 -0700 (PDT)
Date:   Tue,  7 Jul 2020 15:46:01 -0700
Message-Id: <20200707224604.3737893-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v4 1/4] PCI: Move pci_enable_acs() and its dependencies up in pci.c
From:   Rajat Jain <rajatja@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move pci_enable_acs() and the functions it depends on, further up in the
source code to avoid having to forward declare it when we make it static
in near future (next patch).

No functional changes intended.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v4: Same as v3
v3: Initial version of the patch, created per Bjorn's suggestion

 drivers/pci/pci.c | 254 +++++++++++++++++++++++-----------------------
 1 file changed, 127 insertions(+), 127 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce096272f52b1..eec625f0e594e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -777,6 +777,133 @@ int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask)
 	return 0;
 }
 
+static int pci_acs_enable;
+
+/**
+ * pci_request_acs - ask for ACS to be enabled if supported
+ */
+void pci_request_acs(void)
+{
+	pci_acs_enable = 1;
+}
+
+static const char *disable_acs_redir_param;
+
+/**
+ * pci_disable_acs_redir - disable ACS redirect capabilities
+ * @dev: the PCI device
+ *
+ * For only devices specified in the disable_acs_redir parameter.
+ */
+static void pci_disable_acs_redir(struct pci_dev *dev)
+{
+	int ret = 0;
+	const char *p;
+	int pos;
+	u16 ctrl;
+
+	if (!disable_acs_redir_param)
+		return;
+
+	p = disable_acs_redir_param;
+	while (*p) {
+		ret = pci_dev_str_match(dev, p, &p);
+		if (ret < 0) {
+			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
+				     disable_acs_redir_param);
+
+			break;
+		} else if (ret == 1) {
+			/* Found a match */
+			break;
+		}
+
+		if (*p != ';' && *p != ',') {
+			/* End of param or invalid format */
+			break;
+		}
+		p++;
+	}
+
+	if (ret != 1)
+		return;
+
+	if (!pci_dev_specific_disable_acs_redir(dev))
+		return;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos) {
+		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
+		return;
+	}
+
+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
+
+	/* P2P Request & Completion Redirect */
+	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
+
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+
+	pci_info(dev, "disabled ACS redirect\n");
+}
+
+/**
+ * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
+ * @dev: the PCI device
+ */
+static void pci_std_enable_acs(struct pci_dev *dev)
+{
+	int pos;
+	u16 cap;
+	u16 ctrl;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		return;
+
+	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
+
+	/* Source Validation */
+	ctrl |= (cap & PCI_ACS_SV);
+
+	/* P2P Request Redirect */
+	ctrl |= (cap & PCI_ACS_RR);
+
+	/* P2P Completion Redirect */
+	ctrl |= (cap & PCI_ACS_CR);
+
+	/* Upstream Forwarding */
+	ctrl |= (cap & PCI_ACS_UF);
+
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+}
+
+/**
+ * pci_enable_acs - enable ACS if hardware support it
+ * @dev: the PCI device
+ */
+void pci_enable_acs(struct pci_dev *dev)
+{
+	if (!pci_acs_enable)
+		goto disable_acs_redir;
+
+	if (!pci_dev_specific_enable_acs(dev))
+		goto disable_acs_redir;
+
+	pci_std_enable_acs(dev);
+
+disable_acs_redir:
+	/*
+	 * Note: pci_disable_acs_redir() must be called even if ACS was not
+	 * enabled by the kernel because it may have been enabled by
+	 * platform firmware.  So if we are told to disable it, we should
+	 * always disable it after setting the kernel's default
+	 * preferences.
+	 */
+	pci_disable_acs_redir(dev);
+}
+
 /**
  * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
  * @dev: PCI device to have its BARs restored
@@ -3230,133 +3357,6 @@ void pci_configure_ari(struct pci_dev *dev)
 	}
 }
 
-static int pci_acs_enable;
-
-/**
- * pci_request_acs - ask for ACS to be enabled if supported
- */
-void pci_request_acs(void)
-{
-	pci_acs_enable = 1;
-}
-
-static const char *disable_acs_redir_param;
-
-/**
- * pci_disable_acs_redir - disable ACS redirect capabilities
- * @dev: the PCI device
- *
- * For only devices specified in the disable_acs_redir parameter.
- */
-static void pci_disable_acs_redir(struct pci_dev *dev)
-{
-	int ret = 0;
-	const char *p;
-	int pos;
-	u16 ctrl;
-
-	if (!disable_acs_redir_param)
-		return;
-
-	p = disable_acs_redir_param;
-	while (*p) {
-		ret = pci_dev_str_match(dev, p, &p);
-		if (ret < 0) {
-			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
-				     disable_acs_redir_param);
-
-			break;
-		} else if (ret == 1) {
-			/* Found a match */
-			break;
-		}
-
-		if (*p != ';' && *p != ',') {
-			/* End of param or invalid format */
-			break;
-		}
-		p++;
-	}
-
-	if (ret != 1)
-		return;
-
-	if (!pci_dev_specific_disable_acs_redir(dev))
-		return;
-
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
-	if (!pos) {
-		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
-		return;
-	}
-
-	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
-
-	/* P2P Request & Completion Redirect */
-	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
-
-	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
-
-	pci_info(dev, "disabled ACS redirect\n");
-}
-
-/**
- * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
- * @dev: the PCI device
- */
-static void pci_std_enable_acs(struct pci_dev *dev)
-{
-	int pos;
-	u16 cap;
-	u16 ctrl;
-
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
-	if (!pos)
-		return;
-
-	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
-	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
-
-	/* Source Validation */
-	ctrl |= (cap & PCI_ACS_SV);
-
-	/* P2P Request Redirect */
-	ctrl |= (cap & PCI_ACS_RR);
-
-	/* P2P Completion Redirect */
-	ctrl |= (cap & PCI_ACS_CR);
-
-	/* Upstream Forwarding */
-	ctrl |= (cap & PCI_ACS_UF);
-
-	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
-}
-
-/**
- * pci_enable_acs - enable ACS if hardware support it
- * @dev: the PCI device
- */
-void pci_enable_acs(struct pci_dev *dev)
-{
-	if (!pci_acs_enable)
-		goto disable_acs_redir;
-
-	if (!pci_dev_specific_enable_acs(dev))
-		goto disable_acs_redir;
-
-	pci_std_enable_acs(dev);
-
-disable_acs_redir:
-	/*
-	 * Note: pci_disable_acs_redir() must be called even if ACS was not
-	 * enabled by the kernel because it may have been enabled by
-	 * platform firmware.  So if we are told to disable it, we should
-	 * always disable it after setting the kernel's default
-	 * preferences.
-	 */
-	pci_disable_acs_redir(dev);
-}
-
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 {
 	int pos;
-- 
2.27.0.212.ge8ba1cc988-goog

