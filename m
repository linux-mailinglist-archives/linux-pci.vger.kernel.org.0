Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A88B4223
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403919AbfIPUoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:44:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40294 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403842AbfIPUoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:44:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so687714wmj.5;
        Mon, 16 Sep 2019 13:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3sxSYLfbzulAgVeJ0Is1a2sfy/t0mpOhwffZAY40o0o=;
        b=eMKsVjJD86TT6IgqxLR6Yov40d+L5VLH7t4imYpR9nBnjVcAQE2fkID+DgR8n3eBn+
         MT38tbOMS/7cXklWDqdBiVhqoWD17SWvXrDOVGlq4bznqNJJb5XeK8Eh46i2EEZIDsVG
         Rdo6+c/x56Gh5+TrvKWWlsFpoojiMn1b6Bxirymmw4SDW6Do3RliAJT7zyMgtQaAidja
         A3XM/KS2W1PLMrHTa76m8kRcVkocYrlK/TL+PFi2sTOTeej19VxM0HCuhrjl3A5eW4VX
         NnTXCUga7Jb93c/57Pp8YAd08yNWD/EZCDC6iYTycTnufCDZnAz1ToBPhmsZOnHZLtMC
         fCPQ==
X-Gm-Message-State: APjAAAVq9h2QeiwQ3w82lSqQ5XYy8zjMLkjNEo9fK26AniC5A3MYC6Q/
        qxZXHLgTZf5+rGvqx6mS/6w=
X-Google-Smtp-Source: APXvYqz89ScpfpAp1SlFgiH/W3BfTQfscU2KeuZpz2OZGSFYe/PLKrNhNHnVVFUEs4equmEex79WOw==
X-Received: by 2002:a1c:dd0a:: with SMTP id u10mr667819wmg.100.1568666656316;
        Mon, 16 Sep 2019 13:44:16 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:44:15 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 08/26] alpha/PCI: Use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:40 +0300
Message-Id: <20190916204158.6889-9-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use define PCI_STD_NUM_BARS instead of PCI_ROM_RESOURCE for the number of
PCI BARs.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/alpha/kernel/pci-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index f94c732fedeb..0021580d79ad 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -71,10 +71,10 @@ static int pci_mmap_resource(struct kobject *kobj,
 	struct pci_bus_region bar;
 	int i;
 
-	for (i = 0; i < PCI_ROM_RESOURCE; i++)
+	for (i = 0; i < PCI_STD_NUM_BARS; i++)
 		if (res == &pdev->resource[i])
 			break;
-	if (i >= PCI_ROM_RESOURCE)
+	if (i >= PCI_STD_NUM_BARS)
 		return -ENODEV;
 
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
@@ -115,7 +115,7 @@ void pci_remove_resource_files(struct pci_dev *pdev)
 {
 	int i;
 
-	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		struct bin_attribute *res_attr;
 
 		res_attr = pdev->res_attr[i];
@@ -232,7 +232,7 @@ int pci_create_resource_files(struct pci_dev *pdev)
 	int retval;
 
 	/* Expose the PCI resources from this device as files */
-	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 
 		/* skip empty resources */
 		if (!pci_resource_len(pdev, i))
-- 
2.21.0

