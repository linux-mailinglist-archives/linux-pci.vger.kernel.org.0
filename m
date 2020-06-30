Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3902020ECD2
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 06:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgF3Etv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 00:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbgF3Etu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2020 00:49:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3495FC061755
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2020 21:49:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l9so20548862ybm.20
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2020 21:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oOkAbwq8p407mhg423y3Mz2Wo+eujw0WSddpP6QvRRY=;
        b=bqRlWmWFtzvxjY/hGDN0smVXPSmteQpIkwImH3mOT3bpWT/83vg+H0LthEfYPvJ7eE
         OjdTm6vaUdar72o0GcothiKheZeLXY7WnbrCw32HNKpBzmrv29B/o2bQ5xh7ABw2gufw
         mlRStONhvk4aqg1Wm/SDCEf+n8a2VvRaHWDp+XYCGXqqJFsUmUv5De4SMEXzX3LQOcnS
         D8qqp/Jrqpg93hmyRNyrvvyrQ4WxAfasyRtrR5wmPtICzJKIVTmGGsQKT1Qj2krwqX/i
         CvmWUZtpw4xXae7d25HqX1Fgd92sxB0Vq0pPAGdHDqgQblCn1WJbVR8GQf9F3iapw932
         QFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oOkAbwq8p407mhg423y3Mz2Wo+eujw0WSddpP6QvRRY=;
        b=GM5omZOMTYEOpXaj0rkxDWQgSF1X7mZZo81TT1DI6BXN9ORL1c3gURuIPhoav64e1W
         b2LKT6vnXRiBq2efmCGyi/llZbQoTZTGG6++HL2AM4hYqMotTrZyDAKcT07RVyM3E5pF
         JWQDgHvY4ODBlmWffMdPOJw1plFysvfH1RsKHhk/IPFGEAUgPBGC77XOavFpILPKc6kh
         4wtfZQeDSIZw60Wnwvs22tazgXo6RUxC46IggWGbnkQ8pw4yakgsJWgt9bhjq+ETdAac
         inHDht9QsAAdLSAkLGAr5cftJdaxWbpJxA7sFXEIL/96nyulBnFEmHhx/bJBOqtaRuV+
         v94A==
X-Gm-Message-State: AOAM532XE4cDjmEGf6MCC7LNDWldnSgk+WpOL0dBEWvMXFe1CJdVK8V5
        W6rLNSv50tcVZlAJDnUNTfqI2+4ohLHX
X-Google-Smtp-Source: ABdhPJxhj935WeKux4i7rydgzCngHBXskKxNfygrruRg/KnQPX5IW/lx4g7i2XO9UTRgefom2yTqLzVuowMz
X-Received: by 2002:a25:408:: with SMTP id 8mr31144133ybe.500.1593492589407;
 Mon, 29 Jun 2020 21:49:49 -0700 (PDT)
Date:   Mon, 29 Jun 2020 21:49:37 -0700
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
Message-Id: <20200630044943.3425049-2-rajatja@google.com>
Mime-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 1/7] PCI: Keep the ACS capability offset in device
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

Currently this is being looked up at a number of places. Read and store it
once at bootup so that it can be used by all later.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Commit log cosmetic changes

 drivers/pci/p2pdma.c |  2 +-
 drivers/pci/pci.c    | 21 +++++++++++++++++----
 drivers/pci/pci.h    |  2 +-
 drivers/pci/probe.c  |  2 +-
 drivers/pci/quirks.c |  8 ++++----
 include/linux/pci.h  |  1 +
 6 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index e8e444eeb1cd2..f29a48f8fa594 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -253,7 +253,7 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
 	int pos;
 	u16 ctrl;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ACS);
+	pos = pdev->acs_cap;
 	if (!pos)
 		return 0;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce096272f52b1..d2ff987585855 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -51,6 +51,7 @@ EXPORT_SYMBOL(pci_pci_problems);
 
 unsigned int pci_pm_d3_delay;
 
+static void pci_enable_acs(struct pci_dev *dev);
 static void pci_pme_list_scan(struct work_struct *work);
 
 static LIST_HEAD(pci_pme_list);
@@ -3284,7 +3285,7 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
 	if (!pci_dev_specific_disable_acs_redir(dev))
 		return;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	pos = dev->acs_cap;
 	if (!pos) {
 		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
 		return;
@@ -3310,7 +3311,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	u16 cap;
 	u16 ctrl;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	pos = dev->acs_cap;
 	if (!pos)
 		return;
 
@@ -3336,7 +3337,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-void pci_enable_acs(struct pci_dev *dev)
+static void pci_enable_acs(struct pci_dev *dev)
 {
 	if (!pci_acs_enable)
 		goto disable_acs_redir;
@@ -3362,7 +3363,7 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	int pos;
 	u16 cap, ctrl;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ACS);
+	pos = pdev->acs_cap;
 	if (!pos)
 		return false;
 
@@ -3487,6 +3488,18 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 	return true;
 }
 
+/**
+ * pci_acs_init - Initialize if hardware supports it
+ * @dev: the PCI device
+ */
+void pci_acs_init(struct pci_dev *dev)
+{
+	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+
+	if (dev->acs_cap)
+		pci_enable_acs(dev);
+}
+
 /**
  * pci_rebar_find_pos - find position of resize ctrl reg for BAR
  * @pdev: PCI device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6d3f758671064..12fb79fbe29d3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -532,7 +532,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 	return resource_alignment(res);
 }
 
-void pci_enable_acs(struct pci_dev *dev);
+void pci_acs_init(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2f66988cea257..6d87066a5ecc5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2390,7 +2390,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_ats_init(dev);		/* Address Translation Services */
 	pci_pri_init(dev);		/* Page Request Interface */
 	pci_pasid_init(dev);		/* Process Address Space ID */
-	pci_enable_acs(dev);		/* Enable ACS P2P upstream forwarding */
+	pci_acs_init(dev);		/* Access Control Services */
 	pci_ptm_init(dev);		/* Precision Time Measurement */
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 812bfc32ecb82..b341628e47527 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4653,7 +4653,7 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
 	if (!pci_quirk_intel_spt_pch_acs_match(dev))
 		return -ENOTTY;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
 
@@ -4961,7 +4961,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	if (!pci_quirk_intel_spt_pch_acs_match(dev))
 		return -ENOTTY;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
 
@@ -4988,7 +4988,7 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
 	if (!pci_quirk_intel_spt_pch_acs_match(dev))
 		return -ENOTTY;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
 
@@ -5355,7 +5355,7 @@ int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *l, int timeout)
 	bool found;
 	struct pci_dev *bridge = bus->self;
 
-	pos = pci_find_ext_capability(bridge, PCI_EXT_CAP_ID_ACS);
+	pos = bridge->acs_cap;
 
 	/* Disable ACS SV before initial config reads */
 	if (pos) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c79d83304e529..a26be5332bba6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -486,6 +486,7 @@ struct pci_dev {
 #ifdef CONFIG_PCI_P2PDMA
 	struct pci_p2pdma *p2pdma;
 #endif
+	u16		acs_cap;	/* ACS Capability offset */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
 	char		*driver_override; /* Driver name to force a match */
-- 
2.27.0.212.ge8ba1cc988-goog

