Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72DB20ECD4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 06:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgF3Et4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 00:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbgF3Etz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2020 00:49:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E97C08C5DB
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2020 21:49:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186so20978794yby.19
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2020 21:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1GSrptB51Ebugg9FWmWRPrlpTSANe16GXZRwAajHZjI=;
        b=Fzmn3zBwkz61BImTOmDr+UTqOyqjePTXGkh2hh+S9U5oUAWTEewVvXE0uQnsPICARw
         I99XjUw5d2rDoIZdnlsNGHrUCAmkOxGbNHRwaHrLSQ93afd5NQ2O9b8bt/QFN+kmOqz8
         6b/2D1Px6vY61wmL7bbf75lz0DLo7RzK8C2ue6JEr9B6rGRMQj4D5lsoIRC4digE15t2
         Jq+U37h/FBmiVefuqrmdLQ6Ozp1XMDCz2/MkwVnK2u1QRTAvChjhJ0ETbjj6l2hlq6bC
         OCCFlluLgpNQH2STAKDJat5EyiTzGw1QCtWN/NrA7MNM/GfXkk71b9IypHvuQw2C32pP
         Gf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1GSrptB51Ebugg9FWmWRPrlpTSANe16GXZRwAajHZjI=;
        b=iuhDyT2FJayGfer3iJpMc+NIxw8WmTcnga6oj65DI9Ddkk3PwUHeHZ6vsAeRBLAe+C
         ibjRTv0cZLqbNSkEIZs6R086BeTDLG7VrsfytWzPa8Ij7OAG1fbkRUdYh5pKYfnHCkH7
         oFEbpngyM6iCzjL54M59MZhD5pygWiF4JMWtoArYO1xkesGA2DCzLHu3TaLwsZ5sPXhs
         hOPQ826TTMrviCB/t2Lm1ppLM5FK+r9BWDRHcRkXsm5KLgb6N2d9Z14UfEH0NG9JasyH
         4YwYESM+LhPBqKSFTCso27IEMpfYCMTW1Cl6DcVLIlkJG16vgsYH7CqL/VkFYHncsYPt
         HkWQ==
X-Gm-Message-State: AOAM533vFjX1RanZjogi2mtxp4NbFjLFg3eN3IZ8zZV7fkd7wV+FfqrB
        3HIE3byzIAFn4/kNe1Cs2rO/OiyhGNN4
X-Google-Smtp-Source: ABdhPJyKXLRBH4F1knixflHShhi5F9yyQyirad1BSVGvjyy37E1ndR68pL34aiL8DZ68wClo3Fdo0aLLE7OB
X-Received: by 2002:a25:c442:: with SMTP id u63mr8382527ybf.92.1593492593590;
 Mon, 29 Jun 2020 21:49:53 -0700 (PDT)
Date:   Mon, 29 Jun 2020 21:49:39 -0700
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
Message-Id: <20200630044943.3425049-4-rajatja@google.com>
Mime-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 3/7] PCI/ACS: Enable PCI_ACS_TB for untrusted/external-facing
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
v2: Commit log change 

 drivers/pci/pci.c    |  4 ++++
 drivers/pci/quirks.c | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d2ff987585855..79853b52658a2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3330,6 +3330,10 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	/* Upstream Forwarding */
 	ctrl |= (cap & PCI_ACS_UF);
 
+	if (dev->external_facing || dev->untrusted)
+		/* Translation Blocking */
+		ctrl |= (cap & PCI_ACS_TB);
+
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b341628e47527..6294adeac4049 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
 	}
 }
 
+/*
+ * Currently this quirk does the equivalent of
+ * PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV
+ *
+ * Currently missing, it also needs to do equivalent of PCI_ACS_TB,
+ * if dev->external_facing || dev->untrusted
+ */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
 	if (!pci_quirk_intel_pch_acs_match(dev))
@@ -4973,6 +4980,10 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
+	if (dev->external_facing || dev->untrusted)
+		/* Translation Blocking */
+		ctrl |= (cap & PCI_ACS_TB);
+
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
 
 	pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
-- 
2.27.0.212.ge8ba1cc988-goog

