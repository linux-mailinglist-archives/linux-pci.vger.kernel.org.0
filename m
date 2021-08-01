Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A013DCC0F
	for <lists+linux-pci@lfdr.de>; Sun,  1 Aug 2021 16:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhHAO0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Aug 2021 10:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhHAO0C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Aug 2021 10:26:02 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E9CC06175F;
        Sun,  1 Aug 2021 07:25:54 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e21so16679054pla.5;
        Sun, 01 Aug 2021 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r29+sUujdKPey6oLGLCs3NweFY8aTssXwj399PyY5uY=;
        b=KwlRG+sUCcX8tISzPUvUnSuLcdFgjtxRRc9KAz7NVxEPMznzePYn06nGw/FW3tzSCo
         +qRZiHYRrDGpTEO55JAGfHqNJxGTr4TlhBY/YqwNWi7dGKpmN0U3xcMTUYGsmk4UPWLy
         pOEhVpQrSsLxnAHZl23MZnYiRBB38bdecFFnmqFnvX1PEx72n0Q8rOI/wdOM0whAo1Ec
         l2shOqpbXCBe11X4ZeIgUiaVrIW3fq7Klm0RVCKUXD6kPiRt2cRib08eBWGE13KaQnVC
         X2pukE1pS2sTMmyhNc80Ik0G/ddLifoqm48JCv/KeQEx3llfuK40kOeKGI17kFm7vt0O
         zysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r29+sUujdKPey6oLGLCs3NweFY8aTssXwj399PyY5uY=;
        b=uW3//qZ+Wco149TcRKBTTxtgT4PhhHhyjVXEFGBEs80CMvjTlmdrnB26rQG7SdF8VP
         p0tgC8ZX/zvA+OBihobJqzhDgowdLw9ihvbIz5bzRqcuCTMNBHQJY1UIB4H+NN8LZMGc
         1wAdfBGYjW/u6eZR6B79FW3pzn6ZHpNH48i3woQSgsyJsnxvW9b43XcIkODC9tKHG+WB
         fEcffTg30VqQadWOhvt+XMfi1j82a2a57fH5SqyrxTBqHR0/y72wg5Zb7JbBVThETTRd
         dQ8O1kSPXJgd/fa3mYkej1RtUWSNY4ulZrQPjli6dobr/n3IJQsv4RApq1s1Z6/Zl/fj
         acEg==
X-Gm-Message-State: AOAM530frBPJMoWhp8/TNT5fxojGPSi78wHpzrdlK2GeCrdqrfzCs43o
        CRcdq4ayeIf7GznaFrmNfDA=
X-Google-Smtp-Source: ABdhPJxWiZKdMHwLonlmbEOke5g+8smroGoscvtd5jg/GCkc+v8nV8MQ+Jb7SsIxMQxGZgttJ4RZtA==
X-Received: by 2002:aa7:9828:0:b029:3bd:dc3d:de5f with SMTP id q8-20020aa798280000b02903bddc3dde5fmr348440pfl.47.1627827953642;
        Sun, 01 Aug 2021 07:25:53 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.186])
        by smtp.googlemail.com with ESMTPSA id g11sm7740897pju.13.2021.08.01.07.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 07:25:53 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v13 7/9] PCI: Setup ACPI fwnode early and at the same time with OF
Date:   Sun,  1 Aug 2021 19:55:16 +0530
Message-Id: <20210801142518.1224-8-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801142518.1224-1-ameynarkhede03@gmail.com>
References: <20210801142518.1224-1-ameynarkhede03@gmail.com>
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

