Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A51BB425D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391620AbfIPUrh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:47:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33425 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfIPUrh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:47:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so872777wme.0;
        Mon, 16 Sep 2019 13:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hIaCxdmc4Mv8gjZ6OZgOWrffbO/JWGkLQPEVsPVt/ms=;
        b=FIpGy+/wT7Ofs4xwqI15sZ4utyBbsg7vrYiNZf4X/kJEKrhhHZ80A3VnEuLzUHiwcR
         r8VhIxMpU0cq8kMDNkqQh9q2vaZb5r7Is0SOWw7/PCgp03ztTzWlg9MQNcH1uZLP2IqA
         CJCWKDe4raZN1E1IjuBFM2MXUVmq0va3nR0FjTSepUKh+l/g3kIOusllXCGCOnPMerjs
         D8CUW05kY3v5m/taqkpgNrtGPyTmavIp/gueEaFuR3qNm8ymzh5pUzGLdIjLl3B2Mo2j
         SNG0oVfQgFK6Rm8crEzmPLMQ5eF2Uzcankv4nAWG1pRz9k/fepvigOvsuf+tlWQw6SLz
         3Esg==
X-Gm-Message-State: APjAAAWQL3SlgrGiyKRWddHEoIL8MlV0bA8E9qHn0CrrbWCn2yay7qbk
        Nb/PPXr34p+E4l+TChZU2PU=
X-Google-Smtp-Source: APXvYqxV54TN6lC5/Jcuj+mDUpfWm3xDMt+2fNrtKXU0IdKBO73RRVso0NF9z88qEsbkVDCd7KhnGw==
X-Received: by 2002:a7b:cc0a:: with SMTP id f10mr778750wmh.6.1568666855820;
        Mon, 16 Sep 2019 13:47:35 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:47:35 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        devel@driverdev.osuosl.org, Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>
Subject: [PATCH v3 20/26] staging: gasket: Use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:52 +0300
Message-Id: <20190916204158.6889-21-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove local definition GASKET_NUM_BARS for the number of PCI BARs and use
global one PCI_STD_NUM_BARS instead.

Cc: Rob Springer <rspringer@google.com>
Cc: Todd Poynor <toddpoynor@google.com>
Cc: Ben Chan <benchan@chromium.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/staging/gasket/gasket_constants.h |  3 ---
 drivers/staging/gasket/gasket_core.c      | 12 ++++++------
 drivers/staging/gasket/gasket_core.h      |  4 ++--
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/gasket/gasket_constants.h b/drivers/staging/gasket/gasket_constants.h
index 50d87c7b178c..9ea9c8833f27 100644
--- a/drivers/staging/gasket/gasket_constants.h
+++ b/drivers/staging/gasket/gasket_constants.h
@@ -13,9 +13,6 @@
 /* The maximum devices per each type. */
 #define GASKET_DEV_MAX 256
 
-/* The number of supported (and possible) PCI BARs. */
-#define GASKET_NUM_BARS 6
-
 /* The number of supported Gasket page tables per device. */
 #define GASKET_MAX_NUM_PAGE_TABLES 1
 
diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 13179f063a61..cd8be80d2076 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -371,7 +371,7 @@ static int gasket_setup_pci(struct pci_dev *pci_dev,
 {
 	int i, mapped_bars, ret;
 
-	for (i = 0; i < GASKET_NUM_BARS; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		ret = gasket_map_pci_bar(gasket_dev, i);
 		if (ret) {
 			mapped_bars = i;
@@ -393,7 +393,7 @@ static void gasket_cleanup_pci(struct gasket_dev *gasket_dev)
 {
 	int i;
 
-	for (i = 0; i < GASKET_NUM_BARS; i++)
+	for (i = 0; i < PCI_STD_NUM_BARS; i++)
 		gasket_unmap_pci_bar(gasket_dev, i);
 }
 
@@ -493,7 +493,7 @@ static ssize_t gasket_sysfs_data_show(struct device *device,
 		(enum gasket_sysfs_attribute_type)gasket_attr->data.attr_type;
 	switch (sysfs_type) {
 	case ATTR_BAR_OFFSETS:
-		for (i = 0; i < GASKET_NUM_BARS; i++) {
+		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 			bar_desc = &driver_desc->bar_descriptions[i];
 			if (bar_desc->size == 0)
 				continue;
@@ -505,7 +505,7 @@ static ssize_t gasket_sysfs_data_show(struct device *device,
 		}
 		break;
 	case ATTR_BAR_SIZES:
-		for (i = 0; i < GASKET_NUM_BARS; i++) {
+		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 			bar_desc = &driver_desc->bar_descriptions[i];
 			if (bar_desc->size == 0)
 				continue;
@@ -556,7 +556,7 @@ static ssize_t gasket_sysfs_data_show(struct device *device,
 		ret = snprintf(buf, PAGE_SIZE, "%d\n", gasket_dev->reset_count);
 		break;
 	case ATTR_USER_MEM_RANGES:
-		for (i = 0; i < GASKET_NUM_BARS; ++i) {
+		for (i = 0; i < PCI_STD_NUM_BARS; ++i) {
 			current_written =
 				gasket_write_mappable_regions(buf, driver_desc,
 							      i);
@@ -736,7 +736,7 @@ static int gasket_get_bar_index(const struct gasket_dev *gasket_dev,
 	const struct gasket_driver_desc *driver_desc;
 
 	driver_desc = gasket_dev->internal_desc->driver_desc;
-	for (i = 0; i < GASKET_NUM_BARS; ++i) {
+	for (i = 0; i < PCI_STD_NUM_BARS; ++i) {
 		struct gasket_bar_desc bar_desc =
 			driver_desc->bar_descriptions[i];
 
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index be44ac1e3118..c417acadb0d5 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -268,7 +268,7 @@ struct gasket_dev {
 	char kobj_name[GASKET_NAME_MAX];
 
 	/* Virtual address of mapped BAR memory range. */
-	struct gasket_bar_data bar_data[GASKET_NUM_BARS];
+	struct gasket_bar_data bar_data[PCI_STD_NUM_BARS];
 
 	/* Coherent buffer. */
 	struct gasket_coherent_buffer coherent_buffer;
@@ -369,7 +369,7 @@ struct gasket_driver_desc {
 	/* Set of 6 bar descriptions that describe all PCIe bars.
 	 * Note that BUS/AXI devices (i.e. non PCI devices) use those.
 	 */
-	struct gasket_bar_desc bar_descriptions[GASKET_NUM_BARS];
+	struct gasket_bar_desc bar_descriptions[PCI_STD_NUM_BARS];
 
 	/*
 	 * Coherent buffer description.
-- 
2.21.0

