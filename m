Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B03280032
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbgJANbl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 09:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732016AbgJANbk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 09:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601559099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bSNYRgr1s5QShIox/qdOqO/zSDA77sqfVML7LKhu+Eo=;
        b=PultOSXS4y7VxEG32PG+qWce8gWCR1xYYf9kn71pNy86luMjAC4UsLJyB+cJI3pjO+lOI9
        5GOBg6t7ZMB26a9Miu+v2zaiejjYNbTbKK3zfh8G0WCcha0QLT3Yw601IR4FlkzlBnM2tY
        s2O2oQOapAdtdobPdiqr3of49p72kds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-spdIK0nJOseCc1HGKUT1SQ-1; Thu, 01 Oct 2020 09:31:37 -0400
X-MC-Unique: spdIK0nJOseCc1HGKUT1SQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D2A58D4EA0;
        Thu,  1 Oct 2020 13:31:36 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-115-202.rdu2.redhat.com [10.10.115.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00BCC55762;
        Thu,  1 Oct 2020 13:31:35 +0000 (UTC)
From:   Qian Cai <cai@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next] pci: Fix -Wunused-function warnings for pci_ltr_*
Date:   Thu,  1 Oct 2020 09:28:49 -0400
Message-Id: <20201001132850.7630-1-cai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When CONFIG_PCIEASPM=n,

drivers/pci/pci.c:3098:12: warning: 'pci_ltr_encode' defined but not used [-Wunused-function]
 static u16 pci_ltr_encode(u64 val)
            ^~~~~~~~~~~~~~
drivers/pci/pci.c:3076:12: warning: 'pci_ltr_decode' defined but not used [-Wunused-function]
 static u64 pci_ltr_decode(u16 latency)
            ^~~~~~~~~~~~~~

Fixes: 5ccf2a6e483f ("PCI/ASPM: Add support for LTR _DSM")
Signed-off-by: Qian Cai <cai@redhat.com>
---
 drivers/pci/pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index db8feb2033e7..e96e5933b371 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3069,6 +3069,7 @@ void pci_pm_init(struct pci_dev *dev)
 		dev->imm_ready = 1;
 }
 
+#ifdef CONFIG_PCIEASPM
 /**
  * pci_ltr_decode - Decode the latency to a value in ns
  * @latency: latency register value according to PCIe r5.0, sec 6.18, 7.8.2
@@ -3113,7 +3114,6 @@ static u16 pci_ltr_encode(u64 val)
  */
 void pci_ltr_init(struct pci_dev *dev)
 {
-#ifdef CONFIG_PCIEASPM
 	int ltr;
 	struct pci_dev *bridge;
 	u64 snoop = 0, nosnoop = 0;
@@ -3150,9 +3150,15 @@ void pci_ltr_init(struct pci_dev *dev)
 		pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT,
 				      nosnoop_enc);
 	}
-#endif
 }
 
+#else
+void pci_ltr_init(struct pci_dev *dev)
+{
+}
+
+#endif
+
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
 {
 	unsigned long flags = IORESOURCE_PCI_FIXED | IORESOURCE_PCI_EA_BEI;
-- 
2.28.0

