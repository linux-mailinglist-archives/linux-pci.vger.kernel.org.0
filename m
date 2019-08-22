Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E33998DE
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 18:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389805AbfHVQKR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 12:10:17 -0400
Received: from ale.deltatee.com ([207.54.116.67]:47828 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730354AbfHVQKQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 12:10:16 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i0pfC-00079G-H0; Thu, 22 Aug 2019 10:10:16 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i0pfC-0001RG-CY; Thu, 22 Aug 2019 10:10:14 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 22 Aug 2019 10:10:12 -0600
Message-Id: <20190822161013.5481-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822161013.5481-1-logang@deltatee.com>
References: <20190822161013.5481-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH v2 2/3] PCI: Move pci_[get|set]_resource_alignment_param() into their callers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both the functions pci_get_resource_alignment_param() and
pci_set_resource_alignment_param() are now only called in one place:
resource_alignment_show() and resource_alignment_store() respectively.

There is no value in this extra set of functions so we move both into
their callers respectively.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 489fff757833..5e00371149b1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6108,39 +6108,29 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	}
 }
 
-static ssize_t pci_set_resource_alignment_param(const char *buf, size_t count)
-{
-	spin_lock(&resource_alignment_lock);
-
-	kfree(resource_alignment_param);
-	resource_alignment_param = kstrndup(buf, count, GFP_KERNEL);
-
-	spin_unlock(&resource_alignment_lock);
-
-	return resource_alignment_param ? count : -ENOMEM;
-}
-
-static ssize_t pci_get_resource_alignment_param(char *buf, size_t size)
+static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
 {
 	size_t count = 0;
 
 	spin_lock(&resource_alignment_lock);
 	if (resource_alignment_param)
-		count = snprintf(buf, size, "%s", resource_alignment_param);
+		count = snprintf(buf, PAGE_SIZE, "%s", resource_alignment_param);
 	spin_unlock(&resource_alignment_lock);
 
 	return count;
 }
 
-static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
-{
-	return pci_get_resource_alignment_param(buf, PAGE_SIZE);
-}
-
 static ssize_t resource_alignment_store(struct bus_type *bus,
 					const char *buf, size_t count)
 {
-	return pci_set_resource_alignment_param(buf, count);
+	spin_lock(&resource_alignment_lock);
+
+	kfree(resource_alignment_param);
+	resource_alignment_param = kstrndup(buf, count, GFP_KERNEL);
+
+	spin_unlock(&resource_alignment_lock);
+
+	return resource_alignment_param ? count : -ENOMEM;
 }
 
 static BUS_ATTR_RW(resource_alignment);
-- 
2.20.1

