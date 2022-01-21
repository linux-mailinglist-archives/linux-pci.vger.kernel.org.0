Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096A0496062
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381018AbiAUOFJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:05:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51660 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381016AbiAUOFJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:05:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5A0361792
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 14:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168B7C340E1;
        Fri, 21 Jan 2022 14:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642773908;
        bh=HioImQrg33h3GwYnOxwxENQO0LgCnPbH9UzRK7c1SB8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jrc3oPz7FN+ft6qUdbPwuf7fvzHRkcXwZobSy9YqeCtEy9c2Z3vL7FgBFeO2Ad2SN
         KTUF5heR0LQq9SMDiVLkviiqM5+CGvqwgmiKVw+TqZeHEUqXVxsFukuVhifHV8vJX8
         FCeYS4q0+Y49PMgmJsc+cVM6coF7hyu2GFswYjPBL1YKNS51nKATjfPG8TyttKvhxO
         J8zi351AGfMPrMZ5q50nMzsVsXQoa5wumPMZmbGArN7FDxTCnxSxecnM1CD8LwoV5j
         lh8ezUldQ0A4X2IfysUUKZIpjYmPkTXEPaFH6D9yOXucbxRlH/K59ZLYk6l4PO/CaO
         0dlpwQ6Vp2jEw==
Received: by pali.im (Postfix)
        id C1FDA857; Fri, 21 Jan 2022 15:05:07 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 4/4] lspci: Replace find_driver() via libpci PCI_FILL_DRIVER
Date:   Fri, 21 Jan 2022 15:03:51 +0100
Message-Id: <20220121140351.27382-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121140351.27382-1-pali@kernel.org>
References: <20220121140351.27382-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

And implement this show_kernel() and show_kernel_machine() for all
platforms.
---
 ls-kernel.c | 56 +++++++++++++++--------------------------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/ls-kernel.c b/ls-kernel.c
index 2284b4625b12..3c484af7a9e0 100644
--- a/ls-kernel.c
+++ b/ls-kernel.c
@@ -212,40 +212,6 @@ show_kernel_cleanup(void)
 
 #endif
 
-#define DRIVER_BUF_SIZE 1024
-
-static char *
-find_driver(struct device *d, char *buf)
-{
-  struct pci_dev *dev = d->dev;
-  char name[1024], *drv, *base;
-  int n;
-
-  if (dev->access->method != PCI_ACCESS_SYS_BUS_PCI)
-    return NULL;
-
-  base = pci_get_param(dev->access, "sysfs.path");
-  if (!base || !base[0])
-    return NULL;
-
-  n = snprintf(name, sizeof(name), "%s/devices/%04x:%02x:%02x.%d/driver",
-	       base, dev->domain, dev->bus, dev->dev, dev->func);
-  if (n < 0 || n >= (int)sizeof(name))
-    die("show_driver: sysfs device name too long, why?");
-
-  n = readlink(name, buf, DRIVER_BUF_SIZE);
-  if (n < 0)
-    return NULL;
-  if (n >= DRIVER_BUF_SIZE)
-    return "<name-too-long>";
-  buf[n] = 0;
-
-  if (drv = strrchr(buf, '/'))
-    return drv+1;
-  else
-    return buf;
-}
-
 static const char *
 next_module_filtered(struct device *d)
 {
@@ -268,10 +234,10 @@ next_module_filtered(struct device *d)
 void
 show_kernel(struct device *d)
 {
-  char buf[DRIVER_BUF_SIZE];
   const char *driver, *module;
 
-  if (driver = find_driver(d, buf))
+  pci_fill_info(d->dev, PCI_FILL_DRIVER);
+  if (driver = pci_get_string_property(d->dev, PCI_FILL_DRIVER))
     printf("\tKernel driver in use: %s\n", driver);
 
   if (!show_kernel_init())
@@ -287,10 +253,10 @@ show_kernel(struct device *d)
 void
 show_kernel_machine(struct device *d)
 {
-  char buf[DRIVER_BUF_SIZE];
   const char *driver, *module;
 
-  if (driver = find_driver(d, buf))
+  pci_fill_info(d->dev, PCI_FILL_DRIVER);
+  if (driver = pci_get_string_property(d->dev, PCI_FILL_DRIVER))
     printf("Driver:\t%s\n", driver);
 
   if (!show_kernel_init())
@@ -303,13 +269,23 @@ show_kernel_machine(struct device *d)
 #else
 
 void
-show_kernel(struct device *d UNUSED)
+show_kernel(struct device *d)
 {
+  const char *driver;
+
+  pci_fill_info(d->dev, PCI_FILL_DRIVER);
+  if (driver = pci_get_string_property(d->dev, PCI_FILL_DRIVER))
+    printf("\tDriver in use: %s\n", driver);
 }
 
 void
-show_kernel_machine(struct device *d UNUSED)
+show_kernel_machine(struct device *d)
 {
+  const char *driver;
+
+  pci_fill_info(d->dev, PCI_FILL_DRIVER);
+  if (driver = pci_get_string_property(d->dev, PCI_FILL_DRIVER))
+    printf("Driver:\t%s\n", driver);
 }
 
 void
-- 
2.20.1

