Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A813C6E5E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 12:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhGMK1a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 06:27:30 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40880 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhGMK1a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 06:27:30 -0400
Received: by mail-wm1-f52.google.com with SMTP id h18-20020a05600c3512b029020e4ceb9588so1230548wmq.5
        for <linux-pci@vger.kernel.org>; Tue, 13 Jul 2021 03:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M6EALgS37OQWvu8bXWN8/n6HJahdTZizhntFgVrPkfs=;
        b=ImxbbldBlIQRitbI/RTPUkxwLCmuiSsBithwESXlhACKgpePryZrl5sSu3/k7Nimt+
         cA/Tj3pIr9tOpKohtJKn2mGqwrmKQ1FoKQXIhmXbfyxGwxbblzkG7+f1yyapkRlfLAjZ
         TS1FC5Gwwyt6v0Gr1vKmKZYCO0n+ZwGONzKO+ANM9OUbwf5F4sALH5GaEi9kPNhbp7l+
         qlprHSmYNOBa+yAP2E/4Ox20PUwrlZ3jEg9f0b236UqvsOyaDRwS86MlrGd4Xoipcf5e
         bzn/2U7lUFGZ8mkwiddrxCUtuvr+mtoMUCRbKOp6RuJPzAQkylyo4jzkZBXz9ZnZl6Bh
         2mKA==
X-Gm-Message-State: AOAM531R1GLCzHOPgN5FuBbqzKln/WI8SymaEhMHfsYgTs9cYwKbZIWS
        7dnSoKIeUh4dTvfNnaeD0Bw=
X-Google-Smtp-Source: ABdhPJwMkCYbwjlCFs4c9HRQHl1h+NEeec1NL6AJxd9u+VqwvmNVlRjvAv3u84hFVAXlq2PK7qI1cw==
X-Received: by 2002:a7b:cc15:: with SMTP id f21mr19814233wmh.5.1626171878810;
        Tue, 13 Jul 2021 03:24:38 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id h13sm17104423wrs.68.2021.07.13.03.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 03:24:38 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Refactor pci_ioremap_bar() and pci_ioremap_wc_bar()
Date:   Tue, 13 Jul 2021 10:24:36 +0000
Message-Id: <20210713102436.304693-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, functions pci_ioremap_bar() and pci_ioremap_wc_bar() share
similar implementation details as both functions were almost identical
in the past, especially when the latter was initially introduced in the
commit c43996f4001d ("PCI: Add pci_ioremap_wc_bar()") as somewhat exact
copy of the function pci_ioremap_bar().

However, function pci_ioremap_bar() received several updates that were
never introduced to the function pci_ioremap_wc_bar().

Thus, to align implementation of both functions and reduce the need to
duplicate code between them, introduce a new internal function called
__pci_ioremap_resource() as a helper with a shared codebase intended to
be called from functions pci_ioremap_bar() and pci_ioremap_wc_bar().

The  __pci_ioremap_resource() function will therefore include a check
for the IORESOURCE_UNSET flag that has previously been added to the
function pci_ioremap_bar() in the commit 646c0282df04 ("PCI: Fail
pci_ioremap_bar() on unassigned resources") and otherwise has been
missing from function pci_ioremap_wc_bar().

Additionally, function __pci_ioremap_resource() will retire the usage of
the WARN_ON() macro and replace it with pci_err() to show information
such as the driver name, the BAR number and resource details in case of
a failure, instead of printing a complete backtrace. The WARN_ON() has
already been replaced with pci_warn() in the commit 1f7bf3bfb5d6 ("PCI:
Show driver, BAR#, and resource on pci_ioremap_bar() failure") which
sadly didn't include an update to the function pci_ioremap_wc_bar() at
that time.

Finally, a direct use of functions ioremap() and ioremap_wc() in the
function __pci_ioremap_resource() will be replaced with calls to the
pci_iomap_range() and pci_iomap_wc_range() functions respectively.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e3bb0d073352..4bae55f0700b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -206,7 +206,8 @@ int pci_status_get_and_clear_errors(struct pci_dev *pdev)
 EXPORT_SYMBOL_GPL(pci_status_get_and_clear_errors);
 
 #ifdef CONFIG_HAS_IOMEM
-void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
+static void __iomem *__pci_ioremap_resource(struct pci_dev *pdev, int bar,
+					    bool write_combine)
 {
 	struct resource *res = &pdev->resource[bar];
 
@@ -214,24 +215,25 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
 	 * Make sure the BAR is actually a memory resource, not an IO resource
 	 */
 	if (res->flags & IORESOURCE_UNSET || !(res->flags & IORESOURCE_MEM)) {
-		pci_warn(pdev, "can't ioremap BAR %d: %pR\n", bar, res);
+		pci_err(pdev, "can't ioremap BAR %d: %pR\n", bar, res);
 		return NULL;
 	}
-	return ioremap(res->start, resource_size(res));
+
+	if (write_combine)
+		return pci_iomap_wc_range(pdev, bar, 0, 0);
+
+	return pci_iomap_range(pdev, bar, 0, 0);
+}
+
+void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
+{
+	return __pci_ioremap_resource(pdev, bar, false);
 }
 EXPORT_SYMBOL_GPL(pci_ioremap_bar);
 
 void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar)
 {
-	/*
-	 * Make sure the BAR is actually a memory resource, not an IO resource
-	 */
-	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
-		WARN_ON(1);
-		return NULL;
-	}
-	return ioremap_wc(pci_resource_start(pdev, bar),
-			  pci_resource_len(pdev, bar));
+	return __pci_ioremap_resource(pdev, bar, true);
 }
 EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
 #endif
-- 
2.32.0

