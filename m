Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAEA3B7625
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 18:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhF2QGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 12:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbhF2QFN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 12:05:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8810BC0617AE;
        Tue, 29 Jun 2021 09:02:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so2275288pjb.0;
        Tue, 29 Jun 2021 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FzFAYoe8i6E8Jfu7+JTjQ+OySct86gxILgXLJDPjav0=;
        b=JVND+J1ZeLfeqQ6ZiP4rtVLKB/YL5K1QQle3ljERTDuFTam1YsCA1H5ZI1jfwjM10q
         GmOiF6BYm/IBLvZUEcs85WH5DwvJqIEKLLPxrWA+1UVcJ6Zpw3h6paneZfDWMOx178Mk
         gBDz6cVh+1BgIwCRVK914IeEa8j8bYEaYJaYxk8SGENDupY1ubgmLSnJhFG0Fw4lt/no
         GZuhG68hdwE96nNJs2K9GwqSF9gGByI+v6vGX9wF6ZYd9pyj6Mj27noSbeE7TA4RNPIQ
         Yf7y2GYqNWagLqj442qe1GDsZfHQ8vnpP+ulihjrpljrv6iYgPD5pzDAB0sJm/eaHYcy
         zN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzFAYoe8i6E8Jfu7+JTjQ+OySct86gxILgXLJDPjav0=;
        b=MwQQALOiG4stpH+E4BvAT5LPuMuau/DFmytMkFQRSNPdxlQjN6ZmH3uoflTi0WfDB/
         gRfOn19+qExyUEkVfqMmrp8TbtN7tNBib7bbKs7V7FbkgrRoNhQGFvMeCZkf/H+C14Nw
         FAXDDrDnXm+TGs1EMrWsdMBlyprTFnENb8l4Fb092mZk+qyPKOM8wc6eOhx63PiWVxKd
         cGC74lMbA3eQMheMvVW1qnyjLNukIWHTUAyzeFy9L9Mg+6HaYRGDaBaDdyRL1QlWyeut
         qwwGGhzrlU1mcKiQoFGoeYz44Qr0wLMdlogINh/TdTCvrct3JC6QQU/5xOUfus3YKd3L
         63NA==
X-Gm-Message-State: AOAM532i3iyD+A+M2pcoe6uESCfDifMUtwbcPh6aREg0Z0Z8U4jNXZHt
        C4pSRH5Hu2DoFe/64TaIAfE=
X-Google-Smtp-Source: ABdhPJwuFy3vpV14Q7BqUre2ifDLQFdXFD61PRp61uM4DSQMm2po/jkc526fYVqIYNWnlg1vb8cTVQ==
X-Received: by 2002:a17:90a:c916:: with SMTP id v22mr6559433pjt.47.1624982541137;
        Tue, 29 Jun 2021 09:02:21 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.119])
        by smtp.googlemail.com with ESMTPSA id m14sm19166240pgu.84.2021.06.29.09.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 09:02:20 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v8 6/8] PCI: Setup ACPI fwnode early and at the same time with OF
Date:   Tue, 29 Jun 2021 21:31:02 +0530
Message-Id: <20210629160104.2893-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629160104.2893-1-ameynarkhede03@gmail.com>
References: <20210629160104.2893-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shanker Donthineni <sdonthineni@nvidia.com>

The pci_dev objects are created through two mechanisms 1) during PCI
bus scan and 2) from I/O Virtualization. The fwnode in pci_dev object
is being set at different places depends on the type of firmware used,
device creation mechanism, and acpi_pci_bridge_d3() WAR.

The software features which have a dependency on ACPI fwnode properties
and need to be handled before device_add() will not work. One use case,
the software has to check the existence of _RST method to support ACPI
based reset method.

This patch does the two changes in order to provide fwnode consistently.
 - Set ACPI and OF fwnodes from pci_setup_device().
 - Remove pci_set_acpi_fwnode() in acpi_pci_bridge_d3().

After this patch, ACPI/OF firmware properties are visible at the same
time during the early stage of pci_dev setup. And also call sites should
be able to use firmware agnostic functions device_property_xxx() for the
early PCI quirks in the future.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 drivers/pci/pci-acpi.c | 1 -
 drivers/pci/probe.c    | 7 ++++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index eaddbf701..dae021322 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -952,7 +952,6 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 		return false;
 
 	/* Assume D3 support if the bridge is power-manageable by ACPI. */
-	pci_set_acpi_fwnode(dev);
 	adev = ACPI_COMPANION(&dev->dev);
 
 	if (adev && acpi_device_power_manageable(adev))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 750ba53fb..9f0f2e5fb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1790,6 +1790,9 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->error_state = pci_channel_io_normal;
 	set_pcie_port_type(dev);
 
+	pci_set_of_node(dev);
+	pci_set_acpi_fwnode(dev);
+
 	pci_dev_assign_slot(dev);
 
 	/*
@@ -1925,6 +1928,7 @@ int pci_setup_device(struct pci_dev *dev)
 	default:				    /* unknown header */
 		pci_err(dev, "unknown header type %02x, ignoring device\n",
 			dev->hdr_type);
+		pci_release_of_node(dev);
 		return -EIO;
 
 	bad:
@@ -2352,10 +2356,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
 
-	pci_set_of_node(dev);
-
 	if (pci_setup_device(dev)) {
-		pci_release_of_node(dev);
 		pci_bus_put(dev->bus);
 		kfree(dev);
 		return NULL;
-- 
2.32.0

