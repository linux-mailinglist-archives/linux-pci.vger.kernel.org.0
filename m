Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D592629FA2
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 22:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403868AbfEXUQS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 16:16:18 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33764 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403762AbfEXUQS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 16:16:18 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hUGbu-00032T-HJ; Fri, 24 May 2019 14:16:17 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hUGbu-00026Y-Ct; Fri, 24 May 2019 14:16:14 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 24 May 2019 14:16:10 -0600
Message-Id: <20190524201610.8039-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524201610.8039-1-logang@deltatee.com>
References: <20190524201610.8039-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 3/3] PCI: Force trailing new line to resource_alignment_param in sysfs
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When 'pci=resource_alignment=' is specified on the command line, there
is no trailing new line.  Then, when it's read through the corresponding
sysfs attribute, there will be no newline and a cat command will not
show correctly in a shell. If the parameter is set through sysfs
a new line will be stored and it will 'cat' correctly.

To solve this, append a new line character in the show function if
one does not already exist.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3e71e161f18b..99d130ac6b96 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6090,6 +6090,16 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
 		count = snprintf(buf, PAGE_SIZE, "%s", resource_alignment_param);
 	spin_unlock(&resource_alignment_lock);
 
+	/*
+	 * When set by the command line, resource_alignment_param will not
+	 * have a trailing line feed, which is ugly. So conditionally add
+	 * it here.
+	 */
+	if (count >= 2 && buf[count - 2] != '\n' && count < PAGE_SIZE - 1) {
+		buf[count - 1] = '\n';
+		buf[count++] = 0;
+	}
+
 	return count;
 }
 
-- 
2.20.1

