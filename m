Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE74B421B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403849AbfIPUoJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:44:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40274 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403842AbfIPUoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:44:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so687375wmj.5;
        Mon, 16 Sep 2019 13:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35Le1CuHRQyVF/cByw2yYN48BkYqEm/VqIIyyf0DRl4=;
        b=B+dLal9Z/qIruAwH40UbKUUu/gDCp6z1+Rf9r090hUkENBdmWM4X7k7YF+zSF6m6aB
         OTugm8Va8BEVKYT3VqWJlzFaKx2qX0qomJGQPBXo3/VHb3ABnx5N45KRpuY7LHgGUa4A
         +kTX2l2Ptvi9MEk8X/iA9iJy53cvHuIX9e05zO9Z3tjyI97nyDJjVHYtv6l6iPueB5zC
         pKH5cjeDbrp2fdaXm1a/1AI8JwFYbtFQOBpEa2CYtR6JVKM5RLJuORUOs/GorSf3N1FB
         iyWFyLEG43fJbvLpMgmgAUbhlC/aMJxXLo3SEKKdGUT7FvtOzWJKb7i0ewFtDBw1VbFV
         Nyig==
X-Gm-Message-State: APjAAAVk6b8j0epPVcy0BnJQ0wkjxmxX19zxdj4LNIAJlDDlSVuYHty6
        VYvq8N3A/0q3cyj4cxHEMdE=
X-Google-Smtp-Source: APXvYqzq7sPF6D7wniXMauABS31yabJspsf0fMDPngm0w8h5Zpukx77o0z1P8ruvWjMvSdZv8jFfCQ==
X-Received: by 2002:a1c:f917:: with SMTP id x23mr687011wmh.101.1568666646746;
        Mon, 16 Sep 2019 13:44:06 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:44:06 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 04/26] PCI: endpoint: Use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:36 +0300
Message-Id: <20190916204158.6889-5-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To iterate through all possible BARs, loop conditions refactored to the
*number* of BARs "i < PCI_STD_NUM_BARS", instead of the index of the last
valid BAR "i <= BAR_5". This is more idiomatic C style and allows to avoid
the fencepost error. Array definitions changed to PCI_STD_NUM_BARS where
appropriate.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 10 +++++-----
 include/linux/pci-epc.h                       |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 1cfe3687a211..5d74f81ddfe4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -44,7 +44,7 @@
 static struct workqueue_struct *kpcitest_workqueue;
 
 struct pci_epf_test {
-	void			*reg[6];
+	void			*reg[PCI_STD_NUM_BARS];
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
 	struct delayed_work	cmd_handler;
@@ -377,7 +377,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 
 	cancel_delayed_work(&epf_test->cmd_handler);
 	pci_epc_stop(epc);
-	for (bar = BAR_0; bar <= BAR_5; bar++) {
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		epf_bar = &epf->bar[bar];
 
 		if (epf_test->reg[bar]) {
@@ -400,7 +400,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 
 	epc_features = epf_test->epc_features;
 
-	for (bar = BAR_0; bar <= BAR_5; bar += add) {
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
 		epf_bar = &epf->bar[bar];
 		/*
 		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
@@ -450,7 +450,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	}
 	epf_test->reg[test_reg_bar] = base;
 
-	for (bar = BAR_0; bar <= BAR_5; bar += add) {
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
 		epf_bar = &epf->bar[bar];
 		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
 
@@ -478,7 +478,7 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
 	bool bar_fixed_64bit;
 	int i;
 
-	for (i = BAR_0; i <= BAR_5; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		epf_bar = &epf->bar[i];
 		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
 		if (bar_fixed_64bit)
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f641badc2c61..56f1846b9d39 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -117,7 +117,7 @@ struct pci_epc_features {
 	unsigned int	msix_capable : 1;
 	u8	reserved_bar;
 	u8	bar_fixed_64bit;
-	u64	bar_fixed_size[BAR_5 + 1];
+	u64	bar_fixed_size[PCI_STD_NUM_BARS];
 	size_t	align;
 };
 
-- 
2.21.0

