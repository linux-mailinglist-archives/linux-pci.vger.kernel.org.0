Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E163E0989
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 22:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhHDUm6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 16:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbhHDUm5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 16:42:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673FAC0613D5;
        Wed,  4 Aug 2021 13:42:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso5295868pjf.4;
        Wed, 04 Aug 2021 13:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r29+sUujdKPey6oLGLCs3NweFY8aTssXwj399PyY5uY=;
        b=GfH9AQYfOwf64sqJ9ZMAiEHLdYTlYEd2WpYW1kqEEoHn7I0bHZUbDyvQRiDivWiydK
         zVw/8MvwKOtp0DK3M8y0zcikwHAG1GNojbz3IJtUcaa2Qv0LV/NXYzKrPyndiPhvjVfz
         Xid8iYY5tJre3kuzzNipFD7HoUWwqJHfonaSZeU7ALE0WxX5LQ8oqqj6B3zn39w7E+e7
         mHQ/h0Ew5y2mMpd8e/+U6cTf3YM5/hcS/+cmDKlVXE/UT+TEiz1xPH5jGxSPMoPEh2w8
         for4V+6UP5UGgKJXinMI+XXqAf6skLs2buH4E3yYCM82j6STdjh+4oyyKmHLU5cCNsci
         bnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r29+sUujdKPey6oLGLCs3NweFY8aTssXwj399PyY5uY=;
        b=nhUmm+52YkX+XRwrmImGF7IICJJgtGdcmuE/hJ8xGHKH7MTMKpj3DR4vgpviNdkB03
         ZLQC3mWeOh48qHoK/oqbSn5QAyWvR+ozL10GBqF3U89vRVILmQHpvTzkydk1Yr0SBTjX
         paYhcK+viPqDxUjN03gWLq78IV79szIrtkIS57Y6bHKKQkjYej+sCyXSNBpAAg5byO6H
         cUP9Pz/mRr2LX4sDcUXtXMifKZJ21lmRarn6EU0rEE5gYvzUDymwLao09Jr4BmbXDGRb
         MGBCrhaao1PbvImcOe4irUqcRmElz7036MZkIJtkC/shZWwWTmZo4dkFQj/MN0aOvUus
         N/gg==
X-Gm-Message-State: AOAM530DEa8ip5Fzh2yStSG9wBOGwFcFLcjQaIxq8ROzc98LWDJ16Hsk
        VIC989I2bsIYA31u3KWmxBM=
X-Google-Smtp-Source: ABdhPJzSfPqWAzEyYwNOfMGjI1eR0PABPIkTtRv8JrJ6T+jj6NH0kzSTBi4Fx3VHiJgMu7xSW4iNnA==
X-Received: by 2002:a17:90b:1d0d:: with SMTP id on13mr11762309pjb.69.1628109764024;
        Wed, 04 Aug 2021 13:42:44 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.161])
        by smtp.googlemail.com with ESMTPSA id w2sm7064922pjt.14.2021.08.04.13.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 13:42:43 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v14 7/9] PCI: Setup ACPI fwnode early and at the same time with OF
Date:   Thu,  5 Aug 2021 02:11:59 +0530
Message-Id: <20210804204201.1282-8-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804204201.1282-1-ameynarkhede03@gmail.com>
References: <20210804204201.1282-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shanker Donthineni <sdonthineni@nvidia.com>

The pci_dev objects are created through two mechanisms 1) during PCI
bus scan and 2) from I/O Virtualization. The fwnode in pci_dev object
is being set at different places depends on the type of firmware used,
device creation mechanism, and acpi_pci_bridge_d3().

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
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci-acpi.c | 1 -
 drivers/pci/probe.c    | 7 ++++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index eaddbf701759..dae021322b3f 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -952,7 +952,6 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 		return false;
 
 	/* Assume D3 support if the bridge is power-manageable by ACPI. */
-	pci_set_acpi_fwnode(dev);
 	adev = ACPI_COMPANION(&dev->dev);
 
 	if (adev && acpi_device_power_manageable(adev))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 379e85037d9b..15a6975d3757 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1789,6 +1789,9 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->error_state = pci_channel_io_normal;
 	set_pcie_port_type(dev);
 
+	pci_set_of_node(dev);
+	pci_set_acpi_fwnode(dev);
+
 	pci_dev_assign_slot(dev);
 
 	/*
@@ -1924,6 +1927,7 @@ int pci_setup_device(struct pci_dev *dev)
 	default:				    /* unknown header */
 		pci_err(dev, "unknown header type %02x, ignoring device\n",
 			dev->hdr_type);
+		pci_release_of_node(dev);
 		return -EIO;
 
 	bad:
@@ -2351,10 +2355,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
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

