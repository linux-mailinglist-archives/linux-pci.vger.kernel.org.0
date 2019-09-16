Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2AAB421D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403863AbfIPUoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:44:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38762 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403842AbfIPUoN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:44:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so698692wme.3;
        Mon, 16 Sep 2019 13:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VQgdi9RT91f00lILEI11lVCIdYnGLkjukNZtLishIZk=;
        b=RDN9MmJw1VqMnj4kwfg57e/T64vOGq6XRngILGbD35TWUowyfMccbb2Z24YDOyrG3F
         SL6eibZFnXlMJ6WHzG6q8GnCBfywda7bvQhqWAv/Yudu8FUU/8FBNcHr6Rmc0L5BWmnu
         Y6YeCMDeEpg8vhJXtdlFNT6r23YfvUMYRaUJPLyo+zUVwWmHUIX+S5H0Sd1IxBXnWT17
         /SFBPiNaocSSyu5GhvouT2vX6MOplQsMEZ6OEJ4J86qiRdW68SbKc0LorubBSJVwT90n
         aMvb6j8dHAKKSDxkEwdhSgClraVXi/ouHruNUGns196nMKU/ssv5RMeRfAKzmTkiXomI
         MytQ==
X-Gm-Message-State: APjAAAVTQqpvs1/XXQeLCLIUCMeRWKnmGDlaEf/mvuySCtQ94cCc3LeN
        76AMA0DmTxfxJL0uEZaBsNI=
X-Google-Smtp-Source: APXvYqwSCKf2jDSGvpyiWIOrkHIQoWSHUpohLQAA2EOc95iW0E/vOzyutjgC3S4E89sCHpvuJ/Xaeg==
X-Received: by 2002:a1c:a942:: with SMTP id s63mr665037wme.152.1568666649828;
        Mon, 16 Sep 2019 13:44:09 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:44:09 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 05/26] misc: pci_endpoint_test: Use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:37 +0300
Message-Id: <20190916204158.6889-6-efremov@linux.com>
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
 drivers/misc/pci_endpoint_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 6e208a060a58..a5e317073d95 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -94,7 +94,7 @@ enum pci_barno {
 struct pci_endpoint_test {
 	struct pci_dev	*pdev;
 	void __iomem	*base;
-	void __iomem	*bar[6];
+	void __iomem	*bar[PCI_STD_NUM_BARS];
 	struct completion irq_raised;
 	int		last_irq;
 	int		num_irqs;
@@ -687,7 +687,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	if (!pci_endpoint_test_request_irq(test))
 		goto err_disable_irq;
 
-	for (bar = BAR_0; bar <= BAR_5; bar++) {
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
 			base = pci_ioremap_bar(pdev, bar);
 			if (!base) {
@@ -740,7 +740,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	ida_simple_remove(&pci_endpoint_test_ida, id);
 
 err_iounmap:
-	for (bar = BAR_0; bar <= BAR_5; bar++) {
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (test->bar[bar])
 			pci_iounmap(pdev, test->bar[bar]);
 	}
@@ -771,7 +771,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
 	ida_simple_remove(&pci_endpoint_test_ida, id);
-	for (bar = BAR_0; bar <= BAR_5; bar++) {
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (test->bar[bar])
 			pci_iounmap(pdev, test->bar[bar]);
 	}
-- 
2.21.0

