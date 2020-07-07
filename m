Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B320217B38
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 00:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgGGWqV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 18:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgGGWqN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2020 18:46:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6B1C08C5DC
        for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2020 15:46:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r17so48933221ybj.22
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2020 15:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n09L38FqLziZB80XiEEa4U3Rbl7E07buKJV52yFHq04=;
        b=Gc/SRTnIxUHoSJi+odkT9ED/cAZBziEF60Mve91fM9ATmPS3FGriWKvJORZEl5Z0i6
         Rt1q9Vj5DMEAtIDwvsa0svlN3MYRac1QJf+VBjUzkBJ22HvTQa8Now99YUMjCbAmUArG
         5X+9HsquJ7uXVe4Pxn4vmk60HOhkEddPfyOyNrHxPW1zHyAcQIwk3gp0EqwnVfa3GZY4
         q4JcOTH38ilJwF+ZrP6i0omqbEBDlm/Qojb6gfUCxgu5Ue6rglL1jV4JOPjCNpS+ODQj
         hyRyy82rMnXmypFgaIK9L3UolmGvLn5iAPdb1li5GfA7hM9hQC5Y3D/8RLFnLgvk5HSZ
         pO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n09L38FqLziZB80XiEEa4U3Rbl7E07buKJV52yFHq04=;
        b=BTDvIgou4erDBx03KPYMH8OEl12VKJ2o4KIcK67ZCVgHdRKNFU/SAsFV1YVQMc2Hx9
         nuYyTyxXjvk9tCcV5qHUvNi1hXqFn5fBVCdGKGXtvWznV/6Mii1tPkXnkDWpoyCEifLv
         JtGLWQ8rWVqkmbGiM9M8gKzTl/nBGCXMbaDFgM4R9uo8oyhAkLb0r8W2vWzmj2EKlXwU
         HIm2SpbcqVAX3M2OgC4FyZ1geV6aCTGrykEWoMFjboU/ajULn7xEhQG6e8u6r/1ntETE
         snKucGg+uK667hut0itAr3n20CrJqL72jCKvKPwBWTtwh2cZkNZkh6y6z0SuAj/1csbj
         8g7A==
X-Gm-Message-State: AOAM530OCxT6uJcjA2MYkUUXMPOSrSjpuLfts2fCi/zAaTJIwJISi8G1
        MILsIytz5aaUngQ20VT2AV/HS3wt9yLq
X-Google-Smtp-Source: ABdhPJyqUZg0SfkVxfU/L4DX91czSrlqUnkerJoAkpXyDw0tpSP0A/Ld1JaoBY9wWt59l+/b2cp9XcCWy7MR
X-Received: by 2002:a25:8007:: with SMTP id m7mr31698114ybk.60.1594161972909;
 Tue, 07 Jul 2020 15:46:12 -0700 (PDT)
Date:   Tue,  7 Jul 2020 15:46:04 -0700
In-Reply-To: <20200707224604.3737893-1-rajatja@google.com>
Message-Id: <20200707224604.3737893-4-rajatja@google.com>
Mime-Version: 1.0
References: <20200707224604.3737893-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for untrusted/external-facing
 devices
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

When enabling ACS, enable translation blocking for external facing ports
and untrusted devices.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v4: Add braces to avoid warning from kernel robot
    print warning for only external-facing devices.
v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
    Minor code comments fixes.
v2: Commit log change

 drivers/pci/pci.c    |  8 ++++++++
 drivers/pci/quirks.c | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 73a8627822140..a5a6bea7af7ce 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -876,6 +876,14 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	/* Upstream Forwarding */
 	ctrl |= (cap & PCI_ACS_UF);
 
+	/* Enable Translation Blocking for external devices */
+	if (dev->external_facing || dev->untrusted) {
+		if (cap & PCI_ACS_TB)
+			ctrl |= PCI_ACS_TB;
+		else if (dev->external_facing)
+			pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
+	}
+
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b341628e47527..bb22b46c1d719 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
 	}
 }
 
+/*
+ * Currently this quirk does the equivalent of
+ * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
+ *
+ * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
+ * if dev->external_facing || dev->untrusted
+ */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
 	if (!pci_quirk_intel_pch_acs_match(dev))
@@ -4973,6 +4980,14 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
+	/* Enable Translation Blocking for external devices */
+	if (dev->external_facing || dev->untrusted) {
+		if (cap & PCI_ACS_TB)
+			ctrl |= PCI_ACS_TB;
+		else if (dev->external_facing)
+			pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
+	}
+
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
 
 	pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
-- 
2.27.0.212.ge8ba1cc988-goog

