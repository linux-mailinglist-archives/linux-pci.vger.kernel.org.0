Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FC926E778
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 23:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgIQVhR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 17:37:17 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59360 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbgIQVhR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2020 17:37:17 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 17:37:17 EDT
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 97499C03B4;
        Thu, 17 Sep 2020 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1600378231; bh=DwSOOa3p0zCFi9AGtBpYBd7JOmOEe8SKRvLy85WZCy8=;
        h=From:To:Cc:Subject:Date:From;
        b=HPum3U/noFtdp3lTm8foL1P/aC0uVhlQQi3VgsJnDAeV1+gz17mJNB3DWslZtNEs8
         /nhM+5fIxoI9MnIj4hqEX8xralEgiiZ0YooqB1ZNOkbJ9QPLPBX8uC5ooFpa4vShrS
         GljN3MCcQk6fGA02SsZknCamf5QyXJdOYeKpH/pTAn3WZCMulc7mwycTiMeVfy0sbP
         lwF8rBEvW5pAMXIXqIaKJQzuaaM0eWqOTcWshsniweRoj5hKOHAIn2i4F3MYqLMghJ
         CvLqN2ZpuaI7bnpXj5AoCC171WM4DHhjni8jRYfVgoKzmRXjDW7bXHRMSBHHBucUs8
         QtyCWbp5uwosw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id E9F02A005D;
        Thu, 17 Sep 2020 21:30:29 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] [-next] PCI: endpoint: Using plain integer as NULL pointer
Date:   Thu, 17 Sep 2020 23:30:27 +0200
Message-Id: <80895f7465719edb3aa259e907acc4bc3217945c.1600378209.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes warning given by executing "make C=2 drivers/pci/"

Sparse output:
CHECK   drivers/pci/endpoint/pci-epc-core.c
 drivers/pci/endpoint/pci-epc-core.c: note: in included file:
 ./include/linux/pci-ep-cfs.h:22:16: warning:
 Using plain integer as NULL pointer
CHECK   drivers/pci/endpoint/pci-epf-core.c
 drivers/pci/endpoint/pci-epf-core.c: note: in included file:
 ./include/linux/pci-ep-cfs.h:31:16: warning:
 Using plain integer as NULL pointer

Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 include/linux/pci-ep-cfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci-ep-cfs.h b/include/linux/pci-ep-cfs.h
index f42b0fd..6628813 100644
--- a/include/linux/pci-ep-cfs.h
+++ b/include/linux/pci-ep-cfs.h
@@ -19,7 +19,7 @@ void pci_ep_cfs_remove_epf_group(struct config_group *group);
 #else
 static inline struct config_group *pci_ep_cfs_add_epc_group(const char *name)
 {
-	return 0;
+	return NULL;
 }
 
 static inline void pci_ep_cfs_remove_epc_group(struct config_group *group)
@@ -28,7 +28,7 @@ static inline void pci_ep_cfs_remove_epc_group(struct config_group *group)
 
 static inline struct config_group *pci_ep_cfs_add_epf_group(const char *name)
 {
-	return 0;
+	return NULL;
 }
 
 static inline void pci_ep_cfs_remove_epf_group(struct config_group *group)
-- 
2.7.4

