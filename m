Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407A73C238D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhGIMlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 08:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhGIMlu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jul 2021 08:41:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E63C0613DD;
        Fri,  9 Jul 2021 05:39:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso5997210pjp.2;
        Fri, 09 Jul 2021 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VS1RajXqBW2rHG06wEAoXVbvaifwKd8wbtqi5Hfsnaw=;
        b=BfuWcoyHrceQHRAs10S9LX9GEcHzZlaWauC2RfF230gpURHUl3wIxeupwetiLPQZRW
         wW3JMk53olTKiw15PMQBTR1k6xFtbdCB0fFq5H6TcIoyqYB39RyM/xN6ghWpOempSLK9
         j+xyDWTj4J5dHECtp9Rfgmjinze9EHkSEaUtfW1AoKxiY3hFfNATvBN6Nov0JVxCJSD1
         ranoBzh7p0GlGOfFdd8YYDg5eC9fI01Zy4S8EZZqBp4sF1hTtyjaeP5FipO3py9qNx4Z
         IO7Jh1254atBApTG73xURB8X3kcY5kv8JP+FyiX/Dp5m9bvvqBp8/nplxjJIZdJMnQVk
         zYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VS1RajXqBW2rHG06wEAoXVbvaifwKd8wbtqi5Hfsnaw=;
        b=Laf09lfSOrUrq0cTQWFjn7Oqp5xuMOrfFbfVtxQH9Fui6+on4Eq7KerAK6LqqbfTxL
         q5ZFJiy70rISvtoFJJ5otyJsqKXrmOt/Fj2jvUlYKk9FVwotKsYZ2kYbVkovKuETSBOz
         t/eh4ewUma7VQp0IeLp6Gfjq5jyiOtlZ8F+HNDjsGuzHahrbyFroBen49JsP2Pg7UIxo
         xazAUudygrfTume7Dmf2y1pz8wzDOKiFZ9GAR7rU/uES+HDYCT+DhFhFRSdPQ9wsZ58N
         9vCB9sG2dobpsWqHE+Ubz34/9OeXI+6B68ftR4KeTQWejPVuaP0O+lakXbYYcr9CK4Fo
         uKxQ==
X-Gm-Message-State: AOAM533DWBBgBEyuywhrdBAezp/ck7VbGvcrpOTW7P1oX4q/+x7t+/z+
        +4gEVuGzrLdqU3hkOYvTNzE=
X-Google-Smtp-Source: ABdhPJxy6krJqGPrSnqfBVlqn1YIxzjqgKBbLv+YKpT+HqIUp3bWk1AU72nWmqDbr4/nQM0tvOgqnA==
X-Received: by 2002:a17:90a:6848:: with SMTP id e8mr10600318pjm.224.1625834346480;
        Fri, 09 Jul 2021 05:39:06 -0700 (PDT)
Received: from localhost.localdomain ([152.57.176.46])
        by smtp.googlemail.com with ESMTPSA id j6sm5592402pji.23.2021.07.09.05.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 05:39:06 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v10 6/8] PCI: Setup ACPI fwnode early and at the same time with OF
Date:   Fri,  9 Jul 2021 18:08:11 +0530
Message-Id: <20210709123813.8700-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709123813.8700-1-ameynarkhede03@gmail.com>
References: <20210709123813.8700-1-ameynarkhede03@gmail.com>
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
index c272e23db..c911d6a5c 100644
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

