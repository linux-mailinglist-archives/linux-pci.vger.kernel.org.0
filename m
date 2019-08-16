Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C838FEF5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 11:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfHPJ01 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 05:26:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43212 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfHPJ00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 05:26:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8so890134wrn.10;
        Fri, 16 Aug 2019 02:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQFIDh4S3BKcxzlORjnStXsZ6DfUzI3N/hnvhmTuLs8=;
        b=CWw/YvrlegXOrjLsqedl6yU38/BWBbnuB0l9bleEwM1I1GMZ27VAvuUvuaORJNaMNH
         L+/qa+p7a8UcL3HAWlQXFP4qFEdp0RFdHcXYErBlEZKGoMWWakTVDQKNRiXl4x5atchO
         9lX+L/aQfJG9U8Q3cpePfF4czq2kKgQWmzLye9Gn7UVBZW0Vihdn2Y3GPHM+gcNWXjM9
         9wY0Ctayb1o1qP+a4w2onl580ixnlkl/g6f3bCSkfSi3MqxJ/rwXrvEj7CUIkr4t5XVb
         uOodklnuj6PrfDZurJYc6hM8oTt2/mRYf5P7RuKjvXcLzjZzKZcj9YLJqk7MohhpKBOl
         N6sA==
X-Gm-Message-State: APjAAAVmCHVBVAWplkvJKFq2deKdr4hAa9KjjpKGMnGy+77SuK0y8UMb
        WHmh73Ysy/AEYB1L1ivfHP16ziDIoJs=
X-Google-Smtp-Source: APXvYqwG11k4igHgrryrjPHyfeT7XXX08qys061YfZoc8Z1PSbAFAnEUv3PxRdRufCgDzgfe8AsPIg==
X-Received: by 2002:adf:f5c5:: with SMTP id k5mr10271991wrp.42.1565947584701;
        Fri, 16 Aug 2019 02:26:24 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id q20sm16521138wrc.79.2019.08.16.02.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 02:26:24 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH v2 10/10] PCI: Use PCI_STD_NUM_BARS
Date:   Fri, 16 Aug 2019 12:24:37 +0300
Message-Id: <20190816092437.31846-11-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816092437.31846-1-efremov@linux.com>
References: <20190816092437.31846-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the magic constant with define PCI_STD_NUM_BARS.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/pci.c    | 11 ++++++-----
 drivers/pci/quirks.c |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1b27b5af3d55..a9005c9eee6c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3768,7 +3768,7 @@ void pci_release_selected_regions(struct pci_dev *pdev, int bars)
 {
 	int i;
 
-	for (i = 0; i < 6; i++)
+	for (i = 0; i < PCI_STD_NUM_BARS; i++)
 		if (bars & (1 << i))
 			pci_release_region(pdev, i);
 }
@@ -3779,7 +3779,7 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
 {
 	int i;
 
-	for (i = 0; i < 6; i++)
+	for (i = 0; i < PCI_STD_NUM_BARS; i++)
 		if (bars & (1 << i))
 			if (__pci_request_region(pdev, i, res_name, excl))
 				goto err_out;
@@ -3827,7 +3827,7 @@ EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
 
 void pci_release_regions(struct pci_dev *pdev)
 {
-	pci_release_selected_regions(pdev, (1 << 6) - 1);
+	pci_release_selected_regions(pdev, (1 << PCI_STD_NUM_BARS) - 1);
 }
 EXPORT_SYMBOL(pci_release_regions);
 
@@ -3846,7 +3846,8 @@ EXPORT_SYMBOL(pci_release_regions);
  */
 int pci_request_regions(struct pci_dev *pdev, const char *res_name)
 {
-	return pci_request_selected_regions(pdev, ((1 << 6) - 1), res_name);
+	return pci_request_selected_regions(pdev,
+			((1 << PCI_STD_NUM_BARS) - 1), res_name);
 }
 EXPORT_SYMBOL(pci_request_regions);
 
@@ -3868,7 +3869,7 @@ EXPORT_SYMBOL(pci_request_regions);
 int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
 {
 	return pci_request_selected_regions_exclusive(pdev,
-					((1 << 6) - 1), res_name);
+				((1 << PCI_STD_NUM_BARS) - 1), res_name);
 }
 EXPORT_SYMBOL(pci_request_regions_exclusive);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 02bdf3a0231e..51caa61e6112 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1810,7 +1810,7 @@ static void quirk_alder_ioapic(struct pci_dev *pdev)
 	 * The next five BARs all seem to be rubbish, so just clean
 	 * them out.
 	 */
-	for (i = 1; i < 6; i++)
+	for (i = 1; i < PCI_STD_NUM_BARS; i++)
 		memset(&pdev->resource[i], 0, sizeof(pdev->resource[i]));
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic);
-- 
2.21.0

