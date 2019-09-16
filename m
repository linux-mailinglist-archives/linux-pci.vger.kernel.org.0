Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB8FB4221
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403903AbfIPUoS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:44:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53883 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403881AbfIPUoQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:44:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so779220wmd.3;
        Mon, 16 Sep 2019 13:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2nJMFsxH3rGbm7OGTrOSwfsrpZrcICAXeTBwaXsuQJg=;
        b=eEPWJs0iftYMP7xXi7ZhppBM5NR4xHurpptq6dJKYfzB9XzmxU6NgaQ2xnjI2hfDPF
         tv7HpLC7JNqdGQ/yxYG+h2sNPIZTH52j8bNi7+ZAVB+7FQG0ht8vHO60L3ItQekbqUXM
         0R5nRkfVFuqShfbWD27PVBed95Fa+dXtaTIT6mbmM5SbgKNuq3r7MCKk0NPEFthyvJQN
         pLB3CtaSEi/fFkf0AsApZTBk0IzA3deqyY+xPh8pr7LAgI+BWI1rFN1rYlKLBdi/AVt3
         c4LH0YgME0hY8i0/VdWYdeU1HS1eM0zF//ylthgJENX2OfFs/flXYdrJP3hTMrEeJjdu
         UD3w==
X-Gm-Message-State: APjAAAX6/Rj8WfQrafPEL2WLVT8nRfrdBh7cN7ipaCx4s9CWZsfR1ix6
        48Orh5eqFPJBoZC0jyCZ5z7Wsp+NFS0=
X-Google-Smtp-Source: APXvYqyJ3ewqCnuMqQSgNrhQ5ujo5Ot5mz2frJOPfWzvyP7uB9VEJUyuLp7vwR5tDGXsa+ET0xbVIg==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr683892wmd.58.1568666654249;
        Mon, 16 Sep 2019 13:44:14 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:44:13 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 07/26] x86/PCI: Loop using PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:39 +0300
Message-Id: <20190916204158.6889-8-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refactor loops to use idiomatic C style and avoid the fencepost error
of using "i < PCI_STD_RESOURCE_END" when "i <= PCI_STD_RESOURCE_END"
is required, e.g., commit 2f686f1d9bee ("PCI: Correct PCI_STD_RESOURCE_END
usage").

To iterate through all possible BARs, loop conditions changed to the
*number* of BARs "i < PCI_STD_NUM_BARS", instead of the index of the last
valid BAR "i <= PCI_STD_RESOURCE_END" or PCI_ROM_RESOURCE.

Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/x86/pci/common.c        | 2 +-
 arch/x86/pci/intel_mid_pci.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 9acab6ac28f5..1e59df041456 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -135,7 +135,7 @@ static void pcibios_fixup_device_resources(struct pci_dev *dev)
 		* resource so the kernel doesn't attempt to assign
 		* it later on in pci_assign_unassigned_resources
 		*/
-		for (bar = 0; bar <= PCI_STD_RESOURCE_END; bar++) {
+		for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 			bar_r = &dev->resource[bar];
 			if (bar_r->start == 0 && bar_r->end != 0) {
 				bar_r->flags = 0;
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 43867bc85368..00c62115f39c 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -382,7 +382,7 @@ static void pci_fixed_bar_fixup(struct pci_dev *dev)
 	    PCI_DEVFN(2, 2) == dev->devfn)
 		return;
 
-	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		pci_read_config_dword(dev, offset + 8 + (i * 4), &size);
 		dev->resource[i].end = dev->resource[i].start + size - 1;
 		dev->resource[i].flags |= IORESOURCE_PCI_FIXED;
-- 
2.21.0

