Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BF13E1982
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 18:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhHEQbG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 12:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbhHEQaS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Aug 2021 12:30:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA93C06179E;
        Thu,  5 Aug 2021 09:30:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so16181465pjs.0;
        Thu, 05 Aug 2021 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r29+sUujdKPey6oLGLCs3NweFY8aTssXwj399PyY5uY=;
        b=UmDlMlASDluPg4GT1xMtLmd7+XasBOU6W1/FMF/H/4Pjznf/mFLLchzWjtcIoFyEAa
         gm+t2WZSnNt5WqbRzelv+hgfkTDMZQ82HEmG1Wafv5Qu7rWWXfFCd+7cV5ujbInsNYS+
         qcDzVMDtQTP4ClbCwGr+PJ8FjWA4ZZjqW44SO2tYFYhQolzyNgSSntzV+Bf8ZtEfuINq
         +2Jy79VATtvwxDuaolVyknGP1EYz6u2tBd6NubK3A/yx7mXkVaW2V52uYL5Ia9AU76X5
         qfIrZitjn99tfuaT9gmmzqNpyIpREA7++bu+P2VQPhZLTe1vDY9/YE1HVqrWdGdoQ2sd
         5e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r29+sUujdKPey6oLGLCs3NweFY8aTssXwj399PyY5uY=;
        b=uG1SUGNeEBa4xp8mdqZk3euxcs7zFlV8ovInE5fztgG2J03AA9JdjUwHyt74n10MrA
         8TPxMBZoxB56UvamrcYWgiWN22gCXZpzNC3RWPhcWo/EkzOW1SmcYD0JeET2a87SzZ2w
         3aeNaNlxnpzkKsVZOpp1v+lQl2cz3vIA2Z3y9dkW85nvorJqragiPrHCXYHcGHh0CROm
         c/3HS/mMs4eJrOGZjrHha1bkHUC+4Ln03jFbdhDhetV5XdsbpMqkqBn8cVXLu0ol47em
         rXK82tQB8I3ThfNCaBH+VykaI7YLliZGpjIqZaN32DFTvzgWzrZusOy4pAlmGnDsWHRj
         p3gw==
X-Gm-Message-State: AOAM532t2jlc00OjyQZu1cWxwh6FLc7e4ur+D8plonszfv+KfeEM0ZZt
        PgVrAnTF8ABSvwwsJ2FSVKo=
X-Google-Smtp-Source: ABdhPJwPlXuHygx/9byU2NZWKAovPw3TJ66MQqvRW/XjQB4GvQkL72zfUC/1gbsHkGWNyAZIq/POlQ==
X-Received: by 2002:a62:1a4c:0:b029:3b8:3265:5f92 with SMTP id a73-20020a621a4c0000b02903b832655f92mr341944pfa.4.1628181002777;
        Thu, 05 Aug 2021 09:30:02 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.161])
        by smtp.googlemail.com with ESMTPSA id nr6sm62551pjb.39.2021.08.05.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 09:30:02 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v15 7/9] PCI: Setup ACPI fwnode early and at the same time with OF
Date:   Thu,  5 Aug 2021 21:59:15 +0530
Message-Id: <20210805162917.3989-8-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805162917.3989-1-ameynarkhede03@gmail.com>
References: <20210805162917.3989-1-ameynarkhede03@gmail.com>
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

