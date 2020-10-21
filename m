Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C1B29542E
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 23:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506115AbgJUV2U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 17:28:20 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56258 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2506102AbgJUV2U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2020 17:28:20 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D79AF401D8;
        Wed, 21 Oct 2020 21:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603315699; bh=JYFScV9SdffGkhcxF4oYe3j7zFfnehqnn1E3sxkj/H8=;
        h=From:To:Cc:Subject:Date:From;
        b=YEObjLZ+AaCLU20P12YEg/TX12EpGr+X2/+wrMAnJqeAsZj4DC6o5msbiGLX3hWi5
         Z7WIaxJDf4ueqqDCdcp/J8PlY93lcfH7HCzrh2O60vNtG+ohxn1k/sAeMIqgJ5q2I1
         3XQbN8q0zBY2XYEQsRpXIFvyqM6Nj2vpWi6tCmE9PgikWZRuUj5cpcT7cO+ODeyWCK
         XRZZVyFRaKsjGB2obxDvUMVKOp3HrONqEooDMOgZ0TjCDJ1HynExZjU9pet0j8pv2Z
         0v+LvQbRlFy6Y9caTXpPi2MTstkBWq28kSLnIftPj0maXGE+uKKnhWr3lt5M6YSV2l
         B5xXxjC85WJ9A==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3B0AEA01F1;
        Wed, 21 Oct 2020 21:28:16 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: pci_endpoint_test: Remove unnecessary verification
Date:   Wed, 21 Oct 2020 23:28:10 +0200
Message-Id: <142cbbc215bed4243a219ea17b46f4256ceccb22.1603315690.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The first condition of the if statement can never be true, because
bar variable is an enum variable type defined between 0 and 5, and
also bar variable acquires the value from arg function parameter which
is an unsigned long variable.

The constant 5 was replaced the the equivalent enum type, in this case
BAR_5.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/pci_endpoint_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index e060796..b86f9f7 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -704,7 +704,7 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case PCITEST_BAR:
 		bar = arg;
-		if (bar < 0 || bar > 5)
+		if (bar > BAR_5)
 			goto ret;
 		if (is_am654_pci_dev(pdev) && bar == BAR_0)
 			goto ret;
-- 
2.7.4

