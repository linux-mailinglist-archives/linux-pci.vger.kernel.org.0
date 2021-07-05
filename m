Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05493BBE2A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhGEOZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 10:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbhGEOZJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 10:25:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41ABC061574;
        Mon,  5 Jul 2021 07:22:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s13so7236698plg.12;
        Mon, 05 Jul 2021 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1N3+qWlEG+Qg73HGcApeu+QIm5Y+1lSdg14qL5Ytgo=;
        b=I6oizvPvHL+WCwjmHmcKNfI8iLnnA8kGMIJghSJdL7NOyRvGA+HBQBIE24G1bi/9Ca
         xvRwl7bqE/sD0teac/t8TCVF4biSLZ1KFjqgDGbZJw10k86MNJenqJq8bTLcqZCq3OfA
         xCUjyFt9t/FeTIupXBgJ4LfYIb4hlmVqCk7WjZ5ZXp+C4L1En/tY2esULG9Sm4VTFwZa
         3DoSdZ8hONVKrWB2C2/Dp8ZYnsYj9gybx951BzPuqSiJ+37coP3juCrDfpARlyPelNAA
         tf0iQ3zbhdVbtivhr7DFinJXX+PuDfLmF77PZzBqIanzVChm0d0A0gBvzKbYMkgIKMJo
         Gz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1N3+qWlEG+Qg73HGcApeu+QIm5Y+1lSdg14qL5Ytgo=;
        b=OINWRbLiRVJFiTnjMNV4ct6nt8CmBzhtgI34fpX1npAMpqvcnf9vKfQVBJwyEFYzew
         b31NyNnv3d+Xa/RZIiKf4JKAVPbzz9FdLg5IptoNdYG/2iNpIVQNxWmLjayyCzb63OlL
         v7bN4MFuAcUF5SeR1wZO20epjN5sscNGAuZw3by7zlRrFOnObGVT+yPq732Rx3hG+uI1
         QezkOOkI7YElqbawraIG2H+0Vbqy1L+KJBpXlWhxLt3MuGbGb9O/3dO+vFyM1w4PfV2l
         /JQQtOZdDnmKepTEtYb6zVBOMdU00pnFGwxwpkwWl9Q5ZTfu4bH8795oaslQloYXdISe
         yZhA==
X-Gm-Message-State: AOAM530VGCCl80llBscJ+T6jzqZe7zzrtNGWsg/MxIUWtMKU73g7ur8B
        hPlrjF5Ss8uVcGD+kgsmmA0=
X-Google-Smtp-Source: ABdhPJz3/tGECHbpfs2E9rtjoI6L8iPtlP5MuPrr/j0yag0LiG5a6nzU96OZdYMt1r097qE3mVv9EA==
X-Received: by 2002:a17:90a:6d89:: with SMTP id a9mr15816933pjk.194.1625494951443;
        Mon, 05 Jul 2021 07:22:31 -0700 (PDT)
Received: from localhost.localdomain ([2409:4042:2696:1624:5e13:abf4:6ecf:a1f1])
        by smtp.googlemail.com with ESMTPSA id 92sm22615307pjv.29.2021.07.05.07.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 07:22:31 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v9 6/8] PCI: Setup ACPI fwnode early and at the same time with OF
Date:   Mon,  5 Jul 2021 19:51:36 +0530
Message-Id: <20210705142138.2651-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705142138.2651-1-ameynarkhede03@gmail.com>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
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
index 221a20415..ba0137322 100644
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

